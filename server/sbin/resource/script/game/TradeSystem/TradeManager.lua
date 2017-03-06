--[[TradeManager.lua
描述:
	交易管理类
]]

TradeManager = class(nil, Singleton)

function TradeManager:__init()
	--目标玩家的请求列表
	self.requestList = {}
	--记录p2p交易相关
	self.tradeList = {}
end

function TradeManager:__release()
	self.requestList = nil
	self.tradeList = nil
end

--玩家点击X关闭与NPC交易
function TradeManager:closeTrade(player)
	if not player then
		return
	end
	--player:setActionState(PlayerStates.Normal)
end

--玩家从npc购回界面购回物品
function TradeManager:ptoNBuyBack(player, itemGuid, itemNum, moveItemInfo)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler then 
		--处理玩家的金钱和绑银
		local item = g_itemMgr:getItem(itemGuid)
		if not item then
			return
		end
		-- 包裹已满
		local emptyGrids = packetHandler:getPacketEmptyGridsNum(PacketPackType.Normal)
		if emptyGrids == 0  then 
			self:sendTradeMessage(player, 4)
			return
		end 
		--回购时价格应该取物品配置
		local itemID = item:getItemID()
		local itemConfig = tItemDB[itemID]
		if item then
			--获取回购的类型和单价
			local saleMoneyType = itemConfig.SaleMoneyType
			local saleMoneyNum = itemConfig.SaleMoneyNum
			local playerSubMoney = player:getSubMoney()
			local playerMoney = player:getMoney()
			local costSubMoney = 0
			local costMoney = 0
			local totalPrice = saleMoneyNum*itemNum 	--获取总价
			
			if saleMoneyType == ItemPriceType.BindMoney then 
				if playerSubMoney >= totalPrice then
					costSubMoney = totalPrice
				else
					if playerMoney >= totalPrice then 
						costMoney = totalPrice
					else
						--玩家金钱不足无法购买
						self:sendTradeMessage(player, 5)
						return
					end
				end 
			else
				if playerMoney >= totalPrice then 
					costMoney = totalPrice
				else
					--玩家金钱不足无法购买
					self:sendTradeMessage(player, 5)
					return
				end
			end 
			--先看玩家的钱数再做移动操作再处理钱数成功失败
			local result = self:onMoveItem(player, itemGuid, itemNum, moveItemInfo)
			-- 这个地方应该还加一个判断成功和失败
			if not result then
				self:sendTradeMessage(player, 4)
				return  
			end
			player:setSubMoney(playerSubMoney-costSubMoney)
			player:setMoney(playerMoney-costMoney)
			player:flushPropBatch()
			if costSubMoney > 0 then
				self:sendTradeMessage(player, 1, costSubMoney,itemNum,itemID)
			end
			if costMoney > 0 then
				self:sendTradeMessage(player, 2, costMoney,itemNum,itemID)
			end
		end
	end
end

