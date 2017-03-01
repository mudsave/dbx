--[[MainTaskDB36_40.lua
	任务配置36到40级(任务系统)
]]

MainTaskDB36_40 = 
{
----------------------主线35-36--------------------------------------
	[1301] =	            --主线35-36
	{
		
		name = "探寻董卓下落",	--任务名字
		startNpcID = 20801,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1225},	--任务前置任务没有填nil
		nextTaskID = 1302,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --牛辅
			{
				mineIndex = 1,		--第一个雷
				scriptID = 220,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1302,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20804, x = 98, y = 211, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20802, x = 100, y = 212, noDelete = true},
					{npcID = 20802, x = 96, y = 210, noDelete = true},
					{npcID = 20803, x = 95, y = 213, noDelete = true},
					{npcID = 20803, x = 97, y = 214, noDelete = true},
				},
				posData = {mapID = 116, x = 98, y = 211}, --踩雷坐标
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
			{type="openDialog", param={dialogID = 1304},}, --在任务结束时打开一个对话框
			{type="createPrivateNpc", ----------创建牛辅
					param={
						npcs =
						{
								[1] = {npcID = 20804,mapID = 116, x = 98, y = 211,dir = South,},
						},
					},
			},
			{type="deletePrivateNpc", ----------删除吕布貂蝉
				param={
						npcs =
						{
							{npcID = 20719,	taskID = {1225}, index = 1},
							{npcID = 20702,	taskID = {1225}, index = 2},
						},
					},
			},
			{type="finishTask", param = {recetiveTaskID = 1302}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1302] =	            --主线35-36
	{
		
		name = "寻觅李儒",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1301},	--任务前置任务没有填nil
		nextTaskID = 1303,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --左灵
			{
				mineIndex = 1,		--第一个雷
				scriptID = 221,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1306,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20809, x = 37, y = 229, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20805, x = 36, y = 233, noDelete = true},
					{npcID = 20805, x = 38, y = 225, noDelete = true},
					{npcID = 20806, x = 33, y = 232, noDelete = true},
					{npcID = 20806, x = 34, y = 228, noDelete = true},
				},
				posData = {mapID = 116, x = 37, y = 229}, --踩雷坐标
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
			{type="deletePrivateNpc", ----------删除牛辅
				param={
						npcs =
						{
							{npcID = 20804,	taskID = {1301}, index = 1},
						},
					},
			},
			{type="createPrivateNpc", ----------创建左灵
					param={
						npcs =
						{
								[1] = {npcID = 20809,mapID = 116, x = 37, y = 229,dir = EastSouth,},
						},
					},
			},
			{type="openDialog", param={dialogID = 1308},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1303}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1303] =	            --主线35-36
	{
		
		name = "勇闯长安",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1302},	--任务前置任务没有填nil
		nextTaskID = 1304,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --梁冀
			{
				mineIndex = 1,		--第一个雷
				scriptID = 222,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1310,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 13, x = 54, y = 98}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		}, 
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态 
			{
			{type="createPrivateNpc", ----------创建梁冀
					param={
						npcs =
						{
								[1] = {npcID = 20812, mapID = 13, x = 54, y = 98,dir = WestSouth,},
								[2] = {npcID = 20807, mapID = 13, x = 56, y = 98,dir = WestSouth,},
								[3] = {npcID = 20808, mapID = 13, x = 52, y = 98,dir = WestSouth,},
								[4] = {npcID = 20810, mapID = 13, x = 55, y = 101,dir = WestSouth,},
								[5] = {npcID = 20811, mapID = 13, x = 52, y = 101,dir = WestSouth,},
						},
					},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除左灵
				param={
						npcs =
						{
							{npcID = 20809,	taskID = {1302}, index = 1},
						},
					},
			},
			{type="openDialog", param={dialogID = 1312},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", ----------删除梁冀
				param={
						npcs =
						{
							{npcID = 20812,	taskID = {1303}, index = 1},
							{npcID = 20807,	taskID = {1303}, index = 2},
							{npcID = 20808,	taskID = {1303}, index = 3},
							{npcID = 20810,	taskID = {1303}, index = 4},
							{npcID = 20811,	taskID = {1303}, index = 5},
						},
					},
			},
			{type="finishTask", param = {recetiveTaskID = 1304}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1304] =	            --主线35-36
	{
		
		name = "降服李儒",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = 20813,	--任务结束npc
		preTaskData = {1303},	--任务前置任务没有填nil
		nextTaskID = 1305,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1315,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --李儒
			{
				mineIndex = 1,		--第一个雷
				scriptID = 223,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1313,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 13, x = 161, y = 105}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		}, 
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态 
			{
			{type="createPrivateNpc", ----------创建李儒
					param={
						npcs =
						{
								[1] = {npcID = 20813, mapID = 13, x = 161, y = 105,dir = WestSouth,},
						},
					},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="openDialog", param={dialogID = 1315},}, --在任务结束时打开一个对话框
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1305] =	            --主线35-36
	{
		
		name = "问题复杂",	--任务名字
		startNpcID = 20813,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1304},	--任务前置任务没有填nil
		nextTaskID = 1306,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --臧霸
			{
				mineIndex = 1,		--第一个雷
				scriptID = 224,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1317,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20816, x = 148, y = 153, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20814, x = 151, y = 153, noDelete = true},
					{npcID = 20814, x = 145, y = 153, noDelete = true},
					{npcID = 20815, x = 147, y = 150, noDelete = true},
					{npcID = 20815, x = 150, y = 150, noDelete = true},
				},
				posData = {mapID = 115, x = 148, y = 153}, --踩雷坐标
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
			{type="openDialog", param={dialogID = 1319},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", ----------删除李儒
				param={
						npcs =
						{
							{npcID = 20813,	taskID = {1304}, index = 1},
						},
					},
			},
			{type="finishTask", param = {recetiveTaskID = 1306}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1306] =	            --主线35-36
	{
		
		name = "遭遇陷阱",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1305},	--任务前置任务没有填nil
		nextTaskID = 1307,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10004,--采集的实体ID
					scriptID= 225,
					dialogID = 1320,
					npcsData =			--刷出npc数据
					{
						{npcID = 20817, x = 166, y = 155,},--邪教魔化护法
				},
						
			}
		},
		[2] = {type='TcontactSeal',param = {sealID = 10004, bor = true},},---任务目标 例如：摧毁需破坏的阵法或者摧毁采集的物品
		}, 
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态 
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="openDialog", param={dialogID = 1322},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1307}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1307] =	            --主线35-36
	{
		
		name = "继续寻找",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1306},	--任务前置任务没有填nil
		nextTaskID = 1308,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		    [1] = {type='Tmine',param =     --郭汜
			{
				mineIndex = 1,		--第一个雷
				scriptID = 226,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1323,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20818, x = 137, y = 123, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20814, x = 140, y = 123, noDelete = true},
					{npcID = 20814, x = 134, y = 123, noDelete = true},
					{npcID = 20815, x = 138, y = 126, noDelete = true},
					{npcID = 20815, x = 135, y = 126, noDelete = true},
				},
				posData = {mapID = 110, x = 137, y = 123}, --踩雷坐标
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
			{type="openDialog", param={dialogID = 1325},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1308}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1308] =	            --主线35-36
	{
		
		name = "再遇陷阱",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = nil,	--任务结束npc
		preTaskData = {1307},	--任务前置任务没有填nil
		nextTaskID = 1309,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10006,--采集的实体ID
					scriptID = 227,
					dialogID = 1326,
					npcsData =			--刷出npc数据
					{
						{npcID = 20819, x = 139, y = 149,},--金翅大鹏王
				},
						
			}
		},
		[2] = {type='TcontactSeal',param = {sealID = 10006, bor = false},},---任务目标 例如：摧毁需破坏的阵法或者摧毁采集的物品
		}, 
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态 
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="openDialog", param={dialogID = 1328},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1309}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1309] =	            --主线35-36
	{
		
		name = "最后入口",	--任务名字
		startNpcID = nil,	--任务起始npc22
		endNpcID = 20820,	--任务结束npc
		preTaskData = {1308},	--任务前置任务没有填nil
		nextTaskID = {1310,1312,1314,1316,1318,1320},--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1331,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		    [1] = {type='Tmine',param =     --高顺
			{
				mineIndex = 1,		--第一个雷
				scriptID = 228,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1329,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20820, x = 92, y = 222, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20814, x = 90, y = 220, noDelete = true},
					{npcID = 20814, x = 94, y = 224, noDelete = true},
					{npcID = 20815, x = 88, y = 224, noDelete = true},
					{npcID = 20815, x = 90, y = 226, noDelete = true},
				},
				posData = {mapID = 116, x = 92, y = 222}, --踩雷坐标
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
			{type="openDialog", param={dialogID = 1331},}, --在任务结束时打开一个对话框
			{type="createPrivateNpc", ----------创建高顺
					param={
						npcs =
						{
								[1] = {npcID = 20820,mapID = 116, x = 92, y = 222,dir = South,},
						},
					},
			},
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
----------------------------------------------------乾元岛
	[1310] =	--乾元岛
	{

		name = "面临难题",	--任务名字
		startNpcID = 20820,	--任务起始npc 
		endNpcID = 20004,		--任务结束npc    
		preTaskData = {1309},	--任务前置任务没有填nil
		nextTaskID = 1311,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1334,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
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
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 1, x = 26, y = 84,npcID = 20004,},}, --寻路到掌门
			},
		},
	},
	[1311] =	--乾元岛
	{

		name = "询问掌门",	--任务名字
		startNpcID = 20004,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc    
		preTaskData = {1310},	--任务前置任务没有填nil
		nextTaskID = 1322,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1336,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.QYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
	----------------------------------------------------桃源洞
	[1312] =	--桃源洞
	{

		name = "面临难题",	--任务名字
		startNpcID = 20820,	--任务起始npc 
		endNpcID = 20005,		--任务结束npc    
		preTaskData = {1309},	--任务前置任务没有填nil
		nextTaskID = 1313,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1339,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
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
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 4, x = 60, y = 72,npcID = 20005,},}, --寻路到掌门
			},
		},
	},
	[1313] =	--桃源洞
	{

		name = "询问掌门",	--任务名字
		startNpcID = 20005,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc    
		preTaskData = {1312},	--任务前置任务没有填nil
		nextTaskID = 1322,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1341,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.TYD,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
	----------------------------------------------------金霞山
	[1314] =	--金霞山
	{

		name = "面临难题",	--任务名字
		startNpcID = 20820,	--任务起始npc 
		endNpcID = 20006,		--任务结束npc   
		preTaskData = {1309},	--任务前置任务没有填nil
		nextTaskID = 1315,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1344,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
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
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 3, x = 28, y = 92,npcID = 20006,},}, --寻路到掌门
			},
		},
	},
	[1315] =	--金霞山
	{

		name = "询问掌门",	--任务名字
		startNpcID = 20006,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc   
		preTaskData = {1314},	--任务前置任务没有填nil
		nextTaskID = 1322,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1346,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.JXS,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
	----------------------------------------------------蓬莱阁
	[1316] =	--蓬莱阁
	{

		name = "面临难题",	--任务名字
		startNpcID = 20820,	--任务起始npc 
		endNpcID = 20007,		--任务结束npc  
		preTaskData = {1309},	--任务前置任务没有填nil
		nextTaskID = 1317,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1349,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
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
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 2, x = 84, y = 124,npcID = 20007,},}, --寻路到掌门
			},
		},
	},
	[1317] =	--蓬莱阁
	{

		name = "询问掌门",	--任务名字
		startNpcID = 20007,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc   
		preTaskData = {1316},	--任务前置任务没有填nil
		nextTaskID = 1322,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1351,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.PLG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
	----------------------------------------------------紫阳门
	[1318] =	--紫阳门
	{

		name = "面临难题",	--任务名字
		startNpcID = 20820,	--任务起始npc 
		endNpcID = 20008,		--任务结束npc  
		preTaskData = {1309},	--任务前置任务没有填nil
		nextTaskID = 1319,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1354,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
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
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 6, x = 67, y = 133,npcID = 20008,},}, --寻路到掌门
			},
		},
	},
	[1319] =	--紫阳门
	{

		name = "询问掌门",	--任务名字
		startNpcID = 20008,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc    
		preTaskData = {1318},	--任务前置任务没有填nil
		nextTaskID = 1322,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1356,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.ZYM,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
	----------------------------------------------------云霄宫
	[1320] =	--云霄宫
	{

		name = "面临难题",	--任务名字
		startNpcID = 20820,	--任务起始npc 
		endNpcID = 20009,		--任务结束npc    
		preTaskData = {1309},	--任务前置任务没有填nil
		nextTaskID = 1321,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1359,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
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
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				}
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 5, x = 44, y = 111,npcID = 20009,},}, --寻路到掌门
			},
		},
	},
	[1321] =	--云霄宫
	{

		name = "询问掌门",	--任务名字
		startNpcID = 20009,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc
		preTaskData = {1320},	--任务前置任务没有填nil
		nextTaskID = 1322,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1361,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = SchoolType.YXG,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 35000,    --绑银
			[TaskRewardList.player_pot] = 10500,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
				{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
	----------------------------------------------------分门派结束
	[1322] =	--主线35-36
	{

		name = "解决方案",	--任务名字
		startNpcID = 20829,	--任务起始npc 
		endNpcID = 20829,	--任务结束npc
		preTaskData = {condition = "or",{1311,1313,1315,1317,1319,1321}},		--任务前置任务没有填nil
		nextTaskID = 1323,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1363,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1363},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1323] =	            --主线35-36
	{
		
		name = "采集材料",	--任务名字
		startNpcID = 20829,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1322},	--任务前置任务没有填nil
		nextTaskID = 1324,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10005,--采集的实体ID
					scriptID = 229 ,
					dialogID = 1364,
					npcsData =			--刷出npc数据
					{
						{npcID = 20821, x = 46, y = 127,},--守护灵兽
					},	
				}
		},
		[2] = {type = "TgetItem", param = {itemID = 1041001, count = 1 ,bor = false},}--任务目标获取物品
		}, 
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=      ---接任务状态 
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="openDialog", param={dialogID = 1367},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1324}},--触发完成任务接受下一个任务
			},
		},		
	},
	[1324] =	--主线35-36
	{

		name = "再获材料",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1323},		--任务前置任务没有填nil
		nextTaskID = 1325,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --牛魔
			{
				mineIndex = 1,		--第一个雷
				scriptID = 230,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1368,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20822, x = 60, y = 166, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
				},
				posData = {mapID = 104, x = 60, y = 166}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
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
			{type="getItem", param = {itemID = 1041002, count = 1,}},			--获得指定数量的物品(参数物品ID，数量)
			{type="openDialog", param={dialogID = 1370},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1325}},--触发完成任务接受下一个任务
			},
		},
	},
	[1325] =	            --主线35-36
	{
		
		name = "失落而归",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1324},	--任务前置任务没有填nil
		nextTaskID = 1339,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level = {1,150},--等级限制
		rewards = --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		}, 
		consume =--任务消耗没有填{}
		{
		},
		targets = --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 115, x = 65, y = 186, bor =	false},},-------到达指定坐标
		}, 
		triggers = --任务触发器
		{
		    [TaskStatus.Active]		=      ---接任务状态 
			{
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="openDialog", param={dialogID = 1371},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1339}},--触发完成任务接受下一个任务
			},
			[TaskStatus.Finished]	=      ---完成任务状态 
			{
			}
	},
	},
	[1326] =	
	{

		name = "得知下落",	--任务名字
		startNpcID = 20829,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc    
		preTaskData = {1325},	--任务前置任务没有填nil
		nextTaskID = 1327,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1378,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
            [TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='TautoMeet',param = {mapID = 110 , x = 24, y = 171, bor = false},},---到达一个坐标自动遇敌
			[2] = {type='Tscript',param = {scriptID	= 231,count = 1, bor = false},}, --打一个脚本战斗(脚本战斗ID 203，次数)
			[3] = {type='Tscript',param = {scriptID	= 232,count = 1, bor = true},}, --打一个脚本战斗(脚本战斗ID 203，次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{"createMine",
					param =
					{
					{mapID = 110, scriptID = {231,232},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
					}
			} --创建任务雷，如果一个任务在一张地图上，需要打两场任务雷，级两场任务雷的情况下，写这个代码
			},
			[TaskStatus.Done]		=
			{
			{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			{type = "removeMine", param = {}}, -- 移除任务类
			{type="getItem", param = {itemID = 1041003, count = 1,}},			--获得指定数量的物品(参数物品ID，数量)
			{type="createPrivateNpc", ----------创建雪融木
					param={
						npcs =
						{
								[1] = {npcID = 20823,mapID = 110, x = 24, y = 171,dir = South,},
						},
					},
			},
			{type="openDialog", param={dialogID = 1376},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1327] =	--主线35-36
	{

		name = "铲除强盗",	--任务名字
		startNpcID = 29030,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc
		preTaskData = {1326},		--任务前置任务没有填nil
		nextTaskID = 1328,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1382,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --胡大力
			{
				mineIndex = 1,		--第一个雷
				scriptID = 233,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1380,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20824, x = 198, y = 47, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 20832, x = 201, y = 44, noDelete = true},
					{npcID = 20832, x = 195, y = 50, noDelete = true},
					{npcID = 20832, x = 195, y = 47, noDelete = true},
					{npcID = 20832, x = 198, y = 44, noDelete = true},
				},
				posData = {mapID = 110, x = 198, y = 47}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="deletePrivateNpc", ----------删除雪融木
				param={
						npcs =
						{
							{npcID = 20823,	taskID = {1326}, index = 1},
						},
					},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 13, x = 96, y = 71,npcID = 29030,},}, --寻路到知天命
			},
			[TaskStatus.Finished]	=
			{
			{type="getItem", param = {itemID = 1041004, count = 1,}},			--获得指定数量的物品(参数物品ID，数量)
			}
		},
	},
	[1328] =	--主线35-36
	{

		name = "炼制秘符",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc
		preTaskData = {1327},		--任务前置任务没有填nil
		nextTaskID = 1329,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1385,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			--[1] = {type='Tarea',param = {mapID = 129 , x = 121, y = 34, bor = false},},-------到达指定坐标
			[1] = {type = "TcommitItem", param = {taskID = 1328,itemsInfo = {{itemID = 1041001, count = 1},{itemID = 1041002, count = 1},{itemID = 1041003, count = 1},{itemID = 1041004, count = 1}} ,bor = true},}

		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				{type="CreateIntemDirect",param = {taskID = 1328,itemsInfo = {{itemID = 1041001, count = 1},{itemID = 1041002, count = 1},{itemID = 1041003, count = 1},{itemID = 1041004, count = 1}}}},
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1385},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1329] =	--主线35-36
	{

		name = "炼制成功",	--任务名字
		startNpcID = 20829,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc
		preTaskData = {1328},		--任务前置任务没有填nil
		nextTaskID = 1330,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1387,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
				
			},
			[TaskStatus.Done]		=
			{
				{type="finishTask", param = {}},
			},
		},
	},
	[1330] =	--主线35-36
	{

		name = "破除封印",	--任务名字
		startNpcID = 20829,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1329},		--任务前置任务没有填nil
		nextTaskID = 1331,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10007,--采集的实体ID
					scriptID = 234,
					dialogID = 1389,
					npcsData =			--刷出npc数据
					{
						{npcID = 20825, x = 64, y = 263,},--守阵阵灵1
					},	
				}
		},
		[2] = {type='TcontactSeal',param = {sealID = 10007, bor = false},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1391},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1331}},--触发完成任务接受下一个任务
			},
		},
	},
	[1331] =	--主线35-36
	{

		name = "破除封印",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1330},		--任务前置任务没有填nil
		nextTaskID = 1332,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10008,--采集的实体ID
					scriptID = 235,
					dialogID = 1392,
					npcsData =			--刷出npc数据
					{
						{npcID = 20826, x = 58, y = 190,},--守阵阵灵2
					},	
				}
		},
		[2] = {type='TcontactSeal',param = {sealID = 10008, bor = false},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1394},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1332}},--触发完成任务接受下一个任务
			},
		},
	},
	[1332] =	--主线35-36
	{

		name = "破除封印",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1331},		--任务前置任务没有填nil
		nextTaskID = 1333,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10009,--采集的实体ID
					scriptID = 236,
					dialogID = 1395,
					npcsData =			--刷出npc数据
					{
						{npcID = 20827, x = 113, y = 128,},--守阵阵灵3
					},	
				}
		},
		[2] = {type='TcontactSeal',param = {sealID =10009, bor = false},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1397},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1333}},--触发完成任务接受下一个任务
			},
		},
	},
	[1333] =	--主线35-36
	{

		name = "破除封印",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1332},		--任务前置任务没有填nil
		nextTaskID = 1334,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10010,--采集的实体ID
					scriptID = 237,
					dialogID = 1398,
					npcsData =			--刷出npc数据
					{
						{npcID = 20828, x = 185, y = 71,},--守阵阵灵4
					},	
				}
		},
		[2] = {type='TcontactSeal',param = {sealID =10010, bor = false},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1480},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1334}},--触发完成任务接受下一个任务
			},
		},
	},
	[1334] =	--主线35-36
	{

		name = "拉拢帮手",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 20801,		--任务结束npc
		preTaskData = {1333},		--任务前置任务没有填nil
		nextTaskID = 1335,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1481,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 116 , x = 154, y = 149, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc", ----------创建吕布
					param={
						npcs =
						{
								[1] = {npcID = 20801,mapID = 116, x = 154, y = 149,dir = EastSouth,},
						},
					},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1481},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1335] =	--主线35-36
	{

		name = "大战飞廉",	--任务名字
		startNpcID = 20801,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1334},		--任务前置任务没有填nil
		nextTaskID = 1336,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tmine',param =     --飞廉
			{
				mineIndex = 1,		--第一个雷
				scriptID = 238,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1484,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 20830, x = 120, y = 71,noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
				},
				posData = {mapID = 130, x = 120, y = 71}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
		},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="deletePrivateNpc", ----------删除吕布
				param={
						npcs =
						{
							{npcID = 20801,	taskID = {1334}, index = 1},
						},
					},
			},
			{type="createFollow", param = {npcs = {20801},}},				--创建指定npc跟随(参数npcID)
			{type="createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 113, x =179, y =206, tarMapID = 116, tarX = 216, tarY = 40},
								[2] = {mapID = 116, x =228, y =135, tarMapID = 130, tarX = 127, tarY = 37},
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
								{taskID = 1335, index = 1},
								{taskID = 1335, index = 2},
							},
						},
			},
			{type="openDialog", param={dialogID = 1486},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1336}},--触发完成任务接受下一个任务
			},
		},
	},
	[1336] =	--主线35-36
	{

		name = "暴君身陨",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1335},		--任务前置任务没有填nil
		nextTaskID = 1337,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1490,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tmine',param =     --董卓
			{
				mineIndex = 1,		--第一个雷
				scriptID = 239,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1487,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
				},
				posData = {mapID = 130, x = 114, y = 140}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
		},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateNpc", ----------创建董卓、汉献帝
					param={
						npcs =
						{
								[1] = {npcID = 20831,mapID = 130, x = 114, y = 145,dir = WastSouth,},
								[2] = {npcID = 20833,mapID = 130, x = 114, y = 140,dir = EastSouth,},
						},
					},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="deleteFollow", param = {npcs = {20801},}}, --在完成状态删除指定ID的npc跟随
			{type="deletePrivateNpc", ----------删除董卓
				param={
						npcs =
						{
							{npcID = 20831,	taskID = {1336}, index = 1},
						},
					},
			},
			{type="openDialog", param={dialogID = 1489},}, --在任务结束时打开一个对话框
			{type="createPrivateNpc", ----------创建吕布
					param={
						npcs =
						{
								[1] = {npcID = 20801,mapID = 130, x = 119, y = 138,dir = WastSouth,},
						},
					},
			},
			{type="createPrivateTransfer", ------创建私有传送阵
					param={
							transfers =
							{
								[1] = {mapID = 130, x =125, y =222, tarMapID = 10, tarX = 112, tarY = 196},
							},
						},
			},
			},
		},
	},
	[1337] =	--主线35-36
	{

		name = "帝王危机",	--任务名字
		startNpcID = 20049,	--任务起始npc 
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1336},		--任务前置任务没有填nil
		nextTaskID = 1338,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1492,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="deletePrivateNpc", ----------删除吕布、汉献帝
				param={
						npcs =
						{
							{npcID = 20833,	taskID = {1336}, index = 2},
							{npcID = 20801,	taskID = {1336}, index = 1},
						},
					},
			},
			{type="deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1336, index = 1},
							},
						},
			},
			},
			[TaskStatus.Done]		=
			{
			},
		},
	},
	[1338] =	--主线35-36
	{

		name = "求助师祖",	--任务名字
		startNpcID = 20049,	--任务起始npc 
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1337},		--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1493,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 218, bor =	false},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1493},},
			{type="finishTask", param = {recetiveTaskID =1401}},
			},
		},
	},
	[1339] =	--主线35-36
	{

		name = "询问下落",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 20829,		--任务结束npc
		preTaskData = {1325},		--任务前置任务没有填nil
		nextTaskID = 1326,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1372,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 8000,      --宠物经验
			[TaskRewardList.subMoney] = 36000,    --绑银
			[TaskRewardList.player_pot] = 10800,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 129 , x = 80, y = 91, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			},
			[TaskStatus.Done]		=
			{
			{type="autoTrace", param = {tarMapID	= 129, x = 80, y = 91,npcID = 20829,},}, --寻路到清虚道德真君 
			},
		},
	},
