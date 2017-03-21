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
		startNpcID = nil,
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
		consume	={},
		targets	={},
		triggers =
		{
			[TaskStatus.Done]		=
			{
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
		startDialogID =	nil,
		endDialogID = 103,
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor =	false},},-------到达指定坐标
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
		nextTaskID = {1004,1014,1024,1034,1044,1054},--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 107,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 240,   --玩家经验
			--[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 3000,    --绑银
			[TaskRewardList.player_pot] = 900000,  	--人物潜能
		},
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript',param = {scriptID	= 100 ,	count =1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="openDialog", param={dialogID = 107},}, --在任务结束时打开一个对话框
			},
		},
	},
----------------------------------------------开始分门派--------------------------------------
----------------------------------------------乾元岛--------------------------------------
	[1004] = -----------乾元岛
	{
		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1006,	--任务后置任务没有填nil
		startDialogID =nil,--452	--接任务对话ID没有填nil
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
		consume	={},
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
	--[[[1005] =	--乾元岛
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1004},	--任务前置任务没有填nil
		nextTaskID = 1006,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type = "TgetItem", param = {itemID = 1026006, count = 1 ,bor = true},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026006, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 111},},--在任务结束时打开一个对话框
			},
		},
	},]]
	[1006] =	--乾元岛
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1004},	--任务前置任务没有填nil
		nextTaskID = 1007,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 113,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		--穿戴指定物品及装备目标（可以写多个）
		[1] = {type='TwearEquip',param = {equipID	= 2001086, bor = false},},--武器
		[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
		[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
		[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
		[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
		[6] = {type='TwearEquip',param = {equipID	= 2001095, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
			{type="getItem", param = {itemID = 1026006, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 113},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1007] =	--乾元岛
	{
		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = {1006},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1008,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 116,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 1 , x = 26, y = 84, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type = "flyEffect", param = {flyEffectID = 101}},--飞剑动画
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 1, x = 26, y = 84,npcID = 20004,},}, --寻路到掌门
			},
		},
	},
	[1008] =	--乾元岛
	{
		name = "苦练心法",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = {1007},	--任务前置任务没有填nil
		nextTaskID = 1009,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 118,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 20101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 118},},--在任务结束时打开一个对话框
			},
		},
	},
	[1009] =	--乾元岛
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20004,	--乾元岛掌门
		endNpcID = 20021,		--大弟子乾元岛段岳
		preTaskData = {1008},--任务前置任务没有填nil
		nextTaskID = 1010,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 120,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 1, x = 32, y = 76, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 120},},--在任务结束时打开一个对话框
			},
		},
	},
	[1010] =	----乾元岛
	{
		name = "捕捉宠物",	--任务名字
		startNpcID = 20021,	--乾元岛掌门
		endNpcID = 20021,		--大弟子乾元岛段岳
		preTaskData = {1009},--任务前置任务没有填nil
		nextTaskID = 1011,--任务后置任务没有填nil
		startDialogID =nil,--接任务对话ID没有填nil
		endDialogID = 122,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 1 , x = 65, y = 97, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 1, x = 65, y = 97,}},--传送至第一个暗雷热区
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
	[1011] =	--乾元岛
	{
		name = "要事相商",	--任务名字
		startNpcID = 20021,	--大弟子段岳
		endNpcID = 20004,		--乾元岛掌门
		preTaskData = {1010},--任务前置任务没有填nil
		nextTaskID = 1012,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 124,--交任务对话ID没有填nil
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
		consume	={},
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
	[1012] =	--乾元岛
	{
		name = "前往桃园镇",	--任务名字
		startNpcID = 20004,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1011},--任务前置任务没有填nil
		nextTaskID = 1013,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 127,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 72, y = 71, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1013] =	--乾元岛
	{
		name = "镇长侄儿",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1012}, --任务前置任务没有填nil
		nextTaskID = 1064,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 129,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			    },
			},
		},
	},
-------------------------------乾元岛结束--------------------------------------
----------------------------------------------桃源洞--------------------------------------
	[1014] = -----------桃源洞
	{
		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1016,	--任务后置任务没有填nil
		startDialogID =	nil,	--453--接任务对话ID没有填nil
		endDialogID = 131,	--交任务对话ID没有填nil
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
		consume	={},
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
	--[[[1015] =	--桃源洞
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1014},	--任务前置任务没有填nil
		nextTaskID = 1016,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 133,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type = "TgetItem", param = {itemID = 1026013, count = 1 ,bor = true},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026013, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 133},},--在任务结束时打开一个对话框
			},
		},
	},]]
	[1016] =	--桃源洞
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1014},	--任务前置任务没有填nil
		nextTaskID = 1017,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 135,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		--穿戴指定物品及装备目标（可以写多个）
		[1] = {type='TwearEquip',param = {equipID	= 2001088, bor = false},},--武器
		[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
		[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
		[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
		[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
		[6] = {type='TwearEquip',param = {equipID	= 2001095, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026013, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 135},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1017] =	--桃源洞
	{
		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1016},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1018,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 138,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 4 , x = 59, y = 72, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type = "flyEffect", param = {flyEffectID = 102}},--飞剑动画
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 4, x = 59, y = 72,npcID = 20005,},}, --寻路到掌门
			},
		},
	},
	[1018] =	--桃源洞
	{
		name = "苦练心法",	--任务名字
		startNpcID = 20005,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1017},	--任务前置任务没有填nil
		nextTaskID = 1019,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 140,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 50101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 140},},--在任务结束时打开一个对话框
			},
		},
	},
	[1019] =	--桃源洞
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20005,	--乾元岛掌门
		endNpcID = 20025,		--大弟子乾元岛段岳
		preTaskData = {1018},--任务前置任务没有填nil
		nextTaskID = 1020,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 142,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 4, x = 61, y = 93, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 142},},--在任务结束时打开一个对话框
			},
		},
	},
	[1020] =	----桃源洞
	{
		name = "捕捉宠物",	--任务名字
		startNpcID = 20025,	--乾元岛掌门
		endNpcID = 20025,		--大弟子乾元岛段岳
		preTaskData = {1019},--任务前置任务没有填nil
		nextTaskID = 1021,--任务后置任务没有填nil
		startDialogID =nil,--接任务对话ID没有填nil
		endDialogID = 144,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 4 , x = 136, y = 63, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 4, x = 136, y = 63,}},--传送至第一个暗雷热区
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
	[1021] =	--桃源洞
	{
		name = "要事相商",	--任务名字
		startNpcID = 20025,	--大弟子段岳
		endNpcID = 20005,		--乾元岛掌门
		preTaskData = {1020},--任务前置任务没有填nil
		nextTaskID = 1022,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 146,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 4, x = 59, y = 72, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 4, x = 59, y = 72,npcID = 20005,},},
			},
		},
	},
	[1022] =	--桃源洞
	{
		name = "前往桃园镇",	--任务名字
		startNpcID = 20005,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1021},--任务前置任务没有填nil
		nextTaskID = 1023,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 149,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 72, y = 71, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1023] =	--桃源洞
	{
		name = "镇长侄儿",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1022}, --任务前置任务没有填nil
		nextTaskID = 1064,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 151,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			    },
			},
		},
	},
-------------------------------桃源洞结束--------------------------------------
----------------------------------------------金霞山--------------------------------------
	[1024] = -----------金霞山
	{
		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1026,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 153,	--交任务对话ID没有填nil
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
		consume	={},
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
	--[[[1025] =	--金霞山
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1024},	--任务前置任务没有填nil
		nextTaskID = 1026,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 155,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type = "TgetItem", param = {itemID = 1026020, count = 1 ,bor = true},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026020, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 155},}, --在任务结束时打开一个对话框
			},
		},
	},]]
	[1026] =	--金霞山
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1024},	--任务前置任务没有填nil
		nextTaskID = 1027,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 157,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		--穿戴指定物品及装备目标（可以写多个）
		[1] = {type='TwearEquip',param = {equipID	= 2001090, bor = false},},--武器
		[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
		[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
		[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
		[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
		[6] = {type='TwearEquip',param = {equipID	= 2001095, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
			{type="getItem", param = {itemID = 1026020, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 157},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1027] =	--金霞山
	{
		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1026},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1028,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 160,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 3 , x = 26, y = 92, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type = "flyEffect", param = {flyEffectID = 103}},--飞剑动画
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 3, x = 26, y = 92,npcID = 20006,},}, --寻路到掌门
			},
		},
	},
	[1028] =	--金霞山
	{
		name = "苦练心法",	--任务名字
		startNpcID = 20006,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1027},	--任务前置任务没有填nil
		nextTaskID = 1029,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 162,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 10101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 162},},--在任务结束时打开一个对话框
			},
		},
	},
	[1029] =	--金霞山
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20006,	--乾元岛掌门
		endNpcID = 20023,		--大弟子乾元岛段岳
		preTaskData = {1028},--任务前置任务没有填nil
		nextTaskID = 1030,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 164,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 3, x = 33, y = 111, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 164},},--在任务结束时打开一个对话框
			},
		},
	},
	[1030] =	----金霞山
	{
		name = "捕捉宠物",	--任务名字
		startNpcID = 20023,	--乾元岛掌门
		endNpcID = 20023,		--大弟子乾元岛段岳
		preTaskData = {1029},--任务前置任务没有填nil
		nextTaskID = 1031,--任务后置任务没有填nil
		startDialogID =nil,--接任务对话ID没有填nil
		endDialogID = 166,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 3 , x = 88, y = 124, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 3, x = 88, y = 124,}},--传送至第一个暗雷热区
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
	[1031] =	--金霞山
	{

		name = "要事相商",	--任务名字
		startNpcID = 20023,	--大弟子段岳
		endNpcID = 20006,		--乾元岛掌门
		preTaskData = {1030},--任务前置任务没有填nil
		nextTaskID = 1032,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 168,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 3, x = 26, y = 92, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 3, x = 26, y = 92,npcID = 20006,},},
			},
		},
	},
	[1032] =	--金霞山
	{
		name = "前往桃园镇",	--任务名字
		startNpcID = 20006,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1031},--任务前置任务没有填nil
		nextTaskID = 1033,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 171,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 72, y = 71, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1033] =	--金霞山
	{
		name = "镇长侄儿",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1032}, --任务前置任务没有填nil
		nextTaskID = 1064,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 173,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			    },
			},
		},
	},
