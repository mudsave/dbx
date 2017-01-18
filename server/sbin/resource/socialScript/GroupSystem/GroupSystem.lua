--[[GroupSystem.lua

    Function: Receive the event from client or other server
    Author: Caesar
    Update:16.12.16 Done
]]

require "base.base"
require "GroupSystem.GroupSysMgr"

GroupSystem = class(EventSetDoer,Singleton)

function GroupSystem:__init( )
    self._doer = {

        [FriendEvent_BC_CreateGroup]            = GroupSystem.onCreateGroup,
        [FriendEvent_CB_ExitGroup]              = GroupSystem.onExitGroup,
        [FriendEvent_CB_InviteFriend]           = GroupSystem.onInviteFriend,
        [FriendEvent_BB_PlayerExist]            = GroupSystem.onPlayerExist,
        [FriendEvent_CB_ConfirmGroupInvite]     = GroupSystem.onConfirmGroupInvite,
        [FriendEvent_CB_ShowGroupInfo]          = GroupSystem.onShowGroupInfo,
        [FriendEvent_CB_UpdateGroupSetting]     = GroupSystem.onUpdateGroupSetting,
        [FriendEvent_CB_UpdateGroupInfo]        = GroupSystem.onUpdateGroupInfo,
        [FriendEvent_CB_GetGroupInfoInChat]     = GroupSystem.onGetGroupInfoInChat,
        [FriendEvent_CB_SendMsgToGroup]         = GroupSystem.onSendMsgToGroup,
        [FriendEvent_CB_RefuseOfflineGroupAsk]  = GroupSystem.onRefuseOfflineGroupAsk,

    }
    self._listenState = false
    self._groupDBID = 0
    self._playerDBID = 0
    self._roleDBID = 0
end

--创建群组
function GroupSystem:onCreateGroup(event)
    
    local params = event:getParams()
    local name = params[1]
    local ownerDBID = params[2]
    LuaDBAccess.CreateGroup(ownerDBID,name)
    LuaDBAccess.loadGroupInfo(0,name,GroupSystem.onGroupInfoLoaded,ownerDBID)
    
end

function GroupSystem.onGroupInfoLoaded(recordlist,ownerDBID)
    local groupInfo = recordlist[1][1]
    local groupDBID = groupInfo.ID
    LuaDBAccess.addGroupMember(ownerDBID,groupDBID,2)
    
    local role = g_playerMgr:getPlayerByDBID(ownerDBID)
    local groupHandler = role:getHandler(HandlerDef_Group)
    --更新服务端玩家群列表
    groupHandler:addGroupInfoToList(groupDBID,1,0)
    groupHandler:getGroupInfoInList(groupDBID).name = groupInfo.name
    groupHandler:getGroupInfoInList(groupDBID).ownerDBID = ownerDBID
   
    --更新服务端群信息表
    local group = Group(groupInfo)
    group:addMember(ownerDBID)
    g_playerMgr:addLoadedGroup(group)
    
    --更新客户端玩家群列表
    local eventGroupInfo = groupHandler:getGroupInfoInList(groupDBID)
    eventGroupInfo.members = group:getMembers()
    local event = Event.getEvent(FriendEvent_BC_AddGroupInfoToList,eventGroupInfo)
    g_eventMgr:fireRemoteEvent(event,role)
    
end

