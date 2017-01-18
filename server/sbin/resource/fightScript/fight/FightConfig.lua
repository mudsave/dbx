--[[FightConfig.lua
描述：
	战斗常数及配置
--]]
	
 FightEntityMaxID = 10000

eClsTypeNone 		=		0
eClsTypePlayer		=		1
eClsTypeNpc 		=		2
eClsTypePet 		=		3
eClsTypeMonster		=		4

 FightState = {
			Start		= 1,
			RoundStart	= 2,
			Caculate	= 3,
			RoundEnd	= 4,
			FightEnd	= 5,
			PhaseStart  = 6,
}

FightTimeOut = {
	[FightState.Start]	= 10,
	[FightState.RoundStart]	= 10,
	[FightState.Caculate]	= 2,
	[FightState.RoundEnd]	= 5,
	[FightState.FightEnd]	= 5,

}


FightStand = {
		A = 1,--右边
		B = 2,--左边
		C = 3,--观战
}

RoleLifeState = {
	Normal	= 0x01,
	Dead	= 0x02,
	--下面为被控制状态
	Sopor	= 0x010, --昏睡状态
	Freeze	= 0x020, --冰冻状态
	Chaos	= 0x040, --混乱状态
	Taunt	= 0x080, --嘲讽状态
	Poison	= 0x100, --中毒状态
	Silence	= 0x200, --沉默状态
}

MaxFightRoundActionsNum	 = 32
MaxFightChooseActionTime = 25
MaxFightActionPlayTime   = 80--3*60
MaxFightActionCaculateTime = 2
MaxFightPhaseStartTime = 10
MaxFightOfflineTime = 60
MemCollectPeriod = 10*60

FightActionMap = {
			[FightUIType.CommonAttack]		= FightAction.doCommonAttack,
			[FightUIType.UseSkill]			= FightAction.doSkilAction,
			[FightUIType.Auto]				= FightAction.doAuto,
			[FightUIType.Protect]			= FightAction.doProtect,
			[FightUIType.Defense]			= FightAction.doDefense,
			[FightUIType.Escape]			= FightAction.doEscape,
			[FightUIType.UseMaterial]		= FightAction.doUseMaterial,
			[FightUIType.Call]				= FightAction.doCall,
			[FightUIType.CallBack]			= FightAction.doCallBack,
			[FightUIType.Catch]				= FightAction.doCatch,
		 }
ResultAttrType = {
			Hp = 1,
			Mp = 2,
		 }

ResultStatusType = 
{
	Miss						= 1,	-- 闪避
	Critical					= 2,	-- 爆击
	Counter						= 3,	-- 反弹
	Defense						= 4,	-- 防御
	CriticalAndCounter			= 5,	-- 爆击+反弹
	CriticalAndDefense			= 6,	-- 爆击+防御
	DefenseAndCounter			= 7,	-- 防御+反弹
	Invalid						= 8,	-- 无效
}

FinalHitRateConst = 10--最终命中率常数
FinalHitRateCoef = 20--最终命中率折算系数
FinalHitRateCoef1 = 0.01--最终命中率折算系数
FinalCritRateConst = 0.1--最终暴击率常数
FinalCritRateCoef = 20--最终暴击率折算系数
FinalCritRateCoef1 = 0.01--最终暴击率折算系数
FinalCriticalDamageConst = 1.5--最终暴击伤害常数
CounterIncConst = 0.1 --反震伤害常数
DefenseDamageConst = 0.5 --防御减伤害比例

FightEntityHandlerType = {
	AIHandler = 1,
	HandlerDef_FightBuff = 2,
	HandlerDef_FightItem = 3,
	SkillHandler = 4,
}

NonExistEntityID = (-1)*0xFFFFFFFF
NonExistEntityPos = (-1)

AttackType = {
				Phisical = 1,
				Magic	 = 2,
}

ClearRoundCountAfterInjured = 2

EachActiveKillValue = 5
EachPassiveKillValue = 10
MaxAngerValue = 100
EachLifeReduction = {10,20}
EachLifeDeadReduction = {100,150}
EachLoyaltyReduction = 1
EachLoyaltyDeadReduction = 1500
 
