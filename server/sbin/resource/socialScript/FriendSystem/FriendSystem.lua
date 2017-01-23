--[[FriendSystem.lua

    Function: Receive the event from client or other server
    Author: Caesar
	Update:16.12.15 Done
	
--]]



require "base.base"
require "FriendSystem.FriendSysMgr"


FriendSystem = class(EventSetDoer, Singleton)

function FriendSystem:__init()
	self._doer = {

		[FriendEvent_CB_AddFriend]							= FriendSystem.onAddFriend,
		[FriendEvent_CB_DeleteFriend]						= FriendSystem.onDeleteFriend,
		[FriendEvent_CB_GetFriendInfo]						= FriendSystem.onGetFriendInfo,
		[FriendEvent_CB_ConfirmFriend]						= FriendSystem.onConfirmFriend,
		[FriendEvent_CB_SendFriendInfoOnline] 				= FriendSystem.onGetFriendInfoOnline,
		[FriendEvent_CB_RefuseOfflineFriendAsk]				= FriendSystem.onRefuseOfflineFriendAsk,
		[FriendEvent_CB_GetFriendInfoInChat]				= FriendSystem.onGetFriendInfoInChat,
		[FriendEvent_CB_SendMsgToPlayer]					= FriendSystem.onGetMsgFromPlayer,
		[FriendEvent_CB_AddPlayerToBlcaklistInScreen]		= FriendSystem.onAddPlayerToBlcaklistInScreen,
		[FriendEvent_CB_RemovePlayerInBlackListInScreen]	= FriendSystem.onRemovePlayerInBlackListInScreen,
		[FriendEvent_CB_UpdateRoleInfo]						= FriendSystem.onUpdateRoleInfo,
		[FriendEvent_CB_RunIntoFriends]						= FriendSystem.onRunIntoFriends,
		[FriendEvent_CB_ShowNotifyInfo]						= FriendSystem.onShowNotifyInfo,
		[FriendEvent_SB_AddPlayerToBlcaklistInEnemy]		= FriendSystem.onAddPlayerToBlcaklistInEnemy,
		[FriendEvent_CB_RemovePlayerInBlackListInEnemy]		= FriendSystem.onRemovePlayerInBlackListInEnemy
	}
	
	self._listenState = false
end

function FriendSystem.getInstance()
	return FriendSystem()
end


--对好友的操作----------------------------------------------------------------------------------------------

--查找好友得到好友信息
function FriendSystem:onGetFriendInfo(event)

	local params = event:getParams()
	local roleDBID = params[3]
	local playerDBID = params[1] 
	local playerName = params[2]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	--得到好友对象
	local friend = g_playerMgr:getPlayerByDBID(playerDBID)
	friend = friend or g_playerMgr:getPlayerByName(playerName)
	--如果好友在线
	if friend then
		local event_GetFriendInfoOnline = Event.getEvent(FriendEvent_BC_GetFriendInfoOnline,roleDBID)
		g_eventMgr:fireRemoteEvent(event_GetFriendInfoOnline,friend)

	else--离线
		--判断在服务器中是否存有玩家数据，如果存在，则调用服务器中的数据，提高效率
		local friendLoaded  = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
		friendLoaded = friendLoaded or g_playerMgr:getLoadedPlayerByName(playerName)

		if  friendLoaded then

			local factionHandler = friendLoaded:getHandler(HandlerDef_Faction)
			local factionDBID = factionHandler:getFactionDBID()
			local factionName = nil
			if factionDBID> 0 then
				local factionInfo = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
				if factionInfo then
					factionName = factionInfo:getFactionName()
				end
			end

			local friendInfo = {ID = friendLoaded:getDBID(),name = friendLoaded:getName(),
						school = friendLoaded:getSchool(),level = friendLoaded:getLevel(),
						faction = factionName,position = nil,sex = friendLoaded:getSex() }
			local event_ShowFriendInfo = Event.getEvent(FriendEvent_BC_ShowFriendInfo,friendInfo)
			g_eventMgr:fireRemoteEvent(event_ShowFriendInfo,role)
		else
			local info = {roleDBID = roleDBID,infoFunc = friendInfoFunc.showInCheck}
			LuaDBAccess.getPlayerInfo(playerDBID,playerName,FriendSystem.onGetFriendInfoOffline,info)
		end
	end
	
