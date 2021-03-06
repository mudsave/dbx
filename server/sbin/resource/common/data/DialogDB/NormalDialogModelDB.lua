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
		txt = "这里便是玄都玉京天了么，原来仙境是如此美丽！先不急着观赏美景，刚刚救我的童子叫我前去找他，我先去找他询问情况再说！",
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
[101] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "多谢童子的救命之恩！如今你将我带到这里，究竟是何原因？",
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
		speakerID = 20001,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠莫慌！刚才吾是奉师尊元始天尊之命下界救你，具体原因吾不是很清楚！师尊如今正在前方等你，你且前去拜访，师尊会将具体事宜告知与你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1001}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1002}},
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
		speakerID = 0,
		soundID = nil,
		txt = "在下<font color = '#FFFFFF00'><myName></font>拜见元始天尊！不知天尊将我带到此处，所为何事？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 104}},
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
		txt = "本尊如今将你带到这里，是因为现时下界正是东汉末年，人间动荡，妖魔作乱。少年人，你上应天命，乃是拯救天下苍生的天命之子。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1002}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1003}},
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
		txt = "天尊，如今我什么都不会，不知我该如何拯救天下苍生！",
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
		txt = "无妨，本座这便传你一招基础道法，以应付妖魔邪道。正好与本座座下的玉清神将切磋下，在战斗中能更快的熟悉道法的应用，若是你在切磋中战胜了玉清神将，便算是掌握此招精髓了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		txt = "祖师，我已成功击败玉清神将！不知祖师还有何吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 108}},
				    {action = DialogActionType.Gotos, param = {dialogIDs = {452,453,454,455,456,457}}},
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
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 111}},
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
		speakerID = 0,
		soundID = nil,
		txt = "可是童子，此百宝袋我该如何使用？又该如何穿戴百宝袋里面的仙衣？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，吾这便教你如何使用百宝袋和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1004}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1006}},
		{action = DialogActionType.UITip, param = {v = 15,p = 1}},
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
		txt = "多谢童子指教，我已知晓百宝袋的使用方法和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.Goto, param = {dialogID = 115}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "此事已了，吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1006}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1007}},
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
					{action = DialogActionType.Goto, param = {dialogID = 117}},
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
		speakerID = 20004,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法提升至十级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1007}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1008}},
		{action = DialogActionType.UITip, param = {v = 9,p = 1}},
				},
			}
		},
	},
[118] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请师父吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 119}},
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
		speakerID = 20004,
		soundID = nil,
		txt = "如今你已是本派的入门弟子，门派心法还需勤加修炼，此外为师还有一件宝物相赠，你且去寻为师座下大弟子打探此物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1008}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1009}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师父让我前来询问宝物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 121}},
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
		speakerID = 20021,
		soundID = nil,
		txt = "恭候师弟多时，本派入门弟子都将携带宠物一枚，此宠可以在今后的历练中成为你的助力，<font color = '#FFFFFF00'><myName></font>你且去前山寻找你的宠物吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1009}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1010}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，宠物已经捕捉到了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 123}},
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
		speakerID = 20021,
		soundID = nil,
		txt = "如此甚好，你且将它带在身边，和你并肩作战。听闻师父有要事相商，<font color = '#FFFFFF00'><myName></font>你便去师父处询问罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1010}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1011}},
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
		speakerID = 0,
		soundID = nil,
		txt = "师父有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 125}},
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
		speakerID = 20004,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。如今黄巾军正在桃园镇处作乱，<font color = '#FFFFFF00'><myName></font>你且前去桃园镇帮助其镇长刘元起诛杀在桃园镇附近作乱的黄巾军！你可寻找门派传送人送你去桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 126}},
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
		speakerID = 0,
		soundID = nil,
		txt = "好的师父，我这便启程前往桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1011}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1012}},
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
		txt = "我乃乾元岛弟子<font color = '#FFFFFF00'><myName></font>，特奉为师太极仙翁之命前来，协助你铲除在桃园镇附近的黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 128}},
					},
			}
		},
	},
[128] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20027,
		soundID = nil,
		txt = "多谢英雄前来协助，如今我侄儿刘备正在桃园镇内准备前去讨伐黄巾军，你可去寻他一起前往讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1012}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1013}},
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
		txt = "我乃乾元岛弟子<font color = '#FFFFFF00'><myName></font>，特奉师命前来，协助你讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某如今因势单力薄，想要寻找几位武艺高强人士一起讨伐黄巾军。最近听闻在桃园镇内，有一名好汉名叫张飞，你且前去帮我询问那位好汉能否与刘某一起讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1013}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1064}},
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
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 133}},
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
		txt = "童子，此百宝袋该如何使用？又该如何穿戴百宝袋里面的仙衣？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20003,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，吾这便教你如何使用百宝袋和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1014}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1016}},
		{action = DialogActionType.UITip, param = {v = 15,p = 1}},
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
		txt = "多谢童子指教，我已知晓百宝袋的使用方法和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 136}},
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
					{action = DialogActionType.Goto, param = {dialogID = 137}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "此事已了，吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1016}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1017}},
			},
			}
		},
	},
[138] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 139}},
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
		speakerID = 20005,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法和副心法各提升一级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1017}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1018}},
		{action = DialogActionType.UITip, param = {v = 9,p = 1}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请师父吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 141}},
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
		speakerID = 20005,
		soundID = nil,
		txt = "如今你已是本派的入门弟子，门派心法还需勤加修炼，此外为师还有一件宝物相赠，你且去寻为师座下大弟子打探此物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1018}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1019}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师父让我前来询问宝物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 143}},
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
		speakerID = 20025,
		soundID = nil,
		txt = "恭候师弟多时，本派入门弟子都将携带宠物一枚，此宠可以在今后的历练中成为你的助力，<font color = '#FFFFFF00'><myName></font>你且去前山寻找你的宠物吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1019}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1020}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，宠物已经捕捉到了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 145}},
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
		speakerID = 20025,
		soundID = nil,
		txt = "如此甚好，你且将它带在身边，和你并肩作战。听闻师父有要事相商，<font color = '#FFFFFF00'><myName></font>你便去师父处询问罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1020}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1021}},
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
		speakerID = 0,
		soundID = nil,
		txt = "师父有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 147}},
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
		speakerID = 20005,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。如今黄巾军正在桃园镇处作乱，<font color = '#FFFFFF00'><myName></font>你且前去桃园镇帮助其镇长刘元起诛杀在桃园镇附近作乱的黄巾军！你可寻找门派传送人送你去桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 148}},
					},
			}
		},
	},
[148] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "好的师父，我这便启程前往桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1021}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1022}},
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
		txt = "我乃桃源洞弟子<font color = '#FFFFFF00'><myName></font>，特奉为师龙虎天师之命前来，协助你铲除在桃园镇附近的黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20027,
		soundID = nil,
		txt = "多谢英雄前来协助，如今我侄儿刘备正在桃园镇内准备前去讨伐黄巾军，你可去寻他一起前往讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1022}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1023}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我乃桃源洞弟子<font color = '#FFFFFF00'><myName></font>，特奉师命前来，协助你讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某如今因势单力薄，想要寻找几位武艺高强人士一起讨伐黄巾军。最近听闻在桃园镇内，有一名好汉名叫张飞，你且前去帮我询问那位好汉能否与刘某一起讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1023}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1064}},
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
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 155}},
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
		txt = "童子，此百宝袋该如何使用？又该如何穿戴百宝袋里面的仙衣？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 156}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，吾这便教你如何使用百宝袋和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1024}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1026}},
		{action = DialogActionType.UITip, param = {v = 15,p = 1}},
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
		txt = "多谢童子指教，我已知晓百宝袋的使用方法和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 158}},
					},
			}
		},
	},
[158] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 159}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "此事已了，吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1026}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1027}},
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
					{action = DialogActionType.Goto, param = {dialogID = 161}},
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
		speakerID = 20006,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法和副心法各提升一级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1027}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1028}},
		{action = DialogActionType.UITip, param = {v = 9,p = 1}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请师父吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 163}},
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
		speakerID = 20006,
		soundID = nil,
		txt = "如今你已是本派的入门弟子，门派心法还需勤加修炼，此外为师还有一件宝物相赠，你且去寻为师座下大弟子打探此物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1028}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1029}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师父让我前来询问宝物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 165}},
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
		speakerID = 20023,
		soundID = nil,
		txt = "恭候师弟多时，本派入门弟子都将携带宠物一枚，此宠可以在今后的历练中成为你的助力，<font color = '#FFFFFF00'><myName></font>你且去前山寻找你的宠物吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1029}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1030}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，宠物已经捕捉到了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 167}},
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
		speakerID = 20023,
		soundID = nil,
		txt = "如此甚好，你且将它带在身边，和你并肩作战。听闻师父有要事相商，<font color = '#FFFFFF00'><myName></font>你便去师父处询问罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1030}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1031}},
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
		speakerID = 0,
		soundID = nil,
		txt = "师父有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 169}},
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
		speakerID = 20006,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。如今黄巾军正在桃园镇处作乱，<font color = '#FFFFFF00'><myName></font>你且前去桃园镇帮助其镇长刘元起诛杀在桃园镇附近作乱的黄巾军！你可寻找门派传送人送你去桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 0,
		soundID = nil,
		txt = "好的师父，我这便启程前往桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1031}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1032}},
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
		txt = "我乃金霞山弟子<font color = '#FFFFFF00'><myName></font>，特奉为师妙道真君之命前来，协助你铲除在桃园镇附近的黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20027,
		soundID = nil,
		txt = "多谢英雄前来协助，如今我侄儿刘备正在桃园镇内准备前去讨伐黄巾军，你可去寻他一起前往讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1032}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1033}},
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
		txt = "我乃金霞山弟子<font color = '#FFFFFF00'><myName></font>，特奉师命前来，协助你讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 174}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某如今因势单力薄，想要寻找几位武艺高强人士一起讨伐黄巾军。最近听闻在桃园镇内，有一名好汉名叫张飞，你且前去帮我询问那位好汉能否与刘某一起讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1033}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1064}},
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
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 177}},
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
		txt = "童子，此百宝袋该如何使用？又该如何穿戴百宝袋里面的仙衣？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20003,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，吾这便教你如何使用百宝袋和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1034}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1036}},
		{action = DialogActionType.UITip, param = {v = 15,p = 1}},
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
		txt = "多谢童子指教，我已知晓百宝袋的使用方法和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 180}},
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
					{action = DialogActionType.Goto, param = {dialogID = 181}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "此事已了，吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1036}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1037}},
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
					{action = DialogActionType.Goto, param = {dialogID = 183}},
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
		speakerID = 20007,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法和副心法各提升一级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1037}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1038}},
		{action = DialogActionType.UITip, param = {v = 9,p = 1}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请师父吩咐。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 185}},
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
		speakerID = 20007,
		soundID = nil,
		txt = "如今你已是本派的入门弟子，门派心法还需勤加修炼，此外为师还有一件宝物相赠，你且去寻为师座下大弟子打探此物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1038}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1039}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师父让我前来询问宝物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 187}},
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
		speakerID = 20022,
		soundID = nil,
		txt = "恭候师弟多时，本派入门弟子都将携带宠物一枚，此宠可以在今后的历练中成为你的助力，<font color = '#FFFFFF00'><myName></font>你且去前山寻找你的宠物吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1039}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1040}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，宠物已经捕捉到了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 189}},
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
		speakerID = 20022,
		soundID = nil,
		txt = "如此甚好，你且将它带在身边，和你并肩作战。听闻师父有要事相商，<font color = '#FFFFFF00'><myName></font>你便去师父处询问罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1040}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1041}},
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
		speakerID = 0,
		soundID = nil,
		txt = "师父有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 191}},
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
		speakerID = 20007,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。如今黄巾军正在桃园镇处作乱，<font color = '#FFFFFF00'><myName></font>你且前去桃园镇帮助其镇长刘元起诛杀在桃园镇附近作乱的黄巾军！你可寻找门派传送人送你去桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 192}},
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
		speakerID = 0,
		soundID = nil,
		txt = "好的师父，我这便启程前往桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1041}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1042}},
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
		txt = "我乃蓬莱阁弟子<font color = '#FFFFFF00'><myName></font>，特奉为师南海龙女之命前来，协助你铲除在桃园镇附近的黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20027,
		soundID = nil,
		txt = "多谢英雄前来协助，如今我侄儿刘备正在桃园镇内准备前去讨伐黄巾军，你可去寻他一起前往讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1042}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1043}},
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
		txt = "我乃蓬莱阁弟子<font color = '#FFFFFF00'><myName></font>，特奉师命前来，协助你讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某如今因势单力薄，想要寻找几位武艺高强人士一起讨伐黄巾军。最近听闻在桃园镇内，有一名好汉名叫张飞，你且前去帮我询问那位好汉能否与刘某一起讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1043}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1064}},
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
		txt = "我奉元始祖师吩咐，特来寻你下凡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 198}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 199}},
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
		txt = "童子，此百宝袋该如何使用？又该如何穿戴百宝袋里面的仙衣？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20003,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，吾这便教你如何使用百宝袋和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1044}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1046}},
		{action = DialogActionType.UITip, param = {v = 15,p = 1}},
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
		txt = "多谢童子指教，我已知晓百宝袋的使用方法和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.Goto, param = {dialogID = 203}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "此事已了，吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1046}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1047}},
			},
			}
		},
	},
