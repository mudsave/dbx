--[[DiscussHeroSystem.lua
描述:信息交互
]]


DiscussHeroSystem = class(EventSetDoer, Singleton)

function DiscussHeroSystem:__init()
	self._doer = {
		[FightEvents_SS_FightEnd_afterClient]	= DiscussHeroSystem.onFightEnd,
		[ActivityEvent_CS_ExitDiscussHero]		= DiscussHeroSystem.onExitDiscussHero,
		[ActivityEvent_CS_EnterDiscussHeroPVP]	= DiscussHeroSystem.onPk,
	}
	
end

function DiscussHeroSystem:__release()
end

-- 战斗结束
function DiscussHeroSystem:onFightEnd(event)
	local params = event:getParams()
	local results = params[1]
	local monsterDBIDs = params[3]
	local fightID = params[4]
	local isPVE = false
	print("--------煮酒活动战斗-------1")
	local roleID = g_discussHeroMgr:getFightRoleID(fightID)
	if not roleID then
		print("没有这个ID")
		return
	end
	print("--------煮酒活动战斗-------2")
	local role = g_entityMgr:getPlayerByID(roleID)
	-- 判断对象是人还是NPC 
	if role then
		isPVE = false
	else
		isPVE = true
	end
	print("isPVE",isPVE)
	local winners = {} 
	local losers = {}
	-- 玩家分类
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player  then
			if isWin then
				table.insert(winners,player)
			else
				table.insert(losers,player)
			end
			local maxHP = player:getAttrValue(player_max_hp)
			player:setHP(maxHP)
			local maxMP = player:getAttrValue(player_max_mp)
			player:setMP(maxMP)
		end
	end
	-- 活动是否开启
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		return
	end
	local activityState = discussHero:getDiscussHeroState()
	local isAdd = false -- 是否增加NPC数量
	if activityState == ActivityState.Opening then
		isAdd = true
	end
	--打怪
	if isPVE then
		local curNpc = g_entityMgr:getNpc(roleID)
		if curNpc then
			curNpc:setStatus(ePlayerNormal)
		end
		if table.size(winners) > 0 then
			-- 奖励 青梅酒 + 1
			g_discussHeroMgr:changeNpcData(fightID,isAdd)
			print("-- 奖励 青梅酒 + 1")
			self:changeDiscussData(winners,1,0,true)
		else
			-- 战斗失败
			for _,player in pairs(losers) do
				self:exitDiscussHero(player)
			end
		end
	else
		if table.size(winners) > 0 then	
			-- 增加积分
			local count = table.size(losers)
			print("-- 增加积分",count)
			self:changeDiscussData(winners,0,count,true)
		end
		if table.size(losers) > 0 then
			-- 青梅酒 - 1
			print("-- 青梅酒 - 1")
			self:changeDiscussData(losers,-1,0)
		end
	end
	g_discussHeroMgr:removeRoleFromFightIDList(fightID)
end 

function DiscussHeroSystem:changeDiscussData(playerLists,wineCountDelta,totalScoreDelta,isWin)
	
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		return
	end
	-- 计算出队伍积分
	local teamScoreDelta = 0
	local activityMapID = nil
	local mapPos = nil
	local activityState = discussHero:getDiscussHeroState()
	if table.size(playerLists) > 0 then
		for _,player in pairs(playerLists) do
			local activityHandler =  player:getHandler(HandlerDef_Activity)
			if activityHandler then
				local wineCount,totalScore = activityHandler:getDicussHero()
				print("设置wineCount1111,totalScore",wineCount,totalScore)
				wineCount = wineCount + wineCountDelta
				totalScore = totalScore + totalScoreDelta
				activityMapID = g_discussHeroMgr:getActivityMapID(player)
				if wineCount <= 0 and activityState == ActivityState.OpeningFirst then
					self:exitDiscussHero(player)
					-- 通知所有玩家？？
				else
					print("设置wineCount222,totalScore",wineCount,totalScore)
					activityHandler:setDicussHero(wineCount,totalScore)
					teamScoreDelta = teamScoreDelta + totalScore
					if not isWin then
						if not mapPos then
							mapPos =  DiscussUtils.getRandMapPos(activityMapID)
							g_sceneMgr:enterDiscussHeroScene(activityMapID,mapPos.x,mapPos.y)
						end
					end
				end
			end
		end
		-- 改变最大值 并通知客户端
		g_discussHeroMgr:setMaxTotalScore(activityMapID,teamScoreDelta)
		-- 通知客户端
		for _,player in pairs(playerLists) do
			local activityHandler =  player:getHandler(HandlerDef_Activity)
			if activityHandler then
				local wineCount,totalScore = activityHandler:getDicussHero()
				local info = {}
				info.wineCount = wineCount
				info.totalScore = totalScore
				info.teamScore = teamScoreDelta
				info.maxScore = g_discussHeroMgr:getMaxTotalScore(activityMapID)
				print("-------->info",toString(info))
				self:sendMessageToClient(player,info)
			end
		end
	end
	
