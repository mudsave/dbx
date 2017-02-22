--[[DropManager.lua
描述：
	战斗掉落
--]]

require "base.base"


DropManager = class(nil, Singleton)

function DropManager:__init()
	-- 用来记录本次战斗所获得所有的奖励
	self.rewardList = {}
end

local roleRewordType = {
	[eClsTypePlayer]	= {"exp","money","subMoney","tao", "combatNum","potency",},
	[eClsTypePet]		= {"exp","petTao"},
}

-- 把值奖励加入链表中 统计 一次性给玩家
function DropManager:addValueRewordToList(role,rewardNode)
	-- 检查类型 和 是否合格
	local eType = role:getEntityType()
	-- 错误提示
	if not eType then
		print("奖励机制中的错误 奖励的人没有类型")
		return 1
	end
	local rewardNames = roleRewordType[eType]
	if not rewardNames then
		return 2
	end
	local rewardList = self.rewardList
	local roleID = role:getID()
	-- 奖励的名字
	for _, name in ipairs(rewardNames) do
		local roleRecord = rewardList[roleID]
		if not roleRecord then
			roleRecord = {}
			rewardList[roleID] = roleRecord
		end
		local value = rewardNode[name]
		if value then
			local prev = roleRecord[name]
			if prev then
				roleRecord[name] = prev  + value
			else
				roleRecord[name] = value
			end
		end
	end
end

-- 把物品奖励加入链表中 统计 一次性给玩家
function DropManager:addItemRewordToList(role,rewardNode)
	-- 检查是否是玩家
	if instanceof(role, Player) then
		local rewardList = self.rewardList
		for _, item in ipairs(rewardNode) do
			if item.ID and item.count then
				local itemID = item.ID
				local itemNum = item.count
				local roleID = role:getID()
				local roleRecord = rewardList[roleID]
				if not roleRecord then
					roleRecord = {}
					rewardList[roleID] = roleRecord
				end
				local itemInfo = roleRecord.item
				if not itemInfo then
					itemInfo = {}
					roleRecord.item = itemInfo
				end
				local prev = itemInfo[itemID]
				if not prev then
					itemInfo[itemID] = itemNum
				else
					itemInfo[itemID] = prev + itemNum
				end
			end
		end
	end
end

-- 战斗奖励总接口
function DropManager:dealWithRewards(FightEndResults,scriptID,monsterDBIDs, fightID)
	local bWin
	for playerID,isWin in pairs(FightEndResults) do
		bWin = isWin
		break
	end
	if not bWin then
		return
	end
	-- 如果没有这个配置
	if not ScriptFightDB[scriptID] then
		return
	end
	-- 没有瑞兽奖励配置不是这个接口
	if ScriptFightDB[scriptID].LuckyRewardID then
		return
	end
	-- 脚本奖励
	self:dealSriptReword(FightEndResults, scriptID , fightID)
	-- 怪物掉落奖励
	self:dealMonsterReword(FightEndResults, monsterDBIDs , fightID)
	-- 最后再从记录的表中 处理奖励和提示信息
	self:dealRewardsTip(FightEndResults, fightID)
end

-- 脚本奖励
function DropManager:dealSriptReword(FightEndResults,scriptID, fightID)
	-- 是否有脚本奖励
	if scriptID and ScriptFightDB[scriptID] then
		local rewards = ScriptFightDB[scriptID].rewards
		if rewards then
			-- 把脚本奖励给每一个玩家
			for roleID,isWin in pairs(FightEndResults) do
				local player = g_entityMgr:getPlayerByID(roleID)
				if player then
					self:addValueRewordToList(player,rewards)
					self:addItemRewordToList(player,rewards.mats)
				else
					local pet = g_entityMgr:getPet(roleID)
					if pet and (pet:getPetStatus() == PetStatus.Fight or pet:getPetStatus() == PetStatus.Ready) then
						self:addValueRewordToList(pet,rewards)
					end
				end
			end
		end
	end
end

