--[[EventDef.lua
描述�??
	定义game事件
]]

--定义组ID
local Event_Group_Local					= 0x00000
local Event_Group_Frame					= 0x10000
local Event_Group_Confg					= 0x20000
local Event_Group_ChatMsg				= 0x30000
local Event_Group_Dialog				= 0x40000
local Event_Group_ClientMsg				= 0x50000
local Event_Group_ClientMsgID			= 0x60000
local Event_Group_MoveMsg				= 0x70000
local Event_Group_PlayerSysMsg			= 0x80000
local Event_Group_SceneMsg				= 0x90000
local Event_Group_Item					= 0x100000
local Event_Group_Fight					= 0x200000
local Event_Group_Team					= 0x300000
local Event_Group_Ectype				= 0x400000
local Event_Group_ShortCutKey			= 0x500000
local Event_Group_Buff					= 0x600000
local Event_Group_Skill					= 0x700000
local Event_Group_Task					= 0x800000
local Event_Group_Trade					= 0x900000
local Event_Group_Mail					= 0x1000000
local Event_Group_Caction				= 0x1100000
local Event_Group_Quit					= 0x1200000
local Event_Group_TaskTarget			= 0x1300000
local Event_Group_Social				= 0x1400000
local Event_Group_NewRewards			= 0x1500000
local Event_Group_Pet					= 0x1600000
local Event_Group_Experience			= 0x1700000
local Event_Group_Ride					= 0x1800000
local Event_Group_OnlineReward			= 0x1900000
local Event_Group_PK					= 0x2100000
local Event_Group_EquipPlaying			= 0x2200000
local Event_Group_Drama					= 0x2300000
local Event_Group_Collecting			= 0x2400000
local event_Group_NewcomerGifts			= 0x2500000
local Event_Group_AutoPoint				= 0x2600000
local Event_Group_SocialServer_Group	= 0x2700000
local Event_Group_SocialServer_Faction	= 0x2800000
local Event_Group_SocialServer_Friend 	= 0x2000000
local Event_Group_Transportion			= 0x2900000
local Event_Group_RoleConfigure			= 0x3000000
local Event_Group_LifeSkill             = 0x3100000
local Event_Group_SystemSet				= 0x3200000
local Event_Group_Activity				= 0x3300000
local Event_Group_PetDepot				= 0x3400000
local Event_Group_Treasure				= 0x3500000
local Event_Group_Practise				= 0x3600000
local Event_Group_SocialServer_BroadCast = 0x3700000
local Event_Group_DekaronSchool			= 0x3800000
local Event_Group_ExchangeItem			= 0x3900000
local Event_Group_DoubleReward			= 0x4000000
local Event_Group_Stall         		= 0x4100000


--定义Event_Group_Local事件
LocalEvents_SS_Test						= Event_Group_Local + 1

--定义Event_Group_Local事件
FrameEvents_CS_Test						= Event_Group_Frame + 1
FrameEvents_SC_Test						= Event_Group_Frame + 2
FrameEvents_SS_playerDropLine			= Event_Group_Frame + 3
FrameEvents_SS_playerOnLine				= Event_Group_Frame + 4
FrameEvents_CS_playerHeartBeat			= Event_Group_Frame + 5
FrameEvents_SS_leaveScene				= Event_Group_Frame + 6

FrameEvents_SC_Ping						= Event_Group_Frame + 7
FrameEvents_CS_Ping						= Event_Group_Frame + 8
FrameEvents_CS_addMoney					= Event_Group_Frame + 9
--定义Event_Group_Confg事件

ConfigEvents_CS_SaveConfig				= Event_Group_Confg + 1
ConfigEvents_CS_SaveShortcutKeys		= Event_Group_Confg + 2
ConfigEvents_C_MenuItemClicked			= Event_Group_Confg + 3
ConfigEvents_SC_LoadConfig				= Event_Group_Confg + 4

--定义Event_Group_ChatMsg消息
ChatEvents_CC_TextAccepted				= Event_Group_ChatMsg + 1
ChatEvents_CS_ShellCommand				= Event_Group_ChatMsg + 2
ChatEvents_CS_SendChatMsg				= Event_Group_ChatMsg + 3
ChatEvents_SC_SendChatMsg				= Event_Group_ChatMsg + 4
ChatEvents_CF_SendChatMsg				= Event_Group_ChatMsg + 5
ChatEvents_FC_SendChatMsg				= Event_Group_ChatMsg + 6
ChatEvents_SC_GotoMsgReturn				= Event_Group_ChatMsg + 7
ChatEvents_SB_SendToAround				= Event_Group_ChatMsg + 8
ChatEvents_SB_SendToTeam				= Event_Group_ChatMsg + 9
ChatEvents_SB_SendToWorld				= Event_Group_ChatMsg + 10
ChatEvents_CB_SendToHorn				= Event_Group_ChatMsg + 11

--定义Event_Group_Dialog事件
DialogEvents_CS_OpenDialog				= Event_Group_Dialog + 1
DialogEvents_CS_OpenDialogByID			= Event_Group_Dialog + 2
DialogEvents_SC_OpenFunDialog			= Event_Group_Dialog + 3
DialogEvents_SC_OpenDialog				= Event_Group_Dialog + 4
DialogEvents_SC_OpenErrorDialog			= Event_Group_Dialog + 5
DialogEvents_CS_NextDialog				= Event_Group_Dialog + 6
DialogEvents_CS_CloseDialog				= Event_Group_Dialog + 7
DialogEvents_SC_CloseDialog				= Event_Group_Dialog + 8
DialogEvents_CS_CloseDialogByID			= Event_Group_Dialog + 9

--定义Event_Group_ClientMsg消息事件
ClientEvents_SC_PromptMsg				= Event_Group_ClientMsg + 1
ClientEvents_SC_HyperLinkMsg			= Event_Group_ClientMsg + 2
ClientEvents_SC_SystemMsg               = Event_Group_ClientMsg + 3

--定义Event_Group_MoveMsg消息事件ID
MoveEvent_CS_MoveTo						= Event_Group_MoveMsg + 1
MoveEvent_CS_StopMove					= Event_Group_MoveMsg + 2
MoveEvent_SS_StartMove					= Event_Group_MoveMsg + 3
MoveEvent_SS_StopMove					= Event_Group_MoveMsg + 4
MoveEvent_SS_OnStopMove					= Event_Group_MoveMsg + 5
MoveEvent_SS_OnStartMove				= Event_Group_MoveMsg + 6
MoveEvent_SS_OnStopMove					= Event_Group_MoveMsg + 7


--定义Event_Group_PlayerSysMsg消息事件ID
PlayerSysEvent_CS_AttrPointChanged		= Event_Group_PlayerSysMsg + 1
PlayerSysEvent_SC_AttrPointChanged		= Event_Group_PlayerSysMsg + 2
PlayerSysEvent_CS_PhasePointChanged		= Event_Group_PlayerSysMsg + 3
PlayerSysEvent_SC_PhasePointChanged		= Event_Group_PlayerSysMsg + 4
PlayerSysEvent_CS_RoleUpgrade			= Event_Group_PlayerSysMsg + 5
PlayerSysEvent_SC_RoleUpgrade			= Event_Group_PlayerSysMsg + 6
PlayerSysEvent_CS_PropsBatchStart		= Event_Group_PlayerSysMsg + 7
PlayerSysEvent_SC_PropsBatchEnd			= Event_Group_PlayerSysMsg + 8
PlayerSysEvent_CS_ShowDramaChanged		= Event_Group_PlayerSysMsg + 9

