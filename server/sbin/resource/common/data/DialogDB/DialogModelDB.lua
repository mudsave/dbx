--[[DialogModelDB.lua
	对话配置(对话系统)
	1-100空着不用
	100-10000 主线对话
	10001-20000副本 各种副本的对话ID集合
	20001-21000主城固定npc以及默认对话
	21001-26000通天塔以及其他
	27001-27100坐骑任务
	27101-27150天子猎金场
	30001-35000循环任务（30100-30300 帮派任务）
	35001-35099抓宠任务
	35100-35199瑞兽降福
	现在副本用到的ID是3000 ---3100
	这一段跳过，我们配置主线任务的时候注意这个。
	50100-50199 每日任务（新增）
]]

DialogModelDB =
{
-------------------主线任务特殊处理对话-----------------------------task---
    [108] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人传承有六大仙门，本座已令其中一派乾元岛掌门太极仙翁收你入门，教你降妖伏魔本领！你且去寻莲花童子助你下凡！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1004}},
						},
			}
		},
	},
	 [118] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人传承有六大仙门，本座已令其中一派桃源洞掌门龙虎天师收你入门，教你降妖伏魔本领！你且去寻莲花童子助你下凡！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1009}},
						},
			}
		},
	},
      [128] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人间传承有六大仙门，本座已令其中一派金霞山掌门妙道真君收你入门，教你降妖伏魔本领！你且去寻莲花童子助你下凡！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1014}},
						},
			}
		},
	},
       [138] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人间传承有六大仙门，本座已令其中一派蓬莱阁掌门南海龙女收你入门，教你降妖伏魔本领！你且去寻莲花童子助你下凡！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1019}},
						},
			}
		},
	},
        [148] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人间传承有六大仙门，本座已令其中一派紫阳门掌门黄天化收你入门，教你降妖伏魔本领！你且去寻莲花童子助你下凡！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1024}},
						},
			}
		},
	},
        [158] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人间传承有六大仙门，本座已令其中一派云霄宫掌门纯阳真人收你入门，教你降妖伏魔本领！你且去寻莲花童子助你下凡！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1029}},
						},
			}
		},
	},

----------------------------31-32级主线任务NPC绑定对话--------------------------
	[1110] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1153, statue = true}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "那孙将军现在何处？可有杀出重围？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1153}},
					{action = DialogActionType.RecetiveTask, param = {taskID = 1154}},
					{action = DialogActionType.Goto, param = {dialogID = 1111}},

						},
			}
		},
	},

	[1120] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1156, statue = true}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙将军，我已将二位将军救下。恕我直言，以将军之兵力，何以不敌那徐荣。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1156}},
					{action = DialogActionType.RecetiveTask, param = {taskID = 1157}},
					{action = DialogActionType.Goto, param = {dialogID = 1121}},

						},
			}
		},
	},

	[1166] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 0,
		soundID = nil,
		txt = "童子，我已获得四妖兽的魂魄，请您炼制灭魂珠吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1168,itemsInfo = {{itemID = 1041018, count = 1},{itemID = 1041019, count = 1},{itemID = 1041020, count = 1},{itemID = 1041021, count = 1}}},},
				},
			},
		},
	},

	[1172] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1169, statue = true}},
		},
		speakerID = 20639,
		soundID = nil,
		txt = "小娃娃，没想到你竟然还敢回来，这次绝不会再让你逃了。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1173}},

						},
			}
		},
	},

	[1177] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1171, statue = true}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "黄盖将军，那妖人吕岳已被我杀死，妖阵已破，不会再有魔兵出现捣乱！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1178}},

						},
			}
		},
	},

--------------------31-32级主线任务NPC绑定对话完毕------------------------------------

	[1221] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘莫慌，我这便回师门问策，我师父定有办法可解吕将军之毒。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1206}},
						},
			}
		},
	},

         [1222] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘莫慌，我这便回师门问策，我师父定有办法可解吕将军之毒。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1207}},
						},
			}
		},
	},

         [1223] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘莫慌，我这便回师门问策，我师父定有办法可解吕将军之毒。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1208}},
						},
			}
		},
	},

         [1224] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘莫慌，我这便回师门问策，我师父定有办法可解吕将军之毒。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1209}},
						},
			}
		},
	},

	 [1225] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘莫慌，我这便回师门问策，我师父定有办法可解吕将军之毒。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1210}},
						},
			}
		},
	},

	[1226] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘莫慌，我这便回师门问策，我师父定有办法可解吕将军之毒。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1211}},
						},
			}
		},
	},

	----------------------33-34级主线对话-----------------------
	 [1287] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "此事不妙，需速速回门派请求掌门援助！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1210}},
						},
			}
		},
	},
	[1288] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "此事不妙，需速速回门派请求掌门援助！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1211}},
						},
			}
		},
	},
	[1289] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "此事不妙，需速速回门派请求掌门援助！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1212}},
						},
			}
		},
	},
	[1290] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "此事不妙，需速速回门派请求掌门援助！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1213}},
						},
			}
		},
	}, 
	[1291] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "此事不妙，需速速回门派请求掌门援助！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1214}},
						},
			}
		},
	},
	[1292] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "此事不妙，需速速回门派请求掌门援助！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1215}},
						},
			}
		},
	},
	[1298] =            -------------主线任务33-34传送青峰山
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.HasTasks, param = {taskIDs = {1217,1224}, statue = true}},	
		},
		speakerID = 20726,
		txt = "阐教弟子，我可以送你到长安。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "长安",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 13, tarX = 100, tarY = 100}},
				},
			},

		},
	},
	[1299] =            -------------主线任务33-34传送青峰山
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.HasTasks, param = {taskIDs = {1223}, statue = true}},	
		},
		speakerID = 30256,
		txt = "阐教弟子，我可以送你到蓬莱山。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "蓬莱山",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 114, tarX = 57, tarY = 113}},
				},
			},

		},
	},
		----------------------------主线35-36对话门派分段---------------------
	[1332] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},----乾元岛
		},
		speakerID = 20820,
		soundID = nil,
		txt = "没错！那魔龙宫的入口就在我身后不远。不过魔龙宫的入口已经被投靠董卓的魔将飞廉封印，封印的阵法分别位于西凉地图的四个不同方位，只有解除这四处封印，才能开启魔龙宫真正的入口。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1333}},
						},
			}
		},
	},
	[1333] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},----乾元岛
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来只能回师门找师傅询问下有何解决办法。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1310}},
						},
			}
		},
	},
	[1337] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},--桃源洞
		},
		speakerID = 20820,
		soundID = nil,
		txt = "没错！那魔龙宫的入口就在我身后不远。不过魔龙宫的入口已经被投靠董卓的魔将飞廉封印，封印的阵法分别位于西凉地图的四个不同方位，只有解除这四处封印，才能开启魔龙宫真正的入口。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1338}},
						},
			}
		},
	},
	[1338] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},--桃源洞
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来只能回师门找师傅询问下有何解决办法。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1312}},
						},
			}
		},
	},
    [1342] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},--金霞山
		},
		speakerID = 20820,
		soundID = nil,
		txt = "没错！那魔龙宫的入口就在我身后不远。不过魔龙宫的入口已经被投靠董卓的魔将飞廉封印，封印的阵法分别位于西凉地图的四个不同方位，只有解除这四处封印，才能开启魔龙宫真正的入口。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1343}},
						},
			}
		},
	},
	[1343] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},--金霞山
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来只能回师门找师傅询问下有何解决办法。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1314}},
						},
			}
		},
	},
    [1347] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},--蓬莱阁
		},
		speakerID = 20820,
		soundID = nil,
		txt = "没错！那魔龙宫的入口就在我身后不远。不过魔龙宫的入口已经被投靠董卓的魔将飞廉封印，封印的阵法分别位于西凉地图的四个不同方位，只有解除这四处封印，才能开启魔龙宫真正的入口。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1348}},
						},
			}
		},
	},
	[1348] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},--蓬莱阁
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来只能回师门找师傅询问下有何解决办法。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1316}},
						},
			}
		},
	},
    [1352] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},--紫阳门
		},
		speakerID = 20820,
		soundID = nil,
		txt = "没错！那魔龙宫的入口就在我身后不远。不过魔龙宫的入口已经被投靠董卓的魔将飞廉封印，封印的阵法分别位于西凉地图的四个不同方位，只有解除这四处封印，才能开启魔龙宫真正的入口。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1353}},
						},
			}
		},
	},
	[1353] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},--紫阳门
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来只能回师门找师傅询问下有何解决办法。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1318}},
						},
			}
		},
	},
    [1357] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},--云霄宫
		},
		speakerID = 20820,
		soundID = nil,
		txt = "没错！那魔龙宫的入口就在我身后不远。不过魔龙宫的入口已经被投靠董卓的魔将飞廉封印，封印的阵法分别位于西凉地图的四个不同方位，只有解除这四处封印，才能开启魔龙宫真正的入口。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1358}},
						},
			}
		},
	},
	[1358] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},--云霄宫
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来只能回师门找师傅询问下有何解决办法。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1320}},
						},
			}
		},
	},
	---37~38级任务---------
	[1475] =    -----------洛阳卢植
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 20049,
		txt = "左道长比你先一步到了，他此时正在皇宫救醒陛下，你也快进去吧。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 131, tarX = 35, tarY = 10}},--切换场景
						},
			}
		},
	},
	[1476] =             -------------主线任务37-38，任务ID1426，上交物品，老人财产。
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1426, statue = true}},	
		},
		speakerID = 20944,
		soundID = nil,
		txt = "我的东西你找到了吗？",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "上交材料",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1426,itemsInfo = {{itemID = 1041010, count = 1}}},},
				},
			},
		},
	},
	[1477] =             -------------主线任务37-38，任务ID1420，上交物品，炼化轩辕图。
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1420, statue = true}},	
		},
		speakerID = 20929,
		soundID = nil,
		txt = "青玄之气，紫阳之火，均是炼化轩辕图必备材料，你都找齐了吗？",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "上交材料",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1420,itemsInfo = {{itemID = 1041009, count = 1},{itemID = 1041011, count = 1},{itemID = 1041012, count = 1}}},},
				},
			},
		},
	},
	[1478] =             -------------主线任务37-38，任务ID1423，上交物品，真龙之气。
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1423, statue = true}},	
		},
		speakerID = 20929,
		soundID = nil,
		txt = "真龙之气乃救醒陛下的关键，将之交给我，贫道自有方法救醒陛下。",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "上交材料",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1423,itemsInfo = {{itemID = 1041013, count = 1}}},},
				},
			},
		},
	},
	[1533] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29030,
		soundID = nil,
		txt = "多谢英雄相助，把你取得的材料交到我这，老夫这便修复罗盘为你算得李傕的下落。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1511,itemsInfo = {{itemID = 1041005, count = 1},{itemID = 1041008, count = 1},},},},
				},
			}
		},
	},
	[1547] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29030,
		soundID = nil,
		txt = "英雄辛苦了，吾这便施法为你召唤那李傕的亡魂！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1516,itemsInfo = {{itemID = 1041006, count = 1},{itemID = 1041007, count = 1},},},},
				},
			}
		},
	},
---循环任务--------------------------------------------------------------
----------天道任务对话，ID：4001~4500-----------
	[4001] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25001,
		txt = "吾乃上古妖魔山臊，当年被阐教困于封神台内，今日我重获自由，定要杀它个痛快！",
		options =
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4001,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4002] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25002,
		
		txt = "吾乃上古妖魔钦原，当年惜败于阐教手中，被强行困于封神台下，今日定要阐教血债血偿！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4002,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4003] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25003,
		txt = "吾乃上古妖魔诸犍，当年被阐教封于封神台下，今日必要阐教付出代价！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4003,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4004] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25004,
		txt = "吾乃上古妖魔冥阴，当年力挺截教，却被阐教封于封神台下，今日我破封而出，定要助截教覆灭阐教！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4004,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4005] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25005,
		txt = "吾乃上古妖魔炎顷，当年被阐教困于封神台内，今日我重获自由，定要杀它个痛快！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4005,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4006] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25006,
		txt = "吾乃上古妖魔当康，当年惜败于阐教手中，被强行困于封神台下，今日定要阐教血债血偿！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4006,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4007] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25007,
		txt = "吾乃上古妖魔胡余，当年被阐教封于封神台下，今日必要阐教付出代价！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4007,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4008] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25008,
		txt = "吾乃上古妖魔契俞，当年力挺截教，却被阐教封于封神台下，今日我破封而出，定要助截教覆灭阐教！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4008,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4009] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25009,
		txt = "吾乃上古妖魔狻猊，当年被阐教困于封神台内，今日我重获自由，定要杀它个痛快！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4009,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4010] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25010,
		txt = "吾乃上古妖魔修蛇，当年惜败于阐教手中，被强行困于封神台下，今日定要阐教血债血偿！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4010,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4011] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25011,
		txt = "吾乃上古妖魔日猋，当年被阐教封于封神台下，今日必要阐教付出代价！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4011,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4012] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25012,
		txt = "吾乃上古妖魔剑魔，当年力挺截教，却被阐教封于封神台下，今日我破封而出，定要助截教覆灭阐教！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4012,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4013] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25013,
		txt = "吾乃上古妖魔英招 ，当年被阐教困于封神台内，今日我重获自由，定要杀它个痛快！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4013,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4014] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25014,
		txt = "吾乃上古妖魔青丘，当年不慎被困于封神台下，今日必要将人间捣个天翻地覆！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4014,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4015] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25015,
		txt = "吾乃上古妖魔夔牛，入海则必风雨，何人敢拦我！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4015,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4016] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25016,
		txt = "吾乃上古妖魔肥遗，吾法力通天，出则必旱，无人能敌！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4016,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4017] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25017,
		txt = "吾乃上古妖兽开明，力大无穷，天下只不过是我取食的场所。",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4017,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4018] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25018,
		txt = "吾乃上古妖兽紫魃，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4018,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4019] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25019,
		txt = "吾乃上古妖魔螟蛟，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4019,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4020] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25020,
		txt = "吾乃上古妖魔句芒，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4020,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4021] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25021,
		txt = "吾乃上古妖魔凿齿，吾身坚如磐石，吾抓削铁如泥，这天下还没有我不能做的事！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4021,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4022] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25022,
		txt = "吾乃上古妖魔貔貅，吾好杀戮，天下众生，均是可杀之物，与蝼蚁何异？",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4022,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4023] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25023,
		txt = "吾乃上古妖魔狡猊，吾好杀戮，天下众生，均是可杀之物，与蝼蚁何异？",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4023,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4024] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25024,
		txt = "吾乃上古妖魔狍鹗，吾好杀戮，天下众生，均是可杀之物，与蝼蚁何异？",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4024,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4025] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25025,
		txt = "吾乃上古妖兽诸怀，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4025,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4026] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25026,
		txt = "吾乃上古妖兽必方，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4026,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4027] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25027,
		txt = "吾乃上古妖魔牛柃，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4027,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4028] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25028,
		txt = "吾乃上古妖魔尚飨，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4028,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4029] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25029,
		txt = "吾乃上古妖魔禺号，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4029,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4030] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 25030,
		txt = "吾乃上古妖魔雨屏，当年不服阐教，被强行封于封魔台下，今日定要阐教十倍奉还！",
		options = 
		{
			[1] = {
				showConditions = {{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},tiredness = 1,},},},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4030,mapID = nil,type = "heaven", value = 1,}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "等我组好队再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4031] =            ------------------天道指引对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "封神台一妖魔<npcID>破封而出，其凶暴嗜血，对我阐教一直颇有意见，任其发展定会危害一方，你速前往<mapID,x,y>将他斩杀。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		              {
				},	
			},
		},
	},
	[4032] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.CheckTaskTeam, param = {playerNum = 2,playerLvlRange =10,taskLvlRange = {minLvl = 30,maxLvl =150},errorID=23,},},
		{condition = DialogCondition.CheckTaskTeam, param = {tiredness = 10,errorID=27,},},
		{condition = DialogCondition.HasTask, param = {taskID = 10008, statue = false,errorID = 28}},
		},
		speakerID = 29008,
		txt = "截教妖道，上古邪魔，均会为祸人间，还望道友能降妖伏魔，匡扶天道。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveSpecialTask, param = {taskID = 10008}},
				},
			},
		},
	},
----------师门任务对话，ID：4200~5000-----------------------------
----------------------接任务文本-------------------------------
     [4201] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 29040,
		
		txt = "呃~师门任务请移步本门派掌门领取！",
		options =
		{},
	},
     [4202] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.Level, param = {level = 20, errorID = 29}},
		{condition = DialogCondition.HasTask, param = {taskID = 10001, statue = false, errorID = 30}},
		{condition = DialogCondition.CheckLoopTask, param = {taskID = 10001, errorID = 31}},
		},
		speakerID = 20004,
		soundID = nil,
		txt = "越是大的门派日常杂物越多！你来得正好，我这里正有些任务交给你去做，也是你锤炼道心的大好机会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10001}},
				},
			},
		},
	},
    [4203] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			
		},
		speakerID = 29041,
		
		txt = "呃~师门任务请移步本门派掌门领取！",
		options =
		{},
	},
    [4204] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.Level, param = {level = 20, errorID = 29}},
		{condition = DialogCondition.HasTask, param = {taskID = 10002, statue = false, errorID = 30}},
		{condition = DialogCondition.CheckLoopTask, param = {taskID = 10002, errorID = 31}},
		},
		speakerID = 20006,
		
		txt = "越是大的门派日常杂物越多！你来得正好，我这里正有些任务交给你去做，也是你锤炼道心的大好机会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10002}},
				},
			},
		},
	},
    [4205] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			
		},
		speakerID = 29043,
		
		txt = "呃~师门任务请移步本门派掌门领取！",
		options =
		{},
	},
    [4206] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.Level, param = {level = 20, errorID = 29}},
		{condition = DialogCondition.HasTask, param = {taskID = 10003, statue = false, errorID = 30}},
		{condition = DialogCondition.CheckLoopTask, param = {taskID = 10003, errorID = 31}},	
		},
		speakerID = 20008,
		
		txt = "越是大的门派日常杂物越多！你来得正好，我这里正有些任务交给你去做，也是你锤炼道心的大好机会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10003}},
				},
			},
		},
	},
    [4207] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 29042,
		
		txt = "呃~师门任务请移步本门派掌门领取！",
		options =
		{},
	},
    [4208] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.Level, param = {level = 20, errorID = 29}},
		{condition = DialogCondition.HasTask, param = {taskID = 10004, statue = false, errorID = 30}},
		{condition = DialogCondition.CheckLoopTask, param = {taskID = 10004, errorID = 31}},	
		},
		speakerID = 20009,
		
		txt = "越是大的门派日常杂物越多！你来得正好，我这里正有些任务交给你去做，也是你锤炼道心的大好机会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10004}},
				},
			},
		},
	},
    [4209] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 29044,
		
		txt = "呃~师门任务请移步本门派掌门领取！",
		options =
		{},
	},
    [4210] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.Level, param = {level = 20, errorID = 29}},
		{condition = DialogCondition.HasTask, param = {taskID = 10005, statue = false, errorID = 30}},
		{condition = DialogCondition.CheckLoopTask, param = {taskID = 10005, errorID = 31}},	
		},
		speakerID = 20005,
		
		txt = "越是大的门派日常杂物越多！你来得正好，我这里正有些任务交给你去做，也是你锤炼道心的大好机会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10005}},
				},
			},
		},
	},
    [4211] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 29045,
		
		txt = "呃~师门任务请移步本门派掌门领取！",
		options =
		{},
	},
    [4212] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		{condition = DialogCondition.Level, param = {level = 20, errorID = 29}},
		{condition = DialogCondition.HasTask, param = {taskID = 10001, statue = false, errorID = 30}},
	        {condition = DialogCondition.CheckLoopTask, param = {taskID = 10006, errorID = 31}},
		},
		speakerID = 20007,
		
		txt = "越是大的门派日常杂物越多！你来得正好，我这里正有些任务交给你去做，也是你锤炼道心的大好机会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10006}},
				},
			},
		},
	},
------------------------暗雷战斗------------------------------
	[4230] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "世道纷乱，连我山门也不能幸免。身为本门弟子，更应以捍卫门派安危为己任。据弟子来报，<mapID,x,y>附近出现了一些<npcID>，我希望你解决它们！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
    [4231] =             ------------------乾元岛捣乱小妖（20-30级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26001,
		soundID = nil,
		txt = "嘿嘿嘿，有不知死活的凡人送命来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4101,mapID = 1}},
				},
			}
		},
	},
    [4232] =             ------------------乾元岛狡猾盗贼（30-40级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26003,
		soundID = nil,
		txt = "可恶！居然被你发现我的踪迹，那就不能留你活口了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4102,mapID = 1}},
				},
			}
		},
	},
    [4233] =             ------------------乾元岛作歹流氓（40-50级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26005,
		soundID = nil,
		txt = "早听闻仙门弟子个个道法非凡，我就要试试这所谓的道法有何威力？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4103,mapID = 1}},
				},
			}
		},
	},
    [4234] =             ------------------乾元岛恶毒山贼（50-60级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26007,
		soundID = nil,
		txt = "仙门宝地，有能者居之，你们是时候要让出来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4104,mapID = 1}},
				},
			}
		},
	},
	[4235] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "世道纷乱，连我山门也不能幸免。身为本门弟子，更应以捍卫门派安危为己任。据弟子来报，<mapID,x,y>附近出现了一些<npcID>，我希望你解决它们！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
    [4236] =             ------------------金霞山捣乱小妖（20-30级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26001,
		soundID = nil,
		txt = "嘿嘿嘿，有不知死活的凡人送命来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4101,mapID = 3}},
				},
			}
		},
	},
    [4237] =             ------------------金霞山狡猾盗贼（30-40级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26003,
		soundID = nil,
		txt = "可恶！居然被你发现我的踪迹，那就不能留你活口了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4102,mapID = 3}},
				},
			}
		},
	},
    [4238] =             ------------------金霞山作歹流氓（40-50级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26005,
		soundID = nil,
		txt = "早听闻仙门弟子个个道法非凡，我就要试试这所谓的道法有何威力？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4103,mapID = 3}},
				},
			}
		},
	},
    [4239] =             ------------------金霞山恶毒山贼（50-60级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26007,
		soundID = nil,
		txt = "仙门宝地，有能者居之，你们是时候要让出来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4104,mapID = 3}},
				},
			}
		},
	},
	[4240] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "世道纷乱，连我山门也不能幸免。身为本门弟子，更应以捍卫门派安危为己任。据弟子来报，<mapID,x,y>附近出现了一些<npcID>，我希望你解决它们！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
    [4241] =             ------------------紫阳门捣乱小妖（20-30级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26001,
		soundID = nil,
		txt = "嘿嘿嘿，有不知死活的凡人送命来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4101,mapID = 6}},
				},
			}
		},
	},
    [4242] =             ------------------紫阳门狡猾盗贼（30-40级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26003,
		soundID = nil,
		txt = "可恶！居然被你发现我的踪迹，那就不能留你活口了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4102,mapID = 6}},
				},
			}
		},
	},
    [4243] =             ------------------紫阳门作歹流氓（40-50级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26005,
		soundID = nil,
		txt = "早听闻仙门弟子个个道法非凡，我就要试试这所谓的道法有何威力？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4103,mapID = 6}},
				},
			}
		},
	},
    [4244] =             ------------------紫阳门恶毒山贼（50-60级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26007,
		soundID = nil,
		txt = "仙门宝地，有能者居之，你们是时候要让出来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4104,mapID = 6}},
				},
			}
		},
	},
	[4245] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "世道纷乱，连我山门也不能幸免。身为本门弟子，更应以捍卫门派安危为己任。据弟子来报，<mapID,x,y>附近出现了一些<npcID>，我希望你解决它们！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
    [4246] =             ------------------云霄宫捣乱小妖（20-30级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26001,
		soundID = nil,
		txt = "嘿嘿嘿，有不知死活的凡人送命来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4101,mapID = 5}},
				},
			}
		},
	},
    [4247] =             ------------------云霄宫狡猾盗贼（30-40级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26003,
		soundID = nil,
		txt = "可恶！居然被你发现我的踪迹，那就不能留你活口了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4102,mapID = 5}},
				},
			}
		},
	},
    [4248] =             ------------------云霄宫作歹流氓（40-50级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26005,
		soundID = nil,
		txt = "早听闻仙门弟子个个道法非凡，我就要试试这所谓的道法有何威力？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4103,mapID = 5}},
				},
			}
		},
	},
    [4249] =             ------------------云霄宫恶毒山贼（50-60级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26007,
		soundID = nil,
		txt = "仙门宝地，有能者居之，你们是时候要让出来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4104,mapID = 5}},
				},
			}
		},
	},
	[4250] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "世道纷乱，连我山门也不能幸免。身为本门弟子，更应以捍卫门派安危为己任。据弟子来报，<mapID,x,y>附近出现了一些<npcID>，我希望你解决它们！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
    [4251] =             ------------------桃源洞捣乱小妖（20-30级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26001,
		soundID = nil,
		txt = "嘿嘿嘿，有不知死活的凡人送命来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4101,mapID = 4}},
				},
			}
		},
	},
    [4252] =             ------------------桃源洞狡猾盗贼（30-40级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26003,
		soundID = nil,
		txt = "可恶！居然被你发现我的踪迹，那就不能留你活口了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4102,mapID = 4}},
				},
			}
		},
	},
    [4253] =             ------------------桃源洞作歹流氓（40-50级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26005,
		soundID = nil,
		txt = "早听闻仙门弟子个个道法非凡，我就要试试这所谓的道法有何威力？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4103,mapID = 4}},
				},
			}
		},
	},
    [4254] =             ------------------桃源洞恶毒山贼（50-60级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26007,
		soundID = nil,
		txt = "仙门宝地，有能者居之，你们是时候要让出来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4104,mapID = 4}},
				},
			}
		},
	},
	[4255] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "世道纷乱，连我山门也不能幸免。身为本门弟子，更应以捍卫门派安危为己任。据弟子来报，<mapID,x,y>附近出现了一些<npcID>，我希望你解决它们！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
    [4256] =             ------------------蓬莱阁捣乱小妖（20-30级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26001,
		soundID = nil,
		txt = "嘿嘿嘿，有不知死活的凡人送命来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4101,mapID = 2}},
				},
			}
		},
	},
    [4257] =             ------------------蓬莱阁狡猾盗贼（30-40级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26003,
		soundID = nil,
		txt = "可恶！居然被你发现我的踪迹，那就不能留你活口了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4102,mapID = 2}},
				},
			}
		},
	},
    [4258] =             ------------------蓬莱阁作歹流氓（40-50级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26005,
		soundID = nil,
		txt = "早听闻仙门弟子个个道法非凡，我就要试试这所谓的道法有何威力？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4103,mapID = 2}},
				},
			}
		},
	},
    [4259] =             ------------------蓬莱阁恶毒山贼（50-60级）
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26007,
		soundID = nil,
		txt = "仙门宝地，有能者居之，你们是时候要让出来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 4104,mapID = 2}},
				},
			}
		},
	},
    [4260] =             ------------------乞丐事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26014,
		soundID = nil,
		txt = "这位英雄，行行好！给我2000绑银吃饭吧！",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "救人一命胜造七级浮屠（支付绑银2000）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4261}},		
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "哼！你这是在敲诈！（进入战斗）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4262}},
				},
			}
		},
	},
	[4261] =            ------------------乞丐道谢
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.Currency, param = {type = "submoney",value =2000, errorID = 32}},
		},
		speakerID = 26014,
		soundID = nil,
		txt = "英雄真是好心人，感激不尽啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                 {
		                 {action = DialogActionType.CostMoney, param = {money = 2000, scriptID = 4141}},
			         },	
		    },
		},		
	},
	[4262] =            ------------------乞丐战斗对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26018,
		soundID = nil,
		txt = "我千辛万苦作了伪装没想到还是被你识破，今天你别想活着回去了！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                 {
		                 {action = DialogActionType.Fight, param = {scriptID = 4141}},
			         },	
		    },
		},		
	},
	
