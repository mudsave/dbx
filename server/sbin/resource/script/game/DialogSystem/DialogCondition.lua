--[[DialogCondition.lua
描述：
	对话系统条件(对话系统)
--]]

DialogCondition = class(Singleton)

function DialogCondition:__init()

end

--检测多个对话ID哪个满足条件
function DialogCondition:choseDialogID(player, dialogIDs, npcID)

	for _, dialogID in pairs(dialogIDs) do

		local choseFinish = true
		local conditions = DialogModelDB[dialogID].conditions 
		for _, data in pairs(conditions) do
			local method = DialogConditionDoer[data.condition]
			local instence = DialogConditionInstance[data.condition]
			local result, errorID = method(instence, player, data.param, npcID)
			if not result then
				if  errorID and errorID > 0 then
					choseFinish = false
					break
				else
					choseFinish = false
					break
				end
			end
		end
		if choseFinish then
			return dialogID
		end
	end

end

-- 选择选项条件
function DialogCondition:choseOption(player, showConditions)

	for _, data in pairs(showConditions) do
		local method = DialogConditionDoer[data.condition]
		local instence = DialogConditionInstance[data.condition]
		local result, errorID = method(instence, player, data.param) 
		if not result and errorID and errorID > 0 then
			return result, errorID
		end
	end
	return true, 0

end

--检测对话ID是否满足条件
function DialogCondition:checkDialogID(player, dialogID, npcID)

	local conditions = DialogModelDB[dialogID].conditions
	for _, data in pairs(conditions) do
		local method = DialogConditionDoer[data.condition]
		local instence = DialogConditionInstance[data.condition]
		local result, errorID = method(instence, player, data.param, npcID)
		if not result and errorID and errorID > 0 then
			return result, errorID
		end
	end
	return true, 0
	
end

--对话功能之切换对话框
function DialogCondition:checkGoto(player, param)
	return 1
end

function DialogCondition.getInstance()
	return DialogCondition()
end

