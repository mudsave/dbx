--[[ItemManager.lua
描述:
	道具管理类
]]

-- 存储所有道具的数据表
tItemDB = {}
table.deepCopy(tWarrantDB, tItemDB)
table.deepCopy(tMedicamentDB, tItemDB)
table.deepCopy(tEquipmentDB, tItemDB)
-- 深度拷贝时，如果Key值重复就只会插入Value值，这里检测下是否有异常

ItemManager = class(nil, Singleton)

function ItemManager:__init()
	-- 记录所有道具
	self.items = {}
end

-- 生成装备基础属性
function ItemManager:generateEquipBaseAttr(propertyContext, itemConfig)
	propertyContext.baseEffect = {}
	if itemConfig.BaseAttrTypeA and itemConfig.BaseAttrValueA then
		table.insert(propertyContext.baseEffect,{itemConfig.BaseAttrTypeA,itemConfig.BaseAttrValueA})
	end
	if itemConfig.BaseAttrTypeB and itemConfig.BaseAttrValueB then
		table.insert(propertyContext.baseEffect,{itemConfig.BaseAttrTypeB,itemConfig.BaseAttrValueB})
	end
	if itemConfig.BaseAttrTypeC and itemConfig.BaseAttrValueC then
		table.insert(propertyContext.baseEffect,{itemConfig.BaseAttrTypeC,itemConfig.BaseAttrValueC})
	end
end

function ItemManager:randomAttr(propertyContext,attrTypeDB,itemConfig)
	local attrID
	while(1) do 
		attrID = attrTypeDB[math.random(table.getn(attrTypeDB))]
		local count = 0
		for _,attr in pairs(propertyContext.addEffect) do
			if attr[1] == attrID then
				count = count+1
			end
		end
		if count < 2 then
			break
		end
	end
	if AddAttrValueDB[attrID] then
		local multiple = 1
		local takingValueUnit = AddAttrValueDB[attrID].takingValueUnit
		if takingValueUnit == 0.1 then
			multiple = 10
		elseif takingValueUnit == 0.01 then
			multiple = 100
		elseif takingValueUnit == 0.001 then
			multiple = 1000
		elseif takingValueUnit == 0.0001 then
			multiple = 10000
		end
		local attrValueLimit = AddAttrValueDB[attrID][itemConfig.UseNeedLvl]
		if attrValueLimit then
			local attrValue = math.random(attrValueLimit.lower_limit * multiple, attrValueLimit.upper_limit * multiple)
			attrValue = attrValue / multiple
			table.insert(propertyContext.addEffect,{attrID,attrValue,0})
		else
			print("AddAttrValueDB未定义指定等级，attrID，UseNeedLvl", attrID, itemConfig.UseNeedLvl)
		end
	else
		print("AddAttrValueDB未定义指定属性，attrID", attrID)
	end
end

-- 生成装备附加属性,attrType作为生成装备时候根据附加属性类型来选择表
function ItemManager:generateEquipAddAttr(propertyContext, itemConfig, blueAttrNum, attrType)
	propertyContext.addEffect = {}
	if not blueAttrNum and itemConfig.AddAttrTypeBlueA and itemConfig.AddAttrValueBlueA then
		-- 走装备表配置
		local equipQuality = itemConfig.Quality
		table.insert(propertyContext.addEffect,{itemConfig.AddAttrTypeBlueA,itemConfig.AddAttrValueBlueA,0})
		if itemConfig.AddAttrTypeBlueB and itemConfig.AddAttrValueBlueB then
			table.insert(propertyContext.addEffect,{itemConfig.AddAttrTypeBlueB,itemConfig.AddAttrValueBlueB,0})
		else
			table.insert(propertyContext.addEffect,{0,0,0})
		end
		if itemConfig.AddAttrTypeBlueC and itemConfig.AddAttrValueBlueC then
			table.insert(propertyContext.addEffect,{itemConfig.AddAttrTypeBlueC,itemConfig.AddAttrValueBlueC,0})
		else
			table.insert(propertyContext.addEffect,{0,0,0})
		end
		if itemConfig.AddAttrTypePink and itemConfig.AddAttrValuePink and equipQuality >= ItemQuality.Pink then
			table.insert(propertyContext.addEffect,{itemConfig.AddAttrTypePink,itemConfig.AddAttrValuePink,0})
		else
			table.insert(propertyContext.addEffect,{0,0,0})
		end
		if itemConfig.AddAttrTypeGold and itemConfig.AddAttrValueGold and equipQuality >= ItemQuality.Gold then
			table.insert(propertyContext.addEffect,{itemConfig.AddAttrTypeGold,itemConfig.AddAttrValueGold,0})
		else
			table.insert(propertyContext.addEffect,{0,0,0})
		end
		if itemConfig.AddAttrTypeGreen and itemConfig.AddAttrValueGreen and equipQuality >= ItemQuality.Green then
			table.insert(propertyContext.addEffect,{itemConfig.AddAttrTypeGreen,itemConfig.AddAttrValueGreen,0})
		else
			table.insert(propertyContext.addEffect,{0,0,0})
		end
	else
		local AddAttrTypeList = {}
		-- 走属性表随机
		if not attrType then
			AddAttrTypeList = AddAttrTypeDB[itemConfig.SubClass]
		else
			AddAttrTypeList = EquipMakeAddAttrTypeDB[attrType]
		end
		if AddAttrTypeList then
			local attrTypeDB = AddAttrTypeList[itemConfig.EquipClass]
			if attrTypeDB then
				blueAttrNum = blueAttrNum or 0
				if blueAttrNum == 0 then
					local random = math.random(1, 100)
					if random <= 60 then
						blueAttrNum = 1
					elseif random <= 90 then
						blueAttrNum = 2
					else
						blueAttrNum = 3
					end
				end
				for i = 1, EquipBlueAttrMaxNum do
					if i <= blueAttrNum then
						self:randomAttr(propertyContext,attrTypeDB,itemConfig)
					else
						table.insert(propertyContext.addEffect,{0,0,0})
					end
				end
				local equipQuality = itemConfig.Quality
				if equipQuality == ItemQuality.Pink then
					self:randomAttr(propertyContext,attrTypeDB,itemConfig)
				elseif equipQuality == ItemQuality.Gold then
					for i = 1,2 do
						self:randomAttr(propertyContext,attrTypeDB,itemConfig)
					end
				elseif equipQuality == ItemQuality.Green then
					for i = 1,3 do
						self:randomAttr(propertyContext,attrTypeDB,itemConfig)
					end
				end
			else
				print("AddAttrTypeDB未定义指定装备，SubClass，EquipClass", itemConfig.SubClass, itemConfig.EquipClass)
			end
		end
	end
