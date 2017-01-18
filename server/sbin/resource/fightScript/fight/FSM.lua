--[[FSM.lua
描述：
	战斗系统状态机
--]]

require "base.base"


FSM = class()

function FSM:__init()
	self.state = nil
	--self:enterState(self.state)
end

function FSM:gotoState(state)
	local oldState = self.state
	if oldState == state then
		return
	end
	self:leaveState(oldState)
	self.state = state
	self:enterState(state)
end

function FSM:leaveState(state)
	local action = FightLeaveAction[state]
	if action then
		action(self)
	end
end

function FSM:enterState(state)
	local action = FightEnterAction[state]
	if action then
		action(self)
	end
end

function FSM:input(event)
	local eventID = event:getID()
	local params = event:getParams()

	local actions = FightInputAction[self.state]
	if not actions then
		return
	end

	local action = actions[eventID]
	if not action then
		return
	end

	action(self,params)
end

function FSM:update()
	local action = FightTimeOutAction[self.state]
	if action then
		action(self)
	end
end



