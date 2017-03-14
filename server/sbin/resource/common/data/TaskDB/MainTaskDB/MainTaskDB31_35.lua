--[[MainTaskDB31_35.lua
	任务配置31到35级(任务系统)
]]

MainTaskDB31_35 =
{
-----------31-32主线任务-----------
	[1151] ={                  --[[查探孙坚下落--]]

		name = "查探孙坚下落",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20601,		--任务结束npc
		preTaskData = {1118},	--任务前置任务没有填nil
		nextTaskID = 1152,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1104,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 30000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 30000,    --绑银
			[TaskRewardList.player_pot] = 9000,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --吴明
			{
			mineIndex = 1,		--第一个雷
			scriptID = 175,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1102,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			{npcID = 20601, x = 142, y = 191, noDelete = true},
			{npcID = 20603, x = 145, y = 189, noDelete = true},
			{npcID = 20603, x = 145, y = 193, noDelete = true},
			},
			posData = {mapID = 110, x = 142, y = 191}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20601, mapID = 110, x = 142, y = 191, dir = Direction. North,}, --吴明
						},
					},
			},
			{type="openDialog", param={dialogID = 1105},},
			{type="finishTask", param = {recetiveTaskID = 1152}},
		        },
		},
	},
	[1152] =
	{

		name = "救下孙坚",	--任务名字
		startNpcID = 20601,	--任务起始npc
		endNpcID = 20625,		--任务结束npc
		preTaskData = {1151},	--任务前置任务没有填nil
		nextTaskID = 1153,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1109,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		    	[TaskRewardList.player_xp] = 30000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --杨定
			{
			mineIndex = 1,		--第一个雷
			scriptID = 176,
			lastMine = true,	--是否为最后一个雷
			dialogID = 1106,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 110, x = 201, y = 109}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
			
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20602, mapID = 110, x = 201, y = 109, dir = Direction. WestSouth,}, --创建杨定
							[2] = {npcID = 20625, mapID = 110, x = 200, y = 107, dir = Direction. EastNorth,}, --创建孙坚
							[3] = {npcID = 20604, mapID = 110, x = 198, y = 108, dir = Direction. EastSouth,}, --创建潼关隘口守卫1
							[4] = {npcID = 20629, mapID = 110, x = 199, y = 105, dir = Direction. East,}, --创建潼关隘口守卫2
							[5] = {npcID = 20630, mapID = 110, x = 202, y = 105, dir = Direction. North,}, --创建潼关隘口守卫3
							[6] = {npcID = 20631, mapID = 110, x = 202, y = 108, dir = Direction. West,}, --创建潼关隘口守卫4

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
							{npcID = 20601, taskID = {1151}, index = 1}, --删除吴明
							{npcID = 20602, taskID = {1152}, index = 1}, --删除杨定
							{npcID = 20604, taskID = {1152}, index = 3}, --删除小怪
							{npcID = 20629, taskID = {1152}, index = 4}, --删除小怪
							{npcID = 20630, taskID = {1152}, index = 5}, --删除小怪
							{npcID = 20631, taskID = {1152}, index = 6}, --删除小怪
						},
					},
				},
				{type="openDialog", param={dialogID = 1108},},
			},
		},
	},

	[1153] =
	{
		name = "真假孙坚",	--任务名字
		startNpcID = 20625,	--任务起始npc孙坚
		endNpcID = 20606,	--任务结束npc祖茂
		preTaskData = {1152}, --前置任务ID
		nextTaskID = 1154,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1110,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 110 , x = 200, y = 111, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20625, taskID = {1152}, index = 1}, --删除孙坚
						},
					},
				},
				{type="createPrivateNpc",
				param={
						npcs =
						{
						[1] = {npcID = 20606, mapID = 110, x = 200, y = 107, dir = Direction. EastNorth,}, --创建祖茂
						},
					},
				},
				},
				[TaskStatus.Done] =
				{
				{type="openDialog", param={dialogID = 1110},},
				},
			},
	},
	[1154] =
	{
		name = "救人于水火",	--任务名字
		startNpcID = 20606,	--任务起始npc
		endNpcID = 20641,		--任务结束npc
		preTaskData = {1153},	--任务前置任务没有填nil
		nextTaskID = 1155,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1114,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		    	[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --徐荣
			{
			mineIndex = 1,		--第三个雷
			scriptID = 177,
			lastMine = true,	--是否为最后一个雷
			dialogID = 1112,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{},
			posData = {mapID = 110, x = 168, y = 98}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
		},	
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
						[1] = {npcID = 20605, mapID = 110, x = 168, y = 98, dir = Direction. EastSouth,}, --徐荣
						[2] = {npcID = 20641, mapID = 110, x = 166, y = 101, dir = Direction. EastSouth,}, --孙坚
						[3] = {npcID = 20632, mapID = 110, x = 164, y = 99, dir = Direction. East,}, --小怪1
						[4] = {npcID = 20633, mapID = 110, x = 162, y = 102, dir = Direction. EastSouth,}, --小怪2
						[5] = {npcID = 20634, mapID = 110, x = 165, y = 105, dir = Direction. WestSouth,}, --小怪3
						[6] = {npcID = 20635, mapID = 110, x = 169, y = 101, dir = Direction. WestNorth,}, --小怪4
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
							{npcID = 20605, taskID = {1154}, index = 1}, --删除徐荣
							{npcID = 20606, taskID = {1153}, index = 1}, --删除祖茂
							{npcID = 20632, taskID = {1154}, index = 3}, --删除小怪1
							{npcID = 20633, taskID = {1154}, index = 4}, --删除小怪2
							{npcID = 20634, taskID = {1154}, index = 5}, --删除小怪3
							{npcID = 20635, taskID = {1154}, index = 6}, --删除小怪4
						},
					},
			},
			{type="openDialog", param={dialogID = 1114},},
			{type="finishTask", param = {recetiveTaskID = 1155}},
			},
		},
	},
	[1155] =
	{
		name = "营救朱治吴景",	--任务名字
		startNpcID = 20641,	--任务起始npc
		endNpcID = 20607,		--任务结束npc
		preTaskData = {1154},	--任务前置任务没有填nil
		nextTaskID = 1156,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1119,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
            [1] = {type='Tmine',param =     --周恒
			{
			    mineIndex = 1,		--第二个雷
			    scriptID = 178,
			    lastMine = true,	--是否为最后一个雷
			    dialogID = 1117,        --动作结束打开的对话框
			    npcsData =			--刷出npc数据
			{
			        {npcID = 20609, x = 136, y =121, noDelete = true},
			        {npcID = 20604, x = 134, y =118, noDelete = true},
				{npcID = 20604, x = 134, y =124, noDelete = true},
			        {npcID = 20604, x = 131, y =119, noDelete = true},
				{npcID = 20604, x = 131, y =123, noDelete = true},
			 },
			    posData = {mapID = 110, x = 137, y = 119}, --踩雷坐标
			    bor = true,	--如果为true则完成此目标任务直接完成
			},
		},	
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20607, mapID = 110, x = 132, y = 121, dir = Direction. EastSouth,}, --朱治
							[2] = {npcID = 20608, mapID = 110, x = 130, y = 121, dir = Direction. EastSouth,}, --吴景
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
							{npcID = 20641, taskID = {1154}, index = 1}, --删除孙坚
						},
					},
			},
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20646, mapID = 110, x = 169, y = 94, dir = Direction. EastSouth,}, --创建孙坚
						},
					},
			},
			{type="autoTrace", param = {tarMapID=110, x =135, y = 121,npcID = 20607,},}, --自动寻路到朱治身边
			{type="openDialog", param={dialogID = 1119},},
			{type="finishTask", param = {recetiveTaskID = 1156}},
			},
		},
	},
	[1156] =
	{
		name = "回禀孙坚",	--任务名字
		startNpcID = 20607,	--任务起始npc孙坚
		endNpcID = 20646,	--任务结束npc祖茂
		preTaskData = {1155}, --前置任务ID
		nextTaskID = 1157,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1121,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 110 , x = 169, y = 94, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="openDialog", param={dialogID = 1120},},
				},
			},
	},
	[1157] =
	{
		name = "探寻黄盖",	--任务名字
		startNpcID = 20646,	--任务起始npc
		endNpcID = 20610,		--任务结束npc
		preTaskData = {1155},	--任务前置任务没有填nil
		nextTaskID = 1157,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1124,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				scriptID = 179 ,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1122,
				npcsData =			--刷出npc数据
				{
					{npcID = 20610, x = 97, y = 123, noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20611, x = 96, y = 120, noDelete = true},
					{npcID = 20611, x = 96, y = 126, noDelete = true},
					{npcID = 20611, x = 94, y = 122, noDelete = true},
					{npcID = 20611, x = 94, y = 125, noDelete = true},
				},
				posData = {mapID = 110, x = 97, y = 123}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20607, taskID = {1155}, index = 1}, --删除朱治
							{npcID = 20608, taskID = {1155}, index = 2}, --删除吴景
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
							{npcID = 20646, taskID = {1155}, index = 1}, --删除孙坚
						},
					},
			},
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20610, mapID = 110, x = 97, y = 123, dir = Direction. EastSouth,}, --伍习
						},
					},
			},
			 {type="openDialog", param={dialogID = 1124},},
			 {type="finishTask", param = {recetiveTaskID = 1158}},
		},
	},
	},
	[1158] =
	{

		name = "营救黄盖",	--任务名字
		startNpcID = 20610,	--任务起始npc
		endNpcID = 20626,		--任务结束npc
		preTaskData = {1156},	--任务前置任务没有填nil
		nextTaskID = 1158,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1130,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 180,
				dialogID = 1126,
				npcsData =			--刷出npc数据
				{
					{npcID = 20612, x = 82, y = 129, actionID = 5, magicID = 1004, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20603, x = 81, y = 125, actionID = 5, magicID = 1004, noDelete = true},
					{npcID = 20603, x = 81, y = 133, actionID = 5, magicID = 1004, noDelete = true},
					{npcID = 20603, x = 79, y = 127, actionID = 5, magicID = 1004, noDelete = true},
					{npcID = 20603, x = 79, y = 131, actionID = 5, magicID = 1004, noDelete = true},
				},
				posData	= {mapID = 110,	x = 82, y = 129}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第2个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 181,
				dialogID = 1128,
				npcsData =			--刷出npc数据
				{
				},
				posData	= {mapID = 110,	x = 27, y = 162}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20613, mapID = 110, x = 26, y = 166, dir = Direction. South,}, --梁兴
							[2] = {npcID = 20626, mapID = 110, x = 24, y = 164, dir = Direction. EastSouth,}, --黄盖
							[3] = {npcID = 20614, mapID = 110, x = 24, y = 162, dir = Direction. EastNorth,}, --黄盖看守
							[4] = {npcID = 20638, mapID = 110, x = 23, y = 168, dir = Direction. WestSouth,}, --黄盖看守
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
							{npcID = 20613, taskID = {1157}, index = 1}, --删除梁兴
							{npcID = 20614, taskID = {1157}, index = 3}, --删除黄盖看守
							{npcID = 20638, taskID = {1157}, index = 4}, --删除黄盖看守
						},
					},
				},
			{type="autoTrace", param = {tarMapID=110, x =24, y = 164,npcID = 20626,},}, --自动寻路到黄盖身边
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20610, taskID = {1156}, index = 1}, --删除伍习
						},
					},
				},
			{type="openDialog", param={dialogID = 1130},}, --打开一个对话框
			},
		},
	},
	[1159] =
	{

		name = "妖兵之谜",	--任务名字
		startNpcID = 20626,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1158},	--任务前置任务没有填nil
		nextTaskID = 1160,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1136,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TautoMeet',param = {mapID = 110 , x = 201, y = 110, bor =	false},},
		[2] = {type='Tscript',param = {scriptID	= 182 ,	count =	1, bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createMine",
				param =
				{
				{mapID = 110, scriptID = {182,},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
				}
			},
			},
			[TaskStatus.Done]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20615, mapID = 110, x = 201, y = 110, dir = Direction. WestSouth,}, --张济
						},
					},
			},
			 {type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			 {type = "removeMine", param = {}}, -- 移除任务类
			{type="openDialog", param={dialogID = 1137},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1160}},
			},
		},
	},
	[1160] =
	{

		name = "护阵大将",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1159},	--任务前置任务没有填nil
		nextTaskID = 1161,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 183,
				dialogID = 1138,
				npcsData =			--刷出npc数据
				{
				},
				posData	= {mapID = 110,	x = 207, y = 60}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20617, mapID = 110, x = 207, y = 60, dir = Direction. North,}, --张横
							[2] = {npcID = 20618, mapID = 110, x = 205, y = 58, dir = Direction. North,}, --妖阵守将1
							[3] = {npcID = 20637, mapID = 110, x = 209, y = 58, dir = Direction. North,}, --妖阵守将2
						},
					},
			},
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 110, x = 177, y = 39, tarMapID = 111, tarX = 53, tarY = 17},--创建私有传送阵
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
							{npcID = 20617, taskID = {1160}, index = 1}, --删除张横
							{npcID = 20618, taskID = {1160}, index = 2}, --删除妖阵守将1
							{npcID = 20637, taskID = {1160}, index = 3}, --删除妖阵守将2
							{npcID = 20626, taskID = {1158}, index = 2}, --删除黄盖
							{npcID = 20615, taskID = {1159}, index = 1}, --删除张济
					},
			},
			},
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20640, mapID = 110, x = 207, y = 60, dir = Direction. EastSouth,}, --创建张横
						},
					},
			},
			{type="openDialog", param={dialogID = 1140},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1161}},
			},
		},
	},
	[1161] =
	{

		name = "探查妖阵",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1160},	--任务前置任务没有填nil2016/10/31
		nextTaskID = 1162,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		     [1] = {type='Tmine',param =     --吕岳幻像
			{
			    mineIndex = 1,		--第一个雷
			    scriptID = 184,
			    lastMine = true,	--是否为最后一个雷
			    dialogID = 1142,        --动作结束打开的对话框
			    npcsData =			--刷出npc数据
			{
			 },
			    posData = {mapID = 111, x = 34, y = 32}, --踩雷坐标
			    bor = true,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20619, mapID = 111, x = 34, y = 32, dir = Direction. West,}, --创建吕岳（幻像）
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
						{npcID = 20619, taskID = {1161}, index = 1}, --删除吕岳幻像
						{npcID = 20640, taskID = {1160}, index = 1}, --删除张横
					},
					},
				},
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1160, index = 1},--删除私有传送阵
							},
						},
				},
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 111, x = 53, y = 17, tarMapID = 8, tarX = 148, tarY = 81},--创建私有传送阵
							},
						},
			},
			{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20639, mapID = 111, x = 34, y = 32, dir = Direction. West,}, --创建吕岳（幻像）
						},
					},
			},
			{type="openDialog", param={dialogID = 1144},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1162}},
			},
		},
	},		
	[1162] =
	{

		name = "求助天尊",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1161},	--任务前置任务没有填nil
		nextTaskID = 1163,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1146,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1161, index = 1},--删除私有传送阵
							},
						},
				},
			{type="openDialog", param={dialogID = 1146},},
			},
		},
	},
	[1163] =
	{

		name = "破阵之法",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1162},	--任务前置任务没有填nil
		nextTaskID = 1164,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1149,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 31000,    --绑银
			[TaskRewardList.player_pot] = 9300,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 8 , x = 148, y = 75, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1149},},
			},
	},
	},
   [1164] =
	{

		name = "金缠之魂",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1163},	--任务前置任务没有填nil
		nextTaskID = 1165,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			 [1] = {type='Tmine',param =     --金缠
			{
			    mineIndex = 1,		--第一个雷
			    scriptID = 185,
			    lastMine = true,	--是否为最后一个雷
			    dialogID = 1153,        --动作结束打开的对话框
			    npcsData =			--刷出npc数据
			{
				{npcID = 20620, x = 210, y = 71, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
			 },
			    posData = {mapID = 106, x = 210, y = 71}, --踩雷坐标
			    bor = true,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="getItem", param = {itemID = 1041018, count = 1,}},
			{type="openDialog", param={dialogID = 1155},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID =1165}},
			},
		},
	}, 
   [1165] =
	{

		name = "烬枝之魂",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1164},	--任务前置任务没有填nil
		nextTaskID = 1166,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TautoMeet',param = {mapID = 106 , x = 131, y = 231, bor =	false},},
		[2] = {type='Tscript',param = {scriptID	= 186 ,	count =	1, bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createMine",
				param =
				{
				{mapID = 106, scriptID = {186,},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
				}
			},
			},
			[TaskStatus.Done]		=
			{
			{type="getItem", param = {itemID = 1041019, count = 1,}},
			 {type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			 {type = "removeMine", param = {}}, -- 移除任务类
			{type="openDialog", param={dialogID = 1159},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID =1166}},
			},
		},
	}, 
	   [1166] =
	{

		name = "火魁之魂",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1165},	--任务前置任务没有填nil
		nextTaskID = 1167,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			 [1] = {type='Tmine',param =     --火魁
			{
			    mineIndex = 1,		--第一个雷
			    scriptID = 187,
			    lastMine = true,	--是否为最后一个雷
			    dialogID = 1160,        --动作结束打开的对话框
			    npcsData =			--刷出npc数据
			{
				{npcID = 20622, x = 169, y = 159, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
			 },
			    posData = {mapID = 107, x = 169, y = 159}, --踩雷坐标
			    bor = true,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="getItem", param = {itemID = 1041020, count = 1,}},
			{type="openDialog", param={dialogID = 1162},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID =1167}},
			},
		},
	}, 
	[1167] =
	{

		name = "天禄之魂",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1166},	--任务前置任务没有填nil
		nextTaskID = 1168,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			 [1] = {type='Tmine',param =     --天禄
			{
			    mineIndex = 1,		--第一个雷
			    scriptID = 188,
			    lastMine = true,	--是否为最后一个雷
			    dialogID = 1163,        --动作结束打开的对话框
			    npcsData =			--刷出npc数据
			{
				{npcID = 20623, x = 241, y = 91, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
			 },
			    posData = {mapID = 109, x = 241, y = 91}, --踩雷坐标
			    bor = true,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="getItem", param = {itemID = 1041021, count = 1,}},
			{type="openDialog", param={dialogID = 1165},}, --打开一个对话框
			{type="finishTask", param = {recetiveTaskID =1168}},
			},
		},
	}, 
	[1168] =
	{
		name = "灭魂珠",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20003,	--任务结束npc
		preTaskData = {1167}, --前置任务ID
		nextTaskID = 1169,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1168,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		--[1] = {type='Tarea',param = {mapID = 8 , x = 148, y = 75, bor = true},},-------到达指定坐标
		[1] = {type = "TcommitItem", param = {taskID = 1168,itemsInfo = {{itemID = 1041018, count = 1},{itemID = 1041019, count = 1},{itemID = 1041020, count = 1},{itemID = 1041021, count = 1}} ,bor = true},}

		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				{type="CreateIntemDirect",param = {taskID = 1168,itemsInfo = {{itemID = 1041018, count = 1},{itemID = 1041019, count = 1},{itemID = 1041020, count = 1},{itemID = 1041021, count = 1}}}},
				},
				[TaskStatus.Done] =
				{
				{type="getItem", param = {itemID = 1041022, count = 1,}},
				{type="openDialog", param={dialogID = 1167},},
				},
			},
	},
	[1169] =
	{
		name = "破除妖阵",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20619,	--任务结束npc
		preTaskData = {1168}, --前置任务ID
		nextTaskID = 1170,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1173,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 111 , x = 30, y = 32, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
					{type="doSwithScene", param = {tarMapID = 110,	x = 200, y = 111,}},	--传送到另一个场景
					{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 110, x = 177, y = 39, tarMapID = 111, tarX = 53, tarY = 17},--创建私有传送阵
							},
						},
			},
				},
				[TaskStatus.Done] =
				{
				{type="openDialog", param={dialogID = 1172},},
				},
			},
	},
	[1170] =
	{
		name = "战吕岳",	--任务名字
		startNpcID = 20619,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1169}, --前置任务ID
		nextTaskID = 1171,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = nil,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =
		{
		},
		targets =
			{
			[1]={type='Tscript',param = {scriptID	= 189 ,	count =	1,bor = true},},
			},
		triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				{type="openDialog", param={dialogID = 1174},},
				{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20624, mapID = 111, x = 34, y = 32, dir = Direction. WestNorth,}, --吕岳
						},
					},
				},
				{type="deletePrivateNpc",
				param={
					npcs =
					{
						{npcID = 20639, taskID = {1161}, index = 1}, --删除吕岳幻像
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
								{taskID = 1169, index = 1},--删除私有传送阵
							},
						},
				},
				{type="deletePrivateNpc",
				param={
					npcs =
					{
						{npcID = 20624, taskID = {1169}, index = 1}, --删除吕岳
					},
					},
				},
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 111, x = 53, y = 17, tarMapID = 110, tarX = 183, tarY = 50},--创建私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1176},},
				{type="finishTask", param = {recetiveTaskID =1171}},
				},
			},
	},
	[1171] =
	{
		name = "禀告黄盖",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20627,	--任务结束npc
		preTaskData = {1170}, --前置任务ID
		nextTaskID = 1172,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1178,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 110 , x = 169, y = 94, bor = false},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{	
				{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20627, mapID = 110, x = 169, y = 94, dir = Direction. EastSouth,}, --创建黄盖
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
								{taskID = 1170, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1177},},
				},
			},
	},
	[1172] =
	{
		name = "铲除徐荣",	--任务名字
		startNpcID = 20627,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1171}, --前置任务ID
		nextTaskID = 1173,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = nil,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tmine',param =     --徐荣
			{
			    mineIndex = 1,		--第一个雷
			    scriptID = 190,
			    lastMine = true,	--是否为最后一个雷
			    dialogID = 1181,        --动作结束打开的对话框
			    npcsData =			--刷出npc数据
			{
			},
			    posData = {mapID = 110, x = 56, y = 198}, --踩雷坐标
			    bor = true,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				{type="createPrivateNpc",
				param={
						npcs =
						{
							[1] = {npcID = 20605, mapID = 110, x = 56, y = 198, dir = Direction. WestSouth,}, --徐荣
							[2] = {npcID = 20642, mapID = 110, x = 59, y = 197, dir = Direction. WestSouth,}, --妖阵精兵1
							[3] = {npcID = 20643, mapID = 110, x = 53, y = 197, dir = Direction. WestSouth,}, --妖阵精兵2
							[4] = {npcID = 20644, mapID = 110, x = 57, y = 200, dir = Direction. WestSouth,}, --妖阵守将1
							[5] = {npcID = 20645, mapID = 110, x = 54, y = 200, dir = Direction. WestSouth,}, --妖阵守将2
						},
					},
			},
				},
				[TaskStatus.Done] =
				{
				{type="deletePrivateNpc",
				param={
					npcs =
					{
						{npcID = 20605, taskID = {1172}, index = 1}, --删除徐荣
						{npcID = 20642, taskID = {1172}, index = 2}, --删除妖阵精兵1
						{npcID = 20643, taskID = {1172}, index = 3}, --删除妖阵精兵2
						{npcID = 20644, taskID = {1172}, index = 4}, --删除妖阵守将1
						{npcID = 20645, taskID = {1172}, index = 5}, --删除妖阵守将2
					},
					},
				},
				{type="finishTask", param = {recetiveTaskID =1173}},
				},
			},
	},
	[1173] =
	{

		name = "回禀黄盖",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20627,		--任务结束npc
		preTaskData = {1172},	--任务前置任务没有填nil
		nextTaskID = 1174,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1183,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 110 , x = 169, y = 94, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
			{
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1164, index = 1},--删除私有传送阵
							},
						},
				},
			{type="autoTrace", param = {tarMapID=110, x = 169, y = 94,npcID = 20627,},},  --自动寻路到黄盖身边
			},
		[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1183},}, --打开一个对话框
			},
		},
		},
	[1174] =
	{
		name = "转告卢植",	--任务名字
		startNpcID = 20627,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1171},	--任务前置任务没有填nil
		nextTaskID = 1200,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1187,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 32000,    --绑银
			[TaskRewardList.player_pot] = 9600,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
			{
			},
		[TaskStatus.Done]		=
			{
			{type="deletePrivateNpc",
			param={
			        npcs =
					{
					   {npcID = 20627, taskID = {1171}, index = 1}, --黄盖
					},
					},
				},
			{type="openDialog", param={dialogID = 1187},}, --打开一个对话框
			},
		},
		},


