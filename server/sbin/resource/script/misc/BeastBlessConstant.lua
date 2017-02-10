
-- 条件限制
BeastBlessMinLvl		= 30	--	最小等级
BeastBlessPlayerNum		= 3		--	最少人数
BeastBlessFightCount	= 10	--	战斗次数
BeastBlessPlayerLvlRange= 10	--	等级差

-- 特殊物品和特殊怪

BeastBlessSpecialMonster = 25507
BeastBlessSpecialItem = 3031006

-- 得到正常奖励
BeastBlessReword		= 5

-- 战斗后奖励
BeastRoleRewordType = {
	[eClsTypePlayer]	= {"playerExp","subMoney","playerTao",},
	[eClsTypePet]		= {"petExp","petTao"},
}

BeastBlessDropType = 
{	
	playerExp	= 1,
	subMoney	= 2,
	PlayerTao	= 3,
	PetExp		= 4,
	PetTao		= 5,
}

-- 特殊怪的计算
BeastBlessExtraReward = 
{	
	[25505] = BeastBlessDropType.subMoney,
	[25506] = BeastBlessDropType.playerExp,
	[25508] = BeastBlessDropType.PlayerTao,
}

BeastBlessToValueReward = 
{	
	[BeastBlessDropType.playerExp]	= {"playerExp","BeastBlessUtils.getExpFormula","BeastBlessUtils.getDExpFormula"},
	[BeastBlessDropType.subMoney]		= {"subMoney","BeastBlessUtils.getSubMoneyFormula","BeastBlessUtils.getDSubMoneyFormula"},
	[BeastBlessDropType.PlayerTao]	= {"PlayerTao","BeastBlessUtils.getTaoFormula","BeastBlessUtils.getDTaoFormula"},
}







