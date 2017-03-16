--[[CollectSystem.lua
描述：
     采集系统
--]]require "base.base"
require "game.FightSystem.DropManager"
require "game.ItemSystem.ItemManager"	
require "game.CollectSystem.CollectManager"
require "scene.Scene"
require "game.TaskSystem.TaskCallBack"

CollectSystem = class(EventSetDoer, Singleton)
function CollectSystem:__init()
	local isGridsNumFull = false
	self._doer = {
		[GoodsEvents_CS_RemoveGoods] = CollectSystem.onRemoveGoods,
	}
end

--客户端点击物
function CollectSystem:onRemoveGoods(event)
    local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local goodsNpcID = params[1]
	local goodsNpc = g_entityMgr:getGoodsNpc(goodsNpcID)
	
	--判断地图上是否有该包裹
	if goodsNpc then
		local isSuccess = false
		local isRemoved = false
	    local collectionRefresher = CollectionRefresher.getInstance()
		--获取GoodsReward物件包ID
		local packID = goodsNpc:getDBID()
		local config = ArticlesDB[packID]
		local condition = config.condition
		--猎金场活动条件判断
		if g_sceneMgr:isInGoldHuntScene(player) then
			if not g_goldHuntMgr:canCollectMine(player,packID) then
				local event_notice =Event.getEvent(GoodsEvents_SC_NoticeMSG, 8)
				g_eventMgr:fireRemoteEvent(event_notice,player)
				return
			end
			isRemoved = collectionRefresher:collect(goodsNpcID)
			CollectSystem:openGoodsPack(goodsNpcID,playerID)
			g_goldHuntMgr:onItemCollected(goodsNpcID,packID,playerID,isRemoved)
			return
		end
		if not isGridsNumFull then 
			--条件为空，说明该物件为障碍物，同样可以采集移除
			if table.size(condition) <=0 then
				isSuccess = true
				collectionRefresher:collect(goodsNpcID)
				CollectSystem:openGoodsPack(goodsNpcID,playerID)
			else   	
				-- 处理玩家等级是否满足开采条件
				if condition.lowLevel then 
					local playerLevel = player:getLevel()
					--如果玩家等级小于该开采条件内
					if  playerLevel < condition.lowLevel then
						isSuccess = true
						collectionRefresher:collect(goodsNpcID)
						CollectSystem:openGoodsPack(goodsNpcID,playerID)
					else
						--处理玩家等级过高
						local noticeID_1 =  1
						local event_levelNotice_1 = Event.getEvent(GoodsEvents_SC_HighLevelMSG, noticeID_1)
						g_eventMgr:fireRemoteEvent(event_levelNotice_1,player)
					end 
				-- 处理玩家任务是否满足开采条件
				else		
					if condition.taskID then
						isSuccess = true
						--如果玩家持有该任务
						if player:getHandler(HandlerDef_Task):getTask(condition.taskID) then
						collectionRefresher:collect(goodsNpcID)
						CollectSystem:openGoodsPack(goodsNpcID,playerID)
						
						--采集完成，通知任务系统
						TaskCallBack.onContactSeal(playerID, packID)
						else 
							local noticeID_2 =  2
							local event_notice =Event.getEvent(GoodsEvents_SC_NoticeMSG, noticeID_2)
							g_eventMgr:fireRemoteEvent(event_notice,player)
						end
					-- 处理消耗物品
					else
						if condition.itemID then
							local itemConfigID = config.condition.itemID
							--消耗物品数量，策划要求写死
							local num = 1
							local packetHandler = player:getHandler(HandlerDef_Packet)
							--判断玩家物品是否有打开包裹需要消耗的物品
							if packetHandler:getNumByItemID(itemConfigID) >= num then
								--消耗玩家物品		
								isSuccess = true
								packetHandler:removeByItemId(itemConfigID, num)
								collectionRefresher:collect(goodsNpcID)
								CollectSystem:openGoodsPack(goodsNpcID,playerID)
							else
								local noticeID_3 =  3
								local event_notice =Event.getEvent(GoodsEvents_SC_NoticeMSG, noticeID_3)
								g_eventMgr:fireRemoteEvent(event_notice,player)
							end
						else
							if condition.highLevel then  
								local playerLevel = player:getLevel()
								--如果玩家等级高于给配置条件
								if  playerLevel > condition.highLevel then
									isSuccess = true
									collectionRefresher:collect(goodsNpcID)
									CollectSystem:openGoodsPack(goodsNpcID,playerID)
								else
									--处理玩家等级过高
									local noticeID_4 =  4
									local event_levelNotice_4 = Event.getEvent(GoodsEvents_SC_LowLevelMSG, noticeID_4)
									g_eventMgr:fireRemoteEvent(event_levelNotice_4,player)
								end
							end
						end
					end
				end
			end
		else 
			local noticeID_6 =  6
			local event_lackGridsMSG = Event.getEvent(GoodsEvents_SC_LackGridsMSG, noticeID_6)
			g_eventMgr:fireRemoteEvent(event_lackGridsMSG,player)
        end 			
		
	--该包裹被采集后，其他玩家还在读条的处理
    else
		local noticeID_5 =  5
		local event_Colnotice =Event.getEvent(GoodsEvents_SC_ColnoticeMSG, noticeID_5)
		g_eventMgr:fireRemoteEvent(event_Colnotice,player)
    end 