--定义Event_Group_SceneMsg消息事件ID
SceneEvent_CS_SwitchScene				= Event_Group_SceneMsg + 1
SceneEvent_SC_StartOrganEffect			= Event_Group_SceneMsg + 2
SceneEvent_SC_StopOrganEffect			= Event_Group_SceneMsg + 3
SceneEvent_SC_AddOrganEntity			= Event_Group_SceneMsg + 4
SceneEvent_SC_RemoveOrganEntity			= Event_Group_SceneMsg + 5
SceneEvent_SC_ResumeOrganEntity			= Event_Group_SceneMsg + 6
SceneEvent_SC_ChangeOrganEffectTarget	= Event_Group_SceneMsg + 7
SceneEvent_CS_PlayerUnderAttack			= Event_Group_SceneMsg + 8
SceneEvent_SC_PlayerUnderAttack			= Event_Group_SceneMsg + 9
SceneEvent_CS_PlayerFlyEffect			= Event_Group_SceneMsg + 10
SceneEvent_CS_PlayerAutoSender			= Event_Group_SceneMsg + 11
SceneEvent_CS_UpdateOrganPosition		= Event_Group_SceneMsg + 12
SceneEvent_SC_UpdateOrganPosition		= Event_Group_SceneMsg + 13
SceneEvent_CS_NoticeTileChange			= Event_Group_SceneMsg + 14
SceneEvent_CS_PositionRevert			= Event_Group_SceneMsg + 15
SceneEvent_CS_PlayerTransfer			= Event_Group_SceneMsg + 16
SceneEvent_SC_PlayerTransfer			= Event_Group_SceneMsg + 17
SceneEvent_CS_MoveSpeedEffect			= Event_Group_SceneMsg + 18
SceneEvent_SC_MoveSpeedEffect			= Event_Group_SceneMsg + 19
SceneEvent_SS_AttackEffect				= Event_Group_SceneMsg + 20

-- 定义物品系统消息事件
ItemEvents_SC_UpdateInfo	            = Event_Group_Item + 1
ItemEvents_SC_CreateItem	            = Event_Group_Item + 2
ItemEvents_CS_MoveItem	                = Event_Group_Item + 3
ItemEvents_CS_DestroyItem	            = Event_Group_Item + 4
ItemEvents_CS_PackUp	                = Event_Group_Item + 5
ItemEvents_CS_UseMedicament	            = Event_Group_Item + 6
ItemEvents_SC_CapacityChange	        = Event_Group_Item + 7
ItemEvents_CS_SplitItem	                = Event_Group_Item + 8
ItemEvents_CS_StoreMoney                = Event_Group_Item + 9
ItemEvents_CS_FetchMoney                = Event_Group_Item + 10
ItemEvents_CS_ExtendDepot               = Event_Group_Item + 11
ItemEvents_CS_UpdatePack                = Event_Group_Item + 12
ItemEvents_SC_OpenEquipAppraisal        = Event_Group_Item + 13
ItemEvents_CS_RequestEquipAppraisal     = Event_Group_Item + 14
ItemEvents_SC_EquipAppraisalResult      = Event_Group_Item + 15
ItemEvents_SC_OpenExchangeProps			= Event_Group_Item + 16
ItemEvents_CS_RequestExchangeProps      = Event_Group_Item + 17
ItemEvents_SC_ExchangePropsResult       = Event_Group_Item + 18
ItemEvents_CS_RepairEquipMent	        = Event_Group_Item + 19
ItemEvents_CS_RepairAllEquipMent	    = Event_Group_Item + 20
ItemEvents_SC_RepairEquipment			= Event_Group_Item + 21

--战斗系统消息事件
FightEvents_FC_StartFight				= Event_Group_Fight + 1
FightEvents_SF_StartFight				= Event_Group_Fight + 2
FightEvents_CF_ChooseAction				= Event_Group_Fight + 4
FightEvents_FC_FightResults				= Event_Group_Fight + 5
FightEvents_FC_QuitFight				= Event_Group_Fight + 6
FightEvents_CF_PlayOver					= Event_Group_Fight + 7
FightEvents_SS_FightEnter				= Event_Group_Fight + 8
FightEvents_FS_FightResults				= Event_Group_Fight + 11
FightEvents_FS_StartFight				= Event_Group_Fight + 12
FightEvents_FS_FightEnd					= Event_Group_Fight + 13
FightEvents_SF_StartScriptFight			= Event_Group_Fight + 14
FightEvents_FC_StartRound				= Event_Group_Fight + 15
FightEvents_FF_ExitWorld				= Event_Group_Fight + 16
FightEvents_SS_FightEnd					= Event_Group_Fight + 17
FightEvents_FS_QuitFight				= Event_Group_Fight + 18
FightEvents_FC_EnterFightState			= Event_Group_Fight + 19
FightEvents_FC_SwitchFightScene			= Event_Group_Fight + 20
FightEvents_SF_ExitFight				= Event_Group_Fight + 21 --退出战斗GM指令
FightEvents_SF_QueryAttr				= Event_Group_Fight + 22
FightEvents_SF_SetAttr                  = Event_Group_Fight + 23
FightEvents_FC_SetAttr                  = Event_Group_Fight + 24
FightEvents_FS_CreatePet                = Event_Group_Fight + 25
FightEvents_SF_CreatePet                = Event_Group_Fight + 26
FightEvents_CS_EnterMineFight           = Event_Group_Fight + 27
FightEvents_CS_QuitFight				= Event_Group_Fight + 28 
FightEvents_SS_FightEnd_beforeClient	= Event_Group_Fight + 29
FightEvents_SS_FightEnd_afterClient		= Event_Group_Fight + 30
FightEvents_CS_SwitchMineState			= Event_Group_Fight + 31
FightEvents_SS_FightEnd_ResetState		= Event_Group_Fight + 32
FightEvents_SC_StartAutoMeet			= Event_Group_Fight + 33
FightEvents_CF_PlayBubbleEnd			= Event_Group_Fight + 34

