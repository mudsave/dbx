-- common.constant.SkillConstant.lua

--目标类型
TargetType = {
	self 		= 1, 	-- 自身
	friend 		= 2, 	-- 友方单体
	enemy 		= 3, 	-- 敌方单体
	friend_g 	= 4, 	-- 友方群体
	enemy_g 	= 5, 	-- 敌方群体
}

--消耗类型
ConsumeType = {
	Hp 		= 1, 		-- 生命消耗
	Mp 		= 2, 		-- 法力消耗
	Anger 	= 3, 		-- 怒气消耗
	vit 	= 4, 		-- 体力消耗
}

--技能类型
Skill_Type = {
	Normal 			= 0x001,		-- 普通技能
	Buff 			= 0x002,		-- Buff技能
	Heal 			= 0x003,		-- 恢复技能
	Heal 			= 0x003,		-- 恢复技能
	Passive 		= 0x004,		-- 被动技能
	Transport 		= 0x005,		-- 传送技能
	UnionHit 		= 0x007,		-- 合击技能
	ToolMake 		= 0x008,		-- 道具制作
	Ultimate 		= 0x009,		-- 门派大招
	Tranform 		= 0x00a,		-- 变身
	Revival 		= 0x00b,		-- 复活
	BuffDmg 		= 0x00c,		-- 带buff伤害
	Arrows 			= 0x00d,		-- 箭雨
	Dispel 			= 0x00e,		-- 驱散
	ReduceMp 		= 0x00f,		-- 烧蓝
	Gathering		= 0x010,		-- 蓄力
}

--子技能
SkillEff = {
	At 			= 0001,		-- 物理伤害
	Mt 			= 0002,		-- 法术伤害
	Pursue 		= 0003,		-- 追击
	Buff 		= 0004,		-- buff
	HpHeal 		= 0005,		-- 生命恢复
	MpHeal 		= 0006,		-- 法力恢复

	Transport 	= 0008,		-- 传送
	UnionHit 	= 0009,		-- 合击
	ToolMake 	= 0010,		-- 道具制作
	AddHit 		= 0011,		-- 提升命中
	AddCrit 	= 0012,		-- 提升暴击
	Revival 	= 0013,		-- 复活
	Dispel 		= 0014,		-- 增益驱散
	AddPhase 	= 0015,		-- 提升相性
	ReduceMp 	= 0016,		-- 烧蓝

	FireAt 		= 0017,		-- 火攻击
	WindAt 		= 0018,		-- 风攻击
	ThunderAt 	= 0019,		-- 雷攻击
	SoilAt 		= 0020,		-- 土攻击
	IceAt 		= 0021,		-- 冰攻击
	PoisonAt 	= 0022,		-- 毒攻击
}