------------------------明雷挑战------------------------------
	[4270] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "本门<npcID>武艺高强。你修为如今尚浅，为师希望你能前往与其切磋，学习战斗经验，以便更快进步！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4271] =            ------------------乾元岛大弟子（30-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20021,
		txt = "既然你想要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4105,mapID = 1}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4272] =            ------------------乾元岛执法长老（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29066,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4111,mapID = 1}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4273] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "本门<npcID>武艺高强。你修为如今尚浅，为师希望你能前往与其切磋，学习战斗经验，以便更快进步！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4274] =            ------------------金霞山大弟子（30-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20023,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4107,mapID = 3}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4275] =            ------------------金霞山执法长老（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29068,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4113,mapID = 3}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4276] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "本门<npcID>武艺高强。你修为如今尚浅，为师希望你能前往与其切磋，学习战斗经验，以便更快进步！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4277] =            ------------------紫阳门大弟子（30-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20026,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4109,mapID = 6}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4278] =            ------------------紫阳门执法长老（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29070,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4115,mapID = 6}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4279] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "本门<npcID>武艺高强。你修为如今尚浅，为师希望你能前往与其切磋，学习战斗经验，以便更快进步！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4280] =            ------------------云霄宫大弟子（30-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20024,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4110,mapID = 5}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4281] =            ------------------云霄宫执法长老（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29071,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4116,mapID = 5}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4282] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "本门<npcID>武艺高强。你修为如今尚浅，为师希望你能前往与其切磋，学习战斗经验，以便更快进步！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4283] =            ------------------桃源洞大弟子（30-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20025,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4106,mapID = 4}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4284] =            ------------------桃源洞执法长老（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29067,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4112,mapID = 4}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4285] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "本门<npcID>武艺高强。你修为如今尚浅，为师希望你能前往与其切磋，学习战斗经验，以便更快进步！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4286] =            ------------------蓬莱阁大弟子（30-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20022,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4108,mapID = 2}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4287] =            ------------------蓬莱阁执法长老（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29069,
		txt = "既然你要同我切磋，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4114,mapID = 2}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
------------------------悬赏任务------------------------------
	[4301] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "有弟子来报，<mapID,x,y>附近有<npcID>出没，我希望你能去一趟，铲除它们，为民除害！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
						{action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4302] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "有弟子来报，<mapID,x,y>附近有<npcID>出没，我希望你能去一趟，铲除它们，为民除害！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4303] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "有弟子来报，<mapID,x,y>附近有<npcID>出没，我希望你能去一趟，铲除它们，为民除害！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4304] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "有弟子来报，<mapID,x,y>附近有<npcID>出没，我希望你能去一趟，铲除它们，为民除害！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4305] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "有弟子来报，<mapID,x,y>附近有<npcID>出没，我希望你能去一趟，铲除它们，为民除害！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4306] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "有弟子来报，<mapID,x,y>附近有<npcID>出没，我希望你能去一趟，铲除它们，为民除害！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4307] =            ------------------截教奸细（35-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26009,
		txt = "你是阐教弟子？来一个，我杀一个！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "今天你死到临头了！（进入战斗）",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4117,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我准备完毕再回来找你！",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4308] =            ------------------门派叛徒（35-45级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26012,
		txt = "吾偶得秘籍，练成一身神功，如今神功初成，这天下还有谁能挡我！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "今天你死到临头了！（进入战斗）",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4118,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我准备完毕再回来找你！",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[4309] =            ------------------入侵刺客（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26011,
		txt = "在我的地盘，即便是龙也得给我盘着，没人可以拂逆我！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "今天你死到临头了！（进入战斗）",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4119,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我准备完毕再回来找你！",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[4310] =            ------------------偷天大盗（45-60级）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26010,
		txt = "既然被你发现我的藏身处，那就别想活着回去了！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "今天你死到临头了！（进入战斗）",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4120,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我准备完毕再回来找你！",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
------------------------对话任务------------------------------
	[4350] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "为师前些日子托付了一些事情给<npcID>，他目前在<mapID,x,y>，你替我前去询问进度如何？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}
					  },	
		    },
			},
		},
	},
	[4351] =            ------------------乾元岛洛阳庄启年对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29005,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4357}},	
		              },	
		    },
		},
	},		
	[4352] =            ------------------乾元岛洛阳张道长对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4357}},	
		              },	
		    },
		},
	},
	[4353] =            ------------------乾元岛桃园镇刘元起对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20027,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4357}},	
		              },	
		    },
		},
	},
	[4354] =            ------------------乾元岛洛阳周霍兴对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29001,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4357}},	
		              },	
		    },
		},
	},
	[4355] =            ------------------乾元岛洛阳无名老人对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20928,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4357}},	
		              },	
		    },
		},
	},
	[4356] =            ------------------乾元岛桃园镇包打听对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29012,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4357}},	
		              },	
		    },
		},
	},
	[4357] =            ------------------乾元岛玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "多谢相告，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
						{action = DialogActionType.FinishLoopTask, param = {taskID = 10001}},
					  },	
		    },	
		    },
		},			
	[4358] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "为师前些日子托付了一些事情给<npcID>，他目前人在<mapID,x,y>，你替我前去询问进度如何？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
		              },
			},
		},		
	},
	[4359] =            ------------------金霞山洛阳庄启年对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29005,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4365}},	
		              },
			},
		},		
	},
	[4360] =            ------------------金霞山洛阳张道长对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4365}},	
		              },
			},
		},
	},
	[4361] =            ------------------金霞山桃园镇刘元起对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20027,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4365}},	
		              },
			},
		},
	},
	[4362] =            ------------------金霞山洛阳周霍兴对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29001,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4365}},	
		              },
			},
		},
	},
	[4363] =            ------------------金霞山洛阳无名老人对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20928,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4365}},	
		              },
			},
		},
	},
	[4364] =            ------------------金霞山桃园镇包打听对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29012,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4365}},	
		              },
			},
		},
	},
	[4365] =            ------------------金霞山玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "多谢相告，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.FinishLoopTask, param = {taskID = 10002}},
		              },
			},
		},		
	},
	[4366] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "为师前些日子托付了一些事情给<npcID>，他目前人在<mapID,x,y>，你替我前去询问进度如何？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},
	},		
	[4367] =            ------------------紫阳门洛阳庄启年对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29005,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4373}},	
					  },	
		    },
		},		
	},
	[4368] =            ------------------紫阳门洛阳张道长对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4373}},	
					  },	
		    },
		},		
	},
	[4369] =            ------------------紫阳门桃园镇刘元起对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20027,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4373}},	
					  },	
		    },
		},	
	},
	[4370] =            ------------------紫阳门洛阳周霍兴对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29001,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4373}},	
					  },	
		    },
		},	
	},
	[4371] =            ------------------紫阳门洛阳无名老人对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20928,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4373}},	
					  },	
		    },
		},	
	},
	[4372] =            ------------------紫阳门桃园镇包打听对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29012,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4373}},	
					  },	
		    },
		},	
	},
	[4373] =            ------------------紫阳门玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "多谢相告，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.FinishLoopTask, param = {taskID = 10003}},
			      },	
		    },
		},			
	},
	[4374] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "为师前些日子托付了一些事情给<npcID>，他目前人在<mapID,x,y>，你替我前去询问进度如何？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4375] =            -------------------云霄宫洛阳庄启年对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29005,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4381}},		
					  },	
		    },
		},		
	},
	[4376] =            -------------------云霄宫洛阳张道长对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4381}},		
					  },	
		    },
		},		
	},
	[4377] =            -------------------云霄宫桃园镇刘元起对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20027,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4381}},		
					  },	
		    },
		},
	},
	[4378] =            -------------------云霄宫洛阳周霍兴对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29001,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4381}},		
					  },	
		    },
		},
	},
	[4379] =            -------------------云霄宫洛阳无名老人对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20928,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4381}},		
					  },	
		    },
		},
	},
	[4380] =            -------------------云霄宫桃园镇包打听对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29012,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4381}},		
					  },	
		    },
		},
	},
	[4381] =            -------------------云霄宫玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "多谢相告，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
                              {action = DialogActionType.FinishLoopTask, param = {taskID = 10004}},
			      },	
		    },
		},		
	},
	[4382] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "为师前些日子托付了一些事情给<npcID>，他目前人在<mapID,x,y>，你替我前去询问进度如何？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},
					  },	
		    },
		},		
	},
	[4383] =            -------------------桃源洞洛阳庄启年对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29005,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4389}},
					  },	
		    },
		},		
	},
	[4384] =            -------------------桃源洞洛阳张道长对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4389}},
					  },	
		    },
		},
	},
	[4385] =            -------------------桃源洞桃园镇刘元起对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20027,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4389}},
					  },	
		    },
		},
	},
	[4386] =            -------------------桃源洞洛阳周霍兴对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29001,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4389}},
					  },	
		    },
		},
	},
	[4387] =            -------------------桃源洞洛阳无名老人对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20928,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4389}},
					  },	
		    },
		},
	},
	[4388] =            -------------------桃源洞桃园镇包打听对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29012,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4389}},
					  },	
		    },
		},
	},
	[4389] =            -------------------桃源洞玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "多谢相告，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
                              {action = DialogActionType.FinishLoopTask, param = {taskID = 10005}},
			      },	
		    },
		},		
	},
	[4390] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "为师前些日子托付了一些事情给<npcID>，他目前人在<mapID,x,y>，你替我前去询问进度如何？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},
					  },	
		    },
		},		
	},
	[4391] =            -------------------蓬莱阁洛阳庄启年对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29005,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4397}},
					  },	
		    },
		},		
	},
	[4392] =            -------------------蓬莱阁洛阳张道长对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29008,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4397}},
					  },	
		    },
		},
	},
	[4393] =            -------------------蓬莱阁桃园镇刘元起对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20027,
		soundID = nil,
		txt = "你师尊所交待之事已经完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4397}},
					  },	
		    },
		},
	},
	[4394] =            -------------------蓬莱阁洛阳周霍兴对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29001,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4397}},
					  },	
		    },
		},
	},
	[4395] =            -------------------蓬莱阁洛阳无名老人对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20928,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4397}},
					  },	
		    },
		},
	},
	[4396] =            -------------------蓬莱阁桃园镇包打听对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29012,
		soundID = nil,
		txt = "你师尊所交待之事还需要些时日才能完成，请代我转告你师尊。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.Goto, param = {dialogID = 4397}},
					  },	
		    },
		},
	},
	[4397] =            -------------------蓬莱阁玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "多谢相告，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
			      {action = DialogActionType.FinishLoopTask, param = {taskID = 10006}},
			      },	
		    },
		},		
	},
------------------------送信任务------------------------------
	[4450] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "为师这里有一封重要的信，需要你辛苦一趟替我交给<mapID,x,y>的<npcID>，不得有误！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4451] =            ------------------乾元岛洛阳卢植送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20049,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		              {
		              {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10001, itemID = 1041016, itemsInfo ={count = 1},},},	
			      },	
		        },
		},		
	},
	[4452] =            ------------------乾元岛长安杨文辉送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 27075,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4453] =            ------------------乾元岛洛阳钱喜满送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20017,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		        actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4454] =            ------------------乾元岛洛阳谢丞涛送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29079,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
			      },	
		    },
		},		
	},
	[4455] =            ------------------乾元岛长安面点点送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29036,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4456] =            ------------------乾元岛长安陆小六送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29034,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4457] =            ------------------乾元岛洛阳皇莆嵩送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20059,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4458] =            ------------------乾元岛长安王允送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20701,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4459] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "为师这里有一封重要的信，需要你辛苦一趟替我交给<mapID,x,y>的<npcID>，不得有误！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4460] =            ------------------金霞山洛阳卢植送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20049,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4461] =            ------------------金霞山长安杨文辉送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 27075,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4462] =            ------------------金霞山洛阳钱喜满送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20017,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4463] =            ------------------金霞山洛阳谢丞涛送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29079,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4464] =            ------------------金霞山长安面点点送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29036,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4465] =            ------------------金霞山长安陆小六送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29034,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4466] =            ------------------金霞山洛阳皇莆嵩送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20059,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4467] =            ------------------金霞山长安王允送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20701,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10002, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4468] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "为师这里有一封重要的信，需要你辛苦一趟替我交给<mapID,x,y>的<npcID>，不得有误！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4469] =            ------------------紫阳门洛阳卢植送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20049,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4470] =            ------------------紫阳门长安杨文辉送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 27075,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4471] =            ------------------紫阳门洛阳钱喜满送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20017,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4472] =            ------------------紫阳门洛阳谢丞涛送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29079,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4473] =            ------------------紫阳门长安面点点送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29036,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4474] =            ------------------紫阳门长安陆小六送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29034,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4475] =            ------------------紫阳门洛阳皇莆嵩送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20059,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4476] =            ------------------紫阳门长安王允送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20701,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10003, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4477] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "为师这里有一封重要的信，需要你辛苦一趟替我交给<mapID,x,y>的<npcID>，不得有误！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4478] =            ------------------云霄宫洛阳卢植送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20049,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4479] =            ------------------云霄宫长安杨文辉送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 27075,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4480] =            ------------------云霄宫洛阳钱喜满送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20017,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4481] =            ------------------云霄宫洛阳谢丞涛送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29079,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4482] =            ------------------云霄宫长安面点点送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29036,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4483] =            ------------------云霄宫长安陆小六送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29034,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4484] =            ------------------云霄宫洛阳皇莆嵩送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20059,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4485] =            ------------------云霄宫长安王允送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20701,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10004, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4486] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "为师这里有一封重要的信，需要你辛苦一趟替我交给<mapID,x,y>的<npcID>，不得有误！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4487] =            ------------------桃源洞洛阳卢植送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20049,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4488] =            ------------------桃源洞长安杨文辉送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 27075,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4489] =            ------------------桃源洞洛阳钱喜满送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20017,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4490] =            ------------------桃源洞洛阳谢丞涛送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29079,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4491] =            ------------------桃源洞长安面点点送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29036,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4492] =            ------------------桃源洞长安陆小六送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29034,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4493] =            ------------------桃源洞洛阳皇莆嵩送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20059,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4494] =            ------------------桃源洞长安王允送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20701,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10005, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4495] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "为师这里有一封重要的信，需要你辛苦一趟替我交给<mapID,x,y>的<npcID>，不得有误！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4496] =            ------------------蓬莱阁洛阳卢植送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20049,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4497] =            ------------------蓬莱阁长安杨文辉送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 27075,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4498] =            ------------------蓬莱阁洛阳钱喜满送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20017,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4499] =            ------------------蓬莱阁洛阳谢丞涛送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29079,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4500] =            ------------------蓬莱阁长安面点点送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29036,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4501] =            ------------------蓬莱阁长安陆小六送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 29034,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4502] =            ------------------蓬莱阁洛阳皇莆嵩送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20059,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},
	[4503] =            ------------------蓬莱阁长安王允送信任务
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20701,
		soundID = nil,
		txt = "你将那封信带过来了？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10006, itemsInfo ={{count = 1}}}},	
					  },	
		    },
		},		
	},

------------------------抓宠任务------------------------------

	[4550] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "这门派越来越壮大，弟子也越招越多了。本门乃修炼圣地，你且辛苦一趟去<mapID,x,y>附近抓一只<petID>回来供师弟师妹修炼吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4551] =           ---------------------乾元岛上交宠物
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "这么快就回来啦！你找到我需要的宠物了吗？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
				{action = DialogActionType.PaidPet, param = {taskID = 10001}},		
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},			
		},
	},
	[4552] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "这门派越来越壮大，弟子也越招越多了。本门乃修炼圣地，你且辛苦一趟去<mapID,x,y>附近抓一只<petID>回来供师弟师妹修炼吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4553] =             ---------------------金霞山上交宠物
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "这么快就回来啦！你找到我需要的宠物了吗？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
				{action = DialogActionType.PaidPet, param = {taskID = 10002}},		
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},			
		},
	},
	[4554] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "这门派越来越壮大，弟子也越招越多了。本门乃修炼圣地，你且辛苦一趟去<mapID,x,y>附近抓一只<petID>回来供师弟师妹修炼吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4555] =              ---------------------紫阳门上交宠物
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "这么快就回来啦！你找到我需要的宠物了吗？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
				{action = DialogActionType.PaidPet, param = {taskID = 10003}},		
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},			
		},
	},
	[4556] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "这门派越来越壮大，弟子也越招越多了。本门乃修炼圣地，你且辛苦一趟去<mapID,x,y>附近抓一只<petID>回来供师弟师妹修炼吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4557] =                 ---------------------云霄宫上交宠物
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "这么快就回来啦！你找到我需要的宠物了吗？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
				{action = DialogActionType.PaidPet, param = {taskID = 10004}},	
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},			
		},
	},
	[4558] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "这门派越来越壮大，弟子也越招越多了。本门乃修炼圣地，你且辛苦一趟去<mapID,x,y>附近抓一只<petID>回来供师弟师妹修炼吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4559] =                  ---------------------桃源洞上交宠物
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "这么快就回来啦！你找到我需要的宠物了吗？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
				{action = DialogActionType.PaidPet, param = {taskID = 10005}},		
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},			
		},
	},
	[4560] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "这门派越来越壮大，弟子也越招越多了。本门乃修炼圣地，你且辛苦一趟去<mapID,x,y>附近抓一只<petID>回来供师弟师妹修炼吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4561] =                ---------------------蓬莱阁上交宠物
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "这么快就回来啦！你找到我需要的宠物了吗？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
				{action = DialogActionType.PaidPet, param = {taskID = 10006}},	
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},			
		},
	},
------------------------上交道具------------------------------
 	[4600] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "随着门下弟子越来越多，<itemID>的储备也不足了，你辛苦一趟帮我搜集1个<itemID>，拿回来交给我吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},		
	},	
	[4601] =            ------------------乾元岛上交道具
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20004,
		txt = "这么快就回来啦？找到我需要的丹药了吗？",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "上交道具",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10001, itemsInfo = {count = 1},},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
 	[4602] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "随着门下弟子越来越多，<itemID>的储备也不足了，你辛苦一趟帮我搜集1个<itemID>，拿回来交给我吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
 	[4603] =            ------------------金霞山上交道具
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20006,
		txt = "这么快就回来啦？找到我需要的丹药了吗？",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "上交道具",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10002, itemsInfo = {count = 1},},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
 	[4604] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "随着门下弟子越来越多，<itemID>的储备也不足了，你辛苦一趟帮我搜集1个<itemID>，拿回来交给我吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
 	[4605] =            ------------------紫阳门上交道具
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20008,
		txt = "这么快就回来啦？找到我需要的丹药了吗？",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "上交道具",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10003, itemsInfo = {count = 1},},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
 	[4606] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "随着门下弟子越来越多，<itemID>的储备也不足了，你辛苦一趟帮我搜集1个<itemID>，拿回来交给我吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
 	[4607] =            ------------------云霄宫上交道具
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20009,
		txt = "这么快就回来啦？找到我需要的丹药了吗？",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "上交道具",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10004, itemsInfo = {count = 1},},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
 	[4608] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "随着门下弟子越来越多，<itemID>的储备也不足了，你辛苦一趟帮我搜集1个<itemID>，拿回来交给我吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
 	[4609] =            ------------------桃源洞上交道具
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20005,
		txt = "这么快就回来啦？找到我需要的丹药了吗？",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "上交道具",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10005, itemsInfo = {count = 1},},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
 	[4610] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "随着门下弟子越来越多，<itemID>的储备也不足了，你辛苦一趟帮我搜集1个<itemID>，拿回来交给我吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
 	[4611] =            ------------------蓬莱阁上交道具
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20007,
		txt = "这么快就回来啦？找到我需要的丹药了吗？",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "上交道具",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10006, itemsInfo = {count = 1},},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},

------------------------上交装备------------------------------

----------------------------捐款------------------------------
	[4701] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "作为本门弟子，应以扶贫济弱为己任！据闻江湖上人称“乐善施”的<npcID>现在人在<mapID,x,y>，你去看看有什么能够帮得上忙的吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4702] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29079,
		
		txt = "千金散尽还复来，你有这种觉悟真是令人欣慰啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10001}},
				},
			}
		},
	},
	[4703] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "作为本门弟子，应以扶贫济弱为己任！据闻江湖上人称“乐善施”的<npcID>现在人在<mapID,x,y>，你去看看有什么能够帮得上忙的吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4704] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29079,
		
		txt = "千金散尽还复来，你有这种觉悟真是令人欣慰啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10002}},
				},
			}
		},
	},
	[4705] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "作为本门弟子，应以扶贫济弱为己任！据闻江湖上人称“乐善施”的<npcID>现在人在<mapID,x,y>，你去看看有什么能够帮得上忙的吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4706] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29079,
		
		txt = "千金散尽还复来，你有这种觉悟真是令人欣慰啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10003}},
				},
			}
		},
	},
	[4707] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "作为本门弟子，应以扶贫济弱为己任！据闻江湖上人称“乐善施”的<npcID>现在人在<mapID,x,y>，你去看看有什么能够帮得上忙的吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4708] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29079,
		
		txt = "千金散尽还复来，你有这种觉悟真是令人欣慰啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10004}},
				},
			}
		},
	},
	[4709] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "作为本门弟子，应以扶贫济弱为己任！据闻江湖上人称“乐善施”的<npcID>现在人在<mapID,x,y>，你去看看有什么能够帮得上忙的吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4710] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29079,
		
		txt = "千金散尽还复来，你有这种觉悟真是令人欣慰啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10005}},
				},
			}
		},
	},
	[4711] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "作为本门弟子，应以扶贫济弱为己任！据闻江湖上人称“乐善施”的<npcID>现在人在<mapID,x,y>，你去看看有什么能够帮得上忙的吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4712] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29079,
		
		txt = "千金散尽还复来，你有这种觉悟真是令人欣慰啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10006}},
				},
			}
		},
	},
