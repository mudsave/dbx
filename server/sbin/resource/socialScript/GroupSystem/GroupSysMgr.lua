--[[GroupSysMgr.lua

    Function: The manager of GroupSystem 
    Author: Caesar

]]

require "core.LuaDBAccess"
require "entity.Group"

GroupSysMgr = class(nil,Singleton)

function GroupSysMgr:__init()

end

--得到群组数据
function GroupSysMgr.loadData(roleDBID)
    --执行相关函数，然后执行回调函数,传入查询的结果
    local operationId = LuaDBAccess.loadRoleGroups(roleDBID,GroupSysMgr.onRoleGroupsLoaded,roleDBID)
end

--得到玩家所有相关群ID，包括正在申请的群ID
function GroupSysMgr.onRoleGroupsLoaded(recordList,roleDBID)

    local groupInfos = recordList[1]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupHandler = role:getHandler(HandlerDef_Group)
    local friendHandler = role:getHandler(HandlerDef_Friend)
    --初始化群数量和群离线消息数量
    local groupNum = 0 
    local groupChatOfflineMsgCount = 0
    if table.size(groupInfos) > 0 then
        --判断是否存在离线聊天信息，初始化离线数量
        for _,groupInfo in pairs(groupInfos) do
            --如果存在离线消息，则初始化一些变量
            if groupInfo.receiveOfflineMsgState == 1 then
                groupChatOfflineMsgCount = groupChatOfflineMsgCount + 1
                groupHandler:addOfflineGroupDBIDInList(groupInfo.groupID)
            end
        end
        --初始化离线消息数量和群组数
        groupHandler:setRemainChatOfflineMsgCount(groupChatOfflineMsgCount)
        groupHandler:setRemainGroupCount(table.size(groupInfos))
        --对得到的数据进行判断，筛选出已经加入的群ID
        for _,v in pairs(groupInfos) do
            --判断群组是否已经加载
            local group = g_playerMgr:getLoadedGroupByDBID(v.groupID)
            if group then --如果群组已经加载，则从服务端加载数据，同时判断离线申请
                --存储已经加入的群ID到玩家群Handler中
                if v.state == PlayerState.Already then
                    --初始化相关群信息
                    groupHandler:addGroupInfoToList(v.groupID,v.notice)
                    groupHandler:getGroupInfoInList(v.groupID).name = group:getName()
                    groupHandler:getGroupInfoInList(v.groupID).ownerDBID = group:getOwnerDBID()
                    groupHandler:getGroupInfoInList(v.groupID).inform = group:getInform()
                    --初始化群成员表
                    groupHandler:getGroupInfoInList(v.groupID).members = group:getMembers()

                    if(group:getOwnerDBID() == roleDBID) then --如果玩家是该群群主，则拥有群数加1
                        groupHandler:setGroupNum(groupHandler:getGroupNum() + 1)
                    end
                end
                --处理离线申请
                GroupSysMgr.handleOfflineAsk(v,role,groupHandler,group,groupNum,friendHandler)
            else--如果服务器不存在该群组，则从数据库调用数据
                groupHandler:addGroupInfoToList(v.groupID,v.notice)
                LuaDBAccess.loadGroupInfo(v.groupID,"",GroupSysMgr.onGroupsLoaded,roleDBID)
            end
        end
    else
        AlreadyLoadData.GroupOfflineData = true
        if AlreadyLoadData.FriendOfflineData and AlreadyLoadData.GroupOfflineData then
            print("群组：全部离线消息加载完毕，等待发送")
            if table.size(role:getOfflineMsgs()) > 0 then
                local event_SendOfflineMsg = Event.getEvent(FriendEvent_BC_SendOfflineMsg,role:getOfflineMsgs())
                g_eventMgr:fireRemoteEvent(event_SendOfflineMsg,role)
            end
        end
    end
end

--处理离线邀请
function GroupSysMgr.handleOfflineAsk( v,role,groupHandler,group,groupNum,friendHandler )

    if v.state == PlayerState.Ask then

        local eventParams = {}
        local ownerDBID = group:getOwnerDBID()
        local groupOwner = g_playerMgr:getLoadedPlayerByDBID(ownerDBID)
        groupNum = groupNum + 1
        local offlineMsg = {kind = OfflineMsgKind.GroupAsk,groupNum = groupNum,
        groupDBID = group:getDBID(),groupName = group:getName(),
        ownerName = groupOwner:getName()}
        role:addOfflineMsg(offlineMsg)
        
    end
    groupHandler:setRemainGroupCount(groupHandler:getRemainGroupCount()-1)
    --发送群组信息到客户端
    GroupSysMgr.fireGroupInfoToClient(groupHandler,friendHandler,role)

