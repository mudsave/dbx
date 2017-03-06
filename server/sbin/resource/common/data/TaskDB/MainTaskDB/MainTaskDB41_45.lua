--[[MainTaskDB41_45.lua
	任务配置41到45级(任务系统)
]]

MainTaskDB41_45 = 
{
----------------------主线41-42--------------------------------------	
	[1601] =	            --[[寻找袁术--]]
	{
		
		name = "寻找袁术",	--任务名字
		startNpcID = 21039,	--任务起始npc
		endNpcID = 21106,	--任务结束npc
		preTaskData = {1524},	--任务前置任务没有填nil
		nextTaskID = 1602,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1608,	--交任务对话ID没有填nil
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
			[1] = {type='Tmine',param =     --陈留守将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 451,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1602,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21103, x = 126, y = 40, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21101, x = 123, y = 40, noDelete = true},
					{npcID = 21101, x = 126, y = 43, noDelete = true},
					{npcID = 21102, x = 120, y = 41, noDelete = true},
					{npcID = 21102, x = 124, y = 46, noDelete = true},
				},
				posData = {mapID = 409, x = 126, y = 40}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
	                [2] = {type='Tmine',param =     --陈留副将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 452,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1604,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21104, x = 111, y = 86, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21101, x = 116, y = 83, noDelete = true},
					{npcID = 21101, x = 109, y = 90, noDelete = true},
					{npcID = 21102, x = 112, y = 90, noDelete = true},
					{npcID = 21102, x = 116, y = 86, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 409, x = 111, y = 86}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
                        [3] = {type='Tmine',param =     --李丰
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 453,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1606,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 409, x = 155, y = 117}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
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
								[1] = {mapID = 120, x = 168, y = 82, tarMapID = 409, tarX = 140, tarY = 26},--创建私有传送阵江夏—陈留
							},
					      },
			},
			{type="createPrivateNpc", ----------创建李丰
					param={
						npcs =
						{
								[1] = {npcID = 21105,mapID = 409, x = 155, y = 117,dir = Direction.WestSouth,},
						},
					      },
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除蔡瑁
				param={
						npcs =
						{
							{npcID = 21039, taskID = {1528}, index = 1}, --删除蔡瑁
						},
				       },
			},
			{type="deletePrivateNpc", ----------删除李丰
				param={
						npcs =
						{
							{npcID = 21105, taskID = {1601}, index = 1}, --删除李丰
						},
				       },
			},
			{type="createPrivateNpc", ----------创建接任务对话李丰
					param={
						npcs =
						{
								[1] = {npcID = 21106,mapID = 409, x = 155, y = 117,dir = Direction.WestSouth,},
						},
					     },
			},
			{type="openDialog", param={dialogID = 1608},}, --在任务目标完成时打开一个对话框
			}, 
	        },
	},
        [1602] =	            
	{
		
		name = "大战袁术",	--任务名字
		startNpcID = 21106,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1601},	--任务前置任务没有填nil
		nextTaskID = 1603,	--任务后置任务没有填nil
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
			[1] = {type='Tmine',param =     --袁营校尉
			{
				mineIndex = 1,		--第一个雷
				scriptID = 454,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1610,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21109, x = 219, y = 154, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21107, x = 215, y = 151, noDelete = true},
					{npcID = 21107, x = 223, y = 151, noDelete = true},
					{npcID = 21108, x = 215, y = 156, noDelete = true},
					{npcID = 21108, x = 223, y = 156, noDelete = true},
				},
				posData = {mapID = 409, x = 219, y = 154}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			     },
	                [2] = {type='Tmine',param =     --陈留副将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 455,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1612,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21110, x = 131, y = 169, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21107, x = 129, y = 172, noDelete = true},
					{npcID = 21107, x = 129, y = 166, noDelete = true},
					{npcID = 21108, x = 125, y = 166, noDelete = true},
					{npcID = 21108, x = 125, y = 172, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 409, x = 131, y = 169}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			     },
                        [3] = {type='Tmine',param =     --袁术
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 456,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1614,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 409, x = 41, y = 141}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			      },
	       },		
		triggers = --任务触发器
		{
		    [TaskStatus.Active] =
				{
                        {type="createPrivateNpc", ----------创建袁术
					param={
						npcs =
						{
								[1] = {npcID = 21111,mapID = 409, x = 41, y = 141,dir = Direction.WestSouth,}, --袁术
						},
				},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除袁术
				param={
						npcs =
						{
						     {npcID = 21106, taskID = {1601}, index = 1}, --删除接任务对话李丰
							 {npcID = 21111, taskID = {1602}, index = 1}, --删除袁术
						},
					},
			},
			{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1601, index = 1},--删除私有传送阵江夏—陈留
							},
						},
			},
                        {type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 409, x = 101, y = 199, tarMapID = 120, tarX = 168, tarY = 82},--创建私有传送阵陈留-江夏
							},
					      },
			},
			{type="openDialog", param={dialogID = 1616},}, --在任务结束时打开一个对话框
			{type="finishTask", param = {recetiveTaskID = 1603}},
			},
	        },
	},
        [1603] =
	{
		name = "回禀天尊",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20002,	--任务结束npc
		preTaskData = {1602}, --前置任务ID 
		nextTaskID = 1604,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1617,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 8, x = 134, y = 219, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] =
				{
				},
				[TaskStatus.Done] =
				{
				{type="openDialog", param={dialogID = 1617},},--在任务目标完成时打开一个对话框
			    {type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1602, index = 1},--删除私有传送阵陈留-江夏
							},
					    },
				     },
				},
	     },
	},
        [1604] =
	{
		name = "前往洛阳",	--任务名字
		startNpcID = 20002,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1603}, --前置任务ID 
		nextTaskID = 1605,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1619,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 10, x = 46, y = 216, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] = 
				{
				},
				[TaskStatus.Done] =
					{
						{type="openDialog", param={dialogID = 1619},},	--在任务目标完成时打开一个对话框		
			                },
	                },
	},
        [1605] =	            
	{
		
		name = "勇闯虎牢关",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1604},	--任务前置任务没有填nil
		nextTaskID = 1606,	--任务后置任务没有填nil
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
			[1] = {type='Tmine',param =     --虎牢关守将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 457,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1621,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21114, x = 150, y = 219, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21112, x = 148, y = 216, noDelete = true},
					{npcID = 21112, x = 148, y = 222, noDelete = true},
					{npcID = 21113, x = 148, y = 214, noDelete = true},
					{npcID = 21113, x = 148, y = 224, noDelete = true},
				},
				posData = {mapID = 109, x = 150, y = 219}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
	                [2] = {type='Tmine',param =     --虎牢关副将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 458,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1623,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21115, x = 104, y = 175, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21112, x = 104, y = 172, noDelete = true},
					{npcID = 21112, x = 104, y = 178, noDelete = true},
					{npcID = 21113, x = 100, y = 173, noDelete = true},
					{npcID = 21113, x = 100, y = 177, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 109, x = 104, y = 175}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
                        [3] = {type='Tmine',param =     --杨弘
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 459,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1625,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 109, x = 149, y = 124}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
		    [TaskStatus.Active] =
				{
			{type="createPrivateNpc", ----------创建杨弘
					param={
						npcs =
						{
								[1] = {npcID = 21116,mapID = 109, x = 149, y = 124,dir = Direction.WestNorth,}, --杨弘					
						},
					},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除杨弘
				param={
						npcs =
						{
							{npcID = 21116, taskID = {1605}, index = 1}, --删除杨弘
						},
					},
			},
			{type="openDialog", param={dialogID = 1627},},	--在任务目标完成时打开一个对话框		
			{type="finishTask", param = {recetiveTaskID = 1606}},--触发完成任务接受下一个任务
			},
	},
	},        
        [1606] =	            
	{
		
		name = "诛杀张勋",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1605},	--任务前置任务没有填nil
		nextTaskID = 1607,	--任务后置任务没有填nil
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
			[1] = {type='Tmine',param =     --张营副官
			{
				mineIndex = 1,		--第一个雷
				scriptID = 460,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1628,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21119, x = 194, y = 108, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21117, x = 191, y = 112, noDelete = true},
					{npcID = 21117, x = 199, y = 104, noDelete = true},
					{npcID = 21118, x = 195, y = 111, noDelete = true},
					{npcID = 21118, x = 198, y = 108, noDelete = true},
				},
				posData = {mapID = 109, x = 194, y = 108}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
	                [2] = {type='Tmine',param =     --张营大将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 461,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1630,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21120, x = 249, y = 96, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21117, x = 246, y = 95, noDelete = true},
					{npcID = 21117, x = 252, y = 95, noDelete = true},
					{npcID = 21118, x = 244, y = 93, noDelete = true},
					{npcID = 21118, x = 254, y = 93, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 109, x = 249, y = 96}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
                        [3] = {type='Tmine',param =     --张勋
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 462,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1632,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 109, x = 256, y = 61}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
		    [TaskStatus.Active] =
				{
			{type="createPrivateNpc", ----------创建张勋
					param={
						npcs =
						{
								[1] = {npcID = 21121,mapID = 109, x = 256, y = 61,dir = Direction.EastNorth,}, --张勋                                                            
						},
					},
			},
			        },
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除张勋
				param={
						npcs =
						{
							{npcID = 21121, taskID = {1606}, index = 1}, --删除张勋						       
						},
					},
			},
			{type="finishTask", param = {recetiveTaskID = 1620}},--触发完成任务接受下一个任务
			},
	         },
	},   
	[1620] =
	{
		name = "前往洛阳",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1606}, --前置任务ID 
		nextTaskID = 1607,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1634,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 10, x = 46, y = 216, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] = 
				{
				},
				[TaskStatus.Done] =
					{
			 			{type="openDialog", param={dialogID = 1634},},						
					},
			},
	},
        [1607] =
	{
		name = "救援曹操",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 21133,	--任务结束npc
		preTaskData = {1620}, --前置任务ID 
		nextTaskID = 1608,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1636,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 410, x = 55, y = 177, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] = 
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 109, x = 129, y = 243, tarMapID = 410, tarX = 65, tarY = 186},--创建私有传送阵虎牢关-汝南
							},
					      },
			        },
                                   {type="createPrivateNpc", ----------创建曹操
					param={
						npcs =
						{
								[1] = {npcID = 21133,mapID = 410, x = 55, y = 173,dir = Direction.EastNorth,}, --曹操                                                          
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
								{taskID = 1607, index = 1},--删除私有传送阵虎牢关-汝南
							},
						},
			         },
				{type="openDialog", param={dialogID = 1636},},						
	                      },
	                },
	},
        [1608] =
	{
		name = "协助曹仁",	--任务名字
		startNpcID = 21133,	--任务起始npc
		endNpcID = 21122,	--任务结束npc
		preTaskData = {1607}, --前置任务ID 
		nextTaskID = 1609,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1638,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 410, x = 41, y = 151, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] = 
				{
                  {type="createPrivateNpc", ----------创建曹仁
					param={
						npcs =
						{
								[1] = {npcID = 21122,mapID = 410, x = 41, y = 151,dir = Direction.EastSouth,}, --曹仁                                                        
						},
					},
			           },
				},
				[TaskStatus.Done] =
				{					
				  {type="deletePrivateNpc",----------删除曹操
				      param={
						npcs =
						{
						{npcID = 21133, taskID = {1607}, index = 1}, --删除曹操
						},
					  },
				},
			{type="openDialog", param={dialogID = 1638},},	
			},
	   },
	},
        [1609] =	            
	{	
		name = "诛杀龚都",	--任务名字
		startNpcID = 21122,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1608},	--任务前置任务没有填nil
		nextTaskID = 1610,	--任务后置任务没有填nil
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
			[1] = {type='Tmine',param =     --汝南守将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 463,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1640,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21125, x = 107, y = 195, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21123, x = 103, y = 196, noDelete = true},
					{npcID = 21123, x = 110, y = 196, noDelete = true},
					{npcID = 21124, x = 104, y = 198, noDelete = true},
					{npcID = 21124, x = 109, y = 198, noDelete = true},
				},
				posData = {mapID = 410, x = 107, y = 195}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
	                [2] = {type='Tmine',param =     --汝南副将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 464,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1642,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21126, x = 217, y = 141, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21123, x = 216, y = 144, noDelete = true},
					{npcID = 21123, x = 220, y = 140, noDelete = true},
					{npcID = 21124, x = 214, y = 142, noDelete = true},
					{npcID = 21124, x = 218, y = 138, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 410, x = 217, y = 141}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
                        [3] = {type='Tmine',param =     --龚都
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 465,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1644,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 410, x = 103, y = 87}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
					{type="deletePrivateNpc",----------删除曹操、曹仁
					param={
							npcs =
							{
								{npcID = 21133, taskID = {1607}, index = 1}, --删除曹操
								{npcID = 21122, taskID = {1608}, index = 2}, --删除曹仁
							},
						},
					},
					{type="createFollow", param = {npcs = {21122},},},--创建曹仁跟随
					{type="createPrivateNpc", ----------创建龚都
						param={
								npcs =
								{
									[1] = {npcID = 21127,mapID = 410, x = 103, y = 87,dir = Direction.East,}, --龚都
								},
							},
					},
				},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除龚都
				param={
						npcs =
						{
							{npcID = 21127, taskID = {1609}, index = 1}, --删除龚都
						},
				      },
			},
			{type="openDialog", param={dialogID = 1646},},	
			{type="finishTask", param = {recetiveTaskID = 1610}},--完成任务目标自动交接
			},
	        },
	},        
        [1610] =	            
	{
		
		name = "大战刘辟",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21122,	--任务结束npc
		preTaskData = {1609},	--任务前置任务没有填nil
		nextTaskID = 1611,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1653,	--交任务对话ID没有填nil
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
			[1] = {type='Tmine',param =     --汝南都尉
			{
				mineIndex = 1,		--第一个雷
				scriptID = 466,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1647,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21130, x = 104, y = 54, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21128, x = 102, y = 53, noDelete = true},
					{npcID = 21128, x = 107, y = 53, noDelete = true},
					{npcID = 21129, x = 101, y = 51, noDelete = true},
					{npcID = 21129, x = 108, y = 51, noDelete = true},
				},
				posData = {mapID = 410, x = 104, y = 54}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
	                [2] = {type='Tmine',param =     --汝南大将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 467,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1649,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21131, x = 170, y = 109, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21128, x = 167, y = 110, noDelete = true},
					{npcID = 21128, x = 171, y = 106, noDelete = true},
					{npcID = 21129, x = 169, y = 112, noDelete = true},
					{npcID = 21129, x = 173, y = 108, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 410, x = 170, y = 109}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
                        [3] = {type='Tmine',param =     --刘辟
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 468,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1651,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 410, x = 206, y = 105}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
		    [TaskStatus.Active] =
	            {  
			{type="createPrivateNpc", ----------创建刘辟
					param={
						npcs =
						{
								[1] = {npcID = 21132,mapID = 410, x = 206, y = 105,dir = Direction.EastNorth,}, --刘辟                                                           
						},
					},
			},
		     },
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除刘辟
				param={
						npcs =
						{
							{npcID = 21132, taskID = {1610}, index = 1}, --删除刘辟					       
						},
				      },
			},
		        {type="deleteFollow", param = {npcs = {21122},},},--删除曹仁跟随
			{type="createPrivateNpc", ----------创建曹仁
					param={
						npcs =
						{
								[1] = {npcID = 21122,mapID = 410, x = 206, y = 102,dir = Direction.EastNorth,}, --曹仁                                                          
						},
					      },
			},		  
			{type="openDialog", param={dialogID = 1653},}, --在任务结束时打开一个对话框
			},
	       },
	},        
        [1611] =
	{
		name = "回禀卢植",	--任务名字
		startNpcID = 21122,	--任务起始npc
		endNpcID = 20049,	--任务结束npc
		preTaskData = {1610}, --前置任务ID 
		nextTaskID = 1612,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1654,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 10, x = 46, y = 216, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 410, x = 158, y = 20, tarMapID = 109, tarX = 129, tarY = 243},--创建私有传送阵汝南-虎牢关
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
								{taskID = 1611, index = 1},--删除私有传送阵汝南-虎牢关
							},
					       },
			                        },
						{type="deletePrivateNpc", ----------删除曹仁
		                     param={
						npcs =
						{
							{npcID = 21122, taskID = {1610}, index = 1}, --删除曹仁				       
						},
				           },
			                        },
						{type="openDialog", param={dialogID = 1654},},	--在任务目标完成时打开一个对话框		
			                },
	                },
	},
        [1612] =	            
	{
		
		name = "宛城增援",	--任务名字
		startNpcID = 20049,	--任务起始npc
		endNpcID = 21133,	--任务结束npc
		preTaskData = {1611},	--任务前置任务没有填nil
		nextTaskID = 1613,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1662,	--交任务对话ID没有填nil
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
			[1] = {type='Tmine',param =     --宛城副将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 469,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1656,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21136, x = 151, y = 64, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21134, x = 153, y = 65, noDelete = true},
					{npcID = 21134, x = 148, y = 65, noDelete = true},
					{npcID = 21135, x = 155, y = 67, noDelete = true},
					{npcID = 21135, x = 145, y = 68, noDelete = true},
				},
				posData = {mapID = 122, x = 151, y = 64}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
	                [2] = {type='Tmine',param =     --宛城守将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 470,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1658,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21137, x = 93, y = 107, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21134, x = 90, y = 104, noDelete = true},
					{npcID = 21134, x = 96, y = 110, noDelete = true},
					{npcID = 21135, x = 89, y = 108, noDelete = true},
					{npcID = 21135, x = 93, y = 111, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 122, x = 93, y = 107}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
                        [3] = {type='Tmine',param =     --韩暹
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 471,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1660,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 122, x = 82, y = 146}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
					{type="createPrivateNpc", ----------创建韩暹
						param={
								npcs =
								{
									[1] = {npcID = 21138,mapID = 122, x = 82, y = 146,dir = Direction.South,}, --韩暹
								},
							},
					},
				},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除韩暹
				param={
						npcs =
						{
							{npcID = 21138, taskID = {1612}, index = 1}, --删除韩暹
						},
					},
			},
		        {type="createPrivateNpc", ----------创建曹操
					param={
						npcs =
						{
								[1] = {npcID = 21133,mapID = 122, x = 78, y = 169,dir = Direction.WestSouth,}, --曹操                                                         
						},
					      },
		        },
				{type = "autoTrace", param = {tarMapID	= 122, x = 78, y = 169,npcID = 21133,},}, --寻路到曹操
			},
	        },
	},        
       [1613] =	            
	{
		
		name = "营救典韦",	--任务名字
		startNpcID = 21133,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1612},	--任务前置任务没有填nil
		nextTaskID = 1614,	--任务后置任务没有填nil
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
			[1] = {type='Tmine',param =     --宛城都尉
			{
				mineIndex = 1,		--第一个雷
				scriptID = 472,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1664,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21139, x = 138, y = 155, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21134, x = 139, y = 152, noDelete = true},
					{npcID = 21134, x = 139, y = 158, noDelete = true},
					{npcID = 21135, x = 141, y = 153, noDelete = true},
					{npcID = 21135, x = 141, y = 157, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 122, x = 134, y = 155}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
	                [2] = {type='Tmine',param =     --宛城校尉
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 473,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1666,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21140, x = 135, y = 178, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21134, x = 132, y = 177, noDelete = true},
					{npcID = 21134, x = 138, y = 177, noDelete = true},
					{npcID = 21135, x = 132, y = 180, noDelete = true},
					{npcID = 21135, x = 138, y = 180, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 122, x = 133, y = 174}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			       },
                        [3] = {type='Tmine',param =     --韩猛
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 474,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1668,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 122, x = 128, y = 222}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			      },
	        },		
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
					{type="createPrivateNpc", ----------创建韩猛
						param={
								npcs =
								{
									[1] = {npcID = 21141,mapID = 122, x = 128, y = 222,dir = Direction.WestSouth,}, --韩猛
								},
							},
					},
				},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="deletePrivateNpc", ----------删除韩猛
				param={
						npcs =
						{
							{npcID = 21141, taskID = {1613}, index = 1}, --删除韩猛
						},
					},
			},
			{type="finishTask", param = {recetiveTaskID = 1614}},--完成任务目标自动交接
			},
	        },
	},        
        [1614] =
	{
		name = "寻找典韦",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1613}, --前置任务ID 
		nextTaskID = 1615,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 122, x = 121, y = 258, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] =
				{
				{type="createPrivateNpc", ----------创建典韦尸体
					param={
						npcs =
						{
								[1] = {npcID = 21164,mapID = 122, x = 118, y = 262,dir = Direction.EastSouth,}, --典韦尸体                                                         
						},
					      },
		        },
				},
				[TaskStatus.Done] =
					{
						{type="openDialog", param={dialogID = 1670},},	--在任务目标完成时打开一个对话框
						{type="finishTask", param = {recetiveTaskID = 1615}},--完成任务目标自动交接		
			                },
	                },
	},
        [1615] =	            
	{
		
		name = "解宛城之困",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21133,	--任务结束npc
		preTaskData = {1614},	--任务前置任务没有填nil
		nextTaskID = 1616,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1677,	--交任务对话ID没有填nil
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
			[1] = {type='Tmine',param =     --胡营副将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 475,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1671,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21144, x = 194, y = 172, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21142, x = 194, y = 170, noDelete = true},
					{npcID = 21142, x = 196, y = 172, noDelete = true},
					{npcID = 21143, x = 193, y = 168, noDelete = true},
					{npcID = 21143, x = 198, y = 173, noDelete = true},
				},
				posData = {mapID = 122, x = 194, y = 172}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
	                [2] = {type='Tmine',param =     --胡营大将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 476,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1673,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21145, x = 241, y = 143, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21142, x = 241, y = 140, noDelete = true},
					{npcID = 21142, x = 244, y = 143, noDelete = true},
					{npcID = 21143, x = 243, y = 136, noDelete = true},
					{npcID = 21143, x = 248, y = 141, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 122, x = 241, y = 143}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
                        [3] = {type='Tmine',param =     --胡车儿
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 477,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1675,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 122, x = 224, y = 89}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
		    [TaskStatus.Active] =
				{
			{type="createPrivateNpc", ----------创建胡车儿
					param={
						npcs =
						{
								[1] = {npcID = 21146,mapID = 122, x = 224, y = 89,dir = Direction.EastNorth,}, --胡车儿                                                           
						},
					},
			},
			},
			[TaskStatus.Done]		=      ---完成目标状态 
			{
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 122, x = 53, y = 181, tarMapID = 411, tarX = 109, tarY = 236},--创建私有传送阵宛城-宛城城池
							},
					      },
			 },   
			{type="deletePrivateNpc", ----------删除胡车儿
				param={
						npcs =
						{
						    {npcID = 21164, taskID = {1614}, index = 1}, --删除典韦		
							{npcID = 21146, taskID = {1615}, index = 1}, --删除胡车儿				       
						},
				      },
			},	  
			{type="autoTrace", param = {tarMapID=122, x =78, y = 166,npcID = 21133,},}, --自动寻路到曹操身边
			},
	       },
	},        
       [1616] =	            
	{
		
		name = "降服贾诩",	--任务名字
		startNpcID = 21133,	--任务起始npc
		endNpcID = 21152,	--任务结束npc
		preTaskData = {1615},	--任务前置任务没有填nil
		nextTaskID = 1617,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1685,	--交任务对话ID没有填nil
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
			[1] = {type='Tmine',param =     --池城守将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 478,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1679,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21149, x = 117, y = 212, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21147, x = 114, y = 211, noDelete = true},
					{npcID = 21147, x = 120, y = 211, noDelete = true},
					{npcID = 21148, x = 115, y = 209, noDelete = true},
					{npcID = 21148, x = 119, y = 209, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 411, x = 117, y = 212}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
	                [2] = {type='Tmine',param =     --池城副将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 479,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1681,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21150, x = 102, y = 148, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21147, x = 100, y = 151, noDelete = true},
					{npcID = 21147, x = 100, y = 144, noDelete = true},
					{npcID = 21148, x = 98, y = 150, noDelete = true},
					{npcID = 21148, x = 98, y = 147, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 411, x = 102, y = 148}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			       },
                        [3] = {type='Tmine',param =     --贾诩
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 480,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1683,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 411, x = 146, y = 121}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			      },
	        },		
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
					{type="createPrivateNpc", ----------创建贾诩
						param={
								npcs =
								{
									[1] = {npcID = 21151,mapID = 411, x = 146, y = 121,dir = Direction.WestNorth,}, --贾诩
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
								{taskID = 1615, index = 1},--删除私有传送阵宛城-宛城城池
							},
					       },
		        },
			{type="deletePrivateNpc", ----------删除贾诩
				param={
						npcs =
						{
							{npcID = 21151, taskID = {1616}, index = 1}, --删除贾诩
						},
					},
			},
			{type="createPrivateNpc", ----------创建对话贾诩
					param={
						npcs =
						{
								[1] = {npcID = 21152,mapID = 411, x = 146, y = 121,dir = Direction.WestNorth,}, --对话贾诩                                                         
						},
					      },
		        },
			{type="openDialog", param={dialogID = 1685},}, --在任务结束时打开一个对话框
			},
	        },
	},        
        [1617] =	            
	{
		
		name = "打败张绣",	--任务名字
		startNpcID = 21152,	--任务起始npc
		endNpcID = 21158,	--任务结束npc
		preTaskData = {1616},	--任务前置任务没有填nil
		nextTaskID = 1618,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1693,	--交任务对话ID没有填nil
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
			[1] = {type='Tmine',param =     --张营守将
			{
				mineIndex = 1,		--第一个雷
				scriptID = 481,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1687,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21155, x = 188, y = 191, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21153, x = 185, y = 194, noDelete = true},
					{npcID = 21153, x = 191, y = 194, noDelete = true},
					{npcID = 21154, x = 185, y = 188, noDelete = true},
					{npcID = 21154, x = 191, y = 188, noDelete = true},
				},
				posData = {mapID = 411, x = 188, y = 191}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
	                [2] = {type='Tmine',param =     --张营副将
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 482,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1689,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21156, x = 189, y = 142, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21153, x = 188, y = 144, noDelete = true},
					{npcID = 21153, x = 191, y = 144, noDelete = true},
					{npcID = 21154, x = 185, y = 146, noDelete = true},
					{npcID = 21154, x = 193, y = 146, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 411, x = 189, y = 142}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
                        [3] = {type='Tmine',param =     --张绣
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 483,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1691,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 411, x = 203, y = 159}, --踩雷坐标
			        bor = true,	--如果为true则完成此目标任务直接完成
			}, 
			},
			},		
		triggers = --任务触发器
		{
		    [TaskStatus.Active] =
				{
			{type="createPrivateNpc", ----------创建张绣
					param={
						npcs =
						{
								[1] = {npcID = 21157,mapID = 411, x = 203, y = 159,dir = Direction.WestSouth,}, -- 张绣                                                         
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
							{npcID = 21152, taskID = {1616}, index = 1}, --删除对话贾诩
						},
				       },
			  },
			{type="deletePrivateNpc", ----------删除张绣
				param={
						npcs =
						{
							{npcID = 21157, taskID = {1617}, index = 1}, --删除张绣				       
						},
				      },
			},	  
		        {type="createPrivateNpc", ----------创建对话张绣
					param={
						npcs =
						{
								[1] = {npcID = 21158,mapID = 411, x = 203, y = 159,dir = Direction.WestNorth,}, --对话张绣                                                        
						},
					      },
		        },
			{type="openDialog", param={dialogID = 1693},}, --在任务结束时打开一个对话框
			},
	       },
	},        
       [1618] =	            
	{
		
		name = "诛杀罗宣",	--任务名字
		startNpcID = 21158,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {1617},	--任务前置任务没有填nil
		nextTaskID = 1619,	--任务后置任务没有填nil
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
			[1] = {type='Tmine',param =     --火龙窟妖兽
			{
				mineIndex = 1,		--第一个雷
				scriptID = 484,
				lastMine = false,	--是否为最后一个雷
				dialogID = 1695,        --动作结束打开的对话框
				npcsData =	        --刷出npc数据
				{
					{npcID = 21161, x = 76, y = 140, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21159, x = 74, y = 142, noDelete = true},
					{npcID = 21159, x = 78, y = 142, noDelete = true},
					{npcID = 21160, x = 80, y = 144, noDelete = true},
					{npcID = 21160, x = 72, y = 144, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 412, x = 76, y = 140}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			      },
	                [2] = {type='Tmine',param =     --火龙窟魔人
	  		{
			        mineIndex = 2,		--第二个雷
			        scriptID = 485,         --脚本战斗
			        lastMine = false,	--是否为最后一个雷
			        dialogID = 1697,        --动作结束打开的对话框
			        npcsData =              --刷出npc数据
			        {
					{npcID = 21162, x = 176, y = 182, noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21159, x = 173, y = 179, noDelete = true},
					{npcID = 21159, x = 179, y = 179, noDelete = true},
					{npcID = 21160, x = 173, y = 185, noDelete = true},
					{npcID = 21160, x = 179, y = 185, noDelete = true},
				},                     --刷出npc数据
			        posData = {mapID = 412, x = 176, y = 182}, --踩雷坐标
			        bor = false,	--如果为true则完成此目标任务直接完成
			},
			       },
                        [3] = {type='Tmine',param =     --罗宣
			{
			        mineIndex = 3,	        --第一个雷
			        scriptID = 486,         --脚本战斗
			        lastMine = true,	--是否为最后一个雷
			        dialogID = 1699,        --动作结束打开的对话框
			        npcsData =	        --刷出npc数据
			        {
			        },
			        posData = {mapID = 412, x = 114, y = 229}, --踩雷坐标
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
								[1] = {mapID = 411, x = 202, y = 171, tarMapID = 412, tarX = 25, tarY = 160},--创建私有传送阵宛城城池-火焰窟
							},
					      },
			 },   
					{type="createPrivateNpc", ----------创建罗宣
						param={
								npcs =
								{
									[1] = {npcID = 21163,mapID = 412, x = 114, y = 233,dir = Direction.WestSouth,}, --罗宣
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
								{taskID = 1618, index = 1},--删除私有传送阵宛城城池-火焰窟
							},
					},
		     },
			{type="deletePrivateNpc", ----------删除罗宣
				param={
						npcs =
						{
							{npcID = 21163, taskID = {1618}, index = 1}, --删除罗宣
						},
					},
			},
		        {type="deletePrivateNpc",
				param={
						npcs =
						{
							{npcID = 21158, taskID = {1617}, index = 1}, --删除对话张绣
						},
				       },
			},
			{type="finishTask", param = {recetiveTaskID = 1619}},--完成任务目标自动交接
			},
	        },
	},        
        [1619] =
	{
		name = "再见曹操",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = 21133,	--任务结束npc
		preTaskData = {1618}, --前置任务ID 
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = 1584,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 122, x = 78, y = 169, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{
				[TaskStatus.Active] = 
				{
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 412, x = 102, y = 248, tarMapID = 122, tarX = 53, tarY = 181},--创建私有传送阵火焰窟-宛城
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
								{taskID = 1618, index = 1},--删除私有传送阵火焰窟-宛城
							},
					},
		      },
		     {type="openDialog", param={dialogID = 1584},}, --在任务结束时打开一个对话框			
			 },
	    },
	},
