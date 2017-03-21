--[[FightSystemAction.lua
描述：
	战斗系统动作(对应ScriptFightActionType)
--]]

require "base.base"


FightSystemAction = class(nil, Singleton)
--系统行为协议
--[[
播动画:{actionType = FightActionType.System,type =ScriptFightActionType.PlayAnimation ,params={fileName = "vvv"}}
播气泡:{actionType = FightActionType.System,type =ScriptFightActionType.PlayBubble ,params={IDs = {1000},bubbleID = 2}}
播对话:{actionType = FightActionType.System,type =ScriptFightActionType.PlayDialog ,params={DialogID =11}}
播动作:{actionType = FightActionType.System,type =ScriptFightActionType.PlayAction ,params={IDs = {11},actionID = 2}}
播光效:{actionType = FightActionType.System,type =ScriptFightActionType.PlayEffect ,params={magicID = 1,IDs = {22},type = EffectType.Unit}}
变换实体:{actionType = FightActionType.System,type =ScriptFightActionType.ReplaceEntity ,params={IDs = {[1] = monsterInfo} , actionID = 3}}
实体离开:{actionType = FightActionType.System,type =ScriptFightActionType.EntityQuit ,params={IDs = {2},actionID = 3}}
实体进入:{actionType = FightActionType.System,type = ScriptFightActionType.EntityEnter,params = {monsterInfo1,monsterInfo2,}}
使用技能:{actionType = FightActionType.System,type =ScriptFightActionType.UseSkill ,params={}}
加Buff:{actionType = FightActionType.System,type =ScriptFightActionType.AddBuff ,params={}}
去buff:{actionType = FightActionType.System,type =ScriptFightActionType.RemoveBuff ,params={}}
设置重伤:{actionType = FightActionType.System,type =ScriptFightActionType.SetGBH ,params={IDs = {2}}
暂停:{actionType = FightActionType.System,type =ScriptFightActionType.FightPause ,params={time = 5}}--秒
玩家全部逃离:{actionType = FightActionType.System,type =ScriptFightActionType.MakeEscape ,params={}}
交换位置:{actionType = FightActionType.System,type =ScriptFightActionType.ExchangePos ,params={curPos = 2,targetPos = 10}}
]]

function FightSystemAction:__init()
	
end

--[[
	params={fileName = "XXX"}
]]
function FightSystemAction.PlayAnimation(fight,params,result,bInserted)
		local AnimationResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayAnimation ,params={}}
		AnimationResult.params.fileName = params.fileName
		if not result then
			FightUtils.insertFightResult(fight,AnimationResult,bInserted)
		else
			table.insert(result,AnimationResult)
		end
end

local function SystemActionFindOnePlayer(fight)
			local membersA = fight:getMembers()[FightStand.A]
			local player
			for _ ,role in pairs(membersA) do
				if instanceof(role,FightPlayer) and role:getLifeState() ~= RoleLifeState.Dead then
					player = role
					if player:getIsTeamHead() then
						break
					end
				end
			end
			return player
end

local function SystemActionFindOneRandomPlayer(fight)
			local membersA = fight:getMembers()[FightStand.A]
			local player
			local count = table.size(membersA)
			local rand = math.random(count)
			local i = 0
			for _ ,role in pairs(membersA) do
				i = i + 1
				if instanceof(role,FightPlayer) and role:getLifeState() ~= RoleLifeState.Dead then
					player = role
					if i == rand then
						break
					end
				end
			end
			return player
end

--[[
	params={DBID={11},bubbleID = XXX}
]]
function FightSystemAction.PlayBubble(fight,params,result,bInserted)
	local bHas = false
	local BubbleResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayBubble ,params={}}
	local members = fight:getMembers()[FightStand.B]
	BubbleResult.params.IDs = {}
	for _,DBID in pairs(params.DBID) do
		if DBID > 0 then
			local targets = FightUtils.getTargetsByDBID(members,DBID)
			if targets and #targets > 0 then
				bHas = true
				for _, targetID in ipairs(targets)  do
					table.insert(BubbleResult.params.IDs,targetID)
				end
			end
		elseif DBID == 0 then
			
			local player = SystemActionFindOnePlayer(fight)
			
			if player then
				bHas = true
				table.insert(BubbleResult.params.IDs,player:getID())
			end
		end
	end
	
	BubbleResult.params.bubbleID = params.bubbleID
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,BubbleResult,bInserted)
		else
			table.insert(result,BubbleResult)
			result.bHas = true
		end
	end
