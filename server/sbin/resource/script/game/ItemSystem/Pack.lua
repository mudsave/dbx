--[[Pack.lua
描述:
	包裹类
]]

Pack = class()

function Pack:__init()
	-- 物品格
	self.grids = {}
	-- 容量
	self.capacity = 0
	-- 拥有者
	self.owner = nil
	-- 包裹索引
	self.packIndex = -1
	-- 所属容器ID
	self.packContainerID = -1
	-- 记录有改变的位置，用来通知客户端
	self.changeLocation = {}
	-- 记录有计时的道具位置
	self.timeItemLocation = {}
	--记录位置
	self.gridIndex = 1
end

function Pack:__release()
	for i = 1, self:getCapability() do
		local item = self.grids[i]
	    if item then
			g_itemMgr:destroyItem(self.owner,item:getGuid())
			self.grids[i] = nil
		end
		
	end
end

-- 设置包裹道具
function Pack:setGridItem(item, gridIndex)
	-- 记录所在物品格索引
	item:setGridIndex(gridIndex)
	-- 记录所属容器ID
	item:setContainerID(self.packContainerID)
	-- 记录所属包裹
	item:setPack(self)
	-- 记录道具
	self.grids[gridIndex] = item

	-- 计时道具要存一下位置信息，方便检测到期时间
	if item:getExpireTime() > 0 then
		self.timeItemLocation[item:getGuid()] = gridIndex
	end
end

-- 获得包裹道具
function Pack:getGridItem(gridIndex)
	return self.grids[gridIndex]
end

-- 获得包裹存在计时的道具
function Pack:getTimeItems()
	local tTimeItems = {}
	for itemGuid, gridIndex in pairs(self.timeItemLocation) do
		local gridItem = self.grids[gridIndex]
		if gridItem then
			if gridItem:getGuid() == itemGuid then
				-- 加入列表
				table.insert(tTimeItems, gridItem)
			else
				-- 计时道具可能已销毁，其他道具放到这里了
				self.timeItemLocation[itemGuid] = nil
			end
		else
			-- 计时道具可能已销毁
			self.timeItemLocation[itemGuid] = nil
		end
	end
	return tTimeItems
end

-- 设置包裹容量
function Pack:setCapability(capacity)
	self.capacity = capacity
end

-- 获得包裹容量
function Pack:getCapability()
	return self.capacity
end

-- 设置拥有者
function Pack:setOwner(owner)
	self.owner = owner
end

-- 获取拥有者
function Pack:getOwner()
	return self.owner
end

-- 设置包裹索引
function Pack:setPackIndex(packIndex)
	self.packIndex = packIndex
end

-- 获得包裹索引
function Pack:getPackIndex()
	return self.packIndex
end

-- 设置所属容器ID
function Pack:setPackContainerID(packContainerID)
	self.packContainerID = packContainerID
end

-- 通知客户端更新道具
function Pack:updateItemsToClient(gridItem,flag)
	if not gridItem then
		return
	end
	-- 获得道具属性现场发给客户端
	local propertyContext = gridItem:getPropertyContext()

	-- 把属性效果的Lua表序列化一下，防止浮点数精度丢失的问题
	if propertyContext.attr then
		propertyContext.attr = serialize(propertyContext.attr)
	end
	if propertyContext.suitAttr then
		propertyContext.suitAttr = serialize(propertyContext.suitAttr)
	end
	propertyContext.baseEffect = serialize(propertyContext.baseEffect)
	propertyContext.addEffect = serialize(propertyContext.addEffect)
	propertyContext.bindEffect = serialize(propertyContext.bindEffect)
	propertyContext.refiningEffect = serialize(propertyContext.refiningEffect)
	local event = Event.getEvent(ItemEvents_SC_CreateItem, gridItem:getGuid(), propertyContext,flag)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

