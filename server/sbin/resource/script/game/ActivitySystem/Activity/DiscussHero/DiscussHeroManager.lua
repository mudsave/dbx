--[[DiscussHeroManager.lua
描述:管理 煮酒论英雄 NPC 
]]
DiscussHeroManager = class(nil, Singleton)

function DiscussHeroManager:__init()
	-- 活动NPC里的
	self.npcList = {}
	-- 死亡表
	self.npcDieList = {}
	-- 记录战斗的ID
	self.fightRoleIDList = {}
	-- 最多积分
	self.maxTotalScoreList = {}
end

-- self.npcList = {[activityMapID] = {[npcID] = npc}}
-- self.npcDieList = {[activityMapID] = {[npcID] = npc}}
function DiscussHeroManager:__release()
end

function DiscussHeroManager:setMaxTotalScore(activityMapID,totalScore)
	local maxTotalScore = self.maxTotalScoreList[activityMapID]
	print("----maxTotalScore",maxTotalScore)
	if totalScore > maxTotalScore then
		self.maxTotalScoreList[activityMapID] = totalScore
		-- 通知所有的人
		print("通知所有的人maxTotalScore",self.maxTotalScore)
		local info = {}
		info.maxScore = totalScore
		g_discussHeroSym:notifyClientDataChangeInMap(activityMapID,info)
	end
end

function DiscussHeroManager:getMaxTotalScore(activityMapID)
	return self.maxTotalScoreList[activityMapID] or 0
end

function DiscussHeroManager:getFightRoleID(fightID)
	return self.fightRoleIDList[fightID]
end

function DiscussHeroManager:removeRoleFromFightIDList(fightID)
	self.fightRoleIDList[fightID] = nil
end

function DiscussHeroManager:removePlayerFromeDiscussHero()
	
end

-- 活动开启初始化增加NPC
function DiscussHeroManager:initAllNpc()
	self.maxTotalScore = 0
	-- 判断地图人数
	local mapInfo = DiscussHeroDB[gDiscussHeroActivityID].mapInfo
	local npcList = self.npcList
	local npcDieList = self.npcDieList
	for activityMapID,data in ipairs(mapInfo) do
		local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
		local curNpcList = {}
		if scene then
			local playerCount = scene:getPlayerCount()
			-- 增加NPC
			if playerCount > 0 then
				for i = 1,playerCount do
					local npc = g_entityFct:createDynamicNpc(data.npcDBID)
					if npc then
						if DiscussUtils.addNpcInRandMap(scene,npc,curNpcList) then
							local npcID = npc:getID()
							curNpcList[npcID] = npc
						end
					end
				end
			end
		end
		npcList[activityMapID] = curNpcList
		npcDieList[activityMapID] = {}
		-- 本场景最大的积分
		self.maxTotalScoreList[activityMapID] = 0
	end
end

-- 给特定的场景增加NPC
function DiscussHeroManager:addNpc(activityMapID)
	local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
	local mapInfo = DiscussHeroDB[gDiscussHeroActivityID].mapInfo
	local npcList = self.npcList
	local npcDieList = self.npcDieList
	local curNpcList = npcList[activityMapID]
	local curDieList = npcDieList[activityMapID]
	local data = mapInfo[activityMapID]
	if scene and data and curNpcList then
		local npc = nil
		if table.size(curDieList) > 0 then
			print("从死亡链表中取")
			for npcID,npc in pairs(curDieList) do
				npc = npc
				break
			end
		else
			print("自己创建")
			npc = g_entityFct:createDynamicNpc(data.npcDBID)
		end
		if npc then
			if DiscussUtils.addNpcInRandMap(scene,npc,curNpcList) then
				local npcID = npc:getID()
				curNpcList[npcID] = npc
			end
		else
			print("DiscussHeroManager逻辑错误")
		end
	end
end

