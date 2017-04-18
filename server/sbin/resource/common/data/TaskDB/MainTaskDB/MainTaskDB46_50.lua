--[[MainTaskDB46_50.lua
	任务配置46到50级(任务系统)
]]

MainTaskDB46_50 = 
{
    [1801] =
	{
		name = "商议对策",	--任务名字
		startNpcID = 21228,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1714},	--任务前置任务没有填nil
		nextTaskID = 1802,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1901,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateTransfer",
				param={
						transfers =
						{
						[1] = {mapID = 416, x = 124, y = 260, tarMapID = 10, tarX = 200, tarY = 200},--创建私有传送阵
						},
				},
		},
		{type = "autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --寻路到掌门
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1801, index = 1},--删除私有传送阵
							},
						},
				},
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 21228,taskID = {1714}, index = 1},--孙策
				},
			},
		},
		{type="openDialog", param={dialogID = 1901},}, --在任务结束时打开一个对话框
		},
	},
    },
    [1802] =
	{
		name = "查探消息",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 21304,		--任务结束npc
		preTaskData = {1801},	--任务前置任务没有填nil
		nextTaskID = 1803,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1909,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --河北守将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 601,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1903,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21302, x = 59, y = 170,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21301, x = 61, y = 172,  noDelete = true},
			{npcID = 21301, x = 57, y = 168,  noDelete = true},
			{npcID = 21301, x = 60, y = 167,  noDelete = true},
			{npcID = 21301, x = 62, y = 169,  noDelete = true},
			},
			posData = {mapID = 126, x = 59, y = 170}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --河北副将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 602,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1905,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21303, x = 121, y = 119,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21301, x = 119, y = 117,  noDelete = true},
			{npcID = 21301, x = 123, y = 121,  noDelete = true},
			{npcID = 21301, x = 122, y = 116,  noDelete = true},
			{npcID = 21301, x = 124, y = 118,  noDelete = true},
			},
			posData = {mapID = 126, x = 121, y = 119}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --审配
			{
			mineIndex = 3,		--第三个雷
			scriptID = 603,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1907,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21304, x = 190, y = 110,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21301, x = 187, y = 112,  noDelete = true},
			{npcID = 21301, x = 192, y = 112,  noDelete = true},
			},
			posData = {mapID = 126, x = 190, y = 110}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type="createPrivateNpc", ----------创建私有审配
				param={
					npcs =
						{
						[1] = {npcID = 21304, mapID = 126, x = 190, y = 110,dir = Direction. WestSouth,},--审配
						},
				},
		},
		{type="openDialog", param={dialogID = 1909},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1803] =
	{
		name = "探查袁绍",	--任务名字
		startNpcID = 21304,	--任务起始npc
		endNpcID = 21306,		--任务结束npc
		preTaskData = {1802},	--任务前置任务没有填nil
		nextTaskID = 1804,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1913,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --吕旷
			{
			mineIndex = 1,		--第三个雷
			scriptID = 604,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1911,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21306, x = 172, y = 84,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21305, x = 174, y = 86,  noDelete = true},
			{npcID = 21305, x = 169, y = 85,  noDelete = true},
			},
			posData = {mapID = 418, x = 172, y = 84}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--邺城
				param={
						transfers =
						{
						[1] = {mapID = 126, x =202, y =52, tarMapID = 418, tarX = 190, tarY = 12},--进入
						--[2] = {mapID = 418, x =191, y =7, tarMapID = 126, tarX = 206, tarY = 53},--出来
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有审配
			param={
				npcs =
				{
				{npcID = 21304,taskID = {1802}, index = 1},--审配
				},
			},
		},
		{type="createPrivateNpc", ----------创建私有吕旷
				param={
					npcs =
						{
						[1] = {npcID = 21306, mapID = 418, x = 172, y = 84,dir = Direction. WestSouth,},--吕旷
						},
				},
		},
		{type="openDialog", param={dialogID = 1913},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1804] =
	{
		name = "回禀卢植",	--任务名字
		startNpcID = 21306,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1803},	--任务前置任务没有填nil
		nextTaskID = 1805,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1916,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --寻路到掌门
		{type = "createPrivateTransfer", ------创建私有传送阵--邺城
				param={
						transfers =
						{
						--[1] = {mapID = 126, x =202, y =52, tarMapID = 418, tarX = 190, tarY = 12},--进入
						[1] = {mapID = 418, x =191, y =7, tarMapID = 126, tarX = 206, tarY = 53},--出来
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵--邺城
			param={
					transfers =
					{
					{taskID = 1803, index = 1},
					{taskID = 1804, index = 1},
					},
				},
		},
		{type="deletePrivateNpc", ---------删除私有吕旷
			param={
				npcs =
				{
				{npcID = 21306,taskID = {1803}, index = 1},--吕旷
				},
			},
		},
		{type="openDialog", param={dialogID = 1916},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1805] =
	{
		name = "再访公孙瓒",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 21310,		--任务结束npc
		preTaskData = {1804},	--任务前置任务没有填nil
		nextTaskID = 1806,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1924,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --袁军守将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 605,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1918,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21308, x = 226, y = 94,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21307, x = 229, y = 91,  noDelete = true},
			{npcID = 21307, x = 223, y = 97,  noDelete = true},
			{npcID = 21307, x = 223, y = 94,  noDelete = true},
			{npcID = 21307, x = 226, y = 91,  noDelete = true},
			},
			posData = {mapID = 132, x = 226, y = 94}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --袁军副将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 606,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1920,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21309, x = 180, y = 52,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21307, x = 178, y = 56,  noDelete = true},
			{npcID = 21307, x = 181, y = 48,  noDelete = true},
			{npcID = 21307, x = 176, y = 54,  noDelete = true},
			{npcID = 21307, x = 178, y = 50,  noDelete = true},
			},
			posData = {mapID = 132, x = 180, y = 52}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --高翔
			{
			mineIndex = 3,		--第三个雷
			scriptID = 607,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1922,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21310, x = 153, y = 96,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21307, x = 157, y = 95,  noDelete = true},
			{npcID = 21307, x = 153, y = 99,  noDelete = true},
			},
			posData = {mapID = 132, x = 153, y = 96}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type="createPrivateNpc", ----------创建私有高翔
				param={
					npcs =
						{
						[1] = {npcID = 21310, mapID = 132, x = 153, y = 96,dir = Direction. West,},--高翔
						},
				},
		},
		{type="openDialog", param={dialogID = 1924},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1806] =
	{
		name = "深入辽东",	--任务名字
		startNpcID = 21310,	--任务起始npc
		endNpcID = 21316,		--任务结束npc
		preTaskData = {1805},	--任务前置任务没有填nil
		nextTaskID = 1807,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1928,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --冯礼
			{
			mineIndex = 1,		--第三个雷
			scriptID = 608,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1926,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{},
			posData = {mapID = 132, x = 204, y = 158}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有冯礼
				param={
					npcs =
						{
						[1] = {npcID = 21315, mapID = 132, x = 204, y = 158,dir = Direction. WestSouth,},--冯礼
						[2] = {npcID = 21311, mapID = 132, x = 208, y = 156,dir = Direction. West,},
						[3] = {npcID = 21312, mapID = 132, x = 208, y = 152,dir = Direction. North,},
						[4] = {npcID = 21313, mapID = 132, x = 203, y = 152,dir = Direction. East,},
						[5] = {npcID = 21314, mapID = 132, x = 202, y = 156,dir = Direction. South,},
						[6] = {npcID = 21316, mapID = 132, x = 205, y = 154,dir = Direction. EastNorth,},--赵云
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有高翔
			param={
				npcs =
				{
				{npcID = 21310,taskID = {1805}, index = 1},--高翔
				{npcID = 21315,taskID = {1806}, index = 1},--冯礼
				{npcID = 21311,taskID = {1806}, index = 2},
				{npcID = 21312,taskID = {1806}, index = 3},
				{npcID = 21313,taskID = {1806}, index = 4},
				{npcID = 21314,taskID = {1806}, index = 5},
				},
			},
		},
		{type="openDialog", param={dialogID = 1928},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1807] =
	{
		name = "勇闯易京",	--任务名字
		startNpcID = 21316,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1806},	--任务前置任务没有填nil
		nextTaskID = 1808,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --袁军偏将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 609,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1930,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21318, x = 121, y = 129,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21317, x = 121, y = 132,  noDelete = true},
			{npcID = 21317, x = 121, y = 126,  noDelete = true},
			{npcID = 21317, x = 119, y = 128,  noDelete = true},
			{npcID = 21317, x = 119, y = 131,  noDelete = true},
			},
			posData = {mapID = 132, x = 121, y = 129}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --袁军统领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 610,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1932,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21319, x = 67, y = 200,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21317, x = 64, y = 204,  noDelete = true},
			{npcID = 21317, x = 70, y = 196,  noDelete = true},
			{npcID = 21317, x = 70, y = 199,  noDelete = true},
			{npcID = 21317, x = 68, y = 202,  noDelete = true},
			},
			posData = {mapID = 132, x = 67, y = 200}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --郭援
			{
			mineIndex = 3,		--第三个雷
			scriptID = 611,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1934,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21320, x = 122, y = 237,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21317, x = 118, y = 239,  noDelete = true},
			{npcID = 21317, x = 125, y = 239,  noDelete = true},
			},
			posData = {mapID = 132, x = 122, y = 237}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有赵云
			param={
				npcs =
				{
				{npcID = 21316,taskID = {1806}, index = 6},--赵云
				},
			},
		},
		{type = "createFollow", param = {npcs = {21316},}},				--创建指定npc跟随(参数npcID)
		},
		[TaskStatus.Done] =
		{
		{type="openDialog", param={dialogID = 1936},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1808}},--触发完成任务接受下一个任务
		},
	},
    },
	[1808] =
	{
		name = "闯入易京",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21324,		--任务结束npc
		preTaskData = {1807},	--任务前置任务没有填nil
		nextTaskID = 1809,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1943,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --袁军攻城将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 612,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1937,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21322, x = 207, y = 137,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21321, x = 210, y = 137,  noDelete = true},
			{npcID = 21321, x = 204, y = 137,  noDelete = true},
			{npcID = 21321, x = 205, y = 139,  noDelete = true},
			{npcID = 21321, x = 208, y = 139,  noDelete = true},
			},
			posData = {mapID = 417, x = 207, y = 137}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --袁军铁甲将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 613,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1939,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21323, x = 169, y = 154,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21321, x = 172, y = 154,  noDelete = true},
			{npcID = 21321, x = 166, y = 154,  noDelete = true},
			{npcID = 21321, x = 167, y = 156,  noDelete = true},
			{npcID = 21321, x = 170, y = 156,  noDelete = true},
			},
			posData = {mapID = 417, x = 169, y = 154}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --吕威璜
			{
			mineIndex = 3,		--第三个雷
			scriptID = 614,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1941,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21324, x = 188, y = 196,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21321, x = 186, y = 198,  noDelete = true},
			{npcID = 21321, x = 189, y = 198,  noDelete = true},
			},
			posData = {mapID = 417, x = 188, y = 196}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--易京城
				param={
						transfers =
						{
						[1] = {mapID = 132, x =119, y =265, tarMapID = 417, tarX = 192, tarY = 42},--进入
						--[2] = {mapID = 417, x =191, y =36, tarMapID = 132, tarX = 119, tarY = 261},--进入口出来
						--[3] = {mapID = 417, x =110, y =249, tarMapID = 132, tarX = 119, tarY = 261},--终点口出来
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="createPrivateNpc", ----------创建私有吕威璜
				param={
					npcs =
						{
						[1] = {npcID = 21324, mapID = 417, x = 188, y = 196,dir = Direction. WestSouth,},--吕威璜
						},
				},
		},
		{type="openDialog", param={dialogID = 1943},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1809] =
	{
		name = "找寻文丑",	--任务名字
		startNpcID = 21324,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1808},	--任务前置任务没有填nil
		nextTaskID = 1810,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --易京守将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 615,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1946,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21326, x = 150, y = 182,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21325, x = 153, y = 180,  noDelete = true},
			{npcID = 21325, x = 147, y = 183,  noDelete = true},
			{npcID = 21325, x = 151, y = 179,  noDelete = true},
			{npcID = 21325, x = 148, y = 180,  noDelete = true},
			},
			posData = {mapID = 417, x = 150, y = 182}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --易京偏将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 616,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1948,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21327, x = 139, y = 120,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21325, x = 139, y = 123,  noDelete = true},
			{npcID = 21325, x = 139, y = 117,  noDelete = true},
			{npcID = 21325, x = 137, y = 119,  noDelete = true},
			{npcID = 21325, x = 137, y = 122,  noDelete = true},
			},
			posData = {mapID = 417, x = 139, y = 120}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --牵招
			{
			mineIndex = 3,		--第三个雷
			scriptID = 617,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1950,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21328, x = 99, y = 145,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21325, x = 96, y = 147,  noDelete = true},
			{npcID = 21325, x = 101, y = 147,  noDelete = true},
			},
			posData = {mapID = 417, x = 99, y = 145}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有吕威璜
			param={
				npcs =
				{
				{npcID = 21324,taskID = {1808}, index = 1},--吕威璜
				},
			},
		},
		{type="openDialog", param={dialogID = 1952},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1810}},--触发完成任务接受下一个任务
		},
	},
    },
	[1810] =
	{
		name = "报仇雪恨",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1809},	--任务前置任务没有填nil
		nextTaskID = 1811,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --文丑
			{
			mineIndex = 1,		--第三个雷
			scriptID = 620,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1957,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21332, x = 117, y = 207,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21329, x = 114, y = 210,  noDelete = true},
			{npcID = 21329, x = 120, y = 209,  noDelete = true},
			},
			posData = {mapID = 417, x = 117, y = 207}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type="openDialog", param={dialogID = 1959},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1811}},--触发完成任务接受下一个任务
		},
	},
    },
	[1811] =
	{
		name = "再探河北",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21336,		--任务结束npc
		preTaskData = {1810},	--任务前置任务没有填nil
		nextTaskID = 1812,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1967,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --河北偏将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 621,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1961,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21334, x = 58, y = 226,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21333, x = 59, y = 222,  noDelete = true},
			{npcID = 21333, x = 58, y = 229,  noDelete = true},
			{npcID = 21333, x = 56, y = 224,  noDelete = true},
			{npcID = 21333, x = 56, y = 228,  noDelete = true},
			},
			posData = {mapID = 126, x = 58, y = 226}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --河北都尉
			{
			mineIndex = 2,		--第二个雷
			scriptID = 622,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1963,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21335, x = 120, y = 188,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21333, x = 122, y = 184,  noDelete = true},
			{npcID = 21333, x = 119, y = 191,  noDelete = true},
			{npcID = 21333, x = 121, y = 190,  noDelete = true},
			{npcID = 21333, x = 123, y = 186,  noDelete = true},
			},
			posData = {mapID = 126, x = 120, y = 188}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --焦触
			{
			mineIndex = 3,		--第三个雷
			scriptID = 623,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1965,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21336, x = 144, y = 140,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21333, x = 146, y = 136,  noDelete = true},
			{npcID = 21333, x = 140, y = 141,  noDelete = true},
			},
			posData = {mapID = 126, x = 144, y = 140}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--易京城
				param={
						transfers =
						{
						--[1] = {mapID = 132, x =119, y =265, tarMapID = 417, tarX = 192, tarY = 42},--进入
						--[2] = {mapID = 417, x =191, y =36, tarMapID = 132, tarX = 119, tarY = 261},--进入口出来
						[1] = {mapID = 417, x =110, y =249, tarMapID = 132, tarX = 119, tarY = 261},--终点口出来
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵--易京城
			param={
					transfers =
					{
					{taskID = 1808, index = 1},
					{taskID = 1811, index = 1},
					--{taskID = 1808, index = 3},
					},
				},
		},
		{type="createPrivateNpc", ----------创建私有焦触
				param={
					npcs =
						{
						[1] = {npcID = 21336, mapID = 126, x = 144, y = 140,dir = Direction. East,},--焦触
						},
				},
		},
		{type="openDialog", param={dialogID = 1967},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1812] =
	{
		name = "营救田楷",	--任务名字
		startNpcID = 21336,	--任务起始npc
		endNpcID = 21344,		--任务结束npc
		preTaskData = {1811},	--任务前置任务没有填nil
		nextTaskID = 1813,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1975,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --邺城守将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 624,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1969,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21341, x = 179, y = 38,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21337, x = 182, y = 38,  noDelete = true},
			{npcID = 21338, x = 176, y = 38,  noDelete = true},
			{npcID = 21339, x = 177, y = 40,  noDelete = true},
			{npcID = 21340, x = 180, y = 40,  noDelete = true},
			},
			posData = {mapID = 418, x = 179, y = 38}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --邺城参将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 625,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1971,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21342, x = 119, y = 109,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21337, x = 117, y = 107,  noDelete = true},
			{npcID = 21338, x = 121, y = 111,  noDelete = true},
			{npcID = 21339, x = 116, y = 110,  noDelete = true},
			{npcID = 21340, x = 118, y = 112,  noDelete = true},
			},
			posData = {mapID = 418, x = 119, y = 109}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --邓升
			{
			mineIndex = 3,		--第三个雷
			scriptID = 626,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1973,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{},
			posData = {mapID = 418, x = 50, y = 178}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--邺城
				param={
						transfers =
						{
						[1] = {mapID = 126, x =202, y =52, tarMapID = 418, tarX = 190, tarY = 12},--进入
						--[2] = {mapID = 418, x =191, y =7, tarMapID = 126, tarX = 206, tarY = 53},--出来
						},
				},
		},
		{type="createPrivateNpc", ----------创建私有邓升
				param={
					npcs =
						{
						[1] = {npcID = 21343, mapID = 418, x = 50, y = 178,dir = Direction. South,},--邓升
						[2] = {npcID = 21337, mapID = 418, x = 54, y = 178,dir = Direction. West,},
						[3] = {npcID = 21338, mapID = 418, x = 57, y = 174,dir = Direction. WestNorth,},
						[4] = {npcID = 21339, mapID = 418, x = 54, y = 171,dir = Direction. EastNorth,},
						[5] = {npcID = 21340, mapID = 418, x = 50, y = 174,dir = Direction. East,},
						[6] = {npcID = 21344, mapID = 418, x = 53, y = 175,dir = Direction. South,},--田楷
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有吕威璜
			param={
				npcs =
				{
				{npcID = 21336,taskID = {1811}, index = 1},--吕威璜
				{npcID = 21343,taskID = {1812}, index = 1},--邓升
				{npcID = 21337,taskID = {1812}, index = 2},
				{npcID = 21338,taskID = {1812}, index = 3},
				{npcID = 21339,taskID = {1812}, index = 4},
				{npcID = 21340,taskID = {1812}, index = 5},
				},
			},
		},
		{type="openDialog", param={dialogID = 1975},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1813] =
	{
		name = "深入邺城",	--任务名字
		startNpcID = 21344,	--任务起始npc
		endNpcID = 21348,		--任务结束npc
		preTaskData = {1812},	--任务前置任务没有填nil
		nextTaskID = 1814,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1983,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --赤云童子
			{
			mineIndex = 1,		--第三个雷
			scriptID = 629,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1981,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21348, x = 123, y = 226,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			},
			posData = {mapID = 418, x = 123, y = 226}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有田楷
			param={
				npcs =
				{
				{npcID = 21344,taskID = {1812}, index = 6},--田楷
				},
			},
		},
		{type = "deleteFollow", param = {npcs = {21316},}}, --在完成状态删除指定ID的npc跟随
		{type="createPrivateNpc", ----------创建私有赤云童子
				param={
					npcs =
						{
						[1] = {npcID = 21348, mapID = 418, x = 123, y = 226,dir = Direction. WestSouth,},--赤云童子
						[2] = {npcID = 21316, mapID = 418, x = 119, y = 224,dir = Direction. EastSouth,},--赵云
						},
				},
		},
		{type="openDialog", param={dialogID = 1983},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1814] =
	{
		name = "急告天尊",	--任务名字
		startNpcID = 21348,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1813},	--任务前置任务没有填nil
		nextTaskID = 1815,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1986,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		{type = "createPrivateTransfer", ------创建私有传送阵--邺城
				param={
						transfers =
						{
						--[1] = {mapID = 126, x =202, y =52, tarMapID = 418, tarX = 190, tarY = 12},--进入
						[1] = {mapID = 418, x =191, y =7, tarMapID = 126, tarX = 206, tarY = 53},--出来
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 21348,taskID = {1813}, index = 1},--赤云童子
				{npcID = 21316,taskID = {1813}, index = 2},--赵云
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵--邺城
			param={
					transfers =
					{
					{taskID = 1812, index = 1},
					{taskID = 1814, index = 1},
					},
				},
		},
		{type="openDialog", param={dialogID = 1986},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1815] =
	{
		name = "道统之争",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1814},	--任务前置任务没有填nil
		nextTaskID = 1816,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1988,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --寻路到掌门
		},
		[TaskStatus.Done] =
		{
		{type="openDialog", param={dialogID = 1988},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1816] =
	{
		name = "濮阳之围",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1815},	--任务前置任务没有填nil
		nextTaskID = 1817,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param =     --袁军前锋大将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 630,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1990,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21350, x = 175, y = 94,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21349, x = 178, y = 94,  noDelete = true},
			{npcID = 21349, x = 172, y = 94,  noDelete = true},
			{npcID = 21349, x = 173, y = 96,  noDelete = true},
			{npcID = 21349, x = 176, y = 96,  noDelete = true},
			},
			posData = {mapID = 133, x = 175, y = 94}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --袁军金甲大将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 631,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1992,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21351, x = 225, y = 135,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21349, x = 222, y = 135,  noDelete = true},
			{npcID = 21349, x = 228, y = 135,  noDelete = true},
			{npcID = 21349, x = 223, y = 137,  noDelete = true},
			{npcID = 21349, x = 226, y = 137,  noDelete = true},
			},
			posData = {mapID = 133, x = 225, y = 135}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --陶升
			{
			mineIndex = 3,		--第三个雷
			scriptID = 632,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1994,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 21352, x = 120, y = 148,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
			{npcID = 21349, x = 118, y = 146,  noDelete = true},
			{npcID = 21349, x = 118, y = 151,  noDelete = true},
			},
			posData = {mapID = 133, x = 120, y = 148}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{},
		[TaskStatus.Done] =
		{
		{type="openDialog", param={dialogID = 1996},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1817}},--触发完成任务接受下一个任务
		},
	},
    },
	[1817] =
	{
		name = "会合曹军",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21353,		--任务结束npc
		preTaskData = {1816},	--任务前置任务没有填nil
		nextTaskID = 1901,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1997,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 28000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 133 , x = 126, y = 98, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "autoTrace", param = {tarMapID	= 133, x = 126, y = 98,npcID = 21353,},}, --寻路到掌门
		{type="createPrivateNpc", ----------创建私有夏侯渊
				param={
					npcs =
						{
						[1] = {npcID = 21353, mapID = 133, x = 126, y = 98,dir = Direction. EastSouth,},--夏侯渊
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="openDialog", param={dialogID = 1997},}, --在任务结束时打开一个对话框
		},
	},
    },