---------------------------------主线任务33-35级任务--------------------------------------
[1200] =
	{
		name = "对话王允",	--任务名字
		startNpcID = 20049,	--任务起始npc卢植
		endNpcID = 20701,	--任务结束npc
		preTaskData = {1174}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 1201,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1201,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 13, x = 55, y = 141, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] = nil,
				{
				},
				[TaskStatus.Done] =
					{
						{type="openDialog", param={dialogID = 1201},},
						
			},
	},
	},
[1201] =
         {                  --[[除掉耳线--]]

		name = "除掉耳线",	--任务名字
		startNpcID = 20701,	--任务起始npc
		endNpcID = 20701,		--任务结束npc
		preTaskData = {1200},	--任务前置任务没有填nil
		nextTaskID = 1202,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1205,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --李肃
			{
			mineIndex = 1,		--第一个雷
			scriptID = 200,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1203,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 20704, x = 54, y = 98,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20737, x = 52, y = 97,  noDelete = true},
					{npcID = 20739, x = 56, y = 97,  noDelete = true},
					{npcID = 20736, x = 52, y = 95,  noDelete = true},
					{npcID = 20738, x = 56, y = 95,  noDelete = true},
			},
			posData = {mapID = 13, x = 54, y = 99}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
		        [TaskStatus.Active] = 
			{ 
				},
			[TaskStatus.Done] =
			{
			{type="autoTrace", param = {tarMapID=13, x =55, y = 141,npcID = 20701,},}, --自动寻路到王允身边
		        },
		},
	},
