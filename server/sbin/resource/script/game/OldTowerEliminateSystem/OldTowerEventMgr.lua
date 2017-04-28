--[[OldTowerEventMgr.lua
	古塔驱妖事件管理
--]]

OldTowerEventMgr = class(EventSetDoer, Singleton)

function OldTowerEventMgr:__init()
	self._doer = 
	{
		[OldTowerEvent_CS_OldTowerNpcChange]		= OldTowerEventMgr.onNpcClassChange,				--在古塔驱妖场景中点击了某个npc
		[OldTowerEvent_CS_OldTowerNpcClear]			= OldTowerEventMgr.onClearOldTowerNpc,				--某行某列重复，清除
		[OldTowerEvent_CS_OldTowerTimeOut]			= OldTowerEventMgr.onOldTowerTimeOut,				--客户端倒计时结束通知
		[OldTowerEvent_CS_RequestQuit]				= OldTowerEventMgr.onOldTowerRequestQuit,			--客户端通知退出场景
	}
end

-- 由客户端通知点击了某个npc
function OldTowerEventMgr:onNpcClassChange(event)
	local params = event:getParams()
	local aimNpcPoint = params[1]
	local playerID = event.playerID
	g_oldTowerSym:onNpcClassChange(aimNpcPoint,playerID)
end

--由客户端通知Npc出现行重复或列重复
function OldTowerEventMgr:onClearOldTowerNpc(event)
	local params = event:getParams()
	local dataTable = params[1]
	local playerID = event.playerID
	local clearTimes = table.size(dataTable)
	g_oldTowerSym:onClearOldTowerNpc(dataTable,playerID,clearTimes)
end

--由客户端通知古塔倒计时结束
function OldTowerEventMgr:onOldTowerTimeOut(event)
	local params = event:getParams()
	local playerID = event.playerID
	g_oldTowerSym:onOldTowerTimeOut(playerID)
end

function OldTowerEventMgr:onOldTowerRequestQuit(event)
	local params = event:getParams()
	local playerID = event.playerID
	g_oldTowerSym:onOldTowerRequestQuit(playerID)
end

function OldTowerEventMgr.getInstance()
	return OldTowerEventMgr()
end

EventManager.getInstance():addEventListener(OldTowerEventMgr.getInstance())