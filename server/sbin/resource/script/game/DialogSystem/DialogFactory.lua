--[[DialogFactory.lua
描述：
	对话工厂(对话系统)
--]]

DialogFactory = class(Singleton)

function DialogFactory:__init()

end

--创建一个对话对象
function DialogFactory:createDialogObject(player, dialogID, check)
	local dialogData = DialogModelDB[dialogID]
	if not dialogData then
		print("对话ID出错,ID为",dialogID)
		return
	end

	if dialogData.dialogType > 3 then
		print("对话ID类型出错,ID为",dialogID)
		return
	end
	if not check then
		local result, errorID = g_dialogCondtion:checkDialogID(player, dialogID)
		if not result then
			if errorID and errorID > 0 then
				g_dialogFty:createErrorDialogObject(player, errorID)
				g_dialogDoer:openErrorDialog(player, errorID)
			end
			print("对话不满足条件",dialogID)
			return 
		end
	end
	local playerID = player:getID()
	g_dialogMgr:removeDialog(playerID)
	local dialog = Dialog()
	dialog:setBeginTime(0)
	if dialogData.dialogType == DialogType.FunctionOption then
		if dialogData.funtionName then
			local dialogInfo = FunctionDialog[dialogData.funtionName](player)
			dialog:setID(dialogID)
			dialog:setTxt(dialogInfo.txt)
			dialog:setOptions(dialogInfo.options)
			dialog:setDialogType(dialogInfo.dialogType)
		else
			print("特殊对话对应函数执行失败",dialogData.funtionName, dialogID)
			return
		end
	else
		dialog:setID(dialogID)
		dialog:setOptions(dialogData.options)
		dialog:setDialogType(dialogData.dialogType)
	end

	g_dialogMgr:addDialog(playerID, dialog)
	return dialog
end

--创建一个条件没满足的对话对象
function DialogFactory:createErrorDialogObject(player, errorID)
	local dialog = Dialog()
	dialog:setBeginTime(0)
	g_dialogMgr:addDialog(player:getID(), dialog)
end

function DialogFactory.getInstance()
	return DialogFactory()
end

g_dialogFty = DialogFactory.getInstance()