--[[SkillConstant.lua
	描述：
	
--]]
require "attribute.PetAttrDefine"
require "attribute.PlayerAttrDefine"

AttackIncAnger 		= 10 	-- 使用技能攻击时增加的怒气值
BeAttackIncAnger 	= 10 	-- 被攻击时增加的怒气值

FluctuateFactor		= 10	-- 波动因子,用于计算波动值
MustCriticalValue	= 233	-- 必定暴击数值
MustHitValue		= 233	-- 必定命中数值

-- 数据加成计算类型
AddType = {
	value 			= 1, 	-- 固定值
	percent 		= 2, 	-- 百分比
	mix 			= 3, 	-- {150,35}先百分比,再固定值(用于技能伤害计算:固定攻击力*百分比, 附加伤害为固定值上下波动)
}

-- 门派类别
SchoolType = {
	PM      = 0x00,
	QYD     = 0x01,		-- 乾元岛
	JXS     = 0x02,		-- 金霞山
	ZYM     = 0x03,		-- 紫阳门
	YXG     = 0x04,		-- 云霄宫
	TYD     = 0x05,		-- 桃源洞
	PLG     = 0x06,		-- 蓬莱阁
}

PhaseName = {
	[PhaseType.Soil]		= "土",
	[PhaseType.Ice]			= "冰",
	[PhaseType.Fire]		= "火",
	[PhaseType.Poison]		= "毒",
	[PhaseType.Thunder]		= "雷",
	[PhaseType.Wind]		= "风",
	[PhaseType.None]		= "无",
}

-- 门派相性对应
SchoolPhase = {
	[SchoolType.QYD]	= PhaseType.Fire,
	[SchoolType.JXS]	= PhaseType.Soil,
	[SchoolType.ZYM]	= PhaseType.Wind,
	[SchoolType.YXG]	= PhaseType.Thunder,
	[SchoolType.TYD]	= PhaseType.Poison,
	[SchoolType.PLG]	= PhaseType.Ice,
}

-- 伤害类型
DamageType = {
	Wind    	= 1,	-- 风
	Thunder 	= 2,	-- 雷
	Ice     	= 3,	-- 冰
	Fire    	= 4,	-- 火
	Soil    	= 5,	-- 土
	Poison  	= 6,	-- 毒
	None    	= 7,	-- 无
	Physic		= 8,	-- 物理
	Magic		= 9,	-- 魔法
}

--宠物技能类型
PetSkillType = {
	Normal 			= 0x001, 		-- 普通伤害
	Buff 			= 0x002, 		-- buff
	AttrPassive 	= 0x103,		-- 属性被动
	StatePassive 	= 0x104, 		-- 状态被动
}

--技能类型 和 子技能映射表(排序映射)
SkillTypeEff = {
	[Skill_Type.Normal]		= {1, 2, 3,},  					-- 普通技能包含的子技能, 按先后顺序
	[Skill_Type.Buff]		= {4},							-- Buff技能
	[Skill_Type.Heal]		= {5, 6},						-- 恢复技能
	[Skill_Type.Passive]	= {17, 18, 19, 20, 21, 22},		-- 被动技能
	[Skill_Type.Transport]	= {},							-- 传送技能
	[Skill_Type.UnionHit]	= {9},							-- 合击技能
	[Skill_Type.ToolMake]	= {},							-- 道具制作
	[Skill_Type.Ultimate]	= {11, 12, 1, 2, 4, 5},			-- 门派大招
	[Skill_Type.Tranform]	= {4, 5},						-- 变身
	[Skill_Type.Revival] 	= {13, 5, 6,},					-- 复活
	[Skill_Type.BuffDmg] 	= {4, 1, 2},					-- 带buff伤害
	[Skill_Type.Arrows] 	= {12, 1},						-- 箭雨
	[Skill_Type.Dispel] 	= {14, 2},						-- 驱散
	[Skill_Type.ReduceMp] 	= {16},							-- 烧蓝
	[Skill_Type.Gathering] 	= {4,1,2},						-- 蓄力
}

