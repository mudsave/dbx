--[[MainTaskDB1_20.lua
	任务配置1到20级(任务系统)
]]

MainTaskDB1_20 =
{
	[10086] =
	{
		a = 2,
		g = {1,2,3,{t = 5}}
	},
	------------------------------1-25级----------------
	[1001] =
	{

		name = "初到仙境",
		startNpcID = 20001,
		endNpcID = 20001,
		preTaskData = nil,
		nextTaskID = 1002,
		startDialogID =	100,
		endDialogID = 101,
		taskType2 = TaskType2.Main,
		school = nil,
		level =	{1,150},
		rewards	=
		{
			[TaskRewardList.player_xp] = 100,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 1000,    --绑银
			[TaskRewardList.player_pot] = 300,  	--人物潜能
		},
		consume	=
		{
		},
		targets	=
		{
		},
		triggers =
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 8, x = 95, y = 184,npcID = 20001,},},
			},
		},
	},

	[1002] =
	{
		name = "拜见元始",
		startNpcID = 20001,
		endNpcID = 20002,
		preTaskData = {1001},
		nextTaskID = 1003,
		startDialogID =	103,
		endDialogID = 104,
		taskType2 = TaskType2.Main,
		school = nil,
		level =	{1,150},
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 110,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 2000,    --绑银
			[TaskRewardList.player_pot] = 600,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 134, y	= 219,npcID = 20002,},},
			},
		},
	},
	[1003] =
	{

		name = "通过考验",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1002},	--任务前置任务没有填nil
		nextTaskID = {1004,1009,1014,1019,1024,1029},--任务后置任务没有填nil
		startDialogID =	105,	--接任务对话ID没有填nil
		endDialogID = 107,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 240,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 3000,    --绑银
			[TaskRewardList.player_pot] = 900,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript',param = {scriptID	= 100 ,	count =	1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 107},}, --在任务结束时打开一个对话框
			},
		},
	},
	----------------------------------------------乾元岛----------------------------
	[1004] = -----------乾元岛
	{

		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1005,	--任务后置任务没有填nil
		startDialogID =	108,	--接任务对话ID没有填nil
		endDialogID = 109,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 130,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 4000,    --绑银
			[TaskRewardList.player_pot] = 1200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8, x = 148, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 148, y	= 72,npcID = 20003,},},

			},
		},

	},
	[1005] =	--乾元岛
	{

		name = "打开百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1004},	--任务前置任务没有填nil
		nextTaskID = 1006,	--任务后置任务没有填nil
		startDialogID =	110,	--接任务对话ID没有填nil
		endDialogID = 111,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 280,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 5000,    --绑银
			[TaskRewardList.player_pot] = 1500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="getItem", param = {itemID = 1026006, count = 1,}},--获得物品
			},
		},
	},
	[1006] =	--乾元岛
	{

		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = nil,------{1005},	--任务前置任务没有填nil
		nextTaskID = 1007,	--任务后置任务没有填nil
		startDialogID =	112,	--接任务对话ID没有填nil
		endDialogID = 113,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 300,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 6000,    --绑银
			[TaskRewardList.player_pot] = 1800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 1 , x = 44, y = 85, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="doSwithScene", param = {tarMapID = 1,	x = 44, y = 85,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 1, x = 26, y = 84,npcID = 20004,},}, --寻路到掌门
			},
		},
	},
	[1007] =	--乾元岛
	{

		name = "苦练心法",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = {1006},	--任务前置任务没有填nil
		nextTaskID = 1034,	--任务后置任务没有填nil
		startDialogID =	114,	--接任务对话ID没有填nil
		endDialogID = 115,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 600,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 7000,    --绑银
			[TaskRewardList.player_pot] = 2100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 20101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 115},},
			},
		},
	},
	[1034] =	--乾元岛
	{

		name = "寻找大弟子",	--任务名字
		startNpcID = 20004,	--乾元岛掌门
		endNpcID = 20021,		--大弟子乾元岛段岳
		preTaskData = {1007},
		nextTaskID = 1036,
		startDialogID =	168,
		endDialogID = 169,
		taskType2 = TaskType2.Main,
		school = SchoolType.QYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 8000,    --绑银
			[TaskRewardList.player_pot] = 2400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 1, x = 32, y = 76, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 1, x = 32, y	= 76,npcID = 20021,},},
			},
		},
	},
	
	[1036] =	----乾元岛
	{

		name = "捕捉宠物",	--任务名字
		startNpcID = 20021,	--乾元岛掌门
		endNpcID = 20021,		--大弟子乾元岛段岳
		preTaskData = {1034},
		nextTaskID = 1037,
		startDialogID =nil	,
		endDialogID = 171,
		taskType2 = TaskType2.Main,
		school = SchoolType.QYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 9000,    --绑银
			[TaskRewardList.player_pot] = 2700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 1 , x = 61, y = 82, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 1, x = 61, y = 82,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 1, scriptID = {101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
					}
				},
			},
			[TaskStatus.Done]		=
			{
				{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			      {type = "removeMine", param = {}}, -- 移除任务类
			},
		},
},
	[1037] =	--乾元岛
	{

		name = "要事相商",	--任务名字
		startNpcID = 20021,	--大弟子段岳
		endNpcID = 20004,		--乾元岛掌门
		preTaskData = {1036},
		nextTaskID = 1038,
		startDialogID =	172,
		endDialogID = 173,
		taskType2 = TaskType2.Main,
		school = SchoolType.QYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 1, x = 26, y = 84, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 1, x = 26, y	= 84,npcID = 20004,},},
			},
		},
	},
	[1038] =	--乾元岛
	{

		name = "前往桃园镇",	--任务名字
		startNpcID = 20004,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1037},
		nextTaskID = 1035,
		startDialogID =	116,
		endDialogID = 117,
		taskType2 = TaskType2.Main,
		school = SchoolType.QYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 94, y = 34, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 1, x =132, y =41, tarMapID = 9, tarX = 94, tarY = 34},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
                {type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1038, index = 1},
							},
						},
				},
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1035] =	--乾元岛
	{
		name = "寻找刘备",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1038}, 
		nextTaskID = 1065,
		startDialogID =	360,   --后面添加的一个对话
		endDialogID = 366,
		taskType2 = TaskType2.Main,
		school = SchoolType.QYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1000,   --玩家经验
			[TaskRewardList.pet_xp] = 1000,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 101 , x = 224, y = 115, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
					{
						{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20028,	mapID =	101, x = 224, y = 115,dir = WestSouth,},
						},
					},
				},
					},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 366},}, --在任务结束时打开一个对话框
			},
		},
	},
	----------------------------------------------桃源洞----------------------------
	[1009] = -----------桃源洞
	{

		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1010,	--任务后置任务没有填nil
		startDialogID =	118,	--接任务对话ID没有填nil
		endDialogID = 119,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 130,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 4000,    --绑银
			[TaskRewardList.player_pot] = 1200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8, x = 148, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 148, y	= 72,npcID = 20003,},},

			},
		},
	},
	[1010] =	--桃源洞
	{

		name = "打开百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1009},	--任务前置任务没有填nil
		nextTaskID = 1011,	--任务后置任务没有填nil
		startDialogID =	120,	--接任务对话ID没有填nil
		endDialogID = 121,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 280,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 5000,    --绑银
			[TaskRewardList.player_pot] = 1500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="getItem", param = {itemID = 1026013, count = 1,}},--获得物品
			},
		},
	},
	[1011] =	--桃源洞
	{

		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1010},	--任务前置任务没有填nil
		nextTaskID = 1012,	--任务后置任务没有填nil
		startDialogID =	122,	--接任务对话ID没有填nil
		endDialogID = 123,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 300,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 6000,    --绑银
			[TaskRewardList.player_pot] = 1800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 4 , x = 78, y = 70, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="doSwithScene", param = {tarMapID = 4,	x = 78, y = 70,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 4, x = 59, y = 72,npcID = 20005,},}, --寻路到掌门
			},
		},
	},
	[1012] =	--桃源洞
	{

		name = "苦练心法",	--任务名字
		startNpcID = 20005,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1011},	--任务前置任务没有填nil
		nextTaskID = 1039,	--任务后置任务没有填nil
		startDialogID =	124,	--接任务对话ID没有填nil
		endDialogID = 125,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 600,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 7000,    --绑银
			[TaskRewardList.player_pot] = 2100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 50101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 125},},
			},
		},
	},
	[1039] =	--桃源洞
	{

		name = "寻找大弟子",	--任务名字
		startNpcID = 20005,	--桃源洞掌门
		endNpcID = 20025,		--大弟子庄梦蝶
		preTaskData = {1012},
		nextTaskID = 1040,
		startDialogID =	174,
		endDialogID = 175,
		taskType2 = TaskType2.Main,
		school = SchoolType.TYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 8000,    --绑银
			[TaskRewardList.player_pot] = 2400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 4, x = 61, y = 93, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 4, x = 61, y	= 93,npcID = 20025,},},
			},
		},
	},
	
	[1040] =	----桃源洞
	{

		name = "捕捉宠物",	--任务名字
		startNpcID = 20025,	--桃源洞掌门
		endNpcID = 20025,		--大弟子庄梦蝶
		preTaskData = {1039},
		nextTaskID = 1042,
		startDialogID =176	,
		endDialogID = 177,
		taskType2 = TaskType2.Main,
		school = SchoolType.TYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 9000,    --绑银
			[TaskRewardList.player_pot] = 2700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 4 , x = 79, y = 58, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 4, x = 79, y = 58,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 4, scriptID = {101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
					}
				},
			},
			[TaskStatus.Done]		=
			{
				{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			    {type = "removeMine", param = {}}, -- 移除任务类
			},
		},
	},
	[1042] =	--桃源洞
	{

		name = "要事相商",	--任务名字
		startNpcID = 20025,	--大弟子庄梦蝶
		endNpcID = 20005,		--桃源洞掌门
		preTaskData = {1040},
		nextTaskID = 1043,
		startDialogID =	178,
		endDialogID = 179,
		taskType2 = TaskType2.Main,
		school = SchoolType.TYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 4, x = 59, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 4, x = 59, y	= 72,npcID = 20005,},},
			},
		},
	},
	[1043] =	--桃源洞
	{

		name = "前往桃园镇",	--任务名字
		startNpcID = 20005,	--桃源洞掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1042},
		nextTaskID = 1041,
		startDialogID =	126,
		endDialogID = 127,
		taskType2 = TaskType2.Main,
		school = SchoolType.TYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 94, y = 34, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 4, x = 97, y = 9, tarMapID = 9, tarX = 94, tarY = 34},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
                {type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1043, index = 1},
							},
						},
				},
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
	  [1041] =	--桃源洞
	{
		name = "寻找刘备",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1043}, 
		nextTaskID = 1065,
		startDialogID =	361,   --后面添加的一个对话
		endDialogID = 367,
		taskType2 = TaskType2.Main,
		school = SchoolType.TYD,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1000,   --玩家经验
			[TaskRewardList.pet_xp] = 1000,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 101 , x = 224, y = 115, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
					{
						{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20028,	mapID =	101, x = 224, y = 115,dir = WestSouth,},
						},
					},
				},
					},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 367},}, --在任务结束时打开一个对话框
			},
		},
	},

	----------------------------------------------金霞山----------------------------
	[1014] = -----------金霞山
	{

		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1015,	--任务后置任务没有填nil
		startDialogID =	128,	--接任务对话ID没有填nil
		endDialogID = 129,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 130,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 4000,    --绑银
			[TaskRewardList.player_pot] = 1200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8, x = 148, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 148, y	= 72,npcID = 20003,},},

			},
		},
	},
	[1015] =	--金霞山
	{

		name = "打开百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1014},	--任务前置任务没有填nil
		nextTaskID = 1016,	--任务后置任务没有填nil
		startDialogID =	130,	--接任务对话ID没有填nil
		endDialogID = 131,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 280,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 5000,    --绑银
			[TaskRewardList.player_pot] = 1500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="getItem", param = {itemID = 1026020, count = 1,}},--获得物品
			},
		},
	},
	[1016] =	--金霞山
	{

		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1015},	--任务前置任务没有填nil
		nextTaskID = 1017,	--任务后置任务没有填nil
		startDialogID =	128,	--接任务对话ID没有填nil
		endDialogID = 133,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 300,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 6000,    --绑银
			[TaskRewardList.player_pot] = 1800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 3 , x = 39, y = 82, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="doSwithScene", param = {tarMapID = 3,	x = 39, y = 82,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 3, x = 26, y = 92,npcID = 20006,},}, --寻路到掌门
			},
		},
	},
	[1017] =	--金霞山
	{

		name = "苦练心法",	--任务名字
		startNpcID = 20006,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1016},	--任务前置任务没有填nil
		nextTaskID = 1044,	--任务后置任务没有填nil
		startDialogID =	134,	--接任务对话ID没有填nil
		endDialogID = 135,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 600,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 7000,    --绑银
			[TaskRewardList.player_pot] = 2100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 10101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 135},},
			},
		},
	},
	[1044] =	--金霞山
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20006,	--金霞山掌门
		endNpcID = 20023,		--大弟子李长风
		preTaskData = {1017},
		nextTaskID = 1045,
		startDialogID =	180,
		endDialogID = 181,
		taskType2 = TaskType2.Main,
		school = SchoolType.JXS,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 8000,    --绑银
			[TaskRewardList.player_pot] = 2400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 3, x = 33, y = 111, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 3, x = 33, y	= 111,npcID = 20023,},},
			},
		},
	},
	
	[1045] =	----金霞山
	{

		name = "捕捉宠物",	--任务名字
		startNpcID = 20023,	----大弟子李长风
		endNpcID = 20023,		--大弟子李长风
		preTaskData = {1044},
		nextTaskID = 1047,
		startDialogID =182	,
		endDialogID = 183,
		taskType2 = TaskType2.Main,
		school = SchoolType.JXS,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 9000,    --绑银
			[TaskRewardList.player_pot] = 2700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 3 , x = 106, y = 84, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 3, x = 106, y = 84,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 3, scriptID = {101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
					}
				},
			},
			[TaskStatus.Done]		=
			{
			      {type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			      {type = "removeMine", param = {}}, -- 移除任务类
			},
		},
	},
	[1047] =	--金霞山
	{

		name = "要事相商",	--任务名字
		startNpcID = 20023,	--大弟子李长风
		endNpcID = 20006,		--金霞山掌门
		preTaskData = {1045},
		nextTaskID = 1048,
		startDialogID =	184,
		endDialogID = 185,
		taskType2 = TaskType2.Main,
		school = SchoolType.JXS,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 3, x = 26, y = 92, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 3, x = 26, y	= 92,npcID = 20006,},},
			},
		},
	},
	[1048] =	--金霞山
	{

		name = "前往桃园镇",	--任务名字
		startNpcID = 20006,	--金霞山掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1047},
		nextTaskID = 1046,
		startDialogID =	136,
		endDialogID = 137,
		taskType2 = TaskType2.Main,
		school = SchoolType.JXS,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 94, y = 34, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 3, x = 101, y = 12, tarMapID = 9, tarX = 94, tarY = 34},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
                {type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1048, index = 1},
							},
						},
				},
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
     [1046] =	--金霞山
	{
		name = "寻找刘备",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1048}, 
		nextTaskID = 1065,
		startDialogID =	362,
		endDialogID = 368,
		taskType2 = TaskType2.Main,
		school = SchoolType.JXS,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1000,   --玩家经验
			[TaskRewardList.pet_xp] = 1000,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 101 , x = 224, y = 115, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
					{
						{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20028,	mapID =	101, x = 224, y = 115,dir = WestSouth,},
						},
					},
				},
					},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 368},}, --在任务结束时打开一个对话框
			},
		},
	},


	----------------------------------------------蓬莱阁----------------------------
	[1019] = -----------蓬莱阁
	{

		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1020,	--任务后置任务没有填nil
		startDialogID =	138,	--接任务对话ID没有填nil
		endDialogID = 139,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 130,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 4000,    --绑银
			[TaskRewardList.player_pot] = 1200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8, x = 148, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 148, y	= 72,npcID = 20003,},},

			},
		},
	},
	[1020] =	--蓬莱阁
	{

		name = "打开百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1019},	--任务前置任务没有填nil
		nextTaskID = 1021,	--任务后置任务没有填nil
		startDialogID =	140,	--接任务对话ID没有填nil
		endDialogID = 141,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 280,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 5000,    --绑银
			[TaskRewardList.player_pot] = 1500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="getItem", param = {itemID = 1026027, count = 1,}},--获得物品
			},
		},
	},
	[1021] =	--蓬莱阁
	{

		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1020},	--任务前置任务没有填nil
		nextTaskID = 1022,	--任务后置任务没有填nil
		startDialogID =	142,	--接任务对话ID没有填nil
		endDialogID = 143,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 300,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 6000,    --绑银
			[TaskRewardList.player_pot] = 1800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 2 , x = 86, y = 100, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="doSwithScene", param = {tarMapID = 2,	x = 86, y = 100,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 2, x = 83, y = 125,npcID = 20007,},}, --寻路到掌门
			},
		},
	},
	[1022] =	--蓬莱阁
	{

		name = "苦练心法",	--任务名字
		startNpcID = 20007,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1021},	--任务前置任务没有填nil
		nextTaskID = 1049,	--任务后置任务没有填nil
		startDialogID =	144,	--接任务对话ID没有填nil
		endDialogID = 145,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 600,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 7000,    --绑银
			[TaskRewardList.player_pot] = 2100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 40101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 145},},
			},
		},
	},
	[1049] =	--蓬莱阁
	{

		name = "寻找大弟子",	--任务名字
		startNpcID = 20007,	--蓬莱阁掌门
		endNpcID = 20022,		--大弟子兮颜
		preTaskData = {1022},
		nextTaskID = 1050,
		startDialogID =	186,
		endDialogID = 187,
		taskType2 = TaskType2.Main,
		school = SchoolType.PLG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 8000,    --绑银
			[TaskRewardList.player_pot] = 2400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 2, x = 61, y = 127, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 2, x = 61, y	= 127,npcID = 20022,},},
			},
		},
	},
	
	[1050] =	----蓬莱阁
	{

		name = "捕捉宠物",	--任务名字
		startNpcID = 20022,	----大弟子兮颜
		endNpcID = 20022,		--大弟子兮颜
		preTaskData = {1049},
		nextTaskID = 1052,
		startDialogID =188	,
		endDialogID = 189,
		taskType2 = TaskType2.Main,
		school = SchoolType.PLG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 9000,    --绑银
			[TaskRewardList.player_pot] = 2700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 2 , x = 19, y = 98, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 2, x = 19, y = 98,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 2, scriptID ={101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
					}
				},
			},
			[TaskStatus.Done]		=
			{
				 {type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			      {type = "removeMine", param = {}}, -- 移除任务类
			},
		},
	},
	[1052] =	--蓬莱阁
	{

		name = "要事相商",	--任务名字
		startNpcID = 20022,	--大弟子兮颜
		endNpcID = 20007,		--蓬莱阁掌门
		preTaskData = {1050},
		nextTaskID = 1053,
		startDialogID =	190,
		endDialogID = 191,
		taskType2 = TaskType2.Main,
		school = SchoolType.PLG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 2, x = 83, y = 125, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 2, x = 83, y	= 125,npcID = 20007,},},
			},
		},
	},
	[1053] =	--蓬莱阁
	{

		name = "前往桃园镇",	--任务名字
		startNpcID = 20007,	--蓬莱阁掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1052},
		nextTaskID = 1051,
		startDialogID =	146,
		endDialogID = 147,
		taskType2 = TaskType2.Main,
		school = SchoolType.PLG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 94, y = 34, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 2, x = 13, y = 99, tarMapID = 9, tarX = 94, tarY = 34},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
                {type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1053, index = 1},
							},
						},
				},
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
    [1051] =	--蓬莱阁
	{
		name = "寻找刘备",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1053}, 
		nextTaskID = 1065,
		startDialogID =	363,
		endDialogID = 369,
		taskType2 = TaskType2.Main,
		school = SchoolType.PLG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1000,   --玩家经验
			[TaskRewardList.pet_xp] = 1000,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 101 , x = 224, y = 115, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
					{
						{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20028,	mapID =	101, x = 224, y = 115,dir = WestSouth,},
						},
					},
				},
					},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 369},}, --在任务结束时打开一个对话框
			},
		},
	},



	----------------------------------------------紫阳门----------------------------
	[1024] = -----------紫阳门
	{

		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1025,	--任务后置任务没有填nil
		startDialogID =	148,	--接任务对话ID没有填nil
		endDialogID = 149,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 130,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 4000,    --绑银
			[TaskRewardList.player_pot] = 1200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8, x = 148, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 148, y	= 72,npcID = 20003,},},

			},
		},
	},
	[1025] =	--紫阳门
	{

		name = "打开百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1024},	--任务前置任务没有填nil
		nextTaskID = 1026,	--任务后置任务没有填nil
		startDialogID =	150,	--接任务对话ID没有填nil
		endDialogID = 151,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 280,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 5000,    --绑银
			[TaskRewardList.player_pot] = 1500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="getItem", param = {itemID = 1026034, count = 1,}},--获得物品
			},
		},
	},
		[1026] =	--紫阳门
	{

		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1025},	--任务前置任务没有填nil
		nextTaskID = 1027,	--任务后置任务没有填nil
		startDialogID =	152,	--接任务对话ID没有填nil
		endDialogID = 153,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 300,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 6000,    --绑银
			[TaskRewardList.player_pot] = 1800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 6 , x = 72, y = 101, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="doSwithScene", param = {tarMapID = 6,	x = 72, y = 101,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 135,npcID = 20008,},}, --寻路到掌门
			},
		},
	},
	[1027] =	--紫阳门
	{

		name = "苦练心法",	--任务名字
		startNpcID = 20008,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1026},	--任务前置任务没有填nil
		nextTaskID = 1054,	--任务后置任务没有填nil
		startDialogID =	154,	--接任务对话ID没有填nil
		endDialogID = 155,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 600,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 7000,    --绑银
			[TaskRewardList.player_pot] = 2100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 30101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 155},},
			},
		},
	},
	[1054] =	--紫阳门
	{

		name = "寻找大弟子",	--任务名字
		startNpcID = 20008,	--紫阳门掌门
		endNpcID = 20026,		--大弟子殿飞白
		preTaskData = {1027},
		nextTaskID = 1055,
		startDialogID =	192,
		endDialogID = 193,
		taskType2 = TaskType2.Main,
		school = SchoolType.ZYM,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 8000,    --绑银
			[TaskRewardList.player_pot] = 2400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 6, x = 43, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 6, x = 43, y	= 112,npcID = 20026,},},
			},
		},
	},
	
	[1055] =	----紫阳门
	{

		name = "捕捉宠物",	--任务名字
		startNpcID = 20026,	----大弟子殿飞白
		endNpcID = 20026,		--大弟子殿飞白
		preTaskData = {1054},
		nextTaskID = 1057,
		startDialogID =194	,
		endDialogID = 195,
		taskType2 = TaskType2.Main,
		school = SchoolType.ZYM,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 9000,    --绑银
			[TaskRewardList.player_pot] = 2700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 6 , x = 114, y = 47, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 6, x = 114, y = 47,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 6, scriptID = {101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
					}
				},
			},
			[TaskStatus.Done]		=
			{
				 {type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			      {type = "removeMine", param = {}}, -- 移除任务类
			},
		},
	},
	[1057] =	--紫阳门
	{

		name = "要事相商",	--任务名字
		startNpcID = 20026,	--大弟子殿飞白
		endNpcID = 20008,		--紫阳门掌门
		preTaskData = {1055},
		nextTaskID = 1058,
		startDialogID =	196,
		endDialogID = 197,
		taskType2 = TaskType2.Main,
		school = SchoolType.ZYM,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 6, x = 67, y = 135, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 6, x = 67, y	= 135,npcID = 20008,},},
			},
		},
	},
	[1058] =	--紫阳门
	{

		name = "前往桃园镇",	--任务名字
		startNpcID = 20008,	--紫阳门掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1057},
		nextTaskID = 1056,
		startDialogID =	156,
		endDialogID = 157,
		taskType2 = TaskType2.Main,
		school = SchoolType.ZYM,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 94, y = 34, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 6, x = 26, y = 72, tarMapID = 9, tarX = 94, tarY = 34},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
                {type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1058, index = 1},
							},
						},
				},
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
    [1056] =	--紫阳门
	{
		name = "寻找刘备",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1058}, 
		nextTaskID = 1065,
		startDialogID =	364,
		endDialogID = 370,
		taskType2 = TaskType2.Main,
		school = SchoolType.ZYM,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1000,   --玩家经验
			[TaskRewardList.pet_xp] = 1000,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 101 , x = 224, y = 115, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
					{
						{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20028,	mapID =	101, x = 224, y = 115,dir = WestSouth,},
						},
					},
				},
					},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 370},}, --在任务结束时打开一个对话框
			},
		},
	},

	----------------------------------------------云霄宫----------------------------
	[1029] = -----------云霄宫
	{

		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1030,	--任务后置任务没有填nil
		startDialogID =	158,	--接任务对话ID没有填nil
		endDialogID = 159,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 130,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 4000,    --绑银
			[TaskRewardList.player_pot] = 1200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8, x = 148, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 8, x = 148, y	= 72,npcID = 20003,},},

			},
		},
	},
	[1030] =	--云霄宫
	{

		name = "打开百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1029},	--任务前置任务没有填nil
		nextTaskID = 1031,	--任务后置任务没有填nil
		startDialogID =	160,	--接任务对话ID没有填nil
		endDialogID = 161,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 280,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 5000,    --绑银
			[TaskRewardList.player_pot] = 1500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="getItem", param = {itemID = 1026041, count = 1,}},--获得物品
			},
		},
	},
	[1031] =	--云霄宫
	{

		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1030},	--任务前置任务没有填nil
		nextTaskID = 1032,	--任务后置任务没有填nil
		startDialogID =	162,	--接任务对话ID没有填nil
		endDialogID = 163,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 300,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 6000,    --绑银
			[TaskRewardList.player_pot] = 1800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 5 , x = 50, y = 90, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="doSwithScene", param = {tarMapID = 5,	x = 50, y = 90,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 5, x = 43, y = 112,npcID = 20009,},}, --寻路到掌门
			},
		},
	},
	[1032] =	--云霄宫
	{

		name = "苦练心法",	--任务名字
		startNpcID = 20009,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1031},	--任务前置任务没有填nil
		nextTaskID = 1059,	--任务后置任务没有填nil
		startDialogID =	164,	--接任务对话ID没有填nil
		endDialogID = 165,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 600,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 7000,    --绑银
			[TaskRewardList.player_pot] = 2100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 60101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 165},},
			},
		},
	},
	[1059] =	--云霄宫
	{

		name = "寻找大弟子",	--任务名字
		startNpcID = 20009,	--云霄宫掌门
		endNpcID = 20024,		--大弟子玄素
		preTaskData = {1032},
		nextTaskID = 1060,
		startDialogID =	198,
		endDialogID = 199,
		taskType2 = TaskType2.Main,
		school = SchoolType.YXG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 8000,    --绑银
			[TaskRewardList.player_pot] = 2400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 5, x = 33, y = 77, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 5, x = 33, y	= 77,npcID = 20024,},},
			},
		},
	},
	
	[1060] =	----云霄宫
	{

		name = "捕捉宠物",	--任务名字
		startNpcID = 20024,	----大弟子玄素
		endNpcID = 20024,		--大弟子玄素
		preTaskData = {1059},
		nextTaskID = 1062,
		startDialogID =200	,
		endDialogID = 201,
		taskType2 = TaskType2.Main,
		school = SchoolType.YXG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 9000,    --绑银
			[TaskRewardList.player_pot] = 2700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 5 , x = 97, y = 25, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 5, x = 97, y = 25,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 5, scriptID = {101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
					}
				},
			},
			[TaskStatus.Done]		=
			{
				{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			{type = "removeMine", param = {}}, -- 移除任务类
			},
		},
	},
	[1062] =	--云霄宫
	{

		name = "要事相商",	--任务名字
	    startNpcID = 20024,	--大弟子玄素
		endNpcID = 20009,		--云霄宫掌门
		preTaskData = {1060},
		nextTaskID = 1063,
		startDialogID =	202,
		endDialogID = 203,
		taskType2 = TaskType2.Main,
		school = SchoolType.YXG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 5, x = 43, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{

				{type="autoTrace", param = {tarMapID	= 5, x = 43, y	= 112,npcID = 20009,},},
			},
		},
	},
	[1063] =	--云霄宫
	{

		name = "前往桃园镇",	--任务名字
		startNpcID = 20009,	--云霄宫掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1062},
		nextTaskID = 1061,
		startDialogID =	166,
		endDialogID = 167,
		taskType2 = TaskType2.Main,
		school = SchoolType.YXG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 900,   --玩家经验
			[TaskRewardList.pet_xp] = 900,      --宠物经验
			[TaskRewardList.subMoney] = 10000,    --绑银
			[TaskRewardList.player_pot] = 3000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 94, y = 34, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 5, x = 102, y = 103, tarMapID = 9, tarX = 94, tarY = 34},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
                {type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1063, index = 1},
							},
						},
				},
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
	[1061] =	--云霄宫
	{
		name = "寻找刘备",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1063}, 
		nextTaskID = 1065,
		startDialogID =	365,
		endDialogID = 371,
		taskType2 = TaskType2.Main,
		school = SchoolType.YXG,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1000,   --玩家经验
			[TaskRewardList.pet_xp] = 1000,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 101 , x = 224, y = 115, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
					{
						{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20028,	mapID =	101, x = 224, y = 115,dir = WestSouth,},
						},
					},
				},
					},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 371},}, --在任务结束时打开一个对话框
			},
		},
	},