end



--[[
	params={ID=11}
]]
function FightSystemAction.PlayDialog(fight,params,result,bInserted)
	local DialogResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayDialog ,params={}}
	DialogResult.params.DialogID = params.ID
	if not result then
		FightUtils.insertFightResult(fight,DialogResult,bInserted)
	else
		table.insert(result,DialogResult)
		result.bHas = true
	end
end



--[[
	params={DBID={11},actionID =22}
]]
function FightSystemAction.PlayAction(fight,params,result,bInserted)
	local bHas = false
	local ActionResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayAction ,params={}}
	ActionResult.params.IDs = {}
	local members = fight:getMembers()[FightStand.B]
	for _,DBID in pairs(params.DBID) do
		if DBID > 0 then
			local targets = FightUtils.getTargetsByDBID(members,DBID)
			if targets and #targets > 0 then
				bHas = true
				for _, targetID in ipairs(targets)  do
					table.insert(ActionResult.params.IDs,targetID)
				end
			end
		elseif DBID == 0 then
			local player = SystemActionFindOnePlayer(fight)
			
			if player then
				bHas = true
				table.insert(ActionResult.params.IDs,player:getID())
			end
		end
	end
	ActionResult.params.actionID = params.actionID
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,ActionResult,bInserted)
		else
			table.insert(result,ActionResult)
			result.bHas = true
		end
	end
end

--[[
	params={magicID = 1,DBID ={22},type = LightEffectType.Unit}
]]
function FightSystemAction.PlayEffect(fight,params,result,bInserted)
	local bHas
	local EffectResult
	local members = fight:getMembers()[FightStand.B]
	if  params.type == LightEffectType.Unit then
		for _,DBID in pairs(params.DBID) do
			if DBID > 0 then
				local targets = FightUtils.getTargetsByDBID(members,DBID)
				if targets and #targets > 0 then
					if not bHas then
						bHas = true
						EffectResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayEffect ,params={}}
						EffectResult.params.IDs = {}
						EffectResult.params.magicID = params.magicID
						EffectResult.params.type = params.type
					end
					for _, targetID in ipairs(targets)  do
						table.insert(EffectResult.params.IDs,targetID)
					end
				end
			elseif DBID == 0 then
				local player = SystemActionFindOnePlayer(fight)
				if player then
					if not bHas then
						bHas = true
						EffectResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayEffect ,params={}}
						EffectResult.params.IDs = {}
						EffectResult.params.magicID = params.magicID
						EffectResult.params.type = params.type
					end
					table.insert(EffectResult.params.IDs,player:getID())
				end
			elseif DBID == -1 then
				local player = SystemActionFindOneRandomPlayer(fight)
				if player then
					if not bHas then
						bHas = true
						EffectResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayEffect ,params={}}
						EffectResult.params.IDs = {}
						EffectResult.params.magicID = params.magicID
						EffectResult.params.type = params.type
					end
					table.insert(EffectResult.params.IDs,player:getID())
				end
			end
		end
	else
		bHas = true
		EffectResult = {actionType = FightActionType.System,type =ScriptFightActionType.PlayEffect ,params={}}
		EffectResult.params.IDs = {}
		EffectResult.params.magicID = params.magicID
		EffectResult.params.type = params.type
	end
	
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,EffectResult,bInserted)
		else
			table.insert(result,EffectResult)
			result.bHas = true
		end
	end
end