[1901] =
	{

		name = "再寻关羽",	--任务名字
		startNpcID = 21353,	--任务起始npc
		endNpcID = 21401,	--任务结束npc
		preTaskData = {1817},	--任务前置任务没有填nil
		nextTaskID = 1902,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2001,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 420 , x = 135, y = 47, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 109, x = 162, y = 223, tarMapID = 420, tarX = 30, tarY = 151},--创建私有传送阵
						},
					},
				},
				{type="createPrivateNpc", 
					param={
						npcs =
						{
							[1] = {npcID = 21401,mapID = 420, x = 135, y = 47,dir = Direction. EastSouth,},--创建关羽
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
							{npcID = 21353,	taskID = {1817}, index = 1}, --删除关羽
						},
					},
				},
				{type="openDialog", param={dialogID = 2001},}, --在任务结束时打开一个对话框
			},
		},
	},

[1902] =
	{
		name = "前往白马坡",	--任务名字
		startNpcID = 21401,	--任务起始npc22
		endNpcID = 21409,	--任务结束npc
		preTaskData = {1901},	--任务前置任务没有填nil
		nextTaskID = 1903,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2009,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 651,
				lastMine = false,	--是否为最后一个雷
				dialogID = 2003,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 21402, x = 183, y = 128, noDelete = true},
					{npcID = 21405, x = 182, y = 126, noDelete = true},
					{npcID = 21406, x = 181, y = 124, noDelete = true},
					{npcID = 21407, x = 185, y = 129, noDelete = true},
					{npcID = 21408, x = 187, y = 130, noDelete = true},
				},
				posData = {mapID = 422, x = 183, y = 128}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
				},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 652,
				lastMine = false,	--是否为最后一个雷
				dialogID = 2005,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 21403, x = 206, y = 104, noDelete = true},
					{npcID = 21405, x = 202, y = 104, noDelete = true},
					{npcID = 21406, x = 206, y = 100, noDelete = true},
					{npcID = 21407, x = 206, y = 108, noDelete = true},
					{npcID = 21408, x = 210, y = 104, noDelete = true},
				},
				posData = {mapID = 422, x = 206, y = 104}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
				},
			[3] = {type='Tmine',param =
			{
				mineIndex = 3,		--第一个雷
				scriptID = 653,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2007,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 422, x = 228, y = 79}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
				},
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 420, x = 216, y = 61, tarMapID = 422, tarX = 171, tarY = 160},--创建私有传送阵
						},
					},

				},
				{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 21401,	taskID = {1901}, index = 1}, --删除关羽
						},
					},
				},
				{type="createFollow", param = {npcs = {21401},}},				--添加关羽跟随
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 21404,mapID = 422, x = 224, y = 83,dir = Direction. North,}, --创建蒋奇
								[2] = {npcID = 21405,mapID = 422, x = 224, y = 79,dir = Direction. EastSouth,}, --创建袁军兵士1
								[3] = {npcID = 21406,mapID = 422, x = 228, y = 83,dir = Direction. WestSouth,}, --创建袁军兵士2
								[4] = {npcID = 21407,mapID = 422, x = 229, y = 75,dir = Direction. EastNorth,}, --创建袁军兵士3
								[5] = {npcID = 21408,mapID = 422, x = 232, y = 79,dir = Direction. WestNorth,}, --创建袁军兵士4
								[6] = {npcID = 21409,mapID = 422, x = 228, y = 79,dir = Direction. North,}, --创建曹洪
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateTransfer",
					param={
						transfers =
						{
							{taskID = 1901, index = 1},--删除私有传送阵
						},
					},
				},
				{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 21404,	taskID = {1901}, index = 1}, --删除蒋奇
							{npcID = 21405,	taskID = {1901}, index = 2}, --删除袁军兵士
							{npcID = 21406,	taskID = {1901}, index = 3}, --删除袁军兵士
							{npcID = 21407,	taskID = {1901}, index = 4}, --删除袁军兵士
							{npcID = 21408,	taskID = {1901}, index = 5}, --删除袁军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2009},}, --在任务结束时打开一个对话框
			},
		},
	},

