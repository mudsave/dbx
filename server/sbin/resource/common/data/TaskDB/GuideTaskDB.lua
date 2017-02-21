--[[GuidTaskDB.lua
	描述：指引任务配置
]]

-- 指引任务
GuideTaskDB = {
	-- 师门任务
	[2001] = {
		name = "拜见掌门",			-- 任务名称
		startNpcID		= 20004,	-- 起始NPC
		endNpcID		= 20004,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 2002,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.QYD,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards			= {},					-- 任务的奖励
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{			
		},
		triggers =								-- 任务的触发
		{
			[TaskStatus.Done] =
			{
				{type="autoTrace", param = {tarMapID = 1, x = 30, y = 85,npcID = 20004,},},
			},
		},
	},

	[2002] = {
		name = "完成10次师门任务",	-- 任务名称
		startNpcID		= 20004,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {2001},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.QYD,		-- 任务的门派
		level			=	{20,150},			-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 100,		-- 玩家经验
			[TaskRewardList.subMoney]	= 1000,		-- 绑银
			[TaskRewardList.player_pot] = 300,  	-- 人物潜能
		},
		consume	=									-- 任务的消耗
		{
		},
		targets	=									-- 任务的目标
		{	
			[1] = {type = 'TguideTask', param = {taskID = 10001, count = 10, bor = false}}, -- 指引相应的任务
			-- [2] = {type = 'TjoinFaction',param = {count = 1,bor = false}},				-- 加入帮派的指引
		},
		triggers =									-- 任务的触发
		{			
		},
	},


	[2003] = {
		name = "会见萧枭",			-- 任务名称
		startNpcID		= 29048,	-- 起始NPC
		endNpcID		= 29048,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards			= {},					-- 任务的奖励
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{			
		},
		triggers =								-- 任务的触发
		{
			[TaskStatus.Done] =
			{
				{type="autoTrace", param = {tarMapID = 10, x = 135, y = 207,npcID = 29048,},},
			},
		},
	},


	[2004] = {
			name = "加入帮会",	-- 任务名称
			startNpcID		= 290048,	-- 起始NPC
			endNpcID		= nil,		-- 结束NPC
			preTaskData		= {2003},		-- 前置任务
			nextTaskID		= nil,		-- 后置任务
			startDialogID	= nil,		-- 开始对话的ID
			endDialogID		= nil,		-- 结束对话的ID
			taskType2		= TaskType2.NewBie,	-- 任务的类型
			school			= nil,		-- 任务的门派
			level			=	{20,150},			-- 接受任务的等级
			rewards	=								-- 任务的奖励
			{
				[TaskRewardList.player_xp]	= 100,		-- 玩家经验
				[TaskRewardList.subMoney]	= 1000,		-- 绑银
				[TaskRewardList.player_pot] = 300,  	-- 人物潜能
			},
			consume	=									-- 任务的消耗
			{
			},
			targets	=									-- 任务的目标
			{	
				-- [1] = {type = 'TguideTask', param = {taskID = 10001, count = 10, bor = false}}, -- 指引相应的任务
				[1] = {type = 'TjoinFaction',param = {count = 1,bor = false}},				-- 加入帮派的指引
			},
			triggers =									-- 任务的触发
			{			
			},
		},



}

table.copy(GuideTaskDB, NormalTaskDB)