--[[
	params={curID ={22},replaceID = 11,actionID = 1(or effectID = 1)}
]]
function FightSystemAction.ReplaceEntity(fight,params,result,bInserted)
	local bHas = false
	local ReplaceResult = {actionType = FightActionType.System,type =ScriptFightActionType.ReplaceEntity ,params={}}
	ReplaceResult.params.IDs = {}
	local members = fight:getMembers()[FightStand.B]
	for _,DBID in pairs(params.curID) do
		local targets = FightUtils.getTargetsByDBID(members,DBID)
		if targets and #targets > 0 then
			bHas = true
			for _, targetID in ipairs(targets)  do
				local newTarget = fight:replaceEntity( params.replaceID,targetID)
				local info = {}
				FightUtils.setMonsterInfo4Client({newTarget},info,nil)
				ReplaceResult.params.IDs[targetID] = info[1]
			end
		end
	end
	
	if params.actionID then
		ReplaceResult.params.actionID = params.actionID
	elseif params.effectID then
		ReplaceResult.params.effectID = params.effectID
	end
	
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,ReplaceResult,bInserted)
		else
			table.insert(result,ReplaceResult)
			result.bHas = true
		end
	end
end


--[[
	params={DBID ={22},actionID = 1}
]]
function FightSystemAction.EntityQuit(fight,params,result,bInserted)

	local bHas
	local QuitResult = {actionType = FightActionType.System,type =ScriptFightActionType.EntityQuit ,params={}}
	QuitResult.params.IDs = {}
	local members = fight:getMembers()[FightStand.B]
	for _,DBID in pairs(params.DBID) do
		local targets = FightUtils.getTargetsByDBID(members,DBID)
		if targets and #targets > 0 then
			bHas = true
			for _, targetID in ipairs(targets)  do
				table.insert(QuitResult.params.IDs,targetID)
				local target = g_fightEntityMgr:getRole(targetID)
				fight:removeRole(target,true)
			end
		end
	end
	QuitResult.params.actionID = params.actionID
	
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,QuitResult,bInserted)
		else
			table.insert(result,QuitResult)
			result.bHas = true
		end
	end
	
end


------------招怪-----------------------------------------
--[[
params={{DBID = 1,actionID = 1(or effectID = 1),count = 1},}
result:脚本战斗传来的指定结果位置
fightResult:普通战斗传来的指定结果位置
]]
function FightSystemAction.EntityEnter(fight,params,result,bInserted,fightResult)
--print("FightSystemAction.EntityEnter")
	local ResultCallMembers 
	if fightResult then
		ResultCallMembers = {}
		fightResult.targetsInfo = ResultCallMembers
		fightResult.callType = FightCallType.Monster
		fightResult.success = true
	else
		ResultCallMembers = {actionType = FightActionType.System ,type = ScriptFightActionType.EntityEnter,params = {}}
	end
	local totalCount = 0
	for _,info in ipairs(params) do
		totalCount= totalCount + (info.count or 1)
	end
	if totalCount == 0 then
		print("配置出错,怪物数量为0!")
		return
	end
	local members = fight:getMembers()
	totalCount = totalCount + table.size(members[FightStand.B])
	--生成怪物加入战斗
	local fightID = fight:getID()
	local monsters = {}
	for _,info in ipairs(params) do
		local monsterDBID = info.DBID or info.ID
		for i = 1 , info.count or 1 do
			local monster = g_fightEntityFactory:createMonster(monsterDBID)
			monster:setFightID(fightID)
			if info.actionID then
				monster:setEnterActionID(info.actionID)
			elseif info.effectID then
				monster:setEnterEffectID(info.effectID)
			end
			
			local pos = fight:getRolePos(StandRoleType.Monster, FightStand.B, totalCount)
			if pos then
				fight:addRole(FightStand.B, pos, monster)
			end
			table.insert(monsters,monster)
		end
	end

	--设置怪物信息
	if fightResult then
		FightUtils.setMonsterInfo4Client(monsters,ResultCallMembers,nil)
	else
		FightUtils.setMonsterInfo4Client(monsters,ResultCallMembers.params,nil)
	end

	if not fightResult then 
		if not result then
			FightUtils.insertFightResult(fight,ResultCallMembers,bInserted)
		else
			table.insert(result,ResultCallMembers)
			result.bHas = true
		end
	end
