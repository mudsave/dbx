--[[FightServerLoad.lua
描述：
	战斗服负载相关
--]]

FightServerLoad = class(nil, Singleton)

function FightServerLoad:__init()
    self._loads = nil --[worldID] = fightCount
end

function FightServerLoad:__release()
    self._loads = nil
end

function FightServerLoad:set(loads)
    self._loads = loads
end

function FightServerLoad:getMinLoadWorldID()
	local minWorldID, minCount
	for worldID,fightCount in pairs(self._loads) do
		if (not minWorldID) and (not minCount) then
			minWorldID = worldID
			minCount = fightCount
		else
			if fightCount < minCount then
				minWorldID = worldID
				minCount = fightCount
			end
		end
	end

	return minWorldID
end

function FightServerLoad.setLoad(loads)
    g_fightServerLoad:set(loads)
    -- print ("FightServerLoad:set\n", toString(loads))
end

function FightServerLoad.getInstance()
    return FightServerLoad()
end