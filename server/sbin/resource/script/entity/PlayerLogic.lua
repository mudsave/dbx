--[[PlayerLogic.lua
描述：
	玩家业务逻辑部分
--]]




function Player:__init_logic()
	
	self._ectypeMapID	= false
end

function Player:__release_logic()
	--todo
	
	self._ectypeMapID = nil
end



-- 设置玩家副本动态ID
function Player:setEctypeMapID(ectypeMapID)
	self._ectypeMapID = ectypeMapID
end

-- 获取玩家副本动态ID
function Player:getEctypeMapID()
	return self._ectypeMapID
end

--player is can move 
function Player:isCanMove()
	--[[
	if self:getActionState() == PlayerStates.Follow then
		return false
	elseif self:isFighting() then
		return false
	end
	]]
	return true
end