end

--[[
	params={DBID ={22},skillID = 1} 或 {targetType = ScriptFightTargetType.AnyOfEnemys,skillID = 1}
]]
local skillTargets = {}
function FightSystemAction.UseSkill(fight,params,result,bInserted)
--print("111111111111111111111111111111",toString(params))
	table.clear(skillTargets)
	local bHas
	--local SkillResult = {actionType = FightActionType.System,type =ScriptFightActionType.UseSkill ,params={}}
	-- 技能等级暂时默认为1
	local skill = g_SystemSkillMgr:getSkill(params.skillID,1)
	if params.DBID then
		local members = fight:getMembers()[FightStand.B]
		for _,DBID in pairs(params.DBID) do
			local targets = FightUtils.getTargetsByDBID(members,DBID)
			if targets and #targets > 0 then
				bHas = true
				for _, targetID in ipairs(targets)  do
					local target = g_fightEntityMgr:getRole(targetID)
					table.insert(skillTargets,target)
				end
			end
		end
	elseif params.targetType then
		local target
		if  params.targetType == ScriptFightTargetType.AnyOfEnemys then
			local members = fight:getMembers()[FightStand.A]
			target = FightUtils.findRandomTarget(members,nil)
			if target then
				bHas = true
				table.insert(skillTargets,target)
			end
		elseif params.targetType == ScriptFightTargetType.AnyOfFriends then
			local members = fight:getMembers()[FightStand.B]
			target = FightUtils.findRandomTarget(members,nil)
			if target then
				bHas = true
				table.insert(skillTargets,target)
			end
		end
	end

	if bHas then
		local result1 = skill:perform(skillTargets,FightStand.B)
		if not result then
			FightUtils.insertFightResult(fight,result1,bInserted)
		else
			table.insert(result,result1)
			result.bHas = true
		end
		table.clear(skillTargets)
	end
end

--[[
	params={DBID ={22},buffID = 2}或 {targetType = ScriptFightTargetType.AnyOfEnemys,buffID = 2}
]]
function FightSystemAction.AddBuff(fight,params,result,bInserted)
	local bHas
	local AddBuffResult = {actionType = FightActionType.System,type =ScriptFightActionType.AddBuff ,params={}}
	AddBuffResult.params.IDs = {}
	AddBuffResult.params.buffID = params.buffID
	
	local buffTargets = {}
	if params.DBID then
		local members = fight:getMembers()[FightStand.B]
		for _,DBID in pairs(params.DBID) do
			local targets = FightUtils.getTargetsByDBID(members,DBID)
			if targets and #targets > 0 then
				bHas = true
				for _, targetID in ipairs(targets)  do
					local target = g_fightEntityMgr:getRole(targetID)
					g_fightBuffMgr:addBuff(nil,target,params.buffID,1)
					table.insert(AddBuffResult.params.IDs,targetID)
				end
			end
		end
	elseif params.targetType then
		local target
		if  params.targetType == ScriptFightTargetType.AnyOfEnemys then
			local members = fight:getMembers()[FightStand.A]
			target = FightUtils.findRandomTarget(members,nil)
			if target then
				bHas = true
				g_fightBuffMgr:addBuff(nil,target,params.buffID,1)
				table.insert(AddBuffResult.params.IDs,target:getID())
			end
		elseif params.targetType == ScriptFightTargetType.AnyOfFriends then
			local members = fight:getMembers()[FightStand.B]
			target = FightUtils.findRandomTarget(members,nil)
			if target then
				bHas = true
				g_fightBuffMgr:addBuff(nil,target,params.buffID,1)
				table.insert(AddBuffResult.params.IDs,target:getID())
			end
		end
	end
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,AddBuffResult,bInserted)
		else
			table.insert(result,AddBuffResult)
			result.bHas = true
		end
	end
end

