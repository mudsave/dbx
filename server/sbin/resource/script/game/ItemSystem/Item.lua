--[[Item.lua
描述:
	物品基类
]]

Item = class()

function Item:__init(itemID, itemNum)
	-- 道具大类
	self.class = 0
	-- 全局唯一标识
	self.guid = ""
	-- 道具ID
	self.itemID = itemID
	-- 道具数目
	self.itemNum = itemNum
	-- 所在物品格索引
	self.gridIndex = -1
	-- 所在容器ID
	self.containerID = -1
	-- 记录所在包裹，方便绑定或者锁定等标志更新给客户端
	self.pack = nil
	-- 到期时间，物品创建的时候，服务器时间加上策划设定的时间就是到期时间
	self.expireTime = 0
	-- 整理排序优先级，数值越大优先级越高
	self.sortPriority = -1
	-- 设置整理排序优先级
	self:setSortPriority()
	-- 锁定标志
	self.lockFlag = false
	-- 物品生成的等级
	self.itemLvl = nil 
end

function Item:__release()
end

-- 获得道具大类
function Item:getItemClass()
	return self.class
end

-- 获得道具子类
function Item:getSubClass()
	local itemConfig = tItemDB[self.itemID]
	return itemConfig.SubClass
end

-- 设置GUID
function Item:setGuid(guid)
	self.guid = guid
end

-- 获得GUID
function Item:getGuid()
	return self.guid
end

-- 获得道具ID
function Item:getItemID()
	return self.itemID
end

-- 设置道具数目
function Item:setNumber(number)
	self.itemNum = number
end

-- 获得道具数目
function Item:getNumber()
	return self.itemNum
end

-- 获得包裹索引
function Item:getPackIndex()
	return self.pack:getPackIndex()
end

-- 设置物品格索引
function Item:setGridIndex(gridIndex)
	self.gridIndex = gridIndex
end

-- 获得物品格索引
function Item:getGridIndex()
	return self.gridIndex
end

-- 设置所在容器ID
function Item:setContainerID(containerID)
	self.containerID = containerID
end

-- 获得所在容器ID
function Item:getContainerID()
	return self.containerID
end

-- 设置所在包裹
function Item:setPack(pack)
	self.pack = pack
end

-- 获得所在包裹
function Item:getPack()
	return self.pack
end

-- 设置道具到期时间
function Item:setExpireTime(expireTime)
	self.expireTime = expireTime
end

-- 获得道具到期时间
function Item:getExpireTime()
	return self.expireTime
end

-- 获得道具绑定标志
function Item:getBindFlag()
	local itemConfig = tItemDB[self.itemID]
	return not itemConfig.CanTrade
end

-- 判断是否是任务道具，如果是任务道具，添加到背包容器时只能放任务包裹
function Item:isTaskItem()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return false
	end
	return itemConfig.SubClass == ItemSubClass.Task
end

-- 判断是否是战斗道具
function Item:isBattleItem()
	local medicamentConfig = tMedicamentDB[self.itemID]
	if not medicamentConfig then
		return false
	end
	return medicamentConfig.UseNeedState >= MedicamentUseState.Fight
end

-- 获得最大叠加数目
function Item:getPileNum()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return 0
	end
	return itemConfig.MaxPileNum
end

-- 获得售卖金钱数目
function Item:getSalePrice()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return 0
	end
	return itemConfig.SaleMoneyNum or 0
end

-- 获得物品品质等级
function Item:getQuality()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return 0
	end
	return itemConfig.Quality or 0
end

-- 获得物品使用等级
function Item:getUseNeedLvl()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return 0
	end
	return itemConfig.UseNeedLvl or 1
end

