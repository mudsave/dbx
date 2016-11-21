-- Attribute.lua

require "base.class"

-- keep global function to enchance performance
local tonumber = tonumber

-- module notice functions
local function format(text,...)	return text and text:format(...) or ""		end
local function notice(text,...) print("Attribute:"..format(text,...) )		end

-- define an attribute class
function DefineAttribute(AttrDefine,Exprs,InfRef,SyncRef,PropRef)
	local Attribute = class()

	function Attribute:__init(entity,attrName,isDirty,value)
		self.type		= attrName			-- attribute's id
		self.value		= tonumber(value)	-- default value
		self.entity		= entity			-- possessor
		self.dirty		= isDirty			-- should update or not
		self.changed	= false				-- up-to-date or not

		local detail	= AttrDefine[attrName]
		self.db			= detail.db			-- would keep in database
		self.expr		= detail.expr		-- is an expr attribute
		self.name		= detail.name		-- name in string format
	end

	-- set attribute's value and make influence
	function Attribute:setValue(value)
		value = tonumber(value)
		if self.value == value then
			return
		end
		self.value		= value
		self.changed	= true
		self.dirty		= false

		local owner = self.entity

		if not self:isExpr() then
			local peer = owner:getPeer()
			local propID = PropRef[self.type]

			setPropValue(peer,propID,value)
		end
		
		local inf = InfRef[self.type]
		if inf then
			for _,attrName in ipairs(inf) do
				local attribute = owner:getAttribute(attrName)
				if attribute:isExpr() then
					if SyncRef[attrName] then
						attribute.dirty = true
					else
						attribute:getValue()
					end
				else
					notice("not an expression attribute:%s %s",self:getName(),attribute:getName())
				end
			end
		end
		owner:onAttrChanged(self.type)
	end

	-- attain attribute's latest value
	function Attribute:getValue()
		if not self.dirty then
			return self.value
		end

		local expr = Exprs[self.type]
		if not expr then
			notice("configure error:dirty attribute %s without expression",self:getName())
			return nil
		end
		local value = expr(self.entity)
		self:setValue(value)
		return value
	end

	-- is to save to db
	function Attribute:isSaveDB()
		return self.db
	end

	-- is an expression value
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