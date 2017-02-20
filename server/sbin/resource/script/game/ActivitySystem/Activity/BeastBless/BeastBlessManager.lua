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
	local activityHandler = player:getHandler(HandlerDef_Activity)
	local activityId = g_beastBless:getID()
	if activityHandler then
		if recordList and table.size(recordList) > 0 then
			for _,data in pairs(recordList) do
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
function BeastBlessManager:addBeastFightFlagList(playerID,curNpc)
	local scene = curNpc:getScene()
	local mapID = scene:getMapID()
	local curBeastList = self.beastList[mapID]
	if curBeastList then
		local beastID = curNpc:getID()
		local beast = curBeastList.beasts[beastID]
		if beast then
			local beastFightFlag = self.beastFightFlag
			beast:setFighting(true)
			beastFightFlag[playerID] = beast
		else
			print("error:addBeastFightFlagList npcID")
		end
	else
		print("error:addBeastFightFlagList mapID")
	end
end

-- 移除记录标记
function BeastBlessManager:removeBeastFightFlagList(playerID)
	local beast = self.beastFightFlag[playerID]
	if beast then
		beast:setFighting(false)
		self.beastFightFlag[playerID] = nil
	end
end

function BeastBlessManager:getBeastFromFlagList(playerID)
	return self.beastFightFlag[playerID]
end

-- beast增加到死亡链表中
function BeastBlessManager:addBeastToDieList(beast)
	local beastDieList = self.beastDieList
	local mapID = beast:getMapID()
	local npcID = beast:getNpcID()
	-- 当前地图死亡链表
	local curMapDieList = nil
	if not beastDieList[mapID] then
		curMapDieList = {}
		curMapDieList[npcID] = beast
		beastDieList[mapID] = curMapDieList
	else
		curMapDieList = beastDieList[mapID]
		curMapDieList[npcID] = beast
	end
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
			-- print("beasts",toString(beasts))
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
function BeastBlessManager:createBeastToMap(config)
	local beastList =  self.beastList
	-- 地图ID集
	local mapInfo = config.mapID
	-- 随机beast
	local npcValues = config.npcValues
	-- 每个地图瑞兽的数量
	local npcNum = config.npcNum
	for _,data in pairs(mapInfo) do
		-- 当前地图表
		local mapID = data.mapID
		local npcNum = data.npcNum
		local curMapBeastList = {}
		-- 当前地图瑞兽记录表
		local beasts = {}
		-- 当前地图瑞兽数量计数
		local beatCount = 0
		-- 
		for index = 1,npcNum do
			local npcDBID = BeastBlessUtils.randNpc(npcValues)
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
		curMapBeastList.beastMaxCount = npcNum
		-- 记录可以随机的NPC种类表
		curMapBeastList.beastsType = npcValues
		-- 所有的beast记录放入表中
		curMapBeastList.beasts = beasts
		-- 地图对应到表中
		beastList[mapID] = curMapBeastList
	end
end

-- 销毁所有的瑞兽
function BeastBlessManager:destroyAllBeast()
	-- 销毁
	local beastList = self.beastList
	local beastDieList = self.beastDieList
	-- 销毁活动的瑞兽
	for mapID,data in pairs(beastList) do
		local beasts = data.beasts
		for beastID,beast in pairs(beasts) do
			beast:removeFromMap()
			g_entityMgr:removeNpc(beastID)
		end
	end
	for beastID,beast in pairs(beastDieList) do
		g_entityMgr:removeNpc(beastID)
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
			print("$$　no curMapBeastList")
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


-- 瑞兽活动奖励总接口
function BeastBlessManager:dealWithRewards(fightEndResults, scriptID, monsterDBIDs, fightID, fightInfo)
	print("fightInfo:::",toString(fightInfo))
	-- 战斗胜利场数计数
	self:dealFightCount(fightEndResults)
	-- 奖励计数
	self:dealWithRewardCount(fightEndResults, scriptID, fightInfo)
	-- 奖励提示
	self:dealRewardsTip(fightEndResults)
end

