--[[BabelTaskDB.lua
	ͨ通天塔任务配置
--]]
BabelTaskDB = 
{
	[20001] = 
	{
		name = "ͨ通天塔",
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
		-- 奖励公式
		formulaRewards =
		{
			[1] = 
			{
				--角色经验
				[TaskRewardList.player_xp] = BabelRewardFormula.addXp,
				-- 宠物
				[TaskRewardList.pet_xp] = BabelRewardFormula.addPetXp,
			},
			[2] =
			{
				--任务道行
				[TaskRewardList.player_tao] = BabelRewardFormula.addTao,
				-- 宠物
				-- 宠物道行
				[TaskRewardList.pet_tao] = BabelRewardFormula.addPetTao,
			},
		},
	},
}