-- 记录改变位置
function Pack:setChange(gridIndex,flag)
	if gridIndex < 1 or gridIndex > self:getCapability() then
		return
	end
	local marks
	if flag then
		marks = true
	else
		marks = false
	end
	local gridItem = self.grids[gridIndex]
	if gridItem then
		-- 通知客户端创建道具
		self:updateItemsToClient(gridItem,marks)
	end

	self.changeLocation[gridIndex] = gridIndex
end

-- 发送更新到客户端
function Pack:updateClient()
	local changeInfo = {}
	-- 填充具体的道具更新信息
	for _, gridIndex in pairs(self.changeLocation) do
		if gridIndex >= 1 and gridIndex <= self:getCapability() then
			local item = self.grids[gridIndex]
			changeInfo[gridIndex] = {}
			if item then
				changeInfo[gridIndex].guid = item:getGuid()
				changeInfo[gridIndex].gridIndex = gridIndex
			else
				changeInfo[gridIndex].gridIndex = gridIndex
			end
		end
	end
	if table.size(changeInfo) > 0 then
		local event = Event.getEvent(ItemEvents_SC_UpdateInfo, self.packContainerID, self.packIndex, changeInfo)
		g_eventMgr:fireRemoteEvent(event, self.owner)
	end

	-- 清除改变位置表
	self.changeLocation = {}
end

-- 获得背包第一个空格的位置，如果itemConfig不为空，表示找可以叠加的位置，并返回可以叠加上去的数目
function Pack:getFirstSpace(itemConfig)
	for i = 1, self:getCapability() do
		local item = self.grids[i]
		if (not item and not itemConfig) then
			return i
		elseif (item and itemConfig) then
			if item:getItemID() == itemConfig.ID then
				if item:getNumber() < itemConfig.MaxPileNum then
					return i, itemConfig.MaxPileNum-item:getNumber()
				end
			end
		end
	end
	return -1
end

-- 获得本包裹道具数目，其实是占用格子数
function Pack:getPackItemNum()
	local itemNum = 0

	for i = 1, self:getCapability() do
		local item = self.grids[i]
		if item then
			itemNum = itemNum + 1
		end
	end
	return itemNum
end

-- 获得本包裹所有空格数
function Pack:getAllSpaceNum()
	local spaceNum = 0

	for i = 1, self:getCapability() do
		local item = self.grids[i]
		if not item then
			spaceNum = spaceNum + 1
		end
	end

	return spaceNum
end

-- 获得本包裹指定道具可以叠加上去的数目
function Pack:getCanPileNum(itemID)
	local totalCanPileNum = 0
	local curCanPileNum = 0

	for i = 1, self:getCapability() do
		local item = self.grids[i]
		if item and item:getItemID() == itemID then
			curCanPileNum = item:getPileNum() - item:getNumber()
			if curCanPileNum > 0 then
				totalCanPileNum = totalCanPileNum + curCanPileNum
			end
		end
	end

	return totalCanPileNum
end

-- 获得本包裹可以叠加的指定道具所在位置
function Pack:getCanPileItemPos(itemID)
	for i = 1, self:getCapability() do
		local item = self.grids[i]
		if item and item:getItemID() == itemID then
			local curCanPileNum = item:getPileNum() - item:getNumber()
			if curCanPileNum > 0 then
				return i
			end
		end
	end
	return -1
end

-- 添加道具到包裹指定物品格
function Pack:addItemsToGrid(item, gridIndex, bUpdateClient)
	if gridIndex < 1 or gridIndex > self:getCapability() then
		return false
	end

	local gridItem = self.grids[gridIndex]
	if not gridItem then
		-- 记录道具
		self:setGridItem(item, gridIndex)
	else
		-- 此物品格已经有道具了
		return false
	end

	-- 记录到改变表
	self:setChange(gridIndex,true)
	-- 通知客户端
	if bUpdateClient then
		self:updateClient()
	end

	return true
end

