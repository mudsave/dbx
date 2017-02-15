--[[PacketHandler.lua
描述：
	实体的背包handler
--]]

PacketHandler = class(nil, Timer)

function PacketHandler:__init(entity)
	self._entity = entity
	-- 背包
	self.packet = Packet(self._entity)
	-- 开启15秒的定时器，检测计时道具是否到期
	self.checkGoodsTimerID = g_timerMgr:regTimer(self, 1000*15, 1000*15, "检测背包计时道具")
	-- 做一个检测2分钟定时器
	self.doubleTimer = 0
	-- 杀气定时器
	self.killAirTimer = 0
end

function PacketHandler:__release()
	self._entity = nil
	release(self.packet)
	self.packet = nil
	-- 删除定时器
	g_timerMgr:unRegTimer(self.checkGoodsTimerID)
	self.doubleTimer = nil
	self.killAirTimer = nil
end

-- 获取背包
function PacketHandler:getPacket()
	return self.packet
end

--获取物品
function PacketHandler:getItemsByID(itemID)
	return self.packet:getItemsByID(itemID)
end

-- 定时器回调
function PacketHandler:update(timerID)
	if timerID == self.checkGoodsTimerID then
		-- 检测背包道具
		self.packet:checkItemExpire()
		-- 如果是2分钟
		self.doubleTimer = self.doubleTimer + 1
		if self.doubleTimer == 2 then
			-- 增加玩家的体力值
			local vigor = self._entity:getVigor()
			local maxVigor = self._entity:getMaxVigor()
			if vigor < maxVigor then
				vigor = vigor + 1
				self._entity:setVigor(vigor)
			end
			self.doubleTimer = 0
		end

		-- 杀气定时
		self.killAirTimer = self.killAirTimer + 1
		if self.killAirTimer == 2 then
			-- 减玩家杀气
			local killAir = self._entity:getAttrValue(player_kill)
			if killAir > 0 then
				killAir = killAir - 1
				self._entity:setAttrValue(player_kill, killAir)
			end
			self.killAirTimer = 0
		end
	end
end

-- 生成道具到背包
function PacketHandler:addItemsToPacket(itemID, itemNum)
	local itemConfig = tItemDB[itemID]
	if not itemConfig then
		-- 找不到道具配置
		return false
	end
	if itemConfig.MaxPileNum < 1 then
		-- 以防万一
		return false
	end
	local needCreateNum = 1
	if itemNum > itemConfig.MaxPileNum then
		needCreateNum = itemNum / itemConfig.MaxPileNum
		if itemNum % itemConfig.MaxPileNum > 0 then
			needCreateNum = needCreateNum + 1
		end
	end

	local itemCreateNum = 0
	for i = 1, needCreateNum do
		if itemNum >= itemConfig.MaxPileNum then
			itemNum = itemNum - itemConfig.MaxPileNum
			itemCreateNum = itemConfig.MaxPileNum
		else
			itemCreateNum = itemNum
		end
		local item = g_itemMgr:createItem(itemID, itemCreateNum)
		if item then
			local result = self.packet:addItems(item:getGuid(), true)
			if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
				if itemConfig.UseNeedLvl == -1 then
					item:setItemLvl(self._entity:getLevel())
				else 
					item:setItemLvl(itemConfig.UseNeedLvl)
				end
				-- 发个监听消息给循环任务系统
			else
				-- 添加失败，发送邮件，要么就销毁道具
				return false
			end
		end
	end
	-- 添加物品成功发个消息给任务系统
	TaskCallBack.onBuyItem(self._entity:getID(), itemID)
	return true
end

-- 获得指定ID道具的个数
function PacketHandler:getNumByItemID(itemId)
	return self.packet:getNumByItemID(itemId)
end

--[[我们游戏设定物品绑定非绑定是由配置是否交易有关，不能更改，所以这代码用不着，但保留
-- 获得指定ID未绑定道具的个数
function PacketHandler:getNoBindItemNum(itemId)
	return self.packet:getNoBindItemNum(itemId)
end

-- 获得指定ID绑定道具的个数
function PacketHandler:getBindItemNum(itemId)
	return self.packet:getBindItemNum(itemId)
end

-- 扣除指定ID道具，优先扣除绑定的，绑定的不够再扣除未绑定的
function PacketHandler:removeByItemIdEx(itemId, itemNum)
	-- 获得绑定道具数目
	local bindItemNum = self.packet:getBindItemNum(itemId)
	-- 获得未绑定道具数目
	local noBindItemNum = self.packet:getNoBindItemNum(itemId)
	if bindItemNum + noBindItemNum < itemNum then
		-- 数目不够，无法扣除
		return 0
	end
	local needRemoveItemNum = itemNum
	-- 先扣除绑定的
	if bindItemNum > 0 then
		if bindItemNum >= itemNum then
			needRemoveItemNum = 0
			self.packet:removeBindItem(itemId, itemNum)
		else
			needRemoveItemNum = itemNum - bindItemNum
			self.packet:removeBindItem(itemId, bindItemNum)
		end
	end
	-- 再扣除未绑定的
	if needRemoveItemNum > 0 then
		self.packet:removeNoBindItem(itemId, needRemoveItemNum)
	end
	return itemNum
end

-- 移除未绑定的ID的道具
function PacketHandler:removeNoBindItem(itemId, removeNum)
	self.packet:removeNoBindItem(itemId, removeNum)
end
]]