--[[
	params={DBID ={22},buffID = 2}或 {targetType = ScriptFightTargetType.AnyOfEnemys,buffID = 2}
]]
function FightSystemAction.RemoveBuff(fight,params,result,bInserted)
	local Has
	local RemoveBuffResult = {actionType = FightActionType.System,type =ScriptFightActionType.RemoveBuff ,params={}}
	RemoveBuffResult.params.IDs = {}
	RemoveBuffResult.params.buffID = params.buffID

	if params.DBID then
		local members = fight:getMembers()[FightStand.B]
		for _,DBID in pairs(params.DBID) do
			local targets = FightUtils.getTargetsByDBID(members,DBID)
			if targets and #targets > 0 then
				bHas = true
				for _, targetID in ipairs(targets)  do
					local target = g_fightEntityMgr:getRole(targetID)
					g_fightBuffMgr:doRemoveBuffByID(target,params.buffID)
					table.insert(RemoveBuffResult.params.IDs,targetID)
				end
			end
		end
	elseif params.targetType then
		local target
		if  params.targetType == ScriptFightTargetType.AnyOfEnemys then
			local members = fight:getMembers()[FightStand.A]
			target = FightUtils.findRandomTarget(members,nil)
			if target then
				bHas = g_fightBuffMgr:doRemoveBuffByID(target,params.buffID)
			end
		elseif params.targetType == ScriptFightTargetType.AnyOfFriends then
			local members = fight:getMembers()[FightStand.B]
			target = FightUtils.findRandomTarget(members,nil)
			if target then
				bHas = g_fightBuffMgr:doRemoveBuffByID(target,params.buffID)
			end
		end
		if has then
			table.insert(RemoveBuffResult.params.IDs,target:getID())
		end
	end
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,RemoveBuffResult,bInserted)
		else
			table.insert(result,RemoveBuffResult)
			result.bHas = true
		end
	end
end


--[[
	params={DBID ={22},}
]]
function FightSystemAction.SetGBH(fight,params,result,bInserted)
	local bHas
	local GBHResult = {actionType = FightActionType.System,type =ScriptFightActionType.SetGBH ,params={}}
	GBHResult.params.IDs = {}
	local members = fight:getMembers()[FightStand.B]
	for _,DBID in pairs(params.DBID) do
		local targets = FightUtils.getTargetsByDBID(members,DBID)
		if targets and #targets > 0 then
			bHas = true
			for _, targetID in ipairs(targets)  do
				table.insert(GBHResult.params.IDs,targetID)
				local target = g_fightEntityMgr:getRole(targetID)
				target:setIsToGBH(true)
			end
		end
	end
	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,GBHResult,bInserted)
		else
			table.insert(result,GBHResult)
			result.bHas = true
		end
	end
end

--[[
	params={time = 2}
]]
function FightSystemAction.FightPause(fight,params,result,bInserted)
	local PauseResult = {actionType = FightActionType.System,type =ScriptFightActionType.FightPause ,params={}}
	PauseResult.params.time = params.time
	if not result then
		FightUtils.insertFightResult(fight,PauseResult,bInserted)
	else
		table.insert(result,PauseResult)
	end
end
--[[
params={winner = "monster" 或 "player"}
]]
function FightSystemAction.FightEnd(fight,params,result,bInserted)
	fight:setEnd(true)
	if params.winner == "monster" then
		fight:setWinSide(FightStand.B)
	elseif params.winner == "player" then
		fight:setWinSide(FightStand.A)
	end
end

--[[
	params={}
]]
function FightSystemAction.MakeEscape(fight,params,result,bInserted)
	local EscapeResult = {actionType = FightActionType.System,type =ScriptFightActionType.MakeEscape ,params={}}
	if not result then
		FightUtils.insertFightResult(fight,EscapeResult,bInserted)
	else
		table.insert(result,EscapeResult)
		result.bHas = true
	end
	fight:setEnd(true)
end

--[[
	params={DBID ={22},value = 0.5}
]]
function FightSystemAction.SetCounterRate(fight,params)
	local bHas
	local members = fight:getMembers()[FightStand.B]
	for _,DBID in pairs(params.DBID) do
		local targets = FightUtils.getTargetsByDBID(members,DBID)
		if targets and #targets > 0 then
			bHas = true
			for _, targetID in ipairs(targets)  do
				local target = g_fightEntityMgr:getRole(targetID)
				target:setAdd_Unhit(params.value or 0.5)
			end
		end
	end
