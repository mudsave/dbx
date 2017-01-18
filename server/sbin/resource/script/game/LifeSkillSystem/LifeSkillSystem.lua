--[[LifeSkillSystem.lua
    描述：
     生活技能系统
--]]
require "game.LifeSkillSystem.LifeSkillManager"
--require "misc.LifeSkillConstant"
LifeSkillSystem = class(EventSetDoer, Singleton)
function LifeSkillSystem:__init()
	self._doer = {
		[LifeSkillEvent_CS_product] =  LifeSkillSystem.onProduct,
		[LifeSkillEvent_CS_sendProductLevelInfo] = LifeSkillSystem.randOutputRecipe,
		[LifeSkillEvent_CS_productRandRecipe] = LifeSkillSystem.onProductRandRecipe,
		[LifeSkillEvent_CS_learnSkill] = LifeSkillSystem.onLearnSkill,
		[LifeSkillEvent_CS_costMoneyLearnSkill] = LifeSkillSystem.costMoneyLearnSkill,
		[LifeSkillEvent_CS_onRefine] = LifeSkillSystem.onRefineItem,
	}
end

function LifeSkillSystem:onRefineItem(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	
	local refineItemID = params[1]
	local skillIndex = params[2]
	for _,refineInfo in pairs(RefineDB or {})do
		if refineItemID == refineInfo.refineItemID then
			local packetHandler = player:getHandler(HandlerDef_Packet)
			--生产所获得的配方
			local num = self:getRefineItemNum(player,skillIndex)
			packetHandler:addItemsToPacket(refineInfo.itemID, num)
			--发消息给客户端
			local refineItemName = refineInfo.refineItemName
			local itemName = refineInfo.itemName
			local event = Event.getEvent(LifeSkillEvent_SC_refineSuccessNotice,refineItemName,itemName,num)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

--获取权重
function LifeSkillSystem:getNumWeight(player,skillIndex)
	local lifeSkillHandler = player:getHandler(HandlerDef_LifeSkill)
	local level = lifeSkillHandler:getLifeSkillLev(skillIndex)
	local weight1 = level*0.2+30
	local weight2 = level*0.4+20
	local weight3 = level*0.8+10
	return weight1,weight2,weight3
end

--获取提炼后产物的数量
function LifeSkillSystem:getRefineItemNum(player,skillIndex)
    local weight1,weight2,weight3 = self:getNumWeight(player,skillIndex)
	local totalWeight = weight1+weight2+weight3
	local randWeight = math.random(1,totalWeight)
	if randWeight<weight1 then
		return 1
	elseif 	randWeight<weight1+weight2 then
	    return 2
	elseif 	randWeight<weight1+weight2+weight3 then
		return 3
	end
end

--学习技能，此学习是在经验充足，银两充足，绑银不足的情况下学习或者帮贡充足，银两充足，绑银不足
function LifeSkillSystem:costMoneyLearnSkill(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	
	local skillIndex = params[1]
	local costState = params[2]
	
	-- 获取玩家的等级
	local playerLev = player:getLevel()
	local limitLevel = playerLev + 10
    local lifeSkillHandler = player:getHandler(HandlerDef_LifeSkill)
	local level = lifeSkillHandler:getLifeSkillLev(skillIndex)
	if level> limitLevel then  
		--发消息给客户端
	    local event = Event.getEvent(LifeSkillEvent_SC_upLevelNotice,1)
		g_eventMgr:fireRemoteEvent(event, player)
        return 
	else 
		if costState then
			local costs = UpSkillDB[1][skillIndex]
			--消耗银两
			local costMoney = costs[CostEnum.Bind][level+1]
			local money = player:getMoney() - costMoney
			player:setMoney(money)
			--消耗经验
			local xpValua = player:getAttrValue(player_xp)
			local costXp = xpValua - costs[CostEnum.Exp][level+1]
			player:setAttrValue(player_xp,costXp)
		
			if skillIndex ==7 then
				--提高逃跑成功率
				local escapRate =1 
				local playerEscapRate = player:getAttrValue(player_add_escape_rate)
				local addEscapRate = playerEscapRate+escapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateEscpeInfo,skillIndex,escapRate)
				g_eventMgr:fireRemoteEvent(event, player)
			
			elseif skillIndex==8 then
			    --提高捉宠成功率
				local catchRate = 1
				local playerCatchRate = player:getAttrValue(player_add_catchpet_rate)
				local addCatchRate = playerCatchRate+catchRate
				player:setAttrValue(player_add_catchpet_rate,addCatchRate)
				---- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateCatchInfo,skillIndex,catchRate)
				g_eventMgr:fireRemoteEvent(event, player)
		    end	
			
			--等级加1
			level = level+1	
			lifeSkillHandler:setLifeSkillLev(skillIndex, level)
			local newCostMoney = costs[CostEnum.Bind][level+1]
			local newCostXp = costs[CostEnum.Exp][level+1]
			-- 发消息给客户端
			local event = Event.getEvent(LifeSkillEvent_SC_upLevelInfo,skillIndex, level,newCostMoney,newCostXp)
			g_eventMgr:fireRemoteEvent(event, player)	
		else --表示在帮会处学习
			local costs = UpSkillDB[2][skillIndex]
			--消耗银两
			local costMoney =player:getMoney() - costs[CostEnum.Bind][level+1]
			player:setMoney(costMoney)
			
			--消耗帮贡
			local factionDBID = player:getFactionDBID()
			local bang = 0
			if factionDBID > 0 then
				bang = player:getFactionMoney()
				local bangValue = bang - costs[CostEnum.Bang][level+1]
				
				--等级加1
				level = level+1	
				lifeSkillHandler:setLifeSkillLev(skillIndex, level)
				local newCostMoney = costs[CostEnum.Bind][level+1]
			    local newCostBang = costs[CostEnum.Bang][level+1]
				--发消息给客户端
	            local event = Event.getEvent(LifeSkillEvent_SC_upLevelAndFreshInfo,skillIndex, level,newCostMoney,newCostBang)
			    g_eventMgr:fireRemoteEvent(event, player)
			else
		        return
			end
			
			if skillIndex ==7 then
				--提高自身逃跑成功率
				local escapRate = level + 1
				local playerEscapRate = player:getAttrValue(player_add_escape_rate)
				local addEscapRate = playerEscapRate+escapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				--降低当前敌方逃跑成功率
				local lowEnemyEscapRate =level + 1
				local enemyEscapRate = player:getAttrValue(player_reduce_escape_rate)
				local reduceEnemyEscapeRate = enemyEscapRate + lowEnemyEscapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateEscpeInfo,skillIndex,escapRate,lowEnemyEscapRate)
				g_eventMgr:fireRemoteEvent(event, player)
				
			
			elseif skillIndex==8 then
			    --提高捉宠成功率
				local catchRate = level + 1
				local playerCatchRate = player:getAttrValue(player_add_catchpet_rate)
				local addCatchRate = playerCatchRate+catchRate
				player:setAttrValue(player_add_catchpet_rate,addCatchRate)
				---- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateCatchInfo,skillIndex,catchRate)
				g_eventMgr:fireRemoteEvent(event, player)
		    end				
		end
	end
