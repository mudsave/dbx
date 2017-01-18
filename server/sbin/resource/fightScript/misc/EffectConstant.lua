--[[EffectConstant .lua
描述：
	效果常量
	--misc.EffectConstant 
]]
--require "entity.attribute.PlayerAttrDefine"
--require "entity.attribute.PetAttrDefine"
--require "entity.attribute.MonsterAttrDefine"

PhaseType =
{
	Wind    = 1, -- 风
	Thunder = 2, -- 雷
	Ice     = 3, -- 冰
	Fire    = 4, -- 火
	Soil    = 5, -- 土
	Poison  = 6, -- 毒
	None    = 7, -- 无
}

--技能效果作用范围
EffectRangeType = {
	Self = 1,
	Pet = 2,
	Single = 3,
}

EffectTypeAction = {
	[EffectType.ChangeAt]			= "ft_add_at",
	[EffectType.ChangeMt]			= "ft_add_mt",
	[EffectType.ChangeAf]			= "ft_add_af",
	[EffectType.ChangeMf]			= "ft_add_mf",
	[EffectType.ChangeHit]			= "ft_add_hit",
	[EffectType.ChangeDodge]		= "ft_add_dodge",
	[EffectType.ChangeCritical]		= "ft_add_critical",
	[EffectType.ChangeTenacity]		= "ft_add_tenacity",
	[EffectType.ChangeSpeed]		= "ft_add_speed",
	[EffectType.ChangeWinAt]		= "ft_add_wind_at",
	[EffectType.ChangeThuAt]		= "ft_add_thunder_at",
	[EffectType.ChangeIceAt]		= "ft_add_ice_at",
	[EffectType.ChangeFirAt]		= "ft_add_fire_at",
	[EffectType.ChangeSoiAt]		= "ft_add_soil_at",
	[EffectType.ChangePoiAt]		= "ft_add_poison_at",
	[EffectType.ChangeWinResist]	= "ft_add_wind_resist",
	[EffectType.ChangeThuResist]	= "ft_add_thunder_resist",
	[EffectType.ChangeIceResist]	= "ft_add_ice_resist",
	[EffectType.ChangeFirResist]	= "ft_add_fire_resist",
	[EffectType.ChangeSoiResist]	= "ft_add_soil_resist",
	[EffectType.ChangePoiResist]	= "ft_add_poison_resist",
	[EffectType.ChangeAllt]			= "ft_add_all_attack",
	[EffectType.ChangeAllf]			= "ft_add_all_defense",
}

LightingEffectType = {
	[EffectType.ChangeAt]				= 1,
	[EffectType.ChangeMt]				= 1,
	[EffectType.ChangeAf]				= 1,
	[EffectType.ChangeMf]				= 1,
	[EffectType.ChangeHit]				= 1,
	[EffectType.ChangeDodge]			= 1,
	[EffectType.ChangeCritical]			= 1,
	[EffectType.ChangeTenacity]			= 1,
	[EffectType.ChangeSpeed]			= 1,
	[EffectType.ChangeAllt]				= 1,
	[EffectType.ChangeAllf]				= 1,
	[EffectType.ChangeWinAt]			= PhaseType.Wind,
	[EffectType.ChangeThuAt]			= PhaseType.Thunder,
	[EffectType.ChangeIceAt]			= PhaseType.Ice,
	[EffectType.ChangeFirAt]			= PhaseType.Fire,
	[EffectType.ChangeSoiAt]			= PhaseType.Soil,
	[EffectType.ChangePoiAt]			= PhaseType.Poison,
	[EffectType.ChangeWinResist]		= PhaseType.Wind,
	[EffectType.ChangeThuResist]		= PhaseType.Thunder,
	[EffectType.ChangeIceResist]		= PhaseType.Ice,
	[EffectType.ChangeFirResist]		= PhaseType.Fire,
	[EffectType.ChangeSoiResist]		= PhaseType.Soil,
	[EffectType.ChangePoiResist]		= PhaseType.Poison,
	[EffectType.AbsorbAllDmgDa]			= 2,
	[EffectType.AbsorbMtDmgDa]			= 2,
	[EffectType.AbsorbAtDmgDa]			= 2,
	[EffectType.MtShield]				= 2,
	
	[EffectType.HealReduce]				= 1,
	[EffectType.AllAttrReduce]			= 1,
	[EffectType.PetLoyaltyReduceProb]	= 1,
	[EffectType.PetLoyaltyReduceRatio]	= 1,
	[EffectType.PetExistRatio]			= 1,
	[EffectType.Dispel]					= 1,
	[EffectType.PhaseRestrain]			= 1,
	[EffectType.MpDot]		 			= 1,
	[EffectType.CouterDmg]				= 1,
	[EffectType.RestoreHp]				= 1,
	[EffectType.RestoreMp]				= 1,
	[EffectType.HealIncrease]			= 1,
	[EffectType.AllAttrIncrease]		= 1,
	
}

LightingEffectType2 = {
	[BuffKind.ChaosObstacle]		= PhaseType.Wind,
	[BuffKind.PoisonObstacle]		= PhaseType.Poison,
	[BuffKind.FreezeObstacle]		= PhaseType.Ice,
	[BuffKind.SilenceObstacle]		= PhaseType.Thunder,
	[BuffKind.TauntObstacle]		= PhaseType.Soil,
	[BuffKind.SoporObstacle]		= PhaseType.Fire,
}

LightingEffectType3 = {
	[BuffKind.HealReduce]		= 1,
	[BuffKind.Dispel]			= 1,
	[BuffKind.PhaseRestrain]	= 1,
	[BuffKind.MpDot]		 	= 1,
	[BuffKind.CouterDmg]		= 1,
	[BuffKind.RestoreHp]		= 1,
	[BuffKind.RestoreMp]		= 1,
	[BuffKind.HealIncrease]		= 1,
	[BuffKind.AllAttrIncrease]	= 1,
	[BuffKind.Dot]				= 1,
	[BuffKind.QYDXuLi]			= 1,
	[BuffKind.QYDXuRuo]			= 1,
	[BuffKind.ZYMXuLi]			= 1,
	[BuffKind.Special]			= 1,
}