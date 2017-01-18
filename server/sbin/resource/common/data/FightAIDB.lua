--[[ FightAIDB.lua]]
AITargetType = {
				 Me				 = 1,--自己 {  type = AITargetType.Me,},
				 AnyOfFriend	 = 2,--友方任意 {  type = AITargetType.AnyOfFriend, params ={},},
				 AnyOfEnemy		 = 3,--敌方任意 {  type = AITargetType.AnyOfEnemy, params ={},},
				 AnyOfFriendButMe = 4,--除自己外友方任意 {  type = AITargetType.AnyOfFriendButMe, params ={},},
				 AllOfEnemy		 = 5,--敌方全体 {  type = AITargetType.AllOfEnemy, params ={},},
				 AllOfFriend	 = 6,--友方方全体 {  type = AITargetType.AllOfFriend, params ={},},
				 AllRoleOfEnemy	 = 7,--敌方全体角色(伪pvp中的玩家) {  type = AITargetType.AllRoleOfEnemy, params ={},},
				 AllPetOfEnemy	 = 8,--敌方全体宠物  {  type = AITargetType.AllPetOfEnemy, params ={},},
				 AnyRoleOfEnemy	 = 9,--敌方任意角色(伪pvp中的玩家) {  type = AITargetType.AnyRoleOfEnemy, params ={},},
				 AnyPetOfEnemy	 = 10,--敌方任意宠物 {  type = AITargetType.AnyPetOfEnemy, },
				 AttrPercent	 = 11,--属性比例要求 {  type = AITargetType.AttrPercent, params ={isEnemy = true ,type = AIAttrType.Hp,relation ="<=", value = 0.1 ,count = 2},},
				 Level			 = 12,--等级要求{  type = AITargetType.Level, params ={isEnemy = true,type ="min" or "max" },},
				 School			 = 13,--门派要求{  type = AITargetType.School, params ={isEnemy = true,type =SchoolType.QYD },},
				 Phase			 = 14,--相性要求{  type = AITargetType.Phase, params ={isEnemy = true,type = PhaseType.Soil},},
				 --AttackType		 = 15,--攻击类型 {  type = AITargetType.AttackType, params ={isEnemy = true,type = AttackType.Magic},},
				 Status          = 16,--状态限定(buff){  type = AITargetType.Status, params ={isEnemy = true,buffID = 1,count = 1},},或者{  type = AITargetType.Status, params ={isEnemy = true, type = BuffKind.Dot},},
				 DBID			 = 17,--单位ID{  type = AITargetType.DBID, params ={ID = DBID},},
				 Position		 = 18,--位置{  type = AITargetType.Position, params ={pos = 10},},
				 DeadFriend		 = 19,--倒地已方{  type = AITargetType.DeadFriend, },
				 AttrMinMax		 = 20,--属性极限值{  type = AITargetType.AttrMinMax, params ={isEnemy = true,type = AIAttrType.Hp,relation = "min"},},--relation为"min"或"max"

}
--[[
--门派类别
SchoolType = {
	PM          = 0x00,
	QYD         = 0x01,
	JXS         = 0x02,
	ZYM         = 0x03,
	YXG         = 0x04,
	TYD         = 0x05,
	PLG         = 0x06,
}
--相性类型
PhaseType = {
	Soil = 1, 		--土
	Ice = 2, 		--冰
	Fire = 3,		--火
	Poison = 4,		--毒
	Thunder = 5,	--雷
	Wind = 6, 		--风
}
--攻击类型
AttackType = {
				Phisical = 1,--物攻
				Magic	 = 2,--法攻
}
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
--战斗类型
FightUIType = {
		CommonAttack = 2, -- 普通攻击 --{actionType = FightUIType.CommonAttack},
		UseSkill     = 3, -- 使用技能--{actionType = FightUIType.UseSkill,params ={skillID =10001}},
		Protect      = 4, -- 保护--{actionType = FightUIType.Protect,params ={ID =11}},
		Escape	     = 5, -- 逃跑-{actionType = FightUIType.Escape,params ={}},
		Defense	     = 8, -- 防御-{actionType = FightUIType.Defense,params ={}},
		Call	     = 9, -- 召唤-{actionType = FightUIType.Call,params ={{ID =11,count = 1},},},
}
]]