--主要是处理货架和物品界面物品的交换
function TradeManager:onMoveItem(player, itemGuid, itemNum, moveItemInfo)
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

	-- 目标容器ID
	local dstContainerID = moveItemInfo.dstContainerID
	-- 目标容器包裹索引
	local dstPackIndex = moveItemInfo.dstPackIndex
	-- 目标容器格子索引
	local dstGridIndex = moveItemInfo.dstGridIndex
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local ShelfHandler = player:getHandler(HandlerDef_Shelf)
	local srcContainer = nil
	if srcContainerID == PackContainerID.Packet then
		srcContainer = packetHandler:getPacket()
	elseif srcContainerID == PackContainerID.Shelf then
		srcContainer = ShelfHandler:getShelf()
	else
		return TradeMsgID.PacketItemNotSell
	end

	-- 目标容器
	local dstContainer = nil
	if dstContainerID == PackContainerID.Packet then
		dstContainer = packetHandler:getPacket()
	elseif dstContainerID == PackContainerID.Shelf then
		dstContainer = ShelfHandler:getShelf()
	else
		return TradeMsgID.ItemNotBuyToPacket
	end
	
	-- 判断源位置是否合法
	local result, srcItem = srcContainer:getItems(srcPackIndex, srcGridIndex)
	if result == -1 or srcItem ~= moveItem then
		return
	end
	-- 如果是背包到回购货架 指定包裹为1，如果是回购货架到包裹为-1不指定
	if dstPackIndex ~= -1 then
		-- 物品到回购货架才会调用到这里
		local result = dstContainer:addNumberItemsToPack(srcItem, dstPackIndex, itemNum)
		if result == AddItemsResult.SucceedPile then
			-- 放一部到其他包裹，重新设置数量
			srcContainer:removeItem(itemGuid, itemNum, true)
		elseif result == AddItemsResult.Succeed then
			-- 从源位置移除，只是把物品全都移动呢
			srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
		end
		return result
	else
		
		-- 如果是回购货架到包裹为-1不指定固定的包裹，
		--	一部分
		if itemNum < srcItem:getNumber() then
			local newItem = g_itemMgr:createItemFromContext(srcItem:getPropertyContext(), itemNum)
			if newItem then
				-- 如果目标格子索引等于-1，说明客户端请求把道具放入目标包裹随便一个空格里
				if dstGridIndex == -1 then
					-- 如果目标包裹索引等于-1，说明客户端请求把道具放入目标容器随便一个包裹里
					local result = dstContainer:addItems(newItem:getGuid(), true)
					if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
						-- 扣除源道具的数目
						srcContainer:removeItem(srcItem:getGuid(), itemNum, true)
					end
					return result
				end
			end
		else
			--全部
			local result = dstContainer:addItems(srcItem:getGuid(), true)
			if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
				-- 从源位置移除
				srcContainer:removeItemsFromGrid(srcPackIndex, srcGridIndex, true)
				if srcContainerID == PackContainerID.Shelf then
					srcContainer:upGridItem(srcPackIndex, true)
				end
			end
			return result
		end
	end
end


--服务器处理玩家和Npc货架卖东西itemID是GUID
function TradeManager:ptoNSellGoods(player, itemGuid, itemNum, moveItemInfo)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler then 
		--处理玩家的金钱和绑银
		local item = g_itemMgr:getItem(itemGuid)
		local itemID = item:getItemID()
		local itemConfig = tItemDB[itemID]
		if item then
			local result = self:onMoveItem(player, itemGuid, itemNum, moveItemInfo)
			if result == AddItemsResult.Succeed or result == AddItemsResult.SucceedPile then
				local saleMoneyType = itemConfig.SaleMoneyType
				local saleMoneyNum = itemConfig.SaleMoneyNum
				local money = 0
				if saleMoneyType == ItemPriceType.BindMoney then
					money = player:getSubMoney() + saleMoneyNum*itemNum
					player:setSubMoney(money)					
					--之后可能要发消息给客户端做一些提示处理
					local money = saleMoneyNum * itemNum
					self:sendTradeMessage(player, 3, money,itemNum,itemID)
					player:flushPropBatch()
				elseif saleMoneyType == ItemPriceType.Money then
					money = player:getMoney() + saleMoneyNum*itemNum
					player:setMoney(money)
					--之后可能要发消息给客户端做一些提示处理
					local money = saleMoneyNum * itemNum
					self:sendTradeMessage(player, 12, money,itemNum,itemID)
					player:flushPropBatch()
				end
			else
				self:sendTradeMessage(player, result)
			end
		end
	end
end


--根据id获取货架表中物品的价格
function TradeManager:getItemPrice(itemID)
	local buyPrice
	for _, value in pairs(NpcPackDB or {}) do
		local items = value.items
		if items then 
			for _, itemInfo in pairs(items or {}) do
				if itemInfo.id == itemID then
					buyPrice = itemInfo.buyPrice
					return buyPrice
				end
			end
		end
	end
end