-- 添加道具到玩家背包, 这个接口在P2P交易当中，有可能这个itemGuid被销毁，先把配置ID存起来，在发送到任务系统
function PacketHandler:addItems(itemGuid)
	local item = g_itemMgr:getItem(itemGuid)
	local itemID = item:getItemID()
	local result = self.packet:addItems(itemGuid, true) 
	if result == AddItemsResult.Succeed or reslut == AddItemsResult.SucceedPile then
		TaskCallBack.onBuyItem(self._entity:getID(), itemID)
	end
end

-- 移除指定ID道具，返回移除的个数
function PacketHandler:removeByItemId(itemID, itemNum)
	return self.packet:removeByItemId(itemID, itemNum)
	
end

-- 循环任务对话移除物品接口 不会回调到任务系统的监听
function PacketHandler:removeTaskItem(itemID, itemNum)
	return self.packet:removeByItemId(itemID, itemNum)
end

-- 移除指定GUID的道具
function PacketHandler:removeItem(itemGuid, removeNum)
	return self.packet:removeItem(itemGuid, removeNum, true)
end

-- 设置指定GUID的道具锁定标志
function PacketHandler:setLockFlag(gridItem, lockFlag)
	gridItem:setLockFlag(lockFlag)
	--通知客户端,让客户端此物品枷锁
	local packIndex = gridItem:getPackIndex()
	local pack = self.packet:getPack(packIndex)
	pack:updateItemsToClient(gridItem)
end

-- 获得指定类型包裹剩余格子数
function PacketHandler:getPacketEmptyGridsNum(packType)
	local leftGridsNum = 0
	if packType == PacketPackType.Normal then
		for packIndex = PacketPackIndex.Default, PacketPackIndex.Horse do
			local pack = self.packet:getPack(packIndex)
			if pack then
				leftGridsNum = leftGridsNum + pack:getAllSpaceNum()
			end
		end
	else
		local pack = self.packet:getPack(PacketPackIndex.Task)
		if pack then
			leftGridsNum = pack:getAllSpaceNum()
		end
	end
	return leftGridsNum
end

-- 判断指定道具ID和数目能否放入背包
function PacketHandler:canAddPacket(itemID, itemNum, bindFlag)
	return self.packet:canAddPacket(itemID, itemNum, bindFlag)
end

-- 更新背包的等级包裹
function PacketHandler:updateLevelPack()
	local pack = self.packet:getPack(PacketPackIndex.Level)
	if not pack then
		local levelPack = Pack()
		levelPack:setCapability(PacketPackDefaultCapacity)
		self.packet:addPack(PacketPackIndex.Level, levelPack)
	end
end

-- 更新背包的坐骑包裹
function PacketHandler:updateHorsePack(canUse)
	if canUse then
		if self.packet:getPack(PacketPackIndex.Horse) then
			-- 已经开启了
			return
		end
		-- 开启坐骑包裹
		local horsePack = Pack()
		horsePack:setCapability(PacketPackDefaultCapacity)
		self.packet:addPack(PacketPackIndex.Horse, horsePack)
	else
		local horsePack = self.packet:getPack(PacketPackIndex.Horse)
		if not horsePack then
			-- 还未开启
			return
		end
		local packItemNum = horsePack:getPackItemNum()
		if packItemNum > 0 then
			-- 有道具存在，不能关闭坐骑包裹
			return
		end
		-- 关闭坐骑包裹
		self.packet:stopPack(PacketPackIndex.Horse)
	end
	-- 通知客户端刷新坐骑包裹
	local event = Event.getEvent(ItemEvents_CS_UpdatePack, PackContainerID.Packet, PacketPackIndex.Horse, canUse)
	g_eventMgr:fireRemoteEvent(event, self._entity)
end