function DiscussHeroManager:changeNpcData(fightID,isAdd)
	local npcList = self.npcList
	local npcDieList = self.npcDieList
	local npcID = self.fightRoleIDList[fightID]
	print("fightID,isAdd",fightID,isAdd)
	if npcID then
		-- 判断地图人数
		for activityMapID,curNpcList in pairs(npcList) do
			local npc = curNpcList[npcID]
			if npc then
				local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
				local playerCount = scene:getPlayerCount()
				local curNpcNum = table.size(curNpcList)
				-- 人数和NPC量
				if curNpcNum <= playerCount and isAdd then
					print("fightID1111,isAdd",npcID,isAdd)
					scene:detachEntity(npc)
					DiscussUtils.addNpcInRandMap(scene,npc,curNpcList)
				else
					print("fightID22222,isAdd",npcID,isAdd)
					local curDieList = npcDieList[activityMapID] 
					scene:detachEntity(npc)
					curNpcList[npcID] = nil
					if table.size(curDieList) > 20 then
						g_entityMgr:removeNpc(npcID)
					else
						curDieList[npcID] = npc
					end
				end
			end
		end
	else
		print("changeNpcData逻辑有错误")
	end
end

-- 销毁所有的NPC
function DiscussHeroManager:removeAllNpcFromeMap()
	local npcList = self.npcList
	local npcDieList = self.npcDieList
	for activityMapID,curNpcList in pairs(npcList) do
		for npcID,npc in pairs(curNpcList) do
			local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
			scene:detachEntity(npc)
			curNpcList[npcID] = nil
			g_entityMgr:removeNpc(npcID)
		end
	end
	for activityMapID,curNpcList in pairs(npcDieList) do
		for npcID,npc in pairs(curNpcList) do
			local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
			scene:detachEntity(npc)
			curNpcList[npcID] = nil
			g_entityMgr:removeNpc(npcID)
		end
	end
end

-- 判断进入场景等级
function DiscussHeroManager:getActivityMapID(player)
	local level = player:getLevel()
	if not level then
		print("等级有问题")
	end
	local mapInfo = DiscussHeroDB[gDiscussHeroActivityID].mapInfo
	for activityMapID,data in ipairs(mapInfo) do
		if data.minLevel <= level and level < data.maxLevel then
			return activityMapID
		end
	end
	print("DiscussHeroManager配置出错playerLevel = ",level)
	return nil
end

function DiscussHeroManager:enterDiscussHero(player,posInfo)
	print("____进入煮酒论英雄场景",toString(posInfo))
	local posX,posY = posInfo.x,posInfo.y
	local activityMapID = self:getActivityMapID(player)
	if not activityMapID then
		print("没有这个活动",activityMapID)
		return false
	end
	-- 判断活动是否开启 新人进入加入NPC
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		return
	end
	local activityState = discussHero:getDiscussHeroState()
	-- 判断是否组队
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler and teamHandler:isTeam() then
		local playerList = teamHandler:getTeamPlayerList()
		for _,player in pairs(playerList) do
			local bResult = g_sceneMgr:enterDiscussHeroScene(activityMapID,player,posX,posY)
			g_discussHeroSym:notifyClientEnterScene(player)
			if activityState == ActivityState.Opening then
				self:addNpc(activityMapID)
			end
			if not bResult then
				print("进入活动失败",bResult)
				return false
			end
		end
	else
		local bResult = g_sceneMgr:enterDiscussHeroScene(activityMapID,player,posX,posY)
		-- 进入活动 通知客户端
		if activityState == ActivityState.Opening then
			self:addNpc(activityMapID)
		end
		g_discussHeroSym:notifyClientEnterScene(player)
		if not bResult then
			print("进入活动失败",bResult)
			return false
		end
	end
	return true
end

function DiscussHeroManager:doEixtDiscussHero(player)
	
end

