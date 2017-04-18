-- Attribute.lua

require "base.class"

-- 暂存全局函数,减少全局表搜索
local tonumber = tonumber
local rawget = rawget
local rawset = rawset

-- Warning:
-- 对于"error test ... test end]]" 范式的代码,
-- 在系统测试完毕/所有出错都得到解决后,可在"error test"之前加入"--[["块注释符号

-- 属性类定义函数
local function Define(AttrDefine,Exprs,InfRef,SyncRef,PropRef)
	local Attribute = class()

	function Attribute:__init(attrName,detail)
		if not detail then
			detail	= AttrDefine[attrName]
		end

		self.type		= attrName			-- 属性名称
		self.db			= detail.db			-- 是否需要存数据库
		self.expr		= detail.expr		-- 是不是公式属性
		self.name		= detail.name		-- 名称

		self.propID		= PropRef[attrName]	-- 同步ID
		self.formula	= Exprs[attrName]	-- 计算公式
		
		self:clear(detail)
	end

	function Attribute:clear(detail)
		local def = detail.def or 0	-- 默认值

		self.value		= def		-- 当前值

		self.dirty		= false		-- 是否为脏
		self.updated	= 0			-- 更新计数
		self.casted		= 0			-- 广播计数
	end

	function Attribute:loadValue(value,peer)
		self.value		= value
		self.dirty		= false
		
		return self:updatePeer(peer,value,self.propID)
	end

	function Attribute:setValue(value,peer)
		if value then
			local prev = self.value
			if prev ~= value then
				self.value = value
				self.dirty = false

				self.updated = self.updated + 1
				self:updatePeer(peer,value,self.propID)
				return prev
			else
				--print(("属性%s的设值操作失败,因为和旧值相同"):format(self:getName()))
			end
		end
		return nil
	end

	function Attribute:getValue()
		return self.value
	end

	function Attribute:updatePeer(peer,value,propID)
		if propID and peer then
			setPropValue(peer,propID,value)
			self.casted = self.updated
		end
	end

	function Attribute:broadcast( peer,force )
		if force or self.casted < self.updated then
			return self:updatePeer(peer,self.value,self.propID)
		end
	end

	function Attribute:isSaveDB()
		return self.db and self.updated > 0
	end

	function Attribute:isExpr()
		return self.expr
	end

	function Attribute:isDirty()
		return self.dirty
	end

	function Attribute:getName()
		return self.name
	end

	function Attribute:tostring()
		return ("Attribute:{type=%s,value=%d}"):format(self:getName(),self:getValue())
	end


	local AttributeSet = class()
	
	function AttributeSet:__init(entity)
		for attrName,detail in ipairs(AttrDefine) do
			rawset(self,attrName,Attribute(attrName,detail))
		end

		self.silent	= true		-- 属性改动事件广播禁用标记,在属性集合初始化时候,禁止属性相互影响
		self.next	= false		-- 下一个属性集合,属性集合重用功能

		self:setEntity(entity)
	end

	function AttributeSet:setEntity(entity)
		self.entity = entity or false
	end

	function AttributeSet:loadAttrRecord(attrRecord)

		-- error test
		if not self.entity then
			print "加载属性记录时候,属性集合没有绑定所有者"
		end
		if not attrRecord then
			print(("实体%s %s 没有属性记录"):format( 
				string.gbkToUtf8(self.entity:getName()),
				self.entity:getDBID()
			))
		end
		-- test end]]

		local peer = self.entity:getPeer()
		for index,data in pairs(attrRecord) do

			-- error test
			local attribute = rawget(self,data.attrType)
			if not attribute then
				print( ("%s的属性集合中无法找到属性%s"):format( tostring(self.entity), data.attrType ) )
			end
			if attribute:isExpr() then
				print( ("不能给公式属性%s设值%d"):format( attribute:getName(),data.attrValue ) )
			end
			-- test end]]

			rawget(self,data.attrType):loadValue(
				data.attrValue,peer
			)
		end
	end

	function AttributeSet:setAttrValue(attrName,value)
		local attr = rawget(self,attrName)

		-- error test
		if not attr then
			print( ("属性集合中没有这条属性%s"):format(attrName or "") )
		end
		if attr:isExpr() then
			print( ("不能给公式属性%s设值"):format(attr:getName()) )
		end
		if not value then
			print(("不要给属性%s设置空值"):format(
				attr:getName()
			))
		end
		-- test end]]
		
		local entity = self.entity
		local prev = attr:setValue( value,entity:getPeer() )
		if prev then
			entity:onAttrChanged(attrName,prev,value)
			self:notifyInfluenceChanged(attrName)
		end
	end

	function AttributeSet:addAttrValue(attrName,delta)
		local attr = rawget(self,attrName)

		-- error test
		if not attr then
			print( ("加值计算时,没有这条属性%s"):format(attrName or "") )
		end
		if attr:isExpr() then
			print( ("不能给公式属性%s加值"):format(attr:getName()) )
		end
		-- test end]]
		
		local entity = self.entity
		local prev = attr:getValue()
		local value = prev + delta
		if attr:setValue( value,entity:getPeer() ) then
			entity:onAttrChanged( attrName,prev,value )
			self:notifyInfluenceChanged(attrName)
		end
	end

	function AttributeSet:getAttrValue(attrName)
		local attr = rawget(self,attrName)
		if attr.dirty then
			local entity = self.entity
			local value = attr.formula(self)
			local prev = attr:setValue( value,entity:getPeer() )
			if prev then
				entity:onAttrChanged( attrName,prev,value )
				self:notifyInfluenceChanged(attrName)
				return value
			end
		end
		return attr.value
	end

	function AttributeSet:updateAll( force )
		local entity = self.entity
		local peer = entity:getPeer()
		for attrName,attr in ipairs(self) do
			if attr.dirty then
				local value = attr.formula(self)
				local prev = attr:setValue( value,peer )
				if prev then
					entity:onAttrChanged( attrName,prev,value )
					self:notifyInfluenceChanged(attrName)
				end
			else 
				attr:broadcast( force )
			end
		end
		if force then
			self.silent = false
		end
	end

	function AttributeSet:notifyInfluenceDirty(attrName)
		local inf = InfRef[attrName]
		if inf then
			for index,attrName in ipairs(inf) do
				rawget(self,attrName).dirty = true
				self:notifyInfluenceDirty(attrName)
			end
		end
	end

	function AttributeSet:notifyInfluenceChanged(attrName)
		local inf = InfRef[attrName]
		if not inf then	return end
		for index,attrName in ipairs(inf) do
			local attr = rawget(self,attrName)
			if not self.silent and SyncRef[attrName] then

				-- error test
				if not attr:isExpr() then
					print( ("非公式属性%d配置为被影响属性"):format( attr:getName() ) )
				end
				if not attr.formula then
					print( ("公式属性%d没有配置公式"):format( attr:getName() ) )
				end
				-- test end]]

				local entity = self.entity
				local value = attr.formula(self)
				local prev = attr:setValue( value,entity:getPeer() )
				if prev then
					entity:onAttrChanged(attrName,prev,value)
					self:notifyInfluenceChanged(attrName)
				end
			else
				attr.dirty = true
				self:notifyInfluenceDirty(attrName)
			end
		end
	end

	function AttributeSet:clear()
		self:setEntity(nil)
		self.silent = true
		
		for attrName,detail in ipairs(AttrDefine) do
			rawget(self,attrName):clear(detail)
		end
	end

	function AttributeSet:onSave()
		local t = {}
		local len = 0
		for attrName,attribute in ipairs(self) do
			if attribute:isSaveDB() then
				t[len + 1] = attrName
				t[len + 2] = attribute:getValue()
				len = len + 2
			end
		end
		return len/2,table.concat(t,",")
	end

	-- 复用属性集合的链表头部
	local frees = false

	function AttributeSet:release()
		self:clear()

		self.next = frees
		frees = self
	end

	-- 返回获得属性集合入口函数
	return function(entity)
		if not frees then
			return AttributeSet(entity)
		end
		local ret = frees
		frees = ret.next

		ret.next = false
		ret:setEntity(entity)

		return ret
	end
