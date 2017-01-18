--[[Trade.lua
描述:
	p2p玩家交易只是记录交易包裹，不会改变物品
]]

Trade = class()

function Trade:__init(capacity)
	-- 物品格根据各自索引来存物品GUID和数目
	self.grids = {}
	-- 容量
	self.capacity = capacity
end

function Trade:__release()
	for i = 1, self:getCapability() do
		self.grids[i] = nil
	end
end

--获取包裹的容量
function Trade:getCapability()
	return self.capacity
end

function Trade:getFirstSpace()
	for i = 1, self.capacity do
		local gridItem = self.grids[i]
		if not gridItem then
			return i
		end
	end
	return -1
end

-- 增加道具指定的数量到指定包裹
function Trade:addNumberItemsToPack(itemGuid, count)
	local item =g_itemMgr:getItem(itemGuid)
	local itemID = item:getItemID()
	local itemConfig = tItemDB[itemID]
	if not itemConfig then
		-- 找不到道具配置
		return AddItemsResult.SrcInvalid
	end

	-- 叠加不可行，查找空位，整体放入
	local gridIndex = self:getFirstSpace()
	if gridIndex ~= -1 then
		-- 可以整体放入
		self.grids[gridIndex] = {}
		self.grids[gridIndex].guid = itemGuid
		self.grids[gridIndex].itemNum = count
		-- 道具添加成功
		return AddItemsResult.Succeed, gridIndex
	else
		-- 包裹已满
		return AddItemsResult.Full
	end
end

--根据指定的个子找到物品的个数
function Trade:getItemNumber(gridIndex)
	if self.grids[gridIndex] then
		return self.grids[gridIndex].itemNum
	else
		return -1
	end
end

function Trade:getTradeItem()
	return self.grids
end

--指定物品格移除物品的个数
function Trade:removeItem(slotIndex, itemNum)
	--找到指定格子当中物品的个数
	local itemInfo = self.grids[slotIndex]
	if itemInfo then
		--移除的个数和存在的个数相同
		if itemInfo.itemNum == itemNum then
			--全部移除
			self.grids[slotIndex] = nil
		else
			--数量减少
			self.grids[slotIndex].itemNum = self.grids[slotIndex].itemNum - itemNum
		end
	end
end

--获取物品所占格子的个数
function Trade:getTradeItemNum()
	local itemNum = 0
	for i = 1, self:getCapability() do
		local itemInfo = self.grids[i]
		if itemInfo then
			itemNum = itemNum + 1
		end
	end
	return itemNum
end