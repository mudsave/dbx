--[[NormalDialogModelDB.lua  --服务器
	对话配置（对话系统）
]]

NormalDialogModelDB = 
{
	[100] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "咦，这是什么地方？难道我穿越了？前面有个人，过去问问看。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1001}},
					},
			}
		},
	},
[101] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20001,
		soundID = nil,
		txt = "此处名为三十六天玄都玉京天，乃是吾师尊阐教圣人元始天尊修炼道场。你正是被吾师尊以大法力摄来此地。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 102}},
					},
			}
		},
	},
[102] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你们把我弄到这里要做什么？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1001}},
				    {action = DialogActionType.Goto, param = {dialogID = 103}},
			},
			}
		},
	},
[103] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20001,
		soundID = nil,
		txt = "不必害怕，师尊正在等你，你且去拜见他老人家便知。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1002}},
					},
			}
		},
	},
[104] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "现时下界正是东汉末年，人间动荡，妖魔作乱。少年人，你上应天命，乃是拯救天下苍生的天命之主。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1002}},
				    {action = DialogActionType.Goto, param = {dialogID = 105}},
			},
			}
		},
	},
[105] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "拯救天下苍生？我愿意尽一己之力，可是我啥都不会。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 106}},
					},
			}
		},
	},
[106] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "无妨，本座这便传你一招道法本领，以应付妖魔邪道。你且使此招和本座座下的玉清神将一战，若能击败他，便算掌握此招精髓。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1003}},
				{action = DialogActionType.EnterScriptFight, param = {scriptID = 100,mapID = 8}},
					{action = DialogActionType.UITip, param = {v = 1,p = 1}},
				},
			}
		},
	},
[107] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已成功击败玉清神将，不知祖师还有何吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1003}},
				    {action = DialogActionType.Gotos, param = {dialogIDs = {108,118,128,138,148,158}}},
					},
			}
		},
	},
[109] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1004}},
				    {action = DialogActionType.Goto, param = {dialogID = 110}},
			},
			}
		},
	},
[110] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！你可打开一看！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1005}},
				{action = DialogActionType.UITip, param = {v = 15,p = 1}},
				},
			}
		},
	},
[111] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此百宝袋每10级便可开启一次，可获无穷妙物，你且小心别弄丢了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1005}},
				    {action = DialogActionType.Goto, param = {dialogID = 112}},
			},
			}
		},
	},
[112] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1006}},
					},
			}
		},
	},
[113] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我受元始祖师之命，欲拜你门下学习仙道本领，以诛妖除魔，救济苍生百姓，还望掌门收留！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1006}},
				    {action = DialogActionType.Goto, param = {dialogID = 114}},
			},
			}
		},
	},
[114] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法升到十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1007}},
				{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[115] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请掌门吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1007}},
				    {action = DialogActionType.Goto, param = {dialogID = 168}},
			},
			}
		},
	},
[116] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。当今天下有三位不世出之英豪，名为刘备、关羽、张飞，现在在桃源镇。此三人性命关乎天下气运，不容半点闪失。你速前往向桃源镇镇长刘元起打探三人下落。护其周全，共同讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1038}},
					},
			}
		},
	},
[117] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃乾元岛弟子，特奉师命前来，打探刘备、关羽、张飞三人下落，助其三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1038}},
				    {action = DialogActionType.Goto, param = {dialogID = 360}},
			},
			}
		},
	},
[119] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1009}},
				    {action = DialogActionType.Goto, param = {dialogID = 120}},
			},
			}
		},
	},
[120] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！你可打开一看！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1010}},
				{action = DialogActionType.UITip, param = {v = 15,p = 1}},
				},
			}
		},
	},
[121] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此百宝袋每10级便可开启一次，可获无穷妙物，你且小心别弄丢了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1010}},
				    {action = DialogActionType.Goto, param = {dialogID = 122}},
			},
			}
		},
	},
[122] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1011}},
					},
			}
		},
	},
[123] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我受元始祖师之命，欲拜你门下学习仙道本领，以诛妖除魔，救济苍生百姓，还望掌门收留！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1011}},
				    {action = DialogActionType.Goto, param = {dialogID = 124}},
			},
			}
		},
	},
[124] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20005,
		soundID = nil,
		txt = "你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法升到十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1012}},
				{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[125] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请掌门吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1012}},
				    {action = DialogActionType.Goto, param = {dialogID = 174}},
			},
			}
		},
	},
[126] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20005,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。当今天下有三位不世出之英豪，名为刘备、关羽、张飞，现在在桃源镇。此三人性命关乎天下气运，不容半点闪失。你速前往向桃源镇镇长刘元起打探三人下落。护其周全，共同讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1043}},
					},
			}
		},
	},
[127] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃桃源洞弟子，特奉师命前来，打探刘备、关羽、张飞三人下落，助其三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1043}},
				    {action = DialogActionType.Goto, param = {dialogID = 361}},
			},
			}
		},
	},
[129] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1014}},
				    {action = DialogActionType.Goto, param = {dialogID = 130}},
			},
			}
		},
	},
[130] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！你可打开一看！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1015}},
				{action = DialogActionType.UITip, param = {v = 15,p = 1}},
				},
			}
		},
	},
[131] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此百宝袋每10级便可开启一次，可获无穷妙物，你且小心别弄丢了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1015}},
				    {action = DialogActionType.Goto, param = {dialogID = 132}},
			},
			}
		},
	},
[132] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1016}},
					},
			}
		},
	},
[133] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我受元始祖师之命，欲拜你门下学习仙道本领，以诛妖除魔，救济苍生百姓，还望掌门收留！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1016}},
				    {action = DialogActionType.Goto, param = {dialogID = 134}},
			},
			}
		},
	},
[134] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20006,
		soundID = nil,
		txt = "你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法升到十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1017}},
				{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[135] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请掌门吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1017}},
				    {action = DialogActionType.Goto, param = {dialogID = 180}},
			},
			}
		},
	},
[136] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20006,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。当今天下有三位不世出之英豪，名为刘备、关羽、张飞，现在在桃源镇。此三人性命关乎天下气运，不容半点闪失。你速前往向桃源镇镇长刘元起打探三人下落。护其周全，共同讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1048}},
					},
			}
		},
	},
[137] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃金霞山弟子，特奉师命前来，打探刘备、关羽、张飞三人下落，助其三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1048}},
				    {action = DialogActionType.Goto, param = {dialogID = 362}},
			},
			}
		},
	},
[139] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1019}},
				    {action = DialogActionType.Goto, param = {dialogID = 140}},
			},
			}
		},
	},
[140] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！你可打开一看！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1020}},
				{action = DialogActionType.UITip, param = {v = 15,p = 1}},
				},
			}
		},
	},
[141] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此百宝袋每10级便可开启一次，可获无穷妙物，你且小心别弄丢了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1020}},
				    {action = DialogActionType.Goto, param = {dialogID = 142}},
			},
			}
		},
	},
[142] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1021}},
					},
			}
		},
	},
[143] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我受元始祖师之命，欲拜你门下学习仙道本领，以诛妖除魔，救济苍生百姓，还望掌门收留！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1021}},
				    {action = DialogActionType.Goto, param = {dialogID = 144}},
			},
			}
		},
	},
[144] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20007,
		soundID = nil,
		txt = "你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法升到十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1022}},
				{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[145] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请掌门吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1022}},
				    {action = DialogActionType.Goto, param = {dialogID = 186}},
			},
			}
		},
	},
[146] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20007,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。当今天下有三位不世出之英豪，名为刘备、关羽、张飞，现在在桃源镇。此三人性命关乎天下气运，不容半点闪失。你速前往向桃源镇镇长刘元起打探三人下落。护其周全，共同讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1053}},
					},
			}
		},
	},
[147] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃蓬莱阁弟子，特奉师命前来，打探刘备、关羽、张飞三人下落，助其三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1053}},
				    {action = DialogActionType.Goto, param = {dialogID = 363}},
			},
			}
		},
	},
[149] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1024}},
				    {action = DialogActionType.Goto, param = {dialogID = 150}},
			},
			}
		},
	},
[150] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！你可打开一看！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1025}},
				{action = DialogActionType.UITip, param = {v = 15,p = 1}},
				},
			}
		},
	},
[151] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此百宝袋每10级便可开启一次，可获无穷妙物，你且小心别弄丢了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1025}},
				    {action = DialogActionType.Goto, param = {dialogID = 152}},
			},
			}
		},
	},
[152] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1026}},
					},
			}
		},
	},
[153] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我受元始祖师之命，欲拜你门下学习仙道本领，以诛妖除魔，救济苍生百姓，还望掌门收留！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1026}},
				    {action = DialogActionType.Goto, param = {dialogID = 154}},
			},
			}
		},
	},
[154] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20008,
		soundID = nil,
		txt = "你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法升到十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1027}},
				{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[155] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请掌门吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1027}},
				    {action = DialogActionType.Goto, param = {dialogID = 192}},
			},
			}
		},
	},
[156] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20008,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。当今天下有三位不世出之英豪，名为刘备、关羽、张飞，现在在桃源镇。此三人性命关乎天下气运，不容半点闪失。你速前往向桃源镇镇长刘元起打探三人下落。护其周全，共同讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1058}},
					},
			}
		},
	},
[157] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃紫阳门弟子，特奉师命前来，打探刘备、关羽、张飞三人下落，助其三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1058}},
				    {action = DialogActionType.Goto, param = {dialogID = 364}},
			},
			}
		},
	},
[159] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1029}},
				    {action = DialogActionType.Goto, param = {dialogID = 160}},
			},
			}
		},
	},
[160] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！你可打开一看！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1030}},
				{action = DialogActionType.UITip, param = {v = 15,p = 1}},
				},
			}
		},
	},
[161] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此百宝袋每10级便可开启一次，可获无穷妙物，你且小心别弄丢了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1030}},
				    {action = DialogActionType.Goto, param = {dialogID = 162}},
			},
			}
		},
	},
[162] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1031}},
					},
			}
		},
	},
[163] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我受元始祖师之命，欲拜你门下学习仙道本领，以诛妖除魔，救济苍生百姓，还望掌门收留！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1031}},
				    {action = DialogActionType.Goto, param = {dialogID = 164}},
			},
			}
		},
	},
[164] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20009,
		soundID = nil,
		txt = "你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法升到十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1032}},
				{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[165] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请掌门吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1032}},
				    {action = DialogActionType.Goto, param = {dialogID = 198}},
			},
			}
		},
	},
[166] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20009,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。当今天下有三位不世出之英豪，名为刘备、关羽、张飞，现在在桃源镇。此三人性命关乎天下气运，不容半点闪失。你速前往向桃源镇镇长刘元起打探三人下落。护其周全，共同讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1063}},
					},
			}
		},
	},
[167] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃云霄宫弟子，特奉师命前来，打探刘备、关羽、张飞三人下落，助其三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1063}},
				    {action = DialogActionType.Goto, param = {dialogID = 365}},
			},
			}
		},
	},
[168] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "为师最近听闻座下弟子禀报，说近日门派内有妖物作祟，你且前去寻为师座下大弟子，打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1034}},
					},
			}
		},
	},
[169] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师傅叫我来询问门派妖物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1034}},
				    {action = DialogActionType.Goto, param = {dialogID = 170}},
			},
			}
		},
	},
[170] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20021,
		soundID = nil,
		txt = "此妖物现在门派东南方，乃是偷跑出来玩闹的小妖，你且前去寻找并捕捉此妖物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1036}},
					},
			}
		},
	},
[171] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，此妖物已捕捉来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1036}},
				    {action = DialogActionType.Goto, param = {dialogID = 172}},
			},
			}
		},
	},
[172] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20021,
		soundID = nil,
		txt = "很好，此小妖你就收做宠物吧，在今后的历练中，此小妖会成为你的助力。最近听闻师傅有要事相商，你且前去师傅那询问。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1037}},
				{action = DialogActionType.UITip, param = {v = 18,p = 1}},
			{action = DialogActionType.UITip, param = {v = 19,p = 1}},
				},
			}
		},
	},
[173] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1037}},
				    {action = DialogActionType.Goto, param = {dialogID = 116}},
			},
			}
		},
	},
[174] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20005,
		soundID = nil,
		txt = "为师最近听闻座下弟子禀报，说近日门派内有妖物作祟，你且前去寻为师座下大弟子，打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1039}},
					},
			}
		},
	},
[175] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师傅叫我来询问门派妖物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1039}},
				    {action = DialogActionType.Goto, param = {dialogID = 176}},
			},
			}
		},
	},
[176] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20025,
		soundID = nil,
		txt = "此妖物乃是偷跑出来玩闹的小妖，你且前去捕捉此妖物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1040}},
					},
			}
		},
	},
[177] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，此妖物已捕捉来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1040}},
				    {action = DialogActionType.Goto, param = {dialogID = 178}},
			},
			}
		},
	},
[178] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20025,
		soundID = nil,
		txt = "很好，此小妖你就收做宠物吧，在今后的历练中，此小妖会成为你的助力。最近听闻师傅有要事相商，你且前去师傅那询问。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1042}},
				{action = DialogActionType.UITip, param = {v = 18,p = 1}},
			{action = DialogActionType.UITip, param = {v = 19,p = 1}},
				},
			}
		},
	},
[179] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1042}},
				    {action = DialogActionType.Goto, param = {dialogID = 126}},
			},
			}
		},
	},
[180] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20006,
		soundID = nil,
		txt = "为师最近听闻座下弟子禀报，说近日门派内有妖物作祟，你且前去寻为师座下大弟子，打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1044}},
					},
			}
		},
	},
[181] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师傅叫我来询问门派妖物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1044}},
				    {action = DialogActionType.Goto, param = {dialogID = 182}},
			},
			}
		},
	},
[182] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20023,
		soundID = nil,
		txt = "此妖物乃是偷跑出来玩闹的小妖，你且前去捕捉此妖物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1045}},
					},
			}
		},
	},
[183] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，此妖物已捕捉来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1045}},
				    {action = DialogActionType.Goto, param = {dialogID = 184}},
			},
			}
		},
	},
[184] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20023,
		soundID = nil,
		txt = "很好，此小妖你就收做宠物吧，在今后的历练中，此小妖会成为你的助力。最近听闻师傅有要事相商，你且前去师傅那询问。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1047}},
				{action = DialogActionType.UITip, param = {v = 18,p = 1}},
			{action = DialogActionType.UITip, param = {v = 19,p = 1}},
				},
			}
		},
	},
[185] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1047}},
				    {action = DialogActionType.Goto, param = {dialogID = 136}},
			},
			}
		},
	},
[186] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20007,
		soundID = nil,
		txt = "为师最近听闻座下弟子禀报，说近日门派内有妖物作祟，你且前去寻为师座下大弟子，打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1049}},
					},
			}
		},
	},
[187] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师傅叫我来询问门派妖物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1049}},
				    {action = DialogActionType.Goto, param = {dialogID = 188}},
			},
			}
		},
	},
[188] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20022,
		soundID = nil,
		txt = "此妖物乃是偷跑出来玩闹的小妖，你且前去捕捉此妖物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1050}},
					},
			}
		},
	},
[189] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，此妖物已捕捉来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1050}},
				    {action = DialogActionType.Goto, param = {dialogID = 190}},
			},
			}
		},
	},
[190] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20022,
		soundID = nil,
		txt = "很好，此小妖你就收做宠物吧，在今后的历练中，此小妖会成为你的助力。最近听闻师傅有要事相商，你且前去师傅那询问。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1052}},
				{action = DialogActionType.UITip, param = {v = 18,p = 1}},
			{action = DialogActionType.UITip, param = {v = 19,p = 1}},
				},
			}
		},
	},
[191] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1052}},
				    {action = DialogActionType.Goto, param = {dialogID = 146}},
			},
			}
		},
	},
[192] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20008,
		soundID = nil,
		txt = "为师最近听闻座下弟子禀报，说近日门派内有妖物作祟，你且前去寻为师座下大弟子，打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1054}},
					},
			}
		},
	},
