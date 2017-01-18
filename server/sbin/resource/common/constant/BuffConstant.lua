-- common.constant.BuffConstant.lua

-- 持续类型
BUFF_LAST_TYPE = {
	time = 1, --时间计算
	num  = 2, --数值计算
}

--效果加持方式
EffectAddType = {
	FixedValue	= 1,--固定值
	Percent		= 2,--百分比
}

-- 效果对象
PoolType = {
	player = 1, --玩家
	pet = 2, --宠物
}

-- 多倍经验丹
BoostTimes = {
	double = 2, --双倍
	trible = 3, --三倍
}

-- 效果种类
BuffJudgeLevel = {
	mentalLevel	= 0x01,--心法等级
	xpLevel		= 0x02,--经验等级
}

-- buff的持续类型
BuffStayType = {
	Time	= 0x01, --持续时间
	Bout	= 0x02, --回合计算
	Value	= 0x03, --数值计算
	Tao		= 0x04, --道行波动
}

-- 变身卡属性影响
Trans_effect = {
	ChangeAt			=  1,--物理攻击力
	ChangeMt			=  2,--法术攻击力
	ChangeAf			=  3,--物理防御力
	ChangeMf			=  4,--法术防御力
	ChangeHit			=  5,--命中
	ChangeDodge			=  6,--闪避
	ChangeCritical		=  7,--暴击
	ChangeTenacity		=  8,--抗暴
	ChangeSpeed			=  9,--速度
	ChangeWinAt			= 10,--风攻击
	ChangeThuAt			= 11,--雷攻击
	ChangeIceAt			= 12,--冰攻击
	ChangeFirAt			= 13,--火攻击
	ChangeSoiAt			= 14,--土攻击
	ChangePoiAt			= 15,--毒攻击
	ChangeWinResist		= 16,--风防御
	ChangeThuResist		= 17,--雷防御
	ChangeIceResist		= 18,--冰防御
	ChangeFirResist		= 19,--火防御
	ChangeSoiResist		= 20,--土防御
	ChangePoiResist		= 21,--毒防御
	ChangeAllt			= 22,--全部攻击力
	ChangeAllf			= 23,--全部防御力
}

-- 战斗外Buff类型
FightOutBuffType = {
	hp_pool 		= 1, 	--生命自动恢复
	mp_pool 		= 2, 	--法力自动恢复
	exorcism 		= 3, 	--驱魔香
	rein_beast 		= 4, 	--驭兽铃
	xp_boost 		= 5, 	--多倍经验丹
	god_bless 		= 6, 	--护心丹
	tarns_card 		= 7, 	--变身卡
	enforced_pk		= 8,	--强制pk
	protect_pk  	= 9, 	--保护pk
	evil 			= 10, 	--恶贯满盈
	loyalty_pool	= 11,
	fight_count		= 12,	--战斗计数buff
	full_monster	= 13,	--满怪buff
}


-- 战斗中buff类型
BuffKind = {
	AddPhase		= 0x01,--相性增益
	AddAttr			= 0x02,--属性增益
	Sub				= 0x03,--减益
	Dot				= 0x04,--dot
	TransCard		= 0x05,--变身卡
	ChaosObstacle	= 0x06,--混乱障碍
	PoisonObstacle	= 0x07,--中毒障碍
	FreezeObstacle	= 0x08,--冰冻障碍
	SilenceObstacle	= 0x09,--沉默障碍
	TauntObstacle	= 0x10,--嘲讽障碍
	SoporObstacle	= 0x11,--昏睡障碍
	Shield			= 0x12,--护盾Buff
	JXSTrans		= 0x13,--金霞山变身
	QYDXuLi			= 0x14,--乾元岛蓄力
	QYDXuRuo		= 0x15,--乾元岛虚弱
	ZYMXuLi			= 0x16,--紫阳门蓄力
	Special			= 0x17,--特殊类buff
	HealReduce		= 0x18,--治疗效果下降
	AllAttrReduce	= 0x19,--所有属性下降
	Dispel			= 0x20,--驱散增益
	PhaseRestrain	= 0x21,--相性克制
	MpDot			= 0x22,--持续耗蓝
	CouterDmg		= 0x23,--反震伤害
	RestoreHp		= 0x24,--恢复hp
	RestoreMp		= 0x25,--恢复mp
	HealIncrease	= 0x26,--治疗效果增加
	AllAttrIncrease	= 0x27,--所有属性增加
}

--每种对应一个程序函数
EffectType = {
	ChangeAt			= 1,--物理攻击力
	ChangeMt			= 2,--法术攻击力
	ChangeAf			= 3,--物理防御力
	ChangeMf			= 4,--法术防御力
	ChangeHit			= 5,--命中
	ChangeDodge			= 6,--闪避
	ChangeCritical		= 7,--暴击
	ChangeTenacity		= 8,--抗暴
	ChangeSpeed			= 9,--速度
	ChangeWinAt			= 10,--风攻击
	ChangeThuAt			= 11,--雷攻击
	ChangeIceAt			= 12,--冰攻击
	ChangeFirAt			= 13,--火攻击
	ChangeSoiAt			= 14,--土攻击
	ChangePoiAt			= 15,--毒攻击
	ChangeWinResist		= 16,--风防御
	ChangeThuResist		= 17,--雷防御
	ChangeIceResist		= 18,--冰防御
	ChangeFirResist		= 19,--火防御
	ChangeSoiResist		= 20,--土防御
	ChangePoiResist		= 21,--毒防御
	ChangeAllt			= 22,--全部攻击力
	ChangeAllf			= 23,--全部防御力
	AbsorbAllDmgDa		= 24,--吸收全部伤害总量
	AbsorbMtDmgDa		= 25,--吸收法术伤害总量
	AbsorbAtDmgDa		= 26,--吸收物理伤害总量
	MtShield			= 27,--法术护盾
	DotDamage			= 28,--持续掉血
	RecoverHP			= 29,--战斗结束恢复生命值
	RecoverMP			= 30,--战斗结束恢复法力值
	Exorcism			= 31,--驱魔香
	XpDanDouble			= 32,--双倍经验丹
	ReinBeast			= 33,--驭兽
	GodBless			= 34,--护心
	PoiDamage			= 35,--中毒掉血
	Immunity			= 36,--障碍免疫

	HealReduce			= 37,--治疗效果下降
	AllAttrReduce		= 38,--所有属性减少
	PetLoyaltyReduceProb= 39,--降低宠物忠诚度几率
	PetLoyaltyReduceRatio= 40,--降低宠物忠诚度比例
	PetExistRatio		= 41,--宠物忠诚度低于30%，离开战场
	Dispel				= 42,--驱散增益
	PhaseRestrain		= 43,--相性克制降低比例
	PhaseBeRestrain		= 44,--被相性克制增加比例
	MpDot				= 45,--持续耗蓝
	CouterDmg			= 46,--反震伤害比例
	RestoreHp			= 47,--恢复hp
	RestoreMp			= 48,--恢复mp
	HealIncrease		= 49,--治疗效果增加
	AllAttrIncrease		= 50,--所有属性增加
}