---------------------------------主线任务42-43级任务--------------------------------------
[1701] =
	{
		name = "寻找曹仁",	--任务名字
		startNpcID = 21233,	--任务起始npc曹操
		endNpcID = nil,	--任务结束npc
		preTaskData = {1619}, --前置任务ID 李清的最后一个任务ID
		nextTaskID = 1702,	--任务后置任务没有填nil
		startDialogID =	1701,	--接任务对话ID没有填nil
		endDialogID = 1702,	--交任务对话ID没有填nil
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
		[1] = {type='Tarea',param = {mapID = 124, x = 172, y = 59, bor = true},},-------到达指定坐标
		},
			triggers = --任务触发器
			{

				[TaskStatus.Active] = 
				{
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21202, mapID = 124, x = 172, y = 59, dir = Direction. WestSouth,}, --曹仁
						},
					},
			},
				},
				[TaskStatus.Done] =
					{
					{type="openDialog", param={dialogID = 1702},},
			},
	},
	},

[1702] =
         {              

		name = "樊城危机",	--任务名字
		startNpcID = 21202,	--任务起始npc
		endNpcID = 21210,		--任务结束npc
		preTaskData = {1701},	--任务前置任务没有填nil
		nextTaskID = 1702,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1710,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --偷袭将领
			{
			mineIndex = 1,		--第一个雷
			scriptID = 501,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1704,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21203, x = 107, y = 63,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21204, x = 104, y = 64,  noDelete = true},
					{npcID = 21205, x = 106, y = 66,  noDelete = true},
					{npcID = 21206, x = 102, y = 64,  noDelete = true},
					{npcID = 21207, x = 106, y = 68,  noDelete = true},
			},
			posData = {mapID = 413, x = 107, y = 63}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --偷袭头目
			{
			mineIndex = 2,		--第二个雷
			scriptID = 502,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1706,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21208, x = 154, y = 122,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21204, x = 153, y = 121,  noDelete = true},
					{npcID = 21205, x = 153, y = 124,  noDelete = true},
					{npcID = 21206, x = 152, y = 120,  noDelete = true},
					{npcID = 21207, x = 152, y = 124,  noDelete = true},
			},
			posData = {mapID = 413, x = 155, y = 122}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --陈就
			{
			mineIndex = 3,		--第三个雷
			scriptID = 503,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1708,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21209, x = 180, y = 157,  noDelete = true},
			                {npcID = 21204, x = 178, y = 155,  noDelete = true},
					{npcID = 21205, x = 178, y = 159,  noDelete = true},
					{npcID = 21206, x = 177, y = 153,  noDelete = true},
					{npcID = 21207, x = 177, y = 161,  noDelete = true},
			},
			posData = {mapID = 413, x = 180, y = 157}, --踩雷坐标
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
								[1] = {mapID = 124, x = 131, y = 94, tarMapID = 413, tarX = 141, tarY = 19},--创建私有传送阵
							},
						},
			},
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21210, mapID = 413, x = 176, y = 157, dir = Direction.EastSouth,}, --程普

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
						[1] ={npcID = 21202, taskID = {1701}, index = 1}, --删除曹仁
						},
					  },
		        },
		        {type="openDialog", param={dialogID = 1710},},
			},
		},
	},
