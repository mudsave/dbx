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
		endNpcInfo = {name = "伏完将军",mapID = 10 ,x = 52,y = 230 },
		preTaskData = nil,	--任务前置任务没有填nil
		nextTaskID = nil,
		startDialogID =	nil,	--接任务对话ID没有填nil
		endDialogID = nil,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Daily,		-- 任务类型
		content = "<font color ='#FFFFFFFF'>累计消灭200只与你等级相差5级以内的怪物,当前已击杀（%d/%d只）</font>",		-- 任务日志中显示的，任务内容
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
			[1] = {type= "TkillMonster",param = {monsterID	= {-5,5},targetCount = 2,currentCount = 0 },tip = "击杀200只与你等级相差为5的怪物"},
		},
		triggers = --任务触发器
		{
			
		},
		quitDesc = "放弃当前任务，任务进度将被删除，同时消耗一次当日可完成次数，你确定吗？",
	}
}