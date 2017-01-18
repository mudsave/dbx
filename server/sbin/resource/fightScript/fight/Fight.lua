--[[Fight.lua
描述：
	每场战斗的实体
--]]

require "base.base"
require "misc.FightConstant"

Fight = class(FSM,Timer)

local MaxCurFightID = 1

local FightResults = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}--预先设置48个动作结果表
local ActionQueue = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}} --48个排好序的动作
local AttrsPool4transfer = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}--48个·传输到世界服的属性(玩家,宠物)集
local storedPets4transfer = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
							 {},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
							} --120个--TODO 分散处理?

local quitPetAttrs = {{},{},{},{},{},{},{},{},{},{}}--10个--逃跑的备用宠物属性集
function clearFightActionQueue()
	
	for i, action in ipairs(ActionQueue) do
		table.clear(action)
		if i > 48 then
			ActionQueue[i] = nil
		end
	end
	--超过32个删除，够用
	local total = #ActionQueue
	local j
	for j =48,total do
		ActionQueue[j] = nil
	end
end

function clearFightResults()
	for _, actionResult in ipairs(FightResults) do
		table.clear(actionResult)
	end
end

function clearAttrs4tranfer()
	for _, attrs in ipairs(AttrsPool4transfer) do
		table.clear(attrs)
	end
	for _, attrs in ipairs(storedPets4transfer) do
		table.clear(attrs)
	end
end

function clearQuitPetAttrs()
	for _, attrs in ipairs(quitPetAttrs) do
		table.clear(attrs)
	end
end

function setActionInvalid(role)
	for i, action in ipairs(ActionQueue) do
		if action.role == role then
			action.isInvalid = true
		end
	end
end
function Fight:__init()
	self._fightType = nil
	self._srcWorldID = 1 --来自哪个世界服的ID
	self._id = MaxCurFightID
	MaxCurFightID = MaxCurFightID + 1
	self._members = {[FightStand.A]={},[FightStand.B]={},[FightStand.C]={}} --存放战斗中角色的集合
	self._mapID = nil
	self._actionSet = {curIndex=1,{isOrdered=nil,isDone=nil},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}} --32个排序前的
	self._waitActionNum = 0 --每回合需要等待客户端的选择动作数
	self._waitClientNum = 0 --每回合需要等待客户端数
	self._curWaitActionNum = 0 --本回合需要等待数
	self._curWaitClientNum = 0 --本回合需要等待数
	self._roundStartTimerID = nil --回合开始超时定时器(用于选择动作超时)
	self._roundEndTimerID = nil --回合结束超时定时器(用于播放动作超时)
	self._fightStartTimerID = nil--战斗开始超时定时器
	self._roundCalculateTimerID = nil --执行动作超时(用于执行出错时)
	self._offlineTimeOutTimerID = nil --离线超时定时器
	self._roundCount = 0 --回合数
	self._winSide = FightStand.A --战斗胜利的一方
	self._escapedRoles = {}--{role1,role2}
	self._oldActions = {}--{[entityID1]=action1,[entityID2]=action2}
	self._allMonsterDBIDs = {}
	self._curResultIndex = 0
	self._deadList = {}--存放死亡的怪物
	self._world_fightID = nil --在世界服唯一
	self._timerContext = {}--[timerID] = context
end

function Fight:getFightID()
	return self._world_fightID
end

function Fight:setFightID(ID)
	self._world_fightID = ID
end
function Fight:setSrcWorldID(worldID)
	self._srcWorldID = worldID
end

function Fight:getSrcWorldID()
	return self._srcWorldID
end

function Fight:setType(fightType)
	self._fightType = fightType
end

function Fight:getType()
	return self._fightType
end

function Fight:getID()
	return self._id
end

function Fight:getMembers()
	return self._members
end

function Fight:setWinSide(side)
	self._winSide = side
end

function Fight:getWinSide()
	return self._winSide
end

function Fight:getRoundStartTimerID()
	return self._roundStartTimerID
end

function Fight:getRoundEndTimerID()
	return self._roundEndTimerID
end

function Fight:getFightStartTimerID()
	return self._fightStartTimerID
end

function Fight:getOfflineTimeOutTimerID()
	return self._offlineTimeOutTimerID
end

function Fight:clearRoundStartTimerID()
	self._roundStartTimerID = nil
end

function Fight:clearRoundEndTimerID()
	self._roundEndTimerID = nil
end

function Fight:clearFightStartTimerID()
	self._fightStartTimerID = nil
end

function Fight:clearOfflineTimeOutTimerID()
	self._offlineTimeOutTimerID = nil
end

function Fight:getRoundCaculateTimerID()
	return self._roundCaculateTimerID
end

function Fight:clearRoundCaculateTimerID()
	self._roundCaculateTimerID = nil
end

function Fight:decreaseWaitActionNum()
	self._waitActionNum = self._waitActionNum - 1
	if self._waitActionNum < 0 then
		self._waitActionNum = 0
	end
end

function Fight:increaseWaitActionNum()
	self._waitActionNum = self._waitActionNum + 1
end

function Fight:decreaseWaitClientNum()
	self._waitClientNum = self._waitClientNum - 1
	if self._waitClientNum < 0 then
		self._waitClientNum = 0
	end
end

function Fight:getCurResultIndex()
	return self._curResultIndex
end

function Fight:setCurResultIndex(index)
	self._curResultIndex = index
end

function Fight:setCurResult(index,result)
	FightResults[index] = result
end

function Fight:insertCurResult(index,result)
	table.insert(FightResults,index,result)
end

function Fight:getCurResult()
	return FightResults[self._curResultIndex] 
end

function Fight:getRoundCount()
	return self._roundCount
end
function Fight:getRole(pos)
	for side,poses in pairs(self._members) do
		local role = poses[pos]
		if role then
			return role
		end
	end
end

function Fight:hasMonster(DBID)
	for side,roles in pairs(self._members) do
		for _ ,role in pairs(roles) do
			if instanceof(role,FightMonster) and role:getDBID() == DBID and (role:getLifeState() == RoleLifeState.Normal or role:getIsGBH() == true ) then
				return true
			end
		end
	end
	return false
end

function Fight:setOldAction(entityID,action)
	self._oldActions[entityID] = action

end

function Fight:getOldAction(entityID)
	return self._oldActions[entityID]

end

function Fight:addEscapedRole(role)
	table.insert(self._escapedRoles,role)
end