end

--根据群ID得到群信息
function GroupSysMgr.onGroupsLoaded(recordList,roleDBID)

    local groupInfo = recordList[1]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupHandler = role:getHandler(HandlerDef_Group)
    local group = {}
    for _,v in pairs(groupInfo) do --得到群属性并赋值
        if(v.ownerDBID == roleDBID) then --如果玩家是该群群主，则拥有群数加1
           groupHandler:setGroupNum(groupHandler:getGroupNum() + 1)
           groupHandler:getGroupInfoInList(v.ID).ownerDBID = roleDBID
        end
        groupHandler:getGroupInfoInList(v.ID).name = v.name
        groupHandler:getGroupInfoInList(v.ID).inform = v.inform

        --存储群组信息到服务器
        group = Group(v)
        g_playerMgr:addLoadedGroup(group)
    end
    --存储群成员
    LuaDBAccess.loadGroupMembers(group:getDBID(),GroupSysMgr.onLoadGroupMembers,roleDBID) 
end

--得到群成员并初始化群成员表
function GroupSysMgr.onLoadGroupMembers(recordList,roleDBID)
    
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupHandler = role:getHandler(HandlerDef_Group)
    local friendHandler = role:getHandler(HandlerDef_Friend)

    local groupMembers = recordList[1]
    local group = g_playerMgr:getLoadedGroupByDBID(groupMembers[1].groupID)
    --设置群成员数量
    groupHandler:setRemainGroupMembersCount(table.size(groupMembers))
    for _,v in pairs(groupMembers) do
        if v.state == PlayerState.Already then
           group:addMember(v.ID)
           LuaDBAccess.getPlayerInfo(v.ID,"",GroupSysMgr.onLoadGroupMembersInfo,roleDBID)
        end
    end

    --初始化群成员表
    groupHandler:getGroupInfoInList(groupMembers[1].groupID).members = group:getMembers()
    groupHandler:setRemainGroupCount(groupHandler:getRemainGroupCount()-1)
    GroupSysMgr.fireGroupInfoToClient(groupHandler,friendHandler,role)

end

--载入群成员信息
function GroupSysMgr.onLoadGroupMembersInfo( recordList,roleDBID )
    
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local groupHandler = role:getHandler(HandlerDef_Group)
    local friendHandler = role:getHandler(HandlerDef_Friend)
    local groupMembers = recordList[1]
	local playerSocialServerData = recordList[2][1]
    
    if table.size(groupMembers) > 0 then
        local member = groupMembers[1]
        local playerExist = g_playerMgr:getLoadedPlayerByDBID(member.ID)
		if not playerExist then
            local player = Player()
            player:setDBID(member.ID)
            player:setName(member.name)
            player:setLevel(member.level)
            player:setSchool(member.school)
            player:setSex(member.sex)
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
    end

    groupHandler:setRemainGroupMembersCount(groupHandler:getRemainGroupMembersCount() - 1 )
    GroupSysMgr.fireGroupInfoToClient(groupHandler,friendHandler,role)

end

--发送群组消息到客户端
function GroupSysMgr.fireGroupInfoToClient( groupHandler,friendHandler,role )

    if groupHandler:getRemainGroupCount() == 0 and groupHandler:getRemainGroupMembersCount() == 0 then
        --发送玩家群信息到客户端
        local event = Event.getEvent(FriendEvent_BC_SendGroupInfoList,groupHandler:getGroupInfoList())
        g_eventMgr:fireRemoteEvent(event,role)

        --读取群组离线消息
        local offlineGroupDBIDList =  groupHandler:getOfflineGroupDBIDList()
        if  table.size(offlineGroupDBIDList) > 0 then
            for key ,value in pairs(offlineGroupDBIDList) do
                LuaDBAccess.getGroupChatOfflineMsg(value,role:getDBID(),GroupSysMgr.getGroupChatOfflineMsg,role:getDBID())
                groupHandler:removeOfflineGroupDBIDInList(key)
            end
        else
            --如果群组离线消息不存在，则发送总离线消息表
            AlreadyLoadData.GroupOfflineData = true
            if AlreadyLoadData.FriendOfflineData and AlreadyLoadData.GroupOfflineData then
                print("群组：全部离线消息加载完毕，等待发送")
                if table.size(role:getOfflineMsgs()) > 0 then
                    local event = Event.getEvent(FriendEvent_BC_SendOfflineMsg,role:getOfflineMsgs())
                    g_eventMgr:fireRemoteEvent(event,role)
                end
            end
        end
    end
