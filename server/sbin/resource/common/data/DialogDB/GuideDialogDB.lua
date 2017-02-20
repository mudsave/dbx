--[[GuideDialogDB.lua
	描述：指引任务对话的配置
]]

GuideDialogDB = {
	-- 乾元岛师门任务
	[700] = {
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "你入门有一段时间了，是时候为门派出一份力，完成师门任务，当然门派也不会亏待你，完成任务后你将会得到丰厚的奖励。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 2001}},
				},
			}
		},
	},
}


table.copy(NormalDialogModelDB,GuideDialogModelDB)