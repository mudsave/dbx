--[[P2PTrade.lua
 描述：玩家之间交易
--]]

P2PTrade = class()

--初始化
function P2PTrade:__init(player1, player2)
	player1:setActionState(PlayerStates.P2PTrade)
	player2:setActionState(PlayerStates.P2PTrade)
	self.player1 = player1
	self.player2 = player2
	--设置交易货架上的物品信息和交易的状态
	self.TradeInfo1 = {}
	self.TradeInfo2 = {}

	--记录两个玩家的物品信息
	self.TradeInfo1.itemInfo = Trade(TradeDefaultCapacity)
	self.TradeInfo2.itemInfo = Trade(TradeDefaultCapacity)

	--记录玩家金钱
	self.TradeInfo1.money = nil
	self.TradeInfo2.money = nil

	-- 记录宠物相关信息
	self.TradeInfo1.petInfo = {}
	self.TradeInfo2.petInfo = {}
	--记录玩家状态
	self.TradeInfo1.state = TradeState.Status_Enter
	self.TradeInfo1.state = TradeState.Status_Enter
end

--清理
function P2PTrade:__release()
	self.player1:setActionState(PlayerStates.Normal)
	self.player2:setActionState(PlayerStates.Normal)
	self.player1 = nil
	self.player2 = nil
	release(self.TradeInfo1.itemInfo)
	release(self.TradeInfo2.itemInfo)
	self.TradeInfo1.money = nil
	self.TradeInfo2.money = nil
	-- 记录宠物相关信息
	self.TradeInfo1.petInfo = nil
	self.TradeInfo2.petInfo = nil
	self.TradeInfo1 = nil
	self.TradeInfo2 = nil
end