end

--学习升级生活技能,此学习是在银两足够的情况下学习的
function LifeSkillSystem:onLearnSkill(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local skillIndex = params[1]
	local costState = params[2]
	
	-- 获取玩家的等级
	local playerLev = player:getLevel()
	local limitLevel = playerLev + 10
    local lifeSkillHandler = player:getHandler(HandlerDef_LifeSkill)
	local level = lifeSkillHandler:getLifeSkillLev(skillIndex)
	if level>limitLevel then
		--发消息给客户端
	    local event = Event.getEvent(LifeSkillEvent_SC_upLevelNotice,1)
		g_eventMgr:fireRemoteEvent(event, player)
        return 
	else 	
		--当costState为true是表示在主城NPC处消耗，否则在帮会处消耗
		if costState then
			local costs = UpSkillDB[1][skillIndex]
			--判断玩家绑银是否小于配置值，防止客户端显示出现负数情况
			if player:getSubMoney()<costs[CostEnum.Bind][level+1] then 
				return
			else
				--消耗绑银
				local costMoney = player:getSubMoney() - costs[CostEnum.Bind][level+1]
				player:setSubMoney(costMoney)
				player:flushPropBatch()
			end	
			
			--判断玩家经验是否小于配置值，防止客户端显示出现负数情况
			if player:getAttrValue(player_xp)<costs[CostEnum.Exp][level+1] then 
				return
			else	
				--消耗经验
				local xpValua = player:getAttrValue(player_xp)
				local costXp = xpValua - costs[CostEnum.Exp][level+1]
				player:setAttrValue(player_xp,costXp)
				player:flushPropBatch()
			end
			
			--等级加1
			newLevel = level+1	
			if skillIndex ==7 then
				--提高逃跑成功率
				local escapRate =level+1
				local playerEscapRate = player:getAttrValue(player_add_escape_rate)
				local addEscapRate = playerEscapRate+escapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				--降低当前敌方逃跑成功率
				local lowEnemyEscapRate =level + 1
				local enemyEscapRate = player:getAttrValue(player_reduce_escape_rate)
				local reduceEnemyEscapeRate = enemyEscapRate + lowEnemyEscapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateEscpeInfo,skillIndex,escapRate,lowEnemyEscapRate)
				g_eventMgr:fireRemoteEvent(event, player)
			
			elseif skillIndex==8 then
			    --提高捉宠成功率
				local catchRate = level+1
				local playerCatchRate = player:getAttrValue(player_add_catchpet_rate)
				local addCatchRate = playerCatchRate+catchRate
				player:setAttrValue(player_add_catchpet_rate,addCatchRate)
				--发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateCatchInfo,skillIndex,catchRate)
				g_eventMgr:fireRemoteEvent(event, player)
		    end	
			
			
			lifeSkillHandler:setLifeSkillLev(skillIndex, newLevel)
			local newCostMoney = costs[CostEnum.Bind][newLevel+1]
			local newCostXp = costs[CostEnum.Exp][newLevel+1]
			-- 发消息给客户端
			local event = Event.getEvent(LifeSkillEvent_SC_upLevelInfo,skillIndex, newLevel,newCostMoney,newCostXp)
			g_eventMgr:fireRemoteEvent(event, player)
		else
		
		    local costs = UpSkillDB[2][skillIndex]
			
			--判断玩家绑银是否小于配置值，防止客户端显示出现负数情况
			if player:getSubMoney()<costs[CostEnum.Bind][level+1] then
				return
			else	
				--消耗绑银
				local costSubMoney = player:getSubMoney() - costs[CostEnum.Bind][level+1]
				player:setSubMoney(costSubMoney)
				player:flushPropBatch()
			end
			
			--消耗帮贡
			local factionDBID = player:getFactionDBID()
			local bang = player:getFactionMoney()
			local playerDBID = player:getDBID()
			
			--判断玩家帮贡是否小于配置值，防止客户端显示出现负数情况
			if bang < costs[CostEnum.Bang][level+1] then
				return
			else	
				if factionDBID > 0  then
					bang = player:getFactionMoney()
					local bangValue = bang - costs[CostEnum.Bang][level+1]
					player:setFactionMoney(bangValue)
					player:flushPropBatch()
					local event = Event.getEvent(FactionEvent_BB_UpdateFactionMemberInfo,"memberMoney",playerDBID,toNumber(bangValue))
					g_eventMgr:fireWorldsEvent(event,SocialWorldID)

					---等级加1
					newLevel = level+1
					lifeSkillHandler:setLifeSkillLev(skillIndex, newLevel)
					local newCostMoney = costs[CostEnum.Bind][newLevel+1]
					local newCostBang = costs[CostEnum.Bang][newLevel+1]

					--发消息给客户端
					local event = Event.getEvent(LifeSkillEvent_SC_upLevelAndFreshInfo,skillIndex, newLevel,newCostMoney,newCostBang)
					g_eventMgr:fireRemoteEvent(event, player)
				else
					return
				end
			end 
			
			if skillIndex ==7 then
				--提高逃跑成功率
				local escapRate =level + 1 
				local playerEscapRate = player:getAttrValue(player_add_escape_rate)
				local addEscapRate = playerEscapRate+escapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				--降低当前敌方逃跑成功率
				local lowEnemyEscapRate =level + 1
				local enemyEscapRate = player:getAttrValue(player_reduce_escape_rate)
				local reduceEnemyEscapeRate = enemyEscapRate + lowEnemyEscapRate
				player:setAttrValue(player_add_escape_rate,addEscapRate)
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateEscpeInfo,skillIndex,escapRate,lowEnemyEscapRate)
				g_eventMgr:fireRemoteEvent(event, player)
			
			elseif skillIndex==8 then
			    --提高捉宠成功率
				local catchRate = 1
				local playerCatchRate = player:getAttrValue(player_add_catchpet_rate)
				local addCatchRate = playerCatchRate+catchRate
				player:setAttrValue(player_add_catchpet_rate,addCatchRate)
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_updateCatchInfo,skillIndex,catchRate)
				g_eventMgr:fireRemoteEvent(event, player)
		    end		
		end
	end
