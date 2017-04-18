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

function DialogManager:onPlayerOffline(player)
	-- 如果在对话功能中有创建呢新的对话，和之前的对话ID不相同的话
	local dialog = self:getDialog(player:getID())
	if dialog then
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		if teamID > 0 then
			local team = g_teamMgr:getTeam(teamID)
			local teamMemberList = team:getMemberList()
			for i = 1, table.getn(teamMemberList) do
				local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
				self:removeDialog(teamMember:getID())
				g_dialogSym:closeDialog(teamMember)
			end
		else
			self:removeDialog(player:getID())
			g_dialogSym:closeDialog(player)
		end
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