-- 得到玩家的人数 和玩家的临时表
function DropManager:getPlayerNum(FightEndResults)
	local playerNum = 0
	local tempPlayer = {}
	for roleID,isWin in pairs(FightEndResults) do
		local player = g_entityMgr:getPlayerByID(roleID)
		if player then
			playerNum = playerNum + 1
			table.insert(tempPlayer,player)
		end
	end
	return playerNum,tempPlayer
end

local randRewordWeight = 100

function DropManager:dealMonsterReword(FightEndResults,monsterDBIDs, fightID)
	-- 玩家的人数 
	local playerNum ,curPlayer = self:getPlayerNum(FightEndResults)
	-- 物品的临时表
	local curItemList = {}
	-- 计算数值奖励
	for _, monsterDBID in ipairs(monsterDBIDs) do
		local monsterConfig = MonsterDB[monsterDBID] or NpcDB[monsterDBID]
		if not monsterConfig then
			print("没有这个怪物,请求检验是否有",monsterDBID)
		else
			for roleID,isWin in pairs(FightEndResults) do
				local player = g_entityMgr:getPlayerByID(roleID)
				if player then
					self:doMonsterValueReword(monsterConfig, player, playerNum,fightID)
				else
					local pet = g_entityMgr:getPet(roleID)
					if pet and (pet:getPetStatus() == PetStatus.Fight or pet:getPetStatus() == PetStatus.Ready) then
						self:doMonsterValueReword(monsterConfig, pet, playerNum,fightID)
						
					end
				end
			end
			-- 统计掉落物品的数量和种类
			self:getDropItems(curItemList,monsterConfig)
		end
	end
	--print("掉落的所有物品",toString(curItemList))
	-- 把每一个物品分配给玩家
	local maxWeight = randRewordWeight*playerNum
	for _,item in pairs(curItemList) do
		for i = 1,item.count do
			local curWeight = 0
			local rand = math.random(maxWeight)
			for _,player in pairs(curPlayer) do
				if curWeight <= rand and rand < curWeight + randRewordWeight then
					self:addItemRewordToList(player,{{ID = item.ID,count = 1}})
					break
				end	
			end
			
		end
	end
end

function DropManager:getDropItems(curItemList,monsterConfig)
	
	-- 得到怪物的掉落配置ID
	if monsterConfig.dropID and monsterConfig.dropID > 0 then
		--得到怪物具体的掉落配置
		local DropData = MonsterDropsDB[monsterConfig.dropID]
		if not DropData then
			print("没有这个掉落的ID配置",monsterConfig.dropID)
			return DropData
		end
		-- 有三种掉落
		if DropData.worldDrop and DropData.worldDrop == 1 then
			-- 世界掉落
			self:doWorldDrop(curItemList)
			-- 等级掉落
			self:doLevelDrop(monsterConfig,curItemList)
		end
		-- 自身掉落
		self:doMosterSelfDrop(DropData,curItemList)
	end
end


function DropManager:getRandItem(config)
	local maxWeight = 0
	-- 计算总权重
	for _, item in pairs(config) do
		maxWeight = maxWeight + item.weight
	end
	-- 得到随机物
	local rand = math.random(maxWeight)
	local curWeight  = 0
	for _,item in pairs(config) do
		if rand >= curWeight and rand < curWeight +  item.weight then
			return item
		end
		curWeight = curWeight +  item.weight
	end	
end

-- 世界掉落
function DropManager:doWorldDrop(curItems)
	if not WorldDropConfig then
		print("WorldDropConfig.lua 没有配置")
	end
	local wordItem = self:getRandItem(WorldDropConfig)
	if wordItem then
		table.insert(curItems, wordItem)
	else 
		print("世界掉落 有错误")
	end
end

-- 等级掉落
function DropManager:doLevelDrop(monsterConfig,curItems)
	if not LevelDropsConfig then
		print("LevelDropsConfig表没有配置")
	end
	local level = monsterConfig.level or 1
	for _,config in ipairs(LevelDropsConfig) do
		if level >= config.minLevel and level <= config.maxLevel then
			local levelDrop = self:getRandItem(config.items)
			if levelDrop then
				-- print("等级取物品取到的是",toString(levelDrop))
				table.insert(curItems,levelDrop)
			else
				print("等级掉落 有错误")
			end
		end
	end