[204] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 205}},
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
		speakerID = 20008,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法和副心法各提升一级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1047}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1048}},
		{action = DialogActionType.UITip, param = {v = 9,p = 1}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请师父吩咐。",
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
		speakerID = 20008,
		soundID = nil,
		txt = "如今你已是本派的入门弟子，门派心法还需勤加修炼，此外为师还有一件宝物相赠，你且去寻为师座下大弟子打探此物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1048}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1049}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师父让我前来询问宝物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 209}},
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
		speakerID = 20026,
		soundID = nil,
		txt = "恭候师弟多时，本派入门弟子都将携带宠物一枚，此宠可以在今后的历练中成为你的助力，<font color = '#FFFFFF00'><myName></font>你且去前山寻找你的宠物吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1049}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1050}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，宠物已经捕捉到了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 211}},
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
		speakerID = 20026,
		soundID = nil,
		txt = "如此甚好，你且将它带在身边，和你并肩作战。听闻师父有要事相商，<font color = '#FFFFFF00'><myName></font>你便去师父处询问罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1050}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1051}},
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
		txt = "师父有何吩咐？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 213}},
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
		speakerID = 20008,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。如今黄巾军正在桃园镇处作乱，<font color = '#FFFFFF00'><myName></font>你且前去桃园镇帮助其镇长刘元起诛杀在桃园镇附近作乱的黄巾军！你可寻找门派传送人送你去桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 214}},
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
		txt = "好的师父，我这便启程前往桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1051}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1052}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我乃紫阳门弟子<font color = '#FFFFFF00'><myName></font>，特奉为师黄天化之命前来，协助你铲除在桃园镇附近的黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 216}},
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
		speakerID = 20027,
		soundID = nil,
		txt = "多谢英雄前来协助，如今我侄儿刘备正在桃园镇内准备前去讨伐黄巾军，你可去寻他一起前往讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1052}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1053}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我乃紫阳门弟子<font color = '#FFFFFF00'><myName></font>，特奉师命前来，协助你讨伐黄巾军。",
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
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某如今因势单力薄，想要寻找几位武艺高强人士一起讨伐黄巾军。最近听闻在桃园镇内，有一名好汉名叫张飞，你且前去帮我询问那位好汉能否与刘某一起讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1053}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1064}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "吾已知师尊吩咐！师尊另命吾将此百宝袋转赐于你，此袋中装有灵药仙衣，可助你于人间修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 221}},
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
		txt = "童子，此百宝袋该如何使用？又该如何穿戴百宝袋里面的仙衣？",
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
		speakerID = 20003,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，吾这便教你如何使用百宝袋和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1054}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1056}},
		{action = DialogActionType.UITip, param = {v = 15,p = 1}},
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
		speakerID = 0,
		soundID = nil,
		txt = "多谢童子指教，我已知晓百宝袋的使用方法和穿戴仙衣！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 224}},
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
		speakerID = 20003,
		soundID = nil,
		txt = "此事已了，吾这便送你入凡，莲花作法，灵剑听命，速下凡去吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1056}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1057}},
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
		speakerID = 20009,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>你初入本门，为师且助你参悟本门心法，心法参悟到一定等级便可领悟技能。你且尝试将本门主心法和副心法各提升一级。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1057}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1058}},
		{action = DialogActionType.UITip, param = {v = 9,p = 1}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我已参悟本门基本心法了，请师父吩咐。",
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
		speakerID = 20009,
		soundID = nil,
		txt = "如今你已是本派的入门弟子，门派心法还需勤加修炼，此外为师还有一件宝物相赠，你且去寻为师座下大弟子打探此物。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1058}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1059}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，师父让我前来询问宝物一事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 231}},
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
		speakerID = 20024,
		soundID = nil,
		txt = "恭候师弟多时，本派入门弟子都将携带宠物一枚，此宠可以在今后的历练中成为你的助力，<font color = '#FFFFFF00'><myName></font>你且去前山寻找你的宠物吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1059}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1060}},
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
		speakerID = 0,
		soundID = nil,
		txt = "大师兄，宠物已经捕捉到了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20024,
		soundID = nil,
		txt = "如此甚好，你且将它带在身边，和你并肩作战。听闻师父有要事相商，<font color = '#FFFFFF00'><myName></font>你便去师父处询问罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1060}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1061}},
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
		txt = "师父有何吩咐？",
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
		speakerID = 20009,
		soundID = nil,
		txt = "妖道张角得截教真传，借黄巾军作乱，谋夺汉室江山。如今黄巾军正在桃园镇处作乱，<font color = '#FFFFFF00'><myName></font>你且前去桃园镇帮助其镇长刘元起诛杀在桃园镇附近作乱的黄巾军！你可寻找门派传送人送你去桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 0,
		soundID = nil,
		txt = "好的师父，我这便启程前往桃园镇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1061}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1062}},
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
		txt = "我乃云霄宫弟子<font color = '#FFFFFF00'><myName></font>，特奉为师纯阳真人之命前来，协助你铲除在桃园镇附近的黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 238}},
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
		speakerID = 20027,
		soundID = nil,
		txt = "多谢英雄前来协助，如今我侄儿刘备正在桃园镇内准备前去讨伐黄巾军，你可去寻他一起前往讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1062}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1063}},
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
		speakerID = 0,
		soundID = nil,
		txt = "我乃云霄宫弟子<font color = '#FFFFFF00'><myName></font>，特奉师命前来，协助你讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 240}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "原来是仙门弟子，刘某如今因势单力薄，想要寻找几位武艺高强人士一起讨伐黄巾军。最近听闻在桃园镇内，有一名好汉名叫张飞，你且前去帮我询问那位好汉能否与刘某一起讨伐黄巾军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1063}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1064}},
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
		speakerID = 0,
		soundID = nil,
		txt = "这位好汉，我奉桃园镇义士刘备之命，邀请你加入义军共同讨伐黄巾军。",
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
		speakerID = 20037,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠，不用多说，俺早已准备加入义军讨伐黄巾军，如今俺有一把武器让铁匠帮我制作，你且帮俺前去询问铁匠武器做好了没有。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1064}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1065}},
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
		speakerID = 0,
		soundID = nil,
		txt = "铁匠大叔，我来帮张飞义士询问下他的武器有没有制作好！",
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
		speakerID = 20029,
		soundID = nil,
		txt = "这位少侠，你来的太晚了，就在刚刚我制作的一批武器都被黄巾军给抢走，其中也包含张飞义士的武器在内，你且将这消息告知张飞义士，询问下有何解决方法！",
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
[245] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张飞义士，从铁匠大叔口中得知，你的武器已被黄巾军给抢走了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 246}},
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
		speakerID = 20037,
		soundID = nil,
		txt = "竟然发生了这种事情，以俺猜测估计在桃园镇内有黄巾军的奸细。就在前几天俺看到桃园镇内有一红脸汉子，俺怀疑他就是奸细，你且帮俺前去打探打探。",
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
[247] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，你是不是就是黄巾军的奸细，在此偷取铁匠武器！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 248}},
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
		speakerID = 20032,
		soundID = nil,
		txt = "你是何人，为何诬陷我是奸细，看来你也不是什么好人，那就让我来教训教训你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 102,mapID = 9}},
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
		speakerID = 20032,
		soundID = nil,
		txt = "这位<font color = '#FFFFFF00'><myName></font>少侠你找错人了，在下姓关名羽字云长，乃是在桃园镇做些小买卖，不是黄巾军的奸细。其实我知道真正偷走武器的是谁，在桃园镇内有一陌生人，此人那天抢走武器被我看到了，现在此人应该还在桃园镇内，你可前去寻找。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1067}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1068}},
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
		txt = "站住！是不是就是你偷走铁匠大叔的武器！",
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
		speakerID = 20030,
		soundID = nil,
		txt = "没想到竟然被你发现了，那就别怪我不客气了，拿命来吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 103,mapID = 9}},
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
		txt = "快说！你为何偷走武器，偷走武器又是所为何事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 253}},
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
		speakerID = 20030,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠饶命！我是奉黄巾军首领张宝的命令前来桃园镇打探消息，那天正好看到铁匠制作好一批武器，就把他武器抢走了，交于张宝手里，如今张宝就在镇外桃林处。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 254}},
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
		speakerID = 0,
		soundID = nil,
		txt = "看来事情有点复杂了，黄巾军已经偷偷进入桃园镇外了，我得速去将消息告知刘备义士才行。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1068}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1069}},
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
		txt = "刘备义士，经过我的探查，得知黄巾军首领张宝已经出现在镇外桃林，我们该如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20028,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠别急，如今张宝已在镇外桃林处，凭我们两个还不是其对手，少侠你且前去邀请张飞义士，与我们一同前往诛杀张宝！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1069}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1070}},
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
		txt = "张飞义士，如今黄巾军首领张宝已在镇外桃林处，刘备义士希望你能与我们一起前往诛杀张宝！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20037,
		soundID = nil,
		txt = "没想到黄巾军已经逼近桃园镇了，俺这就准备出发。俺觉得那个红脸汉子武力也很高强，如果有他相助的话，必能事半功倍，少侠你可前去邀请他一同诛杀张宝。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1070}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1071}},
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
		txt = "关羽义士，我奉命前来请你一同前往镇外桃林诛杀黄巾军首领张宝，不知你可愿否！",
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
		speakerID = 20032,
		soundID = nil,
		txt = "关某愿意前往诛杀黄巾军统领张宝，关某这就准备出发！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 261}},
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
		speakerID = 0,
		soundID = nil,
		txt = "多谢关羽义士，在下就先回去将此好消息禀报给刘备义士！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1071}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1072}},
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
		txt = "刘备义士，我已邀请张飞义士和关羽义士一同前往镇外桃林讨伐张宝！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20028,
		soundID = nil,
		txt = "多谢少侠相助，我等前去与那两位义士会合吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1072}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1073}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "多谢两位侠士相助，刘某在此感谢不尽！",
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
		speakerID = 20032,
		soundID = nil,
		txt = "刘备义士不必感谢，此黄巾军无恶不作，扰得民不聊生，关某也是看不下去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 266}},
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
		speakerID = 20037,
		soundID = nil,
		txt = "俺张飞就是看不惯那些无恶不作之人，俺们这就一起进入镇外桃林讨伐那个黄巾军首领张宝，诛杀黄巾军！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1073}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1074}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "张宝！你竟敢在此作乱，今日就是你的死期！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 268}},
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
		speakerID = 20031,
		soundID = nil,
		txt = "就凭你们这几个土鸡瓦狗，还想杀死我，小的们，上！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 104,mapID = 400}},
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
		txt = "如今张宝逃走，我们该如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 270}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠莫急，刘某与二弟、三弟返回桃园镇准备好武器铠甲，你且先前去黄巾军老巢巨鹿打探张宝下落，我等到时在巨鹿会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1074}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1075}},
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
		speakerID = 20038,
		soundID = nil,
		txt = "我乃张宝手下部将严政，你是何人，竟敢擅闯此地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 272}},
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
		speakerID = 0,
		soundID = nil,
		txt = "严政还不速速将张宝下落告知与我，我便放了你！",
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
[273] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说！张宝如今藏在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 274}},
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
		speakerID = 20038,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠饶命，如今张宝就在巨鹿深处，但他一直鬼鬼祟祟的不知道在做什么，我们也不知何事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1075}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1076}},
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
		speakerID = 0,
		soundID = nil,
		txt = "刘备义士我这就将你救出来！",
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
		speakerID = 20044,
		soundID = nil,
		txt = "没想到又有一个来送死的，那我就不客气的收下了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 106,mapID = 101}},
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
		speakerID = 0,
		soundID = nil,
		txt = "刘备义士，我已打探到张宝下落，但你为何会被围困住！还有关羽和张飞两位义士去往何处！",
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
		speakerID = 20028,
		soundID = nil,
		txt = "多谢<font color = '#FFFFFF00'><myName></font>少侠救命之恩，刘某与二弟、三弟一同前往巨鹿找寻张宝，不料被黄巾军偷袭，导致我与二弟、三弟都被分散，希望少侠能与我一同前往找寻刘某的二弟和三弟。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1076}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1077}},
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
		speakerID = 20045,
		soundID = nil,
		txt = "没想到马相竟然没有挡住你们，真是废物，看我来将你们斩杀在此！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 280}},
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
		txt = "大言不惭！那就让我来看看你是否有这个实力！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 107,mapID = 101}},
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
		speakerID = 20037,
		soundID = nil,
		txt = "多谢<font color = '#FFFFFF00'><myName></font>少侠和大哥相救，俺发现二哥关羽正被另一个黄巾军将领围困于前方，俺们速去与二哥关羽会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1077}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1078}},
			},
			}
		},
	},
[282] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20046,
		soundID = nil,
		txt = "糟糕！那些饭桶！竟然让你们杀到这里来救人了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 283}},
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
		txt = "关羽义士莫慌，我们这就斩杀此贼救你出来！  ",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 108,mapID = 101}},
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
		speakerID = 20032,
		soundID = nil,
		txt = "多谢<font color = '#FFFFFF00'><myName></font>少侠和大哥、三弟相救，关某从黄巾军那些将领处偷听到，张宝如今正在巨鹿深处布置一个秘密古阵，我们可前往古阵找寻那张宝。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20028,
		soundID = nil,
		txt = "那我们即刻出发！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1078}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1079}},
			},
			}
		},
	},
[286] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张宝，这次你跑不掉了，今日就是你的死期！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 287}},
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
		speakerID = 20031,
		soundID = nil,
		txt = "狂妄小子！上次我是让你们，你们还敢闯入这里，进入了我的地盘，就别再想活着出去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 109,mapID = 401}},
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
		speakerID = 20032,
		soundID = nil,
		txt = "终于将张宝诛杀，这下桃园镇再无黄巾军作乱！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 0,
		soundID = nil,
		txt = "三位义士，为何张宝会在此布置这个秘密古阵，这古阵有何作用！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 290}},
					},
			}
		},
	},
[290] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20032,
		soundID = nil,
		txt = "其实我在被黄巾军围困的时候，顺便偷听到张宝布置的这个秘密古阵是为了收集巨鹿的战场亡魂，如今其弟张梁正携带这些亡魂赶往岐山，而岐山中还有一座张角所布置的万魂大阵，正由其弟张梁在那看守。其万魂大阵布置在封神台上面，那张角正欲破坏封神台，封神台乃元始天尊命姜尚修建镇压万千妖魔的地方，若封神台被破，则天下大乱，后果不堪设想，我们需立刻前往封神台阻止！ ",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1079}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1080}},
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
		speakerID = 20047,
		soundID = nil,
		txt = "黄巾上将程远志在此！本将军奉命把守封神台，凡靠近者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 292}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "程志远，你逆天而行，今日便是你的死期！",
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
[293] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "程志远已被诛杀，我等继续深入探寻万魂大阵所在何处！",
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
[294] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "终于找到了万魂大阵，但如今这万魂大阵被三个子阵法给包裹住，形成一个连环阵法，想要进入万魂大阵需要先破除最外面的三个阵法才能进入。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 295}},
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
		txt = "那我们开始破除阵法吧！",
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
[296] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20048,
		soundID = nil,
		txt = "来者何人！此乃失魂阵内，竟敢随意乱闯！找死么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 0,
		soundID = nil,
		txt = "区区阵法灵兽，还敢口出狂言！受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 111,mapID = 402}},
				},
			}
		},
	},