--心法属性加成类型
AttrAddType = {
	At 			= 1,	-- 物理攻击力加值
	Mt 			= 2,	-- 法术攻击力加值
	ObsHit 		= 3,	-- 障碍命中加值
	Defense 	= 4,	-- 全部防御力加值
	PhaseDf 	= 5,	-- 全相性抗性加值
	AngerAdd 	= 6,	-- 斗气获得加成
	MaxHp 		= 7,	-- 法力上限加值
}

--角色类型
RoleType = {
	Player 	= 1,
	Monster = 2,
	Npc 	= 3,
	Pet 	= 4,
}

AtType = {
	At = 1,
	Mt = 2,
}

SystemSkillType = {	
	Normal 		= 1,	-- 普通技能
	Buff 		= 2,	-- Buff技能
	Heal 		= 3,	-- 恢复技能
	Ultimate 	= 8,	-- 门派大招
	Tranform 	= 9,	-- 变身
	BuffDmg 	= 11,	-- 带buff伤害
	Arrows 		= 12,	-- 箭雨
	Dispel 		= 13,	-- 驱散
	ReduceMp 	= 14,	-- 烧蓝
}

--子效果
SystemSkillEff = {
	At 			= 1,	-- 物理伤害
	Mt 			= 2,	-- 法术伤害
	Buff 		= 4,	-- buff
	HpHeal 		= 5,	-- 生命恢复
	MpHeal 		= 6,	-- 法力恢复
	ReduceMp 	= 16,	-- 烧蓝
	Dispel 		= 14,	-- 增益驱散

	FireAt 		= 17,	-- 火攻击
	WindAt 		= 18,	-- 风攻击
	ThunderAt	= 19,	-- 雷攻击
	SoilAt 		= 20,	-- 土攻击
	IceAt 		= 21,	-- 冰攻击
	PoisonAt 	= 22,	-- 毒攻击
}

SystemSkillEffOrder = {
	14, 16, 5, 6, 4, 2, 1,
}

-- 克制映射表： 1克制 2不克制 3被克制
RestraintMapping = {
	{2, 2, 1, 3, 1, 3, 2},
	{2, 2, 1, 3, 1, 3, 2},
	{3, 3, 2, 1, 2, 3, 2},
	{1, 1, 3, 2, 3, 2, 2},
	{3, 3, 2, 1, 2, 3, 2},
	{1, 1, 3, 2, 3, 2, 2},
	{2, 2, 2, 2, 2, 2, 2},
}

-- 克制结果
RestraintType = {
	Restrain 		= 1,	-- 克制
	NoneRrestrain	= 2,	-- 不克制
	BeRestrained	= 3,	-- 被克制
}

-- 克制系数(用于计算伤害)
RestraintCoef = {
	[RestraintType.Restrain] 		= 1.2,
	[RestraintType.NoneRrestrain] 	= 1,
	[RestraintType.BeRestrained] 	= 0.8,
}