[1903] =
	{
		name = "营救曹操",	--任务名字
		startNpcID = 21409,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1902},	--任务前置任务没有填nil
		nextTaskID = 1904,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2013,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 654,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2011,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 422, x = 186, y = 70}, --踩雷坐标
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
								[1] = {npcID = 21410,mapID = 422, x = 186, y = 70,dir = Direction. South,}, --创建孟岱
								[2] = {npcID = 21405,mapID = 422, x = 180, y = 69,dir = Direction. South,}, --创建袁军兵士1
								[3] = {npcID = 21406,mapID = 422, x = 183, y = 69,dir = Direction. South,}, --创建袁军兵士2
								[4] = {npcID = 21407,mapID = 422, x = 187, y = 73,dir = Direction. South,}, --创建袁军兵士3
								[5] = {npcID = 21408,mapID = 422, x = 187, y = 76,dir = Direction. South,}, --创建袁军兵士4
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateTransfer",
					param={
						transfers =
						{
							{taskID = 1902, index = 1},--删除私有传送阵
						},
					},
				},
				{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 21409,	taskID = {1902}, index = 6}, --删除曹洪
							{npcID = 21410,	taskID = {1903}, index = 1}, --删除孟岱
							{npcID = 21405,	taskID = {1903}, index = 2}, --删除袁军兵士
							{npcID = 21406,	taskID = {1903}, index = 3}, --删除袁军兵士
							{npcID = 21407,	taskID = {1903}, index = 4}, --删除袁军兵士
							{npcID = 21408,	taskID = {1903}, index = 5}, --删除袁军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2013},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1904}},		--自动交接任务
			},
		},
	},