--定义组队系统消息时间
TeamEvents_CS_CreateTeam				= Event_Group_Team + 1
TeamEvents_SC_CreateTeam				= Event_Group_Team + 2
TeamEvents_CS_DissolveTeam				= Event_Group_Team + 3
TeamEvents_SC_DissolveTeam				= Event_Group_Team + 4
TeamEvents_CS_InviteJoinTeam			= Event_Group_Team + 5
TeamEvents_SC_InviteJoinTeam			= Event_Group_Team + 6
TeamEvents_CS_AnswerInvite				= Event_Group_Team + 7
TeamEvents_SC_NewMemberJoinTeam			= Event_Group_Team + 8
TeamEvents_CS_RequestJoinTeam			= Event_Group_Team + 9
TeamEvents_SC_RequestJoinTeam			= Event_Group_Team + 10
TeamEvents_CS_AnswerRequest				= Event_Group_Team + 11
TeamEvents_CS_StepOutTeam				= Event_Group_Team + 12
TeamEvents_SC_StepOutTeam				= Event_Group_Team + 13
TeamEvents_CS_ComeBackTeam				= Event_Group_Team + 14
TeamEvents_SC_ComeBackTeam				= Event_Group_Team + 15
TeamEvents_CS_ChangeLeader				= Event_Group_Team + 16
TeamEvents_SC_ChangeLeader				= Event_Group_Team + 17
TeamEvents_CS_MoveOutMember				= Event_Group_Team + 18
TeamEvents_SC_MoveOutMember				= Event_Group_Team + 19
TeamEvents_CS_QuitTeam					= Event_Group_Team + 20
TeamEvents_SC_QuitTeam					= Event_Group_Team + 21
TeamEvents_SC_MemberJoinTeam			= Event_Group_Team + 22
TeamEvents_SC_RefuseRequestTeam			= Event_Group_Team + 23
TeamEvents_SC_LeaderQuitTeam			= Event_Group_Team + 24
TeamEvents_CS_UpdateQueueCount			= Event_Group_Team + 25
TeamEvents_SC_UpdateQueueCount			= Event_Group_Team + 26
TeamEvents_CS_SearchTeamList			= Event_Group_Team + 27
TeamEvents_SC_SearchTeamList			= Event_Group_Team + 28
TeamEvents_CS_AutoTeam					= Event_Group_Team + 29
TeamEvents_CS_CancelAutoTeam			= Event_Group_Team + 30
TeamEvents_SC_CancelAutoTeam			= Event_Group_Team + 31
TeamEvents_CS_LeaderAutoTeam			= Event_Group_Team + 32
TeamEvents_CS_LeaderCancelAutoTeam		= Event_Group_Team + 33
TeamEvents_SS_DissolveEctypeTeam        = Event_Group_Team + 34
TeamEvents_SS_StepOutTeam               = Event_Group_Team + 35
TeamEvents_SC_InviteJoinTeamNotify		= Event_Group_Team + 36
TeamEvents_SC_ComeBackTeamNotify		= Event_Group_Team + 37
TeamEvents_SC_inviteJoinTeamNotify		= Event_Group_Team + 38
TeamEvents_SC_targetOfflineNotify		= Event_Group_Team + 39
TeamEvents_SC_targetHasTeamNotify		= Event_Group_Team + 40
TeamEvents_SC_teamIsFullNotify			= Event_Group_Team + 41
TeamEvents_SC_refuseJoinTeamToLeader	= Event_Group_Team + 42
TeamEvents_SC_refuseJoinTeamToTarget	= Event_Group_Team + 43
TeamEvents_SS_MemberJoinTeam			= Event_Group_Team + 44
TeamEvents_SS_QuitTeam					= Event_Group_Team + 45
TeamEvents_SS_ChangeLeader				= Event_Group_Team + 46
TeamEvents_SS_MoveOutMember				= Event_Group_Team + 47
TeamEvents_CS_ApplyForLeader			= Event_Group_Team + 48
TeamEvents_SC_CreateConfirmWin			= Event_Group_Team + 49
TeamEvents_CS_RefuseApply				= Event_Group_Team + 50

-- 定义副本系统消息事件
EctypeEvents_CS_EnterEctype				= Event_Group_Ectype + 1
EctypeEvents_SC_EnterEctype				= Event_Group_Ectype + 2
EctypeEvents_CS_ExitEctype				= Event_Group_Ectype + 3
EctypeEvents_SC_EctypeHotArea			= Event_Group_Ectype + 4
EctypeEvents_CS_HotAreaCallback			= Event_Group_Ectype + 5
EctypeEvents_SC_CurProcess				= Event_Group_Ectype + 6
EctypeEvents_SC_TransferDoor			= Event_Group_Ectype + 7
EctypeEvents_CS_TransferDoor			= Event_Group_Ectype + 8
EctypeEvents_SC_CurRing					= Event_Group_Ectype + 9
EctypeEvents_SC_LoadOrganEffect			= Event_Group_Ectype + 10
EctypeEvents_SC_OpenOrganEffect			= Event_Group_Ectype + 11
EctypeEvents_SC_RemoveOrganEffect		= Event_Group_Ectype + 12
EctypeEvents_SC_SceneMagic              = Event_Group_Ectype + 13
EctypeEvents_SC_AddFollowEntity         = Event_Group_Ectype + 14
EctypeEvents_SC_RemoveFollowEntity      = Event_Group_Ectype + 15
EctypeEvents_CS_RemoveObject			= Event_Group_Ectype + 16
EctypeEvents_CS_EnterPatrolFight		= Event_Group_Ectype + 17
EctypeEvents_SC_ScoreChange				= Event_Group_Ectype + 18

--定义快捷栏事�??
ShortCutKeyEvents_CS_UpdateKeyData			= Event_Group_ShortCutKey + 1
ShortCutKeyEvents_SC_UpdateDataToClient		= Event_Group_ShortCutKey + 2
ShortCutKeyEvents_CS_UpdateKeyDataForUseUp	= Event_Group_ShortCutKey + 3

--定义buff系统事件
BuffEvents_FC_RemoveBuff				= Event_Group_Buff + 1
BuffEvents_SC_LoadBuff					= Event_Group_Buff + 2
BuffEvents_SC_AddBuff					= Event_Group_Buff + 3
BuffEvents_SC_RemoveBuff				= Event_Group_Buff + 4
BuffEvents_CS_CancelBuff				= Event_Group_Buff + 5
BuffEvents_SC_UpdateBuff				= Event_Group_Buff + 6
BuffEvents_SC_FreezeBuff				= Event_Group_Buff + 7
BuffEvents_SC_CancalFreezeBuff			= Event_Group_Buff + 8
SkillEvents_CS_UseSkill					= Event_Group_Skill + 8

--定义技能系统事�??
SkillEvents_CS_LearnSkill				= Event_Group_Skill + 1
SkillEvents_SC_LearnSkill				= Event_Group_Skill + 2
SkillEvents_CS_GetMindLevel				= Event_Group_Skill + 3
SkillEvents_SC_GetMindLevel				= Event_Group_Skill + 4
SkillEvents_CS_LoadMinds				= Event_Group_Skill + 5
SkillEvents_SC_LoadMinds				= Event_Group_Skill + 6
SkillEvents_SC_LoadMindsExt				= Event_Group_Skill + 7