-- 从包裹指定物品格移除道具，并不销毁道具
function Pack:removeItemsFromGrid(gridIndex, bUpdateClient)
	if gridIndex < 1 or gridIndex > self:getCapability() then
		return false
	end

	local gridItem = self.grids[gridIndex]
	if gridItem then
		self.grids[gridIndex] = nil
	else
		-- 此物品格没有道具
		return false
	end

	-- 记录到改变表
	self:setChange(gridIndex)
	-- 通知客户端
	if bUpdateClient then
		self:updateClient()
	end

	return true
end

-- 叠加道具到包裹指定物品格
function Pack:pileItemsToGrid(srcItem, dstGridIndex)
	if dstGridIndex < 1 or dstGridIndex > self:getCapability() then
		return false
	end

	local gridItem = self.grids[dstGridIndex]
	if gridItem then
		if gridItem:getItemID() ~= srcItem:getItemID() then
			-- ID不同，不能叠加
			return false
		end
		local maxPileNum = gridItem:getPileNum()
		if maxPileNum > 1 then
			local totalNum = gridItem:getNumber() + srcItem:getNumber()
			-- 判断是否可以叠加
			if totalNum <= maxPileNum then
				-- 设置叠加后的道具数目
				gridItem:setNumber(totalNum)
				-- 记录到改变表
				self:setChange(dstGridIndex)
				-- 通知客户端
				self:updateClient()
			else
				-- 大于最大叠加数，只能交换
				return false
			end
		else
			-- 最大数目是1，不可叠加
			return false
		end
	else
		-- 逻辑错误
		return false
	end

	return true
end

-- 叠加道具到包裹指定物品格，注意这里是能叠加多少就叠加多少
function Pack:pileItemsToGridEx(srcItem, dstGridIndex)
	if dstGridIndex < 1 or dstGridIndex > self:getCapability() then
		return false
	end

	local gridItem = self.grids[dstGridIndex]
	if gridItem then
		if gridItem:getItemID() ~= srcItem:getItemID() then
			-- ID不同，不能叠加
			return false
		end
		local maxPileNum = gridItem:getPileNum()
		if maxPileNum > 1 then
			local itemNum = gridItem:getNumber()
			local spareNum = maxPileNum - itemNum
			-- 判断是否可以叠加
			if spareNum > 0 then
				local srcGridIndex = srcItem:getGridIndex()
				local srcItemNum = srcItem:getNumber()
				if spareNum >= srcItemNum then
					-- 源道具全部叠加了，可以销毁了
					self.grids[srcGridIndex] = nil
					g_itemMgr:destroyItem(self.owner,srcItem:getGuid())
					-- 设置叠加后的道具数目
					gridItem:setNumber(itemNum+srcItemNum)
				else
					-- 源道具叠加了一部分数目
					srcItem:setNumber(srcItemNum-spareNum)
					-- 设置叠加后的道具数目
					gridItem:setNumber(itemNum+spareNum)
				end
				-- 记录到改变表
				self:setChange(srcGridIndex)
				-- 记录到改变表
				self:setChange(dstGridIndex)
			else
				-- 不能叠加
				return false
			end
		else
			-- 最大数目是1，不可叠加
			return false
		end
	else
		-- 逻辑错误
		return false
	end

	return true
end

-- 添加道具
function Pack:addItems(item, bUpdateClient)
	local itemID = item:getItemID()
	local itemConfig = tItemDB[itemID]
	if not itemConfig then
		-- 找不到道具配置
		return AddItemsResult.SrcInvalid
	end

	-- 优先通过叠加放入道具
	if itemConfig.MaxPileNum > 1 then
		for i = 1, self:getCapability() do
			local gridItem = self.grids[i]
			if gridItem and gridItem:getItemID() == itemID then
				local totalNumber = gridItem:getNumber() + item:getNumber()
				if totalNumber <= itemConfig.MaxPileNum then
					-- 设置叠加后的道具数目
					gridItem:setNumber(totalNumber)
					-- 记录到改变表
					self:setChange(i)
					-- 通知客户端
					if bUpdateClient then
						self:updateClient()
					end
					-- 道具叠加成功
					return AddItemsResult.SucceedPile
				end
			end
		end

		-- 暂时不处理通过多个叠加可以放下的情况
	end
	-- 叠加不可行，查找空位，整体放入
	local gridIndex = self:getFirstSpace()
	if gridIndex ~= -1 then
		-- 可以整体放入
		self:setGridItem(item, gridIndex)
		-- 记录到改变表
		self:setChange(gridIndex)
		-- 通知客户端
		if bUpdateClient then
			self:updateClient()
		end
		-- 道具添加成功
		return AddItemsResult.Succeed
	else
		-- 包裹已满
		return AddItemsResult.Full
	end