[193] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师傅叫我来询问门派妖物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1054}},
				    {action = DialogActionType.Goto, param = {dialogID = 194}},
			},
			}
		},
	},
[194] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20026,
		soundID = nil,
		txt = "此妖物乃是偷跑出来玩闹的小妖，你且前去捕捉此妖物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1055}},
					},
			}
		},
	},
[195] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，此妖物已捕捉来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1055}},
				    {action = DialogActionType.Goto, param = {dialogID = 196}},
			},
			}
		},
	},
[196] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20026,
		soundID = nil,
		txt = "很好，此小妖你就收做宠物吧，在今后的历练中，此小妖会成为你的助力。最近听闻师傅有要事相商，你且前去师傅那询问。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1057}},
				{action = DialogActionType.UITip, param = {v = 18,p = 1}},
			{action = DialogActionType.UITip, param = {v = 19,p = 1}},
				},
			}
		},
	},
[197] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1057}},
				    {action = DialogActionType.Goto, param = {dialogID = 156}},
			},
			}
		},
	},
[198] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20009,
		soundID = nil,
		txt = "为师最近听闻座下弟子禀报，说近日门派内有妖物作祟，你且前去寻为师座下大弟子，打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1059}},
					},
			}
		},
	},
[199] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师傅叫我来询问门派妖物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1059}},
				    {action = DialogActionType.Goto, param = {dialogID = 200}},
			},
			}
		},
	},
[200] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20024,
		soundID = nil,
		txt = "此妖物乃是偷跑出来玩闹的小妖，你且前去捕捉此妖物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1060}},
					},
			}
		},
	},
[201] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，此妖物已捕捉来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1060}},
				    {action = DialogActionType.Goto, param = {dialogID = 202}},
			},
			}
		},
	},
[202] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20024,
		soundID = nil,
		txt = "很好，此小妖你就收做宠物吧，在今后的历练中，此小妖会成为你的助力。最近听闻师傅有要事相商，你且前去师傅那询问。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1062}},
				{action = DialogActionType.UITip, param = {v = 18,p = 1}},
			{action = DialogActionType.UITip, param = {v = 19,p = 1}},
				},
			}
		},
	},
[203] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1062}},
				    {action = DialogActionType.Goto, param = {dialogID = 166}},
			},
			}
		},
	},
[205] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某和两位兄弟关羽、张飞前来剿灭黄巾贼党，不料误中张角妖军埋伏，我虽拼死冲出围困，但我两位兄弟却被张宝的手下张梁围困在前方，还望英雄助我重新杀入重围击杀张梁，找回我那两位兄弟",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1065}},
					},
			}
		},
	},
[206] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20031,
		soundID = nil,
		txt = "我乃张梁手下副将马相，在此等候多时，刘备你既然来了留下性命吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 207}},
					},
			}
		},
	},
[207] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "马相！还不快快放了我二弟！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 102,mapID = 101}},
				},
			}
		},
	},
[208] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20032,
		soundID = nil,
		txt = "多谢大哥和英雄相救！关某已探得三弟翼德现正被张角的另一个黄巾将领杜远率妖兵围困于前方，我等速去与三弟会合，斩杀杜远！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1065}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1066}},
			},
			}
		},
	},
[209] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20033,
		soundID = nil,
		txt = "站住！我奉杜远将军之令把守此地，任何人都休想通过！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 210}},
					},
			}
		},
	},
[210] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20032,
		soundID = nil,
		txt = "尔等阻拦我寻我三弟，真是不知死活！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 103,mapID = 101}},
				},
			}
		},
	},
[211] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20036,
		soundID = nil,
		txt = "糟糕！那些饭桶！竟然让你们杀到这里来救人了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 212}},
					},
			}
		},
	},
[212] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "翼德莫慌，我们这就斩杀此贼救你出来！  ",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 104,mapID = 101}},
				},
			}
		},
	},
[213] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20037,
		soundID = nil,
		txt = "多谢大哥二哥和英雄相救！张梁如今就在前方，我们这就前往击杀张梁。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1066}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1067}},
			},
			}
		},
	},
[214] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张梁，你竟替那张角卖命，荼毒苍生，今日我等便要替天下除害！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 215}},
					},
			}
		},
	},
[215] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20040,
		soundID = nil,
		txt = "没料尔等竟能闯到此地。也罢！尔等一心求死，那就让本座送尔等上路吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 105,mapID = 101}},
				},
			}
		},
	},
[216] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "谢谢英雄相助，吾听闻那张角欲破坏封神台，封神台乃元始天尊命姜尚修建镇压万千妖魔的地方，若封神台被破，则天下大乱，后果不堪设想，我们需立刻前往封神台阻止！ ",
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
[217] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20043,
		soundID = nil,
		txt = "俺奉主公张角之令把守此地，尔等休想接近封神台，坏俺家主公大事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 218}},
					},
			}
		},
	},
[218] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "贼子休得猖狂，看我怎么收拾你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 106,mapID = 102}},
				},
			}
		},
	},
[219] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20044,
		soundID = nil,
		txt = "黄巾上将程远志在此！本将军奉命把守封神台，凡靠近者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 220}},
					},
			}
		},
	},
[220] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "程远志，你逆天而行，今日便是你的死期！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 107,mapID = 102}},
				},
			}
		},
	},
[221] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "尔乃何人，张角老贼现在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 222}},
					},
			}
		},
	},
[222] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20045,
		soundID = nil,
		txt = "我乃张角之弟张宝，俺兄长已成功解开封神台的封印！只要他破除封神台内最后一道封印，届时妖魔群出，这天下就是俺黄巾军的了！你们既已知晓受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 108,mapID = 102}},
				},
			}
		},
	},
[223] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "不妙，吾等虽已斩杀张宝，但张角老贼早已在封神台，一旦封神台最后一道封印被张角所破，必将妖魔群出，天下大乱！我等速入封神台，定要阻止张角那厮！",
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
[224] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张角老贼现在何处，若不快快道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 225}},
					},
			}
		},
	},
[225] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20046,
		soundID = nil,
		txt = "想见天公将军张角大人先闯过我这关再说！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 109,mapID = 102}},
				},
			}
		},
	},
[226] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20047,
		soundID = nil,
		txt = "黄巾大将张曼成在此！尔等穷追不舍，想坏吾家主公大事，定要尔等葬身于此地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 227}},
					},
			}
		},
	},
[227] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "助纣为虐，看招吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 110,mapID = 102}},
				},
			}
		},
	},
[228] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "张角老贼，快快给我住手！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 229}},
					},
			}
		},
	},
[229] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20048,
		soundID = nil,
		txt = "刘备，你来晚了！封神台的最后一道封马上就要被本座破掉，万千妖魔群出，天下即将大乱！哈哈！这江山迟早是我的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 113,mapID = 102}},
				},
			}
		},
	},
[230] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20048,
		soundID = nil,
		txt = "封神台封印已破，本座已成功完成使命，便不再奉陪了，这便去也，后会有期！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[231] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "糟糕！封神台封印已被张角老贼破坏，妖魔逃往各方！此地非说话之所，我们先离开此地，从长计议！",
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
[232] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "糟糕！封神台封印已被张角老贼破坏，妖魔逃往各方！我大汉天下危矣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1070}},
				    {action = DialogActionType.Goto, param = {dialogID = 233}},
			},
			}
		},
	},
[233] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "封神台之事非同小可，我这便返回玄都玉京天将此事告知元始天尊。 ",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1071}},
					},
			}
		},
	},
[234] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "元始祖师，封神台被张角破坏，千万妖魔逃往四方，该如何是好？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 235}},
					},
			}
		},
	},
[235] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1071}},
				    {action = DialogActionType.Goto, param = {dialogID = 236}},
			},
			}
		},
	},
[236] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你且前去找他探讨此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1072}},
				    {action = DialogActionType.Goto, param = {dialogID = 237}},
			},
			}
		},
	},
[237] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "遵命，弟子这便去找他。",
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
[238] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，岐山封神台被张角摧毁，无数妖魔逃窜四方，大汉子民危矣。还望朝廷遣大军收伏妖魔！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1072}},
				    {action = DialogActionType.Goto, param = {dialogID = 240}},
			},
			}
		},
	},
[239] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "我亦想立即将此事禀报圣上，奏请出兵，奈何有阉宦十常侍祸乱后宫，将陛下软禁，朝中大臣根本无法面见陛下。只有除掉十常侍，方可调动朝廷军队。",
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
[240] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "我亦想立即将此事禀报圣上，奏请出兵，奈何有阉宦十常侍祸乱后宫，将陛下软禁，朝中大臣根本无法面见陛下。只有除掉十常侍，方可调动朝廷军队。御林军统领蹇硕乃是十常侍头目张让心腹，要除十常侍，必先除掉蹇硕。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1073}},
					},
			}
		},
	},
[241] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20052,
		soundID = nil,
		txt = "擅闯御花园，意欲何为？难不成是想谋反吗？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 242}},
					},
			}
		},
	},
[242] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休得拦我，蹇硕在哪里？叫他滚出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 114,mapID = 103}},
				},
			}
		},
	},
[243] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20053,
		soundID = nil,
		txt = "蹇硕在此，何人在御花园造次，真是活的不耐烦了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 244}},
					},
			}
		},
	},
[244] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "蹇硕，你伙同阉宦十常侍张让软禁陛下，操弄权柄，今日便要替天下人除掉你此祸害！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 115,mapID = 103}},
				},
			}
		},
	},
[245] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "蹇硕已除，这就继续前行击杀张让。",
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
[246] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20056,
		soundID = nil,
		txt = "站住，张让大人有令，擅闯御花园者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 247}},
					},
			}
		},
	},
[247] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我要见张让，尔等速速让开，我便让你们一条性命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 116,mapID = 103}},
				},
			}
		},
	},
[248] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张让，总算找到你了！你软禁圣上已久，如今把圣上藏在了何处，快快道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 249}},
					},
			}
		},
	},
[249] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20057,
		soundID = nil,
		txt = "圣上素来宠信咱家，咱家对圣上也是忠心耿耿，何来软禁之说！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 117,mapID = 103}},
				},
			}
		},
	},
[250] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，陛下究竟在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 251}},
					},
			}
		},
	},
[251] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20057,
		soundID = nil,
		txt = "英雄饶命！陛下现如今藏在御花园南苑，英雄可前往查探。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[252] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "皇帝为何不在御花园南苑，莫非被人给劫走了不成？",
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
[253] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "尔等作为御前侍卫，为何鬼鬼祟祟，皇帝失踪是不是和你们有关？还不速速报来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[254] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20058,
		soundID = nil,
		txt = "不好被发现了，快逃！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[255] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢植大人，我前往御花园查探皇上下落，发现皇上失踪了，并在御花园发现假冒的御前侍卫。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1076}},
				    {action = DialogActionType.Goto, param = {dialogID = 256}},
			},
			}
		},
	},
[256] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "究竟是何方妖魔，竟掳走陛下！京畿警卫向来由朝廷大将皇甫嵩负责，如今他正在洛阳城中，你可前去寻他，打探近日洛阳有否发现妖魔踪迹。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1077}},
					},
			}
		},
	},
[257] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "皇甫将军，陛下前两日被一妖魔潜入宫中抓走了，我奉卢植大人之令，特前来查探此事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1077}},
				    {action = DialogActionType.Goto, param = {dialogID = 258}},
			},
			}
		},
	},
[258] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20059,
		soundID = nil,
		txt = "假冒的御前侍卫混入皇宫，御前侍卫统领赵忠脱不了关系，很可能和此事有关，他现在洛阳城城门你前去找他打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1078}},
					},
			}
		},
	},
[259] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "假冒的御前侍卫混入皇宫，是不是你在背后捣鬼？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 260}},
					},
			}
		},
	},
[260] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20060,
		soundID = nil,
		txt = "既然你已知晓，那就不能留你性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 120,mapID = 10}},
				},
			}
		},
	},
[261] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20060,
		soundID = nil,
		txt = "英雄饶命是我一时糊涂，接受了黑风山贼张燕的收买，才允许那些人混入皇宫的。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[262] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说那张燕现如今何处！有何图谋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1078}},
				    {action = DialogActionType.Goto, param = {dialogID = 263}},
			},
			}
		},
	},
[263] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20060,
		soundID = nil,
		txt = "张燕乃当年张角的亲传弟子，神通高强，张角破坏封神台之后张燕率一群黑山贼匪占领盘踞黑风山为恶。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1079}},
					},
			}
		},
	},
[264] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20061,
		soundID = nil,
		txt = "什么人，敢擅闯我黑风山！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 265}},
					},
			}
		},
	},
[265] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张燕现在何处，快快从实交来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 121,mapID = 104}},
				},
			}
		},
	},
[266] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20064,
		soundID = nil,
		txt = "吾乃张燕手下大将张泽是也，就凭你也想见我们张燕大人，先看你有没有这个本事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 267}},
					},
			}
		},
	},
[267] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就先拿下你，再找张燕。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 122,mapID = 104}},
				},
			}
		},
	},
[268] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20065,
		soundID = nil,
		txt = "站住！何人敢闯入我黑风山之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[269] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张燕这厮躲在什么地方，快点如实招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[270] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20066,
		soundID = nil,
		txt = "我家张大人有令，要治你等擅闯山门之罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 271}},
					},
			}
		},
	},
[271] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张燕这厮鬼鬼祟祟躲起来不敢见人，定然心里有鬼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 123,mapID = 104}},
				},
			}
		},
	},
[272] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20067,
		soundID = nil,
		txt = "吾乃黄巾大将张燕是也！你等穷追不舍，究竟意欲何为？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 273}},
					},
			}
		},
	},
[273] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张燕你收买赵忠，派假冒的御前侍卫混入皇宫，皇帝失踪是不是你掳走的？还不速速道来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 124,mapID = 104}},
				},
			}
		},
	},
[274] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20067,
		soundID = nil,
		txt = "本将军认输了，英雄休要再打。皇帝失踪乃前方的黑风老妖所为，黑风老妖的洞府黑风洞就在前方不远，那小皇帝也确实是他抓走的，你若想找回小皇帝，尽管去找他算账便好，此事和我无关。",
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
[275] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20068,
		soundID = nil,
		txt = "什么人，敢擅闯我黑风洞！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 276}},
					},
			}
		},
	},
[276] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快点叫黑风老妖乖乖把当今圣上交出来，否则定叫你们死无葬身之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 125,mapID = 104}},
				},
			}
		},
	},
[277] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20069,
		soundID = nil,
		txt = "尔等竟敢擅闯我山门，杀我弟子，可恨！今日本老祖定要将尔等碎尸万段！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 278}},
					},
			}
		},
	},
[278] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "黑风老妖，你把皇帝陛下藏在哪了，快快交来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 126,mapID = 104}},
				},
			}
		},
	},
[279] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那黑风老妖道行高深，非我所能对付，可陛下如今又落在此妖手中，非救不可！我这便返回师门求助师傅！",
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
[280] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，皇帝陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1082}},
				    {action = DialogActionType.Goto, param = {dialogID = 281}},
			},
			}
		},
	},
[281] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "此黑风老妖乃千年老妖，为师也未必是其对手，为师这便送你前往玉泉山，拜见我阐教金仙玉鼎真人祖师，玉鼎祖师定能助你降服黑风老妖。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1083}},
					},
			}
		},
	},
[283] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玉鼎祖师，晚辈如今在人间为搭救汉室皇帝，却受阻于黑风老妖，还望祖师助我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1083}},
				    {action = DialogActionType.Goto, param = {dialogID = 304}},
			},
			}
		},
	},
[284] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，皇帝陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1084}},
				    {action = DialogActionType.Goto, param = {dialogID = 285}},
			},
			}
		},
	},
