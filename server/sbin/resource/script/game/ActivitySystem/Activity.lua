--[[Activity.lua
描述：
	活动基类
--]]

Activity = class()

function Activity:__init()
	self._id			= nil --活动id
	self._targetList	= {} --活动目标
	self._status		= nil --活动状态
end

function Activity:__release()
	self._id			= nil
	self._targetList	= nil
	self._status		= nil
end

function Activity:addTarget(target)
	self._targetList[target] = true
end

function Activity:removeTarget(target)
	self._targetList[target] = nil
end

--活动结束
function Activity:close()
	for target, flag in pairs(self._targetList or {}) do
		if flag == true then
			local player = target:getEntity()
			player:getHandler(HandlerDef_Activity):closeActivity(self._id)
			release(target)
		else
			print("活动目标施放出错")
		end
	end	
end