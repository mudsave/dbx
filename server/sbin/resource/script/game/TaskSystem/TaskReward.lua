--[[TaskReward.lua
	任务奖励公式(任务系统)
]]

TaskReward = {}

function TaskReward.Formula(player)
	local reward = 
	{
		[Role.xp] = 100,
		[Pet.xp] = 100,
	}
	return reward
end