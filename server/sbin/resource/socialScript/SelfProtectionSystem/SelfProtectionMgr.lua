--[[SelfProtectionMgr.lua

    Function: Protect the social data 
    Author: Caesar

]]


SelfProtectionMgr = class(nil,Singleton)


function SelfProtectionMgr:__init()

end



--检查玩家是否存在
function SelfProtectionMgr:checkPlayerExist(playerDBID,playerName,roleDBID)
    LuaDBAccess.getPlayerInfo(playerDBID,playerName,SelfProtectionMgr.onCheckPlayerExist,roleDBID)
end

function SelfProtectionMgr.onCheckPlayerExist(recordList,roleDBID)
    local playerInfos = recordList[1]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    if table.size(playerInfos) > 0 then--玩家存在
        local event = Event.getEvent(FriendEvent_BB_PlayerExist,playerInfos[1])
        g_eventMgr:fireEvent(event)
    else--玩家不存在
        local msg = FriendMsgTextKeyTable.PlayerIsNotExist
        local notifyParams = {msg = msg}
        local event = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.NormalNotify,notifyParams)
        g_eventMgr:fireRemoteEvent(event,role)
    end
end

--检查群组是否存在
function SelfProtectionMgr:checkGroupExit( groupDBID,groupName,roleDBID )
    LuaDBAccess.loadGroupInfo(groupDBID,groupName,SelfProtectionMgr.onCheckGroupExit,roleDBID)
end

function SelfProtectionMgr.onCheckGroupExit( recordList,roleDBID )
    local groupInfos = recordList[1]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    if table.size(groupInfos) > 0 then
    else
        local msg = GroupMsgTextKeyTable.GroupIsNotExist
        local notifyParams = {msg = msg}
        local event = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.NormalNotify,notifyParams)
        g_eventMgr:fireRemoteEvent(event,role)
    end
end


function SelfProtectionMgr:__release()
    
    
end


function SelfProtectionMgr.getInstance()
    return SelfProtectionMgr()
end