[1202] =
         {                  --[[大战王昭--]]

		name = "大战王昭",	--任务名字
		startNpcID = 20701,	--任务起始npc
		endNpcID = 20701,		--任务结束npc
		preTaskData = {1201},	--任务前置任务没有填nil
		nextTaskID = 1203,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1208,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --王昭
			{
			mineIndex = 1,		--第一个雷
			scriptID = 201,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1206,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 20720, x = 164, y = 96,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20740, x = 167, y = 97,  noDelete = true},
					{npcID = 20742, x = 161, y = 97,  noDelete = true},
					{npcID = 20741, x = 165, y = 99,  noDelete = true},
					{npcID = 20743, x = 162, y = 99,  noDelete = true},
			},
			posData = {mapID = 13, x = 164, y = 95}, --踩雷坐标
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
			{type="autoTrace", param = {tarMapID=13, x =55, y = 141,npcID = 20701,},}, --自动寻路到王允身边
		},
	},
	},

[1203] =
	{
		name = "寻找貂蝉",	--任务名字
		startNpcID = 20701,	--任务起始npc王允
		endNpcID = 20702,	--任务结束npc
		preTaskData = {1202}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 1204,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1209,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 106, x = 220, y = 120, bor = true},},-------到达指定坐标
		},
			
		triggers = --任务触发器
		{

			[TaskStatus.Active] =
				{
				{type="createPrivateNpc",                                         --私有npc创建
				param={ 
						npcs =
						{
							[1] = {npcID = 20702, mapID = 106, x = 218, y = 119, dir = Direction. EastSouth,}, --貂蝉
							[2] = {npcID = 20703, mapID = 106, x = 216, y = 118, dir = Direction. EastSouth,}, --萵姬
						},
					},
				},
				},
			[TaskStatus.Done] =
				{
				{type="openDialog", param={dialogID = 1209},},	
				},
	          },
	},