--定义任务系统事件
TaskEvent_CS_RecetiveTask				= Event_Group_Task + 1
TaskEvent_CS_DeleteTask					= Event_Group_Task + 2
TaskEvent_SC_RecetiveTask				= Event_Group_Task + 3
TaskEvent_SC_DeleteTask					= Event_Group_Task + 4
TaskEvent_SC_DoneTask					= Event_Group_Task + 5
TaskEvent_SC_FinishTask					= Event_Group_Task + 6
TaskEvent_SC_TaskFaild					= Event_Group_Task + 7
TaskEvent_SC_TaskReward					= Event_Group_Task + 8
TaskEvent_CS_NpcEnterSight				= Event_Group_Task + 9
TaskEvent_SC_UpdateNpcStatue			= Event_Group_Task + 10
TaskEvent_SC_AddPrivateNpc				= Event_Group_Task + 11
TaskEvent_SC_RemovePrivateNpc			= Event_Group_Task + 12
TaskEvent_SC_LoadTasksData				= Event_Group_Task + 13
TaskEvent_SC_AddTaskMine				= Event_Group_Task + 14
TaskEvent_SC_RemoveTaskMine				= Event_Group_Task + 15
TaskEvent_SC_RevertState				= Event_Group_Task + 16
TaskEvent_SC_AddTransfersData			= Event_Group_Task + 17
TaskEvent_SC_AddFollowEntity			= Event_Group_Task + 18
TaskEvent_SC_RemoveFollowEntity			= Event_Group_Task + 19
TaskEvent_SC_UpdateNormalTaskList		= Event_Group_Task + 20
TaskEvent_SC_UpdateLoopTaskList			= Event_Group_Task + 21
TaskEvent_CS_QuitSystem					= Event_Group_Task + 22
TaskEvent_SC_NpcEscape					= Event_Group_Task + 23
TaskEvent_SC_LoadTaskTrace				= Event_Group_Task + 24
TaskEvent_SC_RemoveTransfersData		= Event_Group_Task + 25
TaskEvent_SC_CreateCage					= Event_Group_Task + 26
TaskEvent_SC_RemoveCage					= Event_Group_Task + 27
TaskEvent_SC_MessageShow				= Event_Group_Task + 28
TaskEvent_SC_SetDirect					= Event_Group_Task + 29
TaskEvent_SC_AddHotDialog				= Event_Group_Task + 30
TaskEvent_SC_RemoveHotDialog			= Event_Group_Task + 31
--循环任务抽奖事件
TaskEvent_CS_RequestRandom				= Event_Group_Task + 32
TaskEvent_SC_RequestRandomReturn		= Event_Group_Task + 33
TaskEvent_CS_AddItemsToPacket			= Event_Group_Task + 34
TaskEvent_SC_AddItemsToPacketReturn		= Event_Group_Task + 35
--循环任务环数完成，自动打开抽奖界面
TaskEvent_SC_OpenRewardUI				= Event_Group_Task + 36
--打开捐献界面
TaskEvent_SC_OpenDonateUI				= Event_Group_Task + 37
TaskEvent_CS_Donate						= Event_Group_Task + 38
TaskEvent_SC_DonateReturn				= Event_Group_Task + 39

TaskEvent_SC_AddCollectGuard			= Event_Group_Task + 40
TaskEvent_SC_RemoveCollectGuard			= Event_Group_Task + 41
TaskEvent_SC_CommitEquipFail			= Event_Group_Task + 42
TaskEvent_CS_CommitEquip				= Event_Group_Task + 43
TaskEvent_SC_NotifyClientData			= Event_Group_Task + 44
TaskEvent_SC_LoadLoopTaskList			= Event_Group_Task + 45
TaskEvent_SS_AddActivityPractise		= Event_Group_Task + 46

--循环任务（送信任务上交物品�??
TaskEvent_SC_CommitItemResult			= Event_Group_Task + 47
TaskEvent_SC_CommitEquipResult			= Event_Group_Task + 48
TaskEvent_SC_ForceStopAutoMeet			= Event_Group_Task + 49
TaskEvent_SC_AddTaskItem				= Event_Group_Task + 50
TaskEvent_SC_RemoveTaskItem				= Event_Group_Task + 51
TaskEvent_SC_StartTimer					= Event_Group_Task + 52
TaskEvent_SC_OpenPaidPetUI				= Event_Group_Task + 53
TaskEvent_SC_AddTaskPet					= Event_Group_Task + 54
TaskEvent_SC_RemoveTaskPet				= Event_Group_Task + 55
TaskEvent_CS_RemoveTaskPet				= Event_Group_Task + 56
TaskEvent_SC_SetTargetsState			= Event_Group_Task + 57
TaskEvent_SC_UpdateGuideTask			= Event_Group_Task + 58
TaskEvent_SC_UpdateItemDataToClient		= Event_Group_Task + 59
TaskEvent_CS_CommitItem					= Event_Group_Task + 60
TaskEvent_SC_LoadLoopTaskInfoToClient	= Event_Group_Task + 61
TaskEvent_BS_GuideJoinFaction			= Event_Group_Task + 62
TaskEvent_SC_AddMatchNpc				= Event_Group_Task + 63
TaskEvent_CS_EnterNextLayer				= Event_Group_Task + 64
TaskEvent_SC_AddShelfPet				= Event_Group_Task + 65
TaskEvent_SC_RemoveShelfPet				= Event_Group_Task + 66
TaskEvent_CS_PuzzleFinish				= Event_Group_Task + 67
TaskEvent_SC_BeginPuzzle				= Event_Group_Task + 68
TaskEvent_CS_OpenTaskTip				= Event_Group_Task + 69


--定义交易系统事件
--p2N交易消息
TradeEvents_SC_RequestNpc				= Event_Group_Trade + 1
TradeEvents_CS_BuyGoods					= Event_Group_Trade + 2
TradeEvents_CS_CloseTrade				= Event_Group_Trade + 3
TradeEvents_CS_SellGoods				= Event_Group_Trade + 4
TradeEvents_SC_SellFinish				= Event_Group_Trade + 5
TradeEvents_CS_PayMode					= Event_Group_Trade + 6
TradeEvents_CS_BuyBack					= Event_Group_Trade + 7
TradeEvents_SC_BuyBackFinish			= Event_Group_Trade + 8

--p2p交易消息
TradeEvents_CS_P2PTradeVerifyState		= Event_Group_Trade + 15
TradeEvents_SC_P2PSendRequest			= Event_Group_Trade + 16
TradeEvents_CS_P2PAnswerRequest			= Event_Group_Trade + 17
TradeEvents_SC_RequestAnswered			= Event_Group_Trade + 18
TradeEvents_SC_P2PTradeRefuse			= Event_Group_Trade + 19
TradeEvents_CS_P2PCancelTrade			= Event_Group_Trade + 20
TradeEvents_SC_TradeCanceled			= Event_Group_Trade + 21
TradeEvents_CS_P2PTradeShowItem			= Event_Group_Trade + 22
TradeEvents_SC_P2PChangeItemReturn		= Event_Group_Trade + 23
TradeEvents_CS_P2PTradeLock				= Event_Group_Trade + 24
TradeEvents_SC_P2PTradeInfo				= Event_Group_Trade + 25
TradeEvents_CS_P2PConfirmTrade			= Event_Group_Trade + 26
TradeEvents_SC_P2PTradeConfirmed		= Event_Group_Trade + 27
TradeEvents_SC_P2PTradeFinish			= Event_Group_Trade + 28
TradeEvents_SC_P2PItemLockFlag			= Event_Group_Trade + 29
TradeEvents_CS_P2PTradePet				= Event_Group_Trade + 30
TradeEvents_SC_P2PChangePetReturn		= Event_Group_Trade + 31

TradeEvents_CS_BuyPet					= Event_Group_Trade + 32 --宠物商店购买宠物
TradeEvents_CS_P2PMessageChoose			= Event_Group_Trade +33	--处理P2P发过来的消息

--邮件消息
MailEvent_SC_MailsDelieved				= Event_Group_Mail + 1	--服务器给客户端推送邮�??
MailEvent_SC_MailsRemoved				= Event_Group_Mail + 2	--服务器发送给客户端的事件，已经删除了的邮�??
MailEvent_SC_MailItemPicked				= Event_Group_Mail + 3	--物品已经领取了的邮件 [2016�??3�??30�?? 更改了名字]