-- 设置物品排序优先级
function Item:setSortPriority()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return
	end
	
	if itemConfig.Class == ItemClass.Equipment then
		if itemConfig.SubClass == EquipmentClass.Weapon then 
			if itemConfig.EquipClass == WeaponSubClass.Knife then 
				self.sortPriority = 1
			elseif itemConfig.EquipClass == WeaponSubClass.Spear then
				self.sortPriority = 2
			elseif itemConfig.EquipClass == WeaponSubClass.Sword then
				self.sortPriority = 3
			elseif itemConfig.EquipClass == WeaponSubClass.Crossbow then
				self.sortPriority = 4
			elseif itemConfig.EquipClass == WeaponSubClass.Fan then
				self.sortPriority = 5
			elseif itemConfig.EquipClass == WeaponSubClass.Rod then
				self.sortPriority = 6
			else
				self.sortPriority = 9
			end 
		elseif itemConfig.SubClass == EquipmentClass.Armor then 
			if itemConfig.EquipClass == ArmorSubClass.Helmet then 
				self.sortPriority = 11
			elseif itemConfig.EquipClass == ArmorSubClass.Shoulder then
				self.sortPriority = 12
			elseif itemConfig.EquipClass == ArmorSubClass.Clothes then
				self.sortPriority = 13
			elseif itemConfig.EquipClass == ArmorSubClass.Trousers then
				self.sortPriority = 14
			elseif itemConfig.EquipClass == ArmorSubClass.Shoes then
				self.sortPriority = 15
			else
				self.sortPriority = 19
			end 
		elseif itemConfig.SubClass == EquipmentClass.Adorn then 
			if itemConfig.EquipClass == AdornSubClass.Necklace then 
				self.sortPriority = 21
			elseif itemConfig.EquipClass == AdornSubClass.Amulet then
				self.sortPriority = 22
			elseif itemConfig.EquipClass == AdornSubClass.Ring then
				self.sortPriority = 23
			else 
				self.sortPriority = 29
			end 
		else 
			self.sortPriority = 50
		end 
	elseif itemConfig.Class == ItemClass.Medicament then
		if itemConfig.SubClass == ItemSubClass.Medicament then 
			self.sortPriority = 51
		elseif itemConfig.SubClass == ItemSubClass.reservePool then
			self.sortPriority = 52
		elseif itemConfig.SubClass == ItemSubClass.LinglongPill then
			self.sortPriority = 53
		elseif itemConfig.SubClass == ItemSubClass.Function then
			self.sortPriority = 55
		elseif itemConfig.SubClass == ItemSubClass.ChangeCard then
			self.sortPriority = 56
		elseif itemConfig.SubClass == ItemSubClass.FlyingFlag then
			self.sortPriority = 57
		elseif itemConfig.SubClass == ItemSubClass.Food then
			self.sortPriority = 58
		else
			self.sortPriority =100
		end 
	elseif itemConfig.Class == ItemClass.Warrant then
		if itemConfig.SubClass == ItemSubClass.Material then 
			self.sortPriority = 101
		elseif itemConfig.SubClass == ItemSubClass.Drawing then
			self.sortPriority = 102
		elseif itemConfig.SubClass == ItemSubClass.manufacMat then
			self.sortPriority = 103
		elseif itemConfig.SubClass == ItemSubClass.Runes then
			self.sortPriority = 104
		elseif itemConfig.SubClass == ItemSubClass.SkillBook then
			self.sortPriority = 105
		elseif itemConfig.SubClass == ItemSubClass.Beast then
			self.sortPriority = 106
		elseif itemConfig.SubClass == ItemSubClass.LingShi then
			self.sortPriority = 107
		elseif itemConfig.SubClass == ItemSubClass.Function then
			self.sortPriority = 108
		elseif itemConfig.SubClass == ItemSubClass.Trophy then
			self.sortPriority = 109
		else
			self.sortPriority =150
		end 
	else
		self.sortPriority = 200
	end
	if self.sortPriority == -1 then
		print("设置道具整理排序优先级错误，itemID = ", self.itemID)
	end
	--print(self.itemID, self.sortPriority)
end

-- 得到物品排序优先级
function Item:getSortPriority()
	return self.sortPriority
end

-- 设置物品的锁定标志
function Item:setLockFlag(lockFlag)
	if self.lockFlag ~= lockFlag then
		self.lockFlag = lockFlag
		if self.pack then
			self.pack:setChange(self.gridIndex)
		end
	end
end

-- 获取物品的锁定标志
function Item:getLockFlag()
	return self.lockFlag
end

-- 设置物品生成的等级
function Item:setItemLvl(lvl)
	self.itemLvl = lvl 
end

-- 获得物品生成的等级
function Item:getItemLvl()
	return self.itemLvl
end

-- 治疗类道具类型对应表
local tHealItems =
{
	[MedicamentReactType.ChangeHp] = true,
	[MedicamentReactType.ChangeMp] = true,
	[MedicamentReactType.ChangeHpMp] = true,
	[MedicamentReactType.UseHpPool] = true,
	[MedicamentReactType.UseMpPool] = true,
}
-- 判断道具是否是治疗类道具
function Item:isHealItem()
	local itemConfig = tItemDB[self.itemID]
	if not itemConfig then
		return false
	end
	if tHealItems[itemConfig.ReactType] then
		return true
	end
	return false
end