----------------------------巡逻触发事件------------------------------
	[4751] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "世道纷乱，身为本门弟子，应不懈余力守卫师门！据弟子来报，<mapID,x,y>附近有外来人士出没，你且前往查看一番！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4752] =            ------------------乾元岛玩家任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "诶？那边好像有个奇怪的人，过去看看！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		             {action = DialogActionType.Goto, param = {dialogID = 4753}},	
					  },	
		    },
		},		
	},
	[4753] =            ------------------乾元岛神秘人事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "“英雄者,胸怀大志,腹有良谋”最近真是越来越觉得这句话有道理了！这位仙友，你觉得志向还是谋略重要呢？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "当然是志向啦！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10001},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "肯定是谋略啊！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10001},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[4754] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "世道纷乱，身为本门弟子，应不懈余力守卫师门！据弟子来报，<mapID,x,y>附近有外来人士出没，你且前往查看一番！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4755] =            ------------------金霞山玩家任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "诶？那边好像有个奇怪的人，过去看看！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		             {action = DialogActionType.Goto, param = {dialogID = 4756}},	
					  },	
		    },
		},		
	},
	[4756] =            ------------------金霞山神秘人事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "“英雄者,胸怀大志,腹有良谋”最近真是越来越觉得这句话有道理了！这位仙友，你觉得志向还是谋略重要呢？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "当然是志向啦！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10002},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "肯定是谋略啊！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10002},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[4757] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "世道纷乱，身为本门弟子，应不懈余力守卫师门！据弟子来报，<mapID,x,y>附近有外来人士出没，你且前往查看一番！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4758] =            ------------------紫阳门玩家任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "诶？那边好像有个奇怪的人，过去看看！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		             {action = DialogActionType.Goto, param = {dialogID = 4759}},	
					  },	
		    },
		},		
	},
	[4759] =            ------------------紫阳门神秘人事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "“英雄者,胸怀大志,腹有良谋”最近真是越来越觉得这句话有道理了！这位仙友，你觉得志向还是谋略重要呢？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "当然是志向啦！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10003},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "肯定是谋略啊！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10003},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[4760] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "世道纷乱，身为本门弟子，应不懈余力守卫师门！据弟子来报，<mapID,x,y>附近有外来人士出没，你且前往查看一番！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4761] =            ------------------云霄洞玩家任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "诶？那边好像有个奇怪的人，过去看看！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		             {action = DialogActionType.Goto, param = {dialogID = 4762}},	
					  },	
		    },
		},		
	},
	[4762] =            ------------------云霄宫神秘人事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "“英雄者,胸怀大志,腹有良谋”最近真是越来越觉得这句话有道理了！这位仙友，你觉得志向还是谋略重要呢？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "当然是志向啦！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10004},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "肯定是谋略啊！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10004},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[4763] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "世道纷乱，身为本门弟子，应不懈余力守卫师门！据弟子来报，<mapID,x,y>附近有外来人士出没，你且前往查看一番！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4764] =            ------------------桃源洞玩家任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "诶？那边好像有个奇怪的人，过去看看！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		             {action = DialogActionType.Goto, param = {dialogID = 4765}},	
					  },	
		    },
		},		
	},
	[4765] =            ------------------桃源洞神秘人事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "“英雄者,胸怀大志,腹有良谋”最近真是越来越觉得这句话有道理了！这位仙友，你觉得是志向还是谋略重要呢？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "当然是志向啦！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10005},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "肯定是谋略啊！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10005},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[4766] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "世道纷乱，身为本门弟子，应不懈余力守卫师门！据弟子来报，<mapID,x,y>附近有外来人士出没，你且前往查看一番！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.CloseDialog, param ={}},	
					  },	
		    },
		},		
	},
	[4767] =            ------------------蓬莱阁玩家任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "诶？那边好像有个奇怪的人，过去看看！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		             {action = DialogActionType.Goto, param = {dialogID = 4768}},	
					  },	
		    },
		},		
	},
	[4768] =            ------------------蓬莱阁神秘人事件
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "“英雄者,胸怀大志,腹有良谋”最近真是越来越觉得这句话有道理了！这位仙友，你觉得是志向还是谋略重要呢？",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "当然是志向啦！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10006},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "肯定是谋略啊！",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10006},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[4769] =            ------------------神秘人明雷战斗指引
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 26015,
		soundID = nil,
		txt = "哈哈哈~说得很有道理的样子啊！如今我有一<npcID>远在<mapID,x,y>,只要你能替我教训他，我就承认你配得上英雄的名号！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions ={},
			}
		},
	},
	[4770] =            ------------------仇敌
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26028,
		txt = "你是何人？我与你素不相识，你为何对我苦苦相逼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4771}},
				},
			}
		},
	},
	[4771] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		txt = "哈哈哈~不管怎么样，为了证明我的确是个英雄，我可是千里迢迢来到这里！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4772}},
				},
			},
		},
	},
	[4772] =            ------------------仇敌
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26028,
		txt = "......既然如此，那就来吧！赢了我你就是英雄！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4142,mapID = nil}},
				},
			}
		},
	},
	[4773] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "据闻云游四方的<npcID>又发明了新的菜谱，俗话说“唯师门任务与美食不可辜负”。你每天为师门出力想必也是很辛苦，这次就破例给你放个假，你下山去尝尝<npcID>的新菜谱，再回来告诉我感受吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},
		
	},
	[4774] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "据闻云游四方的<npcID>又发明了新的菜谱，俗话说“唯师门任务与美食不可辜负”。你每天为师门出力想必也是很辛苦，这次就破例给你放个假，你下山去尝尝<npcID>的新菜谱，再回来告诉我感受吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},
		
	},
	[4775] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "据闻云游四方的<npcID>又发明了新的菜谱，俗话说“唯师门任务与美食不可辜负”。你每天为师门出力想必也是很辛苦，这次就破例给你放个假，你下山去尝尝<npcID>的新菜谱，再回来告诉我感受吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},
		
	},
	[4776] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "据闻云游四方的<npcID>又发明了新的菜谱，俗话说“唯师门任务与美食不可辜负”。你每天为师门出力想必也是很辛苦，这次就破例给你放个假，你下山去尝尝<npcID>的新菜谱，再回来告诉我感受吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},
		
	},
	[4777] =            ------------------桃源洞掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "据闻云游四方的<npcID>又发明了新的菜谱，俗话说“唯师门任务与美食不可辜负”。你每天为师门出力想必也是很辛苦，这次就破例给你放个假，你下山去尝尝<npcID>的新菜谱，再回来告诉我感受吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},
		
	},
	[4778] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "据闻云游四方的<npcID>又发明了新的菜谱，俗话说“唯师门任务与美食不可辜负”。你每天为师门出力想必也是很辛苦，这次就破例给你放个假，你下山去尝尝<npcID>的新菜谱，再回来告诉我感受吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},		
	},
	[4780] =            ------------------玩家评价
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "嗯嗯嗯~滑而不腻 香辣爽口，真乃人间极品啊！不愧是当代厨神呢！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},	
			          },	
		    },
		},		
	},
	[4781] =            ------------------乾元岛掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20004,
		soundID = nil,
		txt = "徒儿，今天下山之行感受如何呀？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4782}},
			          },	
		    },
		},		
	},
	[4782] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "下山一行着实让弟子长了见识，多谢掌门恩典，弟子告退！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10001}},
			          },	
		    },
		},		
	},
	[4783] =            ------------------金霞山掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20006,
		soundID = nil,
		txt = "徒儿，今天下山之行感受如何呀？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4784}},
			          },	
		    },
		},		
	},
	[4784] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "下山一行着实让弟子长了见识，多谢掌门恩典，弟子告退！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10002}},
			          },	
		    },
		},		
	},
	[4785] =            ------------------紫阳门掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20008,
		soundID = nil,
		txt = "徒儿，今天下山之行感受如何呀？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4786}},
			          },	
		    },
		},		
	},
	[4786] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "下山一行着实让弟子长了见识，多谢掌门恩典，弟子告退！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10003}},
			          },	
		    },
		},		
	},
	[4787] =            ------------------云霄宫掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20009,
		soundID = nil,
		txt = "徒儿，今天下山之行感受如何呀？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4788}},
			          },	
		    },
		},		
	},
	[4788] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "下山一行着实让弟子长了见识，多谢掌门恩典，弟子告退！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10004}},
			          },	
		    },
		},		
	},
	[4789] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20005,
		soundID = nil,
		txt = "徒儿，今天下山之行感受如何呀？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4790}},
			          },	
		    },
		},		
	},
	[4790] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "下山一行着实让弟子长了见识，多谢掌门恩典，弟子告退！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10005}},
			          },	
		    },
		},		
	},
	[4791] =            ------------------蓬莱阁掌门任务指引
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 20007,
		soundID = nil,
		txt = "徒儿，今天下山之行感受如何呀？",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4792}},
			          },	
		    },
		},		
	},
	[4792] =            ------------------玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "下山一行着实让弟子长了见识，多谢掌门恩典，弟子告退！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10006}},
			          },	
		    },
		},		
	},
	[4793] =            ------------------乾元岛太极护国羹介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜，使用菌菇、鲜豆腐、南瓜叶等精心炮制而成，以鲜香、造型独特流传于世。因其外形酷似太极八卦，我将其命名为“太极护国羹”！ 这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062213, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4794] =            ------------------金霞山太极护国羹介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜，使用菌菇、鲜豆腐、南瓜叶等精心炮制而成，以鲜香、造型独特流传于世。因其外形酷似太极八卦，我将其命名为“太极护国羹”！ 这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062214, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4795] =            ------------------紫阳门太极护国羹介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜，使用菌菇、鲜豆腐、南瓜叶等精心炮制而成，以鲜香、造型独特流传于世。因其外形酷似太极八卦，我将其命名为“太极护国羹”！ 这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062215, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4796] =            ------------------云霄宫太极护国羹介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜，使用菌菇、鲜豆腐、南瓜叶等精心炮制而成，以鲜香、造型独特流传于世。因其外形酷似太极八卦，我将其命名为“太极护国羹”！ 这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062216, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4797] =            ------------------桃源洞太极护国羹介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜，使用菌菇、鲜豆腐、南瓜叶等精心炮制而成，以鲜香、造型独特流传于世。因其外形酷似太极八卦，我将其命名为“太极护国羹”！ 这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062217, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4798] =            ------------------蓬莱阁太极护国羹介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜，使用菌菇、鲜豆腐、南瓜叶等精心炮制而成，以鲜香、造型独特流传于世。因其外形酷似太极八卦，我将其命名为“太极护国羹”！ 这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062218, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4799] =            ------------------乾元岛曹操鸡介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜主要原料为母鸡、白酒。成品色泽红润，香气浓郁，皮脆油亮。相传当年，曹将军屯兵庐州，因军政事务繁忙，操劳过度而卧床不起。治疗过程中，本厨神在鸡内添加中药，烹制成药膳鸡。曹将军食后病情果然日趋好转。于是，这道菜本人将其命名为“曹操鸡”。这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062219, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4800] =            ------------------金霞山曹操鸡介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜主要原料为母鸡、白酒。成品色泽红润，香气浓郁，皮脆油亮。相传当年，曹将军屯兵庐州，因军政事务繁忙，操劳过度而卧床不起。治疗过程中，本厨神在鸡内添加中药，烹制成药膳鸡。曹将军食后病情果然日趋好转。于是，这道菜本人将其命名为“曹操鸡”。这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062220, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4801] =            ------------------紫阳门曹操鸡介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜主要原料为母鸡、白酒。成品色泽红润，香气浓郁，皮脆油亮。相传当年，曹将军屯兵庐州，因军政事务繁忙，操劳过度而卧床不起。治疗过程中，本厨神在鸡内添加中药，烹制成药膳鸡。曹将军食后病情果然日趋好转。于是，这道菜本人将其命名为“曹操鸡”。这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062221, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4802] =            ------------------云霄宫曹操鸡介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜主要原料为母鸡、白酒。成品色泽红润，香气浓郁，皮脆油亮。相传当年，曹将军屯兵庐州，因军政事务繁忙，操劳过度而卧床不起。治疗过程中，本厨神在鸡内添加中药，烹制成药膳鸡。曹将军食后病情果然日趋好转。于是，这道菜本人将其命名为“曹操鸡”。这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062222, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4803] =            ------------------桃源洞曹操鸡介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜主要原料为母鸡、白酒。成品色泽红润，香气浓郁，皮脆油亮。相传当年，曹将军屯兵庐州，因军政事务繁忙，操劳过度而卧床不起。治疗过程中，本厨神在鸡内添加中药，烹制成药膳鸡。曹将军食后病情果然日趋好转。于是，这道菜本人将其命名为“曹操鸡”。这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062223, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4804] =            ------------------蓬莱阁曹操鸡介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "这道菜主要原料为母鸡、白酒。成品色泽红润，香气浓郁，皮脆油亮。相传当年，曹将军屯兵庐州，因军政事务繁忙，操劳过度而卧床不起。治疗过程中，本厨神在鸡内添加中药，烹制成药膳鸡。曹将军食后病情果然日趋好转。于是，这道菜本人将其命名为“曹操鸡”。这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062224, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4805] =            ------------------乾元岛剑门豆腐介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "“剑门豆腐”，与坚不可摧的剑门关相齐名。相传当年大将军姜维兵败退到剑门关。当时营中兵疲不能战，马乏不能骑，眼看剑门关危在旦夕。本厨神取来自剑门七十一峰的“剑泉”水，经浸豆、磨浆、滤渣、煮浆、点浆、脱水等工序，精心制作。以豆腐犒赏士兵，以豆渣喂战马，士兵和战马体力迅速得到恢复。三日之后，姜维仅引五千兵将就大败敌人。“剑门豆腐”的美誉也就在此诞生了！这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062225, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4806] =            ------------------金霞山剑门豆腐介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "“剑门豆腐”，与坚不可摧的剑门关相齐名。相传当年大将军姜维兵败退到剑门关。当时营中兵疲不能战，马乏不能骑，眼看剑门关危在旦夕。本厨神取来自剑门七十一峰的“剑泉”水，经浸豆、磨浆、滤渣、煮浆、点浆、脱水等工序，精心制作。以豆腐犒赏士兵，以豆渣喂战马，士兵和战马体力迅速得到恢复。三日之后，姜维仅引五千兵将就大败敌人。“剑门豆腐”的美誉也就在此诞生了！这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062226, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4807] =            ------------------紫阳门剑门豆腐介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "“剑门豆腐”，与坚不可摧的剑门关相齐名。相传当年大将军姜维兵败退到剑门关。当时营中兵疲不能战，马乏不能骑，眼看剑门关危在旦夕。本厨神取来自剑门七十一峰的“剑泉”水，经浸豆、磨浆、滤渣、煮浆、点浆、脱水等工序，精心制作。以豆腐犒赏士兵，以豆渣喂战马，士兵和战马体力迅速得到恢复。三日之后，姜维仅引五千兵将就大败敌人。“剑门豆腐”的美誉也就在此诞生了！这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062227, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4808] =            ------------------云霄宫剑门豆腐介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "“剑门豆腐”，与坚不可摧的剑门关相齐名。相传当年大将军姜维兵败退到剑门关。当时营中兵疲不能战，马乏不能骑，眼看剑门关危在旦夕。本厨神取来自剑门七十一峰的“剑泉”水，经浸豆、磨浆、滤渣、煮浆、点浆、脱水等工序，精心制作。以豆腐犒赏士兵，以豆渣喂战马，士兵和战马体力迅速得到恢复。三日之后，姜维仅引五千兵将就大败敌人。“剑门豆腐”的美誉也就在此诞生了！这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062228, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4809] =            ------------------桃源洞剑门豆腐介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "“剑门豆腐”，与坚不可摧的剑门关相齐名。相传当年大将军姜维兵败退到剑门关。当时营中兵疲不能战，马乏不能骑，眼看剑门关危在旦夕。本厨神取来自剑门七十一峰的“剑泉”水，经浸豆、磨浆、滤渣、煮浆、点浆、脱水等工序，精心制作。以豆腐犒赏士兵，以豆渣喂战马，士兵和战马体力迅速得到恢复。三日之后，姜维仅引五千兵将就大败敌人。“剑门豆腐”的美誉也就在此诞生了！这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062229, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4810] =            ------------------蓬莱阁剑门豆腐介绍
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},
		},
		speakerID = 26029,
		soundID = nil,
		txt = "“剑门豆腐”，与坚不可摧的剑门关相齐名。相传当年大将军姜维兵败退到剑门关。当时营中兵疲不能战，马乏不能骑，眼看剑门关危在旦夕。本厨神取来自剑门七十一峰的“剑泉”水，经浸豆、磨浆、滤渣、煮浆、点浆、脱水等工序，精心制作。以豆腐犒赏士兵，以豆渣喂战马，士兵和战马体力迅速得到恢复。三日之后，姜维仅引五千兵将就大败敌人。“剑门豆腐”的美誉也就在此诞生了！这位小友，快去物品栏中右键右键品尝吧！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.BuyItem, param = {itemID = 1062230, itemNum = 1}},
			          },	
		    },
		},		
	},
	[4811] =            ------------------乾元岛护送事件
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "这位英雄，请留步啊！看你也是面目和善之人，能否帮小女子一个小忙啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4812}},
			          },	
		    },
		},		
	},
	[4812] =            ------------------乾元岛护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘不妨说来听听，看在下能否帮到你！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.AddFollowNpc, param = {taskID = 10001, followNpcID = 26021}},
			          },	
		    },
		},		
	},
	[4813] =            ------------------金霞山护送事件
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "这位英雄，请留步啊！看你也是面目和善之人，能否帮小女子一个小忙啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4814}},
			          },	
		    },
		},		
	},
	[4814] =            ------------------金霞山护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘不妨说来听听，看在下能否帮到你！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.AddFollowNpc, param = {taskID = 10002, followNpcID = 26021}},
			          },	
		    },
		},		
	},
	[4815] =            ------------------紫阳门护送事件
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "这位英雄，请留步啊！看你也是面目和善之人，能否帮小女子一个小忙啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4816}},
			          },	
		    },
		},		
	},
	[4816] =            ------------------紫阳门护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘不妨说来听听，看在下能否帮到你！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.AddFollowNpc, param = {taskID = 10003, followNpcID = 26021}},
			          },	
		    },
		},		
	},
	[4817] =            ------------------云霄宫护送事件
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "这位英雄，请留步啊！看你也是面目和善之人，能否帮小女子一个小忙啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4818}},
			          },	
		    },
		},		
	},
	[4818] =            ------------------云霄宫护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘不妨说来听听，看在下能否帮到你！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                   {action = DialogActionType.AddFollowNpc, param = {taskID = 10004, followNpcID = 26021}},
			          },	
		    },
		},		
	},
	[4819] =            ------------------桃源洞护送事件
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "这位英雄，请留步啊！看你也是面目和善之人，能否帮小女子一个小忙啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4820}},
			          },	
		    },
		},		
	},
	[4820] =            ------------------桃源洞护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘不妨说来听听，看在下能否帮到你！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.AddFollowNpc, param = {taskID = 10005, followNpcID = 26021}},
			          },	
		    },
		},		
	},
	[4821] =            ------------------蓬莱阁护送事件
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "这位英雄，请留步啊！看你也是面目和善之人，能否帮小女子一个小忙啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Goto, param = {dialogID = 4822}},
			          },	
		    },
		},		
	},
	[4822] =            ------------------桃源洞护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘不妨说来听听，看在下能否帮到你！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.AddFollowNpc, param = {taskID = 10006, followNpcID = 26021}},
			          },	
		    },
		},		
	},
	[4823] =            ------------------护送事件迷途少女回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "前几日，吾与旧友<npcID>结伴同游，谁料在途中走散了！如今我俩约好在<mapID,x,y>碰面，奈何小女子人生地不熟，还请英雄能为我带个路啊！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.CloseDialog, param ={}},
			          },	
		    },
		},		
	},
	[4824] =            ------------------护送事件迷途少女回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{},
		speakerID = 26021,
		soundID = nil,
		txt = "感谢英雄带路，到这里就可以了,这就是我要找的人！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.Gotos, param = {dialogIDs = {4825,4826,4827,4828,4829,4830}}},
			          },	
		    },
		},		
	},
	[4825] =            ------------------乾元岛护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		 {condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘保重，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10001}},
			          },	
		    },
		},		
	},
	[4826] =            ------------------金霞山护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘保重，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10002}},
			          },	
		    },
		},		
	},
	[4827] =            ------------------紫阳门护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘保重，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10003}},
			          },	
		    },
		},		
	},
	[4828] =            ------------------护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘保重，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10004}},
			          },	
		    },
		},		
	},
	[4829] =            ------------------护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.TYD}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘保重，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10005}},
			          },	
		    },
		},		
	},
	[4830] =            ------------------护送事件玩家回复
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.School, param = {school = SchoolType.PLG}},
		},
		speakerID = 0,
		soundID = nil,
		txt = "姑娘保重，告辞！",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		         actions =
		                  {
		                  {action = DialogActionType.FinishLoopTask, param = {taskID = 10006}},
			          },	
		    },
		},		
	},
	[4850] =            ------------------乾元岛厨神事件（太极护国羹）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "太极护国羹",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4793}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4851] =            ------------------金霞山厨神事件（太极护国羹）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "太极护国羹",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4794}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4852] =            ------------------紫阳门厨神事件（太极护国羹）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "太极护国羹",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4795}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4853] =            ------------------云霄宫厨神事件（太极护国羹）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "太极护国羹",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4796}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4854] =            ------------------桃源洞厨神事件（太极护国羹）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "太极护国羹",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4797}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4855] =            ------------------蓬莱阁厨神事件（太极护国羹）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "太极护国羹",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4798}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4856] =            ------------------乾元岛厨神事件（曹操鸡）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "曹操鸡",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4799}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4857] =            ------------------金霞山厨神事件（曹操鸡）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "曹操鸡",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4800}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4858] =            ------------------紫阳门厨神事件（曹操鸡）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "曹操鸡",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4801}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4859] =            ------------------云霄宫厨神事件（曹操鸡）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "曹操鸡",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4802}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4860] =            ------------------桃源洞厨神事件（曹操鸡）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "曹操鸡",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4803}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4861] =            ------------------蓬莱阁厨神事件（曹操鸡）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "曹操鸡",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4804}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4862] =            ------------------乾元岛厨神事件（剑门豆腐）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "剑门豆腐",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4805}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4863] =            ------------------金霞山厨神事件（剑门豆腐）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "剑门豆腐",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4806}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4864] =            ------------------紫阳门厨神事件（剑门豆腐）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "剑门豆腐",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4807}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4865] =            ------------------云霄宫厨神事件（剑门豆腐）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "剑门豆腐",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4808}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4866] =            ------------------桃源洞厨神事件（剑门豆腐）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "剑门豆腐",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4809}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
	[4867] =            ------------------蓬莱阁厨神事件（剑门豆腐）
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 26029,
		soundID = nil,
		txt = "知道我是谁吗？我可是传说中的厨神！我一直致力于研究新的菜谱，既然我们有缘在此相见，那就让你帮忙试试口味吧！那么今天的菜谱是......",
		options =
		{
			[1] =
			{
				showConditions = 
				{},
				optionTxt = "剑门豆腐",
				actions =
				{
                                {action = DialogActionType.Goto, param = {dialogID = 4810}},
				},
				icon = DialogIcon.Talk,
			},
		},		
	},
------------------------此地乃试炼任务之地，请不要随意乱闯----------------------------------
---------------------------------暗雷战斗---40-44级----------------------------------
------------------------------------1-50环----------------------------------
    [5001] =             -----------------暗雷战斗-董卓余党
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27001,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5001,mapID = nil}},
				},
			}
		},
	},
	[5002] =             -----------------暗雷战斗-黄巾余党
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27002,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5002,mapID = nil}},
				},
			}
		},
	},
	[5003] =             -----------------暗雷战斗-悍匪
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27003,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5003,mapID = nil}},
				},
			}
		},
	},
	[5004] =             -----------------暗雷战斗-强盗
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27004,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5004,mapID = nil}},
				},
			}
		},
	},
	[5005] =             -----------------暗雷战斗-流氓
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27005,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5005,mapID = nil}},
				},
			}
		},
	},
	[5006] =             -----------------暗雷战斗-贼寇
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27006,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5006,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---40-44级----------------------------------
------------------------------------50-100环----------------------------------
	[5007] =             -----------------暗雷战斗-马匪
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27007,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5007,mapID = nil}},
				},
			}
		},
	},
	[5008] =             -----------------暗雷战斗-玉泉行者
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27008,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5008,mapID = nil}},
				},
			}
		},
	},
	[5009] =             -----------------暗雷战斗-飞贼
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27009,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5009,mapID = nil}},
				},
			}
		},
	},
	[5010] =             -----------------暗雷战斗-董军伍长
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27010,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5010,mapID = nil}},
				},
			}
		},
	},
	[5011] =             -----------------暗雷战斗-黄巾护卫长
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27011,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5011,mapID = nil}},
				},
			}
		},
	},
	[5012] =             -----------------暗雷战斗-荒漠盗匪
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27012,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5012,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---40-44级----------------------------------
------------------------------------100-150环----------------------------------
	[5013] =             -----------------暗雷战斗-倭寇
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27013,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5013,mapID = nil}},
				},
			}
		},
	},
	[5014] =             -----------------暗雷战斗-山贼
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27014,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5014,mapID = nil}},
				},
			}
		},
	},
	[5015] =             -----------------暗雷战斗-水贼
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27015,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5015,mapID = nil}},
				},
			}
		},
	},
	[5016] =             -----------------暗雷战斗-董军军阀
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27016,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5016,mapID = nil}},
				},
			}
		},
	},
	[5017] =             -----------------暗雷战斗-黄巾军阀
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27017,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5017,mapID = nil}},
				},
			}
		},
	},
	[5018] =             -----------------暗雷战斗-黑山军
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27018,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5018,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---40-44级----------------------------------
------------------------------------150-200环----------------------------------
	[5019] =             -----------------暗雷战斗-邪教余党
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27019,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5019,mapID = nil}},
				},
			}
		},
	},
	[5020] =             -----------------暗雷战斗-盟军叛党
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27020,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5020,mapID = nil}},
				},
			}
		},
	},
	[5021] =             -----------------暗雷战斗-邪神教徒
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27021,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5021,mapID = nil}},
				},
			}
		},
	},
	[5022] =             -----------------暗雷战斗-邪恶祭祀
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27022,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5022,mapID = nil}},
				},
			}
		},
	},
	[5023] =             -----------------暗雷战斗-逆道天师
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27023,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5023,mapID = nil}},
				},
			}
		},
	},
	[5024] =             -----------------暗雷战斗-截教叛徒
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27024,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我们不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5024,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---45-49级----------------------------------
------------------------------------1-50环----------------------------------
	[5025] =             -----------------暗雷战斗-胡力
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27025,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5025,mapID = nil}},
				},
			}
		},
	},
	[5026] =             -----------------暗雷战斗-张龙
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27026,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5026,mapID = nil}},
				},
			}
		},
	},
	[5027] =             -----------------暗雷战斗-九龙
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27027,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5027,mapID = nil}},
				},
			}
		},
	},
	[5028] =             -----------------暗雷战斗-王石
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27028,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5028,mapID = nil}},
				},
			}
		},
	},
	[5029] =             -----------------暗雷战斗-风邪
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27029,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5029,mapID = nil}},
				},
			}
		},
	},
	[5030] =             -----------------暗雷战斗-灵姬
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27030,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5030,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---45-49级----------------------------------
------------------------------------50-100环----------------------------------
	[5031] =             -----------------暗雷战斗-赵融
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27031,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5031,mapID = nil}},
				},
			}
		},
	},
	[5032] =             -----------------暗雷战斗-冯芳
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27032,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5032,mapID = nil}},
				},
			}
		},
	},
	[5033] =             -----------------暗雷战斗-程普
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27033,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5033,mapID = nil}},
				},
			}
		},
	},
	[5034] =             -----------------暗雷战斗-甘宁
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27034,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5034,mapID = nil}},
				},
			}
		},
	},
	[5035] =             -----------------暗雷战斗-袁遗
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27035,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5035,mapID = nil}},
				},
			}
		},
	},
	[5036] =             -----------------暗雷战斗-杨奉
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27036,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5036,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---45-49级----------------------------------
------------------------------------100-150环----------------------------------
	[5037] =             -----------------暗雷战斗-黄承乙
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27037,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5037,mapID = nil}},
				},
			}
		},
	},
	[5038] =             -----------------暗雷战斗-李奇
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27038,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5038,mapID = nil}},
				},
			}
		},
	},
	[5039] =             -----------------暗雷战斗-晁雷
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27039,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5039,mapID = nil}},
				},
			}
		},
	},
	[5040] =             -----------------暗雷战斗-晁天
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27040,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5040,mapID = nil}},
				},
			}
		},
	},
	[5041] =             -----------------暗雷战斗-李丙
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27041,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5041,mapID = nil}},
				},
			}
		},
	},
	[5042] =             -----------------暗雷战斗-常昊
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27042,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5042,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---45-49级----------------------------------
------------------------------------150-200环----------------------------------
	[5043] =             -----------------暗雷战斗-杨显
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27043,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5043,mapID = nil}},
				},
			}
		},
	},
	[5044] =             -----------------暗雷战斗-李兴霸
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27044,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5044,mapID = nil}},
				},
			}
		},
	},
	[5045] =             -----------------暗雷战斗-杨修
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27045,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5045,mapID = nil}},
				},
			}
		},
	},
	[5046] =             -----------------暗雷战斗-马方
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27046,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5046,mapID = nil}},
				},
			}
		},
	},
	[5047] =             -----------------暗雷战斗-吴龙
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27047,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5047,mapID = nil}},
				},
			}
		},
	},
	[5048] =             -----------------暗雷战斗-周信
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27048,
		soundID = nil,
		txt = "这天下将是我们魔教的，你们这群凡人还妄想击杀我们，简直痴心妄想。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5048,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---50-54级----------------------------------
