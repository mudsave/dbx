--[[BabelTaskDB.lua
	?通天塔任务配置
--]]
BabelTaskDB = 
{
	[20001] = 
	{
		name = "?通天塔",
		taskType2 = TaskType2.Babel,
		period = TaskPeriod.day,
		-- 动态任务目标，无需配置
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type="TbabelScript", param = {}},
		},
		triggers = 
		{
			[TaskStatus.Active] = 
			{
				{type = "challengeNpcTrace", param = {}},
			},
		},
		maxLayer = 200,
		-- 濂栧姳鍏紡
		formulaRewards =
		{
			[1] = 
			{
				--瑙掕壊缁忛獙
				[TaskRewardList.player_xp] = BabelRewardFormula.addXp,
				-- 瀹犵墿
				[TaskRewardList.pet_xp] = BabelRewardFormula.addPetXp,
			},
			[2] =
			{
				--浠诲姟閬撹
				[TaskRewardList.player_tao] = BabelRewardFormula.addTao,
				-- 瀹犵墿
				-- 瀹犵墿閬撹
				[TaskRewardList.pet_tao] = BabelRewardFormula.addPetTao,
			},
		},
	},
}