[298] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "失魂阵已破除，我们且进入下一个阵法！",
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
[299] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20051,
		soundID = nil,
		txt = "竟然闯入了血魂阵，你们就别想活着出去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 300}},
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
		txt = "大言不惭！今日必将你破除！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 112,mapID = 403}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "血魂阵已破除，还剩一个子阵法！",
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
[302] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20053,
		soundID = nil,
		txt = "没想到你们竟然闯到了这里，凡靠近万魂大阵者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 303}},
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
		txt = "今日我们必将万魂大阵破除，你阻挡我不了我们！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 113,mapID = 404}},
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
		speakerID = 20028,
		soundID = nil,
		txt = "三个子阵法已全部破除，我等这就进入万魂大阵将其破除，阻止张角破坏封印台！",
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
[305] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 306}},
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
		speakerID = 20055,
		soundID = nil,
		txt = "没料尔等竟能闯到此地。也罢！尔等一心求死，那就让本座送尔等上路吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 114,mapID = 405}},
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
					{action = DialogActionType.Goto, param = {dialogID = 308}},
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
		speakerID = 0,
		soundID = nil,
		txt = "师父，我与刘关张三兄弟前去击杀张角，不料张角破除了封神台，放出了无数妖魔，而且张角还逃走了，这该如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 310}},
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
		speakerID = 20004,
		soundID = nil,
		txt = "此事非同小可，为师这里暂无任何解决办法！你且前去玄都玉京天询问元始天尊有何解决办法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1088}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1089}},
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
		speakerID = 0,
		soundID = nil,
		txt = "师父，我与刘关张三兄弟前去击杀张角，不料张角破除了封神台，放出了无数妖魔，而且张角还逃走了，这该如何是好！",
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
		speakerID = 20005,
		soundID = nil,
		txt = "此事非同小可，为师这里暂无任何解决办法！你且前去玄都玉京天询问元始天尊有何解决办法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1090}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1091}},
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
		txt = "师父，我与刘关张三兄弟前去击杀张角，不料张角破除了封神台，放出了无数妖魔，而且张角还逃走了，这该如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		speakerID = 20006,
		soundID = nil,
		txt = "此事非同小可，为师这里暂无任何解决办法！你且前去玄都玉京天询问元始天尊有何解决办法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1092}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1093}},
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
		txt = "师父，我与刘关张三兄弟前去击杀张角，不料张角破除了封神台，放出了无数妖魔，而且张角还逃走了，这该如何是好！",
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
		speakerID = 20007,
		soundID = nil,
		txt = "此事非同小可，为师这里暂无任何解决办法！你且前去玄都玉京天询问元始天尊有何解决办法！",
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
[317] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "师父，我与刘关张三兄弟前去击杀张角，不料张角破除了封神台，放出了无数妖魔，而且张角还逃走了，这该如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 318}},
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
		speakerID = 20008,
		soundID = nil,
		txt = "此事非同小可，为师这里暂无任何解决办法！你且前去玄都玉京天询问元始天尊有何解决办法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1096}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1097}},
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
		txt = "师父，我与刘关张三兄弟前去击杀张角，不料张角破除了封神台，放出了无数妖魔，而且张角还逃走了，这该如何是好！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 320}},
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
		speakerID = 20009,
		soundID = nil,
		txt = "此事非同小可，为师这里暂无任何解决办法！你且前去玄都玉京天询问元始天尊有何解决办法！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1098}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1099}},
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
		txt = "卢大人，岐山封神台被张角摧毁，无数妖魔逃窜四方，大汉子民危矣。还望朝廷遣大军收伏妖魔！",
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
					{action = DialogActionType.FinishTask, param = {taskID = 1100}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1351}},
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
		speakerID = 20060,
		soundID = nil,
		txt = "擅闯御花园，意欲何为？难不成是想谋反吗？",
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
		txt = "休得拦我，蹇硕在哪里？叫他滚出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 116,mapID = 15}},
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
		speakerID = 20061,
		soundID = nil,
		txt = "站住！此乃御林营重地，没有蹇硕统领的命令，谁也不许擅入！",
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
		speakerID = 0,
		soundID = nil,
		txt = "我今天就是来找蹇硕这逆贼算账的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 117,mapID = 15}},
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
		speakerID = 20062,
		soundID = nil,
		txt = "蹇硕在此，何人在御花园造次，真是活的不耐烦了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 330}},
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
		txt = "蹇硕，你伙同阉宦十常侍张让软禁陛下，操弄权柄，今日便要替天下人除掉你这祸害！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 118,mapID = 15}},
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
[332] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20065,
		soundID = nil,
		txt = "站住，张让大人有令，擅闯御花园者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 119,mapID = 15}},
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
		speakerID = 20066,
		soundID = nil,
		txt = "你等竟敢携带兵刃闯入皇城重地，莫不是谋反不成！来人呐！给我拿下了！",
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
		speakerID = 0,
		soundID = nil,
		txt = "岂有此理！你等软禁当今圣上，竟还贼喊捉贼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 120,mapID = 15}},
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
		txt = "张让，总算找到你了！你软禁圣上已久，如今把圣上藏在了何处，快快道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 337}},
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
		speakerID = 20067,
		soundID = nil,
		txt = "圣上素来宠信咱家，咱家对圣上也是忠心耿耿，何来软禁之说！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 121,mapID = 15}},
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
		speakerID = 0,
		soundID = nil,
		txt = "快说，陛下现在在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 339}},
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
		speakerID = 20067,
		soundID = nil,
		txt = "好汉饶命，我这就说！皇帝被我藏在御花园的南苑，你可前去那里找寻皇帝！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1352}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1353}},
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
		txt = "陛下怎么不见了！张让肯定不会骗我！莫非被人给劫走了不成，不行，我要在这附近再寻找下，看是否有留下什么线索！",
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
[341] = 
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
		speakerID = 20049,
		soundID = nil,
		txt = "究竟是何方妖魔，竟掳走陛下！皇宫警卫向来由朝廷大将皇甫嵩负责，如今他正在洛阳城南门，你可前去寻他，打探近日洛阳有否发现妖魔踪迹。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1354}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1355}},
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
		txt = "皇甫将军，陛下前两日被一妖魔潜入宫中抓走了，我奉卢植大人之令，特前来查探此事！",
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
		speakerID = 20059,
		soundID = nil,
		txt = "假冒的御前侍卫混入皇宫，御前侍卫统领赵忠脱不了关系，很可能和此事有关！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 345}},
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
		speakerID = 20059,
		soundID = nil,
		txt = "我观你为陛下奔波劳累，体力有所下降，老夫这里有一坐骑便送于少侠，可在赶路时加快步伐，减少体力的消耗。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1355}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1356}},
		{action = DialogActionType.UITip, param = {v = 24,p = 25}},
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
		speakerID = 0,
		soundID = nil,
		txt = " 多谢皇甫将军赐我坐骑！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 347}},
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
		speakerID = 20059,
		soundID = nil,
		txt = "<font color = '#FFFFFF00'><myName></font>少侠，小事一桩，如今赵忠正在洛阳城城门口处，你可前去找他打探此事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1356}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1357}},
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
		txt = "假冒的御前侍卫混入皇宫，是不是你在背后捣鬼？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 349}},
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
		speakerID = 20070,
		soundID = nil,
		txt = "既然你已知晓，那就不能留你性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 123,mapID = 10}},
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
					{action = DialogActionType.Goto, param = {dialogID = 351}},
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
		speakerID = 20059,
		soundID = nil,
		txt = "张燕乃当年张角的亲传弟子，神通高强，张角破坏封神台之后张燕率一群黑山贼匪盘踞黑风岭为恶。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1357}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1358}},
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
		txt = "快说那张燕现如今何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 353}},
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
		speakerID = 20071,
		soundID = nil,
		txt = "别杀我，我这就说，如今张燕就驻扎在黑风岭中，前方还有张燕麾下将领在此看守，只要将其首领诛杀，就能找到张燕！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1358}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1359}},
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
		speakerID = 20074,
		soundID = nil,
		txt = "站住！何人敢闯入我黑风山之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 355}},
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 125,mapID = 104}},
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
		speakerID = 20075,
		soundID = nil,
		txt = "我家张大人有令，要治你等擅闯山门之罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 357}},
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 126,mapID = 104}},
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
		speakerID = 20076,
		soundID = nil,
		txt = "吾乃黄巾大将张燕是也！你等穷追不舍，究竟意欲何为？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 359}},
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
		txt = "张燕你收买赵忠，派假冒的御前侍卫混入皇宫，皇帝失踪是不是你掳走的？还不速速道来。",
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
[360] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说出陛下的下落，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 361}},
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
		speakerID = 20076,
		soundID = nil,
		txt = "英雄饶命，我这便告知于你！假冒侍卫乃是受我师傅黑风老妖命令，进入皇宫抓捕皇帝。黑风老妖如今就在黑风岭中深处黑风洞中，你可找他询问皇帝的下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1359}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1360}},
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
		speakerID = 20077,
		soundID = nil,
		txt = "尔等竟敢擅闯我山门，杀我弟子，可恨！今日本老祖定要将尔等碎尸万段！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 363}},
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
		speakerID = 0,
		soundID = nil,
		txt = "黑风老妖，你把陛下藏在哪了，快快交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 128,mapID = 407}},
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
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 365}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1361}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1362}},
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
		txt = "掌门师尊，陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 367}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1363}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1364}},
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
		txt = "掌门师尊，陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 369}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1365}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1366}},
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
		txt = "掌门师尊，陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 371}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1367}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1368}},
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
		txt = "掌门师尊，陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 373}},
					},
			}
		},
	},
[373] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1369}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1370}},
			},
			}
		},
	},
[374] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "掌门师尊，陛下被黑风老妖抓走，我欲搭救，奈何此老妖非我所能对付，还望师尊教我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 375}},
					},
			}
		},
	},
[375] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1371}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1372}},
			},
			}
		},
	},
[378] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20079,
		soundID = nil,
		txt = "吾乃金霞童子，奉吾师之命在此等候多时。吾等这便进入黑风洞，收伏黑风老妖吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 379}},
					},
			}
		},
	},
[379] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1373}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1374}},
			},
			}
		},
	},
[380] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20077,
		soundID = nil,
		txt = "不知死活的小子，上次让你溜了，居然又来送死，这次看你还怎么跑！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 381}},
					},
			}
		},
	},
[381] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20079,
		soundID = nil,
		txt = "黑风老妖，可识得吾金霞童子！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 129,mapID = 407}},
				},
			}
		},
	},
[382] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20077,
		soundID = nil,
		txt = "我抓走人间皇帝，实乃受西凉诸侯董卓之托，如今皇帝已被我遣人送到了董卓手中！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 383}},
					},
			}
		},
	},
[383] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20079,
		soundID = nil,
		txt = "黑风老妖已降，皇帝下落也已查清，吾这便返回天界，小友快去把此消息禀于汉室之人，设法营救皇帝吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1374}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1375}},
			},
			}
		},
	},
[384] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "皇甫将军，我已从黑风老妖口中得知，当今圣上已被黑风老妖送到了西凉诸侯董卓手中！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 385}},
					},
			}
		},
	},
[385] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20059,
		soundID = nil,
		txt = "董卓此人向来野心勃勃，如今竟私下掳走陛下，其心可诛！堳坞是董卓大军的驻军要地，你且前往堳坞打探董卓下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1375}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1376}},
			},
			}
		},
	},
[386] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20082,
		soundID = nil,
		txt = "我董军军营岂是你能擅闯的？小的们，给本将拿下此人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 387}},
					},
			}
		},
	},
[387] = 
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 130,mapID = 106}},
				},
			}
		},
	},
[388] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你可知堳坞驻军要地的动静和皇帝的下落，如实报来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 389}},
					},
			}
		},
	},
[389] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20083,
		soundID = nil,
		txt = "吾乃堳坞营前将军樊定，就凭你也有资格打探我堳坞的驻军要地，纳命来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 131,mapID = 106}},
				},
			}
		},
	},
[390] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20084,
		soundID = nil,
		txt = "你是何人，无故闯我军营，杀我将士，对本将苦苦相逼，意欲何为？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 391}},
					},
			}
		},
	},
[391] = 
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 132,mapID = 106}},
				},
			}
		},
	},
[392] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓这逆贼如今把陛下藏在了何处？还不快快从实招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 393}},
					},
			}
		},
	},
[393] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20084,
		soundID = nil,
		txt = "董卓筑有一处秘密堡垒在堳坞南边，圣上便是被董卓藏在此地，由上古大魔飞廉镇守，英雄想要营救圣上，可去堳坞南边一探究竟。 ",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1376}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1377}},
			},
			}
		},
	},
[394] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20087,
		soundID = nil,
		txt = "堳坞乃我家主公董卓军垒重地，你竟敢擅闯，真是活腻了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 395}},
					},
			}
		},
	},
[395] = 
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 133,mapID = 106}},
				},
			}
		},
	},
[396] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20088,
		soundID = nil,
		txt = "本将奉飞廉大人之令，特前来擒你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 397}},
					},
			}
		},
	},
[397] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "飞廉果然藏身在此，今日就先灭了你，再找飞廉算账！",
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
[398] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "当今皇帝是不是藏于此堳坞之地，还不快快把皇帝交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 399}},
					},
			}
		},
	},
[399] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20089,
		soundID = nil,
		txt = "吾乃上古大魔飞廉，想知道皇帝的下落，看你本事如何！",
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
[400] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "祖师，我前往长安打探皇帝下落，不料中了上古大魔飞廉的埋伏，原来从封神台逃出的一些妖魔如今已经投靠董卓，有这些妖兵相助，董卓实力大涨。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 401}},
					},
			}
		},
	},
[401] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "要对付董卓，需在人间寻得两位应天命而生的英雄人物，一为袁绍，一为曹操，以此二人之声望，号召天下英雄联手讨伐董卓，董卓大军便不足为惧。你可前去洛阳询问卢植此二人下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1378}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1379}},
			},
			}
		},
	},
[402] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，我受元始祖师指点，要寻袁绍、曹操二人出面号召天下英雄讨伐董卓，营救陛下，不知此二人现在何处？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 403}},
					},
			}
		},
	},
[403] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "糟糕！袁绍本在朝中为官，但前些天因得罪董卓，已被董卓遣人抓走！得赶紧设法营救！董卓有一心腹将领李肃，如今在孟津大营驻守，你可速前往其军营打探袁绍关押之处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1379}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1380}},
			},
			}
		},
	},
[404] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20093,
		soundID = nil,
		txt = "何人敢擅闯军营！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 405}},
					},
			}
		},
	},
[405] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "李肃在哪里？快让他来见我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 136,mapID = 408}},
				},
			}
		},
	},
[406] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20094,
		soundID = nil,
		txt = "站住！我奉李将军之令把守此地，你擅闯军营重地，该当何罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 407}},
					},
			}
		},
	},
[407] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "董卓走狗，不必多言，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 137,mapID = 408}},
				},
			}
		},
	},
[408] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20095,
		soundID = nil,
		txt = "我乃董太师手下驻守大将李肃是也，你是何人，敢如此放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 409}},
					},
			}
		},
	},
[409] = 
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 138,mapID = 408}},
				},
			}
		},
	},
[410] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快快从实交代，袁绍被你们抓到哪里去了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 411}},
					},
			}
		},
	},
[411] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20095,
		soundID = nil,
		txt = "英雄饶命！袁绍如今已被捉拿关押在潼关一地，由董卓手下大将侯成看守！英雄要想救出袁绍，可往潼关找那侯成算账。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1380}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1381}},
			},
			}
		},
	},
[412] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 413}},
					},
			}
		},
	},
[413] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20098,
		soundID = nil,
		txt = "就是你小子想要救袁绍的？来得正好，本将正要捉拿几个袁绍同党去找董太师邀功呢！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 139,mapID = 110}},
				},
			}
		},
	},
[414] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 415}},
					},
			}
		},
	},
[415] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "袁某早有讨伐董贼之心，故才被他所擒。听闻董卓已遣其手下大将段煨前来阻截袁某出潼关，还望英雄杀退追兵，助我脱困！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1381}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1382}},
			},
			}
		},
	},
[416] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20101,
		soundID = nil,
		txt = "袁绍，看你往哪里跑！你若束手就擒，我还可在董太师面前替你美言几句，饶你一命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 417}},
					},
			}
		},
	},
[417] = 
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 140,mapID = 110}},
				},
			}
		},
	},
[418] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "多谢英雄！但要号召天下群雄讨董，我必先逃出潼关大营。听闻这次董卓派出族弟董旻前来镇守潼关出口，还望英雄击退董旻，助我离开潼关大营。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 419}},
					},
			}
		},
	},
[419] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁将军放心，我必会平安护送你出潼关大营的，我们这便出发！",
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
[420] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20109,
		soundID = nil,
		txt = "袁绍！本将等你多时了！董太师已诏令天下要捉你，今日本将就擒你回去请赏！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 421}},
					},
			}
		},
	},
[421] = 
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
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 141,mapID = 110}},
				},
			}
		},
	},
[422] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20091,
		soundID = nil,
		txt = "潼关已过，前方已是我袁家地盘，董卓休想再奈何袁某！多谢英雄一路相送！袁某此番回去，定然号召天下群雄，共举讨董义旗！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 423}},
					},
			}
		},
	},
[423] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1383}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1384}},
			},
			}
		},
	},
[424] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1001}},
					},
			}
		},
	},
[425] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20028,
		soundID = nil,
		txt = "张梁已被诛杀，万魂大阵也已被破除，我等速去封神台，阻止张角！",
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
[426] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 427}},
					},
			}
		},
	},
[427] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20056,
		soundID = nil,
		txt = "刘备，你来晚了！封神台的最后一道封印马上就要被本座破掉，万千妖魔群出，天下即将大乱！哈哈！这江山迟早是我的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 115,mapID = 406}},
				},
			}
		},
	},
[428] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 429}},
					},
			}
		},
	},
[429] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你这便去找他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1089}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
			},
			}
		},
	},
[430] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 431}},
					},
			}
		},
	},
[431] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你这便去找他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1091}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
			},
			}
		},
	},
[432] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 433}},
					},
			}
		},
	},
[433] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你这便去找他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1093}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
			},
			}
		},
	},
[434] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 435}},
					},
			}
		},
	},
[435] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你这便去找他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1095}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
			},
			}
		},
	},
[436] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 437}},
					},
			}
		},
	},
[437] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你这便去找他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1097}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
			},
			}
		},
	},
[438] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 439}},
					},
			}
		},
	},
[439] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "本座已知悉封神台之事，冥冥天道循环，人间注定要有一番群雄蜂起、三国并立之乱世劫难，方有封神台被毁之事。当务之急，乃设法收服妖魔，助众生渡此大劫。你且下界前往洛阳，将封神台一事告知汉室朝廷，让朝廷早作打算。听闻汉室朝廷尚书卢植大人有济世之志，你这便去找他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1099}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1100}},
			},
			}
		},
	},
[440] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 441}},
					},
			}
		},
	},
[441] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20078,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为金霞童子，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1362}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1373}},
			},
			}
		},
	},
[442] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 443}},
					},
			}
		},
	},
[443] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20078,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为金霞童子，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1364}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1373}},
			},
			}
		},
	},
[444] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 445}},
					},
			}
		},
	},
[445] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20078,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为金霞童子，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1366}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1373}},
			},
			}
		},
	},
[446] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 447}},
					},
			}
		},
	},
[447] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20078,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为金霞童子，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1368}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1373}},
			},
			}
		},
	},
[448] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 449}},
					},
			}
		},
	},
