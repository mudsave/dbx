--[[AIHandler.lua
描述：
	战斗AI
--]]

require "base.base"


FightAIHandler = class(nil)


function FightAIHandler:__init(owner)
	self._owner = owner
	self._aiMgr = ChooseAIManager.getInstance()
	self._aiIDs = nil
	self._wordsID = nil
	self._skillID = nil
	
end
--[[
action: 战斗传入的，再设置好传回去
context: 战斗传入的，{targets=fight._members}好像没用到targets
]]
local canUsedSkills = {}
function FightAIHandler:setAction(action,context)
	
	action.context = {}
	action.role = self._owner
	--如果没配ai，随机一个技能
	if self._aiIDs == nil then
		local h = self._owner:getHandler(FightEntityHandlerType.SkillHandler)
		local skills = h:getSkills()
		table.clear(canUsedSkills)
		for _,skillID in ipairs(skills) do
			if self._owner:canUseSkill(skillID) then
					local skillInfo = MonsterSkillDB[skillID]
					if skillInfo.skill_type == Skill_Type.Normal then
							table.insert(canUsedSkills,skillID)
					end
			end
		end
		local num = #canUsedSkills
		if  num > 0 then
			local rand = math.random(num)
			local skillID = canUsedSkills[rand]

			action.actionType = FightUIType.UseSkill
			action.context.skillID = skillID
			action.context.targets = nil
			action.context.isEnemy = true
		end
	--按顺序执行AI
	else
		for _,AIID in ipairs(self._aiIDs ) do
			local actionType,targets ,params,isEnemy,skillID = self._aiMgr:choose(AIID ,self._owner,context.targets)
			action.actionType = actionType
			--没选中AI则下一个AI
			if actionType ~= nil then
					if actionType == FightUIType.UseSkill then--TODO 怪物技能
						action.context.skillID = skillID
						action.context.targets = targets
						action.context.isEnemy = isEnemy
					elseif actionType == FightUIType.CommonAttack then 
						if (not targets) or #targets == 0 then
							action.context.target = NonExistEntityPos
						else
							local pos = targets[1]:getPos()[3]
							action.context.target = pos 
						end
					elseif actionType == FightUIType.Call then 
						action.context.members = params
					elseif actionType == FightUIType.Protect then
						local target = targets[1]
						if target then
							local pos = target:getPos()[3]
							action.context.target = pos 
							print(pos)
						else
							--print("qqqqqqqqqq")
							print("cann't find protect target!")
						end
					
					end

					print("FightAIHandler:setAction(action,context)",instanceof(action.role,FightMonster),instanceof(target,FightPlayer))
					break
			end
		end
	end
	--都没选中则普攻
	if action.actionType == nil then
			action.actionType = FightUIType.CommonAttack
			action.context.target = NonExistEntityPos
	end
end

function FightAIHandler:setAIIDs(ID)
	self._aiIDs = ID
end

function FightAIHandler:getAIIDs()
	return self._aiIDs
end

function FightAIHandler:setWordsID(ID)
	self._wordsID = ID
end

function FightAIHandler:getWordsID()
	return self._wordsID
end

--[[
function FightAIHandler:getSkillID()
	return self._skillID
end

function FightAIHandler:setSkillID(ID)
	self._skillID = ID
end
]]




function FightAIHandler:__release()
	self._owner = nil
end