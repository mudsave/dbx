--[[DialogHandler.lua
描述：
	npc对话handler(对话系统)
--]]

DialogHandler = class()

function DialogHandler:__init(entity)
	self._entity = entity
	self._dialogIDs = {}		--npc身上挂的对话
end

function DialogHandler:__release()
	self._entity = nil
end

function DialogHandler:getDialogIDs()
	return self._dialogIDs
end

function DialogHandler:setDialogIDs(dialogIDs)
	self._dialogIDs = dialogIDs
end

function DialogHandler:onAction(player,context)
	
end