[1703] =
         {              

		name = "拯救孙坚",	--任务名字
		startNpcID = 21210,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1702},	--任务前置任务没有填nil
		nextTaskID = 1704,	--任务后置任务没有填nil
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
		[1] = {type='Tmine',param =     --樊城暗哨
			{
			mineIndex = 1,		--第一个雷
			scriptID = 504,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1711,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21211, x = 133, y = 167,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21212, x = 132, y = 170,  noDelete = true},
					{npcID = 21213, x = 132, y = 164,  noDelete = true},
					{npcID = 21214, x = 130, y = 166,  noDelete = true},
					{npcID = 21215, x = 130, y = 169,  noDelete = true},
			},
			posData = {mapID = 413, x = 134, y = 167}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --樊城守卫
			{
			mineIndex = 2,		--第二个雷
			scriptID = 505,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1713,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21216, x = 44, y = 125,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21212, x = 47, y = 126,  noDelete = true},
					{npcID = 21213, x = 41, y = 126,  noDelete = true},
					{npcID = 21214, x = 42, y = 128,  noDelete = true},
					{npcID = 21215, x = 45, y = 128,  noDelete = true},
			},
			posData = {mapID = 413, x = 44, y = 124}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --黄射
			{
			mineIndex = 3,		--第三个雷
			scriptID = 506,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1715,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			 {
			                {npcID = 21217, x = 120, y = 216,  noDelete = true},
			                {npcID = 21212, x = 122, y = 218,  noDelete = true},
					{npcID = 21213, x = 118, y = 218,  noDelete = true},
					{npcID = 21214, x = 116, y = 220,  noDelete = true},
					{npcID = 21215, x = 123, y = 220,  noDelete = true},
			},
			posData = {mapID = 413, x = 120, y = 216}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务c直接完成
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
						[1] ={npcID = 21210, taskID = {1702}, index = 1}, --删除程普
						},
					  },
		        },
				{type="createFollow", param = {npcs = {21210},},},--创建程普跟随
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1702, index = 1},--删除私有传送阵
							},
						},
				},
                                  },
			[TaskStatus.Done] =
			{
			{type="deleteFollow", param = {npcs = {21210},},},--删除程普跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
				npcs ={
				   [1] = {npcID = 21210, mapID = 413, x = 120, y = 216, dir = Direction. EastSouth,}, --程普
					},
				},
		     },
			
		        {type="openDialog", param={dialogID = 1717},},
			},
		},
	},
