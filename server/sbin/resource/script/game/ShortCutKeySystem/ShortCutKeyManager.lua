--[[ShortCutKeyManager.lua
描述:
	快捷栏管理
]]

ShortCutKeyManager = class(nil, Singleton)

function ShortCutKeyManager:__init()
	self.flag					= false
	self.shortCutKeyInfoList	= {}				--快捷栏对应物品或者技能信息列表
end

function ShortCutKeyManager:__release()
	self.shortCutKeyInfoList = {}
	self.flag = false
end

--更新快捷栏数据
function ShortCutKeyManager:updateShortCutKeyData(roleID,info)
	local tempInfo = {}
	for _,value in pairs(info) do
		table.insert(tempInfo,value)
	end
	self.shortCutKeyInfoList[roleID] = tempInfo
end

--更新物品用完时的快捷栏数据
function ShortCutKeyManager:updateShortCutKeyDataForUseUp(roleID,info,flag)
	local tempInfo = {}
	for _,value in pairs(info) do
		table.insert(tempInfo,value)
	end
	self.shortCutKeyInfoList[roleID] = tempInfo
	self.flag = flag
end

--取对应玩家的快捷栏数据
function ShortCutKeyManager:getKeyData(roleID)
	return self.shortCutKeyInfoList[roleID]
end

--检查玩家下线
function ShortCutKeyManager:onPlayerCheckOut(player)
	local roleID = player:getID()
	local keyData = self:getKeyData(roleID)
	local playerDBID = player:getDBID()
	if table.size(keyData) > 0 then									--玩家上线进行了快捷栏相关操作
		LuaDBAccess.shortCutKeyDelete(playerDBID)					--保存数据前，先清理下数据库数据
		for _,value in pairs (keyData) do
			LuaDBAccess.shortCutKeySave(playerDBID,value)
		end
	else
		if self.flag then
			LuaDBAccess.shortCutKeyDelete(playerDBID)				--物品用完时删除快捷栏对应格子数据
		else
			print("玩家上线没有进行快捷栏相关操作！")
		end
	end
end



function ShortCutKeyManager:updateDataToClient(player,value)
	local event = Event.getEvent(ShortCutKeyEvents_SC_UpdateDataToClient,value)
	g_eventMgr:fireRemoteEvent(event,player)
end

function ShortCutKeyManager.getInstance()
	return ShortCutKeyManager()
end