end

-- 添加指定个数的道具
function Pack:addItemsLimitNums(item, addNum, bUpdateClient)
	local itemID = item:getItemID()
	local itemConfig = tItemDB[itemID]
	if not itemConfig then
		-- 找不到道具配置
		return AddItemsResult.SrcInvalid
	end

	-- 尽可能通过叠加放入道具
	if itemConfig.MaxPileNum > 1 then
		for i = 1, self:getCapability() do
			local gridItem = self.grids[i]
			if gridItem and gridItem:getItemID() == itemID then
				local leftPileNum = itemConfig.MaxPileNum - gridItem:getNumber()
				if leftPileNum > 0 then
					if addNum <= leftPileNum then
						-- 设置叠加后的道具数目
						gridItem:setNumber(gridItem:getNumber() + addNum)
						-- 记录到改变表
						self:setChange(i)
						-- 通知客户端
						if bUpdateClient then
							self:updateClient()
						end
						-- 道具叠加成功
						return AddItemsResult.SucceedPile
					else
						-- 只能叠加一部分
						gridItem:setNumber(itemConfig.MaxPileNum)
						-- 剩余数目继续找叠加
						addNum = addNum - leftPileNum
						-- 记录到改变表
						self:setChange(i)
						-- 通知客户端
						if bUpdateClient then
							self:updateClient()
						end
					end
				end
			end
		end
	end

	-- 叠加不可行，继续查找空位，整体放入
	local gridIndex = self:getFirstSpace()
	if gridIndex ~= -1 then
		if addNum == item:getNumber() then
			-- 本包裹就可以放下这个道具，不用分拆来放
			self:setGridItem(item, gridIndex)
			-- 记录到改变表
			self:setChange(gridIndex)
			-- 通知客户端
			if bUpdateClient then
				self:updateClient()
			end
			-- 道具添加成功
			return AddItemsResult.Succeed
		else
			-- 本包裹只是放一部分，需要重新创建新的道具
			local newItem = g_itemMgr:createItemFromContext(item:getPropertyContext(), addNum)
			if not newItem then
				return AddItemsResult.Failed
			end
			-- 记录新的道具，这里并不立即销毁源道具，因为其他放部分数目的包裹还要用，等都放入好了，由调用者根据返回值来销毁源道具
			self:setGridItem(newItem, gridIndex)
			-- 记录到改变表
			self:setChange(gridIndex)
			-- 通知客户端
			if bUpdateClient then
				self:updateClient()
			end
			-- 道具叠加成功
			return AddItemsResult.SucceedPile
		end
	else
		return AddItemsResult.Full	
	end
end

-- 判断本包裹可以放入的道具数目，注意：这里并不一定返回可以放入的绝对最大数，只要能装得下就直接返回可以装下的数目
function Pack:canAddNumber(item)
	local itemID = item:getItemID()
	local itemNum = item:getNumber()
	local itemConfig = tItemDB[itemID]
	if not itemConfig then
		-- 找不到道具配置
		return 0
	end
	local maxPileNum = itemConfig.MaxPileNum
	local canAddNumber = 0
	local curCanPileNum = 0
	for i = 1, self:getCapability() do
		local gridItem = self.grids[i]
		if not gridItem then
			-- 空格直接按最大叠加数来计算
			canAddNumber = canAddNumber + maxPileNum
		elseif gridItem and gridItem:getItemID() == itemID then
			curCanPileNum = maxPileNum - gridItem:getNumber()
			if curCanPileNum > 0 then
				-- 加上可以叠加的数目
				canAddNumber = canAddNumber + curCanPileNum
			end
		end
		if canAddNumber >= itemNum then
			-- 已经可以装下了，不用继续找下去了，直接返回
			return canAddNumber
		end
	end
	-- 执行到这里，说明本包裹装不下，返回可以装的最大数目
	return canAddNumber
