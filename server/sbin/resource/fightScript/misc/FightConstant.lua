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

--战斗动作类型
FightActionType = {
		Auto			= 1,	-- 自动
		CommonAttack	= 2,	-- 普通攻击
		UseCommonSkill	= 3,	-- 使用技能
		Protect			= 4,	-- 保护
		Escape			= 5,	-- 逃跑
		UseMaterial		= 6,	-- 使用物品
		Catch			= 7,	-- 捕捉
		Defense			= 8,	-- 防御
		Call			= 9,	-- 召唤
		CallBack		= 10,	-- 召回
		System			= 11,   --系统

		UseUniteSkill	= 20,	-- 使用合击技能
		UseBuffSkill	= 21,	-- 使用Buff技能
		UseResumeSkill	= 22,	-- 使用恢复技能
		SystemSkill		= 23,	-- 系统技能
		DispelSkill		= 24,	-- 驱散技能
		Relive			= 25,	-- 重生
		Buff 			= 26, 	--buff
}

FightCallType = {
	Monster = 1,
	Pet		= 0,
}

--站位角色类型
StandRoleType = {
			Player = 1,
			Pet = 2,
			Monster = 3,
			Npc	= 4,
}

--怪物类型
monsterType = 
{
	commonMonster	= 1,--普通怪物
	bossMonster		= 2,--boss怪物
}
AIType = {
			Config = 1,--普通
			Script = 2,--脚本
}
--战斗阵型
FightStandMap = {
		[FightType.PVE] = {
					--a边玩家
					[1] =	{
							--1个玩家
							[1] = { 
								[StandRoleType.Player] = {8},
								[StandRoleType.Pet] = {6},
								[StandRoleType.Npc] =	{
									  [1] = {11},
									  [2] = {11,3},
									  [3] = {2,4,11},
									},
							       },
							--2个玩家
							[2] = { 
								[StandRoleType.Player] = {7,4},
								[StandRoleType.Pet] = {5,2},
								[StandRoleType.Npc] =	{
									  [1] = {10},
									  [2] = {10,12},
									  [3] = {10,11,12},
									},
							       },
							--3个个玩家
							[3] = { 
								[StandRoleType.Player] = {7,4,12},
								[StandRoleType.Pet] = {5,2,10},
								[StandRoleType.Npc] =	{
									  [1] = {11},
									  [2] = {11,3},
									  [3] = {11,3,6},
									},
							       },
							--4个个玩家
							[4] = { 
								[StandRoleType.Player] = {7,4,11,16},
								[StandRoleType.Pet] = {5,2,9,14},
								[StandRoleType.Npc] =	{
									  [1] = {4},
									  [2] = {4,5},
									  [3] = {4,5,7},
									  [4] = {4,5,7,8},
									},
							       },
							--5个个玩家
							[5] = { 
								[StandRoleType.Player] = {1,9,10,7,8},
								[StandRoleType.Pet] = {11,4,5,2,3},
								[StandRoleType.Npc] =	{
									  [1] = {6},
									  [2] = {6,12},
									  
									},
							       },
						},
					--b边怪物:[怪物数量]={位置1，位置2}
					[2] =	{
							[1] = {26},
							[2] = {25,27},
							[3] = {26,21,29},
							[4] = {22,25,27,30},
							[5] = {26,21,29,23,31},
							[6] = {21,23,26,28,29,31},
							[7] = {21,23,26,28,30,32,33},
							[8] = {21,23,26,28,30,32,33,35},
						},
				
				 },

	[FightType.PVP] = {
					--a边玩家
					[1] =	{
							--1个玩家
							[1] = { 
								[StandRoleType.Player] = {8},
								[StandRoleType.Pet] = {6},
								[StandRoleType.Npc] =	{
									  [1] = {11},
									  [2] = {11,3},
									  [3] = {2,4,11},
									},
							       },
							--2个玩家
							[2] = { 
								[StandRoleType.Player] = {7,4},
								[StandRoleType.Pet] = {5,2},
								[StandRoleType.Npc] =	{
									  [1] = {10},
									  [2] = {10,12},
									  [3] = {10,11,12},
									},
							       },
							--3个个玩家
							[3] = { 
								[StandRoleType.Player] = {7,4,12},
								[StandRoleType.Pet] = {5,2,10},
								[StandRoleType.Npc] =	{
									  [1] = {11},
									  [2] = {11,3},
									  [3] = {11,3,6},
									},
							       },
							 --4个个玩家
							[4] = { 
								[StandRoleType.Player] = {7,4,11,16},
								[StandRoleType.Pet] = {5,2,9,14},
								[StandRoleType.Npc] =	{
									  [1] = {4},
									  [2] = {4,5},
									  [3] = {4,5,7},
									  [4] = {4,5,7,8},
									},
							       },
						},
					--b边玩家:
					[2] =	{
							--1个玩家
							[1] = { 
								[StandRoleType.Player] = {25},
								[StandRoleType.Pet] = {27},
								[StandRoleType.Npc] =	{
									  [1] = {25},
									  [2] = {25,17},
									  [3] = {18,16,25},
									},
							       },
							--2个玩家
							[2] = { 
								[StandRoleType.Player] = {26,21},
								[StandRoleType.Pet] = {28,23},
								[StandRoleType.Npc] =	{
									  [1] = {26},
									  [2] = {26,24},
									  [3] = {26,25,24},
									},
							       },
							--3个个玩家
							[3] = { 
								[StandRoleType.Player] = {26,21,29},
								[StandRoleType.Pet] = {28,23,31},
								[StandRoleType.Npc] =	{
									  [1] = {25},
									  [2] = {25,17},
									  [3] = {25,17,22},
									},
							       },
						         --4个个玩家
							[4] = { 
								[StandRoleType.Player] = {27,22,31,34},
								[StandRoleType.Pet] = {28,23,32,35},
								[StandRoleType.Npc] =	{
									  [1] = {4},
									  [2] = {4,5},
									  [3] = {4,5,7},
									  [4] = {4,5,7,8},
									},
							       },
						},
				
				 },
}
PVPPosMap =
{
	["a->b"]={
		[1]=24,[2]=23,[3]=22,[4]=21,
		[5]=28,[6]=27,[7]=26,[8]=25,
		[9]=32,[10]=31,[11]=30,[12]=29,
		[13]=36,[14]=35,[15]=34,[16]=33,
	},
	["b->a"]={
		[21]=4,[22]=3,[23]=2,[24]=1,
		[25]=8,[26]=7,[27]=6,[28]=5,
		[29]=12,[30]=11,[31]=10,[32]=9,
		[33]=16,[34]=15,[35]=14,[36]=13,
	},
}

FightMapPoses = {a={},b={}}
for posA , posB in pairs(PVPPosMap["a->b"]) do
	FightMapPoses.a[posA] = true
	FightMapPoses.b[posB] = true
end

FightClientDefaultMapID = 2
FightMaxRound = 99
FullMaxHpMpLevel = 25
PunishVigorReduction = 10
PunishDurReductionPerc = 10

FightBussinessType = 
{
	Wild	= 1,--野外
	Excise	= 2,--切磋
	PK		= 3,--PK
	Task	= 4,--任务
	Test	= 5,--测试
	Collect = 6,--采集
	Treasure= 7,--藏宝图

}
CallPetLevelNeed = 10
ReadyPetExpOff = 20
PetWinReduceLife = {10,20}