[1204] =
         {                  --[[离开私苑--]]

		name = "离开私苑",	--任务名字
		startNpcID = 20702,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1203},	--任务前置任务没有填nil
		nextTaskID = 1205,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --萵姬
			{
			mineIndex = 1,		--第一个雷
			scriptID = 202,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1212,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 106, x = 220, y = 120}, --踩雷坐标
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
			
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20702, taskID = {1203}, index = 1}, --删除貂蝉
						},
					},
				},
			{type="createFollow", param = {npcs = {20702},},},--创建貂蝉跟随
			{type="openDialog", param={dialogID = 1213},},
			{type="finishTask", param = {recetiveTaskID = 1205},},
			
			},
		},
	},
	
[1205] =
         {                  --[[会见吕布--]]

		name = "会见吕布",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20702,		--任务结束npc
		preTaskData = {1204},	--任务前置任务没有填nil
		nextTaskID = 1206,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1217,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --魔化吕布
			{
			mineIndex = 1,		--第一个雷
			scriptID = 203,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1214,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 106, x = 162, y = 86}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
				{type="autoTrace", param = {tarMapID=106, x =163, y = 85,npcID = 20707,},}, --自动寻路到吕布身边
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20707, mapID = 106, x = 161, y = 87, dir = Direction. WestSouth,}, --魔化吕布
						},
					},
			},
			{type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20703, taskID = {1203}, index = 1}, --删除萵姬
						},
					},
				},
				},
			[TaskStatus.Done]		=
			{
			{type="deleteFollow", param = {npcs = {20702},},},
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20702, mapID = 106, x = 161, y = 86, dir = Direction. WestSouth,}, --貂蝉
						},
					},
			},
                        {type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 20707, taskID = {1205}, index = 1}, --删除吕布
						},
					},
				},
		        {type="openDialog", param={dialogID = 1217},},
			},
		},
	},
