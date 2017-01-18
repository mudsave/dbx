--[[FightNpc.lua
描述：
	战斗怪物实体
--]]

FightNpc = class(FightEntity)

function FightNpc:__init()
	--self._pos = {nil,nil,nil} --在entity中有,含义:地图ID,FightStand.A or FightStand.B,编号
	self._fightID = nil
	self._id = FightEntityMaxID
	FightEntityMaxID = FightEntityMaxID + 1
end
 