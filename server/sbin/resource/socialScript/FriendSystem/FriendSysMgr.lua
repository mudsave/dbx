--[[FriendSysMgr.lua

    Function: The manager of FriendSystem 
    Author: Caesar
	Update:16.12.14 Done
--]]



require "base.base"
require "GroupSystem.GroupSysMgr"

FriendSysMgr = class(nil, Singleton)



function FriendSysMgr:__init()
	
end

--从数据库中读取好友数据--------------------------------------------------------------------------------

function FriendSysMgr.loadData(roleDBID)
	--根据回调调用 OnLoaded 方法
	LuaDBAccess.loadRoleFriends(roleDBID,FriendSysMgr.onLoaded,roleDBID)
end

--好友数据处理，返回的数据载入该玩家的全部好友信息
function FriendSysMgr.onLoaded(recordList,roleDBID)

	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local friendInfos = recordList[1]
	local friendHandler = role:getHandler(HandlerDef_Friend)
	local groupHandler = role:getHandler(HandlerDef_Group)

	local friendNum = 0 --存储好友申请的顺序
	--如果得到的数据大于0，则执行下列代码
	if table.size(friendInfos) > 0 then
		
		--存储得到的好友个数
		friendHandler:setRemainFriendCount(table.size(friendInfos))
		if role then
			for _,friendInfo in pairs(friendInfos)  do
				local friend = g_playerMgr:getLoadedPlayerByDBID(friendInfo.friendID)
				if friend then
					--存储非申请信息到对应的表中
					if friendInfo.screen == BlackListState.Not and friendInfo.state == PlayerState.Already then --存储玩家好友

						friendHandler:addFriend(friendInfo.friendID)--存储玩家好友
						friendHandler:getFriend(friendInfo.friendID).name = friend:getName()

					elseif friendInfo.screen == BlackListState.Screen  then--存储玩家屏蔽名单

						local screenInfo = {screenDBID = friendInfo.friendID, screenName = friend:getName()}
						friendHandler:addScreenInfoToBlackListInfo(screenInfo)

					elseif friendInfo.screen == BlackListState.Enemy then --存储玩家仇人名单

						local enemyInfo = {enemyDBID = friendInfo.friendID, enemyName = friend:getName()}
						friendHandler:addEnemyInfoToBlackListInfo(enemyInfo)

					end

					--处理玩家的离线申请消息
					FriendSysMgr.handleOfflineAsk(friendInfo,role,friend,friendNum)

				--服务器不存在好友数据，则从数据库调用，此时不会判断是否有申请	
				else

					if friendInfo.screen == BlackListState.Not and friendInfo.state == PlayerState.Already then --存储玩家好友
						friendHandler:addFriend(friendInfo.friendID)
					elseif friendInfo.screen == BlackListState.Screen  then--存储玩家黑名单
						local screenInfo = {screenDBID = friendInfo.friendID, screenName = nil}
						friendHandler:addScreenInfoToBlackListInfo(screenInfo)
					elseif friendInfo.screen == BlackListState.Enemy then
						local enemyInfo = {enemyDBID = friendInfo.friendID, enemyName = nil}
						friendHandler:addEnemyInfoToBlackListInfo(enemyInfo)
					end
					--从数据库得到玩家数据
					LuaDBAccess.getPlayerInfo(friendInfo.friendID,"",FriendSysMgr.saveToFriendInfoList,roleDBID)		
				end
			end
		end
	else

		friendHandler:setRemainFriendCount(0)
		FriendSysMgr.fireFriendInfoToClient(friendHandler,role)
	end
	
end

--处理离线申请和消息
function FriendSysMgr.handleOfflineAsk( friendInfo,role,friend,friendNum )
	
	local roleDBID = friendInfo.ID
	local friendDBID = friendInfo.friendID

	if friendInfo.state == PlayerState.Ask then

		friendNum = friendNum + 1
		local offlineMsg = {kind = OfflineMsgKind.FriendAsk,friendNum = friendNum,friendDBID = friendDBID,friendName = friend:getName()}
		role:addOfflineMsg(offlineMsg)

	end

	local friendHandler = role:getHandler(HandlerDef_Friend)
	friendHandler:setRemainFriendCount(friendHandler:getRemainFriendCount()-1)
	FriendSysMgr.fireFriendInfoToClient(friendHandler,role)

