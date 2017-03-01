--[[GuideDialogDB.lua
	描述：指引任务对话的配置
]]

GuideDialogModelDB = {
	-- 乾元岛师门任务
	[35500] = {--乾元岛
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "完成10次师门任务",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 15001}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15002}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20502}},		-- 跳转到第一个对话
				},
			}
		},
	},

	[35501] = {--金霞山
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 20006,
			soundID = nil,
			txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15003}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15004}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20602}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35502] = {--紫阳门
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 20008,
			soundID = nil,
			txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15005}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15006}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20702}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35503] = {--云霄宫
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 20009,
			soundID = nil,
			txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15007}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15008}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20752}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35504] = {--桃源洞
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 20005,
			soundID = nil,
			txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15009}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15010}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20552}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35505] = {--蓬莱阁
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 20007,
			soundID = nil,
			txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15011}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15012}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20652}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35506] = {--试炼任务
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 27150,
			soundID = nil,
			txt = "如今天下大乱，妖魔横行，不锻炼自身能力可不行啊。在40级后每周都可以到我这里领取试炼任务，不但可以斩妖除魔，为民除害，还可以得到奖励，环数越高，奖励越多！",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15013}},	-- 完成任务
						{action = DialogActionType.Goto, param = {dialogID = 20027}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35505] = {--天道任务
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 29008,
			soundID = nil,
			txt = "原来是<myName>啊，你入门有一段时间了，是时候为门派出一份力，当然门派也不会亏待你，完成师门任务后你将会得到丰厚的奖励。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15011}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15012}},	-- 完成10次师门任务
						{action = DialogActionType.Goto, param = {dialogID = 20652}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35506] = {--试炼任务
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 27150,
			soundID = nil,
			txt = "如今天下大乱，妖魔横行，不锻炼自身能力可不行啊。在40级后每周都可以到我这里领取试炼任务，不但可以斩妖除魔，为民除害，还可以得到奖励，环数越高，奖励越多！",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "晚辈明白了",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15013}},	-- 完成任务
						{action = DialogActionType.Goto, param = {dialogID = 20027}},		-- 跳转到第一个对话
					},
				}
			},
		},

	[35507] = {--天道任务
			dialogType = DialogType.HasOption,
			conditions = 
			{
			},
			speakerID = 29008,
			soundID = nil,
			txt = "当年张角破坏封神台，导致妖魔尽出，不知道友可有时间帮我降妖除魔？天道任务的妖怪都很危险，需要两人以上组队方可接受任务，完成任务可获得大量的道行与潜能。",
			options = 
			{
				[1] = {
					showConditions = {},
					optionTxt = "弟子领命",
					actions =
					{
						{action = DialogActionType.FinishTask, param = {taskID = 15014}},	-- 完成任务
						{action = DialogActionType.RecetiveTask,param = {taskID = 15015}},	-- 完成10次天道任务
						{action = DialogActionType.Goto, param = {dialogID = 20024}},		-- 跳转到第一个对话
					},
				}
			},
		},
	[35508] = {
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
				optionTxt = "我明白了",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 15016}},	-- 完成任务拜见萧枭
					{action = DialogActionType.RecetiveTask,param = {taskID = 15017}},	-- 接受加入一个帮派的任务
					{action = DialogActionType.Goto, param = {dialogID = 20802}},		-- 跳转到加入帮派的对话
				},
			}
		},	
	},

	[35509] = {
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 39000,
		soundID = nil,
		txt = "原来是<myName>啊，你现在也小有所成，可以驾驭坐骑了。当你集齐青龙卷、朱雀卷、白虎卷、玄武卷与对应的坐骑灵符时，便可以在我这兑换坐骑任务。",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "晚辈了解",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 15018}},	-- 完成任务拜见萧枭
					{action = DialogActionType.Goto, param = {dialogID = 27090}},		-- 跳转到加入帮派的对话
				},
			}
		},	
	},

	[35510] = {
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 29005,
		soundID = nil,
		txt = "生活技能包括铸甲、裁缝、制宝、烹饪、炼药、提炼、侦查与捕获，提升对应技能可以用来制造装备、产出药材等。在我这里学习后便可以在技能界面的生活技能分页使用对应技能。同时在帮派也可以学习生活技能。",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "我明白了",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 15019}},	-- 完成任务拜见萧枭
					{action = DialogActionType.Goto, param = {dialogID = 20021}},		-- 跳转到加入帮派的对话
				},
			}
		},	
	},

	[35511] = {
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 30320,
		soundID = nil,
		txt = "副本任务为组队任务，在副本中退出队伍，将会被请出副本。副本的难度均比较大，进入副本前请准备周全，当你完成副本时，将会得到丰厚的奖励。",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "我明白了",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 15020}},
					{action = DialogActionType.Goto, param = {dialogID = 20000}},
				},
			}
		},	
	},
}


table.copy(GuideDialogModelDB,DialogModelDB)