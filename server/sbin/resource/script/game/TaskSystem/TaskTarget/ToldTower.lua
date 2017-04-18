--[[ToldTower.lua
描述：
	古塔驱妖任务目标
--]]

ToldTower = class(TaskTarget)

function ToldTower:__init(entity, task, param, state)	
	--获得已经上装的装备里有没有param.equipID
	self._state = state and state or 0
	self:addWatcher("onOldTowerClear")
end

-- 监听上装
function Tpuzzle:onPuzzleFinish(clearTimes)
	if clearTimes == 20 then 
		self:setState(self._state + 1)
		if self:completed() then
			-- 如果完成，那么此时购买物品经停已经删除
			self._task:refresh()
			self:removeWatcher("onOldTowerClear")
		end
	end
end

function ToldTower:completed()
	return self._state >= 20
end

function ToldTower:getState()
	return self._state
end

function ToldTower:removeWatchers()
	self:removeWatcher("onOldTowerClear")
end

function ToldTower:removeAllWatchers()
	self:removeWatcher("onOldTowerClear")
end