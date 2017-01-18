--[[GroupHandler

    Function:Save the data or function for Group
    Author:Caesar

]]

GroupHandler = class()

function GroupHandler:__init(entity)
    self._entity = entity
    self._groupInfoList = {}
    self._groupNum = 0
    self._remainGroupCount = 0
    self._remainGroupMembersCount = 0
    self._remainGroupOfflineMsgCount = 0
    self._offlineGroupDBIDList = {}
    self._saveOfflineMsg = false
end

function GroupHandler:addGroupInfoToList( groupDBID,noticeValue)
    self._groupInfoList[groupDBID] = { DBID = groupDBID ,notice = noticeValue,name = "",members= {},ownerDBID = nil,inform = nil}
end

function GroupHandler:deleteGroupInList( groupDBID )
    self._groupInfoList[groupDBID] = nil
end

function GroupHandler:getGroupInfoInList( groupDBID )
    return self._groupInfoList[groupDBID]
end

function GroupHandler:getGroupInfoList()
    return self._groupInfoList
end

function GroupHandler:getGroupNum(  )
    return self._groupNum
end

function GroupHandler:setGroupNum( num )
    self._groupNum = num
end


function GroupHandler:saveOfflineMsg(  )
    self._saveOfflineMsg = true
end

function GroupHandler:isSaveOfflineMsg(  )
    return self._saveOfflineMsg
end


function GroupHandler:setRemainGroupCount( count )
    self._remainGroupCount = count
end

function GroupHandler:getRemainGroupCount(  )
    return self._remainGroupCount
end

function GroupHandler:setRemainGroupMembersCount( count )
    self._remainGroupMembersCount = count
end

function GroupHandler:getRemainGroupMembersCount(  )
     return self._remainGroupMembersCount
end

function GroupHandler:getRemainChatOfflineMsgCount(  )
    return self._remainGroupOfflineMsgCount
end

function GroupHandler:setRemainChatOfflineMsgCount( count )
    self._remainGroupOfflineMsgCount = count
end

function GroupHandler:addOfflineGroupDBIDInList( DBID )
    self._offlineGroupDBIDList[DBID] = DBID
end

function GroupHandler:removeOfflineGroupDBIDInList( DBID )
    self._offlineGroupDBIDList[DBID] = nil
end

function GroupHandler:getOfflineGroupDBIDList(  )
    return self._offlineGroupDBIDList 
end

function GroupHandler:__release()
	self._entity = nil
    self._groupInfoList = nil
    self._groupNum = 0
    self._saveOfflineMsg = nil
    self._remainGroupMembersCount = nil
    self._remainGroupOfflineMsgCount = nil
    self._offlineGroupDBIDList = nil
end
