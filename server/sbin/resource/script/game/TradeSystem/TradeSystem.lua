--[[TradeSystem.lua
描述:
交易系统,处理客户端交易相关信息
--]]

require "game.TradeSystem.TradeManager"
require "game.ItemSystem.Shelf"
require "game.TradeSystem.P2PTrade"
require "game.TradeSystem.Trade"

TradeSystem = class(EventSetDoer, Singleton)

function TradeSystem:__init()
	self._doer =
	{
		--右键单击购买物品
		[TradeEvents_CS_BuyGoods]				= TradeSystem.doPtoNBuyGoods,
		--关闭交易
		[TradeEvents_CS_CloseTrade]				= TradeSystem.doCloseTrade,
		--出售物品给NPC
		[TradeEvents_CS_SellGoods]				= TradeSystem.doSellGoods,
		--改变玩家的支付方式
		[TradeEvents_CS_PayMode]				= TradeSystem.doPayMode,
		--玩家购回卖出去的物品
		[TradeEvents_CS_BuyBack]				= TradeSystem.doBuyBack,

		--P2P交易请求相关信息
		[TradeEvents_CS_P2PTradeVerifyState]	= TradeSystem.doTradeVerifyState,
		--p2p接受请求相关信息
		[TradeEvents_CS_P2PAnswerRequest]		= TradeSystem.doP2PAnswerRequest,
		--p2p取消交易
		[TradeEvents_CS_P2PCancelTrade]			= TradeSystem.doP2PCancelTrade,
		--p2p记录物品的相关信息
		[TradeEvents_CS_P2PTradeShowItem]		= TradeSystem.doP2PTradeShowItem,
		--p2p玩家点击锁定
		[TradeEvents_CS_P2PTradeLock]			= TradeSystem.doP2PTradeLock,
		--p2p玩家点击确定交易
		[TradeEvents_CS_P2PConfirmTrade]		= TradeSystem.doP2PConfirmTrade,
		-- p2p记录宠物的相关信息
		[TradeEvents_CS_P2PTradePet]			= TradeSystem.doP2PTradePet,
	}
end

-- p2p交易宠物
function TradeSystem:doP2PTradePet(event)
	local params = event:getParams()
	local showPetInfo = params[1]
	--服务器根据宠物ID获取宠物相关信息
	g_tradeMgr:doP2PTradeShowItem(showPetInfo)
end

--玩家点击确定按钮来确定交易
function TradeSystem:doP2PConfirmTrade(event)
	local params = event:getParams()
	local roleID = params[1]
	local targetID = params[2]
	g_tradeMgr:doP2PConfirmTrade(roleID, targetID)
end

--玩家点击锁定按钮
function TradeSystem:doP2PTradeLock(event)
	local params = event:getParams()
	local roleID = params[1]
	local targetID = params[2]
	local tradeMoney = params[3]
	--此时玩家锁定时要把玩家的金钱给记录一下
	g_tradeMgr:doP2PTradeLock(roleID, targetID, tradeMoney)
end

--p2p交易记录物品相关信息
function TradeSystem:doP2PTradeShowItem(event)
	local params = event:getParams()
	local showItemInfo = params[1]
	--服务器根据物品的Guid获取物品
	g_tradeMgr:doP2PTradeShowItem(showItemInfo)
end

--p2p取消交易
function TradeSystem:doP2PCancelTrade(event)
	local params = event:getParams()
	local roleID = params[1]
	local targetID = params[2]
	g_tradeMgr:doP2PCancelTrade(roleID, targetID)
end

--p2p接受交易请求
function TradeSystem:doP2PAnswerRequest(event)
	local params = event:getParams()
	local roleID = params[1]
	local targetID = params[2]
	local isAccept = params[3]
	g_tradeMgr:doP2PAnswerRequest(roleID, targetID, isAccept)
end

--P2P交易请求
function TradeSystem:doTradeVerifyState(event)
	local params = event:getParams()
	local roleID = params[1]
	local targetID = params[2]
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local mapID = player:getCurPos()
	if mapID >= EctypeMap_StartID then
	    local ectype = g_ectypeMgr:getEctype(mapID)
	    if ectype and not ectype:canTradeInEctype() then
		    --此副本不可交易
			g_ectypeMgr:sendEctypeMessageTip(player, 9)
			return
		end
	end
	--玩家首次点击p2p交易
	g_tradeMgr:doTradeVerifyState(roleID, targetID)
end

--p2p交易相关内容
--玩家购回卖出去的物品
function TradeSystem:doBuyBack(event)
	local params = event:getParams()
	local itemGuid = params[1]
	local itemNum = params[2]
	local moveItemInfo = params[3]
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	g_tradeMgr:ptoNBuyBack(player, itemGuid, itemNum, moveItemInfo)
end

--设置玩家的支付方式
function TradeSystem:doPayMode(event)
	local params = event:getParams()
	local payMode = params[1]
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	player:setPayMode(payMode)
end

--出售物品给NPC出售价格从物品配置表读取
--出售价格的类型也是从物品配置表读取
function TradeSystem:doSellGoods(event)
	local params = event:getParams()
	local itemID = params[1]
	local itemNum = params[2]
	local moveItemInfo = params[3]
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	g_tradeMgr:ptoNSellGoods(player, itemID, itemNum, moveItemInfo)
end

--客户端点击x关闭与NPC的交易
function TradeSystem:doCloseTrade(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	g_tradeMgr:closeTrade(player)
end

--客户端点击确定和右键购买物品
function TradeSystem:doPtoNBuyGoods(event)
	print("------------购买物品。。。。。")
	local params = event:getParams()
	local itemID = params[1]
	local itemNum = params[2]
	local npcPackID = params[3]
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	--服务器处理玩家和Npc商店交易
	g_tradeMgr:ptoNBuyGoods(player, itemID, itemNum, npcPackID)

end

function TradeSystem.getInstance()
	return TradeSystem()
end

EventManager.getInstance():addEventListener(TradeSystem.getInstance())