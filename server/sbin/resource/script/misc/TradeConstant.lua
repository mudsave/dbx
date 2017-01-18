--[[TradeConstant.lua
描述：
交易系统常量的定义
--]]

--p2p交易的类型
P2PTradeType = 
{
	--物品
	Item		= 1,
	--宠物
	Pet			= 2,
	--银两
	Money		= 3,
}

--p2p交易的动作
TradeAction = 
{
	--上架
	ActionUp	= 1,
	--下架
	ActionDown	= 2,
}

--交易的状态
TradeState = 
{
	--进入交易
	Status_Enter		= 1,
	--上下架物品
	Status_ChangeItem	= 2,
	--枷锁
	Status_LockTrade	= 3,
	--确定交易
	Status_ComfirmTrade	= 4,
}


--p2p交易消息
TradeMsgID = 
{
	--成功购买
	SuccessBuy	= 1,
	--成功出售
	SuccessSell	= 2,
	--包裹满
	PacketFull	= 4,
	--钱不足
	MoneyLess	= 5,
	--正在交易
	Trading		= 6,
	--此包裹物品不能出售
	PacketItemNotSell	= 7,
	--不能购买到当前包裹中
	ItemNotBuyToPacket	= 8,
	
}

P2PTrade_ItemMaxNum = 12
P2NTrade_Multiple = 10
PetTradeMax = 4
P2PTrade_LevelDiffer = 10
