--[[Packet.lua
描述：
	背包
]]

Packet = class()

function Packet:__init(owner)
	-- 拥有者
	self.owner = owner;
	-- 所有包裹
	self.packs = {}
	-- 初始化包裹
	self:initPack()
end

function Packet:__release()
	for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			release(self.packs[packIndex])
			self.packs[packIndex] = nil
		end
	end
end

-- 检测计时道具是否到期
function Packet:checkItemExpire()
	for packindex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		-- 获得包裹
		local pack = self:getPack(packindex)
		if pack then
			-- 获得包裹存在计时的道具
			local tTimeItems = pack:getTimeItems()
			for i = 1, table.getn(tTimeItems) do
				local gridItem = tTimeItems[i]
				if gridItem then
					if os.time() >= gridItem:getExpireTime() then
						-- 删除道具
						local result = self:removeItem(gridItem:getGuid(), 0, true)
						if result == RemoveItemsResult.SucceedClean then
							-- 提示客户端道具过期，已删除
						end
					end
				end
			end
		end
	end
end

-- 获得容器ID
function Packet:getContainerID()
	return PackContainerID.Packet
end

-- 通知客户端道具数据
function Packet:updateItemToClient()
	for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			self.packs[packIndex]:updateClient()
		end
	end
end

-- 添加包裹
function Packet:addPack(packIndex, pack)
	if instanceof(pack, Pack) then
		if self.packs[packIndex] then
			-- 已经存在
			return false
		else
			pack:setOwner(self.owner)
			pack:setPackIndex(packIndex)
			pack:setPackContainerID(PackContainerID.Packet)
			self.packs[packIndex] = pack
			return true
		end
	end
	return false
end

-- 关闭包裹
function Packet:stopPack(packIndex)
	local pack = self:getPack(packIndex)
	if not pack then
		-- 包裹未开启
		return
	end
	release(self.packs[packIndex])
	self.packs[packIndex] = nil
end

-- 获得包裹
function Packet:getPack(packIndex)
	return self.packs[packIndex]
end

-- 初始化包裹
function Packet:initPack()
	-- 默认包裹
	local defaultPack = Pack()
	defaultPack:setCapability(PacketPackDefaultCapacity)
	defaultPack:setPackContainerID(PackContainerID.Packet)
	self:addPack(PacketPackIndex.Default, defaultPack)

	-- 任务包裹
	local taskPack = Pack()
	taskPack:setCapability(PacketPackDefaultCapacity)
	self:addPack(PacketPackIndex.Task, taskPack)
end

-- 得到包裹空格索引
function Packet:getSpaceIndex(item)
	local itemConfig = tItemDB[item:getItemID()]
	if not itemConfig then
		-- 找不到道具配置
		return false, -1, -1
	end

	if itemConfig.SubClass == ItemSubClass.Task then
		-- 去任务包裹里去找
		local gridIndex = self.packs[PacketPackIndex.Task]:getFirstSpace()
		if gridIndex > 0 then
			return true, PacketPackIndex.Task, gridIndex
		end
	else
		-- 先在本道具所在的包裹里查找
		local packIndex = item:getPackIndex()
		if self.packs[packIndex] then
			local gridIndex = self.packs[packIndex]:getFirstSpace()
			if gridIndex > 0 then
				return true, packIndex, gridIndex
			end
		end
		-- 再在其他包裹里查找
		for packIndex = PacketPackIndex.Default, PacketPackIndex.Horse do
			if self.packs[packIndex] then
				local gridIndex = self.packs[packIndex]:getFirstSpace()
				if gridIndex > 0 then
					return true, packIndex, gridIndex
				end
			end
		end
	end

	return false, -1, -1
end

-- 获得指定位置的道具
function Packet:getItems(packIndex, gridIndex)
	if packIndex < PacketPackIndex.Default or packIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return -1, nil
	end

	if self.packs[packIndex] then
		if gridIndex >= 1 and gridIndex <= self.packs[packIndex]:getCapability() then
			return 0, self.packs[packIndex]:getGridItem(gridIndex)
		end
	end
	-- 逻辑错误
	return -1, nil
end

