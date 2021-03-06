--[[ScriptFightDB.lua
描述：
	--脚本战斗DB
	--脚本ID段划分
--1~100			日常测试使用
--101~999		主线专用
--1000~3000		普通副本
--3001~4000		连环副本
--4001~5000		日常活动副本、帮派副本、英雄本
--5001~6000		通天塔
--6001~7000		藏宝图、野外暗雷、节日活动
--7001~7100		坐骑召唤任务
--7101+			其他玩法
--8001~9000             活动玩法
--10001~15000	封神台
--]]
ScriptFightDB={}
ScriptType = {
				Common = 1,
				LuckyMonster = 2,--瑞兽降福
				Random = 3,--随机阶段
}
--条件类型
ScriptFightConditionType=
{
	AttrValue		= 1,--属性比例 {type = ScriptFightConditionType.AttrValue, params={DBID = 1052,type="hp",["<="] = 0},},
	IDExist			= 2,--id是否存在 {type = ScriptFightConditionType.IDExist, params={DBID = 1052,relation =">", value = 1,},},
	RoundCount		= 3,--第几回合 {type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
	RoundInterval	= 4,--回合间隔 {type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 2},},
	BuffStatus		= 5,--带有指定的buff(ID,或类型) {type = ScriptFightConditionType.BuffStatus, params={DBID = {1052},buffID = 1(or type=BuffKind.Dot),},},或{type = ScriptFightConditionType.BuffStatus, params={targetType = ScriptFightTargetType.AnyOfEnemys,buffID = 1(or type=BuffKind.Dot),},}
	LiveNum			= 6,--存活的单位数 {type = ScriptFightConditionType.LiveNum, params={isEnemy = true ,count = 2},},
	IsAttacked		= 7,--指定单位是否受击 {type = ScriptFightConditionType.IsAttacked, params={DBID = {1052},}, },
	FightPeriod		= 8,--战斗持续时间 {type = ScriptFightConditionType.FightPeriod, params={time = 10},},--分钟
	PlayerDead		= 9,--玩家或宠物死亡{type = ScriptFightConditionType.PlayerDead, params={type = ScriptFightDeadType.PlayerOrPet},}
	MonsterCatched  = 10,--怪物被捕捉{type = ScriptFightConditionType.MonsterCatched, params={DBID = {1052},}
	ScoreNum        = 11,--玩家积分值{type = ScriptFightConditionType.ScoreNum, params={relation =">", value = 1,},},
}
ScriptFightDeadType = {
	Player	= 1,
	Pet		= 2,
	PlayerOrPet = 3,
}
ScriptFightTargetType = {
	AnyOfFriends = 1,--友方随机
	AnyOfEnemys = 2,--敌方随机
}
ScriptMonsterCreateType = {
	Random = 1,--随机
	Assign = 2,--指定
}
--[[
1.属性比例的参数中 type 的值为"hp"生命,"mp"蓝,"kill"杀气
2.带有指定类型的buff,buff类型定义为
--buff类型
BuffKind = {
	AddPhase		= 0x01,--相性增益
	AddAttr			= 0x02,--属性增益
	Sub				= 0x03,--减益
	Dot				= 0x04,--dot
	TransCard		= 0x05,--变身卡
	ChaosObstacle	= 0x06,--混乱障碍
	PoisonObstacle	= 0x07,--中毒障碍
	FreezeObstacle	= 0x08,--冰冻障碍
	SilenceObstacle	= 0x09,--沉默障碍
	TauntObstacle	= 0x10,--嘲讽障碍
	SoporObstacle	= 0x11,--昏睡障碍
	Shield			= 0x12,--护盾Buff
	JXSTrans		= 0x13,--金霞山变身
	QYDXuLi			= 0x14,--乾元岛蓄力
	QYDXuRuo		= 0x15,--乾元岛虚弱
	ZYMXuLi			= 0x16,--紫阳门蓄力
	Special			= 0x17,--特殊类buff
}

--
]]
--光效类型
LightEffectType = {
			Unit = 0,--单位ID
			All = 1,--敌友全部
			EnyOfAll = 2,--敌友任一
			Center	 = 3,--场景中央
}
--动作类型
ScriptFightActionType=
{
	PlayAnimation = 1,--播动画 {type = ScriptFightActionType.PlayAnimation,params={fileName = "XXX"},}
	PlayBubble	  = 2,--播气泡 {type = ScriptFightActionType.PlayBubble,params={DBID={11},bubbleID = XXX},}
	PlayDialog	  = 3,--播对话 {type = ScriptFightActionType.PlayDialog,params={ID=11}, }
	PlayAction	  = 4,--播动作 {type = ScriptFightActionType.PlayAction,params={DBID={11},actionID =22} }
	PlayEffect	  = 5,--播光效 {type = ScriptFightActionType.PlayEffect,params={magicID = 1,DBID ={22},type = LightEffectType.Unit } }
	ReplaceEntity = 6,--替换实体 {type = ScriptFightActionType.ReplaceEntity,params={curID ={22},replaceID = 11,actionID = 1} }
	EntityQuit	  = 7,--实体退场 {type = ScriptFightActionType.EntityQuit,params={DBID ={22},actionID = 1} }
	EntityEnter	  = 8,--实体进场 {type = ScriptFightActionType.EntityEnter,params={{DBID = 1,actionID = 1,count = 1},} }
	UseSkill	  = 9,--使用技能 {type = ScriptFightActionType.UseSkill,params={DBID ={22},skillID = 1}}或 {type = ScriptFightActionType.UseSkill,params={targetType = ScriptFightTargetType.AnyOfEnemys,skillID = 1}}
	AddBuff		  = 10,--加buff {type = ScriptFightActionType.AddBuff,params={DBID ={22},buffID = 2} }或 {type = ScriptFightActionType.AddBuff,params={targetType = ScriptFightTargetType.AnyOfEnemys,buffID = 2} }
	RemoveBuff	  = 11,--去buff {type = ScriptFightActionType.RemoveBuff,params={DBID ={22},buffID = 2} }或 {type = ScriptFightActionType.RemoveBuff,params={targetType = ScriptFightTargetType.AnyOfEnemys,buffID = 2} }
	SetGBH		  = 12,--设置为重伤 {type = ScriptFightActionType.SetGBH,params={DBID ={22},} }
	FightPause	  = 13,--客户端战斗暂停 {type = ScriptFightActionType.FightPause,params={time = 2} }--秒
	FightEnd	  = 14,--战斗结束 {type = ScriptFightActionType.FightEnd,params={winner = "monster" 或 "player"} }
	MakeEscape	  = 15,--强制逃跑 {type = ScriptFightActionType.MakeEscape,params={} }
	SetCounterRate= 16,--设置反击率 {type = ScriptFightActionType.SetCounterRate,params={DBID ={22},value = 0.5} }
	ExchangePos	  = 17,--交换或改变位置 {type = ScriptFightActionType.ExchangePos,params={curPos = 21,targetPos =23} }
	ChangeHp	  = 18,--设置生命值(增大或减少最大值的百分比,如果是玩家的话params={DBID =-1,percent = -50}}是相对红蓝){type = ScriptFightActionType.ChangeHp,params={DBID ={22},percent = -50}}
	SameTime	  =19,--同时执行一组
	RefreshMembers = 20,--刷新怪物
	AddScore = 21,--增加玩家积分{type = ScriptFightActionType.AddScore,params={value = 5} }
	ChangeReward = 22,--影响奖励值{type = ScriptFightActionType.ChangeReward,params={type = "exp",mode = "value",value = 100} }--type = "exp","tao","money","expoint","pot";mode= "value" or "percent"
}

ScriptFightDB[1] = {
			--战斗触发条件
			condition = {
					mustSingle = false --是否禁止组队
			},
			backgroundMusic = nil,
			backgroundPic = nil,
			--有哪些怪物(怪物配置ID)
			--monsters = {type=ScriptMonsterCreateType.Random,minCount = 3,maxCount = 3,{ID = 1053,weight= 50}, {ID = 1052,weight= 50}},--随机
			monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10001,pos = 18},},--指定
			--npcs = {{ID = 1052},{ID = 1052,},},--指定 {{ID = 1052,pos=11},{ID = 1052,pos = 3},}
			--系统行为
			systemActions = {




										[1] = { condition = {
																--{type = ScriptFightConditionType.AttrValue,params={DBID = 1053,type="hp",["<="] = 0.5},},
																--{type = ScriptFightConditionType.LiveNum, params={isEnemy = false ,count = 1},},
																--{type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 1},},
																--{type = ScriptFightConditionType.FightPeriod, params={time = 3},},
																--{type = ScriptFightConditionType.PlayerDead, params={},},
																--{type = ScriptFightConditionType.IDExist, params={DBID = {1052},},},
																isAnd = true,
																count = 1,
														    },

												actions = {
															 {type = ScriptFightActionType.UseSkill,params={DBID ={1053},skillID = 3} },
															 --{type = ScriptFightActionType.AddBuff,params={DBID ={1053},buffID = 5000} },
															--{type = ScriptFightActionType.MakeEscape,params={} }
															{type = ScriptFightActionType.ExchangePos,params={curPos = 18,} }
															--{type = ScriptFightActionType.ReplaceEntity,params={curID ={1053},replaceID = 1052} }
															--{type = ScriptFightActionType.EntityEnter,params={{DBID = 1052,actionID = nil,count = 1},} }
															--{type = ScriptFightActionType.EntityQuit,params={DBID ={1052},actionID = nil} }
															--{type = ScriptFightActionType.AddBuff,params={targetType = ScriptFightTargetType.AnyOfFriends,buffID = 5000} },
															--{type = ScriptFightActionType.ChangeHp,params={DBID ={1053},percent = -10}},
														  },
											   },--行为1

			},
			--每回合做哪些事


						begin = {

						},--回合开始做哪些事
						fin = {

						},--回合结束做哪些事


			--阶段(用于分阶段的战斗)
			phases = {

					[1] = {
							typeID = 0, sceneID = "zd_yougu2.xml",isSpecialAction =true,
							monsters={10001},
					},
					[2] = {
							typeID = 0, sceneID = "zd_yougu2.xml",isSpecialAction =true,
							monsters={10001},
					}

			},
			--战斗开始做哪些事
			fightBegin = {

			},
			--战斗结束做哪些事
			fightEnd = {

			},

			rewards={
						mats={},--物品{{ID=10001,count = 1}}
						exp = 1,
						money = 1,
			},--奖励
			isNoEscape = true,
}

ScriptFightDB[2] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10001,},},
	systemActions = {
			[1] = {
				condition  = {
					{type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
					isAnd = true,
				 },
				 actions = {
					{type = ScriptFightActionType.PlayAction,params={DBID={10001},actionID =1021} ,},
				 }
			},
		}
}

ScriptFightDB[3] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10001},{ID = 10001}},
	begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayDialog,params={ID=1}, } ,
					 {type = ScriptFightActionType.EntityQuit,params={DBID ={1052}} }
				 }
			},
	},

}

ScriptFightDB[4] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 1052},{ID = 1053}},
	begin = {
			[1] = {
				condition = {
					isAnd = true,
				 },
				 actions = {
					isSameTime = true,
					 {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 1},},
					 --{type = ScriptFightActionType.EntityQuit,params={DBID ={1052}} },
				 }
			},

	},
	phases = {		--多阶段战斗（暂未测试）
		[1] = {		--阶段数
			typeID = 0, sceneID = "zd_yougu2.xml",isSpecialAction =true,
			--typeID = 过场动画方式，默认0，sceneID = 背景图文件名，isSpecialAction = true（特殊动作，默认true）
			monsters={1052},				--怪物配置
		},

		[2] = {
			typeID = 0, sceneID = "zd_yougu2.xml",isSpecialAction =true,
			monsters={1052},
		}
	},

}

ScriptFightDB[5] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 1052},{ID = 1053}},
	begin = {
	[1] = {
		condition = {
			isAnd = true,
		 },
		actions = {
			 {type = ScriptFightActionType.FightEnd,params={winner = "player" } }  --或 "player"
		}
	},
	},
	rewards={
		mats={{ID = 50005 , count = 1}},--物品{{ID=10001,count = 1}}
	},
}


-----------------------------------野外战斗脚本（ID段10~99）--------------------
ScriptFightDB[10] = {					---------------巨鹿野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10012,weight= 45}, {ID = 10013,weight= 45},{ID = 10101,weight= 5,max = 1}, {ID = 10102,weight= 5,max = 1}},
}

ScriptFightDB[11] = {					---------------封神台野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10014,weight= 45}, {ID = 10015,weight= 45},{ID = 10103,weight= 5,max = 1}, {ID = 10104,weight= 5,max = 1}},
}

ScriptFightDB[12] = {					---------------黑风山野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10016,weight= 45}, {ID = 10017,weight= 45},{ID = 10105,weight= 5,max = 1}, {ID = 10106,weight= 5,max = 1}},
}

ScriptFightDB[13] = {					---------------孟津野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10018,weight= 45}, {ID = 10019,weight= 45},{ID = 10107,weight= 5,max = 1}, {ID = 10108,weight= 5,max = 1}},
}

ScriptFightDB[14] = {					---------------东郡野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10020,weight= 45}, {ID = 10021,weight= 45},{ID = 10109,weight= 5,max = 1}, {ID = 10110,weight= 5,max = 1}},
}

ScriptFightDB[15] = {					---------------虎牢关野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10022,weight= 45}, {ID = 10023,weight= 45},{ID = 10111,weight= 5,max = 1}, {ID = 10112,weight= 5,max = 1}},
}

ScriptFightDB[16] = {					---------------潼关野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10024,weight= 45}, {ID = 10025,weight= 45},{ID = 10113,weight= 5,max = 1}, {ID = 10114,weight= 5,max = 1}},
}

ScriptFightDB[17] = {					---------------天山野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10026,weight= 45}, {ID = 10027,weight= 45},{ID = 10115,weight= 5,max = 1}, {ID = 10116,weight= 5,max = 1}},
}

ScriptFightDB[18] = {					---------------西凉野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10028,weight= 45}, {ID = 10029,weight= 45},{ID = 10117,weight= 5,max = 1}, {ID = 10118,weight= 5,max = 1}},
}

ScriptFightDB[19] = {					---------------北海野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10030,weight= 45}, {ID = 10031,weight= 45},{ID = 10119,weight= 5,max = 1}, {ID = 10120,weight= 5,max = 1}},
}

ScriptFightDB[20] = {					---------------辽东野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10032,weight= 45}, {ID = 10033,weight= 45},{ID = 10121,weight= 5,max = 1}, {ID = 10122,weight= 5,max = 1}},
}

ScriptFightDB[21] = {					---------------宛城野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10034,weight= 45}, {ID = 10035,weight= 45},{ID = 10123,weight= 5,max = 1}, {ID = 10124,weight= 5,max = 1}},
}

ScriptFightDB[22] = {					---------------寿春野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10036,weight= 45}, {ID = 10037,weight= 45},{ID = 10125,weight= 5,max = 1}, {ID = 10126,weight= 5,max = 1}},
}

ScriptFightDB[23] = {					---------------河北野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10038,weight= 45}, {ID = 10039,weight= 45},{ID = 10127,weight= 5,max = 1}, {ID = 10128,weight= 5,max = 1}},
}

ScriptFightDB[24] = {					---------------濮阳野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10040,weight= 45}, {ID = 10041,weight= 45},{ID = 10129,weight= 5,max = 1}, {ID = 10130,weight= 5,max = 1}},
}

ScriptFightDB[25] = {					---------------官渡野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10042,weight= 45}, {ID = 10043,weight= 45},{ID = 10131,weight= 5,max = 1}, {ID = 10132,weight= 5,max = 1}},
}

ScriptFightDB[27] = {					---------------野怪
	monsters = {type=ScriptMonsterCreateType.Random,{ID = 10044,weight= 45}, {ID = 10045,weight= 45},{ID = 10133,weight= 5,max = 1}, {ID = 10134,weight= 5,max = 1}},
}

-----------------------------------------帮会休闲任务测试脚本---------------------------------------------------------
ScriptFightDB[30] = {
                   
	subType = ScriptType.Random  , --触发随机读取多组战斗的配置标记，如果多组战斗是按顺序执行则此项无需配置
	count = 2	,	--随机读取次数，仅在配置了subType = ScriptType.Random时才能写入，表示脚本战斗场次
	isRepeat = false ,   --已经出现的战斗是否会被重复触发 

	phases = {		--多阶段战斗（注意一旦启用多阶段战斗，则其他所有的怪物出场、触发节点、条件、行为都要写在多阶段战斗内，外部的全部失效）
		[1] = {		--阶段数(若脚本内已经配置了怪物等参数值时，第一阶段的所有怪物和背景图等均不读取这里面的配置)
			typeID = 0, sceneID = "zd_fb_jt01.xml",isSpecialAction =true,
			--typeID = 过场动画方式，默认0，sceneID = 背景图文件名，isSpecialAction = true（特殊动作，默认true）
			monsters={40017,31301,31302},				--怪物配置
		},

		[2] = {
			typeID = 0, sceneID = "zd_yw_tg01_01.xml",isSpecialAction =true,
			monsters={40018,31301,31302},
		},
		[3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml",isSpecialAction =true,
			monsters={40019,31301,31302},
		},
	},



	rewards={			--脚本胜利后奖励列表
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		--物品奖励，ID=物品ID，count = 掉落数
		exp = 1,												--经验值（暂无接口）
		money = 1,											--银两（暂无接口）
		subMoney = 1,										--绑银（暂无接口）
	},--奖励
	}
ScriptFightDB[31] = {
                   
	subType = ScriptType.Random  , --触发随机读取多组战斗的配置标记，如果多组战斗是按顺序执行则此项无需配置
	count = 2	,	--随机读取次数，仅在配置了subType = ScriptType.Random时才能写入，表示脚本战斗场次
	isRepeat = false ,   --已经出现的战斗是否会被重复触发 

	phases = {		--多阶段战斗（注意一旦启用多阶段战斗，则其他所有的怪物出场、触发节点、条件、行为都要写在多阶段战斗内，外部的全部失效）
		[1] = {		--阶段数(若脚本内已经配置了怪物等参数值时，第一阶段的所有怪物和背景图等均不读取这里面的配置)
			typeID = 0, sceneID = "zd_fb_jt01.xml",isSpecialAction =true,
			--typeID = 过场动画方式，默认0，sceneID = 背景图文件名，isSpecialAction = true（特殊动作，默认true）
			monsters={40020,31301,31302},				--怪物配置
		},

		[2] = {
			typeID = 0, sceneID = "zd_yw_tg01_01.xml",isSpecialAction =true,
			monsters={40021,31301,31302},
		},
		[3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml",isSpecialAction =true,
			monsters={40022,31301,31302},
		},
	},



	rewards={			--脚本胜利后奖励列表
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		--物品奖励，ID=物品ID，count = 掉落数
		exp = 1,												--经验值（暂无接口）
		money = 1,											--银两（暂无接口）
		subMoney = 1,										--绑银（暂无接口）
	},--奖励
	}
ScriptFightDB[32] = {
                   
	subType = ScriptType.Random  , --触发随机读取多组战斗的配置标记，如果多组战斗是按顺序执行则此项无需配置
	count = 2	,	--随机读取次数，仅在配置了subType = ScriptType.Random时才能写入，表示脚本战斗场次
	isRepeat = false ,   --已经出现的战斗是否会被重复触发 

	phases = {		--多阶段战斗（注意一旦启用多阶段战斗，则其他所有的怪物出场、触发节点、条件、行为都要写在多阶段战斗内，外部的全部失效）
		[1] = {		--阶段数(若脚本内已经配置了怪物等参数值时，第一阶段的所有怪物和背景图等均不读取这里面的配置)
			typeID = 0, sceneID = "zd_fb_jt01.xml",isSpecialAction =true,
			--typeID = 过场动画方式，默认0，sceneID = 背景图文件名，isSpecialAction = true（特殊动作，默认true）
			monsters={40023,31301,31302},				--怪物配置
		},

		[2] = {
			typeID = 0, sceneID = "zd_yw_tg01_01.xml",isSpecialAction =true,
			monsters={40024,31301,31302},
		},
		[3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml",isSpecialAction =true,
			monsters={4005,31301,31302},
		},
	},



	rewards={			--脚本胜利后奖励列表
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		--物品奖励，ID=物品ID，count = 掉落数
		exp = 1,												--经验值（暂无接口）
		money = 1,											--银两（暂无接口）
		subMoney = 1,										--绑银（暂无接口）
	},--奖励
	}
ScriptFightDB[33] = {
                   
	subType = ScriptType.Random  , --触发随机读取多组战斗的配置标记，如果多组战斗是按顺序执行则此项无需配置
	count = 2	,	--随机读取次数，仅在配置了subType = ScriptType.Random时才能写入，表示脚本战斗场次
	isRepeat = false ,   --已经出现的战斗是否会被重复触发 

	phases = {		--多阶段战斗（注意一旦启用多阶段战斗，则其他所有的怪物出场、触发节点、条件、行为都要写在多阶段战斗内，外部的全部失效）
		[1] = {		--阶段数(若脚本内已经配置了怪物等参数值时，第一阶段的所有怪物和背景图等均不读取这里面的配置)
			typeID = 0, sceneID = "zd_fb_jt01.xml",isSpecialAction =true,
			--typeID = 过场动画方式，默认0，sceneID = 背景图文件名，isSpecialAction = true（特殊动作，默认true）
			monsters={40026,31301,31302},				--怪物配置
		},

		[2] = {
			typeID = 0, sceneID = "zd_yw_tg01_01.xml",isSpecialAction =true,
			monsters={40027,31301,31302},
		},
		[3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml",isSpecialAction =true,
			monsters={40028,31301,31302},
		},
	},



	rewards={			--脚本胜利后奖励列表
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		--物品奖励，ID=物品ID，count = 掉落数
		exp = 1,												--经验值（暂无接口）
		money = 1,											--银两（暂无接口）
		subMoney = 1,										--绑银（暂无接口）
	},--奖励
	}
ScriptFightDB[34] = {
                   
	subType = ScriptType.Random  , --触发随机读取多组战斗的配置标记，如果多组战斗是按顺序执行则此项无需配置
	count = 2	,	--随机读取次数，仅在配置了subType = ScriptType.Random时才能写入，表示脚本战斗场次
	isRepeat = false ,   --已经出现的战斗是否会被重复触发 

	phases = {		--多阶段战斗（注意一旦启用多阶段战斗，则其他所有的怪物出场、触发节点、条件、行为都要写在多阶段战斗内，外部的全部失效）
		[1] = {		--阶段数(若脚本内已经配置了怪物等参数值时，第一阶段的所有怪物和背景图等均不读取这里面的配置)
			typeID = 0, sceneID = "zd_fb_jt01.xml",isSpecialAction =true,
			--typeID = 过场动画方式，默认0，sceneID = 背景图文件名，isSpecialAction = true（特殊动作，默认true）
			monsters={40029,31301,31302},				--怪物配置
		},

		[2] = {
			typeID = 0, sceneID = "zd_yw_tg01_01.xml",isSpecialAction =true,
			monsters={40030,31301,31302},
		},
		[3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml",isSpecialAction =true,
			monsters={40031,31301,31302},
		},
	},



	rewards={			--脚本胜利后奖励列表
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		--物品奖励，ID=物品ID，count = 掉落数
		exp = 1,												--经验值（暂无接口）
		money = 1,											--银两（暂无接口）
		subMoney = 1,										--绑银（暂无接口）
	},--奖励
	}

-----------------------------------------------测试怪物属性脚本，请勿删除------------------------------------------------------
ScriptFightDB[94] = {              ----------------战斗结束时做哪些事
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20114}},
	fightEnd = {
	[1] = {
		  condition = {
		{type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20114},bubbleID = 101},},
		  }
	},
	},
}
ScriptFightDB[95] = {              ----------------战斗开始时做那些事
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20114}},
	fightBegin = {
	[1] = {
		  condition = {
		 {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20114},bubbleID = 101},},
		  }
	},
	},
}
ScriptFightDB[96] = {              ----------------回合结束做哪些事
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20114}},
	fin = {
	[1] = {
		  condition = {
		{type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20114},bubbleID = 101},},
		  }
	},
	},
}
ScriptFightDB[97] = {              ----------------回合开始做哪些事
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20114}},
	begin = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20114},bubbleID = 101},},
		  }
	},
	},
}
ScriptFightDB[98] = {              --------------测试1
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20115},{ID = 20116},{ID = 20116},},
}
ScriptFightDB[99] = {              --------------测试2
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20117},{ID = 20118},{ID = 20118},},
}
-----------------------------------------------测试怪物属性脚本，请勿删除------------------------------------------------------
-----------------------------------------------1-25级主线脚本------------------------------------------------------
ScriptFightDB[100] = {              --------------玄都玉京——玉清神将
      condition = {								    --战斗触发条件，如果没有条件要写，直接整个condition不写
		mustSingle = true,    --是否禁止组队   true --表示禁止组队    false --表示不禁止组队，false时可以不配置此项
		isNoEscape = true,	--禁止逃跑      true --表示禁止战斗逃跑    false --表示不禁止逃跑，false时可以不配置此项
	},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20010}},
}
ScriptFightDB[101] = {              --------------门派——玉清神将（捕捉）
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10011}},
}
ScriptFightDB[102] = {              --------------桃园镇——关羽
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20114}},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20114,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20114,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20114},bubbleID = 101},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20114,},},},
		  }
	},
	},
}
ScriptFightDB[103] = {              --------------桃园镇——陌生人
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20030}},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20030,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20030,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20030},bubbleID = 102},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20030,},},},
		  }
	},
	},
}
ScriptFightDB[104] = {              --------------镇外桃林——张宝	
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20031},{ID = 20033},{ID = 20034},{ID = 20035},{ID = 20036},},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20031,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20031,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20031},bubbleID = 103},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20031,},},},
		  }
	},
	},
}
ScriptFightDB[105] = {              --------------巨鹿——严政	
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20038},{ID = 20039},{ID = 20039},{ID = 20039},{ID = 20039},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20038,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20038,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20038},bubbleID = 104},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20038,},},},
		  }
	},
	},
}
ScriptFightDB[106] = {              --------------巨鹿——马相
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20044},{ID = 20040},{ID = 20041},{ID = 20042},{ID = 20043},},
}
ScriptFightDB[107] = {              --------------巨鹿——杜远
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20045},{ID = 20040},{ID = 20041},{ID = 20042},{ID = 20043},},
	npcs = {{ID = 20028},},--跟随NPC，刘备
}
ScriptFightDB[108] = {              --------------巨鹿——李乐
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20046},{ID = 20040},{ID = 20041},{ID = 20042},{ID = 20043},},
	npcs = {{ID = 20028},{ID = 20037},},--跟随NPC，刘备、张飞。
}
ScriptFightDB[109] = {              --------------秘密古阵——张宝
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20031}},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
}
ScriptFightDB[110] = {              --------------岐山——程远志
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20047},{ID = 20040},{ID = 20041},{ID = 20042},{ID = 20043},},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
}
ScriptFightDB[111] = {              --------------失魂阵——玄煌
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20048},{ID = 20050},{ID = 20050},{ID = 20050},{ID = 20050},},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
	--[[systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20048},bubbleID = 105},},
		  }
	},
	},]]
}
ScriptFightDB[112] = {              --------------血魂阵——水雉
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20051},{ID = 20052},{ID = 20052},{ID = 20052},{ID = 20052},},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
	--[[systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20051},bubbleID = 106},},
		  }
	},
	},]]
}
ScriptFightDB[113] = {              --------------噬魂阵——火心
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20053},{ID = 20054},{ID = 20054},{ID = 20054},{ID = 20054},},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
	--[[systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20053},bubbleID = 107},},
		  }
	},
	[2] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 10 },},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20053},bubbleID = 108},},
		  {type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
		  }
	},
	},]]
}
ScriptFightDB[114] = {              --------------万魂大阵——张梁
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20055}},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
}
ScriptFightDB[115] = {              --------------封神台——张角	
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20056},},
	npcs = {{ID = 20028},{ID = 20032},{ID = 20037},},--跟随NPC，刘备、关羽、张飞。
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20056,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20056,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20056},bubbleID = 109},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20056,},},},
		  }
	},
	},
}
ScriptFightDB[116] = {              --------------御花园——御花园统领
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20060},{ID = 20057},{ID = 20057},{ID = 20058},{ID = 20058},},
}
ScriptFightDB[117] = {              --------------御花园——蹇硕副将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20061},{ID = 20057},{ID = 20057},{ID = 20058},{ID = 20058},},
}
ScriptFightDB[118] = {              --------------御花园——蹇硕
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20062},{ID = 20057},{ID = 20057},{ID = 20058},{ID = 20058},},
}
ScriptFightDB[119] = {              --------------御花园——阉党头目
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20065},{ID = 20063},{ID = 20063},{ID = 20064},{ID = 20064},},
}
ScriptFightDB[120] = {              --------------御花园——张让亲卫
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20066},{ID = 20063},{ID = 20063},{ID = 20064},{ID = 20064},},
}
ScriptFightDB[121] = {              --------------御花园——张让	
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20067},{ID = 20063},{ID = 20063},{ID = 20064},{ID = 20064},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20067,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20067,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20067},bubbleID = 110},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20067,},},},
		  }
	},
	},
}
ScriptFightDB[122] = {              --------------御花园——冒牌御前侍卫头目
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20069},{ID = 20068},{ID = 20068},{ID = 20068},{ID = 20068},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 111},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20069},bubbleID = 112},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 113},},
		  }
	},
	},
}
ScriptFightDB[123] = {              --------------洛阳——赵忠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20070},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20070,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20070,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20070},bubbleID = 114},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20070,},},},
		  }
	},
	},
}
ScriptFightDB[124] = {              --------------黑风山——探子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20071},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20071},bubbleID = 122},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 123},},
		  }
	},
	[2] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20071,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20071,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20071},bubbleID = 115},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20071,},},},
		  }
	},
	},
}
ScriptFightDB[125] = {              --------------黑风山——黑风山贼将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20074},{ID = 20072},{ID = 20072},{ID = 20073},{ID = 20073},},
}
ScriptFightDB[126] = {              --------------黑风山——黑风山守卫
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20075},{ID = 20072},{ID = 20072},{ID = 20073},{ID = 20073},},
}
ScriptFightDB[127] = {              --------------黑风山——张燕
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20076},{ID = 20072},{ID = 20072},{ID = 20073},{ID = 20073},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20076,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20076,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20076},bubbleID = 116},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20076,},},},
		  }
	},
	},
}
ScriptFightDB[128] = {              --------------黑风洞——黑风老妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20077},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
		  },
		  actions = {
          {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 117},},
		  {type = ScriptFightActionType.MakeEscape,params={} },
		  }
	},
	},
}
ScriptFightDB[129] = {              --------------黑风洞——黑风老妖2
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20077},},
	npcs = {{ID = 20079},},--跟随NPC，金霞童子
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20077,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20077,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20077},bubbleID = 118},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20077,},},},
		  }
	},
	},
}
ScriptFightDB[130] = {              --------------堳坞——镇营大将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20082},{ID = 20080},{ID = 20080},{ID = 20081},{ID = 20081},},
}
ScriptFightDB[131] = {              --------------堳坞——樊定
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20083},{ID = 20080},{ID = 20080},{ID = 20081},{ID = 20081},},
}
ScriptFightDB[132] = {              --------------堳坞——樊稠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20084},{ID = 20080},{ID = 20080},{ID = 20081},{ID = 20081},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20084,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20084,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20084},bubbleID = 119},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20084,},},},
		  }
	},
	},
}
ScriptFightDB[133] = {              --------------堳坞——堳坞魔将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20087},{ID = 20085},{ID = 20085},{ID = 20086},{ID = 20086},},
}
ScriptFightDB[134] = {              --------------堳坞——郿坞妖将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20088},{ID = 20085},{ID = 20085},{ID = 20086},{ID = 20086},},
}
ScriptFightDB[135] = {              --------------堳坞——飞廉
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20089},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
		  },
		  actions = {
          {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 120},},
		  {type = ScriptFightActionType.MakeEscape,params={} },
		  }
	},
	},
}
ScriptFightDB[136] = {              --------------孟津大营——副将统领
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20093},{ID = 20090},{ID = 20090},{ID = 20092},{ID = 20092},},
}
ScriptFightDB[137] = {              --------------孟津大营——李肃亲卫
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20094},{ID = 20090},{ID = 20090},{ID = 20092},{ID = 20092},},
}
ScriptFightDB[138] = {              --------------孟津大营——李肃
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20095},{ID = 20090},{ID = 20090},{ID = 20092},{ID = 20092},},
	systemActions = {
	[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20095,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20095,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20095},bubbleID = 121},},
          {type = ScriptFightActionType.EntityQuit,params={DBID ={20095,},},},
		  }
	},
	},
}
ScriptFightDB[139] = {              --------------潼关——侯成
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20098},{ID = 20096},{ID = 20097},{ID = 20111},{ID = 20112},},
}
ScriptFightDB[140] = {              --------------潼关——段煨
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20101},{ID = 20099},{ID = 20099},{ID = 20100},{ID = 20100},},
	npcs = {{ID = 20091},},--跟随NPC，袁绍
}
ScriptFightDB[141] = {              --------------潼关——董旻
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20109},{ID = 20102},{ID = 20103},{ID = 20104},{ID = 20105},},
	npcs = {{ID = 20091},},--跟随NPC，袁绍
}
----1-25级脚本战斗完事------

-------------------------------主线25-30脚本---------------------------------
ScriptFightDB[161] = {           --[[解救陈宫--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20305},{ID = 20303},{ID = 20304},{ID = 20310},{ID = 20311},},
}
ScriptFightDB[162] = {           --[[查探曹操下落--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20309},{ID = 20306},{ID = 20306},{ID = 20306},{ID = 20306},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20309,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20309,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={20309},bubbleID = 401},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={20309},}, }
			},
	},
},
}
ScriptFightDB[163] = {           --[[解救曹操--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20312},{ID = 20307},{ID = 20319},{ID = 20320},{ID = 20324},},
}
ScriptFightDB[164] = {           --[[再遇阻拦--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20317},{ID = 20316},{ID = 20328},{ID = 20329},{ID = 20332},},
	npcs = {{ID = 20313,},},
}
ScriptFightDB[165] = {           --[[驰援关羽--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20321},{ID = 20338},{ID = 20339},{ID = 20340},{ID = 20341},},
	npcs = {{ID = 20322,},},
}
ScriptFightDB[166] = {           --[[温酒斩华雄--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20325},{ID = 20323},{ID = 20343},{ID = 20344},{ID = 20345},},
	npcs = {{ID = 20322,},},
}
ScriptFightDB[167] = {             --[[降服张辽--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20331},{ID = 20330},{ID = 20346},{ID = 20347},{ID = 20348},},
	npcs = {{ID = 20322,},{ID = 20326,},{ID = 20327,},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20331,type="hp",["<="]=30},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20331,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={20331},bubbleID = 402},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={20331},}, }
			},
	},
},
}
ScriptFightDB[168] = {             --[[三英战吕布--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20335},},
	npcs = {{ID = 20322,},{ID = 20326,},{ID = 20327,},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20335,type="hp",["<="]=30},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20335,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={20335},bubbleID = 403},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={20335},}, }
			},
	},
},
}
ScriptFightDB[169] = {             --[[大战魔化吕布--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20342},},
	npcs = {{ID = 20322,},{ID = 20326,},{ID = 20327,},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20342,type="hp",["<="]=30},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20342,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={20342},bubbleID = 404},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={20342},}, }
			},
	},
},
}
 --[[护送曹操--]]
ScriptFightDB[170] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20314},{ID = 20306},{ID = 20306},{ID = 20306},{ID = 20306},},
	npcs = {{ID = 20313,},},
}
ScriptFightDB[171] = {           
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20315},{ID = 20314},{ID = 20314},{ID = 20314},{ID = 20314},},
	npcs = {{ID = 20313,},},
}
ScriptFightDB[172] = {           
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20316},{ID = 20315},{ID = 20315},{ID = 20315},{ID = 20315},},
	npcs = {{ID = 20313,},},
}