end

--得到群组离线聊天信息
function GroupSysMgr.getGroupChatOfflineMsg( recordList,roleDBID )
    
    local groupOfflineMsgs = recordList[1]
    --如果存在离线消息
    if table.size(groupOfflineMsgs) > 0 then
        local groupDBID = 0
        --由于存储在数据库的消息和实际发送的消息顺序是相反的，这里反向创建一个表
        local tableSize = table.size(groupOfflineMsgs)
        local groupChatOfflineMsgs = {}
        for _,v in pairs(groupOfflineMsgs) do
            groupDBID = v.groupDBID
            groupChatOfflineMsgs[tableSize] = v
            tableSize = tableSize - 1
        end
        
        local role = g_playerMgr:getPlayerByDBID(roleDBID)
        local group = g_playerMgr:getLoadedGroupByDBID(groupDBID)
    
        local groupHandler = role:getHandler(HandlerDef_Group)
        local friendHandler = role:getHandler(HandlerDef_Friend)
        --成员信息表
        local memberInfos = {}
        local groupMembers = group:getMembers()
        --根据DBID从服务端得到群信息，并以表的形式存储
        for _,value in pairs(groupMembers) do
            --临时成员信息表
            local memberInfoNew = {}
            local memberInfo = g_playerMgr:getPlayerByDBID(value) 
            --如果成员在线
            if memberInfo then
                memberInfoNew = {DBID = memberInfo:getDBID(),name = memberInfo:getName(),state = "在线"}
            else--判断成员是否在线
                memberInfo = g_playerMgr:getLoadedPlayerByDBID(value)
                if memberInfo then
                    memberInfoNew = {DBID = memberInfo:getDBID(),name = memberInfo:getName(),state = "离线"}
                end
                --这里暂时不加成员从没上线的情况，因为群组成员都是在群组上线的前提下存在
            end
            memberInfos[memberInfoNew.DBID] = memberInfoNew
        end
        --群组信息
        local groupInfo = {DBID = group:getDBID(),name = group:getName(),ownerDBID = group:getOwnerDBID(),inform = group:getInform(),members = groupMembers,memberInfos = memberInfos }
        --遍历离线消息表
        for _,value in pairs(groupChatOfflineMsgs) do

            --从数据库得到离线聊天消息，并整合成表
            local msg = {msgGroupName = value.groupName,msgHeader = value.msgHeader,msgContent = value.msgContent }
            --整合成离线聊天表
            local offlineMsg = {kind = OfflineMsgKind.GroupChat,[value.groupName] = {},groupInfo = groupInfo}
            --把消息插入到离线聊天表
            table.insert( offlineMsg[value.groupName],msg )
            local role = g_playerMgr:getPlayerByDBID(roleDBID)
            role:addOfflineMsg(offlineMsg)
            
        end
        --更新数据库
        LuaDBAccess.deleteGroupChatOfflineMsg(roleDBID,groupDBID)
        LuaDBAccess.updateGroupSetting(roleDBID,groupDBID,2,group.notice,0)
        groupHandler:setRemainChatOfflineMsgCount(groupHandler:getRemainChatOfflineMsgCount() - 1)

        GroupSysMgr.checkRemainChatOfflineMsgCount(groupHandler,friendHandler,role)
    
    end
    
end

--检查离线消息是否读取完毕
function GroupSysMgr.checkRemainChatOfflineMsgCount(groupHandler,friendHandler,role)

    --如果群组离线消息读取完，则发送消息
    if groupHandler:getRemainChatOfflineMsgCount() == 0 then
        AlreadyLoadData.GroupOfflineData = true
        if AlreadyLoadData.GroupOfflineData and AlreadyLoadData.FriendOfflineData then
            print("群组：全部离线消息加载完毕，等待发送")
            if table.size(role:getOfflineMsgs()) > 0 then
                local event = Event.getEvent(FriendEvent_BC_SendOfflineMsg,role:getOfflineMsgs())
                g_eventMgr:fireRemoteEvent(event,role)
            end
        end
    end

end

function GroupSysMgr.getInstance()
    return GroupSysMgr()
end