-- 获得指定ID的道具列表
function Packet:getItemsByID(itemID)
	local itemList = {}
	for packindex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		-- 获得包裹
		local pack = self:getPack(packindex)
		if pack then
			-- 获得包裹道具
			for gridIndex = 1, pack:getCapability() do
				local item = pack:getGridItem(gridIndex)
				if item and item:getItemID() == itemID then
					table.insert(itemList,item)
				end
			end
		end
	end 
	return itemList
end

-- 添加道具
function Packet:addItems(itemGuid, bUpdateClient)
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return AddItemsResult.SrcInvalid
	end
	local itemConfig = tItemDB[item:getItemID()]
	if not itemConfig then
		-- 找不到道具配置
		return AddItemsResult.SrcInvalid
	end

	-- 判断是否需要放任务背包
	if itemConfig.SubClass == ItemSubClass.Task then
		local result = self.packs[PacketPackIndex.Task]:addItems(item, bUpdateClient)
		if result == AddItemsResult.SucceedPile then
			-- 销毁源道具，不可用了
			g_itemMgr:destroyItem(itemGuid)
		end
		return result
	else
		local canAdd, tAddPacks = self:canAddItems(item)
		if canAdd then
			local result = AddItemsResult.Succeed
			for i = 1, #tAddPacks do
				local packIndex = tAddPacks[i][1]
				local addNum = tAddPacks[i][2]
				result = self.packs[packIndex]:addItemsLimitNums(item, addNum, bUpdateClient)
				if result ~= AddItemsResult.Succeed and result ~= AddItemsResult.SucceedPile then
					-- 正常情况不会出现这种结果，因为前面已经判断可以添加成功了
					return result
				end
			end
			-- 如果源道具分拆放入多个包裹或者同一个包裹叠加存放，就要销毁源道具
			if #tAddPacks > 1 or result == AddItemsResult.SucceedPile then
				-- 销毁源道具，不可用了
				g_itemMgr:destroyItem(itemGuid)
				return AddItemsResult.SucceedPile
			else
				return AddItemsResult.Succeed
			end
		else
			-- 放不下
			return AddItemsResult.Full
		end
	end
end

-- 判断可否放入包裹，注意：这里是除了任务包裹、扩展包裹的其他包裹
function Packet:canAddItems(item)
	local canAdd = false
	local tAddPacks = {}
	local needAddNumber = item:getNumber()
	local canAddNumber = 0

	for packIndex = PacketPackIndex.Default, PacketPackIndex.Horse do
		if self.packs[packIndex] then
			-- 当前包裹可以放入的数目
			local curAddNumber = self.packs[packIndex]:canAddNumber(item)
			if curAddNumber > 0 then
				-- 记录当前已经可以放入的道具数目
				canAddNumber = canAddNumber + curAddNumber
				if needAddNumber - canAddNumber <= 0 then
					-- 记录下当前包裹索引和当前包裹可以放入的道具数目，这里只记录满足放入的数目
					table.insert(tAddPacks, {packIndex, needAddNumber})
					-- 已经可以放下了
					canAdd = true
					break
				else
					-- 记录下当前包裹索引和当前包裹可以放入的道具数目
					table.insert(tAddPacks, {packIndex, curAddNumber})
					-- 计算还需要放入的数目
					needAddNumber = needAddNumber - canAddNumber
				end
			end
		end
	end

	return canAdd, tAddPacks
end

-- 移除道具
function Packet:removeItem(itemGuid, removeNum, bUpdateClient)
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return RemoveItemsResult.SrcInvalid
	end

	-- 获得道具所在的包裹索引
	local packIndex = item:getPackIndex()
	if packIndex < PacketPackIndex.Default or packIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return RemoveItemsResult.Failed
	end

	local result = self.packs[packIndex]:removeItem(item, removeNum, bUpdateClient)
	if result == RemoveItemsResult.SucceedClean then
		-- 销毁源道具，不可用了
		g_itemMgr:destroyItem(itemGuid)
	end
	local itemID = item:getItemID()
	TaskCallBack.onRemoveItem(self.owner:getID(), itemID)
	return result
end

