--[[GuidTaskDB.lua
	描述：指引任务配置
]]

-- 指引任务
GuideTaskDB = {
	-- 师门任务
	[15001] = {
		name = "师门指引",			-- 任务名称
		startNpcID		= 20004,	-- 起始NPC
		endNpcID		= 20004,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15002,	-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.QYD,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15002] = {
		name = "完成十次师门任务",	-- 任务名称
		startNpcID		= 20004,	-- 起始NPC
		endNpcID		= 20004,		-- 结束NPC
		preTaskData		= {15001},		-- 前置任务
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
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15003] = {
		name = "师门指引",			-- 任务名称
		startNpcID		= 20006,	-- 起始NPC
		endNpcID		= 20006,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15004,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.JXS,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15004] = {
		name = "完成十次师门任务",	-- 任务名称
		startNpcID		= 20006,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15003},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.JXS,		-- 任务的门派
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
			[1] = {type = 'TguideTask', param = {taskID = 10002, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15005] = {
		name = "师门指引",			-- 任务名称
		startNpcID		= 20008,	-- 起始NPC
		endNpcID		= 20008,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15006,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.ZYM,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15006] = {
		name = "完成十次师门任务",	-- 任务名称
		startNpcID		= 20008,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15005},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.ZYM,		-- 任务的门派
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
			[1] = {type = 'TguideTask', param = {taskID = 10003, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15007] = {
		name = "师门指引",			-- 任务名称
		startNpcID		= 20009,	-- 起始NPC
		endNpcID		= 20009,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15008,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.YXG,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15008] = {
		name = "完成十次师门任务",	-- 任务名称
		startNpcID		= 20009,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15007},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.YXG,		-- 任务的门派
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
			[1] = {type = 'TguideTask', param = {taskID = 10004, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15009] = {
		name = "师门指引",			-- 任务名称
		startNpcID		= 20005,	-- 起始NPC
		endNpcID		= 20005,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15010,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.TYD,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15010] = {
		name = "完成十次师门任务",	-- 任务名称
		startNpcID		= 20005,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15009},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.TYD,		-- 任务的门派
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
			[1] = {type = 'TguideTask', param = {taskID = 10005, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15011] = {
		name = "师门指引",			-- 任务名称
		startNpcID		= 20007,	-- 起始NPC
		endNpcID		= 20007,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15012,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.PLG,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15012] = {
		name = "完成十次师门任务",	-- 任务名称
		startNpcID		= 20007,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15011},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= SchoolType.PLG,		-- 任务的门派
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
			[1] = {type = 'TguideTask', param = {taskID = 10006, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15013] = {
		name = "试炼指引",			-- 任务名称
		startNpcID		= 27150,	-- 起始NPC
		endNpcID		= 27150,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {40,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},

	[15014] = {
		name = "天道指引",			-- 任务名称
		startNpcID		= 29008,	-- 起始NPC
		endNpcID		= 29008,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15015,	-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {30,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15015] = {
		name = "完成十次天道任务",	-- 任务名称
		startNpcID		= 29008,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15014},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			=	{30,150},			-- 接受任务的等级
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
			[1] = {type = 'TguideTask', param = {taskID = 10008, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},

	[15016] = {
		name = "帮派指引",			-- 任务名称
		startNpcID		= 29048,	-- 起始NPC
		endNpcID		= 29048,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15016,	-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
			{
				[TaskRewardList.player_xp]	= 10,		-- 玩家经验
				[TaskRewardList.subMoney]	= 100,		-- 绑银
				[TaskRewardList.player_pot] = 30,  	-- 人物潜能
			},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15017] = {
			name = "加入帮会",	-- 任务名称
			startNpcID		= 29048,	-- 起始NPC
			endNpcID		= nil,		-- 结束NPC
			preTaskData		= {15016},		-- 前置任务
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
				[1] = {type = 'TjoinFaction',param = {count = 1,bor = false}},				-- 加入帮派的指引
			},
			triggers =									-- 任务的触发
			{			
			},
		},

	[15018] = {
		name = "坐骑指引",			-- 任务名称
		startNpcID		= 39000,	-- 起始NPC
		endNpcID		= 39000,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {35,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},

	[15019] = {
		name = "生活技能",			-- 任务名称
		startNpcID		= 29005,	-- 起始NPC
		endNpcID		= 29005,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {20,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},

	[15020] = {
		name = "副本指引",			-- 任务名称
		startNpcID		= 30320,	-- 起始NPC
		endNpcID		= 30320,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {35,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},

	[15021] = {
		name = "讨逆指引",			-- 任务名称
		startNpcID		= 28022,	-- 起始NPC
		endNpcID		= 28022,	-- 结束NPC
		preTaskData		= nil,		-- 前置任务
		nextTaskID		= 15022,	-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			= {35,150},				-- 接受任务的等级
		rewards	=								-- 任务的奖励
		{
			[TaskRewardList.player_xp]	= 10,		-- 玩家经验
			[TaskRewardList.subMoney]	= 100,		-- 绑银
			[TaskRewardList.player_pot] = 30,  	-- 人物潜能
		},
		consume			= {},					-- 任务的消耗		
		targets	=								-- 任务的目标
		{
		},
		triggers =								-- 任务的触发
		{
		},
	},
	[15022] = {
		name = "完成十次天道任务",	-- 任务名称
		startNpcID		= 29008,	-- 起始NPC
		endNpcID		= nil,		-- 结束NPC
		preTaskData		= {15021},		-- 前置任务
		nextTaskID		= nil,		-- 后置任务
		startDialogID	= nil,		-- 开始对话的ID
		endDialogID		= nil,		-- 结束对话的ID
		taskType2		= TaskType2.NewBie,	-- 任务的类型
		school			= nil,		-- 任务的门派
		level			=	{35,150},			-- 接受任务的等级
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
			[1] = {type = 'TguideTask', param = {taskID = 10010, count = 10, bor = false}}, -- 指引相应的任务
		},
		triggers =									-- 任务的触发
		{			
		},
	},
}

table.copy(GuideTaskDB, NormalTaskDB)




