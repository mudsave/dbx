--[[PetDepotHandler.lua
描述：
	宠物仓库handler
]]

PetDepotHandler = class()

function PetDepotHandler:__init(entity)
	self._entity = entity
	self.curCapacity = 3    --宠物仓库大小默认为3

end

--设置宠物仓库容量
function PetDepotHandler:setCapacity(capacity)
	self.curCapacity = capacity
end

--获取宠物仓库的容量
function PetDepotHandler:getCapacity()
	return self.curCapacity
end


--上线发送数据到客户端
function PetDepotHandler:sendDataToClient()
	
end