end

-- 怪物自身掉落
function DropManager:doMosterSelfDrop(DropData,curItems)
	-- 临时记录
	local tempDropItems = {}
	local tempItems = {}
	-- 计算怪物掉落道具的个数
	for _,dropItemInfo in pairs(DropData) do
		if type(dropItemInfo) ~= "number" and dropItemInfo.dropItemPercent then
			tempDropItems[dropItemInfo.dropItemID] = dropItemInfo
		end
	end
	-- 本次掉落的物品类型总数记录
	local itemKindCount = 0
	-- 这个因为配置的关系
	if not DropData.dropKindCount then
		-- 根据配置物品数量 每一个出现
		local min = 1
		local max = table.size(tempDropItems)
		itemKindCount = math.random(min,max)
	else
		-- 通过状态判断总数的取值
		if table.size(DropData.dropKindCount) == 1 then
			-- 确定数值
			itemKindCount = DropData.dropKindCount[1]
		elseif table.size(DropData.dropKindCount) == 2 then
			-- 范围数值
			local min = DropData["dropKindCount"][1]
			local max = DropData["dropKindCount"][2]
			itemKindCount = math.random(min,max)
		elseif table.size(monDrops.dropKindCount) == 0 then
			-- 根据配置物品数量 每一个出现
			local min = 1
			local max = table.size(tempDropItems)
			itemKindCount = math.random(min,max)
		end
	end
	if itemKindCount <= 0 then 
		print("没有掉落物品，运气不好")
		return 
	end
	if itemKindCount > 0 then
		-- 把这几种物品选出来
		for var = 1,math.huge do 
			-- 权重计数
			local maxWeight = 0
			for _,item in pairs(tempDropItems) do
				maxWeight = maxWeight + item.dropItemPercent
			end
			local rand = math.random(maxWeight)
			local curWeight = 0
			local nextWeight = 0
			for _,item in pairs(tempDropItems) do
				nextWeight = curWeight + item.dropItemPercent 
				if rand >= curWeight and rand <  nextWeight then
					-- 选中的物品
					tempItems[item.dropItemID] = item 
					-- 把这个物品从临时表里清除
					tempDropItems[item.dropItemID] = nil
					-- 选中了一种物品 种类数减一
					itemKindCount = itemKindCount - 1
					break
				else
					curWeight = nextWeight
				end
			end
			-- 种类选择完成
			if itemKindCount <= 0 then
				break
			end
		end
	end
	-- print("总共需要取"..table.size(tempItems) .."种物品")
	-- 把选中种类的物品 数量确定
	if table.size(tempItems) <= 0 then
		print("错误提示！！物品掉落没有选中一种物品")
	end
	for itemID,item in pairs(tempItems) do
		if table.size(item.dropItemCount) == 1 then
			-- 确定数值
			table.insert(curItems,{ID = item.dropItemID, count = item.dropItemCount[1]})
			-- print("取到的是",item.dropItemID,item.dropItemCount[1])
		elseif table.size(item.dropItemCount) == 2 then 
			-- 范围数值
			local min = item["dropItemCount"][1]
			local max = item["dropItemCount"][2]
			local count = math.random(min,max)
			-- print("取到的是",item.dropItemID,count)
			table.insert(curItems,{ID = item.dropItemID, count = count})
		end
	end
end

