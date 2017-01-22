--[[ChatManager.lua

    Function: The manager of chatSystem
    Author: Caesar

--]]



ChatManager = class(nil, Singleton)

function ChatManager:__init()
	
end

function ChatManager:sendMessage(role, channelType, message, sign, context)

	local roleInfo = {DBID = role:getDBID(), name = role:getName(),ID = role:getID()}
	--帮会频道
	if channelType == ChatChannelType.Faction then
		--给当前帮会在线成员发送帮派消息
		local factionDBID = role:getHandler(HandlerDef_Faction):getFactionDBID()
		local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
		if faction then
			local memberList = faction:getMemberList()
			for memberDBID,memberInfo in pairs(memberList) do 
				local member = g_playerMgr:getPlayerByDBID(memberDBID)
				if member then
					local event = Event.getEvent(ChatEvents_SC_SendChatMsg,0,0,ChatChannelType.Faction, message, roleInfo ,sign)
					g_eventMgr:fireRemoteEvent(event, member)
				end
			end
		end

	--门派频道
	elseif channelType == ChatChannelType.School then

		local schoolID = role:getSchool()
		local onlinePlayers = g_playerMgr:getOnlinePlayers()
		for _,player in pairs(onlinePlayers) do
			if player:getSchool() == schoolID then
				local event = Event.getEvent(ChatEvents_SC_SendChatMsg,0,0,ChatChannelType.School, message, roleInfo ,sign)
				g_eventMgr:fireRemoteEvent(event, player)
			end
		end

	--私人频道
	elseif channelType == ChatChannelType.Private then

		local targetID = context
		local target = g_playerMgr:getPlayerByDBID(targetID)
		local event = Event.getEvent(ChatEvents_SC_SendChatMsg,0,0,ChatChannelType.Private, message, roleInfo ,sign)
		g_eventMgr:fireRemoteEvent(event, target)
	--当前频道
	elseif channelType == ChatChannelType.Current then
		local event = Event.getEvent(ChatEvents_SB_SendToAround,role:getDBID(),0,channelType,message,roleInfo,sign)
		g_eventMgr:fireWorldsEvent(event,CurWorldID)
	--队伍频道
	elseif channelType == ChatChannelType.Team then
		local event = Event.getEvent(ChatEvents_SB_SendToTeam,role:getDBID(),0,channelType,message,roleInfo,sign)
		g_eventMgr:fireWorldsEvent(event,CurWorldID)
	--世界频道
	elseif channelType == ChatChannelType.World then
		local bNotReduce = context
		if not bNotReduce then
			local vigor = role:getVigor()-WorldChannelVigorCost
			role:setVigor(vigor)
			local event = Event.getEvent(ChatEvents_SB_SendToWorld,role:getDBID(),vigor)
			g_eventMgr:fireWorldsEvent(event,CurWorldID)
		end
		local event = Event.getEvent(ChatEvents_SC_SendChatMsg, -1, 0, ChatChannelType.World, message, roleInfo, sign )
		RemoteEventProxy.broadcast(event,0)
	end

end


function ChatManager.getInstance()
	return ChatManager()
end

