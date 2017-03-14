--[[ItemSystem.lua
描述:
	物品系统，处理客户端的消息请求
]]

require "game.ItemSystem.Item"
require "game.ItemSystem.Equipment"
require "game.ItemSystem.Medicament"
require "game.ItemSystem.Warrant"
require "game.ItemSystem.Pack"
require "game.ItemSystem.Packet"
require "game.ItemSystem.Depot"
require "game.ItemSystem.Equip"
require "game.ItemSystem.ItemFactory"
require "game.ItemSystem.ItemManager"
require "game.ItemSystem.ItemUseFun"
require "game.ItemSystem.ItemEffect"

ItemSystem = class(EventSetDoer, Singleton)

function ItemSystem:__init()
	self._doer =
	{
		-- 移动道具
		[ItemEvents_CS_MoveItem]				= ItemSystem.onMoveItem,
		-- 销毁道具
		[ItemEvents_CS_DestroyItem]				= ItemSystem.onDestroyItem,
		-- 整理道具
		[ItemEvents_CS_PackUp]					= ItemSystem.onPackUp,
		-- 使用药品
		[ItemEvents_CS_UseMedicament]			= ItemSystem.onUseMedicament,
		-- 拆分道具
		[ItemEvents_CS_SplitItem]				= ItemSystem.onSplitItem,
		-- 存放银两
		[ItemEvents_CS_StoreMoney]				= ItemSystem.onStoreMoney,
		-- 取走银两
		[ItemEvents_CS_FetchMoney]				= ItemSystem.onFetchMoney,
		-- 扩充仓库
		[ItemEvents_CS_ExtendDepot]				= ItemSystem.onExtendDepot,
		--请求鉴定装备
		[ItemEvents_CS_RequestEquipAppraisal]	= ItemSystem.onAppraisalEeuip,
		--兑换物品
		[ItemEvents_CS_RequestExchangeProps]	= ItemSystem.onExchangeProps,
		--修理装备
		[ItemEvents_CS_RepairEquipMent]			= ItemSystem.onRepairEquipMent,
		--修理装备
		[ItemEvents_CS_RepairAllEquipMent]		= ItemSystem.onRepairAllEquipMent,
	}
end

