--[[BeastBlessManager.lua 
描述:BeastBlessManager 瑞兽的管理
瑞兽管理链表设计为 活动表和死亡表
活动表结构
beastList = {
	[mapID] = {
		表记录
		beasts = {[npcID] = beast}
		数量计数
		beastCount = value
		最大数量
		beastMaxCount = value
		随机NPCDBID表
		beastsType = 
	}
}
死亡表结构为
beastDieList = 
{
	[mapID] = {[npcID] = beast}
}
战斗记录表是记录当前beast是否在战斗状态,是和战斗ID对应
奖励表是给玩家奖励机制
]]

BeastBlessManager = class(nil, Singleton)


function BeastBlessManager:__init()
	-- 存在瑞兽的管理
	self.beastList = {}
	-- 死亡瑞兽的管理
	self.beastDieList = {}
	-- 战斗记录标记
	self.beastFightFlag = {}
	-- 奖励记录
	self.rewardList = {}
end

function BeastBlessManager:__release()
	self.beastList = nil
	self.beastDieList = nil
	self.beastFightFlag = nil
	self.rewardList = nil
end

-- 初始化在线上的玩家
function BeastBlessManager:initOnLinePlayerData()
	local playerList = g_entityMgr:getPlayers()
	local activityId = g_beastBless:getID()
	for playerID,player in pairs(playerList) do
		print("在线玩家重置",activityId)
		local activityHandler = player:getHandler(HandlerDef_Activity)
		activityHandler:setPriDataById(activityId,0)
	end
end

-- 上线的玩家加入到活动表中
function BeastBlessManager:joinPlayer(player,recordList)
	print("beast$$recordList:",toString(recordList))
	local activityHandler = player:getHandler(HandlerDef_Activity)
	local activityId = g_beastBless:getID()
	print("activityId",activityId)
	if activityHandler then
		if recordList and table.size(recordList) > 0 then
			for _,data in pairs(recordList) do
				print("BeastBlessManager:",toString(data))
				if not time.isSameDay(data.recordTime) then
					-- 重置数据
					activityHandler:setPriDataById(activityId,0)
				else
					local fightCount = 0
					if data.fightCount then
						fightCount = data.fightCount 
					end
					print("设置私有数据fightCount")
					activityHandler:setPriDataById(activityId,fightCount)
				end
			end
		else
			print("设置私有数据")
			print("activityId",activityId)
			activityHandler:setPriDataById(activityId,0)
		end
	end
end

-- 把战斗记录标记加入到
function BeastBlessManager:addBeastFightFlagList(fightID,curNpc)
	local scene = curNpc:getScene()
	local mapID = scene:getMapID()
	local curBeastList = self.beastList[mapID]
	if curBeastList then
		local beastID = curNpc:getID()
		local beast = curBeastList.beasts[beastID]
		if beast then
			local beastFightFlag = self.beastFightFlag
			beast:setFighting(true)
			beastFightFlag[fightID] = beast
		else
			print("error:addBeastFightFlagList npcID")
		end
	else
		print("error:addBeastFightFlagList mapID")
	end
end

-- 移除记录标记
function BeastBlessManager:removeBeastFightFlagList(fightID)
	local beast = self.beastFightFlag[fightID]
	if beast then
		beast:setFighting(false)
		self.beastFightFlag[fightID] = nil
	end
end

function BeastBlessManager:getBeastFromFlagList(fightID)
	return self.beastFightFlag[fightID]
end

-- beast增加到死亡链表中
function BeastBlessManager:addBeastToDieList(beast)
	local beastDieList = self.beastDieList
	local mapID = beast:getMapID()
	local npcID = beast:getNpcID()
	-- 当前地图死亡链表
	local curMapDieList = nil
	if not beastDieList[mapID] then
		print("没有beastDieList")
		curMapDieList = {}
		curMapDieList[npcID] = beast
		beastDieList[mapID] = curMapDieList
	else
		curMapDieList = beastDieList[mapID]
		curMapDieList[npcID] = beast
	end
	print("addBeastToDieList：curMapDieList",toString(beastDieList[mapID]))
end

-- 从beastDie移除
function BeastBlessManager:removeBeastFromDieList(beast)
	local beastDieList = self.beastDieList
	local mapID = beast:getMapID()
	local npcID = beast:getNpcID()
	local curMapDieList = beastDieList[mapID]
	if curMapDieList then
		curMapDieList[npcID] = nil
	else
		print("$$　error:addBeastToDieList no ")
	end 
	print("从beastDie移除",toString(curMapDieList))
