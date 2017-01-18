--[[ExperienceSystem.lua
	描述：历练系统
--]]

require "game.ExperienceSystem.ExperienceManager"
ExperienceSystem = class(EventSetDoer, Singleton)

function ExperienceSystem:__init()
	self._doer =
	{
		-- 历练系统升级 
		[Experience_CS_Learn]		= ExperienceSystem.onLearn,
	}
end

-- 历练系统升级
function ExperienceSystem:onLearn(event)
	local params = event:getParams()

	local roleID = event.playerID
	if not roleID then
		return
	end
	
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end
	local skillID = params[1]
	local upgradeCnt = params[2]
	-- 根据skillID去找配置
	local level 
	local result
	if upgradeCnt == 1 then
		result, level = self:learnExpSkill(player, skillID)
	else
		for inex = 1, upgradeCnt do 
			result, level = self:learnExpSkill(player, skillID)
			if not result then
				break
			end
		end
	end

	-- 发消息给客户端
	local event = Event.getEvent(Experience_SC_Learn, skillID, level)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 升一级技能
function ExperienceSystem:learnExpSkill(player, skillID)
	if not player then
		return
	end
	local expInfo = ExperienceDB[skillID]
	if not expInfo then
		return
	end
	-- 获取玩家的等级
	local playerLev = player:getLevel()
	local expPoint = player:getAttrValue(player_expoint)
	-- 获取配置所属历练的属性的类型
	local attrType = expInfo.attrType
	-- 效果
	local experienceHandler = player:getHandler(HandlerDef_Experience)
	local level =  experienceHandler:getExpSkillLev(skillID)
	if level >= playerLev then
		print("此时级别最高")
		self:sendExpMessageTip(player, 10)
		return false, level
	end
		
	local expCost = expInfo.expCost
	local cost = expCost[level] or 0
	if cost > expPoint then
		print("历练点不足")
		self:sendExpMessageTip(player, 9)
		return false, level
	end
	-- 先设置历练等级 
	level = level + 1
	experienceHandler:setExpSkillLev(skillID, level)
	-- 这是给玩家添加+
	local effect = expInfo.effect
	local value1 = effect[level] or 0
	local value2 = effect[level + 1] or 0
	
	player:addAttrValue(attrType, value2 - value1)

	-- 扣除历练
	local expPoint = player:getAttrValue(player_expoint)
	player:setAttrValue(player_expoint, expPoint - cost)
	-- 发个消息给客户端

	player:flushPropBatch()
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Experience, skillID, level)
	g_eventMgr:fireRemoteEvent(event, player)
	return true, level
end

-- 发提示消息给客户端
function ExperienceSystem:sendExpMessageTip(player, msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, 5, msgID)
	g_eventMgr:fireRemoteEvent(event, player)
end

function ExperienceSystem.getInstance()
	return ExperienceSystem()
end

EventManager.getInstance():addEventListener(ExperienceSystem.getInstance())