end

--得到返回的单个好友信息，存储到玩家好友信息表中
function FriendSysMgr.saveToFriendInfoList(recordList,roleDBID)
	
	local friendInfos = recordList[1]
	local playerSocialServerData = recordList[2][1]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local friendHandler = role:getHandler(HandlerDef_Friend)
	
	for _,friendInfo in pairs(friendInfos) do

		local playerLoaded = g_playerMgr:getLoadedPlayerByDBID(friendInfo.ID)
		if not playerLoaded then

			local player = Player()
			player:setDBID(friendInfo.ID)
			player:setName(friendInfo.name)
			player:setLevel(friendInfo.level)
			player:setSchool(friendInfo.school)
			player:setSex(friendInfo.sex)
        	player:setOfflineDate(time.totime(playerSocialServerData.offlineDate))
			player:addHandler(HandlerDef_Friend,FriendHandler(player))
			player:addHandler(HandlerDef_Group,GroupHandler(player))
			player:addHandler(HandlerDef_Faction,FactionHandler(player))
			player:getHandler(HandlerDef_Faction):setFactionMoney(playerSocialServerData.factionMoney)
       	 	player:getHandler(HandlerDef_Faction):setFactionHistoryMoney(playerSocialServerData.factionHistoryMoney)
        	player:getHandler(HandlerDef_Faction):initializeFactionDBID(playerSocialServerData.factionDBID)
			player:getHandler(HandlerDef_Faction):initializeWeekContribute(playerSocialServerData.lastWeekFactionContribute,playerSocialServerData.thisWeekFactionContribute,playerSocialServerData.offlineDate)
			g_playerMgr:addLoadedPlayer(player)

		end

		if friendHandler:getFriend(friendInfo.ID) then
			friendHandler:getFriend(friendInfo.ID).name = friendInfo.name
		elseif friendHandler:getScreenInfoInBlackListInfo(friendInfo.ID) then
			friendHandler:getScreenInfoInBlackListInfo(friendInfo.ID).screenName = friendInfo.name
		elseif friendHandler:getEnemyInfoInBlackListInfo(friendInfo.ID) then
			friendHandler:getEnemyInfoInBlackListInfo(friendInfo.ID).enemyName = friendInfo.name
		end

	end

	friendHandler:setRemainFriendCount(friendHandler:getRemainFriendCount()-1)
	FriendSysMgr.fireFriendInfoToClient(friendHandler,role)
end

--发送好友信息到客户端
function FriendSysMgr.fireFriendInfoToClient( friendHandler,role )
	
	--当加载完所有好友数据后，发送到客户端，然后在服务端开始加载离线聊天数据
	if 0 == friendHandler:getRemainFriendCount()  then
		--当玩家所有好友信息都加载完之后，发送到客户端
		local event = Event.getEvent(FriendEvent_BC_SendFriendInfoList,
		friendHandler:getFriendList(),
		friendHandler:getScreenInfosInBlackListInfo(),
		friendHandler:getEnemyInfosInBlackListInfo(),
		friendHandler:getAutoHideChatWin()
		)
		g_eventMgr:fireRemoteEvent(event,role)

		local roleDBID = role:getDBID()
		LuaDBAccess.getFriendChatOfflineMsg(roleDBID,FriendSysMgr.getFriendChatOfflineMsg,roleDBID)
	end

end

