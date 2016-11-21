--[[PlayerLogic.lua
描述：
	玩家业务逻辑部分
--]]
require "entity.attribute.Attribute"

function Player:__init_logic()
	self._name		= nil
	self._sex		= nil
	self._modelId	= nil
	self._showParts	= nil
	self._school	= nil
	self.level		= nil
	self.attrSet	= {}

	self:createAttributeSet()
end

function Player:__release_logic()
	--todo
end

-- 创建玩家属性集合
function Player:createAttributeSet()
	local attrSet = self.attrSet
	for attrName,detail in pairs(PlayerAttrDefine) do
		if not attrSet[attrName] then
			attrSet[attrName] = PlayerAttribute(self,attrName,detail.expr,0)
		end
	end
end

-- 获取某一项属性
function Player:getAttribute(attrName)
	return attrName and self.attrSet[attrName]
end

-- 获得属性集合
function Player:getAttrSet()
	return self.attrSet
end

-- 设置属性值
function Player:setAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:setAttrValue] 没有%s这项属性!"):format(attrName or "nil"))
	end
	if attribute:isExpr() then
		print(("[Player:setAttrValue] 不能给公式属性%s设值"):format(attribute:getName()))
	end
	attribute:setValue(value)
end

-- 获得某项属性的值
function Player:getAttrValue(attrName)
	local attribute = attrName and self.attrSet[attrName]
	if attribute then
		return attribute:getValue()
	else
		print(("[Player:getAttrValue()] 没有%s这项属性!"):format(attrName or "nil"))
		return nil
	end
end

-- 给某项属性加值
function Player:addAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:addAttrValue] 没有%s这项属性!"):format(attrName or "nil"))
	end
	if attribute:isExpr() then
		print(("[Player:addAttrValue] 不能给公式属性%s设值"):format(attribute:getName()))
	end
	attribute:setValue(attribute:getValue() + value)
end

-- 属性改变事件通知
function Player:onAttrChanged(attrName)
	print("[Player:onAttrChanged]")
end