--离开群组
function GroupSystem:onExitGroup(event)

    local params = event:getParams()
    local roleDBID = params[1]
    local groupDBID = params[2]
    
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupHandler = role:getHandler(HandlerDef_Group)
    
    local groupInfo = groupHandler:getGroupInfoInList(groupDBID)
    --普通玩家离开群
    LuaDBAccess.exitGroup(roleDBID,groupDBID)
    local ownerDBID = groupInfo.ownerDBID
    groupHandler:deleteGroupInList(groupDBID)
    local group = g_playerMgr:getLoadedGroupByDBID(groupDBID)
    group:removeMember(roleDBID)

    for _,memberDBID in pairs(group:getMembers()) do
        local member = g_playerMgr:getPlayerByDBID(memberDBID)
        if member then
            local memberInfo = {DBID = roleDBID,name = role:getName(),state = PlayerOnlineState.Online}
            local informKind = UpdateCode.Delete
            local event_Update = Event.getEvent(FriendEvent_BC_UpdateGroupMemberInChat,memberInfo,groupDBID,informKind)
            g_eventMgr:fireRemoteEvent(event_Update,member)
        end
    end

    --群主解散群额外需要删除群信息
    if ownerDBID == roleDBID then
        local groupMembers =group:getMembers()
        for k,v in pairs(groupMembers) do
            local player = g_playerMgr:getLoadedPlayerByDBID(v)
            if player then
                local event_DeleteGroupInfoInList = Event.getEvent(FriendEvent_BC_DeleteGroupInfoInList,groupDBID)
                g_eventMgr:fireRemoteEvent(event_DeleteGroupInfoInList,player)
            end
        end
        --更新数据库
        LuaDBAccess.deleteGroup(groupDBID)
        --更新服务端数据
        g_playerMgr:deleteLoadedGroup(groupDBID)
        --邮件通知群内成员
        print("Email to other members")
    end
    
    
end

--邀请玩家入群
function GroupSystem:onInviteFriend( event )
    local params = event:getParams()
    local playerName = params[1]
    self._roleDBID = params[2]
    self._groupDBID = params[3]
    --先判断该玩家是否存在，如果存在，则回调onPlayerExist方法
    SelfProtectionMgr:checkPlayerExist(0,playerName,self._roleDBID)
    self._listenState = true
end

function GroupSystem:onPlayerExist( event )
    
    if self._listenState == true then
        local params = event:getParams()
        local playerInfo = params[1]
        --判断玩家是否在群中
        local group = g_playerMgr:getLoadedGroupByDBID(self._groupDBID)
        local member = group:getMember(playerInfo.ID)
        local role  = g_playerMgr:getPlayerByDBID(self._roleDBID)
        if member then
            local msg = GroupMsgTextKeyTable.AlreadyInGroup
            local notifyParams = {msg = msg}
            local event_ShowNotifyInfo = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.NormalNotify,notifyParams)
            g_eventMgr:fireRemoteEvent(event_ShowNotifyInfo,role)
        else--玩家不在群中
            --检查玩家是否在线
            local player = g_playerMgr:getPlayerByDBID(playerInfo.ID)
            if player then
                local informType = MsgboxParams.MsgType.OnlineMsg
                local informKind = MsgboxParams.MsgKind.MsgKind_GroupInvite
                local roleName = role:getName()
                local event_ShowInform = Event.getEvent(FriendEvent_BC_ShowInform,informType,informKind,roleName,self._groupDBID,group:getName())
                g_eventMgr:fireRemoteEvent(event_ShowInform,player)
            else
                LuaDBAccess.addGroupMember(playerInfo.ID,self._groupDBID,1)
            end
        end
    end
    
    self._listenState = false
end

--同意群组邀请
function GroupSystem:onConfirmGroupInvite( event )

    local params = event:getParams()
    local playerDBID = params[1]
    local groupDBID  = params[2]
    local informType = params[3]

    local groupInfo = g_playerMgr:getLoadedGroupByDBID(groupDBID)
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    local groupHandler = player:getHandler(HandlerDef_Group)
--更新玩家服务端群信息
    groupHandler:addGroupInfoToList(groupDBID,1,0)
    local group =  groupHandler:getGroupInfoInList(groupDBID)
    group.name = groupInfo:getName()
    group.ownerDBID = groupInfo:getOwnerDBID()
    group.inform = groupInfo:getInform()
    groupInfo:addMember(playerDBID)
    group.members = groupInfo:getMembers()

--向群里所有的在线成员发送成员新加信息
    for _,memberDBID  in pairs(group.members) do
        if memberDBID ~= playerDBID then
            local member = g_playerMgr:getPlayerByDBID(memberDBID)
            if member then
                local state = PlayerOnlineState.Online
                local informKind = UpdateCode.Add
                local memberInfo = {DBID = playerDBID,name = player:getName(),state = state}
                local event_UpdateGroupMemberInChat = Event.getEvent(FriendEvent_BC_UpdateGroupMemberInChat,memberInfo,groupDBID,informKind)
                g_eventMgr:fireRemoteEvent(event_UpdateGroupMemberInChat,member)
            end
        end
    end

    