[285] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20005,
		soundID = nil,
		txt = "此黑风老妖乃千年老妖，为师也未必是其对手，为师这便送你前往玉泉山，拜见我阐教金仙玉鼎真人祖师，玉鼎祖师定能助你降服黑风老妖。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1085}},
					},
			}
		},
	},
[287] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玉鼎祖师，晚辈如今在人间为搭救汉室皇帝，却受阻于黑风老妖，还望祖师助我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1085}},
				    {action = DialogActionType.Goto, param = {dialogID = 304}},
			},
			}
		},
	},
[288] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，皇帝陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1086}},
				    {action = DialogActionType.Goto, param = {dialogID = 289}},
			},
			}
		},
	},
[289] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20006,
		soundID = nil,
		txt = "此黑风老妖乃千年老妖，为师也未必是其对手，为师这便送你前往玉泉山，拜见我阐教金仙玉鼎真人祖师，玉鼎祖师定能助你降服黑风老妖。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1087}},
					},
			}
		},
	},
[291] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玉鼎祖师，晚辈如今在人间为搭救汉室皇帝，却受阻于黑风老妖，还望祖师助我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1087}},
				    {action = DialogActionType.Goto, param = {dialogID = 304}},
			},
			}
		},
	},
[292] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，皇帝陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1088}},
				    {action = DialogActionType.Goto, param = {dialogID = 293}},
			},
			}
		},
	},
[293] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20007,
		soundID = nil,
		txt = "此黑风老妖乃千年老妖，为师也未必是其对手，为师这便送你前往玉泉山，拜见我阐教金仙玉鼎真人祖师，玉鼎祖师定能助你降服黑风老妖。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1089}},
					},
			}
		},
	},
[295] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玉鼎祖师，晚辈如今在人间为搭救汉室皇帝，却受阻于黑风老妖，还望祖师助我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1089}},
				    {action = DialogActionType.Goto, param = {dialogID = 304}},
			},
			}
		},
	},
[296] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，皇帝陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1090}},
				    {action = DialogActionType.Goto, param = {dialogID = 297}},
			},
			}
		},
	},
[297] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20008,
		soundID = nil,
		txt = "此黑风老妖乃千年老妖，为师也未必是其对手，为师这便送你前往玉泉山，拜见我阐教金仙玉鼎真人祖师，玉鼎祖师定能助你降服黑风老妖。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1091}},
					},
			}
		},
	},
[299] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玉鼎祖师，晚辈如今在人间为搭救汉室皇帝，却受阻于黑风老妖，还望祖师助我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1091}},
				    {action = DialogActionType.Goto, param = {dialogID = 304}},
			},
			}
		},
	},
[300] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，皇帝陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1092}},
				    {action = DialogActionType.Goto, param = {dialogID = 301}},
			},
			}
		},
	},
[301] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20009,
		soundID = nil,
		txt = "此黑风老妖乃千年老妖，为师也未必是其对手，为师这便送你前往玉泉山，拜见我阐教金仙玉鼎真人祖师，玉鼎祖师定能助你降服黑风老妖。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1093}},
					},
			}
		},
	},
[303] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玉鼎祖师，晚辈如今在人间为搭救汉室皇帝，却受阻于黑风老妖，还望祖师助我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1093}},
				    {action = DialogActionType.Goto, param = {dialogID = 304}},
			},
			}
		},
	},
[304] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20070,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为二郎真君杨戬，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1094}},
					},
			}
		},
	},
[305] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20071,
		soundID = nil,
		txt = "吾乃杨戬，奉吾师之命在此久候多时。吾等这便进入黑风洞，收伏黑风老妖吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1094}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1095}},
			},
			}
		},
	},
[306] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就有劳上仙出手了！",
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
[307] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20103,
		soundID = nil,
		txt = "不知死活的小子，上次让你溜了，居然又来送死，这次看你还怎么跑！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 308}},
					},
			}
		},
	},
[308] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20071,
		soundID = nil,
		txt = "黑风老妖，可识得吾杨戬！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 127,mapID = 104}},
				},
			}
		},
	},
[309] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20103,
		soundID = nil,
		txt = "别打了！本老祖投降便是，还望二郎真君饶命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[310] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20071,
		soundID = nil,
		txt = "人间皇帝如今身在何处！快快道来，本真君尚可网开一面！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[311] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20103,
		soundID = nil,
		txt = "我抓走人间皇帝，实乃受西凉诸侯董卓之托，如今皇帝已被我遣人送予到了董卓手中！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 312}},
					},
			}
		},
	},
[312] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20071,
		soundID = nil,
		txt = "黑风老妖已降，皇帝下落也已查清，本君这便返回天界，小友快去把此消息禀于汉室之人，设法营救皇帝吧！",
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
[313] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "皇甫将军，我已从黑风老妖口中得知，当今圣上已被黑风老妖送往了西凉诸侯董卓之手！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1095}},
				    {action = DialogActionType.Goto, param = {dialogID = 314}},
			},
			}
		},
	},
[314] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20059,
		soundID = nil,
		txt = "董卓此人向来野心勃勃，如今竟私下掳走皇帝陛下，其心可诛！长安是董卓大军的驻军要地，你且前往长安打探董卓下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1096}},
					},
			}
		},
	},
[315] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你可知长安驻军要地的动静和小皇帝的下落，如实报来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 316}},
					},
			}
		},
	},
[316] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20074,
		soundID = nil,
		txt = "吾乃长安营前将军樊定，就凭你也有资格打探我长安的驻军要地，纳命来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 128,mapID = 105}},
				},
			}
		},
	},
[317] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20074,
		soundID = nil,
		txt = "皇帝的下落在下不知道，但此地的的樊稠是董卓心腹大将，他肯定知道。",
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
[318] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20075,
		soundID = nil,
		txt = "我董军军营岂是你能擅闯的？小的们，给本将拿下此人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 319}},
					},
			}
		},
	},
[319] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你等董卓走狗，皆是死有余辜！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 129,mapID = 105}},
				},
			}
		},
	},
[320] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20076,
		soundID = nil,
		txt = "你是何人，无故闯我军营，杀我将士，对本将苦苦相逼，意欲何为？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 321}},
					},
			}
		},
	},
[321] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你等逆贼竟敢私下掳走当今陛下，我今日便是来找你们算账的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 130,mapID = 105}},
				},
			}
		},
	},
[322] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20076,
		soundID = nil,
		txt = "英雄饶命！小的认输了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[323] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓这逆贼如今把圣上藏在了何处？还不快快从实招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 324}},
					},
			}
		},
	},
[324] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20076,
		soundID = nil,
		txt = "董卓筑有一处秘密堡垒在长安南边，圣上便是被董卓藏在此地，英雄想要营救圣上，可去长安南边一探究竟。 ",
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
[325] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20079,
		soundID = nil,
		txt = "长安乃我家主公董卓军垒重地，你竟敢擅闯，真是活腻了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 326}},
					},
			}
		},
	},
[326] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休得拦我，皇帝在哪，还不报出实情！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 131,mapID = 105}},
				},
			}
		},
	},
[327] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "当今皇帝是不是藏于此长安之地，还不快快把皇帝交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 328}},
					},
			}
		},
	},
[328] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20080,
		soundID = nil,
		txt = "吾乃上古大魔飞廉，想知道皇帝的下落，看你本事如何！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 132,mapID = 105}},
				},
			}
		},
	},
[329] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "糟糕！这魔头好生厉害，我已体力不支，不是他的对手，今日还是先跑为上！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
						},
			}
		},
	},
[330] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大人，我前往长安打探皇帝下落，不料中了上古大魔飞廉的埋伏，原来从封神台逃出的一些妖魔如今已经投靠董卓，有这些妖兵相助，董卓实力大涨。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1098}},
				    {action = DialogActionType.Goto, param = {dialogID = 331}},
			},
			}
		},
	},
[331] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20059,
		soundID = nil,
		txt = "此事事关重要，你且前往洛阳询问卢植大人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1099}},
					},
			}
		},
	},
[332] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，我已查明抓走陛下的人乃是西凉董卓，还望卢大人能够遣大军讨伐董卓，剿灭逆贼，营救陛下！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1099}},
				    {action = DialogActionType.Goto, param = {dialogID = 333}},
			},
			}
		},
	},
[333] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "西园校尉袁绍四世三公，对付董卓由他出面召唤天下英雄讨伐董卓，天下群雄必定应者如云。袁大人现在洛阳城袁府中，你且前往寻找袁大人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
					},
			}
		},
	},
[334] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你等何人，为何出现在袁绍府中！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 335}},
					},
			}
		},
	},
[335] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20083,
		soundID = nil,
		txt = "我乃董卓将领魏续是也，奉命前来捉拿袁绍！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 336}},
					},
			}
		},
	},
[336] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "原来是董卓的手下，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 133,mapID = 10}},
				},
			}
		},
	},
[337] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20083,
		soundID = nil,
		txt = "英雄饶命，袁绍不满我家主公董卓掌控朝廷，我家主公特命我等前来捉拿袁绍，不料袁绍已逃走。想必我我家主公定会派出大量追兵围捕袁绍。",
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
[338] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "糟糕！袁绍大人想必此刻处境非常危险，董卓如今在郿坞有一支驻军，驻守头领李肃乃是董卓心腹大将。如能够降伏此人，定能知道袁绍的下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1100}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1121}},
			},
			}
		},
	},
[339] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20086,
		soundID = nil,
		txt = "我乃董太师手下驻守大将李肃是也，你是何人，敢如此放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 340}},
					},
			}
		},
	},
[340] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "可知袁绍如今在何处？快快从实交来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 134,mapID = 106}},
				},
			}
		},
	},
[341] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20089,
		soundID = nil,
		txt = "何人敢擅闯我郿坞大营！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 342}},
					},
			}
		},
	},
[342] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁绍被关押在哪里？快快说来，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 135,mapID = 106}},
				},
			}
		},
	},
[343] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁将军莫慌，我这便来救你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 344}},
					},
			}
		},
	},
[344] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20090,
		soundID = nil,
		txt = "就是你小子想要救袁绍的？来得正好，本将正要捉拿几个袁绍同党去找董太师邀功呢！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 136,mapID = 106}},
				},
			}
		},
	},
[345] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁将军，我此番救你，乃是望你能以你袁家四世三公之声望联络天下群雄，共伐董卓，营救圣上，匡扶汉室。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1122}},
				    {action = DialogActionType.Goto, param = {dialogID = 346}},
			},
			}
		},
	},
[346] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "袁某早有讨伐董贼之心，故才被他所擒。听闻董卓已遣其手下大将段煨前来阻截袁某出郿坞，还望英雄杀退追兵，助我脱困！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1123}},
					},
			}
		},
	},
[347] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20094,
		soundID = nil,
		txt = "袁绍休跑！本将奉董太师之令前来捉你问罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 348}},
					},
			}
		},
	},
[348] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "有我在此，你们休想动袁绍一根毫毛！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 137,mapID = 106}},
				},
			}
		},
	},
[349] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20095,
		soundID = nil,
		txt = "袁绍，看你往哪里跑！你若束手就擒，我还可在董太师面前替你美言几句，饶你一命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 350}},
					},
			}
		},
	},
[350] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "董贼罪恶滔天，我袁绍和他誓不两立！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 138,mapID = 106}},
				},
			}
		},
	},
[351] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "多谢英雄！但要号召天下群雄讨董，我必先逃出郿坞大营。听闻这次董卓派出同族弟董雯前来镇守郿坞关出口，还望英雄击退董雯，助我离开郿坞大营。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1123}},
				    {action = DialogActionType.Goto, param = {dialogID = 352}},
			},
			}
		},
	},
[352] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁将军放心，我必会平安护送你出郿坞大营的，我们这便出发！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1124}},
					},
			}
		},
	},
[353] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20097,
		soundID = nil,
		txt = "站住！你们是何人，因何来我郿坞大营兵家重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 354}},
					},
			}
		},
	},
[354] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我二人要过此关，还不快快让开！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 140,mapID = 106}},
				},
			}
		},
	},
[355] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20096,
		soundID = nil,
		txt = "袁绍！本将等你多时了！董太师已行令天下要捉你，今日本将就擒你回去请赏！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 356}},
					},
			}
		},
	},
[356] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "有我在此，岂容你动袁将军分毫！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 139,mapID = 106}},
				},
			}
		},
	},
[357] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "郿坞关已过，前方已是我袁家地盘，董卓休想再奈何袁某！多谢英雄一路相送！袁某此番回去，定然号召天下群雄，共举讨董义旗！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1124}},
				    {action = DialogActionType.Goto, param = {dialogID = 358}},
			},
			}
		},
	},
[358] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那袁将军多加保重了！我这便返归洛阳，寻卢植大人复命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1125}},
					},
			}
		},
	},
[359] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，我已将袁绍护送出郿坞大营，不日他便将号召天下群雄共举义旗讨伐董卓！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1125}},
				    {action = DialogActionType.Goto, param = {dialogID = 1001}},
			},
			}
		},
	},
[360] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "英雄来晚了一步，现刘备、关羽、张飞三人已前往巨鹿讨伐张角，英雄可速去巨鹿相助三人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1035}},
					},
			}
		},
	},
[361] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "英雄来晚了一步，现刘备、关羽、张飞三人已前往巨鹿讨伐张角，英雄可速去巨鹿相助三人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1041}},
					},
			}
		},
	},
[362] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "英雄来晚了一步，现刘备、关羽、张飞三人已前往巨鹿讨伐张角，英雄可速去巨鹿相助三人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1046}},
					},
			}
		},
	},
[363] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "英雄来晚了一步，现刘备、关羽、张飞三人已前往巨鹿讨伐张角，英雄可速去巨鹿相助三人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1051}},
					},
			}
		},
	},
[364] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "英雄来晚了一步，现刘备、关羽、张飞三人已前往巨鹿讨伐张角，英雄可速去巨鹿相助三人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1056}},
					},
			}
		},
	},
[365] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "英雄来晚了一步，现刘备、关羽、张飞三人已前往巨鹿讨伐张角，英雄可速去巨鹿相助三人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1061}},
					},
			}
		},
	},
[366] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃乾元岛弟子，特奉为师太极仙翁之命前来，助你三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1035}},
				    {action = DialogActionType.Goto, param = {dialogID = 205}},
			},
			}
		},
	},
[367] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃桃源洞弟子，特奉为师龙虎天师之命前来，助你三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1041}},
				    {action = DialogActionType.Goto, param = {dialogID = 205}},
			},
			}
		},
	},
[368] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃金霞山弟子，特奉为师妙道真君之命前来，助你三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1046}},
				    {action = DialogActionType.Goto, param = {dialogID = 205}},
			},
			}
		},
	},
[369] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃蓬莱阁弟子，特奉为师南海龙女之命前来，助你三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1051}},
				    {action = DialogActionType.Goto, param = {dialogID = 205}},
			},
			}
		},
	},
[370] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃紫阳门弟子，特奉为师黄天化之命前来，助你三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1056}},
				    {action = DialogActionType.Goto, param = {dialogID = 205}},
			},
			}
		},
	},
[371] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我乃云霄宫弟子，特奉为师纯阳真人之命前来，助你三人讨伐张角。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1061}},
				    {action = DialogActionType.Goto, param = {dialogID = 205}},
			},
			}
		},
	},
[372] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已成功击败玉清神将，不知祖师还有何吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1003}},
				    {action = DialogActionType.Goto, param = {dialogID = 118}},
			},
			}
		},
	},
[1001] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "袁绍虽已平安，但你要寻的另一位英雄曹操因不满董卓操控朝政，刺杀董卓失败，被他派兵追杀，现正困于东郡，还望英雄火速前往东郡，助其脱身！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1101}},
					},
			}
		},
	},
[1002] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20302,
		soundID = nil,
		txt = "英雄救我！我乃曹操同伴，不幸被擒，我知道曹操身在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1003}},
					},
			}
		},
	},
[1003] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20305,
		soundID = nil,
		txt = "刚捉了一个曹操同伙，没想又来一个，正好一并都捉了交予董太师请功！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 161,mapID = 107}},
				},
			}
		},
	},
