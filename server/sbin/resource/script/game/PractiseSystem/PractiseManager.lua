--[[PractiseManager.lua
描述:修行值管理
]]

PractiseManager = class(nil,Singleton)

function PractiseManager:__init()
end

function PractiseManager:__release()
end

function PractiseManager:update(period)
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			local storeXp = player:getStoreXp()
			local xpValue = 0
			-- 更新存储经验
			for _,dataDB in pairs(tActivityPageDB) do
				if schoolType == dataDB.SchoolType  or not dataDB.SchoolType then
					local taskID = dataDB.TaskID
					if taskID then
						local loopTask = LoopTaskDB[taskID]
						if loopTask then
							local levelLimit = loopTask.level
							local type = loopTask.taskType2
							if levelLimit[1] <= myLevel and type ~= TaskType2.Heaven then 
								local countRing = taskHandler:getCurrentRing(taskID)
								if loopTask.loop then
									local loop = loopTask.loop
									local periodTime = loopTask.period
									if period == "day" and periodTime == TaskPeriod.day then 
										for index = countRing,loop do
											local xpFuncName = loopTask.formulaRewards[TaskRewardList.player_xp]
											print("xpFuncName:",xpFuncName)
											if xpFuncName then
												xpValue = xpValue + xpFuncName(countRing,player:getLevel())	
												print("xpValue:",xpValue)
											end
										end
									elseif period == "week" and periodTime == TaskPeriod.week then
										for index = countRing,loop do
											local xpFuncName = loopTask.formulaRewards[TaskRewardList.player_xp]
											print("xpFuncName:",xpFuncName)
											if xpFuncName then
												xpValue = xpValue + xpFuncName(countRing,player:getLevel())	
												print("xpValue:",xpValue)
											end
										end
									end
								end
							end
						end
					end
				end
				if xpValue > 0 then 
				xpValue = player:setStoreXp(storeXp + xpValue)
				g_eventMgr:fireRemoteEvent(
							Event.getEvent(
							ClientEvents_SC_PromptMsg,eventGroup_Practise,2,xpValue
					),
					player
				)
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
	local period = 0
	for _,data in pairs(recordList) do
		if data then
		storeXp = storeXp + data.storeXp
		period = data.recordTime
			if not time.isSameDay(data.recordTime) then
				-- 更新到0
				player:setPractise(0)
			else	
				-- 修行值和宝箱
				player:setPractise(data.practise)
				if practiseHandler then
					practiseHandler:setTabBoxState(data)
				end
			end
		end
	end
	local xpValue = 0
	-- 更新存储经验
	for _,dataDB in pairs(tActivityPageDB) do
		if schoolType == dataDB.SchoolType  or not dataDB.SchoolType then
			local taskID = dataDB.TaskID
			if taskID then
				local loopTask = LoopTaskDB[taskID]
				if loopTask then
					local levelLimit = loopTask.level
					local type = loopTask.taskType2
					if levelLimit[1] <= myLevel and type ~= TaskType2.Heaven then  
						local countRing = taskHandler:getCurrentRing(taskID)
						if loopTask.loop then
							local loop = loopTask.loop
							local periodTime = loopTask.period
							if not time.isSameDay(period) and periodTime == TaskPeriod.day then 
								for index = countRing,loop do
									local xpFuncName = loopTask.formulaRewards[TaskRewardList.player_xp]
									print("xpFuncName:",xpFuncName)
									if xpFuncName then
										xpValue = xpValue + xpFuncName(countRing,player:getLevel())	
										print("xpValue:",xpValue)
									end
								end
							elseif  not time.isSameWeek(period)  and periodTime == TaskPeriod.week then
								for index = countRing,loop do
									local xpFuncName = loopTask.formulaRewards[TaskRewardList.player_xp]
									print("xpFuncName:",xpFuncName)
									if xpFuncName then
										xpValue = xpValue + xpFuncName(countRing,player:getLevel())	
										print("xpValue:",xpValue)
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if xpValue > 0 then
		xpValue = player:setStoreXp(storeXp + xpValue)
		g_eventMgr:fireRemoteEvent(
					Event.getEvent(
					ClientEvents_SC_PromptMsg,eventGroup_Practise,2,xpValue
			),
			player
		)
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
