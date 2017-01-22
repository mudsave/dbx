--[[DailyTask.lua
描述：
	日常任务类
--]]

DailyTask = class(Task)

function DailyTask:__init()

end

function DailyTask:__release()

end

function DailyTask:setRewards(rewards)
	self._rewards = rewards
end

function DailyTask:getRewards()
	return self._rewards
end

function DailyTask:setTriggers(triggers)
	self._triggers = triggers
end

function DailyTask:getTriggers()
	return self._triggers
end

function DailyTask:addReward()
	local player = g_entityMgr:getPlayerByID(self._roleID)
	for rewardType, value in pairs(self._rewards) do
		if rewardType == TaskRewardList.player_xp then
			player:addXp(value)
		elseif rewardType == TaskRewardList.money then
			player:setMoney(player:getMoney() + value)
		elseif rewardType == TaskRewardList.subMoney then
			player:setSubMoney(player:getSubMoney() + value)
		elseif rewardType == TaskRewardList.pet_xp then
			local pid = player:getFollowPetID()
			local fpet = pid and g_entityMgr:getPet(pid)
			if fpet then
				fpet:addXp(value)
			end
		elseif rewardType == TaskRewardList.player_tao then
			player:addTao(value)
		elseif rewardType == TaskRewardList.pet_tao then
			local pid = player:getFollowPetID()
			local fpet = pid and g_entityMgr:getPet(pid)
			if fpet then
				local curPetTao = fpet:getAttrValue(pet_tao)
				fpet:setAttrValue(pet_tao,value + curPetTao)
				fpet:flushPropBatch()
			end
		elseif rewardType == TaskRewardList.player_pot then
			local curPotValue = player:getAttrValue(player_pot)
			player:setAttrValue(player_pot,curPotValue + value)
		else
			print("奖励类型没定义，",rewardType)
		end	

	end
	player:flushPropBatch()
	g_taskSystem:addMessageShow(player, self._rewards)
end	