end

function  FriendSystem:onGetFriendInfoOnline(event)
	--得到玩家在线信息
	local params  = event:getParams()
	local player = g_playerMgr:getPlayerByDBID(params[1].ID)
	local factionName = nil
	if player then
		local factionHandler = player:getHandler(HandlerDef_Faction)
		local factionDBID = factionHandler:getFactionDBID()
		if factionDBID > 0 then
			local factionInfo = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
			if factionInfo then
				factionName = factionInfo:getFactionName()
			end
		end
	end

	local friendInfo = {ID = params[1].ID,name = params[1].name,school = params[1].school,level= params[1].level,position =params[1].position,faction = factionName,sex = g_playerMgr:getLoadedPlayerByDBID(params[1].ID):getSex() }
	local roleDBID = params[2]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local event_ShowFriendInfo = Event.getEvent(FriendEvent_BC_ShowFriendInfo,friendInfo)
	g_eventMgr:fireRemoteEvent(event_ShowFriendInfo,role)
end


--查找好友得到好友信息之后的回调方法
function FriendSystem.onGetFriendInfoOffline(recordList,info)
	
	local role = g_playerMgr:getPlayerByDBID(info.roleDBID)
	local infoDatabase = recordList[1]
	--如果得到的表中存有数据，那么表示查找的好友存在
	if table.size(infoDatabase) >0 then
		if info.infoFunc == friendInfoFunc.showInCheck then

			local factionName = nil
			if table.size(recordList[2][1]) > 0 then
				local factionDBID = recordList[2][1].factionDBID
				if factionDBID > 0 then
					local factionInfo = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
					if factionInfo then
						factionName = factionInfo:getFactionName()
					end
				end
			end

			local friendInfo = {ID = infoDatabase[1].ID,name = infoDatabase[1].name,
							school = infoDatabase[1].school,level = infoDatabase[1].level,
							faction = factionName,position = nil,sex = infoDatabase[1].sex }
			--将固定不变的数据库信息和随内存变化的信息传递
			local event = Event.getEvent(FriendEvent_BC_ShowFriendInfo,friendInfo)
			g_eventMgr:fireRemoteEvent(event,role)

		elseif info.infoFunc == friendInfoFunc.showInChat then

			local friendInfo = {DBID = infoDatabase[1].ID,name = infoDatabase[1].name,level = infoDatabase[1].level,school = infoDatabase[1].school,sex = infoDatabase[1].sex,state =PlayerOnlineState.Offline}
			local event = Event.getEvent(FriendEvent_BC_ShowFriendInfoInChat,friendInfo)
			g_eventMgr:fireRemoteEvent(event,role)

		end
	else
		local event = Event.getEvent(FriendEvent_BC_ShowFriendInfo,"")
		g_eventMgr:fireRemoteEvent(event,role)
	end
end

