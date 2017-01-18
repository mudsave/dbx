--[[Group.lua

	Function: Save the data for Group
    Author: Caesar

--]]

require "base.base"


Group = class()

function Group:__init(info)

	self.ID = nil
	self.DBID = info.ID
	self.name = info.name
	self.ownerDBID = info.ownerDBID
	self.inform = info.inform
	self.members = {}
	
end

function Group:__release()
	self.DBID = nil
	self.members = nil
	self.name = nil
	self.ownerDBID = nil
	self.inform = nil
end

function Group:setDBID(ID)
	self.DBID = ID
end

function Group:getDBID()
	return self.DBID 
end

function Group:setOwnerDBID(ID)
	self.ownerDBID = ID
end

function Group:getOwnerDBID()
	return self.ownerDBID 
end

function Group:setName(name)
	self.name = name
end

function Group:getName()
	return self.name 
end

function Group:setInform(inform)
	self.inform = inform
end

function Group:getInform()
	return self.inform
end

function Group:addMember(memberID)
	self.members[memberID] = memberID
end

function Group:removeMember(memberID)
	self.members[memberID] = nil 
end

function Group:getMember( memberID )
	return self.members[memberID]
end

function Group:getMembers()
	return self.members
end