[1704] =
         {              

		name = "孙策去向",	--任务名字
		startNpcID = 21216,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1703},	--任务前置任务没有填nil
		nextTaskID = 1705,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1725,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --寿春统领
			{
			mineIndex = 1,		--第一个雷
			scriptID = 507,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1719,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21218, x = 133, y = 77,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21219, x = 130, y = 77,  noDelete = true},
					{npcID = 21220, x = 132, y = 80,  noDelete = true},
					{npcID = 21221, x = 127, y = 77,  noDelete = true},
					{npcID = 21222, x = 131, y = 83,  noDelete = true},
			},
			posData = {mapID = 124, x = 133, y = 77}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --寿春监军
			{
			mineIndex = 2,		--第二个雷
			scriptID = 508,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1721,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21223, x = 55, y = 164,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21219, x = 54, y = 167,  noDelete = true},
					{npcID = 21220, x = 52, y = 165,  noDelete = true},
					{npcID = 21221, x = 54, y = 169,  noDelete = true},
					{npcID = 21222, x = 50, y = 165,  noDelete = true},
			},
			posData = {mapID = 124, x = 55, y = 164}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --阎象
			{
			mineIndex = 3,		--第三个雷
			scriptID = 509,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1723,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21224, x = 146, y = 129,  noDelete = true},
					{npcID = 21219, x = 149, y = 124,  noDelete = true},
					{npcID = 21220, x = 149, y = 129,  noDelete = true},
					{npcID = 21221, x = 151, y = 128,  noDelete = true},
					{npcID = 21222, x = 151, y = 125,  noDelete = true},
			},
			posData = {mapID = 124, x = 146, y = 129}, --踩雷坐标
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
								[1] = {mapID = 413, x = 122, y = 245, tarMapID = 124, tarX = 197, tarY = 45},--创建私有传送阵
							},
						},
			},
                                  },
			[TaskStatus.Done]		=
			{
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21279, mapID = 124, x = 148, y = 126, dir = Direction. WestNouth,}, --阎象
						},
					},
			},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21210, taskID = {1703}, index = 1}, --删除程普
						},
					        },
				                },
		        {type="openDialog", param={dialogID = 1725},},
			},
		},
	},
