--[[DekaronSchoolManager.lua
	描述：门派闯关活动管理
--]]

--闯关门派的6个活动目标
local schoolActivityTargetDB =
{
	--乾元岛护法
	[1] = 
	{ 
		npcId = 50051,
		scripts = {8021,8022,8023,8024,8025,8026},
	},
	--金霞山护法
	[2] = 
	{ 
		npcId = 50052,
		scripts = {8031,8032,8033,8034,8035,8036},
	},
	--紫阳门护法
	[3] = 
	{ 
		npcId = 50053,
		scripts = {8041,8042,8043,8044,8045,8046},
	},
	--云霄宫护法
	[4] = 
	{ 
		npcId = 50054,
		scripts = {8051,8052,8053,8054,8055,8056},
	},
	--桃源洞护法
	[5] = 
	{ 
		npcId = 50055,
		scripts = {8061,8062,8063,8064,8065,8066},
	},
	--蓬莱阁护法
	[6] = 
	{ 
		npcId = 50056,
		scripts = {8071,8072,8073,8074,8075,8076},
	},
}

DekaronSchoolManager = class(EventSetDoer, Singleton)


function DekaronSchoolManager:__init()
	self.fightList = {}
	self.rank = {}
end

function DekaronSchoolManager:__release()
	self.rank = nil
end

-- 玩家上线加入活动 如果活动存在 具体的逻辑在自己每个活动中做
function DekaronSchoolManager:onPlayerOnline(player, recordList)
	-- 加载所有开启的的活动数据
	local activity = g_activityMgr:getActivity(gSchoolActivityID)
	if activity and activity:isOpening() then
		activity:joinPlayer(player,recordList)
	else
		print("活动已经结束。。。。。。。。。。")
	end
end

function DekaronSchoolManager:addFightFlagList(teamID,scriptID)
	table.insert(self.fightList,{teamID,scriptID})
end

function DekaronSchoolManager:removeFightFlagList(teamID,scriptID)
	for i,fightInfo in pairs(self.fightList) do
		if fightInfo.teamID == teamID then
			table.remove(self.fightList,i)
		end
	end
end

function DekaronSchoolManager:checkFightFlag(teamID)
	for _,fightInfo in pairs(self.fightList) do
		if fightInfo.teamID == teamID then
			return true
		end
	end
	return false
end

--刷新排名
function DekaronSchoolManager:getRankList()
	return self.rank
end

--刷新排名
function DekaronSchoolManager:updateRank()
	table.sort(self.rank, function(a,b)
		return self.rank[a][2] > self.rank[b][2]
	end
	)
end

--更新排行列表
function DekaronSchoolManager:updateRankList(team, add)
	local exist = false
	local pos = 0
	for i, teamInfo in pairs(self.rank) do
		if teamInfo[1]== team:getTeamID() then
			exist = true
			pos = i
			break
		end
	end
	if not exist and add then
		local leaderID = team:getLeaderID()
		local player = g_entityMgr:getPlayerByID(leaderID)
		table.insert(self.rank, {team:getTeamID(), team:getProcess(), player:getName()})
		-- 此时队伍当中要加一个记录
		team:setRandList(true)
	elseif exist and  add then
		self.rank[pos][2] = self.rank[pos][2] + 1
	elseif exist and not add then
		table.remove(self.rank, pos)
	end
end

function DekaronSchoolManager:cleanRankList()
	table.clear(self.rank)
end

-- 发送给客户端消息
function DekaronSchoolManager:sendRewardMessageTip(player, msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_FightReward, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

--队长领取活动
function DekaronSchoolManager:joinActivity(player)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if not (teamHandler and teamHandler:isLeader()) then
		return false
	end
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	local activityTarget = team:getDekaronActivityTarget()
	-- 队长领取活动任务目标，如果之前的队伍当中有活动任务目标，则返回
	if activityTarget then
		return
	end
	local activity = g_activityMgr:getActivity(gSchoolActivityID)
	if activity and activity:isOpening() then
		--队伍归队玩家等级大于30级，4人组队，队伍中归队玩家等级差距不超过10级才可领取活动参赛资格以及进行NPC挑战。
		local teamMemNum = team:getMemberCount()
		if teamMemNum < ActivityNumber.DekaronSchool then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DekaronSchool, 5)
			g_eventMgr:fireRemoteEvent(event, player)
			return 
		end
		local maxLvl, minLvl = team:getMaxAndMinLvl()
		if minLvl < 30 or (maxLvl - minLvl) > 10 then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DekaronSchool, 6)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
		self:changeDekaronTarget(team)
		return true
	else
		print("activityID活动还没开启",activityID)
		return
	end
