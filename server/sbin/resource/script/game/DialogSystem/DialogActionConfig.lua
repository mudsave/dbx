--[[DialogActionConfig.lua
	对话功能配置(对话系统)
]]

--点击选项执行的功能
DialogActionConfig =
{
	[DialogActionType.SwithScene]				= DialogAction.doSwithScene,
	[DialogActionType.Goto]						= DialogAction.doGoto,
	[DialogActionType.Gotos]					= DialogAction.doGotos,
	[DialogActionType.EnterFight]				= DialogAction.doEnterFight,
	[DialogActionType.EnterScriptFight]			= DialogAction.doEnterScriptFight,
	[DialogActionType.EnterEctype]				= DialogAction.doEnterEctype,
	[DialogActionType.RingEctype]				= DialogAction.doRingEctype,
	[DialogActionType.EnterRingEctype]			= DialogAction.doEnterRingEctype,
	[DialogActionType.EnterPVPFight]			= DialogAction.doEnterPVPFight,
	[DialogActionType.FrozenBuff]				= DialogAction.doFreezeBuff,
	[DialogActionType.CancelFrozenBuff]			= DialogAction.doCancelFrozenBuff,
	[DialogActionType.RecetiveTask]				= DialogAction.doRecetiveTask,
	[DialogActionType.RecetiveSpecialTask]		= DialogAction.doRecetiveSpecialTask,
	[DialogActionType.RequestNpcTrade]			= DialogAction.doRequestNpcTrade,
	[DialogActionType.GetItem]					= DialogAction.doGetItem,
	[DialogActionType.FinishTask]				= DialogAction.doFinishTask,
	[DialogActionType.DoneTask]					= DialogAction.doDoneTask,
	[DialogActionType.AutoTrace]				= DialogAction.doAutoTrace,
	[DialogActionType.RecoverMaxHp]				= DialogAction.doRecoverMaxHp,
	[DialogActionType.FlyEffect]				= DialogAction.doFlyEffect,
	[DialogActionType.UITip]					= DialogAction.doOpenUITip,
	[DialogActionType.CloseDialog]				= DialogAction.doCloseDialog,
	[DialogActionType.OpenUI]				    = DialogAction.doOpenUI,
	[DialogActionType.RepairPet]				= DialogAction.doRepairPet,
	[DialogActionType.RepairAllPet]				= DialogAction.doRepairAllPet,
	[DialogActionType.PaidPet]					= DialogAction.doPaidPet,
	[DialogActionType.MayTaskFight]				= DialogAction.doMayTaskFight,
	[DialogActionType.CostMoney]				= DialogAction.doCostMoney,
	[DialogActionType.Fight]					= DialogAction.doFight,
	[DialogActionType.BuyItem]					= DialogAction.doBuyItem,
	[DialogActionType.DeductMoney]				= DialogAction.doDeductMoney,
	[DialogActionType.openLookTaskWin]			= DialogAction.doOpenLookTaskWin,
	[DialogActionType.EnterTreasureFight]		= DialogAction.doEnterTreasureFight,
	[DialogActionType.ShowFactionList]			= DialogAction.doShowFactionList,
	[DialogActionType.CreateFaction]			= DialogAction.doCreateFaction,
	[DialogActionType.EnterCatchPetFight]		= DialogAction.doEnterCatchPetFight,
	[DialogActionType.EnterCatchPetMap]			= DialogAction.doEnterCatchPetMap,
	[DialogActionType.EnterFactionScene]		= DialogAction.doEnterFactionScene,
	[DialogActionType.ContributeFaction]		= DialogAction.doContributeFaction,
	[DialogActionType.OpenEquipAppraisal]		= DialogAction.doOpenEquipAppraisal,
	[DialogActionType.ExchangeProps]			= DialogAction.doExchangeProps,
	[DialogActionType.ConsumeRecetiveTask]		= DialogAction.doConsumeRecetiveTask,
	[DialogActionType.FinishLoopTask]			= DialogAction.doFinishLoopTask,
	[DialogActionType.AddFollowNpc]				= DialogAction.doAddFollowNpc,
	[DialogActionType.EnterBeastFight]			= DialogAction.doEnterBeastFight,
	[DialogActionType.EnterGoldHuntZone]		= DialogAction.doEnterGoldHuntZone,
	[DialogActionType.GoldHuntFight]			= DialogAction.doGoldHuntFight,
	[DialogActionType.GoldHuntCommit]			= DialogAction.doGoldHuntCommit,
	[DialogActionType.GetTheActivity]			= DialogAction.doGetTheActivity,
	[DialogActionType.GiveUpActivity]			= DialogAction.doGiveUpActivity,
	[DialogActionType.DekaronSchoolFight]		= DialogAction.doDekaronSchoolFight,
	[DialogActionType.RecetiveTasks]			= DialogAction.doRecetiveTasks,
	[DialogActionType.ReceiveBabelTask]			= DialogAction.doReceiveBabelTask,
	[DialogActionType.EnterBabel]				= DialogAction.doEnterBabel,
	[DialogActionType.EnterNextLayer]			= DialogAction.doEnterNextLayer,
	[DialogActionType.FlyUp]					= DialogAction.doFlyUp,
	[DialogActionType.ChangeRewardType]			= DialogAction.doChangeRewardType,
	[DialogActionType.ChangeTarget]				= DialogAction.doChangeTarget,
	[DialogActionType.EnterDiscussHero]			= DialogAction.doEnterDiscussHero,
	[DialogActionType.DiscussHeroFight]			= DialogAction.doDiscussHeroFight,
	[DialogActionType.OpenItemRepairWin]		= DialogAction.doRepairEquipment,
	[DialogActionType.OpenPuzzle]				= DialogAction.doOpenPuzzle,
	[DialogActionType.ChangePlayerMoney]		= DialogAction.doChangePlayerMoney,
	[DialogActionType.FactionEctype]			= DialogAction.doFactionEctype,
	[DialogActionType.OldTowerEliminate]		= DialogAction.doOldTower,
}