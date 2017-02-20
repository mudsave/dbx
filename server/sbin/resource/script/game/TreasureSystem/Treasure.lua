--[[Treasure.lua
描述:宝藏类 
]]

Treasure = class()

function Treasure:__init(owner,treasureID)
	-- 配置ID
	self.ID = treasureID
	-- 宝藏的拥有者
	self.owner = owner
	-- GUIID唯一值 一个地图 对应一个宝藏
	self.guid = nil
	-- 读取配置
	self.config = tTreasureDB[self.ID]
	-- 种类
	self.type = self.config.Type
	-- 宝藏所在地图ID
	self.mapID =  nil
	-- 宝藏所在地图x坐标
	self.posX = nil
	-- 宝藏所在地图y坐标
	self.posY = nil
	-- 宝藏地图附近的点 这个是用来发送给玩家寻找宝藏的点
	self.nearPosX = nil
	self.nearPosY = nil
	-- 宝藏的状态控制 1原始 没有点击过 2知道地点 3知道附近点
	self.tipState = TreasureTipsState.ShowPosition
	
	 
end

function Treasure:__release()
	self.ID		= nil
	self.owner	= nil
	self.guid	= nil
	self.config = nil
	self.type	= nil
	self.mapID	= nil
	self.posX	= nil
	self.posY	= nil
	self.nearPosX = nil
	self.nearPosY = nil
	self.tipState = nil
end

-- 得到和宝藏图相互联系的guid
function Treasure:getGuid()
	return self.guid
end

-- 设置和宝藏图相互联系的guid
function Treasure:setGuid(guid)
	self.guid = guid
end

-- 得到总配置
function Treasure:getConfig()
	return self.config
end

-- 得到宝藏的配置ID
function Treasure:getID()
	return self.ID
end

-- 得到宝藏所在地图
function Treasure:getMapID()
	return self.mapID
end

-- 得到宝藏的类类型
function Treasure:getType()
	return self.type
end

-- 得到宝藏的坐标
function Treasure:getPosX()
	return self.posX
end

function Treasure:getPosY()
	return self.posY
end

-- 得到宝藏附近点的坐标
function Treasure:getNearPosX()
	return self.nearPosX
end

function Treasure:getNearPosY()
	return self.nearPosY
end

-- 在客户端显示的状态
function Treasure:getTipState()
	return self.tipState
end

-- 判断人物和地图是否在同一个地图里
function Treasure:isSameMap()
	if self.mapID ~= self.owner:getScene():getMapID() then
		return false
	end
	return true
end

-- 对客户端藏宝图提示显示的设置
function Treasure:doClickChangeTipState()
	if self.tipState == TreasureTipsState.Original then
		self.tipState = TreasureTipsState.ShowPosition	
		print("显示状态",self.tipState)
	elseif self.tipState == TreasureTipsState.ShowPosition then
	end
	-- 通知客户端
	self:toNotifyUpdateClientInfo()
end

-- 根据配置随机生成宝藏所在地图属性
function Treasure:generateRandMapData()
	-- 随机地图ID
	self:doRandMapID()
end  

-- 根据传入的数据生成宝藏所在地图数据
function Treasure:setMapData(context)
	self.mapID = context.mapID
	self.posX = context.posX
	self.posX = context.posY
	self.nearPosX = context.nearPosX
	self.nearPosY = context.nearPosY
	self.tipState = context.tipState
end


function Treasure:doRandMapID()
	local MapConfig = tTreasureInMapDB[self.config.TMapID]
	local newMapTable = TreasureUtils.RandNewTableByLevelLimit(self.owner,MapConfig.MapValues)
	local tEvent = TreasureUtils.randTreasureEvent(newMapTable)
	self.mapID = tEvent.MapID
	local event = Event.getEvent(TreasureEvent_SC_MapIDInfo, self.mapID,self.guid)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

-- 随机坐标
function Treasure:doRandPosion(transferPosdDate)	
		-- 调用场景中的位置随机函数
		posX, posY = g_sceneMgr:getRandomPosition(self.mapID)
		if transferPosdDate[1] == posX and transferPosdDate[2] == posY then
			return self:setTransferPosition(transferPosdDate)
		else 
		   self.posX = posX
		   self.posY = posY
		end 
	-- 随机附近的坐标
	self:doRandNearPosition()
end

-- 随机附近的坐标
function Treasure:doRandNearPosition()
	self.nearPosX, self.nearPosY = TreasureUtils.RandNearPosition(self.mapID, self.posX, self.posY, TreasureNearPosionRange)
	self:toNotifyUpdateClientInfo()
end

-- 宝藏的图标提示
function Treasure:toNotifyUpdateClientInfo()
	local item = g_itemMgr:getItem(self.guid)
	local desc = {}
	desc.mapID = self.mapID
	desc.nearPosX = self.nearPosX
	desc.nearPosY = self.nearPosY
	print("desc.nearPosX",desc.nearPosX,desc.nearPosY)
	desc.tipState = self.tipState
	local msg = {}
	msg.guid = self.guid
	msg.gridIndex = item:getGridIndex()
	msg.desc = desc
	local changeInfo = {}
	changeInfo[item:getGridIndex()] = msg
	local event = Event.getEvent(ItemEvents_SC_UpdateInfo, item:getContainerID(), item:getPackIndex(), changeInfo)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