end

function DekaronSchoolManager:giveUpActivity(player)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler and teamHandler:isLeader() then
		local handler = player:getHandler(HandlerDef_Activity)
		local teamID = teamHandler:getTeamID()
		local team = g_teamMgr:getTeam(teamID)
		if team:getDekaronActivityTarget() then
			team:setDekaronActivityTarget(nil)
			team:setProcess(0)
			for _,memberInfo in pairs(team:getMemberList()) do
				local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local activityHandler = member:getHandler(HandlerDef_Activity)
				activityHandler:setDekaronIntegral(nil)
				local event = Event.getEvent(DekaronSchool_SC_GiveUpActvityTarget)
				g_eventMgr:fireRemoteEvent(event, member)
			end
		end
	else
		local activityHandler = player:getHandler(HandlerDef_Activity)
		activityHandler:setDekaronIntegral(nil)
		local event = Event.getEvent(DekaronSchool_SC_GiveUpActvityTarget)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

--更新活动目标
function DekaronSchoolManager:changeDekaronTarget(team)
	--重现获取活动目标
	local exist = false
	local school
	local targetList = team:getDekaronTargetList()
	if table.size(targetList) == table.size(schoolActivityTargetDB) then
		table.clear(targetList)
	end
	while(1) do
		exist = false
		school = math.random(1, #schoolActivityTargetDB)
		for _, targetSchool in pairs(targetList) do
			if targetSchool == school then
				exist = true
			end
		end
		if exist == false then
			break
		end
	end
	local teamProcess = team:getProcess()
	local scriptIndex = 0
	if teamProcess <= 6 then
		scriptIndex = 1
	elseif teamProcess > 6 and teamProcess <= 12 then
		scriptIndex = 2
	elseif teamProcess > 12 and teamProcess <= 18 then
		scriptIndex = 3
	elseif teamProcess > 18 and teamProcess <= 24 then
		scriptIndex = 4
	else
		scriptIndex = 5
	end
	local config = schoolActivityTargetDB[school]
	local scriptId = config.scripts[scriptIndex]
	local param =
	{
		school = school,
		team = team,
		npcID = config.npcId,
		entity = player,
		scriptId = scriptId,
	}
	team:setDekaronActivityTarget(AScript(param))
end


--新玩家加入队伍
function DekaronSchoolManager:joinTeam(player, teamID)
	local team = g_teamMgr:getTeam(teamID)
	local activityTarget = team:getDekaronActivityTarget()
	if activityTarget then
		local param = activityTarget:getParams()
		local handler = player:getHandler(HandlerDef_Activity)
		local event = Event.getEvent(DekaronSchool_SC_AddActvityTarget, param.npcID, 0, handler:getDekaronIntegral() or 0)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

--退出队伍
function DekaronSchoolManager:removeTeam(player)
	local handler = player:getHandler(HandlerDef_Activity)
	local event = Event.getEvent(DekaronSchool_SC_AddActvityTarget,0,0,handler:getDekaronIntegral() or 0)
	g_eventMgr:fireRemoteEvent(event, player)
end

--玩家上线加入到活动中
function DekaronSchoolManager:loadDekaronSchool(player,recordList)
	local integral = recordList[1].integral
	local handler = player:getHandler(HandlerDef_Activity)
	handler:setDekaronIntegral(integral)
	local event = Event.getEvent(DekaronSchool_SC_AddActvityTarget, 0,0,integral)
	g_eventMgr:fireRemoteEvent(event, player)
end

function DekaronSchoolManager.getInstance()
	return DekaronSchoolManager()
end

EventManager.getInstance():addEventListener(DekaronSchoolManager.getInstance())