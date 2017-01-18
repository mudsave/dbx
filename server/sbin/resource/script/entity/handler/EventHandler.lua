--[[EventHandler.lua
描述：
	事件监听类
--]]

EventHandler = class()

function EventHandler:__init(entity)
	self._entity = entity
	self._watchers = {}
	self._delayWatchers = {}
	self._watcherStates = {}
end

function EventHandler:__release()
	self._entity = nil
	self._watchers = {}
	self._delayWatchers = {}
	self._watcherStates = {}
end

function EventHandler:addWatcher(eventName, watcher)
	if self._watcherStates[eventName] == true then
		if not self._delayWatchers[eventName] then
			self._delayWatchers[eventName] = {}
		end
		table.insert(self._delayWatchers[eventName], watcher)
		return
	end
	if self._watchers[eventName] then
		self._watchers[eventName][watcher]=true
	else
		self._watchers[eventName]={[watcher]=true}
	end

end

function EventHandler:addWatchers(eventNames, watcher)
	for _, eventName in pairs(eventNames or table.empty) do
		self:addWatcher(eventName, watcher)
	end
end

function EventHandler:removeWatcher(eventName, watcher)
	if self._watchers[eventName] then
		self._watchers[eventName][watcher]= false
	end
end

function EventHandler:removeWatchers(eventNames, watcher)
	for _, eventName in pairs(eventNames or table.empty) do
		self:removeWatcher(eventName, watcher)
	end
end

function EventHandler:notifyWatchers(eventName,...)
	if self._watchers[eventName] then
		self._watcherStates[eventName] = true
		for watcher,yes in pairs(self._watchers[eventName]) do
			if yes and type(watcher[eventName])=="function" then
				watcher[eventName](watcher, ...)
 			end
		end
		self._watcherStates[eventName] = false
		for idx, watcher in ipairs(self._delayWatchers[eventName] or {}) do
			self:addWatcher(eventName, watcher)
		end
		self._delayWatchers[eventName] = {}
	end
end