-------------------------------金霞山结束--------------------------------------
----------------------------------------------蓬莱阁--------------------------------------
	[1034] = -----------蓬莱阁
	{
		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1036,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 175,	--交任务对话ID没有填nil
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
		consume	={},
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
	--[[[1035] =	--蓬莱阁
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1034},	--任务前置任务没有填nil
		nextTaskID = 1036,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 177,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type = "TgetItem", param = {itemID = 1026027, count = 1 ,bor = true},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026027, count = 1,}},--获得物品
			},
		},
	},]]
	[1036] =	--蓬莱阁
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1034},	--任务前置任务没有填nil
		nextTaskID = 1037,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 179,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		--穿戴指定物品及装备目标（可以写多个）
		[1] = {type='TwearEquip',param = {equipID	= 2001085, bor = false},},--武器
		[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
		[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
		[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
		[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
		[6] = {type='TwearEquip',param = {equipID	= 2001095, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
			{type="getItem", param = {itemID = 1026027, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 179},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1037] =	--蓬莱阁
	{
		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1036},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1038,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 182,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 2 , x = 83, y = 125, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type = "flyEffect", param = {flyEffectID = 104}},--飞剑动画
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 2, x = 83, y = 125,npcID = 20007,},}, --寻路到掌门
			},
		},
	},
	[1038] =	--蓬莱阁
	{
		name = "苦练心法",	--任务名字
		startNpcID = 20007,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1037},	--任务前置任务没有填nil
		nextTaskID = 1039,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 184,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 40101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 184},},--在任务结束时打开一个对话框
			},
		},
	},
	[1039] =	--蓬莱阁
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20007,	--乾元岛掌门
		endNpcID = 20022,		--大弟子乾元岛段岳
		preTaskData = {1038},--任务前置任务没有填nil
		nextTaskID = 1040,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 186,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 2, x = 61, y = 127, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 186},},--在任务结束时打开一个对话框
			},
		},
	},
	[1040] =	----蓬莱阁
	{
		name = "捕捉宠物",	--任务名字
		startNpcID = 20022,	--乾元岛掌门
		endNpcID = 20022,		--大弟子乾元岛段岳
		preTaskData = {1039},--任务前置任务没有填nil
		nextTaskID = 1041,--任务后置任务没有填nil
		startDialogID =nil,--接任务对话ID没有填nil
		endDialogID = 188,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 2 , x = 125, y = 54, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 2, x = 125, y = 54,}},--传送至第一个暗雷热区
				{type="createMine",
					param =
					{
					{mapID = 2, scriptID = {101,},fightMapID = nil,stepFactor = 0.1,mustCatch = true},
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
	[1041] =	--蓬莱阁
	{
		name = "要事相商",	--任务名字
		startNpcID = 20022,	--大弟子段岳
		endNpcID = 20007,		--乾元岛掌门
		preTaskData = {1040},--任务前置任务没有填nil
		nextTaskID = 1042,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 190,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 2, x = 83, y = 125, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 2, x = 83, y = 125,npcID = 20007,},},
			},
		},
	},
	[1042] =	--蓬莱阁
	{
		name = "前往桃园镇",	--任务名字
		startNpcID = 20007,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1041},--任务前置任务没有填nil
		nextTaskID = 1043,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 193,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 72, y = 71, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1043] =	--蓬莱阁
	{
		name = "镇长侄儿",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1042}, --任务前置任务没有填nil
		nextTaskID = 1064,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 195,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			    },
			},
		},
	},
-------------------------------蓬莱阁结束--------------------------------------
----------------------------------------------紫阳门--------------------------------------
	[1044] = -----------紫阳门
	{
		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1046,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 197,	--交任务对话ID没有填nil
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
		consume	={},
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
	--[[[1045] =	--紫阳门
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1044},	--任务前置任务没有填nil
		nextTaskID = 1046,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 199,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type = "TgetItem", param = {itemID = 1026034, count = 1 ,bor = true},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026034, count = 1,}},--获得物品
			},
		},
	},]]
	[1046] =	--紫阳门
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1044},	--任务前置任务没有填nil
		nextTaskID = 1047,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 201,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		--穿戴指定物品及装备目标（可以写多个）
		[1] = {type='TwearEquip',param = {equipID	= 2001089, bor = false},},--武器
		[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
		[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
		[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
		[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
		[6] = {type='TwearEquip',param = {equipID	= 2001095, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
			{type="getItem", param = {itemID = 1026034, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 201},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1047] =	--紫阳门
	{
		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1046},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1048,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 204,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 6 , x = 67, y = 135, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type = "flyEffect", param = {flyEffectID = 105}},--飞剑动画
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 135,npcID = 20008,},}, --寻路到掌门
			},
		},
	},
	[1048] =	--紫阳门
	{
		name = "苦练心法",	--任务名字
		startNpcID = 20008,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1047},	--任务前置任务没有填nil
		nextTaskID = 1049,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 206,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 30101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 206},},--在任务结束时打开一个对话框
			},
		},
	},
	[1049] =	--紫阳门
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20008,	--乾元岛掌门
		endNpcID = 20026,		--大弟子乾元岛段岳
		preTaskData = {1048},--任务前置任务没有填nil
		nextTaskID = 1050,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 208,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 6, x = 43, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 208},},--在任务结束时打开一个对话框
			},
		},
	},
	[1050] =	----紫阳门
	{
		name = "捕捉宠物",	--任务名字
		startNpcID = 20026,	--乾元岛掌门
		endNpcID = 20026,		--大弟子乾元岛段岳
		preTaskData = {1049},--任务前置任务没有填nil
		nextTaskID = 1051,--任务后置任务没有填nil
		startDialogID =nil,--接任务对话ID没有填nil
		endDialogID = 210,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 6 , x = 131, y = 80, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 6, x = 131, y = 80,}},--传送至第一个暗雷热区
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
	[1051] =	--紫阳门
	{
		name = "要事相商",	--任务名字
		startNpcID = 20026,	--大弟子段岳
		endNpcID = 20008,		--乾元岛掌门
		preTaskData = {1050},--任务前置任务没有填nil
		nextTaskID = 1052,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 212,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 6, x = 67, y = 135, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 135,npcID = 20008,},},
			},
		},
	},
	[1052] =	--紫阳门
	{
		name = "前往桃园镇",	--任务名字
		startNpcID = 20008,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1051},--任务前置任务没有填nil
		nextTaskID = 1053,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 215,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 72, y = 71, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1053] =	--紫阳门
	{
		name = "镇长侄儿",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1052}, --任务前置任务没有填nil
		nextTaskID = 1064,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 217,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			    },
			},
		},
	},
-------------------------------紫阳门结束--------------------------------------
----------------------------------------------云霄宫--------------------------------------
	[1054] = -----------云霄宫
	{
		name = "受命下界",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 1056,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 219,	--交任务对话ID没有填nil
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
		consume	={},
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
	--[[[1055] =	--云霄宫
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1054},	--任务前置任务没有填nil
		nextTaskID = 1056,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 221,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type = "TgetItem", param = {itemID = 1026041, count = 1 ,bor = true},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="getItem", param = {itemID = 1026041, count = 1,}},--获得物品
			},
		},
	},]]
	[1056] =	--云霄宫
	{
		name = "获得百宝袋",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20003,		--任务结束npc
		preTaskData = {1054},	--任务前置任务没有填nil
		nextTaskID = 1057,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 223,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		--穿戴指定物品及装备目标（可以写多个）
		[1] = {type='TwearEquip',param = {equipID	= 2001087, bor = false},},--武器
		[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
		[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
		[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
		[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
		[6] = {type='TwearEquip',param = {equipID	= 2001095, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=
			{
			{type="getItem", param = {itemID = 1026041, count = 1,}},--获得物品
			},
			[TaskStatus.Done]		=
			{
			{type = "openDialog", param={dialogID = 223},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1057] =	--云霄宫
	{
		name = "前往门派",	--任务名字
		startNpcID = 20003,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1056},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1058,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 226,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 5 , x = 43, y = 112, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type = "flyEffect", param = {flyEffectID = 106}},--飞剑动画
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 5, x = 43, y = 112,npcID = 20009,},}, --寻路到掌门
			},
		},
	},
	[1058] =	--云霄宫
	{
		name = "苦练心法",	--任务名字
		startNpcID = 20009,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1057},	--任务前置任务没有填nil
		nextTaskID = 1059,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 228,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TlearnSkill',param	= {skillID = 60101, tarLevel = 10 , bor = true},},--学习特定技能到多少级
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 228},},--在任务结束时打开一个对话框
			},
		},
	},
	[1059] =	--云霄宫
	{
		name = "寻找大弟子",	--任务名字
		startNpcID = 20009,	--乾元岛掌门
		endNpcID = 20024,		--大弟子乾元岛段岳
		preTaskData = {1058},--任务前置任务没有填nil
		nextTaskID = 1060,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 230,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 5, x = 33, y = 77, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 230},},--在任务结束时打开一个对话框
			},
		},
	},
	[1060] =	----云霄宫
	{
		name = "捕捉宠物",	--任务名字
		startNpcID = 20024,	--乾元岛掌门
		endNpcID = 20024,		--大弟子乾元岛段岳
		preTaskData = {1059},--任务前置任务没有填nil
		nextTaskID = 1061,--任务后置任务没有填nil
		startDialogID =nil,--接任务对话ID没有填nil
		endDialogID = 232,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			  [1] = {type='TocatchPet',param	= {petID  = 1001, count = 1 , bor = true},},--捕捉一个宠物
			  [2] = {type='TautoMeet',param = {mapID = 5 , x = 118, y = 44, bor = false},},---到达一个坐标自动遇敌
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="autoTrace", param = {tarMapID	= 5, x = 118, y = 44,}},--传送至第一个暗雷热区
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
	[1061] =	--云霄宫
	{
		name = "要事相商",	--任务名字
		startNpcID = 20024,	--大弟子段岳
		endNpcID = 20009,		--乾元岛掌门
		preTaskData = {1060},--任务前置任务没有填nil
		nextTaskID = 1062,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 234,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 5, x = 43, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 5, x = 43, y = 112,npcID = 20009,},},
			},
		},
	},
	[1062] =	--云霄宫
	{
		name = "前往桃园镇",	--任务名字
		startNpcID = 20009,	--乾元岛掌门
		endNpcID = 20027,		--镇长刘元起
		preTaskData = {1061},--任务前置任务没有填nil
		nextTaskID = 1063,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 237,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 72, y = 71, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 9, x = 72, y	= 71,npcID = 20027,},},
			},
		},
	},
   [1063] =	--云霄宫
	{
		name = "镇长侄儿",	--任务名字       
		startNpcID = 20027,
		endNpcID = 20028,
		preTaskData = {1062}, --任务前置任务没有填nil
		nextTaskID = 1064,--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		endDialogID = 239,--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			    },
			},
		},
	},