------------------------------------1-50环----------------------------------
	[5049] =             -----------------暗雷战斗-诡异术士符血
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27049,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5049,mapID = nil}},
				},
			}
		},
	},
	[5050] =             -----------------暗雷战斗-邪教魔化护法
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27050,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5050,mapID = nil}},
				},
			}
		},
	},
	[5051] =             -----------------暗雷战斗-魔君白久
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27051,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5051,mapID = nil}},
				},
			}
		},
	},
	[5052] =             -----------------暗雷战斗-魔将陈千军
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27052,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5052,mapID = nil}},
				},
			}
		},
	},
	[5053] =             -----------------暗雷战斗-妖将火獐
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27053,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5053,mapID = nil}},
				},
			}
		},
	},
	[5054] =             -----------------暗雷战斗-镇狱明王
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27054,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5054,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---50-54级----------------------------------
------------------------------------50-100环----------------------------------
	[5055] =             -----------------暗雷战斗-魔君玄霓
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27055,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5055,mapID = nil}},
				},
			}
		},
	},
	[5056] =             -----------------暗雷战斗-魔将萧怀青
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27056,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5056,mapID = nil}},
				},
			}
		},
	},
	[5057] =             -----------------暗雷战斗-千年藤妖
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27057,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5057,mapID = nil}},
				},
			}
		},
	},
	[5058] =             -----------------暗雷战斗-妖将陆魁
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27058,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5058,mapID = nil}},
				},
			}
		},
	},
	[5059] =             -----------------暗雷战斗-邪道刘邑
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27059,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5059,mapID = nil}},
				},
			}
		},
	},
	[5060] =             -----------------暗雷战斗-术士方相
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27060,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5060,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---50-54级----------------------------------
------------------------------------100-150环----------------------------------
	[5061] =             -----------------暗雷战斗-魔君姬发
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27061,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5061,mapID = nil}},
				},
			}
		},
	},
	[5062] =             -----------------暗雷战斗-魔将乔坤
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27062,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5062,mapID = nil}},
				},
			}
		},
	},
	[5063] =             -----------------暗雷战斗-妖将曹宝
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27063,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5063,mapID = nil}},
				},
			}
		},
	},
	[5064] =             -----------------暗雷战斗-邪道萧臻
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27064,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5064,mapID = nil}},
				},
			}
		},
	},
	[5065] =             -----------------暗雷战斗-术士方弼
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27065,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5065,mapID = nil}},
				},
			}
		},
	},
	[5066] =             -----------------暗雷战斗-薛恶虎
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27066,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5066,mapID = nil}},
				},
			}
		},
	},
---------------------------------暗雷战斗---50-54级----------------------------------
------------------------------------150-200环----------------------------------
	[5067] =             -----------------暗雷战斗-韩毒龙
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27067,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5067,mapID = nil}},
				},
			}
		},
	},
	[5068] =             -----------------暗雷战斗-赤精子
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27068,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5068,mapID = nil}},
				},
			}
		},
	},
	[5069] =             -----------------暗雷战斗-雪峰老妖
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27069,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5069,mapID = nil}},
				},
			}
		},
	},
	[5070] =             -----------------暗雷战斗-水火童子
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27070,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5070,mapID = nil}},
				},
			}
		},
	},
	[5071] =             -----------------暗雷战斗-魔将马善
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 27071,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5071,mapID = nil}},
				},
			}
		},
	},
	[5072] =             -----------------暗雷战斗-妖将王虎
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		}, 
		speakerID = 27072,
		soundID = nil,
		txt = "你等竟敢打断本神施法，看来是嫌自己活得太好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 5072,mapID = nil}},
				},
			}
		},
	},
---------------------------------挑战明雷---无限制等级、无环数限制----------------------------------
	[5073] =            -----------------挑战明雷-洛阳-卢植
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20049}},
		},
		speakerID = 20049,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5073,mapID = 10}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5074] =            -----------------挑战明雷-洛阳-王子师
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 30320}},
		},
		speakerID = 30320,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5074,mapID = 10}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5075] =            -----------------挑战明雷-洛阳-皇甫嵩
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20059}},
		},
		speakerID = 20059,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5075,mapID = 10}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5076] =            -----------------挑战明雷-洛阳-张维义
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 29008}},
		},
		speakerID = 29008,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5076,mapID = 10}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5077] =            -----------------挑战明雷-桃园-杨森
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 27073}},
		},
		speakerID = 27073,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5077,mapID = 9}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5078] =            -----------------挑战明雷-桃园-高友乾
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 27074}},
		},
		speakerID = 27074,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5078,mapID = 9}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5079] =            -----------------挑战明雷-长安-王允
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20701}},
		},
		speakerID = 20701,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5079,mapID = 13}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5080] =            -----------------挑战明雷-长安-杨文辉
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 27075}},
		},
		speakerID = 27075,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5080,mapID = 13}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5081] =            -----------------挑战明雷-襄阳-郑伦
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 27076}},
		},
		speakerID = 27076,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5081,mapID = 14}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5082] =            -----------------挑战明雷-襄阳-陈奇
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 27077}},
		},
		speakerID = 27077,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5082,mapID = 14}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5083] =            -----------------挑战明雷-乾元岛-段岳
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20021}},
		},
		speakerID = 20021,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5083,mapID = 1}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5084] =            -----------------挑战明雷-蓬莱阁-兮颜
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20022}},	
		},
		speakerID = 20022,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5084,mapID = 2}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5085] =            -----------------挑战明雷-金霞山-李长风
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20023}},	
		},
		speakerID = 20023,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5085,mapID = 3}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5086] =            -----------------挑战明雷-桃源洞-庄梦蝶
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20025}},
		},
		speakerID = 20025,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5086,mapID = 4}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5087] =            -----------------挑战明雷-云霄宫-玄素
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20024}},	
		},
		speakerID = 20024,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5087,mapID = 5}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5088] =            -----------------挑战明雷-紫阳门-殿飞白
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.brightMine,npcID = 20026}},	
		},
		speakerID = 20026,
		txt = "是你要挑战我么，那就开始吧！",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5088,mapID = 6}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---40-44级----------------------------------
------------------------------------1-50环----------------------------------------------
	[5089] =            -----------------天道悬赏-黑风小妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27078}},
		},
		speakerID = 27078,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5089,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5090] =            -----------------天道悬赏-入魔双刀客
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27079}},
		},
		speakerID = 27079,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5090,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5091] =            -----------------天道悬赏-魔化女刺客
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27080}},
		},
		speakerID = 27080,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5091,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5092] =            -----------------天道悬赏-魔化剑奴
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27081}},	
		},
		speakerID = 27081,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5092,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5093] =            -----------------天道悬赏-黑衣人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27082}},	
		},
		speakerID = 27082,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5093,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5094] =            -----------------天道悬赏-邪恶祭祀
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27083}},
		},
		speakerID = 27083,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5094,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---40-44级----------------------------------
------------------------------------50-100环----------------------------------------------
	[5095] =            -----------------天道悬赏-蛇妖常旭
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27084}},	
		},
		speakerID = 27084,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5095,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5096] =            -----------------天道悬赏-魔仙黄龙
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27085}},
		},
		speakerID = 27085,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5096,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5097] =            -----------------天道悬赏-甲胄翰赤
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27086}},
		},
		speakerID = 27086,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5097,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5098] =            -----------------天道悬赏-符咒翰赤
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27087}},
		},
		speakerID = 27087,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5098,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5099] =            -----------------天道悬赏-翠岩妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27088}},
		},
		speakerID = 27088,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5099,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5100] =            -----------------天道悬赏-花魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27089}},
		},
		speakerID = 27089,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5100,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---40-44级----------------------------------
------------------------------------100-150环----------------------------------------------
	[5101] =            -----------------天道悬赏-术妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27090}},
		},
		speakerID = 27090,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5101,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5102] =            -----------------天道悬赏-鬼姬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27091}},
		},
		speakerID = 27091,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5102,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5103] =            -----------------天道悬赏-虎头怪
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27092}},
		},
		speakerID = 27092,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5103,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5104] =            -----------------天道悬赏-巫灵
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27093}},	
		},
		speakerID = 27093,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5104,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5105] =            -----------------天道悬赏-忧草姬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27094}},	
		},
		speakerID = 27094,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5105,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5106] =            -----------------天道悬赏-黑翰赤
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27095}},	
		},
		speakerID = 27095,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5106,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---40-44级----------------------------------
------------------------------------150-200环----------------------------------------------
	[5107] =            -----------------天道悬赏-白翰赤
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27096}},
		},
		speakerID = 27096,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5107,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5108] =            -----------------天道悬赏-幻姬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27097}},
		},
		speakerID = 27097,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5108,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5109] =            -----------------天道悬赏-烽骑
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27098}},
		},
		speakerID = 27098,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5109,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5110] =            -----------------天道悬赏-幻妖姬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27099}},	
		},
		speakerID = 27099,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5110,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5111] =            -----------------天道悬赏-幻灵姬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27100}},
		},
		speakerID = 27100,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5111,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5112] =            -----------------天道悬赏-无双赤鬼
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 270101}},	
		},
		speakerID = 27101,
		txt = "又有人过来送死了！那就别怪我了",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5112,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---45-49级----------------------------------
------------------------------------1-50环----------------------------------------------
	[5113] =            -----------------天道悬赏-魔教大护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27102}},
		},
		speakerID = 27102,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5113,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5114] =            -----------------天道悬赏-邪恶女妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27103}},
		},
		speakerID = 27103,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5114,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5115] =            -----------------天道悬赏-魔化妖道
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27104}},
		},
		speakerID = 27104,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5115,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5116] =            -----------------天道悬赏-黄巾魔将
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27105}},
		},
		speakerID = 27105,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5116,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5117] =            -----------------天道悬赏-冰石傀
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27106}},
		},
		speakerID = 27106,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5117,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5118] =            -----------------天道悬赏-飞熊
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27107}},	
		},
		speakerID = 27107,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5118,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---45-49级----------------------------------
------------------------------------50-100环----------------------------------------------
	[5119] =            -----------------天道悬赏-血魔君
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27108}},
		},
		speakerID = 27108,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5119,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5120] =            -----------------天道悬赏-血狂
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27109}},	
		},
		speakerID = 27109,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5120,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5121] =            -----------------天道悬赏-莲魂影
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27110}},
		},
		speakerID = 27110,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5121,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5122] =            -----------------天道悬赏-花怀风
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27111}},
		},
		speakerID = 27111,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5122,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5123] =            -----------------天道悬赏-龙魂
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27112}},
		},
		speakerID = 27112,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5123,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5124] =            -----------------天道悬赏-金翅迦楼洛
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27113}},
		},
		speakerID = 27113,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5124,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---45-49级----------------------------------
------------------------------------100-150环----------------------------------------------
	[5125] =            -----------------天道悬赏-雪风
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27114}},	
		},
		speakerID = 27114,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5125,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5126] =            -----------------天道悬赏-魔道羽灵
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27115}},
		},
		speakerID = 27115,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5126,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5127] =            -----------------天道悬赏-鬼道羽灵
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27116}},	
		},
		speakerID = 27116,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5127,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5128] =            -----------------天道悬赏-古格
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27117}},	
		},
		speakerID = 27117,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5128,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5129] =            -----------------天道悬赏-夜魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27118}},	
		},
		speakerID = 27118,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5129,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5130] =            -----------------天道悬赏-玄风
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27119}},	
		},
		speakerID = 27119,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5130,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---45-49级----------------------------------
------------------------------------150-200环----------------------------------------------
	[5131] =            -----------------天道悬赏-血灵魑魅
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27120}},
		},
		speakerID = 27120,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5131,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5132] =            -----------------天道悬赏-地藏妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27121}},
		},
		speakerID = 27121,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5132,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5133] =            -----------------天道悬赏-雪妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27122}},
		},
		speakerID = 27122,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5133,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5134] =            -----------------天道悬赏-剑魂
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27123}},
		},
		speakerID = 27123,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5134,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5135] =            -----------------天道悬赏-高渊
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27124}},	
		},
		speakerID = 27124,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5135,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5136] =            -----------------天道悬赏-魅惑妖姬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27125}},	
		},
		speakerID = 27125,
		txt = "没想到竟然被你发现了我的下落，那就别怪我不客气，只有死人才能保守秘密。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5136,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---50-54级----------------------------------
------------------------------------1-50环----------------------------------------------
	[5137] =            -----------------天道悬赏-魔化器灵
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27126}},
		},
		speakerID = 27126,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5137,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5138] =            -----------------天道悬赏-牛魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27127}},
		},
		speakerID = 27127,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5138,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5139] =            -----------------天道悬赏-金翅大鹏王
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27128}},	
		},
		speakerID = 27128,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5139,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5140] =            -----------------天道悬赏-邪灵分身
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27129}},
		},
		speakerID = 27129,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5140,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5141] =            -----------------天道悬赏-血法祭祀
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27130}},
		},
		speakerID = 27130,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5141,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5142] =            -----------------天道悬赏-魔灵傀儡
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27131}},	
		},
		speakerID = 27131,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5142,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---50-54级----------------------------------
------------------------------------50-100环----------------------------------------------
	[5143] =            -----------------天道悬赏-冰魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27132}},	
		},
		speakerID = 27132,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5143,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5144] =            -----------------天道悬赏-罗刹恶鬼
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27133}},
		},
		speakerID = 27133,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5144,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5145] =            -----------------天道悬赏-蛟魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27134}},
		},
		speakerID = 27134,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5145,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5146] =            -----------------天道悬赏-双头魔狼
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27135}},
		},
		speakerID = 27135,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5146,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5147] =            -----------------天道悬赏-嗜血魔将
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27136}},	
		},
		speakerID = 27136,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5147,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5148] =            -----------------天道悬赏-嗜血蛮将
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27137}},	
		},
		speakerID = 27137,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5148,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---50-54级----------------------------------
------------------------------------100-150环----------------------------------------------
	[5149] =            -----------------天道悬赏-罗刹女妖
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27138}},	
		},
		speakerID = 27138,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5149,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5150] =            -----------------天道悬赏-幽灵鬼师
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27139}},	
		},
		speakerID = 27139,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5150,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5151] =            -----------------天道悬赏-血炼猪魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27140}},	
		},
		speakerID = 27140,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5151,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5152] =            -----------------天道悬赏-魔灵犬
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27141}},	
		},
		speakerID = 27141,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5152,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5153] =            -----------------天道悬赏-魔奴
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27142}},
		},
		speakerID = 27142,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5153,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5154] =            -----------------天道悬赏-魔将端无
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27143}},
		},
		speakerID = 27143,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5154,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
---------------------------------天道悬赏---50-54级----------------------------------
------------------------------------150-200环----------------------------------------------
	[5155] =            -----------------天道悬赏-恶灵童子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27144}},
		},
		speakerID = 27144,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5155,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5156] =            -----------------天道悬赏-枪魔
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27145}},
		},
		speakerID = 27145,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5156,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5157] =            -----------------天道悬赏-赤魂王
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27146}},	
		},
		speakerID = 27146,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5157,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5158] =            -----------------天道悬赏-金蟾鬼母
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27147}},	
		},
		speakerID = 27147,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5158,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5159] =            -----------------天道悬赏-毒娘子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27148}},	
		},
		speakerID = 27148,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5159,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[5160] =            -----------------天道悬赏-妖鬼皇
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		--{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.script,npcID = 27149}},
		},
		speakerID = 27149,
		txt = "就凭你还想诛杀我，简直是痴心妄想。",
		options =
        {
			[1] = {
				showConditions = {},
				optionTxt = "进入战斗",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 5160,mapID = nil}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
--------------------------接任务对话------------------------------------------
	[5161] =           -----------------暗雷战斗
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "如今天下大乱，妖物强盗到处残害百姓，听闻<mapID,x,y>附近有<npcID>在四处作乱，你且前去查询情况。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
	[5162] =           -----------------挑战明雷--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "如今妖物为祸人间，法力高强，需锻炼自己，前去<mapID,x,y>处挑战<npcID>，学习战斗经验。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
	[5163] =           -----------------天道悬赏--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "据探子来报，在<mapID,x,y>处，发现有<npcID>出现，杀害平民百姓，前去将其诛杀。 ",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
	[5164] =           -----------------对话--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "前往<mapID,x,y>处，寻找<npcID>询问当今天下是何形势。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
	[5165] =           -----------------送信--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "下个月初一是个好日，将这封信件送往<mapID,x,y>处，送给<npcID>，邀请他聚一聚。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
	[5166] =           -----------------上交道具--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "前去<mapID,x,y>购买一件<itemID>。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
	[5167] =           -----------------上交宠物--------------------
	{
		dialogType = DialogType.NotOption,
	    conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "听闻最近<petID>有些异常，你且前去将其抓来，交于<npcID>处查询情况。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
-----------------------------------对话任务------------------------------
	[5168] =           -----------------对话任务--卢植--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20049}},
		},
		speakerID = 20049,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5169] =           -----------------对话任务--王子师--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 30320}},
		},
		speakerID = 30320,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
    [5170] =           -----------------对话任务--皇甫嵩--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20059}},
		},
		speakerID = 20059,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5171] =           -----------------对话任务--张维义--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 29008}},
		},
		speakerID = 29008,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5172] =           -----------------对话任务--杨森--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 27073}},
		},
		speakerID = 27073,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5173] =           -----------------对话任务--高友乾--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 27074}},
		},
		speakerID = 27074,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		                {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5174] =           -----------------对话任务--王允--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20701}},
		},
		speakerID = 20701,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5175] =           -----------------对话任务--杨文辉--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 27075}},
		},
		speakerID = 27075,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5176] =           -----------------对话任务--郑伦--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 27076}},
		},
		speakerID = 27076,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5177] =           -----------------对话任务--陈奇--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 27077}},
		},
		speakerID = 27077,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5178] =           -----------------对话任务--段岳--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20021}},
		},
		speakerID = 20021,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5179] =           -----------------对话任务--兮颜--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20022}},
		},
		speakerID = 20022,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5180] =           -----------------对话任务--李长风--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20023}},
		},
		speakerID = 20023,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		              {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5181] =           -----------------对话任务--庄梦蝶--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20025}},
		},
		speakerID = 20025,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5182] =           -----------------对话任务--玄素--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20024}},
		},
		speakerID = 20024,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
	[5183] =           -----------------对话任务--殿飞白--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.talk, npcID = 20026}},
		},
		speakerID = 20026,
		soundID = nil,
		txt = "如今天下妖物横行，门下弟子都在努力修炼，争取早日除魔卫道。",
		options =
		{
			{
			 showConditions = {},
			 optionTxt = "",
		     actions =
		              {
		               {action = DialogActionType.FinishLoopTask, param = {taskID = 10007}},
					  },	
		    },
		},
	},
-------------------------------- 送信-----------------------
    [5184] =           -----------------送信任务--卢植--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
		},
		speakerID = 20049,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5185] =           -----------------送信任务--王子师--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 30320}},
		},
		speakerID = 30320,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5186] =           -----------------送信任务--皇甫嵩--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
		},
		speakerID = 20059,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5187] =           -----------------送信任务--张维义--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 29008}},
		},
		speakerID = 29008,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5188] =           -----------------送信任务--杨森--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 27073}},
		},
		speakerID = 27073,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5189] =           -----------------送信任务--高友乾--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 27074}},
		},
		speakerID = 27074,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5190] =           -----------------送信任务--王允--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
		},
		speakerID = 20701,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5191] =           -----------------送信任务--杨文辉--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
		},
		speakerID = 27075,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5192] =           -----------------送信任务--郑伦--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 27076}},
		},
		speakerID = 27076,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5193] =           -----------------送信任务--陈奇--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 27077}},
		},
		speakerID = 27077,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5194] =           -----------------送信任务--段岳--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20021}},
		},
		speakerID = 20021,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5195] =           -----------------送信任务--兮颜--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20022}},
		},
		speakerID = 20022,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5196] =           -----------------送信任务--李长风--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20023}},
		},
		speakerID = 20023,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5197] =           -----------------送信任务--庄梦蝶--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20025}},
		},
		speakerID = 20025,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5198] =           -----------------送信任务--玄素--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20024}},
		},
		speakerID = 20024,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
	[5199] =           -----------------送信任务--殿飞白--------------------
	{
		dialogType = DialogType.HasOption,
		conditions ={
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.deliverLetters, npcID = 20026}},
		},
		speakerID = 20026,
		soundID = nil,
		txt = "少侠，你将交于我的书信，带来了么！",
		options =
		{
			[1] = {
			 showConditions = {},
			 optionTxt = "给于信件",
		     actions =
		              {
		             {action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo ={count = 1},},},	
					  },	
		    },
		},
	},
-------------------------------- 上缴物品-----------------------
    [5200] =           -----------------上缴物品--卢植--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20049}},
		},
		speakerID = 20049,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},

		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5201] =           -----------------上缴物品--王子师--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 30320}},
		},
		speakerID = 30320,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5202] =           -----------------上缴物品--皇甫嵩--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20059}},
		},
		speakerID = 20059,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5203] =           -----------------上缴物品--张维义--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 29008}},
		},
		speakerID = 29008,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5204] =           -----------------上缴物品--杨森--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 27073}},
		},
		speakerID = 27073,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5205] =           -----------------上缴物品--高友乾--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 27074}},
		},
		speakerID = 27074,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5206] =           -----------------上缴物品--王允--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20701}},
		},
		speakerID = 20701,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5207] =           -----------------上缴物品--杨文辉--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 27075}},
		},
		speakerID = 27075,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5208] =           -----------------上缴物品--郑伦--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 27076}},
		},
		speakerID = 27076,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5209] =           -----------------上缴物品--陈奇--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 27077}},
		},
		speakerID = 27077,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5210] =           -----------------上缴物品--段岳--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20021}},
		},
		speakerID = 20021,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5211] =           -----------------上缴物品--兮颜--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20022}},
		},
		speakerID = 20022,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5212] =           -----------------上缴物品--李长风--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20023}},
		},
		speakerID = 20023,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5213] =           -----------------上缴物品--庄梦蝶--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20025}},
		},
		speakerID = 20025,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5214] =           -----------------上缴物品--玄素--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20024}},
		},
		speakerID = 20024,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5215] =           -----------------上缴物品--殿飞白--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.buyItem,npcID = 20026}},
		},
		speakerID = 20026,
		soundID = nil,
		txt = "这位少侠，你找到我需要的东西了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10007, itemsInfo = {count = 1},},},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	-------------------------------- 上缴宠物-----------------------
    [5216] =           -----------------上缴宠物--卢植--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20049}},
		},
		speakerID = 20049,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5217] =           -----------------上缴宠物--王子师--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 30320}},
		},
		speakerID = 30320,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5218] =           -----------------上缴宠物--皇甫嵩	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20059}},
		},
		speakerID = 20059,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5219] =           -----------------上缴宠物--张维义	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 29008}},
		},
		speakerID = 29008,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5220] =           -----------------上缴宠物--杨森	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 27073}},
		},
		speakerID = 27073,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5221] =           -----------------上缴宠物--高友乾	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 27074}},
		},
		speakerID = 27074,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5222] =           -----------------上缴宠物--王允	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20701}},
		},
		speakerID = 20701,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5223] =           -----------------上缴宠物--杨文辉	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 27075}},
		},
		speakerID = 27075,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5224] =           -----------------上缴宠物--郑伦	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 27076}},
		},
		speakerID = 27076,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5225] =           -----------------上缴宠物--陈奇	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 27077}},
		},
		speakerID = 27077,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5226] =           -----------------上缴宠物--段岳	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20021}},
		},
		speakerID = 20021,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5227] =           -----------------上缴宠物--兮颜	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20022}},
		},
		speakerID = 20022,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5228] =           -----------------上缴宠物--李长风	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20023}},
		},
		speakerID = 20023,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5229] =           -----------------上缴宠物--庄梦蝶	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20025}},
		},
		speakerID = 20025,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5230] =           -----------------上缴宠物--玄素	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20024}},
		},
		speakerID = 20024,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5231] =           -----------------上缴宠物--殿飞白	--------------------
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,taskType = LoopTaskTargetType.catchPet,npcID = 20026}},
		},
		speakerID = 20026,
		soundID = nil,
		txt = "少侠，你捉到异常的宠物了么？",
		options = 
		{
		[1] = {
				showConditions = {},
				optionTxt = "上交宠物",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10007}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[5232] =           -----------------上交道具接对话2--------------------
	{
		dialogType = DialogType.NotOption,
		conditions ={},
		speakerID = 27150,
		soundID = nil,
		txt = "将买到的物品交于<mapID,x,y>的<npcID>处。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
						},
			}
		},
	},
