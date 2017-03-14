--[[Medicament.lua
描述：
	物品大类药品类
]]

Medicament = class(Item)

function Medicament:__init()
	-- 药品大类
	self.class = ItemClass.Medicament
	-- 属性效果
	self.effect = 0
	self.attr = nil
end

function Medicament:__release()
end

-- 设置属性效果
function Medicament:setEffect(itemEffect)
	self.effect = itemEffect
	self:setDBState(ItemDBstate.update)
end

-- 获得属性效果
function Medicament:getEffect()
	return self.effect
end

-- 设置效果表table
function Medicament:setAttr(itemAttr)
	self.attr = itemAttr
	self:setDBState(ItemDBstate.update)
end

-- 获得效果表
function Medicament:getAttr()
	return self.attr
end

-- 根据数据库现场设置药品属性
function Medicament:setPropertyContext(context)
	self.expireTime = context.expireTime
	self.effect = tonumber(context.effect)
	if context.attr and type(context.attr) == "string" then
		context.attr = unserialize(context.attr)
	end
	self.attr = context.attr
end

-- 获得药品属性现场
function Medicament:getPropertyContext()
	local context = {}
	context.itemID = self:getItemID()
	context.number = self:getNumber()
	context.bindFlag = self:getBindFlag()
	context.expireTime = self:getExpireTime()
	context.effect = self:getEffect()
	context.attr = self:getAttr()
	return context
end