[1705] =
         {              

		name = "解救孙策",	--任务名字
		startNpcID = 21279,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1704},	--任务前置任务没有填nil
		nextTaskID = 1706,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1733,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --寿春督查
			{
			mineIndex = 1,		--第一个雷
			scriptID = 510,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1727,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21225, x = 101, y = 213,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21219, x = 101, y = 216,  noDelete = true},
					{npcID = 21220, x = 98, y = 213,  noDelete = true},
					{npcID = 21221, x = 101, y = 218,  noDelete = true},
					{npcID = 21222, x = 96, y = 213,  noDelete = true},
			},
			posData = {mapID = 124, x = 101, y = 213}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --寿春巡史
			{
			mineIndex = 2,		--第二个雷
			scriptID = 511,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1729,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21226, x = 167, y = 202,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21219, x = 165, y = 200,  noDelete = true},
					{npcID = 21220, x = 170, y = 200,  noDelete = true},
					{npcID = 21221, x = 164, y = 198,  noDelete = true},
					{npcID = 21222, x = 172, y = 198,  noDelete = true},
			},
			posData = {mapID = 124, x = 167, y = 202}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --袁胤
			{
			mineIndex = 3,		--第三个雷
			scriptID = 512,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1731,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 124, x = 216, y = 103}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1704, index = 1},--删除私有传送阵
							},
						},
				},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21227, mapID = 124, x = 216, y = 103, dir = Direction. EastNorth,}, --袁胤
							[2] = {npcID = 21219, mapID = 124, x = 213, y = 102, dir = Direction. EastNorth,}, --
							[3] = {npcID = 21220, mapID = 124, x = 219, y = 102, dir = Direction. EastNorth,}, --
							[4] = {npcID = 21221, mapID = 124, x = 213, y = 99, dir = Direction. EastNorth,}, --
							[5] = {npcID = 21222, mapID = 124, x = 220, y = 99, dir = Direction. EastNorth,}, --
							[6] = {npcID = 21228, mapID = 124, x = 216, y = 100, dir = Direction. EastNorth,}, --孙策
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
						[1] ={npcID = 21227, taskID = {1705}, index = 1}, --删除袁胤
						[2] ={npcID = 21219, taskID = {1705}, index = 2}, --
						[3] ={npcID = 21220, taskID = {1705}, index = 3}, --
						[4] ={npcID = 21221, taskID = {1705}, index = 4}, --
						[5] ={npcID = 21222, taskID = {1705}, index = 5}, --
						[6] ={npcID = 21279, taskID = {1704}, index = 1}, --删除阎象
						[7] ={npcID = 21228, taskID = {1705}, index = 6}, --删除孙策
						},
					        },
				                },
			{type="createFollow", param = {npcs = {21228},},},--创建孙策跟随
		        {type="openDialog", param={dialogID = 1733},},
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 124, x = 239, y = 77, tarMapID = 414, tarX = 157, tarY = 21},--创建私有传送阵
							},
						},
			},
			},
		},
	},