----------------31-32级主线-----------------------
ScriptFightDB[175] = {             --[[查探孙坚下落--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20601},{ID = 20603},{ID = 20603},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20601,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20601,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={20601},bubbleID = 410},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={20601},}, }
			},
	},
},
}
ScriptFightDB[176] = {            --[[救下孙坚--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20602},{ID = 20604},{ID = 20629},{ID = 20630},{ID = 20631},},
}
ScriptFightDB[177] = {            --[[救人于水火--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20605},{ID = 20632},{ID = 20633},{ID = 20634},{ID = 20635},},
	systemActions = {
			[1] = {
				condition = {
				            {type = ScriptFightConditionType.AttrValue, params={DBID = 20605,type="hp",["<="]=50},},
						{type = ScriptFightConditionType.AttrValue, params={DBID = 20605,type="hp",[">"] = 0},},
						isAnd = true,
				 },
				 actions = {
				 {type = ScriptFightActionType.PlayBubble,params={DBID={20605},bubbleID = 411},},
				 {type = ScriptFightActionType.EntityQuit,params={DBID ={20605},}, }
					  },
			},
	},
}
ScriptFightDB[178] = {           --[[营救朱治吴景--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20609},{ID = 20604},{ID = 20604},{ID = 20604},{ID = 20604},},
}
ScriptFightDB[179] = {           --[[探寻黄盖--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20610},{ID = 20611},{ID = 20611},{ID = 20611},{ID = 20611},},
	systemActions = {
			[1] = {
				condition = {
				            {type = ScriptFightConditionType.AttrValue, params={DBID = 20610,type="hp",["<="]=40},},
					    {type = ScriptFightConditionType.AttrValue, params={DBID = 20610,type="hp",[">"] = 0},},
					     isAnd = true,
				 },
				 actions = {
				 {type = ScriptFightActionType.PlayBubble,params={DBID={20610},bubbleID = 412},},
				 {type = ScriptFightActionType.EntityQuit,params={DBID ={20610},} },
			     },
			},
	},
}
ScriptFightDB[180] = {           --[[营救黄盖--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20612},{ID = 20603},{ID = 20603},{ID = 20603},{ID = 20603},},
}
ScriptFightDB[181] = {           --[[营救黄盖（梁兴）--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20613},{ID = 20614},{ID = 20614},},
}
ScriptFightDB[182] = {           --[[妖兵之谜--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20615},{ID = 20616},{ID = 20616},{ID = 20616},{ID = 20616},},
	systemActions = {
			[1] = {
				condition = {
				            {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
						isAnd = true,
				 },
				 actions = {
				 {type = ScriptFightActionType.PlayBubble,params={DBID={20615},bubbleID = 415},},
				 {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 418},},
			     },
			},
			[2] = {
				condition = {
				            {type = ScriptFightConditionType.AttrValue, params={DBID = 20615,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 20615,type="hp",[">"] = 0},},
							isAnd = true,
				 },
				 actions = {
				 {type = ScriptFightActionType.PlayBubble,params={DBID={20615},bubbleID = 413},},
				 {type = ScriptFightActionType.EntityQuit,params={DBID ={20615},} },
			     },
			},
	},
}
ScriptFightDB[183] = {           --[[护阵大将--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20617},{ID = 20618},{ID = 20637},},
	systemActions = {
			[1] = {
				condition = {
				            {type = ScriptFightConditionType.AttrValue, params={DBID = 20617,type="hp",["<="]=40},},
					    {type = ScriptFightConditionType.AttrValue, params={DBID = 20617,type="hp",[">"] = 0},},
					     isAnd = true,
				 },
				 actions = {
				 {type = ScriptFightActionType.PlayBubble,params={DBID={20617},bubbleID = 414},},
				 {type = ScriptFightActionType.EntityQuit,params={DBID ={20617,20618,20637},} },
			     },
			},
	},
}
ScriptFightDB[184] = {           --[[探查妖阵--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20619},},
}
ScriptFightDB[185] = {           --[[金缠之魂--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20620},},
}
ScriptFightDB[186] = {           --[[烬枝之魂--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20621},},
	systemActions = {
			[1] = {
				condition = {
				 {type = ScriptFightConditionType.RoundCount, params={ round =1 },},
				isAnd = true,
				 },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 416},},
				{type = ScriptFightActionType.PlayBubble,params={DBID={20621},bubbleID = 417},},	
					 },
				},
			},
}
ScriptFightDB[187] = {           --[[火魁之魂--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20622},},
}
ScriptFightDB[188] = {           --[[天禄之魂--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20623},},
}
ScriptFightDB[189] = {           --[[战吕岳--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20624},},
}
ScriptFightDB[190] = {           --[[铲除徐荣--]]
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20605},{ID = 20616},{ID = 20616},{ID = 20618},{ID = 20618},},
}

----------------33-34级主线-----------------------

ScriptFightDB[200] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID =20704},{ID = 20737},{ID = 20739},{ID = 20736},{ID = 20738},},
}
ScriptFightDB[201] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID =20720},{ID = 20740},{ID = 20742},{ID = 20741},{ID = 20743},},
}
ScriptFightDB[202] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID =20703},},	
}
ScriptFightDB[203] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20707},},
	systemActions = {
	      [1] = {
               	 condition = {
 		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20707,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20707,type="hp",[">"] =0},},
		  isAnd = true,
		  },
	         actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20707},bubbleID = 421},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20707,},}, },
		  },
		  },
},
}
ScriptFightDB[204] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20708},{ID = 20745},{ID = 20747},{ID = 20744},{ID = 20746},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20708,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20708,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20708},bubbleID = 422},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20708,},}, },
		  },
		  },
},
}
ScriptFightDB[205] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20710},{ID = 20721},{ID = 20754},{ID = 20722},{ID = 20753},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20710,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20710,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20710},bubbleID = 428},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20710,},}, },
		  },
		  },
},
}
ScriptFightDB[206] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20709},{ID = 20756},{ID = 20758},{ID = 20755},{ID = 20757},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20709,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20709,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20709},bubbleID = 425},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20709,},}, },
		  },
		  },
},
}
ScriptFightDB[207] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20712},},	
}
ScriptFightDB[208] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20713},{ID = 20762},{ID = 20763},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20713,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20713,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20713},bubbleID = 424},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20713,},},},
		  },
},
},
}
ScriptFightDB[209] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20715},{ID = 20723},{ID = 20760},{ID = 20759},{ID = 20761},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20715,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20715,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20715},bubbleID = 425},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20715,},},}
		  },
},
},
}
ScriptFightDB[210] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20716},{ID = 20748},{ID = 20749},},
}
ScriptFightDB[211] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID =20717},{ID = 20748},{ID = 20749},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20717,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20717,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20717},bubbleID = 428},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 429},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20717,},},}
		  },
},
},
}
ScriptFightDB[212] = {         ---33-34级主线任务
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20718},{ID = 20724},{ID = 20727},{ID = 20750},{ID = 20751},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20718,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20718,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20718},bubbleID = 430},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20718,},},}
		  },
},
},
	
}

ScriptFightDB[213] = {         ---33-34级主线任务魔化吕布
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20707},},
	systemActions ={
	      [1] =
	      {
		  condition = {
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20707,type="hp",["<="] =40},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20707,type="hp",[">"] =0},},
		  isAnd = true,
		  count = 1,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 426},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20707},bubbleID = 427},},
                  {type = ScriptFightActionType.FightEnd,params={winner = "player"},},
		  },
},
},
}


-------------------------------------------35-36级主线-----------------------------------------------------
ScriptFightDB[220] = {             -----------------牛辅
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20804},{ID = 20802},{ID = 20802},{ID = 20803},{ID = 20803}},
	systemActions = {
	          [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20804,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20804,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20804},bubbleID = 432},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20804,},} },
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[221] = {             -----------------左灵
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20809},{ID = 20805},{ID = 20805},{ID = 20806},{ID = 20806}},
	systemActions = {
	          [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20809,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20809,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20809},bubbleID = 433},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20809,},} },
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[222] = {             -----------------梁冀
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20812},{ID = 20807},{ID = 20808},{ID = 20810},{ID = 20811}},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20812,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20809,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20809},bubbleID = 433},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20809,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[223] = {             -----------------李儒
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20813},},
	systemActions = {
	          [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20813},bubbleID = 434},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20813,},} },
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[224] = {             -----------------臧霸
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20816},{ID = 20814},{ID = 20814},{ID = 20815},{ID = 20815}},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20813},bubbleID = 434},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20813,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[225] = {             -----------------邪教魔化护法
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20817},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20813},bubbleID = 434},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20813,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[226] = {             -----------------郭汜
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20818},{ID = 20814},{ID = 20814},{ID = 20815},{ID = 20815}},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20813},bubbleID = 434},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20813,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[227] = {             -----------------金翅大鹏王
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20819},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20813,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20813},bubbleID = 434},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20813,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[228] = {             -----------------高顺
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20820},{ID = 20814},{ID = 20814},{ID = 20815},{ID = 20815}},
	systemActions = {
	          [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20820,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20820,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20820},bubbleID = 435},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20820,},} },
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[229] = {             -----------------守护灵兽
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20821},},
	systemActions = {
	          [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20821,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20821,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20821},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20821,},} },
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[230] = {             -----------------牛魔
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20822},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[231] = {             -----------------雪融木-第一波怪
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10026},{ID = 10027},{ID = 10027},{ID = 10029},{ID = 10029}},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[232] = {             -----------------雪融木-第二波怪
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20823},{ID = 10027},{ID = 10027},{ID = 10029},{ID = 10029}},
	systemActions = {
	           [1] = {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20823},bubbleID = 439},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 440},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20823},bubbleID = 441},},
				   }
	},
	          [2] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20823,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20823,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20823},bubbleID = 437},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20823,},} },
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[233] = {             -----------------胡大力
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20824},{ID = 20832},{ID = 20832},{ID = 20832},{ID = 20832}},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[234] = {             -----------------守阵阵灵1
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20825},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[235] = {             -----------------守阵阵灵2
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20826},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[236] = {             -----------------守阵阵灵3
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20827},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[237] = {             -----------------守阵阵灵4
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20828},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[238] = {             -----------------大魔飞廉
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20830},},
	npcs = {{ID = 20801,},},
	systemActions = {
	          --[[[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",["<="] = 20},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20822,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20822},bubbleID = 436},},
                  {type = ScriptFightActionType.EntityQuit,params={DBID ={20822,},} },
				   }
	},--]]
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
ScriptFightDB[239] = {             -----------------董卓
	backgroundMusic = nil,
	backgroundPic = nil,
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20831},},
	npcs = {{ID = 20801,},},
	systemActions = {
	          [1] = {
		  condition = {
		 {type = ScriptFightConditionType.AttrValue, params={DBID = 20831,type="hp",["<="] = 0},},
		 {type = ScriptFightConditionType.AttrValue, params={DBID = 20831,type="hp",[">"] = 0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20831},bubbleID = 438},},
				   }
	},
	},
	rewards={
	          mats={{ID=10001,count = 1}},
	},
}
-------------------------------------------37-38级主线-----------------------------------------------------
ScriptFightDB[301] = {  
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20901},{ID = 20902},{ID = 20902},{ID = 20903},{ID = 20903},},
	systemActions = {
		[1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20901,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20901,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20901},bubbleID = 451},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20901},},},
		  },
},
},
}
ScriptFightDB[302] = {        
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20905},{ID = 20906},{ID = 20906},{ID = 20907},{ID = 20907},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20905,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20905,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20905},bubbleID = 452},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20905},},},
		  },
},
},
}
ScriptFightDB[303] = {        
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20908},{ID = 20909},{ID = 20909},{ID = 20910},{ID = 20910},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20908,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20908,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20908},bubbleID = 453},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20908},},},
		  },
},
},
}
ScriptFightDB[304] = {        
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20911},{ID = 20912},{ID = 20912},{ID = 20913},{ID = 20913},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20911,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20911,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20911},bubbleID = 454},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20911},},},
		  },
},
},
}
ScriptFightDB[305] = {        
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20914},{ID = 20915},{ID = 20915},{ID = 20916},{ID = 20916},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20914,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20914,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20914},bubbleID = 455},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20914},},},
		  },
},
},
}
ScriptFightDB[306] = {        
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20917},{ID = 20918},{ID = 20918},{ID = 20919},{ID = 20919},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20917,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20917,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20917},bubbleID = 456},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20917},},},
		  },
},
},
}
ScriptFightDB[307] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20920},{ID = 20921},{ID = 20921},{ID = 20922},{ID = 20922},},
}
ScriptFightDB[308] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20923},{ID = 20921},{ID = 20921},{ID = 20924},{ID = 20924},},
}
ScriptFightDB[309] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20925},{ID = 20927},{ID = 20927},{ID = 20926},{ID = 20926},},
}
ScriptFightDB[310] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20930},{ID = 20931},{ID = 20931},{ID = 20932},{ID = 20932},},
}
ScriptFightDB[311] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20934},{ID = 20935},{ID = 20935},{ID = 20936},{ID = 20936},},
}
ScriptFightDB[312] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20937},{ID = 20938},{ID = 20938},{ID = 20939},{ID = 20939},},
}
ScriptFightDB[313] = {        
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20940},{ID = 20941},{ID = 20941},{ID = 20942},{ID = 20942},},
	systemActions = {
	      [1] = {
		  condition = {
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 20940,type="hp",["<="] =20},},
		   {type = ScriptFightConditionType.AttrValue, params={DBID = 20940,type="hp",[">"] =0},},
		  isAnd = true,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={20940},bubbleID = 455},},
		    {type = ScriptFightActionType.EntityQuit,params={DBID ={20940},},},
		  },
},
},
}
ScriptFightDB[314] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20943},},
}
-------------------------------------------39-40级主线-----------------------------------------------------
ScriptFightDB[401] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21001},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21001,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21001,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21001},bubbleID = 461},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21001},}, }
			},
	},
},
}
ScriptFightDB[402] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21002},{ID = 21020},{ID = 21020},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21002,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21002,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21002},bubbleID = 462},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21002},}, }
			},
	},
},
}
ScriptFightDB[403] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21004},{ID = 21021},{ID = 21021},},
    systemActions =
	{
	      [1] =
	      {
		  condition = {
		  {type = ScriptFightConditionType.RoundCount, params={ round = 10,},},
		  isAnd = true,
		  count = 1,
		  },
		  actions = {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={21004},bubbleID = 463},},
		  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 464},},
                  {type = ScriptFightActionType.FightEnd,params={winner = "player"},}
		  },
	      },
	},
}
ScriptFightDB[404] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21005},},
}
ScriptFightDB[405] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21006},{ID = 21022},{ID = 21022},{ID = 21023},{ID = 21023},},
}
ScriptFightDB[406] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21007},{ID = 21024},{ID = 21025},{ID = 21024},{ID = 21025},},
}
ScriptFightDB[407] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21008},{ID = 21026},{ID = 21026},},
}
ScriptFightDB[408] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21010},},
}
ScriptFightDB[409] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21011},{ID = 21027},{ID = 21028},{ID = 21027},{ID = 21028},},
}
ScriptFightDB[410] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21012},{ID = 21027},{ID = 21028},{ID = 21027},{ID = 21028},},
}
ScriptFightDB[411] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21014},{ID = 21027},{ID = 21028},{ID = 21027},{ID = 21028},},
}
ScriptFightDB[412] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21016},{ID = 21031},{ID = 21031},},
    systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21016,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21016,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21016},bubbleID = 465},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21016},}, }
			},
	},
},
}
ScriptFightDB[413] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21017},{ID = 21031},{ID = 21031},},
    systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21017,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21017,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21017},bubbleID = 466},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21017},}, }
			},
	},
},
}
ScriptFightDB[414] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21018},{ID = 21029},{ID = 21030},{ID = 21029},{ID = 21030},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21018,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21018,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21018},bubbleID = 467},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21018},}, }
			},
	},
},
}
ScriptFightDB[415] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21019},{ID = 21029},{ID = 21030},{ID = 21029},{ID = 21030},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21019,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21019,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21019},bubbleID = 468},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21019},}, }
			},
	},
},
}
-------------------------------------------41-42级主线-----------------------------------------------------
ScriptFightDB[451] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21103},{ID = 21101},{ID = 21102},{ID = 21101},{ID = 21102},},
}
ScriptFightDB[452] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21104},{ID = 21101},{ID = 21102},{ID = 21101},{ID = 21102},},
}
ScriptFightDB[453] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21105},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21105},bubbleID = 481},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21105},}, }
			},
	},
},
}
ScriptFightDB[454] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21109},{ID = 21107},{ID = 21108},{ID = 21107},{ID = 21108},},
}
ScriptFightDB[455] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21110},{ID = 21107},{ID = 21108},{ID = 21107},{ID = 21108},},
}
ScriptFightDB[456] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21111},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21111,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21111,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21111},bubbleID = 482},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21111},}, }
			},
	},
},
}
ScriptFightDB[457] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21114},{ID = 21112},{ID = 21113},{ID = 21112},{ID = 21113},},
}
ScriptFightDB[458] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21115},{ID = 21112},{ID = 21113},{ID = 21112},{ID = 21113},},
}
ScriptFightDB[459] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21116},},
}
ScriptFightDB[460] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21119},{ID = 21117},{ID = 21118},{ID = 21117},{ID = 21118},},
}
ScriptFightDB[461] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21120},{ID = 21117},{ID = 21118},{ID = 21117},{ID = 21118},},
}
ScriptFightDB[462] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21121},},
}
ScriptFightDB[463] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21125},{ID = 21123},{ID = 21124},{ID = 21123},{ID = 21124},},
npcs = {{ID = 21122},},--跟随NPC曹仁
}
ScriptFightDB[464] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21126},{ID = 21123},{ID = 21124},{ID = 21123},{ID = 21124},},
npcs = {{ID = 21122},},--跟随NPC曹仁
}
ScriptFightDB[465] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21127},},
npcs = {{ID = 21122},},--跟随NPC曹仁
}
ScriptFightDB[466] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21130},{ID = 21128},{ID = 21129},{ID = 21128},{ID = 21129},},
npcs = {{ID = 21122},},--跟随NPC曹仁
}
ScriptFightDB[467] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21131},{ID = 21128},{ID = 21129},{ID = 21128},{ID = 21129},},
npcs = {{ID = 21122},},--跟随NPC曹仁
}
ScriptFightDB[468] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21132},},
npcs = {{ID = 21122},},--跟随NPC曹仁
}
ScriptFightDB[469] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21136},{ID = 21134},{ID = 21135},{ID = 21134},{ID = 21135},},
}
ScriptFightDB[470] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21137},{ID = 21134},{ID = 21135},{ID = 21134},{ID = 21135},},
}
ScriptFightDB[471] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21138},},
}
ScriptFightDB[472] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21139},{ID = 21134},{ID = 21135},{ID = 21134},{ID = 21135},},
}
ScriptFightDB[473] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21140},{ID = 21134},{ID = 21135},{ID = 21134},{ID = 21135},},
}
ScriptFightDB[474] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21141},},
}
ScriptFightDB[475] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21144},{ID = 21142},{ID = 21143},{ID = 21142},{ID = 21143},},
}
ScriptFightDB[476] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21145},{ID = 21142},{ID = 21143},{ID = 21142},{ID = 21143},},
}
ScriptFightDB[477] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21146},},
}
ScriptFightDB[478] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21149},{ID = 21147},{ID = 21148},{ID = 21147},{ID = 21148},},
}
ScriptFightDB[479] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21150},{ID = 21147},{ID = 21148},{ID = 21147},{ID = 21148},},
}
ScriptFightDB[480] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21151},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21151,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21151,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21151},bubbleID = 483},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21151},}, }
			},
	},
},
}
ScriptFightDB[481] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21155},{ID = 21153},{ID = 21154},{ID = 21153},{ID = 21154},},
}
ScriptFightDB[482] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21156},{ID = 21153},{ID = 21154},{ID = 21153},{ID = 21154},},
}
ScriptFightDB[483] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21157},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21157,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21157,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21157},bubbleID = 484},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21157},}, }
			},
	                      },
},
}
ScriptFightDB[484] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21161},{ID = 21159},{ID = 21160},{ID = 21159},{ID = 21160},},
}
ScriptFightDB[485] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21162},{ID = 21159},{ID = 21160},{ID = 21159},{ID = 21160},},
}
ScriptFightDB[486] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21163},},
}

-------------------------------------------43-44级主线-----------------------------------------------------
ScriptFightDB[501] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21203},{ID = 21204},{ID = 21205},{ID = 21206},{ID = 21207},},
}
ScriptFightDB[502] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21208},{ID = 21204},{ID = 21205},{ID = 21206},{ID = 21207},},
}
ScriptFightDB[503] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21209},{ID = 21204},{ID = 21205},{ID = 21206},{ID = 21207},},
}
ScriptFightDB[504] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21211},{ID = 21212},{ID = 21213},{ID = 21214},{ID = 21215},},
	npcs = {{ID = 21210},},
}
ScriptFightDB[505] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21216},{ID = 21212},{ID = 21213},{ID = 21214},{ID = 21215},},
	npcs = {{ID = 21210},},
}
ScriptFightDB[506] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21217},{ID = 21212},{ID = 21213},{ID = 21214},{ID = 21215},},
	npcs = {{ID = 21210},},
}
ScriptFightDB[507] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21218},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
}
ScriptFightDB[508] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21223},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
}
ScriptFightDB[509] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21224},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21224,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21224,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21224},bubbleID = 510},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21224},}, }
			},
	},
},
}
ScriptFightDB[510] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21225},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
}
ScriptFightDB[511] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21226},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
}
ScriptFightDB[512] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21227},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
}
ScriptFightDB[513] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21229},{ID = 21230},{ID = 21231},{ID = 21232},{ID = 21233},},
	npcs = {{ID = 21228},},
}
ScriptFightDB[514] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21234},{ID = 21230},{ID = 21231},{ID = 21232},{ID = 21233},},
	npcs = {{ID = 21228},},
}
ScriptFightDB[515] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21235},{ID = 21230},{ID = 21231},{ID = 21232},{ID = 21233},},
	npcs = {{ID = 21228},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21235,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21235,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21235},bubbleID = 511},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21235},}, }
			},
	},
},
}
ScriptFightDB[516] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21236},{ID = 21230},{ID = 21231},{ID = 21232},{ID = 21233},},
	npcs = {{ID = 21228},},
}
ScriptFightDB[517] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21237},{ID = 21230},{ID = 21231},{ID = 21232},{ID = 21233},},
	npcs = {{ID = 21228},},
}
ScriptFightDB[518] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21238},{ID = 21230},{ID = 21231},{ID = 21232},{ID = 21233},},
	npcs = {{ID = 21228},},
}
ScriptFightDB[519] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21240},{ID = 21241},{ID = 21242},{ID = 21243},{ID = 21244},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[520] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21245},{ID = 21241},{ID = 21242},{ID = 21243},{ID = 21244},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[521] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21246},},
	npcs = {{ID = 21239},{ID = 21228},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21246,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21246,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21246},bubbleID = 512},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21246},}, }
			},
	},
},
}
ScriptFightDB[522] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21247},{ID = 21248},{ID = 21249},{ID = 21250},{ID = 21251},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[523] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21252},{ID = 21248},{ID = 21249},{ID = 21250},{ID = 21251},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[524] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21253},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[525] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21254},{ID = 21256},{ID = 21257},{ID = 21258},{ID = 21259},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[526] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21255},{ID = 21256},{ID = 21257},{ID = 21258},{ID = 21259},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[527] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21260},{ID = 21256},{ID = 21257},{ID = 21258},{ID = 21259},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[528] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21261},{ID = 21256},{ID = 21257},{ID = 21258},{ID = 21259},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[529] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21262},{ID = 21256},{ID = 21257},{ID = 21258},{ID = 21259},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[530] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21263},{ID = 21256},{ID = 21257},{ID = 21258},{ID = 21259},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[531] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21264},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[532] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21265},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[533] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21266},{ID = 21219},{ID = 21220},{ID = 21221},{ID = 21222},},
	npcs = {{ID = 21239},{ID = 21228},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21266,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21266,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21266},bubbleID = 513},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21266},}, }
			},
	},
},
}
ScriptFightDB[534] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21267},{ID = 21269},{ID = 21270},{ID = 21271},{ID = 21272},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[535] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21268},{ID = 21269},{ID = 21270},{ID = 21271},{ID = 21272},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[536] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21273},{ID = 21269},{ID = 21270},{ID = 21271},{ID = 21272},},
	npcs = {{ID = 21239},{ID = 21228},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21273,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21273,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21273},bubbleID = 514},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21273},}, }
			},
	},
},
}
ScriptFightDB[537] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21274},{ID = 21276},{ID = 21277},{ID = 21271},{ID = 21272},},
        npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[538] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21275},{ID = 21276},{ID = 21277},{ID = 21271},{ID = 21272},},
	npcs = {{ID = 21239},{ID = 21228},},
}
ScriptFightDB[539] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21278},{ID = 21276},{ID = 21277},{ID = 21271},{ID = 21272},},
	npcs = {{ID = 21239},{ID = 21228},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21278,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21278,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21278},bubbleID = 515},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21278},}, }
			},
	},
},
}
-------------------------------------------45-46级主线-----------------------------------------------------
ScriptFightDB[601] = {              --------------河北——河北守将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21302},{ID = 21301,},{ID = 21301,},{ID = 21301,},{ID = 21301,},},
}
ScriptFightDB[602] = {              --------------河北——河北副将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21303},{ID = 21301,},{ID = 21301,},{ID = 21301,},{ID = 21301,},},
}
ScriptFightDB[603] = {              --------------河北——审配
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21304},{ID = 21301,},{ID = 21301,},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21304,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21304,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21304},bubbleID = 530},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21304},}, }
			    },
	       },
     },
}
ScriptFightDB[604] = {              --------------邺城——吕旷
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21306},{ID = 21305,},{ID = 21305,},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21306,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21306,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21306},bubbleID = 531},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21306},}, }
			    },
	       },
     },
}
ScriptFightDB[605] = {              --------------辽东——袁军守将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21308},{ID = 21307,},{ID = 21307,},{ID = 21307,},{ID = 21307,},},
}
ScriptFightDB[606] = {              --------------辽东——袁军副将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21309},{ID = 21307,},{ID = 21307,},{ID = 21307,},{ID = 21307,},},
}
ScriptFightDB[607] = {              --------------辽东——高翔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21310},{ID = 21307,},{ID = 21307,},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21310,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21310,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21310},bubbleID = 532},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21310},}, }
			    },
	       },
     },
}
ScriptFightDB[608] = {              --------------辽东——冯礼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21315},{ID = 21311,},{ID = 21312,},{ID = 21313,},{ID = 21314,},},
}
ScriptFightDB[609] = {              --------------辽东——袁军偏将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21318},{ID = 21317,},{ID = 21317,},{ID = 21317,},{ID = 21317,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[610] = {              --------------辽东——袁军统领
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21319},{ID = 21317,},{ID = 21317,},{ID = 21317,},{ID = 21317,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[611] = {              --------------辽东——郭援
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21320},{ID = 21317,},{ID = 21317,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[612] = {              --------------易京城——袁军攻城将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21322},{ID = 21321,},{ID = 21321,},{ID = 21321,},{ID = 21321,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[613] = {              --------------易京城——袁军铁甲将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21323},{ID = 21321,},{ID = 21321,},{ID = 21321,},{ID = 21321,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[614] = {              --------------易京城——吕威璜
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21324},{ID = 21321,},{ID = 21321,},},
	npcs = {{ID = 21316},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21324,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21324,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21324},bubbleID = 533},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21324},}, }
			    },
	       },
     },
}
ScriptFightDB[615] = {              --------------易京城——易京守将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21326},{ID = 21325,},{ID = 21325,},{ID = 21325,},{ID = 21325,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[616] = {              --------------易京城——易京偏将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21327},{ID = 21325,},{ID = 21325,},{ID = 21325,},{ID = 21325,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[617] = {              --------------易京城——牵招
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21328},{ID = 21325,},{ID = 21325,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[620] = {              --------------易京城——文丑
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21332},{ID = 21329,},{ID = 21329,},},
	npcs = {{ID = 21316},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21332,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21332,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21332},bubbleID = 534},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21332},}, }
			    },
	       },
     },
}
ScriptFightDB[621] = {              --------------河北——河北偏将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21334},{ID = 21333,},{ID = 21333,},{ID = 21333,},{ID = 21333,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[622] = {              --------------河北——河北都尉
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21335},{ID = 21333,},{ID = 21333,},{ID = 21333,},{ID = 21333,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[623] = {              --------------河北——焦触
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21336},{ID = 21333,},{ID = 21333,},},
	npcs = {{ID = 21316},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21336,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21336,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21336},bubbleID = 535},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21336},}, }
			    },
	       },
     },
}
ScriptFightDB[624] = {              --------------邺城——邺城守将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21341},{ID = 21337,},{ID = 21338,},{ID = 21339,},{ID = 21340,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[625] = {              --------------邺城——邺城参将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21342},{ID = 21337,},{ID = 21338,},{ID = 21339,},{ID = 21340,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[626] = {              --------------邺城——邓升
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21343},{ID = 21337,},{ID = 21338,},{ID = 21339,},{ID = 21340,},},
	npcs = {{ID = 21316},},
}
ScriptFightDB[629] = {              --------------邺城——赤云童子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21348},},
	npcs = {{ID = 21316},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21348,type="hp",["<="]=20},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21348,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21348},bubbleID = 536},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21348},}, }
			    },
	       },
     },
}
ScriptFightDB[630] = {              --------------濮阳——袁军前锋大将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21350},{ID = 21349,},{ID = 21349,},{ID = 21349,},{ID = 21349,},},
}
ScriptFightDB[631] = {              --------------濮阳——袁军金甲大将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21351},{ID = 21349,},{ID = 21349,},{ID = 21349,},{ID = 21349,},},
}
ScriptFightDB[632] = {              --------------濮阳——陶升
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21352},{ID = 21349,},{ID = 21349,},},
}
----------------------------------45-46任务完成---------------------------------
---------------------------------47-48主线任务--------------------------------------
--[[前往白马坡--]]
ScriptFightDB[651] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21402},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
ScriptFightDB[652] = {           
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21403},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
ScriptFightDB[653] = {           
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21404},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
--[[营救曹操--]]
ScriptFightDB[654] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21410},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
--[[杀入白马城--]]
ScriptFightDB[655] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21411},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
ScriptFightDB[656] = {           
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21412},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
ScriptFightDB[657] = {           
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21413},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
--[[突围白马城--]]
ScriptFightDB[658] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21415},{ID = 21405},{ID = 21406},{ID = 21407},{ID = 21408},},
	npcs = {{ID = 21401,},},
}
--[[斩颜良--]]
ScriptFightDB[659] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21416},{ID = 21417},{ID = 21418},{ID = 21419},{ID = 21420},},
	npcs = {{ID = 21401,},},
}
--[[寻找孙乾--]]
ScriptFightDB[660] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21422},{ID = 21423},{ID = 21424},{ID = 21425},{ID = 21426},},
}
--[[决意辞行--]]
ScriptFightDB[661] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21428},{ID = 21429},{ID = 21430},{ID = 21431},{ID = 21432},},
	npcs = {{ID = 21401,},},
}
--[[怒闯曹府--]]
ScriptFightDB[662] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21433},{ID = 21429},{ID = 21430},{ID = 21431},{ID = 21432},},
	npcs = {{ID = 21401,},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21433,type="hp",["<="]=30},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21433,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21433},bubbleID = 551},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21433},}, }
			    },
	       },
     },
}
--[[不辞而别--]]
ScriptFightDB[663] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21434},{ID = 21435},{ID = 21436},{ID = 21437},{ID = 21438},},
	npcs = {{ID = 21401,},},
}
--[[遭遇阻拦--]]
ScriptFightDB[664] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21439},{ID = 21435},{ID = 21436},{ID = 21437},{ID = 21438},},
	npcs = {{ID = 21401,},},
}
--[[击杀韩福--]]
ScriptFightDB[665] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21440},{ID = 21435},{ID = 21436},{ID = 21437},{ID = 21438},},
	npcs = {{ID = 21401,},},
}
--[[刀斩卞喜--]]
ScriptFightDB[666] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21441},{ID = 21435},{ID = 21436},{ID = 21437},{ID = 21438},},
	npcs = {{ID = 21401,},},
}
--[[王植之死--]]
ScriptFightDB[667] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21442},{ID = 21435},{ID = 21436},{ID = 21437},{ID = 21438},},
	npcs = {{ID = 21401,},},
}
--[[临近河北--]]
ScriptFightDB[668] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21443},{ID = 21435},{ID = 21436},{ID = 21437},{ID = 21438},},
	npcs = {{ID = 21401,},},
}
--[[收服周仓--]]
ScriptFightDB[669] = {          
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21444},{ID = 21445},{ID = 21446},{ID = 21447},{ID = 21448},},
	npcs = {{ID = 21401,},},
	systemActions = {
			[1] = {
				condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21444,type="hp",["<="]=30},},
				{type = ScriptFightConditionType.AttrValue, params={DBID = 21444,type="hp",[">"] = 0},},
				isAnd = true,
		         },
				actions = {
				{type = ScriptFightActionType.PlayBubble,params={DBID={21444},bubbleID = 552},},
				{type = ScriptFightActionType.EntityQuit,params={DBID ={21444},}, }
			    },
	       },
     },
}
--------------------------------------------------47-48主线任务完成------------------------------------------------------

-------------------------------------------49-50级主线-----------------------------------------------------
ScriptFightDB[701] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21501},{ID = 21503},{ID = 21504},{ID = 21505},{ID = 21506},},
	npcs = {{ID = 21557},{ID = 21554},},
}
ScriptFightDB[702] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21502},{ID = 21503},{ID = 21504},{ID = 21505},{ID = 21506},},
	npcs = {{ID = 21557},{ID = 21554},},
}
ScriptFightDB[703] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21507},{ID = 21503},{ID = 21504},{ID = 21505},{ID = 21506},},
	npcs = {{ID = 21557},{ID = 21554},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21507},bubbleID = 581},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21507},}, }
			},
	},
},
}
ScriptFightDB[704] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21508},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
	npcs = {{ID = 21557},{ID = 21554},},
}
ScriptFightDB[705] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21513},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
	npcs = {{ID = 21557},{ID = 21554},},
}
ScriptFightDB[706] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21515},{ID = 21533},{ID = 21534},},
	npcs = {{ID = 21557},{ID = 21554},{ID = 21514},},
}
ScriptFightDB[707] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21508},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
}
ScriptFightDB[708] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21516},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
}
ScriptFightDB[709] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21517},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21517},bubbleID = 582},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21517},}, }
			},
	},
},
}
ScriptFightDB[710] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21518},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
}
ScriptFightDB[711] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21519},{ID = 21509},{ID = 21510},{ID = 21511},{ID = 21512},},
}
ScriptFightDB[712] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21520},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
}
ScriptFightDB[713] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21523},{ID = 21525},{ID = 21526},{ID = 21527},{ID = 21528},},
	npcs = {{ID = 21522},},
}
ScriptFightDB[714] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21524},{ID = 21525},{ID = 21526},{ID = 21527},{ID = 21528},},
	npcs = {{ID = 21522},},
}
ScriptFightDB[715] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21529},{ID = 21525},{ID = 21526},{ID = 21527},{ID = 21528},},
	npcs = {{ID = 21522},},
}
ScriptFightDB[716] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21531},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
}
ScriptFightDB[717] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21532},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
}
ScriptFightDB[718] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21537},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",["<="]=20},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21537},bubbleID = 583},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21537},}, }
			},
	},
},
}
ScriptFightDB[719] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21538},{ID = 21540},{ID = 21541},{ID = 21542},{ID = 21543},},
}
ScriptFightDB[720] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21539},{ID = 21540},{ID = 21541},{ID = 21542},{ID = 21543},},
}
ScriptFightDB[721] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21544},{ID = 21540},{ID = 21541},{ID = 21542},{ID = 21543},},
}
ScriptFightDB[722] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21545},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
	npcs = {{ID = 21530},},
}
ScriptFightDB[723] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21546},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
	npcs = {{ID = 21530},},
}
ScriptFightDB[724] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21547},{ID = 21549},{ID = 21550},{ID = 21551},{ID = 21552},},
}
ScriptFightDB[725] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21548},{ID = 21549},{ID = 21550},{ID = 21551},{ID = 21552},},
}
ScriptFightDB[726] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21555},{ID = 21549},{ID = 21550},{ID = 21551},{ID = 21552},},
}
ScriptFightDB[727] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 21553},{ID = 21533},{ID = 21534},{ID = 21535},{ID = 21536},},
	systemActions = {
			[1] = {
				condition = {
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",["<="]=40},},
							{type = ScriptFightConditionType.AttrValue, params={DBID = 21105,type="hp",[">"] = 0},},
							isAnd = true,
		                 },
				 actions = {
					  {type = ScriptFightActionType.PlayBubble,params={DBID={21553},bubbleID = 584},},
					  {type = ScriptFightActionType.EntityQuit,params={DBID ={21553},}, }
			},
	},
},
}

