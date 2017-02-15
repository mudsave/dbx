--[[ActivityHandler.lua
	描述:活动handler
]]

ActivityHandler = class()

function ActivityHandler:__init(entity)
	self.entity = entity
	self.activityProgressData = {}
	self.currentTargets = {}
	self.finishTargets = {}
	self.priData = {}
	self._goldHuntData={ID=0,totalScore=0,isPrized = 0,rank = -1}
	self.enterPos = {}
end

function ActivityHandler:__release()
	self.activityProgressData = nil
	self.currentTargets = nil
	self.finishTargets = nil
	self.priData = nil
	self._goldHuntData = nil
	self.enterPos = nil
end

function ActivityHandler:getGoldHuntData()
	return self._goldHuntData
end

function ActivityHandler:addActivityTarget(activityId, targetIndex, target)
	if not self.activityProgressData[activityId] then
		self.activityProgressData[activityId] = {}
	end
	if not self.currentTargets[activityId] then
		self.currentTargets[activityId] = {}
	end
	self.activityProgressData[activityId][targetIndex] = true
	self.currentTargets[activityId][targetIndex] = target
end

function ActivityHandler:removeActivityData(activityId, targetIndex)
	if not self.activityProgressData[activityId] then
		print("当前活动失效，请程序查明原因", activityId)
		return
	end
	self.activityProgressData[activityId][targetIndex] = nil
	self.currentTargets[activityId][targetIndex] = nil
end

function ActivityHandler:closeActivity(activityId)
	self.activityProgressData[activityId] = nil
	self.currentTargets[activityId] = nil
	self.priData[activityId] = nil
end

function ActivityHandler:getActivitysProgress()
	return self.activityProgressData
end

function ActivityHandler:getPriData(activityId)
	return self.priData[activityId]
end

function ActivityHandler:setPriDataById(activityId, priData)
	self.priData[activityId] = priData
	
end


function ActivityHandler:getTargetsById(activityId)
	return self.currentTargets[activityId]
end

function ActivityHandler:getTargets()
	return self.currentTargets
end

function ActivityHandler:offLine()
	local player = self.entity
	for activityId,data in pairs(ActivityDB) do
		-- 判断活动是否开启
		if g_activityMgr:getActivity(activityId) then
			-- 把开启活动的数据存储到数据库中
			g_goldHuntMgr:onOffline(player,activityId)
			g_catchPetMgr:onOffline(player, activityId)
			if ActivityDB[activityId].dbName then
				LuaDBAccess[ActivityDB[activityId].dbName](player,activityId)
			end
		end
	end
	-- for targetIndex, flag in pairs(self.activityProgressData[activityId]) do
		-- if flag == true then
			-- LuaDBAccess[ActivityDB[activityId].dbName](player,activityId)
		-- end
	-- end
	for _, targets in pairs(self.currentTargets) do
		for targetIndex, target in pairs(targets) do
			release(target)
		end
	end
end

function ActivityHandler:addFinishTargets(target)
	table.insert(self.finishTargets, target)
end

function ActivityHandler:releaseFinishTargets()
	for _, target in pairs(self.finishTargets) do
		self:removeActivityData(target:getActivityId(), target:getActivityIndex())
		local activity = g_activityMgr:getActivity(target:getActivityId())
		activity:removeTarget(target)
		release(target)
	end
	self.finishTargets = {}
end

-- 设置进入活动场景前的位置
function ActivityHandler:setEnterPos(mapID, xPos, yPos)
	self.enterPos.mapID = mapID
	self.enterPos.xPos = xPos
	self.enterPos.yPos = yPos
end

function ActivityHandler:getEnterPos()
	return self.enterPos
end
