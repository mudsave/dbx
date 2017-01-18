--[[BranchTaskDB1_20.lua
	支线任务配置1到20级(任务系统)

	101-200		--坐骑召唤任务
]]

BranchTaskDB1_20 =
{
	[101] = 
	{
		name = "坐骑任务神龙教主",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7001, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39001},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[102] = 
	{
		name = "坐骑任务炼狱神牛",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7002, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39002},},
				{type= "openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[103] = 
	{
		name = "坐骑任务金翅大鹏王",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7003, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39003},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[104] = 
	{
		name = "坐骑任务夜刃猎手",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7004, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39004},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[105] = 
	{
		name = "坐骑任务影狐",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7005, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39005},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[106] = 
	{
		name = "坐骑任务巨斧魔王",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7006, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39006},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[107] = 
	{
		name = "坐骑任务碧蓝魔将",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7007, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39007},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[108] = 
	{
		name = "坐骑任务隐士",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7008, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39008},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[109] = 
	{
		name = "坐骑任务图腾力士",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7009, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39009},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
	[110] = 
	{
		name = "坐骑任务万骨魔君",	--任务名字
		startNpcID = nil,	--任务起始npc
		endNpcID = nil,	--任务结束npc
		preTaskData = {nil},	--任务前置任务没有填nil
		nextTaskID = nil,	--任务后置任务没有填nil
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Sub,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{35,150},--等级限制
		limitTime = 60 * 60,
		rewards	= --任务奖励没有填{}
		{
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type='Tscript', param = {scriptID = 7010, count = 1, bor = true},},-------到达指定坐标
		},
		triggers = --任务触发器
		{
			[TaskStatus.Active] =
			{
				{type= "createBoss", param = {npcID = 39010},},
				{type="openDialog", param={dialogID = 27092},},
			},
			[TaskStatus.Done] = 
			{
				{"removeBoss", param = {},},
				{"finishTask", param = {},},
			}			
		},
	},
}

table.copy(BranchTaskDB1_20, NormalTaskDB)