-------------------------------云霄宫结束--------------------------------------
-------------------------------分门派结束--------------------------------------
    [1064] =
	{
		name = "说服张飞",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20037,		--任务结束npc
		preTaskData = {condition = "or",{1013,1023,1033,1043,1053,1063}},		--任务前置任务没有填nil
		nextTaskID = 1065,	--任务后置任务没有填nil
		startDialogID =	nil,--接任务对话ID没有填nil
		--startDialogID =	{130,152,174,196,218,240},	--接任务多个对话ID
		endDialogID = 241,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 84, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有NPC张飞
				param={
					npcs =
					{
						[1] = {npcID = 20037,mapID = 9, x = 84, y = 112,dir = Direction.EestSouth,},--张飞
					},
				},
			},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc刘备
				param={
					npcs =
						{
							{npcID = 20028,	taskID = {1013,1023,1033,1043,1053,1063}, index = 1},
						},
					 },
				 },
			{type="openDialog", param={dialogID = 241},}, --在任务结束时打开一个对话框
		},
	},
    },
    [1065] =
	{
		name = "寻找铁匠",	--任务名字
		startNpcID = 20037,	--任务起始npc
		endNpcID = 20029,		--任务结束npc
		preTaskData = {1064},	--任务前置任务没有填nil
		nextTaskID = 1066,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 243,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 31, y = 97, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有NPC铁匠
			param={
				npcs =
					{
					[1] = {npcID = 20029,mapID = 9, x = 31, y = 97,dir = Direction.South,},--杜远
					},
				},
			},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc张飞
			param={
				npcs =
					{
					{npcID = 20037,	taskID = {1064}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 243},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1066] =
	{
		name = "回复张飞",	--任务名字
		startNpcID = 20029,	--任务起始npc
		endNpcID = 20037,		--任务结束npc
		preTaskData = {1065},	--任务前置任务没有填nil
		nextTaskID = 1067,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 245,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 84, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有NPC张飞
				param={
					npcs =
					{
						[1] = {npcID = 20037,mapID = 9, x = 84, y = 112,dir = Direction.EestSouth,},--张飞
					},
				},
			},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc铁匠
			param={
				npcs =
					{
					{npcID = 20029,	taskID = {1065}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 245},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1067] =
	{
		name = "红脸汉子",	--任务名字
		startNpcID = 20037,	--任务起始npc
		endNpcID = 20032,		--任务结束npc
		preTaskData = {1066},	--任务前置任务没有填nil
		nextTaskID = 1068,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 249,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
		{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 102,
				dialogID = 247,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 9, x = 146, y	= 91}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有NPC关羽
				param={
					npcs =
					{
						[1] = {npcID = 20032,mapID = 9, x = 146, y = 91,dir = Direction.WestSouth,},--关羽
					},
				},
			},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc张飞
			param={
				npcs =
					{
					{npcID = 20037,	taskID = {1066}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 249},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1068] =
	{
		name = "打败陌生人",	--任务名字
		startNpcID = 20032,	--任务起始npc
		endNpcID = 20030,		--任务结束npc
		preTaskData = {1067},	--任务前置任务没有填nil
		nextTaskID = 1069,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 252,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
		{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 103,
				dialogID = 250,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 9, x = 81, y	= 148}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有NPC陌生人
				param={
					npcs =
					{
						[1] = {npcID = 20030,mapID = 9, x = 81, y = 148,dir = Direction.South,},--陌生人
					},
				},
			},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc关羽
			param={
				npcs =
					{
					{npcID = 20032,	taskID = {1067}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 252},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1069] =
	{
		name = "得知真相",	--任务名字
		startNpcID = 20030,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1068},	--任务前置任务没有填nil
		nextTaskID = 1070,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 255,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			  },
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc陌生人
			param={
				npcs =
					{
					{npcID = 20030,	taskID = {1068}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 255},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1070] =
	{
		name = "寻求援助",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20037,		--任务结束npc
		preTaskData = {1069},	--任务前置任务没有填nil
		nextTaskID = 1071,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 257,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 84, y = 112, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
			{type="createPrivateNpc", ----------创建私有张飞
				param={
					npcs =
						{
						[1] = {npcID = 20037,mapID = 9, x = 84, y = 112,dir = Direction.EestSouth,},--张飞
						},
					},
			  },
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc刘备
			param={
				npcs =
					{
					{npcID = 20028,	taskID = {1069}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 257},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1071] =
	{
		name = "找寻关羽",	--任务名字
		startNpcID = 20037,	--任务起始npc
		endNpcID = 20032,		--任务结束npc
		preTaskData = {1070},	--任务前置任务没有填nil
		nextTaskID = 1072,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 259,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 146, y = 91, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
			{type="createPrivateNpc", ----------创建私有关羽
				param={
					npcs =
						{
						[1] = {npcID = 20032,mapID = 9, x = 146, y = 91,dir = Direction.WestSouth,},--关羽
						},
					},
			  },
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc张飞
			param={
				npcs =
					{
					{npcID = 20037,	taskID = {1070}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 259},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1072] =
	{
		name = "回禀刘备",	--任务名字
		startNpcID = 20032,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1071},	--任务前置任务没有填nil
		nextTaskID = 1073,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 262,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 9 , x = 88, y = 66, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
			{type="createPrivateNpc", ----------创建私有刘备
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 9, x = 88, y = 66,dir = Direction.EastNorth,},
						},
					},
			  },
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc关羽
			param={
				npcs =
					{
					{npcID = 20032,	taskID = {1071}, index = 1},
					},
				},
			},
		{type="openDialog", param={dialogID = 262},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1073] =
	{
		name = "桃林会合",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20037,		--任务结束npc
		preTaskData = {1072},	--任务前置任务没有填nil
		nextTaskID = 1074,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 264,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 400 , x = 74, y = 38, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有npc刘备
			param={
				npcs =
				{
				{npcID = 20028,taskID = {1072}, index = 1},
				},
			},
		},
		{type = "createFollow", param = {npcs = {20028},}},				--创建指定npc刘备跟随
		{type = "createPrivateTransfer", ------创建私有传送阵--
			param={
				transfers =
					{
					[1] = {mapID = 9, x =121, y =120, tarMapID = 400, tarX = 91, tarY = 28},
					},
			},
		},
		{type="createPrivateNpc", ----------创建私有关羽、张飞
				param={
					npcs =
						{
						[1] = {npcID = 20037, mapID = 400, x = 74, y = 38,dir = Direction.South,},
						[2] = {npcID = 20032, mapID = 400, x = 72, y = 38,dir = Direction.South,},
						},
					},
			  },
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
		        param={
			        transfers =
				    {
				    {taskID = 1073, index = 1},
				    },
			   },
		},
		{type="openDialog", param={dialogID = 264},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1074] =
	{
		name = "对付张宝",	--任务名字
		startNpcID = 20037,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1073},	--任务前置任务没有填nil
		nextTaskID = 1075,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 269,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 104,
				dialogID = 267,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 400, x = 45, y = 74}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有npc关羽、张飞
			param={
				npcs =
				{
				{npcID = 20037,taskID = {1073}, index = 1},
				{npcID = 20032,taskID = {1073}, index = 2},
				},
			},
		},
		{type = "createFollow", param = {npcs = {20037,20032},}},				--创建指定npc关羽、张飞跟随
		{type="createPrivateNpc", ----------创建私有张宝部队
				param={
					npcs =
						{
						[1] = {npcID = 20031, mapID = 400, x = 45, y = 74,dir = Direction. South,},--张宝
						[2] = {npcID = 20033, mapID = 400, x = 46, y = 76,dir = Direction. South,},
						[3] = {npcID = 20034, mapID = 400, x = 43, y = 73,dir = Direction. South,},
						[4] = {npcID = 20035, mapID = 400, x = 41, y = 76,dir = Direction. South,},
						[5] = {npcID = 20036, mapID = 400, x = 43, y = 78,dir = Direction. South,},
						},
					},
			  },
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc张宝部队
			param={
				npcs =
				{
				{npcID = 20031,taskID = {1074}, index = 1},
				{npcID = 20033,taskID = {1074}, index = 2},
				{npcID = 20034,taskID = {1074}, index = 3},
				{npcID = 20035,taskID = {1074}, index = 4},
				{npcID = 20036,taskID = {1074}, index = 5},
				},
			},
		},
		{type = "deleteFollow", param = {npcs = {20028,20032,20037},}}, --在完成状态删除指定ID的npc跟随
		{type="createPrivateNpc", ----------创建私有刘关张
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 400, x = 42, y = 77,dir = Direction. South,},--刘备
						[2] = {npcID = 20032, mapID = 400, x = 39, y = 78,dir = Direction. South,},--关羽
						[3] = {npcID = 20037, mapID = 400, x = 42, y = 80,dir = Direction. South,},--张飞
						},
				},
		},
		{type = "playAnimation", param = {playID = 1002, sceneID = 1,},},				--触发指定ID的脚本动画(参数待定)
		--{type = "openUI", param={v = "SkillBoard"},}  --在任务结束打开一个UI
		{type="openDialog", param={dialogID = 269},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1075] =
	{
		name = "打探张宝下落",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20038,		--任务结束npc
		preTaskData = {1074},	--任务前置任务没有填nil
		nextTaskID = 1076,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 273,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 105,
				dialogID = 271,
				npcsData =			--刷出npc数据
				{
				{npcID = 20038, x = 196, y	= 104, noDelete =	true},
				{npcID = 20039, x = 197, y	= 106, noDelete =	true},
				{npcID = 20039, x = 195, y	= 102, noDelete =	true},
				{npcID = 20039, x = 193, y	= 105, noDelete =	true},
				{npcID = 20039, x = 194, y	= 107, noDelete =	true},
				},
				posData	= {mapID = 101, x = 196, y = 104}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 400, x =98, y =29, tarMapID = 9, tarX = 121, tarY = 118},
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="deletePrivateNpc", ---------删除私有npc刘关张
			param={
				npcs =
				{
				{npcID = 20028,taskID = {1074}, index = 1},
				{npcID = 20032,taskID = {1074}, index = 2},
				{npcID = 20037,taskID = {1074}, index = 3},
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1075, index = 1},
						},
				},
		},
		{type="createPrivateNpc", ----------创建私有严政
				param={
					npcs =
						{
						[1] = {npcID = 20038, mapID = 101, x = 196, y = 104,dir = Direction. South,},--严政
						},
				},
		},
		{type="openDialog", param={dialogID = 273},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1076] =
	{
		name = "齐心协力",	--任务名字
		startNpcID = 20038,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1075},	--任务前置任务没有填nil
		nextTaskID = 1077,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 277,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 106,
				dialogID = 275,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 101, x = 115, y = 119}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有刘备包围
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 101, x = 115, y = 119,dir = Direction. EastSouth,},--刘备
						[2] = {npcID = 20044, mapID = 101, x = 112, y = 120,dir = Direction. EastSouth,},--马相
						[3] = {npcID = 20040, mapID = 101, x = 114, y = 116,dir = Direction. East,},
						[4] = {npcID = 20041, mapID = 101, x = 118, y = 116,dir = Direction. North,},
						[5] = {npcID = 20042, mapID = 101, x = 118, y = 120,dir = Direction. WestNorth,},
						[6] = {npcID = 20043, mapID = 101, x = 114, y = 122,dir = Direction. WestSouth,},
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
				{npcID = 20038,taskID = {1075}, index = 1},--严政
				{npcID = 20044,taskID = {1076}, index = 2},--马相部队
				{npcID = 20040,taskID = {1076}, index = 3},
				{npcID = 20041,taskID = {1076}, index = 4},
				{npcID = 20042,taskID = {1076}, index = 5},
				{npcID = 20043,taskID = {1076}, index = 6},
				},
			},
		},
		{type="openDialog", param={dialogID = 277},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1077] =
	{
		name = "支援张飞",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20037,		--任务结束npc
		preTaskData = {1076},	--任务前置任务没有填nil
		nextTaskID = 1078,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 281,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 107,
				dialogID = 279,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 101, x = 140, y = 150}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 20028,taskID = {1076}, index = 1},--刘备
				},
			},
		},
		{type = "createFollow", param = {npcs = {20028},}},				--创建刘备跟随
		{type="createPrivateNpc", ----------创建私有张飞包围
				param={
					npcs =
						{
						[1] = {npcID = 20037, mapID = 101, x = 140, y = 150,dir = Direction. EastSouth,},--张飞
						[2] = {npcID = 20045, mapID = 101, x = 143, y = 151,dir = Direction. West,},--杜远
						[3] = {npcID = 20040, mapID = 101, x = 139, y = 153,dir = Direction. WestSouth,},
						[4] = {npcID = 20041, mapID = 101, x = 137, y = 151,dir = Direction. EastSouth,},
						[5] = {npcID = 20042, mapID = 101, x = 139, y = 147,dir = Direction. East,},
						[6] = {npcID = 20043, mapID = 101, x = 143, y = 147,dir = Direction. North,},
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
				{npcID = 20045,taskID = {1077}, index = 2},--杜远部队
				{npcID = 20040,taskID = {1077}, index = 3},
				{npcID = 20041,taskID = {1077}, index = 4},
				{npcID = 20042,taskID = {1077}, index = 5},
				{npcID = 20043,taskID = {1077}, index = 6},
				},
			},
		},
		{type="openDialog", param={dialogID = 281},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1078] =
	{
		name = "支援关羽",	--任务名字
		startNpcID = 20037,	--任务起始npc
		endNpcID = 20032,		--任务结束npc
		preTaskData = {1077},	--任务前置任务没有填nil
		nextTaskID = 1079,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 284,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 108,
				dialogID = 282,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 101, x = 156, y = 185}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 20037,taskID = {1077}, index = 1},--张飞
				},
			},
		},
		{type = "createFollow", param = {npcs = {20037},}},				--创建张飞跟随
		{type="createPrivateNpc", ----------创建私有关羽包围
				param={
					npcs =
						{
						[1] = {npcID = 20032, mapID = 101, x = 156, y = 185,dir = Direction. South,},--关羽
						[2] = {npcID = 20046, mapID = 101, x = 153, y = 188,dir = Direction. South,},--李乐
						[3] = {npcID = 20040, mapID = 101, x = 153, y = 184,dir = Direction. East,},
						[4] = {npcID = 20041, mapID = 101, x = 157, y = 181,dir = Direction. EastNorth,},
						[5] = {npcID = 20042, mapID = 101, x = 160, y = 184,dir = Direction. WestNorth,},
						[6] = {npcID = 20043, mapID = 101, x = 157, y = 188,dir = Direction. West,},
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
				{npcID = 20046,taskID = {1077}, index = 2},--李乐部队
				{npcID = 20040,taskID = {1077}, index = 3},
				{npcID = 20041,taskID = {1077}, index = 4},
				{npcID = 20042,taskID = {1077}, index = 5},
				{npcID = 20043,taskID = {1077}, index = 6},
				},
			},
		},
		{type="openDialog", param={dialogID = 284},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1079] =
	{
		name = "闯入古阵",	--任务名字
		startNpcID = 20032,	--任务起始npc
		endNpcID = 20032,		--任务结束npc
		preTaskData = {1078},	--任务前置任务没有填nil
		nextTaskID = 1080,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 288,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 109,
				dialogID = 286,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 401, x = 41, y = 51}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 20032,taskID = {1078}, index = 1},--关羽
				},
			},
		},
		{type = "createFollow", param = {npcs = {20032},}},				--创建关羽跟随
		{type="createPrivateNpc", ----------创建私有张宝
				param={
					npcs =
						{
						[1] = {npcID = 20031, mapID = 401, x = 41, y = 51,dir = Direction. WestSouth,},--张宝
						},
				},
		},
		{type = "createPrivateTransfer", ------创建私有传送阵--秘密古阵
				param={
						transfers =
						{
						[1] = {mapID = 101, x =91, y =252, tarMapID = 401, tarX = 51, tarY = 8},
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
				{npcID = 20031,taskID = {1079}, index = 1},--张宝
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1079, index = 1},
					},
				},
		},
		--{type = "openUI", param={v = "SkillBoard"},}  --在任务结束打开一个UI
		{type = "deleteFollow", param = {npcs = {20028,20032,20037},}}, --在完成状态删除指定ID的npc跟随
		{type="createPrivateNpc", ----------创建私有刘关张--秘密古阵
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 401, x = 41, y = 51,dir = Direction. WestSouth,},--刘备
						[2] = {npcID = 20032, mapID = 401, x = 43, y = 53,dir = Direction. WestSouth,},--关羽
						[3] = {npcID = 20037, mapID = 401, x = 38, y = 53,dir = Direction. WestSouth,},--张飞
						},
				},
		},
		{type="openDialog", param={dialogID = 288},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1080] =
	{
		name = "探寻岐山",	--任务名字
		startNpcID = 20032,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1079},	--任务前置任务没有填nil
		nextTaskID = 1081,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 110,
				dialogID = 291,
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 102, x = 178, y = 91}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 20028,taskID = {1079}, index = 1},--刘备
				{npcID = 20032,taskID = {1079}, index = 2},--关羽
				{npcID = 20037,taskID = {1079}, index = 3},--张飞
				},
			},
		},
		{type = "createFollow", param = {npcs = {20028,20032,20037},}},	--创建刘关张跟随
		{type = "createPrivateTransfer", ------创建私有传送阵--秘密古阵至巨鹿
				param={
						transfers =
						{
						[1] = {mapID = 401, x =51, y =8, tarMapID = 101, tarX = 91, tarY = 252},
						},
				},
		},
		{type="createPrivateNpc", ----------创建私有程志远部队
				param={
					npcs =
						{
						[1] = {npcID = 20047, mapID = 102, x = 178, y = 91,dir = Direction. WestSouth,},--程志远
						[2] = {npcID = 20040, mapID = 102, x = 175, y = 91,dir = Direction. WestSouth,},
						[3] = {npcID = 20041, mapID = 102, x = 181, y = 91,dir = Direction. WestSouth,},
						[4] = {npcID = 20042, mapID = 102, x = 176, y = 94,dir = Direction. WestSouth,},
						[5] = {npcID = 20043, mapID = 102, x = 179, y = 94,dir = Direction. WestSouth,},
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
				{npcID = 20047,taskID = {1080}, index = 1},--程志远
				{npcID = 20040,taskID = {1080}, index = 2},
				{npcID = 20041,taskID = {1080}, index = 3},
				{npcID = 20042,taskID = {1080}, index = 4},
				{npcID = 20043,taskID = {1080}, index = 5},
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1080, index = 1},
					},
				},
		},
		{type = "openDialog", param={dialogID = 293},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1081}},--触发完成任务接受下一个任务
		},
	},
    },
	[1081] =
	{
		name = "遭遇难题",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1080},	--任务前置任务没有填nil
		nextTaskID = 1082,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 102 , x = 129, y = 100, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		},
		[TaskStatus.Done] =
		{
		{type="openDialog", param={dialogID = 294},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1082}},--触发完成任务接受下一个任务
		},
	},
    },
	[1082] =
	{
		name = "开始破阵",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1083,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 111,
				dialogID = 296,
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 402, x = 25, y = 30}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--失魂阵
				param={
						transfers =
						{
						[1] = {mapID = 102, x =146, y =87, tarMapID = 402, tarX = 29, tarY = 7, magicID = 6002,},
						},
				},
		},
		{type="createPrivateNpc", ----------创建私有玄煌
				param={
					npcs =
						{
						[1] = {npcID = 20048, mapID = 402, x = 25, y = 30,dir = Direction. WestSouth,},--玄煌
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
				{npcID = 20048,taskID = {1082}, index = 1},--玄煌
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1081, index = 1},
					},
				},
		},
		{type = "createPrivateTransfer", ------创建私有传送阵--血魂阵
				param={
						transfers =
						{
						[1] = {mapID = 402, x =9, y =29, tarMapID = 403, tarX = 39, tarY = 13},
						},
				},
		},
		{type="openDialog", param={dialogID = 298},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1083}},--触发完成任务接受下一个任务
		},
	},
    },
	[1083] =
	{
		name = "继续破阵",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1081},	--任务前置任务没有填nil
		nextTaskID = 1083,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 112,
				dialogID = 299,
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 403, x = 39, y = 45}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有水雉
				param={
					npcs =
						{
						[1] = {npcID = 20051, mapID = 403, x = 39, y = 45,dir = Direction. WestSouth,},--水雉
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
				{npcID = 20051,taskID = {1083}, index = 1},--玄煌
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1082, index = 1},
					},
				},
		},
		{type = "createPrivateTransfer", ------创建私有传送阵--噬魂阵
				param={
						transfers =
						{
						[1] = {mapID = 403, x =58, y =45, tarMapID = 404, tarX = 12, tarY = 43},
						},
				},
		},
		{type="openDialog", param={dialogID = 301},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1084}},--触发完成任务接受下一个任务
		},
	},
    },
	[1084] =
	{
		name = "三阵尽破",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1083},	--任务前置任务没有填nil
		nextTaskID = 1085,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 113,
				dialogID = 302,
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 404, x = 44, y = 38}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有水雉
				param={
					npcs =
						{
						[1] = {npcID = 20053, mapID = 404, x = 44, y = 38,dir = Direction. WestNorth,},--水雉
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
				{npcID = 20053,taskID = {1084}, index = 1},--玄煌
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1083, index = 1},
					},
				},
		},
		{type = "createPrivateTransfer", ------创建私有传送阵--万魂大阵
				param={
						transfers =
						{
						[1] = {mapID = 404, x =40, y =63, tarMapID = 405, tarX = 51, tarY = 22},
						},
				},
		},
		{type="openDialog", param={dialogID = 304},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1085}},--触发完成任务接受下一个任务
		},
	},
    },
	[1085] =
	{
		name = "诛杀张梁",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1084},	--任务前置任务没有填nil
		nextTaskID = 1086,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 114,
				dialogID = 305,
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 405, x = 27, y = 27}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有张梁
				param={
					npcs =
						{
						[1] = {npcID = 20055, mapID = 405, x = 27, y = 27,dir = Direction. EastSouth,},--张梁
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
				{npcID = 20055,taskID = {1085}, index = 1},--玄煌
				},
			},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1084, index = 1},
					},
				},
		},
		{type = "createPrivateTransfer", ------创建私有传送阵--封神台
				param={
						transfers =
						{
						[1] = {mapID = 405, x =18, y =28, tarMapID = 406, tarX = 64, tarY = 14},
						},
				},
		},
		{type="openDialog", param={dialogID = 425},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1086}},--触发完成任务接受下一个任务
		},
	},
    },
	[1086] =
	{
		name = "阻止张角",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1085},	--任务前置任务没有填nil
		nextTaskID = 1087,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 406 , x = 40, y = 65, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type="createPrivateNpc", ----------创建私有张角
				param={
					npcs =
						{
						[1] = {npcID = 20056, mapID = 406, x = 34, y = 64,dir = Direction. EastSouth,},--张角
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1085, index = 1},
					},
				},
		},
		--{type = "openUI", param={v = "SkillBoard"},}  --在任务结束打开一个UI
		{type = "finishTask", param = {recetiveTaskID = 1087}},--触发完成任务接受下一个任务
		},
	},
    },
	[1087] =
	{
		name = "阻止未果",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20028,		--任务结束npc
		preTaskData = {1086},	--任务前置任务没有填nil
		nextTaskID = {1088,1090,1092,1094,1096,1098},--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 307,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 115,
				dialogID = 426,
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 406, x = 34, y = 64}, --踩雷坐标
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
		{type="deletePrivateNpc", ---------删除私有npc
			param={
				npcs =
				{
				{npcID = 20056,taskID = {1086}, index = 1},--张角
				},
			},
		},
		{type = "deleteFollow", param = {npcs = {20028,20032,20037},}}, --在完成状态删除指定ID的npc跟随
		{type="createPrivateNpc", ----------创建私有刘关张
				param={
					npcs =
						{
						[1] = {npcID = 20028, mapID = 406, x = 34, y = 64,dir = Direction. EastSouth,},
						[2] = {npcID = 20032, mapID = 406, x = 33, y = 62,dir = Direction. EastSouth,},
						[3] = {npcID = 20037, mapID = 406, x = 33, y = 66,dir = Direction. EastSouth,},
						},
				},
		},
		{type = "openDialog", param={dialogID = 307},}, --在任务结束时打开一个对话框
		},
	},
    },