[1206] =
	{
		name = "发现线索",	--任务名字
		startNpcID = 20702,	--任务起始np
		endNpcID = 20701,	--任务结束npc
		preTaskData = {1205}, --前置任务ID 
		nextTaskID = 1207,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1218,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 13, x = 55, y = 141, bor = true},},-------到达指定坐标
			},
			triggers = --任务触发器
			{
				[TaskStatus.Active] = 
				{
				},
				[TaskStatus.Done] =
					{
				                {type="deletePrivateNpc",
				  param={
						npcs =
						{
							{npcID = 20702, taskID = {1205}, index = 1}, --删除貂蝉
						},
					        },
				                },
				                {type="openDialog", param={dialogID = 12018},},
						
			},
	},
	},
[1207] =
         {                  --[[试探郭汜--]]

		name = "试探郭汜",	--任务名字
		startNpcID = 20701,	--任务起始npc
		endNpcID = 20752,		--任务结束npc
		preTaskData = {1206},	--任务前置任务没有填nil
		nextTaskID = 1208,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1238,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --郭汜
			{
			mineIndex = 1,		--第一个雷
			scriptID = 204,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1236,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 20729, x = 132, y = 119,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20745, x = 130, y = 118,  noDelete = true},
					{npcID = 20747, x = 135, y = 118,  noDelete = true},
					{npcID = 20744, x = 131, y = 116,  noDelete = true},
					{npcID = 20746, x = 134, y = 116,  noDelete = true},
			},
			posData = {mapID = 13, x = 132, y = 120}, --踩雷坐标
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
							[1] = {npcID = 20752, mapID = 13, x = 132, y = 119, dir = Direction. EastSouth,}, --郭汜
						},
					},
			},
		        {type="openDialog", param={dialogID = 1238},},
			},
		},
	},
	