end 

-- 检查死亡表中是否存在这种beast
function BeastBlessManager:findBeastFromDieList(mapID,DBID)
	local beastDieList = self.beastDieList
	local curMapDieList = beastDieList[mapID]
	if curMapDieList then
		for npcID,beast in pairs(curMapDieList)do
			local curDBID = beast:getDBID()
			if DBID == curDBID then
				return beast
			end
		end
	else
		print("$$　error BeastBlessManager")
	end
	return nil
end

-- 查找是否有beast
function BeastBlessManager:findBeastFromList(npcID)
	local beastList =  self.beastList
	for mapID,curMapBeastList in pairs(beastList)do
		local beasts = curMapBeastList.beasts 
		if beasts then
			for curNpcID,beast in pairs(beasts)do
				if npcID == curNpcID then
					return beast
				end
			end
		end
	end
	return false
end

-- 增加一个beast给地图
function BeastBlessManager:addBeastToList(mapID)
	local beastList =  self.beastList
	local curMapBeastList = beastList[mapID]
	if curMapBeastList then
		local beastsTypes = curMapBeastList.beastsType
		local beasts = curMapBeastList.beasts
		local beastCount = curMapBeastList.beastCount
		-- beasts不存在
		if not beasts then
			print("beasts no this")
			beasts = {}
		end
		local npcDBID = BeastBlessUtils.randNpc(beastsTypes)
		print("npcDBID",npcDBID)
		-- 检查死亡表中是否存在这种类型的beast
		local beast = self:findBeastFromDieList(mapID,npcDBID)
		-- 检查死亡表中是否存在这种beast 如果存在直接加入到活动表中 否则创建新的加入到 活动链表中
		local npcID = nil
		if beast then
			print("beastDie")
			print("beasts",toString(beasts))
			npcID = beast:addBeastToMap(beasts)
			self:removeBeastFromDieList(beast)
		else
			print("self create")
			beast = Beast(npcDBID,mapID)
			npcID = beast:addBeastToMap(beasts)
		end
		if npcID then
			-- 这个场景中的所有beast
			beasts[npcID] = beast
			-- 数量加一
			curMapBeastList.beastCount = beastCount + 1
		end	
	else
		print("$$ addBeastToList no find this mapID")
	end
end

-- 从配置中把所有的瑞兽都添加到地图
function BeastBlessManager:initBeastToMap()
	local beastList =  self.beastList
	for _,data in pairs(tBeastBlessInMapDB) do
		local mapID = data.mapID
		-- 当前地图表
		local curMapBeastList = {}
		-- 当前地图瑞兽记录表
		local beasts = {}
		-- 当前地图瑞兽数量计数
		local beatCount = 0
		-- 
		for index = 1,data.npcNum do
			local npcDBID = BeastBlessUtils.randNpc(data.npcValues)
			-- 创建beast 
			local beast = Beast(npcDBID,mapID)
			-- 随机坐标 并加到场景中 不能再同一个坐标
			local npcID = beast:addBeastToMap(beasts)
			print("npcID:",npcID)
			if npcID then
				-- 这个场景中的所有beast
				beasts[npcID] = beast
				-- 数量加一
				beatCount = beatCount + 1
			end
		end
		-- 记录对应到表中
		curMapBeastList.beastCount = beatCount
		-- 记录最大数量
		curMapBeastList.beastMaxCount = data.npcNum
		-- 记录可以随机的NPC种类表
		curMapBeastList.beastsType = data.npcValues
		-- 所有的beast记录放入表中
		curMapBeastList.beasts = beasts
		-- 地图对应到表中
		beastList[mapID] = curMapBeastList
	end
end

-- 删除这个beast瑞兽
function BeastBlessManager:removeBeastFromList(beast)
	local beastList = self.beastList
	local mapID = beast:getMapID()
	local npcID = beast:getNpcID()
	if mapID and npcID then
		local curMapBeastList = beastList[mapID]
		if curMapBeastList then
			local beasts = curMapBeastList.beasts
			local beastCount = curMapBeastList.beastCount
			local beast = beasts[npcID]
			if beast then
				-- 从地图上移除
				beast:removeFromMap()
				-- 从beatlist移除
				beasts[npcID] = nil
				-- print("curMapBeastList.beastCount",curMapBeastList.beastCount)
				curMapBeastList.beastCount = beastCount - 1
				-- print("beastCount",curMapBeastList.beastCount)
				-- 添加到死亡表中
				self:addBeastToDieList(beast)
			end
		else
			print("$$　error removeBeastFromList no curMapBeastList")
		end
	else
		print("$$　error removeBeastFromList no mapID or npcID")
	end