[1065] =
	{

		name = "寻找关羽",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20032,		--任务结束npc
		preTaskData = {condition = "or",{1035,1041,1046,1051,1056,1061}},		--任务前置任务没有填nil
		nextTaskID = 1066,	--任务后置任务没有填nil
		startDialogID =	205,	--接任务对话ID没有填nil
		endDialogID = 208,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 11000,    --绑银
			[TaskRewardList.player_pot] = 3300,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets =
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 102,
				dialogID = 206,
				npcsData =			--刷出npc数据
				{
				},
				posData	= {mapID = 101,	x = 162, y = 50}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
			triggers = --任务触发器
			{
					[TaskStatus.Active] =
					{
						{type="deletePrivateNpc", ---------删除私有npc刘备
					param={
						npcs =
						{
							{npcID = 20028,	taskID = {1035,1041,1046,1051,1056,1061}, index = 1},
						},
					},
				},
						{type="createFollow", param = {npcs = {20028},}},  --刘备跟随
						{type="createPrivateNpc", ----------创建被怪物围住的关羽和第1波怪
						param={
						npcs =
						{
						    [1] = {npcID = 20031,mapID = 101, x = 162, y = 50,dir = WestNorth,},--马相
							[2] = {npcID = 20029,mapID = 101, x = 159, y = 53,dir = WestSouth,},
							[3] = {npcID = 20030,mapID = 101, x = 156, y = 53,dir = South,},
							[4] = {npcID = 20099,mapID = 101, x = 156, y = 47,dir = East,},
							[5] = {npcID = 20100,mapID = 101, x = 159, y = 47,dir = EastNorth,},
							[6] = {npcID = 20032,mapID = 101, x = 159, y = 50,dir = EastSouth,}, --被围困的关羽
						},
							},
						},
					},
				[TaskStatus.Done] =
				{
						{type="deletePrivateNpc", ----------删除参与战斗的5个npc
							param={
							npcs =
							{
							{npcID = 20031,	taskID = {1065}, index = 1},
							{npcID = 20029,	taskID = {1065}, index = 2},
							{npcID = 20030,	taskID = {1065}, index = 3},
							{npcID = 20099,	taskID = {1065}, index = 4},
							{npcID = 20100,	taskID = {1065}, index = 5},
							},
								},
						},
						{type="openDialog", param={dialogID = 208},}, --在任务结束时打开一个对话框
				},
		},
	},