[1004] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20302,
		soundID = nil,
		txt = "我乃董卓手下谋士陈宫，因佩服曹操为人，故背弃董卓，搭救曹操逃来此地，却被董军杀散。这次带兵追杀我们的是董军大将王方，只要找到此人，定能知晓曹将军下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1101}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1102}},
		    {action = DialogActionType.Goto, param = {dialogID = 1005}},
				},
			}
		},
	},
[1005] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那我这便出发，定要找到王方，打探到曹将军下落！",
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
[1006] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20309,
		soundID = nil,
		txt = "站住！尔等竟想营救逆贼曹操，该当何罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1007}},
					},
			}
		},
	},
[1007] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹操是不是已经落入你们手中，快快从实招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 162,mapID = 107}},
				},
			}
		},
	},
[1008] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20309,
		soundID = nil,
		txt = "英雄饶命！那曹操已被我军抓住了，如今就被关押在前方军营里，由大将董越看守！英雄要救曹操，可往军营找那董越。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1102}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1103}},
			},
			}
		},
	},
[1009] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军休慌，我这就来救你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1010}},
					},
			}
		},
	},
[1010] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20312,
		soundID = nil,
		txt = "又来一个送死的，也罢，本将就一起拿下交由董太师处置！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 163,mapID = 107}},
				},
			}
		},
	},
[1011] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，我此番救你，乃是望你以自身之声望号召天下群雄共讨董卓，营救天子，匡扶汉室！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1103}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1104}},
		    {action = DialogActionType.Goto, param = {dialogID = 1012}},
				},
			}
		},
	},
[1012] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "曹某也正有此心！奈何我现仍身处险境，需先逃回老家许昌，方有机会举起讨董义旗。此去许昌，东郡关口由董军大将成廉驻守，路上恐怕还有董军阻拦，还望英雄助我离开东郡！",
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
[1013] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "少侠，前方就是东郡关口，我们只要将成廉诛杀，就能离开东郡！",
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
[1014] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20317,
		soundID = nil,
		txt = "曹操！你竟敢背叛董太师，如今到了本将的地盘，本将这就擒你回去请赏！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1015}},
					},
			}
		},
	},
[1015] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，现在让开道路，尚可活命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 164,mapID = 107}},
				},
			}
		},
	},
[1016] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "东郡关口已过，曹某已平安无事！多谢英雄一路相送！曹某此番回去，便会立刻号召各地群雄，共讨逆贼董卓！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1105}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1106}},
		    {action = DialogActionType.Goto, param = {dialogID = 1017}},
				},
			}
		},
	},
[1017] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军请多多保重！我先行返回上界向天尊复命！",
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
[1018] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "元始祖师，我已成功寻到袁绍、曹操二人，助其号召天下群雄，共讨董卓！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1106}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1107}},
		    {action = DialogActionType.Goto, param = {dialogID = 1019}},
				},
			}
		},
	},
[1019] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "如今袁绍、曹操二人已号召天下十八路诸侯共伐董卓。然董卓得截教妖魔暗中相助，十八路诸侯被阻虎牢关外，寸步难行。你且再下界去见那诸侯盟主袁绍，助其破敌。",
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
[1020] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁盟主，听闻你已联络到天下十八路诸侯共讨董卓，我特奉命前来助你破敌。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1107}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1108}},
		    {action = DialogActionType.Goto, param = {dialogID = 1021}},
				},
			}
		},
	},
[1021] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20318,
		soundID = nil,
		txt = "我盟军与那董军已几番交战，只是那董卓手下有一员猛将华雄，有万夫不挡之勇，连斩我军数员大将。如今曹操已率军前往对付华雄，我恐他有失，还望英雄前去助他一臂之力！",
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
[1022] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，我奉袁盟主之令，前来助你对付那董军猛将华雄。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1108}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1109}},
		    {action = DialogActionType.Goto, param = {dialogID = 1023}},
				},
			}
		},
	},
[1023] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "曹某本欲邀战华雄，却听手下探子来报，有一自称关羽的英雄，竟孤身一人杀入虎牢关，声称要取华雄人头。我担心此人有失，还望英雄前往虎牢关寻此人相助！",
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
[1024] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "关羽大哥，让我来助你一臂之力！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1025}},
					},
			}
		},
	},
[1025] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20322,
		soundID = nil,
		txt = "来得正好！关某刚入虎牢关，却被贼将李蒙拦住！我们这便斩杀此人，再取华雄项上人头！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 165,mapID = 109}},
				},
			}
		},
	},
[1026] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20322,
		soundID = nil,
		txt = "真是杀得痛快！我们这便前往诛杀华雄，为盟军立下首功！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1109}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1110}},
			},
			}
		},
	},
[1027] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20325,
		soundID = nil,
		txt = "华雄在此！又来两个送死的！也罢，本将军这便送你二人上路！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1028}},
					},
			}
		},
	},
[1028] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "华雄，休得猖狂，我们今日便来取你项上人头！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 166,mapID = 109}},
				},
			}
		},
	},
[1029] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20322,
		soundID = nil,
		txt = "关某此番乃是和我两位兄弟刘备、张飞分头行动，我两位兄弟早已潜入虎牢关内，欲趁华雄身亡之机袭占虎牢关！我们速去虎牢关与他们会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1110}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1111}},
			},
			}
		},
	},
[1030] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "刘大哥，华雄已被斩杀，董军已乱，何不趁此良机杀入董营，攻占虎牢关！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1111}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1112}},
		    {action = DialogActionType.Goto, param = {dialogID = 1031}},
				},
			}
		},
	},
[1031] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20326,
		soundID = nil,
		txt = "二弟和小友果然立下奇功一件！如今在虎牢关下镇守的，乃是董军大将张辽，我们这便出发，诛杀张辽，袭占虎牢关！",
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
[1032] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20331,
		soundID = nil,
		txt = "张辽在此！敢来我虎牢关撒野，真是活得不耐烦了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1033}},
					},
			}
		},
	},
[1033] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20326,
		soundID = nil,
		txt = "素闻张辽此人武艺高强，大家小心应付！只要打败张辽，虎牢关就是盟军的了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 167,mapID = 109}},
				},
			}
		},
	},
[1034] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20331,
		soundID = nil,
		txt = "非张某不愿献关，乃是董卓义子吕布正在虎牢关督战，吕布乃盖世猛将，要如何对付他，就看各位了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1035}},
					},
			}
		},
	},
[1035] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20326,
		soundID = nil,
		txt = "那吕布，人称天下第一猛将，他亲自在此守关，我们兄弟三人该如何是好。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1036}},
					},
			}
		},
	},
[1036] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20327,
		soundID = nil,
		txt = "什么天下第一，我兄弟三人还怕他不成，我们这就去杀他个片甲不留。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1112}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1113}},
			},
			}
		},
	},
[1037] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20335,
		soundID = nil,
		txt = "吕布在此！何人敢来一战！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1038}},
					},
			}
		},
	},
[1038] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20327,
		soundID = nil,
		txt = "三姓家奴休走，燕人张翼德在此！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 168,mapID = 109}},
				},
			}
		},
	},
[1039] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20335,
		soundID = nil,
		txt = "我修得一身魔功，还不曾使用过，今天就让你们领教下我的厉害。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1040}},
					},
			}
		},
	},
[1040] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20326,
		soundID = nil,
		txt = "不好！这吕布也已修炼魔功，大家小心！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 169,mapID = 109}},
				},
			}
		},
	},
[1041] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20326,
		soundID = nil,
		txt = "这吕布不愧为天下第一猛将，我们联手还是让他跑了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1114}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1115}},
		    {action = DialogActionType.Goto, param = {dialogID = 1042}},
				},
			}
		},
	},
[1042] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20326,
		soundID = nil,
		txt = "如今华雄伏诛，吕布败逃，虎牢关不攻自破，英雄快去将此事禀告曹操。",
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
[1043] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，华雄已死，吕布也已败走，虎牢关不攻自破，还请发兵剿灭吕布残部。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1115}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1116}},
		    {action = DialogActionType.Goto, param = {dialogID = 1044}},
				},
			}
		},
	},
[1044] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "英雄武艺高强，助我盟军破关，实在感激。还请英雄返回东郡，告知盟主虎牢关已破，请他挥师西进，和董卓决战！",
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
[1045] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "参见盟主！虎牢关已破，华雄已死，吕布也被刘关张三人联手击退，我受曹将军所托，前来请您率兵西征董贼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1116}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1117}},
		    {action = DialogActionType.Goto, param = {dialogID = 1046}},
				},
			}
		},
	},
[1046] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20318,
		soundID = nil,
		txt = "没想英雄竟立下如此盖世奇功！袁某这便点发大军，挥师西征，与董贼决一死战！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1047}},
					},
			}
		},
	},
[1047] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那我这便返归上界，向我祖师复命。",
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
[1048] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "祖师，我已成功救下曹操将军，也已助其攻破虎牢关，现在袁绍大军已经挥师西行，征讨董贼了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1117}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1118}},
		    {action = DialogActionType.Goto, param = {dialogID = 1049}},
				},
			}
		},
	},
[1049] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本尊已知晓此事，但如今你修为还未达到一定高度，切不可沾沾自喜，如今你还须加强修炼，等你升到三十级再来找我吧！",
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
[1050] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师祖，弟子已经修炼成功，请指示！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1118}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1151}},
		    {action = DialogActionType.Goto, param = {dialogID = 1101}},
				},
			}
		},
	},
[1051] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20314,
		soundID = nil,
		txt = "曹操休走，我这就抓你回去请功！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 170,mapID = 109}},
				},
			}
		},
	},
[1052] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20315,
		soundID = nil,
		txt = "曹操！你还妄想逃出东郡，我定捉你回去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 171,mapID = 109}},
				},
			}
		},
	},
[1053] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20316,
		soundID = nil,
		txt = "曹操！你再进一步，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 172,mapID = 109}},
				},
			}
		},
	},
[1101] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "那吕布虽败，但董卓依然势大。如今伐董诸侯中有一英雄孙坚落入了董卓埋伏，被困潼关，此人关系到日后三分天下之大势，不容有失，你速下界往潼关搭救此人，助他脱困。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1151}},
					},
			}
		},
	},
[1102] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20601,
		soundID = nil,
		txt = "何人擅闯潼关重地，有何图谋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1103}},
					},
			}
		},
	},
[1103] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙坚将军所在何处，还不速速招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 175,mapID = 110}},
				},
			}
		},
	},
[1105] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20601,
		soundID = nil,
		txt = "英雄饶命，如今那孙坚已被我军生擒，正由杨定将军押送，就在前方不远处。",
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
[1106] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "速速停下！快放了孙将军，我便饶你一命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1107}},
					},
			}
		},
	},
[1107] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20602,
		soundID = nil,
		txt = "好大的口气，我倒要看看你有几分本事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 176,mapID = 110}},
				},
			}
		},
	},
[1108] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙将军可有受伤？不对！你不是孙将军，你是何人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1152}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1153}},
		    {action = DialogActionType.Goto, param = {dialogID = 1109}},
				},
			}
		},
	},
[1109] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20606,
		soundID = nil,
		txt = "在下祖茂，乃将军部下，打扮成孙将军只为引开追兵。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1110}},
					},
			}
		},
	},
[1111] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20606,
		soundID = nil,
		txt = "将军和我分头突围，不知是否突围成功，还要拜托英雄前往搭救，感激不尽。",
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
[1112] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你们快放了孙将军，我便饶你们不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1113}},
					},
			}
		},
	},
[1113] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20605,
		soundID = nil,
		txt = "哪里来的黄口小儿，竟敢大言不惭，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 177,mapID = 110}},
				},
			}
		},
	},
[1114] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20625,
		soundID = nil,
		txt = "多谢英雄救命之恩，孙某感激不尽。英雄，孙某军中两员大将朱治、吴景，就在前方，正由徐荣手下大将周恒押送，还望英雄能前往搭救。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1154}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1155}},
		    {action = DialogActionType.Goto, param = {dialogID = 1116}},
				},
			}
		},
	},
[1116] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙将军，您且在此歇息，我这就去救下二位将军。",
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
[1117] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20609,
		soundID = nil,
		txt = "黄口小儿，没想到你竟有能力来到此地，那就别想走了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1118}},
					},
			}
		},
	},
[1118] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "口出狂言，想要我的命，就看你有没有这个能力了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 178,mapID = 110}},
				},
			}
		},
	},
[1119] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20607,
		soundID = nil,
		txt = "多谢英雄救出我们，你且速去回复孙将军。",
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
[1121] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20625,
		soundID = nil,
		txt = "英雄有所不知，这徐荣军中凭空多出许多魔兵魔将，甚是厉害。此事十分蹊跷，我已派遣黄盖将军前往探查，但许久未归，英雄可否帮我探寻一番，孙某感激不尽。",
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
[1122] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20610,
		soundID = nil,
		txt = "何人在此游荡，还不速速离去，难不成是那叛军探子。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1123}},
					},
			}
		},
	},
[1123] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我正愁黄将军无迹可寻，你就自己送上门来，那就留下吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 179,mapID = 110}},
				},
			}
		},
	},
[1124] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快快道来！黄盖将军的下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1125}},
					},
			}
		},
	},
[1125] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20610,
		soundID = nil,
		txt = "英雄饶命，黄将军被我军生擒，正关押在北方大营，由梁兴将军看押。",
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
[1126] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20612,
		soundID = nil,
		txt = "来者何人，竟敢擅闯我潼关重地，不知死活么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1127}},
					},
			}
		},
	},
[1127] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休得猖狂，快告诉我梁兴身在何处？速叫他出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 180,mapID = 110}},
				},
			}
		},
	},
[1128] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "梁兴你终于出来了！速速放了黄盖将军，我便饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1129}},
					},
			}
		},
	},
[1129] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20613,
		soundID = nil,
		txt = "想让我放了黄盖，就看你有没有这个本事了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 181,mapID = 110}},
				},
			}
		},
	},
[1130] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "黄将军，我受孙坚将军之托，特来救你。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1158}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1159}},
		    {action = DialogActionType.Goto, param = {dialogID = 1131}},
				},
			}
		},
	},
[1131] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20626,
		soundID = nil,
		txt = "多谢英雄救命之恩，经我数日查探徐荣营中魔兵皆来自西南方，英雄可前往一探究竟。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1133}},
					},
			}
		},
	},
[1133] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我这就前去查探，将军可先去与孙将军汇合。",
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
[1137] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20615,
		soundID = nil,
		txt = "我军中的魔兵魔将，出自此处西南方的一妖阵，在下听闻董卓派遣了手下大将张横镇守妖阵。",
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
[1138] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20617,
		soundID = nil,
		txt = "吾乃张横，来者何人，擅闯禁地者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1139}},
					},
			}
		},
	},
[1139] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我今日偏要查探究竟，还不速速让开。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 183,mapID = 110}},
				},
			}
		},
	},
[1140] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20640,
		soundID = nil,
		txt = "英雄饶命，太师命我在此把守阵法入口，为吕岳道长护法，那魔兵魔将便是从这阵法之中产生的。",
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
[1142] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20619,
		soundID = nil,
		txt = "何人擅闯妖阵，既然来了，就做我阵中的一只孤魂吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1160}},
				    {action = DialogActionType.Goto, param = {dialogID = 1143}},
			},
			}
		},
	},
[1143] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕岳老贼，你休得猖狂，看我今日就收了你的性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 184,mapID = 111}},
				},
			}
		},
	},
[1144] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20639,
		soundID = nil,
		txt = "哈哈哈，无知小儿，你把老夫想的太简单了吧，老夫乃不死之身，你能奈我何，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1145}},
					},
			}
		},
	},