end

-- 生成装备绑定属性
function ItemManager:generateEquipBindAttr(propertyContext, itemConfig)
	local bindAttrValueDB = BindAttrValueDB[itemConfig.UseNeedLvl]
	if not bindAttrValueDB then
		return
	end
	propertyContext.bindEffect = {}
	for attrType, attrValue in pairs(bindAttrValueDB) do
		table.insert(propertyContext.bindEffect,{attrType,attrValue})
	end
end

-- 生成道具属性现场
function ItemManager:generatePropertyContext(item, itemConfig,level)
	-- 设置道具属性现场
	local propertyContext = {}
	propertyContext.expireTime = 0
	propertyContext.effect = 0
	propertyContext.identityFlag = true
	propertyContext.bindFlag = false
	-- 初次创建时设置道具等级
	propertyContext.level = level

	-- 设置到期时间
	if itemConfig.TimeLimitHours and itemConfig.TimeLimitHours > 0 then
		local expireTime = os.time() + itemConfig.TimeLimitHours * 3600
		propertyContext.expireTime = expireTime
	end

	-- 生成道具Effect
	if itemConfig.Class == ItemClass.Equipment then
		-- 装备类道具
		propertyContext.curDurability = itemConfig.MaxDurability * ConsumeDurabilityNeedFightTimes
		-- 基础属性
		self:generateEquipBaseAttr(propertyContext, itemConfig)
		if itemConfig.Quality == ItemQuality.NoIdentify then
			-- 设置未鉴定标志
			propertyContext.identityFlag = false
		else
			-- 附加属性
			self:generateEquipAddAttr(propertyContext, itemConfig)
		end
		-- 绑定属性
		self:generateEquipBindAttr(propertyContext, itemConfig)
	elseif itemConfig.Class == ItemClass.Medicament then
		-- 药品类道具
		if itemConfig.ReactType == MedicamentReactType.UseHpPool or itemConfig.ReactType == MedicamentReactType.UseMpPool then
			-- 生命池道具和法力池道具
			propertyContext.effect = itemConfig.ReactExtraParam1
			
		elseif itemConfig.SubClass == ItemSubClass.FlyingFlag then
			--飞行旗的飞行次数
			propertyContext.effect = itemConfig.ReactExtraParam2
		end
	else
		-- 凭证类道具，没有属性。。
	end
	
	-- 设置道具属性现场
	item:setPropertyContext(propertyContext)
end

-- 创建道具
function ItemManager:createItem(itemId, itemNum,level)
	local itemConfig = tItemDB[itemId]
	if not itemConfig then
		-- 找不到道具配置
		return nil
	end

	local item = nil
	if itemConfig.Class == ItemClass.Equipment then
		-- 装备
		item = g_itemFct:createEquipment(itemId, itemNum)
	elseif itemConfig.Class == ItemClass.Medicament then
		-- 药品
		item = g_itemFct:createMedicament(itemId, itemNum)
	elseif itemConfig.Class == ItemClass.Warrant then
		-- 凭证
		item = g_itemFct:createWarrant(itemId, itemNum)
	else
		-- 类型错误
	end

	if item then
		-- 生成道具属性现场
		self:generatePropertyContext(item, itemConfig,level)

		-- 记录一下
		self.items[item:getGuid()] = item
	end
	item:setDBState(ItemDBstate.save)
	return item
end

-- 根据属性现场创建道具
function ItemManager:createItemFromContext(propertyContext, itemNum,isDBCreate)
	local itemId = propertyContext.itemID
	local itemConfig = tItemDB[itemId]
	if not itemConfig then
		-- 找不到道具配置
		return nil
	end
	
	local item = nil
	if itemConfig.Class == ItemClass.Equipment then
		-- 装备
		item = g_itemFct:createEquipment(itemId, itemNum)
	elseif itemConfig.Class == ItemClass.Medicament then
		-- 药品
		item = g_itemFct:createMedicament(itemId, itemNum)
	elseif itemConfig.Class == ItemClass.Warrant then
		-- 凭证
		item = g_itemFct:createWarrant(itemId, itemNum)
	else
		-- 类型错误
	end

	if item then
		-- 设置道具属性现场
		item:setPropertyContext(propertyContext)

		-- 记录一下
		self.items[item:getGuid()] = item
	end
	if not isDBCreate then
		item:setDBState(ItemDBstate.save)
	end

	return item