-- 得到可以获得正常奖励玩家 和宠物 的人数和玩家的临时表还有侠义奖励的临时表
function BeastBlessManager:getPlayerNum(fightEndResults)
	-- 活动的id
	local activityId = g_beastBless:getID()
	local playerNum = 0
	local normalRewardPlayer = {}
	local specialRewardPlayer = {}
	local normalRewardPet = {}
	local specialRewardPet = {}
	for roleID,isWin in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(roleID)
		if player then
			local activityHandler = player:getHandler(HandlerDef_Activity)
			local fightCount = activityHandler:getPriData(activityId)
			if fightCount <= BeastBlessReword then
				playerNum = playerNum + 1
				normalRewardPlayer[roleID] = player
			else
				specialRewardPlayer[roleID] = player
			end
		else
			local pet = g_entityMgr:getPet(roleID)
			if pet and (pet:getPetStatus() == PetStatus.Fight or pet:getPetStatus() == PetStatus.Ready) then
				local playerID = pet:getOwnerID()
				local player = g_entityMgr:getPlayerByID(playerID)
				local activityHandler = player:getHandler(HandlerDef_Activity)
				local fightCount = activityHandler:getPriData(activityId)
				if fightCount > BeastBlessReword then
					normalRewardPet[roleID] = pet
				else
					specialRewardPet[roleID] = pet
				end
			end
		end
	end
	-- print("playerNum,normalRewardPlayer,specialRewardPlayer,normalRewardPet,specialRewardPet",playerNum,toString(normalRewardPlayer))
	return playerNum,normalRewardPlayer,specialRewardPlayer,normalRewardPet,specialRewardPet
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

function BeastBlessManager:dealWithRewardCount(fightEndResults, scriptID, fightInfo)
	-- 玩家的人数 
	if scriptID and ScriptFightDB[scriptID] then
		local rewardID = ScriptFightDB[scriptID].LuckyRewardID
		if rewardID then
			-- 玩家奖励配置
			local beastBlessReward = tBeastBlessRewardDB[rewardID]
			if beastBlessReward then
				-- 玩家的人数
				local playerNum,normalRewardPlayer,specialRewardPlayer,normalRewardPet,specialRewardPet = self:getPlayerNum(fightEndResults)
				-- 正常奖励 = 基础奖励 + 额外奖励	
				local valueRewordsConfig = beastBlessReward.valueRewards
				-- 值奖励计算
				self:dealValueReward(normalRewardPlayer,normalRewardPet,valueRewordsConfig,fightInfo)
				-- 物品奖励计算
				local itemsConfig = beastBlessReward.items
				-- 统计额外奖励
				self:dealItemReward(normalRewardPlayer,itemsConfig,fightInfo,playerNum)
				-- 侠义奖励
				local specialItemsConfig = beastBlessReward.specialItem
				self:dealspecialReward(specialRewardPlayer,specialRewardPet,specialItemsConfig)
			end
		end
	end
end

local function getBeastBlessUtilsFunc(str,baseValue,changeValue)
	local func,success = loadstring(("return (%s)"):format(str))
	if success then
		return func(baseValue,changeValue)
	end
end

-- 公式
function BeastBlessManager:getFormula(role,rewardsConfig,fightInfo)
	local luckMonster  = fightInfo.LuckMonster 
	local playerLvl = role:getLevel()
	local rewardNode = {} -- 临时
	
	-- 检查类型 和 是否合格
	local eType = role:getEntityType()
	-- 错误提示
	if not eType then
		print("奖励机制中的错误 奖励的人没有类型")
		return 1
	end
	local rewardNames = BeastRoleRewordType[eType]
	if not rewardNames then
		return 2
	end
	-- 计算奖励基础值
	print("计算奖励基础倢",toString(rewardsConfig),value)
	for _,name in pairs(rewardNames) do
		local value = rewardsConfig[name]
		if value then
			print("原有奖励基础值:",toString(name),value)
			if eType == eClsTypePlayer then
				value = BeastBlessUtils.getPlayerBaseRewardFormula(playerLvl,value)
			else
				value = BeastBlessUtils.getPetBaseRewardFormula(playerLvl,value)
			end
			print("计算奖励基础值:",toString(name),value)
			rewardNode[name] = value
		end
	end
	if eType == eClsTypePlayer then
		-- 额外奖励计数
		if luckMonster then
			-- 额外奖励计数
			if luckMonster.n then
				print("额外奖励计数:",toString(luckMonster.n))
				for DBID,nTimes in pairs(luckMonster.n) do
					local rewardType = BeastBlessExtraReward[DBID]
					local name = BeastBlessToValueReward[rewardType]
					local prev = rewardNode[name]
					if prev then
						if rewardType == BeastBlessDropType.playerExp then
							rewardNode[name] = prev + BeastBlessUtils.getExpFormula(prev,nTimes)
						elseif rewardType == BeastBlessDropType.subMoney then
							rewardNode[name] = prev + BeastBlessUtils.getSubMoneyFormula(prev,nTimes)
						elseif rewardType == BeastBlessDropType.playerTao then
							rewardNode[name] = prev + BeastBlessUtils.getTaoFormula(prev,nTimes)
						elseif rewardType == BeastBlessDropType.playerDecSubmoney then
							rewardNode[name] = prev + BeastBlessUtils.getDecSubMoneyFormula(prev,nTimes)
						end
					end
				end
			end
			-- 对对碰奖励
			if luckMonster.m then
				for DBID,mTimes in pairs(luckMonster.m) do
					local rewardType = BeastBlessExtraReward[DBID]
					local name = BeastBlessToValueReward[rewardType]
					local prev = rewardNode[name]
					if prev then
						if rewardType == BeastBlessDropType.playerExp then
							rewardNode[name] = prev + BeastBlessUtils.getDExpFormula(prev,nTimes)
						elseif rewardType == BeastBlessDropType.subMoney then
							rewardNode[name] = prev + BeastBlessUtils.getDSubMoneyFormula(prev,nTimes)
						elseif rewardType == BeastBlessDropType.playerTao then
							rewardNode[name] = prev + BeastBlessUtils.getDTaoFormula(prev,nTimes)
						end
					end
				end
			end
		end
	end
	-- 加入到总表中
	if table.size(rewardNode) > 0 then
		self:addValueRewardToList(role,rewardNode)
	end
