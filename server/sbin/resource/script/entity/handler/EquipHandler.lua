--[[EquipHandler.lua
描述：
	实体的装备handler
--]]

EquipHandler = class()

function EquipHandler:__init(entity)
	self._entity = entity
	-- 装备栏
	self.equip = Equip(self._entity)
end

function EquipHandler:__release()
	self._entity = nil
	release(self.equip)
	self.equip = nil
end

-- 获取装备栏
function EquipHandler:getEquip()
	return self.equip
end

-- 绑定装备
function EquipHandler:bindEquip(equip)
	if not instanceof(equip, Equipment) then
		return
	end
	if equip:getContainerID() ~= PackContainerID.Packet then
		-- 只能操作背包栏的装备
		return
	end
	if equip:getBindFlag() then
		-- 已经绑定了
		return
	end
	-- 通知客户端
	equip:setBindFlag(Bind)
end

-- 解绑装备
function EquipHandler:unBindEquip(equip)
	if not instanceof(equip, Equipment) then
		return
	end
	if equip:getContainerID() ~= PackContainerID.Packet then
		-- 只能操作背包栏的装备
		return
	end
	if not equip:getBindFlag() then
		-- 没有绑定
		return
	end
	-- 通知客户端
	equip:setBindFlag(UnBind)
end

-- 战斗结束后装备耐久度处理
function EquipHandler:onFightEnd(isDead,times)
	local times = times or 1
	local equip = self:getEquip()
	local equipPack = equip:getPack()
	for gridIndex = 1, equipPack:getCapability() do
		local equipment = equipPack:getGridItem(gridIndex)
		if equipment then
			local durability = equipment:getCurDurability()
			if durability > 0 then
				if isDead then
					-- 角色死亡身上所有装备消耗一点耐久度，这里减去消耗常量，客户端显示就是减少一点
					local redu = times * math.floor(durability * PunishDurReductionPerc/100)
					durability = durability - redu
					if durability < 0 then
						durability = 0
					end
				else
					-- 角色未死亡的话，每50场战斗减一点耐久
					durability = durability - 1
				end
				equipment:setCurDurability(durability)
			end
		end
	end
	equipPack:updateClient()
end

-- 鉴定装备
function EquipHandler:identityEquip(equip)
	local itemConfig = tItemDB[equip:getItemID()]
	if not itemConfig then
		-- 找不到道具配置
		return
	end
	if equip:getIdentityFlag() then
		-- 已经鉴定过了
		return
	end
	-- 随机出装备鉴定后的品质
	local equipQuality = ItemQuality.NoIdentify
	local random = math.random(1, 10000)
	if random <= 5900 then
		-- 蓝色
		equipQuality = ItemQuality.Blue
	elseif random <= 8900 then
		-- 粉色
		equipQuality = ItemQuality.Pink
	elseif random <= 9900 then
		-- 金色
		equipQuality = ItemQuality.Gold
	else
		-- 绿色
		equipQuality = ItemQuality.Green
	end
	-- 根据品质生成附加属性
	local itemConfig1 = {}
	table.copy(itemConfig,itemConfig1)
	itemConfig1.Quality = equipQuality
	local propertyContext = equip:getPropertyContext()
	g_itemMgr:generateEquipAddAttr(propertyContext, itemConfig1)
	-- 记录新属性
	equip:setEffectEx(propertyContext)
	-- 设置鉴定标志
	equip:setIdentityFlag(true)
	-- 更新到客户端
	equip:getPack():updateItemsToClient(equip)
	local event = Event.getEvent(ItemEvents_SC_EquipAppraisalResult)
	g_eventMgr:fireRemoteEvent(event, self._entity)
end

--获得所带武器ID
function EquipHandler:getWeaponID()
	local equipMent = self.equip:getPack():getGridItem(WeaponGridIndex)
	if equipMent then
		return equipMent:getItemID()
	end
end

-- 移除指定GUID的道具
function EquipHandler:removeItem(itemGuid, removeNum)
	return self.equip:removeItem(itemGuid, removeNum, true)
end

--获得套装属性
function EquipHandler:setSuitAttr(onEquip,item)
	self.equip:setSuitAttr(onEquip, item)
end