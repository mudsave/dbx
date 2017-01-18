--[[MindHandler.lua
描述：
	心法handler
--]]
require "game.SkillSystem.Mind"

MindHandler = class()

function MindHandler:__init(entity)
	self._entity = entity
	self.minds = {}
	self.main_mind = nil
end

function MindHandler:__release()
	self._entity = nil
	self.minds = nil
end

function MindHandler:gm_set_mind_level(id, level)
	if self:get_mind(id) then
		self:get_mind(id).level = level
	end
end

function MindHandler:get_mind(id)
	return self.minds[id] and self.minds[id] or nil
end

function MindHandler:get_main_mind_level()
	return self.minds[self.main_mind].level
end

function MindHandler:loadMinds()
	local dbid = self._entity:getDBID()
	LuaDBAccess.loadMinds(dbid, self.on_minds_load, dbid)
end

function MindHandler.on_minds_load(recordList, role_dbid)
	local player = g_entityMgr:getPlayerByDBID( role_dbid )
	local handler = player:getHandler(HandlerDef_Mind)
	--print ('recordList', toString(recordList) )
	if recordList._result ~= 0 then
		print ('ERROR: load minds')
		return
	end
	local minds = recordList[1]
	for _,item in pairs(minds) do
		local mind = Mind(handler, player, item.mindID, item.level)
		if mind.db.position == 1 then
			handler.main_mind = item.mindID
		end
		table.insert(handler.minds, mind.id, mind)
	end
	local tmp_minds = MindHandler.deal(handler)
	local event = Event(SkillEvents_SC_LoadMindsExt, handler:get_minds())
	g_eventMgr:fireRemoteEvent(event, player)

	handler:show()
end

function MindHandler:deal()
	local school = self._entity:getSchool()
	if not school or shcool == 0 then
		return false
	end
	local dbid = self._entity:getDBID()
	local s_minds = SchoolMind[school]
	for _,iter in pairs(s_minds) do
		if not self.minds[iter] then
			if MindDB[iter].position == 1 then
				self.main_mind = iter
				LuaDBAccess.addMind(dbid, iter, 1)
				local mind = Mind(self, self._entity, iter, 1)
				table.insert(self.minds, mind.id, mind)
			else
				LuaDBAccess.addMind(dbid, iter, 0)
				local mind = Mind(self, self._entity, iter, 0)
				table.insert(self.minds, mind.id, mind)
			end
		end
	end
	return true
end

function MindHandler:handleLevelInc()
	local incValue = self._entity:getAttrValue(player_add_mind_level)
	for _,mind in pairs(self.minds) do
		mind:handleLevelInc(incValue)
	end
	return true
end

function MindHandler:show()
	local str = 'minds:'
	for _,item in pairs(self.minds) do
		str = str .. toString(item.id) .. ', '
	end
	print (str)
end

function MindHandler:get_minds()
	local minds = {}
	for i,v in pairs(self.minds) do
		minds[i] = v.level
	end
	return minds
end