----------------------------------------------开始分门派--------------------------------------
----------------------------------------------乾元岛--------------------------------------
    [1088] =	--乾元岛
	{
		name = "妖物乱世",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = {1087},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1089,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 309,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 1 , x = 26, y = 84, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 1, x = 85, y = 63,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="deletePrivateNpc", ---------删除私有刘关张
			param={
				npcs =
				{
				{npcID = 20028,taskID = {1087}, index = 1},
				{npcID = 20032,taskID = {1087}, index = 2},
				{npcID = 20037,taskID = {1087}, index = 3},
				},
			},
		},
		{type="autoTrace", param = {tarMapID	= 1, x = 26, y = 84,npcID = 20004,},}, --寻路到掌门
		},
	},
	},
	[1089] =	--乾元岛
	{
		name = "人间大劫",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1088},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 428,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------桃源洞--------------------------------------
    [1090] =	--桃源洞
	{
		name = "妖物乱世",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1087},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1091,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 311,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 4 , x = 59, y = 72, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 4, x = 108, y = 70,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="deletePrivateNpc", ---------删除私有刘关张
		param={
			npcs =
				{
				{npcID = 20028,taskID = {1087}, index = 1},
				{npcID = 20032,taskID = {1087}, index = 2},
				{npcID = 20037,taskID = {1087}, index = 3},
				},
			},
		},
		{type="autoTrace", param = {tarMapID	= 4, x = 59, y = 72,npcID = 20005,},}, --寻路到掌门
		},
	},
	},
	[1091] =	--桃源洞
	{
		name = "人间大劫",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1090},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 430,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------金霞山--------------------------------------
    [1092] =	--金霞山
	{
		name = "妖物乱世",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1087},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1093,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 313,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 3 , x = 26, y = 92, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 3, x = 134, y = 70,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="deletePrivateNpc", ---------删除私有刘关张
		param={
			npcs =
				{
				{npcID = 20028,taskID = {1087}, index = 1},
				{npcID = 20032,taskID = {1087}, index = 2},
				{npcID = 20037,taskID = {1087}, index = 3},
				},
			},
		},
		{type="autoTrace", param = {tarMapID	= 3, x = 26, y = 92,npcID = 20006,},}, --寻路到掌门
		},
	},
	},
	[1093] =	--金霞山
	{
		name = "人间大劫",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1092},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 432,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------蓬莱阁--------------------------------------
    [1094] =	--蓬莱阁
	{
		name = "妖物乱世",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1087},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1095,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 315,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 2 , x = 83, y = 125, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 2, x = 86, y = 32,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="deletePrivateNpc", ---------删除私有刘关张
		param={
			npcs =
				{
				{npcID = 20028,taskID = {1087}, index = 1},
				{npcID = 20032,taskID = {1087}, index = 2},
				{npcID = 20037,taskID = {1087}, index = 3},
				},
			},
		},
		{type="autoTrace", param = {tarMapID	= 2, x = 83, y = 125,npcID = 20007,},}, --寻路到掌门
		},
	},
	},
	[1095] =	--蓬莱阁
	{
		name = "人间大劫",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1094},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 434,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------紫阳门--------------------------------------
    [1096] =	--紫阳门
	{
		name = "妖物乱世",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1087},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1097,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 317,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 6 , x = 67, y = 135, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 6, x = 103, y = 61,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="deletePrivateNpc", ---------删除私有刘关张
		param={
			npcs =
				{
				{npcID = 20028,taskID = {1087}, index = 1},
				{npcID = 20032,taskID = {1087}, index = 2},
				{npcID = 20037,taskID = {1087}, index = 3},
				},
			},
		},
		{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 135,npcID = 20008,},}, --寻路到掌门
		},
	},
	},
	[1097] =	--紫阳门
	{
		name = "人间大劫",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1096},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 436,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------云霄宫--------------------------------------
    [1098] =	--云霄宫
	{
		name = "妖物乱世",	--任务名字
		startNpcID = 20028,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1087},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1099,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 319,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 5 , x = 43, y = 112, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 5, x = 52, y = 54,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="deletePrivateNpc", ---------删除私有刘关张
		param={
			npcs =
				{
				{npcID = 20028,taskID = {1087}, index = 1},
				{npcID = 20032,taskID = {1087}, index = 2},
				{npcID = 20037,taskID = {1087}, index = 3},
				},
			},
		},
		{type="autoTrace", param = {tarMapID	= 5, x = 43, y = 112,npcID = 20009,},}, --寻路到掌门
		},
	},
	},
	[1099] =	--云霄宫
	{
		name = "人间大劫",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1096},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1100,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 438,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------分门派结束--------------------------------------
    [1100] =
	{
		name = "前往洛阳",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {condition = "or",{1089,1091,1093,1095,1097,1099}},		--任务前置任务没有填nil
		nextTaskID = 1351,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		--startDialogID =	{429,431,433,435,437,439},	--接任务多个对话ID
		endDialogID = 323,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		},
		[TaskStatus.Done] =
		{
		{type="autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --寻路到掌门
		},
	},
    },
	[1351] =
	{
		name = "找寻蹇硕",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1100},	--任务前置任务没有填nil
		nextTaskID = 1352,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --御花园统领
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 116,
				dialogID = 325,
				npcsData =			--刷出npc数据
				{
				{npcID = 20060, x = 45, y = 156, noDelete = true},
				{npcID = 20057, x = 45, y = 153, noDelete = true},
				{npcID = 20057, x = 45, y = 159, noDelete = true},
				{npcID = 20058, x = 47, y = 154, noDelete = true},
				{npcID = 20058, x = 47, y = 157, noDelete = true},
				},
				posData	= {mapID = 15, x = 45, y = 156}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] = {type='Tmine',param = --蹇硕副将
			{
				mineIndex = 2,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 117,
				dialogID = 327,
				npcsData =			--刷出npc数据
				{
				{npcID = 20061, x = 81, y = 128, noDelete = true},
				{npcID = 20057, x = 79, y = 127, noDelete = true},
				{npcID = 20057, x = 83, y = 129, noDelete = true},
				{npcID = 20058, x = 81, y = 125, noDelete = true},
				{npcID = 20058, x = 83, y = 126, noDelete = true},
				},
				posData	= {mapID = 15, x = 81, y = 128}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[3] = {type='Tmine',param = --蹇硕
			{
				mineIndex = 3,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 118,
				dialogID = 329,
				npcsData =			--刷出npc数据
				{
				{npcID = 20062, x = 114, y = 102, noDelete = true},
				{npcID = 20057, x = 111, y = 102, noDelete = true},
				{npcID = 20057, x = 117, y = 102, noDelete = true},
				{npcID = 20058, x = 112, y = 104, noDelete = true},
				{npcID = 20058, x = 115, y = 104, noDelete = true},
				},
				posData	= {mapID = 15, x = 114, y = 102}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵--
			param={
					transfers =
					{
					[1] = {mapID = 10, x =31, y =201, tarMapID = 15, tarX = 27, tarY = 170},
					},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1351, index = 1},
					},
				},
		},
		{type="openDialog", param={dialogID = 331},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1352}},--触发完成任务接受下一个任务
		},
	},
    },
	[1352] =
	{
		name = "张让末日",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20067,		--任务结束npc
		preTaskData = {1351},	--任务前置任务没有填nil
		nextTaskID = 1353,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 338,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --阉党头目
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 119,
				dialogID = 332,
				npcsData =			--刷出npc数据
				{
				{npcID = 20065, x = 105, y = 153, noDelete = true},
				{npcID = 20063, x = 102, y = 153, noDelete = true},
				{npcID = 20063, x = 108, y = 153, noDelete = true},
				{npcID = 20064, x = 103, y = 155, noDelete = true},
				{npcID = 20064, x = 106, y = 155, noDelete = true},
				},
				posData	= {mapID = 15, x = 105, y = 153}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] = {type='Tmine',param = --张让亲卫
			{
				mineIndex = 2,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 120,
				dialogID = 334,
				npcsData =			--刷出npc数据
				{
				{npcID = 20066, x = 100, y = 209, noDelete = true},
				{npcID = 20063, x = 100, y = 206, noDelete = true},
				{npcID = 20063, x = 100, y = 212, noDelete = true},
				{npcID = 20064, x = 102, y = 207, noDelete = true},
				{npcID = 20064, x = 102, y = 210, noDelete = true},
				},
				posData	= {mapID = 15, x = 100, y = 209}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[3] = {type='Tmine',param = --张让
			{
				mineIndex = 3,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 121,
				dialogID = 336,
				npcsData =			--刷出npc数据
				{
				{npcID = 20067, x = 136, y = 233, noDelete = true},
				{npcID = 20063, x = 133, y = 233, noDelete = true},
				{npcID = 20063, x = 139, y = 233, noDelete = true},
				{npcID = 20064, x = 134, y = 235, noDelete = true},
				{npcID = 20064, x = 137, y = 235, noDelete = true},
				},
				posData	= {mapID = 15, x = 136, y = 233}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type = "createPrivateNpc", ----------创建私有张让
			param={
				npcs =
				{
				[1] = {npcID = 20067,mapID = 15, x = 136, y = 233,dir = Direction. WestSouth,},
				},
			},
		},
		{type="openDialog", param={dialogID = 338},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1353] =
	{
		name = "御花园寻皇帝",	--任务名字
		startNpcID = 20067,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1352},	--任务前置任务没有填nil
		nextTaskID = 1354,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 15 , x = 178, y = 28, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "autoTrace", param = {tarMapID	= 15, x = 178, y = 28,},}, --寻路到指定地点
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateNpc", ----------删除张宝围困
				param={
						npcs =
						{
							{npcID = 20067,	taskID = {1352}, index = 1},
						},
				},
		},
		{type="openDialog", param={dialogID = 340},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1354}},--触发完成任务接受下一个任务
		},
	},
    },
	[1354] =
	{
		name = "仔细搜查",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1353},	--任务前置任务没有填nil
		nextTaskID = 1355,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 341,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='TautoMeet',param = {mapID = 15 , x = 178, y = 28, bor =	false},},
		[2] = {type='Tscript',param = {scriptID	= 122 ,	count = 1, bor = true},}, --打一个脚本战斗(脚本战斗ID 203，次数)
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createMine",
			param =
				{
				{mapID = 15, scriptID = {122},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
				}
		}, --创建任务雷，如果一个任务在一张地图上，需要打两场任务雷，在两场任务雷的情况下，写这个代码
		},
		[TaskStatus.Done] =
		{
		{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
		{type = "removeMine", param = {}}, -- 移除任务类
		{type = "createPrivateTransfer", ------创建私有传送阵--
			param={
				transfers =
				{
				[1] = {mapID = 15, x =27, y =170, tarMapID = 10, tarX = 31, tarY = 201},
				},
			},
		},
		{type = "autoTrace", param = {tarMapID = 10, x = 46, y = 216,npcID = 20049,},}, --寻路到卢植
		},
	},
    },
	[1355] =
	{
		name = "询问皇甫嵩",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20059,		--任务结束npc
		preTaskData = {1354},	--任务前置任务没有填nil
		nextTaskID = 1356,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 343,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 45, y = 188, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
			param={
					transfers =
					{
					{taskID = 1354, index = 1},
					},
				},
		},
		{type = "openDialog", param={dialogID = 343},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1356] =
	{
		name = "获得坐骑",	--任务名字
		startNpcID = 20059,	--任务起始npc
		endNpcID = 20059,		--任务结束npc
		preTaskData = {1355},	--任务前置任务没有填nil
		nextTaskID = 1357,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 346,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tride',param = {rideID = 134, bor = false},}, ------获得坐骑任务目标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "getRide", param = {rideID = 134, count = 1,}},	--获得指定数量坐骑
		},
		[TaskStatus.Done] =
		{
		{type = "openDialog", param={dialogID = 346},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1357] =
	{
		name = "质问赵忠",	--任务名字
		startNpcID = 20059,	--任务起始npc
		endNpcID = 20070,		--任务结束npc
		preTaskData = {1356},	--任务前置任务没有填nil
		nextTaskID = 1358,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 350,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 123,
				dialogID = 348,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 10, x	= 361, y	= 191}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateNpc", ----------创建私有npc
			param={
				npcs =
					{
					[1] = {npcID = 20070,	mapID =	10, x = 361, y = 191,dir = Direction. South,},
					},
			},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "openDialog", param={dialogID = 350},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1358] =
	{
		name = "探寻黑风岭",	--任务名字
		startNpcID = 20070,	--任务起始npc
		endNpcID = 20071,		--任务结束npc
		preTaskData = {1357},	--任务前置任务没有填nil
		nextTaskID = 1359,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 352,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='TautoMeet',param = {mapID = 104 , x = 205, y = 50, bor =	false},},
		[2] = {type='Tscript',param = {scriptID	= 124 ,	count = 1, bor = true},}, --打一个脚本战斗(脚本战斗ID 203，次数)
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createMine",
			param =
				{
				{mapID = 104, scriptID = {124},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
				}
		}, --创建任务雷，如果一个任务在一张地图上，需要打两场任务雷，在两场任务雷的情况下，写这个代码
		},
		[TaskStatus.Done] =
		{
		{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
		{type = "removeMine", param = {}}, -- 移除任务类
		{type = "deletePrivateNpc", ----------删除赵忠
			param={
					npcs =
					{
					{npcID = 20070,	taskID = {1357}, index = 1},
					},
				},
		},
		{type = "createPrivateNpc", ----------创建探子
			param={
					npcs =
					{
					[1] = {npcID = 20071,	mapID =	104, x = 205, y = 50,dir = Direction. WestSouth,},
					},
			    },
		},
		{type = "openDialog", param={dialogID = 352},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1359] =
	{
		name = "大战张燕",	--任务名字
		startNpcID = 20071,	--任务起始npc
		endNpcID = 20076,		--任务结束npc
		preTaskData = {1358},	--任务前置任务没有填nil
		nextTaskID = 1360,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 360,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --黑风山贼将
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 125,
				dialogID = 354,
				npcsData =			--刷出npc数据
				{
				{npcID = 20074, x = 180, y	= 112, noDelete =	true},
				{npcID = 20072, x = 182, y	= 114, noDelete =	true},
				{npcID = 20072, x = 178, y	= 110, noDelete =	true},
				{npcID = 20073, x = 177, y	= 113, noDelete =	true},
				{npcID = 20073, x = 179, y	= 115, noDelete =	true},
				},
				posData	= {mapID = 104, x	= 180, y	= 112}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] = {type='Tmine',param = --黑风山守卫
			{
				mineIndex = 2,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 126,
				dialogID = 356,
				npcsData =			--刷出npc数据
				{
				{npcID = 20075, x = 116, y	= 131, noDelete =	true},
				{npcID = 20072, x = 116, y	= 128, noDelete =	true},
				{npcID = 20072, x = 116, y	= 134, noDelete =	true},
				{npcID = 20073, x = 113, y	= 131, noDelete =	true},
				{npcID = 20073, x = 113, y	= 134, noDelete =	true},
				},
				posData	= {mapID = 104, x	= 116, y	= 131}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[3] = {type='Tmine',param = --张燕
			{
				mineIndex = 3,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 127,
				dialogID = 358,
				npcsData =			--刷出npc数据
				{
				{npcID = 20076, x = 84, y	= 191, noDelete =	true},
				{npcID = 20072, x = 82, y	= 189, noDelete =	true},
				{npcID = 20072, x = 86, y	= 193, noDelete =	true},
				{npcID = 20073, x = 81, y	= 192, noDelete =	true},
				{npcID = 20073, x = 83, y	= 194, noDelete =	true},
				},
				posData	= {mapID = 104, x	= 84, y	= 191}, --踩雷坐标
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
		{type = "deletePrivateNpc", ----------删除探子
			param={
					npcs =
					{
					{npcID = 20071,	taskID = {1358}, index = 1},
					},
				},
		},
		{type = "createPrivateNpc", ----------创建张燕
			param={
					npcs =
					{
					[1] = {npcID = 20076,	mapID =	104, x = 84, y = 191,dir = Direction. South,},
					},
			    },
		},
		{type = "openDialog", param={dialogID = 360},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1360] =
	{
		name = "深入黑风洞",	--任务名字
		startNpcID = 20076,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1359},	--任务前置任务没有填nil
		nextTaskID = {1361,1363,1365,1367,1369,1371,},--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --黑风山贼将
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 128,
				dialogID = 362,
				npcsData =			--刷出npc数据
				{
				{npcID = 20077, x = 30, y	= 44, noDelete =	true},
				},
				posData	= {mapID = 407, x	= 30, y	= 44}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] =	{type='Tscript',param =	{scriptID = 128	, count	= 1, ignoreResult = true, bor =	true},},--不论胜负
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵
					param={
							transfers =
							{
								[1] = {mapID = 104, x =28, y =180, tarMapID = 407, tarX = 69, tarY = 35},
							},
						},
				},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateNpc", ----------删除张燕
			param={
					npcs =
					{
					{npcID = 20076,	taskID = {1359}, index = 1},
					},
				},
		},
		{type = "deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1360, index = 1},
							},
						},
				},
		{type = "finishTask", param = {recetiveTaskID = {1361,1363,1365,1367,1369,1371,}}},--触发完成任务接受下多个任务
		},
	},
    },