[449] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20078,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为金霞童子，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1370}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1373}},
			},
			}
		},
	},
[450] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 451}},
					},
			}
		},
	},
[451] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20078,
		soundID = nil,
		txt = "此黑风老妖乃从封神台逃出的一头上古大妖，本座有一徒名为金霞童子，法力无边，足可助你收伏黑风老妖。你且安心先往黑风山去，本座随后便遣吾徒下界与你会合！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1372}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1373}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1384}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1101}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1102}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1103}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1104}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1105}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1106}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1106}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1107}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1107}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1108}},
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
		txt = "曹某本欲邀战华雄，却听手下探子来报，有一自称关羽的英雄，竟孤身一人杀入虎牢关，声称要取华雄人头。我担心此人有失，还望英雄前往虎牢关助其战胜华雄！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1108}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1109}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1111}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1112}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1115}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1116}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1116}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1117}},
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
		txt = "祖师，我已成功救下曹操将军，并助其攻破虎牢关，现在袁绍大军已经挥师西行，征讨董贼了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		txt = "本尊已知晓此事，但如今你修为还未达到一定高度，切不可沾沾自喜，你还须加强修炼，等你升到三十级再来找我吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1117}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1118}},
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
[1054] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "少侠你已达到三十级，请到玄都玉京来找我，接取下一个任务。",
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
					{action = DialogActionType.FinishTask, param = {taskID = 1118}},
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
		txt = "速速停下！放了孙将军，我便饶你一命！",
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
[1110] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
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
					{action = DialogActionType.Goto, param = {dialogID = 1111}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1153}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1154}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1154}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1155}},
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
[1120] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
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
					{action = DialogActionType.Goto, param = {dialogID = 1121}},
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
		speakerID = 20646,
		soundID = nil,
		txt = "英雄有所不知，这徐荣军中凭空多出许多魔兵魔将，甚是厉害。此事十分蹊跷，我已派遣黄盖将军前往探查，但许久未归，英雄可否帮我探寻一番，孙某感激不尽。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1156}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1157}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1158}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1159}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1162}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1163}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1151}},
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
		txt = "此金缠看起来凶神恶煞，没想到这么不堪一击。金缠魂魄已拿到，再前去寻找烬枝，听说此烬枝可以化形，和枯木难以区分，看来得仔细找找。",
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
		txt = "这个烬枝竟然如此厉害，还好终于杀了它，接下来就去找火魁，听闻火魁在东郡一带活动，我这就动身前往寻找！",
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
		txt = "火魁，你残害百姓，百姓苦不堪言，今日就将你斩首！",
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
					{action = DialogActionType.Goto, param = {dialogID = 1168}},
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
[1172] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
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
[1177] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1171}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1172}},
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
		txt = "英雄战果如何？那徐荣现在如何？",
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
					{action = DialogActionType.FinishTask, param = {taskID = 1173}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1174}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1200}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1200}},
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
		txt = "我也不知董卓如今身在何处，不过我已成功离间董卓和其义子吕布的关系，使吕布对董卓怀恨在心。我今日原和吕布约好于郿坞私聚，奈何我被董卓亲信萵姬监视无法脱身，请英雄助我斩杀萵姬，让我前去会见吕布，便能知晓董卓下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1203}},
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
					{action = DialogActionType.CloseDialog, param ={}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1219}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1206}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1207}},
			},
			}
		},
	},
[1220] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1221}},
					},
			}
		},
	},
[1221] = 
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
[1222] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20752,
		soundID = nil,
		txt = "其实董卓一直对吕布心存怀疑，吕布手下的大将曹性便是董卓安插在吕布身边的奸细，从曹性处或许能够知道原因，曹性如今便在长安，你去寻他吧。",
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
[1223] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1224}},
					},
			}
		},
	},
[1224] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹性，吕布将军为何心智尽失，是不是你在背后捣的鬼？还不快快道来。",
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
[1225] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20731,
		soundID = nil,
		txt = "英雄饶命，其实董卓早已察觉吕布和貂蝉姑娘之事，前些日子董卓让一个亲信孙胜拿着一种药物来见吕布，令他在吕布的饮食中下毒，此人如今在长安还未离开。",
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
[1226] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1227}},
					},
			}
		},
	},
[1227] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1228}},
					},
			}
		},
	},
[1228] = 
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
[1229] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 108}},
				    {action = DialogActionType.Gotos, param = {dialogIDs = {1282,1283,1284,1285,1286,1287}}},
					},
			}
		},
	},
[1230] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1236}},
					},
			}
		},
	},
[1231] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1237}},
					},
			}
		},
	},
[1232] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1238}},
					},
			}
		},
	},
[1233] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1239}},
					},
			}
		},
	},
[1234] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1240}},
					},
			}
		},
	},
[1235] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1241}},
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
		speakerID = 20004,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1210}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1216}},
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
		speakerID = 20005,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1211}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1226}},
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
		speakerID = 20006,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1212}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1227}},
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
		speakerID = 20007,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1213}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1228}},
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
		speakerID = 20008,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1214}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1229}},
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
		speakerID = 20009,
		soundID = nil,
		txt = "那截教魔毒非一般人可解，我阐教金仙慈航道人精通丹药之术，他定有办法可解吕布之毒，你即刻前往蓬莱仙山寻他相助。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1215}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1230}},
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
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1248}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1249}},
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
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1250}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1251}},
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
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
		txt = "慈航前辈，那吕布身中截教上古魔毒，弟子无法可解，还望前辈相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1216}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1226}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1227}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1228}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1229}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1230}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1217}},
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
[1255] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1256}},
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
[1257] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1258}},
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
		txt = "在下受人所托，来此处寻找天山雪莲，如若知道下落可否告知？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1218}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1219}},
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
		txt = "好大的口气，若想活命便老实交代雪莲在何处！",
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
[1262] = 
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
[1263] = 
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
[1265] = 
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
[1266] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1267}},
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
[1268] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20717,
		soundID = nil,
		txt = "要想见我主人，先过了我这关！",
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
[1269] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20734,
		soundID = nil,
		txt = "英雄饶命，我家主人现在前方，英雄继续前往可见到我家主人。",
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
[1270] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1271}},
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
[1273] = 
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
[1275] = 
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
[1276] = 
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
[1278] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1279}},
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
[1280] = 
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
					{action = DialogActionType.Goto, param = {dialogID = 1281}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1225}},
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
		txt = "来者何人，竟敢擅闯我西凉之地！",
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
					{action = DialogActionType.FinishTask, param = {taskID = 1304}},
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
		txt = "没想到这个传送阵也是假的，就剩最后西凉的入口，那肯定就是真的入口了，容我前去查看。",
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
		txt = "师父，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1310}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1494}},
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
		txt = "师父，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1312}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1495}},
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
		txt = "师父，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1314}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1496}},
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
		txt = "师父，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1316}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1497}},
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
		txt = "师父，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1318}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1498}},
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
		txt = "师父，如今魔龙宫入口被魔将飞廉封印，需解除其四处封印才能开启真正的入口。这有何解决办法么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1320}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1499}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1339}},
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
		txt = "雪融木给你了！我再去玩一会，等一下就回天山，你不要跟清虚祖师说啊！",
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
		txt = "真是个调皮的孩子。现在雪融木也到手了，速前去长安找知天命询问最后一个材料天河朱砂吧！",
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
					{action = DialogActionType.FinishTask, param = {taskID = 1326}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1327}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1328}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1329}},
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
		txt = "站住！此处乃是禁地，擅闯者杀无赦！",
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
		txt = "站住，此处有吾镇守，谁也不许擅入！",
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
					{action = DialogActionType.FinishTask, param = {taskID = 1334}},
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
		txt = "此飞廉已被吾等诛杀，吾等速前往寻找董卓，救出陛下。",
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
		txt = "董卓！我总算找到你了！没想你竟敢逆天而行，吸收陛下的真龙之气修炼魔功，还不快快住手！",
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
		txt = "董卓已被诛杀，可陛下昏迷不醒，你且先去找寻卢植大人禀报情况，我随后就将陛下送回皇宫。",
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
		txt = "卢植大人，我与吕将军已将董卓诛杀，救回陛下。，但发现陛下一直昏迷不醒，这可如何是好。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
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
					{action = DialogActionType.FinishTask, param = {taskID = 1336}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1401}},
					},
			}
		},
	},
[1494] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1311}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
			},
			}
		},
	},
[1495] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1313}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
			},
			}
		},
	},
[1496] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1315}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
			},
			}
		},
	},
[1497] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1317}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
			},
			}
		},
	},
[1498] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1319}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
			},
			}
		},
	},
[1499] = 
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
					{action = DialogActionType.FinishTask, param = {taskID = 1321}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1322}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1338}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1401}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1402}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1403}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1404}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1405}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1406}},
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
		txt = "我与曹将军乃旧识，你休要阻拦！",
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1407}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1408}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1409}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1410}},
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
		txt = "那今天我就先杀你，再杀张闿！",
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
					{action = DialogActionType.CloseDialog, param ={}},
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
		txt = "既然张闿已死，我大仇已报，英雄可转告陶谦，曹某这便下令退兵。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1424}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1412}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1412}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1413}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1414}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1415}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1426}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1416}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1417}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1418}},
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
		txt = "妖道！前几天你可曾抢过一青玄之气？识相的就马上把他还回来，否则休怪我无情了！",
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
					{action = DialogActionType.CloseDialog, param ={}},
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
					{action = DialogActionType.CloseDialog, param ={}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1421}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1422}},
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
		txt = "左道长，真龙之气已得，还请你前往洛阳，拯救陛下！",
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1427}},
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
					{action = DialogActionType.CloseDialog, param ={}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1425}},
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
					{action = DialogActionType.CloseDialog, param ={}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1427}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1501}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1501}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1502}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1502}},
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
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1506}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1506}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1507}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1508}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1509}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1511}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1513}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1514}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1520}},
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
					{action = DialogActionType.Goto, param = {dialogID = 1601}},
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
					{action = DialogActionType.FinishTask, param = {taskID = 1516}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1517}},
			},
			}
		},
	},
[1601] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "如今玉玺已被袁术夺去，我这便前往将玉玺夺回！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1524}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1601}},
			},
			}
		},
	},
[1602] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21103,
		soundID = nil,
		txt = "站住！陈留如今已被我军围得水泄不通，任何人等休想进入！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1603}},
					},
			}
		},
	},
[1603] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "李丰何在？快叫他出来见我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 451,mapID = 409}},
				},
			}
		},
	},
[1604] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21104,
		soundID = nil,
		txt = "李丰大人不见外人，擅闯军营者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1605}},
					},
			}
		},
	},
[1605] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "既然不肯让开，那就受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 452,mapID = 409}},
				},
			}
		},
	},
[1606] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21105,
		soundID = nil,
		txt = "来者何人，前方乃是我军重地，岂敢随意乱闯！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1607}},
					},
			}
		},
	},
[1607] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "速速交代，袁术是否就在此大营中，可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 453,mapID = 409}},
				},
			}
		},
	},
[1608] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，袁术今何在！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1609}},
					},
			}
		},
	},
[1609] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21106,
		soundID = nil,
		txt = "英雄饶命！我这就告知你袁术身在何处！如今袁术就深藏在军营深处，你可前往找寻袁术！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1601}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1602}},
			},
			}
		},
	},
[1610] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21109,
		soundID = nil,
		txt = "你擅闯我陈留军阵，罪不容诛！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1611}},
					},
			}
		},
	},
[1611] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术何在？快叫他出来见我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 454,mapID = 409}},
				},
			}
		},
	},
[1612] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21110,
		soundID = nil,
		txt = "单枪匹马也敢闯我大军，真是找死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1613}},
					},
			}
		},
	},
[1613] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "不必多言，还是手底下见真章！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 455,mapID = 409}},
				},
			}
		},
	},
[1614] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术，玉玺是否在你手里，赶快交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1615}},
					},
			}
		},
	},
[1615] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21111,
		soundID = nil,
		txt = "玉玺就在我手里，但你今天是无法拿回去的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 456,mapID = 409}},
				},
			}
		},
	},
[1616] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "如今袁术已经逃回大本营，不知该如何是好，还是回去问问师祖元始天尊有何解决办法！",
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
[1617] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "元始祖师，传国玉玺已落入袁术手中，被其携带逃回南方老巢寿春，一时无法将其夺回，还望祖师有何解决办法。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1618}},
					},
			}
		},
	},
[1618] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "袁术背后有截教撑腰，得到玉玺后很快就会造反，图谋汉室天下，你可下界找到卢植了解实情助汉室朝廷对付袁术，阻止截教图谋。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1603}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1604}},
			},
			}
		},
	},
[1619] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "袁术已经称帝，举兵威胁洛阳，其先锋大将张勋率先锋部队兵临虎牢关，威逼洛阳，汉室军队羸弱，无法抵挡，还望英雄相助！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1620}},
					},
			}
		},
	},
[1620] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人休慌，我此番正是奉元始师尊之命前来相助，我这便前去剿灭张勋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1604}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1605}},
			},
			}
		},
	},
[1621] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21114,
		soundID = nil,
		txt = "来者何人？竟敢肆闯我虎牢关重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1622}},
					},
			}
		},
	},
[1622] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休要阻挡我，速速交代张勋身在何处，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 457,mapID = 109}},
				},
			}
		},
	},
[1623] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21115,
		soundID = nil,
		txt = "来人止步，你是何人，竟敢擅闯我军大营，还不速速投降！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1624}},
					},
			}
		},
	},
[1624] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "口气不小，那就看你是否有这个实力！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 458,mapID = 109}},
				},
			}
		},
	},
[1625] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21116,
		soundID = nil,
		txt = "吾乃先锋张勋副将杨弘，尔乃何人？竟如此不知好歹！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1626}},
					},
			}
		},
	},
[1626] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "杨弘小斯，快点说出张勋下路，不然休怪我手下无情！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 459,mapID = 109}},
				},
			}
		},
	},
[1627] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "已将杨弘诛杀，我这便继续找寻张勋下落！",
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
[1628] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21119,
		soundID = nil,
		txt = "站住！张勋将军没空见你这些闲杂人等，还不速速离开！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1629}},
					},
			}
		},
	},
[1629] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "速速让开，今日我必将张勋诛杀！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 460,mapID = 109}},
				},
			}
		},
	},
[1630] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21120,
		soundID = nil,
		txt = "有本将在此，岂容你等惊扰张勋将军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1631}},
					},
			}
		},
	},
[1631] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "不识抬举，那就让你知道厉害。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 461,mapID = 109}},
				},
			}
		},
	},
[1632] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21121,
		soundID = nil,
		txt = "尔等闯我军营杀我将士，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1633}},
					},
			}
		},
	},
[1633] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张勋你助纣为虐，明年的今天就是你的祭日！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 462,mapID = 109}},
				},
			}
		},
	},
[1634] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，张勋已被我诛杀，袁术先锋部队已被击溃，虎牢关已转危为安！请指示接下如何行动。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1635}},
					},
			}
		},
	},
[1635] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "少侠果然了得，击退了先锋部队，袁术大军必然会再卷土重来，如今依靠朝廷军队非袁术对手，需要另外寻找援兵，听闻曹操素来不喜袁术，其又与少侠是旧识，还望少侠能请动曹操共抗袁术，如今曹操就驻扎在汝南处，你可前去汝南",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1620}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1607}},
			},
			}
		},
	},
[1636] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，我奉卢植大人之命，特前来寻求援助，如今袁术抢走玉玺，妄图称帝，直逼洛阳，还望将军能帮助朝廷共抗袁术！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1637}},
					},
			}
		},
	},
[1637] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21133,
		soundID = nil,
		txt = "袁术逆天而行，人人得而诛之，曹某亦想马上举兵对付袁术，但如今曹某受到黄巾残军刘辟的威胁，派遣将领曹仁前往讨伐，希望少侠可以相助曹仁除掉刘辟，这样我就可以安心前往对付袁术。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1607}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1608}},
			},
			}
		},
	},
[1638] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹仁将军，我奉你家主公曹操之命，前来助你剿灭黄巾残军刘辟！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1639}},
					},
			}
		},
	},
