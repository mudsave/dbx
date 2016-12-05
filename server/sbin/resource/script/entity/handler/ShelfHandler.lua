--[[ShelfHandler.lua
描述：
	实体的Npc货架回购栏handler
--]]
ShelfHandler = class(nil)

function ShelfHandler:__init(entity)
	self._entity = entity
	-- npc货架回购
	self.shelf = Shelf(self._entity)
end

function ShelfHandler:__release()
	self._entity = nil
	release(self.shelf)
	self.shelf = nil
end

-- 获取货架
function ShelfHandler:getShelf()
	return self.shelf
end


-- 设置回购货架容量
function ShelfHandler:setShelfCapability(curCapability)
	local defaultPack = self.shelf:getPack()
	defaultPack:setCapability(curCapability)
end