end

-- 移除道具
function Pack:removeItem(item, removeNum, bUpdateClient)
	local nResult = RemoveItemsResult.Failed

	-- 判断移除数目
	if 0 == removeNum then
		removeNum = item:getNumber()
	end
	if removeNum > item:getNumber() then
		-- 数量非法
		nResult = RemoveItemsResult.NumInvalid
		return nResult
	end

	local gridIndex = item:getGridIndex()
	local gridItem = self.grids[gridIndex]
	if gridItem == item then
		local gridItemNum = gridItem:getNumber()
		if gridItemNum > removeNum then
			-- 扣除需要移除的数目
			gridItem:setNumber(gridItemNum-removeNum)
			-- 移除道具成功
			nResult = RemoveItemsResult.Succeed
		else
			-- 整个道具移除
			self.grids[gridIndex] = nil
			-- 移除道具成功，源道具需要销毁
			nResult = RemoveItemsResult.SucceedClean
		end
		-- 记录到改变表
		self:setChange(gridIndex)
		if bUpdateClient then
			-- 通知客户端
			self:updateClient()
		end
	end

	return nResult
end

--销毁指定格的道具
function Pack:destroyItem(owner,gridIndex, bUpdateClient)
	if gridIndex < 1 or gridIndex > self:getCapability() then
		return false
	end

	local gridItem = self.grids[gridIndex]
	if gridItem then
		self.grids[gridIndex] = nil
		--从购回界面删除销毁的物品信息
		g_tradeMgr:setBuyBackInfoNIL(gridItem:getGuid())
		--加到销毁列表中
		g_itemMgr:destroyItem(self.owner,gridItem:getGuid())
	else
		-- 此物品格没有道具
		return false
	end

	-- 记录到改变表
	self:setChange(gridIndex)
	-- 通知客户端
	if bUpdateClient then
		self:updateClient()
	end

	return true
end

-- 获得指定ID道具的个数
function Pack:getNumByItemID(itemId)
	local itemNum = 0

	for i = 1, self:getCapability() do
		local gridItem = self.grids[i]
		if gridItem and gridItem:getItemID() == itemId then
			itemNum = itemNum + gridItem:getNumber()
		end
	end

	return itemNum
end

-- 移除指定ID道具，返回移除的个数
function Pack:removeByItemId(itemId, itemNum)
	local removeNum = 0
	local needRemoveNum = itemNum

	for i = 1, self:getCapability() do
		local gridItem = self.grids[i]
		if gridItem and gridItem:getItemID() == itemId then
			local result = RemoveItemsResult.Failed
			local gridItemNum = gridItem:getNumber()
			if needRemoveNum > gridItemNum then
				result = self:removeItem(gridItem, gridItemNum, true)
				if result == RemoveItemsResult.Succeed or result == RemoveItemsResult.SucceedClean then
					removeNum = removeNum + gridItemNum
					needRemoveNum = needRemoveNum - gridItemNum
				end
			else
				result = self:removeItem(gridItem, needRemoveNum, true)
				if result == RemoveItemsResult.Succeed or result == RemoveItemsResult.SucceedClean then
					removeNum = removeNum + needRemoveNum
					needRemoveNum = 0
				end
			end
			if result == RemoveItemsResult.SucceedClean then
				-- 销毁源道具，不可用了
				g_itemMgr:destroyItem(self.owner,gridItem:getGuid())
			end
			if needRemoveNum <= 0 or removeNum >= itemNum then
				-- 已经移除够指定数目了
				return removeNum
			end
		end
	end

	return removeNum