AIAttrType = {
			Hp = 1,--生命
			Mp = 2,--法力
			Kill = 3,--怒气
			At = 4,--物攻
			Mt = 5,--法功
			Af = 6,--物防
			Mf = 7,--法防
			win_phase = 8,--风相性
			thu_phase = 9,--雷相性
			ice_phase = 10,--冰相性
			soi_phase = 11,--土相性
			fir_phase = 12,--火相性
			poi_phase = 13,--毒相性
}

--条件类型
AIConditionType=
{
	AttrPercent   = 1,--属性比例{type=AIConditionType.AttrPercent,params={isEnemy = true ,type = AIAttrType.Hp,relation ="<=", value = 0.1 ,count = 2},}, 或{type=AIConditionType.AttrPercent,params={ ID = DBID,type = AIAttrType.Hp,relation ="<=",value = 0.2},},
	IDExist		  = 2,--id是否存在{type=AIConditionType.IDExist,params={ID = 3},}, 或--id不存在{type=AIConditionType.IDExist,params={ID = 3,isNot = true},}, 
	RoundCount    = 3,--第几回合{type=AIConditionType.RoundCount,params={round = 2,},}
	RoundInterval = 4,--回合间隔{type=AIConditionType.RoundInterval,params={period = 2,startRound = 2},}
	BuffStatus	  = 5,--带有指定的buff(ID,或类型){type=AIConditionType.BuffStatus,params={isEnemy = true,buffID = 1( or type = BuffKind.Dot)},}或 {type=AIConditionType.BuffStatus,params={ID = DBID,buffID = 1( or type = BuffKind.Dot)},}
	LiveNum		  = 6,--存活的单位数{type=AIConditionType.LiveNum,params={isEnemy = true,count = 1},}
	IsAttacked	  = 7,--指定回合是否受击{type=AIConditionType.IsAttacked,params={round ={ 1，2},（period = 1,）},}
	School		  = 8,--门派{type=AIConditionType.School,params={isEnemy = true,school = SchoolType.QYD},}, 
	Phase		  = 9,--相性{type=AIConditionType.Phase,params={isEnemy = true,,phase = PhaseType.Soil},}, 
	Dead		  = 11,--重伤{type=AIConditionType.Dead,params={ID = 3},},或 {type=AIConditionType.Dead,params={isEnemy = true,count = 1},},
	Prob		  = 12,--概率{type=AIConditionType.Prob,params={prob= 0.5},}, 
	

}
FightAIDB = {}

FightAIDB[10086] = {  
	name =  '通用战斗选择AI例子',
	type = AIType.Config, --
	scriptID = nil,
	
	[1] = {

		
			 condition = {
							type=AIConditionType.AttrPercent,
							params={isEnemy = true ,type = AIAttrType.Hp,relation ="<=", value = 0.1 ,count = 2},
						 },
			 action = {actionType = FightUIType.Defense},
			 chooseTarget = {
					 
							  type = AITargetType.AttrPercent,
							  params ={isEnemy = true,type = AIAttrType.Hp,relation ="<=",value = 0.2,count = 1 },
					
							},
		

	},
}

FightAIDB[1] = {
	name  = 'AI测试',
	type = AIType.Config,

	[1] = {
	
		condition = {
			type=AIConditionType.Prob,params={prob= 1},
			
		},
		
		action = { 
			
			actionType = FightUIType.UseSkill,params ={skillID ={ 1004}},
			--actionType = FightUIType.CommonAttack,params ={},
		},

		chooseTarget = {
			type = AITargetType.AnyOfEnemy,
		},
	},
}

FightAIDB[2] = {
	name  = 'AI测试',
	type = AIType.Config,

	[1] = {

		condition = {
			type=AIConditionType.Prob,params={prob= 0.5},
			--type=AIConditionType.Phase,params={isEnemy = true,phase = PhaseType.Soil},
		},
		
		action = { 
			
			actionType = FightUIType.UseSkill,params ={skillID = {1004}},
		},

		chooseTarget = {
			type = AITargetType.Phase, params ={isEnemy = true,type = PhaseType.Soil},
		},
	},

}

FightAIDB[3] = {
	name  = 'AI测试',
	type = AIType.Config,

	[1] = {
		
		action = { 
			
			actionType = FightUIType.UseSkill,params ={skillID ={ 1018}},
		},

		chooseTarget = {
			type = AITargetType.AnyOfEnemy,
		},
	},
	[2] = {
		
		action = { 
			
			actionType = FightUIType.UseSkill,params ={skillID ={ 1021}},
		},

		chooseTarget = {
			type = AITargetType.AnyOfEnemy,
		},
	},
}