[1904] =
	{
		name = "杀入白马城",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1903},	--任务前置任务没有填nil
		nextTaskID = 1905,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 655,
				lastMine = false,	--是否为最后一个雷
				dialogID = 2014,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 21411, x = 160, y = 85, noDelete = true},
					{npcID = 21405, x = 154, y = 84, noDelete = true},
					{npcID = 21406, x = 157, y = 84, noDelete = true},
					{npcID = 21407, x = 161, y = 88, noDelete = true},
					{npcID = 21408, x = 161, y = 91, noDelete = true},
				},
				posData = {mapID = 422, x = 160, y = 85}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
				},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 656,
				lastMine = false,	--是否为最后一个雷
				dialogID = 2017,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 21412, x = 132, y = 117, noDelete = true},
					{npcID = 21405, x = 127, y = 116, noDelete = true},
					{npcID = 21406, x = 129, y = 119, noDelete = true},
					{npcID = 21407, x = 137, y = 116, noDelete = true},
					{npcID = 21408, x = 135, y = 120, noDelete = true},
				},
				posData = {mapID = 422, x = 132, y = 117}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
				},
			[3] = {type='Tmine',param =
			{
				mineIndex = 3,		--第一个雷
				scriptID = 657,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2019,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 422, x = 117, y = 175}, --踩雷坐标
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
								[1] = {npcID = 21413,mapID = 422, x = 117, y = 175,dir = Direction. South,}, --创建白马将军
								[2] = {npcID = 21405,mapID = 422, x = 114, y = 171,dir = Direction. South,}, --创建袁军兵士1
								[3] = {npcID = 21406,mapID = 422, x = 112, y = 175,dir = Direction. South,}, --创建袁军兵士2
								[4] = {npcID = 21407,mapID = 422, x = 117, y = 180,dir = Direction. South,}, --创建袁军兵士3
								[5] = {npcID = 21408,mapID = 422, x = 121, y = 178,dir = Direction. South,}, --创建袁军兵士4
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
							{npcID = 21413,	taskID = {1904}, index = 1}, --删除白马将军
							{npcID = 21405,	taskID = {1904}, index = 2}, --删除袁军兵士
							{npcID = 21406,	taskID = {1904}, index = 3}, --删除袁军兵士
							{npcID = 21407,	taskID = {1904}, index = 4}, --删除袁军兵士
							{npcID = 21408,	taskID = {1904}, index = 5}, --删除袁军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2020},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1905}},		--自动交接任务
			},
		},
	},

[1905] =
	{

		name = "猛将颜良",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21414,	--任务结束npc
		preTaskData = {1904},	--任务前置任务没有填nil
		nextTaskID = 1906,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2021,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 422 , x = 106, y = 227, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateNpc", ----------创建被怪物围住的陈宫和第1波怪
					param={
						npcs =
						{
							[1] = {npcID = 21414,mapID = 422, x = 106, y = 227,dir = Direction. WestSouth,},--创建曹操
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="openDialog", param={dialogID = 2021},}, --在任务结束时打开一个对话框
			},
		},
	},

[1906] =
	{
		name = "突围白马城",	--任务名字
		startNpcID = 21414,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1905},	--任务前置任务没有填nil
		nextTaskID = 1907,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 658,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2023,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 422, x = 103, y = 197}, --踩雷坐标
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
								[1] = {npcID = 21415,mapID = 422, x = 103, y = 197,dir = Direction. East,}, --创建张南
								[2] = {npcID = 21405,mapID = 422, x = 105, y = 192,dir = Direction. East,}, --创建袁军兵士1
								[3] = {npcID = 21406,mapID = 422, x = 102, y = 191,dir = Direction. East,}, --创建袁军兵士2
								[4] = {npcID = 21407,mapID = 422, x = 98, y = 199,dir = Direction. East,}, --创建袁军兵士3
								[5] = {npcID = 21408,mapID = 422, x = 97, y = 196,dir = Direction. East,}, --创建袁军兵士4
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
							{npcID = 21415,	taskID = {1906}, index = 1}, --删除张南
							{npcID = 21405,	taskID = {1906}, index = 2}, --删除袁军兵士
							{npcID = 21406,	taskID = {1906}, index = 3}, --删除袁军兵士
							{npcID = 21407,	taskID = {1906}, index = 4}, --删除袁军兵士
							{npcID = 21408,	taskID = {1906}, index = 5}, --删除袁军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2025},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1907}},		--自动交接任务
			},
		},
	},

[1907] =
	{
		name = "斩颜良",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1906},	--任务前置任务没有填nil
		nextTaskID = 1908,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 659,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2026,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 422, x = 65, y = 203}, --踩雷坐标
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
								[1] = {npcID = 21416,mapID = 422, x = 65, y = 203,dir = Direction. EastSouth,}, --创建颜良
								[2] = {npcID = 21417,mapID = 422, x = 63, y = 197,dir = Direction. EastSouth,}, --创建颜良亲兵1
								[3] = {npcID = 21418,mapID = 422, x = 64, y = 200,dir = Direction. EastSouth,}, --创建颜良亲兵2
								[4] = {npcID = 21419,mapID = 422, x = 64, y = 206,dir = Direction. EastSouth,}, --创建颜良亲兵3
								[5] = {npcID = 21420,mapID = 422, x = 63, y = 209,dir = Direction. EastSouth,}, --创建颜良亲兵4
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
							{npcID = 21416,	taskID = {1907}, index = 1}, --删除颜良
							{npcID = 21417,	taskID = {1907}, index = 2}, --删除颜良亲兵
							{npcID = 21418,	taskID = {1907}, index = 3}, --删除颜良亲兵
							{npcID = 21419,	taskID = {1907}, index = 4}, --删除颜良亲兵
							{npcID = 21420,	taskID = {1907}, index = 5}, --删除颜良亲兵
						},
					},
				},
			{type="openDialog", param={dialogID = 2028},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1908}},		--自动交接任务
			},
		},
	},

[1908] =
	{

		name = "返回白马城",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21414,	--任务结束npc
		preTaskData = {1907},	--任务前置任务没有填nil
		nextTaskID = 1909,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2029,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 422 , x = 106, y = 227, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="openDialog", param={dialogID = 2029},}, --在任务结束时打开一个对话框
				{type="deleteFollow", param = {npcs = {21401},}}, --在交任务状态删除关羽跟随
			},
		},
	},

[1909] =
	{

		name = "告捷汉献帝",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21421,	--任务结束npc
		preTaskData = {1907},	--任务前置任务没有填nil
		nextTaskID = 1909,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2031,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 131 , x = 20, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 422, x = 35, y = 205, tarMapID = 131, tarX = 57, tarY = 34},--创建私有传送阵
						},
					},
				},
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 21421,mapID = 131, x = 20, y = 34,dir = Direction. EastSouth,}, --创建汉献帝
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateTransfer",
					param={
						transfers =
						{
							{taskID = 1909, index = 1},--删除私有传送阵
						},
					},
				},
				{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 21414,	taskID = {1905}, index = 1}, --删除私有曹操
						},
					},
				},
				{type="openDialog", param={dialogID = 2031},}, --在任务结束时打开一个对话框
			},
		},
	},

[1910] =
	{

		name = "打探皇叔下落",	--任务名字
		startNpcID = 21421,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1909},	--任务前置任务没有填nil
		nextTaskID = 1911,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2033,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 131, x = 57, y = 34, tarMapID = 10, tarX = 45, tarY = 199},--创建私有传送阵
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="openDialog", param={dialogID = 2033},}, --在任务结束时打开一个对话框
			},
		},
	},

[1911] =
	{
		name = "寻找孙乾",	--任务名字
		startNpcID = 20049,	--任务起始npc22
		endNpcID = 21427,	--任务结束npc
		preTaskData = {1910},	--任务前置任务没有填nil
		nextTaskID = 1913,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2038,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 660,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2035,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 126, x = 201, y = 152}, --踩雷坐标
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
								[1] = {npcID = 21422,mapID = 126, x = 198, y = 152,dir = Direction. WestNorth,}, --创建王摩
								[2] = {npcID = 21423,mapID = 126, x = 201, y = 149,dir = Direction. EastNorth,}, --创建袁军兵士1
								[3] = {npcID = 21424,mapID = 126, x = 200, y = 155,dir = Direction. WestSouth,}, --创建袁军兵士2
								[4] = {npcID = 21425,mapID = 126, x = 204, y = 149,dir = Direction. North,}, --创建袁军兵士3
								[5] = {npcID = 21426,mapID = 126, x = 204, y = 153,dir = Direction. WestNorth,}, --创建袁军兵士4
								[6] = {npcID = 21427,mapID = 126, x = 201, y = 152,dir = Direction. WestNorth,}, --创建孙乾
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
							{npcID = 21422,	taskID = {1911}, index = 1}, --删除王摩
							{npcID = 21423,	taskID = {1911}, index = 2}, --删除袁军兵士
							{npcID = 21424,	taskID = {1911}, index = 3}, --删除袁军兵士
							{npcID = 21425,	taskID = {1911}, index = 4}, --删除袁军兵士
							{npcID = 21426,	taskID = {1911}, index = 5}, --删除袁军兵士
						},
					},
				},
				{type="deletePrivateTransfer",
					param={
						transfers =
						{
							{taskID = 1910, index = 1},--删除私有传送阵
						},
					},
				},
			{type="openDialog", param={dialogID = 2038},}, --在任务结束时打开一个对话框
			},
		},
	},

