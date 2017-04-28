--[[ToldTower.lua
描述：
	古塔驱妖任务目标
--]]

ToldTower = class(TaskTarget)

function ToldTower:__init(entity, task, param, state)	
	--获得已经上装的装备里有没有param.equipID
	self._state = state and state or 0
	self:addWatcher("onOldTowerClear")
	self:addWatcher("onOldTowerTimeOut")
	self._isfaild = false
	print("ToldTower is build")
end

-- 监听上装
function ToldTower:onOldTowerClear(clearTimes)
	if clearTimes >= oldTowerMaxClear then 
		self:setState(self._state + 1)
		if self:completed() then
			-- 如果完成
			print("ToldTower:onOldTowerClear")
			self._task:refresh()
			self:removeWatcher("onOldTowerClear")
			self:removeWatcher("onOldTowerTimeOut")
		end
	end
end

-- 监听上装
function ToldTower:onOldTowerTimeOut(isTimeOut)
	if isTimeOut then 
		self._isfaild = true
		self._task:refresh()
		self:removeWatcher("onOldTowerClear")
		self:removeWatcher("onOldTowerTimeOut")
	end
end

function ToldTower:isFaild()
	return self._isfaild
end

function ToldTower:completed()
	return self._state >= 1
end

function ToldTower:getState()
	return self._state
end

function ToldTower:removeWatchers()
	self:removeWatcher("onOldTowerClear")
	self:removeWatcher("onOldTowerTimeOut")
end

function ToldTower:removeAllWatchers()
	self:removeWatcher("onOldTowerClear")
	self:removeWatcher("onOldTowerTimeOut")
end