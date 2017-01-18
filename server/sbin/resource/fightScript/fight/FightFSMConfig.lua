--[[FightFSMConfig.lua
描述：
	战斗状态机行为配置
--]]


FightEnterAction = {
	[FightState.Start]			= Fight.onEnterFightStart,
	[FightState.RoundStart]		= Fight.onEnterRoundStart,
	[FightState.Caculate]		= Fight.onEnterCalculate,
	[FightState.RoundEnd]		= Fight.onEnterRoundEnd,
	[FightState.FightEnd]		= Fight.onEnterFightEnd,
	[FightState.PhaseStart]		= FightScript.onEnterPhaseStart,
}

FightLeaveAction = {
	[FightState.Start]			= Fight.onLeaveFightStart,
	[FightState.RoundStart]		= Fight.onLeaveRoundStart,
	[FightState.Caculate]		= Fight.onLeaveCalculate,
	[FightState.RoundEnd]		= Fight.onLeaveRoundEnd,
	[FightState.PhaseStart]		= FightScript.onLeavePhaseStart,
}

--[FightState.Start] = {[eventID]=function,}
FightInputAction = {
	[FightState.RoundStart] = {[FightEvents_CF_ChooseAction] = Fight.onChooseAction,},
	[FightState.RoundEnd]   = {[FightEvents_CF_PlayOver] = Fight.onPlayOver,},
	[FightState.Start]   = {[FightEvents_CF_PlayOver] = Fight.onPlayOverInFightStart,},
	[FightState.PhaseStart] = {[FightEvents_CF_PlayOver] = FightScript.onPlayOverInPhaseStart},
}

FightTimeOutAction = {

	[FightState.Start]	= nil,
	[FightState.RoundStart]	= nil,
	[FightState.Caculate]	= nil,
	[FightState.RoundEnd]	= nil,
	[FightState.FightEnd]	= nil,

}