-- 宠物被动技能效果
PetPassiveEffect = {
	--基础心法
	AllAt 						= 10001,		-- 全部攻击力
	AllDF 						= 10002,		-- 全部防御力
	MaxHp 						= 10003,		-- 最大hp
	MaxMp 						= 10004,		-- 最大mp
	Speed 						= 10005,		-- 速度
	At 							= 10006,		-- 物攻
	Mt 							= 10007, 		-- 法攻
	Af 							= 10008,		-- 物防
	Mf							= 10009,		-- 法防

	Dodge 						= 10010,		-- 闪避
	AntiCrit 					= 10011, 		-- 抗暴
	CritProb 					= 10012,		-- 暴击几率
	CritDmgRatio 				= 10013,		-- 暴击伤害加成
	HitProb 					= 10014,		-- 命中率
	
	--相性攻击类心法
	FireAt 						= 10101,		--火攻击
	WindAt 						= 10102,		--风攻击
	ThunderAt 					= 10103,		--雷攻击
	SoilAt 						= 10104,		--土攻击
	IceAt 						= 10105,		--冰攻击
	PoisonAt 					= 10106,		--毒攻击

	--相性抵抗
	FireResist 					= 10201,		-- 火抗
	WindResist 					= 10202,		-- 风抗
	ThunderResist 				= 10203,		-- 雷抗
	SoilResist 					= 10204,		-- 土抗
	IceResist 					= 10205,		-- 冰抗
	PoisonResist 				= 10206,		-- 毒抗

	--抗障碍系心法
	AntiTaunt 					= 10301,		-- 抗嘲讽
	AntiChaos 					= 10302,		-- 抗混乱
	AntiFreeze 					= 10303,		-- 抗冰冻
	AntiPoison 					= 10304,		-- 抗毒
	AntiSilence 				= 10305,		-- 抗沉默
	Antisopor 					= 10306,		-- 抗昏睡

	-- 主动触发
	PhysicalPursuit 			= 10401,		-- 物理连击
	PhysicalATKChangeValue		= 10402,		-- 物理攻击力改变数值	
	PhysicalATCritAdd			= 10403,		-- 物理暴击几率增加
	CounterFightImmune			= 10404,		-- 反震免疫
	StrikeBackImmune			= 10405,		-- 反击免疫
	AllATKChangeValue			= 10406,		-- 所有攻击力改变数值	
	MagicalPursuit				= 10407,		-- 法术连击
	MagicalATCrit				= 10408,		-- 法术伤害提高
	MagicalATDmgChangeValue		= 10409,		-- 法术攻击伤害改变数值
	MagicalATDmgFluctuate		= 10410,		-- 法术攻击伤害波动		
	DmgIncORHpHeal				= 10411,		-- 伤害加成or生命恢复
	HPHealProb 					= 10412,		-- 恢复血量几率
	HPHealValue					= 10413,		-- 恢复血量数值
	ATDmgIncValue				= 10414,		-- 攻击伤害提高数值
	
	PATWithBloodSucking			= 10415,		-- 物理攻击吸血	
	ATWithBreakDefense 			= 10416,		-- 攻击附带破防
	BreakDefenseBuff			= 10417,		-- 破防BUFF
	ATWithInjured 				= 10418,		-- 攻击附带重伤
	InjuredBuff					= 10419,		-- 重伤BUFF
	ATWithMpSucking 			= 10420,		-- 法术汲取	
	ATWithMpOutflow 			= 10421,		-- 法术流失

	-- 被动触发
	NormalStrikeBack 			= 10501,		-- 物理反击
	NormalStrikeBackValue 		= 10502,		-- 物理反击数值	
	MagicalStrikeBack			= 10503,		-- 法术反击
	MagicalStrikeBackValue 		= 10504,		-- 法术反击数值	
	CounterFight				= 10505,		-- 自动反震
	CounterFightValue			= 10506,		-- 自动反震伤害数值	
	CritImmune					= 10507,		-- 暴击免疫
	MagicalATDodge				= 10508,		-- 法术攻击闪避	
	PhysicalATDodge				= 10509,		-- 物理攻击闪避	
	Revival						= 10510,		-- 复活
	
	PhysicalDmgReduce			= 10511, 		-- 物理伤害减免
	MagicalDmgReduce			= 10512, 		-- 法术伤害减免
	MagicalDmgImmune			= 10513, 		-- 法术伤害免疫
	PhaseDmgReduce	 			= 10514, 		-- 相性伤害减免
	PhaseDmgImmune				= 10515, 		-- 相性伤害免疫
	
	DmgImmuneConvertToHp		= 10516, 		-- 伤害免疫，伤害转换血量
	DmgConvertToHpValue			= 10517, 		-- 伤害转换血量数值
	ReplaceHpWithMp				= 10518,		-- 法力替代生命	
	ReplaceHpWithMpValue		= 10519,		-- 法力替代生命数值	
	AcceptAssistRoundAdd		= 10520, 		-- 受到的辅助类法术效果持续回合数增加
	AcceptHealEffectInc			= 10521,		-- 接受治疗效果增加
	
	-- 进入战斗即触发
	MpConsumeReduce				= 10601,		-- 法力消耗减少
	MagicalATKChangeValue		= 10602,		-- 法术攻击力改变数值
	MagicalDEFChangeValue		= 10603,		-- 法术防御力改变数值
	
	-- 回合触发
	RoundHpHeal			 		= 10701, 		-- 回合恢复血量
	RoundMpHeal					= 10702, 		-- 回合恢复蓝量
	RoundDeBuffDispel			= 10703, 		-- 回合减益驱散
}

