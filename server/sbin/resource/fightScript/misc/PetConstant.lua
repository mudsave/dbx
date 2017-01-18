--[[PetConstant.lua
	描述：宠物系统常量
]]

FightPetLevelParam = 10

-- 宠物状态
PetStatus = {
	Rest	= 0,	--休息
	Ready	= 1,	--掠阵
	Fight	= 2,	--出战
	Sale	= 3,	--出售
	Locked	= 4,	--锁定
	Store	= 5,	--存储
}

-- 宠物的技能的所属类型
PetSkillCategory = {
	Basic		= 1,	--基础技能
	Superior	= 2,	--高级技能
}

-- 宠物的最大忠诚度
MaxPetLoyalty = 10000
MaxPetNum				= 3			--默认宠物栏大小

-- 先天属性名称
PetInbornAttrMap = {
	[pet_inborn_str] = "inbornStr",
	[pet_inborn_int] = "inbornInt",
	[pet_inborn_sta] = "inbornSta",
	[pet_inborn_spi] = "inbornSpi",
	[pet_inborn_dex] = "inbornDex",
}

-- 宠物成长属性
PetGrowthAttrs = {
	{ pet_capacity,		pet_capacity_max,	"capacityGrowth" },
	{ pet_at_grow,		pet_at_grow_max,	"atGrowth" },
	{ pet_mt_grow,		pet_mt_grow_max,	"mtGrowth" },
	{ pet_af_grow,		pet_af_grow_max,	"afGrowth" },
	{ pet_mf_grow,		pet_mf_grow_max,	"mfGrowth" },
	{ pet_hp_grow,		pet_hp_grow_max,	"hpGrowth" },
	{ pet_speed_grow,	pet_speed_grow_max,	"speedGrowth" },
}

PetNormalRandom = CreateProbability {
	{0	,25	,0.4},
	{26	,50	,0.4},
	{51	,75	,0.1},
	{76	,100,0.1}
}

PetSpecialRandom = CreateProbability {
	{0	,25	,0.1},
	{26	,50	,0.4},
	{51	,75	,0.4},
	{76	,100,0.1}
}

PetCompoundRandom = CreateProbability {
	{0	,25	,0.1},
	{26	,50	,0.1},
	{51	,75	,0.4},
	{76	,100,0.4}
}

PS_StartID = 1001	-- 宠物技能开始ID
PS_EndID = 1102		-- 宠物技能结束ID