-- 经验减少 因为等级的关系
function DropManager:getCompareLevel(monsterConfig, role, fightID)
	--收集材料任务物品世界掉落
	--1051021 0.3 1051022 0.6 不掉落0.1
	if monsterConfig.level and instanceof(role ,Player) then
		if role:getLevel() >= monsterConfig.level + 5 or role:getLevel() <= monsterConfig.level - 5 then
			local packetHandler = role:getHandler(HandlerDef_Packet)
			local rand = math.random(100)
			local itemInfo = {}
			local allItem = {}
			if rand >= 1 and rand <= 40 then
				itemInfo = nil
			elseif rand > 40 and rand <= 60 then
				packetHandler:addItemsToPacket(1051005 ,1)
				itemInfo.itemID = 1051005
				itemInfo.itemNum = 1
			elseif rand > 60 and rand <= 100 then
				packetHandler:addItemsToPacket(1051006 ,1)
				itemInfo.itemID = 1051006
				itemInfo.itemNum = 1
			end
			if table.size(itemInfo) > 0 then
				table.insert(allItem,itemInfo)
				self:sendRewardMessageTip(role, 8, allItem)
			end
		end
	end

	local curExp = monsterConfig.expPrize
	if not curExp then
		return nil
	end
	local fightType = g_fightMgr:getFightType(fightID)
	if not fightType then
		print("没有战斗类型",fightType)
	end
	if fightType and fightType == FightBussinessType.Wild then
			local difference = monsterConfig.level  - role:getLevel()
			if difference < 0 then
				difference = 0 - difference
			end
			if difference >= 10 then
				curExp = 1
			else
				local tmpExp = curExp*10/100
				curExp = curExp - tmpExp*difference
			end
		end
	return curExp
end

-- 奖励的计算公式
function DropManager:getPrizeFormula(role, playerNum, value, type)
	-- 判断是否增加组队额外值 倍数
	local extraTime = 0 -- 0 没有额外值 1 队员额外值 2队长额外值
	if playerNum <= 1 then
		extraTime = 0
	else
		extraTime = playerNum
		if instanceof(role,Player) then
			local teamHandler = role:getHandler(HandlerDef_Team)
			if teamHandler:isLeader() then
				extraTime = 2*playerNum
			end
		end
	end
	if value then
		if value > 0 then
			value = value + extraTime * value/100
			-- 向上取整
			value = math.ceil(value)
			return value
		elseif value == -1 then
			local num
			if type == DropType.PlayerTao then
				local level = role:getLevel()
				local curTao = role:getAttrValue(player_tao)
				num = math.floor((level^3)/(curTao + 10))
			elseif type == DropType.Pot then
				local level = role:getLevel()
				num = level^2+1000
			elseif type == DropType.PetTao then
				local level = role:getLevel()
				local curTao = role:getAttrValue(pet_tao)
				num = math.floor((level^3)/(curTao + 10))
			else
				 num = role:getLevel()*8+20
			end
			num = num + num * extraTime/100
			num = math.ceil(num)
			return num
		end
	end
	return nil
end

function DropManager:doMonsterValueReword(monsterConfig, role, playerNum,fightID)
	-- 把配置转化过来
	local rewardNode = {}
	-- 经验减少
	local curRewordExp = self:getCompareLevel(monsterConfig,role,fightID)
	-- 基础数值 + 额外值
	rewardNode.exp		= self:getPrizeFormula(role,playerNum,curRewordExp, DropType.Exp)
	rewardNode.subMoney	= self:getPrizeFormula(role,playerNum,monsterConfig.bindMoneyPrize, nil)
	rewardNode.tao		= self:getPrizeFormula(role,playerNum,monsterConfig.taoExpPrize, DropType.PlayerTao)
	rewardNode.combatNum= self:getPrizeFormula(role,playerNum,monsterConfig.combatNumPrize, nil)
	rewardNode.potency	= self:getPrizeFormula(role,playerNum,monsterConfig.potencyPrize, DropType.Pot)
	if instanceof(role, Pet) then
		rewardNode.petTao = self:getPrizeFormula(role,playerNum,monsterConfig.petTaoPrize, DropType.PetTao)
	end
	local buffHandler = role:getHandler(HandlerDef_Buff)
	if buffHandler then
		local isXpBoost,BoostValue = buffHandler:getXpBoost() 
		if isXpBoost and monsterConfig.addDouble == 1 then
			print("我是有经验丹的人",BoostValue)
			rewardNode.exp = rewardNode.exp * BoostValue  
			rewardNode.subMoney = rewardNode.subMoney * BoostValue
			rewardNode.tao = rewardNode.tao * BoostValue
			rewardNode.combatNum = rewardNode.combatNum * BoostValue
			rewardNode.potency = rewardNode.potency * BoostValue
		end
	end
	-- 插入到链表中
	self:addValueRewordToList(role,rewardNode)
