--[[RoleConfigManager.lua
	描述：玩家功能数据管理
]]


ConfigType =
{
	RefuseFriend	= 0,		-- 好友
	RefuseMessage	= 1,		--私聊
	RefuseInfo		= 2,		--查看信息
	RefuseTeam		= 3,		-- 拒绝入队
	RefuseTrade		= 4,		-- 拒绝交易
	RefuseFaction	= 5,		-- 拒绝入帮
}

RoleConfigManager = class(nil, Singleton)
function RoleConfigManager:__init()
	self.roleDBID = nil
	self.funSetting	= {}
	self.data = {}
end

-- 默认数据（及取配置中的数据）
function RoleConfigManager:initDef() 
	self.funSetting[ConfigType.RefuseFriend]	= false
	self.funSetting[ConfigType.RefuseMessage]	= false
	self.funSetting[ConfigType.RefuseInfo]		= false
	self.funSetting[ConfigType.RefuseTeam]		= false
	self.funSetting[ConfigType.RefuseTrade]		= false
	self.funSetting[ConfigType.RefuseFaction]	= false
	self.data = self.funSetting
	return self.data
end

-- 接收来自客户端的数据
function RoleConfigManager:doSaveFun(roleID,funSetting)
	local player = g_entityMgr:getPlayerByID(roleID)
	local roleDBID = player:getDBID()
	self.roleDBID = roleDBID
	self.data = {}
	self.data.rFriend	= funSetting[ConfigType.RefuseFriend]
	self.data.rMess		= funSetting[ConfigType.RefuseMessage]
	self.data.rInfo		= funSetting[ConfigType.RefuseInfo]
	self.data.rTeam		= funSetting[ConfigType.RefuseTeam]
	self.data.rTrade	= funSetting[ConfigType.RefuseTrade]
	self.data.rFaction	= funSetting[ConfigType.RefuseFaction]
	self:saveDataToServer()
	local SystemSetHandler = player:getHandler(HandlerDef_SystemSet)
	SystemSetHandler:setSystemData(self.data)
end

-- 保存数据到数据库
function RoleConfigManager:saveDataToServer()

	LuaDBAccess.SaveRoleConfig(self.roleDBID,self.data)
end

-- 上线加载数据库的数据
function RoleConfigManager:loadDataFromDB(player,data)
	if not player then return nil end
	if not data then return end

	if table.size(data) > 0 then
		if tonumber(data[1].rFriend) > 0 then
			data[1].rFriend = true
		else
			data[1].rFriend = false
		end
		if tonumber(data[1].rMess) > 0 then
			data[1].rMess = true
		else
			data[1].rMess = false
		end
		if tonumber(data[1].rInfo) > 0 then
			data[1].rInfo = true
		else
			data[1].rInfo = false
		end
		if tonumber(data[1].rTeam) > 0 then
			data[1].rTeam = true
		else
			data[1].rTeam = false
		end
		if tonumber(data[1].rTrade) > 0 then
			data[1].rTrade = true
		else
			data[1].rTrade = false
		end
		if tonumber(data[1].rFaction) > 0 then
			data[1].rFaction = true
		else
			data[1].rFaction = false
		end
		
		local SystemSetHandler = player:getHandler(HandlerDef_SystemSet)
		SystemSetHandler:setSystemData(data[1])
		self:initFromDB(player,data[1])	-- 发送到客户端
	else
		data = self:initDef()
		self:initFromDB(player,data)
	end
end

-- 加载完毕发数据到客户端
function RoleConfigManager:initFromDB(player,data)
	local event = Event.getEvent(RoleConfigureEvent_SC_getSaveFun,data)
	g_eventMgr:fireRemoteEvent(event,player)
end

function RoleConfigManager.getInstance()
	return RoleConfigManager()
end