function Fight:removeRole(role,isKeep)
	
	
	if instanceof(role,FightMonster) and role:getIsGBH() then
		return false
	end

	if instanceof(role,FightMonster) and instanceof(self, FightScript_LuckyMonster)then
			self:updateMonsterDeadInfo(role:getDBID())
	end

	local side = role:getPos()[2]
	local pos = role:getPos()[3]

	local oldRole = self._members[side][pos]

	if role ==  oldRole then
		self._members[side][pos] = nil
		if not isKeep then
			local ID = role:getID()
			g_fightEntityMgr:removeRole(ID)
		else
			if instanceof(role,FightMonster) then
				table.insert(self._deadList,oldRole)
			end
		end

		
		setActionInvalid(role)

		if instanceof(role,FightPlayer) or  instanceof(role,FightPet) then
			self:decreaseWaitActionNum()
		end

		return true
	else
		return false
	end

end

function Fight:getPlayerMembers(side)
	local members = self._members[side]
	local count = 0
	for _,role in pairs(members) do
		if instanceof(role, FightPlayer) then
			count = count + 1
		end
	end
	return count
end

function Fight:addRole(side, pos, role)
	self._members[side][pos] = role
	local rolePos = role:getPos()
	rolePos[1] = self._mapID
	rolePos[2] = side
	rolePos[3] = pos

	role:setFightID(self._id)
	if side ~= FightStand.C and (instanceof(role,FightPlayer) or instanceof(role,FightPet))then
		self._waitActionNum = self._waitActionNum +1
	end--
	if side ~= FightStand.C and instanceof(role,FightPlayer) then
		self._waitClientNum = self._waitClientNum +1
	end
	if instanceof(role,FightMonster) then 
		table.insert(self._allMonsterDBIDs,role:getDBID())
	end
end
--[[
roleType:站位类型
side:A边还是B边
totalCount:多少个同类对象
得到角色能被分配的位置
]]
function Fight:getRolePos(roleType, side, totalCount,npcCount,player)
	
	local map = FightStandMap[self._fightType] or FightStandMap[FightType.PVE]
	local subMap = map[side]
	local subSubMap = subMap[totalCount] --对应于玩家数(怪物数)的map
	local curMembers = self._members[side]

	if roleType == StandRoleType.Player   then
		local finalMap = subSubMap[roleType]
		for k,pos in ipairs(finalMap) do
			local role = curMembers[pos] 	
			if not role then
				if  roleType == StandRoleType.Player then
					player.posIndex = k
				end
				return pos
			end
		end
		if roleType == StandRoleType.Player then
			print("玩家阵型已满",side)
		elseif roleType == StandRoleType.Pet then
			print("宠物阵型已满",side)
		elseif roleType == StandRoleType.Npc then
			print("npc阵型已满",side)
		end 

		if true then  
			return nil 
		end 
	elseif roleType == StandRoleType.Pet  then
		local finalMap = subSubMap[roleType]
		local posIndex = player.posIndex
		local pos = finalMap[posIndex]
		return pos

	elseif  roleType == StandRoleType.Npc then
		local finalMap = subSubMap[roleType][npcCount]
		for _,pos in ipairs(finalMap) do
			local role = curMembers[pos] 	
			if not role then
				return pos
			end
		end
		if roleType == StandRoleType.Player then
			print("玩家阵型已满",side)
		elseif roleType == StandRoleType.Pet then
			print("宠物阵型已满",side)
		elseif roleType == StandRoleType.Npc then
			print("npc阵型已满",side)
		end 

		if true then  
			return nil 
		end 
	elseif roleType == StandRoleType.Monster then
		for _,pos in ipairs(subSubMap) do
			local role = curMembers[pos] 	
			if not role then
				return pos
			end
		end
		print("怪物阵型已满",side)
		return nil
	
	end
end

local tempEmptyPoses={}
function Fight:getRandomEmptyPos(side)
	table.clear(tempEmptyPoses)
	local sideName 
	if side == FightStand.A then
		sideName = "a"
	elseif side == FightStand.B then
		sideName = "b"
	else
		print("side error!")
		return
	end

	local curMembers = self._members[side]
	local alreadyCount = table.size(curMembers)
	local totalCount = table.size(FightMapPoses[sideName])
	if alreadyCount >= totalCount then
		print("无空位置了",sideName)
		return 
	end
	 
	for pos ,_ in pairs(FightMapPoses[sideName]) do
		if not curMembers[pos] then
			table.insert(tempEmptyPoses,pos)
		end
	end
	local emptyCount = table.size(tempEmptyPoses)
	local rand = math.random(emptyCount)
	local finalPos = tempEmptyPoses[rand]
	return finalPos
end

function Fight:_clearFightActionSet()
	for _, action in ipairs(self._actionSet) do
		table.clear(action)
	end
end

function Fight:_resetState()
	for _, rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			
				role:setProtectors(nil,true)
				role:setProtectee(nil)
				role:setIsDefense(false)
				if instanceof(role ,FightPlayer) or instanceof(role ,FightPet) then
					role:setChoosed(false)
				end
				--受攻击回合计数
				if role:getIsInjured() then
					role:setRoundCountAfterInjured(role:getRoundCountAfterInjured() + 1 )
				end
				--一定次数后消除
				local curRoundCountAfterInjured = role:getRoundCountAfterInjured()
				if curRoundCountAfterInjured >= ClearRoundCountAfterInjured then
					role:setRoundCountAfterInjured(0)
					role:setIsInjured(false)
				end
			
		end
	end
end

function Fight:onEnterFightStart()
	self._curWaitClientNum = self._waitClientNum
	--子类的
	if self._fightType == FightType.Script and FightScript.onEnterFightStart then
		FightScript.onEnterFightStart(self)
	--通用的
	else
		--启动定时器
		self._fightStartTimerID = g_timerMgr:regTimer(self,MaxFightChooseActionTime*1000,MaxFightChooseActionTime*1000,"FightStart")
		self._timerContext[self._fightStartTimerID] = {fightID = self._id}
		--通知客户端战斗开始
		local event = Event.getEvent(FightEvents_FC_EnterFightState,1)--1是占位符
		self:informClient(event)
	end
end

function Fight:onPlayOverInFightStart()
	self._curWaitClientNum = self._curWaitClientNum - 1
	if self._curWaitClientNum <= 0 then
			self:gotoState(FightState.RoundStart)
	end
end

function Fight:onLeaveFightStart()
	if self._fightStartTimerID  then 
		g_timerMgr:unRegTimer(self._fightStartTimerID)
		self:clearFightStartTimerID()
	end
end

--处理特殊状态
function Fight:_dealWithState()
	for _,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			if instanceof(role,FightPlayer) or instanceof(role,FightPet) then
				--状态审核
				if role:getLifeState() == RoleLifeState.Dead then
					--self._curWaitActionNum = self._curWaitActionNum -1
				elseif role:getLifeState() == RoleLifeState.Freeze then 
					--self._curWaitActionNum = self._curWaitActionNum -1
				elseif role:getLifeState() == RoleLifeState.Sopor then
					--self._curWaitActionNum = self._curWaitActionNum -1
				elseif role:getIsGathering() == true then
					self._curWaitActionNum = self._curWaitActionNum -1
				elseif role:getOffline() then
					self._curWaitActionNum = self._curWaitActionNum -1
				end

			end
		end
	end