[1145] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "不好！如今这吕岳老妖杀死还能复活，不能恋战，今日且先撤，寻找解决办法。这吕岳老妖为何如此怪异，杀也杀不死，这该如何是好，看来还是得去问问祖师这是怎么回事！",
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
[1146] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "祖师，我在下界发现一个妖阵，妖阵里有一吕岳妖人，释放魔兵残害百姓，我且前去与之大战一场，却无法杀掉此妖人，请求祖师告知我如何诛杀此妖人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1161}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1162}},
		    {action = DialogActionType.Goto, param = {dialogID = 1147}},
				},
			}
		},
	},
[1147] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "此事我已知晓，你且前去寻找本座弟子莲花童子，他会告知你如何诛杀此妖人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1148}},
					},
			}
		},
	},
[1148] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢天尊，我这就去！",
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
[1149] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "莲花童子，我奉天尊之命，来向您讨教，我该如何杀死这个吕岳。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1150}},
					},
			}
		},
	},
[1150] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "此吕岳乃是上古截教妖人，虽法力高强但不可能不死，你诛杀的估计是吕岳的幻象，定是那妖阵有古怪。我这有一颗灭魂珠能破此阵，但此珠法力缺失，需要补充法力，你且前去收集金缠、烬枝、火魁、天禄四妖兽的魂魄，来炼制灭魂珠，助你破此妖阵，诛杀吕岳。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1163}},
					},
			}
		},
	},
[1151] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢童子指引，我这便下界。听闻这金缠、烬枝常在郿坞一带出没，先去郿坞找找找看。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1163}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1164}},
			},
			}
		},
	},
[1153] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20620,
		soundID = nil,
		txt = "没想到还会有人送上门来，那我就不客气收下了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1154}},
					},
			}
		},
	},
[1154] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "想要我的命，那就得看你有没有这个实力！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 185,mapID = 106}},
				},
			}
		},
	},
[1155] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "此金缠看起来凶神恶煞，没想到这么不堪一击。金缠魂魄已拿到，在前去寻找烬枝，听说此烬枝可以化形，和枯木难以区分，看来得仔细找找。",
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
[1159] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "这个烬枝竟然如此厉害，还好终于杀了它，接下来就去找火魁，听闻火魁在东郡一带活动，我这边就动身前往寻找！",
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
[1160] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20622,
		soundID = nil,
		txt = "来者何人，此地乃是我的地盘，你竟敢擅闯此地，不要命了吗!",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1161}},
					},
			}
		},
	},
[1161] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "火魁，你残害百姓，让百姓民不聊生，今日就将你斩首！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 187,mapID = 107}},
				},
			}
		},
	},
[1162] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "火魁已被诛杀，还剩最后一个天禄了，此天禄应该躲藏在虎牢关里，这就前去寻找。",
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
[1163] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "天禄，终于找到你了，你如今处处为祸作乱，今日就要将你诛杀。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1164}},
					},
			}
		},
	},
[1164] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20623,
		soundID = nil,
		txt = "想要诛杀我，那就得看你有没有这个本事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 188,mapID = 109}},
				},
			}
		},
	},
[1165] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "天禄已被诛杀，其魂魄也已收集，如今四个妖兽魂魄都已收集完成，赶紧回去找莲花童子，炼制灭魂珠，诛杀吕岳。",
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
[1167] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "做的很好，我这便炼制灭魂珠，助你斩杀妖人吕岳。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1168}},
					},
			}
		},
	},
[1168] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20003,
		soundID = nil,
		txt = "灭魂珠已炼制完成，这灭魂珠对着吕岳幻象使用，便可以破除妖阵效果！我这就助你前往潼关，为民除害。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1169}},
					},
			}
		},
	},
[1169] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢童子，我这便再去妖阵，斩杀吕岳老贼。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1168}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1169}},
			},
			}
		},
	},
[1173] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕岳老贼，看这是什么，你死到临头了，看我这边破除你的妖阵。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1169}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1170}},
		    {action = DialogActionType.Goto, param = {dialogID = 1174}},
				},
			}
		},
	},
[1174] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20624,
		soundID = nil,
		txt = "竟然是灭魂珠！没想到你和阐教还有关系，不过你以为你能打败我的真身么，真是白日做梦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1175}},
					},
			}
		},
	},
[1175] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，今日我必将你诛杀。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 189,mapID = 111}},
				},
			}
		},
	},
[1176] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕岳老贼已被诛杀，如今已无魔兵出现，前去将此消息告诉黄盖将军。",
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
[1178] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20626,
		soundID = nil,
		txt = "多谢英雄相助，解我军心头大患。我这就去整顿军队，取那徐荣狗命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1171}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1172}},
		    {action = DialogActionType.Goto, param = {dialogID = 1179}},
				},
			}
		},
	},
[1179] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "黄将军，你且带领将士们养精蓄锐，看我去杀了那徐荣。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1180}},
					},
			}
		},
	},
[1180] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20626,
		soundID = nil,
		txt = "英雄武艺高强，定能斩杀那徐荣，烦劳英雄，万事小心。",
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
[1181] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "徐荣老贼，今日就是你的死期，速速纳命来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1182}},
					},
			}
		},
	},
[1182] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20605,
		soundID = nil,
		txt = "原来又是你这个黄口小儿，口出狂言，想要我的命，就看你有没有这个本事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 190,mapID = 110}},
				},
			}
		},
	},
[1183] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20626,
		soundID = nil,
		txt = "英雄战果如何？那徐荣。。。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1184}},
					},
			}
		},
	},
[1184] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "放心黄盖将军，一切顺利，那徐荣已经被我斩杀。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1173}},
				    {action = DialogActionType.Goto, param = {dialogID = 1185}},
			},
			}
		},
	},
[1185] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20626,
		soundID = nil,
		txt = "好！哈哈！果然英雄出少年，那还请英雄前往洛阳禀告太守卢植，我这就整顿军队。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1186}},
					},
			}
		},
	},
[1186] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "好，黄将军，我先行一步。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1174}},
					},
			}
		},
	},
[1187] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀报太守，孙坚将军已被救下，同行的还有黄盖朱治吴景等诸位将军，潼关已经攻破。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1174}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1200}},
		    {action = DialogActionType.Goto, param = {dialogID = 1200}},
				},
			}
		},
	},
[1200] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "今董军大败，但董卓已藏匿，不知所踪，必须找出其藏身之地，将其彻底铲除！司徒王允表面上投靠董贼，实乃汉室忠义之臣。他现居住在长安城内，你可去找他打听董卓下落。",
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
[1201] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "王大人，我为董卓下落而来，王大人乃汉室忠良，可否将董卓下落告知与我？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1200}},
				    {action = DialogActionType.Goto, param = {dialogID = 1202}},
			},
			}
		},
	},
[1202] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20701,
		soundID = nil,
		txt = "董卓老奸巨猾，长安目前是董卓老贼控制的地盘，有他安排的众多耳线，你速速去除掉那老贼安排来监视我的李肃！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1201}},
					},
			}
		},
	},
[1203] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20704,
		soundID = nil,
		txt = "何人擅闯！来此有何事？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1204}},
					},
			}
		},
	},
[1204] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你这董卓的走狗，速速拿命来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 200,mapID = 13}},
				},
			}
		},
	},
[1205] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20701,
		soundID = nil,
		txt = "李肃已除，真是大快人心，不过老朽还是对你有所戒备，你且再去帮老夫杀掉董卓亲信王昭，才足以表明你的真心。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1201}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1202}},
			},
			}
		},
	},
[1206] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20720,
		soundID = nil,
		txt = "哪里来的混小子，敢档本大爷的道！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1207}},
					},
			}
		},
	},
[1207] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "王昭，我今天就要取你的狗命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 201,mapID = 13}},
				},
			}
		},
	},
[1208] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20701,
		soundID = nil,
		txt = "英雄好胆量，老朽佩服，虽然不知董卓具体去向，我早先遣义女貂蝉潜伏于董卓身边以为内应，如今她已获董卓宠信，现人在郿坞，你可前去寻她打听董卓的消息！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1202}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1203}},
			},
			}
		},
	},
[1209] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘，我奉你义父王允之令，来此打探董卓下落，好为天下除害,望姑娘告知于我。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1203}},
				    {action = DialogActionType.Goto, param = {dialogID = 1210}},
			},
			}
		},
	},
[1210] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20702,
		soundID = nil,
		txt = "我也不知董卓如今身在何处，不过我已成功离间董卓和其义子吕布的关系，使吕布对董卓怀恨在心。我今日原和吕布约好于郿坞私聚，奈何我被董卓亲信萵姬监视无法脱身，请英雄助我斩杀萵姬，前去会见吕布，便能知晓董卓下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1204}},
				    {action = DialogActionType.Goto, param = {dialogID = 1211}},
			},
			}
		},
	},
[1211] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20703,
		soundID = nil,
		txt = "貂蝉，董太师待你不薄，为何你今日要和此反贼勾结私逃！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1212}},
					},
			}
		},
	},
[1212] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓老贼荼毒天下，已是众叛亲离，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 202,mapID = 106}},
				},
			}
		},
	},
[1213] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘，现萵姬已除，你可安心会见吕布了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1204}},
					},
			}
		},
	},
[1214] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20702,
		soundID = nil,
		txt = "吕将军，我总算见到你了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1205}},
				    {action = DialogActionType.Goto, param = {dialogID = 1215}},
			},
			}
		},
	},
[1215] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20707,
		soundID = nil,
		txt = "你是何人，敢来打扰本将军！看本将军如何收拾你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1216}},
					},
			}
		},
	},
[1216] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉小心！吕布似乎神智不清，认不出你来了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 203,mapID = 106}},
				},
			}
		},
	},
[1217] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20702,
		soundID = nil,
		txt = "吕布如今神智狂乱，连我都认不出来了，似是遭人陷害，心智尽失，你且先去长安找我义父王允寻找解毒之法，我去找找吕布的踪迹。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1205}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1206}},
			},
			}
		},
	},
[1218] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕大人现已魔入侵心，请问王公有没有什么眉目？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1206}},
				    {action = DialogActionType.Goto, param = {dialogID = 2019}},
			},
			}
		},
	},
[1219] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20701,
		soundID = nil,
		txt = "我怀疑是董卓老贼对吕布做了什么手脚。董卓的心腹郭汜如今正在长安城内，从此人身上或许可以得知消息。",
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
[1236] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20708,
		soundID = nil,
		txt = "你是何人，竟然擅闯！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1237}},
					},
			}
		},
	},
[1237] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，董卓老贼现在何方！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 204,mapID = 13}},
				},
			}
		},
	},
[1238] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20752,
		soundID = nil,
		txt = "其实董卓一直对吕布心存怀疑，吕布手下的大将曹性其实便是董卓安插在吕布身边的奸细，从曹性处或许知道原因，曹性如今便在长安，你去寻他吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1207}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1208}},
			},
			}
		},
	},
[1239] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20710,
		soundID = nil,
		txt = "谁人闯我军营，不怕董太师见罪？！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1240}},
					},
			}
		},
	},
[1240] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹性，吕布将军为何心智尽失，是不是你在背后捣的鬼？还不快快道来",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 205,mapID = 13}},
				},
			}
		},
	},
[1241] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20731,
		soundID = nil,
		txt = "英雄饶命，其实董卓早已察觉吕布和貂蝉姑娘之事，前些日子董卓让一个亲信孙胜拿着一种药物前来寻他，令他在吕布的饮食中下毒，此人如今在长安还未离开。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1208}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1209}},
			},
			}
		},
	},
[1242] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙胜，可是你在吕布饮食中下毒！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1243}},
					},
			}
		},
	},
[1243] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20709,
		soundID = nil,
		txt = "是我又如何，欺瞒主上就该死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1244}},
					},
			}
		},
	},
[1244] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "死到临头还在诡辩，速速道出实情！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 206,mapID = 13}},
				},
			}
		},
	},
[1245] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20730,
		soundID = nil,
		txt = "吕布服食了我所下的上古魔毒，已心智尽失，嗜杀成性，只会听令于董卓一人！此魔毒乃截教金仙所赐，厉害无比，这世上只怕无药可解。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1209}},
				    {action = DialogActionType.Gotos, param = {dialogIDs = {1287,1288,1289,1290,1291,1292}}},
					},
			}
		},
	},
[1246] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀师父，那吕布如今被董卓以截教上古魔毒所害，变得心智尽失，不知师父可有办法能解此毒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1210}},
				    {action = DialogActionType.Goto, param = {dialogID = 1252}},
			},
			}
		},
	},
[1247] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀师父，那吕布如今被董卓以截教上古魔毒所害，变得心智尽失，不知师父可有办法能解此毒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1211}},
				    {action = DialogActionType.Goto, param = {dialogID = 1253}},
			},
			}
		},
	},
[1248] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀师父，那吕布如今被董卓以截教上古魔毒所害，变得心智尽失，不知师父可有办法能解此毒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1212}},
				    {action = DialogActionType.Goto, param = {dialogID = 1254}},
			},
			}
		},
	},
[1249] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀师父，那吕布如今被董卓以截教上古魔毒所害，变得心智尽失，不知师父可有办法能解此毒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1213}},
				    {action = DialogActionType.Goto, param = {dialogID = 1255}},
			},
			}
		},
	},
[1250] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀师父，那吕布如今被董卓以截教上古魔毒所害，变得心智尽失，不知师父可有办法能解此毒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1214}},
				    {action = DialogActionType.Goto, param = {dialogID = 1256}},
			},
			}
		},
	},
[1251] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "禀师父，那吕布如今被董卓以截教上古魔毒所害，变得心智尽失，不知师父可有办法能解此毒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1215}},
				    {action = DialogActionType.Goto, param = {dialogID = 1257}},
			},
			}
		},
	},
[1252] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人前辈精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1216}},
					},
			}
		},
	},
[1253] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20005,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人前辈精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1226}},
					},
			}
		},
	},
[1254] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20006,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人前辈精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1227}},
					},
			}
		},
	},
[1255] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20007,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人前辈精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1228}},
					},
			}
		},
	},
[1256] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20008,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人前辈精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1229}},
					},
			}
		},
	},
[1257] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20009,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人前辈精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1230}},
					},
			}
		},
	},
[1258] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1216}},
				    {action = DialogActionType.Goto, param = {dialogID = 1259}},
			},
			}
		},
	},
[1293] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1226}},
				    {action = DialogActionType.Goto, param = {dialogID = 1259}},
			},
			}
		},
	},
[1294] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1227}},
				    {action = DialogActionType.Goto, param = {dialogID = 1259}},
			},
			}
		},
	},
[1295] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1228}},
				    {action = DialogActionType.Goto, param = {dialogID = 1259}},
			},
			}
		},
	},
[1296] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1229}},
				    {action = DialogActionType.Goto, param = {dialogID = 1259}},
			},
			}
		},
	},
[1297] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1230}},
				    {action = DialogActionType.Goto, param = {dialogID = 1259}},
			},
			}
		},
	},
[1259] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20711,
		soundID = nil,
		txt = "要解那截教上古魔毒，本座还差一味药材，天山雪莲，你这便前往下界，在天山打探天山雪莲的下落，取来予我，本座自有解毒之法。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
					},
			}
		},
	},
[1293] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20714,
		soundID = nil,
		txt = "英雄请留步，我乃天山一介小妖，初次下山游玩不料竟被妖魔追捕，现下已无路可逃，还望英雄能救我脱困！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1217}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1218}},
			},
			}
		},
	},
[1260] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20712,
		soundID = nil,
		txt = "何人拦我去路，还不退开！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1261}},
					},
			}
		},
	},
[1261] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今天我就收了你这只妖孽。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 207,mapID = 115}},
				},
			}
		},
	},
[1262] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20714,
		soundID = nil,
		txt = "大人的救命之恩，小妖没齿难忘，若大人有何需求尽管提！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1263}},
					},
			}
		},
	},
[1263] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "在下受人所托，来此处寻找天山雪莲，如若知道下落可否告知？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1218}},
				    {action = DialogActionType.Goto, param = {dialogID = 1264}},
			},
			}
		},
	},