end

-- 值奖励计算 正常奖励 = 基础奖励 + 额外奖励 + 对对碰奖励
function BeastBlessManager:dealValueReward(normalRewardPlayer,normalRewardPet,rewardsConfig,fightInfo)
	-- 把配置的数值奖励给玩家
	for roleID ,player in pairs(normalRewardPlayer) do
		self:getFormula(player,rewardsConfig,fightInfo)
	end
	
	-- 把配置的数值奖励给宠物
	for petID, pet in pairs(normalRewardPet) do
		self:getFormula(player,rewardsConfig,fightInfo)
	end
end

-- 物品奖励
local randRewordWeight = 100

function BeastBlessManager:dealItemReward(normalRewardPlayer,itemsConfig,fightInfo,playerNum)
	if playerNum == 0 then
		return
	end
	local luckMonster  = fightInfo.LuckMonster 
	local specialCountN = 0 -- 特殊怪的计数
	local specialCountM = 0 -- 特殊怪对数计数
	local specialItem = nil
	local curItems = {}
	-- 统计特殊福利怪
	if luckMonster then
		if luckMonster.n then
			for DBID,nTimes in pairs(luckMonster.n) do
				if DBID == BeastBlessSpecialMonster then
					specialCountN = specialCountN + nTimes
				end
			end
		end
		if luckMonster.m then
			for DBID,mTimes in pairs(luckMonster.m) do
				if DBID == BeastBlessSpecialMonster then
					specialCountM = specialCountM + mTimes
				end
			end
		end
	end
	
	-- 把当前的配置
	if specialCountN > 0 then
		for _,data in pairs(itemsConfig) do
			if data.itemID ~= BeastBlessSpecialItem then
				table.insert(curItems,data)
			else
				specialItem = data
			end
		end
		-- 增加几率
		if table.size(specialItem) then
			specialItem.weight = BeastBlessUtils.getDItemFormula(specialItem.weight,specialCountN,specialCountM)
			table.insert(curItems,specialItem)
		else
			print("specialItem逻辑出错")
		end	
	else
		for _,data in pairs(itemsConfig) do
			table.insert(curItems,data)
		end
	end
	
	-- 选出物品奖励
	local itemID = BeastBlessUtils.randItem(curItems)
	-- 把每这个个物品分配给玩家
	local maxWeight = randRewordWeight*playerNum
	print("maxWeight",maxWeight,randRewordWeight,playerNum)
	local rand = math.random(maxWeight)
	local curWeight = 0
	for playerID,player in pairs(normalRewardPlayer) do
		if curWeight <= rand and rand < curWeight + randRewordWeight then
			self:addItemRewordToList(player,{{ID = itemID,count = 1}})	
			break
		end	
		curWeight = curWeight + randRewordWeight
	end		
end

-- 侠义奖励
function BeastBlessManager:dealspecialReward(specialRewardPlayer,specialRewardPet,specialItemsConfig)
	if table.size(specialRewardPlayer) > 0 then
		local itemID = specialItemsConfig.itemID
		for playerID,player in pairs(specialRewardPlayer) do
			self:addItemRewordToList(player,{{ID = itemID,count = 1}})
		end
	end
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
	local rewardNames = BeastRoleRewordType[eType]
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
					print("roleReward.item",toString(roleReward.item))
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
							-- 特殊物品
							if itemID == BeastBlessSpecialItem then
								-- 广播
								if g_serverId == 0 then
									local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,5,role:getName(),{{itemID = itemID ,itemNum = itemNum}})
									RemoteEventProxy.broadcast(event)
								end
							end
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
	print("msgParams",toString(msgParams))
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_FightReward, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

function BeastBlessManager:getInstance()
	return BeastBlessManager()
end

g_periodChecker:addUpdateListener(BeastBlessManager:getInstance())