--加好友，先判断好友是不是在线，然后执行相应的方法
function FriendSystem:onAddFriend(event)
	--得到好友数据
	local params = event:getParams()
	local roleDBID = params[1]
	local friendDBID = 0
	local friendName = ""
	if type(params[2]) == "number" then
		friendDBID = params[2]
	else
		friendName = params[2]
	end
	print("roleDBID",roleDBID)
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local roleName = role:getName()

	if	roleDBID ~= friendDBID and roleName ~= friendName then
		--查询好友ID是否在玩家在线列表中
		local friend = g_playerMgr:getPlayerByDBID(friendDBID) or g_playerMgr:getPlayerByName(friendName)
		if  friend then
			local systemSetHandler = friend:getHandler(HandlerDef_SystemSet) 
			if systemSetHandler:getRefFriend() then
				local eventGroup_SystemSet = 23
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SystemSet, 1)
				g_eventMgr:fireRemoteEvent(event, role)
				return
			else
				--判断玩家是否已经被屏蔽
				local friendHandler = friend:getHandler(HandlerDef_Friend)
				if friendHandler:getFriend(friend:getDBID()) then
					local msg = FriendMsgTextKeyTable.FailtoAddFriend
					local notifyParams = {msg = msg}
					local event_Notify  = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FriendNotify,notifyParams)
					g_eventMgr:fireRemoteEvent(event_Notify,role)
				else
					if (not friendHandler:getScreenInfoInBlackListInfo(roleDBID)) and (not friendHandler:getEnemyInfoInBlackListInfo(roleDBID)) then
						--发送事件到客户端，弹出提示框
						local role = g_playerMgr:getPlayerByDBID(roleDBID)
						local informKind = MsgboxParams.MsgType.OnlineMsg
						local informType = MsgboxParams.MsgKind.MsgKind_FriendAsk
						local informMsg = tostring(role:getName())
						local eventBC = Event.getEvent(FriendEvent_BC_ShowInform,informType,informKind,informMsg,roleDBID,role:getName())
						g_eventMgr:fireRemoteEvent(eventBC,friend)
					else
						local msg = FriendMsgTextKeyTable.AlreadyInBlackList
						local notifyParams = {msg = msg}
						local event_Notify  = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FriendNotify,notifyParams)
						g_eventMgr:fireRemoteEvent(event_Notify,role)
					end
				end
			end
		else
			local args = {friendDBID = friendDBID,roleDBID = roleDBID}
			LuaDBAccess.loadRoleFriends(friendDBID,FriendSystem.onCheckIsInBlackList,args)
		end
		LuaDBAccess.deleteFriend(roleDBID,friendDBID)
	end
end


function FriendSystem.onCheckIsInBlackList( recordList,args )

	local blackListInfos = recordList[1]
	local isInBlackList = false
	local friendDBID = args.friendDBID
	local roleDBID = args.roleDBID
	for key,value in pairs(blackListInfos) do
		if value.friendID == roleDBID and value.screen ~= 0  then
			isInBlackList = true
			break
		end
	end
	if not isInBlackList then
		LuaDBAccess.addFriend(friendDBID,roleDBID,1,0)
		LuaDBAccess.updateFriend(friendDBID,roleDBID,1,0)
	end

end