[1264] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20714,
		soundID = nil,
		txt = "天山雪莲长在天山北面，由一位妖魔常年看守着，大人可去寻找。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1219}},
					},
			}
		},
	},
[1265] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20713,
		soundID = nil,
		txt = "就凭你也打天山雪莲的主意，真是不知死活！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1266}},
					},
			}
		},
	},
[1266] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "好大的口气，若想活命便老实交代！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 208,mapID = 115}},
				},
			}
		},
	},
[1267] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20764,
		soundID = nil,
		txt = "几天前羌族一个叫俄何烧戈的人打伤我并把雪莲抢走了，英雄可自行去寻找。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1219}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1220}},
			},
			}
		},
	},
[1268] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20715,
		soundID = nil,
		txt = "羌族族长俄何烧戈在此，何人擅闯羌族领地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1269}},
					},
			}
		},
	},
[1269] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "俄何烧戈，老实交代天山雪莲可是在你手中？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 209,mapID = 115}},
				},
			}
		},
	},
[1270] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20733,
		soundID = nil,
		txt = "天山雪莲我已进贡给了天山的千年老妖暗影魔蛟，暗影魔蛟长年骚扰羌族族人，希望靠此宝物以换得族人平安。暗影魔蛟麾下有两大妖兽（风兽和雷兽），若能诛杀其麾下的两大妖兽，此老妖必会现身。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1220}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1221}},
			},
			}
		},
	},
[1271] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20716,
		soundID = nil,
		txt = "何人！竟敢擅闯禁地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1272}},
					},
			}
		},
	},
[1272] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "暗影魔蛟在何处，快快现身！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 210,mapID = 115}},
				},
			}
		},
	},
[1273] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20717,
		soundID = nil,
		txt = "要想见我主公，先过了我这关！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 211,mapID = 115}},
				},
			}
		},
	},
[1274] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20734,
		soundID = nil,
		txt = "英雄饶命，我家大人现在前方，英雄继续前往可见到我家主人。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1221}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1222}},
			},
			}
		},
	},
[1275] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20718,
		soundID = nil,
		txt = "凡人，吾乃天山妖兽，尔来此取金丹也太不自量力了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1276}},
					},
			}
		},
	},
[1276] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "妖怪！不自量力的是你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1277}},
				    {action = DialogActionType.Goto, param = {dialogID = 1277}},
			},
			}
		},
	},
[1277] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20718,
		soundID = nil,
		txt = "呵呵，看招！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 212,mapID = 115}},
				},
			}
		},
	},
[1278] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20735,
		soundID = nil,
		txt = "没想到世间竟有能打败吾的凡人！雪莲在此，拿去罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1222}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1223}},
			},
			}
		},
	},
[1279] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "道人，天山雪莲已交予你，还请道人施法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1280}},
					},
			}
		},
	},
[1280] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20711,
		soundID = nil,
		txt = "驱魔金丹已经练成，速去下界给吕布服用，我已得知貂蝉在西凉找到吕布，可前去寻找。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1223}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1224}},
			},
			}
		},
	},
[1281] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "貂蝉姑娘，我已拿到驱魔金丹，吕大人现在情况如何？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1282}},
					},
			}
		},
	},
[1282] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20702,
		soundID = nil,
		txt = "吕布还在魔化中，且等他清醒再从长计议。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1224}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1225}},
			},
			}
		},
	},
[1283] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20707,
		soundID = nil,
		txt = "吕布在此！鼠辈可敢一战！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1284}},
					},
			}
		},
	},
[1284] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕布，你被魔毒所侵尚不自知，还不快快醒悟！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 213,mapID = 116}},
				},
			}
		},
	},
[1285] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕大人，你被董卓魔毒所害，心智尽失，如今我已替你驱除魔毒，现下感觉可好？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1286}},
					},
			}
		},
	},
[1286] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20719,
		soundID = nil,
		txt = "多谢英雄相救！我这便告知董卓下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1225}},
				    {action = DialogActionType.Goto, param = {dialogID = 1301}},
			},
			}
		},
	},
[1301] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20801,
		soundID = nil,
		txt = "吕某也不知董卓身在何处，董卓有一女婿名为牛辅，如今便在西凉驻守，此人必定知道董卓下落，你可去寻他打探！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1301}},
					},
			}
		},
	},
[1302] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20804,
		soundID = nil,
		txt = "吾乃董太师女婿牛辅是也，谁敢在此撒野！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1303}},
					},
			}
		},
	},
[1303] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "牛辅，速速交待董卓那厮的下落，可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 220,mapID = 116}},
				},
			}
		},
	},
[1304] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓如今身在何处，还不快快道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1305}},
					},
			}
		},
	},
[1305] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20804,
		soundID = nil,
		txt = "董卓如今躲藏于某地修炼魔功，只有其军师李儒才知所在，但李儒也已躲了起来，不过李儒有一个心腹将领左灵如今正驻守在西凉深处，可寻此人打听李儒下落。",
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
[1306] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20809,
		soundID = nil,
		txt = "来者何人，竟敢擅闯我陈仓之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1307}},
					},
			}
		},
	},
[1307] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "左灵，李儒如今何在，还不速速道来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 221,mapID = 116}},
				},
			}
		},
	},
[1308] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说！李儒如今在何处。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1309}},
					},
			}
		},
	},
[1309] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20809,
		soundID = nil,
		txt = "李儒如今就躲藏在长安城中，暗中替董卓掌控朝廷局势。不过长安城如今有董卓手下大将梁冀率重兵驻守，诸位要找李儒，首先得对付那梁冀。",
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
[1310] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20812,
		soundID = nil,
		txt = "吾乃董太师麾下大将梁冀是也，有本将在此，岂容尔等在长安城放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1311}},
					},
			}
		},
	},
[1311] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "梁冀，李儒可是躲在这长安城的长乐宫中？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 222,mapID = 13}},
				},
			}
		},
	},
[1312] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "梁冀已死，我这便前往寻找李儒！",
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
[1313] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20813,
		soundID = nil,
		txt = "李儒在此，尔等逆贼自己送上门来，休怪我不客气了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1314}},
					},
			}
		},
	},
[1314] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "李儒，董卓老贼如今身在何处，快快道来，可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 223,mapID = 13}},
				},
			}
		},
	},
[1315] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓如今身在何处，老实道来，可饶你一命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1304}},
				    {action = DialogActionType.Goto, param = {dialogID = 1316}},
			},
			}
		},
	},
[1316] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20813,
		soundID = nil,
		txt = "董卓在天龙山深处修筑了一座魔龙宫，藏身其中修炼魔功。此魔龙有三处入口，分别位于天山、潼关、西凉，由董卓手下臧霸、郭汜、高顺三员大将镇守，但只有一个入口是真的。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1305}},
					},
			}
		},
	},
[1317] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20816,
		soundID = nil,
		txt = "站住，此地不是你等能来的地方，速速退去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1318}},
					},
			}
		},
	},
[1318] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "想让退去，那就得看你有没有这个实力了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 224,mapID = 115}},
				},
			}
		},
	},
[1319] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "臧霸已被诛杀！咦，前面有个传送阵，是不是不入口呢！前去调查下！",
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
[1320] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20817,
		soundID = nil,
		txt = "来者何人，此地乃是尔等能擅闯的么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1321}},
					},
			}
		},
	},
[1321] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说！这是不是魔龙宫的入口。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 225,mapID = 115}},
				},
			}
		},
	},
[1322] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "没想到这个传送阵是假的，再去潼关看一看是不是真的。",
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
[1323] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20818,
		soundID = nil,
		txt = "郭汜在此！你等闯我潼关兵家重地，意欲何为？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1324}},
					},
			}
		},
	},
[1324] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我特来找寻魔龙宫入口，你若让开，尚可饶你一命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 226,mapID = 110}},
				},
			}
		},
	},
[1325] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "郭汜已被诛杀！前方看到传送阵了，不知是否是真的，前去查探下。",
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
[1326] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20819,
		soundID = nil,
		txt = "没想到还会有人闯入这里，来了就别想走了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1327}},
					},
			}
		},
	},
[1327] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "就凭尔等还想取我项上人头，白日做梦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 227,mapID = 110}},
				},
			}
		},
	},
[1328] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "没想到这个传送阵也是假的，就剩最后西凉的入口，那肯定就是真的入口了，容我等前去查看。",
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
[1329] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20820,
		soundID = nil,
		txt = "高顺在此！我劝你还是速速退去，高某尚可网开一面，饶你擅闯西凉之罪。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1330}},
					},
			}
		},
	},
[1330] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "高顺，董卓已是恶贯满盈，死期将至，你尚不知悔悟！还不快快投降，带我前去诛杀董卓老贼。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 228,mapID = 116}},
				},
			}
		},
	},
[1331] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "还不快快道来，董卓藏身的魔龙宫入口是不是就在你身后！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1309}},
				    {action = DialogActionType.Gotos, param = {dialogIDs = {1332,1337,1342,1347,1352,1357}}},
					},
			}
		},
	},
[1334] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1310}},
				    {action = DialogActionType.Goto, param = {dialogID = 1335}},
			},
			}
		},
	},
[1335] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20004,
		soundID = nil,
		txt = "此事为师早有所料，你速去青峰山寻我阐教金仙前辈清虚道德真君相助，清虚前辈神通非凡，肯定有办法解决封印之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1311}},
					},
			}
		},
	},
[1336] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，我奉师命前来求援，还望祖师能助我解除魔将飞廉封印的魔龙宫入口，好诛灭董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1311}},
				    {action = DialogActionType.Goto, param = {dialogID = 1362}},
			},
			}
		},
	},
[1339] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1312}},
				    {action = DialogActionType.Goto, param = {dialogID = 1340}},
			},
			}
		},
	},
[1340] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20005,
		soundID = nil,
		txt = "此事为师早有所料，你速去青峰山寻我阐教金仙前辈清虚道德真君相助，清虚前辈神通非凡，肯定有办法解决封印之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1313}},
					},
			}
		},
	},
[1341] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，我奉师命前来求援，还望祖师能助我解除魔将飞廉封印的魔龙宫入口，好诛灭董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1313}},
				    {action = DialogActionType.Goto, param = {dialogID = 1362}},
			},
			}
		},
	},
[1344] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1314}},
				    {action = DialogActionType.Goto, param = {dialogID = 1345}},
			},
			}
		},
	},
[1345] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20006,
		soundID = nil,
		txt = "此事为师早有所料，你速去青峰山寻我阐教金仙前辈清虚道德真君相助，清虚前辈神通非凡，肯定有办法解决封印之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1315}},
					},
			}
		},
	},
[1346] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，我奉师命前来求援，还望祖师能助我解除魔将飞廉封印的魔龙宫入口，好诛灭董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1315}},
				    {action = DialogActionType.Goto, param = {dialogID = 1362}},
			},
			}
		},
	},
[1349] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1316}},
				    {action = DialogActionType.Goto, param = {dialogID = 1350}},
			},
			}
		},
	},
[1350] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20007,
		soundID = nil,
		txt = "此事为师早有所料，你速去青峰山寻我阐教金仙前辈清虚道德真君相助，清虚前辈神通非凡，肯定有办法解决封印之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1317}},
					},
			}
		},
	},
[1351] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，我奉师命前来求援，还望祖师能助我解除魔将飞廉封印的魔龙宫入口，好诛灭董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1317}},
				    {action = DialogActionType.Goto, param = {dialogID = 1362}},
			},
			}
		},
	},
[1354] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1318}},
				    {action = DialogActionType.Goto, param = {dialogID = 1355}},
			},
			}
		},
	},
[1355] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20008,
		soundID = nil,
		txt = "此事为师早有所料，你速去青峰山寻我阐教金仙前辈清虚道德真君相助，清虚前辈神通非凡，肯定有办法解决封印之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1319}},
					},
			}
		},
	},
[1356] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，我奉师命前来求援，还望祖师能助我解除魔将飞廉封印的魔龙宫入口，好诛灭董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1319}},
				    {action = DialogActionType.Goto, param = {dialogID = 1362}},
			},
			}
		},
	},
[1359] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师傅，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1320}},
				    {action = DialogActionType.Goto, param = {dialogID = 1360}},
			},
			}
		},
	},
[1360] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20009,
		soundID = nil,
		txt = "此事为师早有所料，你速去青峰山寻我阐教金仙前辈清虚道德真君相助，清虚前辈神通非凡，肯定有办法解决封印之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1321}},
					},
			}
		},
	},
[1361] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，我奉师命前来求援，还望祖师能助我解除魔将飞廉封印的魔龙宫入口，好诛灭董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1321}},
				    {action = DialogActionType.Goto, param = {dialogID = 1362}},
			},
			}
		},
	},
[1362] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20829,
		soundID = nil,
		txt = "要破解魔龙宫入口的封印，则需要四种材料炼制四道秘符。这四种材料分别在青峰山深处的龙血草、黑风山的血缨石髓、天山的翡翠碧沙、长安知天命的天河朱砂。你且前去找寻回来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
				    {action = DialogActionType.Goto, param = {dialogID = 1363}},
			},
			}
		},
	},
[1363] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "是，清虚祖师！弟子这就前去寻找。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1322}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1323}},
			},
			}
		},
	},
[1364] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20821,
		soundID = nil,
		txt = "你是何人！为何来此采集吾守护的灵草！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1365}},
					},
			}
		},
	},
[1365] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我是奉清虚祖师之命来此采集龙血草！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1366}},
					},
			}
		},
	},
[1366] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20821,
		soundID = nil,
		txt = "原来如此，你若能战胜我，灵草便给于你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 229,mapID = 127}},
				},
			}
		},
	},
[1367] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "龙血草终于拿到了，前去黑风山寻找血缨石髓吧！",
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
[1368] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20822,
		soundID = nil,
		txt = "来者何人！为何擅闯我等领地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1369}},
					},
			}
		},
	},
[1369] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你等妖物为祸作乱，人人得而诛之！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 230,mapID = 104}},
				},
			}
		},
	},
[1370] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "没想到，血缨石髓真的在这妖物身上，得来全不费工夫。前往天山寻找第三件材料雪融木。",
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
[1371] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "怎么雪融木不见了，去清虚祖师那里问下雪融木去哪了吧。",
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
[1372] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "清虚祖师，在去天山的时候发现雪融木不见了，您可知它现在何处？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1339}},
				    {action = DialogActionType.Goto, param = {dialogID = 1373}},
			},
			}
		},
	},
[1373] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20829,
		soundID = nil,
		txt = "事吾已知晓，此雪融木乃是经过千年修炼已然成精，现躲藏在潼关之中，雪融木刚成精生性贪玩，你前去将它赶回天山，吾只需它身上的一节雪融木就行，不必将其赶尽杀绝。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1326}},
					},
			}
		},
	},
[1374] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我是奉清虚祖师来将你送回天山，也希望你能给于一节雪融木就行！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1375}},
					},
			}
		},
	},
[1375] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20823,
		soundID = nil,
		txt = "想要雪融木么！你打赢我就给你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 232,mapID = 110}},
				},
			}
		},
	},
[1376] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20823,
		soundID = nil,
		txt = "雪融木给你了！我在去玩一会，等一下就回天山，你不要跟清虚祖师说啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1377}},
					},
			}
		},
	},
[1377] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "真是个调皮的孩子。现在雪融木也到手了，速前去找长安知天命询问最后一个材料天河朱砂吧！",
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
[1378] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉清虚祖师之令，前来找你询问天河朱砂下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1326}},
				    {action = DialogActionType.Goto, param = {dialogID = 1379}},
			},
			}
		},
	},
[1379] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "我已知晓此事，如今天河朱砂就在我身上，想要拿到天河朱砂就要通过我的考验。听闻在潼关处有强盗胡大力四处作乱，你前去将其铲除。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1327}},
					},
			}
		},
	},
[1380] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20824,
		soundID = nil,
		txt = "何人敢擅闯我山寨！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1381}},
					},
			}
		},
	},