[1706] =
         {              

		name = "援助周瑜",	--任务名字
		startNpcID = 21228,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1705},	--任务前置任务没有填nil
		nextTaskID = 1707,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID =1741,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --门下督军
			{
			mineIndex = 1,		--第一个雷
			scriptID = 513,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1735,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21229, x = 207, y = 108,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21230, x = 208, y = 110,  noDelete = true},
					{npcID = 21231, x = 205, y = 110,  noDelete = true},
					{npcID = 21232, x = 209, y = 111,  noDelete = true},
					{npcID = 21233, x = 204, y = 111,  noDelete = true},
			},
			posData = {mapID = 414, x = 207, y = 107}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --前锋校
			{
			mineIndex = 2,		--第二个雷
			scriptID = 514,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1737,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21234, x = 101, y = 80,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21230, x = 99, y = 82,  noDelete = true},
					{npcID = 21231, x = 103, y = 82,  noDelete = true},
					{npcID = 21232, x = 99, y = 84,  noDelete = true},
					{npcID = 21233, x = 103, y = 84,  noDelete = true},
			},
			posData = {mapID = 414, x = 101, y = 79}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --桥蕤
			{
			mineIndex = 3,		--第三个雷
			scriptID = 515,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1739,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 414, x = 221, y = 148}, --踩雷坐标
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
							[1] = {npcID = 21235, mapID = 414, x = 221, y = 148, dir = Direction. WestSouth,}, --桥蕤
							[2] = {npcID = 21230, mapID = 414, x = 223, y = 150, dir = Direction. WestSouth,}, --
							[3] = {npcID = 21231, mapID = 414, x = 219, y = 150, dir = Direction. WestSouth,}, --
							[4] = {npcID = 21232, mapID = 414, x = 224, y = 152, dir = Direction. WestSouth,}, --
							[5] = {npcID = 21233, mapID = 414, x = 218, y = 152, dir = Direction. WestSouth,}, --
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
						[1] ={npcID = 21235, taskID = {1706}, index = 1}, --删除桥蕤
						[2] ={npcID = 21230, taskID = {1706}, index = 2}, --
						[3] ={npcID = 21231, taskID = {1706}, index = 3}, --
						[4] ={npcID = 21232, taskID = {1706}, index = 4}, --
						[5] ={npcID = 21233, taskID = {1706}, index = 5}, --
						},
				        },
                         },
			 {type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21280, mapID = 414, x = 221, y = 148, dir = Direction. WestSouth,}, --桥蕤
						},
					},
			},
		        {type="openDialog", param={dialogID = 1741},},			},
		},
	},
[1707] =
         {              

		name = "解救周瑜",	--任务名字
		startNpcID = 21280,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1706},	--任务前置任务没有填nil
		nextTaskID = 1708,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1749,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --九江门将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 516,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1743,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21236, x = 110, y = 201,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21230, x = 108, y = 201,  noDelete = true},
					{npcID = 21231, x = 110, y = 199,  noDelete = true},
					{npcID = 21232, x = 106, y = 201,  noDelete = true},
					{npcID = 21233, x = 110, y = 197,  noDelete = true},
			},
			posData = {mapID = 414, x = 110, y = 201}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --九江守卫
			{
			mineIndex = 2,		--第二个雷
			scriptID = 517,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1745,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21237, x = 51, y = 122,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21230, x = 50, y = 119,  noDelete = true},
					{npcID = 21231, x = 50, y = 125,  noDelete = true},
					{npcID = 21232, x = 47, y = 121,  noDelete = true},
					{npcID = 21233, x = 47, y = 124,  noDelete = true},
			},
			posData = {mapID = 414, x = 52, y = 122}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --舒邵
			{
			mineIndex = 3,		--第三个雷
			scriptID = 518,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1747,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 414, x = 55, y = 176}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1705, index = 1},--删除私有传送阵
							},
						},
				},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21238, mapID = 414, x = 55, y = 176, dir = Direction. WestSouth,}, --舒邵
							[2] = {npcID = 21230, mapID = 414, x = 53, y = 178, dir = Direction. WestSouth,}, --
							[3] = {npcID = 21231, mapID = 414, x = 57, y = 178, dir = Direction. WestSouth,}, --
							[4] = {npcID = 21232, mapID = 414, x = 53, y = 181, dir = Direction. WestSouth,}, --
							[5] = {npcID = 21233, mapID = 414, x = 57, y = 181, dir = Direction. WestSouth,}, --
							[6] = {npcID = 21239, mapID = 414, x = 55, y = 179, dir = Direction. WestSouth,}, --周瑜
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
						[1] ={npcID = 21238, taskID = {1707}, index = 1}, --删除舒邵
						[2] ={npcID = 21230, taskID = {1707}, index = 2}, --
						[3] ={npcID = 21231, taskID = {1707}, index = 3}, --
						[4] ={npcID = 21232, taskID = {1707}, index = 4}, --
						[5] ={npcID = 21233, taskID = {1707}, index = 5}, --
						[6] ={npcID = 21239, taskID = {1707}, index = 6}, --删除周瑜
						[7] ={npcID = 21280, taskID = {1706}, index = 1}, --删除桥蕤
						},
				        },
                         },
			{type="createFollow", param = {npcs = {21239},},},--创建周瑜跟随
		        {type="openDialog", param={dialogID = 1749},},
			},
		},
	},
[1708] =
         {              

		name = "黄祖下落",	--任务名字
		startNpcID = 21239,	--任务起始npc
		endNpcID = nil,		--任务结束npc
		preTaskData = {1707},	--任务前置任务没有填nil
		nextTaskID = 1709,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1757,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --江夏主将
			{
			mineIndex = 1,		--第一个雷
			scriptID = 519,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1751,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21240, x = 54, y = 144,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21241, x = 54, y = 146,  noDelete = true},
					{npcID = 21242, x = 52, y = 144,  noDelete = true},
					{npcID = 21243, x = 50, y = 144,  noDelete = true},
					{npcID = 21244, x = 54, y = 148,  noDelete = true},
			},
			posData = {mapID = 120, x = 54, y = 144}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --江夏守将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 520,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1753,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21245, x = 63, y = 203,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21241, x = 65, y = 205,  noDelete = true},
					{npcID = 21242, x = 61, y = 205,  noDelete = true},
					{npcID = 21243, x = 65, y = 207,  noDelete = true},
					{npcID = 21244, x = 61, y = 207,  noDelete = true},
			},
			posData = {mapID = 120, x = 63, y = 202}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --张硕
			{
			mineIndex = 3,		--第三个雷
			scriptID = 521,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1755,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 120, x = 112, y = 226}, --踩雷坐标
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
								[1] = {mapID = 414, x = 40, y = 149, tarMapID = 120, tarX = 95, tarY = 115},--创建私有传送阵
							},
						},
			},
				
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21246, mapID = 120, x = 112, y = 226, dir = Direction. WestSouth,}, --张硕
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
						[1] ={npcID = 21246, taskID = {1708}, index = 1}, --删除张硕
						},
				        },
                         },
			 {type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21281, mapID = 120, x = 112, y = 226, dir = Direction. WestSouth,}, --张硕
						},
					},
			},
		        {type="openDialog", param={dialogID = 1757},},
			},
		},
	},
