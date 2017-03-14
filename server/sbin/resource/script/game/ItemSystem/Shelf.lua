--[[Shelf.lua
描述:
	玩家回购货架栏
]]

Shelf = class()

function Shelf:__init(owner)
	-- 拥有者
	self.owner = owner;
	-- 所有包裹
	self.packs = {}

	-- 默认包裹
	local defaultPack = Pack()
	--包裹设置默认容量为12
	defaultPack:setCapability(ShelfMaxCapacity)
	--这个包裹和Npc回购货架绑定4
	defaultPack:setPackContainerID(PackContainerID.Shelf)
	self:addPack(ShelfPackIndex.Default, defaultPack)
end

function Shelf:__release()
	release(self.packs[ShelfPackIndex.Default])
	self.packs[ShelfPackIndex.Default] = nil
end

-- 获得容器ID
function Shelf:getContainerID()
	return PackContainerID.Shelf
end

-- 通知客户端道具数据
function Shelf:updateItemToClient()
	self.packs[ShelfPackIndex.Default]:updateClient()
end

-- 添加包裹
function Shelf:addPack(packIndex, pack)
	if instanceof(pack, Pack) then
		if self.packs[packIndex] then
			-- 已经存在
			return false
		else
			pack:setOwner(self.owner)
			pack:setPackIndex(packIndex)
			self.packs[packIndex] = pack
			return true
		end
	end
	return false
end

-- 获得包裹
function Shelf:getPack()
	-- 仓库就一个包裹
	return self.packs[ShelfPackIndex.Default]
end

-- 获得指定位置的道具
function Shelf:getItems(packIndex, gridIndex)
	if packIndex ~= ShelfPackIndex.Default then
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

-- 删除道具
function Shelf:removeItem(itemGuid, removeNum, bUpdateClient)
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return RemoveItemsResult.SrcInvalid
	end

	local result = self.packs[ShelfPackIndex.Default]:removeItem(item, removeNum, bUpdateClient)
	if result == RemoveItemsResult.SucceedClean then
		-- 销毁源道具，不可用了
		g_itemMgr:destroyItem(self.owner,itemGuid)
	end
end

-- 增加道具指定的数量到指定包裹
function Shelf:addNumberItemsToPack(srcItem, dstPackIndex, itemNum)
	if dstPackIndex ~= ShelfPackIndex.Default then
		-- 逻辑错误
		print("执行到错误")
		return false
	end
	return self.packs[dstPackIndex]:addItemsToShelf(srcItem, itemNum, true)
end

-- 从指定物品格移除道具，并不销毁道具
function Shelf:removeItemsFromGrid(packIndex, gridIndex, bUpdateClient)
	if packIndex ~= ShelfPackIndex.Default then
		-- 逻辑错误
		return false
	end
	return self.packs[packIndex]:removeItemsFromGrid(gridIndex, bUpdateClient)
end


-- 重新设置一下顺序
function Shelf:upGridItem(packIndex, bUpdateClient)
	-- 整理默认包裹
	if packIndex ~= ShelfPackIndex.Default then
		-- 逻辑错误
		return false
	end
	return self.packs[packIndex]:packUpdate(bUpdateClient)
end