end

function LifeSkillSystem:onProduct(event)  
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	
	local recipeID = params[1]
	local skillIndex = params[2]
	
	local result = true
	local packetHandler = player:getHandler(HandlerDef_Packet)
	
	local config = MateriaCostDB[skillIndex]
	if skillIndex==1 or skillIndex==2 then
		for _,costInfo in pairs(config) do
			local id = costInfo.recipeID
			if recipeID==id then
				local vigor = player:getAttrValue(player_vigor)
				if  vigor<costInfo.vigorCost then 
					result = false
					-- 发消息给客户端
					local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice, 2)
					g_eventMgr:fireRemoteEvent(event, player)
					break
				end	
			end	
		end	
	end
	
	if skillIndex==3 then
		for _,costInfo in pairs(config) do
			local id = costInfo.recipeID
			if recipeID==id then
				local itemCost = costInfo.itemsCost
				if itemCost then
					if table.size(itemCost)> 0 then
						local vigor = player:getAttrValue(player_vigor)
						if  vigor<costInfo.vigorCost then
							--for _,itemInfo in pairs(costInfo.itemsCost) do
							result = false
							-- 发消息给客户端
							local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice,2)
							g_eventMgr:fireRemoteEvent(event, player)
							break		
							
						else 
							local itemID = itemCost.itemID
							local itemNum = packetHandler:getNumByItemID(itemID)
							local pNum = itemCost.num
							if itemNum < pNum then 
								result = false
								-- 发消息给客户端
								local event = Event.getEvent(LifeSkillEvent_SC_productFailInfo, 3)
								g_eventMgr:fireRemoteEvent(event, player)
								break
							end	
						end	
					else
						local vigor = player:getAttrValue(player_vigor)
						if  vigor<costInfo.vigorCost then
							result = false
							
							local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice, 2)
							g_eventMgr:fireRemoteEvent(event, player)
							break	
						end
					end
				end	
			end	
		end	
	end
	
	if result then
		local vigor = player:getAttrValue(player_vigor)
		if skillIndex==1 or skillIndex==2 then
			for _,costInfo in pairs(config) do	    
				if recipeID == costInfo.recipeID then
					--消耗体力
					player:setAttrValue(player_vigor,vigor-costInfo.vigorCost)
					local successRate = self:productRate(recipeID)
					if successRate then
						--生产所获得的配方
						packetHandler:addItemsToPacket(recipeID, 1)
						
						--得到配方，发消息给客户端
						local event = Event.getEvent(LifeSkillEvent_SC_gainedRecipeNotice, recipeID,costInfo.vigorCost)
						g_eventMgr:fireRemoteEvent(event, player)
					else
						--消耗材料、体力未生产成功的银两补偿
						local randNum = math.random(0,20)
						local money = costInfo.demandLvl*10+ randNum

						local event = Event.getEvent(LifeSkillEvent_SC_returnMoneyNotice, money)
						g_eventMgr:fireRemoteEvent(event, player)
					end	
				end	
			end		
		end
		
		if skillIndex==3 then 
			for _,costInfo in pairs(config) do	    
				if recipeID == costInfo.recipeID then
					local itemCost = costInfo.itemsCost
					if itemCost then
						local  itemID = costInfo.itemsCost.itemID
						local  itemNum = costInfo.itemsCost.num
						--消耗材料
						packetHandler:removeByItemId(itemID, itemNum)                                                                                                    
						--通知客户端生活技能界面更新消耗数据
						local event = Event.getEvent(LifeSkillEvent_SC_updateInfo, itemID,recipeID)
						g_eventMgr:fireRemoteEvent(event, player)
					end
				
					--消耗体力
					player:setAttrValue(player_vigor,vigor-costInfo.vigorCost)
					local successRate = self:productRate(recipeID)
					if successRate then
						--生产所获得的配方
						packetHandler:addItemsToPacket(recipeID, 1)
						--得到配方，发消息给客户端
						local event = Event.getEvent(LifeSkillEvent_SC_gainedRecipeNotice, recipeID,costInfo.vigorCost)
						g_eventMgr:fireRemoteEvent(event, player)
					else
						--消耗材料、体力未生产成功的银两补偿
						local randNum = math.random(0,20)
						local money = costInfo.demandLvl*10+ randNum
						local event = Event.getEvent(LifeSkillEvent_SC_returnMoneyNotice, money)
						g_eventMgr:fireRemoteEvent(event, player)
					end
					--end
				end	
			end	
		end
	end