[1913] =
	{

		name = "返回许昌",	--任务名字
		startNpcID = 21427,	--任务起始npc
		endNpcID = 21401,	--任务结束npc
		preTaskData = {1911},	--任务前置任务没有填nil
		nextTaskID = 1914,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2040,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 420 , x = 135, y = 47, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 21401,mapID = 420, x = 135, y = 47,dir = Direction. EastSouth,}, --创建关羽
						},
					},
				},
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 109, x = 162, y = 223, tarMapID = 420, tarX = 30, tarY = 151},--创建私有传送阵
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
							{npcID = 21427,	taskID = {1911}, index = 6}, --删除孙乾
						},
					},
				},
				{type="openDialog", param={dialogID = 2040},}, --在任务结束时打开一个对话框
			},
		},
	},

[1914] =
	{
		name = "决意辞行",	--任务名字
		startNpcID = 21401,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1913},	--任务前置任务没有填nil
		nextTaskID = 1915,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 661,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2043,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 420, x = 152, y = 87}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
				},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="deletePrivateNpc",
					param={
						npcs =
						{
							{npcID = 21401,	taskID = {1913}, index = 1}, --删除关羽
						},
					},
				},
				{type="createFollow", param = {npcs = {21401},}},				--添加关羽跟随
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 21428,mapID = 420, x = 152, y = 87,dir = Direction. EastSouth,}, --创建曹操亲卫
								[2] = {npcID = 21429,mapID = 420, x = 149, y = 83,dir = Direction. EastSouth,}, --创建曹府士兵1
								[3] = {npcID = 21430,mapID = 420, x = 150, y = 85,dir = Direction. EastSouth,}, --创建曹府士兵2
								[4] = {npcID = 21431,mapID = 420, x = 150, y = 89,dir = Direction. EastSouth,}, --创建曹府士兵3
								[5] = {npcID = 21432,mapID = 420, x = 149, y = 94,dir = Direction. EastSouth,}, --创建曹府士兵4
								[6] = {npcID = 21433,mapID = 420, x = 127, y = 88,dir = Direction. EastSouth,}, --创建许褚
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
							{npcID = 21428,	taskID = {1913}, index = 1}, --删除曹操亲卫
							{npcID = 21429,	taskID = {1913}, index = 2}, --删除曹府士兵
							{npcID = 21430,	taskID = {1913}, index = 3}, --删除曹府士兵
							{npcID = 21431,	taskID = {1913}, index = 4}, --删除曹府士兵
							{npcID = 21432,	taskID = {1913}, index = 5}, --删除曹府士兵
						},
					},
				},
			{type="openDialog", param={dialogID = 2044},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1915}},		--自动交接任务
			},
		},
	},

[1915] =
	{
		name = "怒闯曹府",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = 21433,	--任务结束npc
		preTaskData = {1914},	--任务前置任务没有填nil
		nextTaskID = 1916,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 662,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2045,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 420, x = 127, y = 88}, --踩雷坐标
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
			{type="openDialog", param={dialogID = 2047},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1915}},		--自动交接任务
			},
		},
	},

[1916] =
	{
		name = "不辞而别",	--任务名字
		startNpcID = 21433,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1915},	--任务前置任务没有填nil
		nextTaskID = 1917,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 663,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2050,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 423, x = 116, y = 74}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
				},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 420, x = 216, y = 61, tarMapID = 423, tarX = 164, tarY = 10},--创建私有传送阵
						},
					},
				},
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 21434,mapID = 423, x = 116, y = 74,dir = Direction. South,}, --创建孔秀
								[2] = {npcID = 21435,mapID = 423, x = 110, y = 74,dir = Direction. South,}, --创建曹军兵士1
								[3] = {npcID = 21436,mapID = 423, x = 113, y = 74,dir = Direction. South,}, --创建曹军兵士2
								[4] = {npcID = 21437,mapID = 423, x = 116, y = 77,dir = Direction. South,}, --创建曹军兵士3
								[5] = {npcID = 21438,mapID = 423, x = 116, y = 80,dir = Direction. South,}, --创建曹军兵士4
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
							{npcID = 21434,	taskID = {1916}, index = 1}, --删除孔秀
							{npcID = 21435,	taskID = {1916}, index = 2}, --删除曹军兵士
							{npcID = 21436,	taskID = {1916}, index = 3}, --删除曹军兵士
							{npcID = 21437,	taskID = {1916}, index = 4}, --删除曹军兵士
							{npcID = 21438,	taskID = {1916}, index = 5}, --删除曹军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2052},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1917}},		--自动交接任务
			},
		},
	},

[1917] =
	{
		name = "遭遇阻拦",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1916},	--任务前置任务没有填nil
		nextTaskID = 1918,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 664,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2053,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 423, x = 44, y = 162}, --踩雷坐标
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
								[1] = {npcID = 21439,mapID = 423, x = 44, y = 162,dir = Direction. South,}, --创建孟坦
								[2] = {npcID = 21435,mapID = 423, x = 38, y = 160,dir = Direction. South,}, --创建曹军兵士1
								[3] = {npcID = 21436,mapID = 423, x = 41, y = 161,dir = Direction. South,}, --创建曹军兵士2
								[4] = {npcID = 21437,mapID = 423, x = 45, y = 165,dir = Direction. South,}, --创建曹军兵士3
								[5] = {npcID = 21438,mapID = 423, x = 46, y = 168,dir = Direction. South,}, --创建曹军兵士4
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
							{npcID = 21439,	taskID = {1917}, index = 1}, --删除孔秀
							{npcID = 21435,	taskID = {1917}, index = 2}, --删除曹军兵士
							{npcID = 21436,	taskID = {1917}, index = 3}, --删除曹军兵士
							{npcID = 21437,	taskID = {1917}, index = 4}, --删除曹军兵士
							{npcID = 21438,	taskID = {1917}, index = 5}, --删除曹军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2055},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1918}},		--自动交接任务
			},
		},
	},

[1918] =
	{
		name = "击杀韩福",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1917},	--任务前置任务没有填nil
		nextTaskID = 1919,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 665,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2056,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 423, x = 89, y = 217}, --踩雷坐标
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
								[1] = {npcID = 21440,mapID = 423, x = 89, y = 217,dir = Direction. WestNorth,}, --创建韩福
								[2] = {npcID = 21435,mapID = 423, x = 96, y = 212,dir = Direction. WestNorth,}, --创建曹军兵士1
								[3] = {npcID = 21436,mapID = 423, x = 92, y = 215,dir = Direction. WestNorth,}, --创建曹军兵士2
								[4] = {npcID = 21437,mapID = 423, x = 90, y = 220,dir = Direction. WestNorth,}, --创建曹军兵士3
								[5] = {npcID = 21438,mapID = 423, x = 91, y = 223,dir = Direction. WestNorth,}, --创建曹军兵士4
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
							{npcID = 21440,	taskID = {1918}, index = 1}, --删除韩福
							{npcID = 21435,	taskID = {1918}, index = 2}, --删除曹军兵士
							{npcID = 21436,	taskID = {1918}, index = 3}, --删除曹军兵士
							{npcID = 21437,	taskID = {1918}, index = 4}, --删除曹军兵士
							{npcID = 21438,	taskID = {1918}, index = 5}, --删除曹军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2058},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1919}},		--自动交接任务
			},
		},
	},
	
[1919] =
	{
		name = "刀斩卞喜",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1918},	--任务前置任务没有填nil
		nextTaskID = 1920,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 666,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2059,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 423, x = 130, y = 115}, --踩雷坐标
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
								[1] = {npcID = 21441,mapID = 423, x = 130, y = 115,dir = Direction. EastNorth,}, --创建卞喜
								[2] = {npcID = 21435,mapID = 423, x = 124, y = 111,dir = Direction. EastNorth,}, --创建曹军兵士1
								[3] = {npcID = 21436,mapID = 423, x = 127, y = 113,dir = Direction. EastNorth,}, --创建曹军兵士2
								[4] = {npcID = 21437,mapID = 423, x = 133, y = 113,dir = Direction. EastNorth,}, --创建曹军兵士3
								[5] = {npcID = 21438,mapID = 423, x = 136, y = 111,dir = Direction. EastNorth,}, --创建曹军兵士4
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
							{npcID = 21441,	taskID = {1919}, index = 1}, --删除卞喜
							{npcID = 21435,	taskID = {1919}, index = 2}, --删除曹军兵士
							{npcID = 21436,	taskID = {1919}, index = 3}, --删除曹军兵士
							{npcID = 21437,	taskID = {1919}, index = 4}, --删除曹军兵士
							{npcID = 21438,	taskID = {1919}, index = 5}, --删除曹军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2061},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1920}},		--自动交接任务
			},
		},
	},