------------------------------------------------副本分割线  -_- 大家好,我是分割线 --------------------------------------------------------------------------
ScriptFightDB[3001] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30001,},{ID = 30002,},{ID = 30003,},{ID = 30004,},{ID = 30005,},},
	--[[begin = {
			[1] = {
				condition = {
				          {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {

					  {type = ScriptFightActionType.PlayBubble,params={DBID={30001},bubbleID = 26144},},
					  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 26145},},
				 }
			},
	},]]
}
ScriptFightDB[3002] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30006,},{ID = 30007,},{ID = 30008,},{ID = 30009,},{ID = 30010,},},
	--[[begin = {
			[1] = {
				condition = {
				          {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {

					  {type = ScriptFightActionType.PlayBubble,params={DBID={30006},bubbleID = 26148},},
					  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 26149},},
				 }
			},
	},]]
}
ScriptFightDB[3003] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30011,},{ID = 30012,},{ID = 30013,},{ID = 30014,},{ID = 30015,},},
	--[[begin = {
			[1] = {
				condition = {
				          {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {

					  {type = ScriptFightActionType.PlayBubble,params={DBID={30011},bubbleID = 26152},},
					  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 26153},},
				 }
			},
	},]]
}
ScriptFightDB[3004] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30016,},{ID = 30017,},{ID = 30018,},{ID = 30019,},{ID = 30020,},},
	--[[begin = {
			[1] = {
				condition = {
				          {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {

					  {type = ScriptFightActionType.PlayBubble,params={DBID={30016},bubbleID = 26156},},
					  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 26157},},
				 }
			},
	},]]
}
ScriptFightDB[3005] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30021,},{ID = 30022,},{ID = 30023,},{ID = 30024,},{ID = 30025,},},
	--[[begin = {
			[1] = {
				condition = {
				          {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {

					  {type = ScriptFightActionType.PlayBubble,params={DBID={30021},bubbleID = 26160},},
					  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 26161},},
				 }
			},
	},]]
}
ScriptFightDB[3006] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30026,pos = 27},},
	--[[begin = {
			[1] = {
				condition = {
				          {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
					isAnd = true,
				 },
				 actions = {

					  {type = ScriptFightActionType.PlayBubble,params={DBID={30026},bubbleID = 26164},},
					  {type = ScriptFightActionType.PlayBubble,params={DBID={0},bubbleID = 26165},},
				 }
			},
	},]]
}
ScriptFightDB[3007] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30072,},{ID = 30071,},{ID = 30073,},{ID = 30070,},{ID = 30074,},{ID = 30462,},{ID = 30463,},{ID = 30464,},}
	}
ScriptFightDB[3008] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30075,},{ID = 30076,},{ID = 30078,},{ID = 30077,},{ID = 30079,},{ID = 30465,},{ID = 30466,},{ID = 30467,},}
	}
ScriptFightDB[3009] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30080,},{ID = 30081,},{ID = 30082,},{ID = 30083,},{ID = 30084,},{ID = 30468,},{ID = 30469,},{ID = 30470,},},
	}
ScriptFightDB[3010] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30085,},{ID = 30086,},{ID = 30087,},{ID = 30088,},{ID = 30089,},{ID = 30471,},{ID = 30472,},{ID = 30473,},},
	}
ScriptFightDB[3011] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30090,},{ID = 30091,},{ID = 30092,},{ID = 30093,},{ID = 30094,},{ID = 30474,},{ID = 30475,},{ID = 30476,},},
	}
ScriptFightDB[3012] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30095,pos = 27},},
	}

ScriptFightDB[3333] = {
	monsters = {type = ScriptMonsterCreateType.Random,{ID = 7,weight = 1},{ID = 20303,weight = 10000}, }	
}


ScriptFightDB[3017] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30184,},{ID = 30182, },{ID = 30183, },{ID = 30181, },{ID = 30185, },{ID = 30300, },{ID = 30301, },{ID = 30302, },},
	}
ScriptFightDB[3018] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30163, },{ID = 30161, },{ID = 30162, },{ID = 30160, },{ID = 30164, },{ID = 30303, },{ID = 30304, },{ID = 30305, },},
	}
ScriptFightDB[3019] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30168, },{ID = 30166, },{ID = 30167, },{ID = 30165, },{ID = 30169, },{ID = 30306, },{ID = 30307, },{ID = 30308, },},
	}
ScriptFightDB[3020] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30173, },{ID = 30171, },{ID = 30172, },{ID = 30170, },{ID = 30174, },{ID = 30309, },{ID = 30310, },{ID = 30311, },},
	}
ScriptFightDB[3021] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30178, },{ID = 30176, },{ID = 30177, },{ID = 30175, },{ID = 30178, },{ID = 30312, },{ID = 30313, },{ID = 30314, },},
	}
ScriptFightDB[3022] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30180,pos = 27 },},
	}

--潜龙岭
ScriptFightDB[3025] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30322, },{ID = 30324, },{ID = 30321, },{ID = 30326, },{ID = 30327, },{ID = 30328, },{ID = 30325, },{ID = 30323, },},
	}
ScriptFightDB[3026] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30334, },{ID = 30332, },{ID = 30329, },{ID = 30330, },{ID = 30335, },{ID = 30331, },{ID = 30336, },{ID = 30333, },},
	}
ScriptFightDB[3027] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30340, },{ID = 30338, },{ID = 30337, },{ID = 30342, },{ID = 30343, },{ID = 30344, },{ID = 30341, },{ID = 30339, },},
	}
ScriptFightDB[3028] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30350, },{ID = 30346, },{ID = 30345, },{ID = 30348, },{ID = 30351, },{ID = 30349, },{ID = 30352, },{ID = 30347, },},
	}
ScriptFightDB[3029] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30354, },{ID = 30353, },{ID = 30355, },{ID = 30358, },{ID = 30356, },{ID = 30359, },{ID = 30355, },{ID = 30360, },},
	}
ScriptFightDB[3030] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30361,pos = 26 },},
	}
---------------------鬼凤峡副本配置，顺便给楼下一个机会--------------------------------
ScriptFightDB[3031] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30421,},{ID = 30422, },{ID = 30423, },{ID = 30420, },{ID = 30424, },{ID = 30425, },{ID = 30426, },{ID = 30427, },},
	}
ScriptFightDB[3032] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30429,},{ID = 30430, },{ID = 30431, },{ID = 30428, },{ID = 30432, },{ID = 30433, },{ID = 30434, },{ID = 30435, },},
	}
ScriptFightDB[3033] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30437,},{ID = 30438, },{ID = 30439, },{ID = 30436, },{ID = 30440, },{ID = 30441, },{ID = 30442, },{ID = 30443, },},
	}
ScriptFightDB[3034] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30445,},{ID = 30446, },{ID = 30447, },{ID = 30444, },{ID = 30448, },{ID = 30449, },{ID = 30450, },{ID = 30451, },},
	}
ScriptFightDB[3035] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30453,},{ID = 30454, },{ID = 30455, },{ID = 30452, },{ID = 30456, },{ID = 30457, },{ID = 30458, },{ID = 30459, },},
	}
ScriptFightDB[3036] = {        ----鬼凤峡BOSS
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30453,},{ID = 30454, },{ID = 30455, },{ID = 30460, },{ID = 30456, },{ID = 30457, },{ID = 30458, },{ID = 30459, },},
	systemActions  = {                                                               

		   [1] = {								

			  condition = {						 
				
				  {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
			     },

			  actions = {							
                                  {type = ScriptFightActionType.PlayBubble,params={DBID={30460},bubbleID = 10037},},   ----第一回合bOSS喊话
				  {type = ScriptFightActionType.AddBuff,params={DBID ={30460},buffID = 68} },          ----添加 无敌buff
				
			   },
		   },
		   [2] = {								

			  condition = {						 
				
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30460,type="hp",["<="] = 0},},
				  count = 1,
			     },

			  actions = {							
                                  {type = ScriptFightActionType.PlayBubble,params={DBID={30460},bubbleID = 10038},},   ----第一回合bOSS喊话
				  {type = ScriptFightActionType.RemoveBuff,params={DBID ={30460,},buffID = 68} },          ----删除 无敌buff
				
			   },
		   },
		   [3] = {								

			  condition = {						 
				
				  {type = ScriptFightConditionType.RoundCount, params={ round = 3 },}, ----特殊小怪喊话
				  count = 1,
			     },

			  actions = {							
                                  {type = ScriptFightActionType.PlayBubble,params={DBID={30460},bubbleID = 10039},},   ----第3回合喊话
				  
				
			   },
		   },
							
	  },
	}

--------------------这里是碧波岛副本配置基地，千万不要击中友军！--------------------------------------
ScriptFightDB[3037] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30511,},{ID = 30512, },{ID = 30513, },{ID = 30510, },{ID = 30514, },{ID = 30515, },{ID = 30516, },{ID = 30517, },},
	}
ScriptFightDB[3038] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30519,},{ID = 30520, },{ID = 30521, },{ID = 30518, },{ID = 30522, },{ID = 30523, },{ID = 30524, },{ID = 30525, },},
	}
ScriptFightDB[3039] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30527,},{ID = 30528, },{ID = 30529, },{ID = 30526, },{ID = 30530, },{ID = 30531, },{ID = 30532, },{ID = 30533, },},
	}
ScriptFightDB[3040] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30535,},{ID = 30536, },{ID = 30537, },{ID = 30534, },{ID = 30538, },{ID = 30539, },{ID = 30540, },{ID = 30541, },},
	}
ScriptFightDB[3041] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30543,},{ID = 30544, },{ID = 30545, },{ID = 30542, },{ID = 30546, },{ID = 30547, },{ID = 30548, },{ID = 30549, },},
	}
ScriptFightDB[3042] = {        ----碧波岛BOSS     
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30550,pos = 27 },},
        systemActions  = {                                                               

		   [1] = {				---第一回合召唤小怪，小怪死亡不消失				

			  condition = {						 
				
				  {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
			     },

			  actions = {							
                                  {type = ScriptFightActionType.PlayBubble,params={DBID={30550},bubbleID = 10045},},   ----第一回合bOSS喊话
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30543,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30544,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30545,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30546,count = 1},} },         ----单位进场
				  isSameTime = true,
				
			   },
		   },
		   [2] = {								

			  condition = {						 
				
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30543,type="hp",["<="] = 0},},
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30544,type="hp",["<="] = 0},},
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30545,type="hp",["<="] = 0},},
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30546,type="hp",["<="] = 0},},
				  
			     },

			  actions = {							
                                  --{type = ScriptFightActionType.PlayBubble,params={DBID={30543},bubbleID = 10037},},   ----第一回合bOSS喊话
				  {type = ScriptFightActionType.SetGBH,params={DBID ={30543,30544,30545,30546},} },
				--设置单位死亡不离场：DBID = 单位ID，支持填入多个
				
			   },
		   },				
	  },
	}

-----冰风原---怎么这么多话说，不要删掉我的就行了--------------------
ScriptFightDB[3045] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30651, },{ID = 30653, },{ID = 30650, },{ID = 30655, },{ID = 30656, },{ID = 30657, },{ID = 30654, },{ID = 30652, },},
	}
ScriptFightDB[3046] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30662, },{ID = 30661, },{ID = 30658, },{ID = 30659, },{ID = 30663, },{ID = 30660, },{ID = 30664, },{ID = 30665, },},
	}
ScriptFightDB[3047] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30668, },{ID = 30671, },{ID = 30666, },{ID = 30670, },{ID = 30672, },{ID = 30673, },{ID = 30669, },{ID = 30667, },},
	}
ScriptFightDB[3048] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30676, },{ID = 30677, },{ID = 30674, },{ID = 30681, },{ID = 30679, },{ID = 30675, },{ID = 30680, },{ID = 30678, },},
	}
ScriptFightDB[3049] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30685, },{ID = 30684, },{ID = 30682, },{ID = 30687, },{ID = 30683, },{ID = 30688, },{ID = 30686, },{ID = 30689, },},
	}
ScriptFightDB[3050] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30690,pos = 26 },},
        systemActions  = {                             --------冰风原BOSS，召唤分身                                  

		   [1] = {								

			  condition = {			---------------生命低于65%召唤小怪			 
				
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30690,type="hp",["<="] = 65},},
				  isAnd = true,
			     },

			  actions = {							
                                  {type = ScriptFightActionType.PlayBubble,params={DBID={30690},bubbleID = 10050},},   ----第一回合bOSS喊话
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30680,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30681,count = 1},} },         ----单位进场
			   },
		   },				
	  },
	}
-----魔罗峰---删掉就让你感受魔王的恐惧--------------

ScriptFightDB[3055] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30741, },{ID = 30742, },{ID = 30740, },{ID = 30743, },{ID = 30744, },{ID = 30745, },{ID = 30746, },{ID = 30747, },},
	}
ScriptFightDB[3056] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30749, },{ID = 30750, },{ID = 30748, },{ID = 30751, },{ID = 30752, },{ID = 30753, },{ID = 30754, },{ID = 30755, },},
	}
ScriptFightDB[3057] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30758, },{ID = 30757, },{ID = 30756, },{ID = 30760, },{ID = 30761, },{ID = 30759, },{ID = 30762, },{ID = 30763, },},
	}
ScriptFightDB[3058] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30765, },{ID = 30768, },{ID = 30764, },{ID = 30766, },{ID = 30769, },{ID = 30767, },{ID = 30770, },{ID = 30771, },},
	}
ScriptFightDB[3059] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30773, },{ID = 30778, },{ID = 30772, },{ID = 30774, },{ID = 30776, },{ID = 30777, },{ID = 30775, },{ID = 30779, },},
	}
ScriptFightDB[3060] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
        systemActions  = {                             --------魔罗峰BOSS，召唤精英                                  

		   [1] = {								

			  condition = {						 
				
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30780,type="hp",["<="] = 30},},
				  count = 1,
			     },

			  actions = {							
                                  {type = ScriptFightActionType.PlayBubble,params={DBID={30780},bubbleID = 10061},},   ----第一回合bOSS喊话
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30757,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30758,count = 1},} },         ----单位进场
			   },
		   },
		   [2] = {								

			  condition = {						 
				
				  {type = ScriptFightConditionType.AttrValue, params={DBID = 30780,type="hp",["<="] = 80},},
				  count = 1,
			     },

			  actions = {							
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30759,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 30760,count = 1},} },         ----单位进场
				  {type = ScriptFightActionType.PlayBubble,params={DBID={30760},bubbleID = 10060},},      ----小怪喊话
				  {type = ScriptFightActionType.PlayBubble,params={DBID={30780},bubbleID = 10062},},      ----张角喊话
			   },
		   },
		   [3] = {								

			  condition = {			---场上存在小怪，boss添加buff			 
				
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30757,relation="=",value = 1},},
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30758,relation="=",value = 1},},
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30759,relation="=",value = 1},},
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30760,relation="=",value = 1},},
				  isAnd = false,
				  
			     },

			  actions = {							
                                  {type = ScriptFightActionType.AddBuff,params={DBID ={30780},buffID = 46} },
			   },
		   },
		   [4] = {								

			  condition = {			---场上不存在小怪，boss删除buff			 
				
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30757,relation="<=",value = 0},},
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30758,relation="<=",value = 0},},
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30759,relation="<=",value = 0},},
				  {type = ScriptFightConditionType.IDExist, params={DBID = 30760,relation="<=",value = 0},},
				  isAnd = true,
				  count = 1,
			     },

			  actions = {							
                                  {type = ScriptFightActionType.RemoveBuff,params={DBID ={30780},buffID = 46} },
			   },
		   },
	  },
	}
----------------------邪盘山“明明是我先的，萝莉也好，御姐也好。你们为什么搞基，搞得这么熟练啊！”-------------------------------
ScriptFightDB[3061] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30826, },{ID = 30827, },{ID = 30825, },{ID = 30828, },{ID = 30829, },{ID = 30830, },{ID = 30831, },{ID = 30832, },},
	}
ScriptFightDB[3062] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30834, },{ID = 30835, },{ID = 30833, },{ID = 30836, },{ID = 30837, },{ID = 30838, },{ID = 30839, },{ID = 30840, },},
	}
ScriptFightDB[3063] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30842, },{ID = 30843, },{ID = 30841, },{ID = 30844, },{ID = 30845, },{ID = 30846, },{ID = 30847, },{ID = 30848, },},
	}
ScriptFightDB[3064] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30850, },{ID = 30851, },{ID = 30849, },{ID = 30852, },{ID = 30853, },{ID = 30854, },{ID = 30855, },{ID = 30856, },},
	}
ScriptFightDB[3065] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30858, },{ID = 30859, },{ID = 30857, },{ID = 30860, },{ID = 30861, },{ID = 30862, },{ID = 30863, },{ID = 30864, },},
	}
ScriptFightDB[3066] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30865,pos = 26 },},
	}

----------------------------------新副本毒龙峰,毒龙---------------------峰-----------------------
ScriptFightDB[3070] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30891, },{ID = 30892, },{ID = 30890, },{ID = 30893, },{ID = 30894, },{ID = 30895, },{ID = 30896, },{ID = 30897, },},
	}
ScriptFightDB[3071] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30899, },{ID = 30900, },{ID = 30898, },{ID = 30901, },{ID = 30902, },{ID = 30903, },{ID = 30904, },{ID = 30905, },},
	}
ScriptFightDB[3072] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30906, },{ID = 30908, },{ID = 30910, },},
	}
ScriptFightDB[3073] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30915, },{ID = 30916, },{ID = 30914, },{ID = 30917, },{ID = 30918, },{ID = 30919, },{ID = 30920, },{ID = 30921, },},
	}
ScriptFightDB[3074] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30923, },{ID = 30924, },{ID = 30922, },{ID = 30925, },{ID = 30926, },{ID = 30927, },{ID = 30928, },{ID = 30929, },},
	}
ScriptFightDB[3075] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30930, },},
	}

-----------------------------------------万码丛中，取副本标记（天宫幻境）--------------------------------------------------------------------------------------------------------


ScriptFightDB[3076] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31021, },{ID = 31022, },{ID = 31020, },{ID = 31023, },{ID = 31024, },{ID = 31025, },{ID = 31026, },{ID = 31027, },},
	}
ScriptFightDB[3077] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31029, },{ID = 31030, },{ID = 31028, },{ID = 31031, },{ID = 31032, },{ID = 31033, },{ID = 31034, },{ID = 31035, },},
	}
ScriptFightDB[3078] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31037, },{ID = 31038, },{ID = 31036, },{ID = 31039, },{ID = 31040, },{ID = 31041, },{ID = 31042, },{ID = 31043, },},
	}
ScriptFightDB[3079] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31045, },{ID = 31046, },{ID = 31044, },{ID = 31047, },{ID = 31048, },{ID = 31049, },{ID = 31050, },{ID = 31051, },},
	}
ScriptFightDB[3080] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31053, },{ID = 31054, },{ID = 31052, },{ID = 31055, },{ID = 31056, },{ID = 31057, },{ID = 31058, },{ID = 31059, },},
	}
ScriptFightDB[3081] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31060, },},
	}

-----------------------------------迷雾林，新年来一发，祝君大吉吧！----------------------------------------------

--------------------------------------------------------------赤魂岭副本--------------------------------------------------------------------------------------------------------
ScriptFightDB[3082] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31111, },{ID = 31112, },{ID = 31110, },{ID = 31113, },{ID = 31114, },{ID = 31115, },{ID = 31116, },{ID = 31117, },},
	}
ScriptFightDB[3083] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31119, },{ID = 31120, },{ID = 31118, },{ID = 31121, },{ID = 31122, },{ID = 31123, },{ID = 31124, },{ID = 31125, },},
	}
ScriptFightDB[3084] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31127, },{ID = 31128, },{ID = 31126, },{ID = 31129, },{ID = 31130, },{ID = 31131, },{ID = 31132, },{ID = 31133, },},
	}
ScriptFightDB[3085] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31135, },{ID = 31136, },{ID = 31134, },{ID = 31137, },{ID = 31138, },{ID = 31139, },{ID = 31140, },{ID = 31141, },},
	}
ScriptFightDB[3086] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31143, },{ID = 31144, },{ID = 31142, },{ID = 31145, },{ID = 31146, },{ID = 31147, },{ID = 31148, },{ID = 31149, },},
	}
ScriptFightDB[3087] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31150, },},
	}
-----------------------------------迷雾林，新年来一发，祝君大吉吧！----------------------------------------------

ScriptFightDB[3088] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31251, },{ID = 31252, },{ID = 31250, },{ID = 31253, },{ID = 31254, },{ID = 31255, },{ID = 31256, },{ID = 31257, },},
	}
ScriptFightDB[3089] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31259, },{ID = 31260, },{ID = 31258, },{ID = 31261, },{ID = 31262, },{ID = 31263, },{ID = 31264, },{ID = 31265, },},
	}
ScriptFightDB[3090] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31267, },{ID = 31268, },{ID = 31266, },{ID = 31269, },{ID = 31270, },{ID = 31271, },{ID = 31272, },{ID = 31273, },},
	
	begin  = {                                                               

		[1] = {								

			condition = {						 
				
				--{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				{type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 2},},
				

			 },

			actions = {							
                                {type = ScriptFightActionType.PlayBubble,params={DBID={31266},bubbleID = 10022},},
				{type = ScriptFightActionType.AddBuff,params={DBID ={31266},buffID = 21} },
				
			 },
		 },
							
	},
	}
ScriptFightDB[3091] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31275, },{ID = 31276, },{ID = 31274, },{ID = 31277, },{ID = 31278, },{ID = 31279, },{ID = 31280, },{ID = 31281, },},
	}
ScriptFightDB[3092] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31282, },},
	
	begin  = {                                                               

		[1] = {								

			condition = {						 
				
				
				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				--{type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 2},},
				
                          count = 1,
			 },

			actions = {							

                                {type = ScriptFightActionType.PlayBubble,params={DBID={31282},bubbleID = 10020},},
				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31258,count = 3},} },
			        {type = ScriptFightActionType.AddBuff,params={DBID ={31282},buffID = 46} },
				

				isSameTime = true,
			 },
		 },
                 [2] = {								

			condition = {						 
				
				
				{type = ScriptFightConditionType.AttrValue, params={DBID = 31282,type="hp",["<="] = 35},},
				--{type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 2},},
				
                          count = 1,
			 },

			actions = {							

                                {type = ScriptFightActionType.PlayBubble,params={DBID={31282},bubbleID = 10021},},
				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31266,count = 3},} },
				{type = ScriptFightActionType.AddBuff,params={DBID ={31282},buffID = 67 } },
				{type = ScriptFightActionType.AddBuff,params={DBID ={31282},buffID = 55 } },
				{type = ScriptFightActionType.AddBuff,params={DBID ={31282},buffID = 42 } },

				isSameTime = true,
			 },
		 },							
	},
	}

-------------------------------------------天公山----跨年配副本----------------------------------
ScriptFightDB[3093] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31196, },{ID = 31191, },{ID = 31193, },{ID = 31190, },{ID = 31194, },{ID = 31195, },{ID = 31197, },{ID = 31192, },},
	}
ScriptFightDB[3094] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31204, },{ID = 31199, },{ID = 31201, },{ID = 31198, },{ID = 31202, },{ID = 31203, },{ID = 31205, },{ID = 31200, },},
	}
ScriptFightDB[3095] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31212, },{ID = 31207, },{ID = 31209, },{ID = 31206, },{ID = 31210, },{ID = 31211, },{ID = 31213, },{ID = 31208, },},
	}
ScriptFightDB[3096] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31218, },{ID = 31220, },{ID = 31215, },{ID = 31214, },{ID = 31216, },{ID = 31217, },{ID = 31219, },{ID = 31221, },},
	}
ScriptFightDB[3097] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31222, },},
	}
-------------------------------------------黄风岭--------------------------------------
ScriptFightDB[3098] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31376, },{ID = 31374, },{ID = 31371, },{ID = 31372, },{ID = 31373, },{ID = 31370, },{ID = 31377, },{ID = 31375, },},
	systemActions  = {                                                                

		[1] = {								

			condition = {						 
				{type = ScriptFightConditionType.RoundInterval, params={period = 3,startRound = 2},},-- 每三回合触发一次
			 },

			actions = {							
				{type = ScriptFightActionType.PlayBubble,params={DBID={31370},bubbleID = 10026},},  --弹出气泡				
				isSameTime = true,
			 },
		 },							
	}, 
	}
	
ScriptFightDB[3099] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31384, },{ID = 31382, },{ID = 31379, },{ID = 31378, },{ID = 31380, },{ID = 31381, },{ID = 31385, },{ID = 31383, },},
	}
ScriptFightDB[3100] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31392, },{ID = 31390, },{ID = 31387, },{ID = 31386, },{ID = 31388, },{ID = 31389, },{ID = 31393, },{ID = 31391, },},
	}
ScriptFightDB[3101] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31398, },{ID = 31400, },{ID = 31395, },{ID = 31394, },{ID = 31396, },{ID = 31397, },{ID = 31399, },{ID = 31401, },},
	}
ScriptFightDB[3102] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31402, },},
	systemActions  = {                                                                

		[1] = {								

			condition = {						 
				
				
				{type = ScriptFightConditionType.AttrValue, params={DBID = 31402,type="hp",["<="] = 80},},-- 生命值低于80%时
				
				
                          count = 1,
			 },

			actions = {							
                                
				{type = ScriptFightActionType.PlayBubble,params={DBID={31402},bubbleID = 10027},},  --弹出气泡
                                {type = ScriptFightActionType.EntityEnter,params={{DBID = 31423,count = 4},} }, --召唤4只精英怪				
				isSameTime = true,
			 },
		 },							
	}, 
	}
--------------------------------------------炎魔窟-----年后首次副本------------------------------------------
ScriptFightDB[3103] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31301, },{ID = 31302, },{ID = 31300, },{ID = 31303, },{ID = 31304, },{ID = 31305, },{ID = 31306, },{ID = 31307, },},
	begin  = {                                                               

		[1] = {								

			condition = {						 
				
				
				 {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				 --指定回合生效：round =指定回合数
				
                          count = 1,
			 },

			actions = {							

                                {type = ScriptFightActionType.PlayBubble,params={DBID={31300},bubbleID = 1},},
				--播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				{type = ScriptFightActionType.AddBuff,params={DBID ={31300,31301,31302},buffID = 21} },
				isSameTime = true,
			 },
		 },
		 },
	}
ScriptFightDB[3104] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31309, },{ID = 31310, },{ID = 31308, },{ID = 31311, },{ID = 31312, },{ID = 31313, },{ID = 31314, },{ID = 31315, },},
	}
ScriptFightDB[3105] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31317, },{ID = 31318, },{ID = 31316, },{ID = 31319, },{ID = 31320, },{ID = 31321, },{ID = 31322, },{ID = 31323, },},
	}
ScriptFightDB[3106] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31325, },{ID = 31326, },{ID = 31324, },{ID = 31327, },{ID = 31328, },{ID = 31329, },{ID = 31330, },{ID = 31331, },},
	}
ScriptFightDB[3107] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31332, },},
	systemActions  = {                                                               

		[1] = {								

			condition = {						 
				
				
				 {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				 --指定回合生效：round =指定回合数
				
                          count = 1,
			 },

			actions = {							

                                {type = ScriptFightActionType.PlayBubble,params={DBID={31332},bubbleID = 10070},},
				--播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31364,count = 1},} },
				--单位进场：DBID = 单位ID，actionID = 动作ID,effectID = 表现ID（不能与action同时存在） ， count = 进场单位数量
				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31365,count = 1},} },
				--单位进场：DBID = 单位ID，actionID = 动作ID,effectID = 表现ID（不能与action同时存在） ， count = 进场单位数量
				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31366,count = 1},} },
				--单位进场：DBID = 单位ID，actionID = 动作ID,effectID = 表现ID（不能与action同时存在） ， count = 进场单位数量
				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31367,count = 1},} },
				--单位进场：DBID = 单位ID，actionID = 动作ID,effectID = 表现ID（不能与action同时存在） ， count = 进场单位数量
				isSameTime = true,
			 },
		 },
		 },
	}

-- 下面是循环任务————天道任务的脚本战斗-------------------------------
ScriptFightDB[4001] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25001},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4002] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25002},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4003] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25003},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4004] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25004},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4005] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25005},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4006] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25006},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4007] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25007},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4008] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25008},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4009] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25009},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4010] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25010},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4011] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25011},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4012] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25012},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4013] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25013},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4014] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25014},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4015] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25015},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4016] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25016},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4017] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25017},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4018] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25018},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4019] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25019},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4020] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25020},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4021] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25021},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4022] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25022},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4023] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25023},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4024] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25024},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4025] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25025},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4026] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25026},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4027] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25027},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4028] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25028},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4029] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25029},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
ScriptFightDB[4030] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 25030},{ID = 25031},{ID = 25031},{ID = 25031},{ID = 25031},},
	}
	---------------------------------------------------帮会休闲副本：驰援虎牢关--------------------------------------------------
ScriptFightDB[4050] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31450, },{ID = 31451, },{ID = 31452, },{ID = 31453, },{ID = 31454, },},
		begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31450},bubbleID = 10000},},
				 }
			      },
	                },
	}
ScriptFightDB[4051] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31455, },{ID = 31456, },{ID = 31457, },{ID = 31458, },{ID = 31459, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31455},bubbleID = 10001},},
				 }
			      },
		       [2]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 31455,relation="<",value = 1},},          --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				        {type = ScriptFightActionType.FightEnd,params={winner = "player" }},                               --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                  },
	                   },
	},
	}
ScriptFightDB[4052] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 11000, },{ID = 31461, },{ID = 31462, },{ID = 31463, },{ID = 31464, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31461,31462,31463,31464},bubbleID = 10002},},
				 }
			      },
			[2]={
                                condition = {
				         {type = ScriptFightConditionType.LiveNum, params={isEnemy = false ,relation="<=",count = 4},},                  --存活单位数：isEnemy = true（敌方）/false（友方），count=存活单位数（比较类型有："<"、">"、"="、"<="、">="）
	                                    },
			          actions = {
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 31461,count = 1},} },                                        --单位进场：DBID = 单位ID， count = 进场单位数量
	                                    },
	                    },
                       [3]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 11000,relation="<",value = 1},},                        --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				        {type = ScriptFightActionType.PlayBubble,params={DBID={31461,31462,31463,31464},bubbleID = 10009},},
				        {type = ScriptFightActionType.FightPause,params={time = 2} },                                                    --结算暂停：time =时间值 （单位：秒）
				        {type = ScriptFightActionType.EntityQuit,params={DBID ={31461,31462,31463,31464},} },                            --单位退场：DBID = 单位ID，支持填入多个， 
			                  },
	                    },
	                },
			}
ScriptFightDB[4053] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31465, },{ID = 31466, },{ID = 31467, },{ID = 31468, },{ID = 31469, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31465},bubbleID = 10003},},
				 }
			      },
	                },
	}
ScriptFightDB[4054] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31470, },{ID = 31471, },{ID = 31472, },{ID = 31473, },{ID = 31474, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31470},bubbleID = 10004},},
				 }
			      },
	                },
	}
ScriptFightDB[4055] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31475, },{ID = 31476, },{ID = 31477, },{ID = 31478, },{ID = 31479, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				            },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31476,31477,31478,31479},bubbleID = 10005},},
				           }
			      },
			[2]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 31475,relation="<",value = 1},},          --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				          {type = ScriptFightActionType.PlayBubble,params={DBID={31476,31477,31478,31479},bubbleID = 10006},},
				          {type = ScriptFightActionType.FightPause,params={time = 2} },                                                    --结算暂停：time =时间值 （单位：秒）
				          {type = ScriptFightActionType.EntityQuit,params={DBID ={31476,31477,31478,31479},} },                            --单位退场：DBID = 单位ID，支持填入多个，
			                  },
	                     },
	},
	}
ScriptFightDB[4056] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31470, },{ID = 31471, },{ID = 31472, },{ID = 31473, },{ID = 31474, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31470},bubbleID = 10004},},
				 }
			      },
	                },
	}
ScriptFightDB[4057] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31465, },{ID = 31466, },{ID = 31467, },{ID = 31468, },{ID = 31469, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31465},bubbleID = 10003},},
				 }
			      },
	                },
	}
ScriptFightDB[4058] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31455, },{ID = 31456, },{ID = 31457, },{ID = 31458, },{ID = 31459, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31455},bubbleID = 10001},},
				 }
			      },
		        [2]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 31455,relation="<",value = 1},},          --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				        {type = ScriptFightActionType.FightEnd,params={winner = "player" }},                               --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                  },
	                   },
	                },
	}
ScriptFightDB[4059] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31450, },{ID = 31451, },{ID = 31452, },{ID = 31453, },{ID = 31454, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31450},bubbleID = 10000},},
				 }
			      },
	                },
	}
ScriptFightDB[4060] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31475, },{ID = 31476, },{ID = 31477, },{ID = 31478, },{ID = 31479, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31476,31477,31478,31479},bubbleID = 10005},},
				           }
			      },
			[2]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 31475,relation="<",value = 1},},                          --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				          {type = ScriptFightActionType.PlayBubble,params={DBID={31476,31477,31478,31479},bubbleID = 10006},},
				          {type = ScriptFightActionType.FightPause,params={time = 2} },                                                    --结算暂停：time =时间值 （单位：秒）
				          {type = ScriptFightActionType.EntityQuit,params={DBID ={31476,31477,31478,31479},} },                            --单位退场：DBID = 单位ID，支持填入多个，
			                  },
	                     },
	                },
	}
ScriptFightDB[4061] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 11000, },{ID = 31461, },{ID = 31462, },{ID = 31463, },{ID = 31464, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31461,31462,31463,31464},bubbleID = 10002},},
				 }
			      },
			[2]={
                                condition = {
				         {type = ScriptFightConditionType.LiveNum, params={isEnemy = false ,relation="<=",count = 4},},                  --存活单位数：isEnemy = true（敌方）/false（友方），count=存活单位数（比较类型有："<"、">"、"="、"<="、">="）
	                                    },
			          actions = {
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 31461,count = 1},} },                                        --单位进场：DBID = 单位ID， count = 进场单位数量
	                                    },
	                    },
                       [3]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 11000,relation="<",value = 1},},                        --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				        {type = ScriptFightActionType.PlayBubble,params={DBID={31461,31462,31463,31464},bubbleID = 10009},},
				        {type = ScriptFightActionType.FightPause,params={time = 2} },                                                    --结算暂停：time =时间值 （单位：秒）
				        {type = ScriptFightActionType.EntityQuit,params={DBID ={31461,31462,31463,31464},} },                            --单位退场：DBID = 单位ID，支持填入多个， 
			                  },
	                    },
	                },
			}

ScriptFightDB[4062] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31465, },{ID = 31466, },{ID = 31467, },{ID = 31468, },{ID = 31469, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31465},bubbleID = 10003},},
				 }
			      },
	                },
	}
ScriptFightDB[4063] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31455, },{ID = 31456, },{ID = 31457, },{ID = 31458, },{ID = 31459, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31455},bubbleID = 10001},},
				 }
			      },
	                },
	}
ScriptFightDB[4064] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31475, },{ID = 31476, },{ID = 31477, },{ID = 31478, },{ID = 31479, },},
	        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31476,31477,31478,31479},bubbleID = 10005},},
				 }
			      },
			[2]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 31475,relation="<",value = 1},},                      --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				          {type = ScriptFightActionType.PlayBubble,params={DBID={31476,31477,31478,31479},bubbleID = 10006},},
				          {type = ScriptFightActionType.FightPause,params={time = 2} },                                                --结算暂停：time =时间值 （单位：秒）
				          {type = ScriptFightActionType.EntityQuit,params={DBID ={31476,31477,31478,31479},} },                        --单位退场：DBID = 单位ID，支持填入多个，
			                      },
	                     },
	                },
	              }
ScriptFightDB[4065] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31480, },{ID = 31481, },{ID = 31482, },{ID = 31483, },{ID = 31484, },},
		        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				            },
				  actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={31480},bubbleID = 10007},},
                                            }
			      },
		        [2]={
                                condition = {
				         {type = ScriptFightConditionType.LiveNum, params={isEnemy = false ,relation="<=",count = 4},},                  --存活单位数：isEnemy = true（敌方）/false（友方），count=存活单位数（比较类型有："<"、">"、"="、"<="、">="）
	                                    },
			          actions = {
				  {type = ScriptFightActionType.EntityEnter,params={{DBID = 31481,count = 1},} },                                        --单位进场：DBID = 单位ID， count = 进场单位数量
	                                    },
	                    },
			[3]= {
			      condition = {
			                {type = ScriptFightConditionType.IDExist, params={DBID = 31480,relation="<",value = 1},},                        --目标单位是否存在：DBID=目标ID，relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=比较值；支持填入多组进行判断
	                                  },
			        actions = {
				          {type = ScriptFightActionType.PlayBubble,params={DBID={31481,31482,31483,31484},bubbleID = 10008},},
				          {type = ScriptFightActionType.FightPause,params={time = 2} },                                                --结算暂停：time =时间值 （单位：秒）
				          {type = ScriptFightActionType.EntityQuit,params={DBID ={31481,31482,31483,31484},} },                        --单位退场：DBID = 单位ID，支持填入多个，
			                  },
	                     },
	                        },
	}
	---------------------------------------------------帮会休闲副本：火烧黄巾贼--------------------------------------------------