-- 移动道具
function ItemSystem:onMoveItem(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	--[[if player:isFighting() then
		-- 战斗中无法操作
		return
	end]]

	local itemGuid = params[1]
	-- 先验证要移动道具是否存在
	local moveItem = g_itemMgr:getItem(itemGuid)
	if not moveItem then
		-- 道具不存在
		return
	end
	-- 源容器ID
	local srcContainerID = moveItem:getContainerID()
	-- 源容器包裹索引
	local srcPackIndex = moveItem:getPackIndex()
	-- 源容器格子索引
	local srcGridIndex = moveItem:getGridIndex()

	local moveItemInfo = params[2]
	-- 目标容器ID
	local dstContainerID = moveItemInfo.dstContainerID
	-- 目标容器包裹索引
	local dstPackIndex = moveItemInfo.dstPackIndex
	-- 目标容器格子索引
	local dstGridIndex = moveItemInfo.dstGridIndex
	-- 源容器
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local depotHandler = player:getHandler(HandlerDef_Depot)
	local equipHandler = player:getHandler(HandlerDef_Equip)
	local srcContainer = nil
	if srcContainerID == PackContainerID.Packet then
		srcContainer = packetHandler:getPacket()
	elseif srcContainerID == PackContainerID.Depot then
		srcContainer = depotHandler:getDepot()
	elseif srcContainerID == PackContainerID.Equip then
		srcContainer = equipHandler:getEquip()
	else
		return
	end
	-- 目标容器
	local dstContainer = nil
	if dstContainerID == PackContainerID.Packet then
		dstContainer = packetHandler:getPacket()
	elseif dstContainerID == PackContainerID.Depot then
		dstContainer = depotHandler:getDepot()
	elseif dstContainerID == PackContainerID.Equip then
		dstContainer = equipHandler:getEquip()
	else
		return
	end
	if srcContainer == dstContainer then
		-- 源容器和目标容器是一个容器，判断下是否同一位置
		if srcPackIndex == dstPackIndex and srcGridIndex == dstGridIndex then
			-- 同一位置，没必要继续处理
			return
		end
	end
	-- 判断源位置是否合法
	local result, srcItem = srcContainer:getItems(srcPackIndex, srcGridIndex)
	if result == -1 or srcItem ~= moveItem then
		return
	end
	-- 如果源容器是装备栏
	if srcContainerID == PackContainerID.Equip then
		-- 目标容器必须是背包
		if dstContainerID ~= PackContainerID.Packet then
			return
		end
	end
	-- 如果目标容器是装备栏
	if dstContainerID == PackContainerID.Equip then
		-- 源容器必须是背包
		if srcContainerID ~= PackContainerID.Packet then
			return
		end
		if dstContainer:canAddItemsToGrid(srcItem, dstPackIndex, dstGridIndex) then
			local result, dstItem = dstContainer:getItems(dstPackIndex, dstGridIndex)
			if result == 0 then
				if dstItem == nil then
					-- 直接放入目标位置
					if dstContainer:addItemsToGrid(srcItem, dstPackIndex, dstGridIndex, true) then	
						-- 从源位置移除
						srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
					end
				else
					-- 目标存在道具，需要进行交换
					dstContainer:removeItemsFromGrid(dstPackIndex, dstGridIndex, false)
					dstContainer:addItemsToGrid(srcItem, dstPackIndex, dstGridIndex, true)
					srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, false)
					srcContainer:addItemsToGrid(dstItem, srcPackIndex, srcGridIndex, true)
				end
			end
		else
			-- 参数不合法
		end
		return
	end

	if srcContainer ~= dstContainer then
		-- 道具在不同容器间移动，才会处理移动数目
		local moveNum = params[3]
		if moveNum then
			local srcItemNum = srcItem:getNumber()
			if moveNum > srcItemNum then
				-- 逻辑错误
				return
			elseif moveNum < srcItemNum then
				local newItem = g_itemMgr:createItemFromContext(srcItem:getPropertyContext(), moveNum)
				if newItem then
					-- 如果目标格子索引等于-1，说明客户端请求把道具放入目标包裹随便一个空格里
					if dstGridIndex == -1 then
						-- 如果目标包裹索引等于-1，说明客户端请求把道具放入目标容器随便一个包裹里,如果不等于-1,则放指定包裹
						local result = nil
						if dstPackIndex == -1 then
							result = dstContainer:addItems(newItem:getGuid(), true)
						else						
							result = dstContainer:addItemsToPack(newItem, dstPackIndex)
						end

						if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
							-- 扣除源道具的数目
							srcContainer:removeItem(srcItem:getGuid(), moveNum, true)
						elseif result == AddItemsResult.Full and srcContainerID == PackContainerID.Depot and dstContainerID == PackContainerID.Packet then
							--您的物品栏中目前没有空间，不能再取出物品
							self:sendItemMessageTip(player, 15)
						end
					else
						-- 判断目标位置是否合法
						local result, dstItem = dstContainer:getItems(dstPackIndex, dstGridIndex)
						if result == -1 then
							return
						end
						if not dstItem then
							-- 直接放入目标位置
							if dstContainer:addItemsToGrid(newItem, dstPackIndex, dstGridIndex, true) then
								-- 扣除源道具的数目
								srcContainer:removeItem(srcItem:getGuid(), moveNum, true)
							end
						else
							-- 不可以直接放入，判断是否可叠加
							if dstContainer:pileItemsToGridEx(newItem, dstPackIndex, dstGridIndex) then
								-- 叠加成功
								dstContainer:updateItemToClient()
								return
							else
								-- 不能叠加，在目标容器找一个空格来放
								local result = dstContainer:addItemsToPack(newItem, dstPackIndex)
								if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
									-- 扣除源道具的数目
									srcContainer:removeItem(srcItem:getGuid(), moveNum, true)
								elseif result == AddItemsResult.Full and srcContainerID == PackContainerID.Depot and dstContainerID == PackContainerID.Packet then
									--您的物品栏中目前没有空间，不能再取出物品
									self:sendItemMessageTip(player, 15)
								end
							end
						end
					end
					return
				end
			else
				-- 移动全部数目，走下面的处理
			end
		end
	end
	-- 如果目标格子索引等于-1，说明客户端请求把道具放入目标包裹随便一个空格里
	if dstGridIndex == -1 then
		-- 如果目标包裹索引等于-1，说明客户端请求把道具放入目标容器随便一个包裹里
		if dstPackIndex == -1 then
			local result = dstContainer:addItems(srcItem:getGuid(), true)
			if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
				-- 从源位置移除
				srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
			elseif result == AddItemsResult.Full and srcContainerID == PackContainerID.Depot and dstContainerID == PackContainerID.Packet then
				--您的物品栏中目前没有空间，不能再取出物品
				self:sendItemMessageTip(player, 15)
			end
			return
		end
		-- 增加到指定包裹
		-- 相同容器，相同背包，目标位置不定直接返回
		if srcPackIndex == dstPackIndex then
			return 
		end
		
		local result = dstContainer:addItemsToPack(srcItem, dstPackIndex)
		if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
			-- 从源位置移除
			srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
		elseif result == AddItemsResult.Full and srcContainerID == PackContainerID.Depot and dstContainerID == PackContainerID.Packet then
			--您的物品栏中目前没有空间，不能再取出物品
			self:sendItemMessageTip(player, 15)
		end
		return
	end
	-- 判断目标位置是否合法
	local result, dstItem = dstContainer:getItems(dstPackIndex, dstGridIndex)
	if result == -1 then
		return
	end
	if not dstItem then
		-- 直接放入目标位置
		if dstContainer:addItemsToGrid(srcItem, dstPackIndex, dstGridIndex, true) then
			-- 从源位置移除
			srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
		end
	else
		-- 不可以直接放入，判断是否可叠加
		if dstContainer:pileItemsToGridEx(srcItem, dstPackIndex, dstGridIndex) then
			-- 叠加成功
			dstContainer:updateItemToClient()
			return
		else
			-- 不可叠加
			if srcContainer == dstContainer then
				-- 同一容器走交换流程
				return srcContainer:swapItem(srcPackIndex, srcGridIndex, dstPackIndex, dstGridIndex)
			else
				-- 不同容器的话，在目标容器找一个空格来放
				local result = dstContainer:addItemsToPack(srcItem, dstPackIndex)
				if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
					-- 从源位置移除
					srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
				elseif result == AddItemsResult.Full and srcContainerID == PackContainerID.Depot and dstContainerID == PackContainerID.Packet then
					--您的物品栏中目前没有空间，不能再取出物品
					self:sendItemMessageTip(player, 15)
				end
			end
		end
	end
