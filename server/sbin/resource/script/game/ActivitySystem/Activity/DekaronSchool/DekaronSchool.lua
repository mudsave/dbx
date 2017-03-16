--[[DekaronSchool.lua
	描述：门派闯关
--]]

require "game.ActivitySystem.Activity.DekaronSchool.AScript"
require "game.ActivitySystem.Activity.DekaronSchool.DekaronSchoolManager"
require "game.ActivitySystem.Activity.DekaronSchool.DekaronSchoolSystem"
require "game.ActivitySystem.Activity.DekaronSchool.DekaronSchoolReward"

gSchoolActivityID = 1

--活动基础配置
local schoolActivityDB = 
{
	[1] = 
	{
		name = "DekaronSchool",
		dbName = "updateSchoolActivity",
		startType = AtyStartType.fixedWeekHour,
		activityTime = {
			[1] = {startTime = {week = 2,hour = 8, min = 47},endTime = {week = 6,hour = 22, min = 0}},
			[2] = {startTime = {week =6,hour = 20, min = 0},endTime = {week = 6,hour = 21, min = 0}},
		}
	}
}

table.copy(schoolActivityDB, ActivityDB)

DekaronSchool = class(Activity, Singleton,Timer)

function DekaronSchool:__init()
	self._id = gSchoolActivityID
	self.teamList = {}
	self.rank = {}
	self.state = nil
end

function DekaronSchool:__release()
	self._id = nil
	self.teamList = nil
	self.rank = nil
	self.state = nil
end

function DekaronSchool:open()
	--播放广播
	local BroadCastMsgID = BroadCastMsgGroupID.Group_DekaronSchool
	local event = Event.getEvent(BroadCastSystem_SC_DekaronSchool,BroadCastMsgID.EventID,BroadCastMsgID.ActivityPreOpening)
	RemoteEventProxy.broadcast(event)
	--活动状态(预开启)
	self.state = ActivityState.PreOpening
	--定时器5分钟后活动开启
	self.openActivityTimerID = g_timerMgr:regTimer(self, 1000*60*1, 1000*60*1, "门派闯关活动5分钟后开启")
end

function DekaronSchool:close()
	--播放广播
	g_dekaronSchoolMgr:updateRank()
	local rankList = g_dekaronSchoolMgr:getRankList()
	--结算奖励遍历前三名的 发广播
	local BroadCastMsgID = BroadCastMsgGroupID.Group_DekaronSchool
	local event = Event.getEvent(BroadCastSystem_SC_DekaronSchool,BroadCastMsgID.EventID,BroadCastMsgID.ActivityTopThree,rankList[1] and rankList[1][3] or nil,rankList[2] and rankList[2][3] or nil,rankList[3] and rankList[3][3] or nil)
	RemoteEventProxy.broadcast(event)
	for i,rankInfo in pairs(rankList or {}) do
		local teamID = rankInfo[1]
		local team = g_teamMgr:getTeam(teamID)
		if i < 100 then
			for _,memberInfo in pairs(team:getMemberList()) do
				local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local playerLevel = member:getLevel()
				local activityHandler = member:getHandler(HandlerDef_Activity)
				local integral = activityHandler:getDekaronIntegral()
				local exp = DekaronSchoolReward.getExpFormula(playerLevel,integral)
				local tao = DekaronSchoolReward.getTaoFormula(playerLevel,integral)
				if exp then
					member:addXp(exp)
					g_dekaronSchoolMgr:sendRewardMessageTip(member, 2,exp)
				end
				--道行
				if tao then
					local tao = tao + member:getAttrValue(player_tao)
					member:setAttrValue(player_tao, tao)
					g_dekaronSchoolMgr:sendRewardMessageTip(member, 5, tao)
				end
			end
		end
		team:setDekaronActivityTarget(nil)
		team:setProcess(0)
	end
	--清除所有信息
	for playerID, player in pairs(g_entityMgr:getPlayers()) do
		player:getHandler(HandlerDef_Activity):setDekaronIntegral(0)
		--关闭UI
	end
	self.state = ActivityState.Close
	LuaDBAccess.deleteSchoolActivity()
end

-- 活动开启
function DekaronSchool:update(timerID)
	if timerID == self.openActivityTimerID then
		self:openActivity()
	end
end

--定时器执行，真正开启活动
function DekaronSchool:openActivity()
	--活动状态(开启)
	if self.state == ActivityState.PreOpening then
		self.state = ActivityState.Opening
		--播放广播
		local BroadCastMsgID = BroadCastMsgGroupID.Group_DekaronSchool
		local event = Event.getEvent(BroadCastSystem_SC_DekaronSchool,BroadCastMsgID.EventID,BroadCastMsgID.ActivityOpening)
		RemoteEventProxy.broadcast(event)
		-- 删除定时器
		g_timerMgr:unRegTimer(self.openActivityTimerID)
	end
end

--活动是否开启
function DekaronSchool:isOpening()
	return self.state == ActivityState.Opening
end

--玩家上线加入到活动中
function DekaronSchool:joinPlayer(player,recordList)
	local recordList = recordList[32]
	local integral = recordList[1].integral
	local handler = player:getHandler(HandlerDef_Activity)
	handler:setDekaronIntegral(integral)
	local event = Event.getEvent(DekaronSchool_SC_AddActvityTarget, 0,0,integral)
	g_eventMgr:fireRemoteEvent(event, player)
end