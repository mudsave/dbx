--[[BuffConstant.lua
描述：
	buff常量定义
]]

-- 对战斗外buff功能函数的Map
FightOutBuffMap = {
	-- 生命自动恢复
	[FightOutBuffType.hp_pool] 		= 	{"startHpPool","calcHpPool","stopHpPool"}, 
	-- 法力自动恢复	
	[FightOutBuffType.mp_pool] 		= 	{"startMpPool","calcMpPool","stopMpPool"}, 
	-- 驱魔香	
	[FightOutBuffType.exorcism] 	= 	{"startExorcism","calcExorcism","stopExorcism"}, 
	-- 驭兽铃	
	[FightOutBuffType.rein_beast] 	= 	{"startReinBeast","calcReinBeast","stopReinBeast"},
	-- 多倍经验丹
	[FightOutBuffType.xp_boost] 	= 	{"startXpBoost","calcXpBoost","stopXpBoost"}, 
	-- 护心丹	
	[FightOutBuffType.god_bless]	= 	{"startGodBless","calcGodBless","stopGodBless"},
	-- 变身卡
	[FightOutBuffType.tarns_card] 	= 	{"startTarnsCard","calcTarnsCard","stopTarnsCard"},
	-- 强制pk	
	[FightOutBuffType.enforced_pk] 	= 	{"startEnforcedPk","calcEnforcedPk","stopEnforcedPk"},
	-- 保护pk
	[FightOutBuffType.protect_pk] 	= 	{"startProtectPk","calcProtectPk","stopProtectPk"}, 
	-- 恶贯满盈
	[FightOutBuffType.evil]			= 	{"startEvil","calcEvil","stopEvil"},
	-- 宠物忠诚池
	[FightOutBuffType.loyalty_pool] = 	{"startLoyaltyPool","calcLoyaltyPool","stopLoyaltyPool"},
	-- 战斗计数buff
	[FightOutBuffType.fight_count] =	{"startFightCount","calcFightCount","stopFightCount"},
	-- 满怪buff
	[FightOutBuffType.full_monster] =	{"startFullMoster","calcFullMoster","stopFullMoster"},
}

-- buff列表中的ID
FightOutBuffPos = {
	hp_pool			= 1,
	mp_pool			= 2,
	exorcism 		= 3,
	rein_beast		= 4,
	xp_boost		= 5,
	god_bless		= 6,
	tarns_card		= 7,
	enforced_pk		= 8,
	protect_pk		= 9,
	evil			= 10,
	loyalty_pool	= 11,
	fight_count		= 12,
	full_monster	= 13,
}

-- 变身卡的影响方法
Trans_effect_method = {
	[Trans_effect.ChangeAt]			= "inc_at_add",
	[Trans_effect.ChangeMt]			= "inc_mt_add",
	[Trans_effect.ChangeAf]			= "inc_af_add",
	[Trans_effect.ChangeMf]			= "inc_mf_add",
	[Trans_effect.ChangeHit]		= "inc_hit_add",
	[Trans_effect.ChangeDodge]		= "inc_dodge_add",
	[Trans_effect.ChangeCritical]	= "inc_critical_add",
	[Trans_effect.ChangeTenacity]	= "inc_tenacity_add",
	[Trans_effect.ChangeSpeed]		= "inc_speed_add",
	[Trans_effect.ChangeWinAt]		= "inc_wind_at_add",
	[Trans_effect.ChangeThuAt]		= "inc_thunder_at_add",
	[Trans_effect.ChangeIceAt]		= "inc_ice_at_add",
	[Trans_effect.ChangeFirAt]		= "inc_fire_at_add",
	[Trans_effect.ChangeSoiAt]		= "inc_soil_at_add",
	[Trans_effect.ChangePoiAt]		= "inc_poison_at_add",
	[Trans_effect.ChangeWinResist]	= "inc_wind_resist_add",
	[Trans_effect.ChangeThuResist]	= "inc_thunder_resist_add",
	[Trans_effect.ChangeIceResist]	= "inc_ice_resist_add",
	[Trans_effect.ChangeFirResist]	= "inc_fire_resist_add",
	[Trans_effect.ChangeSoiResist]	= "inc_soil_resist_add",
	[Trans_effect.ChangePoiResist]	= "inc_poison_resist_add",
	[Trans_effect.ChangeAllt]		= "inc_all_at_mt",
	[Trans_effect.ChangeAllf]		= "inc_all_af_mf",
}

--[[
同类型叠加 （同id叠加 不同id叠加）
同类型不同ID不叠加（同id叠加 不同id不叠加）
同类型不叠加 （同id不叠加 不同id不叠加）
--]]

--叠加 替换  同ID叠加
ReplaceType = {
	overlay = 1,
	replace = 2,
	same_and_replace = 3,
}