ScriptFightDB[4066] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10805, },{ID = 10804, },{ID = 10804, },{ID = 10806, },{ID = 10806, },},
        begin = {
			[1] = {
				condition = {
					 {type = ScriptFightConditionType.RoundCount, params={ round = 1},},
				 },
				 actions = {
					 {type = ScriptFightActionType.PlayBubble,params={DBID={10805},bubbleID = 10015},},
				 }
			      },
	                },

	}
--------------------------------------------师门任务的脚本战斗-------------------------------
--------------------------------------------任务的脚本战斗-------------------------------
ScriptFightDB[4101] = {             -----------------暗雷战斗-捣乱小妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26001},{ID = 26001},{ID = 26002},{ID = 26002},{ID = 26002},},
	}
ScriptFightDB[4102] = {             -----------------暗雷战斗-狡猾盗贼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26003},{ID = 26003},{ID = 26004},{ID = 26004},{ID = 26004},},
	}
ScriptFightDB[4103] = {             -----------------暗雷战斗-作歹流氓
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26005},{ID = 26005},{ID = 26006},{ID = 26006},{ID = 26006},},
	}
ScriptFightDB[4104] = {             -----------------暗雷战斗-恶毒山贼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26007},{ID = 26007},{ID = 26008},{ID = 26008},{ID = 26008},},
	}
ScriptFightDB[4105] = {             -----------------明雷挑战-乾元岛大弟子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20021},},
	}
ScriptFightDB[4106] = {             -----------------明雷挑战-桃源洞大弟子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20025},},
	}
ScriptFightDB[4107] = {             -----------------明雷挑战-金霞山大弟子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20023},},
	}
ScriptFightDB[4108] = {             -----------------明雷挑战-蓬莱阁大弟子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20022},},
	}
ScriptFightDB[4109] = {             -----------------明雷挑战-紫阳门大弟子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20026},},
	}
ScriptFightDB[4110] = {             -----------------明雷挑战-云霄宫大弟子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20024},},
	}
ScriptFightDB[4111] = {             -----------------明雷挑战-乾元岛执法长老
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29066},},
	}
ScriptFightDB[4112] = {             -----------------明雷挑战-桃源洞执法长老
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29067},},
	}
ScriptFightDB[4113] = {             -----------------明雷挑战-金霞山执法长老
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29068},},
	}
ScriptFightDB[4114] = {             -----------------明雷挑战-蓬莱阁执法长老
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29069},},
	}
ScriptFightDB[4115] = {             -----------------明雷挑战-紫阳门执法长老
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29070},},
	}
ScriptFightDB[4116] = {             -----------------明雷挑战-云霄宫执法长老
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29071},},
	}
ScriptFightDB[4117] = {             -----------------悬赏任务-截教奸细
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26009},{ID = 26020},{ID = 26020},},
	}
ScriptFightDB[4118] = {             -----------------悬赏任务-门派叛徒
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26012},{ID = 26020},{ID = 26020},},
	}
ScriptFightDB[4119] = {             -----------------悬赏任务-入侵刺客
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26011},{ID = 26020},{ID = 26020},},
	}
ScriptFightDB[4120] = {             -----------------悬赏任务-偷天大盗
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26010},{ID = 26020},{ID = 26020},},
	}
ScriptFightDB[4141] = 
        {             -----------------巡逻触发乞丐事件-拦路强盗
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26018},{ID = 26018},{ID = 26019},{ID = 26019},{ID = 26019},},
	systemActions = {	      	     
	      [1] =      --主怪血量小于0，战斗结束
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={26018},bubbleID = 550},},
		  },
	       },
	                },
	
	}
ScriptFightDB[4142] = {             -----------------巡逻触发神秘人事件-仇敌
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 26028},},
	}


------------------------------ 插一脚 这里是试炼任务的战斗分割-------------------------------
ScriptFightDB[5001] = {             -----------------暗雷战斗-董卓余党
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27001},{ID = 27001},{ID = 27001},{ID = 27001},{ID = 27001},},
}
ScriptFightDB[5002] = {             -----------------暗雷战斗-黄巾余党
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27002},{ID = 27002},{ID = 27002},{ID = 27002},{ID = 27002},},
}
ScriptFightDB[5003] = {             -----------------暗雷战斗-悍匪
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27003},{ID = 27003},{ID = 27003},{ID = 27003},{ID = 27003},},
}
ScriptFightDB[5004] = {             -----------------暗雷战斗-强盗
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27004},{ID = 27004},{ID = 27004},{ID = 27004},{ID = 27004},},
}
ScriptFightDB[5005] = {             -----------------暗雷战斗-流氓
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27005},{ID = 27005},{ID = 27005},{ID = 27005},{ID = 27005},},
}
ScriptFightDB[5006] = {             -----------------暗雷战斗-贼寇
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27006},{ID = 27006},{ID = 27006},{ID = 27006},{ID = 27006},},
}
ScriptFightDB[5007] = {             -----------------暗雷战斗-马匪
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27007},{ID = 27007},{ID = 27007},{ID = 27007},{ID = 27007},},
}
ScriptFightDB[5008] = {             -----------------暗雷战斗-玉泉行者
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27008},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5009] = {             -----------------暗雷战斗-飞贼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27009},{ID = 27009},{ID = 27009},{ID = 27009},{ID = 27009},},
}
ScriptFightDB[5010] = {             -----------------暗雷战斗-董军伍长
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27010},{ID = 27001},{ID = 27001},{ID = 27001},{ID = 27001},},
}
ScriptFightDB[5011] = {             -----------------暗雷战斗-黄巾护卫长
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27011},{ID = 27002},{ID = 27002},{ID = 27002},{ID = 27002},},
}
ScriptFightDB[5012] = {             -----------------暗雷战斗-荒漠盗匪
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27012},{ID = 27012},{ID = 27012},{ID = 27012},{ID = 27012},},
}
ScriptFightDB[5013] = {             -----------------暗雷战斗-倭寇
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27013},{ID = 27013},{ID = 27013},{ID = 27013},{ID = 27013},},
}
ScriptFightDB[5014] = {             -----------------暗雷战斗-山贼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27014},{ID = 27014},{ID = 27014},{ID = 27014},{ID = 27014},},
}
ScriptFightDB[5015] = {             -----------------暗雷战斗-水贼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27015},{ID = 27015},{ID = 27015},{ID = 27015},{ID = 27015},},
}
ScriptFightDB[5016] = {             -----------------暗雷战斗-董军军阀
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27016},{ID = 27001},{ID = 27001},{ID = 27001},{ID = 27001},},
}
ScriptFightDB[5017] = {             -----------------暗雷战斗-黄巾军阀
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27017},{ID = 27002},{ID = 27002},{ID = 27002},{ID = 27002},},
}
ScriptFightDB[5018] = {             -----------------暗雷战斗-黑山军
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27018},{ID = 27018},{ID = 27018},{ID = 27018},{ID = 27018},},
}
ScriptFightDB[5019] = {             -----------------暗雷战斗-邪教余党
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27019},{ID = 27019},{ID = 27019},{ID = 27019},{ID = 27019},},
}
ScriptFightDB[5020] = {             -----------------暗雷战斗-盟军叛党
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27020},{ID = 27020},{ID = 27020},{ID = 27020},{ID = 27020},},
}
ScriptFightDB[5021] = {             -----------------暗雷战斗-邪神教徒
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27021},{ID = 27021},{ID = 27021},{ID = 27021},{ID = 27021},},
}
ScriptFightDB[5022] = {             -----------------暗雷战斗-邪恶祭祀
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27022},{ID = 27022},{ID = 27022},{ID = 27022},{ID = 27022},},
}
ScriptFightDB[5023] = {             -----------------暗雷战斗-逆道天师
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27023},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5024] = {             -----------------暗雷战斗-截教叛徒
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27024},{ID = 27024},{ID = 27024},{ID = 27024},{ID = 27024},},
}
ScriptFightDB[5025] = {             -----------------暗雷战斗-魔将胡力
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27025},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5026] = {             -----------------暗雷战斗-张龙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27026},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5027] = {             -----------------暗雷战斗-九龙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27027},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5028] = {             -----------------暗雷战斗-王石
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27028},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5029] = {             -----------------暗雷战斗-风邪
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27029},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5030] = {             -----------------暗雷战斗-灵姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27030},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5031] = {             -----------------暗雷战斗-赵融
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27031},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5032] = {             -----------------暗雷战斗-冯芳
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27032},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5033] = {             -----------------暗雷战斗-程普
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27033},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5034] = {             -----------------暗雷战斗-甘宁
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27034},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5035] = {             -----------------暗雷战斗-袁遗
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27035},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5036] = {             -----------------暗雷战斗-杨奉
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27036},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5037] = {             -----------------暗雷战斗-黄承乙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27037},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5038] = {             -----------------暗雷战斗-李奇
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27038},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5039] = {             -----------------暗雷战斗-晁雷
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27039},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5040] = {             -----------------暗雷战斗-晁天
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27040},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5041] = {             -----------------暗雷战斗-李丙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27041},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5042] = {             -----------------暗雷战斗-常昊
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27042},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5043] = {             -----------------暗雷战斗-杨显
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27043},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5044] = {             -----------------暗雷战斗-李兴霸
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27044},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5045] = {             -----------------暗雷战斗-杨修
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27045},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5046] = {             -----------------暗雷战斗-马方
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27046},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5047] = {             -----------------暗雷战斗-吴龙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27047},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5048] = {             -----------------暗雷战斗-周信
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27048},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5049] = {             -----------------暗雷战斗-诡异术士符血
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27049},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5050] = {             -----------------暗雷战斗-邪教魔化护法
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27050},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5051] = {             -----------------暗雷战斗-魔君白久
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27051},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5052] = {             -----------------暗雷战斗-魔将陈千军
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27052},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5053] = {             -----------------暗雷战斗-妖将火獐
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27053},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5054] = {             -----------------暗雷战斗-镇狱明王
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27054},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5055] = {             -----------------暗雷战斗-魔君玄霓
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27055},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5056] = {             -----------------暗雷战斗-魔将萧怀青
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27056},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5057] = {             -----------------暗雷战斗-千年藤妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27057},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5058] = {             -----------------暗雷战斗-妖将陆魁
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27058},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5059] = {             -----------------暗雷战斗-邪道刘邑
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27059},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5060] = {             -----------------暗雷战斗-术士方相
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27060},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5061] = {             -----------------暗雷战斗-魔君姬发
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27061},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5062] = {             -----------------暗雷战斗-魔将乔坤
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27062},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5063] = {             -----------------暗雷战斗-妖将曹宝
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27063},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5064] = {             -----------------暗雷战斗-邪道萧臻
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27064},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5065] = {             -----------------暗雷战斗-术士方弼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27065},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5066] = {             -----------------暗雷战斗-薛恶虎
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27066},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5067] = {             -----------------暗雷战斗-韩毒龙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27067},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5068] = {             -----------------暗雷战斗-赤精子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27068},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5069] = {             -----------------暗雷战斗-雪峰老妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27069},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5070] = {             -----------------暗雷战斗-水火童子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27070},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5071] = {             -----------------暗雷战斗-魔将马善
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27071},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5072] = {             -----------------暗雷战斗-妖将王虎
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27072},{ID = 27151},{ID = 27151},{ID = 27151},{ID = 27151},},
}
ScriptFightDB[5073] = {             -----------------挑战明雷-卢植
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20049},},
}
ScriptFightDB[5074] = {             -----------------挑战明雷-王子师
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30320},},
}
ScriptFightDB[5075] = {             -----------------挑战明雷-皇甫嵩
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20059},},
}
ScriptFightDB[5076] = {             -----------------挑战明雷-张维义
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 29008},},
}
ScriptFightDB[5077] = {             -----------------挑战明雷-杨森
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27073},},
}
ScriptFightDB[5078] = {             -----------------挑战明雷-高友乾
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27074},},
}
ScriptFightDB[5079] = {             -----------------挑战明雷-王允
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20701},},
}
ScriptFightDB[5080] = {             -----------------挑战明雷-杨文辉
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27075},},
}
ScriptFightDB[5081] = {             -----------------挑战明雷-郑伦
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27076},},
}
ScriptFightDB[5082] = {             -----------------挑战明雷-陈奇
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27077},},
}
ScriptFightDB[5083] = {             -----------------挑战明雷-段岳
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20021},},
}
ScriptFightDB[5084] = {             -----------------挑战明雷-兮颜
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20022},},
}
ScriptFightDB[5085] = {             -----------------挑战明雷-李长风
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20023},},
}
ScriptFightDB[5086] = {             -----------------挑战明雷-庄梦蝶
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20025},},
}
ScriptFightDB[5087] = {             -----------------挑战明雷-玄素
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20024},},
}
ScriptFightDB[5088] = {             -----------------挑战明雷-殿飞白
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 20026},},
}
ScriptFightDB[5089] = {             -----------------天道悬赏-黑风小妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27078},},
}
ScriptFightDB[5090] = {             -----------------天道悬赏-入魔双刀客
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27079},},
}
ScriptFightDB[5091] = {             -----------------天道悬赏-魔化女刺客
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27080},},
}
ScriptFightDB[5092] = {             -----------------天道悬赏-魔化剑奴
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27081},},
}
ScriptFightDB[5093] = {             -----------------天道悬赏-黑衣人
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27082},},
}
ScriptFightDB[5094] = {             -----------------天道悬赏-邪恶祭祀
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27083},},
}
ScriptFightDB[5095] = {             -----------------天道悬赏-蛇妖常旭
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27084},},
}
ScriptFightDB[5096] = {             -----------------天道悬赏-魔仙黄龙
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27085},},
}
ScriptFightDB[5097] = {             -----------------天道悬赏-甲胄翰赤
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27086},},
}
ScriptFightDB[5098] = {             -----------------天道悬赏-符咒翰赤
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27087},},
}
ScriptFightDB[5099] = {             -----------------天道悬赏-翠岩妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27088},},
}
ScriptFightDB[5100] = {             -----------------天道悬赏-花魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27089},},
}
ScriptFightDB[5101] = {             -----------------天道悬赏-术妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27090},},
}
ScriptFightDB[5102] = {             -----------------天道悬赏-鬼姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27091},},
}
ScriptFightDB[5103] = {             -----------------天道悬赏-虎头怪
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27092},},
}
ScriptFightDB[5104] = {             -----------------天道悬赏-巫灵
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27093},},
}
ScriptFightDB[5105] = {             -----------------天道悬赏-忧草姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27094},},
}
ScriptFightDB[5106] = {             -----------------天道悬赏-黑翰赤
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27095},},
}
ScriptFightDB[5107] = {             -----------------天道悬赏-白翰赤
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27096},},
}
ScriptFightDB[5108] = {             -----------------天道悬赏-幻姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27097},},
}
ScriptFightDB[5109] = {             -----------------天道悬赏-烽骑
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27098},},
}
ScriptFightDB[5110] = {             -----------------天道悬赏-幻妖姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27099},},
}
ScriptFightDB[5111] = {             -----------------天道悬赏-幻灵姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27100},},
}
ScriptFightDB[5112] = {             -----------------天道悬赏-无双赤鬼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27101},},
}
ScriptFightDB[5113] = {             -----------------天道悬赏-魔教大护法
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27102},},
}
ScriptFightDB[5114] = {             -----------------天道悬赏-邪恶女妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27103},},
}
ScriptFightDB[5115] = {             -----------------天道悬赏-魔化妖道
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27104},},
}
ScriptFightDB[5116] = {             -----------------天道悬赏-黄巾魔将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27105},},
}
ScriptFightDB[5117] = {             -----------------天道悬赏-冰石傀
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27106},},
}
ScriptFightDB[5118] = {             -----------------天道悬赏-飞熊
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27107},},
}
ScriptFightDB[5119] = {             -----------------天道悬赏-血魔君
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27108},},
}
ScriptFightDB[5120] = {             -----------------天道悬赏-血狂
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27109},},
}
ScriptFightDB[5121] = {             -----------------天道悬赏-莲魂影
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27110},},
}
ScriptFightDB[5122] = {             -----------------天道悬赏-花怀风
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27111},},
}
ScriptFightDB[5123] = {             -----------------天道悬赏-龙魂
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27112},},
}
ScriptFightDB[5124] = {             -----------------天道悬赏-金翅迦楼洛
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27113},},
}
ScriptFightDB[5125] = {             -----------------天道悬赏-雪风
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27114},},
}
ScriptFightDB[5126] = {             -----------------天道悬赏-魔道羽灵
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27115},},
}
ScriptFightDB[5127] = {             -----------------天道悬赏-鬼道羽灵
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27116},},
}
ScriptFightDB[5128] = {             -----------------天道悬赏-古格
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27117},},
}
ScriptFightDB[5129] = {             -----------------天道悬赏-夜魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27118},},
}
ScriptFightDB[5130] = {             -----------------天道悬赏-玄风
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27119},},
}
ScriptFightDB[5131] = {             -----------------天道悬赏-血灵魑魅
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27120},},
}
ScriptFightDB[5132] = {             -----------------天道悬赏-地藏妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27121},},
}
ScriptFightDB[5133] = {             -----------------天道悬赏-雪妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27122},},
}
ScriptFightDB[5134] = {             -----------------天道悬赏-剑魂
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27123},},
}
ScriptFightDB[5135] = {             -----------------天道悬赏-高渊
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27124},},
}
ScriptFightDB[5136] = {             -----------------天道悬赏-魅惑妖姬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27125},},
}
ScriptFightDB[5137] = {             -----------------天道悬赏-魔化器灵
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27126},},
}
ScriptFightDB[5138] = {             -----------------天道悬赏-牛魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27127},},
}
ScriptFightDB[5139] = {             -----------------天道悬赏-金翅大鹏王
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27128},},
}
ScriptFightDB[5140] = {             -----------------天道悬赏-邪灵分身
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27129},},
}
ScriptFightDB[5141] = {             -----------------天道悬赏-血法祭祀
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27130},},
}
ScriptFightDB[5142] = {             -----------------天道悬赏-魔灵傀儡
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27131},},
}
ScriptFightDB[5143] = {             -----------------天道悬赏-冰魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27132},},
}
ScriptFightDB[5144] = {             -----------------天道悬赏-罗刹恶鬼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27133},},
}
ScriptFightDB[5145] = {             -----------------天道悬赏-蛟魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27134},},
}
ScriptFightDB[5146] = {             -----------------天道悬赏-双头魔狼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27135},},
}
ScriptFightDB[5147] = {             -----------------天道悬赏-嗜血魔将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27136},},
}
ScriptFightDB[5148] = {             -----------------天道悬赏-嗜血蛮将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27137},},
}
ScriptFightDB[5149] = {             -----------------天道悬赏-罗刹女妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27138},},
}
ScriptFightDB[5150] = {             -----------------天道悬赏-幽灵鬼师
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27139},},
}
ScriptFightDB[5151] = {             -----------------天道悬赏-血炼猪魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27140},},
}
ScriptFightDB[5152] = {             -----------------天道悬赏-魔灵犬
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27141},},
}
ScriptFightDB[5153] = {             -----------------天道悬赏-魔奴
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27142},},
}
ScriptFightDB[5154] = {             -----------------天道悬赏-魔将端无
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27143},},
}
ScriptFightDB[5155] = {             -----------------天道悬赏-恶灵童子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27144},},
}
ScriptFightDB[5156] = {             -----------------天道悬赏-枪魔
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27145},},
}
ScriptFightDB[5157] = {             -----------------天道悬赏-赤魂王
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27146},},
}
ScriptFightDB[5158] = {             -----------------天道悬赏-金蟾鬼母
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27147},},
}
ScriptFightDB[5159] = {             -----------------天道悬赏-毒娘子
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27148},},
}
ScriptFightDB[5160] = {             -----------------天道悬赏-妖鬼皇
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 27149},},
}
ScriptFightDB[5161] = {             -----------------上交宠物-40-44-河内守卫
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10019},},
}
ScriptFightDB[5162] = {             -----------------上交宠物-40-44-刀盾手
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10023},},
}
ScriptFightDB[5163] = {             -----------------上交宠物-40-44-冰妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10027},},
}
ScriptFightDB[5164] = {             -----------------上交宠物-40-44-鲛妖
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10031},},
}
ScriptFightDB[5165] = {             -----------------上交宠物-40-44-游方妖师
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10045},},
}
ScriptFightDB[5166] = {             -----------------上交宠物-45-49-女贼
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10033},},
}
ScriptFightDB[5167] = {             -----------------上交宠物-45-49-河盗
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10032},},
}
ScriptFightDB[5168] = {             -----------------上交宠物-45-49-琴魔女
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10035},},
}
ScriptFightDB[5169] = {             -----------------上交宠物-45-49-妖灵
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10034},},
}
ScriptFightDB[5170] = {             -----------------上交宠物-45-49-死士
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10036},},
}
ScriptFightDB[5171] = {             -----------------上交宠物-45-49-蛮族
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10037},},
}
ScriptFightDB[5172] = {             -----------------上交宠物-50-54-虎将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10038},},
}
ScriptFightDB[5173] = {             -----------------上交宠物-50-54-谋士
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10039},},
}
ScriptFightDB[5174] = {             -----------------上交宠物-50-54-牛头
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10040},},
}
ScriptFightDB[5175] = {             -----------------上交宠物-50-54-马面
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10041},},
}
ScriptFightDB[5176] = {             -----------------上交宠物-50-54-骷髅将
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10042},},
}
ScriptFightDB[5177] = {             -----------------上交宠物-50-54-魔兵
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10043},},
}
-------------------试炼任务完毕，请接下去-------------------------------------
-------------------讨逆任务，Three.Two.One.Go！--------------------------------
ScriptFightDB[5201] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28001},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5202] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28002},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5203] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28003},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5204] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28004},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5205] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28005},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5206] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28006},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5207] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28007},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5208] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28008},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5209] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28009},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5210] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28010},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5211] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28011},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5212] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28012},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5213] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28013},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5214] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28014},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5215] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28015},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5216] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28016},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5217] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28017},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5218] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28018},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5219] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28019},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
ScriptFightDB[5220] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 28020},{ID = 28021},{ID = 28021},{ID = 28021},{ID = 28021},},
	}
--------------------------------------讨逆任务，Over！--------------------------------------------

---------------------------------------天子猎金场活动，扛着锄头来打劫------------------------
ScriptFightDB[6001] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39052,},{ID = 39053, },{ID = 39052, },{ID = 39052, },},
	}
ScriptFightDB[6002] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39052,},{ID = 39053, },{ID = 39053, },{ID = 39052, },},
	}


-------------------打赢了就给骑----坐骑战斗分割线----------------------------
ScriptFightDB[7001] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39001,pos = 27 },},
	}
ScriptFightDB[7002] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39002,pos = 27 },},
	}
ScriptFightDB[7003] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39003,pos = 27 },},
	}
ScriptFightDB[7004] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39004,pos = 27 },},
	}
ScriptFightDB[7005] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39005,pos = 27 },},
	}	
ScriptFightDB[7006] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39006,pos = 27 },},
	}
ScriptFightDB[7007] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39007,pos = 27 },},
	}
ScriptFightDB[7008] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39008,pos = 27 },},
	}
ScriptFightDB[7009] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39009,pos = 27 },},
	}
ScriptFightDB[7010] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 39010,pos = 27 },},
	}


-- 8001 - 9000 门派闯关活动战斗
--[[ScriptFightDB[8001] = {--乾元岛
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50060,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50061,weight= 40},{ID = 50062,weight= 40},{ID = 50063,weight= 5},{ID = 50064,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8002] = {
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50060,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50063,weight= 40},{ID = 50064,weight= 40},{ID = 50065,weight= 5},{ID = 50066,weight= 5},{ID = 50067,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8003] = {--金霞山
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50070,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50071,weight= 40},{ID = 50072,weight= 40},{ID = 50073,weight= 5},{ID = 50074,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8004] = {
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50070,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50073,weight= 40},{ID = 50074,weight= 40},{ID = 50075,weight= 5},{ID = 50076,weight= 5},{ID = 50076,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8005] = {--紫阳门
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50080,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50081,weight= 40},{ID = 50082,weight= 40},{ID = 50083,weight= 5},{ID = 50084,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8006] = {
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50080,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50083,weight= 40},{ID = 50084,weight= 40},{ID = 50085,weight= 5},{ID = 50086,weight= 5},{ID = 50086,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8007] = {--云霄宫
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50090,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50091,weight= 40},{ID = 50092,weight= 40},{ID = 50093,weight= 5},{ID = 50094,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8008] = {
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50090,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50093,weight= 40},{ID = 50094,weight= 40},{ID = 50095,weight= 5},{ID = 50096,weight= 5},{ID = 50097,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8009] = {--桃源洞
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50100,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50101,weight= 40},{ID = 50102,weight= 40},{ID = 50103,weight= 5},{ID = 50104,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8010] = {
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50100,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50103,weight= 40},{ID = 50104,weight= 40},{ID = 50105,weight= 5},{ID = 50106,weight= 5},{ID = 50107,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8011] = {--蓬莱阁
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50110,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50111,weight= 40},{ID = 50112,weight= 40},{ID = 50113,weight= 5},{ID = 50114,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}
ScriptFightDB[8012] = {
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 50110,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 1,maxCount = 2,{ID = 50113,weight= 40},{ID = 50114,weight= 40},{ID = 50115,weight= 5},{ID = 50116,weight= 5},{ID = 50117,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	systemActions = {
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	      },
	      [2] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 10011,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={10011},bubbleID = 1},},
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
	},
	-- 奖励信息
	LuckyRewardID = 1,
}--]]

ScriptFightDB[8021] = {--乾元岛
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50060,pos = 26,max = 1,weight = -1},{ID = 50061,weight= 40},{ID = 50062,weight= 40},{ID = 50063,weight= 5},{ID = 50064,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8022] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50060,pos = 26,max = 1,weight = -1},{ID = 50061,weight= 30},{ID = 50062,weight= 30},{ID = 50063,weight= 15},{ID = 50064,weight= 15},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8023] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50060,pos = 26,max = 1,weight = -1},{ID = 50063,weight= 35},{ID = 50064,weight= 35},{ID = 50065,weight= 10},{ID = 50066,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8024] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50060,pos = 26,max = 1,weight = -1},{ID = 50063,weight= 25},{ID = 50064,weight= 25},{ID = 50065,weight= 20},{ID = 50066,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8025] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50060,pos = 26,max = 1,weight = -1},{ID = 50065,weight= 35},{ID = 50066,weight= 35},{ID = 50067,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8026] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50060,pos = 26,max = 1,weight = -1},{ID = 50065,weight= 10},{ID = 50066,weight= 10},{ID = 50067,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}




ScriptFightDB[8031] = {--金霞山
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50070,pos = 26,max = 1,weight = -1},{ID = 50071,weight= 40},{ID = 50072,weight= 40},{ID = 50073,weight= 5},{ID = 50074,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8032] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50070,pos = 26,max = 1,weight = -1},{ID = 50071,weight= 30},{ID = 50072,weight= 30},{ID = 50073,weight= 15},{ID = 50074,weight= 15},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8033] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50070,pos = 26,max = 1,weight = -1},{ID = 50073,weight= 35},{ID = 50074,weight= 35},{ID = 50075,weight= 10},{ID = 50076,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8034] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50070,pos = 26,max = 1,weight = -1},{ID = 50073,weight= 25},{ID = 50074,weight= 25},{ID = 50075,weight= 20},{ID = 50076,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8035] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50070,pos = 26,max = 1,weight = -1},{ID = 50075,weight= 35},{ID = 50076,weight= 35},{ID = 50077,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8036] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50070,pos = 26,max = 1,weight = -1},{ID = 50075,weight= 10},{ID = 50076,weight= 10},{ID = 50077,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}



ScriptFightDB[8041] = {--紫阳门
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50080,pos = 26,max = 1,weight = -1},{ID = 50081,weight= 40},{ID = 50082,weight= 40},{ID = 50083,weight= 5},{ID = 50084,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8042] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50080,pos = 26,max = 1,weight = -1},{ID = 50081,weight= 30},{ID = 50082,weight= 30},{ID = 50083,weight= 15},{ID = 50084,weight= 15},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8043] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50080,pos = 26,max = 1,weight = -1},{ID = 50083,weight= 35},{ID = 50084,weight= 35},{ID = 50085,weight= 10},{ID = 50086,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8044] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50080,pos = 26,max = 1,weight = -1},{ID = 50083,weight= 25},{ID = 50084,weight= 25},{ID = 50085,weight= 20},{ID = 50086,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8045] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50080,pos = 26,max = 1,weight = -1},{ID = 50085,weight= 35},{ID = 50086,weight= 35},{ID = 50087,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8046] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50080,pos = 26,max = 1,weight = -1},{ID = 50085,weight= 10},{ID = 50086,weight= 10},{ID = 50087,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}


ScriptFightDB[8051] = {--云霄宫
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50090,pos = 26,max = 1,weight = -1},{ID = 50091,weight= 40},{ID = 50092,weight= 40},{ID = 50093,weight= 5},{ID = 50094,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8052] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50090,pos = 26,max = 1,weight = -1},{ID = 50091,weight= 30},{ID = 50092,weight= 30},{ID = 50093,weight= 15},{ID = 50094,weight= 15},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8053] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50090,pos = 26,max = 1,weight = -1},{ID = 50093,weight= 35},{ID = 50094,weight= 35},{ID = 50095,weight= 10},{ID = 50096,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8054] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50090,pos = 26,max = 1,weight = -1},{ID = 50093,weight= 25},{ID = 50094,weight= 25},{ID = 50095,weight= 20},{ID = 50096,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8055] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50090,pos = 26,max = 1,weight = -1},{ID = 50095,weight= 35},{ID = 50096,weight= 35},{ID = 50097,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8056] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50090,pos = 26,max = 1,weight = -1},{ID = 50095,weight= 10},{ID = 50096,weight= 10},{ID = 50097,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}


ScriptFightDB[8061] = {--桃源洞
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50100,pos = 26,max = 1,weight = -1},{ID = 50101,weight= 40},{ID = 50102,weight= 40},{ID = 50103,weight= 5},{ID = 50104,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8062] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50100,pos = 26,max = 1,weight = -1},{ID = 50101,weight= 30},{ID = 50102,weight= 30},{ID = 50103,weight= 15},{ID = 50104,weight= 15},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8063] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50100,pos = 26,max = 1,weight = -1},{ID = 50103,weight= 35},{ID = 50104,weight= 35},{ID = 50105,weight= 10},{ID = 50106,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8064] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50100,pos = 26,max = 1,weight = -1},{ID = 50103,weight= 25},{ID = 50104,weight= 25},{ID = 50105,weight= 20},{ID = 50106,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8065] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50100,pos = 26,max = 1,weight = -1},{ID = 50105,weight= 35},{ID = 50106,weight= 35},{ID = 50107,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8066] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50100,pos = 26,max = 1,weight = -1},{ID = 50105,weight= 10},{ID = 50106,weight= 10},{ID = 50107,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}


ScriptFightDB[8071] = {--蓬莱阁
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50110,pos = 26,max = 1,weight = -1},{ID = 50111,weight= 40},{ID = 50112,weight= 40},{ID = 50113,weight= 5},{ID = 50114,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8072] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50110,pos = 26,max = 1,weight = -1},{ID = 50111,weight= 30},{ID = 50112,weight= 30},{ID = 50113,weight= 15},{ID = 50114,weight= 15},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8073] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50110,pos = 26,max = 1,weight = -1},{ID = 50113,weight= 35},{ID = 50114,weight= 35},{ID = 50115,weight= 10},{ID = 50116,weight= 10},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8074] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50110,pos = 26,max = 1,weight = -1},{ID = 50113,weight= 25},{ID = 50114,weight= 25},{ID = 50115,weight= 20},{ID = 50116,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},	
	}
ScriptFightDB[8075] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50110,pos = 26,max = 1,weight = -1},{ID = 50115,weight= 35},{ID = 50116,weight= 35},{ID = 50117,weight= 20},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	}
ScriptFightDB[8076] = {
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 8,maxCount = 8,{ID = 50110,pos = 26,max = 1,weight = -1},{ID = 50115,weight= 10},{ID = 50116,weight= 10},{ID = 50117,weight= 5},{ID = 50057,weight= 3},{ID = 50058,weight= 3},{ID = 50059,weight= 4}},
	
}


-------煮酒论英雄活动配置【8990~9000】没几个活动位置省一点=w= ----------------------------------------------------------------------
ScriptFightDB[8990] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 70001, pos=30},{ID = 70003,pos=26 },{ID =  70002,pos=21 },{ID = 70002, pos=33},{ID = 70004, pos=23},{ID = 70004, pos =28},{ID = 70004, pos=32},{ID = 70004, pos=35},},
}


-- 给个机会 这里是挖宝的战斗分割-------------------------------
ScriptFightDB[40000] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 48000, },{ID = 48001, },{ID = 50000, },{ID =  48002, },{ID = 48003, },{ID = 50005, },{ID = 50006, },{ID = 50007, },},
	}
ScriptFightDB[40001] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50001, },{ID = 50002, },{ID = 50000, },{ID =  50003, },{ID = 50004, },{ID = 50005, },{ID = 50006, },{ID = 50007, },},
	}
ScriptFightDB[40002] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50009, },{ID = 50010, },{ID = 50008, },{ID = 50011, },{ID = 50012, },{ID = 50013, },{ID = 50014, },{ID = 50015, },},
	}
ScriptFightDB[40003] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50016, },{ID = 50018, },{ID = 50017, },{ID = 50019, },{ID = 50020, },},
	}
ScriptFightDB[40004] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50021, },{ID = 50023, },{ID = 50022, },{ID = 50024, },{ID = 50025, },},
	}
ScriptFightDB[40005] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50026, },{ID = 50028, },{ID = 50027, },{ID = 50029, },{ID = 50030, },},

systemActions = {
			[1] = {
				condition = {
				              {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		        },
				actions =   {
					      {type = ScriptFightActionType.PlayBubble,params={DBID={50026},bubbleID = 500},},}
			},
	                },
	}
ScriptFightDB[40006] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50031, },{ID = 50033, },{ID = 50032, },{ID = 50034, },{ID = 50035, },},
systemActions = {
			[1] = {
				condition = {
				              {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		        },
				actions =   {
					      {type = ScriptFightActionType.PlayBubble,params={DBID={50031},bubbleID = 501},},}
			},
	                },
	}
ScriptFightDB[40007] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 50036, },{ID = 50037, },{ID = 50038, },{ID = 50039, },{ID = 50040, },},
systemActions = {
			[1] = {
				condition = {
				              {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		        },
				actions =   {
					      {type = ScriptFightActionType.PlayBubble,params={DBID={50036},bubbleID = 502},},}
			},
	                },
	}

-- 抓宠玩法（35001——35500）-------------------------------
ScriptFightDB[35001] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10201,weight= 65}, {ID = 10301,weight= 30}, {ID = 10401,weight= 5}},
}
ScriptFightDB[35002] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10202,weight= 65}, {ID = 10302,weight= 30}, {ID = 10402,weight= 5}},
}
ScriptFightDB[35003] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10203,weight= 65}, {ID = 10303,weight= 30}, {ID = 10403,weight= 5}},
}
ScriptFightDB[35004] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10204,weight= 65}, {ID = 10304,weight= 30}, {ID = 10404,weight= 5}},
}
ScriptFightDB[35005] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10205,weight= 65}, {ID = 10305,weight= 30}, {ID = 10405,weight= 5}},
}
ScriptFightDB[35006] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10206,weight= 65}, {ID = 10306,weight= 30}, {ID = 10406,weight= 5}},
}
ScriptFightDB[35007] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10207,weight= 65}, {ID = 10307,weight= 30}, {ID = 10407,weight= 5}},
}
ScriptFightDB[35008] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10208,weight= 65}, {ID = 10308,weight= 30}, {ID = 10408,weight= 5}},
}
ScriptFightDB[35009] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10209,weight= 65}, {ID = 10309,weight= 30}, {ID = 10409,weight= 5}},
}
ScriptFightDB[35010] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10210,weight= 65}, {ID = 10310,weight= 30}, {ID = 10410,weight= 5}},
}
ScriptFightDB[35011] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10211,weight= 65}, {ID = 10311,weight= 30}, {ID = 10411,weight= 5}},
}
ScriptFightDB[35012] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10212,weight= 65}, {ID = 10312,weight= 30}, {ID = 10412,weight= 5}},
}
ScriptFightDB[35013] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10213,weight= 65}, {ID = 10313,weight= 30}, {ID = 10413,weight= 5}},
}
ScriptFightDB[35014] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10214,weight= 65}, {ID = 10314,weight= 30}, {ID = 10414,weight= 5}},
}
ScriptFightDB[35015] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10401},},
}
ScriptFightDB[35016] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10402},},
}
ScriptFightDB[35017] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10403},},
}
ScriptFightDB[35018] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10404},},
}
ScriptFightDB[35019] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10405},},
}
ScriptFightDB[35020] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10406},},
}
ScriptFightDB[35021] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10407},},
}
ScriptFightDB[35022] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10408},},
}
ScriptFightDB[35023] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10409},},
}
ScriptFightDB[35024] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10410},},
}
ScriptFightDB[35025] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10411},},
}
ScriptFightDB[35026] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10412},},
}
ScriptFightDB[35027] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10413},},
}
ScriptFightDB[35028] = {					---------------30地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10414},},
}