-- 宠物状态被动类型到对应状态属性初始化方法名称
PetPassiveType2FuncStr = {
	-- 主动触发
	[PetPassiveEffect.PhysicalPursuit]			= "pPhysicalPursuit",				-- 连击：物理连击，物理攻击下降
	[PetPassiveEffect.PhysicalATCritAdd]		= "pPhysicalATCrit",				-- 必杀：物理暴击几率提高
	[PetPassiveEffect.CounterFightImmune]		= "pSBAndCFImmuneWithATKInc", 		-- 偷袭：反震反击免疫，攻击提高
	[PetPassiveEffect.MagicalPursuit]			= "pMagicalPursuit",				-- 法术连击：法术攻击连击
	[PetPassiveEffect.MagicalATCrit] 			= "pMagicalATCrit",					-- 法术暴击：有几率法术攻击提高
	[PetPassiveEffect.MagicalATDmgFluctuate] 	= "pMagicalATDmgFluctuate",			-- 法术波动：法术攻击伤害波动
	[PetPassiveEffect.DmgIncORHpHeal] 			= "pDmgIncORHpHeal",				-- 开天：几率伤害加倍，几率恢复血量提高伤害
	
	-- 主动触发：攻击附带效果
	[PetPassiveEffect.PATWithBloodSucking]		= "pPATWithBloodSucking",			-- 吸血：物理攻击吸血
	[PetPassiveEffect.ATWithBreakDefense]		= "pATWithBreakDefense",			-- 破防：攻击附带破防，对方有防御技能造成额外伤害
	[PetPassiveEffect.ATWithInjured]			= "pATWithInjured",					-- 重伤：攻击附带重伤BUFF
	[PetPassiveEffect.ATWithMpSucking]			= "pATWithMpSucking",				-- 法术汲取：攻击吸收法力
	[PetPassiveEffect.ATWithMpOutflow] 			= "pATWithMpOutflow",				-- 法术流失：攻击附带法力流失
	
	-- 被动触发
	[PetPassiveEffect.NormalStrikeBack]			= "pNormalStrikeBack",				-- 物理反击：普通反击
	[PetPassiveEffect.MagicalStrikeBack]		= "pMagicalStrikeBack",				-- 法术反击：法术技能反击
	[PetPassiveEffect.CounterFight]				= "pCounterFight",					-- 反震：几率反震
	[PetPassiveEffect.CritImmune]				= "pCritImmuneAndMATDodge",			-- 幸运：暴击免疫，有几率法术攻击闪避
	[PetPassiveEffect.PhysicalATDodge] 			= "pPhysicalATDodge",				-- 招架：物理攻击闪避
	[PetPassiveEffect.Revival] 					= "pRevival",						-- 涅槃：复活恢复生命
	
	-- 被动触发：伤害减免、免疫
	[PetPassiveEffect.PhysicalDmgReduce]		= "pPhysicalDmgReduce",				-- 汲取物伤：减免物理伤害
	[PetPassiveEffect.MagicalDmgReduce]			= "pMagicalDmgReduce",				-- 汲取法伤：减免法术伤害
	[PetPassiveEffect.MagicalDmgImmune]			= "pMagicalDmgImmune",				-- 法术免疫：有几率法术伤害免疫
	[PetPassiveEffect.PhaseDmgReduce]			= "pPhaseDmgReduce",				-- 汲取相攻：减免相性伤害
	[PetPassiveEffect.PhaseDmgImmune] 			= "pPhaseDmgImmune",				-- 相性免疫：有几率相性伤害免疫
	[PetPassiveEffect.DmgImmuneConvertToHp] 	= "pDmgImmuneConvertToHp",			-- 气血转化：有几率伤害免疫同时转换为血量
	[PetPassiveEffect.ReplaceHpWithMp] 			= "pReplaceHpWithMp",				-- 以法续命：法力替代生命
	
	-- 被动触发增益
	[PetPassiveEffect.AcceptAssistRoundAdd] 	= "pAcceptAssistRoundAdd",			-- 永恒：受到辅助类技能持续回合增加
	[PetPassiveEffect.AcceptHealEffectInc] 		= "pAcceptHealEffectInc",			-- 提神：接受治疗效果提高

	-- 进入战斗即触发
	[PetPassiveEffect.MpConsumeReduce] 			= "pMpConsumeReduce",				-- 慧根：法力消耗降低
	[PetPassiveEffect.MagicalATKChangeValue] 	= "pMagicalATKInc",					-- 魔之心：法术攻击提高
	[PetPassiveEffect.MagicalDEFChangeValue] 	= "pMDEFIncAndPATKReduce",			-- 法术抵抗：抵抗法术伤害即魔防提高，物理攻击下降

	-- 回合触发
	[PetPassiveEffect.RoundHpHeal] 				= "pRoundHpHeal",					-- 再生：回合恢复血量
	[PetPassiveEffect.RoundMpHeal] 				= "pRoundMpHeal",					-- 冥想：回合恢复蓝量
	[PetPassiveEffect.RoundDeBuffDispel] 		= "pRoundDeBuffDispel",				-- 神迹：回合减益驱散	
}