[1920] =
	{
		name = "王植之死",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1919},	--任务前置任务没有填nil
		nextTaskID = 1921,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 667,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2062,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 423, x = 220, y = 78}, --踩雷坐标
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
								[1] = {npcID = 21442,mapID = 423, x = 220, y = 78,dir = Direction. West,}, --创建王植
								[2] = {npcID = 21435,mapID = 423, x = 226, y = 74,dir = Direction. West,}, --创建曹军兵士1
								[3] = {npcID = 21436,mapID = 423, x = 223, y = 76,dir = Direction. West,}, --创建曹军兵士2
								[4] = {npcID = 21437,mapID = 423, x = 219, y = 81,dir = Direction. West,}, --创建曹军兵士3
								[5] = {npcID = 21438,mapID = 423, x = 218, y = 84,dir = Direction. West,}, --创建曹军兵士4
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
							{npcID = 21442,	taskID = {1920}, index = 1}, --删除王植
							{npcID = 21435,	taskID = {1920}, index = 2}, --删除曹军兵士
							{npcID = 21436,	taskID = {1920}, index = 3}, --删除曹军兵士
							{npcID = 21437,	taskID = {1920}, index = 4}, --删除曹军兵士
							{npcID = 21438,	taskID = {1920}, index = 5}, --删除曹军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2064},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1921}},		--自动交接任务
			},
		},
	},

[1921] =
	{
		name = "临近河北",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1920},	--任务前置任务没有填nil
		nextTaskID = 1922,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
				{
				mineIndex = 1,		--第一个雷
				scriptID = 668,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2065,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 423, x = 172, y = 180}, --踩雷坐标
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
								[1] = {npcID = 21443,mapID = 423, x = 172, y = 180,dir = Direction. West,}, --创建秦琪
								[2] = {npcID = 21435,mapID = 423, x = 164, y = 184,dir = Direction. West,}, --创建曹军兵士1
								[3] = {npcID = 21436,mapID = 423, x = 168, y = 181,dir = Direction. West,}, --创建曹军兵士2
								[4] = {npcID = 21437,mapID = 423, x = 176, y = 181,dir = Direction. West,}, --创建曹军兵士3
								[5] = {npcID = 21438,mapID = 423, x = 180, y = 184,dir = Direction. West,}, --创建曹军兵士4
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
							{npcID = 21443,	taskID = {1921}, index = 1}, --删除秦琪
							{npcID = 21435,	taskID = {1921}, index = 2}, --删除曹军兵士
							{npcID = 21436,	taskID = {1921}, index = 3}, --删除曹军兵士
							{npcID = 21437,	taskID = {1921}, index = 4}, --删除曹军兵士
							{npcID = 21438,	taskID = {1921}, index = 5}, --删除曹军兵士
						},
					},
				},
			{type="openDialog", param={dialogID = 2067},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1922}},		--自动交接任务
			},
		},
	},

[1922] =
	{

		name = "过五关斩六将",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21401,	--任务结束npc
		preTaskData = {1921},	--任务前置任务没有填nil
		nextTaskID = 1923,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2069,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 126 , x = 52, y = 178, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateTransfer",
					param={
						transfers =
						{
							[1] = {mapID = 423, x = 111, y = 267, tarMapID = 126, tarX = 34, tarY = 191},--创建私有传送阵
						},
					},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateTransfer",
					param={
						transfers =
						{
							{taskID = 1913, index = 1},--删除私有传送阵
							{taskID = 1916, index = 1},--删除私有传送阵
							{taskID = 1922, index = 1},--删除私有传送阵
						},
					},
				},
				{type="openDialog", param={dialogID = 2069},}, --在任务结束时打开一个对话框
			},
		},
	},

[1923] =
	{
		name = "收服周仓",	--任务名字
		startNpcID = 21401,	--任务起始npc22
		endNpcID = 21444,	--任务结束npc
		preTaskData = {1922},	--任务前置任务没有填nil
		nextTaskID = 1924,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2072,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 25000,   --玩家经验
			[TaskRewardList.pet_xp] = 25000,      --宠物经验
			[TaskRewardList.subMoney] = 29000,    --绑银
			[TaskRewardList.player_pot] = 8700,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 669,
				lastMine = true,	--是否为最后一个雷
				dialogID = 2070,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
					{
						{npcID = 21444, x = 86, y = 151, noDelete = true},
						{npcID = 21445, x = 85, y = 149, noDelete = true},
						{npcID = 21446, x = 88, y = 152, noDelete = true},
						{npcID = 21447, x = 89, y = 146, noDelete = true},
						{npcID = 21448, x = 91, y = 148, noDelete = true},
					},
				posData = {mapID = 126, x = 86, y = 151}, --踩雷坐标
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
				{type="createPrivateNpc",
					param={
						npcs =
						{
							[1] = {npcID = 21444,mapID = 126, x = 86, y = 151,dir = Direction. North,},--周仓
						},
					},
				},			
			{type="openDialog", param={dialogID = 2072},}, --在任务结束时打开一个对话框
			},
		},
	},

[1924] =
	{

		name = "兄弟相认",	--任务名字
		startNpcID = 21444,	--任务起始npc
		endNpcID = 21554,	--任务结束npc
		preTaskData = {1923},	--任务前置任务没有填nil
		nextTaskID = 2001,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 2074,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 20000,   --玩家经验
			[TaskRewardList.pet_xp] = 20000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 126 , x = 132, y = 113, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=     ---接任务状态
			{
				{type="createPrivateNpc",
					param={
						npcs =
						{
							[1] = {npcID = 21554,mapID = 126, x = 132, y = 113,dir = Direction. North,},--张飞
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
							{npcID = 21444,	taskID = {1923}, index = 1}, --删除私有周仓
						},
					},
				},
				{type="openDialog", param={dialogID = 2074},}, --在任务结束时打开一个对话框
			},
		},
	},

---------------------------------主线任务49-50级任务--------------------------------------
[2001] =
         {              

		name = "打败逢纪",	--任务名字
		startNpcID = 21555,	--任务起始npc
		endNpcID = 21507,		--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = 2002,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2108,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --河北守将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 701,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2102,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21501, x = 191, y = 99,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21503, x = 194, y = 97,  noDelete = true},
					{npcID = 21504, x = 192, y = 101,  noDelete = true},
					{npcID = 21505, x = 196, y = 95,  noDelete = true},
					{npcID = 21506, x = 193, y = 103,  noDelete = true},
			},
			posData = {mapID = 126, x = 190, y = 98}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --河北将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 702,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2104,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21502, x = 149, y = 142,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21503, x = 146, y = 142,  noDelete = true},
					{npcID = 21504, x = 148, y = 145,  noDelete = true},
					{npcID = 21505, x = 144, y = 142,  noDelete = true},
					{npcID = 21506, x = 148, y = 147,  noDelete = true},
			},
			posData = {mapID = 126, x = 150, y = 141}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --逢纪
			{
			mineIndex = 3,		--第三个雷
			scriptID = 703,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2106,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21513, x = 99, y = 248,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21503, x = 98, y = 251,  noDelete = true},
					{npcID = 21504, x = 102, y = 247, noDelete = true},
					{npcID = 21505, x = 104, y = 247, noDelete = true},
					{npcID = 21506, x = 98, y = 253,  noDelete = true},
			},
			posData = {mapID = 126, x = 99, y = 248}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createFollow", param = {npcs = {21554},},},--创建张飞跟随
			},		
			[TaskStatus.Done]	=
			{
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21556, mapID = 126, x = 99, y = 248, dir = Direction.West,}, --逢纪
						},
					},
			},
		        {type="openDialog", param={dialogID = 2108},},
			},
		},
	},
[2002] =
         {              

		name = "营救刘备",	--任务名字
		startNpcID = 21556,	--任务起始npc
		endNpcID = 21514,		--任务结束npc
		preTaskData = {2001},	--任务前置任务没有填nil
		nextTaskID = 2003,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2113,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --邺城守将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 704,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2109,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21508, x = 179, y = 38,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 181, y = 40,  noDelete = true},
					{npcID = 21510, x = 177, y = 40,  noDelete = true},
					{npcID = 21511, x = 176, y = 43,  noDelete = true},
					{npcID = 21512, x = 181, y = 43,  noDelete = true},
			},
			posData = {mapID = 418, x = 179, y = 38}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --邺城将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 705,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2111,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 418, x = 177, y = 91}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 126, x = 51, y = 237, tarMapID = 418, tarX = 191, tarY = 10},--创建私有传送阵
							},
						},
			},
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21513, mapID = 418, x = 177, y = 91, dir = Direction.WestSouth,}, --田畴
							[2] = {npcID = 21509, mapID = 418, x = 179, y = 93, dir = Direction.WestSouth,}, --
							[3] = {npcID = 21510, mapID = 418, x = 174, y = 93, dir = Direction.WestSouth,}, --
							[4] = {npcID = 21511, mapID = 418, x = 179, y = 96, dir = Direction.WestSouth,}, --
							[5] = {npcID = 21512, mapID = 418, x = 173, y = 96, dir = Direction.WestSouth,}, --
							[6] = {npcID = 21514, mapID = 418, x = 176, y = 95, dir = Direction.WestSouth,}, --刘备
						},
					},
			},
						},		
			[TaskStatus.Done]=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2002, index = 1},--删除私有传送阵
							},
						},
				},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21513, taskID = {2002}, index = 1}, --删除逢纪
						[2] ={npcID = 21509, taskID = {2002}, index = 2}, --
						[3] ={npcID = 21510, taskID = {2002}, index = 3}, --
						[4] ={npcID = 21511, taskID = {2002}, index = 4}, --
						[5] ={npcID = 21512, taskID = {2002}, index = 5}, --
						[6] ={npcID = 21556, taskID = {2001}, index = 1}, --
					        },
				        },
                        },
		        {type="openDialog", param={dialogID = 2113},},
			},
		},
	},