--服务器处理玩家和Npc货架买东西
function TradeManager:ptoNBuyGoods(player, itemID, itemNum, npcPackID)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local emptyGrids = packetHandler:getPacketEmptyGridsNum(PacketPackType.Normal)
	local orderItemNum = packetHandler:getNumByItemID(itemID) 
	
	if packetHandler then 
		--购买时价格取货架配置
		--只知道物品id从货架表中找价格tItemDB
		local itemConfig = tItemDB[itemID]  
		if not itemConfig then
			return
		end
		-- 包裹已满
		if (emptyGrids == 0 and orderItemNum == 0) then 
			self:sendTradeMessage(player, 4)
			return
		end 
		
		local saleMoney = itemConfig.SaleMoneyNum
		if not saleMoney then
			-- 没有配置直接不需要钱
			if not packetHandler:addItemsToPacket(itemID, itemNum) then 
				--物品进入玩家包裹失败
				self:sendTradeMessage(player, 4)
				return 
			end
		else
			-- 获取购买类型
			local buyPriceType = NpcPackDB[npcPackID].buyPriceType
			local buyPrice = P2NTrade_Multiple * saleMoney
			-- 留下金钱处理接口
			local totalPrice = buyPrice*itemNum
			local playerMoney = player:getMoney()
			local playerSubMoney = player:getSubMoney()
			local costSubMoney =0
			local costMoney = 0
			
			if buyPriceType == ItemPriceType.Money then
				if playerMoney >= totalPrice then
					costMoney = totalPrice
				else
					--玩家金钱不足无法购买
					self:sendTradeMessage(player, 5)
					return
				end
			elseif buyPriceType == ItemPriceType.FacContrib then

			elseif buyPriceType == ItemPriceType.BindMoney then
				-- 支付方式是绑银
				if player:getPayMode() then
					if playerSubMoney >= totalPrice then
						costSubMoney = totalPrice
					else 
						if (playerSubMoney + playerMoney) >= totalPrice then
							costSubMoney = playerSubMoney
							costMoney = totalPrice - costSubMoney
						else
						--玩家金钱不足无法够买
							self:sendTradeMessage(player, 5)
							return
						end
					end
				else
					if playerMoney >= totalPrice then
					costMoney = totalPrice
					else
						--玩家金钱不足无法购买
						self:sendTradeMessage(player, 5)
						return
					end	
				end
			end
		
		--获得能够放进包裹的物品数量
		if (emptyGrids == 0 and orderItemNum == 0) then 
			-- 包裹没有空格没同种物品
			self:sendTradeMessage(player, 4)
			return 
		elseif (emptyGrids == 0 and (orderItemNum % itemConfig.MaxPileNum) == 0) then
			--包裹没空格有同种物品
			self:sendTradeMessage(player, 4)
			return
		elseif orderItemNum ~= 0 then
			--包裹有空格有同种物品
			if orderItemNum < itemConfig.MaxPileNum then
				local packNum = (emptyGrids * itemConfig.MaxPileNum) + (itemConfig.MaxPileNum - orderItemNum)
				if packNum < itemNum then
					itemNum = packNum
					self:sendTradeMessage(player, 4)
				end
			elseif  (orderItemNum % itemConfig.MaxPileNum) == 0 then 
				local packNum = emptyGrids * itemConfig.MaxPileNum
				if packNum < itemNum then
					itemNum = packNum
					self:sendTradeMessage(player, 4)
				end
			else 
				local packNum =  (emptyGrids * itemConfig.MaxPileNum) + (itemConfig.MaxPileNum - orderItemNum % itemConfig.MaxPileNum) 
				if packNum < itemNum then
					itemNum = packNum
					self:sendTradeMessage(player, 4)
				end
			end
		else
			--包裹有空格和没有同种物品
			local packNum = emptyGrids * itemConfig.MaxPileNum
			if packNum < itemNum then
				itemNum = packNum
				self:sendTradeMessage(player, 4)
			end
		end
			
		if not packetHandler:addItemsToPacket(itemID, itemNum) then 
			--物品进入玩家包裹失败
			self:sendTradeMessage(player, 4)
			return 
		end
		
		--处理玩家的金钱
		local costPrice = buyPrice*itemNum
		if costMoney > 0 then 
			costMoney = costPrice
		else 
			costSubMoney = costPrice
		end
		player:setMoney(player:getMoney()-costMoney)
		player:setSubMoney(player:getSubMoney()-costSubMoney)
		player:flushPropBatch()
		--最后可能要发一个消息给客户端做提示	
		if costSubMoney > 0 then
				self:sendTradeMessage(player, 1, costSubMoney,itemNum,itemID)
			end

			if costMoney > 0 then
				self:sendTradeMessage(player, 2, costMoney,itemNum,itemID)
			end
		end
	end