-- 提供测试的信息
PrintTypeInfo = {
	[BuffKind.AddPhase]			= "相性增益",
	[BuffKind.AddAttr]			= "属性增益",
	[BuffKind.Sub]				= "减益",
	[BuffKind.Dot]				= "持续掉血",
	[BuffKind.TransCard]		= "变身卡",
	[BuffKind.ChaosObstacle]	= "混乱障碍",
	[BuffKind.PoisonObstacle]	= "中毒障碍",
	[BuffKind.FreezeObstacle]	= "冰冻障碍",
	[BuffKind.SilenceObstacle]	= "沉默障碍",
	[BuffKind.TauntObstacle]	= "嘲讽障碍",
	[BuffKind.SoporObstacle]	= "昏睡障碍",
	[BuffKind.Shield]			= "护盾Buff",
	[BuffKind.JXSTrans]			= "金霞山变身",
	[BuffKind.QYDXuLi]			= "乾元岛蓄力",
	[BuffKind.QYDXuRuo]			= "乾元岛虚弱",
	[BuffKind.ZYMXuLi]			= "紫阳门蓄力",
	[BuffKind.Special]			= "特殊类buff",
	[BuffKind.HealReduce]		= "治疗效果下降",
	[BuffKind.AllAttrReduce]	= "所有属性下降",
	[BuffKind.Dispel]			= "驱散增益",
	[BuffKind.PhaseRestrain]	= "相性克制",
	[BuffKind.MpDot]			= "持续耗蓝",
	[BuffKind.CouterDmg]		= "反震伤害",
	[BuffKind.RestoreHp]		= "恢复hp",
	[BuffKind.RestoreMp]		= "恢复mp",
	[BuffKind.HealIncrease]		= "治疗效果增加",
	[BuffKind.AllAttrIncrease]	= "所有属性增加",
}

-- 增益buff 
GoodBuff = {
	BuffKind.AddPhase,
	BuffKind.AddAttr,
	BuffKind.Shield,
	-- BuffKind.JXSTrans,	-- 不可驱散
}

-- 减益buff
DeBuff = {
	BuffKind.Sub,
	BuffKind.Special,
	BuffKind.HealReduce,
	BuffKind.PhaseRestrain,
	BuffKind.AllAttrReduce,
	BuffKind.Dispel,
	BuffKind.MpDot,
}


-- 添加buff的位置
BuffBindPoint = {
	m_overhead = 1, --头顶
	m_ground = 2,	--脚下
	m_chest = 3,	--身体
}

toEnemy = 1
toFriend = 2
toMyself = 3
fromEnemy = 4
fromFriend = 5