-- 增加道具到指定包裹
function Packet:addItemsToPack(srcItem, dstPackIndex)
	if dstPackIndex < PacketPackIndex.Default or dstPackIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return AddItemsResult.LocInvalid
	end

	-- 判断是否是任务道具
	if srcItem:isTaskItem() then
		if dstPackIndex ~= PacketPackIndex.Task then
			-- 任务道具只能放任务包裹
			return AddItemsResult.LocInvalid
		end
	else
		if dstPackIndex == PacketPackIndex.Task then
			-- 非任务道具不能放任务包裹
			return AddItemsResult.LocInvalid
		end
	end

	if self.packs[dstPackIndex] then
		local result = self.packs[dstPackIndex]:addItems(srcItem, true)
		if result == AddItemsResult.SucceedPile then
			-- 销毁源道具，不可用了
			g_itemMgr:destroyItem(srcItem:getGuid())
		end

		return result
	else
		-- 包裹还未开启
		return AddItemsResult.LocInvalid
	end
end

--添加指定数量的物品到包裹
function Packet:addNumberItemsToPack(srcItem, dstPackIndex, itemNum)
	if dstPackIndex ~= PacketPackIndex.Default then
		-- 逻辑错误
		return false
	end
	return self.packs[dstPackIndex]:addItemsLimitNums(srcItem, itemNum, true)
end

-- 添加道具到指定物品格
function Packet:addItemsToGrid(item, packIndex, gridIndex, bUpdateClient)
	if packIndex < PacketPackIndex.Default or packIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	-- 判断是否是任务道具
	if item:isTaskItem() then
		if packIndex ~= PacketPackIndex.Task then
			-- 任务道具只能放任务包裹
			return false
		end
	else
		if packIndex == PacketPackIndex.Task then
			-- 非任务道具不能放任务包裹
			return false
		end
	end

	if self.packs[packIndex] then
		return self.packs[packIndex]:addItemsToGrid(item, gridIndex, bUpdateClient)
	else
		-- 包裹还未开启
		return false
	end
end

-- 从指定物品格移除道具，并不销毁道具
function Packet:removeItemsFromGrid(packIndex, gridIndex, bUpdateClient)
	if packIndex < PacketPackIndex.Default or packIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	if self.packs[packIndex] then
		return self.packs[packIndex]:removeItemsFromGrid(gridIndex, bUpdateClient)
	else
		-- 包裹还未开启
		return false
	end
end

-- 叠加道具到指定物品格
function Packet:pileItemsToGrid(srcItem, dstPackIndex, dstGridIndex)
	if dstPackIndex < PacketPackIndex.Default or dstPackIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	if self.packs[dstPackIndex] then
		return self.packs[dstPackIndex]:pileItemsToGrid(srcItem, dstGridIndex)
	else
		-- 包裹还未开启
		return false
	end
end

-- 叠加道具到包裹指定物品格，注意这里是能叠加多少就叠加多少
function Packet:pileItemsToGridEx(srcItem, dstPackIndex, dstGridIndex)
	if dstPackIndex < PacketPackIndex.Default or dstPackIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	if self.packs[dstPackIndex] then
		return self.packs[dstPackIndex]:pileItemsToGridEx(srcItem, dstGridIndex)
	else
		-- 包裹还未开启
		return false
	end
end

-- 获得指定ID道具的个数
function Packet:getNumByItemID(itemId)
	local itemConfig = tItemDB[itemId]
	if not itemConfig then
		-- 找不到道具配置
		return 0
	end

	local itemNum = 0
	if itemConfig.SubClass == ItemSubClass.Task then
		-- 在任务包裹里找
		itemNum = self.packs[PacketPackIndex.Task]:getNumByItemID(itemId)
	else
		for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
			if packIndex ~= PacketPackIndex.Task then
				if self.packs[packIndex] then
					itemNum = itemNum + self.packs[packIndex]:getNumByItemID(itemId)
				end
			end
		end
	end

	return itemNum
end