end

function Fight:onEnterRoundStart()
	self._curResultIndex = 1
	self._roundCount = self._roundCount +1
	self:_clearFightActionSet()
	self._actionSet.curIndex = 1
	self._curWaitActionNum = self._waitActionNum
	

	
	--处理特殊状态
	self:_dealWithState()
	--具体类型的战斗处理
	if self._fightType == FightType.PVE then
		FightPVE.onEnterRoundStart(self)
	elseif self._fightType == FightType.PVP then
		FightPVP.onEnterRoundStart(self)
	elseif self._fightType == FightType.Script then
		FightScript.onEnterRoundStart(self)
		
	end
	--将状态(保护,防御)初始化
	self:_resetState()
	--启动定时器
	local period = MaxFightChooseActionTime
	if self:isAllOffline() then
		period = math.floor(period/2)
	end
	self._roundStartTimerID = g_timerMgr:regTimer(self,period*1000,period*1000,"chooseAction")
	self._timerContext[self._roundStartTimerID] = {fightID = self._id}
	if (not self._offlineTimeOutTimerID) and self:isAllOffline() then
			self._offlineTimeOutTimerID = g_timerMgr:regTimer(self,MaxFightOfflineTime*1000,MaxFightOfflineTime*1000,"offlineTimeOutAction")
			self._timerContext[self._offlineTimeOutTimerID] = {fightID = self._id}
	end
	--通知客户端回合开始
	FightUtils.informRoundStart(self,self._roundCount)
	--print(2222222222222)
	Flog:log("\n\n回合开始:".."第"..tostring(self._roundCount).."回合")--TODO del
	-- 不等待立刻开始
	if  self._curWaitActionNum == 0 and (not self:isAllOffline()) then
		self:gotoState(FightState.Caculate) 
	end
end

function Fight:onLeaveRoundStart()
	
	if self._roundStartTimerID then 
		g_timerMgr:unRegTimer(self._roundStartTimerID)
		self._roundStartTimerID = nil
	end
end

--[[
 params[1]:客户端handle
 params[2]:1:玩家，0:宠物
 params[3]:行动类型SkillActionType
 params[4]:上下文{skillID = 10000,itemID =1001,target = pos}
 客户端选择动作的处理函数
]]
function Fight:onChooseAction(params)
	-- print("Fight:onChooseAction(params)",self._curWaitActionNum,toString(params))
	if self._actionSet.curIndex <= MaxFightRoundActionsNum then
		local curIndex = self._actionSet.curIndex
		local action = self._actionSet[curIndex]
		local DBID = params[1]
		local isPlayer = params[2]

		local player = g_fightEntityMgr:getPlayerByDBID(DBID)
		
		
		if isPlayer == 1  then
			local state = player:getLifeState()
			if player:getChoosed() or player:getIsGathering() 	then

				if state == RoleLifeState.Taunt then
					self._curWaitActionNum = self._curWaitActionNum - 1
				end
				if self._curWaitActionNum == 0 then
					self:gotoState(FightState.Caculate)
				end
				return
			else
				player:setChoosed(true)
			end
			action.role = player
		elseif isPlayer == 0 then
			local pet = FightUtils.findMyPet(player)
			if not pet then
				return
			end
			local state = pet:getLifeState()
			if pet:getChoosed() or pet:getIsGathering()  then
				
				if state == RoleLifeState.Taunt then
					self._curWaitActionNum = self._curWaitActionNum - 1
				end

				if self._curWaitActionNum == 0 then
					self:gotoState(FightState.Caculate)
				end
				return
			else
				pet:setChoosed(true)
			end
			
			action.role = pet 
			
		
		end

		if not action.role then
			print("玩家或宠物已无效(死亡)。playerDBID=",player:getDBID())
			return
		end

		action.actionType = params[3]
		local contextInfo = params[4]
		print("action=",DBID, isPlayer, params[3], contextInfo)
		action.context = contextInfo
		self._actionSet.curIndex = curIndex +1
		self._curWaitActionNum = self._curWaitActionNum -1 
	end
	print(self._curWaitActionNum)
	if self._curWaitActionNum == 0 then
		self:gotoState(FightState.Caculate)
	end
end

function Fight:_canFightEnd()
	--超时或者一方死亡
	local ALiveNum = 0
	local BLiveNum = 0
	for _,role in pairs(self._members[FightStand.A]) do
		
		if role:getLifeState() ~= RoleLifeState.Dead and ( instanceof(role,FightPlayer) or  instanceof(role,FightPet) ) then

			ALiveNum = 1
			break
		end
	end

	for _,role in pairs(self._members[FightStand.B]) do
		
		if role:getLifeState() ~= RoleLifeState.Dead and ( instanceof(role,FightPlayer) or  instanceof(role,FightPet) or  instanceof(role,FightMonster) ) then
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

local function onRoundEndBuff(self)
	for side,poses in pairs(self._members) do
		for _,role in pairs(poses) do
			g_fightBuffMgr:onRoundEnd(role)
		end
	end
end

local function onRoundStartBuff(self)
	for side,poses in pairs(self._members) do
		for _,role in pairs(poses) do
			g_fightBuffMgr:onRoundStart(role)
		end
	end
end


function Fight:onEnterRoundEnd()
	if self._fightType == FightType.Script then
		FightScript.onEnterRoundEnd(self)
	end
	self._curWaitClientNum = self._waitClientNum
	--启动定时器
	local period = MaxFightActionPlayTime
	if self:isAllOffline() then
		period = math.floor(period/2)
	end
	self._roundEndTimerID = g_timerMgr:regTimer(self,period*1000,period*1000,"playAction")
	self._timerContext[self._roundEndTimerID] = {fightID = self._id}
	Flog:log("\n\n回合结束:")
	FightUtils.printFightInfo(self)--TODO del
end

function Fight:onLeaveRoundEnd()
	--取消定时器
	if self._roundEndTimerID then 
		g_timerMgr:unRegTimer(self._roundEndTimerID)
		self._roundEndTimerID = nil
	end
	
	--回合结束清理buff
	onRoundEndBuff(self)
	
	--释放死亡名单上的角色
	for k, role in pairs(self._deadList) do
		g_fightEntityMgr:removeRole(role:getID())
		self._deadList[k] = nil
	end
