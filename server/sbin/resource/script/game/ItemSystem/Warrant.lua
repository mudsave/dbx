--[[Warrant.lua
描述:
	物品大类凭证类
]]

Warrant = class(Item)

function Warrant:__init()
	-- 凭证大类
	self.class = ItemClass.Warrant
	self.attr = nil
end

function Warrant:__release()
end


-- 设置属性效果
function Warrant:setAttr(itemAttr)
	self.attr = itemAttr
	self:setDBState(ItemDBstate.update)
end

-- 获得属性效果
function Warrant:getAttr()
	return self.attr
end

-- 根据数据库现场设置属性
function Warrant:setPropertyContext(context)
	self.expireTime = context.expireTime
	self.itemLvl = tonumber(context.level)
	if context.attr and type(context.attr) == "string" then
		context.attr = unserialize(context.attr)
	end
	self.attr = context.attr
end

-- 获得属性现场
function Warrant:getPropertyContext()
	local context = {}
	context.itemID = self:getItemID()
	context.number = self:getNumber()
	context.level = self:getItemLvl()
	context.expireTime = self:getExpireTime()
	context.lockFlag = self:getLockFlag()
	context.attr = self:getAttr()
	return context
end