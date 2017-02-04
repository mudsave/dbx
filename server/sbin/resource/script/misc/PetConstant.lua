--[[PetConstant.lua
	描述：宠物系统常量
]]

FightPetLevelParam = 10

-- 宠物类型
PetType =
{
	-- 野生
	Wild	= 1,
	-- 宝宝
	Baby	= 2,
	-- 元灵
	Spirit	= 3,
	-- 变异
	Varient	= 4,
	-- 神将
	God		= 5,
}

-- 宠物攻击类型
PetAttackType =
{
	Physics = 0, -- 物理
	Magic   = 1, -- 法术
}

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

MaxPetLoyalty			= 10000		-- 宠物的最大忠诚度
PetLoyaltyFightParam	= 6000		-- 宠物出战逃跑忠诚度临界值
PetTalentBox			= 1026005	-- 天赋宝盒，使用之后增加一个宠物栏
MaxPetNum				= 3			-- 默认宠物栏大小
MaxPetEnchance			= 9			-- 宠物最大强化等级
PetVarientRate			= 10		-- 洗宠产生变异宠物的概率
MaxPetTao				= 999999999	-- 宠物最大道行
PetRepairCostMoney		= 2500		-- 宠物修复需要金钱
DeadReducePetTao		= 16		-- 宠物死亡减少的道行值
PetCombineFailRate		= 1			-- 宠物合成失败的概率 百分比
PetMinCombineLvl		= 1			-- 宠物合成所需要的最低等级

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
	{ pet_capacity,			pet_capacity_max,		"capacityGrowth" },
	{ pet_at_grow,			pet_at_grow_max,		"atGrowth" },
	{ pet_mt_grow,			pet_mt_grow_max,		"mtGrowth" },
	{ pet_af_grow,			pet_af_grow_max,		"afGrowth" },
	{ pet_mf_grow,			pet_mf_grow_max,		"mfGrowth" },
	{ pet_hp_grow,			pet_hp_grow_max,		"hpGrowth" },
	{ pet_at_speed_grow,	pet_at_speed_grow_max,	"speedGrowth" },
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

--宠物强化成功概率
PetEnchanceProbability = {
	[0] = 6450,
	[1] = 1000,	
	[2] = 399,
	[3] = 214,
	[4] = 133,
	[5] = 90,
	[6] = 65,
	[7] = 49,
	[8] = 23
} 

PS_StartID = 1001	-- 宠物技能开始ID
PS_EndID = 1102		-- 宠物技能结束ID

-- 是否为高级技能
function PS_IsAdvanced(skillID)
print("**************skillID",type(skillID))
print(debug.traceback())
	-- 在这个范围内的ID不是技能
	if skillID < PS_StartID or skillID > PS_EndID then
		return false,nil
	end
	if skillID % 2 == 0 then
		-- 偶数的技能ID是高级技能,同时返回低级技能ID
		return true,skillID - 1
	end
	return false,nil
end

-- 是否是基础技能
function PS_IsBasic(skillID)
	if skillID < PS_StartID or skillID > PS_EndID then
		return false,nil
	end
	if skillID % 2 == 1 then
		-- 奇数的技能ID是低级技能,同时返回高级技能ID
		return true,skillID + 1
	end
	return false,nil
end

PetTalentBox			= 1026005		--天赋宝盒，使用之后增加一个宠物栏
PetTalentPill			= 1024007		--天资丹
PetEnchancePill			= 1024006		--强化丹
PetRebirthPill			= 1024005		--还童丹
PetTaoPill				= 1024004		--道行丹
PetEvloutPill			= 1024003		--进阶丹
PetLifePill				= 1024002		--寿元丹
PetLoyaltyPill			= 1024001		--忠诚丹

-- 获得宠物强化消耗
function GetEnchanceConsume(pet)
	local count = 1
	return PetEnchancePill,count
end

-- 获得宠物还童消耗
function GetRebirthConsume(pet)
	local count = 1
	return 1024005,count
end


