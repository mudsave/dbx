--[[NewcomerGiftsSystem.lua
	描述：等级礼包
]]

require "data.NewComerGiftsDB"

NewcomerGiftsSystem  = class(EventSetDoer, Singleton)

function NewcomerGiftsSystem:__init()
	self._doer = {
		[NewcomerGifsEvent_CS_doRequestItemData]	= NewcomerGiftsSystem.onRequestItemData,
	}
end

function NewcomerGiftsSystem:onRequestItemData(event)
	local params = event:getParams()
	local player = g_entityMgr:getPlayerByID(params[1])
	local itemID = params[2]
	local itemGuid = params[3]
	local level = player:getLevel()
	local medicamentConfig = tMedicamentDB[itemID]
	local tatgetLevel = medicamentConfig.UseNeedLvl
	local flag = (tatgetLevel <= level)
	local itemData = tLoginGiftItems[itemID]
	local event = Event.getEvent(NewcomerGifsEvent_SC_doGetGiftsData,itemData,flag,itemGuid)
	g_eventMgr:fireRemoteEvent(event,player)
end


function NewcomerGiftsSystem.getInstance()    
	return NewcomerGiftsSystem()
end
EventManager.getInstance():addEventListener(NewcomerGiftsSystem.getInstance())