[1066] =
	{
		name = "寻找张飞",	--任务名字
		startNpcID = 20032,	--任务起始npc
		endNpcID = 20037,		--任务结束npc
		preTaskData = {1065},	--任务前置任务没有填nil
		nextTaskID = 1067,	--任务后置任务没有填nil
		startDialogID =	208,	--接任务对话ID没有填nil
		endDialogID = 213,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2000,   --玩家经验
			[TaskRewardList.pet_xp] = 2000,      --宠物经验
			[TaskRewardList.subMoney] = 12000,    --绑银
			[TaskRewardList.player_pot] = 3600,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets =
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 103,
				dialogID = 209,
				npcsData =			--刷出npc数据
				{
					{npcID = 20033,	x = 109, y = 141, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20034,	x = 107, y = 145, noDelete = true},
					{npcID = 20034,	x = 110, y = 143, noDelete = true},
					{npcID = 20035,	x = 112, y = 141, noDelete = true},
					{npcID = 20035,	x = 114, y = 138, noDelete = true},
				},
				posData	= {mapID = 101,	x = 109, y = 141}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 104,
				dialogID = 211,
				npcsData =			--刷出npc数据
				{
				},
				posData	= {mapID = 101,	x = 139, y = 201}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
			triggers = --任务触发器
			{
					[TaskStatus.Active] =
					{
						{type="deletePrivateNpc", ---------删除私有npc关羽
					param={
						npcs =
						{
							{npcID = 20032,	taskID = {1065}, index = 6},
						},
					},
				},
						{type="createFollow", param = {npcs = {20032},}},  --关羽跟随
						{type="createPrivateNpc", ----------创建被怪物围住的张飞和第1波怪
						param={
						npcs =
						{
						    [1] = {npcID = 20036,mapID = 101, x = 139, y = 201,dir = South,},--杜远
							[2] = {npcID = 20035,mapID = 101, x = 135, y = 202,dir = EastSouth,},
							[3] = {npcID = 20101,mapID = 101, x = 138, y = 205,dir = WestNorth,},
							[4] = {npcID = 20102,mapID = 101, x = 132, y = 206,dir = EastSouth,},
							[5] = {npcID = 20034,mapID = 101, x = 135, y = 207,dir = WestSouth,},
							[6] = {npcID = 20037,mapID = 101, x = 135, y = 205,dir = South,}, --被围困的张飞
						},
							},
						},
					},

				[TaskStatus.Done] =
				{
						{type="deletePrivateNpc", ----------删除参与战斗的5个npc
							param={
							npcs =
							{
							{npcID = 20036,	taskID = {1066}, index = 1},
							{npcID = 20035,	taskID = {1066}, index = 2},
							{npcID = 20101,	taskID = {1066}, index = 3},
							{npcID = 20102,	taskID = {1066}, index = 4},
							{npcID = 20034,	taskID = {1066}, index = 5},
							},
								},
						},
						{type="openDialog", param={dialogID = 213},}, --在任务结束时打开一个对话框
				},
			},
	},