----------------------------------------试炼任务分段完毕，接下来该你们了---------------------------------------------
----------------------------我是分割线，上面是主线对话，下面是npc对话-----------------------------------
	----------------------------洛阳主城ID规划：20001~20150-------------------
	[20001] =    ----洛阳商店
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20012,
		txt = "怪物掉落相关的物品大都可以在这里买到，客官要不要来看看？",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 1},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20002] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20013,
		txt = "武器相关的道具都可以在我这里购买",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 20},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20003] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20014,
		txt = "我这里专门出售特殊功能物品，客官要不要来看看？",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 3},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20004] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20015,
		txt = "我这里出售珍贵的宠物以及相关道具，客官要不要来看看？",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 4},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20005] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20016,
		txt = "优良便捷的坐骑，能为你省下许多时间，是你出行的必备工具。",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 5},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20006] =             --洛阳城内世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =20018 ,
		txt = "我是洛阳车夫",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "桃园镇",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 9, tarX = 81, tarY = 91}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "徐州",   --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 118, tarX = 80, tarY = 156}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "长安",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 13, tarX = 107, tarY = 93}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "巨鹿",  --野外地图
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 101, tarX = 93, tarY = 200}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "岐山",   --野外地图2016/7/27
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 102, tarX = 136, tarY = 118}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "黑风岭",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 104, tarX = 87, tarY = 191}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "郿坞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 106, tarX = 77, tarY = 147}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "东郡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 107, tarX = 167, tarY = 99}},--切换场景
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "虎牢关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 109, tarX = 186, tarY = 106}},--切换场景
				},
			},
			[10] =
			{
				showConditions = {},
				optionTxt = "潼关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 110 , tarX = 80, tarY = 129}},--切换场景
				},
			},
			[11] =
			{
				showConditions = {},
				optionTxt = "天山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 115, tarX = 149, tarY = 128}},--切换场景
				},
			},
			[12] =
			{
				showConditions = {},
				optionTxt = "西凉",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 116, tarX = 227, tarY = 135}},--切换场景
				},
			},
			[13] = {
				showConditions = {},
				optionTxt = "暂时不走",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		}
	},
	[20007] =             --洛阳城内世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =30250 ,
		txt = "我是洛阳车夫",
		options =
		{

		    [1] =
			{
				showConditions = {},
				optionTxt = "宛城",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 122, tarX = 161, tarY = 153}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "寿春",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 124, tarX = 175, tarY = 59}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "河北",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 126, tarX = 147, tarY = 140}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "轩辕坟",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 127, tarX = 133, tarY = 228}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "官渡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 128, tarX = 92, tarY = 205}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "北海",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 119, tarX = 164, tarY = 134}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "襄阳",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 14, tarX = 94, tarY = 73}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "江夏",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 120, tarX = 114, tarY = 151}},--切换场景
				},
			},
			[9] = {
				showConditions = {},
				optionTxt = "暂时不走",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20008] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20017,
		txt = "身上东西太多了？我可以免费帮客官保管钱财物品！", 
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 20017}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4453}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 20017}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4462}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 20017}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4471}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 20017}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4480}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 20017}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4489}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 20017}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4498}},
				},
			},			
			[7] =
			{
				showConditions = {},
				optionTxt = "存放物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "DepotWin"},},--打开物品仓库
				},
				icon = DialogIcon.Box,
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "存放宠物",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "PetDepotWin"},},--打开宠物仓库
				},
				icon = DialogIcon.Box,
			},
		},
	},
	[20009] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20106,
		txt = "你们这些年轻人活泼好动，又爱舞刀弄枪，说不定什么时候就会受伤，要记得多准备些草药带着呀。",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 2},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20010] =           ----------------------------洛阳点点，杂货店
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20107,
		txt = "欢迎光临，本店商品齐全，物美价廉，请随便选购。",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 1},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20011] =         --------------------------洛阳诸葛百里，坐骑店
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20108,
		txt = "给钱我就让你飞。",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 5},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20012] =        --------洛阳元宝商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29046,
		txt = "我是元宝商人，在我这里可以买到特殊的商品。",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 17},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20013] =             --洛阳门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29056,
		txt = "阐教弟子，我可以送你到各大门派。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我还不想走",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20014] =            -------------洛阳城城门守卫
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20060,
		txt = "陛下极为宠信咱家，在这洛阳就是我赵常侍的地盘。",
		options =
		{
			[1] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1078, statue = true}},	
				},
				optionTxt = "质问赵忠（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 259}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "强龙难压地头蛇，我先闪。",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20015] =    -----------洛阳皇甫嵩
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20059,
		txt = "汉朝失政，天下倒悬，能安危定倾者，唯吾耳。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4457}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4466}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4475}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4484}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4493}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 20059}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4502}},
				},
			},
			[7] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20059}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5075,5170,5186,5202,5218}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5170,5186,5202,5218}}},
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20016] =    -----------洛阳卢植
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20049,
		txt = "风霜以别草木之性，危乱而见贞良之节。天下大乱。正是我等有识之士为国尽忠之时。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.HasTask, param = {taskID = 1427, statue = true}},	
				},
				optionTxt = "皇帝苏醒（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1475}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4451}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4460}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4469}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4478}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4487}},
				},
			},
			[7] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 20049}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4496}},
				},
			},
			[8] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20049}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5073,5168,5184,5200,5216 }}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5168,5184,5200,5216 }}},
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "卢大人乃忠良之士，在下佩服。",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},
	[20017] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29001,
		txt = "上好的武器，客官要不要来看看？",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.talk,npcID = 29001}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4354}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.talk,npcID = 29001}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4362}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.talk,npcID = 29001}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4370}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.talk,npcID = 29001}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4378}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.talk,npcID = 29001}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4386}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.talk,npcID = 29001}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4394}},
				},
			},
			[7] = {
				showConditions = {},
				optionTxt = "看看有什么武器",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 6},},
				},
				icon = DialogIcon.Trade,
			},
			[8] ={
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20018] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29002,
		txt = "最新打造的护甲，客官要不要来看看？",
		options =
		{
			[1] ={
				showConditions = {},
				optionTxt = "看看有什么防具",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 7},},
				},
				icon = DialogIcon.Trade,
			},
			[2] ={
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20019] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29003,
		txt = "想要什么首饰吗？",
		options =
		{
			[1] ={
				showConditions = {},
				optionTxt = "看看有什么饰品",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 8},},
				},
				icon = DialogIcon.Trade,
			},
			[2] ={
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20020] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29004,
		txt = "我是家园综管，有什么事吗？",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20021] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29005,
		txt = "我喜欢研究天下各大帮会的生产技能，我可以将我的研究传授与你，不过我收取的费用可不低哦，而且你还得耗费一定的经验。我的研究是偷师与各大帮会，因此从我这里学习到的生产技能等级是不会超出各大帮会研发出的等级的！",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.talk,npcID = 29005}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4351}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.talk,npcID = 29005}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4359}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.talk,npcID = 29005}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4367}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.talk,npcID = 29005}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4375}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.talk,npcID = 29005}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4383}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.talk,npcID = 29005}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4391}},
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "学习生活技能",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "LifeSkillStudyWin",show = 1,},},--打开生活技能仓库
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "我再看看",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20022] =
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 29006,
		txt = "所谓路见不平，拔刀相助，少侠有没有时间来帮助别人？",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "路见不平一声吼，我来！（暂无配置）",
				actions =
				{
					{action = DialogActionType.FrozenBuff, param = {},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "下次再来",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
				icon = DialogIcon.Talk,
			},
		}
	},
	[20023] =
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 29007,
		txt = "现在正值乱世，各地物质都紧缺，镖局人手远远不够，少侠可有空来帮我们，运镖的风险越高，收益也将越好。",
		options =
		{
			[1] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.escort, npcID = 29007}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[2] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.escort, npcID = 29007}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[3] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.escort, npcID = 29007}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[4] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.escort, npcID = 29007}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[5] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.escort, npcID = 29007}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[6] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.escort, npcID = 29007}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "接受运镖任务（暂无配置）",
				actions =
				{
					{action = DialogActionType.FrozenBuff, param = {},},
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "下次再来",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		}
	},
	[20024] =            -------------洛阳张道长，天道任务
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29008,
		txt = "当日张角破坏封神台，使得邪魔尽出，天下大乱，道友可有时间助我等一臂之力，为民除害，斩杀邪魔？",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.talk,npcID = 29008}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4352}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.talk,npcID = 29008}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4360}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.talk,npcID = 29008}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4368}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.talk,npcID = 29008}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4376}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.talk,npcID = 29008}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4384}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.talk,npcID = 29008}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4392}},
				},
			},			
			[7] = {
				showConditions = 
				{
				 {condition = DialogCondition.Level, param = {level = 30}},
				},
				optionTxt = "接受天道任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4032}},
				},
			},
			[8] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 29008}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5076,5171,5187,5203,5219}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5171,5187,5203,5219}}},
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "暂且没空",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20025] =
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 29065,
		txt = "我走遍大江南北，看过的事物何其多，任何东西到我手里，我都能一眼看穿真假。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "鉴定装备",
				actions =
				{
					{action = DialogActionType.OpenEquipAppraisal, param = {},},
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "绑定装备（暂无配置）",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "下次再来",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		}
	},
	[20026] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{},
		speakerID = 29079,
		txt = "天下大乱兮市为墟，母不保子兮妻失夫，吾愿为天下苍生散尽千金，道友可愿为天下苍生尽一份力？",
		options = 
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 29079}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4454}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 29079}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4463}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 29079}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4472}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 29079}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4481}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 29079}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4490}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 29079}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4499}},
				},
			},	
			[7] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.donate}},
				},
				optionTxt = "扶贫济弱（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4702}},
				},
			},
			[8] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.donate}},
				},
				optionTxt = "扶贫济弱（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4704}},
				},
			},
			[9] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.donate}},
				},
				optionTxt = "扶贫济弱（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4706}},
				},
			},
			[10] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.donate}},
				},
				optionTxt = "扶贫济弱（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4708}},
				},
			},
			[11] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.donate}},
				},
				optionTxt = "扶贫济弱（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4710}},
				},
			},
			[12] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.donate}},
				},
				optionTxt = "扶贫济弱（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4712}},
				},
			},
			[13] =
			{
				showConditions = {},
				optionTxt = "我下次再来",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20027] =            -----------------洛阳-陆萧然
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,countRing = 2,statue = true,errorID = 26}},
		{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = false,errorID = 25}},
		{condition = DialogCondition.Level, param = {level = 40,errorID = 22},},	
		},
		speakerID = 27150,
		txt = "现如今妖物强盗在人间祸乱百姓，需要强力的英雄前去斩杀那些妖物强盗，如今我这里有一个试炼任务提升修为，您是否接受此任务？",
		options =
        {
			[1] = {
				showConditions = {
				},
				optionTxt = "接受任务（花费10000银两）",
				actions =
				{
				  {action = DialogActionType.ConsumeRecetiveTask ,param = {type  = "money", value = 10000, taskID = 10007}},--花费一定金钱接受任务
				--{action = DialogActionType.RecetiveTask, param = {taskID = 10007}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5161,5163,5164,5165,5166,5167 }}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再说",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},

		},
	},
	[20028] =            -----------------洛阳-陆萧然
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 27150,
		soundID = nil,
		txt = "天地不仁，以万物为刍狗。如今世道妖物横行，将有大乱也！",
		options = 
		{
			[1] = {
				showConditions = {
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 20027},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "好深奥。。。。。。。。。。",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
    [20029] =            -----------------洛阳-无名老人
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 20928,
		soundID = nil,
		txt = "洛阳，地处古洛水北岸而得名，因处九州之中，素有“九州腹地”之称。",
		options = 
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001,taskType = LoopTaskTargetType.talk,npcID = 20928}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4355}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002,taskType = LoopTaskTargetType.talk, npcID = 20928}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4363}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.talk,npcID = 20928}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4371}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.talk,npcID = 20928}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4379}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.talk,npcID = 20928}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4387}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006,taskType = LoopTaskTargetType.talk, npcID = 20928}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4395}},
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "受教了，晚辈先告辞。",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20030] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29080,
		txt = "我喜欢研究天下各大帮会的生产技能，我可以将我的研究传授与你，不过我收取的费用可不低哦，而且你还得耗费一定的经验。我的研究是偷师与各大帮会，因此从我这里学习到的生产技能等级是不会超出各大帮会研发出的等级的！",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "学习生活技能",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "LifeSkillStudyWin",show = 2,},},--打开生活技能仓库
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "我再看看",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20031] =    ----洛阳测试npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20011,
		txt = "特殊物品可在这买",
		options =
		{
		[1] = {
				showConditions = {},
				optionTxt = "看看卖啥",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 21},},
				},
				icon = DialogIcon.Trade,
			},
		[2] = {
				showConditions = {},
				optionTxt = "只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		[3] =
			{
				showConditions = {},
				optionTxt = "测试战斗用",
				actions =
				{
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 4001}},
				},
			},
		},
	},
	--------------------------------桃园镇对话ID规划：20151~20250------
	[20151] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20019,
		txt = "我是桃园镇车夫",
		options =
		{

			[1] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "徐州",   --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 118, tarX = 80, tarY = 156}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "长安",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 13, tarX = 107, tarY = 93}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "巨鹿",  --野外地图
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 101, tarX = 93, tarY = 200}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "岐山",   --野外地图2016/7/27
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 102, tarX = 136, tarY = 118}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "黑风岭",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 104, tarX = 87, tarY = 191}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "郿坞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 106, tarX = 77, tarY = 147}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "东郡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 107, tarX = 167, tarY = 99}},--切换场景
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "虎牢关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 109, tarX = 186, tarY = 106}},--切换场景
				},
			},
			[10] =
			{
				showConditions = {},
				optionTxt = "潼关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 110 , tarX = 80, tarY = 129}},--切换场景
				},
			},
			[11] =
			{
				showConditions = {},
				optionTxt = "天山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 115, tarX = 149, tarY = 128}},--切换场景
				},
			},
			[12] =
			{
				showConditions = {},
				optionTxt = "西凉",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 116, tarX = 227, tarY = 135}},--切换场景
				},
			},
			[13] =
			{
				showConditions = {},
				optionTxt = "我再转转",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20152] =             --桃园镇世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =30256 ,   ---错误的
		txt = "我是桃园镇车夫",
		options =
		{
			 [1] =
			{
				showConditions = {},
				optionTxt = "宛城",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 122, tarX = 161, tarY = 153}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "寿春",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 124, tarX = 175, tarY = 59}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "河北",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 126, tarX = 147, tarY = 140}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "轩辕坟",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 127, tarX = 133, tarY = 228}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "官渡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 128, tarX = 92, tarY = 205}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "北海",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 119, tarX = 164, tarY = 134}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "襄阳",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 14, tarX = 94, tarY = 73}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "江夏",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 120, tarX = 114, tarY = 151}},--切换场景
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "我再转转",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		}
	},
	[20153] =        --------桃园镇武器商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29009,
		txt = "店是小店，但我这的武器都十分锋利，绝对物超所值！",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么武器",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 9},},
				},
				icon = DialogIcon.Trade,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "我只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20154] =        --------桃园镇药草商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29010,
		txt = "行走江湖，难免什么时候会受伤的，多备些药材准没错。",
		options =
		{
			[1] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.escort, npcID = 29010}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[2] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.escort, npcID = 29010}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[3] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.escort, npcID = 29010}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[4] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.escort, npcID = 29010}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[5] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.escort, npcID = 29010}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[6] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.escort, npcID = 29010}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "购买药草",
				actions =
				{
				{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 10},},
				},
				icon = DialogIcon.Trade,
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "我只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20155] =        --------桃园镇防具商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29011,
		txt = "刀剑无眼，行走在外怎能不带套护甲，客官要不要来看看，绝对有你想要的商品！",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么防具",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 11},},
				},
				icon = DialogIcon.Trade,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "我只是路过",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20156] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29012,
		txt = "我虽是客栈小二，但我知道的事可多了，你想知道什么？",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.talk,npcID = 29012}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4356}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.talk,pcID = 29012}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4364}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.talk,npcID = 29012}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4372}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.talk,npcID = 29012}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4380}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.talk,npcID = 29012}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4388}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.talk,npcID = 29012}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4396}},
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "下次再找你",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20157] =    -----------桃园镇客栈老板
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29013,
		txt = "桃园镇风景秀丽，桃园客栈更是休息的绝佳地方，客官要不要休息一下？",
		options =
		{
			[1] ={
				showConditions = {},
				optionTxt = "飞到洛阳",
				actions =
				{
				{action = DialogActionType.FlyEffect,  param= {flyEffectID = 73}},
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "暂时不用",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20158] =        --------桃园镇杂货商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29014,
		txt = "我店虽小，但我这里商品种类繁多，说不定就有你想要的！",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么商品",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 14},},
				},
				icon = DialogIcon.Trade,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "暂时不用",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20159] =   ------------桃园镇宠物医生
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 29015,
		txt = "我是宠物医生，有受伤的宠物都可以来找我，角色20级前免费，20级后收费少量的金钱，需要帮助吗？",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "修复当前出战宠物",
				actions =
				{
					{action = DialogActionType.RepairPet, param = {},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "修复所有宠物",
				actions =
				{
					{action = DialogActionType.RepairAllPet, param = {},},
				},
				icon = DialogIcon.Talk,
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "没事，打扰了",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		}
	},
	[20160] =    -----------桃园镇长刘元起
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20027,
		txt = "我是桃园镇镇长刘元起，这附近发生什么事都可以找我。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.talk,npcID = 20027}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4353}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.talk,npcID = 20027}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4361}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.talk,npcID = 20027}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4369}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.talk,npcID = 20027}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4377}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.talk,npcID = 20027}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4385}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.talk,npcID = 20027}},	
				},
				optionTxt = "拜访（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4393}},
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		},
	},
	[20161] =    -----------桃园-杨森
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 27073,
		txt = "如今妖物横行，这可如何是好！",
		options =
		{
		    [1] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 27073}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5077,5172,5188,5204,5220}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5172,5188,5204,5220}}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			}
		},
	},
	[20162] =    -----------桃园-高友乾
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 27074,
		txt = "天下大势，自有大势所定夺！",
		options =
		{
		    [1] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 27074}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5078,5173,5189,5205,5221}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5173,5189,5205,5221}}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			}
		},
	},
	-----------------襄阳主城ID规划：20251~20350---------
	[20251] =             --襄阳世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =30252 ,
		txt = "我是襄阳车夫",
		options =
		{
		[1] =
			{
				showConditions = {},
				optionTxt = "桃园镇",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 9, tarX = 81, tarY = 91}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "徐州",   --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 118, tarX = 80, tarY = 156}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "长安",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 13, tarX = 107, tarY = 93}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "巨鹿",  --野外地图
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 101, tarX = 93, tarY = 200}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "岐山",   --野外地图2016/7/27
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 102, tarX = 136, tarY = 118}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "黑风岭",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 104, tarX = 87, tarY = 191}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "郿坞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 106, tarX = 77, tarY = 147}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "东郡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 107, tarX = 167, tarY = 99}},--切换场景
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "虎牢关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 109, tarX = 186, tarY = 106}},--切换场景
				},
			},
			[10] =
			{
				showConditions = {},
				optionTxt = "潼关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 110 , tarX = 80, tarY = 129}},--切换场景
				},
			},
			[11] =
			{
				showConditions = {},
				optionTxt = "天山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 115, tarX = 149, tarY = 128}},--切换场景
				},
			},
			[12] =
			{
				showConditions = {},
				optionTxt = "西凉",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 116, tarX = 227, tarY = 135}},--切换场景
				},
			},
			[13] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		}
	},
	[20252] =             --襄阳世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =30253 ,
		txt = "我是襄阳车夫",
		options =
		{

			[1] =
			{
				showConditions = {},
				optionTxt = "宛城",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 122, tarX = 161, tarY = 153}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "寿春",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 124, tarX = 175, tarY = 59}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "河北",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 126, tarX = 147, tarY = 140}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "轩辕坟",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 127, tarX = 133, tarY = 228}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "官渡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 128, tarX = 92, tarY = 205}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "北海",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 119, tarX = 164, tarY = 134}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "洛阳",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "江夏",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 120, tarX = 114, tarY = 151}},--切换场景
				},
			},
			[9] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		}
	},
	[20253] =   ------------襄阳宠物医生
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 29018,
		txt = "我是宠物医生，有受伤的宠物都可以来找我，角色20级前免费，20级后收费少量的金钱，需要帮助吗？",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "修复当前出战宠物",
				actions =
				{
					{action = DialogActionType.RepairPet, param = {},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "修复所有宠物",
				actions =
				{
					{action = DialogActionType.RepairAllPet, param = {},},
				},
				icon = DialogIcon.Talk,
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "没事，打扰了",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
				icon = DialogIcon.Talk,
			},
		}
	},
	[20254] =    -----------襄阳武器大师
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29019,
		txt = "老夫打造武器那么多年，还没有人在这方面的造诣超过我的。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20255] =        --------襄阳杂货商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29020,
		txt = "在襄阳，我这里的东西是最全的，客官要不要来看看？",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么商品",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 12},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20256] =        --------襄阳药材商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29021,
		txt = "你们行走江湖，都要小心一些，记得多备些药材，以防不测啊。",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "购买药材",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 2},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20257] =    -----------襄阳钱庄老板
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29022,
		txt = "我们可以帮你管理钱财。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20258] =    -----------襄阳酒店老板
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29023,
		txt = "我这里可是襄阳唯一的酒店。",
		options =
		{
			[1] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.escort, npcID = 29023}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[2] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.escort, npcID = 29023}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[3] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.escort, npcID = 29023}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[4] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.escort, npcID = 29023}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[5] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.escort, npcID = 29023}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[6] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.escort, npcID = 29023}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[7] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20259] =    -----------襄阳防具商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29057,
		txt = "没有一套好的防具，又怎么保全自己？客官来看看吧，我对我的防具有足够的信心。",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么防具",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 19},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20260] =        --------襄阳武器商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29058,
		txt = "店是小店，但我这的武器都十分锋利，绝对物超所值！",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么武器",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 18},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "我只是路过",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20261] =    -----------襄阳-郑伦
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 27076,
		txt = "吾乃三运粮总督官郑伦是也，你是何人？",
		options =
		{
		 [1] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 27076}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5081,5176,5192,5208,5224}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5176,5192,5208,5224}}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			}
		},
	},
	[20262] =    -----------襄阳-陈奇
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 27077,
		txt = "吾乃督粮上将军陈奇是也，你是何人？",
		options =
		{
		[1] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 27077}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5082,5177,5193,5209,5225}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5177,5193,5209,5225}}},
				},
			},
		[2] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	---------------长安主城对话ID规划：20351~20450--------
	[20351] =             --长安城内世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =30256 ,
		txt = "我是长安车夫",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "桃园镇",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 9, tarX = 81, tarY = 91}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "徐州",   --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 118, tarX = 80, tarY = 156}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "巨鹿",  --野外地图
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 101, tarX = 93, tarY = 200}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "岐山",   --野外地图2016/7/27
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 102, tarX = 136, tarY = 118}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "黑风岭",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 104, tarX = 87, tarY = 191}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "郿坞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 106, tarX = 77, tarY = 147}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "东郡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 107, tarX = 167, tarY = 99}},--切换场景
				},
			},
			[9] =
			{
				showConditions = {},
				optionTxt = "虎牢关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 109, tarX = 186, tarY = 106}},--切换场景
				},
			},
			[10] =
			{
				showConditions = {},
				optionTxt = "潼关",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 110 , tarX = 80, tarY = 129}},--切换场景
				},
			},
			[11] =
			{
				showConditions = {},
				optionTxt = "天山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 115, tarX = 149, tarY = 128}},--切换场景
				},
			},
			[12] =
			{
				showConditions = {},
				optionTxt = "西凉",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 116, tarX = 227, tarY = 135}},--切换场景
				},
			},
			[13] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		}
	},
	[20352] =             --长安世界传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID =30257 ,
		txt = "我是长安车夫",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "宛城",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 122, tarX = 161, tarY = 153}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "寿春",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 124, tarX = 175, tarY = 59}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "河北",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 126, tarX = 147, tarY = 140}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "轩辕坟",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 127, tarX = 133, tarY = 228}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "官渡",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 128, tarX = 92, tarY = 205}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "北海",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 119, tarX = 164, tarY = 134}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "襄阳",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 14, tarX = 94, tarY = 73}},--切换场景
				},
			},
			[8] =
			{
				showConditions = {},
				optionTxt = "江夏",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 120, tarX = 114, tarY = 151}},--切换场景
				},
			},
			[9] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		}
	},
	[20353] =    -----------长安鱼店老板
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29029,
		txt = "今天刚进货的鱼，保证绝对新鲜，客官需不需要来一条？",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20354] =    -----------长安算卦先生
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29030,
		txt = "銕口直断，消灾解难，荣华富贵在我，生死有命在天。",
		options =
        {
			[1] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1326, statue = true}},	
				},
				optionTxt = "得知下落（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1378}},
				},
			},
			[2] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1327, statue = true}},	
				},
				optionTxt = "铲除强盗（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1383}},
				},
			},
			[3] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1511, statue = true}},	
				},
				optionTxt = "神器复原（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1532}},
				},
			},
			[4] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1516, statue = true}},	
				},
				optionTxt = "召唤亡灵（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1546}},
				},
			},
			[5] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1509, statue = true}},	
				},
				optionTxt = "收集龙鳞（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1524}},
				},
			},
			[6] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20355] =    -----------长安算卦先生
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29031,
		txt = "有此良田，今年的蔬果一定可以大丰收了。",
		options =
		{
			[1] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.escort, npcID = 29031}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[2] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.escort, npcID = 29031}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[3] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.escort, npcID = 29031}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[4] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.escort, npcID = 29031}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[5] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.escort, npcID = 29031}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[6] =
			{
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.escort, npcID = 29031}},
				},
				optionTxt = "迷途少女（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4824}},
				},
			},
			[7] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20356] =    -----------长安酒店老板
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29032,
		txt = "我这可是长安最大最好的酒店，客官要不要进来看看？",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20357] =   ------------长安宠物医生
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 29033,
		txt = "我是宠物医生，有受伤的宠物都可以来找我，角色20级前免费，20级后收费少量的金钱，需要帮助吗？",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "修复当前出战宠物",
				actions =
				{
					{action = DialogActionType.RepairPet, param = {},},
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "修复所有宠物",
				actions =
				{
					{action = DialogActionType.RepairAllPet, param = {},},
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "没事，打扰了",
				actions =
				{
					{action = DialogActionType.CloseDialog, param = {},},
				},
			},
		}
	},
	[20358] =    -----------长安镖师
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29034,
		txt = "想做我们这一行，就要有在刀口上谋生的准备。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 29034}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4456}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 29034}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4465}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 29034}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4474}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 29034}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4483}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 29034}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4492}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 29034}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4501}},
				},
			},
			[7] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20359] =    -----------长安杂货店
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29035,
		txt = "在长安，就属我这里的种类最多，一定有客官喜欢的商品",
		options =
		{
			[2] ={
				showConditions = {},
				optionTxt = "看看有什么卖的",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 13},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20360] =    -----------长安馒头店老板
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29036,
		txt = "我这馒头店可是老字号，保证绝对美味。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 29036}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4455}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 29036}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4464}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 29036}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4473}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 29036}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4482}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 29036}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4491}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 29036}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4500}},
				},
			},
			[7] = {
				showConditions = {},
				optionTxt = "下次再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20361] =    -----------长安武器商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29037,
		txt = "我这里有上佳的武器，保证足够锋利！",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么武器",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 15},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "下次再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20362] =    -----------长安防具商人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29038,
		txt = "没有一套好的防具，又怎么保全自己？客官来看看吧，我对我的防具有足够的信心。",
		options =
		{
			[1]={
				showConditions = {},
				optionTxt = "看看有什么防具",
				actions =
				{
					{action = DialogActionType.RequestNpcTrade , param = {npcPackID = 16},},
				},
				icon = DialogIcon.Trade,
			},
			[2] = {
				showConditions = {},
				optionTxt = "下次再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20363] =        ---长安仓库管理员
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29039,
		txt = "如果觉得身上累赘太多，客官可以存一些在我这里。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "存放物品",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "DepotWin"},},--打开物品仓库
				},
				icon = DialogIcon.Box,
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "存放宠物",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {},},--打开宠物仓库
				},
				icon = DialogIcon.Box,
			},
		},
	},
	[20364] =    -----------长安王允
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20701,
		txt = "屈膝家妓为汉君，宣平楼下毁奸臣。为天下苍生，我司徒王允愿尽一己之力，誓讨汉贼！",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4458}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4467}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4476}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4485}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4494}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 20701}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4503}},
				},
			},
			 [7] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20701}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5079,5174,5190,5206,5222}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5174,5190,5206,5222}}},
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "久仰大名，我先告退。",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20365] =    -----------长安-杨文辉
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 27075,
		txt = "天下大势，分久必合，合久必分！",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4452}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4461}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4470}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4479}},
				},
			},
			[5] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4488}},
				},
			},
			[6] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.deliverLetters, npcID = 27075}},
				},
				optionTxt = "掌门的信（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4497}},
				},
			},
			[7] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 27075}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5080,5175,5191,5207,5223}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5175,5191,5207,5223}}},
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "稍后再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	------------------玄都玉京npc对话规划：20451~20500------------
	[20451] =             --玄都玉京莲花童子传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20003,
		txt = "阐教弟子，我可以送你下凡。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[8] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 1168, statue = true}},	
				},
				optionTxt = "灭魂珠（主线任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 1166}},
				},
			},
			[9] = {
				showConditions = {},
				optionTxt = "我还要再走走",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20452] =    -----------元始天尊
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 20002,
		txt = "道者，累劫良因之无极圣众，于是现运神通，摄众圣道，藏于万气祖根里，纳于粟米之中，于无极而收，六电之气翼其真，祖气护养润其神，积七千余劫，太极经咸应度，无极圣众始布太极。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20453] =    -----------白鹤童子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 20001,
		txt = "元者，本也；始者，初也，先天之气也。此气化为开辟世界之人，即为盘古；化为主持天界之祖，即为元始。吾师存于开天之始，汝为师尊选定之人，必有过人之处。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	---------乾元岛npc对话ID规划：20501~20550
	[20501] =             --乾元岛门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29050,
		txt = "乾元岛景致秀丽，你可四处游玩一番，若要离开我可以送你一程",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我再转转",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20502] =    -----------乾元岛掌门
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20004,
		txt = "流光绯火比月华，刀锋刃影正气浩。龙战凌霄谁人敌，诛邪降魔未曾怕。",
		options =
		{
			[1] = {
				showConditions = 
				{	
				 {condition = DialogCondition.School, param = {school = SchoolType.QYD}},
				},
				optionTxt = "师门任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4202}},
				},
			},
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.catchPet, npcID = 20004}},
				},
				optionTxt = "上交宠物（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4551}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.buyItem, npcID = 20004}},
				},
				optionTxt = "上交道具（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4601}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001, taskType = LoopTaskTargetType.itemTalk, npcID = 20004}},
				},
				optionTxt = "下山之行（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4781}},
				},
			},
			[5] = {
				showConditions = {},
				optionTxt = "弟子先退下",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20503] =    -----------乾元岛长老
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29059,
		txt = "身为本派弟子，当一身正气，斩妖除魔，以匡扶天道为己任，才无愧于天下。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20504] =    -----------乾元岛大弟子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20021,
		txt = "修道当脚踏实地，切不可急功近利，打好基础最为重要。",
		options =
		{
			[1] = {
				showConditions = {
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001,taskType = LoopTaskTargetType.brightMine,npcID = 20021}},	
				},
				optionTxt = "挑战大弟子（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4271}},
				},
			},
			[2] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20021}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5083,5178,5194,5210,5226}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5178,5194,5210,5226}}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},

	[20505] =    -----------乾元岛执法长老
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29066,
		txt = "要上阵杀敌武艺不可不精，平时要多磨炼自己才行！",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10001,taskType = LoopTaskTargetType.brightMine,npcID = 29066}},
				},
				optionTxt = "挑战长老（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4272}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20506] =    -----------乾元岛精英弟子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29072,
		txt = "大哉乾元，万物资始，乃统天。乾元即为天下，乾元弟子当为天下而战。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	---------桃源洞npc对话ID规划：20551~20600-----------
	[20551] =             --桃源洞门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29051,
		txt = "桃源洞建于两仪之上，两仪步步玄机，你不妨四处转转，若要离开，我可以送你一程。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我要再转转",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20552] =    -----------桃源洞掌门
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20005,
		txt = "扇动九霄江山定，流水若云何见欢。画地空把情仇忘，亦真亦幻逍遥叹。",
		options =
		{
			[1] = {
				showConditions = 
				{
				 {condition = DialogCondition.School, param = {school = SchoolType.TYD}},
				},
				optionTxt = "师门任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4210}},
				},
			},			
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.catchPet, npcID = 20005}},
				},
				optionTxt = "上交宠物（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4559}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.buyItem, npcID = 20005}},
				},
				optionTxt = "上交道具（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4609}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005, taskType = LoopTaskTargetType.itemTalk, npcID = 20005}},
				},
				optionTxt = "下山之行（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4789}},
				},
			},
			[5] = {
				showConditions = {},
				optionTxt = "弟子先告退",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20553] =    -----------桃源洞长老
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29060,
		txt = "身为本派弟子，当一身正气，斩妖除魔，以匡扶天道为己任，才无愧于天下。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20554] =    -----------桃源洞大弟子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20025,
		txt = "修行当步步为营，切勿急功近利，此乃修行之根本。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005,taskType = LoopTaskTargetType.brightMine,npcID = 20025}},
				},
				optionTxt = "挑战大弟子（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4283}},
				},
			},			 
			 [2] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20025}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5086,5181,5197,5213,5229}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5181,5197,5213,5229}}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20555] =    -----------桃源洞执法长老
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29067,
		txt = "桃源道术玄妙无比，当用于正道之上，否则后患无穷，切记切记。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10005,taskType = LoopTaskTargetType.brightMine,npcID = 29067}},
				},
				optionTxt = "挑战长老（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4284}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20556] =    -----------桃源洞精英弟子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29073,
		txt = "桃源道法最是奇妙，你需仔细琢磨，方可识得其妙处。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	---------金霞山npc对话ID规划：20601~20650-----------
	[20601] =             --金霞山门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29052,
		txt = "大漠西风、长烟落日的风光很不一样吧？有空你可到处看看，若要离开我可以送你一程。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我要再转转",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20602] =    -----------金霞山掌门
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20006,
		txt = "长枪一横动山河，孤骑九连破乾坤。诛尽妖邪金霞义，封神拜将永留名。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.School, param = {school = SchoolType.JXS}},
				},
				optionTxt = "师门任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4204}},
				},
			},			
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.catchPet, npcID = 20006}},
				},
				optionTxt = "上交宠物（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4553}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.buyItem, npcID = 20006}},
				},
				optionTxt = "上交道具（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4603}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002, taskType = LoopTaskTargetType.itemTalk, npcID = 20006}},
				},
				optionTxt = "下山之行（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4783}},
				},
			},
			[5] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20603] =    -----------金霞山长老
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29061,
		txt = "身为本派弟子，当一身正气，斩妖除魔，以匡扶天道为己任，才无愧于天下。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20604] =    -----------金霞山大弟子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20023,
		txt = "修行当步步为营，切勿急功近利，此乃修行之根本。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002,taskType = LoopTaskTargetType.brightMine,npcID = 20023}},	
				},
				optionTxt = "挑战大弟子（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4274}},
				},
			},			 
			[2] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20023}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5085,5180,5196,5212,5228}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5180,5196,5212,5228}}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20605] =    -----------金霞山执法长老
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29068,
		txt = "拜于金霞山山下，当无惧马革裹尸之苦，以战死沙场为荣。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10002,taskType = LoopTaskTargetType.brightMine,npcID = 29068}},
				},
				optionTxt = "挑战长老（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4275}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20606] =    -----------金霞山精英弟子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29074,
		txt = "本派兵刃以枪为主，乃上阵杀敌首选兵器。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	---------蓬莱阁npc对话ID规划：20651~20700-----------
	[20651] =             --蓬莱阁门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29053,
		txt = "蓬莱阁景色端庄，你可游玩一番，若要离开，我可以送你一程。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我要再转转",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20652] =    -----------蓬莱阁掌门
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20007,
		txt = "凌霜凝天照沧海，青丝沁心雪满衣。济世悬壶怜众生，医心如仙动人间。",
		options =
		{
			[1] = {
				showConditions = 
				{
			        {condition = DialogCondition.School, param = {school = SchoolType.PLG}},
				},
				optionTxt = "师门任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4212}},
				},
			},			
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.catchPet, npcID = 20007}},
				},
				optionTxt = "上交宠物（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4561}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.buyItem, npcID = 20007}},
				},
				optionTxt = "上交道具（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4611}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006, taskType = LoopTaskTargetType.itemTalk, npcID = 20007}},
				},
				optionTxt = "下山之行（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4791}},
				},
			},
			[5] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20653] =    -----------蓬莱阁长老
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29062,
		txt = "身为本派弟子，当一身正气，斩妖除魔，以匡扶天道为己任，才无愧于天下。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20654] =    -----------蓬莱阁大弟子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20022,
		txt = "修行当步步为营，切勿急功近利，此乃修行之根本。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006,taskType = LoopTaskTargetType.brightMine,npcID = 20022}},
				},
				optionTxt = "挑战大弟子（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4286}},
				},
			},
		    [2] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20022}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5084,5179,5195,5211,5227}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5179,5195,5211,5227}}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20655] =    -----------蓬莱阁执法长老
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29069,
		txt = "医者，善可救活一方，恶可毒害百里，谨记不可用错方向。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10006,taskType = LoopTaskTargetType.brightMine,npcID = 29069}},
				},
				optionTxt = "挑战长老（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4287}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20656] =    -----------蓬莱阁精英弟子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29075,
		txt = "蓬莱阁以救治天下为己任，好施行善方是我阁核心。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	---------紫阳门npc对话ID规划：20701~20750-----------
	[20701] =             --紫阳门门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29054,
		txt = "紫阳门居于群山之中，气候多变，道路难行，若要离开，我可以送你一程。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "云霄宫",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 5, tarX = 51, tarY = 58}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我要再转转",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20702] =    -----------紫阳门掌门
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20008,
		txt = "一箭凌云震九州，长虹贯日合八荒。点落四方日月避，风散浮云人间寂。",
		options =
		{
			[1] = {
				showConditions = 
				{
				 {condition = DialogCondition.School, param = {school = SchoolType.ZYM}},
				},
				optionTxt = "师门任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4206}},
				},
			},			
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.catchPet, npcID = 20008}},
				},
				optionTxt = "上交宠物（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4555}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.buyItem, npcID = 20008}},
				},
				optionTxt = "上交道具（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4605}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003, taskType = LoopTaskTargetType.itemTalk, npcID = 20008}},
				},
				optionTxt = "下山之行（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4785}},
				},
			},
			[5] = {
				showConditions = {},
				optionTxt = "弟子告退",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20703] =    -----------紫阳门长老
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29063,
		txt = "身为本派弟子，当一身正气，斩妖除魔，以匡扶天道为己任，才无愧于天下。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20704] =    -----------紫阳门大弟子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20026,
		txt = "修行当步步为营，切勿急功近利，此乃修行之根本。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003,taskType = LoopTaskTargetType.brightMine,npcID = 20026}},
				},
				optionTxt = "挑战大弟子（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4277}},
				},
			},			 
			 [2] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20026}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5088,5183,5199,5215,5231}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5183,5199,5215,5231}}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20705] =    -----------紫阳门执法长老
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29070,
		txt = "紫阳箭术举世无双，百步穿杨也不在话下。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10003,taskType = LoopTaskTargetType.brightMine,npcID = 29070}},
				},
				optionTxt = "挑战长老（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4278}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20706] =    -----------紫阳门精英弟子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29076,
		txt = "紫阳门专于弓射之道，取敌首级与千里之外。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	-----------云霄宫npc对话ID规划：20751~20800
	[20751] =             --云霄宫门派传送npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29055,
		txt = "云霄宫依山而建，风景别有一番滋味，你可以到处走走。若要离开，我可以送你一程。",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "金霞山",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 3, tarX = 132, tarY = 70}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "蓬莱阁",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 2, tarX = 84, tarY = 31}},--切换场景
				},
			},
			[3] =
			{
				showConditions = {},
				optionTxt = "乾元岛",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 1, tarX = 85, tarY = 64}},--切换场景
				},
			},
			[4] =
			{
				showConditions = {},
				optionTxt = "桃源洞",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 4, tarX = 108, tarY = 62}},--切换场景
				},
			},
			[5] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
			[6] =
			{
				showConditions = {},
				optionTxt = "紫阳门",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 6, tarX = 103, tarY = 61}},--切换场景
				},
			},
			[7] =
			{
				showConditions = {},
				optionTxt = "玄都玉京",
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 8, tarX = 101, tarY = 142}},--切换场景
				},
			},
			[8] = {
				showConditions = {},
				optionTxt = "我要再转转",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20752] =    -----------云霄宫掌门
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 20009,
		txt = "日落星沉眏苍茫，剑挽天华惊波澜。绿琦拂过空虚有，却笑桃园在梦中。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.School, param = {school = SchoolType.YXG}},
				},
				optionTxt = "师门任务",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4208}},
				},
			},			
			[2] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.catchPet, npcID = 20009}},
				},
				optionTxt = "上交宠物（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4557}},
				},
			},
			[3] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.buyItem, npcID = 20009}},
				},
				optionTxt = "上交道具（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4607}},
				},
			},
			[4] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004, taskType = LoopTaskTargetType.itemTalk, npcID = 20009}},
				},
				optionTxt = "下山之行（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4787}},
				},
			},
			[5] = {
				showConditions = {},
				optionTxt = "弟子告退",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20753] =    -----------云霄宫长老
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29064,
		txt = "身为本派弟子，当一身正气，斩妖除魔，以匡扶天道为己任，才无愧于天下。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	[20754] =    -----------云霄宫大弟子
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20024,
		txt = "修行当步步为营，切勿急功近利，此乃修行之根本。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004,taskType = LoopTaskTargetType.brightMine,npcID = 20024}},
				},
				optionTxt = "挑战大弟子（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4280}},
				},
			},			 
			 [2] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 20024}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5087,5182,5198,5214,5230}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5182,5198,5214,5230}}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20755] =    -----------云霄宫执法长老
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29071,
		txt = "云霄功法在于心，心之所向，剑锋所指，则攻敌所必胜。",
		options =
		{
			[1] = {
				showConditions = 
				{
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10004,taskType = LoopTaskTargetType.brightMine,npcID = 29071}},
				},
				optionTxt = "挑战长老（师门任务）",
				actions =
				{
				{action = DialogActionType.Goto, param = {dialogID = 4281}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20756] =    -----------云霄宫精英弟子
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29077,
		txt = "云霄宫素来不管世俗，若非有妖魔作乱，云霄弟子不会轻易下山。",
		options =
		{
			{
				showConditions = {},
				actions =
				{
				},
			}
		},
	},
	--------------------其他特殊npc对话ID：20801~20850
	[20801] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			{condition = DialogCondition.Faction, param = {factionDBID = 1}},
		},
		speakerID = 29048,
		txt = "忠义为首，肝胆相照。帮会的宗旨就是这样的，你认为呢？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "进入我的帮派领地",
				actions =
				{
					{action = DialogActionType.EnterFactionScene , param ={tarX = 86, tarY = 68}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20802] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			{condition = DialogCondition.Faction, param = {factionDBID = 0}},
		},
		speakerID = 29048,
		txt = "忠义为首，肝胆相照。帮会的宗旨就是这样的，你认为呢？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "创建新帮派",
				actions =
				{
					{action = DialogActionType.CreateFaction , param = {v = "FactionCreateWin"},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "查看帮派列表",
				actions =
				{
					{action = DialogActionType.ShowFactionList , param = {v = "FactionListWin"},},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20803] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			
		},
		speakerID = 29049,
		txt = "TP？？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "传送到洛阳城",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 134, tarY = 204}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20804] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			
		},
		speakerID = 29078,
		txt = "谢谢你长得这么帅还点我",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "帮会捐献",
				actions =
				{
					{action = DialogActionType.ContributeFaction , param ={v = "FactionContributeWin"}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	--------------------其他特殊npc对话ID：20851~21000--------
	[20851] =             --主线35-36青峰山传送人
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20834,
		txt = "我可以送你们去洛阳，确定要去么！",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "洛阳",  --主城
				actions =
				{
					{action = DialogActionType.SwithScene ,param = {tarMapID  = 10, tarX = 200, tarY = 200}},--切换场景
				},
			},
		},
	},
	[20852] =            -------------主线任务35-36传送青峰山
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.HasTasks, param = {taskIDs = {1311,1313,1315,1317,1319,1321,1328,1339}, statue = true}},	
		},
		speakerID = 29055,
		txt = "阐教弟子，我可以送你到青峰山。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "青峰山",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 129, tarX = 121, tarY = 34}},
				},
			},

		},
	},
	[20853] =             -------------主线任务35-36，任务ID1328，上交物品。
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1328, statue = true}},	
		},
		speakerID = 20829,
		soundID = nil,
		txt = "你找到炼制秘符的材料了么！",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "上交材料",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1328,itemsInfo = {{itemID = 1041001, count = 1},{itemID = 1041002, count = 1},{itemID = 1041003, count = 1},{itemID = 1041004, count = 1}}},},
				},
			},
		},
	},
	[20854] =             -------------主线任务33-34，任务ID1328，上交物品。
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		{condition = DialogCondition.HasTask, param = {taskID = 1223, statue = true}},	
		},
		speakerID = 20711,
		soundID = nil,
		txt = "你可有拿到天山雪莲？",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "上交材料",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 1223,itemsInfo = {{itemID = 1041014, count = 1}}},},
				},
			},
		},
	},
	----门派闯关活动

	[20860] =    -----------门派闯关使者
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50050,
		txt = "若能在门派闯关活动中脱颖而出，势必得到六大仙门共同嘉奖，道友可要一试？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "弟子已准备周全！（接受任务）",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我就看看热闹。",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20861] =    -----------乾元岛护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50051,
		txt = "守护山门安全，乃我辈本分。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "请赐教",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20862] =    -----------乾元岛护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50052,
		txt = "守护山门安全，乃我辈本分。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "请赐教",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20863] =    -----------乾元岛护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50053,
		txt = "守护山门安全，乃我辈本分。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "请赐教",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20864] =    -----------乾元岛护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50054,
		txt = "守护山门安全，乃我辈本分。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "请赐教",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20865] =    -----------乾元岛护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50055,
		txt = "守护山门安全，乃我辈本分。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "请赐教",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[20866] =    -----------乾元岛护法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 50056,
		txt = "守护山门安全，乃我辈本分。",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "请赐教",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