[2003] =
         {              

		name = "护送刘备",	--任务名字
		startNpcID = 21514,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {2002},	--任务前置任务没有填nil
		nextTaskID = 2004,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2116,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --张颌
			{
			mineIndex = 1,		--第一个雷
			scriptID = 706,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2114,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21515, x = 168, y = 148,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 165, y = 148,  noDelete = true},
					{npcID = 21534, x = 168, y = 151,  noDelete = true},
			},
			posData = {mapID = 128, x = 168, y = 148}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createFollow", param = {npcs = {21514},},},--创建刘备跟随
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21514, taskID = {2002}, index = 1}, --删除逢纪
					        },
				        },
                        },
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 418, x = 232, y = 78, tarMapID = 128, tarX = 154, tarY = 89},--创建私有传送阵
							},
						},
			},
						},		
			[TaskStatus.Done]		=
			{
			{type="deleteFollow", param = {npcs = {21514,21554,21557},},},--删除刘备跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21514, mapID = 128, x = 166, y = 150, dir = Direction.South,}, --刘备
							[2] = {npcID = 21554, mapID = 128, x = 164, y = 150, dir = Direction.South,}, --张飞
							[3] = {npcID = 21557, mapID = 128, x = 166, y = 152, dir = Direction.South,}, --关羽
						},
					},
					},
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2003, index = 1},--删除私有传送阵
							},
						},
				},
		        {type="openDialog", param={dialogID = 2116},},
			},
		},
	},
[2004] =
	{
		name = "袁军内情",	--任务名字
		startNpcID = 21233,	--任务起始npc曹操
		endNpcID = nil,	--任务结束npc
		preTaskData = {2003}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 2005,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 2118,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] = 
				{
				},
				[TaskStatus.Done] =
					{
					{type="openDialog", param={dialogID = 2117},},
			},
	},
	},
[2005] =
         {              

		name = "前往邺城",	--任务名字
		startNpcID = 21514,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {2004},	--任务前置任务没有填nil
		nextTaskID = 2006,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2124,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --邺城守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 707,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2119,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21508, x = 221, y = 110,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 223, y = 112,  noDelete = true},
					{npcID = 21510, x = 218, y = 112,  noDelete = true},
					{npcID = 21511, x = 217, y = 115,  noDelete = true},
					{npcID = 21512, x = 223, y = 115,  noDelete = true},
			},
			posData = {mapID = 418, x = 221, y = 110}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --邺城将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 708,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2121,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21516, x = 191, y = 200,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 188, y = 200,  noDelete = true},
					{npcID = 21510, x = 191, y = 203,  noDelete = true},
					{npcID = 21511, x = 186, y = 200,  noDelete = true},
					{npcID = 21512, x = 191, y = 205,  noDelete = true},
			},
			posData = {mapID = 418, x = 191, y = 200}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --郭图
			{
			mineIndex = 3,		--第三个雷
			scriptID = 709,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2123,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21517, x = 123, y = 230,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 120, y = 232,  noDelete = true},
					{npcID = 21510, x = 126, y = 231,  noDelete = true},
					{npcID = 21511, x = 126, y = 235,  noDelete = true},
					{npcID = 21512, x = 120, y = 235,  noDelete = true},
			},
			posData = {mapID = 418, x = 123, y = 230}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 128, x = 138, y = 165, tarMapID = 418, tarX = 191, tarY = 10},--创建私有传送阵
							},
						},
			},
						},		
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2005, index = 1},--删除私有传送阵
							},
						},
				},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21514, taskID = {2004}, index = 1}, --删除刘备
						[2] ={npcID = 21554, taskID = {2004}, index = 2}, --
						[3] ={npcID = 21557, taskID = {2004}, index = 3}, 
					        },
				        },
                        },
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21558, mapID = 418, x = 123, y = 230, dir = Direction.WestSouth,}, --郭图
						},
					},
			},
		        {type="openDialog", param={dialogID = 2125},},
			},
		},
	},
[2006] =
         {              

		name = "邺城地监",	--任务名字
		startNpcID = 21558,	--任务起始npc
		endNpcID = 21521,		--任务结束npc
		preTaskData = {2005},	--任务前置任务没有填nil
		nextTaskID = 2007,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2133,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --邺城守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 710,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2127,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21518, x = 61, y = 181,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 59, y = 179,  noDelete = true},
					{npcID = 21510, x = 59, y = 183,  noDelete = true},
					{npcID = 21511, x = 56, y = 179,  noDelete = true},
					{npcID = 21512, x = 56, y = 183,  noDelete = true},
			},
			posData = {mapID = 418, x = 61, y = 181}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --邺城将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 711,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2129,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21519, x = 93, y = 149,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 94, y = 146,  noDelete = true},
					{npcID = 21510, x = 96, y = 149,  noDelete = true},
					{npcID = 21511, x = 95, y = 143,  noDelete = true},
					{npcID = 21512, x = 98, y = 150,  noDelete = true},
			},
			posData = {mapID = 418, x = 93, y = 149}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --高俦
			{
			mineIndex = 3,		--第三个雷
			scriptID = 712,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2131,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 418, x = 134, y = 151}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21520, mapID = 418, x = 134, y = 151, dir = Direction.West,}, --高俦
							[2] = {npcID = 21509, mapID = 418, x = 136, y = 149, dir = Direction.West,}, --
							[3] = {npcID = 21510, mapID = 418, x = 136, y = 153, dir = Direction.West,}, --
							[4] = {npcID = 21511, mapID = 418, x = 140, y = 149, dir = Direction.West,}, --
							[5] = {npcID = 21512, mapID = 418, x = 140, y = 153, dir = Direction.West,}, --
							[6] = {npcID = 21521, mapID = 418, x = 138, y = 151, dir = Direction.West,}, --许攸
						},
					},
			},
						},		
			[TaskStatus.Done]		=
			{
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21520, taskID = {2006}, index = 1}, --删除高俦
						[2] ={npcID = 21509, taskID = {2006}, index = 2}, --
						[3] ={npcID = 21510, taskID = {2006}, index = 3}, --
						[4] ={npcID = 21511, taskID = {2006}, index = 4}, --
						[5] ={npcID = 21512, taskID = {2006}, index = 5}, --
						[6] ={npcID = 21558, taskID = {2005}, index = 1}, --郭图
					        },
				        },
                        },
		        {type="openDialog", param={dialogID = 2133},},
			},
		},
	},
[2007] =
	{
		name = "逃出邺城",	--任务名字
		startNpcID = 21221,	--任务起始npc
		endNpcID = 21222,	--任务结束npc
		preTaskData = {2006}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 2008,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 2134,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 420, x = 123, y = 89, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] = 
				{
				{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21521, taskID = {2006}, index = 1}, --删除许攸
					        },
				        },
                        },
				{type="createFollow", param = {npcs = {21521},},},--创建许攸跟随
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 418, x = 178, y = 164, tarMapID = 420, tarX = 184, tarY = 25},--创建私有传送阵
							},
						},
			},
			       {type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21522, mapID = 420, x = 123, y = 89, dir = Direction.EastSouth,}, --曹操
						},
					},
			},
				},
				[TaskStatus.Done] =
					{
					{type="deleteFollow", param = {npcs = {21521},},},--删除许攸跟随
					{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21521, mapID = 420, x = 126, y = 89, dir = Direction.WestNorth,}, --许攸
						},
					},
			},
					{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2007, index = 1},--删除私有传送阵
							},
						},
				},
					{type="openDialog", param={dialogID = 2134},},
			},
	},
	},
[2008] =
         {              

		name = "前往乌巢",	--任务名字
		startNpcID = 21522,	--任务起始npc
		endNpcID = 21522,		--任务结束npc
		preTaskData = {2007},	--任务前置任务没有填nil
		nextTaskID = 2009,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2142,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --乌巢守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 713,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2136,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21523, x = 205, y = 154,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21525, x = 208, y = 155,  noDelete = true},
					{npcID = 21526, x = 202, y = 155,  noDelete = true},
					{npcID = 21527, x = 202, y = 158,  noDelete = true},
					{npcID = 21528, x = 208, y = 158,  noDelete = true},
			},
			posData = {mapID = 421, x = 205, y = 154}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --乌巢将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 714,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2138,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21524, x = 65, y = 128,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21525, x = 63, y = 127,  noDelete = true},
					{npcID = 21526, x = 66, y = 130,  noDelete = true},
					{npcID = 21527, x = 61, y = 127,  noDelete = true},
					{npcID = 21528, x = 66, y = 132,  noDelete = true},
			},
			posData = {mapID = 421, x = 65, y = 128}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --淳于琼
			{
			mineIndex = 3,		--第三个雷
			scriptID = 715,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2140,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21529, x = 121, y = 257,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21525, x = 123, y = 259,  noDelete = true},
					{npcID = 21526, x = 118, y = 259,  noDelete = true},
					{npcID = 21527, x = 123, y = 262,  noDelete = true},
					{npcID = 21528, x = 118, y = 262,  noDelete = true},
			},
			posData = {mapID = 421, x = 121, y = 257}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createFollow", param = {npcs = {21522},},},--创建曹操跟随
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21522, taskID = {2007}, index = 1}, --删除曹操
					        },
				        },
                        },
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 420, x = 119, y = 71, tarMapID = 421, tarX = 269, tarY = 108},--创建私有传送阵
							},
						},
			},
						},		
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2008, index = 1},--删除私有传送阵
							},
						},
				},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21521, taskID = {2007}, index = 1}, --删除许攸
					        },
				        },
                        },
			{type="deleteFollow", param = {npcs = {21522},},},--删除曹操跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21522, mapID = 421, x = 121, y = 257, dir = Direction.WestSouth,}, --曹操
						},
					},
			},
		        {type="openDialog", param={dialogID = 2142},},
			},
		},
	},
