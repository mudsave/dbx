--[[DialogManager.lua
描述：
	对话管理(对话系统)
--]]

DialogManager = class(Singleton)

function DialogManager:__init()
	self.dialogs = {}
	self.count = 0
end

--添加一个对话对象
function DialogManager:addDialog(playerID, dialog)
	if self.dialogs[playerID] then
		release(self.dialogs[playerID])
	else
		self.count = self.count + 1
	end
	self.dialogs[playerID] = dialog
end

--移除一个对话对象
function DialogManager:removeDialog(playerID)
	if self.dialogs[playerID] then
		release(self.dialogs[playerID])
		self.dialogs[playerID] = nil
		self.count = self.count - 1
	end
end

--获取指定对话
function DialogManager:getDialog(playerID)
	return self.dialogs[playerID]
end

--获取所有对话
function DialogManager:getDialogs()
	return self.dialogs
end

--获取当前对话数量
function DialogManager:getCount()
	return self.count
end

function DialogManager.getInstance()
	return DialogManager()
end
