--[[ServerManager.lua
	服务器等级
--]]

ServerManager = class(nil, Singleton)

function ServerManager:__init()
	self.startDays = 0
	self.serverLevel = 0
end

function ServerManager:__release()
	self.startDays = nil
	self.serverLevel = nil
end

-- 设置服务器开启的天数
function ServerManager:setStartDays(days)
	self.startDays = days
end

function ServerManager:getStartDays()
	return self.startDays
end

function ServerManager:setServerLevel(level)
	self.serverLevel = level
end

function ServerManager:getServerLevel()
	return self.serverLevel
end

-- 首个玩家登录时，服务器等级数据读取
function ServerManager.onServerStart(recordList, self)
	local serverRecord = recordList[1][1]
	if serverRecord then
		local serverID = serverRecord.serverID
		if serverID and serverID == dataBaseServerID then
			local closeTime = serverRecord.closeTime
			-- 判断, 是不是同一天开启服务器
			if not time.isSameDay(closeTime) then
				self.startDays = serverRecord.startDays + 1
			else
				self.startDays = serverRecord.startDays
			end
		else
			self.startDays = 1
		end
	else
		self.startDays = 1
	end
	-- 根据服务器开启的天数，来确定服务器，开启的等级，读配置	
	self:setServerLevel()
end

function ServerManager:update(period)
	if period == "day" then
		-- 如果到呢每天的24:00
		self.startDays = self.startDays + 1
		-- 根据天数，来找配置的服务器等级
		self:setServerLevel()
	end
end

-- 设置服务器等级, 此时要通知所有的在线玩家, 跨天，针对在线玩家
function ServerManager:setServerLevel()
	-- 根据天数，来确定服务器等级
	local tempServerLvl = 0
	for _, config in ipairs(ServerLevelDB or {}) do
		if self.startDays >= config.days then
			tempServerLvl = config.level
		else
			break
		end
	end
	-- 跨天和第一次登录时，才会去设置在线玩家的服务器等级变化，没变化的就不需要设置
	if self.serverLevel ~= tempServerLvl then
		self.serverLevel = tempServerLvl
		-- 通知所有在当前服务器的玩家
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			if player then
				-- 所有服务器玩家设置当前服务器等级, 和开启的天数
				player:setAttrValue(player_server_level, self.serverLevel)
			end
		end
	end
end

function ServerManager:saveServerData()
	-- 如果服务器开呢， 没有玩家登录，此时关闭服务器。不应该跟新数据库，等级就会变0
	if self.serverLevel ~= 0 then
		LuaDBAccess.saveServer(dataBaseServerID, self.startDays, self.serverLevel)
	end
end

function ServerManager.getInstance()
	return ServerManager()
end

g_serverMgr = ServerManager.getInstance()
g_periodChecker:addPeriodListener("day", g_serverMgr)
