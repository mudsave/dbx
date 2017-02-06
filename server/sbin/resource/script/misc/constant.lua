--[[constant.lua
描述：
	实体常量
	--misc.constant脚本下文件
]]
SocialWorldID = 200

RightPos4Error = {mapID = 10,x = 200 ,y = 198,}
PlayerBornPos  = {mapID = 8,x = 95 ,y = 220}
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

--门派初始模型配置
SchoolModelSwitch = {
	[PlayerSexType.Females] = {
		[SchoolType.QYD] = 2,
		[SchoolType.JXS] = 8,
		[SchoolType.ZYM] = 6,
		[SchoolType.YXG] = 10,
		[SchoolType.TYD] = 4,
		[SchoolType.PLG] = 12,
	},
	[PlayerSexType.Males] = {
		[SchoolType.QYD] = 1,
		[SchoolType.JXS] = 7,
		[SchoolType.ZYM] = 5,
		[SchoolType.YXG] = 9,
		[SchoolType.TYD] = 3,
		[SchoolType.PLG] = 11,
	},
}

MemCollectPeriod = 60
OnlineReason = {
	Normal = 1,
	Reattach = 2,
	Relogin	 = 3,
}


require "misc.EntityConstant"
require "misc.ActivityConstant"
require "misc.EctypeConstant"
require "misc.ItemConstant"
require "misc.EquipPlayingConstant"
require "misc.HandlerConstant"
require "misc.RideConstant"
require "misc.TeamConstant"
require "misc.TaskConstant"
require "misc.DialogConstant"
require "misc.PKConstant"
require "misc.BuffConstant"
require "misc.TradeConstant"
require "misc.SkillConstant"
require "misc.MindConstant"
require "misc.LifeSkillConstant"
require "misc.TreasureConstant"
require "misc.EffectConstant"
require "misc.FightConstant"
require "misc.PractiseConstant"
require "misc.TransportationConstant"
require "misc.SocialServerConstant"
require "misc.MeetMonsterConstant"
require "misc.PetDepotConstant"
require "misc.ActivityConstant"
require "misc.GoldHuntZoneConstant"





