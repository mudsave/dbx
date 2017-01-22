--[[ DailyTaskDB.lua

    Author: Caesar
    Function: save the data for the DailyTask

]]

DailyTaskDB = 
{
	
	[40001] = 
	{
		name = "修炼之路",			-- 任务名称
		level = {25,150} ,				-- 任务可接等级(最小等级--最大等级)
		school = nil,					-- 任务可接门派
		remainCount = 1,
		taskType2 = TaskType2.Daily,		-- 任务类型
		content = "<font color ='#FFFFFFFF'>累计消灭200只与你等级相差5级以内的怪物（%s/200）</font>",		-- 任务日志中显示的，任务内容
		rewards ={						-- 任务奖励
			{
				type=RewardSelectType.All,
				{
					group = '1',
					{ t = 'subMoney',v = 1700,},
					{ t = 'xp',v = 3400,},
				},
			},
		},
		startNpcInfo = {y=134,x=68,name='曲扬',id=10087,mapName='紫电门',mapID=34,},--接任务npc
		endNpcInfo = {y=62,x=188,name='刘备1',id=20198,mapName='碧莲池1',mapID=56,},--交任务npc
		recdesc ="<font color ='#FFFFFFFF'>快到洛阳的管贤士那里领取任务吧！只需交少量钱币或代币就能领取任务，完成后有大量经验、道行奖励！</font>",-------任务日志中显示的，任务说明。此行字段不配置则不显示该模块
		targets = 
		{
			[1] = {type='TwearEquip',param = {},tip = "装备12312", doneTip = "已装备上"}, --打一个脚本战斗(脚本战斗ID 203，次数)
			[2] = {type='TwearEquip',param = {},tip = "装备2",doneTip = "已装备上"},
			[3] = {type='TwearEquip',param = {},tip = "装备3",doneTip = "已装备上"},
			[4] = {type='TwearEquip',param = {},tip = "装备4",doneTip = "已装备上"},-------到达指定坐标
			[5] = {type='TwearEquip',param = {},tip = "装备5",doneTip = "已装备上"},--学习特定技能到多少级
		},
	}

}