----------------------主线37-38--------------------------------------
[1401] =
	{
		name = "真龙之气",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1338}, --前置任务ID 
		nextTaskID = 1402,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1402,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 36000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能

		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1402},},
				},
		},
	},
	[1402] =
	{
		name = "轩辕图线索",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20701,	--任务结束npc
		preTaskData = {1401}, --前置任务ID 
		nextTaskID = 1402,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1404,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 13 , x = 54, y = 145, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{

			[TaskStatus.Active] =
			{
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1404},},
				},
		},
	},
	[1403] =
	{
		name = "收拾董军残敌",	--任务名字
		startNpcID = 20701,	--任务起始npc
		endNpcID =20901,	--任务结束npc
		preTaskData = {1402},	--任务前置任务没有填nil
		nextTaskID = 1403,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1408,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 301,
				dialogID = 1406,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20901,	x = 198, y = 140,noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20902,	x = 196, y = 142,noDelete = true},
					{npcID = 20902,	x = 196, y = 139,noDelete = true},
					{npcID = 20903,	x = 198, y = 142,noDelete = true},
					{npcID = 20903,	x = 198, y = 138,noDelete = true},
				},
					posData	= {mapID = 106,	x = 200, y = 140},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]	=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20901,	mapID =	106, x =198, y = 140,dir = EastSouth,},
					},
				},
			},
			{type="openDialog", param={dialogID = 1408},},
			},
		},
	},

	[1404] =
	{
		name = "拜访陶谦",	--任务名字
		startNpcID = 20901,	--任务起始npc
		endNpcID =20905,	--任务结束npc
		preTaskData = {1403},	--任务前置任务没有填nil
		nextTaskID = 1405,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1412,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 302,
				dialogID = 1409,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20905,	x = 39, y = 171,noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20906,	x = 39, y = 173,noDelete = true},
					{npcID = 20906,	x = 37, y = 171,noDelete = true},
					{npcID = 20907,	x = 38, y = 169,noDelete = true},
					{npcID = 20907,	x = 41, y = 172,noDelete = true},
				},
					posData	= {mapID = 118,	x = 41, y = 169},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]	=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20905,	mapID =	118, x =39, y = 171,dir = EastSouth,},
					},
				},
			},
			{type="openDialog", param={dialogID = 1411},},
			{type="deletePrivateNpc", ----------删除NPC
					param={
						npcs =
						{
                                                {npcID = 20901,	taskID = {1403}, index = 1},
	                                        },
					      },
			},
			},
		},
	},

	[1405] =
	{
		name = "打败夏侯惇",	--任务名字
		startNpcID = 20905,	--任务起始npc
		endNpcID =20908,	--任务结束npc
		preTaskData = {1404},	--任务前置任务没有填nil
		nextTaskID = 1406,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1415,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 303,
				dialogID = 1413,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20908,	x = 160, y = 56,noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20906,	x = 162, y = 57,noDelete = true},
					{npcID = 20906,	x = 162, y = 55,noDelete = true},
					{npcID = 20907,	x = 160, y = 58,noDelete = true},
					{npcID = 20907,	x = 160, y = 54,noDelete = true},
				},
					posData	= {mapID = 118,	x = 158, y = 57},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]	=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20908,	mapID =	118, x =160, y = 56,dir = WastNorth,},
					},
				},
			},
			{type="openDialog", param={dialogID = 1415},},
			},
		},
	},

	[1406] =
	{
		name = "打败曹操亲卫",	--任务名字
		startNpcID = 20908,	--任务起始npc
		endNpcID =20911,	--任务结束npc
		preTaskData = {1405},	--任务前置任务没有填nil
		nextTaskID = 1425,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1472,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 304,
				dialogID = 1416,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20911,	x = 115, y = 206,noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20912,	x = 114, y = 208,noDelete = true},
					{npcID = 20912,	x = 116, y = 208,noDelete = true},
					{npcID = 20913,	x = 113, y = 206,noDelete = true},
					{npcID = 20913,	x = 117, y = 206,noDelete = true},
				},
					posData	= {mapID = 118,	x = 116, y = 204},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
				{type="deletePrivateNpc", ----------删除高顺
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done]	=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20313,mapID = 118, x = 149, y = 225,dir = West,},
					[2] = {npcID = 20911,mapID = 118, x = 115, y = 206,dir = South,},
					},
				},
			},
			{type="openDialog", param={dialogID = 1472},},
			{type="deletePrivateNpc", ----------删除NPC
					param={
						npcs =
						{
                                                {npcID = 20908,	taskID = {1405}, index = 1},
	                                        },
					      },
			},
			},
		},
	},

	[1425] =
	{
		name = "会见曹操",	--任务名字
		startNpcID = 20911,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1406}, --前置任务ID 
		nextTaskID = 1407,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1418,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 118 , x = 147, y = 223, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type="deletePrivateNpc", 
				param={
						npcs =
						{
							{npcID = 20820,	taskID = {1309}, index = 1},
						},
					},
				},
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1418},},
				},
		},
	},

	[1407] =
	{
		name = "询问陈登",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = 20905,	--任务结束npc
		preTaskData = {1425}, --前置任务ID 
		nextTaskID = 1408,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1420,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 118 , x = 41, y = 169, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1420},},
				},
		},
	},

	[1408] =
	{
		name = "探寻张闿",	--任务名字
		startNpcID = 20905,	--任务起始npc
		endNpcID =20914,	--任务结束npc
		preTaskData = {1407},	--任务前置任务没有填nil
		nextTaskID = 1409,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1424,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 305,
				dialogID = 1422,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20914,	x = 91, y = 198,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20915,	x = 90, y = 200,noDelete = true},
					{npcID = 20915,	x = 89, y = 199,noDelete = true},
					{npcID = 20916,	x = 92, y = 199,noDelete = true},
					{npcID = 20916,	x = 90, y = 197,noDelete = true},
				},
					posData	= {mapID = 118,	x = 92, y = 197},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20914,mapID = 118, x = 91, y = 198,dir = South,},
					},
				},
			},
			{type="openDialog", param={dialogID = 1424},},
			},
		},
	},

	[1409] =
	{
		name = "误会冲突",	--任务名字
		startNpcID = 20914,	--任务起始npc
		endNpcID =20917,	--任务结束npc
		preTaskData = {1408},	--任务前置任务没有填nil
		nextTaskID = 1410,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1427,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 306,
				dialogID = 1425,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20917,	x = 200, y = 73,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20918,	x = 197, y = 74,noDelete = true},
					{npcID = 20918,	x = 198, y = 71,noDelete = true},
					{npcID = 20919,	x = 198, y = 76,noDelete = true},
					{npcID = 20919,	x = 201, y = 70,noDelete = true},
				},
					posData	= {mapID = 119,	x = 202, y = 74},
					bor = true,
			},
			},
		},
		consume =--任务消耗没有填{}
		{
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20917,mapID = 119, x = 200, y = 73,dir = Direction. South,},
					},
				},
			},
			{type="deletePrivateNpc", ----------删除NPC
					param={
					npcs =
					{
						{npcID = 20914,	taskID = {1408}, index = 1},
	                                },
					},
					},
			{type="openDialog", param={dialogID = 1427},},
			},
		},
	},

	[1410] =
	{
		name = "勇闯军营",	--任务名字
		startNpcID = 20917,	--任务起始npc
		endNpcID =nil,	--任务结束npc
		preTaskData = {1409},	--任务前置任务没有填nil
		nextTaskID = 1411,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = false,
				scriptID= 307,
				dialogID = 1429,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20920,	x = 148, y = 134,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20921,	x = 146, y = 136,noDelete = true},
					{npcID = 20921,	x = 146, y = 132,noDelete = true},
					{npcID = 20922,	x = 149, y = 137,noDelete = true},
					{npcID = 20922,	x = 149, y = 131,noDelete = true},
				},
					posData	= {mapID = 119,	x = 150, y = 134},
					bor = false,
			},
		},
			[2] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 2,
				lastMine = true,
				scriptID= 308,
				dialogID = 1431,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20923,	x = 78, y = 133,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20921,	x = 76, y = 135,noDelete = true},
					{npcID = 20921,	x = 76, y = 131,noDelete = true},
					{npcID = 20924,	x = 79, y = 136,noDelete = true},
					{npcID = 20924,	x = 79, y = 130,noDelete = true},
				},
					posData	= {mapID = 119,	x = 80, y = 133},
					bor = true,
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="openDialog", param={dialogID = 1433},},
			{type="finishTask", param = {recetiveTaskID =1411}},
			},
		},
	},

	[1411] =
	{
		name = "斩杀张闿",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID =nil,	--任务结束npc
		preTaskData = {1410},	--任务前置任务没有填nil
		nextTaskID = 1424,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 309,
				dialogID = 1434,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20925,	x = 24, y = 160,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20927,	x = 22, y = 158,noDelete = true},
					{npcID = 20927,	x = 22, y = 162,noDelete = true},
					{npcID = 20926,	x = 25, y = 163,noDelete = true},
					{npcID = 20926,	x = 25, y = 157,noDelete = true},
					},
					posData	= {mapID = 119,	x = 26, y = 160},
					bor = true,
			},
		},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="openDialog", param={dialogID = 1473},},
			{type="finishTask", param = {recetiveTaskID =1424}},
			},
		},
	},

	[1424] =
	{
		name = "再见曹操",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20313,	--任务结束npc
		preTaskData = {1411}, --前置任务ID 
		nextTaskID = 1412,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1436,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 118, x = 149, y = 225, bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			},
			[TaskStatus.Done] =
			{
				{type="openDialog", param={dialogID = 1436},},
			},
		},
	},

	[1412] =
	{
		name = "事情解决",	--任务名字
		startNpcID = 20313,	--任务起始npc
		endNpcID = 20905,	--任务结束npc
		preTaskData = {1411}, --前置任务ID 
		nextTaskID = 1413,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1439,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 37000,   	--玩家绑银   
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11100,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 118 , x = 41, y = 169, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20904,mapID = 118, x = 37, y = 169,dir = South,},
					},
				},
			},
			},
			[TaskStatus.Done] =
			{
				{type="openDialog", param={dialogID = 1438},},
				{type="getItem", param = {itemID = 1041009, count = 1,}},--获得物品轩辕图
				{type="deletePrivateNpc", ----------删除NPC
				param={
					npcs =
					{
						{npcID = 20313,	taskID = {1406}, index = 1},
						{npcID = 20911,	taskID = {1406}, index = 2},
	                                },
				},
				},
			},
		},
	},

	[1413] =
	{
		name = "询问卢植",	--任务名字
		startNpcID = 20705,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1412}, --前置任务ID 
		nextTaskID = 1414,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1441,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 46, y = 216, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{{"autoTrace", param = {tarMapID= 10 , x = 46, y = 216,npcID = 20049,},},},  --自动寻路
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1441},},
					{type="deletePrivateNpc", ----------删除NPC
					param={
					npcs =
					{
						{npcID = 20905,	taskID = {1404}, index = 1},
						{npcID = 20904,	taskID = {1412}, index = 2},
	                                },
					},
					},
				},
		},
	},

	[1414] =
	{
		name = "寻找左慈",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 20944,	--任务结束npc
		preTaskData = {1413}, --前置任务ID 
		nextTaskID = 1415,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1443,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 107 , x = 169, y = 107, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20944,mapID = 107, x = 171, y = 109,dir = West,},
					},
				},
			},
			{{type="autoTrace", param = {tarMapID= 107 , x = 169, y = 107,npcID = 20938,},},},  --自动寻路
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1443},},
				},
		},
	},

	[1415] =
	{
		name = "剿灭强盗",	--任务名字
		startNpcID = 20944,	--任务起始npc
		endNpcID =nil,	--任务结束npc
		preTaskData = {1414},	--任务前置任务没有填nil
		nextTaskID = 1426,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 310,
				dialogID = 1445,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20930,	x = 82, y = 194,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20931,	x = 82, y = 198,noDelete = true},
					{npcID = 20931,	x = 81, y = 191,noDelete = true},
					{npcID = 20932,	x = 80, y = 197,noDelete = true},
					{npcID = 20932,	x = 79, y = 194,noDelete = true},
				},
					posData	= {mapID = 107,	x = 87, y = 193},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="getItem", param = {itemID = 1041010, count = 1,}},---------获得物品财宝
			{type="finishTask", param = {recetiveTaskID =1426}},
			},
		},
	},

	[1426] =
	{
		name = "见到左慈",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20944,	--任务结束npc
		preTaskData = {1415}, --前置任务ID 
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1447,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type = "TcommitItem", param = {taskID = 1426,itemsInfo = {{itemID = 1041010, count = 1},},bor = true},}
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="CreateIntemDirect",param = {taskID = 1426,itemsInfo = {{itemID = 1041010, count = 1},},},},
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1447},},
				},
		},
	},

	[1416] =
	{
		name = "寻找材料",	--任务名字
		startNpcID = 20944,	--任务起始npc
		endNpcID = 20933,	--任务结束npc
		preTaskData = {1426}, --前置任务ID 
		nextTaskID = 1417,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1450,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 185, y = 288, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="deletePrivateNpc", ----------删除NPC
					param={
						npcs =
						{
                                                {npcID = 20944,	taskID = {1414}, index = 1},
	                                        },
					      },
			},
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20933,mapID = 10, x = 183, y = 287,dir = EastSouth,},
					[2] = {npcID = 20929,mapID = 107, x = 171, y = 109,dir = West,},
					},
				},
			},
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1450},},
				},
		},
	},

	[1417] =
	{
		name = "青玄线索",	--任务名字
		startNpcID = 20933,	--任务起始npc
		endNpcID = 29006,	--任务结束npc
		preTaskData = {1416}, --前置任务ID 
		nextTaskID = 1418,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1452,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 10 , x = 145, y = 214, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1452},},
					{type="deletePrivateNpc", ----------删除NPC
					param={
						npcs =
						{
                                                {npcID = 20933,	taskID = {1416}, index = 1},
	                                        },
					      },
					},
				},
		},
	},

	[1418] =
	{
		name = "夺回材料",	--任务名字
		startNpcID = 29006,	--任务起始npc
		endNpcID =nil,	--任务结束npc
		preTaskData = {1417},	--任务前置任务没有填nil
		nextTaskID = 1419,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 311,
				dialogID = 1454,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20934,	x = 237, y = 88,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20935,	x = 236, y = 86,noDelete = true},
					{npcID = 20935,	x = 238, y = 86,noDelete = true},
					{npcID = 20936,	x = 235, y = 88,noDelete = true},
					{npcID = 20936,	x = 239, y = 88,noDelete = true},
				},
					posData	= {mapID = 106,	x = 236, y = 91},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="getItem", param = {itemID = 1041011, count = 1,}},--获得物品青玄之气
			{type="openDialog", param={dialogID = 1456},},
			{type="finishTask", param = {recetiveTaskID =1419}},
			},
		},
	},

	[1419] =
	{
		name = "材料集齐",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID =nil,	--任务结束npc
		preTaskData = {1418},	--任务前置任务没有填nil
		nextTaskID = 1420,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 312,
				dialogID = 1457,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20937,	x = 237, y = 75,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20938,	x = 238, y = 78,noDelete = true},
					{npcID = 20938,	x = 234, y = 74,noDelete = true},
					{npcID = 20939,	x = 238, y = 71,noDelete = true},
					{npcID = 20939,	x = 241, y = 73,noDelete = true},
				},
					posData	= {mapID = 107,	x = 233, y = 78},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="getItem", param = {itemID = 1041012, count = 1,}},--获得物品紫阳之火
			{type="openDialog", param={dialogID = 1459},},
			{type="finishTask", param = {recetiveTaskID =1420}},
			},
		},
	},

	[1420] =
	{
		name = "炼化宝图",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1419}, --前置任务ID 
		nextTaskID = 1421,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1462,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type = "TcommitItem", param = {taskID = 1420,itemsInfo = {{itemID = 1041009, count = 1},{itemID = 1041011, count = 1},{itemID = 1041012, count = 1},} ,bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="CreateIntemDirect",param = {taskID = 1420,itemsInfo = {{itemID = 1041009, count = 1},{itemID = 1041011, count = 1},{itemID = 1041012, count = 1}}},},
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1460},},
				},
		},
	},

	[1421] =
	{
		name = "龙气线索",	--任务名字
		startNpcID = 20929,	--任务起始npc
		endNpcID = 20940,	--任务结束npc
		preTaskData = {1420},	--任务前置任务没有填nil
		nextTaskID = 1422,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1465,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 313,
				dialogID = 1463,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20940,	x = 168, y = 195,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 20941,	x = 167, y = 198,noDelete = true},
					{npcID = 20941,	x = 165, y = 196,noDelete = true},
					{npcID = 20942,	x = 169, y = 197,noDelete = true},
					{npcID = 20942,	x = 166, y = 194,noDelete = true},
				},
					posData	= {mapID = 119,	x = 170, y = 194},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20940,mapID = 119, x = 168, y = 195,dir = South,},
					},
				},
			},
			{type="openDialog", param={dialogID = 1465},},
			},
		},
	},

	[1422] =
	{
		name = "龙气化型",	--任务名字
		startNpcID = 20940,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1421},	--任务前置任务没有填nil
		nextTaskID = 1423,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,
				lastMine = true,
				scriptID= 314,
				dialogID = 1467,        -------
				npcsData =			--刷出npc数据
				{
					{npcID = 20943,	x = 94, y = 240,noDelete = true},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
				},
					posData	= {mapID = 119,	x = 95, y = 240},
					bor = true,
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]=
			{
			},
			[TaskStatus.Done]=
			{
			{type="getItem", param = {itemID = 1041013, count = 1,}},--获得物品真龙之气
			{type="deletePrivateNpc", ----------删除NPC
					param={
						npcs =
						{
                        {npcID = 20940,	taskID = {1421}, index = 1},
	                    },
				   },
			},
			{type="finishTask", param = {recetiveTaskID =1423}},
			},
		},
	},

	[1423] =
	{
		name = "左慈出山",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20929,	--任务结束npc
		preTaskData = {1422}, --前置任务ID 
		nextTaskID = 1427,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1469,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type = "TcommitItem", param = {taskID = 1423,itemsInfo = {{itemID = 1041013, count = 1},} ,bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="CreateIntemDirect",param = {taskID = 1423,itemsInfo = {{itemID = 1041013, count = 1},}},},
			},
			[TaskStatus.Done] =
				{
					{type="openDialog", param={dialogID = 1469},},
				},
		},
	},

	[1427] =
	{
		name = "皇帝苏醒",	--任务名字
		startNpcID = 20929,	--任务起始npc
		endNpcID = 20929,	--任务结束npc
		preTaskData = {1423}, --前置任务ID 
		nextTaskID = 1501,	--任务后置任务没有填nil
		startDialogID =	nil,	--
		endDialogID = 1471,	--
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,  	--人物经验
			[TaskRewardList.subMoney] = 38000,   	--玩家绑银
			[TaskRewardList.pet_xp] = 5000,  	--宠物经验
			[TaskRewardList.player_pot] = 11400,  	--人物潜能
		},
		consume =
		{
		},
		targets =
		{
		[1] = {type='Tarea',param = {mapID = 131, x = 36, y = 49, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
			{type="createPrivateNpc", ----------创建私有npc
				param={
					npcs =
					{
					[1] = {npcID = 20999,	mapID =	131, x =36, y = 52,dir = East,},
					[2] = {npcID = 20945,	mapID =	131, x =34, y = 50,dir = East,},
					},
				},
			},
			},
			[TaskStatus.Done] =
				{
				{type="deletePrivateNpc", ----------删除NPC
					param={
						npcs =
						{
						{npcID = 20929,	taskID = {1416}, index = 1},
						{npcID = 20945,	taskID = {1427}, index = 2},
						{npcID = 20999,	taskID = {1427}, index = 3},
	                                        },
					      },
				},
				{type="createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
						[1] = {npcID = 21000,	mapID =	131, x =36, y = 52,dir = South,},
						},
						},
				},
				{type="openDialog", param={dialogID = 1471},},
				},
		},
	},
