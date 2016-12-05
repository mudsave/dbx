--[[constant.lua
鎻忚堪锛?	瀹炰綋甯搁噺
	--misc.constant鑴氭湰涓嬫枃浠?]]
--闂ㄦ淳绫诲埆
SchoolType = {
	PM          = 0x00,
	QYD         = 0x01,
	JXS         = 0x02,
	ZYM         = 0x03,
	YXG         = 0x04,
	TYD         = 0x05,
	PLG         = 0x06,
}

--玩家性别的类型
PlayerSexType = {
	Females         = 0x00, --女性
	Males           = 0x01, --男性
}
RightPos4Error = {mapID = 10,x = 200 ,y = 198,}
--玩家的状态
PlayerStates =
{
	Normal          = 0x01, --普通站立
	Team            = 0x02, --组队
	Follow          = 0x04, --跟随
	AutoMeet		= 0x08,	--自动遇敌
	Fight           = 0x10, --战斗
	P2NTrade        = 0x20, --交易
	P2PTrade		= 0x40,--P2P交易
	FightAndTeam	= 0x800,--战斗和组队
	P2PTradeAndTeam	= 0x100,--P2p交易和组队
}

require "misc.EntityConstant"
require "misc.EctypeConstant"
require "misc.ItemConstant"
require "misc.EquipPlayingConstant"
require "misc.HandlerConstant"
require "misc.RideConstant"
require "misc.TeamConstant"
