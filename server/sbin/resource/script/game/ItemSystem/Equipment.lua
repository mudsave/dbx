--[[Equipment.lua
描述:
	物品大类装备类
]]

Equipment = class(Item)

function Equipment:__init(itemId, itemNum)
	-- 装备大类
	self.class = ItemClass.Equipment
	-- 装备分类，按功能
	self.subClass = tEquipmentDB[itemId].SubClass
	-- 装备具体类型
	self.equipClass = tEquipmentDB[itemId].EquipClass
	-- 当前耐久度
	self.curDurability = 0
	--鉴定
	self.identityFlag = true
	-- 改造等级
	self.remouldAttr = nil
	-- 基础属性效果
	self.baseEffect = nil
	-- 附加属性效果
	self.addEffect = nil
	-- 绑定属性效果
	self.bindEffect = nil
	-- 炼化属性效果
	self.refiningEffect = nil
	-- 套装属性
	self.suitEffect = nil
	-- 绑定标志，true为绑定，
	self.bindFlag = false
end

function Equipment:__release()
end
-- 获得装备的类型
function Equipment:getSubClass()
	local equipConfig = tEquipmentDB[self.itemID]
	return equipConfig.SubClass
end
-- 获得装备具体类型
function Equipment:getEquipClass()
	local equipConfig = tEquipmentDB[self.itemID]
	return equipConfig.EquipClass
end

-- 获得装备等级，就是使用等级
function Equipment:getEquipLevel()
	local equipConfig = tEquipmentDB[self.itemID]
	return self:getItemLvl() and self:getItemLvl() or equipConfig.UseNeedLvl
end

-- 获得装备品质
function Equipment:getEquipQuality()
	local equipConfig = tEquipmentDB[self.itemID]
	if equipConfig.Quality ~= ItemQuality.NoIdentify then
		-- 返回配置的装备品质
		return equipConfig.Quality
	else
		if not self.identityFlag then
			-- 未鉴定
			return ItemQuality.NoIdentify
		else
			-- 根据鉴定后附加属性判断装备品质
			local addEffectNum = table.getn(self.addEffect)
			if addEffectNum >= 6 then
				-- 绿色
				return ItemQuality.Green
			elseif addEffectNum >= 5 then
				-- 金色
				return ItemQuality.Gold
			elseif addEffectNum >= 4 then
				-- 粉色
				return ItemQuality.Pink
			else
				-- 蓝色
				return ItemQuality.Blue
			end
		end
	end
end

-- 获得装备最大耐久
function Equipment:getMaxDurability()
	local equipConfig = tEquipmentDB[self.itemID]
	if not equipConfig then
		return 0
	end
	return equipConfig.MaxDurability*ConsumeDurabilityNeedFightTimes or 0
end

-- 设置当前耐久度
function Equipment:setCurDurability(curDurability)
	if curDurability < 0 then
		curDurability = 0
	end
	if self.curDurability ~= curDurability then
		local setRealDurability = math.floor(curDurability / ConsumeDurabilityNeedFightTimes)
		local curRealDurability = math.floor(self.curDurability / ConsumeDurabilityNeedFightTimes)
		self.curDurability = curDurability
		if setRealDurability ~= curRealDurability then
			-- 如果客户端显示有变化，就通知下客户端
			if self.pack then
				self.pack:setChange(self.gridIndex)
			end
		end
	end
	self:setDBState(ItemDBstate.update)
end

-- 获得当前耐久度
function Equipment:getCurDurability()
	return self.curDurability
end

-- 设置道具绑定标志
function Equipment:setBindFlag(bindFlag)
	if self.bindFlag ~= bindFlag then
		self.bindFlag = bindFlag
		if self.pack then
			self.pack:setChange(self.gridIndex)
		end
	end
	self:setDBState(ItemDBstate.update)
end

-- 获得道具绑定标志
function Equipment:getBindFlag()
	return self.bindFlag
end

-- 设置改造属性
function Equipment:setRemouldAttr(remouldAttr)
	self.remouldAttr = remouldAttr
	if self:getSubClass() == EquipmentClass.Weapon and self:getContainerID() == PackContainerID.Equip then
		local data = string.format("{true,%d,%d}", self.itemID,self:getRemouldAttrValue()*100)
		local player = self.pack:getOwner()
		setPropValue(player:getPeer(), PLAYER_EQUIP_WEAPON,data)
	end
	self:setDBState(ItemDBstate.update)