--[[我们游戏设定物品绑定非绑定是由配置是否交易有关，不能更改，所以这代码用不着，但保留
--获得指定ID的绑定道具的个数
function Packet:getBindItemNum(itemId)
	local itemConfig = tItemDB[itemId]
	if not itemConfig then
		-- 找不到道具配置
		return 0
	end

	local itemNum = 0
	if itemConfig.SubClass == ItemSubClass.Task then
		-- 在任务包裹里找
		itemNum = self.packs[PacketPackIndex.Task]:getBindItemNum(itemId)
	else
		for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
			if packIndex ~= PacketPackIndex.Task then
				if self.packs[packIndex] then
					itemNum = itemNum + self.packs[packIndex]:getBindItemNum(itemId)
				end
			end
		end
	end

	return itemNum
end

-- 获得指定ID的未绑定道具的个数
function Packet:getNoBindItemNum(itemId)
	local itemConfig = tItemDB[itemId]
	if not itemConfig then
		-- 找不到道具配置
		return 0
	end

	local itemNum = 0
	if itemConfig.SubClass == ItemSubClass.Task then
		-- 在任务包裹里找
		itemNum = self.packs[PacketPackIndex.Task]:getNoBindItemNum(itemId)
	else
		for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
			if packIndex ~= PacketPackIndex.Task then
				if self.packs[packIndex] then
					itemNum = itemNum + self.packs[packIndex]:getNoBindItemNum(itemId)
				end
			end
		end
	end

	return itemNum
end

-- 移除指定ID的绑定道具，返回移除的个数
function Packet:removeBindItem(itemId, itemNum)
	-- 先判断下数量够不够
	if self:getBindItemNum(itemId) < itemNum then
		return 0
	end

	local needRemoveNum = itemNum
	for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			local nRemoveNum = self.packs[packIndex]:removeBindItem(itemId, needRemoveNum)
			needRemoveNum = needRemoveNum - nRemoveNum
			if needRemoveNum <= 0 then
				-- 已经扣除够数目了
				return itemNum
			end
		end
	end
	return 0
end

-- 移除指定ID的未绑定道具，返回移除的个数
function Packet:removeNoBindItem(itemId, itemNum)
	-- 先判断下数量够不够
	if self:getNoBindItemNum(itemId) < itemNum then
		return 0
	end

	local needRemoveNum = itemNum
	for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			local nRemoveNum = self.packs[packIndex]:removeNoBindItem(itemId, needRemoveNum)
			needRemoveNum = needRemoveNum - nRemoveNum
			if needRemoveNum <= 0 then
				-- 已经扣除够数目了
				return itemNum
			end
		end
	end
	return 0
end

]]

-- 移除指定ID道具，返回移除的个数
function Packet:removeByItemId(itemId, itemNum)
	-- 先判断下数量够不够
	if self:getNumByItemID(itemId) < itemNum then
		return 0
	end

	local needRemoveNum = itemNum
	for packIndex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			local nRemoveNum = self.packs[packIndex]:removeByItemId(itemId, needRemoveNum)
			needRemoveNum = needRemoveNum - nRemoveNum
			if needRemoveNum <= 0 then
				-- 已经扣除够数目了
				return itemNum
			end
		end
	end
	return 0
end

-- 交换道具位置
function Packet:swapItem(srcPackIndex, srcGridIndex, dstPackIndex, dstGridIndex)
	if srcPackIndex < PacketPackIndex.Default or srcPackIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end
	if dstPackIndex < PacketPackIndex.Default or dstPackIndex >= PacketPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	local srcPack = self.packs[srcPackIndex]
	local srcGridItem = srcPack:getGridItem(srcGridIndex)
	if not srcGridItem then
		return false
	end
	local dstPack = self.packs[dstPackIndex]
	local dstGridItem = dstPack:getGridItem(dstGridIndex)
	if not dstGridItem then
		return false
	end

	-- 交换的两个道具要么都是任务道具，要么都不是，否则不能交换
	if srcGridItem:isTaskItem() ~= dstGridItem:isTaskItem() then
		return false
	end

	-- 源包裹移除原来的道具
	srcPack:removeItemsFromGrid(srcGridIndex, false)
	-- 源包裹添加新道具
	srcPack:addItemsToGrid(dstGridItem, srcGridIndex, true)
	-- 目标包裹移除原来的道具
	dstPack:removeItemsFromGrid(dstGridIndex, false)
	-- 目标包裹添加新道具
	dstPack:addItemsToGrid(srcGridItem, dstGridIndex, true)

	return true
end

-- 整理背包
function Packet:packUp()
	for packIndex = PacketPackIndex.Default, PacketPackIndex.Task do
		-- 获得包裹
		local pack = self.packs[packIndex]
		if pack then
			-- 每一个包裹单独整理
			pack:packUp()
		end
	end
	-- 通知客户端道具数据
	self:updateItemToClient()