--好友请求确认
function FriendSystem:onConfirmFriend(event)

	local params = event:getParams()
	local informType = params[1]
	local roleDBID = params[2]
	local friendDBID = params[3]
	local role 	 = g_playerMgr:getPlayerByDBID(roleDBID)
	local friendHandler = role:getHandler(HandlerDef_Friend)
	
	friendHandler:addFriend(friendDBID)

	--确认在线的好友请求
	if informType == 1 then
		--在线确认，更新数据库，添加两条好友记录
		LuaDBAccess.addFriend(roleDBID,friendDBID,2,0)
		LuaDBAccess.updateFriend(roleDBID,friendDBID,2,0)
		LuaDBAccess.addFriend(friendDBID,roleDBID,2,0)
		LuaDBAccess.updateFriend(friendDBID,roleDBID,2,0)

	--确认离线的好友请求	
	elseif informType == 0 then
		--更新数据库信息
		LuaDBAccess.addFriend(friendDBID,roleDBID,2,0)
		LuaDBAccess.updateFriend(roleDBID,friendDBID,2,0)
	end
	
	local friend = g_playerMgr:getPlayerByDBID(friendDBID)
	
	if friend then

		local state = PlayerOnlineState.Online
		event = Event.getEvent(FriendEvent_BC_OnUpdateFriendOnlineState,friendDBID,state)
		g_eventMgr:fireRemoteEvent(event,role)
		event = Event.getEvent(FriendEvent_BC_OnUpdateFriendOnlineState,roleDBID,state)
		g_eventMgr:fireRemoteEvent(event,friend)
			
		--更新客户端玩家好友信息列表
		local roleInfo = {friendDBID = role:getDBID(),name = role:getName()}
		event = Event.getEvent(FriendEvent_BC_UpdateFriendInfoList,roleInfo)
		g_eventMgr:fireRemoteEvent(event,friend)
			
		local friendInfo = {friendDBID = friend:getDBID(),name = friend:getName()}
		event = Event.getEvent(FriendEvent_BC_UpdateFriendInfoList,friendInfo)
		g_eventMgr:fireRemoteEvent(event,role)
			
		--更新玩家服务端好友列表，以便玩家退出时确认全部下线
		
		local friendHandler = friend:getHandler(HandlerDef_Friend)
		friendHandler:addFriend(roleDBID)
			
	else 
				
		local friend = g_playerMgr:getLoadedPlayerByDBID(friendDBID)
		local friendInfo = {friendDBID = friend:getDBID(),name = friend:getName()}
		event = Event.getEvent(FriendEvent_BC_UpdateFriendInfoList,friendInfo)
		g_eventMgr:fireRemoteEvent(event,role)
			
	end
end


function FriendSystem:onRefuseOfflineFriendAsk(event)

	local params = event:getParams()
	local roleDBID = params[1]
	local friendDBID = params[2]
	LuaDBAccess.deleteFriend(roleDBID,friendDBID)
	
end


--删除好友
function FriendSystem:onDeleteFriend(event)
	local params = event:getParams()
	local roleDBID = params[1]
	local friendDBID = params[2]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local roleHandler = role:getHandler(HandlerDef_Friend)
	--更新数据库
	LuaDBAccess.deleteFriend(roleDBID,friendDBID)
	LuaDBAccess.deleteFriend(friendDBID,roleDBID)
	roleHandler:deleteFriend(friendDBID)

	local friend = g_playerMgr:getPlayerByDBID(friendDBID)
	--如果玩家在线
	if friend  then
		--更新服务端好友列表
		local friendHandler = friend:getHandler(HandlerDef_Friend)
		friendHandler:deleteFriend(roleDBID)
		local state = PlayerOnlineState.Offline
		--更新客户端好友在线列表
		local event
		event = Event.getEvent(FriendEvent_BC_OnUpdateFriendOnlineState,roleDBID,state)
		g_eventMgr:fireRemoteEvent(event,friend)
		--更新客户端好友列表信息
		event = Event.getEvent(FriendEvent_BC_DeleteFriendInfoList,roleDBID)
		g_eventMgr:fireRemoteEvent(event,friend)
	else
		local friendLoaded = g_playerMgr:getLoadedPlayerByDBID(friendDBID)
		if friendLoaded then
			local friendHandler = friendLoaded:getHandler(HandlerDef_Friend)
			friendHandler:deleteFriend(roleDBID)
		end
	end
	
end

