--[[PractiseManager.lua
描述:修行值管理
]]

PractiseManager = class(nil,Singleton)

function PractiseManager:__init()
end

function PractiseManager:__release()
end

function PractiseManager:update(period)
	if period == "day" then 
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			local storeXp = player:getStoreXp()
			-- 更新存储经验
			for _,dataDB in pairs(tActivityPageDB) do
				if schoolType == dataDB.SchoolType  or not dataDB.SchoolType then
					local taskID = dataDB.TaskID
					if taskID then
						local loopTask = LoopTaskDB[taskID]
						if loopTask then
							local levelLimit = loopTask.level
							if levelLimit[1] <= myLevel then 
								local countRing = taskHandler:getCountRing(taskID)
								if countRing <= loopTask.loop then
									storeXp = storeXp + countRing*dataDB.PracticeReword
								end
							end
						end
					end
				end
				player:setStoreXp(storeXp)
				end
			-- 更新修行值
			-- 把活力值重新赋值
			player:setPractise(0)
			-- 更新经验存储值
			player:flushPropBatch()
		end
	end
end

function PractiseManager:loadPractiseFromDB(player, recordList)
	-- print("运行到这里")
	local practiseHandler = player:getHandler(HandlerDef_Practise)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if not recordList then
		player:setPractise(0)
		return
	end
	local schoolType = player:getSchool()
	local myLevel =  player:getLevel()
	local storeXp = 0
	for _,data in pairs(recordList) do
		if data then
			storeXp = data.storeXp
			if not time.isSameDay(data.recordTime) then
				-- 更新到0
				player:setPractise(0)
				-- 更新存储经验 公式更新 活动里没有完成的任务全部增加到存储经验里
				for _,dataDB in pairs(tActivityPageDB) do
					if schoolType == dataDB.SchoolType  or not dataDB.SchoolType then
						local taskID = dataDB.TaskID
						if taskID then
							local loopTask = LoopTaskDB[taskID]
							if loopTask then
								local levelLimit = loopTask.level
								if levelLimit[1] <= myLevel then 
									local countRing = taskHandler:getCountRing(taskID)
									if countRing <= loopTask.loop then
										storeXp = storeXp + countRing*dataDB.PracticeReword
									end
								end
							end
						end
					end
					player:setStoreXp(storeXp)
				end	
			else	
				player:setPractise(data.practise)
				player:setStoreXp(data.storeXp)
				if practiseHandler then
					practiseHandler:setTabBoxState(data)
				end
			end
			player:setPractiseCount(data.practiseCount)
		end
	end
	player:flushPropBatch()
end

function PractiseManager:savePractiseData(player)
	local practiseHandler = player:getHandler(HandlerDef_Practise)
	if practiseHandler then
		practiseHandler:savePracitseData()
	end
end

function PractiseManager.getInstance()
	return PractiseManager
end


-- 每日更新
g_periodChecker:addPeriodListener("day", PractiseManager.getInstance())