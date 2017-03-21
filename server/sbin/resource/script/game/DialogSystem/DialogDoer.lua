--[[DialogDoer.lua
描述：
	对话系统(对话系统)
--]]

DialogDoer = class(Singleton)

function DialogDoer:__init()

end

--创建一个和npc有关的对话框
function DialogDoer:createNpcDialog(player, npc)

	local handler = npc:getHandler(HandlerDef_Dialog)
	if not handler then 
		return 
	end
	local npcID = npc:getID()
	local dialogID = self:checkTaskDialog(player, npcID) --先检测任务ID，是不是任务对话
	if not dialogID then
		local dialogIDs = handler:getDialogIDs()							--获取npc身上的对话
		dialogID = g_dialogCondtion:choseDialogID(player, dialogIDs, npcID)	--检测条件选出对话id
		if not dialogID then
			print("配置出错，对话ID为空")
			return
		end
	end
	g_dialogDoer:createDialogByID(player, dialogID, true, npcID) --创建对话

end

--检测任务对话,普通任务和日常任务由任务配置表决定，然后进行判断显示哪个
function DialogDoer:checkTaskDialog(player, npcID)

	local dialogID
	local taskHandler = player:getHandler(HandlerDef_Task)
	local providerTaskID, taskTypeA = taskHandler:checkTaskProvider(npcID)
	local RecetiveTaskID, taskTypeB = taskHandler:checkTaskRecetiver(npcID)
	if RecetiveTaskID then
		if taskTypeB == TaskType.normal then
			dialogID = NormalTaskDB[RecetiveTaskID].endDialogID
			if type(dialogID) == "table" then
				dialogID = g_dialogCondtion:choseDialogID(player, dialogID)
			end
		elseif taskTypeB == TaskType.loop then
			local loopTask = taskHandler:getTask(RecetiveTaskID)
			dialogID = loopTask:getEndDialogID()
		elseif taskTypeB == TaskType.daily then
			dialogID = DailyTaskDB[RecetiveTaskID].endDialogID
			if type(dialogID) == "table" then
				dialogID = g_dialogCondtion:choseDialogID(player, dialogID)
			end
		end
	elseif providerTaskID then
		if taskTypeA == TaskType.normal then
			dialogID = NormalTaskDB[providerTaskID].startDialogID
			if type(dialogID) == "table" then
				dialogID = g_dialogCondtion:choseDialogID(player, dialogID)
			end
		elseif taskTypeA == TaskType.loop then
			dialogID = LoopTaskDB[providerTaskID].startDialogID
		elseif taskTypeA == TaskType.daily then

			dialogID = DailyTaskDB[providerTaskID].startDialogID
			if type(dialogID) == "table" then
				dialogID = g_dialogCondtion:choseDialogID(player, dialogID)
			end
			
		end
	end

	return dialogID
end

--通过对话id直接创建对话
function DialogDoer:createDialogByID(player, optionID, check, npcID)
	local dialog = g_dialogFty:createDialogObject(player, optionID, check,npcID)
	--创建一个对话对象
	if dialog then
		self:openDialog(player, dialog, npcID)										--打开对话框
	end
end

--点击选项或无选择对话框
function DialogDoer:doNextAction(player, optionID, npcID)
	local dialog = g_dialogMgr:getDialog(player:getID())
	if not dialog then return end
	local dialogID = dialog:getID()
	local closeDialog = true
	local option = dialog:getOptionByID(optionID)	
	if option then
		local actions = option.actions
		for _, data in pairs(actions) do
			local method = DialogActionConfig[data.action]
			if method then
				method(g_dialogAction, player, data.param, npcID)
				if data.action == DialogActionType.Goto 
				or data.action == DialogActionType.Gotos
				or data.action == DialogActionType.RingEctype then
					closeDialog = false
				end
			end
		end
	end
	-- 如果在对话功能中有创建呢新的对话，和之前的对话ID不相同的话
	local newDialog = g_dialogMgr:getDialog(player:getID())
	if closeDialog and (not newDialog or newDialog:getID() == dialogID) then
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		if teamID > 0 then
			local team = g_teamMgr:getTeam(teamID)
			local teamMemberList = team:getMemberList()
			for i = 1, table.getn(teamMemberList) do
				local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
				g_dialogMgr:removeDialog(teamMember:getID())
				g_dialogSym:closeDialog(teamMember)
			end
		else
			g_dialogMgr:removeDialog(player:getID())
			g_dialogSym:closeDialog(player)
		end
	end
	return true
end

--打开一个对话
function DialogDoer:openDialog(player, dialog ,npcID)
	local data = {}
	if not dialog then
	end
	local dialogType = dialog:getDialogType()
	if not dialogType then
		return
	end
	if dialogType == DialogType.FunctionOption then
		data.dialogID = dialog:getID()
		data.options = dialog:getOptions()
		data.txt = dialog:getTxt()
		g_dialogSym:openFunDialog(player, data)
	else
		data.dialogID = dialog:getID()
		data.optionIDs = {}	
		if dialogType == DialogType.HasOption then
			for optionID, optionInfo in ipairs(dialog:getOptions()) do
				if g_dialogCondtion:choseOption(player, optionInfo.showConditions) then
					table.insert(data.optionIDs, optionID)
				end
			end
		end
		g_dialogSym:openDialog(player, data, npcID)
	end
end

--打开错误对话
function DialogDoer:openErrorDialog(player, errorID)
	g_dialogSym:openErrorDialog(player, errorID)
end

--关闭对话框移除对象
function DialogDoer:doCloseDialog(playerID)
	g_dialogMgr:removeDialog(playerID)
end

function DialogDoer.getInstance()
	return DialogDoer()
end