--更新数据库
    if  informType == 0 then
        local notice = 1
        local state = 2
        local receiveGroupChatOfflineMsgState = 0
        LuaDBAccess.updateGroupSetting(playerDBID,groupDBID,state,notice,receiveGroupChatOfflineMsgState)
    else
        LuaDBAccess.addGroupMember(playerDBID,groupDBID,2)
    end
--返回消息到客户端
    local event_UpdateGroupInfoInList = Event.getEvent(FriendEvent_BC_UpdateGroupInfoInList,group)
    g_eventMgr:fireRemoteEvent(event_UpdateGroupInfoInList,player)
    
end

function GroupSystem:onRefuseOfflineGroupAsk( event )

    local params = event:getParams()
    local roleDBID = params[1]
    local groupDBID = params[2]
    LuaDBAccess.exitGroup(roleDBID,groupDBID)
end

--展示群组信息
function GroupSystem:onShowGroupInfo( event )
    local params = event:getParams()
    local playerDBID = params[1]
    local groupDBID = params[2]
    local group = g_playerMgr:getLoadedGroupByDBID(groupDBID)
    local role = g_playerMgr:getPlayerByDBID(playerDBID)
    
    local groupName = group:getName()
    local groupMemberNum = table.size(group:getMembers())
    local groupInform = group:getInform()
    local groupDBID = group:getDBID()
    local ownerDBID = group:getOwnerDBID()
    --判断群主是否存在服务器中
    local owner = g_playerMgr:getLoadedPlayerByDBID(ownerDBID)
    if owner then
        ownerName = owner:getName()
        local groupInfo = { DBID = groupDBID, name = groupName,memberNum = groupMemberNum,
                            inform = groupInform,ownerName = ownerName }
        local event_ShowGroupInfo = Event.getEvent(FriendEvent_BC_ShowGroupInfo,groupInfo)
        g_eventMgr:fireRemoteEvent(event_ShowGroupInfo,role)
    else
        LuaDBAccess.getPlayerInfo(ownerDBID,"",GroupSystem.getOwnerInfo,roleDBID,groupDBID,groupName,groupMemberNum,groupInform)
    end
    
end

--得到群主信息
function GroupSystem.getOwnerInfo( recordlist,roleDBID,groupDBID,groupName,groupMemberNum,groupInform )
    local playerInfos = recordlist[1]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    if playerInfos then
        local  ownerInfo = playerInfos[1]
        if ownerInfo then
            ownerName = ownerInfo.name
            local groupInfo = { DBID = groupDBID,name = groupName,memberNum = groupMemberNum,
                                inform = groupInform,ownerName = ownerName }
            local event_ShowGroupInfo = Event.getEvent(FriendEvent_BC_ShowGroupInfo,groupInfo)
            g_eventMgr:fireRemoteEvent(event_ShowGroupInfo,role)
        end
    end
    
end

--更新个人的群设置
function GroupSystem:onUpdateGroupSetting( event )

    local params = event:getParams()
    local roleDBID = params[1]
    local groupInfo = params[2]
    local player = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupHandler = player:getHandler(HandlerDef_Group)
    --更新服务端设置
    groupHandler:getGroupInfoInList(groupInfo.DBID).notice = groupInfo.notice
    local state = 2
    local notice = groupInfo.notice
    local receiveGroupChatOfflineMsgState = 0
    --更新数据库信息
    LuaDBAccess.updateGroupSetting(roleDBID,groupInfo.DBID,state,notice,receiveGroupChatOfflineMsgState)
end

--更新群信息，一般用来更新群通知
function GroupSystem:onUpdateGroupInfo( event )
    
    local params = event:getParams()
    local groupInfo = params[1]
    --更新服务端
    g_playerMgr:getLoadedGroupByDBID(groupInfo.DBID):setInform(groupInfo.inform)
    --更新数据库
    LuaDBAccess.updateGroupInfo(groupInfo.DBID,groupInfo.inform)
    
    