[1639] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21122,
		soundID = nil,
		txt = "英雄来得正是时候，如今那刘辟正派遣他手下副将龚都前来叫阵，我们这便往阵前，诛杀龚都，再会刘辟。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1608}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1609}},
			},
			}
		},
	},
[1640] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21125,
		soundID = nil,
		txt = "来着何人！胆敢擅闯汝南大营。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1641}},
					},
			}
		},
	},
[1641] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "龚都何在？速叫他出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 463,mapID = 410}},
				},
			}
		},
	},
[1642] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21126,
		soundID = nil,
		txt = "本将奉龚都将军之命，特前来将擅闯之人击杀！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1643}},
					},
			}
		},
	},
[1643] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "口出狂言，就让我看看你是否有这个本事！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 464,mapID = 410}},
				},
			}
		},
	},
[1644] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21127,
		soundID = nil,
		txt = "龚都在此！今日便取尔等人头，向刘辟大帅请功！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1645}},
					},
			}
		},
	},
[1645] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "正要找刘辟算账！今日便来见个高低！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 465,mapID = 410}},
				},
			}
		},
	},
[1646] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21122,
		soundID = nil,
		txt = "龚都已除，那刘辟就在前方，我们这便前往将其诛杀！",
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
[1647] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21130,
		soundID = nil,
		txt = "站住，此地有刘辟将军镇守，谁也不许擅入！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1648}},
					},
			}
		},
	},
[1648] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我今日要找的正是刘辟，还不速速让开！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 466,mapID = 410}},
				},
			}
		},
	},
[1649] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21131,
		soundID = nil,
		txt = "尔等擅闯军营，吾奉刘辟将军之命，前来将尔等诛杀！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1650}},
					},
			}
		},
	},
[1650] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "来的正好，我正要找刘辟算账，先拿你开刀！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 467,mapID = 410}},
				},
			}
		},
	},
[1651] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21132,
		soundID = nil,
		txt = "刘辟在此！尔等闯我大营，杀我副帅，实在可恨，定要将尔等碎尸万段！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1652}},
					},
			}
		},
	},
[1652] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "刘辟小厮，你在此为祸作乱，今日死期以致！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 468,mapID = 410}},
				},
			}
		},
	},
[1653] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21122,
		soundID = nil,
		txt = "刘辟已伏诛，汝南威胁已清除，我家主公曹操也会按照约定出兵讨伐袁术，少侠你且返回洛阳将消息告知卢植处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1610}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1611}},
			},
			}
		},
	},
[1654] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢植大人，曹操已经答应出兵，共伐袁术。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1655}},
					},
			}
		},
	},
[1655] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "吾刚得到消息，曹操率兵讨伐袁术，不料征讨失利，被和袁术勾结的张绣围困在宛城，请少侠速速增援！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1611}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1612}},
			},
			}
		},
	},
[1656] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21136,
		soundID = nil,
		txt = "何人敢擅闯我宛城军营！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1657}},
					},
			}
		},
	},
[1657] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "老实交代，你们将曹操关押于何处？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 469,mapID = 122}},
				},
			}
		},
	},
[1658] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21137,
		soundID = nil,
		txt = "敢擅闯本将镇守的大营，真是活腻了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1659}},
					},
			}
		},
	},
[1659] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "区区小卒，休得张狂！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 470,mapID = 122}},
				},
			}
		},
	},
[1660] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21138,
		soundID = nil,
		txt = "想从本将军手中救走曹操，痴心妄想！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1661}},
					},
			}
		},
	},
[1661] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，手底下见真章吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 471,mapID = 122}},
				},
			}
		},
	},
[1662] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹大人，吾等再次相见，没想到竟然是在这围困之地。为何落到这般？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1663}},
					},
			}
		},
	},
[1663] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21133,
		soundID = nil,
		txt = "谢谢少侠相救，若不是少侠，曹某很可能就葬身于此地，那张绣和袁术已经勾结，曹某中了张绣的诈降之计，亲卫大将典韦为了保护我被困，希望少侠前去将典韦救出。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1612}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1613}},
			},
			}
		},
	},
[1664] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21139,
		soundID = nil,
		txt = "何人敢在此撒野！还不速速投降！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1665}},
					},
			}
		},
	},
[1665] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "典韦将军如今身在何处，还不速速道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 472,mapID = 122}},
				},
			}
		},
	},
[1666] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21140,
		soundID = nil,
		txt = "想从本将军手中救走典韦，痴心妄想！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1667}},
					},
			}
		},
	},
[1667] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快快交代，典韦将军在何处，可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 473,mapID = 122}},
				},
			}
		},
	},
[1668] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21141,
		soundID = nil,
		txt = "吾乃张绣麾下大将韩猛是也！你想救那典韦已经晚了，典韦已经被我们杀了，哈哈！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1669}},
					},
			}
		},
	},
[1669] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "贼子如此猖狂！那就要你来偿命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 474,mapID = 122}},
				},
			}
		},
	},
[1670] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "没想到典韦将军为护主牺牲了自己！典韦将军放心，我这便将宛城将领胡车儿诛杀，祭奠你的在天之灵！",
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
[1671] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21144,
		soundID = nil,
		txt = "你们是什么人，可知道这里是谁的地盘！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1672}},
					},
			}
		},
	},
[1672] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我今日便是来剿灭你们这些乱贼余孽的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 475,mapID = 122}},
				},
			}
		},
	},
[1673] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21145,
		soundID = nil,
		txt = "杀了你们，胡将军定会重重有赏！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1674}},
					},
			}
		},
	},
[1674] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "尔等鼠辈焉能挡我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 476,mapID = 122}},
				},
			}
		},
	},
[1675] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21146,
		soundID = nil,
		txt = "尔等连杀吾军营军候，究意欲何为！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1676}},
					},
			}
		},
	},
[1676] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我今日特来此取你性命，替典韦将军报仇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 477,mapID = 122}},
				},
			}
		},
	},
[1677] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹操大人，吾已击杀胡车儿，替典韦报仇并解除了围困。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1678}},
					},
			}
		},
	},
[1678] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21133,
		soundID = nil,
		txt = "如今宛城算是暂时安全，但张绣依然受袁术操控，盘踞宛城城池，有他在，曹某便无法安心难下对付袁术，还望少侠进入宛城城池将张绣及其手下部队剿灭！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1615}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1616}},
			},
			}
		},
	},
[1679] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21149,
		soundID = nil,
		txt = "来者何人，竟敢擅闯宛城重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1680}},
					},
			}
		},
	},
[1680] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张绣何在！叫他出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 478,mapID = 411}},
				},
			}
		},
	},
[1681] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21150,
		soundID = nil,
		txt = "你竟然闯到了这里，那就别想活着回去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1682}},
					},
			}
		},
	},
[1682] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休说大话，刀枪下见真章吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 479,mapID = 411}},
				},
			}
		},
	},
[1683] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21151,
		soundID = nil,
		txt = "吾乃张绣麾下军师贾诩是也！你是何人，敢擅闯我军营？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1684}},
					},
			}
		},
	},
[1684] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "贾诩，你主子张绣躲哪里去了，还不速速招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 480,mapID = 411}},
				},
			}
		},
	},
[1685] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，张绣现如今在何处？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1686}},
					},
			}
		},
	},
[1686] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21152,
		soundID = nil,
		txt = "张绣和袁术勾结，使曹操中了张绣的诈降之计，曹操身边亲卫大将典韦战死，张绣害怕曹操报仇，已躲藏在宛城城池深处了。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1616}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1617}},
			},
			}
		},
	},
[1687] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21155,
		soundID = nil,
		txt = "竟敢独闯此地，看我拿下你去向张将军请功！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1688}},
					},
			}
		},
	},
[1688] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你若有这个本事，尽管来试试！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 481,mapID = 411}},
				},
			}
		},
	},
[1689] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21156,
		soundID = nil,
		txt = "张将军有令，擅闯我城池者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1690}},
					},
			}
		},
	},
[1690] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休说废话，放马过来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 482,mapID = 411}},
				},
			}
		},
	},
[1691] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21157,
		soundID = nil,
		txt = "张绣在此！你是何人，为何苦苦相逼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1692}},
					},
			}
		},
	},
[1692] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张绣，你勾结袁术，背叛朝廷，逆天而行，今日我特来擒你问罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 483,mapID = 411}},
				},
			}
		},
	},
[1693] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "还不速度道来，若有半句假话，定叫你碎尸万段！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1694}},
					},
			}
		},
	},
[1694] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21158,
		soundID = nil,
		txt = "一名叫罗宣的截教高人奉袁术之令监视我，要不小人也不敢如此造次，如今罗宣就藏身于附近火龙窟中，若英雄能斩杀他，张某愿意投降，归顺朝廷。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1617}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1618}},
			},
			}
		},
	},
[1695] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21161,
		soundID = nil,
		txt = "你是何人，入我火龙窟重地，报上名来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1696}},
					},
			}
		},
	},
[1696] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾乃前来灭了罗宣那逆贼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 484,mapID = 412}},
				},
			}
		},
	},
[1697] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21162,
		soundID = nil,
		txt = "竟敢擅闯罗老大的地盘，看来是活腻了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1698}},
					},
			}
		},
	},
[1698] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我要见罗宣，速速让开，我便饶你一条小命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 485,mapID = 412}},
				},
			}
		},
	},
[1699] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21163,
		soundID = nil,
		txt = "不知死活的小子，居然来送死，看你还怎么跑！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1700}},
					},
			}
		},
	},
[1700] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就看你有没有这个能耐了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 486,mapID = 412}},
				},
			}
		},
	},
[1584] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，那张绣已经投降，其背后的截教妖人罗宣也已伏诛。望曹将军继续挥师南下，讨伐袁术！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1585}},
					},
			}
		},
	},
[1585] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21133,
		soundID = nil,
		txt = "如此甚好，吾即刻重整兵力，讨伐袁术！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1701}},
					},
			}
		},
	},
[1701] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21233,
		soundID = nil,
		txt = "吾已派遣大将曹仁前往寿春讨伐袁术，英雄可速往寿春相助于他，共伐袁术！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1619}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1701}},
			},
			}
		},
	},
[1702] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹仁将军，我奉你家主公曹操之令，特前来助你讨伐袁术。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1701}},
				    {action = DialogActionType.Goto, param = {dialogID = 1703}},
			},
			}
		},
	},
[1703] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21202,
		soundID = nil,
		txt = "袁术势大，我孤军难以对付，听闻驻守樊城的江东诸侯孙坚素来忠义，英雄若能说服他联手讨伐袁术，则袁术必败无疑！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.RecetiveTask, param = {taskID = 1702}},
					},
			}
		},
	},
[1704] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21203,
		soundID = nil,
		txt = "站住！樊城如今已是我家黄祖将军的地盘，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1705}},
					},
			}
		},
	},
[1705] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "樊城乃是孙坚驻守之地，你们是何人，敢如此猖狂！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 501,mapID = 413}},
				},
			}
		},
	},
[1706] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21208,
		soundID = nil,
		txt = "小子，你是什么人，敢擅闯我樊城之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1707}},
					},
			}
		},
	},
[1707] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙坚将军如今在何处！还不快快招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 502,mapID = 413}},
				},
			}
		},
	},
[1708] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21209,
		soundID = nil,
		txt = "站住！我乃江夏太守黄祖手下大将陈就是也，奉黄祖将军令，攻占了樊城，你是何人，敢在此放肆？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1709}},
					},
			}
		},
	},
[1709] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，孙坚将军在哪里？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 503,mapID = 413}},
				},
			}
		},
	},
[1710] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21210,
		soundID = nil,
		txt = "多谢英雄相救！江夏太守黄祖和袁术勾结，偷袭了樊城，我家主公孙坚如今落入了黄祖埋伏，还望英雄助我前往相救！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1702}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1703}},
			},
			}
		},
	},
[1711] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21211,
		soundID = nil,
		txt = "站住！本将奉命把守寿春，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1712}},
					},
			}
		},
	},
[1712] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙坚将军如今在何处？速速道来，可饶你不死。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 504,mapID = 413}},
				},
			}
		},
	},
[1713] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21216,
		soundID = nil,
		txt = "有本将把守此地，你们休想救走孙坚！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1714}},
					},
			}
		},
	},
[1714] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来孙坚将军就在前方不远处了，先灭了你，再救孙坚将军！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 505,mapID = 413}},
				},
			}
		},
	},
[1715] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21217,
		soundID = nil,
		txt = "吾乃黄祖之子黄射是也！奉吾父之命在此伏击孙坚，如今孙坚已死，你们既然来了，那就一并杀了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1716}},
					},
			}
		},
	},
[1716] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "糟糕！看来孙坚凶多吉少。狗贼，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 506,mapID = 413}},
				},
			}
		},
	},
[1717] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙坚将军果然不幸遇难了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1718}},
					},
			}
		},
	},
[1718] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21210,
		soundID = nil,
		txt = "黄祖勾结袁术谋害我家主公，程某定要报仇！程某先护送主公遗体回去安葬，我家小主公孙策驻守寿春，只怕袁术也要对其下手，还望英雄火速前往报信！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1703}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1704}},
			},
			}
		},
	},
[1719] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21218,
		soundID = nil,
		txt = "站住！什么人，来寿春有何图谋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1720}},
					},
			}
		},
	},
[1720] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "寿春乃是孙策将军驻守之地，你们又是什么人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 507,mapID = 124}},
				},
			}
		},
	},
[1721] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21223,
		soundID = nil,
		txt = "寿春如今乃是袁术大人地盘，你还不速速退去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1722}},
					},
			}
		},
	},
[1722] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙策在哪，若不速速道来，定取你性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 508,mapID = 124}},
				},
			}
		},
	},
[1723] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21224,
		soundID = nil,
		txt = "吾乃袁术手下大将阎象是也！你是何人，敢独身来寿春放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1724}},
					},
			}
		},
	},
[1724] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙策是不是在你手中，还不快快放人，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 509,mapID = 124}},
				},
			}
		},
	},
[1725] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，孙策将军如今在哪？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1726}},
					},
			}
		},
	},
[1726] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21279,
		soundID = nil,
		txt = "孙策被我们偷袭抓住，如今已经被押往寿春监牢关押，英雄可往寿春监牢救他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1704}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1705}},
			},
			}
		},
	},
[1727] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21225,
		soundID = nil,
		txt = "站住！什么人，敢擅闯我寿春重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1728}},
					},
			}
		},
	},
[1728] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙策是不是关押在此，老实交代，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 510,mapID = 124}},
				},
			}
		},
	},
[1729] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21226,
		soundID = nil,
		txt = "此乃关押要犯的重地，什么人敢来此放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1730}},
					},
			}
		},
	},
[1730] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "若带我去见孙策将军，尚可饶你一命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 511,mapID = 124}},
				},
			}
		},
	},
[1731] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21227,
		soundID = nil,
		txt = "大将袁胤在此！奉吾主袁术大人令，敢救孙策者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1732}},
					},
			}
		},
	},
[1732] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，若不放了孙策将军，今日就要你葬身于此！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 512,mapID = 124}},
				},
			}
		},
	},
[1733] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙策将军，我受程普将军之托，特前来救你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1734}},
					},
			}
		},
	},
[1734] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21228,
		soundID = nil,
		txt = "袁术已经派人前往九江对付我的结拜兄弟周瑜，还望英雄和我一道火速前往九江救他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1705}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1706}},
			},
			}
		},
	},
[1735] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21229,
		soundID = nil,
		txt = "站住！你们是什么人，来九江做什么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1736}},
					},
			}
		},
	},
[1736] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "放肆，周瑜可是在此地！？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 513,mapID = 414}},
				},
			}
		},
	},
[1737] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21234,
		soundID = nil,
		txt = "奉袁术大人令，特来此捉拿贼党周瑜，闲杂人等速速回避！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1738}},
					},
			}
		},
	},
[1738] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我们正是来救周瑜大人的，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 514,mapID = 414}},
				},
			}
		},
	},
[1739] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21235,
		soundID = nil,
		txt = "吾乃袁军大将桥蕤是也！你们杀了我这么多弟兄，今日定要你们偿命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1740}},
					},
			}
		},
	},
