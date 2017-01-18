--[[FightPVE.lua
描述：
	PVP战斗
--]]

require "base.base"


FightPVE = class(Fight)


function FightPVE:__init()
	
end

function FightPVE:_canFightEnd()
	--超时或者一方死亡
	local ALiveNum = 0
	local BLiveNum = 0
	for _,role in pairs(self._members[FightStand.A]) do
		
		if role:getLifeState() ~= RoleLifeState.Dead and ( instanceof(role,FightPlayer) or  instanceof(role,FightPet) ) then

			ALiveNum = 1
			break
		end
	end

	for _,role in pairs(self._members[FightStand.B]) do
		
		if (role:getLifeState() ~= RoleLifeState.Dead and not role:getIsGBH()) then
			BLiveNum = 1
			break
		end
	end

	if ALiveNum == 0 then
		self._winSide = FightStand.B
		return true
	elseif  BLiveNum == 0 then
		self._winSide = FightStand.A
		return true
	else
		if self._roundCount >=FightMaxRound then
			self._winSide = FightStand.A
			return true
		end
		return false
	end
end


function FightPVE:onEnterRoundStart()
	local i = self._actionSet.curIndex
	
	
	--怪物选动作
	local j = self._actionSet.curIndex
	for _,role in pairs(self._members[FightStand.B]) do
		local action = self._actionSet[j]
		action.role = role
		j = j + 1
		self._actionSet.curIndex = j
	end
	
end		

function FightPVE:__release()
	
end


