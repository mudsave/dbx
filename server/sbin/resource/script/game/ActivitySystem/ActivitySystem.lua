--[[ActivitySystem.lua
	描述:活动系统和客户端的信息交换
]]


require "game.ActivitySystem.Activity"
require "game.ActivitySystem.ActivityManager"
require "game.ActivitySystem.ActivityCallBack"
require "game.ActivitySystem.ActivityTarget"


require "game.ActivitySystem.Activity.GoldHuntZone.GoldHuntZone1"
require "game.ActivitySystem.Activity.GoldHuntZone.GoldHuntZone2"
require "game.ActivitySystem.Activity.GoldHuntZone.GoldHuntZone3"
require "game.ActivitySystem.Activity.GoldHuntZone.GoldHunt_PK"
require "game.ActivitySystem.Activity.GoldHuntZone.GoldHunt_Collect"
require "game.ActivitySystem.Activity.GoldHuntZone.GoldHunt_PVE"
require "game.ActivitySystem.Activity.GoldHuntZone.GoldHuntManager"
require "game.ActivitySystem.Activity.CatchPet.CatchPetActivity"

ActivitySystem = class(EventSetDoer, Singleton)

function ActivitySystem:__init()
	self._doer =
	{
		
	}
end

function ActivitySystem:__release()

end

function ActivitySystem.getInstance()
	return ActivitySystem()
end

EventManager.getInstance():addEventListener(ActivitySystem.getInstance())