[2009] =
	{
		name = "督请夏侯惇",	--任务名字
		startNpcID = 21522,	--任务起始npc曹操
		endNpcID = 21530,	--任务结束npc
		preTaskData = {2008}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 2010,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 2144,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 128, x = 126, y = 123, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] = 
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 421, x = 143, y = 233, tarMapID = 128, tarX = 154, tarY = 91},--创建私有传送阵
							},
						},
			},
			       {type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21530, mapID = 128, x = 126, y = 123, dir = Direction.South,}, --夏侯惇
						},
					},
			},
				},
				[TaskStatus.Done] =
					{
					{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2009, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 2143},},
			},
	},
	},
[2010] =
         {              

		name = "擒住袁尚",	--任务名字
		startNpcID = 21514,	--任务起始npc
		endNpcID = 21537,		--任务结束npc
		preTaskData = {2009},	--任务前置任务没有填nil
		nextTaskID = 2011,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2151,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --袁军守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 716,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2145,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21531, x = 99, y = 156,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 96, y = 156,  noDelete = true},
					{npcID = 21534, x = 100, y = 159,  noDelete = true},
					{npcID = 21535, x = 100, y = 161,  noDelete = true},
					{npcID = 21536, x = 94, y = 156,  noDelete = true},
			},
			posData = {mapID = 128, x = 99, y = 156}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --袁军将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 717,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2147,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21532, x = 94, y = 286,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 91, y = 287,  noDelete = true},
					{npcID = 21534, x = 93, y = 289,  noDelete = true},
					{npcID = 21535, x = 89, y = 287,  noDelete = true},
					{npcID = 21536, x = 93, y = 291,  noDelete = true},
			},
			posData = {mapID = 128, x = 94, y = 286}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --袁尚
			{
			mineIndex = 3,		--第三个雷
			scriptID = 718,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2149,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21537, x = 37, y = 219,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 35, y = 216,  noDelete = true},
					{npcID = 21534, x = 35, y = 222,  noDelete = true},
					{npcID = 21535, x = 32, y = 216,  noDelete = true},
					{npcID = 21536, x = 32, y = 222,  noDelete = true},
			},
			posData = {mapID = 128, x = 37, y = 219}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
						},		
			[TaskStatus.Done]		=
			{
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21559, mapID = 128, x = 37, y = 219, dir = Direction.EastSouth,}, --袁尚
						},
					},
			},
		        {type="openDialog", param={dialogID = 2151},},
			},
		},
	},
[2011] =
         {              

		name = "斩杀杨森",	--任务名字
		startNpcID = 21559,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {2010},	--任务前置任务没有填nil
		nextTaskID = 2012,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2158,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --截教守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 719,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2152,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21538, x = 176, y = 177,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21540, x = 173, y = 178,  noDelete = true},
					{npcID = 21541, x = 175, y = 180,  noDelete = true},
					{npcID = 21542, x = 175, y = 182,  noDelete = true},
					{npcID = 21543, x = 171, y = 178,  noDelete = true},
			},
			posData = {mapID = 419, x = 176, y = 177}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --截教妖兽
			{
			mineIndex = 2,		--第二个雷
			scriptID = 720,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2154,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21539, x = 80, y = 267,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21540, x = 79, y = 269,  noDelete = true},
					{npcID = 21541, x = 79, y = 265,  noDelete = true},
					{npcID = 21542, x = 77, y = 264,  noDelete = true},
					{npcID = 21543, x = 77, y = 271,  noDelete = true},
			},
			posData = {mapID = 419, x = 80, y = 267}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --杨森
			{
			mineIndex = 3,		--第三个雷
			scriptID = 721,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2156,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21544, x = 43, y = 232,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21540, x = 42, y = 229,  noDelete = true},
					{npcID = 21541, x = 42, y = 235,  noDelete = true},
					{npcID = 21542, x = 39, y = 235,  noDelete = true},
					{npcID = 21543, x = 39, y = 229,  noDelete = true},
			},
			posData = {mapID = 419, x = 43, y = 232}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 128, x = 47, y = 257, tarMapID = 419, tarX = 236, tarY = 27},--创建私有传送阵
							},
						},
			},
						},		
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2011, index = 1},--删除私有传送阵
							},
						},
				},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21559, taskID = {2010}, index = 1}, --删除袁尚
					        },
				        },
                        },
		        {type="openDialog", param={dialogID = 2158},},
			},
		},
	},
[2012] =
	{
		name = "寻找夏侯惇",	--任务名字
		startNpcID = nil,	--任务起始npc曹操
		endNpcID = 21530,	--任务结束npc
		preTaskData = {2011}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 2013,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 2159,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 128, x = 126, y = 123, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] = 
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 419, x = 94, y = 211, tarMapID = 128, tarX = 154, tarY = 91},--创建私有传送阵
							},
						},
			},
				},
				[TaskStatus.Done] =
					{
					{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2012, index = 1},--删除私有传送阵
							},
						},
				},
					{type="openDialog", param={dialogID = 2159},},
			},
	},
	},
[2013] =
         {              

		name = "除掉高览",	--任务名字
		startNpcID = 21559,	--任务起始npc
		endNpcID = 21530,		--任务结束npc
		preTaskData = {2010},	--任务前置任务没有填nil
		nextTaskID = 2012,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2164,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --麴义
			{
			mineIndex = 1,		--第一个雷
			scriptID = 722,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2160,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21545, x = 185, y = 183,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 185, y = 180,  noDelete = true},
					{npcID = 21534, x = 188, y = 183,  noDelete = true},
					{npcID = 21535, x = 185, y = 178,  noDelete = true},
					{npcID = 21536, x = 190, y = 183,  noDelete = true},
			},
			posData = {mapID = 128, x = 185, y = 183}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --高览
			{
			mineIndex = 2,		--第二个雷
			scriptID = 723,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2162,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21546, x = 263, y = 79,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 266, y = 77,  noDelete = true},
					{npcID = 21534, x = 265, y = 81,  noDelete = true},
					{npcID = 21535, x = 266, y = 93,  noDelete = true},
					{npcID = 21536, x = 268, y = 75,  noDelete = true},
			},
			posData = {mapID = 128, x = 263, y = 79}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21530, taskID = {2009}, index = 1}, --删除夏侯淳
					        },
				        },
                        },
			{type="createFollow", param = {npcs = {21530},},},--创建夏侯淳跟随
						},		
			[TaskStatus.Done]		=
			{
			{type="deleteFollow", param = {npcs = {21530},},},--删除夏侯淳跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21530, mapID = 128, x = 263, y = 79, dir = Direction.West,}, --夏侯淳
						},
					},
			},
		        {type="openDialog", param={dialogID = 2164},},
			},
		},
	},
[2014] =
         {              

		name = "击杀高干",	--任务名字
		startNpcID = 21530,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {2013},	--任务前置任务没有填nil
		nextTaskID = 2015,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2171,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --冀州守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 724,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2165,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21547, x = 94, y = 218,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 92, y = 216,  noDelete = true},
					{npcID = 21510, x = 92, y = 221,  noDelete = true},
					{npcID = 21511, x = 89, y = 222,  noDelete = true},
					{npcID = 21512, x = 89, y = 216,  noDelete = true},
			},
			posData = {mapID = 418, x = 94, y = 218}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --冀州将领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 725,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 2167,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21548, x = 100, y = 125,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 102, y = 124,  noDelete = true},
					{npcID = 21510, x = 98, y = 124,  noDelete = true},
					{npcID = 21511, x = 97, y = 122,  noDelete = true},
					{npcID = 21512, x = 103, y = 122,  noDelete = true},
			},
			posData = {mapID = 418, x = 100, y = 125}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --高干
			{
			mineIndex = 3,		--第三个雷
			scriptID = 726,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2169,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21555, x = 170, y = 83,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21509, x = 171, y = 85,  noDelete = true},
					{npcID = 21510, x = 171, y = 80,  noDelete = true},
					{npcID = 21511, x = 174, y = 79,  noDelete = true},
					{npcID = 21512, x = 173, y = 86,  noDelete = true},
			},
			posData = {mapID = 418, x = 170, y = 83}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 128, x = 213, y = 48, tarMapID = 418, tarX = 186, tarY = 180},--创建私有传送阵
							},
						},
			},
						},		
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 2014, index = 1},--删除私有传送阵
							},
						},
				},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21530, taskID = {2013}, index = 1}, --删除夏侯淳
					        },
				        },
                        },
		        {type="openDialog", param={dialogID = 2171},},
			},
		},
	},
[2015] =
         {              

		name = "生擒袁熙",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21560,		--任务结束npc
		preTaskData = {2014},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =2174,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 33000,    --绑银
                [TaskRewardList.player_pot] = 9900,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --冀州守卫
			{
			mineIndex = 1,		--第一个雷
			scriptID = 727,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 2172,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21553, x = 135, y = 152,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21533, x = 136, y = 149,  noDelete = true},
					{npcID = 21534, x = 136, y = 154,  noDelete = true},
					{npcID = 21535, x = 138, y = 149,  noDelete = true},
					{npcID = 21536, x = 138, y = 154,  noDelete = true},
			},
			posData = {mapID = 418, x = 135, y = 152}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
						},		
			[TaskStatus.Done]		=
			{
		        {type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21560, mapID = 418, x = 135, y = 152, dir = Direction.west,}, --袁熙
						},
					},
			},
		        {type="openDialog", param={dialogID = 2174},},
			},
		},
	},
}

table.copy(MainTaskDB46_50, NormalTaskDB)