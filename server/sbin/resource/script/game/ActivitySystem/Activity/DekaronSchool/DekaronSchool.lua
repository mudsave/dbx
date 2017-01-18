--[[DekaronSchool.lua
	描述：门票闯关
--]]

local offLinePlayers
{
	{--dbID,level,积分}
}
--闯关门派随机配置
local schoolActivityTargetDB =
{
	[1] = 
	{ 
		npcId = 20001,
		scripts = {101,102},
	},
}

--战斗对应奖励配置
local scriptReward =
{
	[101] = 500,
	[102] = 1000,
}

--活动基础配置
local schoolActivityDB = 
{
	[1] = 
	{
		name = "DekaronSchool",
		dbName = "updateSchoolActivity",
		startType = AtyStartType.fixedDayHour,
		startTime = {hour = 16, min = 25},
		endTime = {hour = 18, min = 30},
	}
}

table.copy(schoolActivityDB, ActivityDB)

require "game.ActivitySystem.Activity.DekaronSchool.AScript"

DekaronSchool = class(Activity, Singleton)

function DekaronSchool:__init()
	self._id = 1
	self.teamList = {}
	self.rank = {}
end

function DekaronSchool:__release()
	self.teamList = nil
	self.rank = nil
end

function DekaronSchool:open()
	--播放广播
	--活动状态(预开启)
	--定时器
end

function DekaronSchool:close()
	--播放广播
end

--定时器执行，真正开启活动
function DekaronSchool:openActivity()
	--活动状态(开启)
	
end

--定时器执行，真正关闭活动
function DekaronSchool:closeActivity()	
	--结算奖励遍历前三名的 发广播
	--结算奖励遍历前一百名的
	--清除所有信息
end

--奖励公式
function DekaronSchool:rewardFormat(player)
	--计算
	--通知客户端
end

--点击对话调用这里,这里的player必须是队长
function DekaronSchool:joinActivity(player)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	local school = math.random(1,#schoolActivityTargetDB)
	local config = schoolActivityTargetDB[school]
	local scriptId = config.scripts[math.random(1,#config.scripts)]
	local param =
	{
		scriptID = scriptId,
		team = team,
		npcID = config.npcId,
		school = school,
		DB = table.copy(schoolActivityTargetDB),
		activity = self,
	}
	team:addDekaronActivityTarget(AScript(param))
	--给队伍添加进度值
	team:setProcess(self._param.team:getProcess() + 1)

	self.teamList[teamID] = team
	--为每个队员添加积分
	
	--打开ui
end

--新玩家加入队伍
function DekaronSchool:joinTeam(player, teamId)
	--获取进度数据
	--打开ui
end

--队长改变(不过貌似不用处理)
function DekaronSchool:leaderChange(player)
	--获取进度数据
	--刷新ui
end

--有玩家退出队伍
function DekaronSchool:exitTeam(player)
	--关闭ui
end

--有队伍解散(考虑组队直接下线的情况也要清理)
function DekaronSchool:dissTeam(teamID)
	--如果有目标释放队伍目标
	--清除活动队伍信息
	self.teamList[teamID] = nil
	--清除进度
	--关闭ui
end

--刷新排名
function DekaronSchool:updateRank(team)
	if table.size(self.rank) == 0 then
		self.rank[1] = {team:getId(), team:getName(), team:getProcess()}
		return
	end
	local exist = false
	for rank, teamInfo in pairs(self.rank) do
		if teamInfo[1]:getId() == team:getId() then
			teamInfo[3] = teamInfo[3] + 1
			exist = true
			break
		end
	end

	if not exist then
		self.rank[table.size(self.rank) + 1] = {team:getId(), team:getName(), 1}
	else
		table.sort(self.rank, function()) --排序娟姐看下怎么好
	end
end