ScriptFightDB[35050] = {					---------------30地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10501,weight= 50}, {ID = 10601,weight= 50}},
}
ScriptFightDB[35051] = {					---------------30地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10502,weight= 50}, {ID = 10602,weight= 50}},
}
ScriptFightDB[35052] = {					---------------30地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10503,weight= 50}, {ID = 10601,weight= 50}},
}
ScriptFightDB[35053] = {					---------------30地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10504,weight= 50}, {ID = 10602,weight= 50}},
}
ScriptFightDB[35080] = {					---------------30地图抓宠终极boss
	--monsters = {type=ScriptMonsterCreateType.Random,{ID = 10609,weight= 99}, {ID = 10602,weight= 1,max = 1}},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10609},},
}
ScriptFightDB[35081] = {					---------------30地图抓宠终极boss
	--monsters = {type=ScriptMonsterCreateType.Random,{ID = 10609,weight= 99}, {ID = 10602,weight= 1,max = 1}},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10610},},
}
ScriptFightDB[35082] = {					---------------30地图抓宠终极boss
	--monsters = {type=ScriptMonsterCreateType.Random,{ID = 10609,weight= 99}, {ID = 10602,weight= 1,max = 1}},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10601},},
}
ScriptFightDB[35083] = {					---------------30地图抓宠终极boss
	--monsters = {type=ScriptMonsterCreateType.Random,{ID = 10609,weight= 99}, {ID = 10602,weight= 1,max = 1}},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10602},},
}

-----------------------------40地图抓宠
ScriptFightDB[35101] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10215,weight= 60}, {ID = 10315,weight= 35}, {ID = 10415,weight= 5}},
}
ScriptFightDB[35102] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10216,weight= 60}, {ID = 10316,weight= 35}, {ID = 10416,weight= 5}},
}
ScriptFightDB[35103] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10217,weight= 60}, {ID = 10317,weight= 35}, {ID = 10417,weight= 5}},
}
ScriptFightDB[35104] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10218,weight= 60}, {ID = 10318,weight= 35}, {ID = 10418,weight= 5}},
}
ScriptFightDB[35105] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10219,weight= 60}, {ID = 10319,weight= 35}, {ID = 10419,weight= 5}},
}
ScriptFightDB[35106] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10220,weight= 60}, {ID = 10320,weight= 35}, {ID = 10420,weight= 5}},
}
ScriptFightDB[35107] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10221,weight= 60}, {ID = 10321,weight= 35}, {ID = 10421,weight= 5}},
}
ScriptFightDB[35108] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10222,weight= 60}, {ID = 10322,weight= 35}, {ID = 10422,weight= 5}},
}
ScriptFightDB[35109] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10223,weight= 60}, {ID = 10323,weight= 35}, {ID = 10423,weight= 5}},
}
ScriptFightDB[35110] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10415},},
}
ScriptFightDB[35111] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10416},},
}
ScriptFightDB[35112] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10417},},
}
ScriptFightDB[35113] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10418},},
}
ScriptFightDB[35114] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10419},},
}
ScriptFightDB[35115] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10420},},
}
ScriptFightDB[35116] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10421},},
}
ScriptFightDB[35117] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10422},},
}
ScriptFightDB[35118] = {					---------------40地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10423},},
}
ScriptFightDB[35150] = {					---------------40地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10505,weight= 99}, {ID = 10603,weight= 1}},
}
ScriptFightDB[35151] = {					---------------40地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10506,weight= 99}, {ID = 10604,weight= 1}},
}
ScriptFightDB[35152] = {					---------------40地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10507,weight= 99}, {ID = 10603,weight= 1}},
}
ScriptFightDB[35153] = {					---------------40地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10508,weight= 99}, {ID = 10604,weight= 1}},
}
ScriptFightDB[35180] = {					---------------40地图抓宠终极boss
	--monsters = {type=ScriptMonsterCreateType.Random,{ID = 10609,weight= 99}, {ID = 10602,weight= 1,max = 1}},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10610},},
}

-----------------------------50地图抓宠
ScriptFightDB[35201] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10224,weight= 60}, {ID = 10324,weight= 35}, {ID = 10424,weight= 5}},
}
ScriptFightDB[35202] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10225,weight= 60}, {ID = 10325,weight= 35}, {ID = 10425,weight= 5}},
}
ScriptFightDB[35203] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10226,weight= 60}, {ID = 10326,weight= 35}, {ID = 10426,weight= 5}},
}
ScriptFightDB[35204] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10227,weight= 60}, {ID = 10327,weight= 35}, {ID = 10427,weight= 5}},
}
ScriptFightDB[35205] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10228,weight= 60}, {ID = 10328,weight= 35}, {ID = 10428,weight= 5}},
}
ScriptFightDB[35206] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10229,weight= 60}, {ID = 10329,weight= 35}, {ID = 10429,weight= 5}},
}
ScriptFightDB[35207] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10230,weight= 60}, {ID = 10330,weight= 35}, {ID = 10430,weight= 5}},
}
ScriptFightDB[35208] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10231,weight= 60}, {ID = 10331,weight= 35}, {ID = 10431,weight= 5}},
}
ScriptFightDB[35209] = {					
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10232,weight= 60}, {ID = 10332,weight= 35}, {ID = 10432,weight= 5}},
}
ScriptFightDB[35210] = {	
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10233,weight= 60}, {ID = 10333,weight= 35}, {ID = 10433,weight= 5}},
}
ScriptFightDB[35211] = {	
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10234,weight= 60}, {ID = 10334,weight= 35}, {ID = 10434,weight= 5}},
}
ScriptFightDB[35212] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10424},},
}
ScriptFightDB[35213] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10425},},
}
ScriptFightDB[35214] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10426},},
}
ScriptFightDB[35215] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10427},},
}
ScriptFightDB[35216] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10428},},
}
ScriptFightDB[35217] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10429},},
}
ScriptFightDB[35218] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10430},},
}
ScriptFightDB[35219] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10431},},
}
ScriptFightDB[35220] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10432},},
}
ScriptFightDB[35221] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10433},},
}
ScriptFightDB[35222] = {					---------------50地图变异宠
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10434},},
}

ScriptFightDB[35250] = {					---------------50地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10509,weight= 99}, {ID = 10605,weight= 1}},
}
ScriptFightDB[35251] = {					---------------50地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10510,weight= 99}, {ID = 10606,weight= 1}},
}
ScriptFightDB[35252] = {					---------------50地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10511,weight= 99}, {ID = 10605,weight= 1}},
}
ScriptFightDB[35253] = {					---------------50地图抓宠巡逻怪
	monsters = {type=ScriptMonsterCreateType.Random,count = 1,{ID = 10512,weight= 99}, {ID = 10606,weight= 1}},
}
ScriptFightDB[35280] = {					---------------50地图抓宠终极boss
	--monsters = {type=ScriptMonsterCreateType.Random,{ID = 10609,weight= 99}, {ID = 10602,weight= 1,max = 1}},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 10611},},
}

-- 45000 - 50000 瑞兽赐福 这个在其他的配置中配置
ScriptFightDB[45000] = 
{
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 25501,pos = 21}},
	-- 要刷新的小怪种类及权重
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 7,maxCount = 7,{ID = 25505,weight= 50},{ID = 25507,weight= 20},{ID = 25508,weight= 50},{ID = 25509,weight= 50}, {ID = 25510,weight= 40},{ID = 25511,weight= 50},},
	systemActions = 
	{	      	     
	      [1] =      --主怪血量小于0，战斗结束
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25501,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayDialog,params={ID=35109}, } ,
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	       },
              [2] = 
	      { 
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25510,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={25501},bubbleID = 524},},
		  {type = ScriptFightActionType.PlayAction,params={DBID={25501},actionID = 1034}},
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 5007,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
              [3] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25509,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 1116,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = 20}},
		  },
	      },
              [4] = 
	      {     
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25507,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25501,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1, 
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25501},bubbleID = 521},},
		  },
	      },
              [5] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25511,relation="=",value = 1},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25511},bubbleID = 526},},
		  },
	      },
	 },
	begin = 
	{		--回合开始做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25501},bubbleID = 520},},
		  {type = ScriptFightActionType.AddBuff,params={DBID ={25501},buffID = 66},},
		  },
	      },	      
	},
	fin = 
	{		--回合结束做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
                  {type = ScriptFightConditionType.RoundCount, params={ round = 5 },},
                  {type = ScriptFightConditionType.IDExist, params={DBID = 25509,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25501,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25501},bubbleID = 522},},
		  },
	      },	      	      
	},
         -- 奖励信息
	LuckyRewardID = 1,
}

ScriptFightDB[45001] = 
{
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 25502,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 7,maxCount = 7,{ID = 25505,weight= 50},{ID = 25507,weight= 20}, {ID = 25508,weight= 50},{ID = 25509,weight= 50}, {ID = 25510,weight= 40},{ID = 25511,weight= 50},},
	systemActions = 
	{	      	     
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25502,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayDialog,params={ID=35110}, } ,
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	       },
              [2] = 
	      { 
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25510,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={25502},bubbleID = 524},},
		  {type = ScriptFightActionType.PlayAction,params={DBID={25502},actionID = 1034}},
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 5007,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
              [3] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25509,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 1116,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = 20}},
		  },
	      },
              [4] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25507,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25502,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25502},bubbleID = 521},},
		  },
	      },
              [5] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25511,relation="=",value = 1},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25511},bubbleID = 526},},
		  },
	      },
	 },
	begin = 
	{		--回合开始做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25502},bubbleID = 520},},
		  {type = ScriptFightActionType.AddBuff,params={DBID ={25502},buffID = 66},},
		  },
	      },	      
	},
	fin = 
	{		--回合结束做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
                  {type = ScriptFightConditionType.RoundCount, params={ round = 5 },},
                  {type = ScriptFightConditionType.IDExist, params={DBID = 25509,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25502,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25502},bubbleID = 522},},
		  },
	      },	      	      
	},
         -- 奖励信息
	LuckyRewardID = 1,
}

ScriptFightDB[45002] = 
{
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 25503,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 7,maxCount = 7,{ID = 25505,weight= 50},{ID = 25507,weight= 20}, {ID = 25508,weight= 50},{ID = 25509,weight= 50}, {ID = 25510,weight= 40},{ID = 25511,weight= 50},},
	systemActions = 
	{	      	     
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25503,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayDialog,params={ID=35111}, } ,
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	       },
              [2] = 
	      { 
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25510,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={25503},bubbleID = 524},},
		  {type = ScriptFightActionType.PlayAction,params={DBID={25503},actionID = 1034}},
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 5007,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
              [3] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25509,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 1116,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = 20}},
		  },
	      },
              [4] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25507,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25503,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25503},bubbleID = 521},},
		  },
	      },
              [5] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25511,relation="=",value = 1},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25511},bubbleID = 526},},
		  },
	      },
	 },
	begin = 
	{		--回合开始做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25503},bubbleID = 520},},
		  {type = ScriptFightActionType.AddBuff,params={DBID ={25503},buffID = 66},},
		  },
	      },	      
	},
	fin = 
	{		--回合结束做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
                  {type = ScriptFightConditionType.RoundCount, params={ round = 5 },},
                  {type = ScriptFightConditionType.IDExist, params={DBID = 25509,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25503,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25503},bubbleID = 522},},
		  },
	      },	      	      
	},
         -- 奖励信息
	LuckyRewardID = 1,
}

ScriptFightDB[45003] = 
{
	-- 战斗类型
	subType = ScriptType.LuckyMonster,
	-- 主怪信息
	majorMonsterInfo = {{ID = 25504,pos = 21}},
	-- 要刷新怪的信息
	monsters = {type=ScriptMonsterCreateType.Random,minCount = 7,maxCount = 7,{ID = 25505,weight= 50},{ID = 25507,weight= 20}, {ID = 25508,weight= 50},{ID = 25509,weight= 50}, {ID = 25510,weight= 40},{ID = 25511,weight= 50},},
	systemActions = 
	{	      	     
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25504,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayDialog,params={ID=35112}, } ,
		  {type = ScriptFightActionType.FightEnd,params={winner = "player" }},--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
		  },
	       },
              [2] = 
	      { 
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25510,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
                  {type = ScriptFightActionType.PlayBubble,params={DBID={25504},bubbleID = 524},},
		  {type = ScriptFightActionType.PlayAction,params={DBID={25504},actionID = 1034}},
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 5007,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = -50}},
		  },
	      },
              [3] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.AttrValue, params={DBID = 25509,type="hp",["<="] = 0},},
		   isAnd = true,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayEffect,params={magicID = 1116,DBID ={0},type = LightEffectType.Unit } },
		  {type = ScriptFightActionType.ChangeHp,params={DBID =-1,percent = 20}},
		  },
	      },
              [4] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25507,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25504,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25504},bubbleID = 521},},
		  },
	      },
              [5] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.IDExist, params={DBID = 25511,relation="=",value = 1},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25511},bubbleID = 526},},
		  },
	      },
	 },
	begin = 
	{		--回合开始做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
	          {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25504},bubbleID = 520},},
		  {type = ScriptFightActionType.AddBuff,params={DBID ={25504},buffID = 66},},
		  },
	      },	      
	},
	fin = 
	{		--回合结束做哪些事，配置方式同systemActions
	      [1] = 
	      {
		  condition = 
		  {
                  {type = ScriptFightConditionType.RoundCount, params={ round = 5 },},
                  {type = ScriptFightConditionType.IDExist, params={DBID = 25509,relation=">=",value = 1},},
		  {type = ScriptFightConditionType.AttrValue, params={DBID = 25504,type="hp",[">"] = 0},},
		   isAnd = true,
		   count = 1,
		  },
		  actions = 
		  {
		  {type = ScriptFightActionType.PlayBubble,params={DBID={25504},bubbleID = 522},},
		  },
	      },	      	      
	},
         -- 奖励信息
	LuckyRewardID = 1,
}
-----------------------------------------7101~7999帮会环任务脚本------------------------------------------------------------------------------

-----------------------帮会休闲任务-智擒真凶测试脚本----------------------

ScriptFightDB[7101] = {                                                                

	subType = ScriptType.Random, 
	count = 1,	
	isRepeat = false ,   

	phases = {		
		[1] = {	 --第一组 商人-小偷	
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			
			monsters = {40100, 40112, 40129, 40113, 40114, 40115, 40116, 40101 },        
			
                        systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          --指定回合生效：round =指定回合数

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40100},bubbleID = 1000},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
							 {type = ScriptFightConditionType.IsAttacked, params={DBID = {40100, 40112, 40129, 40113, 40114, 40115, 40116,},}, },
						       isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },

		                  [3] = {

			                  condition = {
				                          {type = ScriptFightConditionType.AttrValue, params={DBID = 40101,type="hp",["<="] = 0},},
				 
			                              },

			                  actions = {
				                           {type = ScriptFightActionType.FightEnd,params={winner = "player" }},
				                            --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                        },								
	                                },          
	              }, --第一组 商人-小偷
		[2] = {	 --第二组 仙翁-童子	
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			
			monsters = {40104, 40117, 40119, 40133, 40120, 40113, 40130, 40105 },        
			
                        systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          --指定回合生效：round =指定回合数

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40104},bubbleID = 1001},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
							 {type = ScriptFightConditionType.IsAttacked, params={DBID = {40104, 40117, 40119, 40133, 40120, 40113, 40130,},}, },
						       isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项

			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },

		                  [3] = {

			                  condition = {
				                          {type = ScriptFightConditionType.AttrValue, params={DBID = 40105,type="hp",["<="] = 0},},
				 
			                              },

			                  actions = {
				                           {type = ScriptFightActionType.FightEnd,params={winner = "player" }},
				                            --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                        },								
	                                },          
	              }, --第二组 仙翁-童子
		[3] = {	 --第三组 道长-蝙蝠	
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			
			monsters = {40108, 40113, 40117, 40112, 40132, 40130, 40115, 40109 },        
			
                        systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          --指定回合生效：round =指定回合数

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40108},bubbleID = 1003},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
							 {type = ScriptFightConditionType.IsAttacked, params={DBID = {40108, 40113, 40117, 40112, 40132, 40130, 40115,},}, },
						       isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },

		                  [3] = {

			                  condition = {
				                          {type = ScriptFightConditionType.AttrValue, params={DBID = 40109,type="hp",["<="] = 0},},
				 
			                              },

			                  actions = {
				                           {type = ScriptFightActionType.FightEnd,params={winner = "player" }},
				                            --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                        },								
	                                },          
	              }, --第三组 道长-蝙蝠
		[4] = {	 --第四组 书吏-赵云	
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			
			monsters = {40110, 40116, 40131, 40112, 40114, 40120, 40129, 40111 },        
			
                        systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40110},bubbleID = 1004},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
			                               {type = ScriptFightConditionType.IsAttacked, params={DBID = {40110, 40116, 40131, 40112, 40114, 40120, 40129,},}, },
						       isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
						       },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },

		                  [3] = {

			                  condition = {
				                          {type = ScriptFightConditionType.AttrValue, params={DBID = 40111,type="hp",["<="] = 0},},
				 
			                              },

			                  actions = {
				                           {type = ScriptFightActionType.FightEnd,params={winner = "player" }},
				                            --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                        },								
	                                },          
	              }, --第四组 书吏-赵云

        
                 },

                        rewards={			
		                          mats={{ID=10001,count = 1},{ID=10002,count = 1}},		
		                          exp = 1,												
		                          money = 1,											
		                          subMoney = 1,										
	                        },
                    }

------------------挑战帮会守卫脚本-------------------------------------------

ScriptFightDB[7102] = {        ----挑战帮会守卫                                                        

	subType = ScriptType.Random, 
	count = 1,	
	isRepeat = false ,   

	phases = {		
		[1] = {	 --第一组
			
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,			
			monsters = {40136, 40137, 40138, 40139, 40140, 40141, 40142, 40143 },        			                                 
	                systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40136},bubbleID = 1005},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },
				       },
		      }, --第一组 

		[2] = {	 --第二组 	
			
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			monsters = {40144, 40145, 40146, 40147, 40148, 40149, 40150, 40151 },                  
	                systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40144},bubbleID = 1005},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },
				       },
		      }, --第二组 

		[3] = {	 --第三组 
		
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			monsters = {40152, 40153, 40154, 40155, 40156, 40157, 40158, 40159 },        
			systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40152},bubbleID = 1005},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },
				       },            
	              }, --第三组 

		[4] = {	 --第四组 
		
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			monsters = {40160, 40161, 40162, 40163, 40164, 40165, 40166, 40167 },        
			systemActions = {                                                               

		                  [1] = {								--执行行为ID，ID越小越先执行
			                  condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数

				                        {type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},
				                          

				                         isAnd = true,
				                         --多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				                         --count = 1,
				                         --条件执行次数：不写则视为无限次
			                              },
			                  actions = {							--此处不可省略，可填入任意条动作使其生效
				                        {type = ScriptFightActionType.PlayBubble,params={DBID={40160},bubbleID = 1005},},
				                         --播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				                         isSameTime = true,
				                         --添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			                            },
		                       },

                                  [2] = {
			                  condition = {
				                         {type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				                          --指定回合生效：round =指定回合数
			                               },

			                  actions = {
				                         {type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				                          --战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			                            },
		                         },
				       },          
	              }, --第四组 

        
                 },

                        rewards={			
		                          mats={{ID=10001,count = 1},{ID=10002,count = 1}},		
		                          exp = 1,												
		                          money = 1,											
		                          subMoney = 1,										
	                        },
                      }

 -------------------------------------帮会环任务积分挑战脚本-----------------------------------------------------------------------------------
ScriptFightDB[7103] = {                                                                

	subType = ScriptType.Random, 
	count = 1,	
	isRepeat = false ,   

	phases = {		
		  [1] = {	--第一组，苹果佬	哎呀~你撞倒我了，要给我5个苹果才起来
			typeID = 0, sceneID = "zd_bingchuan2.xml" ,isSpecialAction =true,
			
			monsters = {40180, 40181, 40182, 40183, 40184, 40185, 40186, 40187 }, 
			systemActions = {                                                               

		              [1]={								

			condition = {						
				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				isAnd = true,
				count = 1,
				
			            },


			actions = {							
				{type = ScriptFightActionType.PlayBubble,params={DBID={40180},bubbleID = 1006},},
				isSameTime = true,
			           },
		                   },

                              [2]={
			condition = {
				{type = ScriptFightConditionType.ScoreNum, params={relation ="=", value = 5,},},
				--判断玩家积分：relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=判断值
				isAnd = true,
				count = 1,
			            },

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "player" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				
		                  },

		              [3]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
				 --指定回合生效：round =指定回合数
			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				--{type = ScriptFightActionType.EntityQuit,params={DBID ={40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128,},} },
			             },
		                   },								
                              [4]={
			condition = {         --一个榴莲
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40181,type="hp",["<="] = 0},},

			            },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [5]={
			condition = {         --两个苹果
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40182,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 2} },
				--增加玩家积分：value =积分值
			          },
		                  },
		              [6]={
			condition = {        --三个苹果
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40183,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 3} },
				--增加玩家积分：value =积分值
			           },
		                   },
		              [7]={
			condition = {         --4个橘子
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40184,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [8]={
			condition = {           --五个凤梨
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40185,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			           },
		                   },
		              [9]={
			condition = {          --6个苹果
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40186,type="hp",["<="] = 0},},

			          },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [10]={
			condition = {          --7个橙子
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40187,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			            },
		                    },
	
	                                },
	                },
			},
                  [2] = {	--第二组，卖鱼商人，买7条鱼以上给优惠	
			typeID = 0, sceneID = "zd_bingchuan2.xml" ,isSpecialAction =true,
			
			monsters = {40188, 40189, 40190, 40191, 40192, 40193, 40194, 40195 }, 
			systemActions = {                                                               

		              [1]={								

			condition = {						
				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				isAnd = true,
				count = 1,
				
			            },


			actions = {							
				{type = ScriptFightActionType.PlayBubble,params={DBID={40188},bubbleID = 1007},},
				isSameTime = true,
			           },
		                   },

                              [2]={
			condition = {
				{type = ScriptFightConditionType.ScoreNum, params={relation =">=", value = 7,},},
				--判断玩家积分：relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=判断值
				isAnd = true,
				count = 1,
			            },

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "player" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				
		                  },

		              [3]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
				 --指定回合生效：round =指定回合数
			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				--{type = ScriptFightActionType.EntityQuit,params={DBID ={40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128,},} },
			             },
		                   },								
                              [4]={
			condition = {         --鲤鱼
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40189,type="hp",["<="] = 0},},

			            },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [5]={
			condition = {   --一条鱼
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40190,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [6]={
			condition = {       --草鱼
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40191,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			           },
		                   },
		              [7]={
			condition = {       --五条鱼
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40192,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 5} },
				--增加玩家积分：value =积分值
			          },
		                  },
		              [8]={
			condition = {     ----鱼竿
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40193,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			           },
		                   },
		              [9]={
			condition = {      --2个玩具鱼
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40194,type="hp",["<="] = 0},},

			          },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [10]={
			condition = {       --3条鱼
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40195,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 3} },
				--增加玩家积分：value =积分值
			            },
		                    },
	
	                                },
	                },



                  [3] = {	  --第三组，李先生，同学们知道5千克棉花加上4千克铁，到底有多重？	
			typeID = 0, sceneID = "zd_bingchuan2.xml" ,isSpecialAction =true,
			
			monsters = {40196, 40197, 40198, 40199, 40200, 40201, 40202, 40203 }, 
			systemActions = {                                                               

		              [1]={								

			condition = {						
				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				isAnd = true,
				count = 1,
				
			            },


			actions = {							
				{type = ScriptFightActionType.PlayBubble,params={DBID={40196},bubbleID = 1008},},
				isSameTime = true,
			           },
		                   },

                              [2]={
			condition = {
				{type = ScriptFightConditionType.ScoreNum, params={relation =">=", value = 9,},},
				--判断玩家积分：relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=判断值
				isAnd = true,
				count = 1,
			            },

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "player" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				
			          },
		                  },

		              [3]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
				 --指定回合生效：round =指定回合数
			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				--{type = ScriptFightActionType.EntityQuit,params={DBID ={40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128,},} },
			             },
		                   },								
                              [4]={
			condition = {                 --5千克荔枝
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40197,type="hp",["<="] = 0},},

			            },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 5} },
				--增加玩家积分：value =积分值
			          },
		                  },
		              [5]={
			condition = {                 --3千克米
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40123,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [6]={
			condition = {                   --4千克铁
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40124,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 4} },
				--增加玩家积分：value =积分值
			           },
		                   },
		              [7]={
			condition = {                   --2斤花生
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40125,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [8]={
			condition = {                   --2颗鸡蛋
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40126,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			           },
		                   },
		              [9]={
			condition = {                    --1克拉钻石
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40127,type="hp",["<="] = 0},},

			          },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [10]={
			condition = {                    --半斤面粉
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40128,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			            },
		                    },
	
	                                },
	                },
		  [4] = {		
			typeID = 0, sceneID = "zd_bingchuan2.xml" ,isSpecialAction =true,
			
			monsters = {40204, 40205, 40206, 40207, 40208, 40209, 40210, 40211 }, 
			systemActions = {                                                               

		              [1]={								

			condition = {						
				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				isAnd = true,
				count = 1,
				
			            },


			actions = {							
				{type = ScriptFightActionType.PlayBubble,params={DBID={40204},bubbleID = 1009},},
				isSameTime = true,
			           },
		                   },

                              [2]={
			condition = {
				{type = ScriptFightConditionType.ScoreNum, params={relation =">=", value = 7,},},
				--判断玩家积分：relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=判断值
				isAnd = true,
				count = 1,
			            },

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "player" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				
			          },
		                  },

		              [3]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
				 --指定回合生效：round =指定回合数
			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				--{type = ScriptFightActionType.EntityQuit,params={DBID ={40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128,},} },
			             },
		                   },								
                              [4]={
			condition = {                 --7个流氓
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40205,type="hp",["<="] = 0},},

			            },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [5]={
			condition = {                --3个刺客
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40206,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [6]={
			condition = {                 --3名士兵
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40207,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 3} },
				--增加玩家积分：value =积分值
			           },
		                   },
		              [7]={
			condition = {                 --1名将军
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40208,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			          },
		                  },
		              [8]={
			condition = {                --好多小姐姐
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40209,type="hp",["<="] = 0},},

			           },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			           },
		                   },
		              [9]={
			condition = {                 --5名士兵
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40210,type="hp",["<="] = 0},},

			          },

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 5} },
				--增加玩家积分：value =积分值
			          },
		                  },
		              [10]={
			condition = {                 --一位老爷爷
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40211,type="hp",["<="] = 0},},

			             },

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			            },
		                    },
	
	                                },
	                },	
	
},
},
}


----------------------------phases test 多阶段战斗脚本测试-------------------------------------------------------------------------------------

ScriptFightDB[40] = {                                                                

	subType = ScriptType.Random, 
	count = 3,	
	isRepeat = false ,   

	phases = {		
		[1] = {		
			
			typeID = 0, sceneID = "zd_fb_jt01.xml" ,isSpecialAction =true,
			monsters={31250},        
			
		},
		[2] = {
			typeID = 0, sceneID = "zd_yw_yl01.xml" ,isSpecialAction =true,
			monsters={31254,31257},
		
	},
                [3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml" ,isSpecialAction =true,
			monsters={30354,30357},
		
	},
	      
},
rewards={			
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		
		exp = 1,												
		money = 1,											
		subMoney = 1,										
	},
}

--------------------------------------------jiaoben test 脚本测试-----------------------------------------------------

ScriptFightDB[41] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31250, },},
	}

ScriptFightDB[42] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 31250, },},
	begin  = {                                                               

		[1] = {								

			condition = {						
				
				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				--{type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 2},},
				
                          count = 1,
			 },

			actions = {							

				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31258,count = 3},} },
			        {type = ScriptFightActionType.AddBuff,params={DBID ={31282},buffID = 11} },
				

				isSameTime = true,
			 },
		 },
                 [2] = {								

			condition = {						
				
				{type = ScriptFightConditionType.AttrValue, params={DBID = 31282,type="hp",["<="] = 30},},
				--{type = ScriptFightConditionType.RoundInterval, params={period = 2,startRound = 2},},
				
                          count = 1,
			 },

			actions = {							

				{type = ScriptFightActionType.EntityEnter,params={{DBID = 31258,count = 3},} },
			        {type = ScriptFightActionType.AddBuff,params={DBID ={31282},buffID = 44} },
				

				isSameTime = true,
			 },
		 },

		
								
	},
	
	}
-----------------------帮会休闲任务-智擒真凶测试脚本----------------------

ScriptFightDB[43] = {                                                                

	subType = ScriptType.Random, 
	count = 3,	
	isRepeat = false ,   

	phases = {		
		[1] = {		
			typeID = 0, sceneID = "zd_huangye2.xml" ,isSpecialAction =true,
			
			monsters = {40100, 40112, 40110, 40113, 40114, 40115, 40107, 40101 },        
			
                systemActions = {                                                               

		[1] = {								--执行行为ID，ID越小越先执行

			condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数


				 {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				 --指定回合生效：round =指定回合数

				isAnd = true,
				--多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				count = 1,
				--条件执行次数：不写则视为无限次
			 },


			actions = {							--此处不可省略，可填入任意条动作使其生效

				{type = ScriptFightActionType.PlayBubble,params={DBID={40100},bubbleID = 533},},
				--播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				isSameTime = true,
				--添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			 },
		 },--行为1

                  [2]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				 --指定回合生效：round =指定回合数
			},

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			},
		 },

		 [3]={
			condition = {
				--{type = ScriptFightConditionType.IDExist, params={DBID = {40101},},},
				--目标单位是否存在：DBID=目标ID，支持填入多个，英文逗号隔开
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40101,type="hp",["<="] = 0},},
				 --指定单位是否受击：DBID=目标ID，支持填入多个
			},

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "player" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			},
		 },								
	},          
	  },    
	[2] = {
			typeID = 0, sceneID = "zd_yw_tg01_01.xml" ,isSpecialAction =true,
			monsters={31254,31257},
		
	},
        [3] = {
			typeID = 0, sceneID = "zd_yw_dk01_01.xml" ,isSpecialAction =true,
			monsters={30354,30357},
		
	},
},
rewards={			
		mats={{ID=10001,count = 1},{ID=10002,count = 1}},		
		exp = 1,												
		money = 1,											
		subMoney = 1,										
	},
}

ScriptFightDB[44] = {

monsters = {type=ScriptMonsterCreateType.Assign,{ID = 40100,},{ID = 40112, },{ID = 40110, },{ID = 40113, },{ID = 40114, },{ID = 40115, },{ID = 40107, },{ID = 40101, },},

systemActions = {                                                               

		[1] = {								--执行行为ID，ID越小越先执行

			condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数


				 {type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				 --指定回合生效：round =指定回合数

				isAnd = true,
				--多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				count = 1,
				--条件执行次数：不写则视为无限次
			 },


			actions = {							--此处不可省略，可填入任意条动作使其生效

				{type = ScriptFightActionType.PlayBubble,params={DBID={40100},bubbleID = 533},},
				--播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				isSameTime = true,
				--添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			 },
		 },--行为1

                  [2]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 4 },},
				 --指定回合生效：round =指定回合数
			},

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			},
		 },

		 [3]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40101,type="hp",["<="] = 0},},
				--{type = ScriptFightConditionType.IsAttacked, params={DBID = {40101},}, },
				 --指定单位是否受击：DBID=目标ID，支持填入多个
			},

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "player" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			},
		 },								
	}, 
	}
-----------------------帮会休闲任务-积分挑战测试脚本----------------------

ScriptFightDB[45] = {

monsters = {type=ScriptMonsterCreateType.Assign,{ID = 40121,},{ID = 40122, },{ID = 40123, },{ID = 40124, },{ID = 40125, },{ID = 40126, },{ID = 40127, },{ID = 40128, },},

systemActions = {                                                               

		[1] = {								--执行行为ID，ID越小越先执行

			condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数


				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				 --指定回合生效：round =指定回合数

				isAnd = true,
				--多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				count = 1,
				--条件执行次数：不写则视为无限次
			 },


			actions = {							--此处不可省略，可填入任意条动作使其生效

				{type = ScriptFightActionType.PlayBubble,params={DBID={40121},bubbleID = 1006},},
				--播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				isSameTime = true,
				--添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			 },
		 },--行为1

                  [2]={
			condition = {
				{type = ScriptFightConditionType.ScoreNum, params={relation =">=", value = 5,},},
				--判断玩家积分：relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=判断值

				isAnd = true,
				--多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				count = 1,
				--条件执行次数：不写则视为无限次
			},

			actions = {
				{type = ScriptFightActionType.FightEnd,params={winner = "player" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			},
		 },

		 [3]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
				 --指定回合生效：round =指定回合数
			},

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
			},
		 },								
                [4]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40122,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 1} },
				--增加玩家积分：value =积分值
			},
		 },
		 [5]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40123,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 2} },
				--增加玩家积分：value =积分值
			},
		 },
		 [6]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40124,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 3} },
				--增加玩家积分：value =积分值
			},
		 },
		 [7]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40125,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 4} },
				--增加玩家积分：value =积分值
			},
		 },
		 [8]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40126,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 5} },
				--增加玩家积分：value =积分值
			},
		 },
		 [9]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40127,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 6} },
				--增加玩家积分：value =积分值
			},
		 },
		 [10]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40128,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 7} },
				--增加玩家积分：value =积分值
			},
		 },
	
	}, 
	}
ScriptFightDB[46] = {                                                                

	subType = ScriptType.Random, 
	count = 1,	
	isRepeat = false ,   

	phases = {		
		[1] = {		
			typeID = 0, sceneID = "zd_bingchuan2.xml" ,isSpecialAction =true,
			
			monsters = {40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128 }, 
			systemActions = {                                                               

		              [1] = {								--执行行为ID，ID越小越先执行

			condition = {						--此项不可省略，最少需要保留一行isAnd配置项，而不写入任何type项（即无条件触发触发）,count和isAnd仅能填入一条，其他的不限制条数


				{type = ScriptFightConditionType.RoundCount, params={ round = 1 },},
				 --指定回合生效：round =指定回合数

				isAnd = true,
				--多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				count = 1,
				--条件执行次数：不写则视为无限次
			 },


			actions = {							--此处不可省略，可填入任意条动作使其生效

				{type = ScriptFightActionType.PlayBubble,params={DBID={40121},bubbleID = 1006},},
				--播放气泡：DBID = 说话对象ID ，支持填入多个， DBID=0时表示玩家说话（组队时为队长），bubbleID =气泡ID
				
				isSameTime = true,
				--添加此项时表示action中的各项行为同时进行，否则可以不填入此项
			 },
		 },--行为1

                  [2]={
			condition = {
				{type = ScriptFightConditionType.ScoreNum, params={relation =">=", value = 5,},},
				--判断玩家积分：relation=比较类型（比较类型有："<"、">"、"="、"<="、">="），value=判断值

				isAnd = true,
				--多条件整合判断：true（需要满足全部条件才能触发），false（满足任意条件触发），此项不可省略

				count = 1,
				--条件执行次数：不写则视为无限次
			},

			actions = {
				--{type = ScriptFightActionType.FightEnd,params={winner = "player" },},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				{type = ScriptFightActionType.EntityQuit,params={DBID ={40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128,},} },
			},
		 },

		 [3]={
			condition = {
				{type = ScriptFightConditionType.RoundCount, params={ round = 2 },},
				 --指定回合生效：round =指定回合数
			},

			actions = {
				
				{type = ScriptFightActionType.FightEnd,params={winner = "monster" }},
				--战斗结束：winner = 胜利方 （“monster”= 怪物方、“player” = 玩家方）
				--{type = ScriptFightActionType.EntityQuit,params={DBID ={40121, 40122, 40123, 40124, 40125, 40126, 40127, 40128,},} },
			},
		 },								
                [4]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40122,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 1} },
				--增加玩家积分：value =积分值
			},
		 },
		 [5]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40123,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 2} },
				--增加玩家积分：value =积分值
			},
		 },
		 [6]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40124,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 3} },
				--增加玩家积分：value =积分值
			},
		 },
		 [7]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40125,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 4} },
				--增加玩家积分：value =积分值
			},
		 },
		 [8]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40126,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 5} },
				--增加玩家积分：value =积分值
			},
		 },
		 [9]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40127,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 6} },
				--增加玩家积分：value =积分值
			},
		 },
		 [10]={
			condition = {
				{type = ScriptFightConditionType.AttrValue, params={DBID = 40128,type="hp",["<="] = 0},},

			},

			actions = {
				
				{type = ScriptFightActionType.AddScore,params={value = 7} },
				--增加玩家积分：value =积分值
			},
		 },
	
	},
	},
	
},
}