end



-- 奖励加到玩家中和提示
function DropManager:dealRewardsTip(FightEndResults, fightID)
	local rewardList = self.rewardList
	for roleID, isWin in pairs(FightEndResults) do
		local role = g_entityMgr:getPlayerByID(roleID)
		if role then
			local msgID = 1
			local roleID = role:getID()
			local roleReward = rewardList[roleID]
			if roleReward then
				if roleReward.exp then--玩家时双倍经验丹状态，则玩家和宠物战斗后所得经验都为双倍
					role:addXp(roleReward.exp)
					self:sendRewardMessageTip(role, 2, roleReward.exp)
				end
				if roleReward.money then
					local money = roleReward.money + role:getMoney()
					role:setMoney(money)
					self:sendRewardMessageTip(role, 3, roleReward.money)
				end
				if roleReward.subMoney then
					local subMoney = roleReward.subMoney + role:getSubMoney()
					role:setSubMoney(subMoney)
					self:sendRewardMessageTip(role, 4, roleReward.subMoney)
				end
				--道行
				if roleReward.tao then
					local tao = roleReward.tao + role:getAttrValue(player_tao)
					role:setAttrValue(player_tao, tao)
					self:sendRewardMessageTip(role, 5, roleReward.tao)
				end
				
				--战绩
				if roleReward.combatNum then
					local combatNum = roleReward.combatNum + role:getAttrValue(player_combat)
					role:setAttrValue(player_combat, combatNum)
					self:sendRewardMessageTip(role, 6, roleReward.combatNum)
				end
				--潜能
				if roleReward.potency then
					local potency = roleReward.potency + role:getAttrValue(player_pot)
					role:setAttrValue(player_pot, potency)
					self:sendRewardMessageTip(role, 7, roleReward.potency)
				end
				if roleReward.item then
					local packetHandler = role:getHandler(HandlerDef_Packet)
					local params = false
					local allItem = {}
					for itemID, itemNum in pairs(roleReward.item) do
						-- 把物品给玩家
						if packetHandler:addItemsToPacket(itemID, itemNum) then
							local itemInfo = {}
							itemInfo.itemID = itemID
							itemInfo.itemNum = itemNum
							table.insert(allItem,itemInfo)
						end
					end
					if table.size(allItem) > 0 then
						self:sendRewardMessageTip(role, 8, allItem)
					end
				end
				role:flushPropBatch()
			end
		else
			local pet = g_entityMgr:getPet(roleID)
			if pet then
				-- 宠物奖励提示
				local petID = pet:getID()
				local playerID = pet:getOwnerID()
				local player = g_entityMgr:getPlayerByID(playerID)
				local roleReward = rewardList[petID]
				if roleReward then
					
					if  roleReward.exp then
						local petExp = roleReward.exp
						if  pet:getPetStatus() == PetStatus.Ready then
							petExp = math.floor(ReadyPetExpOff*petExp/100)
						end
						pet:addXp(petExp)
						self:sendRewardMessageTip(player, 9, petExp)
					end
					--宠物道行
					if roleReward.petTao then 
						local tao = roleReward.petTao + pet:getAttrValue(pet_tao)
						pet:setAttrValue(pet_tao, tao)
						self:sendRewardMessageTip(player, 10, roleReward.petTao)
					end
					pet:flushPropBatch()
				end
			end
		end
	end
	-- 清空
	self.rewardList = {}
end