end

-- 更新指定位置的道具数据
function Pack:updateItem(gridIndex, itemID, itemNum)
	local gridItem = self.grids[gridIndex]
	if gridItem then
		if gridItem:getItemID() == itemID then
			if itemNum > 0 and gridItem:getNumber() ~= itemNum then
				-- 设置道具新的数目
				gridItem:setNumber(itemNum)
				-- 记录到改变表
				self:setChange(gridIndex)
			end
		end
	end
end

-- 查找优先级比当前道具优先级低的格子，如果有空格就直接返回空格位置
function Pack:getLowerPriorityItemPos(srcItem)
	local srcItemSortPriority = srcItem:getSortPriority()
	local srcQuality = srcItem:getQuality()
	-- 查找范围在本道具之前
	local gridIndex = srcItem:getGridIndex() - 1
	if gridIndex >= 1 and gridIndex <= self:getCapability() then
		for i = 1, gridIndex do
			local gridItem = self.grids[i]
			if gridItem then
				local curSortPriority = gridItem:getSortPriority()
				if curSortPriority > srcItemSortPriority then
					-- 优先级小于源道具
					return i
				elseif curSortPriority == srcItemSortPriority then
					-- 优先级相等，判断物品品质
					local curQuality = gridItem:getQuality()
					if curQuality < srcQuality then
						return i
					elseif curQuality == srcQuality then
						-- 物品价值相等，判断物品使用等级
						if gridItem:getUseNeedLvl() < srcItem:getUseNeedLvl() then
							return i
						elseif gridItem:getUseNeedLvl() == srcItem:getUseNeedLvl() then 
							-- 物品使用等级相等，判断ID
							if gridItem:getItemID() > srcItem:getItemID() then 
								return i
							end 
						end
					end
				end
			else
				-- 如果是空格的话，就直接放过去
				return i
			end
		end
	end
	return -1
end

-- 交换道具，注意：这里是同一个包裹里交换道具
function Pack:swapItem(srcGridItem, dstGridItem)
	if not srcGridItem or not dstGridItem then
		return false
	end
	local srcGridIndex = srcGridItem:getGridIndex()
	local dstGridIndex = dstGridItem:getGridIndex()
	if srcGridIndex == dstGridIndex then
		return false
	end
	local capacity = self:getCapability()
	if srcGridIndex < 1 or srcGridIndex > capacity then
		return false
	end
	if dstGridIndex < 1 or dstGridIndex > capacity then
		return false
	end

	-- 记录新道具
	self:setGridItem(srcGridItem, dstGridIndex)
	self:setGridItem(dstGridItem, srcGridIndex)
	-- 记录到改变表
	self:setChange(srcGridIndex)
	self:setChange(dstGridIndex)

	return true
end

