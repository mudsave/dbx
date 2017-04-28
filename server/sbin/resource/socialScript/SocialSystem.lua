--[[SocialSystem.lua

	Function: Receive the event from client or other server 
	Author: Caesar
	
--]]

require "base.base"
require "misc.ChatConstant"
require "misc.SocialServerConstant"
require "entity.Player"
require "entity.PlayerFactory"
require "entity.PlayerManager"
require "ChatSystem.ChatSystem"

SocialSystem = class(EventSetDoer, Singleton)

UpdatePlayerAttrList = {

	["Level"] = function(player,infoValue) player:setLevel(infoValue) end,
	["ModelID"] = function(player,infoValue) player:setModelID(infoValue) end,
	["Vigor"] = function(player,infoValue) player:setVigor(infoValue) end,
	["OfflineDate"] = function(player,infoValue) player:setOfflineDate(infoValue) end,
	["CurHeadTex"] = function(player,infoValue) player:setCurHeadTex(infoValue) end,
	["CurBodyTex"] = function(player,infoValue) player:setCurBodyTex(infoValue) end,
	["School"] = function(player,infoValue) player:setSchool(infoValue) end,
	["Name"] = function(player,infoValue) player:setName(infoValue) end,
	["Sex"] = function(player,infoValue) player:setSex(infoValue) end,

}



function SocialSystem:__init()
	self._doer = {
		
		[SocialEvent_BB_ExitWorld]			= SocialSystem.onExitWorld,
		[SocialEvent_SB_Enter]				= SocialSystem.onEnterWorld,
		[SocialEvent_SB_SaveData]			= SocialSystem.onSaveData,
		[SocialEvent_BB_UpdatePlayerAttr]	= SocialSystem.onUpdatePlayerAttr
		
	}
end

function SocialSystem:onEnterWorld(event)

	local params = event:getParams()
	local player = g_playerfactory:createPlayer(params[1])
	player:setOnlineDate(os.time())
	g_playerMgr:addPlayer(player)
	g_friendSysMgr.loadData(player:getDBID())
	g_groupSysMgr.loadData(player:getDBID())
	g_factionSysMgr.loadData(player:getDBID())
	
end

function  SocialSystem:onSaveData(event)
	local params = event:getParams()
	local playerInfo = params[1]
	local player = g_playerMgr:getLoadedPlayerByDBID(playerInfo.ID)
	player:setName(playerInfo.name)
	player:setLevel(playerInfo.level)
	player:setSchool(playerInfo.school)

end

function SocialSystem:onExitWorld(event)

	local DBID = event:getParams()[1]
	local player = g_playerMgr:getPlayerByDBID(DBID)
	if not player then
		return 
	end
	local friendHandler = player:getHandler(HandlerDef_Friend)
	--玩家下线
	--向自己的好友发送下线消息
	local roleFriendList = friendHandler:getFriendList()
	for k,v in pairs(roleFriendList)  do
		local friend = g_playerMgr:getPlayerByDBID(v.friendDBID)
		if friend then 
			local event_OnUpdateFriendOnlineState = Event.getEvent(FriendEvent_BC_OnUpdateFriendOnlineState,player:getDBID(),PlayerOnlineState.Offline)
			g_eventMgr:fireRemoteEvent(event_OnUpdateFriendOnlineState,friend)
		end
	end
	--向自己群里的所有成员发送下线消息
	local groupHandler = player:getHandler(HandlerDef_Group)
	local groupInfoList = groupHandler:getGroupInfoList()
	for key,value in pairs(groupInfoList) do
		for k,v in pairs(value.members) do
			if v~= player:getDBID() then
				local member = g_playerMgr:getPlayerByDBID(v)
				if member then
					local informKind = UpdateCode.Update
					local memberInfo = {DBID = player:getDBID(),name = player:getName(),state = PlayerOnlineState.Offline}
					local event_UpdateGroupMemberInChat = Event.getEvent(FriendEvent_BC_UpdateGroupMemberInChat,memberInfo,value.DBID,informKind)
					g_eventMgr:fireRemoteEvent(event_UpdateGroupMemberInChat,member)
				end
			end

		end
	end
	
	local factionHandler = player:getHandler(HandlerDef_Faction)
	LuaDBAccess.updatePlayer(DBID,"AutoHideChatWin",friendHandler:getAutoHideChatWin())
--刷新上周帮贡
	LuaDBAccess.updatePlayer(DBID,"LastWeekFactionContribute",factionHandler:getLastWeekContribute())
--记录离线时间
	player:setOfflineDate(os.time())
	LuaDBAccess.updatePlayer(DBID,"OfflineDate",time.tostring(player:getOfflineDate()))
--向自己帮派里的所有成员发送下线消息
	local factionDBID = factionHandler:getFactionDBID()
	if factionDBID > 0 then
		local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
		local memberList = faction:getMemberList()
		for _,memberInfo in pairs(memberList) do
			local member = g_playerMgr:getPlayerByDBID(memberInfo["memberDBID"])
			if member then
				local event_MemberOffline = Event.getEvent(FactionEvent_BC_MemberOffline,player:getDBID(),player:getOfflineDate())
				g_eventMgr:fireRemoteEvent(event_MemberOffline,member)
			end
		end
	end
--从服务端在线玩家表移除
	g_playerMgr:removePlayer(DBID)
	
end


function SocialSystem:onUpdatePlayerAttr( event )
	
	local params = event:getParams()
	local attributeList = params[1]
	local playerDBID = params[2]
	local player = g_playerMgr:getPlayerByDBID(playerDBID)
	if player then
		for infoName,infoValue in pairs(attributeList) do
			UpdatePlayerAttrList[infoName](player,infoValue)
		end
	end

end

function SocialSystem.getInstance()
	return SocialSystem()
end

g_eventMgr:addEventListener(SocialSystem.getInstance())