end
function Fight:_doInformEscape(role)
	if instanceof(role,FightPlayer) then
		self._waitClientNum = self._waitClientNum -1
		--通知逃跑客户端播放然后退出战斗
		local roleInfo = {}
	
		--准备改变的属性
		FightUtils.setPlayerChangedAttrInfo(role,roleInfo)
		roleInfo.isPlayer = 1
		roleInfo.isWin = false
		
		--备用的宠物
		clearQuitPetAttrs()
		local j = 1
		for _ ,petID in pairs(role:getPetList()) do
			local pet = g_fightEntityMgr:getRole(petID)
			--生成属性集
			quitPetAttrs[j].isPlayer = 0
			quitPetAttrs[j].isWin = false
			FightUtils.setPetChangedAttrInfo(pet,quitPetAttrs[j])
			j = j + 1
		end
		--通知服务器退出战斗
		local event1 = Event.getEvent(FightEvents_FS_QuitFight, roleInfo, self._scriptID, quitPetAttrs, self._world_fightID)
		RemoteEventProxy.sendToWorld(event1,self._srcWorldID)
		print("%%%%%%%%%%%FightEvents_FS_QuitFight")
	

		--逃跑清理buff
		g_fightBuffMgr:onFightEnd(role)

		--释放玩家
		local ID = role:getID()
		g_fightEntityMgr:removeRole(ID)
	end
end

function Fight:_informEscape(DBID)
	--print("Fight:_informQuitFight()",debug.traceback())
	if DBID then
		for k,role in pairs(self._escapedRoles) do
			if instanceof(role,FightPlayer) and role:getDBID() == DBID then 
				self._escapedRoles[k] = nil
				self:_doInformEscape(role)
				break
			end
		end
	else
		for k,role in pairs(self._escapedRoles) do
			self._escapedRoles[k] = nil
			self:_doInformEscape(role)
		end
	end
	
end
--[[
处理客户端播放动作完毕的事件
]]
function Fight:onPlayOver(params)
	--校验有效性
	--print("onPlayOver")
	--print("Fight:onPlayOver(params)",self._curWaitClientNum)
	if self._fightType == FightType.Script and FightScript.onPlayOver then
		FightScript.onPlayOver(self,params)
		return
	end
	self._curWaitClientNum = self._curWaitClientNum - 1
	if self._curWaitClientNum <= 0 then
		--print(11)
		self:_informEscape()
		local bOver = self:_canFightEnd()
		if bOver then
			self:gotoState(FightState.FightEnd)
			--print("*************FightState.FightEnd")
		else
			self:gotoState(FightState.RoundStart)
		end
		
	else
		local dbID = params[1]
		self:_informEscape(dbID)
	end
end



function Fight:onLeaveCalculate()
	if self._roundCalculateTimerID then
		g_timerMgr:unRegTimer(self._roundCalculateTimerID)
		self._roundCalculateTimerID = nil
	end

end
--[[
执行状态超时处理
]]
function Fight.roundCaculateTimeOut(context)
	local fightID = context.fightID
	local fight = g_fightMgr:getFight(fightID)
	local timerID = fight:getRoundCaculateTimerID()
	if timerID  then 
		g_timerMgr:unRegTimer(timerID)
		fight:clearRoundCaculateTimerID()
	end
	print("回合计算出错，退出战斗")
	fight:gotoState(FightState.FightEnd)
end

function Fight:informClient(event)
	for _,roleInfos in pairs(self._members) do
		for _,role in pairs(roleInfos) do
			if instanceof(role, FightPlayer)  and role:getOffline() == false then
				g_eventMgr:fireRemoteEvent(event,role)
				--print("Fight:informClient(event)",event:getID())
			end
		end
	end
end
--执行动作前的预处理
function Fight:_doPreTings()
	local i = self._actionSet.curIndex 
	for _,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			local state = role:getLifeState()
			if role and instanceof(role,FightEntity) and state == RoleLifeState.Taunt then
				local bMonster = instanceof(role,FightMonster)
				local bPlayerOrPet = instanceof(role,FightPlayer) or instanceof(role,FightPet)
				if  (bMonster or (bPlayerOrPet and not role:getChoosed()))  and role:getOffline() == false then
						local action = self._actionSet[i]
						action.role = role
						FightUtils.doTauntThings(action) 
						i = i+1
						self._actionSet.curIndex = i
						if instanceof(role,FightPlayer) or instanceof(role,FightPet)  then
							role:setChoosed(true)
						end
				end
			end
		end
	end

end


function Fight:_execBuffs()
	local buffResult = {}
	for side, roles in pairs(self._members) do
		for _,role in pairs(roles) do
			if role:getLifeState() ~= RoleLifeState.Dead and role:getLifeState() ~= RoleLifeState.Freeze then
				local h = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
				local result = h:getBuffOP()
				for _,iter in pairs(result or {}) do
					table.insert(buffResult, iter)
				end
			end
		end
	end
	if table.size(buffResult) >= 1 then
		--print("  $  getBuffOP\n", toString(buffResult))
		for _,buffResult in pairs(buffResult) do 
			FightUtils.insertFightResult(self, buffResult)
		end	
	end
end


function Fight:_execPassSkills()
	local skillResult = {}
	for side, roles in pairs(self._members) do
		for _,role in pairs(roles) do
			-- 判断是不是宠物
			if role:getLifeState() ~= RoleLifeState.Dead  and RoleType.Pet == SkillUtils.getRoleType(role) then
				local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
				local results = handler:onRoundPassSkill()
				if results and #results > 0 then
					for _, result in ipairs(results) do
						FightUtils.insertFightResult(self, result)
					end
				end
			end
		end
	end
end
function Fight:_subtractLoyalty()
	for side, roles in pairs(self._members) do
		for _,role in pairs(roles) do
			if instanceof(role, FightPet) then
				local cur = role:getLoyalty()
				local left = cur - EachLoyaltyReduction
				if left < 0 then
					left = 0
				end
				role:setLoyalty(left)
			end
		end
	end
end

function Fight:_checkFightResults(results)
	for k, result in pairs(results) do
		local actionType = result.actionType
		
		if actionType == FightActionType.System then
			if result.params then
				if result.params.IDs then
					local IDs = result.params.IDs
					local newIDs = {}
					for _,roleID in pairs(IDs) do
						local role = g_fightEntityMgr:getRole(roleID)
						if role and role:getLifeState() ~= RoleLifeState.Dead then
							table.insert(newIDs,roleID)
						end
					end
					result.params.IDs = newIDs
				end
			end
		end
		
	end
end

