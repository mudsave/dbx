--[[DialogSystem.lua
描述：
	对话系统(对话系统)
--]]
require "game.DialogSystem.Dialog"
require "game.DialogSystem.FunctionDialog"
require "game.DialogSystem.DialogConditionConfig"
require "game.DialogSystem.DialogAction"
require "game.DialogSystem.DialogActionConfig"
require "game.DialogSystem.DialogCondition"
require "game.DialogSystem.DialogManager"
require "game.DialogSystem.DialogDoer"
require "game.DialogSystem.DialogFactory"


DialogSystem = class(EventSetDoer, Singleton)

function DialogSystem:__init()
	self._doer = 
	{
		[DialogEvents_CS_OpenDialog]			= DialogSystem.onOpenDialog,
		[DialogEvents_CS_OpenDialogByID]		= DialogSystem.onOpenDialogByID,
		[DialogEvents_CS_NextDialog]			= DialogSystem.onNextAction,
		[DialogEvents_CS_CloseDialog]			= DialogSystem.onCloseDialog,
		[DialogEvents_CS_CloseDialogByID]		= DialogSystem.onCloseDialogByID,
	}
end

--点击npc开始对话
function DialogSystem:onOpenDialog(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local npcID = params[1]
	if not player then
		-- print("shu test not this player ")
		return 
	end
	local npc = g_entityMgr:getNpc(npcID)
	if not npc then
		-- print("shu test not this npc ")
		return 
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 and not teamHandler:isStepOutState() then		
		for _, member in pairs(teamHandler:getTeamPlayerList()) do
			g_dialogDoer:createNpcDialog(member, npc) --创建一个npc对话
		end
	else
		g_dialogDoer:createNpcDialog(player, npc) --创建一个npc对话
	end
end

function DialogSystem:onOpenDialogByID(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local optionID = params[2]
	
	if not player then
		return 
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		local team = g_teamMgr:getTeam(teamID)
		local teamMemberList = team:getMemberList()
		for i = 1, table.getn(teamMemberList) do			
			if teamMemberList[i].memberState ~= MemberState.StepOut then
				local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
				g_dialogDoer:createDialogByID(teamMember, optionID) --创建一个npc对话
			end
		end
	else
		g_dialogDoer:createDialogByID(player, optionID) --创建一个npc对话
	end
	
end

function DialogSystem:onCloseDialogByID(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local dialogID = params[2]
	if not player then
		return 
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		local team = g_teamMgr:getTeam(teamID)
		local teamMemberList = team:getMemberList()
		for i = 1, table.getn(teamMemberList) do
			local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
			-- 关闭对话
			g_dialogMgr:removeDialog(teamMember:getID())
			g_dialogSym:closeDialog(teamMember)
		end
	else
		g_dialogMgr:removeDialog(player:getID())
		g_dialogSym:closeDialog(player)
	end
end

--点击选项执行下一个行为
function DialogSystem:onNextAction(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local optionID = params[2]
	local npcID = params[3]
	print("optionID,npcID",optionID,npcID)
	if not player then
		return 
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		if not teamHandler:isStepOutState() and team:getLeaderID() ~= player:getID() then
			return
		end
	end
	g_dialogDoer:doNextAction(player, optionID, npcID)	--执行功能
end

--客户端主动请求关闭对话
function DialogSystem:onCloseDialog(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		local team = g_teamMgr:getTeam(teamID)
		local teamMemberList = team:getMemberList()
		for i = 1, table.getn(teamMemberList) do			
			if teamMemberList[i].memberState ~= MemberState.StepOut then
				local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
				g_dialogDoer:doCloseDialog(teamMember:getID())
				if teamMemberList[i].memberID ~= player:getID() then
					self:closeDialog(teamMember)
				end
			end
		end
	else
		g_dialogDoer:doCloseDialog(event.playerID)
	end
	
end

--打开函数对话框
function DialogSystem:openFunDialog(player, data)
	local event = Event.getEvent(DialogEvents_SC_OpenFunDialog, player:getID(), data)
	g_eventMgr:fireRemoteEvent(event, player)
end

--打开一般对话框
function DialogSystem:openDialog(player, data ,npcID)
	local event = Event.getEvent(DialogEvents_SC_OpenDialog, player:getID(), data, npcID)
	g_eventMgr:fireRemoteEvent(event, player)
end

--打开不满足条件的错误对话
function DialogSystem:openErrorDialog(player, errorID)
	local event = Event.getEvent(DialogEvents_SC_OpenErrorDialog, player:getID(), errorID)
	g_eventMgr:fireRemoteEvent(event, player)
end

--服务器主动关闭对话框
function DialogSystem:closeDialog(player)
	local event = Event.getEvent(DialogEvents_SC_CloseDialog, player:getID())
	g_eventMgr:fireRemoteEvent(event, player)
end

function DialogSystem:onUpdateWorldServerData( event )

	--更新世界服中些许包括社会服的数据

end

function DialogSystem.getInstance()
	return DialogSystem()
end

g_eventMgr:addEventListener(DialogSystem.getInstance())