----------------------------------------------开始分门派--------------------------------------
----------------------------------------------乾元岛--------------------------------------
    [1361] =	--乾元岛
	{
		name = "门派求助",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20004,		--任务结束npc
		preTaskData = {1360},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1362,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 364,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 1 , x = 26, y = 84, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 1, x = 85, y = 63,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 1, x = 26, y = 84,npcID = 20004,},}, --寻路到掌门
		},
	},
	},
	[1362] =	--乾元岛
	{
		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20078,		--任务结束npc
		preTaskData = {1361},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1373,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 440,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 112 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 112, x = 80, y = 91,npcID = 20078,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------桃源洞--------------------------------------
    [1363] =	--桃源洞
	{
		name = "门派求助",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20005,		--任务结束npc
		preTaskData = {1360},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1364,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 366,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 4 , x = 59, y = 72, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 4, x = 108, y = 70,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 4, x = 59, y = 72,npcID = 20005,},}, --寻路到掌门
		},
	},
	},
	[1364] =	--桃源洞
	{
		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20078,		--任务结束npc
		preTaskData = {1363},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1373,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 448,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 112 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 112, x = 80, y = 91,npcID = 20078,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------金霞山--------------------------------------
    [1365] =	--金霞山
	{
		name = "门派求助",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20006,		--任务结束npc
		preTaskData = {1360},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1366,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 368,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 3 , x = 26, y = 92, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 3, x = 134, y = 70,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 3, x = 26, y = 92,npcID = 20006,},}, --寻路到掌门
		},
	},
	},
	[1366] =	--金霞山
	{
		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20078,		--任务结束npc
		preTaskData = {1365},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1373,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 444,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 112 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 112, x = 80, y = 91,npcID = 20078,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------蓬莱阁--------------------------------------
    [1367] =	--蓬莱阁
	{
		name = "门派求助",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20007,		--任务结束npc
		preTaskData = {1360},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1368,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 370,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 2 , x = 83, y = 125, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 2, x = 86, y = 32,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 2, x = 83, y = 125,npcID = 20007,},}, --寻路到掌门
		},
	},
	},
	[1368] =	--蓬莱阁
	{
		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20078,		--任务结束npc
		preTaskData = {1367},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1373,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 446,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 112 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 112, x = 80, y = 91,npcID = 20078,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------紫阳门--------------------------------------
    [1369] =	--紫阳门
	{
		name = "门派求助",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20008,		--任务结束npc
		preTaskData = {1360},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1370,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 372,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 6 , x = 67, y = 135, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 6, x = 103, y = 61,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 135,npcID = 20008,},}, --寻路到掌门
		},
	},
	},
	[1370] =	--紫阳门
	{
		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20078,		--任务结束npc
		preTaskData = {1369},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1373,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 448,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 112 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 112, x = 80, y = 91,npcID = 20078,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------云霄宫--------------------------------------
    [1371] =	--云霄宫
	{
		name = "门派求助",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20009,		--任务结束npc
		preTaskData = {1360},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1372,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 374,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 5 , x = 43, y = 112, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		=
		{
		{type="doSwithScene", param = {tarMapID = 5, x = 52, y = 54,}},	--传送到另一个场景
		},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 5, x = 43, y = 112,npcID = 20009,},}, --寻路到掌门
		},
	},
	},
	[1372] =	--云霄宫
	{
		name = "拜访玉泉天",	--任务名字
		startNpcID = 20004,	--任务起始npc
		endNpcID = 20078,		--任务结束npc
		preTaskData = {1371},------{1005},	--任务前置任务没有填nil
		nextTaskID = 1373,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 450,	--交任务对话ID没有填nil
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
		consume	={},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 112 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active]		={},
		[TaskStatus.Done]		=
		{
		{type="autoTrace", param = {tarMapID	= 112, x = 80, y = 91,npcID = 20078,},}, --寻路到掌门
		},
	},
	},