----------------------主线39-40--------------------------------------
	[1501] =
	{
		name = "重兴汉室",	--任务名字
		startNpcID = 21000,	--任务起始npc 
		endNpcID = 20002,		--任务结束npc
		preTaskData = {1427},		--任务前置任务没有填nil
		nextTaskID = 1502,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1503,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tarea',param = {mapID = 8 , x = 134, y = 219, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="createPrivateTransfer",
				param={
					transfers =
						{
						{mapID = 131, x =35, y =10, tarMapID = 10, tarX =43, tarY = 200},--创建一个私有传送阵
						},
					},
			},
			{type="autoTrace", param = {tarMapID	= 8, x = 134, y = 219,npcID = 20002,},}, --寻路到祖师
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1503},}, --在任务结束时打开一个对话框
			},
		},
	},
		[1502] =
	{
		name = "传国玉玺",	--任务名字
		startNpcID = 20002,	--任务起始npc 
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1501},		--任务前置任务没有填nil
		nextTaskID = 1503,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1506,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
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
			{
			{type="autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --寻路到卢植
			},
			[TaskStatus.Done]		=
			{
			{type="deletePrivateTransfer", ------删除私有传送阵
				param={
					transfers =
						{
							{taskID = 1501, index = 1},
						},
					},
			},
			{type="openDialog", param={dialogID = 1506},}, --在任务结束时打开一个对话框
			},
		},
	},
		[1503] =
	{

		name = "冯芳下落",	--任务名字
		startNpcID = 20049,	--任务起始npc 
		endNpcID = 21032,		--任务结束npc
		preTaskData = {1502},		--任务前置任务没有填nil
		nextTaskID = 1504,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1511,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tscript',param = {scriptID	= 401 ,	count =	1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)	
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建赵融
				param={
						npcs = 
						{
							[1] = {npcID = 21001, mapID = 10,x = 185,y = 311,dir = EastSouth,}, --赵融
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
							{npcID = 21001,	taskID = {1503}, index = 1}, --删除赵融
						},
					},
				},
			 {type="createPrivateNpc", ----------创建赵融
				param={
						npcs = 
						{
							[1] = {npcID = 21032, mapID = 10,x = 185,y = 311,dir = EastSouth,}, --赵融
					},
				},
			},
			{type="openDialog", param={dialogID = 1510},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1504] =
	{

		name = "失去线索",	--任务名字
		startNpcID = 21032,	--任务起始npc 
		endNpcID = 21002,		--任务结束npc
		preTaskData = {1503},		--任务前置任务没有填nil
		nextTaskID = 1505,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1515,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tmine',param =     --冯芳
			{
				mineIndex = 1,		--第一个雷
				scriptID = 402,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1512,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 21002, x = 86, y = 191, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21020, x = 84, y = 190, noDelete = true,},
					{npcID = 21020, x = 86, y = 193, noDelete = true,},
				},
				posData = {mapID = 104, x = 86, y = 191}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
			
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="autoTrace", param = {tarMapID	= 104, x = 86, y = 191,npcID = 21002,},}, --寻路到冯芳
			},
			[TaskStatus.Done]		=
			{
			 {type="createPrivateNpc", ----------创建冯芳
				param={
						npcs = 
						{
							[1] = {npcID = 21002, mapID = 104,x = 86,y = 191,dir = WestSouth,}, --赵融
					},
				},
			},
			{type="openDialog", param={dialogID = 1514},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", 
				param={
						npcs = 
						{
							{npcID = 21032,	taskID = {1503}, index = 1}, --删除赵融
						},
					},
				},
			},
		},
	},
	[1505] =
	{

		name = "无获而归",	--任务名字
		startNpcID = 21002,	--任务起始npc 
		endNpcID = 20049,		--任务结束npc
		preTaskData = {1504},		--任务前置任务没有填nil
		nextTaskID = 1506,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1516,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
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
			{
			{type="autoTrace", param = {tarMapID	= 10, x = 46, y = 216,npcID = 20049,},}, --寻路到卢植
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1516},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", 
				param={
						npcs = 
						{
							{npcID = 21002,	taskID = {1504}, index = 1}, --删除冯芳
						},
					},
				},
			},
		},
	},
	[1506] =
	{

		name = "言多必失",	--任务名字
		startNpcID = 20049,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc
		preTaskData = {1505},		--任务前置任务没有填nil
		nextTaskID = 1507,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1518,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 13 , x = 96, y = 71, bor = true},},-------到达指定坐标
			
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1518},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1507] =
	{

		name = "恶战魔星",	--任务名字
		startNpcID = 29030,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1506},		--任务前置任务没有填nil
		nextTaskID = 1508,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tmine',param =     --后卿
			{
				mineIndex = 1,		--第一个雷
				scriptID = 403,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1521,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{
					{npcID = 21004, x = 197, y = 48, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21021, x = 194, y = 48, noDelete = true,},
					{npcID = 21021, x = 194, y = 51, noDelete = true,},
				},
				posData = {mapID = 110, x = 197, y = 48}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
			
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="finishTask", param = {recetiveTaskID = 1508}},
			},
		},
	},
	[1508] =
	{

		name = "复原之法",	--任务名字
		startNpcID =29030,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc
		preTaskData = {1507},		--任务前置任务没有填nil
		nextTaskID = 1509,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1523,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tarea',param = {mapID = 13 , x = 96, y = 71, bor = true},},-------到达指定坐标
			
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1523},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1509] =
	{

		name = "收集龙鳞",	--任务名字
		startNpcID = 29030,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1508},		--任务前置任务没有填nil
		nextTaskID = 1510,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		[1] = {type='Tmine',param =     --天山巨龙
			{
				mineIndex = 1,		--第一个雷
				scriptID = 404,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1526,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 115, x = 48, y = 137}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建天山巨龙
				param={
						npcs = 
						{
							[1] = {npcID = 21005, mapID = 115,x = 48,y = 137,dir = South,}, --天山巨龙
					},
				},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="getItem", param = {itemID = 1041008, count = 1,}},			--获得指定数量的物品(参数物品ID，数量)
			{type="openDialog", param={dialogID = 1528},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1510}},
			},
		},
	},
	[1510] =
	{

		name = "收集玄铁",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1509},		--任务前置任务没有填nil
		nextTaskID = 1511,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		  [1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10001,--采集的实体ID
					scriptID= 405,
					dialogID = 1529,
					npcsData =			--刷出npc数据
					{
						{npcID = 21006, x = 52, y = 234,},
						{npcID = 21022, x = 51, y = 231,},
						{npcID = 21022, x = 55, y = 234,},
						{npcID = 21023, x = 55, y = 227,},
						{npcID = 21023, x = 59, y = 231,},
					},
						
				}
			},
		  [2] = {type = "TgetItem", param = {itemID = 1041005, count = 1 ,bor = false},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1531},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", 
				param={
						npcs = 
						{
							{npcID = 21005,	taskID = {1509}, index = 1}, --删除天山巨龙
						},
					},
				},
			{type="finishTask", param = {recetiveTaskID = 1511}},
			},
		},
	},
	[1511] =
	{

		name = "神器复原",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc
		preTaskData = {1510},		--任务前置任务没有填nil
		nextTaskID = 1512,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1534,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	          [1] = {type = "TcommitItem", param = {taskID = 1511,itemsInfo = {{itemID = 1041005, count = 1},{itemID = 1041008, count = 1},} ,bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="CreateIntemDirect",param = {taskID = 1511,itemsInfo = {{itemID = 1041005, count = 1},{itemID = 1041008, count = 1},},},},
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1534},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1512] =
	{

		name = "李傕下落",	--任务名字
		startNpcID = 29030,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1511},		--任务前置任务没有填nil
		nextTaskID = 1513,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	         [1] = {type='Tarea',param = {mapID = 109 , x = 87, y = 289, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建李傕尸体
				param={
						npcs = 
						{
							[1] = {npcID = 21009, mapID = 109,x = 87,y = 289,dir = WestSouth,}, --李傕
					},
				},
			},
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1536},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1513}},
			},
		},
	},
	[1513] =
	{

		name = "回魂妙术",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc
		preTaskData = {1512},		--任务前置任务没有填nil
		nextTaskID = 1514,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1537,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 39000,    --绑银
			[TaskRewardList.player_pot] = 11700,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	       [1] = {type='Tarea',param = {mapID = 13 , x = 96, y = 71, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1537},}, --在任务结束时打开一个对话框
			{type="deletePrivateNpc", 
				param={
						npcs = 
						{
							{npcID = 21009,	taskID = {1512}, index = 1}, --删除李傕尸体
						},
					},
				},
			},
		},
	},
	[1514] =
	{

		name = "收集水晶",	--任务名字
		startNpcID = 29030,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1513},		--任务前置任务没有填nil
		nextTaskID = 1515,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	     [1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10002,--采集的实体ID
					scriptID= 406,
					dialogID = 1540,
					npcsData =			--刷出npc数据
					{
						{npcID = 21007, x = 173, y = 188,},
						{npcID = 21024, x = 172, y = 186,},
						{npcID = 21024, x = 173, y = 191,},
						{npcID = 21025, x = 169, y = 187,},
						{npcID = 21025, x = 170, y = 194,},
					},
						
				}
			},
		  [2] = {type = "TgetItem", param = {itemID = 1041006, count = 1 ,bor = false},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1542},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1515}},
			},
		},
	},
	[1515] =
	{

		name = "收集药草",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = nil,		--任务结束npc
		preTaskData = {1514},		--任务前置任务没有填nil
		nextTaskID = 1516,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
          [1] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 10003,--采集的实体ID
					scriptID= 407,
					dialogID = 1543,
					npcsData =			--刷出npc数据
					{
						{npcID = 21008, x = 53, y = 143,},
						{npcID = 21026, x = 49, y = 144,},
						{npcID = 21026, x = 54, y = 146,},
					},
						
				}
			},
		  [2] = {type = "TgetItem", param = {itemID = 1041007, count = 1 ,bor = false},}--任务目标获取物品
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1545},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1516}},
			},
		},
	},
	[1516] =
	{

		name = "召唤亡灵",	--任务名字
		startNpcID = nil,	--任务起始npc 
		endNpcID = 29030,		--任务结束npc
		preTaskData = {1515},		--任务前置任务没有填nil
		nextTaskID = 1517,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1576,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	         [1] = {type = "TcommitItem", param = {taskID = 1516,itemsInfo = {{itemID = 1041006, count = 1},{itemID = 1041007, count = 1},} ,bor = true},},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			{type="CreateIntemDirect",param = {taskID = 1516,itemsInfo = {{itemID = 1041006, count = 1},{itemID = 1041007, count = 1},},},},
			},
			[TaskStatus.Done]		=
			{
			{type="openDialog", param={dialogID = 1576},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1517}},
			},
		},
	},
	[1517] =
	{

		name = "玉玺下落",	--任务名字
		startNpcID = 29030,	--任务起始npc 
		endNpcID = 21033,		--任务结束npc
		preTaskData = {1516},		--任务前置任务没有填nil
		nextTaskID = 1518,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1550,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tscript',param = {scriptID = 408 ,count =1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建李傕亡魂
				param={
						npcs = 
						{
							[1] = {npcID = 21010, mapID = 13,x = 48,y = 99,dir = EastSouth,}, --李傕亡魂
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
							{npcID = 21010,	taskID = {1517}, index = 1}, --删除李傕亡魂
						},
					},
				},
			{type="createPrivateNpc", ----------创建李傕亡魂
				param={
						npcs = 
						{
							[1] = {npcID = 21033, mapID = 13,x = 48,y = 99,dir = EastSouth,}, --李傕亡魂
					},
				},
			},
			{type="openDialog", param={dialogID = 1550},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1518] =
	{

		name = "千里解围",	--任务名字
		startNpcID = 21033,	--任务起始npc 
		endNpcID = 21034,		--任务结束npc
		preTaskData = {1517},		--任务前置任务没有填nil
		nextTaskID = 1519,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1553,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tmine',param =     --黄祖
			{
				mineIndex = 1,		--第一个雷
				scriptID = 409,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1551,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 120, x = 221, y = 53}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建李傕亡魂
				param={
						npcs = 
						{
							[1] = {npcID = 21011, mapID = 120,x = 221,y = 53,dir = WestSouth,}, --黄祖
							[2] = {npcID = 21027, mapID = 120,x = 219,y = 56,dir = WestSouth,}, 
							[3] = {npcID = 21040, mapID = 120,x = 223,y = 54,dir = WestSouth,}, 
							[4] = {npcID = 21028, mapID = 120,x = 220,y = 60,dir = WestSouth,}, 
							[5] = {npcID = 21041, mapID = 120,x = 223,y = 58,dir = WestNorth,}, 
							[6] = {npcID = 21034, mapID = 120,x = 221,y = 57,dir = WestSouth,}, --孙坚
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
							{npcID = 21011,	taskID = {1518}, index = 1}, 
							{npcID = 21027,	taskID = {1518}, index = 1}, 
							{npcID = 21040,	taskID = {1518}, index = 1}, 
							{npcID = 21028,	taskID = {1518}, index = 1}, 
							{npcID = 21041,	taskID = {1518}, index = 1}, 
							{npcID = 21033,	taskID = {1517}, index = 1}, 
						},
					},
				},
			{type="openDialog", param={dialogID = 1553},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1519] =
	{

		name = "解救韩当",	--任务名字
		startNpcID = 21034,	--任务起始npc 
		endNpcID = 21013,		--任务结束npc
		preTaskData = {1518},		--任务前置任务没有填nil
		nextTaskID = 1520,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1556,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tmine',param =     --张硕
			{
				mineIndex = 1,		--第一个雷
				scriptID = 410,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1554,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 120, x = 229, y = 101}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建李傕亡魂
				param={
						npcs = 
						{
							[1] = {npcID = 21012, mapID = 120,x = 229,y = 101,dir = WestSouth,}, --黄祖
							[2] = {npcID = 21027, mapID = 120,x = 228,y = 105,dir = EastSouth,}, 
							[3] = {npcID = 21040, mapID = 120,x = 234,y = 103,dir = WestNorth,}, 
							[4] = {npcID = 21028, mapID = 120,x = 231,y = 102,dir = WestSouth,}, 
							[5] = {npcID = 21041, mapID = 120,x = 231,y = 106,dir = WestSouth,}, 
							[6] = {npcID = 21013, mapID = 120,x = 231,y = 104,dir = WestSouth,}, --韩当
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
							{npcID = 21012,	taskID = {1519}, index = 1}, 
							{npcID = 21027,	taskID = {1519}, index = 1}, 
							{npcID = 21040,	taskID = {1519}, index = 1}, 
							{npcID = 21028,	taskID = {1519}, index = 1}, 
							{npcID = 21041,	taskID = {1519}, index = 1}, 
							{npcID = 21034,	taskID = {1518}, index = 1}, 
						},
					},
				},
			{type="openDialog", param={dialogID = 1556},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1520] =
	{

		name = "解救祖茂",	--任务名字
		startNpcID = 21013,	--任务起始npc 
		endNpcID = 21035,		--任务结束npc
		preTaskData = {1519},		--任务前置任务没有填nil
		nextTaskID = 1521,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1560,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tmine',param =     --陈就
			{
				mineIndex = 1,		--第一个雷
				scriptID = 411,
				lastMine = true,	--是否为最后一个雷
				dialogID = 1557,    --动作结束打开的对话框
				npcsData =			--刷出npc数据
				{},
				posData = {mapID = 120, x = 114, y = 220}, --踩雷坐标
				bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", ----------创建李傕亡魂
				param={
						npcs = 
						{
							[1] = {npcID = 21014, mapID = 120,x = 114,y = 220,dir = South,}, --陈就
							[2] = {npcID = 21027, mapID = 120,x = 110,y = 222,dir = EastNorth,}, 
							[3] = {npcID = 21040, mapID = 120,x = 113,y = 223,dir = WestNorth,}, 
							[4] = {npcID = 21028, mapID = 120,x = 108,y = 224,dir = EastSouth,}, 
							[5] = {npcID = 21041, mapID = 120,x = 110,y = 226,dir = WestSouth,}, 
							[6] = {npcID = 21015, mapID = 120,x = 111,y = 223,dir = South,}, --祖茂
							[7] = {npcID = 21035, mapID = 120,x = 221,y = 57,dir = South,}, --孙坚	
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
							{npcID = 21014,	taskID = {1520}, index = 1}, 
							{npcID = 21027,	taskID = {1520}, index = 1}, 
							{npcID = 21040,	taskID = {1520}, index = 1}, 
							{npcID = 21028,	taskID = {1520}, index = 1}, 
							{npcID = 21041,	taskID = {1520}, index = 1}, 
							{npcID = 21013,	taskID = {1519}, index = 1}, 
						},
					},
				},
			{type="openDialog", param={dialogID = 1559},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1521] =
	{

		name = "坐收渔利",	--任务名字
		startNpcID = 21035,	--任务起始npc 
		endNpcID = 21036,		--任务结束npc
		preTaskData = {1520},		--任务前置任务没有填nil
		nextTaskID = 1522,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1565,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tscript',param = {scriptID = 412 ,count =1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21016, mapID = 14,x = 105,y = 44,dir = WestSouth,}, --苏飞
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
							{npcID = 21016,	taskID = {1521}, index = 1}, 
							{npcID = 21015,	taskID = {1520}, index = 1}, 
							{npcID = 21035,	taskID = {1520}, index = 1}, 
						},
					},
				},
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21036, mapID = 14,x = 105,y = 44,dir = WestSouth,}, --苏飞
					},
				},
			},
			{type="openDialog", param={dialogID = 1564},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1522] =
	{

		name = "大败甘宁",	--任务名字
		startNpcID = 21036,	--任务起始npc 
		endNpcID = 21037,		--任务结束npc
		preTaskData = {1521},		--任务前置任务没有填nil
		nextTaskID = 1523,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1568,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tscript',param = {scriptID = 413 ,count =1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21017, mapID = 14,x = 102,y = 77,dir = WestSouth,}, --甘宁
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
							{npcID = 21036,	taskID = {1521}, index = 1}, 
							{npcID = 21017,	taskID = {1522}, index = 1},  
						},
					},
				},
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21037, mapID = 14,x = 102,y = 77,dir = WestSouth,}, --甘宁
					},
				},
			},
			{type="openDialog", param={dialogID = 1568},}, --在任务结束时打开一个对话框
			},
		},
	},
	[1523] =
	{

		name = "击败蔡中",	--任务名字
		startNpcID = 21037,	--任务起始npc 
		endNpcID = 21038,		--任务结束npc
		preTaskData = {1522},		--任务前置任务没有填nil
		nextTaskID = 1524,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1572,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tscript',param = {scriptID = 414 ,count =1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21018, mapID = 14,x = 124,y =110,dir = WestSouth,}, --蔡中
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
							{npcID = 21037,	taskID = {1522}, index = 1}, 
							{npcID = 21018,	taskID = {1523}, index = 1},  
						},
					},
				},
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21038, mapID = 14,x = 124,y = 110,dir = WestSouth,}, --蔡中
					},
				},
			},
			{type="openDialog", param={dialogID = 1571},}, --在任务结束时打开一个对话框
			},
		},
	},