[1740] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说！周瑜如今在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 515,mapID = 414}},
				},
			}
		},
	},
[1741] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，周瑜大人如今在哪？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1742}},
					},
			}
		},
	},
[1742] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21280,
		soundID = nil,
		txt = "周瑜已经被我们抓住，如今已被关押在九江，英雄可速去救他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1706}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1707}},
			},
			}
		},
	},
[1743] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21236,
		soundID = nil,
		txt = "站住！你们是什么人，擅闯九江有何图谋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1744}},
					},
			}
		},
	},
[1744] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "周瑜是不是关押在这里？老实招来，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 516,mapID = 414}},
				},
			}
		},
	},
[1745] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21237,
		soundID = nil,
		txt = "站住！你们想救周瑜，怕是自身难保！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1746}},
					},
			}
		},
	},
[1746] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "若不速速放了周瑜，定取你性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 517,mapID = 414}},
				},
			}
		},
	},
[1747] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21238,
		soundID = nil,
		txt = "本将奉袁术大人令，在此看押周瑜！任何人都休想救走他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1748}},
					},
			}
		},
	},
[1748] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "若不放了周瑜，今日就是你的死期！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 518,mapID = 414}},
				},
			}
		},
	},
[1749] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "周瑜大人，我奉朝廷之令前来讨伐反贼袁术，还望大人教我破贼之策！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1750}},
					},
			}
		},
	},
[1750] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21239,
		soundID = nil,
		txt = "江夏太守黄祖和袁术勾结，想要对付袁术，必先除掉黄祖，听闻黄祖手下心腹大将张硕正驻守江夏，我们可找他打听黄祖的藏身之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1707}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1708}},
			},
			}
		},
	},
[1751] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21240,
		soundID = nil,
		txt = "什么人，敢擅闯我江夏要地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1752}},
					},
			}
		},
	},
[1752] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张硕是不是正在江夏？我们要见他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 519,mapID = 120}},
				},
			}
		},
	},
[1753] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21245,
		soundID = nil,
		txt = "江夏乃张硕将军驻守之地，什么人敢在此放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1754}},
					},
			}
		},
	},
[1754] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快叫张硕出来见我们！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 520,mapID = 120}},
				},
			}
		},
	},
[1755] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21246,
		soundID = nil,
		txt = "吾乃黄祖账下大将张硕是也！你们闯我江夏驻地，有何图谋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1756}},
					},
			}
		},
	},
[1756] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "张硕，你主子黄祖如今躲到哪里去了，从实招来，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 521,mapID = 120}},
				},
			}
		},
	},
[1757] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，那黄祖如今躲在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1758}},
					},
			}
		},
	},
[1758] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21281,
		soundID = nil,
		txt = "黄祖如今就在这江夏帅营中，你们只管去找他算账，一切和我无关！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1708}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1709}},
			},
			}
		},
	},
[1759] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21247,
		soundID = nil,
		txt = "站住！此乃黄祖大人的帅营重地，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1760}},
					},
			}
		},
	},
[1760] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快叫黄祖滚出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 522,mapID = 120}},
				},
			}
		},
	},
[1761] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21252,
		soundID = nil,
		txt = "奉黄祖大人将令，特前来擒拿尔等问罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1762}},
					},
			}
		},
	},
[1762] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今日定要取黄祖贼子人头，挡我者皆死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 523,mapID = 120}},
				},
			}
		},
	},
[1763] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21253,
		soundID = nil,
		txt = "黄祖在此！何人敢在本将帅营放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1764}},
					},
			}
		},
	},
[1764] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "黄祖！你竟敢和袁术勾结，谋害孙坚，拿命来吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 524,mapID = 120}},
				},
			}
		},
	},
[1765] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21239,
		soundID = nil,
		txt = "黄祖一死，袁术外援已去。袁术如今盘踞于寿春宫中，其麾下大将纪灵统领大军驻守寿春宫外大营把守，只要击杀纪灵，我们便可闯入寿春宫除掉袁术！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1709}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1710}},
			},
			}
		},
	},
[1766] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21254,
		soundID = nil,
		txt = "站住！此乃纪灵大帅镇守的寿春大营，何人敢擅闯！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1767}},
					},
			}
		},
	},
[1767] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我们今日来此，正是要取纪灵人头！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 525,mapID = 415}},
				},
			}
		},
	},
[1768] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21255,
		soundID = nil,
		txt = "站住！本将奉纪灵大帅之令把守此地，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1769}},
					},
			}
		},
	},
[1769] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "来得正好，我们正要找纪灵算账！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 526,mapID = 415}},
				},
			}
		},
	},
[1770] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21260,
		soundID = nil,
		txt = "吾乃袁军副帅荀正是也！你们三人就敢来我大营放肆，真是活腻了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1771}},
					},
			}
		},
	},
[1771] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "纪灵躲到哪里去了？速速招来，可饶你不死。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 527,mapID = 415}},
				},
			}
		},
	},
[1772] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21239,
		soundID = nil,
		txt = "斩杀了副帅荀正，袁军必然已乱阵脚，那纪灵定然就在前方，我们速速闯阵，斩杀纪灵！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1710}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1711}},
			},
			}
		},
	},
[1773] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21261,
		soundID = nil,
		txt = "何人敢擅闯帅营？活得不耐烦了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1774}},
					},
			}
		},
	},
[1774] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快叫纪灵出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 528,mapID = 415}},
				},
			}
		},
	},
[1775] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21262,
		soundID = nil,
		txt = "站住！本将奉纪灵大帅将令，前来擒拿尔等问罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1776}},
					},
			}
		},
	},
[1776] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "纪灵自己躲到哪里去了，只会叫你们这些小兵来送死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 529,mapID = 415}},
				},
			}
		},
	},
[1777] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21263,
		soundID = nil,
		txt = "袁军大帅纪灵在此！吾奉主公袁术之令把守寿春宫，岂容尔等小贼放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1778}},
					},
			}
		},
	},
[1778] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "纪灵，你助纣为虐，死期已至，纳命来吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 530,mapID = 415}},
				},
			}
		},
	},
[1779] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21239,
		soundID = nil,
		txt = "纪灵已死，寿春宫外的袁军已溃！我们这便速速进入寿春，找那袁术算账！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1711}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1712}},
			},
			}
		},
	},
[1780] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21264,
		soundID = nil,
		txt = "站住！何人敢擅闯寿春禁地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1781}},
					},
			}
		},
	},
[1781] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术那逆贼是不是正躲在宫中？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 531,mapID = 124}},
				},
			}
		},
	},
[1782] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21265,
		soundID = nil,
		txt = "站住，寿春乃吾主宫禁要地，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1783}},
					},
			}
		},
	},
[1783] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术死到临头，还躲在这里做他的帝皇美梦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 532,mapID = 124}},
				},
			}
		},
	},
[1784] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21266,
		soundID = nil,
		txt = "吾乃寿春统领刘勋是也！有本将在此，岂容你们放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1785}},
					},
			}
		},
	},
[1785] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "来得正好，袁术躲到哪里去了？老实招来，可饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 533,mapID = 124}},
				},
			}
		},
	},
[1786] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，袁术躲到哪里去了？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1787}},
					},
			}
		},
	},
[1787] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21282,
		soundID = nil,
		txt = "吾主袁术如今不在宫中。有一高人王魔自称截教金仙，投靠吾主，于寿春宫外摆下一逆龙大阵，号称以此阵逆转神州龙脉，助吾主修成真龙天子之身，如今吾主便在那阵中修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1712}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1713}},
			},
			}
		},
	},
[1788] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21267,
		soundID = nil,
		txt = "站住！此乃吾主修炼禁地，你们是什么人，竟敢闯入此地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1789}},
					},
			}
		},
	},
[1789] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快叫袁术出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 534,mapID = 416}},
				},
			}
		},
	},
[1790] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21268,
		soundID = nil,
		txt = "本将奉吾主袁术之令，在此护法，敢惊扰吾主修炼者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1791}},
					},
			}
		},
	},
[1791] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术恶贯满盈，今日死期已至！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 535,mapID = 416}},
				},
			}
		},
	},
[1792] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21273,
		soundID = nil,
		txt = "吾乃截教金仙王魔是也！尔等蝼蚁之辈，敢闯入我逆龙阵内，本座岂容尔等活着出去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1793}},
					},
			}
		},
	},
[1793] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "王魔，你枉为截教高人，却在此助纣为虐，今日我便替天行道！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 536,mapID = 416}},
				},
			}
		},
	},
[1794] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "好难缠的王魔，恐怕袁术还在逆龙阵深处，须得速速前去。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1713}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1714}},
			},
			}
		},
	},
[1795] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21274,
		soundID = nil,
		txt = "什么人，竟敢擅闯逆龙大阵，惊扰吾主修炼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1796}},
					},
			}
		},
	},
[1796] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术躲到哪里去了，还不叫他出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 537,mapID = 416}},
				},
			}
		},
	},
[1797] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21275,
		soundID = nil,
		txt = "本将奉主公袁术之令，在此护阵，擅闯者死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1798}},
					},
			}
		},
	},
[1798] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "那就先杀了你，再取袁术性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 538,mapID = 416}},
				},
			}
		},
	},
[1799] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21278,
		soundID = nil,
		txt = "袁术在此！小子，别以为袁某还像上次那么好对付，我已修成魔功，你们都不是我的对手！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1800}},
					},
			}
		},
	},
[1800] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁术，传国玉玺在哪？速速交出来，可留你一个全尸！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 539,mapID = 416}},
				},
			}
		},
	},
[1801] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21228,
		soundID = nil,
		txt = "不料袁术临死前竟把传国玉玺送给了他兄长袁绍，那袁绍乃北方霸主，野心勃勃，玉玺落入其手，可是遗祸无穷！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1802}},
					},
			}
		},
	},
[1802] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我这便返回洛阳，把此事回禀于卢植大人，再从长计议。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1714}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1801}},
			},
			}
		},
	},
[1901] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢植大人，袁术已被我诛杀，但他临死前已把传国玉玺送给了他兄长袁绍！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1902}},
					},
			}
		},
	},
[1902] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "袁绍当年乃讨伐董卓联盟盟主，老夫实不信他会背叛朝廷，贪图传国玉玺。驻守河北的审配乃袁绍亲信，你可前去打探此事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1801}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1802}},
			},
			}
		},
	},
[1903] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21302,
		soundID = nil,
		txt = "何人擅闯河北军营！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1904}},
					},
			}
		},
	},
[1904] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我有要事要见你们审配将军，还不快快让开！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 601,mapID = 126}},
				},
			}
		},
	},
[1905] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21303,
		soundID = nil,
		txt = "审配将军不见外人，擅闯河北军营者，杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1906}},
					},
			}
		},
	},
[1906] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "审配拒不见我，我更加要去找他问个明白！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 602,mapID = 126}},
				},
			}
		},
	},
[1907] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21304,
		soundID = nil,
		txt = "你闯我军营杀我将士，死期已至！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1908}},
					},
			}
		},
	},
[1908] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "审配，我欲拜访你家主公袁绍，询问传国玉玺之事，你为何躲着不敢见我？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 603,mapID = 126}},
				},
			}
		},
	},
[1909] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，传国玉玺是否在你家主公袁绍手中？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1910}},
					},
			}
		},
	},
[1910] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21304,
		soundID = nil,
		txt = "英雄饶命，其实我也实不知此事。但我家主公袁绍如今就在邺城，你可亲自去邺城问他。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1802}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1803}},
			},
			}
		},
	},
[1911] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21306,
		soundID = nil,
		txt = "吾乃大将吕旷是也，在此埋伏已久，奉吾主袁绍将军令，今日务必取你项上人头。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1912}},
					},
			}
		},
	},
[1912] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来袁绍果然贪图传国玉玺，竟想遣人将我灭口。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 604,mapID = 418}},
				},
			}
		},
	},
[1913] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，你为何在此处偷袭我，意欲何为！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1914}},
					},
			}
		},
	},
[1914] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21306,
		soundID = nil,
		txt = "英雄饶命，小人也是奉命行事，因袁绍怕传国玉玺之事外泄，特命我来此埋伏杀你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1915}},
					},
			}
		},
	},
[1915] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "看来袁绍果然有不臣之心，我这便返回洛阳与卢植大人商议对策。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1803}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1804}},
			},
			}
		},
	},
[1916] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，我已探得传国玉玺确实已落入袁绍之手，如今他已背叛朝廷！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1917}},
					},
			}
		},
	},
[1917] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "袁绍兵强马壮，非你我单独所能对付。辽东诸侯公孙瓒乃老夫学生，如今正驻守辽东与袁绍交战，你可前往助他打败袁绍，夺回传国玉玺。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1804}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1805}},
			},
			}
		},
	},
[1918] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21308,
		soundID = nil,
		txt = "站住，辽东已是我袁绍大军的地盘，岂能容你擅闯？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1919}},
					},
			}
		},
	},
[1919] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "辽东不是公孙瓒驻守之地么，如今怎落入你们手里？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 605,mapID = 132}},
				},
			}
		},
	},
[1920] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21309,
		soundID = nil,
		txt = "你是何人，敢擅闯我军阵重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1921}},
					},
			}
		},
	},
[1921] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "公孙瓒如今是不是在你们手中？快快道来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 606,mapID = 132}},
				},
			}
		},
	},
[1922] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21310,
		soundID = nil,
		txt = "吾乃大将高翔是也！你擅闯我辽东军阵，罪不容诛！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1923}},
					},
			}
		},
	},
[1923] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "公孙瓒现在何处，还不快快道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 607,mapID = 132}},
				},
			}
		},
	},
[1924] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快点说出公孙瓒的下落，我便饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1925}},
					},
			}
		},
	},
[1925] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21310,
		soundID = nil,
		txt = "英雄饶命！公孙瓒大军溃败后，已经往辽东深处跑走！英雄可去辽东深处找他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1805}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1806}},
			},
			}
		},
	},
[1926] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21315,
		soundID = nil,
		txt = "吾乃大将冯礼是也！你擅闯我军阵，杀我将士，意欲何为？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1927}},
					},
			}
		},
	},
[1927] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "尔等围困的是何人，竟敢如此撒野！还不速速放人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 608,mapID = 132}},
				},
			}
		},
	},
[1928] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21316,
		soundID = nil,
		txt = "多谢英雄相救，我乃公孙瓒部将赵云是也。公孙大人战败后，现如今正被袁绍大军困于易京城，赵某正欲前去相救，英雄可愿与我一同前往。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1929}},
					},
			}
		},
	},
[1929] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "赵将军，我本就奉朝廷之令，特前来助公孙瓒大人对付袁绍，如今赵将军邀请我，哪有不去的道理，我们这便前往救出公孙瓒大人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1806}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1807}},
			},
			}
		},
	},
[1930] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21318,
		soundID = nil,
		txt = "奉郭援将军之令镇守于此，任何人不得接近易京城！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1931}},
					},
			}
		},
	},
[1931] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我等正是为解救公孙瓒而来，还不快快让开！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 609,mapID = 132}},
				},
			}
		},
	},
[1932] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21319,
		soundID = nil,
		txt = "自寻死路！本将便替郭援将军拿下尔等！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1933}},
					},
			}
		},
	},
[1933] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今日定要杀入易京城，救出公孙瓒！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 610,mapID = 132}},
				},
			}
		},
	},
[1934] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21320,
		soundID = nil,
		txt = "本将郭援在此，尔等休想进入易京城！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1935}},
					},
			}
		},
	},
[1935] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今日我定要救出公孙瓒大人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 611,mapID = 132}},
				},
			}
		},
	},
[1936] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21316,
		soundID = nil,
		txt = "糟糕！易京城已被袁军攻陷，只怕公孙大人凶多吉少！我们速进入易京城寻找公孙大人下落！",
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
[1937] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21322,
		soundID = nil,
		txt = "奉吕威璜将军之命清剿公孙瓒余党，尔等还不快快受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1938}},
					},
			}
		},
	},
[1938] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "公孙瓒在何处，你若不交代，休怪我不客气！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 612,mapID = 417}},
				},
			}
		},
	},