[1709] =
         {              

		name = "击杀黄祖",	--任务名字
		startNpcID = 21281,	--任务起始npc
		endNpcID = 21239,		--任务结束npc
		preTaskData = {1708},	--任务前置任务没有填nil
		nextTaskID = 1710,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1765,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --营地首领
			{
			mineIndex = 1,		--第一个雷
			scriptID = 522,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1759,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21247, x = 122, y = 163,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21248, x = 120, y = 161,  noDelete = true},
					{npcID = 21249, x = 124, y = 161,  noDelete = true},
					{npcID = 21250, x = 118, y = 160,  noDelete = true},
					{npcID = 21251, x = 126, y = 160,  noDelete = true},
			},
			posData = {mapID = 120, x = 122, y = 163}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --营地统领
			{
			mineIndex = 2,		--第二个雷
			scriptID = 523,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1761,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21252, x = 230, y = 106,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21248, x = 228, y = 105,  noDelete = true},
					{npcID = 21249, x = 232, y = 105,  noDelete = true},
					{npcID = 21250, x = 228, y = 103,  noDelete = true},
					{npcID = 21251, x = 232, y = 103,  noDelete = true},
			},
			posData = {mapID = 120, x = 230, y = 107}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --黄祖
			{
			mineIndex = 3,		--第三个雷
			scriptID = 524,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1763,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 120, x = 178, y = 56}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1708, index = 1},--删除私有传送阵
							},
						},
				},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21253, mapID = 120, x = 178, y = 56, dir = Direction. EastSouth,}, --黄祖
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
						[1] ={npcID = 21253, taskID = {1709}, index = 1}, --删除黄祖
						[2] ={npcID = 21281, taskID = {1708}, index = 1}, --删除张硕
						},
				        },
                         },
			{type="deleteFollow", param = {npcs = {21239},},},--删除周瑜跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21239, mapID = 120, x = 178, y = 56, dir = Direction. WestSouth,}, --周瑜
						},
					},
			},
		        {type="openDialog", param={dialogID = 1765},},
			},
		},
	},
[1710] =
         {              

		name = "击杀荀正",	--任务名字
		startNpcID = 21239,	--任务起始npc
		endNpcID = 21239,	--任务结束npc
		preTaskData = {1709},	--任务前置任务没有填nil
		nextTaskID = 1711,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1772,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --袁营卫士
			{
			mineIndex = 1,		--第一个雷
			scriptID = 525,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1766,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21254, x = 245, y = 115,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21256, x = 243, y = 113,  noDelete = true},
					{npcID = 21257, x = 247, y = 113,  noDelete = true},
					{npcID = 21258, x = 242, y = 111,  noDelete = true},
					{npcID = 21259, x = 249, y = 111,  noDelete = true},
			},
			posData = {mapID = 415, x = 245, y = 115}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --袁营武将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 526,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1768,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21255, x = 153, y = 98,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21256, x = 154, y = 100,  noDelete = true},
					{npcID = 21257, x = 151, y = 100,  noDelete = true},
					{npcID = 21258, x = 149, y = 102,  noDelete = true},
					{npcID = 21259, x = 155, y = 102,  noDelete = true},
			},
			posData = {mapID = 415, x = 153, y = 97}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --荀正
			{
			mineIndex = 3,		--第三个雷
			scriptID = 527,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1770,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 415, x = 178, y = 170}, --踩雷坐标
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
						[1] ={npcID = 21239, taskID = {1709}, index = 1}, --删除周瑜
						},
				        },
                         },
			        {type="createFollow", param = {npcs = {21239},},},--创建周瑜跟随
				{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 120, x = 124, y = 73, tarMapID = 415, tarX = 246, tarY = 154},--创建私有传送阵
							},
						},
			},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21260, mapID = 415, x = 178, y = 170, dir = Direction. WestSouth,}, --荀正
							[2] = {npcID = 21256, mapID = 415, x = 176, y = 172, dir = Direction. WestSouth,}, --
							[3] = {npcID = 21257, mapID = 415, x = 180, y = 172, dir = Direction. WestSouth,}, --
							[4] = {npcID = 21258, mapID = 415, x = 180, y = 174, dir = Direction. WestSouth,}, --
							[5] = {npcID = 21259, mapID = 415, x = 176, y = 174, dir = Direction. WestSouth,}, --
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
						[1] ={npcID = 21260, taskID = {1710}, index = 1}, --删除荀正
						[2] ={npcID = 21256, taskID = {1710}, index = 2}, --
						[3] ={npcID = 21257, taskID = {1710}, index = 3}, --
						[4] ={npcID = 21258, taskID = {1710}, index = 4}, --
						[5] ={npcID = 21259, taskID = {1710}, index = 5}, --
						},
				        },
                         },
			 {type="deleteFollow", param = {npcs = {21239},},},--删除周瑜跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21239, mapID = 415, x = 178, y = 170, dir = Direction. WestSouth,}, --周瑜
						},
					},
			},
		        {type="openDialog", param={dialogID = 1772},},
			},
		},
	},
[1711] =
         {              

		name = "击杀纪灵",	--任务名字
		startNpcID = 21239,	--任务起始npc
		endNpcID = nil,	        --任务结束npc
		preTaskData = {1710},	--任务前置任务没有填nil
		nextTaskID = 1712,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1779,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --巡逻城卫队长
			{
			mineIndex = 1,		--第一个雷
			scriptID = 528,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1773,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21261, x = 143, y = 206,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21256, x = 142, y = 205,  noDelete = true},
					{npcID = 21257, x = 142, y = 208,  noDelete = true},
					{npcID = 21258, x = 141, y = 204,  noDelete = true},
					{npcID = 21259, x = 141, y = 210,  noDelete = true},
			},
			posData = {mapID = 415, x = 144, y = 206}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --千夫长
			{
			mineIndex = 2,		--第二个雷
			scriptID = 529,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1775,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21262, x = 88, y = 190,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21256, x = 86, y = 191,  noDelete = true},
					{npcID = 21257, x = 89, y = 191,  noDelete = true},
					{npcID = 21258, x = 90, y = 192,  noDelete = true},
					{npcID = 21259, x = 85, y = 192,  noDelete = true},
			},
			posData = {mapID = 415, x = 88, y = 189}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --纪灵
			{
			mineIndex = 3,		--第三个雷
			scriptID = 530,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1777,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 415, x = 36, y = 230}, --踩雷坐标
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
						[1] ={npcID = 21239, taskID = {1710}, index = 1}, --删除周瑜
						},
				        },
                         },
				{type="createFollow", param = {npcs = {21239},},},--创建周瑜跟随
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1710, index = 1},--删除私有传送阵
							},
						},
				},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21263, mapID = 415, x = 36, y = 230, dir = Direction. EastSouth,}, --纪灵
							[2] = {npcID = 21256, mapID = 415, x = 34, y = 229, dir = Direction. EastSouth,}, --
							[3] = {npcID = 21257, mapID = 415, x = 34, y = 233, dir = Direction. EastSouth,}, --
							[4] = {npcID = 21258, mapID = 415, x = 32, y = 228, dir = Direction. EastSouth,}, --
							[5] = {npcID = 21259, mapID = 415, x = 32, y = 235, dir = Direction. EastSouth,}, --
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
						[1] ={npcID = 21263, taskID = {1711}, index = 1}, --删除纪灵
						[2] ={npcID = 21256, taskID = {1711}, index = 2}, --
						[3] ={npcID = 21257, taskID = {1711}, index = 3}, --
						[4] ={npcID = 21258, taskID = {1711}, index = 4}, --
						[5] ={npcID = 21259, taskID = {1711}, index = 5}, --
						},
				        },
                         },
			 {type="deleteFollow", param = {npcs = {21239},},},--删除周瑜跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21239, mapID = 415, x = 36, y = 230, dir = Direction. WestSouth,}, --周瑜
						},
					},
			},
		        {type="openDialog", param={dialogID = 1779},},
			{type="createPrivateTransfer",
					param={
							transfers =
							{
								[1] = {mapID = 415, x = 16, y = 224, tarMapID = 124, tarX = 47, tarY = 192},--创建私有传送阵
							},
						},
			},
			},
		},
	},