end	

--点击打开物件包
function CollectSystem:openGoodsPack(goodsNpcID,playerID)
    local goodsNpc = g_entityMgr:getGoodsNpc(goodsNpcID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local packID = goodsNpc:getDBID()
	local config = ArticlesDB[packID]
	local dropID = config.dropID
	if  config.scriptID then
	    self:onEnterFight(playerID,config)
    end
	
	if dropID then 
		local rewards = self:gainedRewards(dropID)
		--设置玩家奖励值
		self:setPlayerReward(rewards.value,player)
		
		local packetHandler = player:getHandler(HandlerDef_Packet)
		if not packetHandler then 
			return 
		end
		--获取玩家背包的格子数
		roleEmptyGridsNum = packetHandler:getPacketEmptyGridsNum(PacketPackType.Normal)
		--判断玩家背包格子数是否小于所获物品的种类
		if roleEmptyGridsNum < table.size(rewards.item) then
			local noticeID_6 =  6
			local event_lackGridsMSG = Event.getEvent(GoodsEvents_SC_LackGridsMSG, noticeID_6)
			g_eventMgr:fireRemoteEvent(event_lackGridsMSG,player)
			
			return
		end
		--所获物品显示到客户端
		for itemID, number in pairs(rewards.item) do
			packetHandler:addItemsToPacket(itemID, number)
		end
		
		--采集完成，通知任务系统
		TaskCallBack.onContactSeal(playerID, packID)
		--通知客户端提示所获得的物品
		local event_gainedRewards = Event.getEvent(GoodsEvents_SC_GetRewards,rewards,packID)
		g_eventMgr:fireRemoteEvent(event_gainedRewards,player)	
	else
		print("采集完成")
	end	
end    
  
--获得奖励
function CollectSystem:gainedRewards(dropID)
	local reward = {
			value = {
				money = 0,	   
				subMoney = 0,
				xp = 0,
				pot = 0,
				expoint = 0,
				},
			item = {
				--itemID = itemNum
			},
		}	
		
	if dropID then
		local dropConfig = DropDB[dropID]
		local dropNumData = dropConfig.dropNumData
		if dropNumData then
			local dropType = dropConfig.dropType
			if table.size(dropNumData)>1 then   
				local randIndex = math.random(1,#dropNumData)
				local randNum = dropNumData[randIndex]
				self:gaindedSomething(player,dropType,randNum,reward)
			else
				self:gaindedSomething(player,dropType,dropNumData[1],reward)
			end	
		else 
			local rewardData = DropDB[dropID].dropRewards
			self:addRewardsValue(player,rewardData,reward)
		end 		
	end	
	return reward
end 

--获得具体奖励处理
function CollectSystem:gaindedSomething(player,dropType,number,reward)
	for i = 1,number do
		local ocIndex = self:getDropInfo(dropType)
		rewardData = dropType[ocIndex]
		self:addRewardsValue(player,rewardData,reward)
		--物品奖励单独处理
		if rewardData.item then
			local itemID = rewardData.item.id
			local itemNumData = rewardData.item.number
			local itemNumIndex = math.random(1,#itemNumData)
			local itemNum = itemNumData[itemNumIndex]	
			if reward.item[itemID] then 
				reward.item[itemID] = itemNum + reward.item[itemID]
			else
				reward.item[itemID] = itemNum
			end	
		end
	end
end  
 
function  CollectSystem:addRewardsValue(player,rewardData,reward)
	--金币公式奖励
	if rewardData.formulaMoney then 
		local formulaFun = rewardData.formulaMoney
		local level = player:getLevel()
		local value = formulaFun(level)
		reward.value.money  = reward.value.money + value
	end
	
	--金币奖励
	if rewardData.money then
		reward.value.money = reward.value.money + rewardData.money
	end
	
	--绑银公式奖励
	if rewardData.formulaSubMoney then 
		local formulaFun = rewardData.formulaSubMoney
		local level = player:getLevel()
		local value = formulaFun(level)
		reward.value.subMoney = reward.value.subMoney + value
	end
	
	--绑银奖励
	if rewardData.subMoney then
		reward.value.subMoney = reward.value.subMoney + rewardData.subMoney
	end
	
	--经验公式奖励
	if rewardData.formulaXp then 
		local formulaFun = rewardData.formulaXp
		local level = player:getLevel()
		local value = formulaFun(level)
		reward.value.xp = reward.value.xp + value
	end
	
	--经验奖励
	if rewardData.xp then
		reward.value.xp = reward.value.xp + rewardData.xp
	end
	
	--潜能公式奖励
	if rewardData.formulaPot then 
		local formulaFun = rewardData.formulaPot
		local level = player:getLevel()
		local value = formulaFun(level)
		reward.value.pot = reward.value.pot + value
	end
	
	--潜能奖励
	if rewardData.pot then
		reward.value.pot = reward.value.pot + rewardData.pot
	end
	
	--历练公式奖励
	if rewardData.formulaExpoint then 
		local formulaFun = rewardData.formulaExpoint
		local level = player:getLevel()
		local value = formulaFun(level)
		reward.value.expoint = reward.value.expoint + value
	end
	
	--历练奖励
	if rewardData.expoint then
		reward.value.expoint = reward.value.expoint + rewardData.expoint
	end	

end

--同步奖励至玩家身上
function CollectSystem:setPlayerReward(reward,player)
	if reward.money then
		player:setMoney(player:getMoney() + reward.money)
	end
	
	if reward.subMoney then
		player:setSubMoney(player:getSubMoney() + reward.subMoney)
	end
	
	if reward.xp then
		local xpValua = player:getAttrValue(player_xp)
		player:setAttrValue(player_xp,xpValua+reward.xp)
	end
	
	if reward.pot then
		local potValua = player:getAttrValue(player_pot)
		player:setAttrValue(player_pot,potValua+reward.pot)
	end
	
	if reward.expoint then
		local expointValua = player:getAttrValue(player_expoint)
		player:setAttrValue(player_expoint,expointValua+reward.expoint)
	end	
	player:flushPropBatch()
end
 
--物品权重处理
function CollectSystem:getDropInfo(config)
	local totalWeight = 0
	for _,info in ipairs(config) do
		totalWeight = totalWeight + (info.weight or 0)
	end
	local rand = math.random(totalWeight)
	local curWeight = 0

	for index,info in ipairs(config) do
		if rand >= curWeight and rand <= curWeight +  info.weight then
			return index
		end
		curWeight = curWeight +  info.weight
	end
end
 
--脚本战斗 
function CollectSystem:onEnterFight(playerID,config)
    local player = g_entityMgr:getPlayerByID(playerID)
	local playerList = {}                                     
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if teamHandler:isLeader() then
			playerList = teamHandler:getTeamPlayerList()
		elseif teamHandler:isStepOutState() then
			table.insert(playerList,player)
		end
	else
		table.insert(playerList,player)
	end
        
	local scriptID = config.scriptID
	--加宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)                                               
			table.insert(finalList,pet)
		end
	end

	g_fightMgr:startScriptFight(finalList, scriptID, nil ,FightBussinessType.Collect)
end

function CollectSystem.getInstance()
	return CollectSystem()
end

EventManager:getInstance():addEventListener(CollectSystem.getInstance())
