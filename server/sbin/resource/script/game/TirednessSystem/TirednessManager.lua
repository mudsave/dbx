--[[TirednessManager.lua
活力值管理
]]

TirednessManager = class(nil,Singleton)

function TirednessManager:__init()
	
end

function TirednessManager:__release()
	self.lastData = nil
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
			-- 记录自己数据	
			self.lastData = record
			if not time.isSameDay(record.recordTime) then
				player:setTiredness(MaxPlayerTiredness)
			else
				player:setTiredness(record.tiredness)
			end
		else
			local lastData = {}
			lastData.recordTime = os.time()
			lastData.tiredness = MaxPlayerTiredness
			player:setTiredness(MaxPlayerTiredness)
		end
	end
	player:flushPropBatch()
end

function TirednessManager:isSave(tiredness)
	local lastData = self.lastData
	if lastData then
		if not time.isSameDay(lastData.recordTime) or 
		lastData.tiredness ~= tiredness then
			return true
		end
		return false
	end
	return true
end

function TirednessManager:saveTiredness(player)
	-- 存储时间和活力值
	local curTime = os.time()
	local tiredness = player:getTiredness()
	if self:isSave(tiredness) then
		LuaDBAccess.SaveRoleTiredness(player:getDBID(),tiredness,curTime)
	end
end

function TirednessManager.getInstance()
	return TirednessManager
end

-- 每日更新
g_periodChecker:addPeriodListener("day", TirednessManager.getInstance())