[1067] =
	{

		name = "击杀张梁",	--任务名字
		startNpcID = 20037,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1066},	--任务前置任务没有填nil
		nextTaskID = 1068,	--任务后置任务没有填nil
		startDialogID =	213,	--接任务对话ID没有填nil
		endDialogID = 216,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2000,   --玩家经验
			[TaskRewardList.pet_xp] = 2000,      --宠物经验
			[TaskRewardList.subMoney] = 12000,    --绑银
			[TaskRewardList.player_pot] = 3600,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets =
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 105,
				dialogID = 214,
				npcsData =			--刷出npc数据
				{
					{npcID = 20040,	x = 92, y = 200, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20038,	x = 89, y = 201, noDelete = true},
					{npcID = 20039,	x = 93, y = 197, noDelete = true},
				},
				posData	= {mapID = 101,	x = 92, y = 200}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
			triggers = --任务触发器
			{
					[TaskStatus.Active] =
					{
							{type="deletePrivateNpc", ---------删除私有npc张飞
					param={
						npcs =
						{
							{npcID = 20037,	taskID = {1066}, index = 6},
						},
					},
				},
						{type="createFollow", param = {npcs = {20037},}},  --张飞跟随
					},
				[TaskStatus.Done] =
				{
						{type="openDialog", param={dialogID = 216},}, --在任务结束时打开一个对话框
						{type="finishTask", param = {recetiveTaskID = 1068}},--触发完成任务接受下一个任务
				},
			},
	},
[1068] =
	{

		name = "诛杀程志远",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1067},	--任务前置任务没有填nil
		nextTaskID = 1069,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2000,   --玩家经验
			[TaskRewardList.pet_xp] = 2000,      --宠物经验
			[TaskRewardList.subMoney] = 13000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets =
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 106,
				dialogID = 217,
				npcsData =			--刷出npc数据
				{
					{npcID = 20043,	x = 174, y = 111, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20041,	x = 171, y = 109, noDelete = true},
					{npcID = 20041,	x = 176, y = 114, noDelete = true},
					{npcID = 20042,	x = 171, y = 112, noDelete = true},
					{npcID = 20042,	x = 173, y = 114, noDelete = true},
				},
				posData	= {mapID = 102,	x = 174, y = 111}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第2个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 107,
				dialogID = 219,
				npcsData =			--刷出npc数据
				{
					{npcID = 20044,	x = 122, y = 168, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20041,	x = 120, y = 166, noDelete = true},
					{npcID = 20042,	x = 123, y = 171, noDelete = true},
					{npcID = 20041,	x = 119, y = 169, noDelete = true},
					{npcID = 20042,	x = 121, y = 171, noDelete = true},
				},
				posData	= {mapID = 102,	x = 122, y = 168}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
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
						{type="finishTask", param = {recetiveTaskID = 1069}},--触发完成任务接受下一个任务
				},
			},
	},
[1069] =
	{

		name = "消灭张宝",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1068},	--任务前置任务没有填nil
		nextTaskID = 1070,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 223,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2000,   --玩家经验
			[TaskRewardList.pet_xp] = 2000,      --宠物经验
			[TaskRewardList.subMoney] = 13000,    --绑银
			[TaskRewardList.player_pot] = 3900,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets =
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第1个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 108,
				dialogID =221 ,
				npcsData =			--刷出npc数据    --击杀张宝
				{
					{npcID = 20045,	x = 153, y = 86, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20041,	x = 150, y = 89, noDelete = true},
					{npcID = 20042,	x = 150, y = 91, noDelete = true},
					{npcID = 20041,	x = 154, y = 89, noDelete = true},
					{npcID = 20042,	x = 156, y = 86, noDelete = true},
				},
				posData	= {mapID = 102,	x = 153, y = 86}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
			{
					[TaskStatus.Active] =
					{
						--{"createFollow", param = {npcs = {20037},}},  --张飞跟随
					},

				[TaskStatus.Done] =
				{
						{type="openDialog", param={dialogID = 223},}, --在任务结束时打开一个对话框
						{type="finishTask", param = {recetiveTaskID = 1070}},--触发完成任务接受下一个任务
				},
		},
	},
