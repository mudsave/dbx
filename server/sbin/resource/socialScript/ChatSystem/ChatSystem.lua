--[[ChatSystem.lua

    Function: The ChatSystem
    Author: Caesar

--]]

require "base.base"
require "misc.ChatConstant"
require "ChatSystem.ChatManager"

ChatSystem = class(EventSetDoer, Singleton)
local PlayerWorldCoolInfo = {}--[DBID]=expireTime
local PlayerCoolInfo = {}--[ID]=expireTime
function ChatSystem:__init()
	self._doer = {
		[ChatEvents_CS_SendChatMsg]    = ChatSystem.onGetMessage,
	}
end




local function generalCheck(event)
	
	local DBID = event.DBID
	if not DBID then
		return 8
	end

	local player = g_playerMgr:getPlayerByDBID(DBID)
	if not player then
		return 8
	end

	local expireTime = PlayerCoolInfo[player:getDBID()]
	if expireTime and expireTime > os.time() then
		return 6
	end

	local params = event:getParams()
	local msg = params[2]
	if string.len(msg) > ChatMessageMaxLen then
		return 7
	end
	

	return true
end



function ChatSystem:_checkFaction(player)

	if player:getHandler(HandlerDef_Faction):getFactionDBID() < 1 then
		return 12
	end
	return 0
end

function ChatSystem:_checkSchool(player)
	return 0
end

function ChatSystem:_checkPrivate(player,target)
	if not target then
		return 4
	else
		local targetFriendHandler = target:getHandler(HandlerDef_Friend)
		if targetFriendHandler:getEnemyInfoInBlackListInfo(player:getDBID()) or targetFriendHandler:getScreenInfoInBlackListInfo(player:getDBID()) then		
			return 8
		end
	end
	return 0
end

function ChatSystem:_checkCurrent(player)
	return 0
end

function ChatSystem:_checkTeam(player)
	return 0
end

function ChatSystem:_checkWorld(player)
	local level = player:getLevel()
	if level < WorldChannelMinLevel then
		return 2
	end
	local expireTime = PlayerWorldCoolInfo[player:getDBID()]
	if expireTime and expireTime > os.time() then
		return 3
	end
	local vigor = player:getVigor()
	if (vigor - WorldChannelVigorCost) < 0 then
		return 10
	end
	return 0
end

function ChatSystem:_setExpireTime(player)
	PlayerCoolInfo[player:getDBID()] = os.time() + ChatCoolTime
end

function ChatSystem:onGetMessage(event)
	if not generalCheck(event) then
		return
	end

	local params = event:getParams()
	local channelType = params[1]
	local msg = params[2]
	local sign = params[3]
	local DBID = params[4]
	local player = g_playerMgr:getPlayerByDBID(DBID)
	--帮会频道
	if channelType == ChatChannelType.Faction then
		local errorCode = self:_checkFaction(player)
		if errorCode == 0 then
			g_chatMgr:sendMessage(player, channelType, msg, sign)
			self:_setExpireTime(player)
		else
			local event = Event.getEvent(ChatEvents_SC_SendChatMsg, DBID, errorCode)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	--门派频道
	elseif channelType == ChatChannelType.School then

		local errorCode = self:_checkSchool(player)
		if errorCode == 0 then
			g_chatMgr:sendMessage(player, channelType, msg, sign)
			self:_setExpireTime(player)
		else
			local event = Event.getEvent(ChatEvents_SC_SendChatMsg, DBID, errorCode)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	--私人频道
	elseif channelType == ChatChannelType.Private then
		local targetName = params[5]
		local target = g_playerMgr:getPlayerByName(targetName)
		if target then
			local systemSetHandler = target:getHandler(HandlerDef_SystemSet) 
			if systemSetHandler:getRefMess() then
				local eventGroup_SystemSet = 23
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SystemSet, 3)
				g_eventMgr:fireRemoteEvent(event, player)
				return
			else
				local errorCode = self:_checkPrivate(player, target)
				if errorCode == 0 then
					local targetID = target:getDBID()
					g_chatMgr:sendMessage(player,channelType, msg, sign,targetID)
					self:_setExpireTime(player)
				else
					local event = Event.getEvent(ChatEvents_SC_SendChatMsg, DBID, errorCode)
					g_eventMgr:fireRemoteEvent(event, player)
				end
			end
		else
			local msg = FriendMsgTextKeyTable.PlayerIsNotOnline
			local notifyParams = {msg = msg}
			local event_Notify  = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FriendNotify,notifyParams)
			g_eventMgr:fireRemoteEvent(event_Notify,player)
		end
	--世界频道
	elseif channelType == ChatChannelType.World then
		local errorCode = self:_checkWorld(player)
		if errorCode == 0 then
			g_chatMgr:sendMessage(player, channelType, msg, sign)
			PlayerWorldCoolInfo[player:getDBID()] = os.time() + WorldChannelCoolTime
			self:_setExpireTime(player)
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Chat, errorCode)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	--当前频道
	elseif channelType == ChatChannelType.Current then
		local errorCode = self:_checkCurrent(player)
		if errorCode == 0 then
			g_chatMgr:sendMessage(player, channelType, msg, sign)
			self:_setExpireTime(player)
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Chat, errorCode)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	--组队频道
	elseif channelType == ChatChannelType.Team then
		local errorCode = self:_checkTeam(player)
		if errorCode == 0 then
			g_chatMgr:sendMessage(player, channelType, msg, sign)
			self:_setExpireTime(player)
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Chat, errorCode)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	--喇叭频道
	elseif channelType == ChatChannelType.Horn then
		self:_setExpireTime(player)
		g_chatMgr:sendHornMessage(msg, player , sign)
	end

end

function ChatSystem.getInstance()
	return ChatSystem()
end

g_eventMgr:addEventListener(ChatSystem.getInstance())