end

-- 得到战斗包裹，供战斗服使用
function Packet:getBattlePack()
	-- 能否使用治疗类道具的标记
	local canUseHealItemFlag = true
	local mapID = self.owner:getCurPos()
	if mapID >= EctypeMap_StartID then
		local ectype = g_ectypeMgr:getEctype(mapID)
		if ectype and not ectype:canUseHealItems() then
			-- 当前副本无法使用治疗类道具
			canUseHealItemFlag = false
		end
	end
	local playerDBID = self.owner:getDBID()
	local battlePack = {}
	for packIndex = PacketPackIndex.Default, PacketPackIndex.Horse do
		-- 获得包裹
		local pack = self.packs[packIndex]
		if pack then
			-- 获得包裹道具
			for gridIndex = 1, pack:getCapability() do
				local item = pack:getGridItem(gridIndex)
				-- 只得到战斗中可使用的药品类道具
				if item and item:isBattleItem() then
					if not canUseHealItemFlag and item:isHealItem() then
					else
						local itemID = item:getItemID()
						battlePack[item:getGuid()] = {itemID = itemID, itemNum = item:getNumber(), packIndex = packIndex, gridIndex = gridIndex,
						useTimes = g_itemMgr:getItemUseTimes(playerDBID, itemID),effect = item:getEffect()}
					end
				end
			end
		end
	end
	return battlePack
end

-- 设置战斗包裹，战斗服返回的，这里要根据信息重设玩家道具数据
function Packet:setBattlePack(battlePack)
	for itemGuid, itemInfo in pairs(battlePack or {}) do
		if itemGuid then
			-- 战斗中可用的道具，属于背包已有道具，重设道具数据
			local item = g_itemMgr:getItem(itemGuid)
			if item then
				if itemInfo.useTimes > 0 then
					-- 重设使用次数
					g_itemMgr:resetItemUseTimes(self.owner:getDBID(), itemInfo.itemID, itemInfo.useTimes)
				end
				-- 如果使用完了，数目为0，则要销毁道具
				if itemInfo.itemNum == 0 then
					self:removeItem(itemGuid, 0, false)
				else
					-- 获得道具所在的包裹
					local packIndex = item:getPackIndex()
					local pack = self.packs[packIndex]
					if pack then
						pack:updateItem(item:getGridIndex(), itemInfo.itemID, itemInfo.itemNum)
					else
						-- 逻辑错误
					end
				end
			else
				-- 逻辑错误
			end
		else
			-- 战斗奖励获得的道具，添加进背包
			local item = g_itemMgr:createItem(itemInfo.itemID, itemInfo.itemNum)
			if item then
				self:addItems(item:getGuid(), false)
			end
		end
	end

	-- 通知客户端道具数据
	self:updateItemToClient()
end

-- 判断指定道具ID和数目能否放入背包
function Packet:canAddPacket(itemID, itemNum, bindFlag)
	local itemConfig = tItemDB[itemID]
	if not itemConfig or itemNum <= 0 then
		return false
	end
	local curCanAddNum = 0
	if itemConfig.SubClass == ItemSubClass.Task then
		local taskPack = self.packs[PacketPackIndex.Task]
		if taskPack then
			-- 先找空格能存放的数目
			curCanAddNum = taskPack:getAllSpaceNum() * itemConfig.MaxPileNum
			if curCanAddNum >= itemNum then
				return true
			end
			-- 再找叠加能存放的数目
			curCanAddNum = curCanAddNum + taskPack:getCanPileNum(itemID)
			if curCanAddNum >= itemNum then
				return true
			end
		end
	else
		for packIndex = PacketPackIndex.Default, PacketPackIndex.Horse do
			local pack = self.packs[packIndex]
			if pack then
				-- 先找空格能存放的数目
				curCanAddNum = pack:getAllSpaceNum() * itemConfig.MaxPileNum
				if curCanAddNum >= itemNum then
					return true
				end
				-- 再找叠加能存放的数目
				curCanAddNum = curCanAddNum + pack:getCanPileNum(itemID)
				if curCanAddNum >= itemNum then
					return true
				end
			end
		end
	end
	return false
end