end

-- 根据数据库读出来的数据创建道具
function ItemManager:createItemFromDB(player, itemsRecord)
	if not itemsRecord then
		return false
	end
	
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local packet = packetHandler:getPacket()
	local depotHandler = player:getHandler(HandlerDef_Depot)
	local depot = depotHandler:getDepot()
	local equipHandler = player:getHandler(HandlerDef_Equip)
	local equip = equipHandler:getEquip()

	-- 如果仓库容量大于默认的，就通知下客户端
	local depotCapacity = player:getDepotCapacity()
	if depotCapacity > DepotDefaultCapacity then
		depotHandler:setDepotCapability(depotCapacity)
		local event = Event.getEvent(ItemEvents_SC_CapacityChange, PackContainerID.Depot, depotCapacity)
		g_eventMgr:fireRemoteEvent(event, player)
	end

	-- 记录背包未添加成功的道具，比如策划改变了道具存放的包裹类型，更新后玩家第一次登陆此道具就会添加失败
	local tPacketUnAddItems = {}
	-- 记录仓库未添加成功的道具
	local tDepotUnAddItems = {}

	-- 目前装备道具、背包道具和仓库道具都一并读取了，以后仓库如果要验证密码的话，再单独开来
	for _, items in pairs(itemsRecord) do
		-- 根据数据库现场创建道具
		local item = self:createItemFromContext(items, items.number,true)
		if item then
			-- 添加道具到包裹容器指定物品格
			item:setDBID(items.ID)
			if items.containerID == PackContainerID.Packet then
				-- 添加到背包栏
				if not packet:addItemsToGrid(item, items.packIndex, items.gridIndex, false) then
					-- 记录一下
					table.insert(tPacketUnAddItems, item)
				end
			elseif items.containerID == PackContainerID.Depot then
				-- 添加到仓库栏
				if not depot:addItemsToGrid(item, items.packIndex, items.gridIndex, false) then
					-- 记录一下
					table.insert(tDepotUnAddItems, item)
				end
			elseif items.containerID == PackContainerID.Equip then
				-- 添加到装备栏
				if not equip:addItemsToGrid(item, items.packIndex, items.gridIndex, false) then
					-- 添加失败
				end
			else
				-- 容器错误
			end
			item:setDBState(ItemDBstate.normal)
		else
			-- 创建失败
		end
	end

	-- 统一处理下前面未添加成功的道具
	local unAddItemsNum = 0

	-- 处理背包的
	unAddItemsNum = table.getn(tPacketUnAddItems)
	if unAddItemsNum > 0 then
		for i = 1, unAddItemsNum do
			local itemGuid = tPacketUnAddItems[i]:getGuid()
			local result = packet:addItems(itemGuid, false)
			if result == AddItemsResult.SucceedPile then
				-- 叠加成功，销毁源道具
				packet:removeItem(itemGuid, 0, false)
			elseif result == AddItemsResult.Succeed then
				-- 添加成功
			else
				-- 添加失败了，打印一下Log把，并且销毁道具
				self:destroyItem(player,itemGuid)
			end
		end
	end

	-- 处理仓库的
	unAddItemsNum = table.getn(tDepotUnAddItems)
	if unAddItemsNum > 0 then
		for i = 1, unAddItemsNum do
			local itemGuid = tDepotUnAddItems[i]:getGuid()
			local result = depot:addItems(itemGuid, false)
			if result == AddItemsResult.SucceedPile then
				-- 叠加成功，销毁源道具
				depot:removeItem(itemGuid, 0, false)
			elseif result == AddItemsResult.Succeed then
				-- 添加成功
			else
				-- 添加失败了，打印一下Log把，并且销毁道具
				self:destroyItem(player,itemGuid)
			end
		end
	end

	-- 容器道具数据统一发给客户端
	packet:updateItemToClient()
	depot:updateItemToClient()
	equip:updateItemToClient()
	
	return true
end