--得到好友信息返回给聊天界面，需要的好友信息为姓名、等级、门派、性别、状态（是否离线）
function FriendSystem:onGetFriendInfoInChat(event)

	local params = event:getParams()
	local friendDBID = params[1]
	local roleDBID = params[2]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	--判断该玩家是否在线
	local friendInfo = g_playerMgr:getPlayerByDBID(friendDBID) or g_playerMgr:getPlayerByName(friendDBID)
	--如果在线，则从服务端调用数据
	if friendInfo then

		local info = {DBID = friendInfo:getDBID(),name = friendInfo:getName(),level = friendInfo:getLevel(),school = friendInfo:getSchool(),sex = friendInfo:getSex(),state = PlayerOnlineState.Online}
		local event_ShowFriendInfoInChat = Event.getEvent(FriendEvent_BC_ShowFriendInfoInChat,info)
		g_eventMgr:fireRemoteEvent(event_ShowFriendInfoInChat,role)

	--否则判断是否上过线，如果上过线，在服务端调用数据，否则从数据库调用数据
	else
		local localFriendInfo = g_playerMgr:getLoadedPlayerByDBID(friendDBID) or g_playerMgr:getLoadedPlayerByName(friendDBID)
		
		if localFriendInfo then
			
			local info = {DBID = localFriendInfo:getDBID(),name = localFriendInfo:getName(),level = localFriendInfo:getLevel(),school = localFriendInfo:getSchool(),sex = localFriendInfo:getSex(),state = PlayerOnlineState.Offline}
			local event_ShowFriendInfoInChat = Event.getEvent(FriendEvent_BC_ShowFriendInfoInChat,info)
			g_eventMgr:fireRemoteEvent(event_ShowFriendInfoInChat,role)
		else
			--从数据库读取数据
			local info = {roleDBID = roleDBID,infoFunc = friendInfoFunc.showInChat}
			LuaDBAccess.getPlayerInfo(friendDBID,"",FriendSystem.onGetFriendInfoOffline,info)

		end

	end

end

--得到玩家发来的聊天信息
function FriendSystem:onGetMsgFromPlayer(event)

	local params = event:getParams()
	local roleDBID = params[1]
	local playerName = params[2]
	local msg = params[3]
	local roleInfo

	--检查玩家在发完信息之后是否还在线
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	--如果还在线
	if role then
		roleInfo = {DBID = roleDBID,name = role:getName(),level = role:getLevel(),school = role:getSchool(),sex = role:getSex(),state = PlayerOnlineState.Online }
	else--如果不在线，则从服务端数据库取数据
		role = g_playerMgr:getLoadedPlayerByDBID(roleDBID)
		roleInfo = {DBID = roleDBID,name = role:getName(),level = role:getLevel(),school = role:getSchool(),sex = role:getSex(),state = PlayerOnlineState.Offline }
	end

	--将玩家信息捆绑传输

	msg["playerInfo"] = roleInfo

	local player = g_playerMgr:getPlayerByName(playerName)
	--判断玩家是否在线
	if player then
		local event = Event.getEvent(FriendEvent_BC_SendMsgToPlayer,msg)
		g_eventMgr:fireRemoteEvent(event,player)
	else--如果玩家不在线，则发送离校消息
		--判断该玩家是否上过线
		player = g_playerMgr:getLoadedPlayerByName(playerName)
		--如果上过线，则获取数据
		if player then
			--添加离线聊天信息到数据库
			LuaDBAccess.addFriendChatOfflineMsg(player:getDBID(),roleDBID,role:getName(),msg.msgHeader,msg.msgContent)
		else--如果玩家不在线，则更新数据库
			local args = {roleDBID = roleDBID,roleName = role:getName(),msg = msg}
			LuaDBAccess.getPlayerInfo(0,playerName,FriendSystem.addFriendChatOfflineMsg,args)
		end

	end

end


function FriendSystem.addFriendChatOfflineMsg(recordList,args)

	local playerInfo = recordList[1]
	if playerInfo then
		local msg = args.msg
		local playerDBID = playerInfo[1].ID
		LuaDBAccess.addFriendChatOfflineMsg(playerDBID,args.roleDBID,args.roleName,msg.msgHeader,msg.msgContent)
	end

end