ScriptFightDB[47] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 40035,},{ID = 30546,},},
	fin = {
	          [1]={
			condition = {
				{type = ScriptFightConditionType.RoundInterval, params={period = 1,startRound = 1},},

			},

			actions = {
				
				{type = ScriptFightActionType.PlayBubble,params={DBID={30546},bubbleID = 10026},},
				{type = ScriptFightActionType.FightPause,params={time = 4} },
				isSameTime = true,
			},
		 },
	}
}
--------------------------------10001~15000封神台脚本战斗------------------------------------
-----第1层
ScriptFightDB[10001] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60501, },{ID = 12001, },},
	}
ScriptFightDB[10002] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60502, },{ID = 12002, },},
	}
ScriptFightDB[10003] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60503, },{ID = 12003, },},
	}
ScriptFightDB[10004] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60504, },{ID = 12004, },},
	}
ScriptFightDB[10005] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60505, },{ID = 12001, },},
	}
ScriptFightDB[10006] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60506, },{ID = 12002, },},
	}
ScriptFightDB[10007] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60507, },{ID = 12003, },},
	}
-----第2层
ScriptFightDB[10008] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60509, },{ID = 12011, },},
	}
ScriptFightDB[10009] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60510, },{ID = 12012, },},
	}
ScriptFightDB[10010] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60511, },{ID = 12013, },},
	}
ScriptFightDB[10011] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60512, },{ID = 12014, },},
	}
ScriptFightDB[10012] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60513, },{ID = 12011, },},
	}
ScriptFightDB[10013] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60514, },{ID = 12012, },},
	}
ScriptFightDB[10014] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60515, },{ID = 12013, },},
	}
-----第3层
ScriptFightDB[10015] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60517, },{ID = 12021, },},
	}
ScriptFightDB[10016] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60518, },{ID = 12022, },},
	}
ScriptFightDB[10017] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60519, },{ID = 12023, },},
	}
ScriptFightDB[10018] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60520, },{ID = 12024, },},
	}
ScriptFightDB[10019] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60521, },{ID = 12021, },},
	}
ScriptFightDB[10020] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60522, },{ID = 12022, },},
	}
ScriptFightDB[10021] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60523, },{ID = 12023, },},
	}
-----第4层
ScriptFightDB[10022] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60525, },{ID = 12031, },},
	}
ScriptFightDB[10023] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60526, },{ID = 12032, },},
	}
ScriptFightDB[10024] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60527, },{ID = 12033, },},
	}
ScriptFightDB[10025] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60528, },{ID = 12034, },},
	}
ScriptFightDB[10026] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60529, },{ID = 12031, },},
	}
ScriptFightDB[10027] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60530, },{ID = 12032, },},
	}
ScriptFightDB[10028] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60531, },{ID = 12033, },},
	}
-----第5层
ScriptFightDB[10029] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60533, },{ID = 12041, },},
	}
ScriptFightDB[10030] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60534, },{ID = 12042, },},
	}
ScriptFightDB[10031] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60535, },{ID = 12043, },},
	}
ScriptFightDB[10032] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60536, },{ID = 12044, },},
	}
ScriptFightDB[10033] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60537, },{ID = 12041, },},
	}
ScriptFightDB[10034] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60538, },{ID = 12042, },},
	}
ScriptFightDB[10035] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60539, },{ID = 12043, },},
	}
-----第6层
ScriptFightDB[10036] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60541, },{ID = 12051, },},
	}
ScriptFightDB[10037] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60542, },{ID = 12052, },},
	}
ScriptFightDB[10038] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60543, },{ID = 12053, },},
	}
ScriptFightDB[10039] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60544, },{ID = 12054, },},
	}
ScriptFightDB[10040] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60545, },{ID = 12051, },},
	}
ScriptFightDB[10041] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60546, },{ID = 12052, },},
	}
ScriptFightDB[10042] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60547, },{ID = 12053, },},
	}
-----第7层
ScriptFightDB[10043] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60549, },{ID = 12061, },},
	}
ScriptFightDB[10044] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60550, },{ID = 12062, },},
	}
ScriptFightDB[10045] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60551, },{ID = 12063, },},
	}
ScriptFightDB[10046] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60552, },{ID = 12064, },},
	}
ScriptFightDB[10047] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60553, },{ID = 12061, },},
	}
ScriptFightDB[10048] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60554, },{ID = 12062, },},
	}
ScriptFightDB[10049] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60555, },{ID = 12063, },},
	}
-----第8层
ScriptFightDB[10050] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60557, },{ID = 12071, },},
	}
ScriptFightDB[10051] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60558, },{ID = 12072, },},
	}
ScriptFightDB[10052] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60559, },{ID = 12073, },},
	}
ScriptFightDB[10053] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60560, },{ID = 12074, },},
	}
ScriptFightDB[10054] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60561, },{ID = 12071, },},
	}
ScriptFightDB[10055] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60562, },{ID = 12072, },},
	}
ScriptFightDB[10056] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60563, },{ID = 12073, },},
	}
-----第9层
ScriptFightDB[10057] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60565, },{ID = 12081, },},
	}
ScriptFightDB[10058] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60566, },{ID = 12082, },},
	}
ScriptFightDB[10059] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60567, },{ID = 12083, },},
	}
ScriptFightDB[10060] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60568, },{ID = 12084, },},
	}
ScriptFightDB[10061] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60569, },{ID = 12081, },},
	}
ScriptFightDB[10062] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60570, },{ID = 12082, },},
	}
ScriptFightDB[10063] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60571, },{ID = 12083, },},
	}
-----第10层
ScriptFightDB[10064] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60573, },{ID = 12091, },},
	}
ScriptFightDB[10065] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60574, },{ID = 12092, },},
	}
ScriptFightDB[10066] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60575, },{ID = 12093, },},
	}
ScriptFightDB[10067] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60576, },{ID = 12094, },},
	}
ScriptFightDB[10068] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60577, },{ID = 12091, },},
	}
ScriptFightDB[10069] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60578, },{ID = 12092, },},
	}
ScriptFightDB[10070] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60579, },{ID = 12093, },},
	}
-----第11层
ScriptFightDB[10071] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60581, },{ID = 12101, },},
	}
ScriptFightDB[10072] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60582, },{ID = 12102, },},
	}
ScriptFightDB[10073] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60583, },{ID = 12103, },},
	}
ScriptFightDB[10074] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60584, },{ID = 12104, },},
	}
ScriptFightDB[10075] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60585, },{ID = 12101, },},
	}
ScriptFightDB[10076] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60586, },{ID = 12102, },},
	}
ScriptFightDB[10077] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60587, },{ID = 12103, },},
	}
-----第12层
ScriptFightDB[10078] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60589, },{ID = 12111, },},
	}
ScriptFightDB[10079] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60590, },{ID = 12112, },},
	}
ScriptFightDB[10080] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60591, },{ID = 12113, },},
	}
ScriptFightDB[10081] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60592, },{ID = 12114, },},
	}
ScriptFightDB[10082] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60593, },{ID = 12111, },},
	}
ScriptFightDB[10083] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60594, },{ID = 12112, },},
	}
ScriptFightDB[10084] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60595, },{ID = 12113, },},
	}
-----第13层
ScriptFightDB[10085] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60597, },{ID = 12121, },},
	}
ScriptFightDB[10086] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60598, },{ID = 12122, },},
	}
ScriptFightDB[10087] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60599, },{ID = 12123, },},
	}
ScriptFightDB[10088] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60600, },{ID = 12124, },},
	}
ScriptFightDB[10089] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60601, },{ID = 12121, },},
	}
ScriptFightDB[10090] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60602, },{ID = 12122, },},
	}
ScriptFightDB[10091] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60603, },{ID = 12123, },},
	}
-----第14层
ScriptFightDB[10092] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60605, },{ID = 12131, },},
	}
ScriptFightDB[10093] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60606, },{ID = 12132, },},
	}
ScriptFightDB[10094] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60607, },{ID = 12133, },},
	}
ScriptFightDB[10095] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60608, },{ID = 12134, },},
	}
ScriptFightDB[10096] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60609, },{ID = 12131, },},
	}
ScriptFightDB[10097] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60610, },{ID = 12132, },},
	}
ScriptFightDB[10098] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60611, },{ID = 12133, },},
	}
-----第15层
ScriptFightDB[10099] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60613, },{ID = 12141, },},
	}
ScriptFightDB[10100] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60614, },{ID = 12142, },},
	}
ScriptFightDB[10101] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60615, },{ID = 12143, },},
	}
ScriptFightDB[10102] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60616, },{ID = 12144, },},
	}
ScriptFightDB[10103] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60617, },{ID = 12141, },},
	}
ScriptFightDB[10104] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60618, },{ID = 12142, },},
	}
ScriptFightDB[10105] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60619, },{ID = 12143, },},
	}
-----第16层
ScriptFightDB[10106] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60621, },{ID = 12151, },},
	}
ScriptFightDB[10107] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60622, },{ID = 12152, },},
	}
ScriptFightDB[10108] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60623, },{ID = 12153, },},
	}
ScriptFightDB[10109] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60624, },{ID = 12154, },},
	}
ScriptFightDB[10110] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60625, },{ID = 12151, },},
	}
ScriptFightDB[10111] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60626, },{ID = 12152, },},
	}
ScriptFightDB[10112] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60627, },{ID = 12153, },},
	}
-----第17层
ScriptFightDB[10113] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60629, },{ID = 12161, },},
	}
ScriptFightDB[10114] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60630, },{ID = 12162, },},
	}
ScriptFightDB[10115] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60631, },{ID = 12163, },},
	}
ScriptFightDB[10116] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60632, },{ID = 12164, },},
	}
ScriptFightDB[10117] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60633, },{ID = 12161, },},
	}
ScriptFightDB[10118] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60634, },{ID = 12162, },},
	}
ScriptFightDB[10119] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60635, },{ID = 12163, },},
	}
-----第18层
ScriptFightDB[10120] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60637, },{ID = 12171, },},
	}
ScriptFightDB[10121] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60638, },{ID = 12172, },},
	}
ScriptFightDB[10122] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60639, },{ID = 12173, },},
	}
ScriptFightDB[10123] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60640, },{ID = 12174, },},
	}
ScriptFightDB[10124] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60641, },{ID = 12171, },},
	}
ScriptFightDB[10125] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60642, },{ID = 12172, },},
	}
ScriptFightDB[10126] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60643, },{ID = 12173, },},
	}
-----第19层
ScriptFightDB[10127] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60645, },{ID = 12181, },},
	}
ScriptFightDB[10128] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60646, },{ID = 1218, },},
	}
ScriptFightDB[10129] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60647, },{ID = 12183, },},
	}
ScriptFightDB[10130] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60648, },{ID = 12184, },},
	}
ScriptFightDB[10131] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60649, },{ID = 12181, },},
	}
ScriptFightDB[10132] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60650, },{ID = 12182, },},
	}
ScriptFightDB[10133] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60651, },{ID = 12183, },},
	}
-----第20层
ScriptFightDB[10134] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60653, },{ID = 12191, },},
	}
ScriptFightDB[10135] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60654, },{ID = 12192, },},
	}
ScriptFightDB[10136] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60655, },{ID = 12193, },},
	}
ScriptFightDB[10137] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60656, },{ID = 12194, },},
	}
ScriptFightDB[10138] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60657, },{ID = 12191, },},
	}
ScriptFightDB[10139] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60658, },{ID = 12192, },},
	}
ScriptFightDB[10140] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60659, },{ID = 12193, },},
	}
-----第21层
ScriptFightDB[10141] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60661, },{ID = 12201, },},
	}
ScriptFightDB[10142] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60662, },{ID = 12202, },},
	}
ScriptFightDB[10143] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60663, },{ID = 12203, },},
	}
ScriptFightDB[10144] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60664, },{ID = 12204, },},
	}
ScriptFightDB[10145] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60665, },{ID = 12201, },},
	}
ScriptFightDB[10146] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60666, },{ID = 12202, },},
	}
ScriptFightDB[10147] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60667, },{ID = 12203, },},
	}
-----第22层
ScriptFightDB[10148] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60669, },{ID = 12211, },},
	}
ScriptFightDB[10149] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60670, },{ID = 12212, },},
	}
ScriptFightDB[10150] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60671, },{ID = 12213, },},
	}
ScriptFightDB[10151] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60672, },{ID = 12214, },},
	}
ScriptFightDB[10152] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60673, },{ID = 12211, },},
	}
ScriptFightDB[10153] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60674, },{ID = 12212, },},
	}
ScriptFightDB[10154] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60675, },{ID = 12213, },},
	}
-----第23层
ScriptFightDB[10155] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60677, },{ID = 12221, },},
	}
ScriptFightDB[10156] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60678, },{ID = 12222, },},
	}
ScriptFightDB[10157] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60679, },{ID = 12223, },},
	}
ScriptFightDB[10158] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60680, },{ID = 12224, },},
	}
ScriptFightDB[10159] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60681, },{ID = 12221, },},
	}
ScriptFightDB[10160] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60682, },{ID = 12222, },},
	}
ScriptFightDB[10161] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60683, },{ID = 12223, },},
	}
-----第24层
ScriptFightDB[10162] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60685, },{ID = 12231, },},
	}
ScriptFightDB[10163] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60686, },{ID = 12232, },},
	}
ScriptFightDB[10164] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60687, },{ID = 12233, },},
	}
ScriptFightDB[10165] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60688, },{ID = 12234, },},
	}
ScriptFightDB[10166] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60689, },{ID = 12231, },},
	}
ScriptFightDB[10167] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60690, },{ID = 12232, },},
	}
ScriptFightDB[10168] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60691, },{ID = 12233, },},
	}
-----第25层
ScriptFightDB[10169] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60693, },{ID = 12241, },},
	}
ScriptFightDB[10170] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60694, },{ID = 12242, },},
	}
ScriptFightDB[10171] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60695, },{ID = 12243, },},
	}
ScriptFightDB[10172] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60696, },{ID = 12244, },},
	}
ScriptFightDB[10173] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60697, },{ID = 12241, },},
	}
ScriptFightDB[10174] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60698, },{ID = 12242, },},
	}
ScriptFightDB[10175] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60699, },{ID = 12243, },},
	}
-----第26层
ScriptFightDB[10176] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60701, },{ID = 12251, },},
	}
ScriptFightDB[10177] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60702, },{ID = 12252, },},
	}
ScriptFightDB[10178] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60703, },{ID = 12253, },},
	}
ScriptFightDB[10179] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60704, },{ID = 12254, },},
	}
ScriptFightDB[10180] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60705, },{ID = 12251, },},
	}
ScriptFightDB[10181] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60706, },{ID = 12252, },},
	}
ScriptFightDB[10182] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60707, },{ID = 12253, },},
	}
-----第27层
ScriptFightDB[10183] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60709, },{ID = 12261, },},
	}
ScriptFightDB[10184] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60710, },{ID = 12262, },},
	}
ScriptFightDB[10185] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60711, },{ID = 12263, },},
	}
ScriptFightDB[10186] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60712, },{ID = 12264, },},
	}
ScriptFightDB[10187] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60713, },{ID = 12261, },},
	}
ScriptFightDB[10188] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60714, },{ID = 12262, },},
	}
ScriptFightDB[10189] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60715, },{ID = 12263, },},
	}
-----第28层
ScriptFightDB[10190] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60717, },{ID = 12271, },},
	}
ScriptFightDB[10191] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60718, },{ID = 12272, },},
	}
ScriptFightDB[10192] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60719, },{ID = 12273, },},
	}
ScriptFightDB[10193] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60720, },{ID = 12274, },},
	}
ScriptFightDB[10194] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60721, },{ID = 12271, },},
	}
ScriptFightDB[10195] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60722, },{ID = 12272, },},
	}
ScriptFightDB[10196] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60723, },{ID = 12273, },},
	}
-----第29层
ScriptFightDB[10197] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60725, },{ID = 12281, },},
	}
ScriptFightDB[10198] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60726, },{ID = 12282, },},
	}
ScriptFightDB[10199] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60727, },{ID = 12283, },},
	}
ScriptFightDB[10200] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60728, },{ID = 12284, },},
	}
ScriptFightDB[10201] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60729, },{ID = 12281, },},
	}
ScriptFightDB[10202] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60730, },{ID = 12282, },},
	}
ScriptFightDB[10203] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60731, },{ID = 12283, },},
	}
-----第30层
ScriptFightDB[10204] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60733, },{ID = 12291, },},
	}
ScriptFightDB[10205] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60734, },{ID = 12292, },},
	}
ScriptFightDB[10206] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60735, },{ID = 12293, },},
	}
ScriptFightDB[10207] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60736, },{ID = 12294, },},
	}
ScriptFightDB[10208] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60737, },{ID = 12291, },},
	}
ScriptFightDB[10209] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60738, },{ID = 12292, },},
	}
ScriptFightDB[10210] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60739, },{ID = 12293, },},
	}
-----第31层
ScriptFightDB[10211] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60741, },{ID = 12301, },},
	}
ScriptFightDB[10212] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60742, },{ID = 12302, },},
	}
ScriptFightDB[10213] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60743, },{ID = 12303, },},
	}
ScriptFightDB[10214] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60744, },{ID = 12304, },},
	}
ScriptFightDB[10215] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60745, },{ID = 12301, },},
	}
ScriptFightDB[10216] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60746, },{ID = 12302, },},
	}
ScriptFightDB[10217] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60747, },{ID = 12303, },},
	}
-----第32层
ScriptFightDB[10218] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60749, },{ID = 12311, },},
	}
ScriptFightDB[10219] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60750, },{ID = 12312, },},
	}
ScriptFightDB[10220] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60751, },{ID = 12313, },},
	}
ScriptFightDB[10221] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60752, },{ID = 12314, },},
	}
ScriptFightDB[10222] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60753, },{ID = 12311, },},
	}
ScriptFightDB[10223] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60754, },{ID = 12312, },},
	}
ScriptFightDB[10224] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60755, },{ID = 12313, },},
	}
-----第33层
ScriptFightDB[10225] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60757, },{ID = 12321, },},
	}
ScriptFightDB[10226] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60758, },{ID = 12322, },},
	}
ScriptFightDB[10227] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60759, },{ID = 12323, },},
	}
ScriptFightDB[10228] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60760, },{ID = 12324, },},
	}
ScriptFightDB[10229] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60761, },{ID = 12321, },},
	}
ScriptFightDB[10230] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60762, },{ID = 12322, },},
	}
ScriptFightDB[10231] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60763, },{ID = 12323, },},
	}
-----第34层
ScriptFightDB[10232] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60765, },{ID = 12331, },},
	}
ScriptFightDB[10233] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60766, },{ID = 12332, },},
	}
ScriptFightDB[10234] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60767, },{ID = 12333, },},
	}
ScriptFightDB[10235] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60768, },{ID = 12334, },},
	}
ScriptFightDB[10236] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60769, },{ID = 12331, },},
	}
ScriptFightDB[10237] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60770, },{ID = 12332, },},
	}
ScriptFightDB[10238] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60771, },{ID = 12333, },},
	}
-----第35层
ScriptFightDB[10239] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60773, },{ID = 12341, },},
	}
ScriptFightDB[10240] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60774, },{ID = 12342, },},
	}
ScriptFightDB[10241] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60775, },{ID = 12343, },},
	}
ScriptFightDB[10242] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60776, },{ID = 12344, },},
	}
ScriptFightDB[10243] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60777, },{ID = 12341, },},
	}
ScriptFightDB[10244] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60778, },{ID = 12342, },},
	}
ScriptFightDB[10245] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60779, },{ID = 12343, },},
	}
-----第36层
ScriptFightDB[10246] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60781, },{ID = 12351, },},
	}
ScriptFightDB[10247] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60782, },{ID = 12352, },},
	}
ScriptFightDB[10248] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60783, },{ID = 12353, },},
	}
ScriptFightDB[10249] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60784, },{ID = 12354, },},
	}
ScriptFightDB[10250] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60785, },{ID = 12351, },},
	}
ScriptFightDB[10251] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60786, },{ID = 12352, },},
	}
ScriptFightDB[10252] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60787, },{ID = 12353, },},
	}
-----第37层
ScriptFightDB[10253] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60789, },{ID = 12361, },},
	}
ScriptFightDB[10254] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60790, },{ID = 12362, },},
	}
ScriptFightDB[10255] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60791, },{ID = 12363, },},
	}
ScriptFightDB[10256] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60792, },{ID = 12364, },},
	}
ScriptFightDB[10257] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60793, },{ID = 12361, },},
	}
ScriptFightDB[10258] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60794, },{ID = 12362, },},
	}
ScriptFightDB[10259] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60795, },{ID = 12363, },},
	}
-----第38层
ScriptFightDB[10260] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60797, },{ID = 12371, },},
	}
ScriptFightDB[10261] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60798, },{ID = 12372, },},
	}
ScriptFightDB[10262] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60799, },{ID = 12373, },},
	}
ScriptFightDB[10263] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60800, },{ID = 12374, },},
	}
ScriptFightDB[10264] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60801, },{ID = 12371, },},
	}
ScriptFightDB[10265] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60802, },{ID = 12372, },},
	}
ScriptFightDB[10266] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60803, },{ID = 12373, },},
	}
-----第39层
ScriptFightDB[10267] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60805, },{ID = 12381, },},
	}
ScriptFightDB[10268] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60806, },{ID = 12382, },},
	}
ScriptFightDB[10269] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60807, },{ID = 12383, },},
	}
ScriptFightDB[10270] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60808, },{ID = 12384, },},
	}
ScriptFightDB[10271] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60809, },{ID = 12381, },},
	}
ScriptFightDB[10272] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60810, },{ID = 12382, },},
	}
ScriptFightDB[10273] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60811, },{ID = 12383, },},
	}
-----第40层
ScriptFightDB[10274] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60813, },{ID = 12391, },},
	}
ScriptFightDB[10275] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60814, },{ID = 12392, },},
	}
ScriptFightDB[10276] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60815, },{ID = 12393, },},
	}
ScriptFightDB[10277] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60816, },{ID = 12394, },},
	}
ScriptFightDB[10278] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60817, },{ID = 12391, },},
	}
ScriptFightDB[10279] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60818, },{ID = 12392, },},
	}
ScriptFightDB[10280] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60819, },{ID = 12393, },},
	}
-----第41层
ScriptFightDB[10281] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60821, },{ID = 12401, },},
	}
ScriptFightDB[10282] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60822, },{ID = 12402, },},
	}
ScriptFightDB[10283] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60823, },{ID = 12403, },},
	}
ScriptFightDB[10284] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60824, },{ID = 12404, },},
	}
ScriptFightDB[10285] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60825, },{ID = 12401, },},
	}
ScriptFightDB[10286] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60826, },{ID = 12402, },},
	}
ScriptFightDB[10287] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60827, },{ID = 12403, },},
	}
-----第42层
ScriptFightDB[10288] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60829, },{ID = 12411, },},
	}
ScriptFightDB[10289] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60830, },{ID = 12412, },},
	}
ScriptFightDB[10290] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60831, },{ID = 12413, },},
	}
ScriptFightDB[10291] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60832, },{ID = 12414, },},
	}
ScriptFightDB[10292] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60833, },{ID = 12411, },},
	}
ScriptFightDB[10293] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60834, },{ID = 12412, },},
	}
ScriptFightDB[10294] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60835, },{ID = 12413, },},
	}
-----第43层
ScriptFightDB[10295] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60837, },{ID = 12421, },},
	}
ScriptFightDB[10296] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60838, },{ID = 12422, },},
	}
ScriptFightDB[10297] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60839, },{ID = 12423, },},
	}
ScriptFightDB[10298] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60840, },{ID = 12424, },},
	}
ScriptFightDB[10299] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60841, },{ID = 12421, },},
	}
ScriptFightDB[10300] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60842, },{ID = 12422, },},
	}
ScriptFightDB[10301] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60843, },{ID = 12423, },},
	}
-----第44层
ScriptFightDB[10302] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60845, },{ID = 12431, },},
	}
ScriptFightDB[10303] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60846, },{ID = 12432, },},
	}
ScriptFightDB[10304] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60847, },{ID = 12433, },},
	}
ScriptFightDB[10305] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60848, },{ID = 12434, },},
	}
ScriptFightDB[10306] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60849, },{ID = 12431, },},
	}
ScriptFightDB[10307] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60850, },{ID = 12432, },},
	}
ScriptFightDB[10308] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60851, },{ID = 12433, },},
	}
-----第45层
ScriptFightDB[10309] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60853, },{ID = 12441, },},
	}
ScriptFightDB[10310] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60854, },{ID = 12442, },},
	}
ScriptFightDB[10311] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60855, },{ID = 12443, },},
	}
ScriptFightDB[10312] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60856, },{ID = 12444, },},
	}
ScriptFightDB[10313] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60857, },{ID = 12441, },},
	}
ScriptFightDB[10314] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60858, },{ID = 12442, },},
	}
ScriptFightDB[10315] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60859, },{ID = 12443, },},
	}
-----第46层
ScriptFightDB[10316] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60861, },{ID = 12451, },},
	}
ScriptFightDB[10317] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60862, },{ID = 12452, },},
	}
ScriptFightDB[10318] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60863, },{ID = 12453, },},
	}
ScriptFightDB[10319] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60864, },{ID = 12454, },},
	}
ScriptFightDB[10320] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60865, },{ID = 12451, },},
	}
ScriptFightDB[10321] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60866, },{ID = 12452, },},
	}
ScriptFightDB[10322] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60867, },{ID = 12453, },},
	}
-----第47层
ScriptFightDB[10323] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60869, },{ID = 12461, },},
	}
ScriptFightDB[10324] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60870, },{ID = 12462, },},
	}
ScriptFightDB[10325] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60871, },{ID = 12463, },},
	}
ScriptFightDB[10326] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60872, },{ID = 12464, },},
	}
ScriptFightDB[10327] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60873, },{ID = 12461, },},
	}
ScriptFightDB[10328] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60874, },{ID = 12462, },},
	}
ScriptFightDB[10329] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60875, },{ID = 12463, },},
	}
-----第48层
ScriptFightDB[10330] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60877, },{ID = 12471, },},
	}
ScriptFightDB[10331] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60878, },{ID = 12472, },},
	}
ScriptFightDB[10332] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60879, },{ID = 12473, },},
	}
ScriptFightDB[10333] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60880, },{ID = 12474, },},
	}
ScriptFightDB[10334] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60881, },{ID = 12471, },},
	}
ScriptFightDB[10335] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60882, },{ID = 12472, },},
	}
ScriptFightDB[10336] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60883, },{ID = 12473, },},
	}
-----第49层
ScriptFightDB[10337] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60885, },{ID = 12481, },},
	}
ScriptFightDB[10338] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60886, },{ID = 12482, },},
	}
ScriptFightDB[10339] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60887, },{ID = 12483, },},
	}
ScriptFightDB[10340] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60888, },{ID = 12484, },},
	}
ScriptFightDB[10341] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60889, },{ID = 12481, },},
	}
ScriptFightDB[10342] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60890, },{ID = 12482, },},
	}
ScriptFightDB[10343] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60891, },{ID = 12483, },},
	}
-----第50层
ScriptFightDB[10344] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60893, },{ID = 12491, },},
	}
ScriptFightDB[10345] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60894, },{ID = 12492, },},
	}
ScriptFightDB[10346] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60895, },{ID = 12493, },},
	}
ScriptFightDB[10347] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60896, },{ID = 12494, },},
	}
ScriptFightDB[10348] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60897, },{ID = 12491, },},
	}
ScriptFightDB[10349] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60898, },{ID = 12492, },},
	}
ScriptFightDB[10350] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60899, },{ID = 12493, },},
	}
-----第51层
ScriptFightDB[10351] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60901, },{ID = 12501, },},
	}
ScriptFightDB[10352] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60902, },{ID = 12502, },},
	}
ScriptFightDB[10353] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60903, },{ID = 12503, },},
	}
ScriptFightDB[10354] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60904, },{ID = 12504, },},
	}
ScriptFightDB[10355] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60905, },{ID = 12501, },},
	}
ScriptFightDB[10356] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60906, },{ID = 12502, },},
	}
ScriptFightDB[10357] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60907, },{ID = 12503, },},
	}
-----第52层
ScriptFightDB[10358] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60909, },{ID = 12511, },},
	}
ScriptFightDB[10359] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60910, },{ID = 12512, },},
	}
ScriptFightDB[10360] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60911, },{ID = 12513, },},
	}
ScriptFightDB[10361] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60912, },{ID = 12514, },},
	}
ScriptFightDB[10362] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60913, },{ID = 12511, },},
	}
ScriptFightDB[10363] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60914, },{ID = 12512, },},
	}
ScriptFightDB[10364] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60915, },{ID = 12513, },},
	}
-----第53层
ScriptFightDB[10365] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60917, },{ID = 12521, },},
	}
ScriptFightDB[10366] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60918, },{ID = 12522, },},
	}
ScriptFightDB[10367] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60919, },{ID = 12523, },},
	}
ScriptFightDB[10368] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60920, },{ID = 12524, },},
	}
ScriptFightDB[10369] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60921, },{ID = 12521, },},
	}
ScriptFightDB[10370] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60922, },{ID = 12522, },},
	}
ScriptFightDB[10371] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60923, },{ID = 12523, },},
	}
-----第54层
ScriptFightDB[10372] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60925, },{ID = 12531, },},
	}
ScriptFightDB[10373] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60926, },{ID = 12532, },},
	}
ScriptFightDB[10374] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60927, },{ID = 12533, },},
	}
ScriptFightDB[10375] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60928, },{ID = 12534, },},
	}
ScriptFightDB[10376] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60929, },{ID = 12531, },},
	}
ScriptFightDB[10377] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60930, },{ID = 12532, },},
	}
ScriptFightDB[10378] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60931, },{ID = 12533, },},
	}
-----第55层
ScriptFightDB[10379] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60933, },{ID = 12541, },},
	}
ScriptFightDB[10380] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60934, },{ID = 12542, },},
	}
ScriptFightDB[10381] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60935, },{ID = 12543, },},
	}
ScriptFightDB[10382] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60936, },{ID = 12544, },},
	}
ScriptFightDB[10383] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60937, },{ID = 12541, },},
	}
ScriptFightDB[10384] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60938, },{ID = 12542, },},
	}
ScriptFightDB[10385] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60939, },{ID = 12543, },},
	}
-----第56层
ScriptFightDB[10386] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60941, },{ID = 12551, },},
	}
ScriptFightDB[10387] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60942, },{ID = 12552, },},
	}
ScriptFightDB[10388] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60943, },{ID = 12553, },},
	}
ScriptFightDB[10389] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60944, },{ID = 12554, },},
	}
ScriptFightDB[10390] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60945, },{ID = 12551, },},
	}
ScriptFightDB[10391] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60946, },{ID = 12552, },},
	}
ScriptFightDB[10392] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60947, },{ID = 12553, },},
	}
-----第57层
ScriptFightDB[10393] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60949, },{ID = 12561, },},
	}
ScriptFightDB[10394] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60950, },{ID = 12562, },},
	}
ScriptFightDB[10395] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60951, },{ID = 12563, },},
	}
ScriptFightDB[10396] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60952, },{ID = 12564, },},
	}
ScriptFightDB[10397] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60953, },{ID = 12561, },},
	}
ScriptFightDB[10398] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60954, },{ID = 12562, },},
	}
ScriptFightDB[10399] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60955, },{ID = 12563, },},
	}
-----第58层
ScriptFightDB[10400] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60957, },{ID = 12571, },},
	}
ScriptFightDB[10401] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60958, },{ID = 12572, },},
	}
ScriptFightDB[10402] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60959, },{ID = 12573, },},
	}
ScriptFightDB[10403] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60960, },{ID = 12574, },},
	}
ScriptFightDB[10404] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60961, },{ID = 12571, },},
	}
ScriptFightDB[10405] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60962, },{ID = 12572, },},
	}
ScriptFightDB[10406] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60963, },{ID = 12573, },},
	}
-----第59层
ScriptFightDB[10407] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60965, },{ID = 12581, },},
	}
ScriptFightDB[10408] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60966, },{ID = 12582, },},
	}
ScriptFightDB[10409] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60967, },{ID = 12583, },},
	}
ScriptFightDB[10410] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60968, },{ID = 12584, },},
	}
ScriptFightDB[10411] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60969, },{ID = 12581, },},
	}
ScriptFightDB[10412] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60970, },{ID = 12582, },},
	}
ScriptFightDB[10413] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60971, },{ID = 12583, },},
	}
-----第60层
ScriptFightDB[10414] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60973, },{ID = 12591, },},
	}
ScriptFightDB[10415] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60974, },{ID = 12592, },},
	}
ScriptFightDB[10416] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60975, },{ID = 12593, },},
	}
ScriptFightDB[10417] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60976, },{ID = 12594, },},
	}
ScriptFightDB[10418] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60977, },{ID = 12591, },},
	}
ScriptFightDB[10419] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60978, },{ID = 12592, },},
	}
ScriptFightDB[10420] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60979, },{ID = 12593, },},
	}
-----第61层
ScriptFightDB[10421] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60981, },{ID = 12601, },},
	}
ScriptFightDB[10422] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60982, },{ID = 12602, },},
	}
ScriptFightDB[10423] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60983, },{ID = 12603, },},
	}
ScriptFightDB[10424] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60984, },{ID = 12604, },},
	}
ScriptFightDB[10425] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60985, },{ID = 12601, },},
	}
ScriptFightDB[10426] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60986, },{ID = 12602, },},
	}
ScriptFightDB[10427] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60987, },{ID = 12603, },},
	}
-----第62层
ScriptFightDB[10428] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60989, },{ID = 12611, },},
	}
ScriptFightDB[10429] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60990, },{ID = 12612, },},
	}
ScriptFightDB[10430] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60991, },{ID = 12613, },},
	}
ScriptFightDB[10431] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60992, },{ID = 12614, },},
	}
ScriptFightDB[10432] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60993, },{ID = 12611, },},
	}
ScriptFightDB[10433] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60994, },{ID = 12612, },},
	}
ScriptFightDB[10434] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60995, },{ID = 12613, },},
	}
-----第63层
ScriptFightDB[10435] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60997, },{ID = 12621, },},
	}
ScriptFightDB[10436] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60998, },{ID = 12622, },},
	}
ScriptFightDB[10437] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 60999, },{ID = 12623, },},
	}
ScriptFightDB[10438] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61000, },{ID = 12624, },},
	}
ScriptFightDB[10439] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61001, },{ID = 12621, },},
	}
ScriptFightDB[10440] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61002, },{ID = 12622, },},
	}
ScriptFightDB[10441] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61003, },{ID = 12623, },},
	}
-----第64层
ScriptFightDB[10442] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61005, },{ID = 12631, },},
	}
ScriptFightDB[10443] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61006, },{ID = 12632, },},
	}
ScriptFightDB[10444] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61007, },{ID = 12633, },},
	}
ScriptFightDB[10445] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61008, },{ID = 12634, },},
	}
ScriptFightDB[10446] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61009, },{ID = 12631, },},
	}
ScriptFightDB[10447] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61010, },{ID = 12632, },},
	}
ScriptFightDB[10448] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61011, },{ID = 12633, },},
	}
-----第65层
ScriptFightDB[10449] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61013, },{ID = 12641, },},
	}
ScriptFightDB[10450] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61014, },{ID = 12642, },},
	}
ScriptFightDB[10451] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61015, },{ID = 12643, },},
	}
ScriptFightDB[10452] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61016, },{ID = 12644, },},
	}
ScriptFightDB[10453] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61017, },{ID = 12641, },},
	}
