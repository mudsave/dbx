--[[TaskDB.lua
	任务配置(任务系统)
]]

require "data.TaskDB.TaskRewardFormulaDB"

require "data.TaskDB.NormalTaskDB"
-- 指引任务
require "data.TaskDB.GuideTaskDB"
-- 日常任务
require "data.TaskDB.DailyTaskDB"

require "data.TaskDB.MainTaskDB.LoadMainTaskDB"

require "data.TaskDB.LoopTaskDB.LoadLoopTaskDB"

require "data.TaskDB.BranchTaskDB.LoadBranchTaskDB"