end

--得到群成员信息并显示
function GroupSystem:onGetGroupInfoInChat( event )
    
    local params = event:getParams()
    local roleDBID = params[1]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupDBID = params[2]
    local group = g_playerMgr:getLoadedGroupByDBID(groupDBID)
    local memberInfos = {}

    if group then
--得到群成员DBID表
        local groupMembers = group:getMembers()
--根据DBID从服务端得到群信息，并以表的形式存储
        for _,memberDBID in pairs(groupMembers) do

            local memberInfoNew = {}
            local memberInfo = g_playerMgr:getPlayerByDBID(memberDBID) 

            if memberInfo then
                memberInfoNew = {DBID = memberInfo:getDBID(),name = memberInfo:getName(),state = PlayerOnlineState.Online}
            else
                memberInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
                if memberInfo then
                    memberInfoNew = {DBID = memberInfo:getDBID(),name = memberInfo:getName(),state = PlayerOnlineState.Offline}
                end
            end
            memberInfos[memberInfoNew.DBID] = memberInfoNew
        end

--整合信息，发送到客户端
        local groupInfo = {DBID = group:getDBID(),name = group:getName(),
            ownerDBID = group:getOwnerDBID(),inform = group:getInform(),
            members = groupMembers,memberInfos = memberInfos}
        if role then
            local event_ShowGroupInfoInChat = Event.getEvent(FriendEvent_BC_ShowGroupInfoInChat,groupInfo)
            g_eventMgr:fireRemoteEvent(event_ShowGroupInfoInChat,role)
        end

    end

end

--群组聊天相关处理-----------------------------------------------------------------------------

function GroupSystem:onSendMsgToGroup( event )

    local params = event:getParams()
    local playerDBID = params[1]
    local groupDBID = params[2]
    local msg       = params[3]
--得到群成员DBID表，创建用来在聊天窗口显示的信息
    local group = g_playerMgr:getLoadedGroupByDBID(groupDBID)
    local memberInfos = {}
    --得到群成员
    local groupMembers = group:getMembers()
    for _,memberDBID in pairs(groupMembers) do
        local memberInfoNew = {}
        local memberInfo = g_playerMgr:getPlayerByDBID(memberDBID) 
        if memberInfo then
            memberInfoNew = {DBID = memberInfo:getDBID(),name = memberInfo:getName(),state = PlayerOnlineState.Online}
        else
            memberInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
            if memberInfo then
                memberInfoNew = {DBID = memberInfo:getDBID(),name = memberInfo:getName(),state = PlayerOnlineState.Offline}
            end
        end
        memberInfos[memberInfoNew.DBID] = memberInfoNew
    end
    local groupInfo = {DBID = group:getDBID(),name = group:getName(),
            ownerDBID = group:getOwnerDBID(),inform = group:getInform(),
            members = groupMembers,memberInfos = memberInfos}

--将该信息绑定到消息上
    msg["groupInfo"] = groupInfo
--判断群内玩家是否在线，并进行处理
    for _,memberDBID in pairs(groupMembers) do
        if memberDBID ~= playerDBID then
            local player = g_playerMgr:getPlayerByDBID(memberDBID)
            --如果玩家在线
            if player then
                local event_SendMsgToGroup = Event.getEvent(FriendEvent_BC_SendMsgToGroup,groupInfo.DBID,msg)
                g_eventMgr:fireRemoteEvent(event_SendMsgToGroup,player)
            else
                local player = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
                if player then
                    --更新数据库
                    LuaDBAccess.addGroupChatOfflineMsg(memberDBID,groupInfo.DBID,groupInfo.name,msg.msgHeader,msg.msgContent)
                else
                    print("该玩家从未上过线")
                end
            end
        end

    end

end


function GroupSystem.getInstance()
    return GroupSystem()
end
g_eventMgr:addEventListener(GroupSystem:getInstance())