--属性被动到宠物的具体属性名称(	部分配置问题 )
PetSkillEffect2AttrName = {
	[PetPassiveEffect.WindAt]			= { nil,pet_inc_win_at },
	[PetPassiveEffect.WindResist]		= { nil,pet_inc_win_resist },
	[PetPassiveEffect.ThunderAt]		= { nil,pet_inc_thu_at },
	[PetPassiveEffect.ThunderResist]	= { nil,pet_inc_thu_resist },
	[PetPassiveEffect.IceAt]			= { nil,pet_inc_ice_at },
	[PetPassiveEffect.IceResist]		= { nil,pet_inc_ice_resist },
	[PetPassiveEffect.SoilAt]			= { nil,pet_inc_soi_at },
	[PetPassiveEffect.SoilResist]		= { nil,pet_inc_soi_resist },
	[PetPassiveEffect.FireAt]			= { nil,pet_inc_fir_at },
	[PetPassiveEffect.FireResist]		= { nil,pet_inc_fir_resist },
	[PetPassiveEffect.PoisonAt]			= { nil,pet_inc_poi_at },
	[PetPassiveEffect.PoisonResist]		= { nil,pet_inc_poi_resist },
	
	[PetPassiveEffect.At]				= { pet_add_at,pet_inc_at, },
	[PetPassiveEffect.Mt]				= { pet_add_mt,pet_inc_mt, },
	[PetPassiveEffect.Af]				= { pet_add_af,pet_inc_af, },
	[PetPassiveEffect.Mf]				= { pet_add_mf,pet_inc_mf },
	
	[PetPassiveEffect.MaxHp]			= { pet_add_max_hp,pet_inc_max_hp },
	[PetPassiveEffect.MaxMp]			= { pet_add_max_mp,pet_inc_max_mp },
	[PetPassiveEffect.Speed]			= { pet_add_speed,pet_inc_speed },
	[PetPassiveEffect.CritProb]			= { pet_add_critical,nil },	
	[PetPassiveEffect.CritDmgRatio]		= { pet_inc_critical_effect,pet_inc_critical_effect },
	
	[PetPassiveEffect.HitProb]			= { pet_add_hit, },
	[PetPassiveEffect.Dodge]			= { pet_add_dodge, },
	[PetPassiveEffect.AntiCrit]			= { pet_add_tenacity },
	
	[PetPassiveEffect.AntiTaunt]		= { pet_add_taunt_resist,pet_inc_taunt_resist },
	[PetPassiveEffect.AntiChaos]		= { pet_add_chaos_resist,pet_inc_chaos_resist },
	[PetPassiveEffect.AntiFreeze]		= { pet_add_freeze_resist,pet_inc_freeze_resist },
	[PetPassiveEffect.AntiPoison]		= { pet_add_toxicosis_resist,pet_inc_toxicosis_resist },
	[PetPassiveEffect.AntiSilence]		= { pet_add_silent_resist,pet_inc_silent_resist },
	[PetPassiveEffect.Antisopor]		= { pet_add_sopor_resist,pet_inc_sopor_resist },
}

