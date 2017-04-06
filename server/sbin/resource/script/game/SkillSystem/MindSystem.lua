--[[MindSystem.lua
描述：
	心法
]]
require "game.SkillSystem.PerformSkill"

MindSystem = class(EventSetDoer, Singleton)

function MindSystem:__init()
	self._doer = {
		[SkillEvents_CS_LearnSkill]		= self.upgradeSkill,
		[SkillEvents_CS_GetMindLevel]	= self.getMindLevel,
		[SkillEvents_CS_LoadMinds]		= self.loadMinds,
		[SkillEvents_CS_UseSkill]		= self.useSkill,
	}
end

function MindSystem:upgradeSkill(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local handler = player:getHandler(HandlerDef_Mind)
	local params = event:getParams()
	local mindID = params[1]
	local upgrade_type = params[2]
	print ('upgradeSkill:', mindID, upgrade_type)
	local context = {}
	local mind = handler:get_mind(mindID)
	if not mind then
		print ('ERROR: not exist mind', mindID)
		return
	end
	if mind.level >= MAX_MIND_LEVEL then
		print ('ERROR: mind arrived max level')
		return
	end
	local add_max_level = 0
	if mind.db.position == 1 then
		add_max_level = player:getLevel() + 10 - mind.level
	else
		local main_level = handler:get_main_mind_level()
		add_max_level = main_level - mind.level
	end
	if upgrade_type == 0 then
		if add_max_level <= 0 then
			print ('ERROR: mind arrived max avalibe level')
			return
		end
	else
		if upgrade_type > add_max_level then
			print ('ERROR: mind arrived max avalibe level')
			return
		end
		add_max_level = upgrade_type
	end
	local mindmaxlevel = mind:getMaxlevel(add_max_level, mindID)
	if mindmaxlevel == 0 then
		print("money or pot is not enough!")
		return
	end
	
	local cost =mind:costPotMoney(mindmaxlevel,mindID)
	if cost == false then
		print("error!")
		return
	end
	
	add_max_level = mindmaxlevel
	local result = mind:upgrade(add_max_level)
	result.mindID = mindID
	self.answerUpgrade(player, result)
	if result.up_level == 0 then
		return
	end

	context.mind_id = mindID
	context.add_level = result.up_level
	LuaDBAccess.upgradeMind(player:getDBID(), mindID, result.up_level, self.onUpgradeMind, context)
end

function MindSystem.onUpgradeMind(recordList, context)
	if recordList._result ~= 0 then
		print ('ERROR: upgrade mind', context.mind_id, context.add_level)
	else
		print ('upgrade mind', context.mind_id, context.add_level)
	end
end

function MindSystem:getMindLevel(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local mindID = params[1]
	local mind = player:getHandler(HandlerDef_Mind):get_mind(mindID)
	if not mind then
		print ('ERROR: mind', mindID, 'not exist!')
	end
	local event = Event.getEvent(SkillEvents_SC_GetMindLevel, mindID, mind.level)
	g_eventMgr:fireRemoteEvent(event, player)
end

function MindSystem:loadMinds(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local handler = player:getHandler(HandlerDef_Mind)
	local event = Event.getEvent(SkillEvents_SC_LoadMinds, handler:get_minds())
	g_eventMgr:fireRemoteEvent(event, player)
	event = Event.getEvent(SkillEvents_SC_LoadMindsExt, handler:get_minds())
	g_eventMgr:fireRemoteEvent(event, player)
end

function MindSystem:useSkill(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local skillID = params[1]
	PerformSkill.perform(player, skillID)
end

function MindSystem.answerUpgrade(player, result)
	player:flushPropBatch()
	local event = Event.getEvent(SkillEvents_SC_LearnSkill, result.mindID, result.up_level, result.ec)
	g_eventMgr:fireRemoteEvent(event, player)
end

function MindSystem.getInstance()
	return MindSystem()
end
EventManager.getInstance():addEventListener(MindSystem.getInstance())