[1208] =
         {                  --[[质问曹性--]]

		name = "质问曹性",	--任务名字
		startNpcID = 20752,	--任务起始npc
		endNpcID = 20731,		--任务结束npc
		preTaskData = {1207},	--任务前置任务没有填nil
		nextTaskID = 1209,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1241,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --曹性
			{
			mineIndex = 1,		--第一个雷
			scriptID = 205,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1239,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
		
			},
			posData = {mapID = 13, x = 87, y = 65}, --踩雷坐标
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
							[1] = {npcID = 20710, mapID = 13, x = 85, y = 65, dir = Direction. EastSouth,}, --曹性
							[2] = {npcID = 20721, mapID = 13, x = 83, y = 68, dir = Direction. EastSouth,}, --曹营守将
							[3] = {npcID = 20753, mapID = 13, x = 83, y = 63, dir = Direction. EastSouth,}, --曹营小兵
							[4] = {npcID = 20722, mapID = 13, x = 80, y = 64, dir = Direction. EastSouth,}, --曹营守将
							[5] = {npcID = 20754, mapID = 13, x = 80, y = 68, dir = Direction. EastSouth,}, --曹营小兵
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
							{npcID = 20710, taskID = {1208}, index = 1}, --删除曹性
							{npcID = 20721, taskID = {1208}, index = 2}, --删除曹性
							{npcID = 20722, taskID = {1208}, index = 3}, --删除曹性
							{npcID = 20753, taskID = {1208}, index = 4}, --删除曹性
							{npcID = 20754, taskID = {1208}, index = 5}, --删除曹性
							{npcID = 20752, taskID = {1207}, index = 1}, --删除郭汜
						},
					        },
				                },
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20731, mapID = 13, x = 85, y = 65, dir = Direction. EastSouth,}, --曹性
						},
					},
			},
		    {type="openDialog", param={dialogID = 1241},},
			},
		},
	},
	
[1209] =
         {                  --[[降服孙胜--]]

		name = "降服孙胜",	--任务名字
		startNpcID = 20710,	--任务起始npc
		endNpcID = 20709,		--任务结束npc
		preTaskData = {1208},	--任务前置任务没有填nil
		nextTaskID = {1210,1211,1212,1213,1214,1215},	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1245,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{   
		[1] = {type='Tmine',param =     --王昭
			{
			mineIndex = 1,		--第一个雷
			scriptID = 206,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1242,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 20709, x = 98, y = 135,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20756, x = 96, y = 139,  noDelete = true},
					{npcID = 20758, x = 96, y = 132,  noDelete = true},
					{npcID = 20755, x = 95, y = 135,  noDelete = true},
					{npcID = 20757, x = 95, y = 137,  noDelete = true},
			},
			posData = {mapID = 13, x = 99, y = 135}, --踩雷坐标
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
							[1] = {npcID = 20730, mapID = 13, x = 98, y = 135, dir = Direction. EstSouth,}, --孙胜
						},
					},
			},
		        {type="openDialog", param={dialogID = 1245},},
			
			},
		},
	},
	
[1210] =
	{
		name = "门派求援",	--任务名字
		startNpcID = 0,	--任务起始npc
		endNpcID = 20004,	--任务结束npc
		preTaskData ={1209}, --前置任务ID 
		nextTaskID = 1216,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1246,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 1 , x = 26, y = 84, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
			        {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 1, x = 59, y = 111, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
							},
			 			},
			             },
				{type="openDialog", param={dialogID = 1246},},
			        },
		},
	},
[1211] =
	{
		name = "门派求援",	--任务名字
		startNpcID = 0,	--任务起始npc
		endNpcID = 20005,	--任务结束npc
		preTaskData ={1209}, --前置任务ID 
		nextTaskID = 1226,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1247,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 4 , x = 59, y = 72, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 4, x = 64, y = 134, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
							},
			 			},
			             },
				{type="openDialog", param={dialogID = 1247},},
			        },
		},
	},

[1212] =
	{
		name = "门派求援",	--任务名字
		startNpcID =0,	--任务起始npc
		endNpcID = 20006,	--任务结束npc
		preTaskData ={1209}, --前置任务ID 
		nextTaskID = 1227,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1248,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 3 , x = 26, y = 92, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 3, x = 99, y = 93, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
							},
			 			},
			             },
				{type="openDialog", param={dialogID = 1248},},
			        },
	},
	},
[1213] =
	{
		name = "门派求援",	--任务名字
		startNpcID = 0,	--任务起始npc
		endNpcID = 20007,	--任务结束npc
		preTaskData ={1209}, --前置任务ID 
		nextTaskID = 1228,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1249,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 2 , x = 83, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 2, x = 16, y = 99, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
							},
			 			},
			             },
		                {type="openDialog", param={dialogID = 1249},},
		      	        },
	                  },
	},
[1214] =
	{
		name = "门派求援",	--任务名字
		startNpcID = 0,	--任务起始npc
		endNpcID = 20008,	--任务结束npc
		preTaskData ={1209}, --前置任务ID 
		nextTaskID = 1229,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1250,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 6 , x = 67, y = 135, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 6, x = 57, y = 48, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
							},
			 			},
			             },
				{type="openDialog", param={dialogID = 1250},},
			        },
	                  },
	},
[1215] =
	{
		name = "门派求援",	--任务名字
		startNpcID = 0,	--任务起始npc
		endNpcID = 20009,	--任务结束npc
		preTaskData ={1209}, --前置任务ID 
		nextTaskID = 1230,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1251,	--
		taskType2 = TaskType2.Main, --任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 5 , x = 43, y = 112, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 5, x = 119, y = 64, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
							},
			 			},
			             },
				{type="openDialog", param={dialogID = 1251},},
			        },
	                  },
	},
[1216] =
	{
		name = "前往蓬莱山",	--任务名字
		startNpcID = 20004,	--任务起始
		endNpcID = 20711,	--任务结束npc
		preTaskData = {1210},--前置任务ID 
		nextTaskID = 1217,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1258,	--
		taskType2 = TaskType2.Main,--任务类型
		school =SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 114 , x = 20, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				
				},
				[TaskStatus.Done] =
					{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1210, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1258},},	
			},
	},
	},
[1226] =
	{
		name = "前往蓬莱山",	--任务名字
		startNpcID = 20005,	--任务起始
		endNpcID = 20711,	--任务结束npc
		preTaskData = {1211}, --前置任务ID 
		nextTaskID = 1217,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1293,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 114 , x = 20, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				
				},
				[TaskStatus.Done] =
					{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1211, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1293},},	
			},
	},
	},
[1227] =
	{
		name = "前往蓬莱山",	--任务名字
		startNpcID = 20006,	--任务起始
		endNpcID = 20711,	--任务结束npc
		preTaskData = {1212},--前置任务ID 
		nextTaskID = 1217,	--任务后置任务没有填nil
		startDialogID =nil, 	--
		endDialogID = 1294,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 114 , x = 20, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				
				},
				[TaskStatus.Done] =
					{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1212, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1294},},	
			},
	},
	},
