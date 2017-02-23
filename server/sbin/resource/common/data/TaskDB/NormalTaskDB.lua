--[[MainTaskDB.lua
	任务配置(任务系统)
]]
--{type='Tarea',param =	{mapID = 2 , x = 2, y =	3, bor = true},},
--{type='Tscript',param	= {scriptID = 203 , count = 2, bor = true},},
--{type = "npcEscape",	param =	{npcs =	{{npcID	= 3, x = 50, y = 50}},}}, --npc逃跑到目标点消失
--preTaskData =	{2001},
--preTaskData =	{condition = "and",{2002,2003}},
--preTaskData =	{condition = "or",{2002,2003}},
--preTaskData =	nil,

INIT_DIALOGID =	100 --出生对话
INIT_TASKID =	1001 --出生对话
NormalTaskDB =
{
	[2002] =
	{

		name = "测试任务1",	--任务名字
		startNpcID = 22562,	--任务起始npc
		endNpcID = 20056,	--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 2003,	--任务后置任务没有填nil
		startDialogID =	1,	--接任务对话ID没有填nil
		endDialogID = 51,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 300,    --绑银
			[TaskRewardList.player_pot] = 300,  	--人物潜能
			--[TaskRewardList.money] = 200,       --银两
			--[TaskRewardList.cashMoney] = 400, --银元宝
			--[TaskRewardList.goldCoin] = 500,  --金元宝
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
			--[1] = {type='TautoMeet',param = {mapID = 1 , x = 120, y = 47, bor =	false},},---到达一个坐标自动遇敌
			--[1] =	{type='Tscript',param =	{scriptID = 203	, count	= 1, ignoreResult = true, bor =	true},},--不论胜负
			--lostTransfer = {mapID = , x = , y =},
			[1] = {type='Tscript',param = {scriptID	= 203 ,	count =	1, bor = true},}, --打一个脚本战斗(脚本战斗ID 203，次数)
			[2] = {type='Tmine',param = --主线踩雷目标
			{
				mineIndex = 1,		--第一个雷
				lastMine = false,	--是否为最后一个雷
				scriptID = 203,
				dialogID = 1,
				npcsData =			--刷出npc数据
				{
					{npcID = 20, x = 98, y = 78, noDelete = true,},--(坐标，动作ID，光效ID，动作结束打开的对话框(配一个就行))目标完成是否删除npc，
					{npcID = 21, x = 99, y = 78, noDelete = true},
				},
				posData	= {mapID = 2, x	= 96, y	= 78}, --踩雷坐标
				bor = false,	--如果为true则完成此目标任务直接完成
			},
			},
			[3] = {type='Tmine',param =
			{
				mineIndex = 2,
				lastMine = true,
				scriptID = 203 ,
				dialogID = 1,
				--lostTransfer = {mapID = , x = , y =},--------新加，暗雷玩家战斗逃跑，传送到指定地图
				npcsData =
				{
					{npcID = 20, x = 198, y	= 178, noDelete =	true,},
					{npcID = 21, x = 199, y	= 178, noDelete =	true},
				},
				posData	= {mapID = 2, x	= 196, y = 178},
				bor = false,
			},
			},
			[4] = {type='Tarea',param = {mapID = 2 , x = 164, y = 72, bor =	false},},-------到达指定坐标
			[5] = {type='TlearnSkill',param	= {skillID = 164, tarLevel = 2 , bor = false},},--学习特定技能到多少级
			--[6] = {type='TobtainPet',param	= {petID  = xx, count = 1 , bor = false},},--学习特定技能到多少级  bor= true 只要完成一个任务目标 任务就算完成。
			--[[[7] = {type='TcollectGuard',param =   ---采集物品战斗
				{
					mpwID = 2008,--采集的实体ID
					scriptID= 405,
					dialogID = 2202,
					npcsData =			--刷出npc数据
					{
						{npcID = 20804, x = 187, y = 105, },
						{npcID = 20805, x = 187, y = 105, },
						{npcID = 20806, x = 187, y = 105, },
					},
						
				}
			}]]
			--[8] = {type = "TgetItem", param = {itemID = 1051013, count = 1 ,bor = true},}--任务目标获取物品
			--[9] = {type='TcontactSeal',param = {sealID = xxx， bor = false},},---任务目标 例如：摧毁需破坏的阵法或者摧毁采集的物品
			--[10] = {type='TattainLevel',param = {level = 30,bor = true},},---等级限制目标
			--[11] = {type='Tride',param = {rideID = 10, bor = false},}, ------获得坐骑任务目标

		},
		triggers = --任务触发器
		{
			--带有中间npc的配到对话里
			[TaskStatus.Active] =
			{
				{type = "createFollow", param = {npcs = {1,2,3},}},				--创建指定npc跟随(参数npcID)
				{type = "getItem", param = {itemID = 100225, count = 5,}},			--获得指定数量的物品(参数物品ID，数量)
			--	{type = "doSwithScene", param = {tarMapID = 2,	x = 5, y = 5,}},	--传送到另一个场景
			--	{type = "getRide", param = {rideID = 2, count = 5,}},				--获得指定数量坐骑
			--	{type = "getPet", param = {petID = 2, count = 5,}},				--获得指定数量宠物
			--	{type = "enterScriptFight", param = {scriptID = 203, mapID = 2}},	--进入脚本战斗
			--	{type = "enterEctype",	param =	{ectypeID = 5,}},					--进入副本
			--	{type = "autoTrace", param = {tarMapID	= 3, x = 28, y = 92,npcID = 20006,},}, --寻路到掌门
			--	{type = "playAnimation", param = {playID = 1002, sceneID = 1,},},				--触发指定ID的脚本动画(参数待定)
			--	{type = "flyEffect", param = {flyEffectID = 1}},--飞剑动画
			--	{type = "createCage", param = {position = {mapID = ,x = ,y =},}},	--创建笼子

			{type = "createMine",
					param =
					{
						{mapID = 2, scriptID = 203},
						{mapID = 3, scriptID = 208},
					}
				},	--创建任务雷，在有一个任务中有两张地图，及两张地图以上的写这个代码
			{type = "createMine",
					param =
					{
					{mapID = 103, scriptID = {118,119},fightMapID = nil,stepFactor = 0.2,mustCatch = false},
					}
				} --创建任务雷，如果一个任务在一张地图上，需要打两场任务雷，在两场任务雷的情况下，写这个代码
			},
			[TaskStatus.Done]		=
			{
				{type = "createPrivateNpc", ----------创建私有npc
					param={
						npcs =
						{
								[1] = {npcID = 20029,	mapID =	101, x = 88, y = 218,dir = Direction.WestSouth,},
						},
					},
				},
				{type = "deletePrivateNpc", ----------删除张宝围困
				param={
						npcs =
						{
							{npcID = 20029,	taskID = {1035}, index = 1},
						},
					},
				},
				{type = "createPrivateTransfer", ------创建私有传送阵--
					param={
							transfers =
							{
								[1] = {mapID = 101, x =41, y =234, tarMapID = 102, tarX = 65, tarY = 172},
							},
						},
				},
				{type = "deletePrivateTransfer", ------删除私有传送阵
					param={
							transfers =
							{
								{taskID = 1036, index = 1},
							},
						},
				},
				{type = "deleteFollow", param = {npcs = {3},}}, --在完成状态删除指定ID的npc跟随
				{type = "npcEscape", param = {npcs = {{npcID =	3, x = 50, y = 50}},}},	--npc逃跑到目标点消失
				--{type = "finishTask", param = {}},--触发完成任务
				--{type = "recetiveTask", param = {taskIDs = {1}}},--触发接受任务,改成表
				--上面修改成
				--{type = "finishTask", param = {recetiveTaskID = 1103}},--触发完成任务接受下一个任务
				--{type = "finishTask", param = {recetiveTaskID = {1082,1084,1086,1088,1090,1092}}},--触发完成任务接受下多个任务
				--{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
			    --{type = "removeMine", param = {}}, -- 移除任务类
				--{type = "enterScriptFight", param = {scriptID = 100, mapID = 8}}, --接受任务时直接进入战斗
			},
			[TaskStatus.Finished]	=
			{
				{type = "openDialog", param={dialogID = 1},}, --在任务结束时打开一个对话框
				{type = "openUI", param={v = "SkillBoard"},}  --在任务结束打开一个UI
			}
		}
	},



---[1] = {type='Tarea',param = {}, location={mapID=101,x=245,y=109}, tip = "寻找刘备",linkTip = "刘备",count = 1,}, 客户端指引
---[2] = {type='Tride',param = {},tip = "请上坐骑"}客户端获得坐骑任务目标

	[935] = 
	{
		name = "测试任务2",	--任务名字
		startNpcID = 22562,	--任务起始npc
		endNpcID = 20056,	--任务结束npc
		preTaskData = {1003},	--任务前置任务没有填nil
		nextTaskID = 2003,	--任务后置任务没有填nil
		startDialogID =	1,	--接任务对话ID没有填nil
		endDialogID = 51,	--交任务对话ID没有填nil
		taskType2 = TaskType2.Main,--任务类型
		school = nil,	--门派限制没有填nil
		level =	{1,150},--等级限制
		rewards	= --任务奖励没有填{}
		{
			[TaskRewardList.player_xp] = 5000,   --玩家经验
			[TaskRewardList.pet_xp] = 5000,      --宠物经验
			[TaskRewardList.subMoney] = 300,    --绑银
			[TaskRewardList.player_pot] = 300,  	--人物潜能
			--[TaskRewardList.money] = 200,       --银两
			--[TaskRewardList.cashMoney] = 400, --银元宝
			--[TaskRewardList.goldCoin] = 500,  --金元宝
		},
		consume	=--任务消耗没有填{}
		{
			["money"] = 100,
			["xp"] = 100,
		},
		targets	= --任务目标没有填{}(必须前面填上索引[1][2][3])
		{
		    --穿戴指定物品及装备目标（可以写多个）
			[1] = {type='TwearEquip',param = {equipID	= 2001085, bor = false},},--武器
			[2] = {type='TwearEquip',param = {equipID	= 2001091, bor = false},},--护肩
			[3] = {type='TwearEquip',param = {equipID	= 2001092, bor = false},},--头盔
			[4] = {type='TwearEquip',param = {equipID	= 2001093, bor = false},},--战袍
			[5] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--裤子
			[6] = {type='TwearEquip',param = {equipID	= 2001094, bor = false},},--鞋子
		},
		triggers = --任务触发器
		{
			
		},
	}

}