--[[FightConstant .lua
描述：
	实体常量
	--misc.FightConstant 脚本下文件
]]

--战斗类型
FightType = {
		PVE = 1,
		PVP = 2,
		Script = 3,
}



AIType = {
			Config = 1,--普通
			Script = 2,--脚本
}

FightClientDefaultMapID = 2
FightMaxRound = 99
FullMaxHpMpLevel = 25
PunishVigorReduction = 10
PunishDurReductionPerc = 10

FightBussinessType = 
{
	Wild			= 1,--野外
	Excise			= 2,--切磋
	PK				= 3,--PK
	Task			= 4,--任务
	Test			= 5,--测试
	Collect			= 6,--采集
	Treasure		= 7,--藏宝图
	EctypePatrol	= 8,--副本巡逻战斗
	GoldHunt		= 9,--猎金场
	ActivityPatrol	= 10,--捕宠活动战斗
	DicussHero		= 11,--煮酒论英雄活动战斗

}
CallPetLevelNeed = 10
ReadyPetExpOff = 20

DropType = 
{
	Exp			= 1,
	Pot			= 2,
	PlayerTao	= 3,
	PetTao		= 4,
}