[1228] =
	{
		name = "前往蓬莱山",	--任务名字
		startNpcID = 20007,	--任务起始
		endNpcID = 20711,	--任务结束npc
		preTaskData = {1213}, --前置任务ID 
		nextTaskID = 1217,	--任务后置任务没有填nil
		startDialogID =nil, 	--
		endDialogID = 1295,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 114 , x = 20, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				
				},
				[TaskStatus.Done] =
					{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1213, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1295},},	
			},
	},
	},
[1229] =
	{
		name = "前往蓬莱山",	--任务名字
		startNpcID = 20008,	--任务起始
		endNpcID = 20711,	--任务结束npc
		preTaskData = {1214}, --前置任务ID 
		nextTaskID = 1217,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1296,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 114 , x = 20, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				
				},
				[TaskStatus.Done] =
					{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1214, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1296},},	
			},
	},
	},
[1230] =
	{
		name = "前往蓬莱山",	--任务名字
		startNpcID = 20009,	--任务起始
		endNpcID = 20711,	--任务结束npc
		preTaskData = {1215},--前置任务ID 
		nextTaskID = 1217,	--任务后置任务没有填nil
		startDialogID =nil, 	--
		endDialogID = 1297,	--
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 114 , x = 20, y = 125, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				
				},
				[TaskStatus.Done] =
					{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1215, index = 1},--删除私有传送阵
							},
						},
				},
				{type="openDialog", param={dialogID = 1297},},	
			},
	},
	},

 [1217] =
	{
		name = "天山寻雪莲",	--任务名字
		startNpcID = 20711,	--任务起始
		endNpcID = 20714,	--任务结束npc
		preTaskData =  {condition = "or",{1216,1226,1227,1228,1229,1230}},      --前置任务ID 
		nextTaskID = 1218,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1293,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 115 , x = 73, y = 194, bor = true},},-------到达指定坐标
		},		
		triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 20730, taskID = {1209}, index = 1}, --删除孙胜
						},
					        },
				                },
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20714, mapID = 115, x = 72, y = 193, dir = Direction. EastSouth,}, --天山小妖
						        [2] = {npcID = 20712, mapID = 115, x = 66, y = 188, dir = Direction. EastSouth,}, --天山妖魔
						},
					},
		           	},
				},
				[TaskStatus.Done] =
					{
					{type="openDialog", param={dialogID = 1293},},		
			},
	},
	},
[1218] =
         {                  --[[雪莲踪迹--]]

		name = "雪莲踪迹",	--任务名字
		startNpcID = 20714,	--任务起始npc
		endNpcID = 20714,		--任务结束npc
		preTaskData = {1217},	--任务前置任务没有填nil
		nextTaskID = 1219,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1262,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{ 
		[1] = {type='Tmine',param =     --天山妖魔
			{
			mineIndex = 1,		--第一个雷
			scriptID = 207,         --脚本战斗
			lastMine = true,	--是否为最后一个雷
			dialogID = 1260,        --动作结束打开的对话框
			npcsData =
			{
			},                       --刷出npc数据
			posData = {mapID = 115, x = 68, y = 188}, --踩雷坐标
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
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 20712, taskID = {1217}, index = 1}, --删除天山妖魔
						},
					 },
                          },
		        {type="openDialog", param={dialogID = 1262},},
			},
		},
	},
	
[1219] = 
	{                      --[[雪莲下落--]]     

		name = "雪莲下落",	--任务名字
		startNpcID = 20714,	--任务起始
		endNpcID = 20713,	--任务结束npc
		preTaskData = {1217},       --前置任务ID 
		nextTaskID = 1219,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1267,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
          	[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tmine',param =     --雪莲守妖
			{
			mineIndex = 1,		--第一个雷
			scriptID = 208,         --脚本战斗
			lastMine = true,	--是否为最后一个雷
			dialogID = 1265,        --动作结束打开的对话框
			npcsData =     
			{
			                {npcID = 20713, x = 118, y = 148,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20762, x = 115, y = 146,  noDelete = true},
					{npcID = 20763, x = 115, y = 151,  noDelete = true},
			},                       --刷出npc数据
			posData = {mapID = 115, x = 120, y = 148}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			}, 
			},
			triggers = --任务触发器
			{
			
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
					{
					{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20764, mapID = 115, x = 118, y = 148, dir = Direction. EastSouth,}, --雪莲守妖
						},
					},
		           	},
					{type="openDialog", param={dialogID = 1267},},	
			},
	},
	},
[1220] = 
	{                      --[[打败俄何烧戈--]]     

		name = "打败俄何烧戈",	--任务名字
		startNpcID = 20713,	--任务起始
		endNpcID = 20715,	--任务结束npc
		preTaskData = {1219},       --前置任务ID 
		nextTaskID = 1221,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1270,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tmine',param =     --俄何烧戈
			{
			mineIndex = 1,		--第一个雷
			scriptID = 209,         --脚本战斗
			lastMine = true,	--是否为最后一个雷
			dialogID = 1268,        --动作结束打开的对话框
			npcsData =     
			{
			                {npcID = 20715, x = 207, y = 80,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20723, x = 211, y = 78,  noDelete = true},
					{npcID = 20760, x = 203, y = 78,  noDelete = true},
					{npcID = 20759, x = 205, y = 76,  noDelete = true},
					{npcID = 20761, x = 209, y = 76,  noDelete = true},
			},                       --刷出npc数据
			posData = {mapID = 115, x = 207, y = 81}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
			},
			triggers = --任务触发器
			{
			
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
					{
					{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20733, mapID = 115, x = 207, y = 80, dir = Direction. EastNorth,}, --俄何烧戈
						},
					},
		           	},
					{type="openDialog", param={dialogID = 1270},},	
			},
	},
	},
	
