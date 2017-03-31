--[[Tpuzzle.lua
描述：
	拼图任务目标
--]]

Tpuzzle = class(TaskTarget)

function Tpuzzle:__init(entity, task, param, state)	
	--获得已经上装的装备里有没有param.equipID
	self._state = state and state or 0
	self:addWatcher("onPuzzleFinish")
end

-- 监听上装
function Tpuzzle:onPuzzleFinish(puzzleID)
	if puzzleID == self._param.puzzleID then 
		self:setState(self._state + 1)
		if self:completed() then
			-- 如果完成，那么此时购买物品经停已经删除
			self._task:refresh()
			self:removeWatcher("onPuzzleFinish")
		end
	end
end

function Tpuzzle:completed()
	return self._state >= 1
end

function Tpuzzle:getState()
	return self._state
end

-- 当中卖物品的监听不有删除，还要持续监听
function Tpuzzle:removeWatchers()
	self:removeWatcher("onPuzzleFinish")
end

function Tpuzzle:removeAllWatchers()
	self:removeWatcher("onPuzzleFinish")
end