end

--把npcPackID发到客户端
function TradeManager:requestNpcTrade(player, npcPackID)
	print("-----npcPackID-----", npcPackID)
	if not player then 
		return 
	end

	--获取玩家的状态,如果是交易状态则返回
	local state = player:getActionState()
	if state == PlayerStates.P2NTrade or state == PlayerStates.P2PTradeAndTeam or state == PlayerStates.P2PTrade then
		self:sendTradeMessage(player, 6)
		return 
	end
	--设置玩家的状态为交易状态
	--player:setActionState(PlayerStates.P2NTrade)
	local event = Event.getEvent(TradeEvents_SC_RequestNpc, npcPackID)
	g_eventMgr:fireRemoteEvent(event, player)
end


--P2P交易相关内容的
--判断能否请求
function TradeManager:canDoRequest(player, targetPlayer)
	local state1 = player:getActionState()
	local state2 = targetPlayer:getActionState()
	--判断玩家状态
	if (state1 == PlayerStates.P2NTrade or state1 == PlayerStates.P2PTradeAndTeam or state1 == PlayerStates.P2PTrade) then
		print("您在交易状态，正在忙")
		self:sendP2PTradeMessage(player, 1)
		return false
	end

	if (state2 == PlayerStates.P2NTrade or state2 == PlayerStates.P2PTradeAndTeam or state2 == PlayerStates.P2PTrade) then 
		print("目标玩家正在交易状态，正在忙")
		self:sendP2PTradeMessage(player, 2)
		return false
	end
	
	local systemSetHandler = targetPlayer:getHandler(HandlerDef_SystemSet)
	if systemSetHandler:getRefTrade() then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SystemSet, 5)
		g_eventMgr:fireRemoteEvent(event, player)
		return false
	end
	return true
end

--玩家首次点击交易
function TradeManager:doTradeVerifyState(roleID, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	if not player or not targetPlayer then 
		return 
	end
	local reSult = self:canDoRequest(player, targetPlayer)
	--状态不满足直接返回
	if not reSult then return end
	--记录当前发交易请求的玩家
	if not self.requestList[roleID] then
		self.requestList[roleID] = {}
		self.requestList[roleID][targetID] = os.time()
		--发交易请求到客户端
		local name = player:getName()
		local event = Event.getEvent(TradeEvents_SC_P2PSendRequest, roleID)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)

	else
		if self.requestList[roleID][targetID] then
			local curTime = os.time()
			if curTime - self.requestList[roleID][targetID] <= 30 then
				self:sendP2PTradeMessage(player, 3)
				return
			else
				self.requestList[roleID][targetID] = os.time()
				local event = Event.getEvent(TradeEvents_SC_P2PSendRequest, roleID)
				g_eventMgr:fireRemoteEvent(event, targetPlayer)
			end
		else
			self.requestList[roleID][targetID] = os.time()
			local event = Event.getEvent(TradeEvents_SC_P2PSendRequest, roleID)
			g_eventMgr:fireRemoteEvent(event, targetPlayer)
		end
	end
end

--p2p玩家下线时做一些清理工作
function TradeManager:onPlayerCheckOut(player)
	local roleID = player:getID()
	--某个玩家下线
	self:releaseP2PTrade(roleID, 0)
	if self.requestList[roleID] then
		self.requestList[roleID] = nil
	end
end