end

-- 把地图中beast的数量增加
function BeastBlessManager:updateAllMapBeast()
	-- 检查beast管理表
	local beastList = self.beastList
	for mapID,curMapBeastList in pairs(beastList) do
		local beastMaxCount = curMapBeastList.beastMaxCount 
		local beastCount = curMapBeastList.beastCount 
		-- 数量没有满
		print("补充addBeastNum:",beastMaxCount,beastCount)
		if beastMaxCount >  beastCount then
			-- 补充beast
			local addBeastNum = beastMaxCount - beastCount
			print("补充addBeastNum:",addBeastNum)
			for index = 1,addBeastNum do
				print("index",index)
				self:addBeastToList(mapID)
			end
		end
	end
end

-- 更新每一个beast的时间
function BeastBlessManager:updateAllBeastTime()
	local beastList = self.beastList
	for mapID,curMapBeastList in pairs(beastList) do
		-- print("curMapBeastList.beastCount!!---->",curMapBeastList.beastCount)
		local beasts = curMapBeastList.beasts
		for beastID,beast in pairs(beasts) do
			if not beast:updateTime() then
				self:removeBeastFromList(beast)
			end
		end
	end
end

local timeCount = 1
function BeastBlessManager:minUpdate(currentTime)
	-- 每分钟更新 
	self:updateAllBeastTime()
	-- 5分钟刷新把NPC刷满
	if timeCount > 1 then
		local beastCount = 0
		-- 检查当前地图的beast存在量
		self:updateAllMapBeast()
	end
	timeCount = timeCount + 1
end


-- 战斗后奖励
local roleRewordType = {
	[eClsTypePlayer]	= {"playerExp","money","subMoney","playerTao", "combatNum","pot",},
	[eClsTypePet]		= {"petExp","petTao"},
}


-- 瑞兽活动奖励总接口
function BeastBlessManager:dealWithRewards(fightEndResults, scriptID, monsterDBIDs, fightID, fightInfo)
	-- 奖励计数
	self:dealWithRewardCount(fightEndResults, scriptID, fightInfo)
	-- 战斗胜利场数计数\
	self:dealFightCount(fightEndResults)
	-- 奖励提示
	self:dealRewardsTip(fightEndResults)
end

-- 得到玩家的人数 和玩家的临时表
function BeastBlessManager:getPlayerNum(fightEndResults)
	local playerNum = 0
	local tempPlayer = {}
	for roleID,isWin in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(roleID)
		if player then
			playerNum = playerNum + 1
			table.insert(tempPlayer,player)
		end
	end
	return playerNum,tempPlayer
end

-- 战斗胜利场数计数
function BeastBlessManager:dealFightCount(fightEndResults)
	-- 活动的id
	local activityId = g_beastBless:getID()
	
	for roleID,isWin in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(roleID)
		if player then
			local activityHandler = player:getHandler(HandlerDef_Activity)
			local fightCount = activityHandler:getPriData(activityId)
			-- 防御
			if not fightCount then
				fightCount = 0
			end
			-- 计数加一个数
			fightCount = fightCount + 1
			activityHandler:setPriDataById(activityId,fightCount)
		end
	end
end

