--[[Depot.lua
描述:
	仓库
]]

Depot = class()

function Depot:__init(owner)
	-- 拥有者
	self.owner = owner;
	-- 所有包裹
	self.packs = {}

	-- 第一个包裹
	local firstPack = Pack()
	firstPack:setCapability(DepotDefaultCapacity)
	self:addPack(DepotPackIndex.First, firstPack)
	-- 第二个包裹
	local secondPack = Pack()
	secondPack:setCapability(0)
	self:addPack(DepotPackIndex.Second, secondPack)
end

function Depot:__release()
	for packIndex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			release(self.packs[packIndex])
			self.packs[packIndex] = nil
		end
	end
end

-- 检测计时道具是否到期
function Depot:checkItemExpire()
	for packIndex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
		-- 获得包裹
		local pack = self:getPack(packIndex)
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
function Depot:getContainerID()
	return PackContainerID.Depot
end

-- 通知客户端道具数据
function Depot:updateItemToClient()
	for packIndex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
		if self.packs[packIndex] then
			self.packs[packIndex]:updateClient()
		end
	end
end

-- 添加包裹
function Depot:addPack(packIndex, pack)
	if instanceof(pack, Pack) then
		if self.packs[packIndex] then
			-- 已经存在
			return false
		else
			pack:setOwner(self.owner)
			pack:setPackIndex(packIndex)
			pack:setPackContainerID(PackContainerID.Depot)
			self.packs[packIndex] = pack
			return true
		end
	end
	return false
end

-- 获得包裹
function Depot:getPack(packIndex)
	return self.packs[packIndex]
end

-- 获得指定位置的道具
function Depot:getItems(packIndex, gridIndex)
	if packIndex < DepotPackIndex.First or packIndex >= DepotPackIndex.MaxNum then
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

-- 添加道具
function Depot:addItems(itemGuid, bUpdateClient)
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

	local canAdd, tAddPacks, result = self:canAddItems(item)
	if canAdd then
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
			g_itemMgr:destroyItem(self.owner,itemGuid)
			return AddItemsResult.SucceedPile
		else
			return AddItemsResult.Succeed
		end
	else
		local event = Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Item, result)
		g_eventMgr:fireRemoteEvent(event,self.owner)
	end
	return result
end

-- 判断可否放入包裹
function Depot:canAddItems(item)
	local canAdd = false
	local result = nil
	local tAddPacks = {}
	local needAddNumber = item:getNumber()
	local canAddNumber = 0

	for packIndex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
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
					result = AddItemsResult.Succeed
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
	if not canAdd then
		local depotHandler = self.owner:getHandler(HandlerDef_Depot)
		local curCapacity = depotHandler:getDepotCapability()
		if curCapacity >= DepotMaxCapacity then
			--您的仓库已存满，无法存入物品！
			result = 16
		else
			--你的仓库已满，请购买仓库乾坤包扩充仓库
			result = 14
		end
		
	end

	return canAdd, tAddPacks,result
end

-- 删除道具
function Depot:removeItem(itemGuid, removeNum, bUpdateClient)
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return RemoveItemsResult.SrcInvalid
	end

	-- 获得道具所在的包裹索引
	local packIndex = item:getPackIndex()
	if packIndex < DepotPackIndex.First or packIndex >= DepotPackIndex.MaxNum then
		-- 逻辑错误
		return RemoveItemsResult.Failed
	end

	local result = self.packs[packIndex]:removeItem(item, removeNum, bUpdateClient)
	if result == RemoveItemsResult.SucceedClean then
		-- 销毁源道具，不可用了
		g_itemMgr:destroyItem(self.owner,itemGuid)
	end
end

-- 增加道具到指定包裹
function Depot:addItemsToPack(srcItem, dstPackIndex)
	if dstPackIndex < DepotPackIndex.First or dstPackIndex >= DepotPackIndex.MaxNum then
		-- 逻辑错误
		return AddItemsResult.LocInvalid
	end

	local result = self.packs[dstPackIndex]:addItems(srcItem, true)
	if result == AddItemsResult.SucceedPile then
		-- 销毁源道具，不可用了
		g_itemMgr:destroyItem(self.owner,srcItem:getGuid())
	end
	return result
end

-- 添加道具到指定物品格
function Depot:addItemsToGrid(item, packIndex, gridIndex, bUpdateClient)
	if packIndex < DepotPackIndex.First or packIndex >= DepotPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end
	return self.packs[packIndex]:addItemsToGrid(item, gridIndex, bUpdateClient)
end

-- 从指定物品格移除道具，并不销毁道具
function Depot:removeItemsFromGrid(packIndex, gridIndex, bUpdateClient)
	if packIndex < DepotPackIndex.First or packIndex >= DepotPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	return self.packs[packIndex]:removeItemsFromGrid(gridIndex, bUpdateClient)
end

-- 叠加道具到指定物品格
function Depot:pileItemsToGrid(srcItem, dstPackIndex, dstGridIndex)
	if dstPackIndex < DepotPackIndex.First or dstPackIndex >= DepotPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end

	return self.packs[dstPackIndex]:pileItemsToGrid(srcItem, dstGridIndex)
end

-- 叠加道具到包裹指定物品格，注意这里是能叠加多少就叠加多少
function Depot:pileItemsToGridEx(srcItem, dstPackIndex, dstGridIndex)
	if dstPackIndex < DepotPackIndex.First or dstPackIndex >= DepotPackIndex.MaxNum then
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

-- 交换道具位置
function Depot:swapItem(srcPackIndex, srcGridIndex, dstPackIndex, dstGridIndex)
	if srcPackIndex < DepotPackIndex.First or srcPackIndex >= DepotPackIndex.MaxNum then
		-- 逻辑错误
		return false
	end
	if dstPackIndex < DepotPackIndex.First or dstPackIndex >= DepotPackIndex.MaxNum then
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

-- 整理仓库
function Depot:packUp()
	for packIndex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
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