function Fight:onEnterCalculate()
	clearFightResults()
	--启动定时器
	self._roundCalculateTimerID = g_timerMgr:regTimer(self,MaxFightActionCaculateTime*1000,MaxFightActionCaculateTime*1000,"Fight:onEnterCalculate")
	self._timerContext[self._roundCalculateTimerID] = {fightID = self._id}
	if self._fightType == FightType.Script then
		FightScript.doActionsOnRoundStart(self)
	end

	--是否有掉线的
	self:_addOfflineActions()
	--加上没选动作的
	self:_addTimeoutActions()
	--做些预处理(状态相关)
	--self:_doPreTings()
	--加上玩家蓄力行为
	self:_addGatherActions()
	--动作排序
	self:_sortAction(true)
	--执行动作前结算buff
	onRoundStartBuff(self)
	--执行动作
	self:_excecuteAction()
	--执行buff
	self:_execBuffs()
	--执行被动技能
	self:_execPassSkills()
	
	--执行脚本AI
	if self._fightType == FightType.Script then
		FightScript.onActionsEnd(self)
	end	
	--减宠物忠诚点
	self:_subtractLoyalty()
	--校验战斗结果(去除一些错误的)
	self:_checkFightResults(FightResults)
	print("------------------Fight results---------------")
	print("fightID,roundCount",self._id,self._roundCount)
	print(toString(FightResults))
	print("---------------------------------------------")
	--通知客户端这一回合战斗结果
	local event = Event.getEvent(FightEvents_FC_FightResults,FightResults,self._id,self._roundCount)
	for k,role in pairs(self._escapedRoles) do
		if instanceof(role,FightPlayer) then
			g_eventMgr:fireRemoteEvent(event,role)
		end
	end
	--如果是瑞兽降福脚本战斗,刷怪
	if instanceof( self, FightScript_LuckyMonster)then
		self:refreshMonsters()
		self:addMinorMonsters2Results()
	end
	self:informClient(event)
	self:gotoState(FightState.RoundEnd)
	
end
--[[
增加离线时的行为
]]
function Fight:_addOfflineActions()
	local i = self._actionSet.curIndex
	for _,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			if instanceof(role,FightPlayer) or instanceof(role,FightPet) then
				if (not role:getChoosed()) and role:getOffline() ==true then
						self._actionSet[i] = table.copy(self:_getAutoAction(role))
						i = i+1
						self._actionSet.curIndex = i
						role:setChoosed(true)
				end
			end
		end
	end
end
--[[
角色没选超时的行为
]]
function Fight:_addTimeoutActions()
	local i = self._actionSet.curIndex 
	for _,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			if instanceof(role,FightPlayer) or instanceof(role,FightPet) then
				if (not role:getChoosed()) and role:getOffline() ==false and (not role:getIsGathering()) and role:getLifeState() == RoleLifeState.Normal then
						self._actionSet[i] = table.copy(self:_getAutoAction(role,true))
						i = i+1
						self._actionSet.curIndex = i
						role:setChoosed(true)
				end
			end
		end
	end
end
--[[
每回合根据状态增加玩家蓄力行为
]]
function Fight:_addGatherActions()
	local i = self._actionSet.curIndex 
	for _,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
				if (not instanceof(role,FightMonster) )and role:getIsGathering() then
						local action = self._actionSet[i]
						action.role = role
						print("add actionType",action.actionType)
						i = i+1
						self._actionSet.curIndex = i
						role:setChoosed(true)
						
				end
			
		end
	end
end

function Fight:_sortAction(bFirst)
	if  bFirst  then 
		clearFightActionQueue()
	end
	
	--按速度排序
	local i
	local totalActionNum = self._actionSet.curIndex - 1
	--
	for i = 1 ,totalActionNum do
		
		if not ActionQueue[i].isDone then
			local maxIndex 
			local j
			local curMaxSpeed 
			for j = 1 , totalActionNum do
				--忽略已排序的和做过的
				local action = self._actionSet[j]
				if (not action.isOrdered) and (not action.isDone) then
					--特殊动作放在前
					if ( FightUIType.Protect == action.actionType or FightUIType.Defense == action.actionType ) then
						maxIndex = j
						break
					--普通动作比速度
					else
						local role = self._actionSet[j].role
						
						local speed = role:get_speed() or 1
						local hanlder = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
						--最高优先级
						if hanlder:getFastestSpeed() then
							speed = speed + 0xFFFFFFFF
						end
						--初始化
						if not curMaxSpeed then
							curMaxSpeed = speed
							maxIndex = j
						end
						--比较替换
						if speed > curMaxSpeed then
							curMaxSpeed = speed
							maxIndex = j
						end
					end
				end
			end
			ActionQueue[i].role =  self._actionSet[maxIndex].role
			ActionQueue[i].actionType = self._actionSet[maxIndex].actionType
			ActionQueue[i].context =  self._actionSet[maxIndex].context
			ActionQueue[i].actionSetIndex = maxIndex
			self._actionSet[maxIndex].isOrdered = true
		end
		
	end

	for m = 1 , totalActionNum do
		local action = self._actionSet[m]
		if FightUIType.Protect ~= action.actionType  and FightUIType.Defense ~= action.actionType then
			action.isOrdered = nil --将临时状态清空
		end
	end
	
end


function Fight:_canExcecuteAndDoSth(actionInfo)

	
	local role = actionInfo.role

	--是否是蓄力
	if role:getIsGathering() then
		return true
	end

	local actionType = actionInfo.actionType
	local doFun = FightActionMap[actionType]
	--通用检查
	if not doFun then
		return false
	end

	if not role then
		return false
	end

	

	--目标是否是冰冻状态
	local target = self:getRole(actionInfo.context.target)
	if target and target:getLifeState() == RoleLifeState.Freeze then
		return false
	end
	--状态审核
	if role:getLifeState() == RoleLifeState.Dead then
		return false
	elseif role:getLifeState() == RoleLifeState.Freeze then 
		return false
	elseif role:getLifeState() == RoleLifeState.Sopor then
		return false
	elseif role:getLifeState() == RoleLifeState.Chaos then
		 local bSucceess = FightUtils.doChaosThing(self,actionInfo)
		 if bSucceess then
			return true
		 end
	elseif role:getLifeState() == RoleLifeState.Taunt then 
		FightUtils.doTauntThings(actionInfo)
		return true
	end

	--具体动作相关检查
	local bResult = true
	if actionType == FightUIType.CommonAttack then
		bResult = FightActionCheck.commonAttack(self,role,actionInfo.context)

	elseif actionType == FightUIType.UseSkill then
		bResult = FightActionCheck.skilAction(self,role,actionInfo.context)
		if (not bResult) and role:getLifeState() ~= RoleLifeState.Poison then
			actionInfo.actionType = FightUIType.CommonAttack
			actionInfo.context.target = NonExistEntityPos
			bResult = true
		end

	elseif actionType == FightUIType.Auto then
		actionInfo = self:_getAutoAction(role)
		bResult = self:_canExcecuteAndDoSth(actionInfo)
		--bResult = FightActionCheck.auto(self,role,actionInfo.context)

	elseif actionType == FightUIType.Protect then
		bResult = FightActionCheck.protect(self,role,actionInfo.context)

	elseif actionType == FightUIType.Defense then
		bResult = FightActionCheck.defense(self,role,actionInfo.context)

	elseif actionType == FightUIType.Escape then
		bResult = FightActionCheck.escape(self,role,actionInfo.context)
		if self.isNoEscape then
			bResult = false
		end

	elseif actionType == FightUIType.UseMaterial then
		bResult = FightActionCheck.UseMaterial(self,role,actionInfo.context)

	elseif actionType == FightUIType.Call then
		bResult = FightActionCheck.call(self,role,actionInfo.context)
	elseif actionType == FightUIType.CallBack then
		bResult = FightActionCheck.callBack(self,role,actionInfo.context)
	elseif actionType == FightUIType.Catch then
		bResult = FightActionCheck.catch(self,role,actionInfo.context)
	else
		bResult = false
	end

	if not bResult then 
		return false
	end

	return true
