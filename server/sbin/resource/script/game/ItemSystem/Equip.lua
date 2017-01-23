--[[Equip.lua
描述:
	装备栏
]]

Equip = class()

function Equip:__init(owner)
	-- 拥有者
	self.owner = owner;
	-- 所有包裹
	self.packs = {}

	-- 装备栏就一个默认包裹
	local defaultPack = Pack()
	defaultPack:setCapability(EquipDefaultCapacity)
	defaultPack:setOwner(self.owner)
	defaultPack:setPackIndex(EquipPackIndex.Default)
	defaultPack:setPackContainerID(PackContainerID.Equip)
	self.packs[EquipPackIndex.Default] = defaultPack
end

function Equip:__release()
	release(self.packs[EquipPackIndex.Default])
	self.packs[EquipPackIndex.Default] = nil
end

-- 获得容器ID
function Equip:getContainerID()
	return PackContainerID.Equip
end

-- 通知客户端道具数据
function Equip:updateItemToClient()
	self.packs[EquipPackIndex.Default]:updateClient()
end

-- 获得包裹
function Equip:getPack()
	return self.packs[EquipPackIndex.Default]
end

-- 获得指定位置的道具
function Equip:getItems(packIndex, gridIndex)
	if packIndex ~= EquipPackIndex.Default then
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

-- 检测是否可以添加道具到指定物品格，这里只检测合法性，目标位置存在道具不在此检测范围
function Equip:canAddItemsToGrid(item, packIndex, gridIndex)
	if packIndex ~= EquipPackIndex.Default then
		-- 逻辑错误
		return false
	end
	if not instanceof(item, Equipment) then
		return false
	end
	-- 如果耐久为0，则无任何效果
	if item:getCurDurability() <= 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Item, 13)
		g_eventMgr:fireRemoteEvent(event,self.owner)
		return
	end

	if item:getEquipLevel() > self.owner:getLevel() then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Item, 11)
		g_eventMgr:fireRemoteEvent(event,self.owner)
		return
	end

	local equipGridIndex = item:getEquipGridIndex()
	if type(equipGridIndex) ~= 'table' then
		if equipGridIndex ~= gridIndex then
			-- 装备位置不合法
			return false
		end
	else
		-- 说明是戒指，有两个位置可以装备
		if equipGridIndex[1] ~= gridIndex and equipGridIndex[2] ~= gridIndex then
			-- 装备位置不合法
			return false
		end
	end
	-- 检测如果是武器是否符合门派
	if item:getSubClass() == EquipmentClass.Weapon then 
		local schoolID = self.owner:getSchool()
		-- 武器是否对应门派
		if WeaponSubClassSchoolID[item:getEquipClass()] ~= schoolID then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Item, 12)
			g_eventMgr:fireRemoteEvent(event,self.owner)
			return false
		end
	end
	return true
end

-- 添加道具到指定物品格
function Equip:addItemsToGrid(item, packIndex, gridIndex, bUpdateClient)
	if not self:canAddItemsToGrid(item, packIndex, gridIndex) then
		return false
	end
	local result = self.packs[packIndex]:addItemsToGrid(item, gridIndex, bUpdateClient)
	if result then
		item:onEquip(self.owner)
		self:setSuitAttr(true,item)
		self.owner:flushPropBatch()
	end
	return result
end

-- 从指定物品格移除道具，并不销毁道具
function Equip:removeItemsFromGrid(packIndex, gridIndex, bUpdateClient)
	if packIndex ~= EquipPackIndex.Default then
		-- 逻辑错误
		return false
	end

	local item = self.packs[packIndex]:getGridItem(gridIndex)
	local result = self.packs[packIndex]:removeItemsFromGrid(gridIndex, bUpdateClient)
	if result then
		-- 卸载该装备
		item:unEquip(self.owner)
		self:setSuitAttr(false,item)
		self.owner:flushPropBatch()
	end
	return result
end

-- 移除指定GUID的道具并销毁
function Equip:removeItem(itemGuid, removeNum)
	local equipMent = g_itemMgr:getItem(itemGuid)
	if equipMent then
		equipMent:unEquip(self.owner)
		self:setSuitAttr(false,equipMent)
		self.owner:flushPropBatch()
		return self.packs[EquipPackIndex.Default]:removeItem(equipMent, removeNum, true)
	end
end

function Equip:setSuitAttr(onEquip,item)
	--判断套装属性
	local _,_,_,itemRefiningEffect = item:getEffect()
	if itemRefiningEffect then
		local count = 0
		local level = item:getEquipLevel()
		local phase = itemRefiningEffect.phase
		local attr = nil
		--等级一样，相性一样的装备
		local refiningEquip = {}
		for i = 1, self.packs[EquipPackIndex.Default]:getCapability() do
			local equipMent = self.packs[EquipPackIndex.Default]:getGridItem(i)
			if equipMent then
				local _,_,_,refiningEffect = equipMent:getEffect()
				if refiningEffect and level == equipMent:getEquipLevel() and refiningEffect.phase == phase then
					count = count +1
					table.insert(refiningEquip,equipMent)
				end
			end
		end
		if onEquip then
			if count == 6 or count == 4 or count == 2 then
				local tattr = RefiningEffectDB[phase]
				if tattr then
					local tattrVaue = tattr[level]
					if tattrVaue[count-2] then
						self.owner:subAttrValue(tattr.suitType,tattrVaue[count-2])
					end
					attr = {attrID = tattr.suitType,attrValue = tattrVaue[count],count = count}
				end
				for _,equip in pairs(refiningEquip) do
					equip:setSuitAttr(attr)
					equip:getPack():updateItemsToClient(equip)
				end
				self.owner:addAttrValue(attr.attrID, attr.attrValue)
			else
				local tattr = RefiningEffectDB[phase]
				local tattrVaue = tattr[level]
				if tattrVaue[count-1] then
					attr = {attrID = tattr.suitType,attrValue = tattrVaue[count-1],count = count-1}
				end
				item:setSuitAttr(attr)
				item:getPack():updateItemsToClient(item)
			end		
		end

		if not onEquip then
			if count == 1 or count == 3 or count == 5 then
				local tattr = RefiningEffectDB[phase]
				if tattr then
					local tattrVaue = tattr[level]
					self.owner:subAttrValue(tattr.suitType,tattrVaue[count+1])
					if tattrVaue[count-1] then
						attr = {attrID = tattr.suitType,attrValue = tattrVaue[count-1],count = count-1}
					end
				end
				for _,equip in pairs(refiningEquip) do
					equip:setSuitAttr(attr)
					equip:getPack():updateItemsToClient(equip)
				end
				if attr then
					self.owner:addAttrValue(attr.attrID, attr.attrValue)
				end
			end
			--所以在这里更新一下他的套装属性
			item:setSuitAttr(nil)
			item:getPack():updateItemsToClient(item)
		end
		self.owner:flushPropBatch()
	end
end