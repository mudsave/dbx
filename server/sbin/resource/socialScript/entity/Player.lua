--[[Player.lua

	Function: Save the data of player
	Author: Caesar

--]]

require "base.base"

Player = class()

function Player:__init()

	self._DBID 			= nil
	self._name 			= nil
	self._level 		= nil
	self._school 		= nil
	self._sex 			= nil
	self._offlineDate	= nil
	self._onlineDate	= nil
	self._vigor			= nil
	self._offlineMsg 	= {}
	self._handlers 		= {}
	self._modelID		= false
	self._curHeadTex    = 0
	self._curBodyTex    = 0

	self._hClientLink	= nil
	self._hGateId		= nil
	self._id			= nil
end

function Player:__release()

	self._DBID 			= nil
	self._name 			= nil
	self._level 		= nil
	self._school 		= nil
	self._sex 			= nil
	self._offlineMsg 	= nil
	self._onlineDate	= nil
	self._vigor			= nil
	self._handlers 		= nil
	self._offlineDate	= nil
	self._modelID		= nil
	self._curHeadTex    = nil
	self._curBodyTex    = nil
	self._hClientLink	= nil
	self._hGateId		= nil
	self._id			= nil
end

function Player:setID(id)
	self._id = id
end

function Player:getID()
	return self._id
end

function Player:setGatewayId( gateId )
	self._hGateId = gateId
end

function Player:setClientLink( clientLink )
	self._hClientLink = clientLink
end

function Player:getGatewayId()
	return self._hGateId
end

function Player:getClientLink()
	return self._hClientLink
end

function Player:getDBID()
	return self._DBID
end

function Player:setDBID(ID)
	  self._DBID = ID
end

function Player:setCurHeadTex(texIndex)
	self._curHeadTex = texIndex
end

function Player:getCurHeadTex()
	return self._curHeadTex
end

function Player:setCurBodyTex(texIndex)
	self._curBodyTex = texIndex
end

function Player:getCurBodyTex()
	return self._curBodyTex
end

function Player:setModelID(modelID)
	self._modelID = modelID
end

function Player:getModelID()
	return self._modelID 
end

function Player:getName()
	return self._name
end

function Player:setName(name)
	  self._name = name
end

function Player:getLevel()
	return self._level
end

function Player:setLevel(level)
	  self._level = level
end

function Player:getSchool()
	return self._school
end

function Player:setSchool(school)
	  self._school = school
end

function Player:getSex()
	return self._sex
end

function Player:setSex(sex)
	self._sex = sex
end

function Player:getVigor(  )

	return self._vigor

end

function Player:setVigor( vigor )

	self._vigor = vigor

end

function Player:setOfflineDate( offlineDate )
	self._offlineDate = offlineDate
end

function Player:setOnlineDate( onlineDate )
	self._onlineDate = onlineDate
end

function Player:getOnlineDate(  )
	return self._onlineDate
end

function Player:getOfflineDate(  )
	return self._offlineDate
end


--offlineMsg处理
function Player:addOfflineMsg( offlineMsg )
	self._offlineMsg[table.size(self._offlineMsg) + 1] = offlineMsg
end

function Player:getOfflineMsgs(  )
	return self._offlineMsg
end


--Handler处理
function Player:addHandler( hType,handler )
	self._handlers[hType] = handler
end

function Player:removeHandler( hType )
	self._handlers[hType] = nil
end

function Player:getHandler( hType )
	return self._handlers[hType]
end