PetSkillFuncType = {
	basic = 	1, -- 基础技能
	talent = 	2, -- 天赋技能
	god = 		3,
	mind = 		4, -- 心法技能
}

-- 宠物技能类型 和 子技能映射表(排序映射)
PetSkillTypeEff = {
	[PetSkillType.Normal]		= {1, 2, 3,},  					-- 普通技能包含的子技能, 按先后顺序
	[PetSkillType.Buff]			= {4,},							-- Buff技能
	[PetSkillType.AttrPassive]	= {},							-- 属性被动
	[PetSkillType.StatePassive]	= {},							-- 状态被动
}

-- 技能效果对应执行函数名
SkillEffect2ActionMap = {
	[SkillEff.At]			= {"NormalEffect", "doAt", "setNormalResult", "addNormalResultAction"},			-- 物理伤害
	[SkillEff.Mt]			= {"NormalEffect", "doMt", "setNormalResult", "addNormalResultAction"},			-- 法术伤害
	[SkillEff.Pursue]		= {"NormalEffect", "doPurse", "setNormalResult", "addNormalResultAction"},		-- 追击
	[SkillEff.Buff]			= {"AddBuffEffect", "doAddBuff", "setBuffResult", "addBuffResultAction"},		-- buff
	[SkillEff.HpHeal]		= {"ResumeEffect", "doHpHeal", "setResumeResult", "addResumeResultAction"},		-- 生命恢复
	[SkillEff.MpHeal]		= {"ResumeEffect", "doMpHeal", "setResumeResult", "addResumeResultAction"},		-- 法力恢复

	[SkillEff.UnionHit]		= {"UnionEffect", "doUnionAt", "setUnionResult"},								-- 合击
	[SkillEff.AddCrit]		= {"NormalEffect", "doAddCrit"},												-- 提升暴击
	[SkillEff.AddHit]		= {"NormalEffect", "doAddHit"},													-- 提升命中
	[SkillEff.Revival]		= {"RevivalEffect", "doRevival", "setRevivalResult", "addRevivalResultAction"},	-- 复活
	[SkillEff.Dispel]		= {"DispelEffect", "doDispel", "setDispelResult", "addDispelResultAction"},		-- 增益驱散
	[SkillEff.ReduceMp]		= {"ResumeEffect", "doMpReduce", "setResumeResult", "addResumeResultAction"},	-- 烧蓝

	[PetPassiveEffect.RoundHpHeal]			= {"ResumeEffect", "doHpHeal", "setResumeResult", "addResumeResultAction"},			-- 回合生命恢复
	[PetPassiveEffect.RoundMpHeal]			= {"ResumeEffect", "doMpHeal", "setResumeResult", "addResumeResultAction"},			-- 回合法力恢复
	[PetPassiveEffect.RoundDeBuffDispel]	= {"DispelEffect", "doDeBuffDispel", "setDispelResult", "addDispelResultAction"},	-- 回合减益驱散
	[PetPassiveEffect.Revival]				= {"RevivalEffect", "doRevival", "setRevivalResult", "addRevivalResultAction"},		-- 复活
	[PetPassiveEffect.HPHealValue]			= {"ResumeEffect", "doHpHeal", "setResumeResult", "addResumeResultAction"},			-- 恢复生命
}

-- 宠物初级法术技能
PetPrimaryMagicalSkills = {104, 110, 118, 126, 134, 142, 150}

-- 宠物高级法术技能
PetAdvancedMagicalSkills = {106, 112, 120, 128, 136, 144, 152}

GatheringRound = 1