--获取和当前下线玩家交易玩家ID
function P2PTrade:getOtherID(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player == self.player1 then
		return self.player2:getID()
	elseif player == self.player2 then
		return self.player1:getID()
	else
		return 0
	end
end

--p2p交易物品相关信息的存储物品的上下架target 参数到时候要取消
function P2PTrade:doTradeItem(role, target, actionType, itemGuid, itemNum, index)
	local itemInfo
	--此时主要是交易货架相关信息
	if role == self.player1 then
		itemInfo = self.TradeInfo1.itemInfo
		self.TradeInfo1.state = TradeState.Status_ChangeItem
	else
		itemInfo = self.TradeInfo2.itemInfo
		self.TradeInfo2.state = TradeState.Status_ChangeItem
	end

	--没有物品信息
	if not itemInfo then
		return
	end
	--根据物品的GUId获取物品上架或者下架
	local packetHandler = role:getHandler(HandlerDef_Packet);
	local slotIndex
	if actionType == TradeAction.ActionUp then
		--确定交易栏物品格
		--根据物品的GUID来获取物品
		local item = g_itemMgr:getItem(itemGuid)
		if not item then
			print("获取物品失败")
		end
		local result , slotIndex = itemInfo:addNumberItemsToPack(itemGuid, itemNum)
		if result == AddItemsResult.Full then
			print("包裹也满呢")
			self:sendP2PTradeMessage(role, 4)
			return
		end
		--首先把物品枷锁
		packetHandler:setLockFlag(item, true)
		--在把单一物品质灰发给客户端
		local event = Event.getEvent(TradeEvents_SC_P2PItemLockFlag, itemGuid, true)
		g_eventMgr:fireRemoteEvent(event, role)
		local countNumber = itemInfo:getItemNumber(slotIndex)
		local itemRecord = {}
		itemRecord.guid = itemGuid
		itemRecord.itemNumber = countNumber
		itemRecord.slotIndex = slotIndex
		itemRecord.action = TradeAction.ActionUp
		--把物品的Guid，数量，上下架，返回那个格子
		local event = Event.getEvent(TradeEvents_SC_P2PChangeItemReturn, role:getID(), itemRecord)
		--再把物品信息发给自己的客户端
		g_eventMgr:fireRemoteEvent(event, role)
	elseif actionType == TradeAction.ActionDown then
		--这时候主要根据物品的GUID来找格子
		local tradeItems = itemInfo:getTradeItem()
		if not tradeItems then return end
		slotIndex = index
		--物品格当中存的物品的个数
		local existNumber = itemInfo:getItemNumber(slotIndex)
		itemInfo:removeItem(slotIndex, itemNum)
		local countNumber = itemInfo:getItemNumber(slotIndex)
		--再把物品相应信息发给自己的客户端最好还是把物品属性发过去
		--在把单一物品质灰发给客户端
		--物品格当中的物品全部下架
		if countNumber == -1 then
			local event = Event.getEvent(TradeEvents_SC_P2PItemLockFlag, itemGuid, false)
			g_eventMgr:fireRemoteEvent(event, role)
		end
		local itemRecord = {}
		itemRecord.guid = itemGuid
		itemRecord.itemNumber = countNumber
		itemRecord.slotIndex = slotIndex
		itemRecord.action = TradeAction.ActionDown
		local event = Event.getEvent(TradeEvents_SC_P2PChangeItemReturn, role:getID(), itemRecord)
		--g_eventMgr:fireRemoteEvent(event, target)
		--再把物品信息发给自己的客户端
		g_eventMgr:fireRemoteEvent(event, role)
	end
end

-- 玩家之间交易宠物 有上架和下架
function P2PTrade:doTradePet(role, target, actionType, petID)
	local petInfo
	--此时主要是交易货架相关信息
	if role == self.player1 then
		petInfo = self.TradeInfo1.petInfo
		self.TradeInfo1.state = TradeState.Status_ChangeItem
	else
		petInfo = self.TradeInfo2.petInfo
		self.TradeInfo2.state = TradeState.Status_ChangeItem
	end

	--没有物品信息
	if not petInfo then
		return
	end
	local pet = g_entityMgr:getPet(petID)
	if not pet then
		return 
	end
	-- 宠物上架
	if actionType == TradeAction.ActionUp then
		if pet:getPetStatus() == PetStatus.Fight then
			return 8
		end

		if table.size(petInfo) >= PetTradeMax then
			return 7
		else
			petInfo[petID] = pet
		end
		
		if pet:getLevel() - target:getLevel() > P2PTrade_LevelDiffer then
			return 9
		end
		
		-- 设置宠物的状态在交易当中
		pet:setPetStatus(PetStatus.Sale)
	else
		pet:setPetStatus(PetStatus.Rest)
		petInfo[petID] = nil
	end

	local petRecord = {}
	petRecord.petID = petID
	petRecord.actionType = actionType
	--再把宠物信息发给自己的客户端
	local event = Event.getEvent(TradeEvents_SC_P2PChangePetReturn, role:getID(), petRecord)
	g_eventMgr:fireRemoteEvent(event, role)
	return 0
end

--交易锁定顺便设置一下钱数
function P2PTrade:setTradeMoney(role, targetRole, tradeMoney)
	local tradeInfo
	if role == self.player1 then
		tradeInfo = self.TradeInfo1
		tradeInfo.money = tradeMoney
		--设置当前玩家状态枷锁状态
		tradeInfo.state = TradeState.Status_LockTrade
	else
		tradeInfo = self.TradeInfo2
		tradeInfo.money = tradeMoney
		--设置当前玩家状态枷锁状态
		tradeInfo.state = TradeState.Status_LockTrade
	end
	--锁定的时候要把所有的信息发给对方客户端
	--针对物品要把物品的属性也要发过去
	--首先是物品
	local itemInfo = tradeInfo.itemInfo:getTradeItem()
	local petInfo = tradeInfo.petInfo
	for k, v in pairs(itemInfo or {}) do
		local itemGuid = v.guid
		local item = g_itemMgr:getItem(itemGuid)
		if item then
			local property = item:getPropertyContext()
			v.property = property
		end
	end
	--把所有宠物信息都发给目标客户端
	local itemInfo = itemInfo
	local money = tradeMoney
	local petInfos = {}
	for petID, pet in pairs(petInfo) do
		if pet then
			local petConfig = PetDB[pet:getConfigID()]
			local name = petConfig and petConfig.petName
			local petType = pet:getPetType()
			petInfos[petID] = 
			{
				petID = petID,
				petName = name,
				petType = petType,
			}
		end
	end
	local tradeRecord = 
	{
		itemInfo = itemInfo,
		money = money,
		petInfo = petInfos
	}
	local event = Event.getEvent(TradeEvents_SC_P2PTradeInfo, tradeRecord)
	g_eventMgr:fireRemoteEvent(event, targetRole)
end

--确定交易需要两个玩家都点击
function P2PTrade:doConfirmTrade(role, targetRole)
	local tradeInfo1
	local tradeInfo2
	if role == self.player1 then
		tradeInfo1 = self.TradeInfo1
		tradeInfo2 = self.TradeInfo2
	else
		tradeInfo1 = self.TradeInfo2
		tradeInfo2 = self.TradeInfo1
	end
	if tradeInfo2.state ~= TradeState.Status_LockTrade and tradeInfo2.state ~= TradeState.Status_ComfirmTrade then
		--发消息给自己说对方还没锁定
		self:sendP2PTradeMessage(role, 5)
		return 
	end
	tradeInfo1.state = TradeState.Status_ComfirmTrade
	--两玩家都确定之后才交易
	if tradeInfo2.state == TradeState.Status_ComfirmTrade then
		local reSult = self:dealTrade(role, targetRole, tradeInfo1, tradeInfo2)
		if reSult > 0 then
			self:sendP2PTradeMessage(role, reSult)
			return
		end
		
		--如果交易成功
		g_tradeMgr:doFinishTrade(role:getID(), targetRole:getID())
	end
	--有一方没点确认
	local event = Event.getEvent(TradeEvents_SC_P2PTradeConfirmed, role:getID())
 	g_eventMgr:fireRemoteEvent(event, role)
end

--处理交易
function P2PTrade:dealTrade(role, targetRole, tradeInfo1, tradeInfo2)
	local packetHandler1 = role:getHandler(HandlerDef_Packet)
	if not packetHandler1 then
		return 
	end

	local packetHandler2 = targetRole:getHandler(HandlerDef_Packet)
	if not packetHandler2 then
		return 
	end

	local roleEmptyGridsNum = packetHandler1:getPacketEmptyGridsNum(PacketPackType.Normal)
	local targetEmptyGridsNum = packetHandler2:getPacketEmptyGridsNum(PacketPackType.Normal)
	
	local tradeItemInfo1 = tradeInfo1.itemInfo
	local tradeItemNum1 = tradeItemInfo1:getTradeItemNum()
	local tradeItemInfo2 = tradeInfo2.itemInfo
	local tradeItemNum2 = tradeItemInfo2:getTradeItemNum()
	
	if roleEmptyGridsNum < (tradeItemNum2 - tradeItemNum1) then
		print("当前玩家包裹空间不足, 交易失败")
		return 6
	end

	if targetEmptyGridsNum < (tradeItemNum1 - tradeItemNum2) then
		print("对方玩家的包裹空间不足，交易失败")
		return 7
	end

	-- 处理宠物
	local rolePetSpace = role:getAttrValue(player_max_pet) - role:getPetAmount()
	local targPetSpace = targetRole:getAttrValue(player_max_pet) - targetRole:getPetAmount()
	if rolePetSpace < (table.size(tradeInfo2.petInfo) - table.size(tradeInfo1.petInfo)) then
		return 10
	end

	if targPetSpace < (table.size(tradeInfo1.petInfo) - table.size(tradeInfo2.petInfo)) then
		return 11
	end
	--先从玩家1包裹移除物品
	for _, itemInfo1 in pairs(tradeItemInfo1:getTradeItem() or {}) do
		if itemInfo1 then
			local itemGuid = itemInfo1.guid
			local itemNum = itemInfo1.itemNum
			
			local property = itemInfo1.property
			local prefItem = g_itemMgr:getItem(itemGuid)
		
			--解锁时要想客户端发消息
			packetHandler1:setLockFlag(prefItem, false)
			local event = Event.getEvent(TradeEvents_SC_P2PItemLockFlag, itemGuid, false)
			g_eventMgr:fireRemoteEvent(event, role)
			--此时物品已销毁
			packetHandler1:removeItem(itemGuid, itemNum)
		end
	end
	
	--从玩家2包裹移除物品
	for _, itemInfo2 in pairs(tradeItemInfo2:getTradeItem() or {}) do
		if itemInfo2 then
			local itemGuid = itemInfo2.guid
			local itemNum = itemInfo2.itemNum
			
			local property = itemInfo2.property
			local prefItem = g_itemMgr:getItem(itemGuid)
			
			--解锁时要想客户端发消息
			packetHandler2:setLockFlag(prefItem, false)
			local event = Event.getEvent(TradeEvents_SC_P2PItemLockFlag, itemGuid, false)
			g_eventMgr:fireRemoteEvent(event, targetRole)
			--此时物品已销毁
			packetHandler2:removeItem(itemGuid, itemNum)
		end
	end
	
	--玩家1包裹添加物品
	for _, itemInfo2 in pairs(tradeItemInfo2:getTradeItem() or {}) do
		if itemInfo2 then
			local itemNum = itemInfo2.itemNum
			local property = itemInfo2.property
			local newItem = g_itemMgr:createItemFromContext(property, itemNum)
			local newItemGuid = newItem:getGuid()
			packetHandler1:addItems(newItemGuid)
		end
	end

	for _, itemInfo1 in pairs(tradeItemInfo1:getTradeItem() or {}) do
		if itemInfo1 then
			local itemNum = itemInfo1.itemNum
			local property = itemInfo1.property
			local newItem = g_itemMgr:createItemFromContext(property, itemNum)
			local newItemGuid = newItem:getGuid()
			packetHandler2:addItems(newItemGuid)
		end
	end

	--处理金钱接口
	local money1 = tradeInfo1.money
	local money2 = tradeInfo2.money
	local roleMoney = role:getMoney()
	local targetMoney = targetRole:getMoney()
	if money1 and money1 > 0 then
		if roleMoney < money1 then
			return 12
		end
	end
	if money2 and money2 > 0 then
		if targetMoney < money2 then
			return 13
		end
	end
	role:setMoney(roleMoney - money1 + money2)
	targetRole:setMoney(targetMoney - money2 + money1)
	-- 处理宠物接口 --后期还要加上一些判断
	local petInfo1 = tradeInfo1.petInfo
	local petInfo2 = tradeInfo2.petInfo
	-- 先删除 
	if table.size(petInfo1) > 0 then
		for petID1, _ in pairs(petInfo1) do
			role:removePet(petID1)
		end
	end

	if table.size(petInfo2) > 0 then
		for petID2, _ in pairs(petInfo2) do
			targetRole:removePet(petID2)
		end
	end
	
	-- 再添加
	for petID1, pet in pairs(petInfo1) do
		pet:setOwner(targetRole)
		pet:setPetStatus(PetStatus.Rest)
		local petConfigID = pet:getConfigID()
		local petName = PetDB[petConfigID].petName
		pet:setName(petName)
		-- 宠物不在场景当中
		targetRole:addPet(pet)
	end

	for petID2, pet in pairs(petInfo2) do
		pet:setOwner(role)
		pet:setPetStatus(PetStatus.Rest)
		local petConfigID = pet:getConfigID()
		local petName = PetDB[petConfigID].petName
		pet:setName(petName)
		role:addPet(pet)
	end
	return 0
end

--给双方物品解锁
function P2PTrade:unLockFlag(player, target)
	local tradeItemInfo1
	local tradeItemInfo2
	if player == self.player1 then
		tradeItemInfo1 = self.TradeInfo1.itemInfo
		tradeItemInfo2 = self.TradeInfo2.itemInfo
	else
		tradeItemInfo1 = self.TradeInfo2.itemInfo
		tradeItemInfo2 = self.TradeInfo1.itemInfo
	end
	local packetHandler1 = player:getHandler(HandlerDef_Packet)
	if not packetHandler1 then 
		return
	end

	local packetHandler2 = target:getHandler(HandlerDef_Packet)
	if not packetHandler2 then 
		return
	end
	for index, value in pairs(tradeItemInfo1:getTradeItem()) do 
		local itemGuid = value.guid
		local item = g_itemMgr:getItem(itemGuid)
		if item then
			--首先把物品枷锁
			packetHandler1:setLockFlag(item, false)
			--在把单一物品质灰发给客户端
			local event = Event.getEvent(TradeEvents_SC_P2PItemLockFlag, itemGuid, false)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end

	for index1, value1 in pairs(tradeItemInfo2:getTradeItem()) do 
		local itemGuid = value1.guid
		local item = g_itemMgr:getItem(itemGuid)
		if item then
			--首先把物品枷锁
			packetHandler2:setLockFlag(item, false)
			--在把单一物品质灰发给客户端
			local event = Event.getEvent(TradeEvents_SC_P2PItemLockFlag, itemGuid, false)
			g_eventMgr:fireRemoteEvent(event, target)
		end
	end
end

-- 设置宠物的状态
function P2PTrade:setPetActionState()
	for _, pet1 in pairs(self.TradeInfo1.petInfo or {}) do
		pet1:setPetStatus(PetStatus.Rest)
	end

	for _, pet2 in pairs(self.TradeInfo2.petInfo or {}) do
		pet2:setPetStatus(PetStatus.Rest)
	end
end

-- p2p交易相关提示信息
function P2PTrade:sendP2PTradeMessage(player, msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_P2PTrade, msgID)
	g_eventMgr:fireRemoteEvent(event, player)
end