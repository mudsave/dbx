--[[FightManager.lua
描述：
	战斗的管理
--]]

require "base.base"


FightManager = class(nil,Singleton)



function FightManager:__init()
	self._fights = {}
end

function FightManager:addFight(fight)

	local ID = fight:getID()
	self._fights[ID] = fight
	
end

function FightManager:getFight(ID)

	return 	self._fights[ID] 
end

function FightManager:removeFight(fightID)

	local fight = self._fights[fightID]
	if fight then
		--通知世界服务器

		--释放
		release(fight)
		self._fights[fightID] = nil
		
	end
	
end

function FightManager.getInstance()
	return FightManager()
end



