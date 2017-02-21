--[[ConfSystem.lua
描述:
	系统加载
--]]

function loadSystem()
	require "game.ItemSystem.ItemSystem"
	require "game.EquipPlayingSystem.EquipPlayingSystem"
	require "game.RideSystem.RideSystem"
	require "game.TeamSystem.TeamSystem"
	require "game.TradeSystem.TradeSystem"
	require "game.TaskSystem.TaskSystem"
	require "game.TaskSystem.LoopTaskReward"
	require "game.PKSystem.PKSystem"
	require "game.DialogSystem.DialogSystem"
	require "game.EctypeSystem.EctypeSystem"
	require "game.ExperienceSystem.ExperienceSystem"
	require "game.TreasureSystem.TreasureSystem"
	
	require "game.CactionSystem"
	require "game.MoveSystem"
	require "game.GMSystem.ShellSystem"
	require "game.FrameSystem"

	require "game.SceneSystem"
	require "game.PlayerMiscSystem"
	require "game.CommonSystem.CommonSystem"
	require "game.CollectSystem.CollectSystem"
	--require "game.PetDepotSystem.PetDepotSystem"
	require "game.ServerDataCommunitySystem"
	require "game.TransportationSystem"
	require "game.ShortCutKeySystem.ShortCutKeySystem"

	require "game.ActivitySystem.ActivitySystem"
	require "game.FightSystem.FightRelaySystem"
	require "game.PetSystem.PetSystem"
	require "game.SystemError"
	require "game.LifeSkillSystem.LifeSkillSystem"
	require "game.DramaSystem.DramaSystem"
	require "game.PractiseSystem.PractiseSystem"
	require "game.OnlineRewardSystem.OnlineRewardSystem"
	require "game.NewReWardsSystem.NewReWardsSystem"
	require "game.NewcomerGiftsSystem.NewcomerGiftsSystem"
	require "game.PetDepotSystem.PetDepotSystem"
	require "game.BuffSystem.BuffSystem"
	require "game.SkillSystem.MindSystem"
	require "game.TirednessSystem.TirednessManager"
	require "game.RoleConfigSystem.RoleConfigSystem"
	require "game.MineSystem.MineSystem"
	require "game.MailSystem.MailSystem"
	require "game.TestSystem.TestSystem"
	require "game.ExchangeItemSystem.ExchangeItemSystem"

	g_itemFct			= ItemFactory.getInstance()
	g_itemMgr			= ItemManager.getInstance()
	g_rideMgr			= RideManager.getInstance()
	g_teamMgr			= TeamManager.getInstance()
	g_tradeMgr			= TradeManager.getInstance()

	-- 对话系统
	g_dialogMgr			= DialogManager.getInstance()
	g_dialogDoer		= DialogDoer.getInstance()
	g_dialogSym			= DialogSystem.getInstance()
	g_dialogCondtion	= DialogCondition.getInstance()

	g_PKMgr				= PKManager.getInstance()
	g_ectypeMgr			= EctypeManager.getInstance()
	g_experienceMgr		= ExperienceManager.getInstance()

	g_CollectMgr        = CollectManager.getInstence()


	
	g_treasureSym		= TreasureSystem.getInstance()
	g_treasureMgr		= TreasureManager.getInstance()

	g_fightMgr			= FightManager.getInstance()
	g_buffMgr			= BuffManager.getInstance()
	g_ShortCutKeyMgr	= ShortCutKeyManager.getInstance()
	g_PetDepotMgr		= PetDepotManager.getInstance()
	g_LifeSkillMgr      = LifeSkillManager.getInstance()
	g_practiseMgr		= PractiseManager.getInstance()
	g_tirednessdMgr		= TirednessManager.getInstance()
	g_onlineRewardSessMgr = RewardSessionManager.getInstance()
	g_newRewardsMgr		= NewReWardsManager.getInstance()
	g_RoleConfigMgr		= RoleConfigManager.getInstance()
	g_dropMgr			= DropManager.getInstance()
	g_mailMgr			= MailManager.getInstance()
	
	-- 活动
	g_activityMgr = ActivityManager.getInstance()
	-- 瑞兽降临活动
	g_beastBlessMgr		= BeastBlessManager.getInstance()
	g_goldHuntMgr		= GoldHuntManager.getInstance()
	g_catchPetMgr		= CatchPetManager.getInstance()

	g_exchangeItemMgr = ExchangeItemManager.getInstance()
end