[1939] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21323,
		soundID = nil,
		txt = "凭你二人就想救公孙瓒，简直就是找死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1940}},
					},
			}
		},
	},
[1940] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "速速让开，你拦不住我等！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 613,mapID = 417}},
				},
			}
		},
	},
[1941] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21324,
		soundID = nil,
		txt = "公孙瓒余党竟还有你们这两条漏网之鱼，来人啊，给本将拿下！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1942}},
					},
			}
		},
	},
[1942] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吕威璜！老实交代公孙瓒在哪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 614,mapID = 417}},
				},
			}
		},
	},
[1943] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说公孙瓒现在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1944}},
					},
			}
		},
	},
[1944] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21324,
		soundID = nil,
		txt = "这位英雄实不相瞒，易京城被攻陷后，公孙瓒已经身亡，小人只是奉令驻守此城，杀公孙瓒大人的乃是袁绍手下大将文丑，他如今就在易京城深处，英雄可找他算账，与小人无关。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1945}},
					},
			}
		},
	},
[1945] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21316,
		soundID = nil,
		txt = "可恨！还是晚来了一步！英雄请助我杀入易京城深处，诛杀文丑，为公孙瓒大人报仇！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1808}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1809}},
			},
			}
		},
	},
[1946] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21326,
		soundID = nil,
		txt = "何人擅闯易京城内，找死么！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1947}},
					},
			}
		},
	},
[1947] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "少废话，快让文丑出来受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 615,mapID = 417}},
				},
			}
		},
	},
[1948] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21327,
		soundID = nil,
		txt = "竟敢闯入易京城内谋害文丑将军，胆大包天！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1949}},
					},
			}
		},
	},
[1949] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "文丑匹夫，不敢出来对战，却遣了尔等前来送死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 616,mapID = 417}},
				},
			}
		},
	},
[1950] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21328,
		soundID = nil,
		txt = "吾乃文丑将军账下副将牵招是也！有本将在此，尔等休想动文丑将军分毫！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1951}},
					},
			}
		},
	},
[1951] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休得废话，先斩杀了你，再寻文丑算账！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 617,mapID = 417}},
				},
			}
		},
	},
[1952] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21316,
		soundID = nil,
		txt = "牵招已伏诛，文丑定就在前方营中，英雄快随我一同杀进去！",
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
[1957] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21332,
		soundID = nil,
		txt = "文丑在此！就凭你二人也想为公孙瓒报仇？简直痴心妄想！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1958}},
					},
			}
		},
	},
[1958] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "文丑，受死吧！竟敢杀我家大人，今日不是你死便是我亡！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 620,mapID = 417}},
				},
			}
		},
	},
[1959] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "可恨！还是让文丑跑了！赵将军，我奉朝廷之令，前来夺回落入袁绍之手的传国玉玺，不知赵将军能否助我？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1960}},
					},
			}
		},
	},
[1960] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21316,
		soundID = nil,
		txt = "公孙大人生前曾在袁绍手下安插过一个卧底，名为田楷，如今乃河北守将，或许有传国玉玺的线索，我们这便前往寻他打探传国玉玺之事。",
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
[1961] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21334,
		soundID = nil,
		txt = "尔等闯入我河北，意欲何为！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1962}},
					},
			}
		},
	},
[1962] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我们是田楷将军的朋友，特前来寻他有要事相商。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 621,mapID = 126}},
				},
			}
		},
	},
[1963] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21335,
		soundID = nil,
		txt = "听闻你们是奸细田楷的同党，吾奉令特前来擒拿尔等！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1964}},
					},
			}
		},
	},
[1964] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "田楷如今在哪里？老实交待，尚可饶你一命。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 622,mapID = 126}},
				},
			}
		},
	},
[1965] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21336,
		soundID = nil,
		txt = "大将焦触在此！你等伙同田楷图谋不轨，今日拿下你等，必是大功一件！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1966}},
					},
			}
		},
	},
[1966] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "田楷如今是不是在你手中？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 623,mapID = 126}},
				},
			}
		},
	},
[1967] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说！田楷如今在哪？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1968}},
					},
			}
		},
	},
[1968] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21336,
		soundID = nil,
		txt = "不久前田楷卧底身份暴露，如今已被擒获送往邺城关押，由邺城守将邓升看守。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1811}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1812}},
			},
			}
		},
	},
[1969] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21341,
		soundID = nil,
		txt = "吾乃邺城守将，尔等何故闯我壶关？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1970}},
					},
			}
		},
	},
[1970] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "邓升何在，快叫他把田楷交出来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 624,mapID = 418}},
				},
			}
		},
	},
[1971] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21342,
		soundID = nil,
		txt = "奉邓升将军之命特来捉拿尔等，奸贼同党还不受死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1972}},
					},
			}
		},
	},
[1972] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "区区小将也敢阻我？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 625,mapID = 418}},
				},
			}
		},
	},
[1973] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "田将军，我这便过来救你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1974}},
					},
			}
		},
	},
[1974] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21343,
		soundID = nil,
		txt = "正愁找不到田楷的同党，你们今日反倒送上门来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 626,mapID = 418}},
				},
			}
		},
	},
[1975] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "田将军，我奉朝廷之令追查传国玉玺下落，如今我只知此宝极有可能已落入袁绍之手，不知你可有更多线索助我寻回此宝？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1976}},
					},
			}
		},
	},
[1976] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21344,
		soundID = nil,
		txt = "不久前有一妖人杨森自称奉袁术令，携传国玉玺前来投靠袁绍。杨森弟子赤云童子如今正在邺城深处督阵，二位英雄若能擒获此人，定能知晓更多传国玉玺之事。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1812}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1813}},
			},
			}
		},
	},
[1981] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21348,
		soundID = nil,
		txt = "吾乃赤云童子是也，尔等是何人，敢来此地撒野！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1982}},
					},
			}
		},
	},
[1982] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "赤云童子，还不快快交待，你师父杨森携传国玉玺投靠袁绍，有何图谋？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 629,mapID = 418}},
				},
			}
		},
	},
[1983] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，你师父杨森携传国玉玺投靠袁绍，有何图谋？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1984}},
					},
			}
		},
	},
[1984] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21348,
		soundID = nil,
		txt = "吾师实乃截教弟子，那传国玉玺早已被截教魔化，师尊奉命将魔化的传国玉玺献与袁绍，以乱其心智，借袁绍之力夺取汉室江山！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1985}},
					},
			}
		},
	},
[1985] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "赵将军，袁绍手握重兵，如今被截教掌控，定会为祸人间，此事非同小可，我须返回上界向元始祖师禀报此事，后会有期了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1813}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1814}},
			},
			}
		},
	},
[1986] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "元始祖师，截教魔化传国玉玺，借此控制了袁绍，该如何是好？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1987}},
					},
			}
		},
	},
[1987] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20002,
		soundID = nil,
		txt = "截教欲操控袁绍，以和阐教争夺人间道统，必定会再次掀起兵祸，危害人间。你且下界去，助人间朝廷剿灭袁绍，以平此祸。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1814}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1815}},
			},
			}
		},
	},
[1988] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "卢大人，公孙瓒大人如今已兵败身亡，我特前来助你对付袁绍。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1989}},
					},
			}
		},
	},
[1989] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "英雄来得正好，袁绍如今公然起兵攻打朝廷，曹操奉命前往征讨，无奈初战不利，正于濮阳与袁军对峙，请英雄速前往濮阳助曹操对付袁绍大军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1815}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1816}},
			},
			}
		},
	},
[1990] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21350,
		soundID = nil,
		txt = "站住！濮阳城如今已被我袁军围得水泄不通，任何人等休想进入！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1991}},
					},
			}
		},
	},
[1991] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我今日定要闯进濮阳城，休得拦我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 630,mapID = 133}},
				},
			}
		},
	},
[1992] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21351,
		soundID = nil,
		txt = "妄图接近濮阳城者，斩！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1993}},
					},
			}
		},
	},
[1993] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "谁也拦不住我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 631,mapID = 133}},
				},
			}
		},
	},
[1994] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21352,
		soundID = nil,
		txt = "袁营大将陶升在此，想进濮阳城，先吃我一刀！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1995}},
					},
			}
		},
	},
[1995] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "看你能挡我几时！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 632,mapID = 133}},
				},
			}
		},
	},
[1996] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "如今已经诛杀围困濮阳城的袁军，赶紧前去与曹将军的军队会合！",
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
[1997] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "夏侯将军，我奉朝廷之命，前来助你们征讨袁绍大军，不知曹将军现在何处？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 1998}},
					},
			}
		},
	},
[1998] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21353,
		soundID = nil,
		txt = "多谢英雄前来相助，据手下探子来报，我家主公正被袁军围困在白马坡，粮草即将告罄，情况十分危急，还望英雄前往许昌向关将军求助，救我家主公于水火啊。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1817}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1901}},
			},
			}
		},
	},
[2001] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "关将军，如今曹操被困白马坡，我受夏侯渊所托，特来恳请你前往相救，还望将军仗义相救。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2002}},
					},
			}
		},
	},
[2002] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "关某自与大哥刘备失散，承蒙曹操照顾，寄居许昌。如今曹操有难，关某当鼎力相助，不负曹操恩情。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1901}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1902}},
			},
			}
		},
	},
[2003] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21402,
		soundID = nil,
		txt = "此地乃是我军驻扎之地，速速离去，否则定教你有来无回！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2004}},
					},
			}
		},
	},
[2004] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "好大的口气，我们此番前来，便是要闯一闯你这驻扎之地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 651,mapID = 422}},
				},
			}
		},
	},
[2005] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21403,
		soundID = nil,
		txt = "何人擅闯白马坡，杀我兵士，还不束手就擒！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2006}},
					},
			}
		},
	},
[2006] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快点让开道路，绕你们不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 652,mapID = 422}},
				},
			}
		},
	},
[2007] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "关某此番前来，只因曹操对我有恩，让开道路，我放你离去。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2008}},
					},
			}
		},
	},
[2008] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21404,
		soundID = nil,
		txt = "久闻关羽武功盖世，今日就让我来领教一番！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 653,mapID = 422}},
				},
			}
		},
	},
[2009] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你是何人？可知道曹操下落？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2010}},
					},
			}
		},
	},
[2010] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21409,
		soundID = nil,
		txt = "吾乃主公部下曹洪，主公正被袁军围困在白马城，就在前方，还望关将军和少侠速去支援。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1902}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1903}},
			},
			}
		},
	},
[2011] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21410,
		soundID = nil,
		txt = "关羽！你杀我军将士，闯我军兵阵，是何用意！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2012}},
					},
			}
		},
	},
[2012] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "曹操昔日对我有恩，关羽受人之托，前来相救。还不速速鸣金收兵！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 654,mapID = 422}},
				},
			}
		},
	},
[2013] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我们已经突破白马城外袁军，这便去寻曹操。",
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
[2014] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21411,
		soundID = nil,
		txt = "曹贼同党，速速束手就擒！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2015}},
					},
			}
		},
	},
[2015] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "让开道路，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 655,mapID = 422}},
				},
			}
		},
	},
[2016] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "尔等切莫拦我道路，否则杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2017}},
					},
			}
		},
	},
[2017] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21412,
		soundID = nil,
		txt = "吾乃此处守卫，速速投降！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 656,mapID = 422}},
				},
			}
		},
	},
[2018] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "何人敢拦我等道路，报上名来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2019}},
					},
			}
		},
	},
[2019] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21413,
		soundID = nil,
		txt = "吾乃镇守此地的白马将军，尔等杀了我军多名将士，我这就斩杀你们来祭奠我的兄弟们！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 657,mapID = 422}},
				},
			}
		},
	},
[2020] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "前往障碍已经扫除，我们快去找寻曹操吧。",
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
[2021] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21414,
		soundID = nil,
		txt = "多谢关将军前来搭救，曹某感激不尽，袁绍军中有一猛将名为颜良，精通兵法骁勇善战，正是他率兵将我围困在此处，此人不除，我们恐怕无法突围。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2022}},
					},
			}
		},
	},
[2022] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "关将军，我们先行前去铲除这个颜良，为曹将军开辟突围道路！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1905}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1906}},
			},
			}
		},
	},
[2023] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21415,
		soundID = nil,
		txt = "关羽休走！吾乃颜良将军副将张南，特来领教关将军手段！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2024}},
					},
			}
		},
	},
[2024] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "原来是颜良将军部下，正好先解决你这个副将，再去向颜良讨教！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 658,mapID = 422}},
				},
			}
		},
	},
[2025] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "关将军，张南已除。我们这就闯入大营，取那颜良首级。",
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
[2026] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21416,
		soundID = nil,
		txt = "关羽，你身位刘备部下，却为曹操出力，真是可笑。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2027}},
					},
			}
		},
	},
[2027] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "关某受曹操恩情，收留关某，现有此机会，理应相报。闲话少说，出来应战便是！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 659,mapID = 422}},
				},
			}
		},
	},
[2028] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "如今颜良身死，突围阻碍已除，我们这边返回助曹操突围。",
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
[2029] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "曹将军，那颜良已被关将军斩杀，我们速速突围吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2030}},
					},
			}
		},
	},
[2030] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21414,
		soundID = nil,
		txt = "关将军仗义相救，曹某不胜感激，如今颜良已除，袁军不攻自破，还望英雄前去洛阳，代我向圣上禀告白马坡已破。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1908}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1909}},
			},
			}
		},
	},
[2031] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "参见陛下，如今曹操将军已经攻占白马坡，袁绍部下颜良身首异处，在下特来向你禀报。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2032}},
					},
			}
		},
	},
[2032] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21421,
		soundID = nil,
		txt = "那曹操乃是一代奸雄，野心勃勃，并非一心辅佐汉室。当今天下，能一心匡扶汉室的，唯有我的皇叔刘备。奈何如今皇叔下落不明，你且前去询问太守卢植，看他是否获悉皇叔消息，定要将皇叔找到。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1909}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1910}},
			},
			}
		},
	},
[2033] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我奉当今圣上之命，特来询问太守可知皇叔刘备的消息。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2034}},
					},
			}
		},
	},
[2034] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 20049,
		soundID = nil,
		txt = "听朝廷探子来报，刘备下落尚不得知，但刘备旧部孙乾，如今正在袁绍军中，身处河北，英雄可前往寻找孙乾，向他询问刘备消息。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1910}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1911}},
			},
			}
		},
	},
[2035] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21422,
		soundID = nil,
		txt = "来者何人，报上名来，此地乃是我军要地，不可擅闯！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2036}},
					},
			}
		},
	},
[2036] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休得猖狂，这便取你首级！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 660,mapID = 126}},
				},
			}
		},
	},
[2038] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "孙乾将军，吾受洛阳太守卢植指点，前来询问你可知刘备下落？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2039}},
					},
			}
		},
	},
[2039] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21427,
		soundID = nil,
		txt = "我家主公刘备正受困与河北袁绍军中，还望英雄前往搭救。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1911}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1913}},
			},
			}
		},
	},
[2040] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "关将军，我从孙乾口中得知，刘备已被袁绍擒获，受困于河北袁绍军中。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2041}},
					},
			}
		},
	},
[2041] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "原来大哥在河北，那我们即刻启程前往营救大哥！我这就前去向曹操辞行！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1913}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1914}},
			},
			}
		},
	},
[2042] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21428,
		soundID = nil,
		txt = "关将军，我家主公不在府中，还请改日再来。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2043}},
					},
			}
		},
	},
[2043] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "曹操可是听闻我要离去，便避而不见，尔等速速让开，让我进去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 661,mapID = 420}},
				},
			}
		},
	},
[2044] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "我们这就向曹操辞行，前往河北！",
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
[2045] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21433,
		soundID = nil,
		txt = "关将军，我家主公不在，你怎敢擅闯主公府邸！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2046}},
					},
			}
		},
	},
[2046] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "许褚！你休要拦我，今日无论如何我定要向曹操辞行！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 662,mapID = 420}},
				},
			}
		},
	},
[2047] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "你速速让开道路，我要面见曹操！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2049}},
					},
			}
		},
	},
[2048] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21433,
		soundID = nil,
		txt = "关将军，我家主公确实不在府上，你如此擅闯，着实失礼。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2049}},
					},
			}
		},
	},