end

-- 获得改造属性
function Equipment:getRemouldAttr()
	return self.remouldAttr
end

--获得属性值
function Equipment:getRemouldAttrValue()
	local attrValue = 0
	for _,color in pairs(self.remouldAttr or {}) do
		attrValue = attrValue + EquipRemouldBaseAttrAddDB[color]/100
	end
	return attrValue
end

-- 获得改造等级
function Equipment:getRemouldLevel()
	return table.size(self.remouldAttr)
end

-- 设置鉴定标志
function Equipment:setIdentityFlag(identityFlag)
	self.identityFlag = identityFlag
	self:setDBState(ItemDBstate.update)
end

-- 获得鉴定标志,true为鉴定，false为未鉴定
function Equipment:getIdentityFlag()
	return self.identityFlag
end

-- 设置属性效果
function Equipment:setEffect(context)
	if context.baseEffect then
		self.baseEffect = context.baseEffect
	end
	if context.addEffect then
		self.addEffect = context.addEffect
	end
	if context.bindEffect then
		self.bindEffect = context.bindEffect
	end
	if context.refiningEffect then
		self.refiningEffect = context.refiningEffect
	end
	self:setDBState(ItemDBstate.update)
end

-- 获取套装属性
function Equipment:setSuitAttr(suirAttr)
	self.suitAttr = suirAttr
	self:setDBState(ItemDBstate.update)
end

-- 获取套装属性
function Equipment:getSuitAttr()
	return self.suitAttr
end

-- 设置属性效果扩展函数
function Equipment:setEffectEx(context)
	self.baseEffect = context.baseEffect
	self.addEffect = context.addEffect
	self.bindEffect = context.bindEffect
	self.refiningEffect = context.refiningEffect
	self:setDBState(ItemDBstate.update)
end

-- 获得属性效果
function Equipment:getEffect()
	return self.baseEffect, self.addEffect, self.bindEffect,self.refiningEffect
end

-- 根据数据库现场设置装备属性
function Equipment:setPropertyContext(context)
	-- 装备暂时没有到期时间，永久有效
	self.bindFlag = context.bindFlag and true or false

	if context.expireTime > 0 then
		context.curDurability = context.expireTime
	end
	self.curDurability = context.curDurability

	if context.effect and type(context.effect) == "string" then
		context.remouldAttr = unserialize(context.effect)
		self.remouldAttr = context.remouldAttr
	end
	if not context.identityFlag then
		self.identityFlag = context.identityFlag
	end

	if context.baseEffect and type(context.baseEffect) == "string" then
		context.baseEffect = unserialize(context.baseEffect)
	end
	if context.addEffect and type(context.addEffect) == "string" then
		context.addEffect = unserialize(context.addEffect)
	end
	if context.bindEffect and type(context.bindEffect) == "string" then
		context.bindEffect = unserialize(context.bindEffect)
	end
	if context.refiningEffect and type(context.refiningEffect) == "string" then
		context.refiningEffect = unserialize(context.refiningEffect)
	end
	
	self.baseEffect = context.baseEffect
	self.addEffect = context.addEffect
	self.bindEffect = context.bindEffect
	self.refiningEffect = context.refiningEffect
end

-- 获得装备属性现场
function Equipment:getPropertyContext()
	local context = {}
	context.itemID = self:getItemID()
	context.number = self:getNumber()
	context.bindFlag = self:getBindFlag()
	context.expireTime = self:getExpireTime()
	context.curDurability = self:getCurDurability()
	context.remouldAttr = self:getRemouldAttr()
	context.baseEffect, context.addEffect, context.bindEffect, context.refiningEffect = self:getEffect()
	context.identityFlag = self:getIdentityFlag()
	context.suitAttr = self:getSuitAttr()
	return context
end

-- 获得装备对应的装备栏格子索引
function Equipment:getEquipGridIndex()
	return EquipType_ItemGrid[self.subClass][self.equipClass]
