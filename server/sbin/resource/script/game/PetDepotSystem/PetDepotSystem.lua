--[[PetDepotSystem.lua
描述:
	宠物仓库消息接收
]]

require "game.PetDepotSystem.PetDepotManager"

PetDepotSystem = class(EventSetDoer, Singleton)

function PetDepotSystem:__init()
	self._doer = 
	{
		[PetDepotEvent_CS_ExpandPetDepot]	= PetDepotSystem.doExpandPetDepot,
		[PetDepotEvent_CS_PutInPet]			= PetDepotSystem.doPutInPet,
		[PetDepotEvent_CS_TakeOutPet]		= PetDepotSystem.doTakeOutPet,
	}
end

--扩充宠物仓库
function PetDepotSystem:doExpandPetDepot(event)
	local params = event:getParams()
    local roleID = params[1]
	g_PetDepotMgr:doExpandPetDepot(roleID)
end

--宠物的存入
function PetDepotSystem:doPutInPet(event)
	local params = event:getParams()
	local roleID = params[1]
	local petID = params[2]
	g_PetDepotMgr:doPutInPet(roleID,petID)
end

--宠物的取出
function PetDepotSystem:doTakeOutPet(event)
	local params = event:getParams()
	local roleID = params[1]
	local petID = params[2]
	g_PetDepotMgr:doTakeOutPet(roleID,petID)
end

function PetDepotSystem.getInstance()
	return PetDepotSystem()
end


EventManager.getInstance():addEventListener(PetDepotSystem.getInstance())