----------------------------我是副本分割线，上面是常驻NPC对话，下面是副本-----------------------------------
	[3000] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30001,
		soundID = 26142 ,
		txt = "此地乃吾等镇守，想要见李傕大人，先过我这关！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3001}},
				},
			}

		},
	},
	[3001] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26143 ,
		txt = "找的便是李傕，今日吾必将诛杀此恶贼！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3001 ,mapID =600},},
				},
			}

		},
	},
	[3002] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30006,
		soundID =26146 ,
		txt = "胆敢打扰李傕大人大计，受死吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3003}},
				},
			}

		},
	},
	[3003] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26147 ,
		txt = "先击杀你等，再去诛杀李傕！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3002 ,mapID =600},},
				},
			}

		},
	},
	[3004] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30011,
		soundID =26150 ,
		txt = "此地乃吾等镇守，想要见李傕大人，先过我这关！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3005}},
				},
			}

		},
	},
	[3005] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26151 ,
		txt = "贼心不改，那就先击杀了你，再去找李傕算账！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3003 ,mapID =600},},
				},
			}

		},
	},
	[3006] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30016,
		soundID =26154 ,
		txt = "竟敢闯入李傕大人驻守之地，受死吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3007}},
				},
			}

		},
	},
	[3007] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26155 ,
		txt = "李傕究竟在何处，说出来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3004 ,mapID =600},},
				},
			}

		},
	},
	[3008] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30021,
		soundID =26158 ,
		txt = "李傕大人复活主公大成在即，岂容你来破坏!",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3009}},
				},
			}

		},
	},
	[3009] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26159 ,
		txt = "找的便是李傕，速速让开!",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3005 ,mapID =600},},
				},
			}

		},
	},
	[3010] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30026,
		soundID =26162 ,
		txt = "小贼！胆敢阻挠我复活吾主董卓大计，今日必将把你碎尸万段！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3011}},
				},
			}

		},
	},
	[3011] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26163 ,
		txt = "竟然妄想复活如此罪大恶极之人，今日岂能让你如愿！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3006 ,mapID =600},},
				},
			}

		},
	},
	[3012] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 20019,
		txt = "修复宠物要消耗绑银和金钱的哦",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "修复当前出战宠物",
				actions =
				{
					{action = DialogActionType.RepairPet ,param = {}},--切换场景
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "修复所有宠物",
				actions =
				{
					{action = DialogActionType.RepairAllPet, param = {}},
				},
			}
		},
	},

	[3013] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30070,
		soundID =26168 ,
		txt = "什么人!竟敢来此地破坏郭汜大人的计划!不想活了!",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3014}},
				},
			}

		},
	},
	[3014] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26169 ,
		txt = "找的便是郭汜!将郭汜下落告诉我,饶你不死!",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3007 ,mapID =602},},
				},
			}

		},
	},
	[3015] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30075,
		soundID =26172 ,
		txt = "胆敢闯入到天牢山中来，纳命来吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3016}},
				},
			}

		},
	},
	[3016] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26173 ,
		txt = "先击杀了你们，再去找诛杀郭汜！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3008 ,mapID =602},},
				},
			}

		},
	},
	[3017] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30080,
		soundID =26176 ,
		txt = "有本将在此驻守天牢山，尔等小贼休得嚣张！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3018}},
				},
			}

		},
	},
	[3018] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26177 ,
		txt = "来的好，快说！郭汜究竟在何处！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3009 ,mapID =602},},
				},
			}

		},
	},
	[3019] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30085,
		soundID =26180 ,
		txt = "哪里来的小贼，竟然妄想阻止郭汜大人大计！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3020}},
				},
			}

		},
	},
	[3020] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26181 ,
		txt = "叫郭汜速速出来受死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3010 ,mapID =602},},
				},
			}

		},
	},
	[3021] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30090,
		soundID =26184 ,
		txt = "奉郭汜大人令，特来此击杀埋伏于你，纳命来吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3022}},
				},
			}

		},
	},
	[3022] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26185 ,
		txt = "只会派一些小兵过来送死，郭汜不敢亲自过来吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3011 ,mapID =602},},
				},
			}

		},
	},
	[3023] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30095,
		soundID =26188 ,
		txt = "又是你，屡屡坏我好事，今日胆敢阻止我复活主公计划，吾必让你魂飞魄散！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3024}},
				},
			}

		},
	},
	[3024] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26189 ,
		txt = "郭汜，你既如此执迷不悟，今日我便替天行道！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3012 ,mapID =602},},
				},
			}

		},
	},

-------------------------------------------------------

	[3060] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30181,
		soundID =26194 ,
		txt = "魔魂峰乃樊稠大人驻守之地，闯入者死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3061}},
				},
			}

		},
	},
	[3061] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26195 ,
		txt = "找的便是樊稠！让他速速出来受死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3017 ,mapID =606},},
				},
			}

		},
	},

[3063] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30160,
		soundID =26198 ,
		txt = "本将奉樊稠大人令在此护法，擅闯者杀！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3064}},
				},
			}

		},
	},
	[3064] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26199 ,
		txt = "樊稠在何处，速速招来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3018 ,mapID =606},},
				},
			}

		},
	},

[3065] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30165,
		soundID =26202 ,
		txt = "吾乃樊稠护卫队长是也，你是何人，胆敢擅闯樊稠大人驻守之地！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3066}},
				},
			}

		},
	},
	[3066] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26203 ,
		txt = "樊稠藏在何处，快快道来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3019 ,mapID =606},},
				},
			}

		},
	},

[3067] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30170,
		soundID =26206 ,
		txt = "奉樊稠大人令在此伏击，尔等受死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3068}},
				},
			}

		},
	},
	[3068] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26207 ,
		txt = "樊稠只会派手下来送死，这等鼠辈今日吾必将其诛杀！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3020 ,mapID =606},},
				},
			}

		},
	},

[3069] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30175,
		soundID =26210 ,
		txt = "站住，你竟敢来此破坏樊稠大人大计，今日定不饶你！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3070}},
				},
			}

		},
	},
	[3070] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26211 ,
		txt = "樊稠今日我必诛杀，你们速速让开！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3021 ,mapID =606},},
				},
			}

		},
	},


[3071] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30180,
		soundID =26214 ,
		txt = "小贼，竟然阻挠我复活主公董卓大计，今日定要你生不如死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3072}},
				},
			}

		},
	},
	[3072] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26215 ,
		txt = "樊稠！你居然还妄图复活董卓为祸人间，今日我便替天行道！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3022 ,mapID =606},},
				},
			}

		},
	},
		---潜龙岭

[3075] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30321,
		soundID =26220 ,
		txt = "李儒大人驻守之地，外人不可擅闯！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3076}},
				},
			}

		},
	},
[3076] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26221 ,
		txt = "找的就是李儒，今日定要将尔等恶贼消灭殆尽！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3025 ,mapID =607},},
				},
			}

		},
	},

[3077] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30329,
		soundID =26224 ,
		txt = "激怒李儒大人可没有好果子吃，识相的就乖乖离开这里！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3078}},
				},
			}

		},
	},
[3078] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26225 ,
		txt = "李儒项上人头我非取不可，尔等若想活命，就莫横加阻拦！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3026 ,mapID =607},},
				},
			}

		},
	},

[3079] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30337,
		soundID =26228 ,
		txt = "小贼竟妄图阻挠李儒大人，休想活着离开此处！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3080}},
				},
			}

		},
	},
[3080] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26229 ,
		txt = "李儒那老贼死期已至，尔等还敢大放厥词！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3027 ,mapID =607},},
				},
			}

		},
	},

[3081] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30345,
		soundID =26232 ,
		txt = "誓死护卫大人周全，谁敢威胁大人性命，立即处死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3082}},
				},
			}

		},
	},
[3082] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26233 ,
		txt = "螳臂当车，愚不可及。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3028 ,mapID =607},},
				},
			}

		},
	},


[3083] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30353,
		soundID =26236 ,
		txt = "休想近李儒大人的身，除非先击败老夫！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3084}},
				},
			}

		},
	},
[3084] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26237 ,
		txt = "那便让我来试试你的身手！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3029 ,mapID =607},},
				},
			}

		},
	},


[3085] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30361,
		soundID =26240 ,
		txt = "又是你这贼子，今日定要将你挫骨扬灰方可消我心头之恨！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=3086}},
				},
			}

		},
	},
[3086] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26241 ,
		txt = "李儒，你大难临头还逞口舌之利，找死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3030 ,mapID =607},},
				},
			}

		},
	},

---------------------------------------------副本鬼凤峡对话配置--------------------
[10001] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30428,
		soundID =26246 ,
		txt = "站住！你是何人？胆敢闯入鬼凤峡，活得不耐烦了？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10002}},
				},
			}

		},
	},
	[10002] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26247 ,
		txt = "我来找那波才贼子，叫他速速出来受死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3031 },},
				},
			}

		},
	},