[1221] = 
	{                      --[[神兽风波--]]     

		name = "神兽风波",	--任务名字
		startNpcID = 20715,	--任务起始
		endNpcID = 20718,	--任务结束npc
		preTaskData = {1220},       --前置任务ID 
		nextTaskID = 1222,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1274,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tmine',param =     --风兽
			{
			mineIndex = 1,		--第一个雷
			scriptID = 210,         --脚本战斗
			lastMine = false,	--是否为最后一个雷
			dialogID = 1271,        --动作结束打开的对话框
			npcsData =     
			{
			{npcID = 20716, x = 90, y = 96, actionID = 5, magicID = 115, noDelete = true},
			{npcID = 20748, x = 87, y = 96, actionID = 5, magicID = 115, noDelete = true},
			{npcID = 20749, x = 89, y = 99, actionID = 5, magicID = 115, noDelete = true},
			},                       --刷出npc数据
			posData = {mapID = 115, x =91, y = 95}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --雷兽
			{
			mineIndex = 2,		--第二个雷
			scriptID = 211,         --脚本战斗
			lastMine = true,	--是否为最后一个雷
			dialogID = 1273,        --动作结束打开的对话框
			npcsData =     
			{
			{npcID = 20717, x = 79, y = 105, actionID = 5, magicID = 115, noDelete = true},
			{npcID = 20748, x = 76, y = 105, actionID = 5, magicID = 115, noDelete = true},
			{npcID = 20749, x = 79, y = 108, actionID = 5, magicID = 115, noDelete = true},
			},                       --刷出npc数据
			posData = {mapID = 115, x = 80, y = 104}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
			},
			triggers = --任务触发器
			{
			
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
					{
					{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20734, mapID = 115, x = 75, y =108, dir = Direction. South,}, --雷兽
						},
					},
		           	},
				{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 20733, taskID = {1220}, index = 1}, --删除俄何烧戈
						},
					        },
				                },
					{type="openDialog", param={dialogID = 1274},},		
			},
	},
	},
	
[1222] = 
	{                      --[[得到天山雪莲--]]     

		name = "得到天山雪莲",	--任务名字
		startNpcID = 20718,	--任务起始
		endNpcID = 20718,	--任务结束npc
		preTaskData = {1221},       --前置任务ID 
		nextTaskID = 1223,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1278,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tmine',param =     --暗影魔姣
			{
			mineIndex = 1,		--第一个雷
			scriptID = 212,         --脚本战斗
			lastMine = true,	--是否为最后一个雷
			dialogID = 1275,        --动作结束打开的对话框
			npcsData =     
			{
			                {npcID = 20718, x = 48, y = 137,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20724, x = 49, y = 140,  noDelete = true},
					{npcID = 20727, x = 45, y = 136,  noDelete = true},
					{npcID = 20750, x = 46, y = 141,  noDelete = true},
					{npcID = 20751, x = 44, y = 139,  noDelete = true},
			},                       --刷出npc数据
			posData = {mapID = 115, x = 49, y = 136}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
			},
			triggers = --任务触发器
			{
			
				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
					{
					{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20735, mapID = 115, x = 48, y = 137, dir = Direction. South,}, --暗影魔姣
						},
					},
		           	},
				        {type="getItem", param = {itemID = 1041014, count = 1,}},			--获得指定数量的物品(参数物品ID，数量)
					{type="openDialog", param={dialogID = 1278},},	
			},
	},
	},
[1223] =
         {                  --[[驱魔金丹--]]

		name = "驱魔金丹",	--任务名字
		startNpcID = 20718,	--任务起始npc
		endNpcID = 20711,		--任务结束npc
		preTaskData = {1222},	--任务前置任务没有填nil
		nextTaskID = 1224,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1279,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{ 
		--[1] = {type='Tarea',param = {mapID = 114, x = 18, y = 125, bor = true},},-------到达指定坐标
		[1] = {type = "TcommitItem", param = {taskID = 1223,itemsInfo = {{itemID = 1041014, count = 1}},bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
                               {type="CreateIntemDirect",param = {taskID = 1223,itemsInfo = {{itemID = 1041014, count = 1}}},},
			       {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 115, x = 86, y = 139, tarMapID = 114, tarX = 59, tarY = 113},--创建私有传送阵
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
						[1] ={npcID = 20735, taskID = {1222}, index = 1}, --删除暗影魔姣
						},
					        },
				                },
			{type="getItem", param = {itemID = 1041015, count = 1,}},			--获得指定数量的物品(参数物品ID，数量)
		        {type="openDialog", param={dialogID = 1279},}, 
			},
		},
	},
[1224] =
         {                  --[[会见貂蝉--]]

		name = "会见貂蝉",	--任务名字
		startNpcID = 20711,	--任务起始npc
		endNpcID = 20702,		--任务结束npc
		preTaskData = {1223},	--任务前置任务没有填nil
		nextTaskID = 1225,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1281,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{ 
		[1] = {type='Tarea',param = {mapID = 116, x = 174, y = 160, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 20702, mapID = 116, x = 173, y = 160, dir = Direction. EastSouth,}, --貂蝉
						},
					},
			         },
			},
			[TaskStatus.Done]=
			{
			{type="openDialog", param={dialogID = 1281},},
			},
		},
	},
[1225] = 
	{                      --[[降服魔化吕布--]]     

		name = "降服魔化吕布",	--任务名字
		startNpcID = 20702,	--任务起始
		endNpcID = 20719,	--任务结束npc
		preTaskData = {1224},       --前置任务ID 
		nextTaskID = 1301,	--任务后置任务没有填nil
		startDialogID =nil,	--
		endDialogID = 1286,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
		[TaskRewardList.player_xp] = 8000,   --玩家经验
                [TaskRewardList.pet_xp] = 5000,      --宠物经验
                [TaskRewardList.subMoney] = 34000,    --绑银
                [TaskRewardList.player_pot] = 10200,  	--人物潜能
	 
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tmine',param =     --魔化吕布
			{
			mineIndex = 1,		--第一个雷
			scriptID = 213,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1283,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 116, x = 155, y = 149}, --踩雷坐标
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
							{npcID = 20702, taskID = {1224}, index = 1}, --删除貂蝉
						},
					},
				},
				{type="createFollow", param = {npcs = {20702},},},--创建貂蝉跟随
				{type="createPrivateNpc",  --私有npc创建
				param={
				npcs ={
				   [1] = {npcID = 20707, mapID = 116, x = 154, y = 149, dir = Direction. EastSouth,}, --魔化吕布
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
							{npcID = 20707, taskID = {1225}, index = 1}, --删除魔化吕布
						 },
					         },
				                 },  
			{type="deleteFollow", param = {npcs = {20702},},},
			{type="createPrivateNpc",  --私有npc创建
				param={
				npcs ={
				   [1] = {npcID = 20719, mapID = 116, x = 154, y = 149, dir = Direction. EastSouth,}, --吕布
				   [2] = {npcID = 20702, mapID = 116, x = 155, y = 146, dir = Direction. EastSouth,}, --貂蝉
					},
				},
		     },
			{type="openDialog", param={dialogID = 1285},},
			},
	},
	},

}
table.copy(MainTaskDB31_35, NormalTaskDB)