[1712] =
         {              

		name = "寻找袁术",	--任务名字
		startNpcID = 21239,	--任务起始npc
		endNpcID = nil,	        --任务结束npc
		preTaskData = {1711},	--任务前置任务没有填nil
		nextTaskID = 1713,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1786,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --侍卫领班
			{
			mineIndex = 1,		--第一个雷
			scriptID = 531,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1780,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21264, x = 120, y = 193,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21219, x = 118, y = 193,  noDelete = true},
					{npcID = 21220, x = 120, y = 195,  noDelete = true},
					{npcID = 21221, x = 116, y = 193,  noDelete = true},
					{npcID = 21222, x = 120, y = 197,  noDelete = true},
			},
			posData = {mapID = 124, x = 121, y = 192}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --寿春守将
			{
			mineIndex = 2,		--第二个雷
			scriptID = 532,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1782,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21265, x = 167, y = 201,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21219, x = 165, y = 199,  noDelete = true},
					{npcID = 21220, x = 169, y = 199,  noDelete = true},
					{npcID = 21221, x = 171, y = 197,  noDelete = true},
					{npcID = 21222, x = 163, y = 197,  noDelete = true},
			},
			posData = {mapID = 124, x = 167, y = 201}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --刘勋
			{
			mineIndex = 3,		--第三个雷
			scriptID = 533,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1784,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 124, x = 201, y = 122}, --踩雷坐标
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
						[1] ={npcID = 21239, taskID = {1711}, index = 1}, --删除周瑜
						},
				        },
                         },
			        {type="createFollow", param = {npcs = {21239},},},--创建周瑜跟随
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21266, mapID = 124, x = 201, y = 122, dir = Direction. EastNorth,}, --刘勋
							[2] = {npcID = 21219, mapID = 124, x = 199, y = 120, dir = Direction. EastNorth,}, --
							[3] = {npcID = 21220, mapID = 124, x = 203, y = 120, dir = Direction. EastNorth,}, --
							[4] = {npcID = 21221, mapID = 124, x = 197, y = 118, dir = Direction. EastNorth,}, --
							[5] = {npcID = 21222, mapID = 124, x = 205, y = 118, dir = Direction. EastNorth,}, --
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
								{taskID = 1711, index = 1},--删除私有传送阵
							},
						},
				},
			{type="deletePrivateNpc",
				  param={
						npcs =
						{
						[1] ={npcID = 21266, taskID = {1712}, index = 1}, --删除刘勋
						[2] ={npcID = 21219, taskID = {1712}, index = 2}, --
						[3] ={npcID = 21220, taskID = {1712}, index = 3}, --
						[4] ={npcID = 21221, taskID = {1712}, index = 4}, --
						[5] ={npcID = 21222, taskID = {1712}, index = 5}, --
						},
				        },
                         },
			 {type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21282, mapID = 124, x = 201, y = 122, dir = Direction. EastNorth,}, --刘勋
						},
					},
			},
		        {type="openDialog", param={dialogID = 1786},},
			},
		},
	},
[1713] =
         {              

		name = "勇闯逆龙阵",	--任务名字
		startNpcID = 21282,	--任务起始npc
		endNpcID = nil,	        --任务结束npc
		preTaskData = {1712},	--任务前置任务没有填nil
		nextTaskID = 1714,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1794,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --守阵将军
			{
			mineIndex = 1,		--第一个雷
			scriptID = 534,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1788,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21267, x = 69, y = 151,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21269, x = 69, y = 153,  noDelete = true},
					{npcID = 21270, x = 67, y = 151,  noDelete = true},
					{npcID = 21271, x = 69, y = 155,  noDelete = true},
					{npcID = 21272, x = 65, y = 151,  noDelete = true},
			},
			posData = {mapID = 416, x = 70, y = 150}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --守阵护法
			{
			mineIndex = 2,		--第二个雷
			scriptID = 535,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1790,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21268, x = 97, y = 195,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21269, x = 99, y = 193,  noDelete = true},
					{npcID = 21270, x = 99, y = 197,  noDelete = true},
					{npcID = 21271, x = 101, y = 190,  noDelete = true},
					{npcID = 21272, x = 101, y = 199,  noDelete = true},
			},
			posData = {mapID = 416, x = 97, y = 195}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --王魔
			{
			mineIndex = 3,		--第三个雷
			scriptID = 536,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1792,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 416, x = 135, y = 159}, --踩雷坐标
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
								[1] = {mapID = 124, x = 231, y = 122, tarMapID = 416, tarX = 157, tarY = 39},--创建私有传送阵
							},
						},
			},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21273, mapID = 416, x = 135, y = 159, dir = Direction. EastNorth,}, --王魔
							[2] = {npcID = 21269, mapID = 416, x = 137, y = 157, dir = Direction. EastNorth,}, --
							[3] = {npcID = 21270, mapID = 416, x = 133, y = 157, dir = Direction. EastNorth,}, --
							[4] = {npcID = 21271, mapID = 416, x = 137, y = 155, dir = Direction. EastNorth,}, --
							[5] = {npcID = 21272, mapID = 416, x = 133, y = 155, dir = Direction. EastNorth,}, --
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
						[1] ={npcID = 21273, taskID = {1713}, index = 1}, --删除王魔
						[2] ={npcID = 21269, taskID = {1713}, index = 2}, --
						[3] ={npcID = 21270, taskID = {1713}, index = 3}, --
						[4] ={npcID = 21271, taskID = {1713}, index = 4}, --
						[5] ={npcID = 21272, taskID = {1713}, index = 5}, --
						[6] ={npcID = 21282, taskID = {1712}, index = 1}, --
						},
				        },
                         },
		        {type="openDialog", param={dialogID = 1794},},
			},
		},
	},
[1714] =
         {              

		name = "击杀袁术",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	        --任务结束npc
		preTaskData = {1713},	--任务前置任务没有填nil
		nextTaskID = 1801,	--任务后置任务没有填nil
		startDialogID = nil,	--接任务对话ID没有填nil
		endDialogID = 1801,	--交任务对话ID没有填nil
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
		[1] = {type='Tmine',param =     --亲兵统领
			{
			mineIndex = 1,		--第一个雷
			scriptID = 537,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1795,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21274, x = 174, y = 101,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21276, x = 172, y = 99,  noDelete = true},
					{npcID = 21277, x = 176, y = 99,  noDelete = true},
					{npcID = 21271, x = 178, y = 97,  noDelete = true},
					{npcID = 21272, x = 170, y = 97,  noDelete = true},
			},
			posData = {mapID = 416, x = 174, y = 101}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[2] = {type='Tmine',param =     --侍卫总管
			{
			mineIndex = 2,		--第二个雷
			scriptID = 538,         --
			lastMine = false,	--是否为最后一个雷
			dialogID = 1797,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			                {npcID = 21275, x = 187, y = 189,  noDelete = true,},--(坐标，动作ID，光效ID，)目标完成是否删除npc，
					{npcID = 21276, x = 185, y = 189,  noDelete = true},
					{npcID = 21277, x = 187, y = 191,  noDelete = true},
					{npcID = 21271, x = 183, y = 189,  noDelete = true},
					{npcID = 21272, x = 187, y = 193,  noDelete = true},
			},
			posData = {mapID = 416, x = 188, y = 188}, --踩雷坐标
			bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
		[3] = {type='Tmine',param =     --袁术
			{
			mineIndex = 3,		--第三个雷
			scriptID = 539,         --
			lastMine = true,	--是否为最后一个雷
			dialogID = 1799,        --动作结束打开的对话框
			npcsData =			--刷出npc数据
			{
			},
			posData = {mapID = 416, x = 89, y = 250}, --踩雷坐标
			bor = true,	--如果为true则完成此目标任务直接完成
			},
			},
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
				{
				{type="deletePrivateTransfer",
					param={
							transfers =
							{
								{taskID = 1712, index = 1},--删除私有传送阵
							},
						},
				},
				{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21278, mapID = 416, x = 89, y = 250, dir = Direction. EastSouth,}, --袁术
							[2] = {npcID = 21276, mapID = 416, x = 88, y = 248, dir = Direction. EastSouth,}, --
							[3] = {npcID = 21277, mapID = 416, x = 88, y = 252, dir = Direction. EastSouth,}, --
							[4] = {npcID = 21271, mapID = 416, x = 86, y = 252, dir = Direction. EastSouth,}, --
							[5] = {npcID = 21272, mapID = 416, x = 86, y = 248, dir = Direction. EastSouth,}, --
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
						[1] ={npcID = 21278, taskID = {1714}, index = 1}, --删除袁术
						[2] ={npcID = 21276, taskID = {1714}, index = 2}, --
						[3] ={npcID = 21277, taskID = {1714}, index = 3}, --
						[4] ={npcID = 21271, taskID = {1714}, index = 4}, --
						[5] ={npcID = 21272, taskID = {1714}, index = 5}, --
						},
				        },
                         },
		        {type="deleteFollow", param = {npcs = {21228},},},--删除孙策跟随
			{type="createPrivateNpc",  --私有npc创建
				param={
						npcs =
						{
							[1] = {npcID = 21228, mapID = 416, x = 89, y = 250, dir = Direction. EastSouth,}, --孙策
						},
					},
			},
		        {type="openDialog", param={dialogID = 1801},},
			
			},
		},
	},

}

table.copy(MainTaskDB41_45, NormalTaskDB)
