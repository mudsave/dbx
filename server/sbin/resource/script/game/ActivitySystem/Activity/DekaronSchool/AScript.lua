--[[AScript.lua
描述：
	活动目标战斗(活动系统)
--]]

AScript = class(ActivityTarget)

function AScript:__init(param)
	self._param = param
	self:setEntity(self._param.entity)
	self._activityTargetId = self._param.school
end

function AScript:onScriptDone(scriptID, isWin,monsterDBIDs)
	if scriptID == self._param.scriptId then 
		if isWin then
			--队伍加进度
			local team = self._param.team
			team:setProcess(team:getProcess() + 1)
			--算队伍击怪积分
			local monsterInteral = 0
			for _,monsterID in pairs(monsterDBIDs) do
				if schoolActivityIntegralDB[monsterID] then
					monsterInteral = monsterInteral + schoolActivityIntegralDB[monsterID]
				end
			end
			--为每个队员添加积分
			for _,memberInfo in pairs(team:getMemberList()) do
				if memberInfo.memberState ~= MemberState.StepOut then
					local player = g_entityMgr:getPlayerByID( memberInfo.memberID )
					local handler = player:getHandler(HandlerDef_Activity)
					handler:setDekaronIntegral(handler:getDekaronIntegral()+ monsterInteral)
				end
			end
			--刷新排行
			g_dekaronSchoolMgr:updateRankList(team,true)
			
			--重新获取活动目标
			g_dekaronSchoolMgr:changeDekaronTarget(team)
		end
	end
end

function AScript:getScriptID()
	return self._param.scriptId
end

function AScript:getParams()
	return self._param 
end