[1070] =
	{
		name = "岐山斗张角",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1069},	--任务前置任务没有填nil
		nextTaskID = 1071,	--任务后置任务没有填nil
		startDialogID =	223,	--接任务对话ID没有填nil
		endDialogID = 232,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 14000,    --绑银
			[TaskRewardList.player_pot] = 4200,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets =
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第1个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 109,
				dialogID =224 ,
				npcsData =			--刷出npc数据    --击杀张宝
				{
					{npcID = 20046,	x = 100, y = 104, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20041,	x = 97, y = 106, noDelete = true},
					{npcID = 20042,	x = 102, y = 101, noDelete = true},
					{npcID = 20041,	x = 101, y = 99, noDelete = true},
					{npcID = 20042,	x = 98, y = 102, noDelete = true},
				},
				posData	= {mapID = 102,	x = 100, y = 104}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第1个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 110,
				dialogID =226 ,
				npcsData =			--刷出npc数据    --击杀张宝
				{
					{npcID = 20047,	x = 66, y = 132, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20041,	x = 62, y = 132, noDelete = true},
					{npcID = 20042,	x = 69, y = 131, noDelete = true},
					{npcID = 20041,	x = 61, y = 131, noDelete = true},
					{npcID = 20042,	x = 72, y = 128, noDelete = true},
				},
				posData	= {mapID = 102,	x = 66, y = 132}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
			[3] = {type='Tmine',param =
			{
				mineIndex = 3,		--第1个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 113,     --张宝脚本战斗113  没有111 和112
				dialogID =228 ,
				npcsData =			--刷出npc数据    --击杀张宝
				{
					{npcID = 20048,	x = 57, y = 163, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
				},
				posData	= {mapID = 102,	x = 57, y = 163}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
	},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
					{
						--{"createFollow", param = {npcs = {20037},}},  --张飞跟随
				},
				[TaskStatus.Done] =
				{
				{type="openDialog", param={dialogID = 232},}, --在任务结束时打开一个对话框
				{type="deleteFollow", param = {npcs = {20028,20032,20037},}}, --在完成状态删除指定ID的npc跟随
				{type="createPrivateNpc", ----------创建站立在地图上面的刘关张
				param={
						npcs =
						{
							[1] = {npcID = 20028, mapID = 102, x = 50, y = 160,dir = EastSouth,}, --关羽
							[2] = {npcID = 20032, mapID = 102, x = 50, y = 162,dir = EastSouth,}, --刘备
							[3] = {npcID = 20037, mapID = 102, x = 50, y = 164,dir = EastSouth,}, --张飞
					},
				},
			},
		},
	},
},
[1071] =
	{

		name = "人间大劫",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20002,	--任务结束npc
		preTaskData = {1070},	--任务前置任务没有填nil
		nextTaskID = 1072,	--任务后置任务没有填nil
		startDialogID = 233,	--接任务对话ID没有填nil
		endDialogID = 235,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 1500,   --玩家经验
			[TaskRewardList.pet_xp] = 1500,      --宠物经验
			[TaskRewardList.subMoney] = 14000,    --绑银
			[TaskRewardList.player_pot] = 4200,  	--人物潜能
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
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 102, x = 24, y = 162, tarMapID = 8, tarX = 190, tarY = 143},--在接任务是创建私有传送阵
							},
						},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1071, index = 1},  --走到这个坐标点之后删除上一个任务的传送阵
							},
						},
				},
				{type="deletePrivateNpc", ----------删除张宝围困
				param={
						npcs =
						{
							{npcID = 20028,	taskID = {1070}, index = 1},
							{npcID = 20032,	taskID = {1070}, index = 2},
							{npcID = 20037,	taskID = {1070}, index = 3},
						},
					},
				},
			--{"autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --传送到坐标点之后 自动寻路到天尊处。
			{type="openDialog", param={dialogID = 234},}, --在任务结束时打开一个对话框
			},
		},
	},
[1072] =
	{

		name = "前往洛阳",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1071},	--任务前置任务没有填nil
		nextTaskID = 1073,	--任务后置任务没有填nil
		startDialogID = 236,	--接任务对话ID没有填nil
		endDialogID = 238,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2000,   --玩家经验
			[TaskRewardList.pet_xp] = 2000,      --宠物经验
			[TaskRewardList.subMoney] = 15000,    --绑银
			[TaskRewardList.player_pot] = 4500,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 10 , x = 115, y = 195, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 8, x =190, y =143, tarMapID = 10, tarX = 115, tarY = 195},
							},
						},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1072, index = 1},  --走到这个坐标点之后删除上一个任务的传送阵
							},
						},
				},
			{type="autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --传送到坐标点之后 自动寻路到天尊处。
			},
		},
	},
[1073] =
	{

		name = "斩杀蹇硕",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1072},	--任务前置任务没有填nil
		nextTaskID = 1074,	--任务后置任务没有填nil
		startDialogID = 240,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3500,   --玩家经验
			[TaskRewardList.pet_xp] = 3500,      --宠物经验
			[TaskRewardList.subMoney] = 15000,    --绑银
			[TaskRewardList.player_pot] = 4500,  	--人物潜能
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
				mineIndex = 1,		--第1个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 114,
				dialogID =241 ,
				npcsData =			--刷出npc数据
				{
					{npcID = 20052,	x = 137, y = 67, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20050,	x = 140, y = 67, noDelete = true},
					{npcID = 20050,	x = 140, y = 70, noDelete = true},
					{npcID = 20051,	x = 134, y = 70, noDelete = true},
					{npcID = 20051,	x = 134, y = 67, noDelete = true},
				},
				posData	= {mapID = 103,	x = 137, y = 67}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第1个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 115,
				dialogID =243 ,
				npcsData =			--刷出npc数据    --击杀张宝
				{
					{npcID = 20053,	x = 86, y = 144, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20050,	x = 89, y = 144, noDelete = true},
					{npcID = 20050,	x = 83, y = 144, noDelete = true},
					{npcID = 20051,	x = 83, y = 147, noDelete = true},
					{npcID = 20051,	x = 89, y = 147, noDelete = true},
				},
				posData	= {mapID = 103,	x = 86, y = 144}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="autoTrace", param = {tarMapID	= 103, x = 137, y = 67,npcID = 20052,},},
				{type="createPrivateTransfer", ------创建私有传送阵-- 从洛阳传送到御花园
					param={
							transfers =
							{
								[1] = {mapID = 10, x =21, y =230, tarMapID = 103, tarX = 140, tarY = 38},
							},
						},
				},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1073, index = 1},  --走到这个坐标点之后删除上一个任务的传送阵
							},
						},
				},
			--{"openDialog", param={dialogID = 245},}, --这句后面测试修改
			--{"autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --传送到坐标点之后 自动寻路到天尊处。
			{type="finishTask", param = {recetiveTaskID = 1074}},--触发完成任务接受下一个任务
			},
		},
	},
[1074] =
	{

		name = "怒斩十常侍",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1073},	--任务前置任务没有填nil
		nextTaskID = 1075,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 4000,   --玩家经验
			[TaskRewardList.pet_xp] = 4000,      --宠物经验
			[TaskRewardList.subMoney] = 16000,    --绑银
			[TaskRewardList.player_pot] = 4800,  	--人物潜能
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
				mineIndex = 1,		--第1个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 116,
				dialogID =246 ,
				npcsData =			--刷出npc数据
				{
					{npcID = 20056,	x = 164, y = 141, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20054,	x = 167, y = 141, noDelete = true},
					{npcID = 20054,	x = 167, y = 138, noDelete = true},
					{npcID = 20055,	x = 161, y = 138, noDelete = true},
					{npcID = 20055,	x = 161, y = 141, noDelete = true},
				},
				posData	= {mapID = 103,	x = 164, y = 141}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第1个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 117,
				dialogID =248 ,
				npcsData =			--刷出npc数据    --击杀张宝
				{
					{npcID = 20057,	x = 186, y = 43, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20054,	x = 189, y = 43, noDelete = true},
					{npcID = 20054,	x = 189, y = 40, noDelete = true},
					{npcID = 20055,	x = 183, y = 40, noDelete = true},
					{npcID = 20055,	x = 183, y = 43, noDelete = true},
				},
				posData	= {mapID = 103,	x = 186, y = 43}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="autoTrace", param = {tarMapID	= 103, x = 164, y = 141,npcID = 20056,},}, --寻路到第一个暗雷处
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			--{"openDialog", param={dialogID = 245},}, --在任务结束时打开一个对话框
			--{"autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --传送到坐标点之后 自动寻路到天尊处。
			{type="finishTask", param = {recetiveTaskID = 1075}},--触发完成任务接受下一个任务
			},
		},
	},
[1075] =	--御花园寻皇帝     --这个任务测试 是ok的
	{

		name = "御花园寻皇帝",	--任务名字
		startNpcID = nil,
		endNpcID = nil,		--张让头像之后刷出来的私有npc
		preTaskData = {1074},
		nextTaskID = 1076,
		startDialogID =	nil,
		endDialogID = nil,----杀完去找卢植
		taskType2 = TaskType2.Main,
		school = nil,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 4000,   --玩家经验
			[TaskRewardList.pet_xp] = 4000,      --宠物经验
			[TaskRewardList.subMoney] = 16000,    --绑银
			[TaskRewardList.player_pot] = 4800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TautoMeet',param = {mapID = 103 , x = 198, y = 141, bor =	false},},
			[2] = {type='Tscript',param = {scriptID	= 118 ,	count =	1, bor = true},}, --打一个脚本战斗(脚本战斗ID 203，次数)
			--[2] =	{type='Tscript',param =	{scriptID = 203	, count	= 2, ignoreResult = true, bor =	true},},--不论胜负
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 103, x = 198, y = 141,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 103, scriptID = {118},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
					}
				},
			},
			[TaskStatus.Done]		=
			{
				 {type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			      {type = "removeMine", param = {}}, -- 移除任务类
				--{"openDialog", param={dialogID = 252},}, --在完成目标之后自动打开对话
				{type="finishTask", param = {recetiveTaskID = 1076}},--触发完成任务接受下一个任务
				{type='Tarea',param = {mapID = 103 , x = 183, y = 198, bor = true},},--到达指定的坐标点

			},
		},
	},
[1076] =
	{

		name = "回禀卢植",	--任务名字
		startNpcID = nil,
		endNpcID =20049 ,		--找卢植
		preTaskData = {1075},
		nextTaskID = 1077,
		startDialogID =nil	,
		endDialogID = 255,
		taskType2 = TaskType2.Main,
		school =nil,
		level =	{1,150},--等级限制
			rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2000,   --玩家经验
			[TaskRewardList.pet_xp] = 2000,      --宠物经验
			[TaskRewardList.subMoney] = 15000,    --绑银
			[TaskRewardList.player_pot] = 4500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 103, x =183, y =198, tarMapID = 10, tarX = 116, tarY = 195},
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 255},}, --在任务结束时打开一个对话框
				{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1076, index = 1},
							},
						},
				},
			},
		},
},
[1077] =
	{
		name = "打探消息",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20059,	--任务结束npc
		preTaskData = {1076},	--任务前置任务没有填nil
		nextTaskID = 1078,	--任务后置任务没有填nil
		startDialogID = 256,	--接任务对话ID没有填nil
		endDialogID = 257,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 2500,   --玩家经验
			[TaskRewardList.pet_xp] = 2500,      --宠物经验
			[TaskRewardList.subMoney] = 17000,    --绑银
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 10 , x = 45, y = 188, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				--{"autoTrace", param = {tarMapID	= 10, x = 363 y = 191,npcID = 20060,},},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			--{"openDialog", param={dialogID = 1},}, --在任务结束时打开一个对话框
			--{"autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --传送到坐标点之后 自动寻路到天尊处。
			--{"autoTrace", param = {tarMapID	= 10, x = 363, y = 191,npcID = 20060,},},  --完成任务之后自动寻路到赵忠身边。
			--{type='Tarea',param = {mapID = 10 , x = 381, y = 174, bor = true},},--寻路到指定的坐标
			{type="openDialog", param={dialogID = 257},}, --在任务结束时打开一个对话框
			},
		},
	},
