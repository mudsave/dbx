--[[system.lua
描述：
	系统回调入口
--]]

System = {}

function System._LoadWorldServerData(player, worldServerData)
end

function System._LoadSocialServerData(player, worldServerData)
end

function System.OnPlayerLogined(player)
end

function System.OnPlayerLoaded(player, recordList)
	-- 加载所有道具
	local itemsRecord = recordList[3]
	g_itemMgr:createItemFromDB(player, itemsRecord)
	-- 玩家上线加载坐骑数据
	g_rideMgr:loadRides(player,recordList[20])
end

function System.OnPlayerLogout(player, reason)
	-- 玩家下线保存坐骑数据
	g_rideMgr:onPlayerCheckOut(player)
	-- 下线保存道具数据
	g_itemMgr:saveItemsData(player)
end
