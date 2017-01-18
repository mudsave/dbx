--ChooseAI.lua
 
 require "data.FightAIDB"
 require "data.SpeakAIDB"
 

ChooseAIManager = class(nil,Singleton)

function ChooseAIManager:__init()
end

--[[
 AnyOfEnemy		 = 3,--敌方任意 {  type = AITargetType.AnyOfEnemy, params ={},},
				 AnyOfFriendButMe = 4,--除自己外友方任意 {  type = AITargetType.AnyOfFriendButMe, params ={},},
				 AllOfEnemy		 = 5,--敌方全体 {  type = AITargetType.AllOfEnemy, params ={},},
				 AllOfFriend	 = 6,--友方方全体 {  type = AITargetType.AllOfFriend, params ={},},
				 AllRoleOfEnemy	 = 7,--敌方全体角色(伪pvp中的玩家) {  type = AITargetType.AllRoleOfEnemy, params ={},},
				 AllPetOfEnemy	 = 8,--敌方全体宠物  {  type = AITargetType.AllPetOfEnemy, params ={},},
				 AnyRoleOfEnemy	 = 9,--敌方任意角色(伪pvp中的玩家) {  type = AITargetType.AnyRoleOfEnemy, params ={},},
				 AnyPetOfEnemy	 
]]

function ChooseAIManager:choose(chooseID,role,oldTargets)

	local records = FightAIDB[chooseID]
	
	if records.type == AIType.Config then
		for _,actionInfo in ipairs(records) do
			local chooseTarget = actionInfo.chooseTarget
			local isEnemy 
			if chooseTarget.type == AITargetType.AnyOfEnemy or chooseTarget.type == AITargetType.AllOfEnemy or chooseTarget.type == AITargetType.AllRoleOfEnemy or chooseTarget.type == AITargetType.AllPetOfEnemy or chooseTarget.type == AITargetType.AnyRoleOfEnemy  or chooseTarget.type == AITargetType.AnyPetOfEnemy then                                                                                                                                         
				isEnemy = true
			elseif chooseTarget.type == AITargetType.AnyOfFriendButMe  or chooseTarget.type == AITargetType.AllOfFriend  or chooseTarget.type == AITargetType.AnyOfFriend or chooseTarget.type == AITargetType.Me or chooseTarget.type == AITargetType.DeadFriend then
				isEnemy = false
			else
				isEnemy = chooseTarget.params.isEnemy
			end
			local action = actionInfo.action
			local condition = actionInfo.condition
			--判断条件
			local conditionChecker = FightAIConditionMap[condition.type]
			local fightID = role:getFightID()
			local fight = g_fightMgr:getFight(fightID)
			local bPass,skillID

			if conditionChecker == nil then
				bPass = true
			else
				bPass = conditionChecker(role,fight,condition.params)
				
			end

			--随机一个技能,以及是否冷却
			if bPass and action.actionType == FightUIType.UseSkill then
				local skillIDs = action.params.skillID
				local canSkillIDs = {}
				for _,ID in ipairs(skillIDs) do
					if role:canUseSkill(ID) then
						table.insert(canSkillIDs,ID)
					end
				end
				if #canSkillIDs > 0 then
					local rand = math.random(#canSkillIDs)
					print("rand skill=",rand)
					skillID = canSkillIDs[rand]
				else
					bPass = false
				end
				
			end 

			if bPass then
			--选目标
				local targetFinder = FightAITargetMap[chooseTarget.type]
				local targets = targetFinder(role,fight,chooseTarget.params)
			--执行
				local actionType = action.actionType
				local params = action.params
			--返回
				if actionType == FightUIType.CommonAttack or actionType == FightUIType.UseSkill or actionType == FightUIType.Protect  then
					--是否选中目标
					if #targets > 0 then
						return actionType,targets,params,isEnemy,skillID
					end
				else
					return actionType,targets,params,isEnemy
				end
				
			end
		end
		
	elseif records.type == AIType.Script and  rec.scriptID then
		local fun = AIScriptDB[rec.scriptID]
		actionType,targets,params = fun(role,targets)
		return actionType,targets,params
	end
	return nil
end


function ChooseAIManager.getInstance()
	return ChooseAIManager()
end