ScriptFightDB[10454] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61018, },{ID = 12642, },},
	}
ScriptFightDB[10455] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61019, },{ID = 12643, },},
	}
-----第66层
ScriptFightDB[10456] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61021, },{ID = 12651, },},
	}
ScriptFightDB[10457] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61022, },{ID = 12652, },},
	}
ScriptFightDB[10458] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61023, },{ID = 12653, },},
	}
ScriptFightDB[10459] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61024, },{ID = 12654, },},
	}
ScriptFightDB[10460] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61025, },{ID = 12651, },},
	}
ScriptFightDB[10461] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61026, },{ID = 12652, },},
	}
ScriptFightDB[10462] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61027, },{ID = 12653, },},
	}
-----第67层
ScriptFightDB[10463] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61029, },{ID = 12661, },},
	}
ScriptFightDB[10464] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61030, },{ID = 12662, },},
	}
ScriptFightDB[10465] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61031, },{ID = 12663, },},
	}
ScriptFightDB[10466] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61032, },{ID = 12664, },},
	}
ScriptFightDB[10467] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61033, },{ID = 12661, },},
	}
ScriptFightDB[10468] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61034, },{ID = 12662, },},
	}
ScriptFightDB[10469] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61035, },{ID = 12663, },},
	}
-----第68层
ScriptFightDB[10470] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61037, },{ID = 12671, },},
	}
ScriptFightDB[10471] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61038, },{ID = 12672, },},
	}
ScriptFightDB[10472] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61039, },{ID = 12673, },},
	}
ScriptFightDB[10473] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61040, },{ID = 12674, },},
	}
ScriptFightDB[10474] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61041, },{ID = 12671, },},
	}
ScriptFightDB[10475] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61042, },{ID = 12672, },},
	}
ScriptFightDB[10476] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61043, },{ID = 12673, },},
	}
-----第69层
ScriptFightDB[10477] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61045, },{ID = 12681, },},
	}
ScriptFightDB[10478] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61046, },{ID = 12682, },},
	}
ScriptFightDB[10479] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61047, },{ID = 12683, },},
	}
ScriptFightDB[10480] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61048, },{ID = 12684, },},
	}
ScriptFightDB[10481] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61049, },{ID = 12681, },},
	}
ScriptFightDB[10482] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61050, },{ID = 12682, },},
	}
ScriptFightDB[10483] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61051, },{ID = 12683, },},
	}
-----第70层
ScriptFightDB[10484] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61053, },{ID = 12691, },},
	}
ScriptFightDB[10485] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61054, },{ID = 12692, },},
	}
ScriptFightDB[10486] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61055, },{ID = 12693, },},
	}
ScriptFightDB[10487] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61056, },{ID = 12694, },},
	}
ScriptFightDB[10488] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61057, },{ID = 12691, },},
	}
ScriptFightDB[10489] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61058, },{ID = 12692, },},
	}
ScriptFightDB[10490] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61059, },{ID = 12693, },},
	}
-----第71层
ScriptFightDB[10491] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61061, },{ID = 12701, },},
	}
ScriptFightDB[10492] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61062, },{ID = 12702, },},
	}
ScriptFightDB[10493] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61063, },{ID = 12703, },},
	}
ScriptFightDB[10494] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61064, },{ID = 12704, },},
	}
ScriptFightDB[10495] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61065, },{ID = 12701, },},
	}
ScriptFightDB[10496] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61066, },{ID = 12702, },},
	}
ScriptFightDB[10497] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61067, },{ID = 12703, },},
	}
-----第72层
ScriptFightDB[10498] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61069, },{ID = 12711, },},
	}
ScriptFightDB[10499] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61070, },{ID = 12712, },},
	}
ScriptFightDB[10500] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61071, },{ID = 12713, },},
	}
ScriptFightDB[10501] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61072, },{ID = 12714, },},
	}
ScriptFightDB[10502] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61073, },{ID = 12711, },},
	}
ScriptFightDB[10503] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61074, },{ID = 12712, },},
	}
ScriptFightDB[10504] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61075, },{ID = 12713, },},
	}
-----第73层
ScriptFightDB[10505] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61077, },{ID = 12721, },},
	}
ScriptFightDB[10506] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61078, },{ID = 12722, },},
	}
ScriptFightDB[10507] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61079, },{ID = 12723, },},
	}
ScriptFightDB[10508] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61080, },{ID = 12724, },},
	}
ScriptFightDB[10509] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61081, },{ID = 12721, },},
	}
ScriptFightDB[10510] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61082, },{ID = 12722, },},
	}
ScriptFightDB[10511] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61083, },{ID = 12723, },},
	}
-----第74层
ScriptFightDB[10512] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61085, },{ID = 12731, },},
	}
ScriptFightDB[10513] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61086, },{ID = 12732, },},
	}
ScriptFightDB[10514] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61087, },{ID = 12733, },},
	}
ScriptFightDB[10515] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61088, },{ID = 12734, },},
	}
ScriptFightDB[10516] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61089, },{ID = 12731, },},
	}
ScriptFightDB[10517] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61090, },{ID = 12732, },},
	}
ScriptFightDB[10518] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61091, },{ID = 12733, },},
	}
-----第75层
ScriptFightDB[10519] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61093, },{ID = 12741, },},
	}
ScriptFightDB[10520] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61094, },{ID = 12742, },},
	}
ScriptFightDB[10521] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61095, },{ID = 12743, },},
	}
ScriptFightDB[10522] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61096, },{ID = 12744, },},
	}
ScriptFightDB[10523] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61097, },{ID = 12741, },},
	}
ScriptFightDB[10524] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61098, },{ID = 12742, },},
	}
ScriptFightDB[10525] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61099, },{ID = 12743, },},
	}
-----第76层
ScriptFightDB[10526] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61101, },{ID = 12751, },},
	}
ScriptFightDB[10527] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61102, },{ID = 12752, },},
	}
ScriptFightDB[10528] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61103, },{ID = 12753, },},
	}
ScriptFightDB[10529] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61104, },{ID = 12754, },},
	}
ScriptFightDB[10530] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61105, },{ID = 12751, },},
	}
ScriptFightDB[10531] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61106, },{ID = 12752, },},
	}
ScriptFightDB[10532] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61107, },{ID = 12003, },},
	}
-----第77层
ScriptFightDB[10533] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61109, },{ID = 12761, },},
	}
ScriptFightDB[10534] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61110, },{ID = 12762, },},
	}
ScriptFightDB[10535] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61111, },{ID = 12763, },},
	}
ScriptFightDB[10536] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61112, },{ID = 12764, },},
	}
ScriptFightDB[10537] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61113, },{ID = 12761, },},
	}
ScriptFightDB[10538] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61114, },{ID = 12762, },},
	}
ScriptFightDB[10539] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61115, },{ID = 12763, },},
	}
-----第78层
ScriptFightDB[10540] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61117, },{ID = 12771, },},
	}
ScriptFightDB[10541] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61118, },{ID = 12772, },},
	}
ScriptFightDB[10542] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61119, },{ID = 12773, },},
	}
ScriptFightDB[10543] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61120, },{ID = 12774, },},
	}
ScriptFightDB[10544] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61121, },{ID = 12771, },},
	}
ScriptFightDB[10545] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61122, },{ID = 12772, },},
	}
ScriptFightDB[10546] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61123, },{ID = 12773, },},
	}
-----第79层
ScriptFightDB[10547] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61125, },{ID = 12781, },},
	}
ScriptFightDB[10548] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61126, },{ID = 12782, },},
	}
ScriptFightDB[10549] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61127, },{ID = 12783, },},
	}
ScriptFightDB[10550] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61128, },{ID = 12784, },},
	}
ScriptFightDB[10551] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61129, },{ID = 12781, },},
	}
ScriptFightDB[10552] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61130, },{ID = 12782, },},
	}
ScriptFightDB[10553] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61131, },{ID = 12783, },},
	}
-----第80层
ScriptFightDB[10554] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61133, },{ID = 12791, },},
	}
ScriptFightDB[10555] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61134, },{ID = 12792, },},
	}
ScriptFightDB[10556] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61135, },{ID = 12793, },},
	}
ScriptFightDB[10557] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61136, },{ID = 12794, },},
	}
ScriptFightDB[10558] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61137, },{ID = 12791, },},
	}
ScriptFightDB[10559] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61138, },{ID = 12792, },},
	}
ScriptFightDB[10560] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61139, },{ID = 12793, },},
	}
-----第81层
ScriptFightDB[10561] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61141, },{ID = 12801, },},
	}
ScriptFightDB[10562] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61142, },{ID = 12802, },},
	}
ScriptFightDB[10563] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61143, },{ID = 12803, },},
	}
ScriptFightDB[10564] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61144, },{ID = 12804, },},
	}
ScriptFightDB[10565] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61145, },{ID = 12801, },},
	}
ScriptFightDB[10566] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61146, },{ID = 12802, },},
	}
ScriptFightDB[10567] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61147, },{ID = 12803, },},
	}
-----第82层
ScriptFightDB[10568] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61149, },{ID = 12811, },},
	}
ScriptFightDB[10569] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61150, },{ID = 12812, },},
	}
ScriptFightDB[10570] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61151, },{ID = 12813, },},
	}
ScriptFightDB[10571] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61152, },{ID = 12814, },},
	}
ScriptFightDB[10572] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61153, },{ID = 12811, },},
	}
ScriptFightDB[10573] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61154, },{ID = 12812, },},
	}
ScriptFightDB[10574] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61155, },{ID = 12813, },},
	}
-----第83层
ScriptFightDB[10575] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61157, },{ID = 12821, },},
	}
ScriptFightDB[10576] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61158, },{ID = 12822, },},
	}
ScriptFightDB[10577] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61159, },{ID = 12823, },},
	}
ScriptFightDB[10578] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61160, },{ID = 12824, },},
	}
ScriptFightDB[10579] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61161, },{ID = 12821, },},
	}
ScriptFightDB[10580] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61162, },{ID = 12822, },},
	}
ScriptFightDB[10581] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61163, },{ID = 12823, },},
	}
-----第84层
ScriptFightDB[10582] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61165, },{ID = 12831, },},
	}
ScriptFightDB[10583] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61166, },{ID = 12832, },},
	}
ScriptFightDB[10584] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61167, },{ID = 12833, },},
	}
ScriptFightDB[10585] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61168, },{ID = 12834, },},
	}
ScriptFightDB[10586] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61169, },{ID = 12831, },},
	}
ScriptFightDB[10587] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61170, },{ID = 12832, },},
	}
ScriptFightDB[10588] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61171, },{ID = 12833, },},
	}
-----第85层
ScriptFightDB[10589] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61173, },{ID = 12841, },},
	}
ScriptFightDB[10590] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61174, },{ID = 12842, },},
	}
ScriptFightDB[10591] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61175, },{ID = 12843, },},
	}
ScriptFightDB[10592] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61176, },{ID = 12844, },},
	}
ScriptFightDB[10593] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61177, },{ID = 12841, },},
	}
ScriptFightDB[10594] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61178, },{ID = 12842, },},
	}
ScriptFightDB[10595] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61179, },{ID = 12843, },},
	}
-----第86层
ScriptFightDB[10596] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61181, },{ID = 12851, },},
	}
ScriptFightDB[10597] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61182, },{ID = 12852, },},
	}
ScriptFightDB[10598] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61183, },{ID = 12853, },},
	}
ScriptFightDB[10599] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61184, },{ID = 12854, },},
	}
ScriptFightDB[10600] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61185, },{ID = 12851, },},
	}
ScriptFightDB[10601] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61186, },{ID = 12852, },},
	}
ScriptFightDB[10602] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61187, },{ID = 12853, },},
	}
-----第87层
ScriptFightDB[10603] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61189, },{ID = 12861, },},
	}
ScriptFightDB[10604] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61190, },{ID = 12862, },},
	}
ScriptFightDB[10605] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61191, },{ID = 12863, },},
	}
ScriptFightDB[10606] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61192, },{ID = 12864, },},
	}
ScriptFightDB[10607] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61193, },{ID = 12861, },},
	}
ScriptFightDB[10608] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61194, },{ID = 12862, },},
	}
ScriptFightDB[10609] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61195, },{ID = 12863, },},
	}
-----第88层
ScriptFightDB[10610] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61197, },{ID = 12871, },},
	}
ScriptFightDB[10611] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61198, },{ID = 12872, },},
	}
ScriptFightDB[10612] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61199, },{ID = 12873, },},
	}
ScriptFightDB[10613] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61200, },{ID = 12874, },},
	}
ScriptFightDB[10614] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61201, },{ID = 12871, },},
	}
ScriptFightDB[10615] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61202, },{ID = 12872, },},
	}
ScriptFightDB[10616] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61203, },{ID = 12873, },},
	}
-----第89层
ScriptFightDB[10617] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61205, },{ID = 12881, },},
	}
ScriptFightDB[10618] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61206, },{ID = 12882, },},
	}
ScriptFightDB[10619] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61207, },{ID = 12883, },},
	}
ScriptFightDB[10620] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61208, },{ID = 12884, },},
	}
ScriptFightDB[10621] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61209, },{ID = 12881, },},
	}
ScriptFightDB[10622] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61210, },{ID = 12882, },},
	}
ScriptFightDB[10623] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61211, },{ID = 12883, },},
	}
-----第90层
ScriptFightDB[10624] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61213, },{ID = 12891, },},
	}
ScriptFightDB[10625] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61214, },{ID = 12892, },},
	}
ScriptFightDB[10626] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61215, },{ID = 12893, },},
	}
ScriptFightDB[10627] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61216, },{ID = 12894, },},
	}
ScriptFightDB[10628] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61217, },{ID = 12891, },},
	}
ScriptFightDB[10629] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61219, },{ID = 12892, },},
	}
ScriptFightDB[10630] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61219, },{ID = 12893, },},
	}
-----第91层
ScriptFightDB[10631] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61221, },{ID = 12901, },},
	}
ScriptFightDB[10632] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61222, },{ID = 12902, },},
	}
ScriptFightDB[10633] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61223, },{ID = 12903, },},
	}
ScriptFightDB[10634] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61224, },{ID = 12904, },},
	}
ScriptFightDB[10635] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61225, },{ID = 12901, },},
	}
ScriptFightDB[10636] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61226, },{ID = 12902, },},
	}
ScriptFightDB[10637] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61227, },{ID = 12903, },},
	}
-----第92层
ScriptFightDB[10638] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61229, },{ID = 12911, },},
	}
ScriptFightDB[10639] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61230, },{ID = 12912, },},
	}
ScriptFightDB[10640] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61231, },{ID = 12913, },},
	}
ScriptFightDB[10641] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61232, },{ID = 12914, },},
	}
ScriptFightDB[10642] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61233, },{ID = 12911, },},
	}
ScriptFightDB[10643] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61234, },{ID = 12912, },},
	}
ScriptFightDB[10644] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61235, },{ID = 12913, },},
	}
-----第93层
ScriptFightDB[10645] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61237, },{ID = 12921, },},
	}
ScriptFightDB[10646] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61238, },{ID = 12922, },},
	}
ScriptFightDB[10647] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61239, },{ID = 12923, },},
	}
ScriptFightDB[10648] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61240, },{ID = 12924, },},
	}
ScriptFightDB[10649] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61241, },{ID = 12921, },},
	}
ScriptFightDB[10650] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61242, },{ID = 12922, },},
	}
ScriptFightDB[10651] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61243, },{ID = 12923, },},
	}
-----第94层
ScriptFightDB[10652] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61245, },{ID = 12931, },},
	}
ScriptFightDB[10653] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61246, },{ID = 12932, },},
	}
ScriptFightDB[10654] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61247, },{ID = 12933, },},
	}
ScriptFightDB[10655] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61248, },{ID = 12934, },},
	}
ScriptFightDB[10656] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61249, },{ID = 12931, },},
	}
ScriptFightDB[10657] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61250, },{ID = 12932, },},
	}
ScriptFightDB[10658] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61251, },{ID = 12933, },},
	}
-----第95层
ScriptFightDB[10659] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61253, },{ID = 12941, },},
	}
ScriptFightDB[10660] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61254, },{ID = 12942, },},
	}
ScriptFightDB[10661] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61255, },{ID = 12943, },},
	}
ScriptFightDB[10662] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61256, },{ID = 12944, },},
	}
ScriptFightDB[10663] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61257, },{ID = 12941, },},
	}
ScriptFightDB[10664] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61258, },{ID = 12942, },},
	}
ScriptFightDB[10665] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61259, },{ID = 12943, },},
	}
-----第96层
ScriptFightDB[10666] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61261, },{ID = 12951, },},
	}
ScriptFightDB[10667] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61262, },{ID = 12952, },},
	}
ScriptFightDB[10668] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61263, },{ID = 12953, },},
	}
ScriptFightDB[10669] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61264, },{ID = 12954, },},
	}
ScriptFightDB[10670] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61265, },{ID = 12951, },},
	}
ScriptFightDB[10671] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61266, },{ID = 12952, },},
	}
ScriptFightDB[10672] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61267, },{ID = 12953, },},
	}
-----第97层
ScriptFightDB[10673] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61269, },{ID = 12961, },},
	}
ScriptFightDB[10674] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61270, },{ID = 12962, },},
	}
ScriptFightDB[10675] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61271, },{ID = 12963, },},
	}
ScriptFightDB[10676] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61272, },{ID = 12964, },},
	}
ScriptFightDB[10677] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61273, },{ID = 12961, },},
	}
ScriptFightDB[10678] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61274, },{ID = 12962, },},
	}
ScriptFightDB[10679] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61275, },{ID = 12963, },},
	}
-----第98层
ScriptFightDB[10680] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61277, },{ID = 12971, },},
	}
ScriptFightDB[10681] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61278, },{ID = 12972, },},
	}
ScriptFightDB[10682] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61279, },{ID = 12973, },},
	}
ScriptFightDB[10683] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61280, },{ID = 12974, },},
	}
ScriptFightDB[10684] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61281, },{ID = 12971, },},
	}
ScriptFightDB[10685] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61282, },{ID = 12972, },},
	}
ScriptFightDB[10686] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61283, },{ID = 12973, },},
	}
-----第99层
ScriptFightDB[10687] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61285, },{ID = 12981, },},
	}
ScriptFightDB[10688] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61286, },{ID = 12982, },},
	}
ScriptFightDB[10689] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61287, },{ID = 12983, },},
	}
ScriptFightDB[10690] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61288, },{ID = 12984, },},
	}
ScriptFightDB[10691] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61289, },{ID = 12981, },},
	}
ScriptFightDB[10692] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61290, },{ID = 12982, },},
	}
ScriptFightDB[10693] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61291, },{ID = 12983, },},
	}
-----第100层
ScriptFightDB[10694] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61293, },{ID = 12991, },},
	}
ScriptFightDB[10695] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61294, },{ID = 12992, },},
	}
ScriptFightDB[10696] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61295, },{ID = 12993, },},
	}
ScriptFightDB[10697] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61296, },{ID = 12994, },},
	}
ScriptFightDB[10698] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61297, },{ID = 12991, },},
	}
ScriptFightDB[10699] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61298, },{ID = 12992, },},
	}
ScriptFightDB[10700] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61299, },{ID = 12993, },},
	}

------------------------------------------------------------------------------------------------
-----第101层
ScriptFightDB[10701] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61301, },{ID = 13001, },},
	}
ScriptFightDB[10702] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61302, },{ID = 13002, },},
	}
ScriptFightDB[10703] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61303, },{ID = 13003, },},
	}
ScriptFightDB[10704] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61304, },{ID = 13004, },},
	}
ScriptFightDB[10705] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61305, },{ID = 13001, },},
	}
ScriptFightDB[10706] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61306, },{ID = 13002, },},
	}
ScriptFightDB[10707] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61307, },{ID = 13003, },},
	}
-----第102层
ScriptFightDB[10708] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61309, },{ID = 13011, },},
	}
ScriptFightDB[10709] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61310, },{ID = 13012, },},
	}
ScriptFightDB[10710] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61311, },{ID = 13013, },},
	}
ScriptFightDB[10711] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61312, },{ID = 13014, },},
	}
ScriptFightDB[10712] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61313, },{ID = 13011, },},
	}
ScriptFightDB[10713] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61314, },{ID = 13012, },},
	}
ScriptFightDB[10714] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61315, },{ID = 13013, },},
	}
-----第103层
ScriptFightDB[10715] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61317, },{ID = 13021, },},
	}
ScriptFightDB[10716] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61318, },{ID = 13022, },},
	}
ScriptFightDB[10717] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61319, },{ID = 13023, },},
	}
ScriptFightDB[10718] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61320, },{ID = 13024, },},
	}
ScriptFightDB[10719] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61321, },{ID = 13021, },},
	}
ScriptFightDB[10720] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61322, },{ID = 13022, },},
	}
ScriptFightDB[10721] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61323, },{ID = 13023, },},
	}
-----第104层
ScriptFightDB[10722] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61325, },{ID = 13031, },},
	}
ScriptFightDB[10723] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61326, },{ID = 13032, },},
	}
ScriptFightDB[10724] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61327, },{ID = 13033, },},
	}
ScriptFightDB[10725] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61328, },{ID = 13034, },},
	}
ScriptFightDB[10726] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61329, },{ID = 13031, },},
	}
ScriptFightDB[10727] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61330, },{ID = 13032, },},
	}
ScriptFightDB[10728] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61331, },{ID = 13033, },},
	}
-----第105层
ScriptFightDB[10729] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61333, },{ID = 13041, },},
	}
ScriptFightDB[10730] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61334, },{ID = 13042, },},
	}
ScriptFightDB[10731] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61335, },{ID = 13043, },},
	}
ScriptFightDB[10732] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61336, },{ID = 13044, },},
	}
ScriptFightDB[10733] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61337, },{ID = 13041, },},
	}
ScriptFightDB[10734] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61338, },{ID = 13042, },},
	}
ScriptFightDB[10735] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61339, },{ID = 13043, },},
	}
-----第106层
ScriptFightDB[10736] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61341, },{ID = 13051, },},
	}
ScriptFightDB[10737] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61342, },{ID = 13052, },},
	}
ScriptFightDB[10738] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61343, },{ID = 13053, },},
	}
ScriptFightDB[10739] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61344, },{ID = 13054, },},
	}
ScriptFightDB[10740] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61345, },{ID = 13051, },},
	}
ScriptFightDB[10741] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61346, },{ID = 13052, },},
	}
ScriptFightDB[10742] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61347, },{ID = 13053, },},
	}
-----第107层
ScriptFightDB[10743] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61349, },{ID = 13061, },},
	}
ScriptFightDB[10744] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61350, },{ID = 13062, },},
	}
ScriptFightDB[10745] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61351, },{ID = 13063, },},
	}
ScriptFightDB[10746] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61352, },{ID = 13064, },},
	}
ScriptFightDB[10747] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61353, },{ID = 13061, },},
	}
ScriptFightDB[10748] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61354, },{ID = 13062, },},
	}
ScriptFightDB[10749] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61355, },{ID = 13063, },},
	}
-----第108层
ScriptFightDB[10750] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61357, },{ID = 13071, },},
	}
ScriptFightDB[10751] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61358, },{ID = 13072, },},
	}
ScriptFightDB[10752] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61359, },{ID = 13073, },},
	}
ScriptFightDB[10753] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61360, },{ID = 13074, },},
	}
ScriptFightDB[10754] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61361, },{ID = 13071, },},
	}
ScriptFightDB[10755] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61362, },{ID = 13072, },},
	}
ScriptFightDB[10756] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61363, },{ID = 13073, },},
	}
-----第109层
ScriptFightDB[10757] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61365, },{ID = 13081, },},
	}
ScriptFightDB[10758] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61366, },{ID = 13082, },},
	}
ScriptFightDB[10759] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61367, },{ID = 13083, },},
	}
ScriptFightDB[10760] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61368, },{ID = 13084, },},
	}
ScriptFightDB[10761] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61369, },{ID = 13081, },},
	}
ScriptFightDB[10762] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61370, },{ID = 13082, },},
	}
ScriptFightDB[10763] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61371, },{ID = 13083, },},
	}
-----第110层
ScriptFightDB[10764] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61373, },{ID = 13091, },},
	}
ScriptFightDB[10765] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61374, },{ID = 13092, },},
	}
ScriptFightDB[10766] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61375, },{ID = 13093, },},
	}
ScriptFightDB[10767] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61376, },{ID = 13094, },},
	}
ScriptFightDB[10768] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61377, },{ID = 13091, },},
	}
ScriptFightDB[10769] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61378, },{ID = 13092, },},
	}
ScriptFightDB[10770] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61379, },{ID = 13093, },},
	}
-----第111层
ScriptFightDB[10771] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61381, },{ID = 13101, },},
	}
ScriptFightDB[10772] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61382, },{ID = 13102, },},
	}
ScriptFightDB[10773] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61383, },{ID = 13103, },},
	}
ScriptFightDB[10774] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61384, },{ID = 13104, },},
	}
ScriptFightDB[10775] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61385, },{ID = 13101, },},
	}
ScriptFightDB[10776] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61386, },{ID = 13102, },},
	}
ScriptFightDB[10777] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61387, },{ID = 13103, },},
	}
-----第112层
ScriptFightDB[10778] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61389, },{ID = 13111, },},
	}
ScriptFightDB[10779] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61390, },{ID = 13112, },},
	}
ScriptFightDB[10780] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61391, },{ID = 13113, },},
	}
ScriptFightDB[10781] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61392, },{ID = 13114, },},
	}
ScriptFightDB[10782] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61393, },{ID = 13111, },},
	}
ScriptFightDB[10783] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61394, },{ID = 13112, },},
	}
ScriptFightDB[10784] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61395, },{ID = 13113, },},
	}
-----第113层
ScriptFightDB[10785] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61397, },{ID = 13121, },},
	}
ScriptFightDB[10786] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61398, },{ID = 13122, },},
	}
ScriptFightDB[10787] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61399, },{ID = 13123, },},
	}
ScriptFightDB[10788] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61400, },{ID = 13124, },},
	}
ScriptFightDB[10789] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61401, },{ID = 13121, },},
	}
ScriptFightDB[10790] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61402, },{ID = 13122, },},
	}
ScriptFightDB[10791] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61403, },{ID = 13123, },},
	}
-----第114层
ScriptFightDB[10792] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61405, },{ID = 13131, },},
	}
ScriptFightDB[10793] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61406, },{ID = 13132, },},
	}
ScriptFightDB[10794] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61407, },{ID = 13133, },},
	}
ScriptFightDB[10795] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61408, },{ID = 13134, },},
	}
ScriptFightDB[10796] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61409, },{ID = 13131, },},
	}
ScriptFightDB[10797] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61410, },{ID = 13132, },},
	}
ScriptFightDB[10798] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61411, },{ID = 13133, },},
	}
-----第115层
ScriptFightDB[10799] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61413, },{ID = 13141, },},
	}
ScriptFightDB[10800] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61414, },{ID = 13142, },},
	}
ScriptFightDB[10801] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61415, },{ID = 13143, },},
	}
ScriptFightDB[10802] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61416, },{ID = 13144, },},
	}
ScriptFightDB[10803] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61417, },{ID = 13141, },},
	}
ScriptFightDB[10804] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61418, },{ID = 13142, },},
	}
ScriptFightDB[10805] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61419, },{ID = 13143, },},
	}
-----第116层
ScriptFightDB[10806] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61421, },{ID = 13151, },},
	}
ScriptFightDB[10807] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61422, },{ID = 13152, },},
	}
ScriptFightDB[10808] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61423, },{ID = 13153, },},
	}
ScriptFightDB[10809] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61424, },{ID = 13154, },},
	}
ScriptFightDB[10810] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61425, },{ID = 13151, },},
	}
ScriptFightDB[10811] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61426, },{ID = 13152, },},
	}
ScriptFightDB[10812] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61427, },{ID = 13153, },},
	}
-----第117层
ScriptFightDB[10813] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61429, },{ID = 13161, },},
	}
ScriptFightDB[10814] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61430, },{ID = 13162, },},
	}
ScriptFightDB[10815] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61431, },{ID = 13163, },},
	}
ScriptFightDB[10816] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61432, },{ID = 13164, },},
	}
ScriptFightDB[10817] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61433, },{ID = 13161, },},
	}
ScriptFightDB[10818] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61434, },{ID = 13162, },},
	}
ScriptFightDB[10819] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61435, },{ID = 13163, },},
	}
-----第118层
ScriptFightDB[10820] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61437, },{ID = 13171, },},
	}
ScriptFightDB[10821] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61438, },{ID = 13172, },},
	}
ScriptFightDB[10822] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61439, },{ID = 13173, },},
	}
ScriptFightDB[10823] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61440, },{ID = 13174, },},
	}
ScriptFightDB[10824] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61441, },{ID = 13171, },},
	}
ScriptFightDB[10825] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61442, },{ID = 13172, },},
	}
ScriptFightDB[10826] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61443, },{ID = 13173, },},
	}
-----第119层
ScriptFightDB[10827] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61445, },{ID = 13181, },},
	}
ScriptFightDB[10828] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61446, },{ID = 13182, },},
	}
ScriptFightDB[10829] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61447, },{ID = 13183, },},
	}
ScriptFightDB[10830] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61448, },{ID = 13184, },},
	}
ScriptFightDB[10831] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61449, },{ID = 13181, },},
	}
ScriptFightDB[10832] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61450, },{ID = 13182, },},
	}
ScriptFightDB[10833] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61451, },{ID = 13183, },},
	}
-----第120层
ScriptFightDB[10834] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61453, },{ID = 13191, },},
	}
ScriptFightDB[10835] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61454, },{ID = 13192, },},
	}
ScriptFightDB[10836] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61455, },{ID = 13193, },},
	}
ScriptFightDB[10837] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61456, },{ID = 13194, },},
	}
ScriptFightDB[10838] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61457, },{ID = 13191, },},
	}
ScriptFightDB[10839] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61458, },{ID = 13192, },},
	}
ScriptFightDB[10840] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61459, },{ID = 13193, },},
	}
-----第121层
ScriptFightDB[10841] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61461, },{ID = 13201, },},
	}
ScriptFightDB[10842] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61462, },{ID = 13202, },},
	}
ScriptFightDB[10843] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61463, },{ID = 13203, },},
	}
ScriptFightDB[10844] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61464, },{ID = 13204, },},
	}
ScriptFightDB[10845] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61465, },{ID = 13201, },},
	}
ScriptFightDB[10846] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61466, },{ID = 13202, },},
	}
ScriptFightDB[10847] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61467, },{ID = 13203, },},
	}
-----第122层
ScriptFightDB[10848] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61469, },{ID = 13211, },},
	}
ScriptFightDB[10849] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61470, },{ID = 13212, },},
	}
ScriptFightDB[10850] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61471, },{ID = 13213, },},
	}
ScriptFightDB[10851] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61472, },{ID = 13214, },},
	}
ScriptFightDB[10852] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61473, },{ID = 13211, },},
	}
ScriptFightDB[10853] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61474, },{ID = 13212, },},
	}
ScriptFightDB[10854] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61475, },{ID = 13213, },},
	}
-----第123层
ScriptFightDB[10855] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61477, },{ID = 13221, },},
	}
ScriptFightDB[10856] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61478, },{ID = 13222, },},
	}
ScriptFightDB[10857] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61479, },{ID = 13223, },},
	}
ScriptFightDB[10858] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61480, },{ID = 13224, },},
	}
ScriptFightDB[10859] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61481, },{ID = 13221, },},
	}
ScriptFightDB[10860] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61482, },{ID = 13222, },},
	}
ScriptFightDB[10861] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61483, },{ID = 13223, },},
	}
-----第124层
ScriptFightDB[10862] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61485, },{ID = 13231, },},
	}
ScriptFightDB[10863] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61486, },{ID = 13232, },},
	}
ScriptFightDB[10864] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61487, },{ID = 13233, },},
	}
ScriptFightDB[10865] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61488, },{ID = 13234, },},
	}
ScriptFightDB[10866] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61489, },{ID = 13231, },},
	}
ScriptFightDB[10867] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61490, },{ID = 13232, },},
	}
ScriptFightDB[10868] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61491, },{ID = 13233, },},
	}
-----第125层
ScriptFightDB[10869] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61493, },{ID = 13241, },},
	}
ScriptFightDB[10870] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61494, },{ID = 13242, },},
	}
ScriptFightDB[10871] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61495, },{ID = 13243, },},
	}
ScriptFightDB[10872] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61496, },{ID = 13244, },},
	}
ScriptFightDB[10873] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61497, },{ID = 13241, },},
	}
ScriptFightDB[10874] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61498, },{ID = 13242, },},
	}
ScriptFightDB[10875] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61499, },{ID = 13243, },},
	}
-----第126层
ScriptFightDB[10876] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61501, },{ID = 13251, },},
	}
ScriptFightDB[10877] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61502, },{ID = 13252, },},
	}
ScriptFightDB[10878] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61503, },{ID = 13253, },},
	}
ScriptFightDB[10879] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61504, },{ID = 13254, },},
	}
ScriptFightDB[10880] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61505, },{ID = 13251, },},
	}
ScriptFightDB[10881] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61506, },{ID = 13252, },},
	}
ScriptFightDB[10882] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61507, },{ID = 13253, },},
	}
-----第127层
ScriptFightDB[10883] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61509, },{ID = 13261, },},
	}
ScriptFightDB[10884] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61510, },{ID = 13262, },},
	}
ScriptFightDB[10885] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61511, },{ID = 13263, },},
	}
ScriptFightDB[10886] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61512, },{ID = 13264, },},
	}
ScriptFightDB[10887] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61513, },{ID = 13261, },},
	}
ScriptFightDB[10888] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61514, },{ID = 13262, },},
	}
ScriptFightDB[10889] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61515, },{ID = 13263, },},
	}
-----第128层
ScriptFightDB[10890] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61517, },{ID = 13271, },},
	}
ScriptFightDB[10891] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61518, },{ID = 13272, },},
	}
ScriptFightDB[10892] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61519, },{ID = 13273, },},
	}
ScriptFightDB[10893] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61520, },{ID = 13274, },},
	}
ScriptFightDB[10894] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61521, },{ID = 13271, },},
	}
ScriptFightDB[10895] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61522, },{ID = 13272, },},
	}
ScriptFightDB[10896] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61523, },{ID = 13273, },},
	}
-----第129层
ScriptFightDB[10897] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61525, },{ID = 13281, },},
	}
ScriptFightDB[10898] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61526, },{ID = 13282, },},
	}
ScriptFightDB[10899] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61527, },{ID = 13283, },},
	}
ScriptFightDB[10900] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61528, },{ID = 13284, },},
	}
ScriptFightDB[10901] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61529, },{ID = 13281, },},
	}
ScriptFightDB[10902] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61530, },{ID = 13282, },},
	}
ScriptFightDB[10903] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61531, },{ID = 13283, },},
	}
-----第130层
ScriptFightDB[10904] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61533, },{ID = 13291, },},
	}
ScriptFightDB[10905] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61534, },{ID = 13292, },},
	}
ScriptFightDB[10906] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61535, },{ID = 13293, },},
	}
ScriptFightDB[10907] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61536, },{ID = 13294, },},
	}
ScriptFightDB[10908] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61537, },{ID = 13291, },},
	}
ScriptFightDB[10909] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61538, },{ID = 13292, },},
	}
ScriptFightDB[10910] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61539, },{ID = 13293, },},
	}
-----第131层
ScriptFightDB[10911] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61541, },{ID = 13301, },},
	}
ScriptFightDB[10912] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61542, },{ID = 13302, },},
	}
ScriptFightDB[10913] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61543, },{ID = 13303, },},
	}
ScriptFightDB[10914] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61544, },{ID = 13304, },},
	}
ScriptFightDB[10915] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61545, },{ID = 13301, },},
	}
ScriptFightDB[10916] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61546, },{ID = 13302, },},
	}
ScriptFightDB[10917] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61547, },{ID = 13303, },},
	}
-----第132层
ScriptFightDB[10918] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61549, },{ID = 13311, },},
	}
ScriptFightDB[10919] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61550, },{ID = 13312, },},
	}
ScriptFightDB[10920] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61551, },{ID = 13313, },},
	}
ScriptFightDB[10921] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61552, },{ID = 13314, },},
	}
ScriptFightDB[10922] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61553, },{ID = 13311, },},
	}
ScriptFightDB[10923] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61554, },{ID = 13312, },},
	}
ScriptFightDB[10924] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61555, },{ID = 13313, },},
	}
-----第133层
ScriptFightDB[10925] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61557, },{ID = 13321, },},
	}
ScriptFightDB[10926] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61558, },{ID = 13322, },},
	}
ScriptFightDB[10927] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61559, },{ID = 13323, },},
	}
ScriptFightDB[10928] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61560, },{ID = 13324, },},
	}