end

-- 装备该装备
function Equipment:onEquip(player)
	local equipConfig = tEquipmentDB[self.itemID]
	if not equipConfig then
		-- 找不到装备定义
		return
	end
	if not instanceof(player, Player) then
		return
	end

	-- 更新装备外观
	self:updatePlayerShowParts(player, equipConfig, true)

	-- 装备属性
	self:updateEquipAttr(player, true)
	--通知任务系统
	TaskCallBack.onWearEquip(player:getID(), self.itemID)
end

-- 卸载该装备
function Equipment:unEquip(player)
	local equipConfig = tEquipmentDB[self.itemID]
	if not equipConfig then
		-- 找不到装备定义
		return
	end
	if not instanceof(player, Player) then
		return
	end

	-- 更新装备外观
	self:updatePlayerShowParts(player, equipConfig, false)

	-- 去掉装备属性
	self:updateEquipAttr(player, false)

	--通知任务系统
	TaskCallBack.onDownEquip(player:getID(), self.itemID)
end

-- 更新装备属性
function Equipment:updateEquipAttr(player, isEquip)
	--基础属性
	for i = 1, table.getn(self.baseEffect or {}) do
		local attrID = self.baseEffect[i][1]
		if attrID > 0 then
			local attrValue = self.baseEffect[i][2]
			if isEquip then
				player:addAttrValue(attrID, attrValue)
			else
				player:addAttrValue(attrID, -attrValue)
			end
		end
	end

	--附加属性
	for i = 1, table.getn(self.addEffect or {}) do
		local attrID = self.addEffect[i][1]
		if attrID > 0 then
			local attrValue = self.addEffect[i][2]
			if isEquip then
				player:addAttrValue(attrID, attrValue)
			else
				player:addAttrValue(attrID, -attrValue)
			end
		end
	end

	--绑定属性
	if self:getBindFlag() then
		for i = 1, table.getn(self.bindEffect or {}) do
			local attrID = self.bindEffect[i][1]
			local attrValue = self.bindEffect[i][2]
			if isEquip then
				player:addAttrValue(attrID, attrValue)
			else
				player:addAttrValue(attrID, -attrValue)
			end
		end
	end

	--炼化属性
	if self.refiningEffect then
		local attr = self.refiningEffect.attr
		local attrID = attr[1]
		local attrValue = attr[2]
		if isEquip then
			player:addAttrValue(attrID, attrValue)
		else
			player:addAttrValue(attrID, -attrValue)
		end
	end
end

-- 更新角色装备外观
function Equipment:updatePlayerShowParts(player, equipConfig, onEquip)
	local buffHandler = player:getHandler(HandlerDef_Buff)
	local isTransCard = buffHandler:getTransCard()
	if equipConfig.SubClass == EquipmentClass.Weapon then
		local data = string.format("{%s,%d,%d}", onEquip and "true" or "false", equipConfig.ID,self:getRemouldAttrValue()*100)
		setPropValue(player:getPeer(), PLAYER_EQUIP_WEAPON,data)
	elseif equipConfig.EquipClass == ArmorSubClass.Clothes and not isTransCard then
		local bodyTex = 1
		local curBodyTex = player:getCurBodyTex()
		local curModelID = player:getModelID()
		if onEquip then
			-- 上装
			local str = ModelIDByClothDB[player:getSchool()][player:getSex()][equipConfig.UseNeedLvl]
			if str then
				local i,j = string.find(str,"%d+")
				local configModelID = toNumber(string.sub(str,i,j))

				local subStr = string.sub(str,j+2,string.len(str))
				i,j = string.find(subStr,"%d+")
				bodyTex = toNumber(string.sub(subStr,i,j))
				if configModelID and curModelID ~= configModelID then
					player:setModelID(configModelID)
				end
			end
		else
			-- 卸装
			local modelID = SchoolModelSwitch[player:getSex()][player:getSchool()]
			if curModelID ~= modelID then
				player:setModelID(modelID)
			end
		end
		player:setCurBodyTex(bodyTex)
		local showParts = string.format("{%d,%d}", player:getCurHeadTex(), player:getCurBodyTex())
		player:setShowParts(showParts)
	end
end
