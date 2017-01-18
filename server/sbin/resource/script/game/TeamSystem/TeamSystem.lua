--[[TeamSystem.lua
描述：
	玩家组队系统
--]]

require "game.TeamSystem.TeamManager"
require "game.TeamSystem.Team"

TeamSystem = class(EventSetDoer, Singleton)

function TeamSystem:__init()
	self._doer = {
		[TeamEvents_CS_CreateTeam]				= TeamSystem.onCreateTeam,
		[TeamEvents_CS_DissolveTeam]			= TeamSystem.onDissolveTeam,
		[TeamEvents_CS_InviteJoinTeam]			= TeamSystem.onInviteJoinTeam,
		[TeamEvents_CS_AnswerInvite]			= TeamSystem.onAnswerInvite,
		[TeamEvents_CS_RequestJoinTeam]			= TeamSystem.onRequestJoinTeam,
		[TeamEvents_CS_AnswerRequest]			= TeamSystem.onAnswerRequest,
		[TeamEvents_CS_StepOutTeam]				= TeamSystem.onStepOutTeam,
		[TeamEvents_CS_ComeBackTeam]			= TeamSystem.onComeBackTeam,
		[TeamEvents_CS_ChangeLeader]			= TeamSystem.onChangeLeader,
		[TeamEvents_CS_MoveOutMember]			= TeamSystem.onMoveOutMember,
		[TeamEvents_CS_QuitTeam]				= TeamSystem.onQuitTeam,
		[TeamEvents_CS_UpdateQueueCount]		= TeamSystem.onUpdateQueueCount,
		[TeamEvents_CS_SearchTeamList]			= TeamSystem.onSearchTeamList,
		[TeamEvents_CS_AutoTeam]				= TeamSystem.onAutoTeam,
		[TeamEvents_CS_CancelAutoTeam]			= TeamSystem.onCancelAutoTeam,
		[TeamEvents_CS_LeaderAutoTeam]			= TeamSystem.onLeaderAutoTeam,
		[TeamEvents_CS_LeaderCancelAutoTeam]	= TeamSystem.onLeaderCancelAutoTeam,
		[FriendEvent_CB_TeamPlayerOnline]		= TeamSystem.teamPlayerOnline,
		[TeamEvents_CS_ApplyForLeader]			= TeamSystem.applyForLeader,
		[TeamEvents_CS_RefuseApply]				= TeamSystem.refuseApply,
	}
end

--创建队伍
function TeamSystem:onCreateTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:createTeam(playerID)
end

--解散队伍
function TeamSystem:onDissolveTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:dissolveTeam(playerID)
end

--邀请玩家加入队伍
function TeamSystem:onInviteJoinTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	local targetID = params[2]
	g_teamMgr:inviteJoinTeam(playerID,targetID)
end

--回答邀请
function TeamSystem:onAnswerInvite(event)
	local params = event:getParams()
	local playerID = params[1]
	local leaderID = params[2]
	local isAccept = params[3]
	g_teamMgr:answerInvite(playerID,leaderID,isAccept)
end

--玩家申请加入队伍
function TeamSystem:onRequestJoinTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	local targetID = params[2]
	g_teamMgr:requestJoinTeam(playerID,targetID)
end

--回答申请
function TeamSystem:onAnswerRequest(event)
	local params = event:getParams()
	local leaderID = params[1]
	local targetID = params[2]
	local isAccept = params[3]
	g_teamMgr:answerRequest(leaderID,targetID,isAccept)
end

--玩家退出队伍
function TeamSystem:onQuitTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:quitTeam(playerID)
end

--玩家暂离队伍
function TeamSystem:onStepOutTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:stepOutTeam(playerID)
end

--玩家归队
function TeamSystem:onComeBackTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:comeBackTeam(playerID)
end

--更换队长
function TeamSystem:onChangeLeader(event)
	local params = event:getParams()
	local leaderID = params[1]
	local playerID = params[2]
	g_teamMgr:changeLeader(leaderID,playerID)
end

--移出队伍
function TeamSystem:onMoveOutMember(event)
	local params = event:getParams()
	local leaderID = params[1]
	local playerID = params[2]
	g_teamMgr:moveOutMember(leaderID,playerID)
end

--获取排队人数
function TeamSystem:onUpdateQueueCount(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:updateQueueCount(playerID)
end

--非组队玩家去查找相应队伍
function TeamSystem:onSearchTeamList(event)
	local params = event:getParams()
	local playerID = params[1]
	local minLevel = params[2]
	local maxLevel = params[3]
	local actionTable = params[4]
	g_teamMgr:searchTeamList(playerID,minLevel,maxLevel,actionTable)
end

--非队伍玩家自动组队
function TeamSystem:onAutoTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	local minLevel = params[2]
	local maxLevel = params[3]
	local actionTable = params[4]
	if playerID and minLevel and maxLevel then
		g_teamMgr:autoTeam(playerID,minLevel,maxLevel,actionTable)
	end
end

--非队伍玩家取消自动组队
function TeamSystem:onCancelAutoTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:cancelAutoTeam(playerID)
end

--队长自动组队
function TeamSystem:onLeaderAutoTeam(event)
	local params = event:getParams()
	local leaderID = params[1]
	local minLevel = params[2]
	local maxLevel = params[3]
	local actionID = params[4]
	if leaderID and minLevel and maxLevel then
		g_teamMgr:leaderAutoTeam(leaderID,minLevel,maxLevel,actionID)
	end
end

--队长取消自动组队
function TeamSystem:onLeaderCancelAutoTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	g_teamMgr:leaderCancelAutoTeam(playerID)
end


--组队按钮
function TeamSystem:teamPlayerOnline( event )
	
	local params = event:getParams()
	local roleDBID = params[1]
	local playerDBID = params[2]
	local role = g_entityMgr:getPlayerByDBID(roleDBID)
	if roleDBID == playerDBID then
		local msg = "无法和自己组队"
        local notifyParams = {msg = msg}
		local event_ErrorNotify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.NormalNotify,notifyParams)
		g_eventMgr:fireRemoteEvent(event_ErrorNotify,role)
	else
		local player = g_entityMgr:getPlayerByDBID(playerDBID)
		if not player then
			local event2 = Event.getEvent(TeamEvents_SC_targetOfflineNotify)
			g_eventMgr:fireRemoteEvent(event2,role)
		else
			local playerID = player:getID()
			local playerHandler = player:getHandler(HandlerDef_Team)
			if playerHandler then
				playerHandler = 1
			else
				playerHandler = 0
			end
			local event2 = Event.getEvent(FriendEvent_BC_ReturnTeamHandler,playerID,playerHandler)
			g_eventMgr:fireRemoteEvent(event2,role)
		end
	end
end

--收到别的玩家申请队长的请求
function TeamSystem:applyForLeader(event)
	local params = event:getParams()
	local playerID = params[1]
	local leaderID = params[2]
	local leader = g_entityMgr:getPlayerByID(leaderID)
	local event = Event.getEvent(TeamEvents_SC_CreateConfirmWin,playerID)
	g_eventMgr:fireRemoteEvent(event,leader)
end

--收到拒绝信息，提示给申请人
function TeamSystem:refuseApply(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 3)
	g_eventMgr:fireRemoteEvent(event,player)
end

function TeamSystem.getInstance()
	return TeamSystem()
end

EventManager.getInstance():addEventListener(TeamSystem.getInstance())