--从数据库取得离线聊天消息
function FriendSysMgr.getFriendChatOfflineMsg( recordList,roleDBID)

	local friendOfflineMsgs = recordList[1]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local friendHandler = role:getHandler(HandlerDef_Friend)
	local groupHandler = role:getHandler(HandlerDef_Group)

	if table.size(friendOfflineMsgs) > 0 then

		--初始化离线聊天消息数量
		friendHandler:setRemainChatOfflineMsgCount(table.size(friendOfflineMsgs))
		--由于存储在数据库的消息和实际发送的消息顺序是相反的，这里反向创建一个表用来存储离线消息表
		local tableSize = table.size(friendOfflineMsgs)
		local offlineMsgs = {}
		for _,offlineMsg in pairs(friendOfflineMsgs) do
			offlineMsgs[tableSize] = offlineMsg
			tableSize = tableSize - 1
		end

		--遍历离线消息表
		for _,offlineMsg in pairs(offlineMsgs)	do
			--创建一个临时表存储离线消息表里的数据
			local args = {roleDBID = roleDBID,msgSender = offlineMsg.msgSender,msgHeader =offlineMsg.msgHeader,msgContent = offlineMsg.msgContent}
			local player = g_playerMgr:getLoadedPlayerByDBID(offlineMsg.friendDBID)
			if player then
				local friend= g_playerMgr:getPlayerByDBID(player.ID)
				local state  = nil
				if friend then
					state = PlayerOnlineState.Online
				else
					state = PlayerOnlineState.Offline
				end
				--得到玩家信息
				local friendInfo = {DBID = player:getDBID(),name = player:getName(),level = player:getLevel(),school = player:getSchool(),sex = player:getSex(),state = state}
				local friendName = friendInfo.name
				local offlineMsgs = {kind = OfflineMsgKind.FriendChat,[friendName] = {},friendInfo = friendInfo}
				local msg = {}
				msg.msgSender = args.msgSender
				msg.msgHeader = args.msgHeader
				msg.msgContent = args.msgContent
				--将同一个好友离线聊天消息存储到同一个表中
				table.insert(offlineMsgs[friendName],msg)
				local role = g_playerMgr:getPlayerByDBID(args.roleDBID)
				--存储好友离线消息到角色离线消息表中
				role:addOfflineMsg(offlineMsgs)
				friendHandler:setRemainChatOfflineMsgCount(friendHandler:getRemainChatOfflineMsgCount()-1)
				--存储完之后删除数据库的离线聊天记录
				LuaDBAccess.deleteFriendChatOfflineMsg(role:getDBID(),friendInfo.DBID)
			end
		end
	else
		friendHandler:setRemainChatOfflineMsgCount(0)
	end

	AlreadyLoadData.FriendOfflineData = true

	if AlreadyLoadData.FriendOfflineData and AlreadyLoadData.GroupOfflineData then

		print("好友：全部离线消息加载完毕，等待发送")
		FriendSysMgr.roleOnline(role,friendHandler:getFriendList())
		if table.size(role:getOfflineMsgs()) > 0 then
			local event_SendOfflineMsg = Event.getEvent(FriendEvent_BC_SendOfflineMsg,role:getOfflineMsgs())
			g_eventMgr:fireRemoteEvent(event_SendOfflineMsg,role)
        end
    end

end

--好友上线后更新玩家上线列表以及更新群组成员
function FriendSysMgr.roleOnline(role,roleFriendList)

	--将所有在线的好友存储在一个表中，发送给玩家
	local friendOnlineList = {}
	for  _,friendInfo  in  pairs(roleFriendList)  do
		local friend = g_playerMgr:getPlayerByDBID(friendInfo.friendDBID)
		if friend then
			local state = PlayerOnlineState.Online
			--告知好友，玩家上线
			local event = Event.getEvent(FriendEvent_BC_OnUpdateFriendOnlineState,role:getDBID(),state)
			EventManager:fireRemoteEvent(event,friend)
			--将在线的好友存入表中
			friendOnlineList[friendInfo.friendDBID] = friend:getDBID()
		end
	end
	
	local event_UpdateFriendOnlineState = Event.getEvent(FriendEvent_BC_OnUpdateFriendOnlineState,friendOnlineList,PlayerOnlineState.Online)
	EventManager:fireRemoteEvent(event_UpdateFriendOnlineState,role)

	--得到该玩家所有相关群，向群里所有在线成员发送上线消息
	local groupHandler = role:getHandler(HandlerDef_Group)
	local groupInfoList = groupHandler:getGroupInfoList()
	for _,group in pairs(groupInfoList) do
		for _,memberDBID in pairs(group.members) do
			if memberDBID~= role:getDBID() then
				local member = g_playerMgr:getPlayerByDBID(memberDBID)
				if member then
					local state = PlayerOnlineState.Online
					local informKind = UpdateCode.Update
					local memberInfo = {DBID = role:getDBID(),name = role:getName(),state = state}
					local event = Event.getEvent(FriendEvent_BC_UpdateGroupMemberInChat,memberInfo,value.DBID,informKind)
					g_eventMgr:fireRemoteEvent(event,member)
				end
			end
		end
	end
end

function FriendSysMgr.getInstance()
	return FriendSysMgr()
end
