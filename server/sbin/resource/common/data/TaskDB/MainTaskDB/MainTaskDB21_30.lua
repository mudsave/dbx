--[[MainTaskDB21_30.lua
	任务配置21到30级(任务系统)
	player_xp	 = 1,	--玩家经验
	pet_xp		= 2,	--宠物经验
	money		= 3,	--银两
	subMoney	= 4,	--绑银
	cashMoney	= 5,
	goldCoin	= 6,
]]

MainTaskDB21_30 =
{
-------------------------------------主线25-30---------------------------------------------------------------
	[1101] =	--主线25-30
	{

		name = "解救陈宫",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20302,	--任务结束npc
		preTaskData = {1384},	--任务前置任务没有填nil
		nextTaskID = 1102,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1004,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 4900,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 64000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --东郡——胡轸
			{
				mineIndex = 1,		--第一个雷
				scriptID = 161,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1002,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 107, x = 172, y = 46}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
			{type="createPrivateNpc", ----------创建被怪物围住的陈宫和第1波怪
				param={
						npcs =
						{
							[1] = {npcID = 20305,mapID = 107, x = 173, y = 44,dir = Direction. EastSouth,},--胡轸
							[2] = {npcID = 20303,mapID = 107, x = 174, y = 47,dir = Direction. South,},
							[3] = {npcID = 20304,mapID = 107, x = 177, y = 47,dir = Direction. West,},
							[4] = {npcID = 20310,mapID = 107, x = 179, y = 43,dir = Direction. WestNorth,},
							[5] = {npcID = 20311,mapID = 107, x = 176, y = 41,dir = Direction. EastNorth,},
							[6] = {npcID = 20302,mapID = 107, x = 176, y = 44,dir = Direction. WestNorth,}, --陈宫
						},
					},
				},
		    },
		    [TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
						{npcID = 20305,	taskID = {1101}, index = 1}, --删除私有胡轸
						{npcID = 20303,	taskID = {1101}, index = 2}, --删除小怪
						{npcID = 20304,	taskID = {1101}, index = 3},
						{npcID = 20310,	taskID = {1101}, index = 4},
						{npcID = 20311,	taskID = {1101}, index = 5},
						},
					},
			},
			{type="openDialog", param={dialogID = 1004},}, --在任务结束时打开一个对话框
			},
	},
	},
        [1102] =	--主线25-30
	{

		name = "查探曹操下落",	--任务名字
		startNpcID = 20302,	--任务起始npc
		endNpcID = 20309,	--任务结束npc
		preTaskData = {1101},	--任务前置任务没有填nil
		nextTaskID = 1103,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1008,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 4900,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 65000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --东郡——王方
			{
				mineIndex = 1,		--第一个雷
				scriptID = 162,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1006,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20309, x = 184, y = 69,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20306, x = 187, y = 67,  noDelete = true},
					{npcID = 20306, x = 187, y = 64,  noDelete = true},
					{npcID = 20306, x = 184, y = 64,  noDelete = true},
					{npcID = 20306, x = 182, y = 67,  noDelete = true},
				},
				posData = {mapID = 107, x = 184, y = 69}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
						{npcID = 20302,	taskID = {1101}, index = 6}, --删除私有陈宫
						},
					},
			},
			{type="createPrivateNpc", ----------创建王方
				param={
						npcs =
						{
						    [1] = {npcID = 20309,mapID = 107, x = 184, y = 69,dir = Direction. WestSouth,},--王方
						},
					},
				},
			{type="openDialog", param={dialogID = 1008},}, --在任务结束时打开一个对话框
			},
	},
	},
        [1103] =	--主线25-30  未测试
	{

		name = "解救曹操",	--任务名字
		startNpcID = 20309,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1102},	--任务前置任务没有填nil
		nextTaskID = 1104,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1011 ,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 4900,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 66000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --东郡——董越
			{
				mineIndex = 1,		--第一个雷
				scriptID = 163,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1009,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 107, x = 166, y = 97}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态
			{
			{type="createPrivateNpc", ----------创建被怪物围住的曹操和董越部队
				param={
						npcs =
						{
							[1] = {npcID = 20312, mapID = 107, x = 166, y = 97,dir = Direction. South,},--董越
							[2] = {npcID = 20307, mapID = 107, x = 163, y = 100,dir = Direction. WestSouth,},
							[3] = {npcID = 20319, mapID = 107, x = 166, y = 97,dir = Direction. WestNorth,},
							[4] = {npcID = 20320, mapID = 107, x = 163, y = 94,dir = Direction. EastNorth,},
							[5] = {npcID = 20324, mapID = 107, x = 160, y = 98,dir = Direction. EastSouth,},
							[6] = {npcID = 20313, mapID = 107, x = 163, y = 97,dir = Direction. South,}, --曹操
						},
					},
				},
		    },
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc", ----------删除私有npc
				param={
						npcs =
						{
							{npcID = 20312,	taskID = {1103}, index = 1},
							{npcID = 20307,	taskID = {1103}, index = 2},
							{npcID = 20319,	taskID = {1103}, index = 3},
							{npcID = 20320,	taskID = {1103}, index = 4},
							{npcID = 20324,	taskID = {1103}, index = 5},
							{npcID = 20309,	taskID = {1102}, index = 1},
						},
					},
				},
			{type="openDialog", param={dialogID = 1011},}, --在任务结束时打开一个对话框
			},
	},
	},
	[1104] =	--主线25-30  未测试
	{

		name = "护送曹操",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1103},	--任务前置任务没有填nil
		nextTaskID = 1105,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1013,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5000,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 67000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     
			{
				mineIndex = 1,		--第一个雷
				scriptID = 170,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1051,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20314, x = 109, y = 128,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20306, x = 106, y = 129,  noDelete = true},
					{npcID = 20306, x = 107, y = 131,  noDelete = true},
					{npcID = 20306, x = 110, y = 131,  noDelete = true},
					{npcID = 20306, x = 112, y = 128,  noDelete = true},
				},
				posData = {mapID = 107, x = 109, y = 128}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =     
			{
				mineIndex = 2,		--第二个雷
				scriptID = 171,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1052,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20315, x = 159, y = 165,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20314, x = 154, y = 163,  noDelete = true},
					{npcID = 20314, x = 155, y = 166,  noDelete = true},
					{npcID = 20314, x = 158, y = 169,  noDelete = true},
					{npcID = 20314, x = 161, y = 170,  noDelete = true},
				},
				posData = {mapID = 107, x = 159, y = 165}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[3] = {type='Tmine',param =     
			{
				mineIndex = 3,		--第三个雷
				scriptID = 172,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1053,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20316, x = 125, y = 197,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20315, x = 119, y = 197,  noDelete = true},
					{npcID = 20315, x = 122, y = 197,  noDelete = true},
					{npcID = 20315, x = 125, y = 200,  noDelete = true},
					{npcID = 20315, x = 125, y = 203,  noDelete = true},
				},
				posData = {mapID = 107, x = 125, y = 197}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=  ---接任务状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20313,	taskID = {1103}, index = 6}, --删除私有曹操
						},
					},
				},
			{type="createFollow", param = {npcs = {20313},}},				--添加曹操跟随
			},
			[TaskStatus.Done]		=   -----完成目标状态
			{
			{type="openDialog", param={dialogID = 1013},}, --在目标完成时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1105}},
			},
	},
	},
    [1105] =	--主线25-30
	{

		name = "再遇阻拦",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1104},	--任务前置任务没有填nil
		nextTaskID = 1106,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1016,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 4900,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 68000,    --绑银
		},
		consume =--任务消耗没有填{}		
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --东郡——成廉
			{
				mineIndex = 1,		--第一个雷
				scriptID = 164,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1014,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 107, x = 105, y = 215}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="createPrivateNpc", ----------创建曹操交接任务
				param={
						npcs =
						{
							[1] = {npcID = 20317, mapID = 107, x = 105, y = 215,dir = Direction. South,}, --成廉
							[2] = {npcID = 20316, mapID = 107, x = 102, y = 213,dir = Direction. South,}, --小怪
							[3] = {npcID = 20328, mapID = 107, x = 102, y = 216,dir = Direction. South,}, --小怪
							[4] = {npcID = 20329, mapID = 107, x = 104, y = 218,dir = Direction. South,}, --小怪
							[5] = {npcID = 20332, mapID = 107, x = 108, y = 216,dir = Direction. South,}, --小怪
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deleteFollow", param = {npcs = {20313},}}, --在交任务状态删除指定ID的npc跟随
			{type="createPrivateNpc", ----------创建曹操交接任务
				param={
						npcs =
						{
							[1] = {npcID = 20313, mapID = 107, x = 105, y = 215,dir = Direction. South,}, --曹操
						},
					},
				},
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20317,	taskID = {1104}, index = 1}, --删除成廉
							{npcID = 20316,	taskID = {1104}, index = 2}, --删除小怪
							{npcID = 20328,	taskID = {1104}, index = 3}, --删除小怪
							{npcID = 20329,	taskID = {1104}, index = 4}, --删除小怪
							{npcID = 20332,	taskID = {1104}, index = 5}, --删除小怪
						},
					},
			},
			{type="openDialog", param={dialogID = 1016},}, --在目标完成时打开一个对话框
			},
		},
	},
    [1106] =	--主线25-30  未测试
	{

		name = "回禀天尊",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = 20002,	--任务结束npc
		preTaskData = {1105},	--任务前置任务没有填nil
		nextTaskID = 1107,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1018,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5000,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 69000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc", ----------删除袁绍
				param={
						npcs =
						{
							{npcID = 20313,	taskID = {1105}, index = 1},
						},
					},
			},
			{type="openDialog", param={dialogID = 1018},}, --在目标完成时打开一个对话框
			},
		},
	},
        [1107] =	--主线25-30  未测试
	{

		name = "再探东郡",	--任务名字
		startNpcID = 20318,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1106},	--任务前置任务没有填nil
		nextTaskID = 1108,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1020,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5000,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 70000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 107 , x = 109, y = 98, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateNpc", ----------创建袁绍
					param={
							npcs =
							{
								[1] = {npcID = 20318, mapID = 107, x = 109, y = 98,dir = Direction. EastSouth,},--袁绍
							},
						},
				},
		    },
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="openDialog", param={dialogID = 1020},}, --在目标完成时打开一个对话框
			},
		},
	},
	[1108] =	--主线25-30  未测试
	{

		name = "相助曹操",	--任务名字
		startNpcID = 20318,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1107},	--任务前置任务没有填nil
		nextTaskID = 1109,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1022,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5000,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 71000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 109 , x = 274, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="createPrivateNpc", ----------创建曹操
				param={
						npcs =
						{
							[1] = {npcID = 20313,mapID =109, x = 274, y = 91,dir = Direction. EastSouth,},--曹操
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc", ----------删除袁绍
				param={
						npcs =
						{
							{npcID = 20318,	taskID = {1107}, index = 1},
						},
					},
			},
			{type="openDialog", param={dialogID = 1022},}, --在目标完成时打开一个对话框
			},
		},
	},
	[1109] =	--主线25-30  未测试
	{

		name = "驰援关羽",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = 20322,	--任务结束npc
		preTaskData = {1108},	--任务前置任务没有填nil
		nextTaskID = 1110,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1026,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 5000,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 72000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --李蒙
			{
				mineIndex = 1,		--第一个雷
				scriptID = 165,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1024,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 109, x = 251, y = 96}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20322,mapID = 109, x = 251, y = 91,dir = Direction. EastNorth,},--关羽
								[2] = {npcID = 20321,mapID = 109, x = 250, y = 96,dir = Direction. EastNorth,},--李蒙
								[3] = {npcID = 20338,mapID = 109, x = 246, y = 95,dir = Direction. EastNorth,},--小怪
								[4] = {npcID = 20339,mapID = 109, x = 247, y = 97,dir = Direction. EastNorth,},--小怪
								[5] = {npcID = 20340,mapID = 109, x = 253, y = 97,dir = Direction. EastNorth,},--小怪
								[6] = {npcID = 20341,mapID = 109, x = 254, y = 95,dir = Direction. EastNorth,},--小怪
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateNpc",
					param={
							npcs =
							{
								{npcID = 20321,	taskID = {1109}, index = 2}, --删除李蒙
								{npcID = 20338,	taskID = {1109}, index = 3}, --删除小怪
								{npcID = 20339,	taskID = {1109}, index = 4}, --删除小怪
								{npcID = 20340,	taskID = {1109}, index = 5}, --删除小怪
								{npcID = 20341,	taskID = {1109}, index = 6}, --删除小怪
							},
						},
				},
			{type="openDialog", param={dialogID = 1026},}, --在任务结束时打开一个对话框
			},
	},
	},
	[1110] =	--主线25-30  未测试
	{

		name = "温酒斩华雄",	--任务名字
		startNpcID = 20322,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1109},	--任务前置任务没有填nil
		nextTaskID = 1111,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1029,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 73000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --华雄
			{
				mineIndex = 1,		--第一个雷
				scriptID = 166,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1027,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 109, x = 187, y = 106}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="createFollow", param = {npcs = {20322},}},				--添加关羽
				{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20322,	taskID = {1109}, index = 1}, --删除关羽
						},
					},
				},
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20325,mapID = 109, x = 187, y = 106,dir = Direction. EastSouth,}, --华雄
								[2] = {npcID = 20323,mapID = 109, x = 185, y = 103,dir = Direction. EastSouth,}, --小怪
								[3] = {npcID = 20343,mapID = 109, x = 183, y = 104,dir = Direction. EastSouth,}, --小怪
								[4] = {npcID = 20344,mapID = 109, x = 183, y = 108,dir = Direction. EastSouth,}, --小怪
								[5] = {npcID = 20345,mapID = 109, x = 185, y = 109,dir = Direction. EastSouth,}, --小怪
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 20325,	taskID = {1109}, index = 1}, --删除华雄
							{npcID = 20323,	taskID = {1109}, index = 2}, --删除小怪
							{npcID = 20343,	taskID = {1109}, index = 3}, --删除小怪
							{npcID = 20344,	taskID = {1109}, index = 4}, --删除小怪
							{npcID = 20345,	taskID = {1109}, index = 5}, --删除小怪
						},
					},
				},
				{type="openDialog", param={dialogID = 1029},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1111] =	--主线25-30
	{

		name = "联合刘关张",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = 20326,	--任务结束npc
		preTaskData = {1110},	--任务前置任务没有填nil
		nextTaskID = 1112,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1030,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 74000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 109 , x = 250, y = 94, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20326,mapID = 109, x = 250, y = 94,dir = Direction. EastNorth,}, --创建刘备
								[2] = {npcID = 20327,mapID = 109, x = 252, y = 92,dir = Direction. EastNorth,}, --创建张飞
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="createFollow", param = {npcs = {20326,20327},}},				--添加刘备、张飞跟随
			{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 20326,	taskID = {1111}, index = 1}, --删除刘备
							{npcID = 20327,	taskID = {1111}, index = 2}, --删除张飞
						},
					},
				},
			{type="openDialog", param={dialogID = 1030},}, --在任务结束时打开一个对话框
			},
			[TaskStatus.Finished]	=      ---完成任务状态
			{
			}
	},
	},
	[1112] =	--主线25-30  未测试
	{

		name = "降服张辽",	--任务名字
		startNpcID = 20326,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1111},	--任务前置任务没有填nil
		nextTaskID = 1113,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1034,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 75000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --张辽
			{
				mineIndex = 1,		--第一个雷
				scriptID = 167,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1032,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 109, x = 101, y = 164}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="createPrivateNpc", ----------创建私有袁绍
					param={
						npcs =
						{
								[1] = {npcID = 20331,mapID = 109, x = 101, y = 164,dir = Direction. South,}, --创建张辽
								[2] = {npcID = 20330,mapID = 109, x = 95, y = 164,dir = Direction. South,}, --创建小怪
								[3] = {npcID = 20346,mapID = 109, x = 98, y = 166,dir = Direction. South,}, --创建小怪
								[4] = {npcID = 20347,mapID = 109, x = 104, y = 166,dir = Direction. South,}, --创建小怪
								[5] = {npcID = 20348,mapID = 109, x = 108, y = 163,dir = Direction. South,}, --创建小怪
						},
					},
			},
			{type="createFollow", param = {npcs = {20326,20327},}},				--添加刘备、张飞跟随
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20330,	taskID = {1112}, index = 2}, --删除小怪
							{npcID = 20346,	taskID = {1112}, index = 3}, --删除小怪
							{npcID = 20347,	taskID = {1112}, index = 4}, --删除小怪
							{npcID = 20348,	taskID = {1112}, index = 5}, --删除小怪
						},
					},
			},
			{type="openDialog", param={dialogID = 1034},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1113] =	--主线25-30  未测试
	{

		name = "三英战吕布",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20335,	--任务结束npc
		preTaskData = {1112},	--任务前置任务没有填nil
		nextTaskID = 1151,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1039,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 76000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --吕布
			{
				mineIndex = 1,		--第一个雷
				scriptID = 168,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1037,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 109, x = 87, y = 291}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20335,mapID = 109, x = 87, y = 291,dir = Direction. WestSouth,}, --创建吕布
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20335,	taskID = {1113}, index = 1}, --删除吕布
							{npcID = 20331,	taskID = {1112}, index = 1}, --删除张辽
						},
					},
			},
				{type="openDialog", param={dialogID = 1039},},
				{type="finishTask", param = {recetiveTaskID = 1114}},
			},
		},
	},
	[1114] =	--主线25-30  未测试
	{

		name = "大战魔化吕布",	--任务名字
		startNpcID = 20335,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1112},	--任务前置任务没有填nil
		nextTaskID = 1114,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1041,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8200,   --玩家经验
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
			[TaskRewardList.pet_xp] = 4100,      --宠物经验
			[TaskRewardList.subMoney] = 77000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --魔化吕布
			{
				mineIndex = 1,		--第一个雷
				scriptID = 169,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1040,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 109, x = 87, y = 291}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20342,mapID = 109, x = 87, y = 291,dir = Direction. WestSouth,}, --创建魔化吕布
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20342,	taskID = {1113}, index = 1}, --删除魔化吕布
						},
					},
			},
			{type="createPrivateNpc", ----------创建私有npc
				param={
						npcs =
						{
								[1] = {npcID = 20326,mapID = 109, x = 87, y = 291,dir = Direction. WestSouth,}, --创建刘备
								[1] = {npcID = 20322,mapID = 109, x = 87, y = 291,dir = Direction. WestSouth,}, --创建关羽
								[1] = {npcID = 20327,mapID = 109, x = 87, y = 291,dir = Direction. WestSouth,}, --创建展飞
						},
					},
			},
			{type="deleteFollow", param = {npcs = {20322,20326,20327},}}, --在交任务状态删除指定ID的npc跟随
			{type="openDialog", param={dialogID = 1041},},
			},
		},
	},
	[1115] =	--主线25-30  未测试
	{

		name = "回禀曹操",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1113},	--任务前置任务没有填nil
		nextTaskID = 1115,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1043,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5200,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 78000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 109 , x = 274, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20326,	taskID = {1114}, index = 1}, --删除刘备
							{npcID = 20322,	taskID = {1114}, index = 2}, --删除关羽
							{npcID = 20327,	taskID = {1114}, index = 3}, --删除张飞
						},
					},
			},
			{type="openDialog", param={dialogID = 1043},},
			},
		},
	},

	[1116] =	--主线25-30  未测试
	{

		name = "返回东郡",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = 20318,	--任务结束npc
		preTaskData = {1114},	--任务前置任务没有填nil
		nextTaskID = 1117,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1045,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5200,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 79000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 107 , x = 110, y = 98, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20318,mapID = 107, x = 110, y = 98,dir = Direction. WestNorth,}, --创建袁绍
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20313,	taskID = {1108}, index = 1}, --删除私有曹操
						},
					},
			},
				{type="openDialog", param={dialogID = 1045},},
			},
		},
	},
	[1117] =	--主线25-30  未测试
	{

		name = "回报天尊",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = 20002,	--任务结束npc
		preTaskData = {1116},	--任务前置任务没有填nil
		nextTaskID = 1118,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1048,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.player_pot] = 5200,  	--人物潜能
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 80000,    --绑银
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20318,	taskID = {1115}, index = 1}, --删除私有袁绍
						},
					},
			},
				{type="openDialog", param={dialogID = 1048},},
			},
		},
	},
	[1118] =	--主线25-30  未测试
	{

		name = "达到三十级",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20002,	--任务结束npc
		preTaskData = {1117},	--任务前置任务没有填nil
		nextTaskID = 1151,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1050,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 30000,    --绑银
			[TaskRewardList.player_pot] = 9000,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TattainLevel',param = {level = 30,bor = true},},---等级限制目标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20318,	taskID = {1112}, index = 1}, --删除私有袁绍
						},
					},
			},
			{type="openDialog", param={dialogID = 1050},},
			},
		},
	},


}

table.copy(MainTaskDB21_30, NormalTaskDB)