ScriptFightDB[10929] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61561, },{ID = 13321, },},
	}
ScriptFightDB[10930] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61562, },{ID = 13322, },},
	}
ScriptFightDB[10931] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61563, },{ID = 13323, },},
	}
-----第134层
ScriptFightDB[10932] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61565, },{ID = 13331, },},
	}
ScriptFightDB[10933] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61566, },{ID = 13332, },},
	}
ScriptFightDB[10934] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61567, },{ID = 13333, },},
	}
ScriptFightDB[10935] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61568, },{ID = 13334, },},
	}
ScriptFightDB[10936] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61569, },{ID = 13331, },},
	}
ScriptFightDB[10937] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61570, },{ID = 13332, },},
	}
ScriptFightDB[10938] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61571, },{ID = 13333, },},
	}
-----第135层
ScriptFightDB[10939] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61573, },{ID = 13341, },},
	}
ScriptFightDB[10940] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61574, },{ID = 13342, },},
	}
ScriptFightDB[10941] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61575, },{ID = 13343, },},
	}
ScriptFightDB[10942] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61576, },{ID = 13344, },},
	}
ScriptFightDB[10943] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61577, },{ID = 13341, },},
	}
ScriptFightDB[10944] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61578, },{ID = 13342, },},
	}
ScriptFightDB[10945] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61579, },{ID = 13343, },},
	}
-----第136层
ScriptFightDB[10946] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61581, },{ID = 13351, },},
	}
ScriptFightDB[10947] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61582, },{ID = 13352, },},
	}
ScriptFightDB[10948] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61583, },{ID = 13353, },},
	}
ScriptFightDB[10949] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61584, },{ID = 13354, },},
	}
ScriptFightDB[10950] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61585, },{ID = 13351, },},
	}
ScriptFightDB[10951] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61586, },{ID = 13352, },},
	}
ScriptFightDB[10952] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61587, },{ID = 13353, },},
	}
-----第137层
ScriptFightDB[10953] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61589, },{ID = 13361, },},
	}
ScriptFightDB[10954] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61590, },{ID = 13362, },},
	}
ScriptFightDB[10955] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61591, },{ID = 13363, },},
	}
ScriptFightDB[10956] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61592, },{ID = 13364, },},
	}
ScriptFightDB[10957] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61593, },{ID = 13361, },},
	}
ScriptFightDB[10958] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61594, },{ID = 13362, },},
	}
ScriptFightDB[10959] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61595, },{ID = 13363, },},
	}
-----第138层
ScriptFightDB[10960] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61597, },{ID = 13371, },},
	}
ScriptFightDB[10961] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61598, },{ID = 13372, },},
	}
ScriptFightDB[10962] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61599, },{ID = 13373, },},
	}
ScriptFightDB[10963] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61600, },{ID = 13374, },},
	}
ScriptFightDB[10964] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61601, },{ID = 13371, },},
	}
ScriptFightDB[10965] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61602, },{ID = 13372, },},
	}
ScriptFightDB[10966] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61603, },{ID = 13373, },},
	}
-----第139层
ScriptFightDB[10967] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61605, },{ID = 13381, },},
	}
ScriptFightDB[10968] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61606, },{ID = 13382, },},
	}
ScriptFightDB[10969] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61607, },{ID = 13383, },},
	}
ScriptFightDB[10970] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61608, },{ID = 13384, },},
	}
ScriptFightDB[10971] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61609, },{ID = 13381, },},
	}
ScriptFightDB[10972] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61610, },{ID = 13382, },},
	}
ScriptFightDB[10973] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61611, },{ID = 13383, },},
	}
-----第140层
ScriptFightDB[10974] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61613, },{ID = 13391, },},
	}
ScriptFightDB[10975] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61614, },{ID = 13392, },},
	}
ScriptFightDB[10976] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61615, },{ID = 13393, },},
	}
ScriptFightDB[10977] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61616, },{ID = 13394, },},
	}
ScriptFightDB[10978] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61617, },{ID = 13391, },},
	}
ScriptFightDB[10979] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61618, },{ID = 13392, },},
	}
ScriptFightDB[10980] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61619, },{ID = 13393, },},
	}
-----第141层
ScriptFightDB[10981] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61621, },{ID = 13401, },},
	}
ScriptFightDB[10982] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61622, },{ID = 13402, },},
	}
ScriptFightDB[10983] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61623, },{ID = 13403, },},
	}
ScriptFightDB[10984] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61624, },{ID = 13404, },},
	}
ScriptFightDB[10985] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61625, },{ID = 13401, },},
	}
ScriptFightDB[10986] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61626, },{ID = 13402, },},
	}
ScriptFightDB[10987] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61627, },{ID = 13403, },},
	}
-----第142层
ScriptFightDB[10988] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61629, },{ID = 13411, },},
	}
ScriptFightDB[10989] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61630, },{ID = 13412, },},
	}
ScriptFightDB[10990] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61631, },{ID = 13413, },},
	}
ScriptFightDB[10991] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61632, },{ID = 13414, },},
	}
ScriptFightDB[10992] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61633, },{ID = 13411, },},
	}
ScriptFightDB[10993] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61634, },{ID = 13412, },},
	}
ScriptFightDB[10994] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61635, },{ID = 13413, },},
	}
-----第143层
ScriptFightDB[10995] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61637, },{ID = 13421, },},
	}
ScriptFightDB[10996] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61638, },{ID = 13422, },},
	}
ScriptFightDB[10997] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61639, },{ID = 13423, },},
	}
ScriptFightDB[10998] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61640, },{ID = 13424, },},
	}
ScriptFightDB[10999] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61641, },{ID = 13421, },},
	}
ScriptFightDB[11000] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61642, },{ID = 13422, },},
	}
ScriptFightDB[11001] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61643, },{ID = 13423, },},
	}
-----第144层
ScriptFightDB[11002] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61645, },{ID = 13431, },},
	}
ScriptFightDB[11003] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61646, },{ID = 13432, },},
	}
ScriptFightDB[11004] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61647, },{ID = 13433, },},
	}
ScriptFightDB[11005] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61648, },{ID = 13434, },},
	}
ScriptFightDB[11006] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61649, },{ID = 13431, },},
	}
ScriptFightDB[11007] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61650, },{ID = 13432, },},
	}
ScriptFightDB[11008] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61651, },{ID = 13433, },},
	}
-----第145层
ScriptFightDB[11009] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61653, },{ID = 13441, },},
	}
ScriptFightDB[11010] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61654, },{ID = 13442, },},
	}
ScriptFightDB[11011] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61655, },{ID = 13443, },},
	}
ScriptFightDB[11012] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61656, },{ID = 13444, },},
	}
ScriptFightDB[11013] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61657, },{ID = 13441, },},
	}
ScriptFightDB[11014] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61658, },{ID = 13442, },},
	}
ScriptFightDB[11015] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61659, },{ID = 13443, },},
	}
-----第146层
ScriptFightDB[11016] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61661, },{ID = 13451, },},
	}
ScriptFightDB[11017] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61662, },{ID = 13452, },},
	}
ScriptFightDB[11018] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61663, },{ID = 13453, },},
	}
ScriptFightDB[11019] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61664, },{ID = 13454, },},
	}
ScriptFightDB[11020] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61665, },{ID = 13451, },},
	}
ScriptFightDB[11021] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61666, },{ID = 13452, },},
	}
ScriptFightDB[11022] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61667, },{ID = 13453, },},
	}
-----第147层
ScriptFightDB[11023] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61669, },{ID = 13461, },},
	}
ScriptFightDB[11024] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61670, },{ID = 13462, },},
	}
ScriptFightDB[11025] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61671, },{ID = 13463, },},
	}
ScriptFightDB[11026] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61672, },{ID = 13464, },},
	}
ScriptFightDB[11027] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61673, },{ID = 13461, },},
	}
ScriptFightDB[11028] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61674, },{ID = 13462, },},
	}
ScriptFightDB[11029] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61675, },{ID = 13463, },},
	}
-----第148层
ScriptFightDB[11030] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61677, },{ID = 13471, },},
	}
ScriptFightDB[11031] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61678, },{ID = 13472, },},
	}
ScriptFightDB[11032] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61679, },{ID = 13473, },},
	}
ScriptFightDB[11033] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61680, },{ID = 13474, },},
	}
ScriptFightDB[11034] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61681, },{ID = 13471, },},
	}
ScriptFightDB[11035] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61682, },{ID = 13472, },},
	}
ScriptFightDB[11036] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61683, },{ID = 13473, },},
	}
-----第149层
ScriptFightDB[11037] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61685, },{ID = 13481, },},
	}
ScriptFightDB[11038] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61686, },{ID = 13482, },},
	}
ScriptFightDB[11039] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61687, },{ID = 13483, },},
	}
ScriptFightDB[11040] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61688, },{ID = 13484, },},
	}
ScriptFightDB[11041] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61689, },{ID = 13481, },},
	}
ScriptFightDB[11042] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61690, },{ID = 13482, },},
	}
ScriptFightDB[11043] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61691, },{ID = 13483, },},
	}
-----第150层
ScriptFightDB[11044] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61693, },{ID = 13491, },},
	}
ScriptFightDB[11045] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61694, },{ID = 13492, },},
	}
ScriptFightDB[11046] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61695, },{ID = 13493, },},
	}
ScriptFightDB[11047] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61696, },{ID = 13494, },},
	}
ScriptFightDB[11048] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61697, },{ID = 13491, },},
	}
ScriptFightDB[11049] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61698, },{ID = 13492, },},
	}
ScriptFightDB[11050] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61699, },{ID = 13493, },},
	}
-----第151层
ScriptFightDB[11051] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61701, },{ID = 13501, },},
	}
ScriptFightDB[11052] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61702, },{ID = 13502, },},
	}
ScriptFightDB[11053] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61703, },{ID = 13503, },},
	}
ScriptFightDB[11054] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61704, },{ID = 13504, },},
	}
ScriptFightDB[11055] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61705, },{ID = 13501, },},
	}
ScriptFightDB[11056] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61706, },{ID = 13502, },},
	}
ScriptFightDB[11057] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61707, },{ID = 13503, },},
	}
-----第152层
ScriptFightDB[11058] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61709, },{ID = 13511, },},
	}
ScriptFightDB[11059] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61710, },{ID = 13512, },},
	}
ScriptFightDB[11060] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61711, },{ID = 13513, },},
	}
ScriptFightDB[11061] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61712, },{ID = 13514, },},
	}
ScriptFightDB[11062] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61713, },{ID = 13511, },},
	}
ScriptFightDB[11063] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61714, },{ID = 13512, },},
	}
ScriptFightDB[11064] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61715, },{ID = 13513, },},
	}
-----第153层
ScriptFightDB[11065] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61717, },{ID = 13521, },},
	}
ScriptFightDB[11066] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61718, },{ID = 13522, },},
	}
ScriptFightDB[11067] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61719, },{ID = 13523, },},
	}
ScriptFightDB[11068] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61720, },{ID = 13524, },},
	}
ScriptFightDB[11069] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61721, },{ID = 13521, },},
	}
ScriptFightDB[11070] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61722, },{ID = 13522, },},
	}
ScriptFightDB[11071] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61723, },{ID = 13523, },},
	}
-----第154层
ScriptFightDB[11072] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61725, },{ID = 13531, },},
	}
ScriptFightDB[11073] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61726, },{ID = 13532, },},
	}
ScriptFightDB[11074] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61727, },{ID = 13533, },},
	}
ScriptFightDB[11075] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61728, },{ID = 13534, },},
	}
ScriptFightDB[11076] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61729, },{ID = 13531, },},
	}
ScriptFightDB[11077] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61730, },{ID = 13532, },},
	}
ScriptFightDB[11078] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61731, },{ID = 13533, },},
	}
-----第155层
ScriptFightDB[11079] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61733, },{ID = 13541, },},
	}
ScriptFightDB[11080] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61734, },{ID = 13542, },},
	}
ScriptFightDB[11081] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61735, },{ID = 13543, },},
	}
ScriptFightDB[11082] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61736, },{ID = 13544, },},
	}
ScriptFightDB[11083] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61737, },{ID = 13541, },},
	}
ScriptFightDB[11084] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61738, },{ID = 13542, },},
	}
ScriptFightDB[11085] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61739, },{ID = 13543, },},
	}
-----第156层
ScriptFightDB[11086] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61741, },{ID = 13551, },},
	}
ScriptFightDB[11087] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61742, },{ID = 13552, },},
	}
ScriptFightDB[11088] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61743, },{ID = 13553, },},
	}
ScriptFightDB[11089] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61744, },{ID = 13554, },},
	}
ScriptFightDB[11090] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61745, },{ID = 13551, },},
	}
ScriptFightDB[11091] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61746, },{ID = 13552, },},
	}
ScriptFightDB[11092] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61747, },{ID = 13553, },},
	}
-----第157层
ScriptFightDB[11093] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61749, },{ID = 13561, },},
	}
ScriptFightDB[11094] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61750, },{ID = 13562, },},
	}
ScriptFightDB[11095] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61751, },{ID = 13563, },},
	}
ScriptFightDB[11096] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61752, },{ID = 13564, },},
	}
ScriptFightDB[11097] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61753, },{ID = 13561, },},
	}
ScriptFightDB[11098] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61754, },{ID = 13562, },},
	}
ScriptFightDB[11099] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61755, },{ID = 13563, },},
	}
-----第158层
ScriptFightDB[11100] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61757, },{ID = 13571, },},
	}
ScriptFightDB[11101] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61758, },{ID = 13572, },},
	}
ScriptFightDB[11102] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61759, },{ID = 13573, },},
	}
ScriptFightDB[11103] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61760, },{ID = 13574, },},
	}
ScriptFightDB[11104] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61761, },{ID = 13571, },},
	}
ScriptFightDB[11105] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61762, },{ID = 13572, },},
	}
ScriptFightDB[11106] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61763, },{ID = 13573, },},
	}
-----第159层
ScriptFightDB[11107] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61765, },{ID = 13581, },},
	}
ScriptFightDB[11108] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61766, },{ID = 13582, },},
	}
ScriptFightDB[11109] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61767, },{ID = 13583, },},
	}
ScriptFightDB[11110] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61768, },{ID = 13584, },},
	}
ScriptFightDB[11111] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61769, },{ID = 13581, },},
	}
ScriptFightDB[11112] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61770, },{ID = 13582, },},
	}
ScriptFightDB[11113] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61771, },{ID = 13583, },},
	}
-----第160层
ScriptFightDB[11114] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61773, },{ID = 13591, },},
	}
ScriptFightDB[11115] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61774, },{ID = 13592, },},
	}
ScriptFightDB[11116] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61775, },{ID = 13593, },},
	}
ScriptFightDB[11117] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61776, },{ID = 13594, },},
	}
ScriptFightDB[11118] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61777, },{ID = 13591, },},
	}
ScriptFightDB[11119] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61778, },{ID = 13592, },},
	}
ScriptFightDB[11120] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61779, },{ID = 13593, },},
	}
-----第161层
ScriptFightDB[11121] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61781, },{ID = 13601, },},
	}
ScriptFightDB[11122] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61782, },{ID = 13602, },},
	}
ScriptFightDB[11123] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61783, },{ID = 13603, },},
	}
ScriptFightDB[11124] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61784, },{ID = 13604, },},
	}
ScriptFightDB[11125] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61785, },{ID = 13601, },},
	}
ScriptFightDB[11126] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61786, },{ID = 13602, },},
	}
ScriptFightDB[11127] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61787, },{ID = 13603, },},
	}
-----第162层
ScriptFightDB[11128] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61789, },{ID = 13611, },},
	}
ScriptFightDB[11129] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61790, },{ID = 13612, },},
	}
ScriptFightDB[11130] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61791, },{ID = 13613, },},
	}
ScriptFightDB[11131] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61792, },{ID = 13614, },},
	}
ScriptFightDB[11132] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61793, },{ID = 13611, },},
	}
ScriptFightDB[11133] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61794, },{ID = 13612, },},
	}
ScriptFightDB[11134] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61795, },{ID = 13613, },},
	}
-----第63层
ScriptFightDB[11135] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61797, },{ID = 13621, },},
	}
ScriptFightDB[11136] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61798, },{ID = 13622, },},
	}
ScriptFightDB[11137] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61799, },{ID = 13623, },},
	}
ScriptFightDB[11138] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61800, },{ID = 13624, },},
	}
ScriptFightDB[11139] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61801, },{ID = 13621, },},
	}
ScriptFightDB[11140] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61802, },{ID = 13622, },},
	}
ScriptFightDB[11141] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61803, },{ID = 13623, },},
	}
-----第164层
ScriptFightDB[11142] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61805, },{ID = 13631, },},
	}
ScriptFightDB[11143] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61806, },{ID = 13632, },},
	}
ScriptFightDB[11144] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61807, },{ID = 13633, },},
	}
ScriptFightDB[11145] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61808, },{ID = 13634, },},
	}
ScriptFightDB[11146] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61809, },{ID = 13631, },},
	}
ScriptFightDB[11147] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61810, },{ID = 13632, },},
	}
ScriptFightDB[10448] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61811, },{ID = 13633, },},
	}
-----第165层
ScriptFightDB[11149] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61813, },{ID = 13641, },},
	}
ScriptFightDB[11150] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61814, },{ID = 13642, },},
	}
ScriptFightDB[11151] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61815, },{ID = 13643, },},
	}
ScriptFightDB[11152] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61816, },{ID = 13644, },},
	}
ScriptFightDB[11153] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61817, },{ID = 13641, },},
	}
ScriptFightDB[11154] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61818, },{ID = 13642, },},
	}
ScriptFightDB[11155] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61819, },{ID = 13643, },},
	}
-----第166层
ScriptFightDB[11156] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61821, },{ID = 13651, },},
	}
ScriptFightDB[11157] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61822, },{ID = 13652, },},
	}
ScriptFightDB[11158] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61823, },{ID = 13653, },},
	}
ScriptFightDB[11159] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61824, },{ID = 13654, },},
	}
ScriptFightDB[11160] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61825, },{ID = 13651, },},
	}
ScriptFightDB[11161] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61826, },{ID = 13652, },},
	}
ScriptFightDB[11162] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61827, },{ID = 13653, },},
	}
-----第167层
ScriptFightDB[11163] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61829, },{ID = 13661, },},
	}
ScriptFightDB[11164] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61830, },{ID = 13662, },},
	}
ScriptFightDB[11165] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61831, },{ID = 13663, },},
	}
ScriptFightDB[11166] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61832, },{ID = 13664, },},
	}
ScriptFightDB[11167] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61833, },{ID = 13661, },},
	}
ScriptFightDB[11168] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61834, },{ID = 13662, },},
	}
ScriptFightDB[11169] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61835, },{ID = 13663, },},
	}
-----第168层
ScriptFightDB[11170] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61837, },{ID = 13671, },},
	}
ScriptFightDB[11171] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61838, },{ID = 13672, },},
	}
ScriptFightDB[11172] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61839, },{ID = 13673, },},
	}
ScriptFightDB[11173] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61840, },{ID = 13674, },},
	}
ScriptFightDB[11174] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61841, },{ID = 13671, },},
	}
ScriptFightDB[11175] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61842, },{ID = 13672, },},
	}
ScriptFightDB[11176] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61843, },{ID = 13673, },},
	}
-----第169层
ScriptFightDB[11177] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61845, },{ID = 13681, },},
	}
ScriptFightDB[11178] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61846, },{ID = 13682, },},
	}
ScriptFightDB[11179] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61847, },{ID = 13683, },},
	}
ScriptFightDB[11180] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61848, },{ID = 13684, },},
	}
ScriptFightDB[11181] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61849, },{ID = 13681, },},
	}
ScriptFightDB[11182] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61850, },{ID = 13682, },},
	}
ScriptFightDB[11183] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61851, },{ID = 13683, },},
	}
-----第170层
ScriptFightDB[11184] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61853, },{ID = 13691, },},
	}
ScriptFightDB[11185] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61854, },{ID = 13692, },},
	}
ScriptFightDB[11186] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61855, },{ID = 13693, },},
	}
ScriptFightDB[11187] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61856, },{ID = 13694, },},
	}
ScriptFightDB[11188] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61857, },{ID = 13691, },},
	}
ScriptFightDB[11189] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61858, },{ID = 13692, },},
	}
ScriptFightDB[11190] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61859, },{ID = 13693, },},
	}
-----第171层
ScriptFightDB[11191] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61861, },{ID = 13701, },},
	}
ScriptFightDB[11192] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61862, },{ID = 13702, },},
	}
ScriptFightDB[11193] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61863, },{ID = 13703, },},
	}
ScriptFightDB[11194] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61864, },{ID = 13704, },},
	}
ScriptFightDB[11195] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61865, },{ID = 13701, },},
	}
ScriptFightDB[11196] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61866, },{ID = 13702, },},
	}
ScriptFightDB[11197] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61867, },{ID = 13703, },},
	}
-----第172层
ScriptFightDB[11198] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61869, },{ID = 13711, },},
	}
ScriptFightDB[11199] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61870, },{ID = 13712, },},
	}
ScriptFightDB[11200] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61871, },{ID = 13713, },},
	}
ScriptFightDB[11201] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61872, },{ID = 13714, },},
	}
ScriptFightDB[11202] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61873, },{ID = 13711, },},
	}
ScriptFightDB[11203] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61874, },{ID = 13712, },},
	}
ScriptFightDB[11204] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61875, },{ID = 13713, },},
	}
-----第173层
ScriptFightDB[11205] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61877, },{ID = 13721, },},
	}
ScriptFightDB[11206] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61878, },{ID = 13722, },},
	}
ScriptFightDB[11207] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61879, },{ID = 13723, },},
	}
ScriptFightDB[11208] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61880, },{ID = 13724, },},
	}
ScriptFightDB[11209] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61881, },{ID = 13721, },},
	}
ScriptFightDB[11210] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61882, },{ID = 13722, },},
	}
ScriptFightDB[11211] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61883, },{ID = 13723, },},
	}
-----第174层
ScriptFightDB[11212] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61885, },{ID = 13731, },},
	}
ScriptFightDB[11213] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61886, },{ID = 13732, },},
	}
ScriptFightDB[11214] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61887, },{ID = 13733, },},
	}
ScriptFightDB[11215] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61888, },{ID = 13734, },},
	}
ScriptFightDB[11216] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61889, },{ID = 13731, },},
	}
ScriptFightDB[11217] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61890, },{ID = 13732, },},
	}
ScriptFightDB[11218] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61891, },{ID = 13733, },},
	}
-----第175层
ScriptFightDB[11219] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61893, },{ID = 13741, },},
	}
ScriptFightDB[11220] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61894, },{ID = 13742, },},
	}
ScriptFightDB[11221] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61895, },{ID = 13743, },},
	}
ScriptFightDB[11222] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61896, },{ID = 13744, },},
	}
ScriptFightDB[11223] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61897, },{ID = 13741, },},
	}
ScriptFightDB[11224] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61898, },{ID = 13742, },},
	}
ScriptFightDB[11225] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61899, },{ID = 13743, },},
	}
-----第176层
ScriptFightDB[11226] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61901, },{ID = 13751, },},
	}
ScriptFightDB[11227] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61902, },{ID = 13752, },},
	}
ScriptFightDB[11228] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61903, },{ID = 13753, },},
	}
ScriptFightDB[11229] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61904, },{ID = 13754, },},
	}
ScriptFightDB[11230] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61905, },{ID = 13751, },},
	}
ScriptFightDB[11231] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61906, },{ID = 13752, },},
	}
ScriptFightDB[11232] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61907, },{ID = 13753, },},
	}
-----第177层
ScriptFightDB[11233] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61909, },{ID = 13761, },},
	}
ScriptFightDB[11234] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61910, },{ID = 13762, },},
	}
ScriptFightDB[11235] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61911, },{ID = 13763, },},
	}
ScriptFightDB[11236] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61912, },{ID = 13764, },},
	}
ScriptFightDB[11237] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61913, },{ID = 13761, },},
	}
ScriptFightDB[11238] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61914, },{ID = 13762, },},
	}
ScriptFightDB[11239] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61915, },{ID = 13763, },},
	}
-----第178层
ScriptFightDB[11240] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61917, },{ID = 13771, },},
	}
ScriptFightDB[11241] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61918, },{ID = 13772, },},
	}
ScriptFightDB[11242] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61919, },{ID = 13773, },},
	}
ScriptFightDB[11243] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61920, },{ID = 13774, },},
	}
ScriptFightDB[11244] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61921, },{ID = 13771, },},
	}
ScriptFightDB[11245] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61922, },{ID = 13772, },},
	}
ScriptFightDB[11246] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61923, },{ID = 13773, },},
	}
-----第179层
ScriptFightDB[11247] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61925, },{ID = 13781, },},
	}
ScriptFightDB[11248] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61926, },{ID = 13782, },},
	}
ScriptFightDB[11249] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61927, },{ID = 13783, },},
	}
ScriptFightDB[11250] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61928, },{ID = 13784, },},
	}
ScriptFightDB[11251] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61929, },{ID = 13781, },},
	}
ScriptFightDB[11252] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61930, },{ID = 13782, },},
	}
ScriptFightDB[11253] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61931, },{ID = 13783, },},
	}
-----第180层
ScriptFightDB[11254] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61933, },{ID = 13791, },},
	}
ScriptFightDB[11255] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61934, },{ID = 13792, },},
	}
ScriptFightDB[11256] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61935, },{ID = 13793, },},
	}
ScriptFightDB[11257] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61936, },{ID = 13794, },},
	}
ScriptFightDB[11258] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61937, },{ID = 13791, },},
	}
ScriptFightDB[11259] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61938, },{ID = 13792, },},
	}
ScriptFightDB[11260] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61939, },{ID = 13793, },},
	}
-----第181层
ScriptFightDB[11261] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61941, },{ID = 13801, },},
	}
ScriptFightDB[11262] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61942, },{ID = 13802, },},
	}
ScriptFightDB[10563] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61943, },{ID = 13803, },},
	}
ScriptFightDB[11264] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61944, },{ID = 13804, },},
	}
ScriptFightDB[11265] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61945, },{ID = 13801, },},
	}
ScriptFightDB[11266] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61946, },{ID = 13802, },},
	}
ScriptFightDB[11267] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61947, },{ID = 13803, },},
	}
-----第182层
ScriptFightDB[11268] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61949, },{ID = 13811, },},
	}
ScriptFightDB[11269] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61950, },{ID = 13812, },},
	}
ScriptFightDB[11270] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61951, },{ID = 13813, },},
	}
ScriptFightDB[11271] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61952, },{ID = 13814, },},
	}
ScriptFightDB[11272] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61953, },{ID = 13811, },},
	}
ScriptFightDB[11273] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61954, },{ID = 13812, },},
	}
ScriptFightDB[11274] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61955, },{ID = 13813, },},
	}
-----第183层
ScriptFightDB[11275] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61957, },{ID = 13821, },},
	}
ScriptFightDB[11276] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61958, },{ID = 13822, },},
	}
ScriptFightDB[11277] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61959, },{ID = 13823, },},
	}
ScriptFightDB[11278] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61960, },{ID = 13824, },},
	}
ScriptFightDB[11279] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61961, },{ID = 13821, },},
	}
ScriptFightDB[11280] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61962, },{ID = 13822, },},
	}
ScriptFightDB[11281] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61963, },{ID = 13823, },},
	}
-----第184层
ScriptFightDB[11282] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61965, },{ID = 13831, },},
	}
ScriptFightDB[11283] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61966, },{ID = 13832, },},
	}
ScriptFightDB[11284] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61967, },{ID = 13833, },},
	}
ScriptFightDB[11285] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61968, },{ID = 13834, },},
	}
ScriptFightDB[11286] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61969, },{ID = 13831, },},
	}
ScriptFightDB[11287] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61970, },{ID = 13832, },},
	}
ScriptFightDB[11288] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61971, },{ID = 13833, },},
	}
-----第185层
ScriptFightDB[11289] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61973, },{ID = 13841, },},
	}
ScriptFightDB[11290] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61974, },{ID = 13842, },},
	}
ScriptFightDB[11291] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61975, },{ID = 13843, },},
	}
ScriptFightDB[11292] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61976, },{ID = 13844, },},
	}
ScriptFightDB[11293] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61977, },{ID = 13841, },},
	}
ScriptFightDB[11294] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61978, },{ID = 13842, },},
	}
ScriptFightDB[11295] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61979, },{ID = 13843, },},
	}
-----第186层
ScriptFightDB[11296] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61981, },{ID = 13851, },},
	}
ScriptFightDB[11297] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61982, },{ID = 13852, },},
	}
ScriptFightDB[11298] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61983, },{ID = 13853, },},
	}
ScriptFightDB[11299] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61984, },{ID = 13854, },},
	}
ScriptFightDB[11300] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61985, },{ID = 13851, },},
	}
ScriptFightDB[11301] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61986, },{ID = 13852, },},
	}
ScriptFightDB[11302] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61987, },{ID = 13853, },},
	}
-----第187层
ScriptFightDB[11303] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61989, },{ID = 13861, },},
	}
ScriptFightDB[11304] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61990, },{ID = 13862, },},
	}
ScriptFightDB[11305] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61991, },{ID = 13863, },},
	}
ScriptFightDB[11306] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61992, },{ID = 13864, },},
	}
ScriptFightDB[11307] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61993, },{ID = 13861, },},
	}
ScriptFightDB[11308] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61994, },{ID = 13862, },},
	}
ScriptFightDB[11309] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61995, },{ID = 13863, },},
	}
-----第188层
ScriptFightDB[11310] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61997, },{ID = 13871, },},
	}
ScriptFightDB[11311] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61998, },{ID = 13872, },},
	}
ScriptFightDB[11312] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 61999, },{ID = 13873, },},
	}
ScriptFightDB[11313] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62000, },{ID = 13874, },},
	}
ScriptFightDB[11314] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62001, },{ID = 13871, },},
	}
ScriptFightDB[11315] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62002, },{ID = 13872, },},
	}
ScriptFightDB[11316] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62003, },{ID = 13873, },},
	}
-----第189层
ScriptFightDB[11317] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62005, },{ID = 13881, },},
	}
ScriptFightDB[11318] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62006, },{ID = 13882, },},
	}
ScriptFightDB[11319] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62007, },{ID = 13883, },},
	}
ScriptFightDB[11320] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62008, },{ID = 13884, },},
	}
ScriptFightDB[11321] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62009, },{ID = 13881, },},
	}
ScriptFightDB[11322] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62010, },{ID = 13882, },},
	}
ScriptFightDB[11323] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62011, },{ID = 13883, },},
	}
-----第190层
ScriptFightDB[11324] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62013, },{ID = 13891, },},
	}
ScriptFightDB[11325] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62014, },{ID = 13892, },},
	}
ScriptFightDB[11326] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62015, },{ID = 13893, },},
	}
ScriptFightDB[11327] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62016, },{ID = 13894, },},
	}
ScriptFightDB[11328] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62017, },{ID = 13891, },},
	}
ScriptFightDB[11329] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62019, },{ID = 13892, },},
	}
ScriptFightDB[11330] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62019, },{ID = 13893, },},
	}
-----第191层
ScriptFightDB[11331] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62021, },{ID = 13901, },},
	}
ScriptFightDB[11332] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62022, },{ID = 13902, },},
	}
ScriptFightDB[11333] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62023, },{ID = 13903, },},
	}
ScriptFightDB[11334] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62024, },{ID = 13904, },},
	}
ScriptFightDB[11335] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62025, },{ID = 13901, },},
	}
ScriptFightDB[11336] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62026, },{ID = 13902, },},
	}
ScriptFightDB[11337] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62027, },{ID = 13903, },},
	}
-----第192层
ScriptFightDB[11338] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62029, },{ID = 13911, },},
	}
ScriptFightDB[11339] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62030, },{ID = 13912, },},
	}
ScriptFightDB[11340] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62031, },{ID = 13913, },},
	}
ScriptFightDB[11341] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62032, },{ID = 13914, },},
	}
ScriptFightDB[11342] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62033, },{ID = 13911, },},
	}
ScriptFightDB[11343] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62034, },{ID = 13912, },},
	}
ScriptFightDB[11344] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62035, },{ID = 13913, },},
	}
-----第193层
ScriptFightDB[11345] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62037, },{ID = 13921, },},
	}
ScriptFightDB[11346] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62038, },{ID = 13922, },},
	}
ScriptFightDB[11347] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62039, },{ID = 13923, },},
	}
ScriptFightDB[11348] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62040, },{ID = 13924, },},
	}
ScriptFightDB[11349] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62041, },{ID = 13921, },},
	}
ScriptFightDB[11350] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62042, },{ID = 13922, },},
	}
ScriptFightDB[11351] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62043, },{ID = 13923, },},
	}
-----第194层
ScriptFightDB[11352] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62045, },{ID = 13931, },},
	}
ScriptFightDB[11353] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62046, },{ID = 13932, },},
	}
ScriptFightDB[11354] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62047, },{ID = 13933, },},
	}
ScriptFightDB[11355] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62048, },{ID = 13934, },},
	}
ScriptFightDB[11356] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62049, },{ID = 13931, },},
	}
ScriptFightDB[11357] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62050, },{ID = 13932, },},
	}
ScriptFightDB[11358] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62051, },{ID = 13933, },},
	}
-----第195层
ScriptFightDB[11359] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62053, },{ID = 13941, },},
	}
ScriptFightDB[11360] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62054, },{ID = 13942, },},
	}
ScriptFightDB[11361] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62055, },{ID = 13943, },},
	}
ScriptFightDB[11362] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62056, },{ID = 13944, },},
	}
ScriptFightDB[11363] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62057, },{ID = 13941, },},
	}
ScriptFightDB[11364] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62058, },{ID = 13942, },},
	}
ScriptFightDB[11365] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62059, },{ID = 13943, },},
	}
-----第196层
ScriptFightDB[11366] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62061, },{ID = 13951, },},
	}
ScriptFightDB[11367] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62062, },{ID = 13952, },},
	}
ScriptFightDB[11368] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62063, },{ID = 13953, },},
	}
ScriptFightDB[11369] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62064, },{ID = 13954, },},
	}
ScriptFightDB[11370] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62065, },{ID = 13951, },},
	}
ScriptFightDB[11371] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62066, },{ID = 13952, },},
	}
ScriptFightDB[11372] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62067, },{ID = 13953, },},
	}
-----第97层
ScriptFightDB[11373] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62069, },{ID = 13961, },},
	}
ScriptFightDB[11374] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62070, },{ID = 13962, },},
	}
ScriptFightDB[11375] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62071, },{ID = 13963, },},
	}
ScriptFightDB[11376] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62072, },{ID = 13964, },},
	}
ScriptFightDB[11377] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62073, },{ID = 13961, },},
	}
ScriptFightDB[11378] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62074, },{ID = 13962, },},
	}
ScriptFightDB[11379] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62075, },{ID = 13963, },},
	}
-----第198层
ScriptFightDB[11380] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62077, },{ID = 13971, },},
	}
ScriptFightDB[11381] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62078, },{ID = 13972, },},
	}
ScriptFightDB[11382] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62079, },{ID = 13973, },},
	}
ScriptFightDB[11383] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62080, },{ID = 13974, },},
	}
ScriptFightDB[11384] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62081, },{ID = 13971, },},
	}
ScriptFightDB[11385] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62082, },{ID = 13972, },},
	}
ScriptFightDB[11386] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62083, },{ID = 13973, },},
	}
-----第199层
ScriptFightDB[11387] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62085, },{ID = 13981, },},
	}
ScriptFightDB[11388] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62086, },{ID = 13982, },},
	}
ScriptFightDB[11389] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62087, },{ID = 13983, },},
	}
ScriptFightDB[11390] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62088, },{ID = 13984, },},
	}
ScriptFightDB[11391] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62089, },{ID = 13981, },},
	}
ScriptFightDB[11392] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62090, },{ID = 13982, },},
	}
ScriptFightDB[11393] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62091, },{ID = 13983, },},
	}
-----第200层
ScriptFightDB[11394] = {
	--monsters = {type=ScriptMonsterCreateType.Assign,{ID = 30780,pos = 26 },},
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62093, },{ID = 13991, },},
	}
ScriptFightDB[11395] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62094, },{ID = 13992, },},
	}
ScriptFightDB[11396] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62095, },{ID = 13993, },},
	}
ScriptFightDB[11397] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62096, },{ID = 13994, },},
	}
ScriptFightDB[11398] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62097, },{ID = 13991, },},
	}
ScriptFightDB[11399] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62098, },{ID = 13992, },},
	}
ScriptFightDB[11400] = {
	monsters = {type=ScriptMonsterCreateType.Assign,{ID = 62099, },{ID = 13993, },},
	}