[1078] =
	{
		name = "质问赵忠",	--任务名字
		startNpcID = 20059,	--任务起始npc   --黄
		endNpcID = 20060,	--任务结束npc   --赵
		preTaskData = {1077},	--任务前置任务没有填nil
		nextTaskID = 1079,	--任务后置任务没有填nil
		startDialogID = 258,	--接任务对话ID没有填nil
		endDialogID = 262,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 6000,   --玩家经验
			[TaskRewardList.pet_xp] = 6000,      --宠物经验
			[TaskRewardList.subMoney] = 17000,    --绑银
			[TaskRewardList.player_pot] = 5100,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{

			--[1] = {type='Tscript',param = {scriptID	= 120 ,	count =	1, bor = true},},
			[1] = {type='Tscript',param = {scriptID	= 120 ,	count =	1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 120 次数)

		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="autoTrace", param = {tarMapID	= 10, x = 363, y = 191,npcID = 20060,},},  --接受任务的时候自动寻路到赵忠身边
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			--{"autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --传送到坐标点之后 自动寻路到天尊处。
			--{type='Tarea',param = {mapID = 10 , x = 381, y = 174, bor = true},},--寻路到洛阳传送到黑风岭的指定的坐标
			{type="openDialog", param={dialogID = 262},}
			},
		},
	},
[1079] =
	{
		name = "前往黑风岭",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1078},	--任务前置任务没有填nil
		nextTaskID = 1080,	--任务后置任务没有填nil
		startDialogID = 263,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 7000,   --玩家经验
			[TaskRewardList.pet_xp] = 7000,      --宠物经验
			[TaskRewardList.subMoney] = 18000,    --绑银
			[TaskRewardList.player_pot] = 5400,  	--人物潜能
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
				mineIndex = 1,		--第1个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 121,
				dialogID =264 ,
				npcsData =			--刷出npc数据
				{
					{npcID = 20061,	x = 202, y = 41, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20062,	x = 200, y = 41, noDelete = true},
					{npcID = 20062,	x = 205, y = 39, noDelete = true},
					{npcID = 20063,	x = 198, y = 41, noDelete = true},
					{npcID = 20063,	x = 208, y = 36, noDelete = true},
				},
				posData	= {mapID = 104,	x = 202, y = 41}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第1个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 122,
				dialogID =266 ,
				npcsData =			--刷出npc数据   --张泽
				{
					{npcID = 20064,	x = 171, y = 121, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20062,	x = 171, y = 118, noDelete = true},
					{npcID = 20062,	x = 168, y = 124, noDelete = true},
					{npcID = 20063,	x = 166, y = 122, noDelete = true},
					{npcID = 20063,	x = 167, y = 118, noDelete = true},
				},
				posData	= {mapID = 104,	x = 171, y = 121}, --踩雷坐标
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
			{type="finishTask", param = {recetiveTaskID = 1080}},--触发完成任务接受下一个任务
			},
		},
	},
[1080] =
	{
		name = "剿灭黑山贼",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1079},	--任务前置任务没有填nil
		nextTaskID = 1081,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 7000,   --玩家经验
			[TaskRewardList.pet_xp] = 7000,      --宠物经验
			[TaskRewardList.subMoney] = 18000,    --绑银
			[TaskRewardList.player_pot] = 5400,  	--人物潜能
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
				mineIndex = 1,		--第1个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 124,
				dialogID =272 ,
				npcsData =			--刷出npc数据
				{
					{npcID = 20067,	x = 68, y = 163, noDelete = true,},--张燕
					{npcID = 20065,	x = 67, y = 161, noDelete = true},
					{npcID = 20065,	x = 64, y = 167, noDelete = true},
					{npcID = 20066,	x = 63, y = 165, noDelete = true},
					{npcID = 20066,	x = 62, y = 163, noDelete = true},
				},
				posData	= {mapID = 104,	x = 68, y = 163}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
				{type="autoTrace", param = {tarMapID	= 104, x = 68, y = 163,npcID = 20061,},},  --接受任务的时候自动寻路到赵忠身边
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20067,	mapID =	104, x = 68, y = 163,dir = South,},
						},
					},    --逃跑的怪物都要创建一个私有的npc< 等下一个任务的时候再删除。
				},
			--{"autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --传送到坐标点之后 自动寻路到天尊处。
			{type="finishTask", param = {recetiveTaskID = 1081}},--触发完成任务接受下一个任务
			},
		},
	},
[1081] =
	{
		name = "恶战黑风老妖",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1080},	--任务前置任务没有填nil
		nextTaskID = {1082,1084,1086,1088,1090,1092},	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 7500,   --玩家经验
			[TaskRewardList.pet_xp] = 7500,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
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
				mineIndex = 1,		--第1个雷
				lastMine = false,	--是否为最后一个雷
				scriptID= 125,
				dialogID =275 ,
				npcsData =			--刷出npc数据
				{
					{npcID = 20068,	x = 119, y = 148, noDelete = true,},--张燕
					{npcID = 20065,	x = 116, y = 151, noDelete = true},
					{npcID = 20065,	x = 121, y = 150, noDelete = true},
					{npcID = 20066,	x = 115, y = 154, noDelete = true},
					{npcID = 20066,	x = 119, y = 154, noDelete = true},
				},
				posData	= {mapID = 104,	x = 119, y = 148}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第2个雷
				lastMine = true,	--是否为最后一个雷
				scriptID= 126,
				dialogID =277 ,
				lostTransfer = {mapID = 104, x = 195, y = 13},--------新加，暗雷玩家战斗逃跑，传送到指定地图
				npcsData =			--刷出npc数据
				{
					{npcID = 20069,	x = 86, y = 191, noDelete = true,},--黑风老妖
				},
				posData	= {mapID = 104,	x = 86, y = 191}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[3] = {type='Tarea',param = {mapID = 104, x = 195, y = 13, bor = true},},-------到达指定坐标
			},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
				{type="deletePrivateNpc", ---------删除张燕
				param={
						npcs =
						{
							{npcID = 20067,	taskID = {1080}, index = 1},
						},
					},
				},
			{type="finishTask", param = {recetiveTaskID = {1082,1084,1086,1088,1090,1092}}},--触发完成任务接受下一个任务
			},
		},
	},
	----------------------------------------------------乾元岛
	[1082] =	--乾元岛
	{

		name = "另寻他法",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1082,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 280,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 1 , x = 44, y = 85, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="doSwithScene", param = {tarMapID = 1,	x = 44, y = 85,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 1, x = 26, y = 84,npcID = 20004,},}, --寻路到掌门
			},
		},
	},
	[1083] =	--乾元岛
	{

		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1082},	--任务前置任务没有填nil
		nextTaskID = 1094,	--任务后置任务没有填nil
		startDialogID =	281,	--接任务对话ID没有填nil
		endDialogID = 283,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 112 , x = 190, y = 142, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 1, x = 132, y = 44, tarMapID = 112, tarX = 190, tarY = 142},--在接任务是创建私有传送阵
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1083, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 112, x = 134, y = 219,npcID = 20070,},}, --寻路到祖师
			},
		},
	},
	----------------------------------------------------桃源洞
	[1084] =	--桃源洞
	{

		name = "另寻他法",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1085,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 284,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 4 , x = 78, y = 70, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
            {type="doSwithScene", param = {tarMapID = 4,	x = 78, y = 70,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 4, x = 60, y = 72,npcID = 20005,},}, --寻路到掌门
			},
		},
	},
	[1085] =	--桃源洞
	{

		name = "拜访玉泉天",	--任务名字
		startNpcID = 20005,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1084},	--任务前置任务没有填nil
		nextTaskID = 1094,	--任务后置任务没有填nil
		startDialogID =	285,	--接任务对话ID没有填nil
		endDialogID = 287,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 112 , x = 190, y = 142, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 4, x = 98, y = 9, tarMapID = 112, tarX = 190, tarY = 142},--在接任务是创建私有传送阵
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1085, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 112, x = 134, y = 219,npcID = 20070,},}, --寻路到祖师
			},
		},
	},
	----------------------------------------------------金霞山
	[1086] =	--金霞山
	{

		name = "另寻他法",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1087,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 288,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 3 , x = 39, y = 82, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="doSwithScene", param = {tarMapID = 3,	x = 39, y = 82,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1086, index = 1},
							},
						},
			},
			{type="autoTrace", param = {tarMapID	= 3, x = 28, y = 92,npcID = 20006,},}, --寻路到掌门
			},
		},
	},
	[1087] =	--金霞山
	{

		name = "拜访玉泉天",	--任务名字
		startNpcID = 20006,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1086},	--任务前置任务没有填nil
		nextTaskID = 1094,	--任务后置任务没有填nil
		startDialogID =	289,	--接任务对话ID没有填nil
		endDialogID = 291,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 112 , x = 190, y = 142, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 3, x = 101, y = 12, tarMapID = 112, tarX = 190, tarY = 142},--在接任务是创建私有传送阵
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1087, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 112, x = 134, y = 219,npcID = 20070,},}, --寻路到祖师
			},
		},
	},
	----------------------------------------------------蓬莱阁
	[1088] =	--蓬莱阁
	{

		name = "另寻他法",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1089,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 292,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 2 , x = 86, y = 100, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="doSwithScene", param = {tarMapID = 2,	x = 86, y = 100,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 2, x = 84, y = 124,npcID = 20007,},}, --寻路到掌门
			},
		},
	},
	[1089] =	--蓬莱阁
	{

		name = "拜访玉泉天",	--任务名字
		startNpcID = 20007,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1088},	--任务前置任务没有填nil
		nextTaskID = 1094,	--任务后置任务没有填nil
		startDialogID =	293,	--接任务对话ID没有填nil
		endDialogID = 295,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 112 , x = 190, y = 142, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 2, x = 14, y = 99, tarMapID = 112, tarX = 190, tarY = 142},--在接任务是创建私有传送阵
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1089, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 112, x = 134, y = 219,npcID = 20070,},}, --寻路到祖师
			},
		},
	},
	----------------------------------------------------紫阳门
	[1090] =	--紫阳门
	{

		name = "另寻他法",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1091,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 296,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 6 , x = 72, y = 101, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="doSwithScene", param = {tarMapID = 6,	x = 72, y = 101,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 133,npcID = 20008,},}, --寻路到掌门
			},
		},
	},
	[1091] =	--紫阳门
	{

		name = "拜访玉泉天",	--任务名字
		startNpcID = 20008,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1090},	--任务前置任务没有填nil
		nextTaskID = 1094,	--任务后置任务没有填nil
		startDialogID =	297,	--接任务对话ID没有填nil
		endDialogID = 299,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 112 , x = 190, y = 142, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 6, x = 27, y = 72, tarMapID = 112, tarX = 190, tarY = 142},--在接任务是创建私有传送阵
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1091, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 112, x = 134, y = 219,npcID = 20070,},}, --寻路到祖师
			},
		},
	},
	----------------------------------------------------云霄宫
	[1092] =	--云霄宫
	{

		name = "另寻他法",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1093,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 300,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 5 , x = 50, y = 90, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="doSwithScene", param = {tarMapID = 5,	x = 50, y = 90,}},	--传送到另一个场景
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 5, x = 44, y = 111,npcID = 20009,},}, --寻路到掌门
			},
		},
	},
	[1093] =	--云霄宫
	{

		name = "拜访玉泉天",	--任务名字
		startNpcID = 20009,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1092},	--任务前置任务没有填nil
		nextTaskID = 1094,	--任务后置任务没有填nil
		startDialogID =	301,	--接任务对话ID没有填nil
		endDialogID = 303,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 19000,    --绑银
			[TaskRewardList.player_pot] = 5700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 112 , x = 190, y = 142, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 5, x = 102, y = 103, tarMapID = 112, tarX = 190, tarY = 142},--在接任务是创建私有传送阵
							},
						},
				},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1093, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 112, x = 134, y = 219,npcID = 20070,},}, --寻路到祖师
			},
		},
	},
