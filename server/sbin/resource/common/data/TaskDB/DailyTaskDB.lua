--[[ DailyTaskDB.lua

    Author: Caesar
    Function: save the data for the DailyTask

]]

DailyTaskDB = 
{
	
	[40001] = 
	{
		name = "平邦卫境",			-- 任务名称
		level = {25,150} ,				-- 任务可接等级(最小等级--最大等级)
		school = nil,					-- 任务可接门派
		startNpcID = 29081,	--任务起始npc
		endNpcID = 29081,	--任务结束npc
		endNpcInfo = {name = "伏完",mapID = 10 ,x = 49,y = 229 },
		preTaskData = nil,	--任务前置任务没有填nil
		nextTaskID = nil,
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Daily,		-- 任务类型
		content = "<font color ='#FFFFFFFF'>通过</font><font color = '#FFFFFF00'>任务、日常活动、野外自动遇怪</font><font color ='#FFFFFFFF'>，消灭与你等级相近的妖物。</font><font color = '#FFFFFF00'>（当前：已消灭妖物%d只）</font><font color = '#F89CFF0'>（目标：总共消灭%d只妖物）</font>",		-- 任务日志中显示的，任务内容
		recdesc ="<font color ='#FFFFFFFF'>大批妖物正在洛阳周边兴妖作乱，威胁百姓性命安全，伏完将军目前忙得抽不开身，你需要替他前往守卫边境，击杀200只等级相近</font><font color = '#F89CFF0'>（等级差5级以内）</font><font color ='#FFFFFFFF'>的妖物。完成任务可获得经验与绑银。</font>",
		rewards ={	
			[TaskRewardList.player_xp] 	= 80000,	
			[TaskRewardList.subMoney]	= 100000,	
		},
		consume	=--任务消耗没有填{}
		{
			
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = {type= "TkillMonster",param = {monsterID	= {-5,5},targetCount = 200,currentCount = 0 },tip = "消灭200只与你等级相近的作乱妖物"},
		},
		triggers = --任务触发器
		{
			
		},
		quitDesc = "<font color ='#FFFFFFFF'>放弃当前任务，您的</font><font color = '#FFFF0000'>任务进度将被清除，</font><font color ='#FFFFFFFF'>同时</font><font color = '#FFFF0000'>今天无法再接取该任务</font><font color ='#FFFFFFFF'>，确定吗？</font>",
	},
	[40002] = 
	{
		name = "帮会休闲挑战",			-- 任务名称
		level = {1,150},				-- 任务可接等级(最小等级--最大等级)
		school = nil,					-- 任务可接门派
		startNpcID = 40016,	--任务起始npc
		endNpcID = {40011,40012,40013,40014,40015},	--任务结束npc，这个设置为表，是为了根据权重产生随机
		endNpcInfo = {name = "王允",mapID = 13 ,x = 52,y = 145 },
		preTaskData = nil,	--任务前置任务没有填nil
		nextTaskID = 40003,
		startDialogID =	30102,	--接任务对话ID没有填nil，这里填个表，是为了根据对话的权重产生随机
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Daily,		-- 任务类型
		content = "<font color ='#FFFFFFFF'>和%s对话并进入挑战..............</font>",		-- 任务日志中显示的，任务内容
		rewards ={	
			[TaskRewardList.player_xp] 	= 1000,
			[TaskRewardList.pet_xp]		= 100,	
			[TaskRewardList.pet_tao]	= 100,	
		},
		consume	=--任务消耗没有填{}
		{
			
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = 
			{
				type= "TrandomFightScript",param = {count = 0},
			}
		},
		triggers = --任务触发器
		{
			
		},
		quitDesc = "放弃当前任务，任务进度将被删除，同时消耗一次当日可完成次数，你确定吗？",
	},
	[40003] = 
	{
		name = "帮会休闲挑战",			-- 任务名称
		level = {1,150},				-- 任务可接等级(最小等级--最大等级)
		school = nil,					-- 任务可接门派
		startNpcID = nil,	--任务起始npc
		endNpcID = 40016,	--任务结束npc，这个设置为表，是为了根据权重产生随机
		endNpcInfo = {name = "王允",mapID = 13 ,x = 52,y = 145 },
		preTaskData = 40002,	--任务前置任务没有填nil
		nextTaskID = nil,
		startDialogID =	30102,	--接任务对话ID没有填nil，这里填个表，是为了根据对话的权重产生随机
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Daily,		-- 任务类型
		content = "<font color ='#FFFFFFFF'>前往王允那，告诉挑战结果</font>",		-- 任务日志中显示的，任务内容
		rewards ={	
			[TaskRewardList.player_xp] 	= 1000,
			[TaskRewardList.pet_xp]		= 100,	
			[TaskRewardList.pet_tao]	= 100,	
		},
		consume	=--任务消耗没有填{}
		{
			
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			[1] = 
			{
				type= "TrandomFightScript",param = {count = 0},tip = "击杀200只与你等级相差为5的怪物",
			}
		},
		triggers = --任务触发器
		{
			
		},
		quitDesc = "放弃当前任务，任务进度将被删除，同时消耗一次当日可完成次数，你确定吗？",
	},
	
}