function DiscussHeroManager:doDiscussHeroPVEFight(player, param, npcID)
	local fightRoleIDList = self.fightRoleIDList
	local playerList = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		-- 不是队长不能使用npc
		if not teamHandler:isStepOutState() then
			if teamHandler:isLeader() then
				playerList = teamHandler:getTeamPlayerList()
			else
				print("不是队长不能使用npc")
				return
			end 
		elseif teamHandler:isStepOutState() then 
			if teamHandler:isLeader() then
				playerList = teamHandler:getTeamPlayerList()
			else
				table.insert(playerList,player)
				end
			end
		else
			table.insert(playerList,player)
		end
		--加宠物
		local finalList = {}
		for k,player in ipairs(playerList) do
			-- 通知客户端
			g_discussHeroSym:notifyClientFight(player)
			table.insert(finalList,player)
			local petID = player:getFightPetID()
			if petID then
				local pet = g_entityMgr:getPet(petID)
				table.insert(finalList,pet)
			end
		end		
		local curNpc = g_entityMgr:getNpc(npcID)
		local bPass = g_fightMgr:checkStartScriptFight(finalList, param.scriptID,  param.mapID)
		if bPass then
		if curNpc:getStatus() ~= ePlayerFight then
			curNpc:setStatus(ePlayerFight)
			local fightID = g_fightMgr:startScriptFight(finalList, param.scriptID,  param.mapID, FightBussinessType.DicussHero)
			print("fightID",fightID)
			self.fightRoleIDList[fightID] = npcID
			print("self.fightRoleIDList",toString(self.fightRoleIDList))
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt,12)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