--加入黑名单
function FriendSystem:onAddPlayerToBlcaklistInScreen(event)

	local params = event:getParams()
	local roleDBID = params[1]
	local playerDBID = params[2]
	local screenInfo = params[3]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local roleFriendHandler = role:getHandler(HandlerDef_Friend)

	if playerDBID == 0 then
		local playerName = screenInfo.screenName
		local player = g_playerMgr:getPlayerByName(playerName) or g_playerMgr:getLoadedPlayerByName(playerName)
		if player then
			local DBID = player:getDBID()
			screenInfo.screenDBID = DBID
			playerDBID = DBID
		end
	end
	roleFriendHandler:addScreenInfoToBlackListInfo(screenInfo)
	--判断当前玩家是否已经是角色好友，如果是，则删除好友关系，如果不是，则更新数据库
	local friend = roleFriendHandler:getFriend(playerDBID)
	if friend then
		roleFriendHandler:deleteFriend(playerDBID)
		--发送事件到对方客户端
		local player = g_playerMgr:getPlayerByDBID(playerDBID)
		local playerLoaded = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
		if playerLoaded then
			local playerFriendHandler = playerLoaded:getHandler(HandlerDef_Friend)
			playerFriendHandler:deleteFriend(roleDBID)
		end

		if player then
			local event = Event.getEvent(FriendEvent_BC_DeleteFriendInfoList,roleDBID)
			g_eventMgr:fireRemoteEvent(event,player)
		end

		local event_UpdateBlackList = Event.getEvent(FriendEvent_BC_AddPlayerToBlcaklistInScreen,playerDBID,screenInfo)
		g_eventMgr:fireRemoteEvent(event_UpdateBlackList,role)

		LuaDBAccess.updateFriend(roleDBID,playerDBID,0,1)
		LuaDBAccess.deleteFriend(playerDBID,roleDBID)
	else

		local event_UpdateBlackList = Event.getEvent(FriendEvent_BC_AddPlayerToBlcaklistInScreen,roleDBID,screenInfo)
		g_eventMgr:fireRemoteEvent(event_UpdateBlackList,role)
		LuaDBAccess.addFriend(roleDBID,playerDBID,0,1)

	end

end

--移出黑名单，删除相关记录
function FriendSystem:onRemovePlayerInBlackListInScreen(event)

	local params = event:getParams()
	local roleDBID = params[1]
	local playerDBID = params[2]
	--清除数据库记录
	LuaDBAccess.deleteFriend(roleDBID,playerDBID)
	--清除服务端记录
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local roleHandler = role:getHandler(HandlerDef_Friend)
	roleHandler:deleteScreenInfoInBlackListInfo(playerDBID)

end

function FriendSystem:onAddPlayerToBlcaklistInEnemy( event )

	local params = event:getParams()
	local roleDBID = params[1]
	local playerDBID = params[2]
	local enemyInfo = params[3]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local roleFriendHandler = role:getHandler(HandlerDef_Friend)
	if playerDBID == 0 then
		local playerName = enemyInfo.enemyName
		local player = g_playerMgr:getPlayerByName(playerName) or g_playerMgr:getLoadedPlayerByName(playerName)
		if player then
			local DBID = player:getDBID()
			enemyInfo.enemyDBID = DBID
			playerDBID = DBID
		end
	else
		roleFriendHandler:addEnemyInfoToBlackListInfo(enemyInfo)
		--判断当前玩家是否已经是角色好友，如果是，则删除好友关系，如果不是，则更新数据库
		local friend = roleFriendHandler:getFriend(playerDBID)
		if friend then
			roleFriendHandler:deleteFriend(playerDBID)
			--发送事件到对方客户端
			local player = g_playerMgr:getPlayerByDBID(playerDBID)
			local playerLoaded = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
			if playerLoaded then
				local playerFriendHandler = playerLoaded:getHandler(HandlerDef_Friend)
				playerFriendHandler:deleteFriend(roleDBID)
			end

			if player then
				local event = Event.getEvent(FriendEvent_BC_DeleteFriendInfoList,roleDBID)
				g_eventMgr:fireRemoteEvent(event,player)
			end
			local event_UpdateBlackList = Event.getEvent(FriendEvent_BC_AddPlayerToBlcaklistInEnemy,playerDBID,enemyInfo)
			g_eventMgr:fireRemoteEvent(event_UpdateBlackList,role)

			LuaDBAccess.updateFriend(roleDBID,playerDBID,0,2)
			LuaDBAccess.deleteFriend(playerDBID,roleDBID)
		else
			local event_UpdateBlackList = Event.getEvent(FriendEvent_BC_AddPlayerToBlcaklistInEnemy,playerDBID,enemyInfo)
			g_eventMgr:fireRemoteEvent(event_UpdateBlackList,role)
			LuaDBAccess.addFriend(roleDBID,playerDBID,0,2)

		end
	end