-----------------------------------------------------------------------------------------------
    [1094] =
	{

		name = "收获强援",	--任务名字
		startNpcID = 20070,	--任务起始npc
		endNpcID = 20071,		--任务结束npc
		preTaskData = {condition = "or",{1083,1085,1087,1089,1091,1093}},		--任务前置任务没有填nil
		nextTaskID = 1095,	--任务后置任务没有填nil
		startDialogID =	304,	--接任务对话ID没有填nil
		endDialogID = 305,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 3000,   --玩家经验
			[TaskRewardList.pet_xp] = 3000,      --宠物经验
			[TaskRewardList.subMoney] = 20000,    --绑银
			[TaskRewardList.player_pot] = 6000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 104 , x = 39, y = 191, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 112, x = 190, y = 141, tarMapID = 104, tarX = 30, tarY = 189},--在接任务是创建私有传送阵
							},
						},
				},
			{type="createPrivateNpc", ----------创建杨戬
				param={
						npcs =
						{
							[1] = {npcID = 20071, mapID = 104, x = 39,  y = 191,dir = South,}, --杨戬
					},
				},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1094, index = 1},
						},
					},
			},
			{type="openDialog", param={dialogID = 305},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1095] =
	{

		name = "恶战黑风老妖",	--任务名字
		startNpcID = 20071,	--任务起始npc
		endNpcID = 20059,	--任务结束npc
		preTaskData = {1094},	--任务前置任务没有填nil
		nextTaskID = 1096,	--任务后置任务没有填nil
		startDialogID = 306,	--接任务对话ID没有填nil
		endDialogID = 313,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 7500,   --玩家经验
			[TaskRewardList.pet_xp] = 7500,      --宠物经验
			[TaskRewardList.subMoney] = 20000,    --绑银
			[TaskRewardList.player_pot] = 6000,  	--人物潜能
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
				scriptID = 127,
				lastMine = true,	--是否为最后一个雷
				dialogID = 307,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20103, x = 86, y = 191,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
				},
				posData = {mapID = 104, x = 86, y = 191}, --踩雷坐标
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
							{npcID = 20071,	taskID = {1094}, index = 1}, --删除私有杨戬
						},
					},
				},
			{type="createFollow", param = {npcs = {20071},}},				--添加杨戬跟随
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deleteFollow", param = {npcs = {20071},}}, --在接任务删除杨任的npc跟随
			{type="createPrivateNpc", ----------创建黑风老妖
				param={
						npcs =
						{
							[1] = {npcID = 20103, mapID = 104, x = 86,  y = 191,dir = WestNorth,}, --黑风老妖
							[2] = {npcID = 20071, mapID = 104, x = 82,  y = 196,dir = South,},
					},
				},
			},
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 104, x =30, y =189, tarMapID = 10, tarX = 202, tarY = 193},
							},
						},
			},
			{type="openDialog", param={dialogID = 311},}, --在任务结束时打开一个对话框
			},
		},
	},
    [1096] =
	{

		name = "打败小头目樊定",	--任务名字
		startNpcID = 20059,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1095},		--任务前置任务没有填nil
		nextTaskID = 1097,	--任务后置任务没有填nil
		startDialogID =	314,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 7500,   --玩家经验
			[TaskRewardList.pet_xp] = 7500,      --宠物经验
			[TaskRewardList.subMoney] = 20000,    --绑银
			[TaskRewardList.player_pot] = 6000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =
			{
				mineIndex = 1,		--第一个雷
				scriptID = 128,
				lastMine = true,	--是否为最后一个雷
				dialogID = 315,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20074, x = 87, y = 141,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20072, x = 85, y = 139,  noDelete = true},
					{npcID = 20072, x = 89, y = 143,  noDelete = true},
					{npcID = 20073, x = 83, y = 143,  noDelete = true},
					{npcID = 20073, x = 85, y = 145,  noDelete = true},
				},
				posData = {mapID = 105, x = 87, y = 141}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 10, x = 228, y = 15, tarMapID = 105, tarX = 183, tarY = 8},--在接任务是创建私有传送阵
							},
						},
				},
			{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1095, index = 1},
							},
						},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateNpc", ----------删除杨戬、黑风老妖
				param={
						npcs =
						{
							{npcID = 20103,	taskID = {1095}, index = 1},
							{npcID = 20071,	taskID = {1095}, index = 2},
						},
					},
				},
			{type="createPrivateNpc", ----------创建樊定
				param={
						npcs =
						{
							[1] = {npcID = 20074, mapID = 105, x = 87,  y = 141,dir = South,}, --樊定
					},
				},
			},
			{type="openDialog", param={dialogID = 317},}, --在任务结束时打开一个对话框
			{type="deletePrivateTransfer", ----------删除删除私有传送阵
				param={
						transfers =
						{
							{taskID = 1096, index = 1},
						},
					},
			},
			{type="finishTask", param = {recetiveTaskID = 1097}},--触发完成任务接受下一个任务
			},
		},
	},
	[1097] =
	{

		name = "打败樊稠",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1096},	--任务前置任务没有填nil
		nextTaskID = 1098,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 21000,    --绑银
			[TaskRewardList.player_pot] = 6300,  	--人物潜能
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
				scriptID = 129,
				lastMine = false,	--是否为最后一个雷
				dialogID = 318,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20075, x = 112, y = 262,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20072, x = 110, y = 265,  noDelete = true},
					{npcID = 20072, x = 115, y = 259,  noDelete = true},
					{npcID = 20073, x = 113, y = 265,  noDelete = true},
					{npcID = 20073, x = 115, y = 262,  noDelete = true},
				},
				posData = {mapID = 105, x = 112, y = 262}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 130,
				lastMine = true,	--是否为最后一个雷
				dialogID = 320,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20076, x = 132, y = 174,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20072, x = 135, y = 171,  noDelete = true},
					{npcID = 20072, x = 130, y = 177,  noDelete = true},
					{npcID = 20073, x = 129, y = 175,  noDelete = true},
					{npcID = 20073, x = 132, y = 171,  noDelete = true},
				},
				posData = {mapID = 105, x = 132, y = 174}, --踩雷坐标
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
			{type="deletePrivateNpc", ----------删除樊定
				param={
						npcs =
						{
							{npcID = 20074,	taskID = {1096}, index = 1},
						},
					},
				},
			{type="createPrivateNpc", ----------创建私有樊稠
					param={
						npcs =
						{
								[1] = {npcID = 20076,mapID = 105, x = 132, y = 174,dir = East,},
						},
					},
			},
			{type="openDialog", param={dialogID = 323},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1098}},--触发完成任务接受下一个任务
			},
	},
	},
	[1098] =
	{

		name = "勇闯长安",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20059,	--任务结束npc
		preTaskData = {1097},	--任务前置任务没有填nil
		nextTaskID = 1099,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 330,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 21000,    --绑银
			[TaskRewardList.player_pot] = 6300,  	--人物潜能
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
				scriptID = 131,
				lastMine = false,	--是否为最后一个雷
				dialogID = 325,        --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20079, x = 202, y = 166,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20077, x = 205, y = 164,  noDelete = true},
					{npcID = 20077, x = 199, y = 168,  noDelete = true},
					{npcID = 20078, x = 204, y = 168,  noDelete = true},
					{npcID = 20078, x = 201, y = 170,  noDelete = true},
				},
				posData = {mapID = 105, x = 202, y = 166}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 132,
				lastMine = true,	--是否为最后一个雷
				dialogID = 327,     --动作结束打开的对话框
				lostTransfer = {mapID = 10, x = 196, y = 193},--------新加，暗雷玩家战斗逃跑，传送到指定地图
				npcsData =			--刷出npc数据
				{
					{npcID = 20080, x = 229, y = 110,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
				},
				posData = {mapID = 105, x = 229, y = 110}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[3] = {type='Tarea',param = {mapID = 10, x = 196, y = 193, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
            [TaskStatus.Active]		=      ---接任务状态
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc", ----------删除樊稠
				param={
						npcs =
						{
							{npcID = 20076,	taskID = {1097}, index = 1},
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 10, x = 45, y = 188,npcID = 20059,},}, --寻路到皇甫嵩
			},
	},
	},
	[1099] =
	{

		name = "洛阳求教",	--任务名字
		startNpcID = 20059,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1098},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	330,	--接任务对话ID没有填nil
		endDialogID = 332,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 4000,   --玩家经验
			[TaskRewardList.pet_xp] = 4000,      --宠物经验
			[TaskRewardList.subMoney] = 22000,    --绑银
			[TaskRewardList.player_pot] = 6600,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 10 , x = 43, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20006,},}, --寻路到掌门
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 332},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1100] =
	{

		name = "联络群雄",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1099},	--任务前置任务没有填nil
		nextTaskID = 1121,	--任务后置任务没有填nil
		startDialogID = 333,	--接任务对话ID没有填nil
		endDialogID = 338,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 10000,   --玩家经验
			[TaskRewardList.pet_xp] = 10000,      --宠物经验
			[TaskRewardList.subMoney] = 22000,    --绑银
			[TaskRewardList.player_pot] = 6600,  	--人物潜能
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
				scriptID = 133,
				lastMine = true,	--是否为最后一个雷
				dialogID = 334,     --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 10, x = 166, y = 245}, --踩雷坐标
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
								[1] = {npcID = 20083,mapID = 10, x = 166, y = 245,dir = EastSouth,},
						},
				},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="openDialog", param={dialogID = 337},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1121] =
	{

		name = "质问李肃",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1100},	--任务前置任务没有填nil
		nextTaskID = 1122,	--任务后置任务没有填nil
		startDialogID = 338,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 12000,   --玩家经验
			[TaskRewardList.pet_xp] = 12000,      --宠物经验
			[TaskRewardList.subMoney] = 23000,    --绑银
			[TaskRewardList.player_pot] = 6900,  	--人物潜能
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
				scriptID = 134,
				lastMine = true,	--是否为最后一个雷
				dialogID = 339,     --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20086, x = 207, y = 140, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
				},
				posData = {mapID = 106, x = 207, y = 140}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="deletePrivateNpc", ----------删除张宝围困
				param={
						npcs =
						{
							{npcID = 20083,	taskID = {1100}, index = 1},
						},
					},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20086,mapID = 106, x = 207, y = 140,dir = EastNorth,},
						},
					},
			},
			{type="openDialog", param={dialogID = 337},}, --在任务结束时打开一个对话框--需修改
            {type="finishTask", param = {recetiveTaskID = 1122}},--触发完成任务接受下一个任务
			},
		},
	},
	[1122] =
	{

		name = "营救袁绍",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20091,	--任务结束npc
		preTaskData = {1121},	--任务前置任务没有填nil
		nextTaskID = 1123,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 345,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 12000,   --玩家经验
			[TaskRewardList.pet_xp] = 12000,      --宠物经验
			[TaskRewardList.subMoney] = 23000,    --绑银
			[TaskRewardList.player_pot] = 6900,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		   [1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 135,
				dialogID = 341,
				npcsData =			--刷出npc数据
				{
					{npcID = 20089, x = 225, y = 78,  noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20087, x = 229, y = 75,  noDelete = true},
					{npcID = 20087, x = 222, y = 81,  noDelete = true},
					{npcID = 20088, x = 222, y = 78,  noDelete = true},
					{npcID = 20088, x = 226, y = 74,  noDelete = true},
				},
				posData	= {mapID = 106, x = 225, y = 78}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
          [2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 136,
				lastMine = true,	--是否为最后一个雷
				dialogID = 343,     --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 106, x = 163, y = 84}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
            {type="createPrivateNpc", ----------创建袁绍被小怪包围
					param={
						npcs =
						{
								[1] = {npcID = 20090,	mapID =	106, x = 163, y = 84,dir = WastSouth,},--侯成
								[2] = {npcID = 20087,	mapID =	106, x = 166, y = 82,dir = Wast,},
								[3] = {npcID = 20088,	mapID =	106, x = 167, y = 78,dir = WastNorth,},
								[4] = {npcID = 20104,	mapID =	106, x = 161, y = 82,dir = EastSouth,},
								[5] = {npcID = 20105,	mapID =	106, x = 162, y = 78,dir = EastSouth,},
								[6] = {npcID = 20091,	mapID =	106, x = 164, y = 80,dir = EastNouth,},--袁绍
						},
					},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deletePrivateNpc", ----------删除袁绍围困
				param={
						npcs =
						{
                            {npcID = 20086,	taskID = {1121}, index = 1},----上一个任务创建的私有NPC李肃
							{npcID = 20090,	taskID = {1122}, index = 1},
							{npcID = 20087,	taskID = {1122}, index = 2},
							{npcID = 20088,	taskID = {1122}, index = 3},
							{npcID = 20104,	taskID = {1122}, index = 4},
							{npcID = 20105,	taskID = {1122}, index = 5},
						},
					},
			},
			{type="openDialog", param={dialogID = 345},}, --在任务结束时打开一个对话框--需修改
			},
		},
	},
	[1123] =
	{

		name = "逃离楣坞",	--任务名字
		startNpcID = 20091,	--任务起始npc
		endNpcID = 20091,	--任务结束npc
		preTaskData = {1122},	--任务前置任务没有填nil
		nextTaskID = 1124,	--任务后置任务没有填nil
		startDialogID = 346,	--接任务对话ID没有填nil
		endDialogID = 351,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 15000,   --玩家经验
			[TaskRewardList.pet_xp] = 15000,      --宠物经验
			[TaskRewardList.subMoney] = 24000,    --绑银
			[TaskRewardList.player_pot] = 7200,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		   [1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 137,
				dialogID = 347,
				npcsData =			--刷出npc数据
				{
					{npcID = 20094, x = 153, y = 184,  noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20092, x = 156, y = 185,  noDelete = true},
					{npcID = 20092, x = 150, y = 184,  noDelete = true},
					{npcID = 20093, x = 153, y = 188,  noDelete = true},
					{npcID = 20093, x = 150, y = 187,  noDelete = true},
				},
				posData	= {mapID = 106, x = 153, y = 184}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
          [2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 138,
				lastMine = true,	--是否为最后一个雷
				dialogID = 349,     --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				    {npcID = 20095, x = 114, y = 195,  noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20092, x = 117, y = 195,  noDelete = true},
					{npcID = 20092, x = 111, y = 195,  noDelete = true},
					{npcID = 20093, x = 116, y = 192,  noDelete = true},
					{npcID = 20093, x = 113, y = 192,  noDelete = true},
				},
				posData = {mapID = 106, x = 114, y = 195}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="deletePrivateNpc", ----------删除袁绍
				param={
						npcs =
						{
							{npcID = 20091,	taskID = {1122}, index = 6},
						},
					},
			},
			{type="createFollow", param = {npcs = {20091},}},				--创建指定npc跟随(参数npcID)
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deleteFollow", param = {npcs = {20091},}}, --在完成状态删除指定ID的npc跟随
			{type="createPrivateNpc", ----------创建袁绍
					param={
						npcs =
						{
								[1] = {npcID = 20091,	mapID =	106, x = 114, y = 195,dir = EastSouth,},
						},
					},
			},
			{type="openDialog", param={dialogID = 351},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1124] =
	{

		name = "大破楣坞关",	--任务名字
		startNpcID = 20091,	--任务起始npc
		endNpcID = 20091,	--任务结束npc
		preTaskData = {1123},	--任务前置任务没有填nil
		nextTaskID = 1125,	--任务后置任务没有填nil
		startDialogID = 352,	--接任务对话ID没有填nil
		endDialogID = 357,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 15000,   --玩家经验
			[TaskRewardList.pet_xp] = 15000,      --宠物经验
			[TaskRewardList.subMoney] = 24000,    --绑银
			[TaskRewardList.player_pot] = 7200,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		   [1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 140,     --缺少这场战斗ID
				dialogID = 353,
				npcsData =			--刷出npc数据
				{
					{npcID = 20097, x = 99, y = 148, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20092, x = 99, y = 150, noDelete = true},
					{npcID = 20092, x = 99, y = 145, noDelete = true},
					{npcID = 20093, x = 96, y = 147, noDelete = true},
					{npcID = 20093, x = 96, y = 150, noDelete = true},
				},
				posData	= {mapID = 106, x = 99, y = 148}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
          [2] = {type='Tmine',param =
			{
				mineIndex = 2,		--第一个雷
				scriptID = 139,
				lastMine = true,	--是否为最后一个雷
				dialogID = 355,     --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				    {npcID = 20096, x = 128, y = 81,  noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20092, x = 130, y = 83, noDelete = true},
					{npcID = 20092, x = 126, y = 79, noDelete = true},
					{npcID = 20093, x = 129, y = 78, noDelete = true},
					{npcID = 20093, x = 131, y = 80, noDelete = true},
				},
				posData = {mapID = 106, x = 128, y = 81}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态
			{
			{type="deletePrivateNpc", ----------删除袁绍
				param={
						npcs =
						{
							{npcID = 20091,	taskID = {1123}, index = 1},
						},
					},
			},
			{type="createFollow", param = {npcs = {20091},}},				--创建指定npc跟随(参数npcID)
			},
			[TaskStatus.Done]		=      ---完成目标状态
			{
			{type="deleteFollow", param = {npcs = {20091},}}, --在完成状态删除指定ID的npc跟随
			{type="createPrivateNpc", ----------创建袁绍
					param={
						npcs =
						{
								[1] = {npcID = 20091,	mapID =	106, x = 131, y = 83,dir = West,},
						},
					},
			},
			{type="openDialog", param={dialogID = 357},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1125] =
	{

		name = "回复卢植",	--任务名字
		startNpcID = 20091,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1124},	--任务前置任务没有填nil
		nextTaskID = 1101,	--任务后置任务没有填nil
		startDialogID =	358,	--接任务对话ID没有填nil
		endDialogID = 359,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 25000,    --绑银
			[TaskRewardList.player_pot] = 7500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 359},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", ----------删除袁绍
				param={
						npcs =
						{
							{npcID = 20091,	taskID = {1124}, index = 1},
						},
					},
			},
			},
		},
	},


}

table.copy(MainTaskDB1_20, NormalTaskDB)