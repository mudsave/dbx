--[[SystemError.lua
	请将错误代码用这种形式放在各自的表中
]]

PetError = {
	NonExistentPet		=  1,	-- 不存在的宠物
	OthersPet			=  2,	-- 不是当前玩家的宠物
	PlayerLevelLow		=  3,	-- 玩家等级低，不够携带出战宠物
	TakeLevelHigh		=  4,	-- 宠物的出战等级太高
	PetLifeLow			=  5,	-- 宠物寿命不够

	PetOnMoving			=  6,	-- 宠物在移动
	PetNotFighting		=  7,	-- 不是出战宠物

	InSameStatus		=  8,	-- 宠物已经是这个状态
	DuplicateFight		=  9,	-- 已经有出战宠物了
	DuplicateReady		= 10,	-- 已经有掠阵宠物了
	WrongAttrSet		= 11,	-- 错误的属性设置
	NoEnoughPoint		= 12,	-- 宠物属性点不够
	FreeFight			= 13,	-- 遣散出战宠物
	FreeReady			= 14,	-- 遣散掠阵宠物
	NoFightPet			= 15,	-- 没有出战宠物
	HealthPet			= 16,	-- 宠物已经是满状态的
	PetCured			= 17,	-- 宠物已经修复
	NoEnoughMoney		= 18,	-- 修复宠物金钱不够
	OwnNoPet			= 19,	-- 玩家没有宠物
	NoHurtPet			= 20,	-- 没有需要修复的宠物
	MaxEnchance			= 21,	-- 宠物已达强化最高级
	NoEnoughEnchance	= 22,	-- 宠物强化丹不够
	RebirthFightOrReady	= 23,	-- 出战或者掠阵宠物不能还童
	NoEnoughRebirth		= 24,	-- 宠物还童丹不够
	MaxPetBar			= 25,	-- 宠物栏已达上限
	MaxPetNumber		= 26,	-- 宠物数量已达上限
	NoEnoughExpand		= 27,	-- 天赋宝盒<宠物栏>不够
	PetLoyaltyLow		= 28,	-- 宠物忠诚度过低
	CombineUnhandle		= 29,	-- 合成出战或者掠阵的宠物
	CombineLevelLow		= 30,	-- 合成宠物的等级不足30级
	CombineFailed		= 31,	-- 宠物合成失败
	NoEnoughCombine		= 32,	-- 没有足够的合成物品
	NoRecoverAttr		= 33,	-- 没有可以还原的属性点
	FightPetLearn		= 34,	-- 出战宠物学习技能
	NoSuchBook			= 35,	-- 没有该技能书
	WildCantLearn		= 36,	-- 野生宠物不能学习技能
	DuplicateSkill		= 37,	-- 技能已经学习了
	CantLearnMore		= 38,	-- 宠物技能学习已达上限
	NoPetLearn			= 39,	-- 没有可以学习技能的宠物
	OwnSuperior			= 40,	-- 宠物已有高级技能
	CombineSame			= 41,	-- 合成时只有一个宠物
	PetTypeError		= 42,	-- 元灵和神将不能强化
	PhaseOver35			= 43,	-- 相性点超过35
	RequireNone			= 45,	-- 请求一个不在线的宠物
	RequireMine			= 46,	-- 请求自己的宠物数据
}