-- 保存玩家道具数据
function ItemManager:saveItemsData(player)
	local playerDBID = player:getDBID()

	-- 记录要保存的道具数目
	local itemSaveNumber = 0
	-- 记录要保存的装备数目
	local equipSaveNumber = 0

	-- 记录要更新的道具数目
	local itemUpdateNumber = 0
	-- 记录要更新的装备数目
	local equipUpdateNumber = 0

	-- 记录要删除的道具数目
	local itemDeleteNumber = 0
	-- 记录要删除的装备数目
	local equipDeleteNumber = 0

	-- 设定每次保存的最大道具数
	local maxItemSaveNumber = 30
	local maxEquipSaveNumber = 5
	-- 目前数据库不支持传入二进制数据块，所以这里暂时先用字符串代替，存储过程解析字符串获得道具数据
	local itemStringData = ""
	local equipStringData = ""

	local itemUpdateString = ""
	local equipUpdateString = ""

	local itemDeleteString = ""
	local equipDeleteString = ""

	-- 处理玩家背包栏道具
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local packet = packetHandler:getPacket()
	for packindex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
		-- 获得包裹
		local pack = packet:getPack(packindex)
		if pack then
			-- 获得包裹道具
			for gridIndex = 1, pack:getCapability() do
				local item = pack:getGridItem(gridIndex)
				if item then
					-- 获得要保存的属性现场，各个属性之间用"-"符号来分割
					local propertyContext = item:getPropertyContext()
					if item:getDBState() == ItemDBstate.save then
						if item:getItemClass() ~= ItemClass.Equipment then
							itemStringData = itemStringData..propertyContext.itemID.."-"
							itemStringData = itemStringData..propertyContext.number.."-"
							itemStringData = itemStringData..propertyContext.level.."-"
							itemStringData = itemStringData..packet:getContainerID().."-"
							itemStringData = itemStringData..packindex.."-"
							itemStringData = itemStringData..gridIndex.."-"
							itemStringData = itemStringData..(propertyContext.bindFlag and 1 or 0).."-"
							itemStringData = itemStringData..propertyContext.expireTime.."-"
							itemStringData = itemStringData..(propertyContext.effect or 0).."-"
							if propertyContext.attr then
								itemStringData = itemStringData..toString(propertyContext.attr).."-"
							else
								itemStringData = itemStringData.."nil".."-"
							end
							itemSaveNumber = itemSaveNumber + 1
							if itemSaveNumber >= maxItemSaveNumber then
								print("itemSaveNumber................................"..itemSaveNumber)
								-- 请求数据库保存道具数据
								LuaDBAccess.itemSave(playerDBID, itemSaveNumber, itemStringData)
								-- 清空要保存的道具字符串
								itemStringData = ""
								-- 清零要保存的道具数目
								itemSaveNumber = 0
							end
						else
							equipStringData = equipStringData..propertyContext.itemID.."-"
							equipStringData = equipStringData..propertyContext.number.."-"
							equipStringData = equipStringData..propertyContext.level.."-"
							equipStringData = equipStringData..packet:getContainerID().."-"
							equipStringData = equipStringData..packindex.."-"
							equipStringData = equipStringData..gridIndex.."-"
							equipStringData = equipStringData..(propertyContext.bindFlag and 1 or 0).."-"
							equipStringData = equipStringData..propertyContext.curDurability.."-"
							if propertyContext.remouldAttr then
								equipStringData = equipStringData..toString(propertyContext.remouldAttr).."-"
							else
								equipStringData = equipStringData.."nil".."-"
							end
							if propertyContext.baseEffect then
								equipStringData = equipStringData..toString(propertyContext.baseEffect).."-"
							else
								equipStringData = equipStringData.."nil".."-"
							end
							if propertyContext.addEffect then
								equipStringData = equipStringData..toString(propertyContext.addEffect).."-"
							else
								equipStringData = equipStringData.."nil".."-"
							end
							if propertyContext.bindEffect then
								equipStringData = equipStringData..toString(propertyContext.bindEffect).."-"
							else
								equipStringData = equipStringData.."nil".."-"
							end
							if propertyContext.refiningEffect then
								equipStringData = equipStringData..toString(propertyContext.refiningEffect).."-"
							else
								equipStringData = equipStringData.."nil".."-"
							end
							equipStringData = equipStringData..(propertyContext.identityFlag and 1 or 0).."-"

							equipSaveNumber = equipSaveNumber + 1
							if equipSaveNumber >= maxEquipSaveNumber then
								-- 请求数据库保存装备数据
								LuaDBAccess.equipSave(playerDBID, equipSaveNumber, equipStringData)
								-- 清空要保存的装备字符串
								equipStringData = ""
								-- 清零要保存的装备数目
								equipSaveNumber = 0
							end
						end
					elseif item:getDBState() == ItemDBstate.update then
						local ID = item:getDBID()
						if item:getItemClass() ~= ItemClass.Equipment then
							itemUpdateString = itemUpdateString..ID.."-"
							itemUpdateString = itemUpdateString..propertyContext.number.."-"
							itemUpdateString = itemUpdateString..propertyContext.level.."-"
							itemUpdateString = itemUpdateString..packet:getContainerID().."-"
							itemUpdateString = itemUpdateString..packindex.."-"
							itemUpdateString = itemUpdateString..gridIndex.."-"
							itemUpdateString = itemUpdateString..(propertyContext.bindFlag and 1 or 0).."-"
							itemUpdateString = itemUpdateString..propertyContext.expireTime.."-"
							itemUpdateString = itemUpdateString..(propertyContext.effect or 0).."-"
							if propertyContext.attr then
								itemUpdateString = itemUpdateString..toString(propertyContext.attr).."-"
							else
								itemUpdateString = itemUpdateString.."nil".."-"
							end
							itemUpdateNumber = itemUpdateNumber + 1
							if itemUpdateNumber >= maxItemSaveNumber then
								print("itemUpdateNumber................................"..itemUpdateNumber)
								-- 请求数据库更新道具数据
								LuaDBAccess.itemUpdate(playerDBID, itemUpdateNumber, itemUpdateString)
								-- 清空要更新的道具字符串
								itemUpdateString = ""
								-- 清零要更新的道具数目
								itemUpdateNumber = 0
							end
						else
							equipUpdateString = equipUpdateString..ID.."-"
							equipUpdateString = equipUpdateString..propertyContext.number.."-"
							equipUpdateString = equipUpdateString..propertyContext.level.."-"
							equipUpdateString = equipUpdateString..packet:getContainerID().."-"
							equipUpdateString = equipUpdateString..packindex.."-"
							equipUpdateString = equipUpdateString..gridIndex.."-"
							equipUpdateString = equipUpdateString..(propertyContext.bindFlag and 1 or 0).."-"
							equipUpdateString = equipUpdateString..propertyContext.curDurability.."-"
							if propertyContext.remouldAttr then
								equipUpdateString = equipUpdateString..toString(propertyContext.remouldAttr).."-"
							else
								equipUpdateString = equipUpdateString.."nil".."-"
							end
							if propertyContext.baseEffect then
								equipUpdateString = equipUpdateString..toString(propertyContext.baseEffect).."-"
							else
								equipUpdateString = equipUpdateString.."nil".."-"
							end
							if propertyContext.addEffect then
								equipUpdateString = equipUpdateString..toString(propertyContext.addEffect).."-"
							else
								equipUpdateString = equipUpdateString.."nil".."-"
							end
							if propertyContext.bindEffect then
								equipUpdateString = equipUpdateString..toString(propertyContext.bindEffect).."-"
							else
								equipUpdateString = equipUpdateString.."nil".."-"
							end
							if propertyContext.refiningEffect then
								equipUpdateString = equipUpdateString..toString(propertyContext.refiningEffect).."-"
							else
								equipUpdateString = equipUpdateString.."nil".."-"
							end
							equipUpdateString = equipUpdateString..(propertyContext.identityFlag and 1 or 0).."-"

							equipUpdateNumber = equipUpdateNumber + 1
							if equipUpdateNumber >= maxEquipSaveNumber then
								-- 请求数据库更新装备数据
								LuaDBAccess.equipUpdate(playerDBID, equipUpdateNumber, equipUpdateString)
								-- 清空要更新的装备字符串
								equipUpdateString = ""
								-- 清零要保更新的装备数目
								equipUpdateNumber = 0
							end
						end
					end
					self.items[item:getGuid()] = nil
				end
			end
		end
	end

	-- 处理玩家仓库栏道具
	local depotHandler = player:getHandler(HandlerDef_Depot)
	local depot = depotHandler:getDepot()
	for packindex = DepotPackIndex.First, DepotPackIndex.MaxNum-1 do
		local depotPack = depot:getPack(packindex)
		for gridIndex = 1, depotPack:getCapability() do
			local item = depotPack:getGridItem(gridIndex)
			if item then
				-- 获得要保存的属性现场，各个属性之间用"-"符号来分割
				local propertyContext = item:getPropertyContext()
				if item:getDBState() == ItemDBstate.save then
					if item:getItemClass() ~= ItemClass.Equipment then
						itemStringData = itemStringData..propertyContext.itemID.."-"
						itemStringData = itemStringData..propertyContext.number.."-"
						itemStringData = itemStringData..propertyContext.level.."-"
						itemStringData = itemStringData..depot:getContainerID().."-"
						itemStringData = itemStringData..packindex.."-"
						itemStringData = itemStringData..gridIndex.."-"
						itemStringData = itemStringData..(propertyContext.bindFlag and 1 or 0).."-"
						itemStringData = itemStringData..propertyContext.expireTime.."-"
						itemStringData = itemStringData..(propertyContext.effect or 0).."-"
						if propertyContext.attr then
							itemStringData = itemStringData..toString(propertyContext.attr).."-"
						else
							itemStringData = itemStringData.."nil".."-"
						end
						itemSaveNumber = itemSaveNumber + 1
						if itemSaveNumber >= maxItemSaveNumber then
							-- 请求数据库保存道具数据
							LuaDBAccess.itemSave(playerDBID, itemSaveNumber, itemStringData)
							-- 清空要保存的道具字符串
							itemStringData = ""
							-- 清零要保存的道具数目
							itemSaveNumber = 0
						end
					else
						equipStringData = equipStringData..propertyContext.itemID.."-"
						equipStringData = equipStringData..propertyContext.number.."-"
						equipStringData = equipStringData..propertyContext.level.."-"
						equipStringData = equipStringData..depot:getContainerID().."-"
						equipStringData = equipStringData..packindex.."-"
						equipStringData = equipStringData..gridIndex.."-"
						equipStringData = equipStringData..(propertyContext.bindFlag and 1 or 0).."-"
						equipStringData = equipStringData..propertyContext.curDurability.."-"
						if propertyContext.remouldAttr then
							equipStringData = equipStringData..toString(propertyContext.remouldAttr).."-"
						else
							equipStringData = equipStringData.."nil".."-"
						end
						if propertyContext.baseEffect then
							equipStringData = equipStringData..toString(propertyContext.baseEffect).."-"
						else
							equipStringData = equipStringData.."nil".."-"
						end
						if propertyContext.addEffect then
							equipStringData = equipStringData..toString(propertyContext.addEffect).."-"
						else
							equipStringData = equipStringData.."nil".."-"
						end
						if propertyContext.bindEffect then
							equipStringData = equipStringData..toString(propertyContext.bindEffect).."-"
						else
							equipStringData = equipStringData.."nil".."-"
						end
						if propertyContext.refiningEffect then
							equipStringData = equipStringData..toString(propertyContext.refiningEffect).."-"
						else
							equipStringData = equipStringData.."nil".."-"
						end
						equipStringData = equipStringData..(propertyContext.identityFlag and 1 or 0).."-"

						equipSaveNumber = equipSaveNumber + 1
						if equipSaveNumber >= maxEquipSaveNumber then
							-- 请求数据库保存装备数据
							LuaDBAccess.equipSave(playerDBID, equipSaveNumber, equipStringData)
							-- 清空要保存的装备字符串
							equipStringData = ""
							-- 清零要保存的装备数目
							equipSaveNumber = 0
						end
					end
				elseif item:getDBState() == ItemDBstate.update then
					local ID = item:getDBID()
					if	item:getItemClass() ~= ItemClass.Equipment then
						itemUpdateString = itemUpdateString..ID.."-"
						itemUpdateString = itemUpdateString..propertyContext.number.."-"
						itemUpdateString = itemUpdateString..propertyContext.level.."-"
						itemUpdateString = itemUpdateString..depot:getContainerID().."-"
						itemUpdateString = itemUpdateString..packindex.."-"
						itemUpdateString = itemUpdateString..gridIndex.."-"
						itemUpdateString = itemUpdateString..(propertyContext.bindFlag and 1 or 0).."-"
						itemUpdateString = itemUpdateString..propertyContext.expireTime.."-"
						itemUpdateString = itemUpdateString..(propertyContext.effect or 0).."-"
						if propertyContext.attr then
							itemUpdateString = itemUpdateString..toString(propertyContext.attr).."-"
						else
							itemUpdateString = itemUpdateString.."nil".."-"
						end
						itemUpdateNumber = itemUpdateNumber + 1
						if itemUpdateNumber >= maxItemSaveNumber then
							-- 请求数据库保存道具数据
							LuaDBAccess.itemUpdate(playerDBID, itemUpdateNumber, itemUpdateString)
							-- 清空要保存的道具字符串
							itemUpdateString = ""
							-- 清零要保存的道具数目
							itemUpdateNumber = 0
						end
					else
						equipUpdateString = equipUpdateString..ID.."-"
						equipUpdateString = equipUpdateString..propertyContext.number.."-"
						equipUpdateString = equipUpdateString..propertyContext.level.."-"
						equipUpdateString = equipUpdateString..depot:getContainerID().."-"
						equipUpdateString = equipUpdateString..packindex.."-"
						equipUpdateString = equipUpdateString..gridIndex.."-"
						equipUpdateString = equipUpdateString..(propertyContext.bindFlag and 1 or 0).."-"
						equipUpdateString = equipUpdateString..propertyContext.curDurability.."-"
						if propertyContext.remouldAttr then
							equipUpdateString = equipUpdateString..toString(propertyContext.remouldAttr).."-"
						else
							equipUpdateString = equipUpdateString.."nil".."-"
						end
						if propertyContext.baseEffect then
							equipUpdateString = equipUpdateString..toString(propertyContext.baseEffect).."-"
						else
							equipUpdateString = equipUpdateString.."nil".."-"
						end
						if propertyContext.addEffect then
							equipUpdateString = equipUpdateString..toString(propertyContext.addEffect).."-"
						else
							equipUpdateString = equipUpdateString.."nil".."-"
						end
						if propertyContext.bindEffect then
							equipUpdateString = equipUpdateString..toString(propertyContext.bindEffect).."-"
						else
							equipUpdateString = equipUpdateString.."nil".."-"
						end
						if propertyContext.refiningEffect then
							equipUpdateString = equipUpdateString..toString(propertyContext.refiningEffect).."-"
						else
							equipUpdateString = equipUpdateString.."nil".."-"
						end
						equipUpdateString = equipUpdateString..(propertyContext.identityFlag and 1 or 0).."-"

						equipUpdateNumber = equipUpdateNumber + 1
						if equipUpdateNumber >= maxEquipSaveNumber then
							-- 请求数据库保存装备数据
							LuaDBAccess.equipUpdate(playerDBID, equipUpdateNumber, equipUpdateString)
							-- 清空要保存的装备字符串
							equipUpdateString = ""
							-- 清零要保存的装备数目
							equipUpdateNumber = 0
						end
					end
				end
				self.items[item:getGuid()] = nil
			end
		end
	end

	-- 处理玩家装备栏道具
	local equipHandler = player:getHandler(HandlerDef_Equip)
	local equip = equipHandler:getEquip()
	local equipPack = equip:getPack()
	for gridIndex = 1, equipPack:getCapability() do
		local item = equipPack:getGridItem(gridIndex)
		if item then 
			-- 获得要保存的属性现场，各个属性之间用"-"符号来分割
			local propertyContext = item:getPropertyContext()
			if item:getDBState() == ItemDBstate.save then
				equipSaveNumber = equipSaveNumber + 1
				equipStringData = equipStringData..propertyContext.itemID.."-"
				equipStringData = equipStringData..propertyContext.number.."-"
				equipStringData = equipStringData..propertyContext.level.."-"
				equipStringData = equipStringData..equip:getContainerID().."-"
				equipStringData = equipStringData..EquipPackIndex.Default.."-"
				equipStringData = equipStringData..gridIndex.."-"
				equipStringData = equipStringData..(propertyContext.bindFlag and 1 or 0).."-"
				equipStringData = equipStringData..propertyContext.curDurability.."-"
				if propertyContext.remouldAttr then
					equipStringData = equipStringData..toString(propertyContext.remouldAttr).."-"
				else
					equipStringData = equipStringData.."nil".."-"
				end
				if propertyContext.baseEffect then
					equipStringData = equipStringData..toString(propertyContext.baseEffect).."-"
				else
					equipStringData = equipStringData.."nil".."-"
				end
				if propertyContext.addEffect then
					equipStringData = equipStringData..toString(propertyContext.addEffect).."-"
				else
					equipStringData = equipStringData.."nil".."-"
				end
				if propertyContext.bindEffect then
					equipStringData = equipStringData..toString(propertyContext.bindEffect).."-"
				else
					equipStringData = equipStringData.."nil".."-"
				end
				if propertyContext.refiningEffect then
					equipStringData = equipStringData..toString(propertyContext.refiningEffect).."-"
				else
					equipStringData = equipStringData.."nil".."-"
				end
				equipStringData = equipStringData..(propertyContext.identityFlag and 1 or 0).."-"

				if equipSaveNumber >= maxEquipSaveNumber then
					-- 请求数据库保存装备数据
					LuaDBAccess.equipSave(playerDBID, equipSaveNumber, equipStringData)
					-- 清空要保存的装备字符串
					equipStringData = ""
					-- 清零要保存的装备数目
					equipSaveNumber = 0
				end
			elseif item:getDBState() == ItemDBstate.update then
				equipUpdateNumber = equipUpdateNumber + 1
				local ID = item:getDBID()
				equipUpdateString = equipUpdateString..ID.."-"
				equipUpdateString = equipUpdateString..propertyContext.number.."-"
				equipUpdateString = equipUpdateString..propertyContext.level.."-"
				equipUpdateString = equipUpdateString..equip:getContainerID().."-"
				equipUpdateString = equipUpdateString..EquipPackIndex.Default.."-"
				equipUpdateString = equipUpdateString..gridIndex.."-"
				equipUpdateString = equipUpdateString..(propertyContext.bindFlag and 1 or 0).."-"
				equipUpdateString = equipUpdateString..propertyContext.curDurability.."-"
				if propertyContext.remouldAttr then
					equipUpdateString = equipUpdateString..toString(propertyContext.remouldAttr).."-"
				else
					equipUpdateString = equipUpdateString.."nil".."-"
				end
				if propertyContext.baseEffect then
					equipUpdateString = equipUpdateString..toString(propertyContext.baseEffect).."-"
				else
					equipUpdateString = equipUpdateString.."nil".."-"
				end
				if propertyContext.addEffect then
					equipUpdateString = equipUpdateString..toString(propertyContext.addEffect).."-"
				else
					equipUpdateString = equipUpdateString.."nil".."-"
				end
				if propertyContext.bindEffect then
					equipUpdateString = equipUpdateString..toString(propertyContext.bindEffect).."-"
				else
					equipUpdateString = equipUpdateString.."nil".."-"
				end
				if propertyContext.refiningEffect then
					equipUpdateString = equipUpdateString..toString(propertyContext.refiningEffect).."-"
				else
					equipUpdateString = equipUpdateString.."nil".."-"
				end
				equipUpdateString = equipUpdateString..(propertyContext.identityFlag and 1 or 0).."-"

				if equipUpdateNumber >= maxEquipSaveNumber then
					-- 请求数据库保存装备数据
					LuaDBAccess.equipUpdate(playerDBID, equipUpdateNumber, equipUpdateString)
					-- 清空要保存的装备字符串
					equipUpdateString = ""
					-- 清零要保存的装备数目
					equipUpdateNumber = 0
				end
			end
			self.items[item:getGuid()] = nil
		end
	end

	-- 最后剩余的道具也保存下
	if itemSaveNumber > 0 then
		-- 请求数据库保存道具数据
		LuaDBAccess.itemSave(playerDBID, itemSaveNumber, itemStringData)
	end
	-- 最后剩余的装备也保存下
	if equipSaveNumber > 0 then
		-- 请求数据库保存装备数据
		LuaDBAccess.equipSave(playerDBID, equipSaveNumber, equipStringData)
	end

	-- 最后剩余的道具也更新下
	if itemUpdateNumber > 0 then
		-- 请求数据库更新道具数据
		LuaDBAccess.itemUpdate(playerDBID, itemUpdateNumber, itemUpdateString)
	end
	-- 最后剩余的装备也更新下
	if equipUpdateNumber > 0 then
		-- 请求数据库更新装备数据
		LuaDBAccess.equipUpdate(playerDBID, equipUpdateNumber, equipUpdateString)
	end
	
	--判断回购界面是否有物品
	if next(g_tradeMgr:getBuybackInfo()) ~= nil then 
		for itemGuid,v in pairs(g_tradeMgr:getBuybackInfo()) do
			self:disBuybackinfo(player,itemGuid)
		end 
		--设回默认值
		g_tradeMgr:initBuyBackInfo()
	end 
	
	for _,ID in pairs(packetHandler:getDestroyItemlist()) do
		itemDeleteString = itemDeleteString..ID.."-"
		itemDeleteNumber = itemDeleteNumber + 1
	end

	for _,ID in pairs(packetHandler:getDestroyEquipList()) do
		equipDeleteString = equipDeleteString..ID.."-"
		equipDeleteNumber = equipDeleteNumber + 1
	end
	
	-- 最后删除道具
	if itemDeleteNumber > 0 then
		-- 请求数据库删除道具数据
		LuaDBAccess.itemDelete(playerDBID, itemDeleteNumber, itemDeleteString)
	end
	-- 最后删除装备
	if equipDeleteNumber > 0 then
		-- 请求数据库删除装备数据
		LuaDBAccess.equipDelete(playerDBID, equipDeleteNumber, equipDeleteString)
	end
