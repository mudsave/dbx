--[[FriendHandler.lua

    Function: Save the data for Friend
    Author: Caesar
    
]]

FriendHandler = class()

function FriendHandler:__init(entity)
    self._entity = entity
    self._friendList = {}
    self._blackListInfo = {screenListInfos = {},enemyListInfos = {}}
    self._remainFriendCount = 0
    self._remainOfflineMsgCount = 0
    self._autoHideChatWin = 0
end

function FriendHandler:__release()
	self._entity = nil
	self._friendList = nil
    self._blackListInfo = nil
    self._remainFriendCount = nil
    self._remainOfflineMsgCount = nil
    self._autoHideChatWin = nil
end

--好友操作---------------------------------------------------------
function FriendHandler:addFriend( friendDBID )
    self._friendList[friendDBID] = {friendDBID = friendDBID,name = ""}
end

function FriendHandler:deleteFriend( friendDBID )
    self._friendList[friendDBID] = nil
end

function FriendHandler:getFriend( friendDBID )
    return self._friendList[friendDBID]
end

function FriendHandler:getFriendList( )
    return self._friendList
end

--黑名单操作--------------------------------------------------------

function FriendHandler:addEnemyInfoToBlackListInfo( enemyInfo )
	
    local enemyCount = table.size(self._blackListInfo["enemyListInfos"])
    if enemyCount > 19 then
		self._blackListInfo["enemyListInfos"][1] = nil
		for value = 2,enemyCount do
			self._blackListInfo["enemyListInfos"][value-1] = self._blackListInfo["enemyListInfos"][value]
		end
		self._blackListInfo["enemyListInfos"][enemyCount] = screenInfo
	else
        local enemy = self:getEnemyInfoInBlackListInfo(enemyInfo.enemyDBID)
	    if not enemy then
    	    table.insert( self._blackListInfo["enemyListInfos"],enemyInfo)
	    end
    end
    
end

function FriendHandler:deleteEnemyInfoInBlackListInfo( enemyDBID )
	
    for key,value in pairs(self._blackListInfo["enemyListInfos"]) do  
        if value.enemyDBID == enemyDBID then
            self._blackListInfo["enemyListInfos"][key] = nil
        end
    end

end

function FriendHandler:getEnemyInfoInBlackListInfo( enemyDBID )

	for key,value in pairs(self._blackListInfo["enemyListInfos"]) do  
        if value.enemyDBID == enemyDBID then
            return self._blackListInfo["enemyListInfos"][key]
        end
    end

end

function FriendHandler:getEnemyInfoInBlackListInfoByName( enemyName )

	for key,value in pairs(self._blackListInfo["enemyListInfos"]) do  
        if value.enemyName == enemyName then
            return self._blackListInfo["enemyListInfos"][key]
        end
    end

end

function FriendHandler:getEnemyInfosInBlackListInfo(  )

	return self._blackListInfo["enemyListInfos"]

end

function FriendHandler:setEnemyInfosInBlackListInfo( enemyListInfos )

	self._blackListInfo["enemyListInfos"] = enemyListInfos

end

function FriendHandler:addScreenInfoToBlackListInfo( screenInfo )
	
    local screenCount = table.size(self._blackListInfo["screenListInfos"])
    if screenCount > 29 then
		self._blackListInfo["screenListInfos"][1] = nil
		for value = 2,screenCount do
			self._blackListInfo["screenListInfos"][value-1] = self._blackListInfo["screenListInfos"][value]
		end
		self._blackListInfo["screenListInfos"][screenCount] = screenInfo
	else
        local screen = self:getScreenInfoInBlackListInfo(screenInfo.screenDBID)
        if not screen then
            table.insert( self._blackListInfo["screenListInfos"],screenInfo)
        end
    end

end

function FriendHandler:deleteScreenInfoInBlackListInfo( screenDBID )
	
    for key,value in pairs(self._blackListInfo["screenListInfos"]) do  
        if value.screenDBID == screenDBID then
            self._blackListInfo["screenListInfos"][key] = nil
        end
    end

end

function FriendHandler:getScreenInfoInBlackListInfo( screenDBID )

	for key,value in pairs(self._blackListInfo["screenListInfos"]) do  
        if value.screenDBID == screenDBID then
            return self._blackListInfo["screenListInfos"][key]
        end
    end

end

function FriendHandler:getScreenInfoInBlackListInfoByName( screenName )

	for key,value in pairs(self._blackListInfo["screenListInfos"]) do  
        if value.screenName == screenName then
            return self._blackListInfo["screenListInfos"][key]
        end
    end

end

function FriendHandler:getScreenInfosInBlackListInfo(  )

	return self._blackListInfo["screenListInfos"]

end

function FriendHandler:setScreenInfosInBlackListInfo( screenListInfos )

	self._blackListInfo["screenListInfos"] = screenListInfos

end

function FriendHandler:setAutoHideChatWin( autoHideChatWin )
	self._autoHideChatWin = autoHideChatWin
end
function FriendHandler:getAutoHideChatWin(  )
	return self._autoHideChatWin
end

--消息操作-------------------------------------------------------
function FriendHandler:setRemainFriendCount( count )
    self._remainFriendCount = count
end

function FriendHandler:getRemainFriendCount(  )
    return self._remainFriendCount
end

function FriendHandler:getRemainChatOfflineMsgCount( )
    return self._remainOfflineMsgCount
end

function FriendHandler:setRemainChatOfflineMsgCount( count )
    self._remainOfflineMsgCount = count
end