[1524] =
	{

		name = "质问蔡瑁",	--任务名字
		startNpcID = 21038,	--任务起始npc 
		endNpcID = 21039,		--任务结束npc
		preTaskData = {1523},		--任务前置任务没有填nil
		nextTaskID = 1524,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID =1575,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 8000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 40000,    --绑银
			[TaskRewardList.player_pot] = 12000,  	--人物潜能
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
	      [1] = {type='Tscript',param = {scriptID = 415 ,count =1, ignoreResult = true,bor = true},}, --打一个脚本战斗(脚本战斗ID 100 次数)
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active]		=
			{
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21019, mapID = 14,x = 77,y =134,dir = WestSouth,}, --蔡瑁
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
							{npcID = 21038,	taskID = {1523}, index = 1}, 
							{npcID = 21019,	taskID = {1524}, index = 1},  
						},
					},
				},
			 {type="createPrivateNpc", 
				param={
						npcs = 
						{
							[1] = {npcID = 21039, mapID = 14,x = 77,y = 134,dir = WestSouth,}, --蔡瑁
					},
				},
			},
			{type="openDialog", param={dialogID = 1575},}, --在任务结束时打开一个对话框
			},
		},
	},




 




----------------------------------------------------------------------------------------------------------------
	
}

table.copy(MainTaskDB36_40, NormalTaskDB)