[1381] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "尔等在此地四处作乱、祸害百姓，人人得而诛之！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 233,mapID = 110}},
				},
			}
		},
	},
[1382] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已将在潼关四处作乱的强盗胡大力诛杀！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1383}},
					},
			}
		},
	},
[1383] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "不错，你已经通过考验，天河朱砂就给你吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1327}},
				    {action = DialogActionType.Goto, param = {dialogID = 1384}},
			},
			}
		},
	},
[1384] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢！材料终于都收集了，回去找清虚祖师炼制秘符吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1328}},
					},
			}
		},
	},
[1385] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "祖师，我已经将四种材料全部收集了！已交于您手中，请您开始炼制秘符吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1328}},
				    {action = DialogActionType.Goto, param = {dialogID = 1386}},
			},
			}
		},
	},
[1386] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20829,
		soundID = nil,
		txt = "做的不错，材料已经收集，吾这便开始炼制秘符。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1329}},
					},
			}
		},
	},
[1387] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20829,
		soundID = nil,
		txt = "秘符已炼制完成，你且前去破除封印吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1329}},
				    {action = DialogActionType.Goto, param = {dialogID = 1388}},
			},
			}
		},
	},
[1388] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢祖师，我这便下界破除魔龙宫入口封印！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1330}},
					},
			}
		},
	},
[1389] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20825,
		soundID = nil,
		txt = "站住！此封印乃是禁地，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1390}},
					},
			}
		},
	},
[1390] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休得多言，受死吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 234,mapID = 116}},
				},
			}
		},
	},
[1391] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "第一处封印已破除，前去破除第二处封印。",
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
[1392] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20826,
		soundID = nil,
		txt = "站住，此封印有吾镇守，谁也不许擅入！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1393}},
					},
			}
		},
	},
[1393] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今日封印我必破除，谁也不能阻挡我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 235,mapID = 116}},
				},
			}
		},
	},
[1394] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "第二处封印也已破除，前去第三处封印。",
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
[1395] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20827,
		soundID = nil,
		txt = "何人擅闯封印之地，真是自寻死路！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1396}},
					},
			}
		},
	},
[1396] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "狂妄自大，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 236,mapID = 116}},
				},
			}
		},
	},
[1397] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "第三处封印也被破除，还剩下最后一道封印处，前去第四处封印入口处。",
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
[1398] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20828,
		soundID = nil,
		txt = "来者何人，此地乃是封印之地，岂是尔等能擅闯的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1399}},
					},
			}
		},
	},
[1399] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今日我闯定了！受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 237,mapID = 116}},
				},
			}
		},
	},
[1480] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "四处封印全数破除，之前听高顺说魔龙宫内有魔将飞廉在此镇守，恐怕我一个人难以打败他，董卓义子吕布正好武功非常高强，前去找他一起对付董卓。",
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
[1481] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕将军，我已找到董卓藏身的魔龙宫了，但听闻有魔将飞廉镇守，靠我一个人是打不过飞廉的，希望吕将军能和我一起铲除飞廉，诛杀董卓，匡扶天下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1482}},
				    {action = DialogActionType.FinishTask, param = {taskID = 1334}},
			},
			}
		},
	},
[1482] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20801,
		soundID = nil,
		txt = "自从我义父董卓使我魔化之后，我就与他恩断义绝，如今你已找到他的老巢，吕某愿与你一起前往诛杀董卓老贼。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1483}},
					},
			}
		},
	},
[1483] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就多谢吕将军了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1335}},
					},
			}
		},
	},
[1484] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20830,
		soundID = nil,
		txt = "有吾飞廉在此护法！谁敢惊扰董太师修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1485}},
					},
			}
		},
	},
[1485] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "飞廉！你和那董卓狼狈为奸，恶贯满盈，今日死期已至！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 238,mapID = 126}},
				},
			}
		},
	},
[1486] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20801,
		soundID = nil,
		txt = "此飞廉已被吾等诛杀，吾等速前往寻找董卓，救出皇帝陛下。",
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
[1487] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓！我总算找到你了！没想你竟敢逆天而行，吸收皇帝陛下的真龙之气修炼魔功，还不快快住手！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1488}},
					},
			}
		},
	},
[1488] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20831,
		soundID = nil,
		txt = "哈哈！皇帝小儿的真龙之气已被老夫吸尽，只要老夫炼化这些真龙之气，修成魔龙之体，你们都不是老夫的对手！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 239,mapID = 126}},
				},
			}
		},
	},
[1489] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20801,
		soundID = nil,
		txt = "董卓已被诛杀，可皇帝陛下昏迷不醒，你且先去找寻卢植大人禀报情况，我随后就将皇帝陛下送回皇宫。",
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
[1490] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢植大人，我与吕将军已将董卓诛杀，救回皇帝陛下。，但发现皇帝陛下一直昏迷不醒，这可如何是好。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1336}},
				    {action = DialogActionType.Goto, param = {dialogID = 1491}},
			},
			}
		},
	},
[1491] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "事情老夫已知晓，陛下因董卓吸尽身上的真龙之气，如今又神魂受损，昏迷不醒，非普通药石可治，不知如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1337}},
				    {action = DialogActionType.Goto, param = {dialogID = 1492}},
			},
			}
		},
	},
[1492] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人莫急，我这便返回上界，向我元始师祖求策，他老人家必有法救治陛下。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1337}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1338}},
			},
			}
		},
	},
[1493] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师祖，如今汉献帝被董卓吸尽真龙之气，神魂受损，昏迷不醒，还望祖师教我救治之法。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1338}},
				    {action = DialogActionType.Goto, param = {dialogID = 1401}},
			},
			}
		},
	},
[1401] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "昔日轩辕黄帝座下护法神龙应龙曾于人间留有一道真龙之气，只需寻得，注入汉献帝体内，便可使其复苏。你可下界打探其消息。",
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
[1402] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，我师祖说，当年轩辕黄帝座下护法神龙应龙曾留有一道真龙之气于人间，只需将这真龙之气注入陛下体内，便可助陛下苏醒，不知卢大人是否知道有关应龙，亦或轩辕黄帝的消息？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1403}},
					},
			}
		},
	},
[1403] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "我听闻司徒王允手中有一轩辕图，此图乃轩辕黄帝留于人间的宝物，或许会有线索，你前往长安找他打听。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1401}},
					},
			}
		},
	},
[1404] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "王大人，我听闻你手中有一幅轩辕图，此物事关当今陛下安危，不知可否借来一用？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1405}},
					},
			}
		},
	},
[1405] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20701,
		soundID = nil,
		txt = "此事事关重大，无奈轩辕图现在不在我手里，当年为了对付董贼，老夫曾用这图收买董贼手下的段炜，董贼战败后，此人应该逃至郿坞，你可前去寻他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1402}},
					},
			}
		},
	},
[1406] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "敢问阁下可是段炜？轩辕图可在你手里？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1407}},
					},
			}
		},
	},
[1407] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20901,
		soundID = nil,
		txt = "想要知道轩辕宝图的下落，就要看看你有没有这本事了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 301,mapID = 106}},
				},
			}
		},
	},
[1408] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20901,
		soundID = nil,
		txt = "当年十八路诸侯讨伐董卓时，我被徐州陶谦的手下打败，轩辕宝图也被夺走，如今轩辕宝图应该在陶谦手中，你可去徐州找他打听轩辕宝图的下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1403}},
					},
			}
		},
	},
[1409] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20905,
		soundID = nil,
		txt = "站住！徐州城戒严期间，外人不得擅入！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1410}},
					},
			}
		},
	},
[1410] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我有急事要见陶大人，既然尔等一再阻拦，在下先行得罪了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 302,mapID = 118}},
				},
			}
		},
	},
[1411] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "在下乃阐教弟子，此次前来找陶大人，乃关乎当今陛下安危之事，还望你能带我去见他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1412}},
					},
			}
		},
	},
[1412] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20905,
		soundID = nil,
		txt = "原来是仙门弟子，但如今曹操为父报仇，派夏侯惇攻打徐州，徐州如今已草木皆兵，倘若你能说服夏侯惇退兵，救我徐州百姓，我愿将你荐给主公。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1404}},
					},
			}
		},
	},
[1413] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "夏侯将军，请你停止攻打徐州！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1414}},
					},
			}
		},
	},
[1414] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20908,
		soundID = nil,
		txt = "你竟敢闯我军营，还想让我停止出兵，真是不知死活！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 303,mapID = 118}},
				},
			}
		},
	},
[1415] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20908,
		soundID = nil,
		txt = "阁下也非常人，但所谓君君臣臣，父父子子，如果你能说服我主公，并下令退兵，我马上退兵，否则休怪我无情了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1405}},
					},
			}
		},
	},
[1416] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20911,
		soundID = nil,
		txt = "何人敢闯曹营，不知这是当今丞相的军营吗！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1417}},
					},
			}
		},
	},
[1417] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我与曹将军乃旧时，你休要阻拦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 304,mapID = 118}},
				},
			}
		},
	},
[1418] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，徐州一城百姓何其无辜，还请你退兵为上。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1419}},
					},
			}
		},
	},
[1419] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "曹某本意不在徐州，但父仇未报，曹某不敢退兵。我念英雄乃我旧友，可去告知陶谦，若想要曹某退兵，除非交出凶手张闿，否则不死不休！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1425}},
					},
			}
		},
	},
[1420] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "陈大人，曹操已经答允于我，只要交出他的杀父仇人张闿，他即刻退兵！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1421}},
					},
			}
		},
	},
[1421] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20905,
		soundID = nil,
		txt = "那张闿杀了曹操之父，夺其财宝，如今他应该还在徐州郊野内，还望英雄擒拿张闿，救我徐州百姓！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1407}},
					},
			}
		},
	},
[1422] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20914,
		soundID = nil,
		txt = "站住！此处仍是张闿张大人的领地，留下你的买路钱，否则你就别想走了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1423}},
					},
			}
		},
	},
[1423] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "原来是张闿的手下，快告诉我张闿人在哪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 305,mapID = 118}},
				},
			}
		},
	},
[1424] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20914,
		soundID = nil,
		txt = "张闿早已不在徐州，他惧怕曹操报仇，已经逃去北海，英雄可前往北海寻找！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1408}},
					},
			}
		},
	},
[1425] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20917,
		soundID = nil,
		txt = "又一个黄巾残寇，我太史慈今天就要替天行道，诛杀恶贼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1426}},
					},
			}
		},
	},
[1426] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "阁下住手，我非黄巾残党！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 306,mapID = 119}},
				},
			}
		},
	},
[1427] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "阁下误会了，我乃阐教弟子，此次来北海，是想抓捕张闿，以解徐州之围。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1428}},
					},
			}
		},
	},
[1428] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20917,
		soundID = nil,
		txt = "原来是仙门弟子，是在下鲁莽了，在这里先赔罪了。阁下若想寻那张闿，可去北海军营管亥那看看，在北海能让张闿藏匿的地方，也就只有那里了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1409}},
					},
			}
		},
	},
[1429] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20920,
		soundID = nil,
		txt = "大胆！竟敢闯我军营，这便拿了你向管将军请功！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1430}},
					},
			}
		},
	},
[1430] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今天我要找到张闿，谁敢拦我，我便杀谁！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 307,mapID = 119}},
				},
			}
		},
	},
[1431] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20923,
		soundID = nil,
		txt = "张闿就在我营里，但今天你也没命找他了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1432}},
					},
			}
		},
	},
[1432] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就今天我就先杀你，再杀张闿！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 308,mapID = 119}},
				},
			}
		},
	},
[1433] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张闿那厮应该在这里，我必须把他找出来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1410}},
					},
			}
		},
	},
[1434] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20925,
		soundID = nil,
		txt = "你竟然对我穷追不舍，那今天我们就拼个鱼死网破好了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1435}},
					},
			}
		},
	},
[1435] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张闿，当日你谋财害命，今天便是你偿还之时！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 309,mapID = 119}},
				},
			}
		},
	},
[1436] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，我已将张闿诛杀，还请将军信守承诺，从徐州退兵！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1437}},
					},
			}
		},
	},
[1437] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20313,
		soundID = nil,
		txt = "竟然张闿已死，我大仇已报，英雄可转告陶谦，曹某这便下令退兵。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1411}},
					},
			}
		},
	},
[1438] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20905,
		soundID = nil,
		txt = "少侠大恩大德，救我徐州百姓，此恩没齿难忘，这位是我主公徐州牧陶大人，你若有事相求，便可以现在说了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1439}},
				    {action = DialogActionType.FinishTask, param = {taskID = 1412}},
			},
			}
		},
	},
[1439] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "陈大人，陶大人，当今陛下昏迷不醒，急需轩辕图一用，还望陶大人将此图下落告知于我。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1440}},
					},
			}
		},
	},
[1440] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20904,
		soundID = nil,
		txt = "实不相瞒，那轩辕图如今便在陶某手中，少侠对我有大恩，此图便赠与你了，我期待少侠再创奇迹，救回陛下。",
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
[1441] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，轩辕图我已经取来，不知你是否知道如何寻得真龙之气？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1442}},
					},
			}
		},
	},
[1442] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "据记载，要使用轩辕图，需将此炼化后方可使用，可惜我并不知晓其炼化方法，但东郡有一高人，其名左慈，你可以尝试找他寻求炼化方法。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1413}},
					},
			}
		},
	},
[1443] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "这位前辈，不知你是否知道一位叫左慈的高人？听闻他居住在此地。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1444}},
					},
			}
		},
	},
[1444] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20928,
		soundID = nil,
		txt = "还想找人？我的财宝都被一伙强盗劫走了！如果你能帮我把宝物找回来，我也许能告诉你左慈现在在什么地方。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1414}},
					},
			}
		},
	},
[1445] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20930,
		soundID = nil,
		txt = "站住，此地是我的地盘，任何人等，想要完整的离开，就乖乖的留下买路钱！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1446}},
					},
			}
		},
	},
[1446] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来就是你抢走老人家的东西了，快快把你抢的东西交出来，否则休怪我无情了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 310,mapID = 107}},
				},
			}
		},
	},
[1447] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "老人家，你的宝物我帮你找回来了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1448}},
				    {action = DialogActionType.FinishTask, param = {taskID = 1426}},
			},
			}
		},
	},
[1448] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20929,
		soundID = nil,
		txt = "不错，轩辕宝图乃轩辕黄帝留下的宝物，里面有着真龙之气的线索，倘若让心存歹念之人得到真龙之气，后果不堪设想。吾名左慈，我这次特意乔装打扮来考验你，就是想看看你是否有资格使用这轩辕宝图。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1449}},
					},
			}
		},
	},
[1449] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20929,
		soundID = nil,
		txt = "要炼化这轩辕宝图，本座还差两种材料，其一为青玄之气，另一为紫阳之火，你可以前去洛阳，找百事通，他知道这两物可在何处寻找。",
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
[1450] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "百事通前辈，我现在急需两种材料，一名青玄之气，二为紫阳之火，请你把这两种材料的消息告知于我。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1451}},
					},
			}
		},
	},
[1451] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20933,
		soundID = nil,
		txt = "找我你是问对人了，青玄之气如今就在洛阳管闲事手中，而另一材料紫阳之火则在东郡藏身的嗜血魔将手中，你可以试试找他们索要。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1416}},
					},
			}
		},
	},
[1452] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人，我听闻你手中有一青玄之气，事关当今陛下安危，能否把它赠与我？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1453}},
					},
			}
		},
	},
[1453] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29006,
		soundID = nil,
		txt = "原来如此，但可惜如今青玄之气不在我手里，几天前我路过郿坞时，青玄之气被一妖道所抢，如今他应该还在郿坞处，如果你找到并把青玄之气抢回来，便赠与给你了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1417}},
					},
			}
		},
	},
[1454] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "妖道！前几天你可曾抢过一青玄之气？识相的就吗马上把他拿回来，否则休怪我无情了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1455}},
					},
			}
		},
	},