MailEvent_CS_ReadMail					= Event_Group_Mail + 4	--客户端请求读某一个邮件，在服务器将这个邮件设为已�??
MailEvent_CS_RemoveMails				= Event_Group_Mail + 5	--客户端请求删除一批邮�??
MailEvent_CS_PickMailItem				= Event_Group_Mail + 6	--客户端请求领取邮件物�??
MailEvent_CS_ReadMail					= Event_Group_Mail + 4	--客户端请求读某一个邮件，在服务器将这个邮件设为已�??
MailEvent_CS_RemoveMails				= Event_Group_Mail + 5	--客户端请求删除一批邮�??
MailEvent_CS_PickMailItem				= Event_Group_Mail + 6	--客户端请求领取邮件物�??
MailEvent_CS_RequireMoreMails			= Event_Group_Mail + 7	--客户端请求获得更多的邮件

MailEvent_SS_NewMail					= Event_Group_Mail + 8	--服务器发送新邮件给玩�??

QuitEvent_C_SystemQuit					= Event_Group_Quit + 1	--系统退出监听消�??


CactionEvent_SC_OpenUI					= Event_Group_Caction + 1
CactionEvent_SC_AutoTrace				= Event_Group_Caction + 2
CactionEvent_SC_FlyEffect				= Event_Group_Caction + 3
CactionEvent_SC_OpenUITip				= Event_Group_Caction + 4
CactionEvent_SC_AutoMeet				= Event_Group_Caction + 5
CactionEvent_SC_StopAutoMeet			= Event_Group_Caction + 6
CactionEvent_SC_PlayAnimation			= Event_Group_Caction + 7
CactionEvent_SC_OpenPuzzle				= Event_Group_Caction + 8

TaskTargetEvent_SC_LearnSkill			= Event_Group_TaskTarget + 1
TaskTargetEvent_SC_UpdateEquipTrace		= Event_Group_TaskTarget + 2

--社会服系�??
SocialEvent_BB_ExitWorld						= Event_Group_Social + 1 
SocialEvent_SB_Enter							= Event_Group_Social + 2
SocialEvent_SB_SaveData							= Event_Group_Social + 3
FriendEvent_BC_SendOfflineMsg					= Event_Group_Social + 4
FriendEvent_BC_ShowInform						= Event_Group_Social + 5
FriendEvent_CB_ShowNotifyInfo					= Event_Group_Social + 6
FriendEvent_BC_ShowNotifyInfo					= Event_Group_Social + 7
FriendEvent_BB_PlayerExist						= Event_Group_Social + 8
SocialEvent_BB_UpdatePlayerAttr					= Event_Group_Social + 9
FactionEvent_BB_UpdateWorldServerData			= Event_Group_Social + 10

FriendEvent_BC_SendFriendInfoList				= Event_Group_SocialServer_Friend + 1
FriendEvent_CB_GetFriendInfo					= Event_Group_SocialServer_Friend + 2
FriendEvent_BC_ShowFriendInfo					= Event_Group_SocialServer_Friend + 3
FriendEvent_CB_AddFriend						= Event_Group_SocialServer_Friend + 4
FriendEvent_CB_DeleteFriend						= Event_Group_SocialServer_Friend + 5
FriendEvent_BC_OnUpdateFriendOnlineState		= Event_Group_SocialServer_Friend + 6
FriendEvent_CB_ConfirmFriend					= Event_Group_SocialServer_Friend + 7
FriendEvent_BC_UpdateFriendInfoList				= Event_Group_SocialServer_Friend + 8
FriendEvent_BC_DeleteFriendInfoList				= Event_Group_SocialServer_Friend + 9
FriendEvent_BC_GetFriendInfoOnline				= Event_Group_SocialServer_Friend + 10
FriendEvent_CB_SendFriendInfoOnline				= Event_Group_SocialServer_Friend + 11
FriendEvent_CB_RefuseOfflineFriendAsk			= Event_Group_SocialServer_Friend + 12
FriendEvent_CB_GetFriendInfoInChat				= Event_Group_SocialServer_Friend + 13
FriendEvent_BC_ShowFriendInfoInChat				= Event_Group_SocialServer_Friend + 14
FriendEvent_CB_SendMsgToPlayer					= Event_Group_SocialServer_Friend + 15
FriendEvent_BC_SendMsgToPlayer					= Event_Group_SocialServer_Friend + 16
FriendEvent_CB_AddPlayerToBlcaklistInScreen		= Event_Group_SocialServer_Friend + 17
FriendEvent_CB_RemovePlayerInBlackListInScreen	= Event_Group_SocialServer_Friend + 18
FriendEvent_BC_AddPlayerToBlcaklistInScreen		= Event_Group_SocialServer_Friend + 19
FriendEvent_CB_UpdateRoleInfo					= Event_Group_SocialServer_Friend + 20
FriendEvent_CB_RunIntoFriends					= Event_Group_SocialServer_Friend + 21
FriendEvent_BC_SendRunIntoFriends				= Event_Group_SocialServer_Friend + 22
FriendEvent_CB_TeamPlayerOnline					= Event_Group_SocialServer_Friend + 23
FriendEvent_BC_ReturnTeamHandler				= Event_Group_SocialServer_Friend + 24
FriendEvent_BC_CheckEquipment					= Event_Group_SocialServer_Friend + 25
FriendEvent_SB_AddPlayerToBlcaklistInEnemy		= Event_Group_SocialServer_Friend + 26
FriendEvent_BC_AddPlayerToBlcaklistInEnemy		= Event_Group_SocialServer_Friend + 27
FriendEvent_CB_RemovePlayerInBlackListInEnemy	= Event_Group_SocialServer_Friend + 28

FriendEvent_BC_SendGroupInfoList				= Event_Group_SocialServer_Group + 1
FriendEvent_BC_CreateGroup						= Event_Group_SocialServer_Group + 2
FriendEvent_BC_AddGroupInfoToList				= Event_Group_SocialServer_Group + 3
FriendEvent_CB_ExitGroup						= Event_Group_SocialServer_Group + 4	
FriendEvent_BC_DeleteGroupInfoInList			= Event_Group_SocialServer_Group + 5
FriendEvent_CB_InviteFriend						= Event_Group_SocialServer_Group + 6
FriendEvent_CB_ConfirmGroupInvite	 			= Event_Group_SocialServer_Group + 7
FriendEvent_BC_UpdateGroupInfoInList			= Event_Group_SocialServer_Group + 8
FriendEvent_CB_ShowGroupInfo					= Event_Group_SocialServer_Group + 9
FriendEvent_BC_ShowGroupInfo					= Event_Group_SocialServer_Group + 10
FriendEvent_CB_UpdateGroupSetting				= Event_Group_SocialServer_Group + 11
FriendEvent_CB_UpdateGroupInfo					= Event_Group_SocialServer_Group + 12
FriendEvent_CB_GetGroupInfoInChat				= Event_Group_SocialServer_Group + 13
FriendEvent_BC_ShowGroupInfoInChat				= Event_Group_SocialServer_Group + 14
FriendEvent_BC_UpdateGroupMemberInChat			= Event_Group_SocialServer_Group + 15
FriendEvent_CB_SendMsgToGroup					= Event_Group_SocialServer_Group + 16
FriendEvent_BC_SendMsgToGroup					= Event_Group_SocialServer_Group + 17
FriendEvent_CB_RefuseOfflineGroupAsk			= Event_Group_SocialServer_Group + 18