-- 发送给客户端消息
function DropManager:sendRewardMessageTip(player, msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_FightReward, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 处理惩罚
function DropManager:dealWithPunish(FightEndResults,scriptID, fightID)
	local deadPets = {}
	
	for roleID,isWin in pairs(FightEndResults) do
		local player = g_entityMgr:getPlayerByID(roleID)

		if player then
			print("----------处理惩罚------getHP--",player:getHP())
			if g_sceneMgr:isInGoldHuntScene(player) then
				return
			end
			--死亡惩罚
			--如果具有血池Buff，则传送回桃源镇
			local buffHandler = player:getHandler(HandlerDef_Buff)

			if player:getLevel() <= FullMaxHpMpLevel then
				local maxHP = player:getAttrValue(player_max_hp)
				player:setHP(maxHP)
				local maxMP = player:getAttrValue(player_max_mp)
				player:setMP(maxMP)
			end

			if player:getHP() == 0 then
				local times = 1
				if not buffHandler:getGodBless() then
					--如果没有护心buff则生命值变为1%，减装备耐久度，如果有则调用战斗结束接口
					local maxHP = player:getAttrValue(player_max_hp)
					local hp = math.floor(0.01*maxHP)
					if hp == 0 then
						hp = 1
					end
					player:setHP(hp)
				else
					g_buffMgr:onFightEndGodBless(player)
				end
								
				--pk保护buff
				
				local pkInfo = player:getPkInfo()
				if (not isWin) and pkInfo.isPK and (not pkInfo.isAttacker) then
					local buffHandler = player:getHandler(HandlerDef_Buff)
					g_buffMgr:addBuff(player, PKShieldBuffID)
		
				--切磋失败满血满蓝
				elseif (not isWin) and ( pkInfo.isPK == false)  then
					local maxHP = player:getAttrValue(player_max_hp)
					player:setHP(maxHP)
					local maxMP = player:getAttrValue(player_max_mp)
					player:setMP(maxMP)
				--pk失败
				elseif (not isWin) and (pkInfo.isPK)  then
					if pkInfo.hasBuff then
						times = PKPunishBuffTimes
					else
						times = PKPunishTimes
					end
				end

				-- 战斗结束后角色死亡，处理装备耐久度
				local equipHandler = player:getHandler(HandlerDef_Equip)
				equipHandler:onFightEnd(true,times)
			else
				-- 战斗结束后角色没有死亡，处理装备耐久度
				local equipHandler = player:getHandler(HandlerDef_Equip)
				equipHandler:onFightEnd(false)
			end
			--pk加杀气
			if  isWin then
				local pkInfo = player:getPkInfo()
				local curKill = player:getAttrValue(player_kill)
				if curKill > 0 and curKill < MaxKillValue and pkInfo.isPK and (not pkInfo.isAttacker) then
					player:setAttrValue(player_kill, curKill+1)
				end
			end
			player:flushPropBatch()
		else
			local pet = g_entityMgr:getPet(roleID)
			if pet and pet:getHP() == 0 then
				local maxHP = pet:getAttrValue(pet_max_hp)
				pet:setHP(maxHP)
				local curTao = pet:getAttrValue(pet_tao)--"pet_tao"
				local level = pet:getAttrValue(pet_lvl)
				local reduceTao = math.floor(DeadReducePetTao*level)
				local leftTao
				if curTao >= reduceTao then
					leftTao = curTao - reduceTao
				else
					reduceTao = curTao
					leftTao = 0
				end
				pet:setAttrValue(pet_tao, leftTao)
				if reduceTao > 0 then
					local ownerID = pet:getOwnerID()
					if not deadPets[ownerID] then
						deadPets[ownerID] = {}
					end
					deadPets[ownerID][pet:getID()] = reduceTao
				end
				pet:flushPropBatch()
			end
		end 
	end
	if table.size(deadPets) > 0 then
		for playerID, petInfo in pairs(deadPets) do
			local player = g_entityMgr:getPlayerByID(playerID)
			print(playerID,player)
			local event = Event.getEvent(PetEvent_SC_PetDeadPunish, petInfo)
			g_eventMgr:fireRemoteEvent(event, player)
			print("_________________PetEvent_SC_PetDeadPunish")
		end
	end
end

function DropManager.getInstance()
	return DropManager()
end
