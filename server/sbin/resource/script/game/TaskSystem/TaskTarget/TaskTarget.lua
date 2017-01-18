--[[TaskTarget.lua
描述：
	任务目标类
--]]

TaskTarget = class()

function TaskTarget:__init(entity, task, param)
	self._task = task
	self._entity = entity
	self._param = param
	self._bor = param.bor
	self._state = 0
end

function TaskTarget:__release()
	self._task = nil
	self._entity = nil
	self._param = nil
	self._bor = nil
	self._state = nil
end

function TaskTarget:getBor()
	return self._bor
end

function TaskTarget:isFaild()
	return false
end

function TaskTarget:getState()
	return self._state
end

function TaskTarget:setState(state)
	self._state = state
end

function TaskTarget:addWatcher(eventName)
	local eventHandler = self._entity:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:addWatcher(eventName, self)
	end	
end

function TaskTarget:removeWatcher(eventName)
	local eventHandler = self._entity:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:removeWatcher(eventName, self)
	end
end

-- 基类什么也不做
function TaskTarget:removeAllWatchers()
end

-- 重新设置状态
function TaskTarget:resetState()
end

-- 动态添加脚本战斗ID待子类当中去实现
function TaskTarget:addScriptID(scriptID)

end