FactionEvent_BC_SendFactionInfoToClient			= Event_Group_SocialServer_Faction + 1
FactionEvent_BC_MemberOffline					= Event_Group_SocialServer_Faction + 3
FactionEvent_BC_MemberOnline					= Event_Group_SocialServer_Faction + 4
FactionEvent_CB_InvitePlayerToFaction			= Event_Group_SocialServer_Faction + 5
FactionEvent_CB_UpdateFactionMemberList			= Event_Group_SocialServer_Faction + 6
FactionEvent_BC_UpdateFactionMemberList			= Event_Group_SocialServer_Faction + 7
FactionEvent_CB_UpdateFactionInfo				= Event_Group_SocialServer_Faction + 8
FactionEvent_BC_UpdateFactionInfo				= Event_Group_SocialServer_Faction + 9
FactionEvent_CB_UpdateFactionMemberInfo			= Event_Group_SocialServer_Faction + 10
FactionEvent_BC_UpdateFactionMemberInfo			= Event_Group_SocialServer_Faction + 11
FactionEvent_BB_ShowFactionList					= Event_Group_SocialServer_Faction + 12
FactionEvent_BC_ShowFactionList					= Event_Group_SocialServer_Faction + 13
FactionEvent_BC_CreateFaction					= Event_Group_SocialServer_Faction + 14
FactionEvent_CB_CreateFaction					= Event_Group_SocialServer_Faction + 15
FactionEvent_CB_LeaderDismissFaction			= Event_Group_SocialServer_Faction + 16
FactionEvent_BC_ExitFaction						= Event_Group_SocialServer_Faction + 17
FactionEvent_BB_UpdateFactionMemberInfo			= Event_Group_SocialServer_Faction + 18
FactionEvent_BB_UpdateFactionInfo				= Event_Group_SocialServer_Faction + 19
FactionEvent_BB_ExitFaction						= Event_Group_SocialServer_Faction + 20
FactionEvent_CB_ApplyFaction					= Event_Group_SocialServer_Faction + 21

FactionEvent_CB_AdmitPlayerJoin					= Event_Group_SocialServer_Faction + 22
FactionEvent_CB_RefusePlayerJoin				= Event_Group_SocialServer_Faction + 23
FactionEvent_BC_UpdateStandByPlayerList			= Event_Group_SocialServer_Faction + 24
FactionEvent_CB_FireFactionMember				= Event_Group_SocialServer_Faction + 25
FactionEvent_BB_ContributeFaction				= Event_Group_SocialServer_Faction + 26
FactionEvent_BC_ContributeFaction				= Event_Group_SocialServer_Faction + 27
FactionEvent_CB_ContributeFaction				= Event_Group_SocialServer_Faction + 28
--帮派技能相�??
FactionEvent_BC_UpdateExtendSkill				= Event_Group_SocialServer_Faction + 29
--研发帮派技�??
FactionEvent_CB_ExtendFactionSkill				= Event_Group_SocialServer_Faction + 30
FactionEvent_CB_GetSalaryFromFaction			= Event_Group_SocialServer_Faction + 31
FactionEvent_CB_FactionNotify  				 	= Event_Group_SocialServer_Faction + 32

-- 指引加入帮派

BroadCastSystem_CS_DigTreasure					= Event_Group_SocialServer_BroadCast + 1
BroadCastSystem_CS_RemakeEquip					= Event_Group_SocialServer_BroadCast + 2
BroadCastSystem_CS_UpgradeMounts				= Event_Group_SocialServer_BroadCast + 3
BroadCastSystem_CS_SummonMounts					= Event_Group_SocialServer_BroadCast + 4
BroadCastSystem_SC_DigTreasure					= Event_Group_SocialServer_BroadCast + 5
BroadCastSystem_SC_RemakeEquip					= Event_Group_SocialServer_BroadCast + 6
BroadCastSystem_SC_UpgradeMounts				= Event_Group_SocialServer_BroadCast + 7
BroadCastSystem_SC_SummonMounts					= Event_Group_SocialServer_BroadCast + 8
BroadCastSystem_SC_DekaronSchool				= Event_Group_SocialServer_BroadCast + 9

SysStemSet_SB_UpdateSystemSetData				= Event_Group_SystemSet + 1


--传送系�??
TransportEvent_SC_SendFlyFlagPositionListToClient	= Event_Group_Transportion + 1
TransportEvent_CS_UpdateFlyFlagPositionList			= Event_Group_Transportion + 2
TransportEvent_CS_UpdateFlyFlagNum					= Event_Group_Transportion + 3
TransportEvent_CS_CheckCanTransport					= Event_Group_Transportion + 4
TransportEvent_SC_TransportSucceed					= Event_Group_Transportion + 5


--新手奖励系统
NewRewardsEvent_CS_DoRewards			= Event_Group_NewRewards + 1
NewRewardsEvent_SC_LoadData				= Event_Group_NewRewards + 2
NewRewardsEvent_SC_DoRewardsReturn		= Event_Group_NewRewards + 3
NewRewardsEvent_CS_StartTimer			= Event_Group_NewRewards + 4


--宠物系统
PetEvent_SC_TestAddFollow				= Event_Group_Pet + 1
PetEvent_CS_SetFightPet					= Event_Group_Pet + 2
PetEvent_CS_ShowPet						= Event_Group_Pet + 3
PetEvent_SC_PetJoined					= Event_Group_Pet + 4	--宠物加入
PetEvent_CS_RequireFullBatch			= Event_Group_Pet + 5	--客户端请求完整的Prop批更�??
PetEvent_SC_FullBatchPushed				= Event_Group_Pet + 6	--服务器反馈完整的Prop批已经发�??
PetEvent_CS_SetStatus					= Event_Group_Pet + 7	--客户端请求改变宠物的状�?
PetEvent_SC_StatusChanged				= Event_Group_Pet + 8	--服务反馈宠物状态已经被改变
PetEvent_CS_SetAttrDistribution			= Event_Group_Pet + 9	--客户端请求设置宠物属性点
PetEvent_SC_AttrConfirmed				= Event_Group_Pet + 10	--服务器反馈宠物属性分配已经被确认
PetEvent_CS_SetName						= Event_Group_Pet + 11	--客户端请求设置宠物名�??
PetEvent_SC_NameConfirmed				= Event_Group_Pet + 12	--服务器反馈宠物名称已经被确认
PetEvent_CS_DeletePet					= Event_Group_Pet + 13	--客户端请求遣散宠�??
PetEvent_SC_PetLeaved					= Event_Group_Pet + 14	--服务器反馈宠物已经遣�??
PetEvent_CS_PromotePet                  = Event_Group_Pet + 15  --宠物进阶
PetEvent_SC_PetPromoted		            = Event_Group_Pet + 16	--宠物进阶反馈
PetEvent_CS_RepairPet					= Event_Group_Pet + 17	--宠物修复
PetEvent_SC_ConfirmPetRepair			= Event_Group_Pet + 18	--宠物修复反馈
PetEvent_CS_EnchancePet					= Event_Group_Pet + 19  --宠物强化
PetEvent_SC_PetEnchanced		        = Event_Group_Pet + 20  --宠物强化返回
PetEvent_CS_RebirthPet					= Event_Group_Pet + 21  --宠物还童
PetEvent_SC_PetRebirthed				= Event_Group_Pet + 22  --宠物还童返回
PetEvent_CS_SetPhaseDistribution		= Event_Group_Pet + 23	--客户端请求设置宠物相性点
PetEvent_SC_PhaseConfirmed				= Event_Group_Pet + 24	--相性点已经确认
PetEvent_SC_PetDeadPunish				= Event_Group_Pet + 25	--宠物死亡惩罚
PetEvent_CS_CombinePets					= Event_Group_Pet + 26	--客户端请求合成宠�??
PetEvent_SC_PetsCombined				= Event_Group_Pet + 27	--服务器反馈宠物已经合�??