-- 整理包裹
function Pack:packUp()
	local capacity = self:getCapability()
	-- 首先处理叠加
	for gridIndex = capacity, 1, -1 do
		-- 倒过来执行，后面的道具叠加到前面的道具上
		local gridItem = self.grids[gridIndex]
		if gridItem then
			-- 得到最大叠加数目
			local maxPileNum = gridItem:getPileNum()
			if maxPileNum > 1 then
				-- 需要叠加
				local itemNum = gridItem:getNumber()
				local whileNum = 0
				while gridItem do
					whileNum = whileNum + 1
					if whileNum > itemNum then
						-- 防止死循环
						break
					end
					-- 找到可以叠加的第一个道具位置
					local pileItemGridIndex = self:getCanPileItemPos(gridItem:getItemID())
					-- 检测找到的位置是不是在本道具前面的
					if pileItemGridIndex >= 1 and pileItemGridIndex < gridIndex then
						-- 开始叠加，注意这里可能会销毁源道具
						if not self:pileItemsToGridEx(gridItem, pileItemGridIndex) then
							-- 逻辑错误
							break
						end
						-- 重新得到本道具，如果还在，说明还可以继续处理
						gridItem = self.grids[gridIndex]
						if not gridItem then
							-- 本道具全叠上去了，继续处理下一个
							break
						end
					else
						-- 没有可以叠加的
						break
					end
				end
			end
		end
	end
	-- 然后处理排序
	for gridIndex = capacity, 1, -1 do
		-- 倒过来执行，优先级高的道具就往前放
		local gridItem = self.grids[gridIndex]
		if gridItem then
			local whileNum = 0
			while gridItem do
				whileNum = whileNum + 1
				if whileNum > capacity then
					-- 防止死循环
					break
				end
				local lowerPriorityGridIndex = self:getLowerPriorityItemPos(gridItem)
				if lowerPriorityGridIndex >= 1 then
					local dstGridItem = self.grids[lowerPriorityGridIndex]
					if dstGridItem then
						-- 存在道具，跟本道具进行交换
						if not self:swapItem(gridItem, dstGridItem) then
							-- 逻辑错误
							break
						end
					else
						-- 目标位置没有道具
						if self:removeItemsFromGrid(gridItem:getGridIndex(), false) then
							-- 先从源位置移除，然后移动道具过去
							self:addItemsToGrid(gridItem, lowerPriorityGridIndex, false)
						else
							-- 逻辑错误
							break
						end
					end
					-- 重新得到当前索引的道具，如果还在，说明还可以继续处理
					gridItem = self.grids[gridIndex]
				else
					-- 没有优先级比当前道具还低的道具了
					break
				end
			end
		end
	end
end

--针对Npc货架包裹满呢,移除之后重新排列
function Pack:packUpdate(bUpdateClient)
	for i = 1, ShelfMaxCapacity do 
		local item = self.grids[i]
		if item == nil then
			local item1 = self.grids[i+1]
			if not item1 then 
				self.grids[i] = nil
			else
				self:setGridItem(item1, i)
				self.grids[i+1] = nil
			end
			self:setChange(i)
			-- 通知客户端
		end
	end
	if bUpdateClient then
		self:updateClient()
	end
end

--玩家出售物品时货架物品的添加
function Pack:addItemsToShelf(item, addNum, bUpdateClient)
	-- 查找空位，整体放入
	local itemID = item:getItemID()
	local gridIndex = self:getFirstSpace()
	if gridIndex ~= -1 then
		if addNum == item:getNumber() then
			-- 本包裹就可以放下这个道具，不用分拆来放
			self:setGridItem(item, gridIndex)
			-- 记录到改变表
			self:setChange(gridIndex)
			-- 通知客户端
			if bUpdateClient then
				self:updateClient()
			end
			-- 道具添加成功
			return AddItemsResult.Succeed
		else
			-- 本包裹只是放一部分，需要重新创建新的道具
			local newItem = g_itemMgr:createItem(itemID, addNum)
			if not newItem then
				return AddItemsResult.Failed
			end
			-- 记录新的道具，这里并不立即销毁源道具，因为其他放部分数目的包裹还要用，等都放入好了，由调用者根据返回值来销毁源道具
			self:setGridItem(newItem, gridIndex)
			-- 记录到改变表
			self:setChange(gridIndex)
			-- 通知客户端
			if bUpdateClient then
				self:updateClient()
			end
			-- 道具叠加成功
			return AddItemsResult.SucceedPile
		end
	else
		if self.packContainerID == PackContainerID.Shelf then 
			--这是获取之前的回购货架上的物品把他给销毁
			local itemPrevious = self.grids[1]
			local itemNum = itemPrevious:getNumber()
			self:destroyItem(self.owner,self.gridIndex, true)
			--向前移动一个
			self:packUpdate(bUpdateClient)
			self:setGridItem(item, ShelfMaxCapacity)
			self:setChange(ShelfMaxCapacity)
			self:updateClient()
			return AddItemsResult.Succeed
		end
	end
end