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
end

function ActivityHandler:__release()
	self.activityProgressData = nil
	self.currentTargets = nil
	self.finishTargets = nil
	self.priData = nil
end

function ActivityHandler:addActivityTarget(activityId, targetIndex, target)
	if not self.activityProgressData[activityId] then
		self.activityProgressData[activityId] = {}
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
	for targetIndex, flag in pairs(self.activityProgressData[activityId]) do
		if flag == true then
			LuaDBAccess[ActivityDB[activityId].dbName](player)
		end
	end
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