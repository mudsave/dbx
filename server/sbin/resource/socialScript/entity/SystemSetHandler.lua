--[[SystemSetHandler.lua

	Function: Save the data of the Systemset
	Author: Jiangyu

]]

SystemSetHandler = class(nil)

function SystemSetHandler:__init(entity)
	-- 系统数据所属于的玩家
	self._entity = entity
	-- 系统数据表
	self.data = {}
end

function SystemSetHandler:_release()
	self._entity = nil
	self.data = nil
end

-- 设置系统数据
function SystemSetHandler:setSystemData(data)
	self.data.rFriend		= data.rFriend
	self.data.rMess			= data.rMess
	self.data.rInfo			= data.rInfo
	self.data.rTeam			= data.rTeam
	self.data.rTrade		= data.rTrade
	self.data.rFaction		= data.rFaction
	print("handler's ==================================data",toString(self.data))
end

-- 拒绝添加好友
function SystemSetHandler:getRefFriend()
	return self.data.rFriend
end

-- 拒绝私聊
function SystemSetHandler:getRefMess()
	return self.data.rMess
end

-- 拒绝查看信息
function SystemSetHandler:getRefInfo()
	return self.data.rInfo
end

-- 拒绝加入队伍
function SystemSetHandler:getRefTeam()
	return self.data.rTeam
end

-- 拒绝交易
function SystemSetHandler:getRefTrade()
	return self.data.rTrade
end

-- 拒绝加入帮会
function SystemSetHandler:getRefFaction()
	return self.data.rFaction
end
