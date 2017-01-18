--[[FightScript.lua
描述：
	脚本战斗
--]]

require "base.base"


FightScript = class(Fight)


function FightScript:__init(scriptID)

	self._scriptID = scriptID
	self._scriptPrototype = ScriptFightDB[scriptID]
	self._curPhase = 1
	self._phaseStartTimerID = nil --阶段开始超时定时器(用于播放过场动画超时)
	self._startTime = os.time()
	self._isEnd = false--战斗结束标记
	self._triggerCount = {} --同一个条件的触发次数
	self.isNoEscape = self._scriptPrototype.isNoEscape
end

function FightScript:getScriptID()
	return self._scriptID
end

function FightScript:getPhaseStartTimerID()
	return self._phaseStartTimerID
end

function FightScript:clearPhaseStartTimerID()
	self._phaseStartTimerID = nil
end



function FightScript:onEnterFightStart()
	
	--战斗开始，等待初始化
	local beginInfo = self._scriptPrototype.fightBegin
	if beginInfo then
		--做战斗准备
		--启动定时器
		self._fightStartTimerID = g_timerMgr:regTimer(self,MaxFightChooseActionTime*1000,MaxFightChooseActionTime*1000,"FightStart")
		self._timerContext[self._fightStartTimerID] = {fightID = self._id}
		--通知客户端回合开始
		local event = Event.getEvent(FightEvents_FC_EnterFightState,1)--1是占位符
		self:informClient(event)
	else
		self:gotoState(FightState.RoundStart)
	end

end

function FightScript:_doSystemActions(actions)
		local isSameTime = actions.isSameTime --
		local result,bHas
		if isSameTime then
			result = self:getCurResult()
			result.actionType = FightActionType.System
			result.type =ScriptFightActionType.SameTime
		end
		
		for _, action in ipairs(actions) do
				bHas = true
				local type = action.type
				local params = action.params
				self:_doSystemAction(type,params,result)
				
		end

		if bHas and isSameTime then
			--有行为
			if result.bHas then
				result.bHas = nil
				local curIndex = self:getCurResultIndex()
				self:setCurResultIndex(curIndex+1)
			--为空,恢复原样
			else
				result.actionType = nil
				result.type = nil
			end
		end
