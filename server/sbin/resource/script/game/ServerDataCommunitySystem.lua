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
		[ChatEvents_SB_SendToTeam]				= ServerDataCommunitySystem.onSendToTeam,
		[ChatEvents_SB_SendToWorld]				= ServerDataCommunitySystem.onSendToWorld,
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

function ServerDataCommunitySystem:onSendToTeam(event)

	local params = event:getParams()
	local role = g_entityMgr:getPlayerByDBID(params[1])
	local h = role:getHandler(HandlerDef_Team)
	local teamID = h:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	local playerID = role:getID()
	local roleInfo = {ID = playerID,name = params[5].name}
	for _,memberInfo in pairs(team:getMemberList()) do
		local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
		local event = Event.getEvent(ChatEvents_SC_SendChatMsg,member:getDBID(),params[2],params[3],params[4],roleInfo,params[6])
		g_eventMgr:fireRemoteEvent(event, member)	
	end

end

function ServerDataCommunitySystem:onSendToWorld(event)

	local params = event:getParams()
	local role = g_entityMgr:getPlayerByDBID(params[1])
	local vigor = params[2]
	role:setVigor(vigor)
	role:flushPropBatch()
end

function ServerDataCommunitySystem.getInstance()
	return ServerDataCommunitySystem()
end

EventManager.getInstance():addEventListener(ServerDataCommunitySystem.getInstance())