end


-- 销毁道具
function ItemManager:destroyItem(player,itemGuid)
	local item = self.items[itemGuid]
	if item then
		local ID = item:getDBID()
		if	item:getItemClass() ~= ItemClass.Equipment then
			player:getHandler(HandlerDef_Packet):addDestroyItemList(ID)
		else
			player:getHandler(HandlerDef_Packet):addDestroyEquipList(ID)
		end
		release(item)
	end
	self.items[itemGuid] = nil
end

--回购界面道具销毁
function ItemManager:disBuybackinfo(player,itemGuid)
	local item = self.items[itemGuid]
	if item then
		local ID = item:getDBID()  print("ID", ID)
		if	item:getItemClass() ~= ItemClass.Equipment then
			player:getHandler(HandlerDef_Packet):addDestroyItemList(ID)
		else
			player:getHandler(HandlerDef_Packet):addDestroyEquipList(ID)
		end
		release(item)
	end
	self.items[itemGuid] = nil
end

-- 获得道具
function ItemManager:getItem(itemGuid)
	return self.items[itemGuid]
end

-- 根据容器ID，包裹ID，和格子得到物品 （这种方式限定于最大叠加数是一）
function ItemManager:getItemByPosition(player,containerID,packIndex,gridIndex)
	-- 获得各个容器
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local packet = packetHandler:getPacket()
	local depotHandler = player:getHandler(HandlerDef_Depot)
	local depot = depotHandler:getDepot()
	local equipHandler = player:getHandler(HandlerDef_Equip)
	local result = 1
	local item = nil
	local equip = equipHandler:getEquip()
	if containerID == PackContainerID.Packet then
		result, item = packet:getItems(packIndex,gridIndex)
	elseif containerID == PackContainerID.Depot then
		result, item = depot:getItems(packIndex,gridIndex)
	elseif containerID == PackContainerID.Equip then
		result, item = equip:getItems(packIndex,gridIndex)
	end
	return item
