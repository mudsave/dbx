--[[FightPVP.lua
描述：
	PVP战斗
--]]

require "base.base"


FightPVP = class(Fight)


function FightPVP:__init()
	
end

function FightPVP:onEnterRoundStart()
	
end

function FightPVP:getRolePos(roleType, side, totalCount, unknown, player)
	
	local map = FightStandMap[self._fightType] 
	local subMap = map[side]
	local subSubMap = subMap[totalCount] --对应于玩家数(怪物数)的map
	local curMembers = self._members[side]

	if  (roleType == StandRoleType.Player  or roleType == StandRoleType.Npc) then
		local finalMap = subSubMap[roleType]
		for k,pos in ipairs(finalMap) do
			local role = curMembers[pos] 	
			if not role then
				if  roleType == StandRoleType.Player then
					player.posIndex = k
				end
				return pos
			end
		end
		if roleType == StandRoleType.Player then
			print("玩家阵型已满",side)
		elseif roleType == StandRoleType.Pet then
			print("宠物阵型已满",side)
		elseif roleType == StandRoleType.Npc then
			print("npc阵型已满",side)
		end 

		if true then  
			return nil 
		end 
	
	elseif roleType == StandRoleType.Pet then
		local finalMap = subSubMap[roleType]
		local posIndex = player.posIndex
		local pos = finalMap[posIndex]
		return pos
	end
end

function FightPVP:__release()
	
end