end

require "attribute.PlayerAttrDefine"
require "attribute.PlayerAttrFormula"
require "attribute.PetAttrDefine"
require "attribute.PetAttrFormula"
require "attribute.MonsterAttrDefine"
require "attribute.MonsterAttrFormula"
require "attribute.PvpPlayerAttrDefine"
require "attribute.PvpPlayerAttrFormula"

PlayerAttributeSet		= Define(PlayerAttrDefine,g_AttributePlayerFormat,g_AttrPlayerInfluenceTable,g_AttrPlayerSyncTable,g_AttributePlayerToProp)
PetAttributeSet			= Define(PetAttrDefine,g_AttributePetFormat,g_AttrPetInfluenceTable,g_AttrPetSyncTable,g_AttributePetToProp)
MonsterAttributeSet		= Define(MonsterAttrDefine,g_AttributeMonsterFormat,g_AttrMonsterInfluenceTable,g_AttrMonsterSyncTable,g_AttributeMonsterToProp)
PvpPlayerAttributeSet	= Define(PvpPlayerAttrDefine,g_AttributePvpPlayerFormat,g_AttrPvpPlayerInfluenceTable,g_AttrPvpPlayerSyncTable,g_AttrPvpPlayerToProp)

-- 没有什么是简简单单就能完成的,人们有一个想法,便认为顺着此时的念头走下去就能达到目的
-- 不可能的
-- 要做好一件事,你得先考虑好自己所需的代价
-- 开端就画好饼干,被要成功的愉悦充昏了头脑,对过程中所有的障碍困难视而不见,固执已见
-- 冲动来的快,失望来的也快

