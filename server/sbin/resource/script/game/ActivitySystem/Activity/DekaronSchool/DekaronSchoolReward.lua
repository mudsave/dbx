--[[DekaronSchoolReward.lua
	描述：门派闯关奖励
--]]

DekaronSchoolReward = {}

--闯关门派怪物对应积分
schoolActivityIntegralDB =
{	--[怪物ID] = 门派闯关积分
	[10011] = 5,
	[10012] = 10,
	[10013] = 15,
}

-- 经验
function DekaronSchoolReward.getExpFormula(playerLevel,integral)
	return (playerLevel - 2) * 300 + integral * 500

end

-- 道行
function DekaronSchoolReward.getTaoFormula(playerLevel,integral)
	return (playerLevel - 2) * 300 + integral * 500
end