--玩家接受和拒绝交易
function TradeManager:doP2PAnswerRequest(roleID, targetID, isAccept)
	local rolePlayer = g_entityMgr:getPlayerByID(roleID)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	if(not rolePlayer or not targetPlayer ) then
		return 
	end
	--看记录当中有没有
	--此时targetID是申请者
	local roleRecord = self.requestList[targetID]
	if roleRecord then
		--如果是同意接受清除这条申请记录
		if roleRecord[roleID] then
			--先判断能否接受
			if not self:canDoRequest(rolePlayer, targetPlayer) then
				return
			end

			if isAccept then
				roleRecord[roleID] = nil
				--创建交易
				local trade = P2PTrade(rolePlayer, targetPlayer)
				if not trade then return end

				self.tradeList[roleID] = trade
				self.tradeList[targetID] = trade
				--给自己和申请者发一个消息打开交易界面
				local event1 = Event.getEvent(TradeEvents_SC_RequestAnswered, targetID, roleID)
				g_eventMgr:fireRemoteEvent(event1, rolePlayer)	
				local event2 = Event.getEvent(TradeEvents_SC_RequestAnswered, roleID, targetID)
				g_eventMgr:fireRemoteEvent(event2, targetPlayer)	
			else
				--如果是拒绝就给对方一个提示信息这时候还不能清除申请列表
				local event = Event.getEvent(TradeEvents_SC_P2PTradeRefuse, roleID, targetID)
				g_eventMgr:fireRemoteEvent(event, targetPlayer)	
			end
		end
	end
end

