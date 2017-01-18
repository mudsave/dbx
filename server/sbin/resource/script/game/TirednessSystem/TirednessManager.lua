--[[TirednessManager.lua
活力值管理
]]

TirednessManager = class(nil,Singleton)

function TirednessManager:__init()
	
end

function TirednessManager:__release()

end

-- 每天更新在线玩家的活力值
function TirednessManager:update(period)
	if period == "day" then
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			print("进入跨天调用没有啊")
			-- 把活力值重新赋值
			player:setTiredness(MaxPlayerTiredness)
		end
	end
end

function TirednessManager:loadTirednessFromDB(player,recordList)
	if not recordList or table.size(recordList) < 1 then
		player:setTiredness(MaxPlayerTiredness)
		return 
	end
	for _,record in pairs(recordList) do
		if record then
			if not time.isSameDay(record.recordTime) then
				player:setTiredness(MaxPlayerTiredness)
			else
				player:setTiredness(record.tiredness)
			end
		else
			player:setTiredness(MaxPlayerTiredness)
		end
	end
	player:flushPropBatch()
end

function TirednessManager:saveTiredness(player)
	-- 存储时间和活力值
	local curTime = os.time()
	LuaDBAccess.SaveRoleTiredness(player:getDBID(),player:getTiredness(),curTime)
end

function TirednessManager.getInstance()
	return TirednessManager
end

-- 每日更新
g_periodChecker:addPeriodListener("day", TirednessManager.getInstance())