[10003] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30428,
		soundID =26248 ,
		txt = "何人敢来鬼凤峡撒野！定杀不饶！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10004}},
				},
			}

		},
	},
	[10004] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26249 ,
		txt = "今奉朝廷之令平灭你等，受死吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3032 },},
				},
			}

		},
	},
[10005] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30436,
		soundID =26250 ,
		txt = "朝廷鹰犬，竟敢闯入天军驻地，自寻死路！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10006}},
				},
			}

		},
	},
	[10006] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26251 ,
		txt = "区区小贼，竟敢阻我？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3033 },},
				},
			}

		},
	},
[10007] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30444,
		soundID =26252 ,
		txt = "黄巾天军在此，还不速速死来？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10008}},
				},
			}

		},
	},
	[10008] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26253 ,
		txt = "一群乌合之众竟敢狂吠！杀你们如杀鸡屠狗！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3034 },},
				},
			}

		},
	},
[10009] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30452,
		soundID =26254 ,
		txt = "我等奉将军令，将你剁碎了，祭天！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10010}},
				},
			}

		},
	},
	[10010] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26255 ,
		txt = "波才藏在何处，速速道来！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3035 },},
				},
			}

		},
	},
[10012] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30460,
		soundID =26256 ,
		txt = "汉朝小贼，今日我神功有成，看你有几分峥嵘，还不速速归降我太平道。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10013}},
				},
			}

		},
	},
	[10013] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26257 ,
		txt = "从来汉贼不两立，多说无益，借你项上人头一用！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3036 },},
				},
			}

		},
	},


------------------------碧波岛副本对话配置-------------------------

[10014] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30510,
		soundID =26260 ,
		txt = "此乃黄巾天军驻守之地，敢擅闯者杀！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10015}},
				},
			}

		},
	},
	[10015] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26261 ,
		txt = "张曼成在何处？快快道来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3037 ,mapID =609},},
				},
			}

		},
	},
[10016] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30518,
		soundID =26262 ,
		txt = "你是何人？竟敢擅闯兵家重地，还不速速就擒！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10017}},
				},
			}

		},
	},
	[10017] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26263 ,
		txt = "我来此找那张曼成逆贼，你等退开，否则休怪我刀下无情！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3038 ,mapID =609},},
				},
			}

		},
	},
[10018] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30526,
		soundID =26264 ,
		txt = "站住！你竟敢闯我天军军阵，今日定要你魂归九泉！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10019}},
				},
			}

		},
	},
	[10019] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26265 ,
		txt = "区区黄巾逆贼，我看今日谁敢阻我！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3039 ,mapID =609},},
				},
			}

		},
	},
[10020] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30534,
		soundID =26266 ,
		txt = "鹰犬爪牙，竟敢杀我将士，我必将你碎尸万段！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10021}},
				},
			}

		},
	},
	[10021] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26267 ,
		txt = "乌合之众，何敢言勇？挡我者，杀无赦！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3040 ,mapID =609},},
				},
			}

		},
	},
[10022] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30542,
		soundID =26268 ,
		txt = "某家奉韩将军令在此镇守，何人敢撄天军锋芒！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10023}},
				},
			}

		},
	},
	[10023] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26269 ,
		txt = "尽是些小兵卒子，张曼成何不亲自前来，难道我手中兵刃不利吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3041 ,mapID =609},},
				},
			}

		},
	},
[10024] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30550,
		soundID =26270 ,
		txt = "我乃黄巾军大将张曼成是也！今日神功告成，何人想要自寻死路？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10025}},
				},
			}

		},
	},
	[10025] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26271 ,
		txt = "逆贼猖狂！今日定要将你斩于刀下！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3042 ,mapID =609},},
				},
			}

		},
	},

------------------------冰风原副本对话配置-------------------------

[10030] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30650,
		soundID =26274 ,
		txt = "此处为我黄巾军驻地，来者止步，擅闯者杀！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10031}},
				},
			}

		},
	},
	[10031] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26275 ,
		txt = "今日我来取张燕性命，老匹夫可敢出来一战！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3045 ,mapID =610},},
				},
			}

		},
	},
[10032] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30658,
		soundID =26276 ,
		txt = "何人敢惊扰张将军修炼之地，此乃死罪！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10033}},
				},
			}

		},
	},
	[10033] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26277 ,
		txt = "你等无名小辈，岂能阻我？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3046 ,mapID =610},},
				},
			}

		},
	},
[10034] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30526,
		soundID =26278 ,
		txt = "本将奉张燕大人令在此护法，闯入者死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10035}},
				},
			}

		},
	},
	[10035] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26279 ,
		txt = "今日哪怕龙潭虎穴也要闯一闯，区区不毛之地有何惧哉！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3047 ,mapID =610},},
				},
			}

		},
	},
[10036] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30534,
		soundID =26280 ,
		txt = "胆敢擅闯我冰风原，不知死活！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10037}},
				},
			}

		},
	},
	[10037] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26281 ,
		txt = "闯了又当如何？杀的就是你！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3048 ,mapID =610},},
				},
			}

		},
	},
[10038] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30542,
		soundID =26282 ,
		txt = "朝廷走狗，要见将军需过我这一关！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10039}},
				},
			}

		},
	},
	[10039] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26283 ,
		txt = "好！先杀了你，再去取那张燕狗命！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3049 ,mapID =610},},
				},
			}

		},
	},
[10040] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30550,
		soundID =26284 ,
		txt = "小贼，你杀我将士，辱我声名，此仇不共戴天！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10041}},
				},
			}

		},
	},
	[10041] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26285 ,
		txt = "张燕尔等逆贼烧杀抢掠，无恶不作，今日我替天行道，剿灭尔等！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3050 ,mapID =610},},
				},
			}

		},
	},
--------------------------魔罗峰副本配置-------------------------
[10045] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30740,
		soundID =26288 ,
		txt = "站住！此乃黄巾军重地，擅入此地者杀无赦！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10046}},
				},
			}

		},
	},
	[10046] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26289 ,
		txt = "张角今在何处？从实招来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3055 ,mapID =611},},
				},
			}

		},
	},
[10047] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30748,
		soundID =26290 ,
		txt = "你是何人？敢来魔罗峰撒野，纳命来！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10048}},
				},
			}

		},
	},
	[10048] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26291 ,
		txt = "一群乌合之众，杀你们如探囊取物！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3056 ,mapID =611},},
				},
			}

		},
	},
[10049] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30756,
		soundID =26292 ,
		txt = "朝廷鹰犬，视我黄巾军无人乎？今日定要将你开膛破肚！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10050}},
				},
			}

		},
	},
	[10050] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26293 ,
		txt = "区区一群盗贼流氓，何足道哉？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3057 ,mapID =611},},
				},
			}

		},
	},
[10051] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30764,
		soundID =26294 ,
		txt = "本将在此镇守，岂容你冲撞大人法驾！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10052}},
				},
			}

		},
	},
	[10052] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26295 ,
		txt = "今日我定要那张角逆贼灰飞烟灭，尸骨无存，谁敢拦我？！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3058 ,mapID =611},},
				},
			}

		},
	},
[10053] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30772,
		soundID =26296 ,
		txt = "乳臭未干的小儿，竟敢妄图坏大贤师修炼，问过我手中的刀了吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10054}},
				},
			}

		},
	},
	[10054] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26297 ,
		txt = "悖逆狂徒，看我将你等杀个片甲不留！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3059 ,mapID =611},},
				},
			}

		},
	},
[10055] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30780,
		soundID =26298 ,
		txt = "小儿！来得正好！吾手中尚缺几份祭品，今日便用尔等性命助我练成神功，再立黄天！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10056}},
				},
			}

		},
	},
	[10056] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26299 ,
		txt = "张角，你倒行逆施，恶贯满盈，今天我奉天命以讨不臣，秉生民以诛邪恶，定要你尸骨不存，万劫不复！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3060 ,mapID =611},},
				},
			}

		},
	},


---------------邪盘山副本配置，像我这么萌的，还有200窝------------------------------


[10057] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30825,
		soundID =26288 ,
		txt = "来者何人？胆敢闯入邪盘山，嫌命长了吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10058}},
				},
			}

		},
	},
	[10058] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26289 ,
		txt = "徐荣正在何处，快快道来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3061 ,mapID =612},},
				},
			}

		},
	},
[10059] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30833,
		soundID =26290 ,
		txt = "什么人竟敢闯入我西凉军驻地，还不束手就擒！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10060}},
				},
			}

		},
	},
	[10060] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26291 ,
		txt = "叫那徐荣前来见我，不然留你不得！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3062 ,mapID =612},},
				},
			}

		},
	},
[10061] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30841,
		soundID =26292 ,
		txt = "我奉将军之令在此镇守，谁敢闯关？！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10062}},
				},
			}

		},
	},
	[10062] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26293 ,
		txt = "今日我定要斩杀徐荣，挡我者死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3063 ,mapID =612},},
				},
			}

		},
	},
[10063] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30849,
		soundID =26294 ,
		txt = "大胆狗贼！竟敢意图对将军不利！今日定不饶你！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10064}},
				},
			}

		},
	},
	[10064] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26295 ,
		txt = "徐荣那无胆匪类，杀的就是他！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3064 ,mapID =612},},
				},
			}

		},
	},
[10065] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30857,
		soundID =26296 ,
		txt = "我乃徐大人门下客卿，阁下还请留下性命！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10066}},
				},
			}

		},
	},
	[10066] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26297 ,
		txt = "鸡鸣狗盗之辈，快快上前领死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3065 ,mapID =612},},
				},
			}

		},
	},
[10067] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30865,
		soundID =26298 ,
		txt = "徐某人在此！何人敢阻挠我家主公大计！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10068}},
				},
			}

		},
	},
	[10068] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26299 ,
		txt = "乱臣贼子！还敢妄图东山再起，我看你今日自身难保，纳命来吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3066 ,mapID =612},},
				},
			}

		},
	},
------------------------------------------------毒龙峰副本对话--------------------

[10069] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30890,
		soundID =26317 ,
		txt = "将军命我来巡山，你是何人，来我毒龙峰所为何事？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10070}},
				},
			}

		},
	},
	[10070] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26318 ,
		txt = "我奉命来此找那牛辅老贼，拿他性命！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3070 ,mapID =613},},
				},
			}

		},
	},
[10071] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30898,
		soundID =26319 ,
		txt = "阵前何人，胆敢闯入我西凉军驻守之地，还不束手就擒！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10072}},
				},
			}

		},
	},
	[10072] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26320 ,
		txt = "牛辅现在何处，从实道来，饶你们一命！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3071 ,mapID =613},},
				},
			}

		},
	},
[10073] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30906,
		soundID =26321 ,
		txt = "我乃牛辅手下大将胡赤儿，你等竟敢闯入西凉大军驻地，看我今天活劈了你！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10074}},
				},
			}

		},
	},
	[10074] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26322 ,
		txt = "大胆贼子，竟敢口出狂言，看看今天是你死，还是我活！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3072 ,mapID =613},},
				},
			}

		},
	},
[10075] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30914,
		soundID =26323 ,
		txt = "此地乃牛辅大人闭关之地，宵小止步！否则定斩不饶！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10076}},
				},
			}

		},
	},
	[10076] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26324 ,
		txt = "来此就是要杀了牛辅老贼，谁挡我，我杀谁！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3073 ,mapID =614},},
				},
			}

		},
	},
[10077] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30922,
		soundID =26325 ,
		txt = "我奉大人命率军前来击杀你，还不速速受死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10078}},
				},
			}

		},
	},
	[10078] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "说了杀牛辅，就要杀牛辅，来多少人都没用！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3074 ,mapID =614},},
				},
			}

		},
	},
[10079] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 30930,
		soundID =26327 ,
		txt = "杀我将士，阻我大事，小贼知道死字怎么写吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10080}},
				},
			}

		},
	},
	[10080] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26328 ,
		txt = "今日不仅要杀你将士，坏你大事，还要取你狗命！纳命来吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3075 ,mapID =614},},
				},
			}

		},
	},


------------------------------------------------幻天宫副本对话--------------------

[10081] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31020,
		soundID =26331 ,
		txt = "你是何人？此乃西凉军驻守之地，还不速速退开！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10082}},
				},
			}

		},
	},
	[10082] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26332 ,
		txt = "来的就是此处，我正要找那华雄匹夫算账！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3076 ,mapID =615},},
				},
			}

		},
	},
[10083] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31028,
		soundID =26333 ,
		txt = "阵前何人？此地乃我西凉军重地，闯入者死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10084}},
				},
			}

		},
	},
	[10084] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26334 ,
		txt = "华雄正在何处，速速道来，饶你不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3077 ,mapID =615},},
				},
			}

		},
	},
[10085] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31036,
		soundID =26335 ,
		txt = "胆敢闯入我军秘地，看来今日留你们不得！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10086}},
				},
			}

		},
	},
	[10086] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26336 ,
		txt = "我来此拿华雄匹夫的狗命，识趣的一边去，不识趣的纳命来！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3078 ,mapID =615},},
				},
			}

		},
	},
[10087] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31044,
		soundID =26337 ,
		txt = "我奉将军命在此镇守，擅闯者杀无赦！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10088}},
				},
			}

		},
	},
	[10088] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26338 ,
		txt = "好一个杀无赦！看看今天是谁杀谁！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3079 ,mapID =616},},
				},
			}

		},
	},
[10089] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31052,
		soundID =26339 ,
		txt = "贼子大胆！竟敢惊扰将军修炼，既然来了就别想走！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10090}},
				},
			}

		},
	},
	[10090] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26340 ,
		txt = "老匹夫无胆！派些虾兵蟹将前来，阻得了我吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3080 ,mapID =616},},
				},
			}

		},
	},
[10091] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31060,
		soundID =26341 ,
		txt = "小贼，想要阻挠我家主公复兴大计，也不掂量掂量自己，且做我刀下亡魂吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10092}},
				},
			}

		},
	},
	[10092] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26342 ,
		txt = "老匹夫也敢称雄，看我取你狗命，绝你大计！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3081 ,mapID =616},},
				},
			}

		},
	},
------------------------------------------------赤魂岭副本对话--------------------------------------------------------------------

[10093] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31110,
		soundID =26325 ,
		txt = "来者何人，竟敢窥探我西凉军驻地！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10094}},
				},
			}

		},
	},
	[10094] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "董卓魔魂藏在何处，从实招来，饶你们不死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3082 ,mapID =618},},
				},
			}

		},
	},
[10095] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31118,
		soundID =26325 ,
		txt = "宵小之徒，胆敢闯入冥火原，既然来了，就别想走！死来！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10096}},
				},
			}

		},
	},
	[10096] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "我今日为那董卓而来，你们不阻我道，自然无事，若想阻我，休怪我手下无情！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3083 ,mapID =618},},
				},
			}

		},
	},
[10097] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31126,
		soundID =26325 ,
		txt = "营盘十里，皆是我镇守之地，谁敢踏前一步！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10098}},
				},
			}

		},
	},
	[10098] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "今日董卓我非杀不可，挡我者死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3084 ,mapID =618},},
				},
			}

		},
	},
[10099] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31134,
		soundID =26325 ,
		txt = "我奉命在此镇守多时，岂容你惊扰主公大驾！还不速速降服！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10100}},
				},
			}

		},
	},
	[10100] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "鹿死谁手还不知道呢！多说无用，手底下见真章吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3085 ,mapID =617},},
				},
			}

		},
	},
[10101] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31142,
		soundID =26325 ,
		txt = "竟敢意图破坏主公大计，今日定要将你挫骨扬灰！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10102}},
				},
			}

		},
	},
	[10102] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "尔等乱臣贼子，人人得而诛之，受死吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3086 ,mapID =617},},
				},
			}

		},
	},
[10103] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31150,
		soundID =26325 ,
		txt = "吾乃董卓，区区黄口小儿，竟敢阻挠我复兴大计，今日就要将你千刀万剐！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10104}},
				},
			}

		},
	},
	[10104] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26326 ,
		txt = "老贼狂妄！这次定要让你魂飞魄散，永不超生！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3087 ,mapID =617},},
				},
			}

		},
	},
----------------------------------------------------------------天公山-------------------------------------------------------------------------------------------
[10105] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31190,
		soundID =0 ,
		txt = "站住！此乃天公将军张角修炼之所，擅入此地者杀无赦！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10106}},
				},
			}

		},
	},
	[10106] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "张角老贼在哪，若从实道来，可饶你不死。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3093 ,mapID =622},},
				},
			}

		},
	},
[10107] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31198,
		soundID =0 ,
		txt = "吾乃天公山守山大将，此地岂容尔等小贼放肆！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10108}},
				},
			}

		},
	},
	[10108] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "除掉张角，我自会离去。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3094 ,mapID =622},},
				},
			}

		},
	},
[10109] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31206,
		soundID =0 ,
		txt = "张角大人马上就要修炼出关了，小子，你今日死期已至！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10110}},
				},
			}

		},
	},
	[10110] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "张角老贼已是穷途末路，你等若现在悔悟，尚可活命。",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3095 ,mapID =622},},
				},
			}

		},
	},
[10111] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31214,
		soundID =0 ,
		txt = "天公将军麾下大将杨凤在此！有本将在，谁也休想惊扰张角大人的修炼！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10112}},
				},
			}

		},
	},
	[10112] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "快让张角出来见我，你不是我对手！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3096 ,mapID =622},},
				},
			}

		},
	},
[10113] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31222,
		soundID =0 ,
		txt = "小子，你屡坏本座大事，杀我众多弟兄，实是可恨！今日本座定要将你挫骨扬灰！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10114}},
				},
			}

		},
	},
	[10114] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "张角，你死期已至！前番让你借截教秘术逃了，今日我看你再往哪里逃！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3097 ,mapID =622},},
				},
			}

		},
	},

---------------------------------迷雾林，雾霾麦阿米阿米-----------------------------------------------------------------------
[10115] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31250,
		soundID =0 ,
		txt = "此乃程远志大帅修炼之地，敢擅闯者皆杀无赦！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10116}},
				},
			}

		},
	},
	[10116] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "我只找程远志算账，尔等现在让开尚可活命！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3088 ,mapID =620},},
				},
			}

		},
	},
[10117] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31258,
		soundID =0 ,
		txt = "哪里跑来的小贼，竟敢来此地打扰我家大帅的修炼！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10118}},
				},
			}

		},
	},
	[10118] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "无需多言，叫程远志速速前来领死！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3089 ,mapID =620},},
				},
			}

		},
	},
[10119] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31266,
		soundID =0 ,
		txt = "站住！你竟敢打扰程大帅的修炼，本将今日定取你小命！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=100120}},
				},
			}

		},
	},
	[10120] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "程远志我今日是杀定了，敢挡我者一并诛杀！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3090 ,mapID =620},},
				},
			}

		},
	},
[10121] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31274,
		soundID =0 ,
		txt = "吾乃黄巾大将韩忠是也！奉程远志大帅令在此埋伏多时！受死吧！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10122}},
				},
			}

		},
	},
	[10122] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "来得正是时候，倒省了我找的功夫！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3091 ,mapID =620},},
				},
			}

		},
	},
[10123] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 31282,
		soundID =0 ,
		txt = "小贼！你苦苦相逼，屡次坏本帅大事！今日就和你决一死战！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID=10124}},
				},
			}

		},
	},
	[10124] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =0 ,
		txt = "程远志，上次只是灭了你肉身，不料你竟又复活了！今日我就让你彻底魂飞魄散！",
		options =
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 3092 ,mapID =620},},
				},
			}

		},
	},


	[20000] =
	{
		dialogType = DialogType.HasOption,
		conditions = {},
		speakerID = 30320,
		txt = "据探子回报，张角与其手下将领正藏匿在鬼凤峡、黑厌岭、血魔洞、魔罗峰一带修练魔功，请玩家趁其魔功未成，将张角与手下张燕，张曼成，波才等人斩杀！",
		options =
		{
			[1] =
			{
				showConditions = {
				{condition = DialogCondition.Level, param = {level = 45 ,maxLevel = 55}},
				},
				optionTxt = "进入经验副本【45级】",
				actions =
				{
					{action = DialogActionType.EnterRingEctype , param = {ringEctypeID = 1},},
				},
				icon = DialogIcon.Talk,
			},
			[2] =
			{
				showConditions = {
				{condition = DialogCondition.Level, param = {level = 35 ,maxLevel = 45}},
				},
				optionTxt = "进入潜能副本【35级】",
				actions =
				{
					{action = DialogActionType.EnterRingEctype , param = {ringEctypeID = 2},},
				},
				icon = DialogIcon.Talk,
			},
			[3] = {
				showConditions = 
				{
				--{condition = DialogCondition.HasTask, param = {taskID = 10007, statue = true}},	
				{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10007,npcID = 30320}},
				},
				optionTxt = "试炼任务",
				actions =
				{
				{action = DialogActionType.Gotos, param = {dialogIDs = {5074,5169,5185,5201,5217}}},
				--{action = DialogActionType.Gotos, param = {dialogIDs = {5169,5185,5201,5217}}},
				},
			},
		}
	},

----------------------坐骑任务  开始----------------------------

	[27001] =					--坐骑召唤任务1
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 101}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39001,
		soundID =nil ,
		txt = "等候你多时了，你是我神龙教主命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7001},},
				},
			}

		},
	},
	[27002] =					--坐骑召唤任务2
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 102}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39002,
		soundID =nil ,
		txt = "等候你多时了，你是我炼狱神牛命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7002},},
				},
			}
		},
	},
	[27003] =					--坐骑召唤任务3
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 103}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39003,
		soundID =nil ,
		txt = "等候你多时了，你是我金翅大鹏王命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7003},},
				},
			}
		},
	},
	[27004] =					--坐骑召唤任务4
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 104}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39004,
		soundID =nil ,
		txt = "等候你多时了，你是我夜刃猎手命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7004},},
				},
			}
		},
	},
	[27005] =					--坐骑召唤任务5
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 105}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39005,
		soundID =nil ,
		txt = "等候你多时了，你是我影狐命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7005},},
				},
			}
		},
	},
	[27006] =					--坐骑召唤任务6
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 106}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39006,
		soundID =nil ,
		txt = "等候你多时了，你是我巨斧魔王命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7006},},
				},
			}
		},
	},
	[27007] =					--坐骑召唤任务7
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 107}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39007,
		soundID =nil ,
		txt = "等候你多时了，你是我碧蓝魔将命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7007},},
				},
			}
		},
	},
	[27008] =					--坐骑召唤任务8
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.CheckOwner, param = {taskID = 108}},    -----坐骑任务只有召唤人能挑战
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39008,
		soundID =nil ,
		txt = "等候你多时了，你是我隐士命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7008},},
				},
			}
		},
	},
	[27009] =					--坐骑召唤任务9
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.HasTask, param = {taskID = 109, statue = true}},  -----留着测试任务条件
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39009,
		soundID =nil ,
		txt = "等候你多时了，你是我图腾力士命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7009},},
				},
			}
		},
	},
	[27010] =					--坐骑召唤任务10
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		{condition = DialogCondition.HasTask, param = {taskID = 110, statue = true}},  -----留着测试任务条件
		{condition = DialogCondition.Team, param = {statue = false}},	------限定条件非组队状态下
		},
		speakerID = 39010,
		soundID =nil ,
		txt = "等候你多时了，你是我万骨魔君命中注定的对手吗？",
		options =
		{
			{
				showConditions = {},
				optionTxt = "就让你见识一下我的厉害！",
				actions =
				{
					{action = DialogActionType.EnterScriptFight , param = {scriptID = 7010},},
				},
			}
		},
	},
	[27011] =					--无任务统一跳转对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		--{condition = DialogCondition.HasTask, param = {statue = false}},	
		},
		speakerID = 0,
		soundID =nil ,
		txt = "没有专属的灵符我是打不过他的，还是赶快离开吧",
		options =
		{
		},
	},
	[27012] =					--组队统一跳转对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		{condition = DialogCondition.Team, param = {statue = true}},	------限定条件组队状态下	
		},
		speakerID = 0,
		soundID =nil ,
		txt = "此妖兽天赋异禀，唯有单人挑战将其降服才能驾驭",
		options =
		{
		},
	},
	[27090] =					--神算子npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 39000,
		soundID =nil ,
		txt = "今天下大乱，朝廷动荡，妖魔四处横行，当你到达35级以后，为我找来一些古文秘籍，我可以为你制作降服这些妖兽的灵符，若成功降服妖兽便可成为你的座驾",
		options =
		{
			[1] = {
				showConditions = {
				{condition = DialogCondition.Level, param = {level = 35}},
				},
				optionTxt = "兑换妖兽召唤符",
				actions =
				{
					{action = DialogActionType.ExchangeProps , param = {},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "查询召唤符所需材料",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 27091}},
				},
			},
			[3] = {
				showConditions = {},
				optionTxt = "我下次再来",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	[27091] =					--神算子npc
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 39000,
		soundID =nil ,
		txt = "每个妖兽召唤灵符需要消耗基础材料为青龙卷x20，朱雀卷x20，白虎卷x20，玄武卷x20，外加独有召唤材料x1才能合成一个完整的灵符",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "我明白了",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 27090}},
				},
			},
		},
	},
	[27092] =					--神算子接任务跳对话
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 39000,
		soundID =nil ,
		txt = "现已灵符上已经显现了妖兽的踪迹，快快去降服它",
		options =
		{
		},
	},
------------------------------坐骑任务   结束-------------------
------------------------------------------------------天子猎金场活动开始
	[27101] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 39050,
		soundID =0,
		txt = "南方蛮荒之地发现一处上古遗迹，遗迹中盛产一种上古金晶，是重要的军备物资，朝廷需要征集有志之士前往，你可愿意？",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "前往天子猎金场",
				actions =
				{
					{action = DialogActionType.EnterGoldHuntZone , param = {x = 103, y = 283},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我稍后再来",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},
		},
	},
	[27102] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 39051,
		soundID =0,
		txt = "现在这个兵荒马乱的年代，发财容易，就怕是有命赚没命花，金晶矿带来了吗？",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "上交采集的金晶矿",
				actions =
				{
					{action = DialogActionType.GoldHuntCommit , param = {},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我稍后再来",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},
		},
	},
	[27103] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 39052,
		soundID =0,
		txt = "此处有我驻守，任何人休想通过",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "谁抢到了就是谁的",
				actions =
				{
					{action = DialogActionType.GoldHuntFight , param = {scriptID = 6001 ,mapID =909},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "不和你打",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},
		},
	},
	[27104] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 39053,
		soundID =0,
		txt = "此处有我驻守，任何人休想通过",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "谁抢到了就是谁的",
				actions =
				{
					{action = DialogActionType.GoldHuntFight , param = {scriptID = 6002 ,mapID =909},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "不和你打",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},
		},
	},