end

-- 加载道具使用次数
function ItemManager:loadItemUseTimes(player, useTimesRecord)
	if not useTimesRecord or table.size(useTimesRecord) <= 0 then
		return
	end
	local packetHandler = player:getHandler(HandlerDef_Packet)
	packetHandler:loadItemUseTimes(useTimesRecord)
end

function ItemManager:updateItemUseTimes(player)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	packetHandler:updateItemUseTimes()
end

--打开装备鉴定界面
function ItemManager:openEquipAppraisal(player)
	local event = Event.getEvent(ItemEvents_SC_OpenEquipAppraisal)
	g_eventMgr:fireRemoteEvent(event, player)
end

--打开装备修理界面
function ItemManager:openRepairEquipment(player)
	local event = Event.getEvent(ItemEvents_SC_RepairEquipment)
	g_eventMgr:fireRemoteEvent(event, player)
end 

--打开兑换物品界面
function ItemManager:exchangeProps(player)
	local event = Event.getEvent(ItemEvents_SC_OpenExchangeProps)
	g_eventMgr:fireRemoteEvent(event, player)
end

--兑换物品
function ItemManager:onExchangeProps(player,itemID,num)
	local itemConfig  = tItemDB[itemID]
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if itemConfig.SubClass == ItemSubClass.Beast then
		local specificItem = ExchangePropsDB.specific
		local exchangeMat = ExchangePropsDB.common
		local additemID = specificItem[itemID]
		local flag = false
		for i = 1,num do
			if itemID then
				if packetHandler:getNumByItemID(itemID) < 1 then
					print("--222-----材料不足。。。")
					break
				end
			end
			
			local breakFlag = false
			for _,matInfo in pairs(exchangeMat) do
				local matID = matInfo[1]
				local count = matInfo[2]
				local curcount = packetHandler:getNumByItemID(matID)
				if count > curcount then
					print("--11------材料不足。。。")
					breakFlag = true
					break
				end
			end
			if breakFlag then
				break
			end

			if not packetHandler:canAddPacket(additemID, 1, false) then
				print("背包空间不足无法兑换。")
				break
			end

			for _,matInfo in pairs(exchangeMat) do
				local matID = matInfo[1]
				local count = matInfo[2]
				packetHandler:removeByItemId(matID, count)
			end
			print("加物品，加物品。加物品。。")
			packetHandler:removeByItemId(itemID, 1)
			packetHandler:addItemsToPacket(additemID, 1)
			flag = true
		end
		if flag then
			local event = Event.getEvent(ItemEvents_SC_ExchangePropsResult)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

function ItemManager.getInstance()
	return ItemManager()
end