PetEvent_SC_SkillsArrived				= Event_Group_Pet + 28	--宠物技能到�??
PetEvent_SC_SkillForgotten				= Event_Group_Pet + 29	--遗忘了的宠物技�??
PetEvent_SC_SkillBookRead				= Event_Group_Pet + 30	--技能书使用结果
PetEvent_CS_ReadSkillBook				= Event_Group_Pet + 31	--宠物使用技能书
PetEvent_SC_SkillChanged				= Event_Group_Pet + 32	--宠物技能等级改�??

PetEvent_CS_ExpandPetBar				= Event_Group_Pet + 33	--请求拓展宠物�??
PetEvent_SC_PetBarConfirmed				= Event_Group_Pet + 34	--宠物栏数量到�??

PetEvent_SC_OnSaleArrived				= Event_Group_Pet + 35	--交易宠物信息已经到达

PetEvent_CS_LearnExtendSkill			= Event_Group_Pet + 36	--宠物学习研发技�??
PetEvent_SC_ConfirmExtendLearn			= Event_Group_Pet + 37	--请求客户端确认学习研发技�?
PetEvent_CS_ConfirmExtendLearn			= Event_Group_Pet + 38	--客户端已确认学习研发技�?
--[[
	¤╭⌒�?? ╭⌒�??	{ Keep Distance }	
	╱◥██�?? ╭╭ ⌒╮
	|田︱田田| �??--------------
	╬╬╬╬�?? ╬╬╬╬╬╬╬╬
]]


--历练系统
Experience_SC_SendLevel					= Event_Group_Experience + 1
Experience_CS_Learn						= Event_Group_Experience + 2
Experience_SC_Learn						= Event_Group_Experience + 3


--坐骑系统
RideEvent_SC_LoadRide					= Event_Group_Ride + 1 --玩家上线，加载坐�??
RideEvent_SC_AddRide					= Event_Group_Ride + 2
RideEvent_CS_UpOrDownRide				= Event_Group_Ride + 3	--上坐�??
RideEvent_CS_GrowUp						= Event_Group_Ride + 4	--骑宠进阶
RideEvent_SC_GrowUp						= Event_Group_Ride + 5
RideEvent_CS_RideToItem					= Event_Group_Ride + 6	--坐骑回笼
RideEvent_SC_RideToItem					= Event_Group_Ride + 7
RideEvent_CS_ExpandRideBar				= Event_Group_Ride + 8	--扩充坐骑�??
RideEvent_SC_ExpandRideBar				= Event_Group_Ride + 9
RideEvent_SC_AddRideVigor				= Event_Group_Ride + 10 --增加坐骑体力�??

--在线奖励系统事件集合
OnlineRewardEvent_CS_RequestRandom      = Event_Group_OnlineReward + 1
OnlineRewardEvent_SC_RandomResponse     = Event_Group_OnlineReward + 2
OnlineRewardEvent_CS_AddItemsToPacket   = Event_Group_OnlineReward + 3
OnlineRewardEvent_CS_SendNotice         = Event_Group_OnlineReward + 4
OnlineRewardEvent_SC_GetNotice          = Event_Group_OnlineReward + 5
OnlineRewardEvent_CS_AddLotteryNumber   = Event_Group_OnlineReward + 6
OnlineRewardEvent_SC_Addtimes           = Event_Group_OnlineReward + 7
OnlineRewardEvent_SC_LoadDate           = Event_Group_OnlineReward + 8
OnlineRewardEvent_CS_SaveRewardMaterial = Event_Group_OnlineReward + 9

-- pk系统事件集合
PK_CS_Invite							= Event_Group_PK + 1
PK_SC_Request							= Event_Group_PK + 2
PK_CS_Cancel							= Event_Group_PK + 3
PK_CS_Accept							= Event_Group_PK + 4

-- 装备玩法
EquipPlayingEvent_CS_EquipMake_Request           = Event_Group_EquipPlaying + 1
EquipPlayingEvent_SC_EquipMake_Result            = Event_Group_EquipPlaying + 2
EquipPlayingEvent_CS_AttrReset_Request           = Event_Group_EquipPlaying + 3
EquipPlayingEvent_SC_AttrReset_Result            = Event_Group_EquipPlaying + 4
EquipPlayingEvent_CS_AttrImprove_Request         = Event_Group_EquipPlaying + 5
EquipPlayingEvent_SC_AttrImprove_Result          = Event_Group_EquipPlaying + 6
EquipPlayingEvent_CS_EquipRemould_Request        = Event_Group_EquipPlaying + 7
EquipPlayingEvent_SC_EquipRemould_Result         = Event_Group_EquipPlaying + 8
EquipPlayingEvent_CS_EquipRefining_Request       = Event_Group_EquipPlaying + 9
EquipPlayingEvent_SC_EquipRefining_Result        = Event_Group_EquipPlaying + 10
EquipPlayingEvent_CS_AdornMake_Request           = Event_Group_EquipPlaying + 11
EquipPlayingEvent_SC_AdornMake_Result            = Event_Group_EquipPlaying + 12
EquipPlayingEvent_CS_AdornSynthetict_Request     = Event_Group_EquipPlaying + 13
EquipPlayingEvent_SC_AdornSynthetict_Result      = Event_Group_EquipPlaying + 14
EquipPlayingEvent_CS_ViewEquips_Request			 = Event_Group_EquipPlaying + 15 --查看玩家装备信息
EquipPlayingEvent_SC_ViewEquips_Request			 = Event_Group_EquipPlaying + 16 --查看玩家装备信息
EquipPlayingEvent_CS_EquipAnalyse_Request		 = Event_Group_EquipPlaying + 17 --拆解玩家装备
EquipPlayingEvent_SC_EquipAnalyse_Result		 = Event_Group_EquipPlaying + 18 --拆解玩家装备




--剧情动画

Drama_CS_Start			= Event_Group_Drama + 1
Drama_SC_Start			= Event_Group_Drama + 2
Drama_CS_Stop			= Event_Group_Drama + 3
Drama_SC_Stop			= Event_Group_Drama + 4

--采集系统
GoodsEvents_CS_RemoveGoods						= Event_Group_Collecting + 1
GoodsEvents_SC_GetRewards                       = Event_Group_Collecting + 2
GoodsEvents_SC_NoticeMSG                        = Event_Group_Collecting + 3
GoodsEvents_SC_ColnoticeMSG                     = Event_Group_Collecting + 4
GoodsEvents_SC_HighLevelMSG                     = Event_Group_Collecting + 5
GoodsEvents_SC_LowLevelMSG                      = Event_Group_Collecting + 6
GoodsEvents_SC_LackGridsMSG                     = Event_Group_Collecting + 7
GoodsEvents_SC_GetNumRewards                    = Event_Group_Collecting + 8
GoodsEvents_CS_CollectState 					= Event_Group_Collecting + 9
GoodsEvents_SS_ItemRemoved 						= Event_Group_Collecting + 10

--新手礼包系统
NewcomerGifsEvent_CS_doRequestItemData		= event_Group_NewcomerGifts + 1
NewcomerGifsEvent_SC_doGetGiftsData			= event_Group_NewcomerGifts + 2