[2049] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "既然曹操不愿见我，那我便自行离去，还望许将军转告曹丞相。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1915}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1916}},
			},
			}
		},
	},
[2050] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "关某此行前往河北，已向曹丞相辞行。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2051}},
					},
			}
		},
	},
[2051] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21434,
		soundID = nil,
		txt = "河北袁绍，乃是我家丞相对头，关将军没有丞相的通关文凭，便不可过关！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 663,mapID = 423}},
				},
			}
		},
	},
[2052] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "孔秀阻我前往，故杀之，吾等继续前行。",
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
[2053] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21439,
		soundID = nil,
		txt = "关羽休走！汝杀孔秀，随我返回许昌向丞相谢罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2054}},
					},
			}
		},
	},
[2054] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "关某此去河北，已向丞相辞行，东岭孔秀已被吾杀，汝亦欲寻死耶？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 664,mapID = 423}},
				},
			}
		},
	},
[2055] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "继续前行，何人胆敢阻我？",
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
[2056] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21440,
		soundID = nil,
		txt = "关将军此去何处？可有丞相手信？如无丞相文凭，即为逃窜。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2057}},
					},
			}
		},
	},
[2057] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "事兀不曾讨得，韩将军休要阻我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 665,mapID = 423}},
				},
			}
		},
	},
[2058] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "曹操对我避而不见，沿路守将阻我前行，奈何大哥受困于河北，即使杀光沿路曹将，也要速速到达河北！",
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
[2059] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21441,
		soundID = nil,
		txt = "关羽你杀我军多位将士，一路闯关，我这就擒住你交由主公定罪！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2060}},
					},
			}
		},
	},
[2060] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "废话少说！休要拦我道路！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 666,mapID = 423}},
				},
			}
		},
	},
[2061] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "此处距离河北已不远，我们继续向河北前进。",
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
[2062] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21442,
		soundID = nil,
		txt = "关羽还不速速束手就擒！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2063}},
					},
			}
		},
	},
[2063] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "关某已向曹操辞行，尔等休要再拦我！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 667,mapID = 423}},
				},
			}
		},
	},
[2064] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "前方还有最后一名守将，名曰秦琪，其后便是河北地界！",
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
[2065] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "秦将军，吾等一行欲往河北相救兄长刘备，还望放行。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2066}},
					},
			}
		},
	},
[2066] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21443,
		soundID = nil,
		txt = "关羽汝斩我军五员守将，还妄想我放你离去！还不束手就擒！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 668,mapID = 423}},
				},
			}
		},
	},
[2067] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "前方乃是河北，我们已经要离开曹操地界了，继续前进。",
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
[2068] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "过五关斩六将，关将军当真勇猛无敌！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2069}},
					},
			}
		},
	},
[2069] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "此处便是河北地界，我们这就前往袁绍军中，救出我兄长玄德！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1922}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1923}},
			},
			}
		},
	},
[2070] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21444,
		soundID = nil,
		txt = "你是何人？此处乃是我周仓大王的地界，交出身上值钱的物件，便让你们通过！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2071}},
					},
			}
		},
	},
[2071] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "区区山贼也敢自称大王，看我为民除害！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 669,mapID = 126}},
				},
			}
		},
	},
[2072] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21444,
		soundID = nil,
		txt = "想必这位便是关羽关将军，吾奉张飞将军之命，在此探查关将军和玄德公下落，张飞将军就在前方不远！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2074}},
					},
			}
		},
	},
[2073] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "原来三弟也已来到河北，我们速去与翼德相见。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1923}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 1924}},
			},
			}
		},
	},
[2074] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21401,
		soundID = nil,
		txt = "翼德吾弟，自徐州一战，吾等兄弟失散，听闻兄长就在河北袁绍军中，三弟可有兄长消息？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2075}},
					},
			}
		},
	},
[2075] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21449,
		soundID = nil,
		txt = "二哥你终于来了，我已打探到袁绍的心腹军师逢纪如今就在河内，其定然知晓刘备的下落，我们即刻便出发吧。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 1924}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2001}},
			},
			}
		},
	},
[2102] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21502,
		soundID = nil,
		txt = "站住！河北如今已是我家逢纪将军的地盘，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2103}},
					},
			}
		},
	},
[2103] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "你们是何人，敢如此猖狂！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 701,mapID = 126}},
				},
			}
		},
	},
[2104] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21503,
		soundID = nil,
		txt = "小子，你是什么人，敢擅闯我军营重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2105}},
					},
			}
		},
	},
[2105] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "逢纪如今在何处！还不快快招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 702,mapID = 126}},
				},
			}
		},
	},
[2106] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21507,
		soundID = nil,
		txt = "站住！我乃河北大将逢纪是也，你是何人，敢在此放肆？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2107}},
					},
			}
		},
	},
[2107] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，刘备在哪里？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 703,mapID = 126}},
				},
			}
		},
	},
[2108] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21507,
		soundID = nil,
		txt = "英雄饶命，我都招了，刘备已被主公袁绍软禁于邺城，英雄可前去邺城寻找。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2001}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2002}},
			},
			}
		},
	},
[2109] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21508,
		soundID = nil,
		txt = "站住！本将奉命把守邺城，擅闯者杀无赦！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2110}},
					},
			}
		},
	},
[2110] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "刘备如今在何处？速速道来，可饶你不死。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 704,mapID = 418}},
				},
			}
		},
	},
[2111] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21513,
		soundID = nil,
		txt = "吾乃邺城守将田畴是也！奉主公之命在此看守刘备，休得放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2112}},
					},
			}
		},
	},
[2112] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "狗贼，受死吧！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 705,mapID = 418}},
				},
			}
		},
	},
[2113] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21514,
		soundID = nil,
		txt = "多谢英雄相救，此地不宜久留，吾等速往南方投靠吾族兄刘表，再另寻他计。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2002}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2003}},
			},
			}
		},
	},
[2114] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21515,
		soundID = nil,
		txt = "我乃袁绍大将张颌是也，奉主公命前来追捕刘备，尔等还不速速束手就擒。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2115}},
					},
			}
		},
	},
[2115] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "岂容尔等放肆，今日就让你们有来无回！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 706,mapID = 128}},
				},
			}
		},
	},
[2116] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21514,
		soundID = nil,
		txt = "没想到袁绍狗贼动作如此之快，现下当务之急是早日阻止袁绍。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2003}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2004}},
		    {action = DialogActionType.Goto, param = {dialogID = 2117}},
				},
			}
		},
	},
[2117] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "如何阻止？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2118}},
					},
			}
		},
	},
[2118] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21514,
		soundID = nil,
		txt = "袁绍军内如今其了内讧，军师许攸因和袁绍的心腹谋士郭图不和，被郭图陷害，已被袁绍关押了起来，若能得到许攸相助，必然能够打败袁绍。吾等往南方寻找刘表，你且去救出许攸。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2004}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2005}},
			},
			}
		},
	},
[2119] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21508,
		soundID = nil,
		txt = "邺城乃是袁绍大人地盘，你还不速速退去！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2120}},
					},
			}
		},
	},
[2120] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "许攸在哪，若不速速道来，定取你性命！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 707,mapID = 418}},
				},
			}
		},
	},
[2121] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21516,
		soundID = nil,
		txt = "就凭你也想打探许攸下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2122}},
					},
			}
		},
	},
[2122] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "狗贼，拿命来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 708,mapID = 418}},
				},
			}
		},
	},
[2123] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21517,
		soundID = nil,
		txt = "郭图在此！你是何人，敢独身来邺城放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2124}},
					},
			}
		},
	},
[2124] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "许攸是不是在你手中，还不快快放人，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 709,mapID = 418}},
				},
			}
		},
	},
[2125] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "快说，许攸如今身在何处？",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2126}},
					},
			}
		},
	},
[2126] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21517,
		soundID = nil,
		txt = "许攸被我们偷袭抓住，如今已经被押往邺城地监关押，英雄可往邺城地监救他！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2005}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2006}},
			},
			}
		},
	},
[2127] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21518,
		soundID = nil,
		txt = "站住！什么人，敢擅闯军营重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2128}},
					},
			}
		},
	},
[2128] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "许攸是不是关押在此，速速招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 710,mapID = 418}},
				},
			}
		},
	},
[2129] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21519,
		soundID = nil,
		txt = "此乃关押要犯重地，岂容尔等放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2130}},
					},
			}
		},
	},
[2130] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "交出许攸，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 711,mapID = 418}},
				},
			}
		},
	},
[2131] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21520,
		soundID = nil,
		txt = "大将高俦在此，休想救出许攸！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2132}},
					},
			}
		},
	},
[2132] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，看招！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 712,mapID = 418}},
				},
			}
		},
	},
[2133] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21521,
		soundID = nil,
		txt = "多谢英雄相救，吾本打算去许昌投靠曹操，若英雄能助我一臂之力，我便将袁军军情委以相告。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2006}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2007}},
			},
			}
		},
	},
[2134] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21521,
		soundID = nil,
		txt = "曹将军，吾乃袁绍军师许攸，因在袁营遭奸人陷害差点命丧黄泉，如今已无路可退，还望曹将军能收留，如今袁军的粮草全部堆积于乌巢，由大将夏侯惇看守，只要烧掉乌巢的军粮，则袁军势必打乱，不战而胜。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2135}},
					},
			}
		},
	},
[2135] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21522,
		soundID = nil,
		txt = "许军师诚意前来投靠，吾岂有不收之礼，许军师的情报若是真的，必然能一举歼灭袁军，吾决定前往乌巢一探虚实，英雄便随我一道前往罢。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2007}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2008}},
			},
			}
		},
	},
[2136] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21523,
		soundID = nil,
		txt = "乌巢乃是袁绍大人地盘，尔等是什么人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2137}},
					},
			}
		},
	},
[2137] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "淳于琼在何处，还不速速道来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 713,mapID = 421}},
				},
			}
		},
	},
[2138] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21524,
		soundID = nil,
		txt = "就凭你们也想打探淳将军下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2139}},
					},
			}
		},
	},
[2139] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "不必多言，还是手底下见真章！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 714,mapID = 421}},
				},
			}
		},
	},
[2140] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21529,
		soundID = nil,
		txt = "淳于琼在此！你们是何人，敢来乌巢放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2141}},
					},
			}
		},
	},
[2141] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "速速让开，今日我必将粮草烧毁！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 715,mapID = 421}},
				},
			}
		},
	},
[2142] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21522,
		soundID = nil,
		txt = "多谢英雄相助，现今烧毁了粮草，袁军必然大乱，望英雄能速速前往官渡前线的曹军军营，督请吾大将夏侯惇出兵官渡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2008}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2009}},
			},
			}
		},
	},
[2143] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "夏将军，我奉曹操之命前来请将军出兵官渡。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2144}},
					},
			}
		},
	},
[2144] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21530,
		soundID = nil,
		txt = "既是主公之意，出兵便是，不过袁军现下刀枪不入，难以对付。吾得知袁绍之子袁尚如今正在前线督促，此人贪生怕死。如若能够擒住袁尚，定然知道袁军秘密。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2009}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2010}},
			},
			}
		},
	},
[2145] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21531,
		soundID = nil,
		txt = "来者何人？竟敢肆闯我官渡关重地！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2146}},
					},
			}
		},
	},
[2146] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休要阻挡我，速速交代袁尚身在何处，饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 716,mapID = 128}},
				},
			}
		},
	},
[2147] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21532,
		soundID = nil,
		txt = "来人止步，竟敢擅闯我军大营，还不速速投降！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2148}},
					},
			}
		},
	},
[2148] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "交出袁尚，否则休怪我不客气！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 717,mapID = 128}},
				},
			}
		},
	},
[2149] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21537,
		soundID = nil,
		txt = "袁尚在此！你是何人，为何苦苦相逼！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2150}},
					},
			}
		},
	},
[2150] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "袁尚，你若交待出袁军的秘密，我便饶你不死！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 718,mapID = 128}},
				},
			}
		},
	},
[2151] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21559,
		soundID = nil,
		txt = "实不相瞒，我军有如此大的威力，全是拜截教妖人杨森所赐，他在暗中摆了一个天罡大阵相助，让吾等实力大增，英雄可前往破阵。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2010}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2011}},
			},
			}
		},
	},
[2152] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21538,
		soundID = nil,
		txt = "你是何人，入我截教重地，报上名来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2153}},
					},
			}
		},
	},
[2153] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "我是谁不重要，杨森在何处！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 719,mapID = 419}},
				},
			}
		},
	},
[2154] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21539,
		soundID = nil,
		txt = "竟敢擅闯截教重地，看来是活腻了！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2155}},
					},
			}
		},
	},
[2155] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "杨森在哪里，速速招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 720,mapID = 419}},
				},
			}
		},
	},
[2156] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21544,
		soundID = nil,
		txt = "吾乃杨森是也！你究竟是何人！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2157}},
					},
			}
		},
	},
[2157] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "杨森你作恶多端，今日我便替天行道！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 721,mapID = 419}},
				},
			}
		},
	},
[2158] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "如今大阵已破，需速速前往官渡寻找夏侯惇将军会合。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2011}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2012}},
			},
			}
		},
	},
[2159] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21530,
		soundID = nil,
		txt = "英雄果然好胆识，既然大阵已破，我们便即刻启程剿灭袁军。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2012}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2013}},
			},
			}
		},
	},
[2160] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21545,
		soundID = nil,
		txt = "吾乃袁军大将麴义，袁军的地盘岂是尔等能擅闯的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2161}},
					},
			}
		},
	},
[2161] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "休要阻挡我，否则休怪我不客气！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 722,mapID = 128}},
				},
			}
		},
	},
[2162] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21546,
		soundID = nil,
		txt = "高览在此！官渡重地岂容尔等放肆！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2163}},
					},
			}
		},
	},
[2163] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "高览，今日便是你的死期！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 723,mapID = 128}},
				},
			}
		},
	},
[2164] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21530,
		soundID = nil,
		txt = "如今袁绍兵败，正是前往袁绍的老巢邺城彻底剿灭袁绍的好时机，英雄可先往邺城击杀大将高干，擒住袁绍的次子袁熙，便可得知袁绍下落。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2013}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2014}},
			},
			}
		},
	},
[2165] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21547,
		soundID = nil,
		txt = "来者何人！如今邺城戒备森严，尔敢擅闯！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2166}},
					},
			}
		},
	},
[2166] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "吾此次进入邺城，就是要灭了高干！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 724,mapID = 418}},
				},
			}
		},
	},
[2167] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21548,
		soundID = nil,
		txt = "大胆！高将军的名讳也是尔能直呼的！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2168}},
					},
			}
		},
	},
[2168] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "高干在何处，速速招来！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 725,mapID = 418}},
				},
			}
		},
	},
[2169] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21555,
		soundID = nil,
		txt = "吾乃高干是也，如此大的口气，吾现在便灭了你！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2170}},
					},
			}
		},
	},
[2170] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "废话少说，看招！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 726,mapID = 418}},
				},
			}
		},
	},
[2171] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "高干已除，现下当务之急是前往擒住袁熙。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2014}},
				    {action = DialogActionType.RecetiveTask, param = {taskID = 2015}},
			},
			}
		},
	},
[2172] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21553,
		soundID = nil,
		txt = "吾乃袁绍次子袁熙，你到底有什么图谋！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.Goto, param = {dialogID = 2173}},
					},
			}
		},
	},
[2173] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 0,
		soundID = nil,
		txt = "今日便是来擒你的，速速招出袁绍下落！",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.EnterScriptFight, param = {scriptID = 727,mapID = 418}},
				},
			}
		},
	},
[2174] = 
	{
		dialogType = DialogType.NotOption,
		conditions = 
		{
		},
		speakerID = 21553,
		soundID = nil,
		txt = "英雄饶命，我并不知吾父身在何方，如今他早已不在邺城。",
		options = 
		{
			{
				showConditions = {},
				optionTxt = "",
				actions =
				{
					{action = DialogActionType.FinishTask, param = {taskID = 2015}},
					},
			}
		},
	},
}


table.copy(NormalDialogModelDB,DialogModelDB)