end
		


--生产随机的配方
function LifeSkillSystem:onProductRandRecipe(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	
	local skillIndex = params[1]
	local randRecipeID= params[2]
	
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local vigor = player:getAttrValue(player_vigor)
	--如果skillIndex等于1表示为烹饪技能里的随机配方
	if skillIndex==1 then
		local n = 2
		local fixItemID =1311082
		if  vigor>n then
			--获取玩家要消耗的材料1
			local itemNum1 = packetHandler:getNumByItemID(fixItemID)
			if itemNum1>=2 then
				--背包移除固定消耗材料1
				packetHandler:removeByItemId(fixItemID, 2)
				--消耗体力
				player:setAttrValue(player_vigor,vigor- n)
				--生产所获得的配方
				packetHandler:addItemsToPacket(randRecipeID, 1)
				--通知客户端所获得配方
				local event = Event.getEvent(LifeSkillEvent_SC_gainedRecipeNotice, randRecipeID,n,fixItemID)
				g_eventMgr:fireRemoteEvent(event, player)
				
			else
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice, 3)
				g_eventMgr:fireRemoteEvent(event, player)
			end
			
		else
			-- 发消息给客户端
			local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice, 2)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end	
	
	--如果skillIndex等于2表示为烹饪技能里的随机配方
	if skillIndex==2 then
		local n = 2
		local fixItemID2 =1311083
		if  vigor>n then
			--获取玩家要消耗的材料1
			local itemNum2 = packetHandler:getNumByItemID(fixItemID2)
			if itemNum2>=2 then
				--背包移除固定消耗材料1
				packetHandler:removeByItemId(fixItemID2, 2)
				--消耗体力
				player:setAttrValue(player_vigor,vigor- n)
				--生产所获得的配方
				packetHandler:addItemsToPacket(randRecipeID, 1)
				--通知客户端所获得配方
				local event = Event.getEvent(LifeSkillEvent_SC_gainedRecipeNotice, randRecipeID,n,fixItemID2)
				g_eventMgr:fireRemoteEvent(event, player)
				
			else
				-- 发消息给客户端
				local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice, 3)
				g_eventMgr:fireRemoteEvent(event, player)
			end		
		else
			-- 发消息给客户端
			local event = Event.getEvent(LifeSkillEvent_SC_vigorLackNotice,2)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
	