end

--[[
	params={curPos = 21,targetPos =23}
]]
function FightSystemAction.ExchangePos(fight,params,result,bInserted)
	local ExchangePosResult = {actionType = FightActionType.System,type =ScriptFightActionType.ExchangePos ,params={}}
	local targetPos = fight:exchangePos(params.curPos,params.targetPos)
	if targetPos then
		ExchangePosResult.params.curPos = params.curPos
		ExchangePosResult.params.targetPos = targetPos
		
		if not result then
			FightUtils.insertFightResult(fight,ExchangePosResult,bInserted)
		else
			table.insert(result,ExchangePosResult)
			result.bHas = true
		end
	else
		print("没有合适的位置换位！")
	end

end

--[[
	params={DBID ={22},percent=-20}
]]
function FightSystemAction.ChangeHp(fight,params,result,bInserted)
	local bHas,changeHpResult
	local members = fight:getMembers()[FightStand.B]
	local players = fight:getMembers()[FightStand.A]
	--玩家
	if params.DBID == -1 then
		bHas = true
		changeHpResult = {actionType = FightActionType.System,type =ScriptFightActionType.ChangeHp ,params={}}
		for _,target in pairs(players) do
			if instanceof(target, FightPlayer) then
				local curHp = target:getHp()
				local changedHp = math.floor(curHp*(params.percent/100))
				local finalHp
				if changedHp > 0 then
					finalHp = curHp + changedHp
					if finalHp > maxHp then
						finalHp = maxHp
					end
				elseif changedHp <= 0 then
					finalHp = curHp + changedHp
					if finalHp < 0 then
						finalHp = 0
					end
				end

				target:setHp(finalHp)
				local targetID = target:getID()
				table.insert(changeHpResult.params,{ID = targetID,value = changedHp})
			end
		end
	--怪物
	else
		
		for _,DBID in pairs(params.DBID) do
			local targets = FightUtils.getTargetsByDBID(members,DBID)
			if targets and #targets > 0 then
				if not bHas then
					bHas = true
					changeHpResult = {actionType = FightActionType.System,type =ScriptFightActionType.ChangeHp ,params={}}
				end
				for _, targetID in ipairs(targets)  do
					local target = g_fightEntityMgr:getRole(targetID)
					local maxHp = target:getMaxHp()
					local changedHp = maxHp*(params.percent/100)
					local curHp = target:getHp()
					local finalHp
					if changedHp > 0 then
						finalHp = curHp + changedHp
						if finalHp > maxHp then
							finalHp = maxHp
						end
					elseif changedHp <= 0 then
						finalHp = curHp + changedHp
						if finalHp < 0 then
							finalHp = 0
						end
					end

					target:setHp(finalHp)
					local lifeState
					if finalHp == 0 then
						target:setLifeState(RoleLifeState.Dead)
						lifeState = RoleLifeState.Dead
					end
					table.insert(changeHpResult.params,{ID = targetID,value = changedHp,lifeState = lifeState})
				end
			end
		end
	end

	if bHas then
		if not result then
			FightUtils.insertFightResult(fight,changeHpResult,bInserted)
		else
			table.insert(result,changeHpResult)
			result.bHas = true
		end
	end
end

--[[
	params={value = 5}
]]
function FightSystemAction.AddScore(fight,params,result,bInserted)
	local curScore = fight:getScore()
	local score = curScore + params.value
	fight:setScore(score)
end

--[[
	params={type = "exp",mode = "value",value = 100}
]]
function FightSystemAction.ChangeReward(fight,params,result,bInserted)
	local info = fight:getRewardFactorInfo()
	local type = params.type
	local mode = params.mode
	local value = params.value

	local factor = info[type]
	if not factor then
		info[type] = {mode = mode,value = value}
	else
		if mode == factor.mode then
			factor.value = factor.value + value
		end
	end
end