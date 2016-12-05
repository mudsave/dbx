--[[DepotHandler.lua
描述：
	实体的仓库handler
--]]

DepotHandler = class(nil, Timer)

function DepotHandler:__init(entity)
	self._entity = entity
	-- 仓库
	self.depot = Depot(self._entity)
	-- 开启15秒的定时器，检测计时道具是否到期
	self.checkGoodsTimerID = g_timerMgr:regTimer(self, 1000*15, 1000*15, "检测仓库计时道具")
end

function DepotHandler:__release()
	self._entity = nil
	release(self.depot)
	self.depot = nil
	-- 删除定时器
	g_timerMgr:unRegTimer(self.checkGoodsTimerID)
end

-- 获取仓库
function DepotHandler:getDepot()
	return self.depot
end

-- 定时器回调
function DepotHandler:update(timerID)
	if timerID == self.checkGoodsTimerID then
		-- 检测仓库道具
		self.depot:checkItemExpire()
	end
end

-- 获得仓库容量
function DepotHandler:getDepotCapability()
	local depotCapability = 0
	for packindex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
		local depotPack = self.depot:getPack(packindex)
		if depotPack then
			depotCapability = depotCapability + depotPack:getCapability()
		end
	end
	return depotCapability
end

-- 设置仓库容量
function DepotHandler:setDepotCapability(curCapability)
	local firstPack = self.depot:getPack(DepotPackIndex.First)
	local secondPack = self.depot:getPack(DepotPackIndex.Second)
	if curCapability > DepotPackCapacity then
	    firstPack:setCapability(DepotPackCapacity)
	    secondPack:setCapability(curCapability-DepotPackCapacity)
	else
	    firstPack:setCapability(curCapability)
	    secondPack:setCapability(0)
	end
end
