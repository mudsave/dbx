--[[ActivityCallBack.lua
描述：
	活动完成回调(活动系统)
--]]

ActivityCallBack = {}

function ActivityCallBack.onExamination(player, answerID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onExamination", answerID)
	end
	local activityHandler = self._entitiy:getHandler(HandlerDef_Activity)
	if activityHandler then
		activityHandler:releaseFinishTargets()
	end
end