end

local AIContext4Action1 = {}
function Fight:_judgeAndDoCounterAttack(actionInfo,target,nextIndex)
	local role = actionInfo.role
	local context = actionInfo.context
	local skillID = context and context.skillID
	--是否有反击
	if not target then
		return false
	end
	local targetSide = target:getPos()[2]
	if role:getLifeState() == RoleLifeState.Normal then
		if instanceof(target,FightMonster) and targetSide == FightStand.B and target:getLifeState() == RoleLifeState.Normal and  FightUtils.isUnhit(role, target) then --TODO 现在只限怪物
			--print("counter Attack!",target:getID(),role:getID(),instanceof(role,FightPlayer))
			table.clear(AIContext4Action1)
			local newActionInfo = {isCounter = true}
			local configID = target:getDBID()
			local monsterConfig = MonsterDB[configID] or NpcDB[configID]
			local skills = monsterConfig.unhitSkills
			if skills then
				local rand = math.random(#skills)
				local skillID = skills[rand]
				newActionInfo.actionType = FightUIType.UseSkill
				newActionInfo.role = target
				newActionInfo.context = {skillID = skillID,targets={role},isEnemy = true  }
				table.insert(ActionQueue,nextIndex,newActionInfo)
				return true
			end
		elseif instanceof(target,FightPet)  and target:getLifeState() == RoleLifeState.Normal then
			local isTrue, strikeBackSkillID = FightUtils.isUnhit(role, target, skillID)
			if isTrue then
				local newActionInfo
				-- 技能反击
				if strikeBackSkillID then
					newActionInfo = {role = target,actionType = FightUIType.UseSkill, context={target = role:getPos()[3], skillID = strikeBackSkillID}}
				-- 否则普通反击
				else
					newActionInfo = {role = target,actionType = FightUIType.CommonAttack, context={target = role:getPos()[3]}}
				end
				table.insert(ActionQueue,nextIndex,newActionInfo)
				return true
			end
		end
	end
	return false
end

function Fight:_getAutoAction(role,isTimeOut)
	 local oldAction = self._oldActions[role:getID()]
	 
	 --没有或超时的 则普攻
	 if isTimeOut or ( not oldAction ) then
		 oldAction = {}
		 oldAction.actionType = FightUIType.CommonAttack
		 oldAction.role = role
		 oldAction.context = {target = -1}
		self._oldActions[role:getID()] = oldAction
		
	 --有则读取参数
	 else
		 local actionType = oldAction.actionType
		 local role = oldAction.role
		 local context = oldAction.context
		--保护对象非法,先换目标,没目标再换成普攻
		 if actionType == FightUIType.Protect then 
			local target = self:getRole(context.target)
			if (not target ) or target:getLifeState() ==  RoleLifeState.Dead then
				local mySide = role:getPos()[2]
				local roles = self:getMembers()[mySide]
				target = FightUtils.findRandomTarget(roles)
				if not target then
					local enemySide = FightUtils.getEnemySide(role)
					local roles = self:getMembers()[enemySide]
					target = FightUtils.findRandomTarget(roles)
					oldAction.context.target = target:getPos()[3]
					oldAction.actionType = FightUIType.CommonAttack
					oldAction.doExcecute = FightActionMap[oldAction.actionType]
				else
					oldAction.context.target = target:getPos()[3]
				end
			end

		 end
		 
	 end
	 return oldAction

end

local AIContext4Action = {}
function Fight:_setMonsterAction(action)
	table.clear(AIContext4Action)
	local monster = action.role
	local handler = monster:getHandler(FightEntityHandlerType.AIHandler)
	AIContext4Action.targets = self._members
	handler:setAction(action,AIContext4Action)
end

function Fight:_excecuteAction()
	
	
	if self:_canFightEnd() then
				return
	end
	local i = 1
	local num = #ActionQueue
	for i = 1,num do
		local actionInfo = ActionQueue[i]
		--[[
		if actionInfo.role then
			print("----- 每回合执行动作 -----", i, actionInfo.role:getID())
		end
		print("--- 动作信息 ---", toString(actionInfo))
		--]]
		if table.isEmpty(actionInfo) then 
			break
		end
		if not actionInfo.isInvalid then
			--print("ready to do:",actionInfo.role:getID(),actionInfo.actionType,actionInfo.context and actionInfo.context.target)
			--没有设置怪物action,设置一下
			if instanceof(actionInfo.role,FightMonster) and (not actionInfo.actionType) and actionInfo.role:getIsGathering() == false then 
				self:_setMonsterAction(actionInfo)
			elseif instanceof(actionInfo.role,FightMonster) and actionInfo.role:getIsGathering() == true then 
				actionInfo = self:_getAutoAction(actionInfo.role)
			end
			if self:_canExcecuteAndDoSth(actionInfo) then			
				--print("do:",actionInfo.role:getID(),actionInfo.actionType,actionInfo.context and actionInfo.context.target)
				local oldAction ,actionType, role,doExcecute, context
				actionType = actionInfo.actionType
				role = actionInfo.role
				if actionInfo.isCounter == true and instanceof(role ,FightPlayer) == true then --TODO del
					print("counter error!")
				elseif actionInfo.isCounter == true then
					print("isCounter",role:getID())
				end
				--玩家(宠物)自动战斗
				if (not instanceof(role, FightMonster)) and (actionType == FightUIType.Auto or role:getIsGathering() == true) then
					oldAction = self:_getAutoAction(role)
					actionInfo = oldAction
					ActionQueue[i] = actionInfo
					actionType = oldAction.actionType
					doExcecute = FightActionMap[oldAction.actionType]
					context = oldAction.context
					print("111111111111111111111111",role:getIsGathering(),actionType)
				--普通战斗
				else
					doExcecute = FightActionMap[actionType]
					context = actionInfo.context
				end
				
				actionInfo.isDone = true --下次动态排序将不包括这个
				if actionInfo.actionSetIndex then
					self._actionSet[actionInfo.actionSetIndex].isDone = true --下次动态排序将不包括这个
				end
				--打印日志
				local strAction = ""
				if actionType == FightUIType.CommonAttack then
					strAction = "普攻"
				elseif actionType == FightUIType.UseSkill then
					local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
					local skill = handler:getSkill(context.skillID)
					local tmp_level = 0
					if instanceof(role, FightPlayer) then
						tmp_level = skill.level
					elseif instanceof(role, FightMonster) then
						tmp_level = role:getLevel()
					elseif instanceof(role, FightPet) then
						tmp_level = skill.level
					end
					strAction = "技能".."ID "..context.skillID.."等级"..tmp_level
				elseif actionType == FightUIType.Protect then
					strAction = "保护"
				elseif actionType == FightUIType.Escape then
					strAction = "逃跑"
				elseif actionType == FightUIType.Defense then
					strAction = "防御"
				elseif actionType == FightUIType.CallBack then
					strAction = "召回"
				else
				end
				local strLog = "\n动作发起人:"..role:getPos()[3]..role:getName().." 行为:"..strAction.."\n"
				Flog:log(strLog)--TODO del

				--执行
				local nextResult,skillResult --复活记录
				local attackedTargets
				local j = self._curResultIndex
				self._curResultIndex = self._curResultIndex + 1--self._curResultIndex在计算过程中可能变
				if (actionType ~= FightUIType.Protect and actionType ~= FightUIType.Defense and actionType ~= FightUIType.UseSkill and  actionType ~= FightUIType.CommonAttack) then 
					FightResults[j].actionType = actionType
					FightResults[j].roleID = role:getID()
					doExcecute(role, context, FightResults[j])
				else
					
					if actionType == FightUIType.UseSkill then
						skillResult,nextResult,attackedTargets = doExcecute(role, context, nil)
						FightResults[j] = skillResult
					elseif actionType == FightUIType.CommonAttack then
						FightResults[j].actionType = actionType
						FightResults[j].roleID = role:getID()
						nextResult = doExcecute(role, context, FightResults[j])
						-- print("--- 普通动作:doCommonAttack ---", toString(FightResults[j]))
					else
						doExcecute(role, context, nil)
					end
				
				end
				--
				if role:getLifeState() == RoleLifeState.Dead then
					if actionType == FightUIType.UseSkill then
						FightResults[j].lifeState = RoleLifeState.Dead
					else
						FightResults[j].lifeState = RoleLifeState.Dead
					end 
					--self._oldActions[role:getID()] = nil
				else
					--为自动战斗做准备
					if  actionType~=FightUIType.Call and actionType~=FightUIType.CallBack and actionType~=FightUIType.UseMaterial and  actionType~=FightUIType.Auto and actionType~=FightUIType.Catch and  actionType~=FightUIType.Escape then
						self._oldActions[role:getID()] = {actionType = actionType,role = role, context = context,isAuto = true}
					elseif actionType~=FightUIType.Auto then
						--self._oldActions[role:getID()] = {actionType = FightUIType.CommonAttack,role = role, context = actionInfo.context ,isAuto = true}
					end
				end
				--有复活数据
				if nextResult then
					FightResults[self._curResultIndex ] = nextResult	
					self._curResultIndex = self._curResultIndex + 1			
				end

				if actionType == FightUIType.CommonAttack then
					local monster = self:getRole(actionInfo.context.target)
					self:_judgeAndDoCounterAttack(actionInfo,monster, i + 1)
				-- 只有攻击系技能attackTargets返回才不为空
				elseif actionType == FightUIType.UseSkill and attackedTargets and table.size(attackedTargets) > 0 then
					local m = i
					for _, target in pairs(attackedTargets) do
						local bCounter = self:_judgeAndDoCounterAttack(actionInfo, target, m + 1)
						if bCounter then
							m = m + 1
						end
					end
				end
				
				if self:_canFightEnd() then
					break
				end
				
			else
				actionInfo.isDone = true --下次动态排序将不包括这个
				if actionInfo.actionSetIndex then
					self._actionSet[actionInfo.actionSetIndex].isDone = true --下次动态排序将不包括这个
				end
			end
		end
		i = i + 1			
	end	
end

function Fight:setMapID(mapID)
	self._mapID = mapID
end

function Fight:getMapID()
	return self._mapID
end

function Fight:onEnterFightEnd()
	--做收尾，
	--实体(玩家和宠物)改变的属性返回给场景服务器，通知客户端
	clearAttrs4tranfer()
	local scriptID 
	if self._fightType == FightType.Script then
		FightScript.onEnterFightEnd(self)
		scriptID = self:getScriptID()
	end

	local i = 1
	local j = 1
	for side ,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			if instanceof(role,FightPlayer) then
				FightUtils.setPlayerChangedAttrInfo(role,AttrsPool4transfer[i])
				AttrsPool4transfer[i].isPlayer = 1
				local bWin = false
				if side == self._winSide then
					AttrsPool4transfer[i].isWin = true
					bWin = true
				else
					AttrsPool4transfer[i].isWin = false
				end
				i = i + 1
				for _ ,petID in pairs(role:getPetList()) do
					local pet = g_fightEntityMgr:getRole(petID)
					--生成属性集
					storedPets4transfer[j].isPlayer = 0
					storedPets4transfer[j].isWin = bWin
					FightUtils.reduceWinPet(pet,bWin)
					FightUtils.setPetChangedAttrInfo(pet,storedPets4transfer[j])
					j = j + 1
				end
			elseif instanceof(role,FightPet)then

				if side == self._winSide then
					AttrsPool4transfer[i].isWin = true
					FightUtils.reduceWinPet(role,true)
				else
					AttrsPool4transfer[i].isWin = false
				end
				
				FightUtils.setPetChangedAttrInfo(role,AttrsPool4transfer[i])
				AttrsPool4transfer[i].isPlayer = 0
				
				i = i + 1
			else
			end
			--战斗结束清理buff
			g_fightBuffMgr:onFightEnd(role)
		end
	end

	local fightInfo
	if instanceof(self, FightScript_LuckyMonster) then
		fightInfo = {LuckMonster = self:getDeadMonsterInfo()}
	end

	local event = Event.getEvent(FightEvents_FS_FightEnd,AttrsPool4transfer,scriptID,self._allMonsterDBIDs,storedPets4transfer,self._world_fightID, fightInfo)
	RemoteEventProxy.sendToWorld(event,self._srcWorldID)
	--通知客户端
	--local event = Event.getEvent(FightEvents_FC_QuitFight)
	--self:informClient(event)
	--self:_informEscape()
	--销毁实体和战斗
	g_fightMgr:removeFight(self._id)
end
--[[
选动作超时处理
]]
function Fight.roundStartTimeOut(context)
	--print("Fight.roundStartTimeOut(context)")
	local fightID = context.fightID
	local fight = g_fightMgr:getFight(fightID)
	local timerID = fight:getRoundStartTimerID()
	if timerID  then 
		g_timerMgr:unRegTimer(timerID)
		fight:clearRoundStartTimerID()
	end

	if fight.state == FightState.RoundStart then 
		fight:gotoState(FightState.Caculate)
	end
	
end
--[[
播放动作超时处理
]]
function Fight.roundEndTimeOut(context)
	--print("Fight.roundEndTimeOut(context)")
	local fightID = context.fightID
	local fight = g_fightMgr:getFight(fightID)
	local timerID = fight:getRoundEndTimerID()
	if timerID  then 
		g_timerMgr:unRegTimer(timerID)
		fight:clearRoundEndTimerID()
	end
	fight:_informEscape()
	if fight.state == FightState.RoundEnd then 
		local bOver = fight:_canFightEnd()
		if bOver then
			fight:gotoState(FightState.FightEnd)
		else
			fight:gotoState(FightState.RoundStart)
		end
	end
end
--[[
战斗开始超时
]]
function Fight.onFightStartTimeOut(context)
	local fightID = context.fightID
	local fight = g_fightMgr:getFight(fightID)
	local timerID = fight:getFightStartTimerID()
	if timerID  then 
		g_timerMgr:unRegTimer(timerID)
		fight:clearFightStartTimerID()
	end
	
	if fight.state == FightState.Start then 
		fight:gotoState(FightState.RoundStart)
	end
end
function Fight.onOfflineTimeOut(context)
	local fightID = context.fightID
	local fight = g_fightMgr:getFight(fightID)
	if not fight then
		return
	end
	local timerID = fight:getOfflineTimeOutTimerID()
	if timerID  then 
		g_timerMgr:unRegTimer(timerID)
		fight:clearOfflineTimeOutTimerID()
	end

	fight:setWinSide(FightStand.B)
	fight:gotoState(FightState.FightEnd)

end
--[[
这场战斗是否都处于掉线状态
]]
function Fight:isAllOffline()
	local ALiveNum = 0
	local BLiveNum = 0
	for _,role in pairs(self._members[FightStand.A]) do
		
		if ( instanceof(role,FightPlayer) and not role:getOffline() ) then

			ALiveNum = 1
			break
		end
	end

	for _,role in pairs(self._members[FightStand.B]) do
		
		if ( instanceof(role,FightPlayer) and not role:getOffline() ) then
			BLiveNum = 1
			break
		end
	end

	if ALiveNum == 1 or BLiveNum == 1 then
		return false
	else
		return true
	end
	
end
--玩家离线处理
function Fight:onPlayerExit(player)
	print("onPlayerExit----------------------------")
	--等待客户端减一
	if player:getLifeState() == RoleLifeState.Normal then
		self._waitClientNum = self._waitClientNum - 1
		--self._waitActionNum = self._waitActionNum - 1
	end

	player:setOffline(true)

	--等待宠物动作减一
	local pet = FightUtils.findMyPet(player)
	if pet then
		pet:setOffline(true)
	end

	--播放阶段处理
	if self.state == FightState.RoundEnd then
		self._curWaitClientNum = self._curWaitClientNum - 1
		if self._curWaitClientNum == 0 then
			local bOver = self:_canFightEnd()
			if bOver then
				self:gotoState(FightState.FightEnd)
			else
				self:gotoState(FightState.RoundStart)
			end
			
		end
	--选择动作阶段处理
	elseif self.state == FightState.RoundStart then
		self._curWaitActionNum = self._curWaitActionNum - 1
		if pet then
			if pet:getLifeState() == RoleLifeState.Normal then
				self._curWaitActionNum = self._curWaitActionNum - 1
			end
		end

		if self._curWaitActionNum == 0 then
			self:gotoState(FightState.Caculate)
		end
	--战斗开始阶段处理
	elseif self.state == FightState.Start then
		self._curWaitClientNum = self._curWaitClientNum - 1
		if self._curWaitClientNum == 0 then
			self:gotoState(FightState.RoundStart)
		end
	end
	--玩家离线清理buff
	--g_fightBuffMgr:onFightEnd(player)
end

--玩家掉线后上线处理
function Fight:onPlayerAttached(player)
	player:setOffline(false)
	local pet = FightUtils.findMyPet(player)
	if pet then
		pet:setOffline(false)
	end
end

function Fight:update(timerID)
	local context = self._timerContext[timerID]
	if timerID == (self._fightStartTimerID or -1) then
		self._timerContext[timerID] = nil
		Fight.onFightStartTimeOut(context)
	elseif timerID == (self._roundStartTimerID or -1)  then
		self._timerContext[timerID] = nil
		Fight.roundStartTimeOut(context)
	elseif timerID == (self._offlineTimeOutTimerID or -1)  then
		self._timerContext[timerID] = nil
		Fight.onOfflineTimeOut(context)
	elseif timerID == (self._roundEndTimerID or -1)  then
		self._timerContext[timerID] = nil
		Fight.roundEndTimeOut(context)
	elseif timerID == (self._roundCalculateTimerID or -1)  then
		self._timerContext[timerID] = nil
		Fight.roundCaculateTimeOut(context)
	elseif timerID == (self._phaseStartTimerID or -1) then
		self._timerContext[timerID] = nil
		FightScript.onPhaseStartTimeOut(context)
	end
end
function Fight:__release()
	--print("Fight:__release()")
	self._id = nil
	for _ ,rolesInfo in pairs(self._members) do
		for _,role in pairs(rolesInfo) do
			local ID = role:getID()
			g_fightEntityMgr:removeRole(ID)
		end
	end

	self._members = nil
	self._actionSet = nil
	--self._offMembers = nil
	self._escapedRoles = nil
	self._oldActions = nil
	self._allMonsterDBIDs = nil
	if self._roundStartTimerID  then 
		g_timerMgr:unRegTimer(self._roundStartTimerID)
	end

	if self._roundEndTimerID  then 
		g_timerMgr:unRegTimer(self._roundEndTimerID)
	end 

	if self._roundCalculateTimerID  then 
		g_timerMgr:unRegTimer(self._roundCalculateTimerID)
	end 

	if self._fightStartTimerID  then 
		g_timerMgr:unRegTimer(self._fightStartTimerID)
	end 

	if self._offlineTimeOutTimerID then
		g_timerMgr:unRegTimer(self._offlineTimeOutTimerID)
	end
	print(" Fight:__release()")
end