local randRewordWeight = 100
function BeastBlessManager:dealWithRewardCount(fightEndResults, scriptID, fightInfo)
	-- 玩家的人数 
	if scriptID and ScriptFightDB[scriptID] then
		local rewardID = ScriptFightDB[scriptID].LuckyRewardID
		if rewardID then
			-- 玩家奖励配置
			local beastBlessReward = tBeastBlessRewardDB[rewardID]
			-- 玩家的人数
			local playerNum ,curPlayer = self:getPlayerNum(fightEndResults)
			-- 统计额外奖励
			self:doExtraRewardCount(fightInfo)
			if beastBlessReward then
				-- 把配置的数值奖励给玩家
				for roleID ,isWin in pairs(fightEndResults) do
					local player = g_entityMgr:getPlayerByID(roleID)
					if player then
						-- 处理值奖励
						self:addValueRewardToList(player,beastBlessReward)
					else
						local pet = g_entityMgr:getPet(roleID)
						if pet and (pet:getPetStatus() == PetStatus.Fight or pet:getPetStatus() == PetStatus.Ready) then
							self:addValueRewardToList(pet,beastBlessReward)
						end
					end
				end
				local itemsConfig = beastBlessReward.items
				-- 增加特殊物品的获得几率
				
				-- 选出物品奖励
				local itemID = BeastBlessUtils.randItem(itemsConfig)
				-- 把每这个个物品分配给玩家
				local maxWeight = randRewordWeight*playerNum
				local rand = math.random(maxWeight)
				local curWeight = 0
				for _,player in pairs(curPlayer) do
					if curWeight <= rand and rand < curWeight + randRewordWeight then
						self:addItemRewordToList(player,{{ID = itemID,count = 1}})	
						break
					end	
					curWeight = curWeight + randRewordWeight
				end	
			end
		end
	end
end

-- 额外奖励计数
function BeastBlessManager:doExtraRewardCount(fightInfo)
	local luckMonster  = fightInfo.LuckMonster 
	local nF = 0
	local mF = 0
	-- 额外奖励计数
	if luckMonster then
		-- 处理n m 和特殊计数
		if luckMonster.n then
			for DBID,nTimes in pairs(luckMonster.n) do
				nF = nF + nTimes
			end
		end
		if luckMonster.m then
			for DBID,mTimes in pairs(luckMonster.m) do
				mF = mF + mTimes
			end
		end
	end
	self.nF = nF
	self.mF = mF
end

-- 公式
function BeastBlessManager:getFormula(value)
	-- 公式计算 基础值 + 额外值
	return value * (1 + self.nF + self.mF)
end

-- 把值奖励加入链表 统计 一次性给玩家
function BeastBlessManager:addValueRewardToList(role,rewardNode)
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
	-- 奖励链条
	local rewardList = self.rewardList
	local roleID = role:getID()
	-- 奖励的名字
	for _,name in pairs(rewardNames) do
		local roleRecord = rewardList[roleID]
		if not roleRecord then
			roleRecord = {}
			rewardList[roleID] = roleRecord
		end
		local value = rewardNode[name]
		if value then
			local prev = roleRecord[name]
			value = self:getFormula(value)
			if prev then
				roleRecord[name] = prev  + value
			else
				roleRecord[name] = value
			end
		end
	end
end

-- 把物品奖励加入链表中 统计 一次性给玩家
function BeastBlessManager:addItemRewordToList(role,rewardNode)
	-- 检查是否是玩家
	if instanceof(role, Player) then
		local rewardList = self.rewardList
		-- 随机物品
		for _,item in pairs(rewardNode) do
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
	print("rewardList:",toString(rewardList))
end

function BeastBlessManager:dealRewardsTip(fightEndResults)
	local rewardList = self.rewardList
	for roleID, isWin in pairs(fightEndResults) do
		local role = g_entityMgr:getPlayerByID(roleID)
		if role then
			local msgID = 1
			local roleID = role:getID()
			local roleReward = rewardList[roleID]
			if roleReward then
				if roleReward.playerExp then
					role:addXp(roleReward.playerExp)
					self:sendRewardMessageTip(role, 2, roleReward.playerExp)
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
				if roleReward.playerTao then
					local tao = roleReward.playerTao + role:getAttrValue(player_tao)
					role:setAttrValue(player_tao, tao)
					self:sendRewardMessageTip(role, 5, roleReward.playerTao)
				end
				--战绩
				if roleReward.combatNum then
					local combatNum = roleReward.combatNum + role:getAttrValue(player_combat)
					role:setAttrValue(player_combat, combatNum)
					self:sendRewardMessageTip(role, 6, roleReward.combatNum)
				end
				--潜能
				if roleReward.pot then
					local potency = roleReward.pot + role:getAttrValue(player_pot)
					role:setAttrValue(player_pot, potency)
					self:sendRewardMessageTip(role, 7, roleReward.pot)
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
						else
							print("背包问题")
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
					if  roleReward.petExp then
						local petExp = roleReward.petExp
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
function BeastBlessManager:sendRewardMessageTip(player, msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_FightReward, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

function BeastBlessManager:getInstance()
	return BeastBlessManager()
end

g_periodChecker:addUpdateListener(BeastBlessManager:getInstance())