FightSystemActionMap = {
			[ScriptFightActionType.PlayAnimation]			= FightSystemAction.PlayAnimation,
			[ScriptFightActionType.PlayBubble]				= FightSystemAction.PlayBubble,
			[ScriptFightActionType.PlayDialog]				= FightSystemAction.PlayDialog,
			[ScriptFightActionType.PlayAction]				= FightSystemAction.PlayAction,
			[ScriptFightActionType.PlayEffect]				= FightSystemAction.PlayEffect,
			[ScriptFightActionType.ReplaceEntity]			= FightSystemAction.ReplaceEntity,
			[ScriptFightActionType.EntityQuit]				= FightSystemAction.EntityQuit,

			[ScriptFightActionType.EntityEnter]				= FightSystemAction.EntityEnter,
			[ScriptFightActionType.UseSkill]				= FightSystemAction.UseSkill,
			[ScriptFightActionType.AddBuff]					= FightSystemAction.AddBuff,
			[ScriptFightActionType.RemoveBuff]				= FightSystemAction.RemoveBuff,
			[ScriptFightActionType.SetGBH]					= FightSystemAction.SetGBH,
			[ScriptFightActionType.FightPause]				= FightSystemAction.FightPause,
			[ScriptFightActionType.FightEnd]				= FightSystemAction.FightEnd,
			[ScriptFightActionType.MakeEscape]				= FightSystemAction.MakeEscape,
			[ScriptFightActionType.SetCounterRate]			= FightSystemAction.SetCounterRate,
			[ScriptFightActionType.ExchangePos]				= FightSystemAction.ExchangePos,
			[ScriptFightActionType.ChangeHp]				= FightSystemAction.ChangeHp,
 }

 ScriptFightConditionCheckMap ={
								[ScriptFightConditionType.AttrValue]	= FightSystemActionChecker.AttrValueChanged,
								[ScriptFightConditionType.IDExist]		= FightSystemActionChecker.isIDExist,
								[ScriptFightConditionType.RoundCount]	= FightSystemActionChecker.isRoundCount,
								[ScriptFightConditionType.RoundInterval]= FightSystemActionChecker.isRoundInterval,
								[ScriptFightConditionType.BuffStatus]	= FightSystemActionChecker.isBuffStatus,
								[ScriptFightConditionType.LiveNum]		= FightSystemActionChecker.isLiveNum,
								[ScriptFightConditionType.IsAttacked]	= FightSystemActionChecker.isAttacked,
								[ScriptFightConditionType.FightPeriod]	= FightSystemActionChecker.isFightPeriod,
								[ScriptFightConditionType.PlayerDead]	= FightSystemActionChecker.isPlayerDead,
 }

 FightAITargetMap = {
					 [AITargetType.Me]					= 	ChooseTarget.getMe,
					 [AITargetType.AnyOfFriend]			= 	ChooseTarget.getAnyOfFriend,
					 [AITargetType.AnyOfEnemy]			= 	ChooseTarget.getAnyOfEnemy,
					[AITargetType.AnyOfFriendButMe]		= 	ChooseTarget.getAnyOfFriendButMe,
					 [AITargetType.AllOfEnemy]			= 	ChooseTarget.getAllOfEnemy,
					 [AITargetType.AllOfFriend]			= 	ChooseTarget.getAllOfFriend,
					 [AITargetType.AllRoleOfEnemy]		= 	ChooseTarget.getAllRoleOfEnemy,
					 [AITargetType.AllPetOfEnemy]		= 	ChooseTarget.getAllPetOfEnemy,
					 [AITargetType.AnyRoleOfEnemy]		= 	ChooseTarget.getAnyRoleOfEnemy,
					 [AITargetType.AnyPetOfEnemy]		= 	ChooseTarget.getAnyPetOfEnemy,
					 [AITargetType.AttrPercent]			= 	ChooseTarget.getAttrPercentTargets,
					 [AITargetType.Level]				= 	ChooseTarget.getLevelTargets,
					 [AITargetType.School]				= 	ChooseTarget.getSchoolTargets,
					 [AITargetType.Phase]				= 	ChooseTarget.getPhaseTargets,
					 --[AITargetType.AttackType]			= 	ChooseTarget.getAttackTypeTargets,
					 [AITargetType.Status]				= 	ChooseTarget.getStatusTargets,
					 [AITargetType.DBID]				= 	ChooseTarget.getDBIDTargets,
					 [AITargetType.Position]			= 	ChooseTarget.getPositionTargets,
					 [AITargetType.DeadFriend]			= 	ChooseTarget.getDeadFriendTargets,
					 [AITargetType.AttrMinMax]			= 	ChooseTarget.getAttrMinMaxTargets,

 }

 FightAIConditionMap = {
				[AIConditionType.AttrPercent]					= ChooseCondition.isAttrPercent,
				[AIConditionType.IDExist]						= ChooseCondition.isIDExist,
				[AIConditionType.RoundCount]					= ChooseCondition.isRoundCount,
				[AIConditionType.RoundInterval]					= ChooseCondition.isRoundInterval,
				[AIConditionType.BuffStatus]					= ChooseCondition.isBuffStatus,
				[AIConditionType.LiveNum]						= ChooseCondition.isLiveNum,
				[AIConditionType.IsAttacked]					= ChooseCondition.isAttacked,
				[AIConditionType.School]						= ChooseCondition.isSchool,
				[AIConditionType.Phase]							= ChooseCondition.isPhase,
				[AIConditionType.Dead]							= ChooseCondition.isDead,
				[AIConditionType.Prob]							= ChooseCondition.isProb,
 }

 SchoolType = {
	PM          = 0x00,
	QYD         = 0x01,
	JXS         = 0x02,
	ZYM         = 0x03,
	YXG         = 0x04,
	TYD         = 0x05,
	PLG         = 0x06,
}

School2AttackType = {
	[SchoolType.QYD] = AttackType.Phisical,
	[SchoolType.JXS] = AttackType.Phisical,
	[SchoolType.ZYM] = AttackType.Phisical,

	[SchoolType.PLG] = AttackType.Magic,
	[SchoolType.TYD] = AttackType.Magic,
	[SchoolType.YXG] = AttackType.Magic,
}