--自动加点事件
AutoPointEvent_SC_DistributionComfirmed			= Event_Group_AutoPoint + 1	--加点方案已经确认
AutoPointEvent_SC_OrderComfirmed				= Event_Group_AutoPoint + 2	--相性分配顺序已经确�??
AutoPointEvent_CS_ModifyDistribution			= Event_Group_AutoPoint + 3	--请求更改加点方案
AutoPointEvent_CS_ModifyOrder					= Event_Group_AutoPoint + 4	--请求更改相性分配顺�??

--生活技能系�??
LifeSkillEvent_CS_product                       = Event_Group_LifeSkill + 1
LifeSkillEvent_SC_productFailInfo               = Event_Group_LifeSkill + 2
LifeSkillEvent_SC_updateInfo                    = Event_Group_LifeSkill + 3
LifeSkillEvent_SC_vigorLackNotice               = Event_Group_LifeSkill + 4
LifeSkillEvent_CS_sendProductLevelInfo          = Event_Group_LifeSkill + 5
LifeSkillEvent_SC_randedOutputRecipe            = Event_Group_LifeSkill + 6
LifeSkillEvent_CS_productRandRecipe             = Event_Group_LifeSkill + 7
LifeSkillEvent_SC_gainedRecipeNotice            = Event_Group_LifeSkill + 8
LifeSkillEvent_SC_returnMoneyNotice             = Event_Group_LifeSkill + 9
LifeSkillEvent_CS_learnSkill                    = Event_Group_LifeSkill + 10
LifeSkillEvent_SC_upLevelInfo                   = Event_Group_LifeSkill + 11
LifeSkillEvent_SC_SendLevel                     = Event_Group_LifeSkill + 12
LifeSkillEvent_SC_updateEscpeInfo               = Event_Group_LifeSkill + 13
LifeSkillEvent_SC_updateCatchInfo               = Event_Group_LifeSkill + 14
LifeSkillEvent_SC_upLevelAndFreshInfo           = Event_Group_LifeSkill + 15
LifeSkillEvent_CS_costMoneyLearnSkill           = Event_Group_LifeSkill + 16 
LifeSkillEvent_SC_upLevelNotice                 = Event_Group_LifeSkill + 17
LifeSkillEvent_CS_onRefine						= Event_Group_LifeSkill + 18
LifeSkillEvent_SC_refineSuccessNotice           = Event_Group_LifeSkill + 19
LifeSkillEvent_SC_refineFailedNotice            = Event_Group_LifeSkill + 20

-- 保存系统功能数据
RoleConfigureEvent_CS_DoSaveFun					= Event_Group_RoleConfigure + 1
RoleConfigureEvent_SC_getSaveFun				= Event_Group_RoleConfigure + 2
--
ActivityEvent_CS_updateBox						= Event_Group_Activity + 1

ActivityEvent_SC_updateBox						= Event_Group_Activity + 2
ActivityEvent_SC_GoldHunt_informScore			= Event_Group_Activity + 3
ActivityEvent_SB_GoldHunt_Rank					= Event_Group_Activity + 4
ActivityEvent_BS_GoldHunt_RankResults			= Event_Group_Activity + 5
ActivityEvent_SC_GoldHunt_enter					= Event_Group_Activity + 6
ActivityEvent_SC_GoldHunt_leave					= Event_Group_Activity + 7
ActivityEvent_SC_GoldHunt_end					= Event_Group_Activity + 8
ActivityEvent_SC_GoldHunt_newPhase_begin		= Event_Group_Activity + 9
ActivityEvent_SC_GoldHunt_CurRank				= Event_Group_Activity + 10
ActivityEvent_CS_GoldHunt_leave					= Event_Group_Activity + 11

--
ActivityEvent_CS_EnterPatrolFight				= Event_Group_Activity + 20
-- 活动页面
ActivityEvent_SC_ActivityPageActivity			= Event_Group_Activity + 21
ActivityEvent_SC_ActivityPageDaliy				= Event_Group_Activity + 22
ActivityEvent_SC_ActivityPageOther				= Event_Group_Activity + 23
ActivityEvent_SC_notifyActivityPageUpdateBtn	= Event_Group_Activity + 24

ActivityEvent_SC_EnterDiscussHero				= Event_Group_Activity + 25
ActivityEvent_SC_UpdateDiscussHero				= Event_Group_Activity + 26
ActivityEvent_CS_ExitDiscussHero				= Event_Group_Activity + 27
ActivityEvent_CS_EnterDiscussHeroPVP			= Event_Group_Activity + 28
ActivityEvent_SC_EnterDiscussHeroFight			= Event_Group_Activity + 29
ActivityEvent_SC_ExitDicussHero					= Event_Group_Activity + 30

--宠物仓库消息
PetDepotEvent_CS_ExpandPetDepot					= Event_Group_PetDepot + 1
PetDepotEvent_SC_ExpandPetDepotReturn			= Event_Group_PetDepot + 2
PetDepotEvent_SC_SendDataToClient				= Event_Group_PetDepot + 3
PetDepotEvent_CS_PutInPet						= Event_Group_PetDepot + 4
PetDepotEvent_SC_PutInPetReturn					= Event_Group_PetDepot + 5
PetDepotEvent_CS_TakeOutPet						= Event_Group_PetDepot + 6
PetDepotEvent_SC_TakeOutPetReturn				= Event_Group_PetDepot + 7

-- 宝藏客户端消�??
TreasureEvent_SC_GotoTreasure	     			= Event_Group_Treasure + 1
TreasureEvent_SC_MapIDInfo						= Event_Group_Treasure + 2
TreasureEvent_CS_SendPositionInfo               = Event_Group_Treasure + 3

PractiseEvent_CS_updateBox						= Event_Group_Practise + 1
PractiseEvent_SC_updateBox						= Event_Group_Practise + 2
PractiseEvent_CS_updatePractise					= Event_Group_Practise + 3
PractiseEvent_SC_addPractise					= Event_Group_Practise + 4


DekaronSchool_SC_AddActvityTarget				= Event_Group_DekaronSchool + 1
DekaronSchool_SC_GiveUpActvityTarget			= Event_Group_DekaronSchool + 2
DekaronSchool_CS_updatePractise					= Event_Group_DekaronSchool + 3
DekaronSchool_SC_addPractise					= Event_Group_DekaronSchool + 4

--兑换物品
ExchangeItemEvent_CS_doExchange                 = Event_Group_ExchangeItem + 1
ExchangeItemEvent_SC_doExchangeReturn			= Event_Group_ExchangeItem + 2
ExchangeItemEvent_SC_RewardItemMsg				= Event_Group_ExchangeItem + 3
ExchangeItemEvent_SC_UpdateData					= Event_Group_ExchangeItem + 4
ExchangeItemEvent_SC_ResetData					= Event_Group_ExchangeItem + 5

DoubleRewardEvent_SC_ActvityOpened				= Event_Group_DoubleReward + 1

--摆摊消息
StallEvent_CS_OnOpenStall                       = Event_Group_Stall	+ 1
StallEvent_CS_SendStallName						= Event_Group_Stall + 2 
StallEvent_SC_SendNewStallName                  = Event_Group_Stall + 3
StallEvent_SC_SendStallID                       = Event_Group_Stall + 4
StallEvent_CS_CloseStall                        = Event_Group_Stall + 5
StallEvent_SC_SendStallStateID                  = Event_Group_Stall + 6
StallEvent_CS_SendBuyStallTime                  = Event_Group_Stall + 7