end

-- 销毁道具
function ItemSystem:onDestroyItem(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	--[[if player:isFighting() then
		-- 战斗中无法操作
		return
	end]]

	-- 获得道具Guid
	local itemGuid = params[1]
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return
	end
	local itemConfig = tItemDB[item:getItemID()]
	if not itemConfig then
		-- 找不到道具配置
		return
	end
	-- 先判断能否销毁
	if not itemConfig.CanDestroy then
		return
	end
	-- 获得所属容器ID
	local packContainerID = params[2]
	if packContainerID == PackContainerID.Packet then
		-- 背包
		local packetHandler = player:getHandler(HandlerDef_Packet)
		local itemID = item:getItemID()
		packetHandler:getPacket():removeItem(itemGuid, 0, true)
		return
	elseif packContainerID == PackContainerID.Depot then
		-- 仓库
		local depotHandler = player:getHandler(HandlerDef_Depot)
		return depotHandler:getDepot():removeItem(itemGuid, 0, true)
	else
		return
	end
end

-- 整理道具
function ItemSystem:onPackUp(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	--[[if player:isFighting() then
		-- 战斗中无法操作
		return
	end]]
	-- 源容器ID
	local srcContainerID = params[1]

	-- 源容器
	local srcContainer = nil
	if srcContainerID == PackContainerID.Packet then
		local packetHandler = player:getHandler(HandlerDef_Packet)
		srcContainer = packetHandler:getPacket()
	elseif srcContainerID == PackContainerID.Depot then
		local depotHandler = player:getHandler(HandlerDef_Depot)
		srcContainer = depotHandler:getDepot()
	end
	if not srcContainer then
		return
	end
	-- 整理
	srcContainer:packUp()
end

-- 使用药品
function ItemSystem:onUseMedicament(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	if player:isFighting() then
		-- 战斗中无法操作
		return
	end

	local itemGuid = params[1]
	local targetEntityID = params[2]
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return
	end
	-- 判断药品能否使用
	local reSult, errCode = self:canUseMedicament(player, item, targetEntityID)
	if reSult then
		-- 使用药品
		self:useMedicament(player, item, targetEntityID)
	else
		if errCode then
			self:sendItemMessageTip(player, errCode)
		end
	end
end

-- 判断药品能否使用
function ItemSystem:canUseMedicament(player, item, targetEntityID)
	-- 数量不能小于1
	if item:getNumber() < 1 then
		return false, 2
	end
	
	local medicamentConfig = tMedicamentDB[item:getItemID()]
	if not medicamentConfig then
		return false, 3
	end
	
	-- 物品类型如果是凭证右键不能使用
	if medicamentConfig.Class == ItemClass.Warrant then
		return false, 3
	end
	-- 加以个限制
	if medicamentConfig.UseNeedState == MedicamentUseState.NonUse then 
		return false, 3
	end

	-- 判断使用等级
	local playerLvl = player:getLevel()
	if playerLvl < medicamentConfig.UseNeedLvl then
		return false, 4
	end
	-- 判断战斗状态
	if player:isFighting() then
		if medicamentConfig.UseNeedState < MedicamentUseState.Fight then
			return false, 5
		end
	else
		if medicamentConfig.UseNeedState == MedicamentUseState.Fight then
			return false, 6
		end
	end

	-- 是否需要判断使用次数
	if medicamentConfig.UseTimesOneDay > 0 then
		-- 得到当前使用次数
		local packetHandler = player:getHandler(HandlerDef_Packet)
		local curUseTimes = packetHandler:getItemUseTimes(item:getItemID())
		if curUseTimes >= medicamentConfig.UseTimesOneDay then
			-- 使用次数已用完
			return false, 7
		end
	end
	-- 判断对指定目标能否使用
	-- 如果在副本，还要判断能否使用治疗类道具
	if item:isHealItem() then
		local mapID = player:getCurPos()
		if mapID >= EctypeMap_StartID then
			local ectype = g_ectypeMgr:getEctype(mapID)
			if ectype and not ectype:canUseHealItems() then
				--此副本不可使用
				g_ectypeMgr:sendEctypeMessageTip(player, 10)
				return false, 8
			end
		end
	end
	return true
end

-- 药品作用类型对应效果函数
local tMedicamentReactEffect =
{
	[MedicamentReactType.AddBuff]					= ItemEffect.addBuff,
	[MedicamentReactType.CancelBuff]				= ItemEffect.cancelBuff,
	[MedicamentReactType.ExeLuaFun]					= ItemEffect.exeLuaFun,
	[MedicamentReactType.ChangeHp]					= ItemEffect.changeHp,
	[MedicamentReactType.ChangeMp]					= ItemEffect.changeMp,
	[MedicamentReactType.ChangeHpMp]				= ItemEffect.changeHpMp,
	[MedicamentReactType.ChangeAnger]				= ItemEffect.changeAngerValue,
	[MedicamentReactType.ChangePk]					= ItemEffect.changePkValue,
	[MedicamentReactType.ChangeBindMoney]			= ItemEffect.changeBindMoney,
	[MedicamentReactType.ChangeMoney]				= ItemEffect.changeMoney,
	[MedicamentReactType.ChangeExp]					= ItemEffect.changeExpValue,
	[MedicamentReactType.ChangeCashMoney]			= ItemEffect.changeCashMoney,
	[MedicamentReactType.ChangeGoldCoin]			= ItemEffect.changeGoldCoin,
	[MedicamentReactType.ChangeTao]					= ItemEffect.changeTaoValue,
	[MedicamentReactType.ChangePotential]			= ItemEffect.changePotential,
	[MedicamentReactType.ChangeExpoint]				= ItemEffect.changeExpoint,
	[MedicamentReactType.ChangeCombatNum]			= ItemEffect.changeCombatNum,
	[MedicamentReactType.ChangeContribution]		= ItemEffect.changeContribution,
	[MedicamentReactType.ChangeVigor]				= ItemEffect.changeVigor,
	[MedicamentReactType.ChangePetLoyalty]			= ItemEffect.changePetLoyalty,
	[MedicamentReactType.ChangePetLife]				= ItemEffect.changePetLife,
	[MedicamentReactType.UseHpPool]					= ItemEffect.useHpPoolItem,
	[MedicamentReactType.UseMpPool]					= ItemEffect.useMpPoolItem,
	[MedicamentReactType.OpenClientUI]				= ItemEffect.openClientUI,
	[MedicamentReactType.AddPet]					= ItemEffect.addPet,
	[MedicamentReactType.AddRide]					= ItemEffect.addRide,
	[MedicamentReactType.ChangeAllAttr]				= ItemEffect.changeAllAttr,
	[MedicamentReactType.ChangeAllPhase]			= ItemEffect.changeAllPhase,
	[MedicamentReactType.ChangeRideVigor]			= ItemEffect.changeRideVigor,
	[MedicamentReactType.FinishTask]				= ItemEffect.finishTask,
	[MedicamentReactType.OpenTreasure]				= ItemEffect.openTreasure,
	[MedicamentReactType.AddPetSkill]				= ItemEffect.addPetSkill,
	[MedicamentReactType.AddTask]					= ItemEffect.addTask,
	[MedicamentReactType.CompleteTask]				= ItemEffect.completeTask,
	[MedicamentReactType.ChangeLoyaltyAndAddBuff]	= ItemEffect.changeLoyaltyAndAddBuff,
	[MedicamentReactType.ChangeHpAndAddBuff]		= ItemEffect.changeHpAndAddBuff,
	[MedicamentReactType.ChangeMpAndAddBuff]		= ItemEffect.changeMpAndAddBuff,

}

-- 使用药品
function ItemSystem:useMedicament(player, item, targetEntityID)
	local itemID = item:getItemID()
	local medicamentConfig = tMedicamentDB[itemID]
	if not medicamentConfig then
		return
	end
	local reactEffectFun = tMedicamentReactEffect[medicamentConfig.ReactType]
	if reactEffectFun then
		local reSult, errCode = reactEffectFun(player, item, medicamentConfig, targetEntityID)
		if reSult then
			-- 如果返回的removeFlag为True，就删除源道具
			local packetHandler = player:getHandler(HandlerDef_Packet)
			local packet = packetHandler:getPacket()
			local result = packet:removeItem(item:getGuid(), 1, true)
			if result == RemoveItemsResult.Succeed or result == RemoveItemsResult.SucceedClean then
				if medicamentConfig.UseTimesOneDay > 0 then
					-- 增加使用次数
					packetHandler:addItemUseTimes(itemID)
					-- 使用的提示信息
					local itemName = medicamentConfig.Name
					self:sendItemMessageTip(player, 1, itemName)
				end
				-- 使用物品完成任务
				--[[
				if medicamentConfig.ReactType == MedicamentReactType.MayFinishTask then
					local taskID = medicamentConfig.ReactExtraParam1
					self:dealTask(player:getID(), taskID)	
				end
				--]]
			end
		else
			-- 出错消息
			if errCode then
				self:sendItemMessageTip(player, errCode)
			end
		end
	else
		print("ItemSystem:useMedicament 逻辑错误，ReactType = ", medicamentConfig.ReactType)
	end
end

-- 拆分道具
function ItemSystem:onSplitItem(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
--[[	if player:isFighting() then
		-- 战斗中无法操作
		return
	end
]]
	local itemGuid = params[1]
	local splitNum = params[2]
	-- 先验证道具是否存在
	local item = g_itemMgr:getItem(itemGuid)
	if not item then
		-- 道具不存在
		return
	end
	if item:getContainerID() ~= PackContainerID.Packet then
		-- 暂时只支持背包道具的拆分
		return
	end
	if item:getNumber() <= splitNum or splitNum <= 0 then
		-- 拆分数目不合法
		return
	end
	
    local packetHandler = player:getHandler(HandlerDef_Packet)
	local packet = packetHandler:getPacket()

	-- 想拆分，首先得有空格
	local result, packIndex, gridIndex = packet:getSpaceIndex(item)
	if not result then
		-- 提示包裹已满
		return
	end
	local result = packet:removeItem(itemGuid, splitNum, false)
	if result == RemoveItemsResult.Succeed then
		-- 生成分拆出来的新道具，这里根据当前道具的属性现场来创建，否则可能属性不一样
		local newItem = g_itemMgr:createItemFromContext(item:getPropertyContext(), splitNum)
		if newItem then
			-- 增加到指定空格里
			packet:addItemsToGrid(newItem, packIndex, gridIndex, true)
		end
	end
end

-- 存放银两
function ItemSystem:onStoreMoney(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end

	local storeMoney = params[1]
	local playerMoney = player:getMoney()
	if storeMoney > playerMoney then
		-- 不合法
		return
	end
	local depotMoney = player:getDepotMoney()
	if depotMoney + storeMoney > DepotSaveMoneyMax then
		return
	end
	-- 扣除玩家身上银两
	player:setMoney(playerMoney - storeMoney)

	-- 增加玩家仓库银两
	player:setDepotMoney(depotMoney + storeMoney)
	player:flushPropBatch()
end

-- 取走银两
function ItemSystem:onFetchMoney(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end

	local fetchMoney = params[1]
	local depotMoney = player:getDepotMoney()
	if fetchMoney > depotMoney then
		-- 不合法
		return
	end
	-- 扣除玩家仓库银两
	depotMoney = depotMoney - fetchMoney
	player:setDepotMoney(depotMoney)
	-- 增加玩家身上银两
	local playerMoney = player:getMoney()
	playerMoney = playerMoney + fetchMoney
	player:setMoney(playerMoney)
	player:flushPropBatch()
end

-- 扩充仓库
function ItemSystem:onExtendDepot(event)
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local depotHandler = player:getHandler(HandlerDef_Depot)
	local curCapacity = depotHandler:getDepotCapability()
	if curCapacity >= DepotMaxCapacity then
		-- 已经扩充到最大
		return
	end
	-- 计算是第几次扩充仓库
	local extendCapacity = curCapacity - DepotDefaultCapacity
	if extendCapacity % 6 ~= 0 then
		-- 逻辑错误
		return
	end
	local extendTimes = extendCapacity / 6 + 1
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler:getNumByItemID(DepotExtendItemID) < extendTimes then
		-- 扩充道具不足
		return
	end
	packetHandler:removeByItemId(DepotExtendItemID, extendTimes)
	curCapacity = curCapacity + 6
	if curCapacity > DepotMaxCapacity then
		-- 以防万一
		return
	end
	depotHandler:setDepotCapability(curCapacity)
	-- 角色记录下，要保存数据库
	player:setDepotCapacity(curCapacity)

	local event = Event.getEvent(ItemEvents_SC_CapacityChange, PackContainerID.Depot, curCapacity)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 物品提示消息
function ItemSystem:sendItemMessageTip(player, msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Item, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 处理右键点击任务道具的使用有可能完成任务，有可能触发其他任务
--[[
function ItemSystem:dealTask(roleID, taskID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local value = math.random(1, 2)
	if value == 1 then
		-- 处理完成任务
		taskHandler:finishLoopTask(taskID)
	else
		g_taskDoer:doDeleteTask(player, taskID)
		-- 再接指定的类型的任务
		local loopTask = g_taskFty:createLoopTask(player, taskID, LoopTaskTargetType.itemScript)
		taskHandler:addTask(loopTask)
		g_taskSystem:updateLoopTaskList(player, taskHandler:getRecetiveTaskList())
	end
end
--]]

-- 请求鉴定装备
function ItemSystem:onAppraisalEeuip(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end

	local guid = params[1]
	local equipMent = g_itemMgr:getItem(guid)
	if equipMent and equipMent:getItemClass()== ItemClass.Equipment then
		local equipHandler = player:getHandler(HandlerDef_Equip)
		equipHandler:identityEquip(equipMent)
	end
end

-- 兑换物品
function ItemSystem:onExchangeProps(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end

	local itemID = params[1]
	local num = params[2]
	g_itemMgr:onExchangeProps(player,itemID,num)
end

--修理装备
function ItemSystem:onRepairEquipMent(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end

	local itemGuid = params[1]
	local equipMent = g_itemMgr:getItem(itemGuid)
	if not equipMent then
		return
	end
	local curDurability = equipMent:getCurDurability()
	local maxDurability = equipMent:getMaxDurability()
	if equipMent:getItemClass() ~= ItemClass.Equipment or maxDurability <= curDurability then
		return
	end
	local salePrice = equipMent:getSalePrice()
	local durability  = curDurability/maxDurability * 100
	local perc = 0 
	if durability > 80 then
		perc = 2
	elseif durability >50 then
		perc = 3
	elseif durability > 10 then
		perc = 4
	else
		perc = 6
	end															
	local repairMoney = math.ceil(perc*salePrice*(maxDurability - curDurability )/maxDurability)
	local subMoney = player:getSubMoney()
	local money = player:getMoney()
	if subMoney < repairMoney  and money < repairMoney then
		return
	end
	if subMoney >= repairMoney then
		subMoney = subMoney - repairMoney
		player:setSubMoney(subMoney)
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, 15, repairMoney)
		g_eventMgr:fireRemoteEvent(event, player)
	else
		money = money - repairMoney
		player:setMoney(money)
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, 16, repairMoney)
		g_eventMgr:fireRemoteEvent(event, player)
	end
	equipMent:setCurDurability(maxDurability)
end

--修理全部装备
function ItemSystem:onRepairAllEquipMent(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end

	local equipHandler = player:getHandler(HandlerDef_Equip)
	local equip = equipHandler:getEquip()
	local equipPack = equip:getPack()
	local repairAllMoney = 0
	for gridIndex = 1, equipPack:getCapability() do
		local equipMent = equipPack:getGridItem(gridIndex)
		if equipMent then
			local maxDurability = equipMent:getMaxDurability()
			local curDurability = equipMent:getCurDurability()
			if curDurability < maxDurability then
				local salePrice = equipMent:getSalePrice()
				local durability  = curDurability/maxDurability * 100
				local perc = 0
				if durability > 80 then
					perc = 2
				elseif durability >50 then
					perc = 3
				elseif durability > 10 then
					perc = 4
				else
					perc = 6
				end
				repairAllMoney = repairAllMoney + math.ceil(perc*salePrice*(maxDurability - curDurability )/maxDurability)
			end
		end
	end

	local subMoney = player:getSubMoney()
	local money = player:getMoney()
	if subMoney < repairAllMoney  and money < repairAllMoney then
		return
	end
	if subMoney >= repairAllMoney then
		subMoney = subMoney - repairAllMoney
		player:setSubMoney(subMoney)
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, 17, repairAllMoney)
		g_eventMgr:fireRemoteEvent(event, player)
	else
		money = money - repairAllMoney
		player:setMoney(money)
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, 18, repairAllMoney)
		g_eventMgr:fireRemoteEvent(event, player)
	end
	
	for gridIndex = 1, equipPack:getCapability() do
		local equipMent = equipPack:getGridItem(gridIndex)
		if equipMent then
			local maxDurability = equipMent:getMaxDurability()
			equipMent:setCurDurability(maxDurability)
		end
	end
end


function ItemSystem.getInstance()
	return ItemSystem()
end

EventManager.getInstance():addEventListener(ItemSystem.getInstance())