end

--随机产出配方ID
function LifeSkillSystem:randOutputRecipe(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	
	local skillIndex = params[1]--配置里的[1]表示烹饪和[2]表示炼药
	local productLevel = params[2]
	
	for k,recipeInfos in pairs(ItemProductDB or {})do
		if skillIndex ==k then 
			for recipeIndex,recipeInfo in pairs(recipeInfos)do
				local  recipeLevel = recipeInfo.level
				if  recipeLevel==productLevel then
					local recipeOutputInfo = recipeInfo.itemOutputs
					local ocIndex = self:getDropInfo(recipeOutputInfo)
					gainedRecipe = recipeOutputInfo[ocIndex]
					local randRecipeID = gainedRecipe.itemID
					
					--发送此随机配方到客户端，并执行生产按钮
					local event = Event.getEvent(LifeSkillEvent_SC_randedOutputRecipe,skillIndex,randRecipeID)
					g_eventMgr:fireRemoteEvent(event, player)
				end 
			end
		end	
	end
end

--配方产出权重处理
function LifeSkillSystem:getDropInfo(config)
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

--生产概率判断
function LifeSkillSystem:productRate(recipeID)
    for _,recipeInfo in pairs(MateriaCostDB or{}) do 
	    for _,costInfo in pairs(recipeInfo) do
		    if recipeID == costInfo.recipeID then
				local rate = costInfo.successRate
				local randRate = math.random(1,100)
				if randRate<=rate then
					return true
				else
					return false
				end
			end	
		end
	end	
	return nil
end

function LifeSkillSystem.getInstance()
	return LifeSkillSystem()
end

EventManager:getInstance():addEventListener(LifeSkillSystem.getInstance())