--P2P玩家点击X和取消交易还有交易结束
function TradeManager:doP2PCancelTrade(roleID, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local target = g_entityMgr:getPlayerByID(targetID)
	self:releaseP2PTrade(roleID, targetID)
	--发消息给目标客户端让他取消交易
	local event = Event.getEvent(TradeEvents_SC_TradeCanceled, player:getName(), 0)
	g_eventMgr:fireRemoteEvent(event, target)
	
end

--取消交易做的一些清理工作
function TradeManager:releaseP2PTrade(roleID, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local target = g_entityMgr:getPlayerByID(targetID)
	local P2PTrade = self.tradeList[roleID]
	if not P2PTrade then return end
	--某个玩家下线处理
	if not target then
		self:releaseTrade(roleID)
	else 
		--先给物品解锁
		P2PTrade:unLockFlag(player, target)
		--设置宠物的action
		P2PTrade:setPetActionState(player,target)
		--释放交易
		release(P2PTrade)
		self.tradeList[roleID] = nil
		self.tradeList[targetID] = nil
	end
end

--单一玩家下线
function TradeManager:releaseTrade(roleID)
	local P2PTrade = self.tradeList[roleID]
	if P2PTrade then
		local player = g_entityMgr:getPlayerByID(roleID)
		local targetID = P2PTrade:getOtherID(roleID)
		local target = g_entityMgr:getPlayerByID(targetID)
		P2PTrade:unLockFlag(player, target)
		--设置宠物的action
		P2PTrade:setPetActionState(player,target)
		release(P2PTrade)
		self.tradeList[roleID] = nil
		self.tradeList[targetID] = nil
		--发消息给目标客户端让他取消交易
		local event = Event.getEvent(TradeEvents_SC_TradeCanceled, player:getName(), 1)
		g_eventMgr:fireRemoteEvent(event, target)
	end
end

--服务器根据物品的Guid获取物品 和宠物交易调用同一个接口
function TradeManager:doP2PTradeShowItem(showItemInfo)
	local roleID = showItemInfo.roleID
	local trade = self.tradeList[roleID]
	if trade then
		local role = g_entityMgr:getPlayerByID(roleID)
		if not role then return end

		local targetRole = g_entityMgr:getPlayerByID(showItemInfo.targetID)
		if not targetRole then return end

		local tradeType = showItemInfo.tradeType
		--如果是物品交易
		if tradeType == P2PTradeType.Item then
			trade:doTradeItem(role, targetRole, showItemInfo.tradeAction, showItemInfo.itemGuid, showItemInfo.itemNum, showItemInfo.index)
		elseif tradeType == P2PTradeType.Pet then
			local result = trade:doTradePet(role, targetRole, showItemInfo.tradeAction, showItemInfo.petID)
			if result > 0 then
				-- 交易宠物条件不满足时的信息给自己
				self:sendP2PTradeMessage(role, result)
			end
		end
	end
end

--玩家点击锁定
function TradeManager:doP2PTradeLock(roleID, targetID, tradeMoney)
	local trade = self.tradeList[roleID]
	if trade then
		local role = g_entityMgr:getPlayerByID(roleID)
		if not role then return end

		local targetRole = g_entityMgr:getPlayerByID(targetID)
		if not targetRole then return end

		--执行交易锁定顺便设置一下钱数
		trade:setTradeMoney(role, targetRole, tradeMoney)
	end
end

--玩家点击确定按钮
function TradeManager:doP2PConfirmTrade(roleID, targetID)
	local trade = self.tradeList[roleID]
	if trade then
		local role = g_entityMgr:getPlayerByID(roleID)
		if not role then return end

		local targetRole = g_entityMgr:getPlayerByID(targetID)
		if not targetRole then return end

		--执行确定交易
		trade:doConfirmTrade(role, targetRole)
	end
end

--完成交易
function TradeManager:doFinishTrade(roleID, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local target = g_entityMgr:getPlayerByID(targetID)
	local P2PTrade = self.tradeList[roleID]
	if P2PTrade then 
		--释放交易
		release(P2PTrade)
		self.tradeList[roleID] = nil
		self.tradeList[targetID] = nil
	end
	--再个各自玩家发完成的消息
	local event = Event.getEvent(TradeEvents_SC_P2PTradeFinish)
	g_eventMgr:fireRemoteEvent(event, player)
	g_eventMgr:fireRemoteEvent(event, target)
end

--宠物商店购买宠物
function TradeManager:petBuyShop(player, petID, petBuyPrice, petBuyType)
	local playerMoney = player:getMoney()
	local playerSubMoney = player:getSubMoney()
	if petBuyType == ItemPriceType.BindMoney then 
		if petBuyPrice <= playerSubMoney then 
			if player:canAddPet() then
				local pet = g_entityFct:createPet(tonumber(petID))
				if not pet then
					print(("宠物%s是没有配置的"):format(petID))
					return
				end
				pet:setOwner(player)
				player:addPet(pet)
				player:setSubMoney(playerSubMoney-petBuyPrice)
				self:sendTradeMessage(player, 13, petBuyPrice,1,petID)
			else
				g_eventMgr:fireRemoteEvent(
					Event.getEvent(
						ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.MaxPetNumber
					),player
				)
			end	
		else
			return 
		end 
	elseif petBuyType == ItemPriceType.Money then
		if  petBuyPrice <= playerMoney then 
			if player:canAddPet() then
				local pet = g_entityFct:createPet(petID)
				if not pet then
					print(("宠物%s是没有配置的"):format(petID))
					return
				end
				pet:setOwner(player)
				player:addPet(pet)
				player:setMoney(playerMoney-petBuyPrice)
				self:sendTradeMessage(player, 14, petBuyPrice,1,petID)
			else
				g_eventMgr:fireRemoteEvent(
					Event.getEvent(
						ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.MaxPetNumber
					),player
				)
			end		
		else
			self:sendTradeMessage(player, 5)
			return 
		end 
	else 
		return 
	end 
end 

--处理P2P发过来的消息
function TradeManager:P2PMessageChoose(player,roleID, targetID, choose)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	local choose = choose
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_P2PTrade, choose)
	g_eventMgr:fireRemoteEvent(event, targetPlayer)	
end 

-- NPC货架交易提示信息
function TradeManager:sendTradeMessage(player, msgID, money,itemNum,itemID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, msgID,itemNum,itemID,money)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- p2p交易相关提示信息
function TradeManager:sendP2PTradeMessage(player, msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_P2PTrade, msgID)
	g_eventMgr:fireRemoteEvent(event, player)
end

function TradeManager.getInstance()
	return TradeManager()
end