[1455] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20934,
		soundID = nil,
		txt = "原来是想抢回青玄之气，这东西的确在我手里，就要看你有没有命拿回去了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 311,mapID = 106}},
				},
			}
		},
	},
[1456] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "青玄之气已得，还需去东郡寻那紫阳之火。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1418}},
					},
			}
		},
	},
[1457] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20937,
		soundID = nil,
		txt = "下一个死在我紫阳之火手上的，就是你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1458}},
					},
			}
		},
	},
[1458] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "暴虐无道，残害百姓，当诛！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 312,mapID = 107}},
				},
			}
		},
	},
[1459] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "两种材料我都得到，是时候回去交给左慈了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1419}},
					},
			}
		},
	},
[1460] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "左道长，青玄之气与紫阳之火我都已得到，还请你能马上炼化轩辕图，寻得真龙之气！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1461}},
					},
			}
		},
	},
[1461] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20929,
		soundID = nil,
		txt = "你且稍后，贫道即刻炼化此图。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1462}},
					},
			}
		},
	},
[1462] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20929,
		soundID = nil,
		txt = "轩辕图已炼化，依老夫所知，此图所示真龙之气的地方位于北海，你即刻前去北海打探真龙之气的消息。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1420}},
					},
			}
		},
	},
[1463] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20940,
		soundID = nil,
		txt = "在北海，没人不识我司徒南的，识相的就把身上的财物都交出来，我这大刀可是不长眼睛的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1464}},
					},
			}
		},
	},
[1464] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "大丈夫生于乱世，不但胸无大志，反倒为害一方，其罪当诛！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 313,mapID = 119}},
				},
			}
		},
	},
[1465] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "念你还有悔过之心，这次就放过你。我问你，你在北海这里有没有看见一些异象？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1466}},
					},
			}
		},
	},
[1466] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20940,
		soundID = nil,
		txt = "谢英雄不杀之恩。说起异象，小人记得在北海东方曾有异光闪烁，英雄可以前去查看。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1421}},
					},
			}
		},
	},
[1467] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "是幻化成人的真龙之气，如今陛下昏迷不醒，还需借你的真龙之气一用。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1468}},
					},
			}
		},
	},
[1468] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20943,
		soundID = nil,
		txt = "要用我的真龙之气，与杀了我何异？我修炼多年，好不容易才能幻化成人，岂能让你得逞，今日我定要杀你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 314,mapID = 119}},
				},
			}
		},
	},
[1469] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "左道长，真龙之气已得还请你前往洛阳，拯救陛下！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1470}},
					},
			}
		},
	},
[1470] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20929,
		soundID = nil,
		txt = "贫道先收下真龙之气，你先前去洛阳陛下那，贫道稍作准备，随后就到。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1423}},
					},
			}
		},
	},
[1471] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20929,
		soundID = nil,
		txt = "陛下如今已醒，贫道这便去也，望英雄好自为之，再匡天道！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1427}},
				    {action = DialogActionType.Goto, param = {dialogID = 1501}},
			},
			}
		},
	},
[1472] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20911,
		soundID = nil,
		txt = "我看英雄也非歹人，我家主公就在前方，英雄可自去见他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1406}},
					},
			}
		},
	},
[1473] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张闿已死，要回去请曹操退兵了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1411}},
					},
			}
		},
	},
[1474] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "真龙之气已得，现在要请左道长把真龙之气注入皇帝体内了。",
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
[1501] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21000,
		soundID = nil,
		txt = "多谢英雄相救。如今董卓虽死，但汉家天下已是四分五裂，倾覆在即，朕欲复兴汉室，奈何有心无力，望英雄赐教。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1501}},
				    {action = DialogActionType.Goto, param = {dialogID = 1502}},
			},
			}
		},
	},
[1502] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "陛下勿虑，我这便返归上界，向我元始祖师求教复兴汉室之策。",
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
[1503] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师祖，吾受汉室皇帝之托，特前来求教复兴汉室之策。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1501}},
				    {action = DialogActionType.Goto, param = {dialogID = 1504}},
			},
			}
		},
	},
[1504] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "董卓倒行逆施，使汉室气运衰败。人间有一传国玉玺至宝，可续帝皇气运，你可设法寻得，以续汉家气运，保汉室天下无虞。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1502}},
				    {action = DialogActionType.Goto, param = {dialogID = 1505}},
			},
			}
		},
	},
[1505] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "弟子这便下界寻卢植大人打探。",
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
[1506] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，吾受师祖指点，要寻至宝传国玉玺以续汉室气运，不知大人可知此宝下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1502}},
				    {action = DialogActionType.Goto, param = {dialogID = 1507}},
			},
			}
		},
	},
[1507] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "传国玉玺原为朝廷所有，奈何董卓之乱中，看守此宝的御林将军冯芳竟私窃此宝潜逃，其昔日手下赵融如今尚在洛阳，英雄可前去寻此人打探冯芳下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1503}},
					},
			}
		},
	},
[1508] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "赵融，冯芳私窃传国玉玺潜逃，你是不是同谋，还不快快老实交待冯芳的下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1509}},
					},
			}
		},
	},
[1509] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21001,
		soundID = nil,
		txt = "哼！你是何人！能打败我便告诉你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 401,mapID = 10}},
				},
			}
		},
	},
[1510] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "冯芳如今身在何处，还不快快道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1511}},
					},
			}
		},
	},
[1511] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21032,
		soundID = nil,
		txt = "吾听闻那冯芳因惧汉室追究其丢失玉玺之过，现已经逃往黑风山，英雄可前往黑风山寻他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1503}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1504}},
			},
			}
		},
	},
[1512] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "冯芳，传国玉玺是不是在你手中，还不快交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1513}},
					},
			}
		},
	},
[1513] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21002,
		soundID = nil,
		txt = "就凭你这黄毛小子也要过问玉玺下落，先过我这关！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 402,mapID = 104}},
				},
			}
		},
	},
[1514] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "冯芳，还不快快交待玉玺下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1515}},
					},
			}
		},
	},
[1515] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21002,
		soundID = nil,
		txt = "英雄明鉴，那玉玺如今确实不在我身上。当日十八路诸侯战乱，吾虽拼死看守玉玺，奈何玉玺仍被那李傕所夺。那李傕如今却是下落不明。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1504}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1505}},
			},
			}
		},
	},
[1516] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，据冯芳交待，那玉玺如今已被那李傕所夺，那李傕如今下落不明。晚辈无策，求大人指点！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1517}},
					},
			}
		},
	},
[1517] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "此事着实非同小可，吾听闻长安城有一名神算子名为管辂，精通于运筹帷幄。其也许能算出玉玺下落，你可速去找其打听。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1505}},
					},
			}
		},
	},
[1518] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人，素闻大名，如今汉室危难，尚缺一传国玉玺镇压国运。那传国玉玺如今被李傕所夺下落不明。还望大人能够替吾算得那李傕的下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1519}},
					},
			}
		},
	},
[1519] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "老道的确有心要相助于你。奈何前几日，吾在替一潼关妖王后卿占卜时，不慎语失将其得罪。如今其放言要血洗长安城，唯有借英雄之力将其铲除以救长安黎民百姓一命。事成之后，老道定当全力相助于你。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1520}},
					},
			}
		},
	},
[1520] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾这便去除了后卿这厮。",
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
[1521] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21004,
		soundID = nil,
		txt = "是谁胆敢闯进我潼关撒野！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1522}},
					},
			}
		},
	},
[1522] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "后卿，你身为堂堂上古魔君，居然在这里为非作歹，我今天就要为民除害。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 403,mapID = 110}},
				},
			}
		},
	},
[1523] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人，吾已将那后卿诛杀，还望大人信守承诺助我一臂之力！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1508}},
				    {action = DialogActionType.Goto, param = {dialogID = 1524}},
			},
			}
		},
	},
[1524] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "英雄有所不知，当日吾在替那妖王占卜时，占卜用的罗盘被那愤怒的妖王打碎。如今要复原那罗盘，只有取得天山的“龙鳞”和西凉的“玄铁晶石”，方能修复罗盘。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1525}},
					},
			}
		},
	},
[1525] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人莫慌，吾这便前往天山和西凉，为你取得那修复罗盘的素材。",
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
[1526] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21005,
		soundID = nil,
		txt = "站住！你擅自闯入天山，是来送命的吗！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1527}},
					},
			}
		},
	},
[1527] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "留下龙鳞，方可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 404,mapID = 115}},
				},
			}
		},
	},
[1528] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "龙鳞已经取得，接下来该去西凉寻那“玄铁晶石”了。",
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
[1529] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21006,
		soundID = nil,
		txt = "你是何人！西凉军事把守重地，岂是尔等随便来的地方！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1530}},
					},
			}
		},
	},
[1530] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快快让开，否则你命休矣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 405,mapID = 116}},
				},
			}
		},
	},
[1531] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "玄铁晶石已经取得，该去找管大人复命了！",
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
[1532] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人，吾已经修复罗盘需要的素材搜集完毕，请修复罗盘吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1533}},
					},
			}
		},
	},
[1534] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "根据卦象，那李傕如今应该位于虎牢关方向，你可前去查探！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1511}},
				    {action = DialogActionType.Goto, param = {dialogID = 1535}},
			},
			}
		},
	},
[1535] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾这便深入虎牢关寻那李傕。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1512}},
					},
			}
		},
	},
[1536] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "没想那李傕也遭人暗算，玉玺也不知所踪。如今之计还得回长安找管大人求助。",
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
[1537] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人，吾深入虎牢关，发现那李傕遭人暗算身亡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1538}},
					},
			}
		},
	},
[1538] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "此事毋慌，只要你为我寻得郿坞的“通灵水晶”和潼关的“回魂草”，吾可为你施得回魂大法，召唤李傕的亡魂。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1539}},
					},
			}
		},
	},
[1539] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾这便去收集素材！",
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
[1540] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21007,
		soundID = nil,
		txt = "站住！你擅闯我郿坞大营，意欲何为！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1541}},
					},
			}
		},
	},
[1541] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快让开，否则休怪我不客气！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 406,mapID = 106}},
				},
			}
		},
	},
[1542] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "“通灵水晶”已经得到，接下来该去潼关采集“回魂草”了！",
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
[1543] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21008,
		soundID = nil,
		txt = "站住！潼关大营岂是你随便进来的地方，今天你可别想活着回去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1544}},
					},
			}
		},
	},
[1544] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就来见见真本事吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 407,mapID = 110}},
				},
			}
		},
	},
[1545] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "素材已经收集完毕，该回去长安找管大人复命了！",
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
[1546] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "管大人，吾已集齐施展回魂大法的素材，请管大人施法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1547}},
					},
			}
		},
	},
[1548] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21010,
		soundID = nil,
		txt = "是谁在召唤我打扰我清修！我可不会轻易放过他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1549}},
					},
			}
		},
	},
[1549] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "李傕，你生前抢得那玉玺，还不快快交待下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 408,mapID = 13}},
				},
			}
		},
	},
[1550] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21033,
		soundID = nil,
		txt = "吾当日于虎牢关，不幸被那孙坚暗杀，玉玺也被其所夺。那孙坚如今伐董完毕引兵南下，如今正经过江夏。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1517}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1518}},
			},
			}
		},
	},
[1551] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21011,
		soundID = nil,
		txt = "谁家的黄毛小子，敢来干扰我黄祖的好事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1552}},
					},
			}
		},
	},
[1552] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "还不快快放了孙坚将军！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 409,mapID = 120}},
				},
			}
		},
	},
[1553] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21034,
		soundID = nil,
		txt = "多谢英雄相救，吾知你此番前来寻我之意。吾手下有两名将领韩当、祖茂，如今正被黄祖同党所围困，吾视其为手足，不忍弃之不顾，还望英雄前往解救！事成吾自当将玉玺下落告知于你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1518}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1519}},
			},
			}
		},
	},
[1554] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21012,
		soundID = nil,
		txt = "张硕在此！安敢放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1555}},
					},
			}
		},
	},
[1555] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张硕，还不快快放了韩当将军！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 410,mapID = 120}},
				},
			}
		},
	},
[1556] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21013,
		soundID = nil,
		txt = "多谢英雄拔刀相助，吾另有一手足祖茂如今正被围困于江夏以北，还望英雄前往解救！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1519}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1520}},
			},
			}
		},
	},
[1557] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21014,
		soundID = nil,
		txt = "小子！看你面相生疏，非黄祖大人之手下！还不快快投降方可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1558}},
					},
			}
		},
	},
[1558] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，还不快快放了祖茂将军！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 411,mapID = 120}},
				},
			}
		},
	},
[1559] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21015,
		soundID = nil,
		txt = "多谢英雄相救！孙坚将军就在前方，汝可寻其领赏！",
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
[1560] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙将军，吾已成功解救汝两名手下，还望能告知玉玺下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1520}},
				    {action = DialogActionType.Goto, param = {dialogID = 1561}},
			},
			}
		},
	},
[1561] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21035,
		soundID = nil,
		txt = "实不相瞒，当日吾引兵经过江夏，不慎被黄祖埋伏！在混乱中，玉玺已被一伙神秘人所夺。据手下线索，那伙神秘人已往襄阳方向逃去。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1521}},
					},
			}
		},
	},
[1562] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21016,
		soundID = nil,
		txt = "汝乃何人！如今襄阳戒备森严，汝安敢擅闯！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1563}},
					},
			}
		},
	},
[1563] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾此次进入襄阳，乃是要追查玉玺的下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 412,mapID = 14}},
				},
			}
		},
	},
[1564] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "还不快快交待玉玺下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1565}},
					},
			}
		},
	},
[1565] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21036,
		soundID = nil,
		txt = "那玉玺乃是被锦帆贼甘宁所夺，其如今藏在襄阳深处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1521}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1522}},
			},
			}
		},
	},
[1566] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "甘宁，你擅夺玉玺，实乃大逆不道，还不快快交出玉玺方可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1567}},
					},
			}
		},
	},
[1567] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21017,
		soundID = nil,
		txt = "那得看你能不能过我这一关了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 413,mapID = 14}},
				},
			}
		},
	},
[1568] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21037,
		soundID = nil,
		txt = "当日吾夺那玉玺，实乃是受到蔡瑁重金收买为其卖命！如今那玉玺已经献于其手中，英雄可前往寻其要那玉玺！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1522}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1523}},
			},
			}
		},
	},
[1569] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21018,
		soundID = nil,
		txt = "吾奉蔡瑁将军之命看守襄阳，看你鬼鬼祟祟在襄阳城乱逛，还不快快交待来由！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1570}},
					},
			}
		},
	},
[1570] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾此番进入襄阳就是要找蔡瑁，还不快快交待他的位置！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 414,mapID = 14}},
				},
			}
		},
	},
[1571] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说！蔡瑁现在身处何地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1572}},
					},
			}
		},
	},
[1572] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21038,
		soundID = nil,
		txt = "蔡瑁如今藏于襄阳北方，英雄可自行前往寻他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1523}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1524}},
			},
			}
		},
	},
[1573] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "蔡瑁！你私藏玉玺，真是大逆不道，还不快快交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1574}},
					},
			}
		},
	},
[1574] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21019,
		soundID = nil,
		txt = "玉玺岂是尔等黄毛小子能染指的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 415,mapID = 14}},
				},
			}
		},
	},
[1575] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21039,
		soundID = nil,
		txt = "吾如今投奔于袁术，为讨其好感，为其夺得玉玺。那玉玺如今已被送往袁术手中，英雄可前往寻其算账！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1524}},
					},
			}
		},
	},
[1576] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 29030,
		soundID = nil,
		txt = "英雄，如今已为你召唤到李傕亡灵，其如今位于长安城阴气最重的城门处下方。这亡灵不喜被外人所扰，你可切记小心啊！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1577}},
					},
			}
		},
	},
[1577] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢管大人，吾这便前往会会那厮！",
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
}


table.copy(NormalDialogModelDB,DialogModelDB)
