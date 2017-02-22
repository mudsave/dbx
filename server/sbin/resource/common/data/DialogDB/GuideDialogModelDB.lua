--[[GuideDialogDB.lua
	描述：指引任务对话的配置
]]

GuideDialogModelDB = {
	-- 乾元岛师门任务
	[700] = {
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "你入门有一段时间了，是时候为门派出一份力，完成师门任务，当然门派也不会亏待你，完成任务后你将会得到丰厚的奖励。",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "完成10次师门任务",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2001}},	-- 完成任务拜见掌门
					{action = DialogActionType.RecetiveTask,param = {taskID = 2002}},	-- 完成10次师门任务
					{action = DialogActionType.Goto, param = {dialogID = 20502}},		-- 跳转到第一个对话
				},
			}
		},
	},


	[701] = {
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 29048,
		soundID = nil,
		txt = "你现在已经够资格加入帮会了，我这里所有帮会都记录在案，你可以从帮会列表中选择一个提出入帮申请。加入帮派后便是一个家庭成员，要时刻为帮派出力，通过捐献或完成帮派任务壮大帮派啊！",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "加入一个帮派",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2003}},	-- 完成任务拜见萧枭
					{action = DialogActionType.RecetiveTask,param = {taskID = 2004}},	-- 接受加入一个帮派的任务
					{action = DialogActionType.Goto, param = {dialogID = 20802}},		-- 跳转到加入帮派的对话
				},
			}
		},	
	},

}


table.copy(GuideDialogModelDB,DialogModelDB)