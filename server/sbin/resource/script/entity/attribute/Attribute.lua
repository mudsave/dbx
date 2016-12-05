-- Attribute.lua

require "base.class"

-- 暂存全局函数,减少全局表搜索
local tonumber = tonumber

-- 文件内提示函数
local function format(text,...)	return text and text:format(...) or ""		end
local function notice(text,...) print("Attribute:"..format(text,...) )		end

-- 属性类定义函数
function DefineAttribute(AttrDefine,Exprs,InfRef,SyncRef,PropRef)
	local Attribute = class()

	function Attribute:__init(entity,attrName,isDirty,value)
		self.type		= attrName			-- 属性名称
		self.value		= tonumber(value)	-- 属性默认值
		self.entity		= entity			-- 所有者
		self.dirty		= isDirty			-- 是否需要更新
		self.changed	= false				-- 从创建后是否有更新

		local detail	= AttrDefine[attrName]
		self.db			= detail.db			-- 是否需要存数据库
		self.expr		= detail.expr		-- 是不是公式属性
		self.name		= detail.name		-- 名称
	end

	-- 加载值
	function Attribute:loadValue(value)
		value = tonumber(value)
		self.value		= value
		self.dirty		= false
		self.changed	= false

		self:notifyInfluenceChanged()
		self.entity:onAttrChanged(self.type,prev,value)
	end

	-- 设置值并通知到prop
	function Attribute:setValue(value)
		value = tonumber(value)
		if self.value == value then
			return
		end

		local prev		= self.value

		self.value		= value
		self.dirty		= false
		self.changed	= true

		local attrName	= self.type
		local owner		= self.entity
		local propID	= PropRef[attrName]
		if propID then
			local peer = owner:getPeer()
			setPropValue(peer,propID,value)
		end
		self:notifyInfluenceChanged()
		owner:onAttrChanged(attrName,prev,value)
	end

	-- 获取最新的数据
	function Attribute:getValue()
		if not self.dirty then
			return self.value
		end

		local expr = Exprs[self.type]
		if not expr then
			notice("配置错误,脏属性%s没有公式",self:getName())
			return nil
		end
		local value = expr(self.entity)
		self:setValue(value)
		return value
	end

	-- 更新被当前属性影响的属性
	function Attribute:notifyInfluenceChanged()
		local inf = InfRef[self.type]
		if not inf then
			return
		end
		local owner = self.entity
		for _,attrName in ipairs(inf) do
			local attribute = owner:getAttribute(attrName)
			if attribute:isExpr() then
				attribute.dirty = true
				if SyncRef[attrName] then
					attribute:getValue()
				end
			else
				notice("不是一个公式属性:%s %s",self:getName(),attribute:getName())
			end
		end
	end

	-- 是否需要存到数据库
	function Attribute:isSaveDB()
		return self.db and self.changed
	end

	-- 是不是一个公式属性
	function Attribute:isExpr()
		return self.expr
	end

	function Attribute:getName()
		return self.name
	end

	function Attribute:tostring()
		return ("Attribute:{type=%s,value=%d}"):format(self:getName(),self:getValue())
	end

	return Attribute
end

require "entity.attribute.PlayerAttrDefine"
require "entity.attribute.PlayerAttrFormula"
require "entity.attribute.PetAttrDefine"
require "entity.attribute.PetAttrFormula"
require "entity.attribute.MonsterAttrDefine"
require "entity.attribute.MonsterAttrFormula"
require "entity.attribute.PvpPlayerAttrDefine"
require "entity.attribute.PvpPlayerAttrFormula"

PlayerAttribute		= DefineAttribute(PlayerAttrDefine,g_AttributePlayerFormat,g_AttrPlayerInfluenceTable,g_AttrPlayerSyncTable,g_AttributePlayerToProp)
PetAttribute		= DefineAttribute(PetAttrDefine,g_AttributePetFormat,g_AttrPetInfluenceTable,g_AttrPetSyncTable,g_AttributePetToProp)
MonsterAttribute	= DefineAttribute(MonsterAttrDefine,g_AttributeMonsterFormat,g_AttrMonsterInfluenceTable,g_AttrMonsterSyncTable,g_AttributeMonsterToProp)
PvpPlayerAttribute	= DefineAttribute(PvpPlayerAttrDefine,g_AttributePvpPlayerFormat,g_AttrPvpPlayerInfluenceTable,g_AttrPvpPlayerSyncTable,g_AttrPvpPlayerToProp)