--嘲讽
disorderTaunt = {
	[toEnemy] = {
		can = 1,
		normal_at = 1,
		mpSkill = 0,
		nonmpSkill = 0,
		joinUnionAt = 0,
	},
	[toFriend] = {
		can = 0,
	},
	[toMyself] = {
		can = 0,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

--中毒
disorderPoison = {
	[toEnemy] = {
		can = 0,
	},
	[toFriend] = {
		can = 1,
		protect = 1,
		mpHelpfulSkill = 1,
		nonMpHelpfulSkill = 1,
	},
	[toMyself] = {
		can = 1,
		defense = 1,
		escape = 1,
		mpHelpfulSkill = 1,
		nonMpHelpfulSkill = 1,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

--冰冻
disorderFreeze = {
	[toEnemy] = {
		can = 0,
	},
	[toFriend] = {
		can = 0,
	},
	[toMyself] = {
		can = 0,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

--昏睡
disorderSopor = {
	[toEnemy] = {
		can = 0,
	},
	[toFriend] = {
		can = 0,
	},
	[toMyself] = {
		can = 0,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

--混乱
disorderChaos = {
	[toEnemy] = {
		can = 1,
		normal_at = 1,
		mpSkill = 1,
		nonmpSkill = 0,
		joinUnionAt = 0,
	},
	[toFriend] = {
		can = 0,
	},
	[toMyself] = {
		can = 0,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

--沉默
disorderSilence = {
	[toEnemy] = {
		can = 1,
		normal_at = 1,
		mpSkill = 0,
		nonmpSkill = 0,
		joinUnionAt = 1,

	},
	[toFriend] = {
		can = 1,
		protect = 1,
		mpHelpfulSkill = 0,
		nonMpHelpfulSkill = 1,
	},
	[toMyself] = {
		can = 1,
		defense = 1,
		escape = 1,
		mpHelpfulSkill = 0,
		nonMpHelpfulSkill = 1,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

--正常状态
disorderNormal = {
	[toEnemy] = {
		can = 1,
		normalAt = 1,
		mpSkill = 1,
		nonmpSkill = 1,
		joinUnionAt = 1,

	},
	[toFriend] = {
		can = 1,
		protect = 1,
		mpHelpfulSkill = 1,
		nonMpHelpfulSkill = 1,
	},
	[toMyself] = {
		can = 1,
		defense = 1,
		escape = 1,
		mpHelpfulSkill = 1,
		nonMpHelpfulSkill = 1,
	},
	[fromEnemy] = {
		can = 1,
	},
	[fromFriend] = {
		can = 1,
	},
}

SkillAttrType =
{
	addPhase				= 0x01,--相性增益
	reducePhase				= 0x02,--相性减益
	addAttr					= 0x03,--属性增益
	reduceAttr				= 0x04,--属性减益
	immunityHurt			= 0x05,--免疫伤害
	absorbHurt				= 0x06,--吸收伤害
	addAndReduceAttr		= 0x07,--属性增减益
	defenseAndIgnoreControl	= 0x08,--防+免控
}

-- 战斗中对应的障碍buff
DisorderBuffMap = {
	[BuffKind.ChaosObstacle] 	= {"startChaosObstacle"},
	[BuffKind.PoisonObstacle]	= {"startPoisonObstacle"},
	[BuffKind.FreezeObstacle]	= {"startFreezeObstacle"},
	[BuffKind.SilenceObstacle]	= {"startSilenceObstacle"},
	[BuffKind.TauntObstacle]	= {"startTauntObstacle"},
	[BuffKind.SoporObstacle]	= {"startSoporObstacle"},
}

-- 战斗中的buff集对应的方法
FightBuffMap = {
	[BuffKind.AddPhase]			= {"startAddPhase", "calcAddPhase", "stopAddPhase"},
	[BuffKind.AddAttr]			= {"startAddAttr", "calcAddAttr", "stopAddAttr"},
	[BuffKind.Sub]				= {"startSub", "calcSub", "stopSub"},
	[BuffKind.Dot]				= {"startHpDot", "calcHpDot", "stoptHpDot"},
	[BuffKind.Shield]			= {"startShield", "calcShield", "stopShield"},
	[BuffKind.JXSTrans]			= {"startJXSTrans", "calcJXSTrans", "stopJXSTrans"},
	[BuffKind.QYDXuLi]			= {"startQYDAccrue", "calcQYDAccrue", "stopQYDAccrue"},
	[BuffKind.QYDXuRuo]			= {"startQYDXuRuo", "calcQYDXuRuo", "stopQYDXuRuo"},
	[BuffKind.ZYMXuLi]			= {"startZYMAccrue", "calcZYMAccrue", "stopZYMAccrue"},
	[BuffKind.HealReduce]		= {"startHealReduce", "calcHealReduceBuff", "stopHealReduceBuff"},
	[BuffKind.AllAttrReduce]	= {"startAllAttrReduce", "calcAllAttrReduce", "stopAllAttrReduce"},
	[BuffKind.Dispel]			= {"startDispel", "calcDispel", "stopDispel"},
	[BuffKind.PhaseRestrain]	= {"startPhaseRestrain", "calcPhaseRestrain", "stopPhaseRestrain"},
	[BuffKind.CouterDmg]		= {"startCouterDmg", "calcCouterDmg", "stopCouterDmg"},
	[BuffKind.MpDot]			= {"startMpDot", "calcMpDot" ,"stopMpDot"},
	[BuffKind.RestoreHp]		= {"startRestoreHp", "calcRestoreHp", "stopRestoreHp"},
	[BuffKind.RestoreMp]		= {"startRestoreMp", "calcRestoreMp", "stoptRestoreMp"},
}

DisorderResistMapping = {
	[BuffKind.ChaosObstacle] = "get_chaos_resist",
	[BuffKind.PoisonObstacle] = "get_poison_resist",
	[BuffKind.FreezeObstacle] = "get_freeze_resist",
	[BuffKind.SilenceObstacle] = "get_silent_resist",
	[BuffKind.TauntObstacle] = "get_taunt_resist",
	[BuffKind.SoporObstacle] = "get_sopor_resist",
}

PetSpecialBuffConf = {
	[1000] = {"getS1Success", "getS1Failed", "getS1AddTarget"},
	[1001] = {"getS2Success", "getS2Failed", "getS2AddTarget"},
	[1002] = {"getS3Success", "getS3Failed", "getS3AddTarget"},
	[1003] = {"getS4Success", "getS4Failed", "getS4AddTarget"},
	[1004] = {"getS5Success", "getS5Failed", "getS5AddTarget"},
	[1005] = {"getS6Success", "getS6Failed", "getS6AddTarget"},
}

-- 障碍类BUFF集合
DisorderBuffKindMap = {
	BuffKind.HealReduce,
	BuffKind.AllAttrReduce,
	BuffKind.Dispel,
	BuffKind.PhaseRestrain,
	BuffKind.Dot,
	BuffKind.MpDot,
}

-- 基础辅助类BUFF集合
AssistBuffKindMap = {
	BuffKind.AddAttr,
	BuffKind.AddPhase,
	BuffKind.Shield,
	BuffKind.RestoreMp,
	BuffKind.RestoreHp,
	BuffKind.CouterDmg,
}
-- buff的持续类型
BuffStayType = {
	Time	= 0x01, --持续时间
	Bout	= 0x02, --回合计算
	Value	= 0x03, --数值计算
	Tao		= 0x04, --道行波动
}
