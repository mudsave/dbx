--[[ServerDataCommunitySystem.lua

    Author: Caesar
    Function: Sync the data between socialServer and worldServer

]]

ServerDataCommunitySystem = class(EventSetDoer, Singleton)

function ServerDataCommunitySystem:__init()
	self._doer = 
	{
		
		[FactionEvent_BB_UpdateWorldServerData]	= ServerDataCommunitySystem.onUpdateWorldServerData,
		[ChatEvents_SB_SendToAround]			= ServerDataCommunitySystem.onSendToAround,
	}
end


function ServerDataCommunitySystem:onUpdateWorldServerData( event )
	
	local params = event:getParams()
	local playerDBID = params[1]
	local updateCode = params[2]
	local player = g_entityMgr:getPlayerByDBID(playerDBID)
	if player then

		if updateCode == UpdateWorldServerDataCode.ExitFaction then
			player:setFactionDBID()
		elseif updateCode == UpdateWorldServerDataCode.JoinFaction then
			local factionDBID = params[3] or 1
			player:setFactionDBID(factionDBID)
		elseif updateCode == UpdateWorldServerDataCode.CreateFaction then
			local factionDBID = params[3] or 1
			player:setFactionDBID(factionDBID)
			player:setMoney(player:getMoney() - 300000)
			SceneManager:getInstance():createFactionScene(factionDBID)
		elseif updateCode == UpdateWorldServerDataCode.ContributeFaction then
			local moneyCount = params[3] or 0
			player:setMoney(player:getMoney() - moneyCount)
			player:flushPropBatch()
		end
		
	end

end

function ServerDataCommunitySystem:onSendToAround(event)

	local params = event:getParams()
	local player = g_entityMgr:getPlayerByDBID(params[1])
	local playerID = player:getID()
	local roleInfo = {ID = playerID,name = params[5].name}
	local event_SendToAround = Event.getEvent(ChatEvents_SC_SendChatMsg,playerID, params[2],params[3],params[4],roleInfo,params[6])
	RemoteEventProxy.sendToAround(event_SendToAround,player)

end

function ServerDataCommunitySystem.getInstance()
	return ServerDataCommunitySystem()
end

EventManager.getInstance():addEventListener(ServerDataCommunitySystem.getInstance())