-- 乾元岛师门任务发放人，第一层对话
[30001] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			
		},
		speakerID = 29040,
		
		txt = "循环任务NPC发放人，从这里可以领取循环任务！",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "接受师门任务",
				actions =
				{
				    {action = DialogActionType.RecetiveTask, param = {taskID = 10020}},
					--{action = DialogActionType.Goto, param = {dialogID = 30011}},
				},
			},
			[2] =
			{
				showConditions = 
				{
					{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10020, taskType = LoopTaskTargetType.escort, npcID = 29040}},
				},
				optionTxt = "完成护送任务",
				actions =
				{
					{action = DialogActionType.FinishLoopTask, param = {taskID = 10020}},
				}
			},
		},
	},

-- 脚本战斗ID
[30003] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		
		txt = "吕岳，你堂堂截教真仙，竟助那董卓为恶！今日我便要替天行道！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 100, mapID = 111}},
					},
			}
		},
	},

-- 上缴物品
[30004] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10020, taskType = LoopTaskTargetType.buyItem, npcID = 40003}},
		},
		speakerID = 0,
		
		txt = "把你买到的物品，交接物品可以完成此项任务，哈哈哈哈哈!",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10020, itemsInfo = {count = 1},},},
				},
			}
		},
	},
-- 对话交谈
[30005] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10020, taskType = LoopTaskTargetType.talk, npcID = 40004}},
		},
		speakerID = 0,
		
		txt = "对话完成任务，要吗!",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 10020}},
					{action = DialogActionType.RecetiveTask, param = {taskID = 10020}},
				},
			}
		},
	},

-- 上缴宠物NPC
[30006] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10020, taskType = LoopTaskTargetType.catchPet, npcID = 40005}},
		},
		speakerID = 0,
		
		txt = "此时你要上缴你所捕捉的宠物，就能获取当前循环任务的奖励，赶快把",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.PaidPet, param = {taskID = 10020}},
				},
			}
		},
	},

[30007] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 20079,
		
		txt = "有可能直接完成任务，有可能触发下一个战斗，看你的运气呢！",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "碰运气呢",
				actions =
				{
					{action = DialogActionType.MayTaskFight , param = {taskID = 10020},},
				},
				icon = DialogIcon.Talk,
			},
		},
	},

[30008] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 20079,
		
		txt = "从这里购花费一定的金钱购买任务道具，右键使用任务道具有可能直接完成任务",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.BuyItem, param = {itemID = 1062212, itemNum = 1}},
				},
			}
		},
	},
-- 小偷对话
[30009] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
		},
		speakerID = 20079,
		
		txt = "花费金钱来完成任务或者战斗！",
		options = 
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "耗费银两来完成任务(1000)",
				actions =
				{
					{action = DialogActionType.CostMoney, param = {money = 1000, scriptID = 100}},
				},
			},
			[2] =
			{
				showConditions = {},
				optionTxt = "进入战斗来完成任务",
				actions =
				{
					{action = DialogActionType.Fight, param = {scriptID = 100}},
				},
			}
		},
	},

	
-- 循环任务条件满足出现的对话
[30010] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.School, param = {school = SchoolType.QYD}},
		},
		speakerID = 20079,
		
		txt = "哈哈赶快接取这个训话任务吧",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 10020}},
				},
			},
		},
	},
	[30011] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10020, taskType = LoopTaskTargetType.deliverLetters, npcID = 40009}},
		},
		speakerID = 40009,
		
		txt = "赶紧把信送出去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10020, itemsInfo = {{count = 1}}},},
				},
			}
		},
	},

	[30012] = 
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.LoopTaskTalk, param = {taskID = 10020, taskType = LoopTaskTargetType.donate, npcID = 60217}},
		},
		speakerID = 0,
		
		txt = "骚年捐款吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "捐款--------------111",
				actions =
				{
					{action = DialogActionType.openLookTaskWin,param = {taskID = 10020}},
				},
			}
		},
	},
	-- 暗雷对话指定的脚本战斗
	[30013] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		txt = "吕岳，你堂堂截教真仙，竟助那董卓为恶！今日我便要替天行道！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 100, mapID = 111}},
					},
			}
		},
	},

	[30014] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		txt = "对话完成上缴尾随NPC，能够完成任务",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 10020}},
					--{action = DialogActionType.RecetiveTask, param = {taskID = 10020}},
				},
			}
		},
	},
	[30015] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		txt = "出现此对话可完成任务",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishLoopTask, param = {taskID = 10020}},
					},
			}
		},
	},
	[30016] =
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		txt = "点击对话获得尾随NPC，改变任务状态",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.AddFollowNpc, param = {taskID = 10020, followNpcID = 20702}},
				},
			}
		},
	},
	[30017] =
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.Level, param = {level = 30}},
			{condition = DialogCondition.HasTask_1, param = {taskIDs = {10030}}},
			--{condition =  DialogCondition.CheckLoopTasks, param = {taskIDs = {10030,10031}, errorID = 31}},
		},
		speakerID = 20004,
		txt = "哈哈哈",
		options = 
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "上交5个白虎卷或者10个朱雀卷",
					actions =
					{
						{action = DialogActionType.RecetiveTask, param = {taskID = 10030}},
						{action = DialogActionType.Goto, param = {dialogID=30018}},
					},
				}, 
		},
	},

	[30018] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.HasTask, param = {taskID = 10001}},
			--{condition =  DialogCondition.CheckLoopTask, param = {taskID = 10030, errorID = 31}},
		},
		speakerID = 20913,
		
		txt = "xxxxxxxxxxxxxxx",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "上交5个白虎卷",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10001, itemsInfo ={{itemID = 1051021,count = 5},{itemID = 1051022,count = 10}}}},
				},
			},
		}
	},

	[30019] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			
		},
		speakerID = 20913,
		
		txt = "物品个数不满足，不能完成任务",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog ,param = {}},
				},
			},
		}
	},
--------------------------------帮派任务，上交装备---------------------
	--接收帮会任务
	[30100] = 
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{
			{condition = DialogCondition.NotHasFactionTask, param = {taskID = 10009}},
		},
		speakerID = 30817,
		txt = "愁愁愁，帮会物资总是不够用，这可如何是好！",
		options = 
		{
			[1] = {
				showConditions = {
				},
				optionTxt = "【接受任务】捐献物资",
				actions =
				{
					
					{action = DialogActionType.RecetiveTask, param = {taskID = 10009}},
					
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我只是路过的",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
	--上交帮会任务
	[30101] = 
	{
		dialogType = DialogType.HasOption,
		conditions = 
		{{condition = DialogCondition.HasFactionTask, param = {taskID = 10009}},
		},
		speakerID = 30817,
		
		txt = "愁愁愁，帮会物资总是不够用，这可如何是好！",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "【完成任务】捐献物资",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10009, itemsInfo ={{count = 1}}}},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "我只是路过的",
				actions =
				{
				{action = DialogActionType.CloseDialog, param ={}},
				},
			},
		},
	},
----------------------抓宠玩法（35001——36000）
	[35001] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60000,
		txt = "专属的抓宠地图，等级≥30的玩家消耗捕宠令牌可以进入场景内捕捉你喜欢的宠物，更有几率能刷新元灵类的宠物捕捉，快进来挑战试试运气吧",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "查看地图宠物",
					actions =
					{
						{action = DialogActionType.Goto, param = {dialogID=35002}},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "传送进入场景",
					actions =
					{
						{action = DialogActionType.Goto, param = {dialogID=35003}},
					},
				},
			[3] = 
				{
					showConditions = {},
					optionTxt = "只是随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
		},
	},
	[35002] = 
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 60000,
		txt = "30级地图能捕捉宠物，包括：黄巾兵、妖道、古魔、护法神、蝠妖、幽灵、门客、河内守卫、流寇、刺客、关将、刀盾手、虎妖、中原妖兵<br>40级地图能捕捉的宠物，包括：西凉兵、游方妖师、魔犬、海怪、鲛妖、海盗<br>50级地图能捕捉宠物，包括：妖灵、琴魔女、死士、蛮族、虎将、谋士、牛头、马面、骷髅将、魔兵。",
		options =
		{
		},
	},
	[35003] = 
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60000,
		txt = "只要你有实力，可以选择挑战任意等级地图抓宠",
		options =
		{
			[1] =
				{
					showConditions = {},
					optionTxt = "30级抓宠地图",
					actions =
					{
						{action = DialogActionType.EnterCatchPetMap , param ={mapID = 901, x = 35, y = 157, itemID = 1025001, itemNum = 1}},
					},
				},
			[2] =
				{
					showConditions = {},
					optionTxt = "40级抓宠地图",
					actions =
					{
						{action = DialogActionType.EnterCatchPetMap , param ={mapID = 902, x = 35, y = 157, itemID = 1025001, itemNum = 1}},
					},
				},
			[3] =
				{
					showConditions = {},
					optionTxt = "50级抓宠地图",
					actions =
					{
						{action = DialogActionType.EnterCatchPetMap , param ={mapID = 903, x = 35, y = 157, itemID = 1025001, itemNum = 1}},
					},
				},
			[4] =
				{
					showConditions = {},
					optionTxt = "60级抓宠地图",
					actions =
					{
						{action = DialogActionType.EnterCatchPetMap , param ={mapID = 904, x = 35, y = 157, itemID = 1025001, itemNum = 1}},
					},
				},
		},
	},
	[35004] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60001,
		txt = "累了困了，点我传送出去吧",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "传送出场景",
					actions =
					{
						{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 185, tarY = 131}},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35005] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60002,
		txt = "累了困了，点我传送出去吧",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "传送出场景",
					actions =
					{
						{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 185, tarY = 131}},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35006] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60003,
		txt = "累了困了，点我传送出去吧",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "传送出场景",
					actions =
					{
						{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 185, tarY = 131}},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35007] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60004,
		txt = "累了困了，点我传送出去吧",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "传送出场景",
					actions =
					{
						{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 185, tarY = 131}},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35021] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60011,
		txt = "此地乃吾等镇守，想要过去，先过我这关！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "小样看招",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35001 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35022] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60012,
		txt = "来了还想走，今日吾必将尔魂断于此！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "大胆孽贼，看招",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35002 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35023] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60013,
		txt = "竟然妄想在我处胡作非为，今日岂能让你如愿！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35003 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35024] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60014,
		txt = "什么人!竟敢来此地撒野！不想活了!",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35004 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35025] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60015,
		txt = "胆敢闯入到这里来了，还想活着出去？纳命来吧！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35005 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "赶紧奔跑",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35026] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60016,
		txt = "有大爷我在此驻守，尔等小贼休得嚣张！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "先收拾你",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35006 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35027] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60017,
		txt = "哪里来的小贼，竟然妄想在我这里捞得好处！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "打赢再说",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35007 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35028] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60018,
		txt = "本将奉令在此护法，擅闯者杀！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35008 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35029] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60019,
		txt = "一二三四五六七，终于都有人来啦，先杀个人玩一玩",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35009 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35030] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60020,
		txt = "螳臂当车，愚不可及！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35010 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35031] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60021,
		txt = "又是你这贼子，今日定要将你挫骨扬灰方可消我心头之恨！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35011 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35032] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60022,
		txt = "来了还想走，今日吾必将尔魂断于此！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "大胆孽贼，看招",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35012 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35033] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60023,
		txt = "竟然妄想在我处胡作非为，今日岂能让你如愿！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35013 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35034] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60024,
		txt = "什么人!竟敢来此地撒野！不想活了!",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35014 ,mapID =901},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35035] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60025,
		txt = "胆敢闯入到这里来了，还想活着出去？纳命来吧！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35015 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35036] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60026,
		txt = "有大爷我在此驻守，尔等小贼休得嚣张！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "先收拾你",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35016 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35037] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60027,
		txt = "哪里来的小贼，竟然妄想在我这里捞得好处！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "打赢再说",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35017 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35038] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60028,
		txt = "本将奉令在此护法，擅闯者杀！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35018 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35039] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60029,
		txt = "一二三四五六七，终于都有人来啦，先取你首级玩一玩",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35019 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35040] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60030,
		txt = "本将奉令在此护法，擅闯者杀！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35020 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35041] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60031,
		txt = "螳臂当车，愚不可及！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35021 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35042] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60032,
		txt = "又是你这贼子，今日定要将你挫骨扬灰方可消我心头之恨！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35022 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35043] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60033,
		txt = "此地乃吾等镇守，想要过去，先过我这关！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35023 ,mapID =902},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35044] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60034,
		txt = "来了还想走，今日吾必将尔魂断于此！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "小样看招",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35024 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35045] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60035,
		txt = "竟然妄想在我处胡作非为，今日岂能让你如愿！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35025 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35046] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60036,
		txt = "什么人!竟敢来此地撒野！不想活了!",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35026 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35047] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60037,
		txt = "胆敢闯入到这里来了，还想活着出去？纳命来吧！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35027 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35048] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60038,
		txt = "有大爷我在此驻守，尔等小贼休得嚣张",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35028 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35049] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60039,
		txt = "一二三四五六七，终于都有人来啦，先取你首级玩一玩",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35029 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35050] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60040,
		txt = "哪里来的小贼，竟然妄想在我这里捞得好处",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35030 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35051] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60041,
		txt = "本将奉令在此护法，擅闯者杀！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35031 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35052] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60041,
		txt = "一二三四五六七，终于都有人来啦，先杀个人玩一玩，大刀已经饥渴难耐",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35032 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35053] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60041,
		txt = "螳臂当车，愚不可及！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35033 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},
	[35054] =        --------抓宠玩法
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 60041,
		txt = "又是你这贼子，今日定要将你挫骨扬灰方可消我心头之恨！",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "进入战斗",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 35034 ,mapID =903},},
						},
					},
			[2] = 
				{
					showConditions = {},
					optionTxt = "随便看看",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
			},
		},

------------瑞兽赐福------------------------------------
	[35101] =        --------青龙
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 25501,
		txt = "想要天降福泽，就得接受我的挑战！获得我的赏识，奖励自然也少不了你，请务必把握机会！",
		options =
		{
			[1] =   {
					showConditions = {},
					optionTxt = "请指点一二！",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 7102 ,mapID =nil},},
					},
				},
			[2] =	{
					showConditions = {},
					optionTxt = "准备好再来",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
		},
	},
	[35102] =        --------白虎
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 25502,
		txt = "想要天降福泽，就得接受我的挑战！获得我的赏识，奖励自然也少不了你，请务必把握机会！",
		options =
		{
			[1] =   {
					showConditions = {},
					optionTxt = "请指点一二！",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 7103 ,mapID =nil},},
					},
				},
			[2] =	{
					showConditions = {},
					optionTxt = "准备好再来",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
		},
	},
	[35103] =        --------朱雀
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 25503,
		txt = "想要天降福泽，就得接受我的挑战！获得我的赏识，奖励自然也少不了你，请务必把握机会！",
		options =
		{
			[1] =   {
					showConditions = {},
					optionTxt = "请指点一二！",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 7104 ,mapID =nil},},
					},
				},
			[2] =	{
					showConditions = {},
					optionTxt = "准备好再来",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
		},
	},
	[35104] =        --------玄武
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 25504,
		txt = "想要天降福泽，就得接受我的挑战！获得我的赏识，奖励自然也少不了你，请务必把握机会！",
		options =
		{
			[1] =   {
					showConditions = {},
					optionTxt = "请指点一二！",
					actions =
					{
						{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 7105 ,mapID =nil},},
					},
				},
			[2] =	{
					showConditions = {},
					optionTxt = "准备好再来",
					actions =
					{
						{action = DialogActionType.CloseDialog , param ={}},
					},
				},
		},
	},

 -------挖宝放妖
	[39996] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26159 ,
		txt = "你，是来送新鲜的血液给本座进补的吗",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "不要怕，秒了他",
				actions =
				{
					{action = DialogActionType.EnterTreasureFight , param = {scriptID = 40001 ,mapID =600},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "打不赢就跑",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},

		},
	},
	[39997] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26159 ,
		txt = "哈哈哈我已重获新生，谁都别想再禁锢我！",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "不要怕，秒了他",
				actions =
				{
					{action = DialogActionType.EnterTreasureFight , param = {scriptID = 40002 ,mapID =600},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "打不赢就跑",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},

		},
	},
	[39998] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26159 ,
		txt = "嘻嘻嘻，我要大开杀戒！",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "不要怕，秒了他",
				actions =
				{
					{action = DialogActionType.EnterTreasureFight , param = {scriptID = 40003 ,mapID =600},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "打不赢就跑",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},

		},
	},

	[39999] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 0,--
		soundID =26159 ,
		txt = "人间有这么多美味，再也不想回去了！",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "不要怕，秒了他",
				actions =
				{
					{action = DialogActionType.EnterTreasureFight , param = {scriptID = 40004 ,mapID =600},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "打不赢就跑",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},

		},
	},
---挖宝结束
	[40002] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			{condition = DialogCondition.Faction, param = {hasFaction = 1}},
		},
		speakerID = 29048,
		soundID =1,
		txt = "忠义为首，肝胆相照。帮会的宗旨就是这样的，你认为呢？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "查看帮派列表",
				actions =
				{
					{action = DialogActionType.ShowFactionList , param = {v = "FactionListWin"},},
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "进入我的帮派领地",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 7, tarX = 86, tarY = 68}},
				},
			},

		},
	},
	[40003] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			{condition = DialogCondition.Faction, param = {hasFaction = 0}},
		},
		speakerID = 29048,
		soundID =1,
		txt = "忠义为首，肝胆相照。帮会的宗旨就是这样的，你认为呢？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "查看帮派列表",
				actions =
				{
					{action = DialogActionType.ShowFactionList , param = {v = "FactionListWin"},},
				},
			},
		},
	},
	[40004] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			
		},
		speakerID = 29048,
		soundID =26159,
		txt = "TP？？",
		options =
		{
			[1] = {
				showConditions = {},
				optionTxt = "传送到洛阳城",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 133, tarY = 210}},
				},
			},

		},
	},
	[40005] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "测试帮会对话",
		options =
		{
			[1] = {
				showConditions = {
				{condition = DialogCondition.HasTask, param = {taskID = 10002, statue = false}},
				{condition = DialogCondition.Level, param = {level = 30}},	
				},
				optionTxt = "接受帮会任务",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 133, tarY = 210}},
				},
			},
			[2] = {
				showConditions = {{condition = DialogCondition.HasTask, param = {taskID = 10002, statue = true}},},
				optionTxt = "提交帮会任务",
				actions =
				{
					{action = DialogActionType.SwithScene , param ={tarMapID  = 10, tarX = 133, tarY = 210}},
				},
			},

		},
	},

	[40006] =        --------抓宠玩法测试
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29046,
		txt = "抓宠测试",
		options =
		{
			[1] = 
				{
					showConditions = {},
					optionTxt = "查看地图宠物",
					actions =
					{
						{},
					},
				},
			[2] = 
				{
					showConditions = {},
					optionTxt = "传送场景",
					actions =
					{
						{action = DialogActionType.Goto, param = {dialogID=40007}},
					},
				},
		},
	},
	[40007] = 
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		},
		speakerID = 29046,
		txt = "抓宠任务描述<br>30级地图能抓宠物xx1、xx2,<br>40级地图能抓冲我xxx1、xxx2,<br>50级地图能抓宠物x1、x2,<br>60级地图能抓宠物xxxx1、xxxx2",
		options =
		{
		},
	},
	[40008] = 
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		},
		speakerID = 29046,
		txt = "抓宠测试",
		options =
		{
			[1] =
				{
					showConditions = {},
					optionTxt = "30级抓宠地图",
					actions =
					{
						{action = DialogActionType.EnterCatchPetMap , param ={mapID = 901, x = 100, y = 100, itemID = 1025001, itemNum = 1}},
					},
				},
			[2] =
				{
					showConditions = {},
					optionTxt = "40级抓宠地图",
					actions =
					{
						{},
					},
				},
			[3] =
				{
					showConditions = {},
					optionTxt = "50级抓宠地图",
					actions =
					{
						{},
					},
				},
			[4] =
				{
					showConditions = {},
					optionTxt = "60级抓宠地图",
					actions =
					{
						{},
					},
				},
		},
	},
	[40009] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
			
		},
		speakerID = 29048,
		soundID =26159,
		txt = "嚯嚯嚯，把东西交出来",
		options =
		{
			[1] =
			{
				showConditions = {},
				optionTxt = "给我东西",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin"},},--打开物品仓库
					{action = DialogActionType.OpenUI ,param = {v = "ItemEquipWin"},},--0
				},
			},
			[2] = {
				showConditions = {},
				optionTxt = "嚯嚯嚯，你没有我要的的东西",
				actions =
				{
					{action = DialogActionType.CloseDialog , param ={}},
				},
			},

		},
	},
	[50001] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "想进入战斗吗",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "进入战斗》》》》",
				actions =
				{
					{action = DialogActionType.EnterCatchPetFight , param = {scriptID = 100 ,mapID =600},},
				},
			},
		},
	},

------------------------------日常任务----------------------------------------------------------------------------------------------------------------------------
---------------------------------------每日杀怪计数---------------------------------------------------------------------------------------------------
	[50101] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "修炼之路并非一日而功，只有打稳根基，平时多磨炼自己，每天坚持上阵杀敌方为正道。",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "修炼之路（接受任务）",
				actions =
				{
					{action = DialogActionType.Gotos , param = {dialogIDs = {50102,50103,50104}},},
				},
			},
			[2] = 
			{
				showConditions = {},
				optionTxt = "修炼之路（完成任务）",
				actions =
				{
					{action = DialogActionType.Gotos , param = {dialogIDs = {50105,50106}}},
				},
			},
			[3] = 
			{
				showConditions = {},
				optionTxt = "我还有事，告辞",
				actions =
				{
					{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
	[50102] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "要上阵杀敌武艺不可不精，平时要多磨炼自己才行！这样吧，你在今天之内替我消灭200只与你等级相差5级以内的任意妖怪，提升自身武艺的同时，我依然会给你奖励作为报酬，是不是很划算啊！",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "我这就去完成任务！",
				actions =
				{
					{action = DialogActionType.RecetiveTask , param = {taskID = 40001}},
				},
			},
			[2] = 
			{
				showConditions = {},
				optionTxt = "我还有事，告辞",
				actions =
				{
					{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
	[50103] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "以你现在的能力，还不足以对抗那些可怕的妖怪，请回去修炼到25级再回来找我吧！",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
	[50104] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "修炼之路要循序渐进，绝不是一步而蹴。你今天已经消灭足够多的妖怪了，明天再过来吧！",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
	[50105] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "很好，你完成得不错，这些都是给你的奖励！明天记得还要来我这接任务啊！",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask , param = {taskID = 40001},},
				},
			},
		},
	},
	[50106] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		
		},
		speakerID = 20001,
		soundID =26159,
		txt = "你好像还没消灭200只怪物吧，请再接再厉吧！",
		options =
		{
			[1] = 
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
---------------------------------------每日道具计数---------------------------------------------------------------------------------------------------
	[50110] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{},
		speakerID = 29081,
		soundID =nil,
		txt = "如今黄巾贼兴风作浪，皇子们又为太子之位明争暗斗，真是内忧外患啊！",
		options =
		{
			[1] = 
			{
				showConditions = 
				{
				{condition = DialogCondition.Level, param = {level = 30,},},
                                {condition = DialogCondition.HasTask, param = {taskID = 10030, statue = false}},
				},
				optionTxt = "充实军备",
				actions =
				{
				{action = DialogActionType.RecetiveTask , param = {taskID = 10030}},
                                {action = DialogActionType.Goto, param = {dialogID = 50111}},
				},
			},
			[2] = 
			{
				showConditions = 
				{
				{condition = DialogCondition.HasTask, param = {taskID = 10030, statue = true}},
				},
				optionTxt = "上交头盔",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10030, itemsInfo ={{itemID = 1051021,count = 5},{itemID = 1051022,count = 10}}}},
				},
			},
			[3] = 
			{
				showConditions = {},
				optionTxt = "我还有事，告辞",
				actions =
				{
				{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
	[50111] =
	{
		dialogType = DialogType.HasOption,
		conditions =
		{
                {condition = DialogCondition.CheckLoopTask, param = {taskID = 10030, errorID = 38}},
		},
		speakerID = 29081,
		soundID =nil,
		txt = "<myName>，你来得正好。如今朝廷军备不足，急需一批装备。如果你能替我集齐10件头盔或20件头盔碎片，作为报酬我会给你奖励！记住，这种头盔只能在与你等级相差5级以内的战斗中获得，你每天能够在我这里上交10次！知道了就快去吧！",
		options =
		{
			[1] = 
			{
				showConditions = 
				{},
				optionTxt = "上交盔甲",
				actions =
				{
				{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin",taskID = 10030, itemsInfo ={{itemID = 1051021,count = 5},{itemID = 1051022,count = 10}}}},
				},
			},
			[2] = 
			{
				showConditions = {},
				optionTxt = "我这就去收集",
				actions =
				{
				{action = DialogActionType.CloseDialog , param = {},},
				},
			},
		},
	},
	[50112] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{},
		speakerID = 29081,
		txt = "我需要的是10件头盔或者20件头盔碎片，你提交给我的道具不符合啊！",
		options = 
		{
			[1] = {
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.CloseDialog ,param = {}},
				},
			},
		}
	},


--------------------------------------------------------------------------------------------------------------------------------


	[100001] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人传承有六大仙门，本座已令其中一派<npcID>你入门，教你降妖伏魔本领！你且去<mapID,x,y>助你下凡！",
		options =
		{
			
		},
	},
	[100002] =
	{
		dialogType = DialogType.NotOption,
		conditions =
		{
		
		},
		speakerID = 20002,
		soundID = nil,
		txt = "我阐教在人传承有六大仙门，本座已令其中一派<npcID>你入门，教你降妖伏魔本领！你且去<mapID,x,y>助你下凡！",
		options =
		{
			
		},
	},

	--接受帮会任务
	[10000001] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.NotHasFactionTask, param = {taskID = 10001}},
		},
		speakerID = 0,
		
		txt = "接受帮会任务",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					
					{action = DialogActionType.RecetiveTask, param = {taskID = 10009}},
					
				},
			}
		},
	},

	--上交帮会任务
	[10000002] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
			{condition = DialogCondition.HasFactionTask, param = {taskID = 10009}},
		},
		speakerID = 0,
		
		txt = "交装备！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.OpenUI ,param = {v = "SubmitItemWin", taskID = 10001,equipFlag = true, itemsInfo = {count = 1},},},
				},
			}
		},
	},
}