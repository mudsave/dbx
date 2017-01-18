--[[ChatSystem.lua
描述：
	战斗服聊天消息的接收
--]]

require "misc.ChatConstant"

ChatSystem = class(EventSetDoer, Singleton)
local playerCoolInfo = {}--[DBID] = expireTime --s
function ChatSystem:__init()
	self._doer = {
		[ChatEvents_CF_SendChatMsg]		= ChatSystem.onGetChatMessage,
	}
end


function ChatSystem:onGetChatMessage(event)
	local DBID = event.DBID
	local player = g_fightEntityMgr:getPlayerByDBID(DBID)
	if not player then
		return 
	end

	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID or 0xFFFFFFFF)
	if not fight then
		return
	end

	local expireTime = playerCoolInfo[DBID]
	if expireTime and os.time() < expireTime then
		return
	end

	local params = event:getParams()
	local channelType = params[1]
	local msg = params[2]
	local sign = params[3]
	if channelType ~= ChatChannelType.Current then
		return
	end

	if string.len(msg) > ChatMessageMaxLen then
		return 
	end

	playerCoolInfo[DBID] = os.time() + ChatCoolTime

	local roleInfo = {ID = player:getID(), name = player:getName()}
	for _,roles in pairs(fight:getMembers()) do
		for _, role in pairs(roles) do
			if instanceof(role,FightPlayer) then
				local  event2 = Event(ChatEvents_FC_SendChatMsg, g_serverId, role:getID(), 0, channelType, msg, roleInfo, sign)
				g_eventMgr:fireRemoteEvent(event2,role)
			end
		end
	end
	
	
end
function ChatSystem.getInstance()
	return ChatSystem()
end

g_eventMgr:addEventListener(ChatSystem.getInstance())