----------------------------------------------分门派结束--------------------------------------
    [1373] =
	{
		name = "收获强援",	--任务名字
		startNpcID = 20078,	--任务起始npc
		endNpcID = 20079,		--任务结束npc
		preTaskData = {condition = "or",{1362,1364,1366,1368,1370,1372}},		--任务前置任务没有填nil
		nextTaskID = 1374,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		--startDialogID =	{441,443,445,447,449,451},	--接任务多个对话ID
		endDialogID = 378,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 104 , x = 35, y = 192, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateNpc", ----------创建私有npc
			param={
						npcs =
						{
						[1] = {npcID = 20079,	mapID =	104, x = 35, y = 192,dir = Direction. South,},
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type="autoTrace", param = {tarMapID	= 104, x = 35, y = 192,npcID = 20079,},}, --寻路到掌门
		},
	},
    },
	[1374] =
	{
		name = "恶战黑风老妖",	--任务名字
		startNpcID = 20079,	--任务起始npc
		endNpcID = 20079,		--任务结束npc
		preTaskData = {1373},	--任务前置任务没有填nil
		nextTaskID = 1375,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 382,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --黑风老妖
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 129,
				dialogID = 380,
				npcsData =			--刷出npc数据
				{
				{npcID = 20077, x = 30, y	= 44, noDelete =	true},
				},
				posData	= {mapID = 407, x	= 30, y	= 44}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵
			param={
						transfers =
						{
						[1] = {mapID = 104, x =28, y =180, tarMapID = 407, tarX = 69, tarY = 35},
						},
				},
		},
		{type = "deletePrivateNpc", ----------删除童子
			param={
						npcs =
						{
						{npcID = 20079,	taskID = {1373}, index = 1},
						},
				},
		},
		{type = "createFollow", param = {npcs = {20079},}},				--创建指定npc跟随(参数npcID)
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
				param={
						transfers =
						{
						{taskID = 1374, index = 1},
						},
				},
		},
		{type = "deleteFollow", param = {npcs = {20079},}}, --在完成状态删除指定ID的npc跟随
		{type = "createPrivateNpc", ----------创建私有npc
				param={
						npcs =
						{
						[1] = {npcID = 20079,	mapID =	407, x = 31, y = 47,dir = Direction. South,},
						[2] = {npcID = 20077,	mapID =	407, x = 30, y = 44,dir = Direction. EastSouth,},
						},
				},
		},
		{type = "openDialog", param={dialogID = 382},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1375] =
	{
		name = "告诉皇甫嵩",	--任务名字
		startNpcID = 20079,	--任务起始npc
		endNpcID = 20059,		--任务结束npc
		preTaskData = {1374},	--任务前置任务没有填nil
		nextTaskID = 1376,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 384,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 45, y = 188, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵
			param={
						transfers =
						{
						[1] = {mapID = 407, x =69, y =35, tarMapID = 104, tarX = 28, tarY = 180},
						},
				},
		},
		{type = "deletePrivateNpc", ----------删除童子、黑风老妖
			param={
						npcs =
						{
						{npcID = 20079,	taskID = {1374}, index = 1},
						{npcID = 20077,	taskID = {1374}, index = 2},
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
				param={
						transfers =
						{
						{taskID = 1375, index = 1},
						},
				},
		},
		{type = "openDialog", param={dialogID = 384},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1376] =
	{
		name = "打败樊稠",	--任务名字
		startNpcID = 20059,	--任务起始npc
		endNpcID = 20084,		--任务结束npc
		preTaskData = {1375},	--任务前置任务没有填nil
		nextTaskID = 1377,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 392,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --镇营大将
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 130,
				dialogID = 386,
				npcsData =			--刷出npc数据
				{
				{npcID = 20082, x = 226, y	= 142, noDelete =	true},
				{npcID = 20080, x = 229, y	= 142, noDelete =	true},
				{npcID = 20080, x = 223, y	= 142, noDelete =	true},
				{npcID = 20081, x = 225, y	= 139, noDelete =	true},
				{npcID = 20081, x = 228, y	= 139, noDelete =	true},
				},
				posData	= {mapID = 106, x	= 226, y	= 142}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] = {type='Tmine',param = --樊定
			{
				mineIndex = 2,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 131,
				dialogID = 388,
				npcsData =			--刷出npc数据
				{
				{npcID = 20083, x = 217, y	= 73, noDelete =	true},
				{npcID = 20080, x = 220, y	= 70, noDelete =	true},
				{npcID = 20080, x = 215, y	= 76, noDelete =	true},
				{npcID = 20081, x = 214, y	= 74, noDelete =	true},
				{npcID = 20081, x = 217, y	= 70, noDelete =	true},
				},
				posData	= {mapID = 106, x	= 217, y	= 73}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[3] = {type='Tmine',param = --樊稠
			{
				mineIndex = 3,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 132,
				dialogID = 390,
				npcsData =			--刷出npc数据
				{
				{npcID = 20084, x = 164, y	= 78, noDelete =	true},
				{npcID = 20080, x = 167, y	= 78, noDelete =	true},
				{npcID = 20080, x = 161, y	= 78, noDelete =	true},
				{npcID = 20081, x = 162, y	= 80, noDelete =	true},
				{npcID = 20081, x = 165, y	= 80, noDelete =	true},
				},
				posData	= {mapID = 106, x	= 164, y	= 78}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type = "createPrivateNpc", ----------创建私有npc
				param={
						npcs =
						{
						[1] = {npcID = 20084,	mapID =	106, x = 164, y = 78,dir = Direction. WestSouth,},
						},
				},
		},
		{type = "openDialog", param={dialogID = 392},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1377] =
	{
		name = "事情严重",	--任务名字
		startNpcID = 20084,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1376},	--任务前置任务没有填nil
		nextTaskID = 1378,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --堳坞魔将
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 133,
				dialogID = 394,
				npcsData =			--刷出npc数据
				{
				{npcID = 20087, x = 162, y	= 154, noDelete =	true},
				{npcID = 20085, x = 165, y	= 154, noDelete =	true},
				{npcID = 20085, x = 159, y	= 154, noDelete =	true},
				{npcID = 20086, x = 160, y	= 156, noDelete =	true},
				{npcID = 20086, x = 163, y	= 156, noDelete =	true},
				},
				posData	= {mapID = 106, x	= 162, y	= 154}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] = {type='Tmine',param = --郿坞妖将
			{
				mineIndex = 2,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 134,
				dialogID = 396,
				npcsData =			--刷出npc数据
				{
				{npcID = 20088, x = 114, y	= 202, noDelete =	true},
				{npcID = 20085, x = 111, y	= 205, noDelete =	true},
				{npcID = 20085, x = 117, y	= 199, noDelete =	true},
				{npcID = 20086, x = 111, y	= 202, noDelete =	true},
				{npcID = 20086, x = 114, y	= 199, noDelete =	true},
				},
				posData	= {mapID = 106, x	= 114, y	= 202}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[3] = {type='Tmine',param = --飞廉
			{
				mineIndex = 3,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 135,
				dialogID = 398,
				npcsData =			--刷出npc数据
				{
				{npcID = 20089, x = 95, y	= 148, noDelete =	true},
				},
				posData	= {mapID = 106, x	= 95, y	= 148}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[4] =	{type='Tscript',param =	{scriptID = 135	, count	= 1, ignoreResult = true, bor =	true},},--不论胜负
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateNpc", ----------删除NPC
			param={
						npcs =
						{
						{npcID = 20084, taskID = {1376}, index = 1},
						},
				},
		},
		{type = "doSwithScene", param = {tarMapID = 106,	x = 172, y = 189,}},	--传送到另一个场景
		{type = "finishTask", param = {recetiveTaskID = 1378}},--触发完成任务接受下一个任务
		},
	},
    },
	[1378] =
	{
		name = "求助天尊",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1377},	--任务前置任务没有填nil
		nextTaskID = 1379,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 400,	--交任务对话ID没有填nil
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
		},
		[TaskStatus.Done] =
		{
		{type = "openDialog", param={dialogID = 400},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1379] =
	{
		name = "联络群雄",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1378},	--任务前置任务没有填nil
		nextTaskID = 1380,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 402,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type = "openDialog", param={dialogID = 402},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1380] =
	{
		name = "大败李肃",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20095,		--任务结束npc
		preTaskData = {1379},	--任务前置任务没有填nil
		nextTaskID = 1381,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 410,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --副将统领
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 136,
				dialogID = 404,
				npcsData =			--刷出npc数据
				{
				{npcID = 20093, x = 250, y	= 98, noDelete =	true},
				{npcID = 20090, x = 253, y	= 98, noDelete =	true},
				{npcID = 20090, x = 247, y	= 98, noDelete =	true},
				{npcID = 20092, x = 251, y	= 101, noDelete =	true},
				{npcID = 20092, x = 248, y	= 101, noDelete =	true},
				},
				posData	= {mapID = 408, x	= 250, y	= 98}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[2] = {type='Tmine',param = --李肃亲卫
			{
				mineIndex = 2,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 137,
				dialogID = 406,
				npcsData =			--刷出npc数据
				{
				{npcID = 20094, x = 184, y	= 105, noDelete =	true},
				{npcID = 20090, x = 184, y	= 108, noDelete =	true},
				{npcID = 20090, x = 185, y	= 102, noDelete =	true},
				{npcID = 20092, x = 181, y	= 104, noDelete =	true},
				{npcID = 20092, x = 181, y	= 107, noDelete =	true},
				},
				posData	= {mapID = 408, x	= 184, y	= 105}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		[3] = {type='Tmine',param = --李肃
			{
				mineIndex = 3,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 138,
				dialogID = 408,
				npcsData =			--刷出npc数据
				{
				{npcID = 20095, x = 87, y	= 286, noDelete =	true},
				{npcID = 20090, x = 90, y	= 286, noDelete =	true},
				{npcID = 20090, x = 84, y	= 286, noDelete =	true},
				{npcID = 20092, x = 85, y	= 288, noDelete =	true},
				{npcID = 20092, x = 88, y	= 288, noDelete =	true},
				},
				posData	= {mapID = 408, x	= 87, y	= 286}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵
			param={
						transfers =
						{
						[1] = {mapID = 109, x =221, y =68, tarMapID = 408, tarX = 311, tarY = 79},
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
				param={
						transfers =
						{
						{taskID = 1380, index = 1},
						},
				},
		},
		{type = "createPrivateNpc", ----------创建私有npc
				param={
						npcs =
						{
						[1] = {npcID = 20095,	mapID =	408, x = 87, y = 286,dir = Direction. WestSouth,},
						},
				},
		},
		{type = "openDialog", param={dialogID = 410},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1381] =
	{
		name = "营救袁绍",	--任务名字
		startNpcID = 20095,	--任务起始npc
		endNpcID = 20091,		--任务结束npc
		preTaskData = {1380},	--任务前置任务没有填nil
		nextTaskID = 1382,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 414,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --侯成
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 139,
				dialogID = 412,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 110, x	= 201, y	= 111}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateTransfer", ------创建私有传送阵
			param={
						transfers =
						{
						[1] = {mapID = 408, x =311, y =79, tarMapID = 109, tarX = 221, tarY = 68},
						},
				},
		},
		{type = "createPrivateNpc", ----------创建侯成包围袁绍
				param={
						npcs =
						{
						[1] = {npcID = 20091,	mapID = 110, x = 201, y = 111,dir = Direction. WestNorth,},--袁绍
						[2] = {npcID = 20098,	mapID = 110, x = 197, y = 111,dir = Direction. EastSouth,},--侯成
						[3] = {npcID = 20096,	mapID = 110, x = 199, y = 108,dir = Direction. EastNorth,},
						[4] = {npcID = 20097,	mapID = 110, x = 203, y = 108,dir = Direction. North,},
						[5] = {npcID = 20111,	mapID = 110, x = 198, y = 114,dir = Direction. South,},
						[6] = {npcID = 20112,	mapID = 110, x = 201, y = 114,dir = Direction. WestSouth,},
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateTransfer", ------删除私有传送阵
				param={
						transfers =
						{
						{taskID = 1381, index = 1},
						},
				},
		},
		{type = "deletePrivateNpc", ----------删除NPC
			param={
						npcs =
						{
						{npcID = 20095, taskID = {1380}, index = 1},
						{npcID = 20098, taskID = {1381}, index = 2},
						{npcID = 20096, taskID = {1381}, index = 3},
						{npcID = 20097, taskID = {1381}, index = 4},
						{npcID = 20111, taskID = {1381}, index = 5},
						{npcID = 20112, taskID = {1381}, index = 6},
						},
				},
		},
		{type = "openDialog", param={dialogID = 414},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1382] =
	{
		name = "护送袁绍",	--任务名字
		startNpcID = 20091,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1381},	--任务前置任务没有填nil
		nextTaskID = 1383,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --段煨
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 140,
				dialogID = 416,
				npcsData =			--刷出npc数据
				{
				{npcID = 20101, x = 142, y	= 121, noDelete =	true},
				{npcID = 20099, x = 140, y	= 119, noDelete =	true},
				{npcID = 20099, x = 144, y	= 123, noDelete =	true},
				{npcID = 20100, x = 141, y	= 124, noDelete =	true},
				{npcID = 20100, x = 139, y	= 122, noDelete =	true},
				},
				posData	= {mapID = 110, x	= 142, y	= 121}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "deletePrivateNpc", ----------删除NPC
			param={
						npcs =
						{
						{npcID = 20091, taskID = {1381}, index = 1},
						},
				},
		},
		{type = "createFollow", param = {npcs = {20091},}},				--创建指定npc跟随(参数npcID)
		},
		[TaskStatus.Done] =
		{
		{type = "openDialog", param={dialogID = 418},}, --在任务结束时打开一个对话框
		{type = "finishTask", param = {recetiveTaskID = 1383}},--触发完成任务接受下一个任务
		},
	},
    },
	[1383] =
	{
		name = "安全到达",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20091,		--任务结束npc
		preTaskData = {1382},	--任务前置任务没有填nil
		nextTaskID = 1384,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 422,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tmine',param = --董旻
			{
				mineIndex = 1,		--第一个雷
				lastMine = true,	--是否为最后一个雷
				scriptID = 141,
				dialogID = 420,
				npcsData =			--刷出npc数据
				{},
				posData	= {mapID = 110, x	= 77, y	= 130}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
		},
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] =
		{
		{type = "createPrivateNpc", ----------创建董旻守关
				param={
						npcs =
						{
						[1] = {npcID = 20109,	mapID = 110, x = 77, y = 130,dir = Direction. EastSouth,},--董旻
						[2] = {npcID = 20102,	mapID = 110, x = 77, y = 127,dir = Direction. EastSouth,},
						[3] = {npcID = 20103,	mapID = 110, x = 77, y = 133,dir = Direction. EastSouth,},
						[4] = {npcID = 20104,	mapID = 110, x = 75, y = 129,dir = Direction. EastSouth,},
						[5] = {npcID = 20105,	mapID = 110, x = 75, y = 132,dir = Direction. EastSouth,},
						},
				},
		},
		},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateNpc", ----------删除NPC
			param={
						npcs =
						{
						{npcID = 20109, taskID = {1383}, index = 1},
						{npcID = 20102, taskID = {1383}, index = 1},
						{npcID = 20103, taskID = {1383}, index = 1},
						{npcID = 20104, taskID = {1383}, index = 1},
						{npcID = 20105, taskID = {1383}, index = 1},
						},
				},
		},
		{type = "deleteFollow", param = {npcs = {20091},}}, --在完成状态删除指定ID的npc跟随
		{type = "createPrivateNpc", ----------创建袁绍
				param={
						npcs =
						{
						[1] = {npcID = 20091,	mapID = 110, x = 77, y = 130,dir = Direction. EastSouth,},--袁绍
						},
				},
		},
		{type = "openDialog", param={dialogID = 422},}, --在任务结束时打开一个对话框
		},
	},
    },
	[1384] =
	{
		name = "回复卢植",	--任务名字
		startNpcID = 20091,	--任务起始npc
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1383},	--任务前置任务没有填nil
		nextTaskID = 1101,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 424,	--交任务对话ID没有填nil
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
		consume	={},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
		[TaskStatus.Active] ={},
		[TaskStatus.Done] =
		{
		{type = "deletePrivateNpc", ----------删除张宝围困
				param={
						npcs =
						{
							{npcID = 20091,	taskID = {1383}, index = 1},
						},
				},
		},
		{type = "openDialog", param={dialogID = 424},}, --在任务结束时打开一个对话框
		},
	},
    },
-----------------------------------------------------------------------------------------------------

}

table.copy(MainTaskDB1_20, NormalTaskDB)