end
function FightScript:computeConditions(conditions,atStart,atFin)
			local bPass = false
			local isAnd = conditions.isAnd
			local count = conditions.count or 0xFFFF

			if #conditions == 0 then
				bPass = true
			end

			for _,condition in ipairs(conditions) do
				if condition.type == ScriptFightConditionType.IDExist and atStart then
					 bPass = FightSystemActionChecker.isIDExist(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.RoundCount and atStart then
					bPass = FightSystemActionChecker.isRoundCount(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.RoundInterval and atStart then
					bPass = FightSystemActionChecker.isRoundInterval(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.LiveNum and atStart then
					bPass = FightSystemActionChecker.isLiveNum(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.FightPeriod and atStart then
					bPass = FightSystemActionChecker.isFightPeriod(self,os.time()-self._startTime,condition)
				elseif condition.type == ScriptFightConditionType.BuffStatus and atFin then
					bPass = FightSystemActionChecker.isBuffStatus(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.IsAttacked and atFin then
					bPass = FightSystemActionChecker.isAttacked(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.PlayerDead  then
					bPass = FightSystemActionChecker.isPlayerDead(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.AttrValue  then
					bPass = FightSystemActionChecker.AttrValueChanged(self,nil,condition)
				end
				if isAnd then
					if not bPass then
						break
					end
				else
					if bPass then
						break
					end
				end
			end
			bPass = bPass and ( (self._triggerCount[conditions] or 0 ) < (count or 1) )
			return bPass
end


function FightScript:computeConditionsEx(conditions,attrContext)

			local bPass = false
			local isAnd = conditions.isAnd
			local count = conditions.count or 0xFFFF

			for _,condition in ipairs(conditions) do
				if condition.type == ScriptFightConditionType.IDExist  then
					 bPass = FightSystemActionChecker.isIDExist(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.RoundCount  then
					bPass = FightSystemActionChecker.isRoundCount(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.RoundInterval  then
					bPass = FightSystemActionChecker.isRoundInterval(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.LiveNum  then
					bPass = FightSystemActionChecker.isLiveNum(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.FightPeriod  then
					bPass = FightSystemActionChecker.isFightPeriod(self,os.time()-self._startTime,condition)
				elseif condition.type == ScriptFightConditionType.BuffStatus  then
					bPass = FightSystemActionChecker.isBuffStatus(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.IsAttacked  then
					bPass = FightSystemActionChecker.isAttacked(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.AttrValue  then
					bPass = FightSystemActionChecker.AttrValueChanged(self,attrContext,condition)
				elseif condition.type == ScriptFightConditionType.PlayerDead  then
					bPass = FightSystemActionChecker.isPlayerDead(self,nil,condition)
				end
				print("bPass=",bPass)
				if isAnd then
					if not bPass then
						break
					end
				else
					if bPass then
						break
					end
				end
			end
			bPass = bPass and ( (self._triggerCount[conditions] or 0 ) < (count or 1) )
			return bPass
end
function FightScript:computeConditionsEx4Dead(conditions,role)

			local bPass = false
			local isAnd = conditions.isAnd
			local count = conditions.count or 0xFFFF

			for _,condition in ipairs(conditions) do
				if condition.type == ScriptFightConditionType.IDExist  then
					 bPass = FightSystemActionChecker.isIDExist(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.RoundCount  then
					bPass = FightSystemActionChecker.isRoundCount(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.RoundInterval  then
					bPass = FightSystemActionChecker.isRoundInterval(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.LiveNum  then
					bPass = FightSystemActionChecker.isLiveNum(self,nil,condition)

				elseif condition.type == ScriptFightConditionType.FightPeriod  then
					bPass = FightSystemActionChecker.isFightPeriod(self,os.time()-self._startTime,condition)
				elseif condition.type == ScriptFightConditionType.BuffStatus  then
					bPass = FightSystemActionChecker.isBuffStatus(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.IsAttacked  then
					bPass = FightSystemActionChecker.isAttacked(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.AttrValue  then
					bPass = FightSystemActionChecker.AttrValueChanged(self,nil,condition)
				elseif condition.type == ScriptFightConditionType.PlayerDead  then
					bPass = FightSystemActionChecker.isPlayerDead(self,role,condition)
				end
				print("bPass=",bPass)
				if isAnd then
					if not bPass then
						break
					end
				else
					if bPass then
						break
					end
				end
			end
			bPass = bPass and ( (self._triggerCount[conditions] or 0 ) < (count or 1) )
			return bPass
end

function FightScript:_check_doActions(actionsInfo,atStart,atFin)
	for _,actionInfo in ipairs(actionsInfo) do
			local conditions = actionInfo.condition
			local actions = actionInfo.actions
			local bPass = false
			bPass = self:computeConditions(conditions,atStart,atFin)
			if bPass  then
				self:_doSystemActions(actions)
				self._triggerCount[conditions] = (self._triggerCount[conditions] or 0) + 1
			end
			
		end
end

function FightScript:doActionsOnRoundStart()
	if  self._scriptPrototype.begin then
		local beginActions = self._scriptPrototype.begin
		if beginActions then
			self:_check_doActions(beginActions,true,true)
		end
	end
	--扫描系统行为
	local systemActions = self._scriptPrototype.systemActions
	if systemActions then
		self:_check_doActions(systemActions,true,false)
	end
	
end

function FightScript:onEnterRoundStart()
	
	
	--怪物行为
	--[[
	local roleInfos = self._members[FightStand.B]
	for _,monster in pairs(roleInfos) do
		local DBID = monster:getDBID()

		if curRoundInfo then
			local actionInfo = curRoundInfo[DBID]

			--有配置的行为
			if actionInfo then
				local AIID = actionInfo.AIID
				if AIID then
					local h = monster:getHandler(FightEntityHandlerType.AIHandler)
					h:setAIID(AIID)
				end
			end
		end
		
	end
	]]
	

	-----------------------------------------------------------
	--怪物
	local j = self._actionSet.curIndex
	for _,role in pairs(self._members[FightStand.B]) do
		local action = self._actionSet[j]
		action.role = role
		j = j + 1
		self._actionSet.curIndex = j
	end
	--助战npc
	for _,role in pairs(self._members[FightStand.A]) do
		if instanceof(role,FightMonster) then
			local action = self._actionSet[j]
			action.role = role
			j = j + 1
			self._actionSet.curIndex = j
		end
	end

end

function FightScript:onActionsEnd()
	--扫描系统行为
	local systemActions = self._scriptPrototype.systemActions
	if systemActions then
		self:_check_doActions(systemActions,false,true)
	end
	if  self._scriptPrototype.fin then
		local finnalActions = self._scriptPrototype.fin
		if finnalActions then
			self:_check_doActions(finnalActions,true,true)
		end
	end
end

function FightScript:onEnterRoundEnd()
	if  instanceof(self, FightScript_LuckyMonster)then
			self:updateMonsterDeadInfoSum()
	end
end

function FightScript:onEnterFightEnd()
	local endInfo = self._scriptPrototype.fightEnd
	--战斗结束时行为
	if endInfo then
	
	end
end

function FightScript:onEnterPhaseStart()
	self._curWaitClientNum = self._waitClientNum
	--启动定时器
	self._phaseStartTimerID = g_timerMgr:regTimer(self,MaxFightPhaseStartTime*1000,MaxFightPhaseStartTime*1000,"FightPhaseStart")
	self._timerContext[self._phaseStartTimerID] = {fightID = self._id}
	--设置怪物信息
	local monstersInfo = {}
	local phaseInfo = self._scriptPrototype.phases
	if phaseInfo and phaseInfo[self._curPhase] then
		monstersInfo.typeID = phaseInfo[self._curPhase].typeID
		monstersInfo.sceneID = phaseInfo[self._curPhase].sceneID
	end
	FightUtils.setMonsterInfo4Client(self._members[FightStand.B],monstersInfo,phaseInfo[self._curPhase])
	--通知客户端战斗开始
	local event = Event.getEvent(FightEvents_FC_SwitchFightScene,monstersInfo)
	self:informClient(event)
	print("FightScript:onEnterPhaseStart()")
end

function FightScript:onLeavePhaseStart()
	
	if self._phaseStartTimerID then
		g_timerMgr:unRegTimer(self._phaseStartTimerID)
		self._phaseStartTimerID = nil
	end

end

function  FightScript:onPlayOverInPhaseStart()
	self._curWaitClientNum = self._curWaitClientNum - 1
	if self._curWaitClientNum <= 0 then
		self:gotoState(FightState.RoundStart)
	end

end


--local exitMonsters={}
function FightScript:_clearMonsters()
	
	local monstersInfo = self._members[FightStand.B]
	for monsterID, monster in pairs(monstersInfo) do
		monstersInfo[monsterID] = nil
		g_fightEntityMgr:removeRole(monsterID)
	end

end

--[[
处理客户端播放动作完毕的事件
]]
function FightScript:onPlayOver(params)
	--校验有效性
	--print("Fight:onPlayOver(params)",self._curWaitClientNum)
	self._curWaitClientNum = self._curWaitClientNum - 1
	if self._curWaitClientNum <= 0 then
		self:_informEscape()
		local bOver = self:_canFightEnd()
		local nextPhase = self._curPhase + 1
		--此阶段结束
		if bOver then
			local nextPhase = self._curPhase + 1
			local phaseInfo = self._scriptPrototype.phases
			--有下一阶段(玩家赢)
			if self._winSide == FightStand.A and phaseInfo and phaseInfo[nextPhase] and #(phaseInfo[nextPhase].monsters)>0 then
				self:_clearMonsters()
				local fightMonsters = {}
				local monsterDBIDs = phaseInfo[nextPhase].monsters
				for _, DBID in pairs(monsterDBIDs) do
					local monster = g_fightEntityFactory:createMonster(DBID)
					table.insert(fightMonsters, monster)
				end
				g_fightFactory:initFightByMonsters(self,fightMonsters)
				self._curPhase = nextPhase
				self:gotoState(FightState.PhaseStart)
			--战斗结束
			else
				self:gotoState(FightState.FightEnd)
			end
			
			print("*************FightState.FightPhaseEnd")
		else
			self:gotoState(FightState.RoundStart)
		end
	else
		local DBID = params[1]
		self:_informEscape(DBID)
	end
end

local function hasDeadCondition(conditions)
		local bHas =false
		for _, condition in ipairs(conditions) do
			if condition.type == ScriptFightConditionType.PlayerDead then
				return true
			end
		end
		return false
end
--处理怪物死亡时
function FightScript:onRoleDead(role)
	if instanceof(role ,FightPet) or instanceof(role ,FightPlayer) then
		local actions = self._scriptPrototype.systemActions
		if not actions then
			return
		end
		for _,info in ipairs(actions) do
			local conditions = info.condition
			if hasDeadCondition(conditions) then
				local bPass = self:computeConditionsEx4Dead(conditions,role)
				if bPass then
					self._triggerCount[conditions] = (self._triggerCount[conditions] or 0) + 1
					local curResultIndex = self:getCurResultIndex()
					local nextIndex = curResultIndex + 1
					self:setCurResultIndex(nextIndex)
					for _, action in ipairs(info.actions) do
							local type1 = action.type
							local params = action.params
							self:_doSystemAction(type1,params)
					end
				end
			end
		end
	end
end

local function hasAttrTypeCondition(conditions)
		local bHas =false
		for _, condition in ipairs(conditions) do
			if condition.type == ScriptFightConditionType.AttrValue then
				return true
			end
		end
		return false
end
--处理怪物属性变化时
local AttrContext = {role=nil,attrType="hp",curValue =0}
function FightScript:onAttrChanged(monster,type,value)
	if instanceof(monster ,FightMonster) then
		local actions = self._scriptPrototype.systemActions
		if not actions then
			return
		end
		AttrContext.role = monster
		AttrContext.attrType = type
		AttrContext.curValue = value

		local bInserted = false
		if value == 0 and type == "hp" then
				--bInserted = true--将动作结果插在死亡结果前
		end

		for _,info in ipairs(actions) do
			local conditions = info.condition
			if hasAttrTypeCondition(conditions) then
				local bPass = self:computeConditionsEx(conditions,AttrContext)
				if bPass then
					self._triggerCount[conditions] = (self._triggerCount[conditions] or 0) + 1
					local curResultIndex = self:getCurResultIndex()
					local nextIndex = curResultIndex + 1
					self:setCurResultIndex(nextIndex)
					for _, action in ipairs(info.actions) do
							local type1 = action.type
							local params = action.params
							self:_doSystemAction(type1,params,nil,bInserted)
					end
				end
			end
		end
		if value == 0 and type == "hp" then
				--清除死怪--TODO 重伤
				if not monster:getIsToGBH() then
					self:removeRole(monster,true)
				end
		end
	end
end


function FightScript:_doSystemAction(type,params,result,bInserted)
		local doer = FightSystemActionMap[type]
		if doer then
			doer(self,params,result,bInserted)
		end
	
end

-------------------------------------------------------------
function FightScript.onPhaseStartTimeOut(context)
	local fightID = context.fightID
	local fight = g_fightMgr:getFight(fightID)
	local timerID = fight:getPhaseStartTimerID()
	if timerID  then 
		g_timerMgr:unRegTimer(timerID)
		fight:clearPhaseStartTimerID()
	end
	
	if fight.state == FightState.PhaseStart then 
		fight:gotoState(FightState.RoundStart)
	end
end


function FightScript:replaceEntity(newDBID,oldID)
	
	local target = g_fightEntityMgr:getRole(oldID)
	
	if target then
		local side = target:getPos()[2]
		local pos = target:getPos()[3]
		self:removeRole(target)
		local monster = g_fightEntityFactory:createMonster(newDBID)
		monster:setFightID(self._id)
		self._members[side][pos] = monster
		local finalPos = monster:getPos()
		finalPos[1] = self._mapID
		finalPos[2] = side
		finalPos[3] = pos
		local info = {}
		return monster
	end
end

function FightScript:removeMonster(DBID)--TODO 有多个DBID?
	local target
	for _,roles in pairs(self._members) do
		for pos,role in pairs(roles) do
			if instanceof(role,FightMonster) or instanceof(role,FightNpc) then
				if role:getDBID() == DBID then
					target = role
					break
				end
			end
		end
	end

	if target then
		local side = target:getPos()[2]
		local pos = target:getPos()[3]
		self:removeRole(target)
	end
end



function FightScript:setIsGBH(DBID,isOK)--TODO 有多个DBID?
	local target
	for _,roles in pairs(self._members) do
		for pos,role in pairs(roles) do
			if instanceof(role,FightMonster) or instanceof(role,FightNpc) then
				if role:getDBID() == DBID then
					target = role
					break
				end
			end
		end
	end

	if target then
		target:setIsGBH(isOK)
	end
end

function FightScript:setEnd(isOk,isWin)
	self._isEnd = isOk
	if isWin then
		self._winSide = FightStand.A
	else
		self._winSide = FightStand.B
	end
end

function FightScript:_canFightEnd()
	if self._isEnd then
		return true
	end
	--超时或者一方死亡
	local ALiveNum = 0
	local BLiveNum = 0
	for _,role in pairs(self._members[FightStand.A]) do
		
		if role:getLifeState() ~= RoleLifeState.Dead and  (not role:getIsGBH()) and ( instanceof(role,FightPlayer) or  instanceof(role,FightPet)) then

			ALiveNum = 1
			break
		end
	end

	for _,role in pairs(self._members[FightStand.B]) do
		
		if (role:getLifeState() ~= RoleLifeState.Dead and not role:getIsGBH()) then
			BLiveNum = 1
			break
		end
	end

	if ALiveNum == 0 then
		self._winSide = FightStand.B
		return true
	elseif  BLiveNum == 0 then
		self._winSide = FightStand.A
		return true
	else
		if self._roundCount >=FightMaxRound then
			self._winSide = FightStand.A
			return true
		end
		return false
	end
end

function FightScript:setUnhit_Rate(DBID,rate)
	local target
	for _,roles in pairs(self._members) do
		for pos,role in pairs(roles) do
			if instanceof(role,FightMonster) or instanceof(role,FightNpc) then
				if role:getDBID() == DBID then
					target = role
					break
				end
			end
		end
	end

	if target then
		target:setAdd_Unhit(rate)
	end
end



function FightScript:exchangePos(curPos,targetPos)

	local curObject = self:getRole(curPos)
	if not curObject then
		return nil
	end
	local curSide = curObject:getPos()[2]
	local target
	if not targetPos then
		local mySide = curObject:getPos()[2]
		local maxMonsterCount = 6
		local poses = FightStandMap[FightType.PVE][FightStand.B][maxMonsterCount]
		targetPos = FightUtils.findRandomPos(self._members[mySide],curObject,poses)
	end
	target= self:getRole(targetPos)
	if  target then
		local curPos = curObject:getPos()[3]
		local targetPos = target:getPos()[3]
		self._members[curSide][curPos] = target
		target:getPos()[3] = curPos
		self._members[curSide][targetPos] = curObject
		curObject:getPos()[3] = targetPos
		return targetPos
	else
		self._members[curSide][curPos] = nil
		self._members[curSide][targetPos] = curObject
		curObject:getPos()[3] = targetPos
		return targetPos
	end
end


function FightScript:__release()
	if self._phaseStartTimerID then
		g_timerMgr:unRegTimer(self._phaseStartTimerID)
		self._triggerCount = nil
	end
end


