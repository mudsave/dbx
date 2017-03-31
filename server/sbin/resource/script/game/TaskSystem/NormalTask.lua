--[[NormalTask.lua
描述：
	普通任务类
--]]

NormalTask = class(Task)

function NormalTask:__init()

end

function NormalTask:__release()

end

function NormalTask:setRewards(rewards)
	self._rewards = rewards
end

function NormalTask:getRewards()
	return self._rewards
end

function NormalTask:setTriggers(triggers)
	table.deepCopy(triggers, self._triggers)
end

function NormalTask:getTriggers()
	return self._triggers
end

function NormalTask:addReward()
	local player = g_entityMgr:getPlayerByID(self._roleID)
	for rewardType, value in pairs(self._rewards) do
		if rewardType == TaskRewardList.player_xp then
			local temp_xp_ratio = player:getAttrValue(player_xp_ratio)
			local addXp = math.floor(value * temp_xp_ratio / 100)
			player:addXp(addXp)
			self._rewards[rewardType] = addXp
		elseif rewardType == TaskRewardList.money then
			player:setMoney(player:getMoney() + value)
		elseif rewardType == TaskRewardList.subMoney then
			player:setSubMoney(player:getSubMoney() + value)
		elseif rewardType == TaskRewardList.pet_xp then
			local pid = player:getFightPetID()
			local fpet = pid and g_entityMgr:getPet(pid)
			if fpet then
				fpet:addXp(value)
			end
		elseif rewardType == TaskRewardList.player_tao then
			player:addTao(value)
		elseif rewardType == TaskRewardList.pet_tao then
			local pid = player:getFightPetID()
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