-- 自由pk
function DiscussHeroManager:doDiscussHeroPVPFight(playerID,targetID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local tgPlayer = g_entityMgr:getPlayerByID(targetID)
	
	local playerList1 = {}
	local playerList2 = {}
	local teamHandler1 = player:getHandler(HandlerDef_Team)
	-- local playerList 
	-- local fightType
	if teamHandler1:isTeam() then
		playerList1 = teamHandler1:getTeamPlayerList()
	else
		table.insert(playerList1, player)
	end

	-- 目标玩家做下判断
	local teamHandler2 = tgPlayer:getHandler(HandlerDef_Team)
	if teamHandler2:isTeam() then
		playerList2 = teamHandler2:getTeamPlayerList()
	else
		table.insert(playerList2, tgPlayer)
	end
	-- 如果有出战宠物要添加到战斗当中
	local roleList1 = {}
	local roleList2 = {}
	for _, role in pairs(playerList1 or {}) do
		g_discussHeroSym:notifyClientFight(role)
		table.insert(roleList1, role)
		local petID = role:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet then
				table.insert(roleList1, pet)
			end
		end
	end
	for _, role in pairs(playerList2 or {}) do
		g_discussHeroSym:notifyClientFight(role)
		table.insert(roleList2, role)
		local petID = role:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet then
				table.insert(roleList2, pet)
			end
		end
	end
	-- 拉玩家进入PK
	local fightID = g_fightMgr:startPvpFight(roleList1, roleList2, nil, FightBussinessType.DicussHero)
	self.fightRoleIDList[fightID] = targetID
end

function DiscussHeroManager:changeAllPlayerState()
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		return
	end
	local mapInfo = DiscussHeroDB[gDiscussHeroActivityID].mapInfo
	for activityMapID,data in ipairs(mapInfo) do
		local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
		if scene then
			local roleList = scene:getEntityList()
			for playerID,player in pairs(roleList) do
				if instanceof(player, Player) then
					local handler = player:getHandler(HandlerDef_Activity)
					handler:setPriDataById(gDiscussHeroActivityID,1)
				end
			end
		end
	end
end

local rankingInfo = {
	[1] = {score = 0,tao = 0},
	[2] = {score = 0,tao = 0},
	[3] = {score = 0,tao = 0},
}

function DiscussHeroManager:reSetRankInfo()
	for _,data in pairs(rankingInfo) do
		data.score = 0
		data.tao = 0
	end
end

local function swap(rankingInfo,ranking,teamScore,tao)
	print("swap-------------",ranking)
	if ranking == 1 then
		rankingInfo[3]	= rankingInfo[2]
		rankingInfo[2] = rankingInfo[1]
		rankingInfo[1].score = teamScore
		rankingInfo[1].tao = tao
		print("rankingInfo1",toString(rankingInfo))
		return ranking
	elseif ranking == 2 then
		rankingInfo[3] = rankingInfo[2]
		rankingInfo[2] = teamScore
		rankingInfo[2] = tao
		print("rankingInfo2",toString(rankingInfo))
		return ranking
	elseif ranking == 3 then
		print("rankingInfo3",toString(rankingInfo))
		rankingInfo[3].score = teamScore
		rankingInfo[3].tao = tao
		return ranking
	end
end

local function hasRanking(player)
	local activityHandler = player:getHandler(HandlerDef_Activity)
	local wineCount,totalScore,teamScore = activityHandler:getDicussHero()
	local tao = player:getAttrValue(player_tao)
	print("xxxxxx-------",toString(rankingInfo))
	for ranking,data in ipairs(rankingInfo) do
		local score = data.score 
		if score ==  teamScore then
			print("teamScore===",teamScore)
			if tao > data.tao then
				return swap(rankingInfo,ranking,teamScore,tao)
			else
				print("tao",tao)
			end
		elseif score < teamScore then
			print("teamScore===",teamScore,score)
			return swap(rankingInfo,ranking,teamScore,tao)
		end		
	end
	return false
end


function DiscussHeroManager:allExitDiscussHero()
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		print("活动已经关闭")
		return
	end
	local config = DiscussHeroDB[gDiscussHeroActivityID]
	local mapInfo = config.mapInfo
	local rewardInfo = config.rewardInfo
	for activityMapID,data in ipairs(mapInfo) do
		local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
		if scene then
			local playerRanking = {} -- 玩家排位
			local roleList = scene:getEntityList()
			for playerID,player in pairs(roleList) do
				if instanceof(player, Player) then
					-- 退出
					g_discussHeroSym:exitDiscussHero(player)
					-- 奖励
					self:exitReward(player,activityMapID)
					print("奖励-----")
					-- 是队长才计算队里的信息
					local teamHandler = player:getHandler(HandlerDef_Team)
					if teamHandler and teamHandler:isTeam() then
						print("奖励-----2")
						if teamHandler:isLeader() then
							local isHasRanking = hasRanking(player)
							print("第几名1:",isHasRanking)
							if isHasRanking then
								print("第几名1:",isHasRanking)
								local playerList = teamHandler:getTeamAllPlayerList()
								playerRanking[isHasRanking] = playerList
							end
						end
					else
						local isHasRanking = hasRanking(player)
						print("第几名:",isHasRanking)
						if isHasRanking then
							print("第几名:",isHasRanking)
							playerRanking[isHasRanking] = {player}	
						end
					end
				end
			end
			if table.size(playerRanking) then
				local rankingItem = rewardInfo[activityMapID].rankingItem
				if rankingItem then
					for ranking,playerList in pairs(playerRanking) do
						if ranking == 1 then
							local strName = ""
							local isBroadCast = false
							for _,player in pairs(playerList) do
								local playerName = player:getName() 
								strName = strName..playerName
								isBroadCast = true
							end
							if isBroadCast then
								g_discussHeroSym:broadcastReward(data.minLevel,data.maxLevel,strName)
							end
						end
						local itemID = rankingItem[ranking].itemID
						if itemID then
							for _,player in pairs(playerList) do
								local allItem = {}
								local packetHandler = player:getHandler(HandlerDef_Packet)
								if packetHandler:addItemsToPacket(itemID, 1) then
									local itemInfo = {}
									itemInfo.itemID = itemID
									itemInfo.itemNum = 1
									table.insert(allItem,itemInfo)
								end
								if table.size(allItem) > 0 then
									self:sendRewardMessageTip(player, 8, allItem)
								end
							end
						else
							print("没有配置这个等级名次的物品")
						end
					end
				end
			end
			self:reSetRankInfo()
		end
	end
end

function DiscussHeroManager:onPlayerOnline(player,recordList)
	-- 加载所有开启的的活动数据
	local schoolID = gSchoolActivityID
	local activity = g_activityMgr:getActivity(schoolID)
	if activity then
		local activityHandler = player:getHandler(HandlerDef_Activity)
		if activityHandler then
			if recordList and table.size(recordList) > 0 then
				for _,data in pairs(recordList) do
					if not time.isSameDay(data.recordTime) then
						activityHandler:setPriDataById(schoolID, 0)
					else
						activityHandler:setPriDataById(schoolID, data.isCanIn)
					end
				end
			else
				activityHandler:setPriDataById(schoolID, 0)
			end
		end
	end
end

-- 根据积分奖励
function DiscussHeroManager:exitReward(player,activityMapID)
	local activityHandler = player:getHandler(HandlerDef_Activity)
	local rewardInfos = DiscussHeroDB[gDiscussHeroActivityID].rewardInfo
	local rewardInfo = rewardInfos[activityMapID]
	print("rewardInfo",toString(rewardInfo))
	if activityHandler then
		local wineCount,totalScore,teamScore = activityHandler:getDicussHero()
		print("退出积分奖励",totalScore)
		if totalScore > 0 then
			local expReward = rewardInfo.exp
			local subMoney= rewardInfo.subMoney
			local tao = rewardInfo.tao
			local itemsReward = rewardInfo.items
			if expReward then
				print("expReward",expReward)
				expReward = expReward*totalScore
				player:addXp(expReward)
				self:sendRewardMessageTip(player, 2, expReward)
			end
			if subMoney then
				subMoney = (subMoney*totalScore) + player:getSubMoney()
				player:setSubMoney(subMoney)
				self:sendRewardMessageTip(player, 4, subMoney)
			end
			if tao then
				tao =  (tao * totalScore)+ player:getAttrValue(player_tao)
				player:setAttrValue(player_tao, tao)
				self:sendRewardMessageTip(player, 5, rewardInfo.tao)
			end
			local itemNum = math.ceil(totalScore/5) + 1
			print("itemNum",itemNum)
			-- 物品随机
			if itemsReward then
				local items = {}
				for i = 1,itemNum do
					local itemID = DiscussUtils.randItem(itemsReward)
					print("物品奖励----",itemID)
					table.insert(items,itemID)
				end
				if table.size(items) > 0 then
					local packetHandler = player:getHandler(HandlerDef_Packet)
					local allItem = {}
					for _, itemID in pairs(items) do
						-- 把物品给玩家
						if packetHandler:addItemsToPacket(itemID, 1) then
							local itemInfo = {}
							itemInfo.itemID = itemID
							itemInfo.itemNum = 1
							table.insert(allItem,itemInfo)
						end
					end
					if table.size(allItem) > 0 then
						self:sendRewardMessageTip(role, 8, allItem)
					end
				end
			end
			player:flushPropBatch()
		end
	end
end

-- 排名
function DiscussHeroManager:joinTeamNotify(leaderID)
	local activity = g_activityMgr:getActivity(gSchoolActivityID)
	if not activity then
		return 
	end
	local player = g_entityMgr:getPlayerByID(leaderID)
	if not player then
		return
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler and teamHandler:isTeam() then
		local playerList = teamHandler:getTeamPlayerList()
		g_discussHeroSym:changeDiscussData(playerList,0,0,true)
	end
end

function DiscussHeroManager:QuitTeamNotify(playerID,teamID)
	local activity = g_activityMgr:getActivity(gSchoolActivityID)
	if not activity then
		return 
	end
	local player = g_entityMgr:getPlayerByID(leaderID)
	if not player then
		return
	end
	-- 通知客户端
	g_discussHeroSym:changeDiscussData({player},0,0,true)
	local team = g_teamMgr:getTeam(teamID)
	if team then
		local playerList = {}
		local teaList = team:getMemberList()
		for _,memberInfo in pairs(teaList) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			table.insert(playerList,member)
		end
		if table.size(playerList) then
			g_discussHeroSym:changeDiscussData(playerList,0,0,true)
		end
	end
end


-- 发送给客户端消息
function DiscussHeroManager:sendRewardMessageTip(player, msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_FightReward, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

function DiscussHeroManager.getInstance()
	return DiscussHeroManager()
end