end

--移出黑名单，删除相关记录
function FriendSystem:onRemovePlayerInBlackListInEnemy(event)

	local params = event:getParams()
	local roleDBID = params[1]
	local playerDBID = params[2]
	--清除数据库记录
	LuaDBAccess.deleteFriend(roleDBID,playerDBID)
	--清除服务端记录
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	local roleHandler = role:getHandler(HandlerDef_Friend)
	roleHandler:deleteEnemyInfoInBlackListInfo(playerDBID)

end


function FriendSystem:onUpdateRoleInfo( event )
	
	local params = event:getParams()
	local playerDBID = params[1]
	local autoHideChatWin = params[2]
	local player = g_playerMgr:getPlayerByDBID(playerDBID)
	player:getHandler(HandlerDef_Friend):setAutoHideChatWin(autoHideChatWin)

end

--偶遇功能
function FriendSystem:onRunIntoFriends(event)

	local params = event:getParams()
	local min = params[1]
	local max = params[2]
	local roleDBID = params[3]

	local args = {min = min,max = max,roleDBID =roleDBID}
	LuaDBAccess.runIntoFriends(min,max,roleDBID,FriendSystem.getRunIntoFriends,args)

end

function FriendSystem.getRunIntoFriends( recordList,args )
	local friends = recordList[1]
	local count = table.size(friends)
	local runIntoTable = {}
	local role = g_playerMgr:getPlayerByDBID(args.roleDBID)
	--如果得到了大于等于5的玩家，则直接取随机存
	if count >= 5 then
		math.randomseed(os.clock())
		for var = 1,6 do
			if var > 1 then
				local randomIndex = math.random(1,#friends)
				table.insert( runIntoTable,friends[randomIndex])
				table.remove( friends,randomIndex )
			else
				math.random(1,#friends)
			end
		end

		local event = Event.getEvent(FriendEvent_BC_SendRunIntoFriends,runIntoTable)
		g_eventMgr:fireRemoteEvent(event,role)

	else--如果小于5，则重新取
		LuaDBAccess.runIntoFriends(args.min,60,roleDBID,FriendSystem.getMaxRunIntoFriends,args)
	end

end

function FriendSystem.getMaxRunIntoFriends( recordList,args )
	local role = g_playerMgr:getPlayerByDBID(args.roleDBID)
	local friends = recordList[1]
	local count = table.size(friends)
	local runIntoTable = {}
	math.randomseed(os.clock())
	for var = 1,count do
		if var > 6 then
			break
		elseif var > 1 then
			local randomIndex = math.random(1,#friends)
			table.insert( runIntoTable,friends[randomIndex])
			table.remove( friends,randomIndex )
		else
			math.random(1,#friends)
		end
	end

	local event = Event.getEvent(FriendEvent_BC_SendRunIntoFriends,runIntoTable)
	g_eventMgr:fireRemoteEvent(event,role)

end


function FriendSystem:onShowNotifyInfo( event )
	
	local params = event:getParams()
	local msg = params[1]
	local playerDBID = params[2]
	local player = g_playerMgr:getPlayerByDBID(playerDBID)
	if player then
		local notifyParams = {msg = msg}
		local event_Notify  = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.NormalNotify,notifyParams)
		g_eventMgr:fireRemoteEvent(event_Notify,player)
	end

end




g_eventMgr:addEventListener(FriendSystem.getInstance())