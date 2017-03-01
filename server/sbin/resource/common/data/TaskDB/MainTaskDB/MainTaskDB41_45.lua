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
------------------------------------------- 我是分割线 -----------------------------------------------------------

}

table.copy(MainTaskDB41_45, NormalTaskDB)