end

function DiscussHeroSystem:onPk(event)
	local playerID = event.playerID
	--校验pk条件
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	if not g_sceneMgr:isInDiscussHeroScene(player) then
		return
	end
	if player:getStatus() == ePlayerFight then
		return
	end
	local params = event:getParams()
	local targetID = params[1]
	local tgPlayer = g_entityMgr:getPlayerByID(targetID)
	if not tgPlayer then
		return
	end
	if not g_sceneMgr:isInDiscussHeroScene(tgPlayer) then
		return
	end
	if tgPlayer:getStatus() == ePlayerFight then
		return
	end
	
	local playerTeamHandler = player:getHandler(HandlerDef_Team)
	if playerTeamHandler:isTeam() then
		if not playerTeamHandler:isLeader() then
			return
		end
	end
	
	local tgPlayerTeamHandler = tgPlayer:getHandler(HandlerDef_Team)
	if tgPlayerTeamHandler:isTeam() then
		if not tgPlayerTeamHandler:isLeader() then
			return
		end
	end
	g_discussHeroMgr:doDiscussHeroPVPFight(playerID,targetID)
end

function DiscussHeroSystem:onExitDiscussHero(event)
	local playerID = event.playerID
	--校验pk条件
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	print("退出场景",playerID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler and teamHandler:isTeam() then
		local playerList = teamHandler:getTeamPlayerList()
		for _,player in pairs(playerList) do
			local prevPos = player:getPrevPos()
			g_sceneMgr:doSwitchScence(player:getID(),prevPos[1],prevPos[2],prevPos[3])
		end
	else
		local prevPos = player:getPrevPos()
		g_sceneMgr:doSwitchScence(player:getID(),prevPos[1],prevPos[2],prevPos[3])
	end
end

-- 进入场景时通知个人
function DiscussHeroSystem:notifyClientEnterScene(player)
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		return
	end
	local info = {}
	info.surplusTime = discussHero:getEndTime() - os.time()
	info.activityState = discussHero:getDiscussHeroState()
	print("info",toString(info))
	local event = Event.getEvent(ActivityEvent_SC_EnterDiscussHero,info)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 活动状态改变时产生的改变
function DiscussHeroSystem:notifyClientStateChange()
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
					local info = {}
					local activityHandler =  player:getHandler(HandlerDef_Activity)
					if activityHandler then
						local isSend = true
						info.activityState = discussHero:getDiscussHeroState()
						local wineCount,totalScore = activityHandler:getDicussHero()
						if info.activityState == ActivityState.OpeningFirst then
							if wineCount <= 0 then
								self:exitDiscussHero(player)
								isSend = false
							end
						end
						if isSend then
							info.surplusTime = discussHero:getEndTime() - os.time()
							info.wineCount = wineCount
							info.totalScore = totalScore
							info.teamScore = 0
							info.maxScore = 0
							self:sendMessageToClient(player,info)
						end
					end
				end
			end
		end
	end
end

-- 通知这个场景中的所有人
function DiscussHeroSystem:notifyClientDataChangeInMap(activityMapID,info)
	local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
	if scene then
		local roleList = scene:getEntityList()
		for playerID,player in pairs(roleList) do
			if instanceof(player, Player) then
				self:sendMessageToClient(player,info)
			end
		end
	end
end

-- 数据改变不改变时间 通知个人
function DiscussHeroSystem:sendMessageToClient(player,info)
	local discussHero =  g_activityMgr:getActivity(gDiscussHeroActivityID)
	if not discussHero then
		return
	end
	info.activityState = discussHero:getDiscussHeroState()
	local event = Event.getEvent(ActivityEvent_SC_UpdateDiscussHero,info)
	g_eventMgr:fireRemoteEvent(event, player)
end

function DiscussHeroSystem:notifyClientExitDiscussHero(player)
	-- 通知每一个玩家
	local event = Event.getEvent(ActivityEvent_SC_ExitDicussHero)
	g_eventMgr:fireRemoteEvent(event, player)
end

function DiscussHeroSystem:exitDiscussHero(player)
	local prevPos = player:getPrevPos()
	g_sceneMgr:doSwitchScence(player:getID(),prevPos[1],prevPos[2],prevPos[3])
	self:notifyClientExitDiscussHero(player)
end

function DiscussHeroSystem.getInstance()
	return DiscussHeroSystem()
end

EventManager.getInstance():addEventListener(DiscussHeroSystem.getInstance())
g_discussHeroSym = DiscussHeroSystem.getInstance()
