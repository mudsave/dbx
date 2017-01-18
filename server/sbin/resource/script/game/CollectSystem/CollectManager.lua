--[[CollectManager.lua
      采集管理类
--]]
require "base.base"

--固定坐标池坐标位置状态
ePosState = 
{
	loaded = 1,
	idle = 2,
}

CollectManager = class(nil, Singleton)

function CollectManager:__init()
    --记录固定坐标持种各个坐标的状态
	self.postionStateInfo = {}
	--记录物件上限刷新的个数
	self.totalAmount = {}
	--保存地图上所有加载了实体的坐标
	self.loadedPostion = {}
end

--检测给位置上是否有物件包
function CollectManager:addPosState(mapID, npcID, index)
	if not self.postionStateInfo[mapID] then
		self.postionStateInfo[mapID] = {}
	end
	if not self.postionStateInfo[mapID][npcID] then
		self.postionStateInfo[mapID][npcID] = {}
	end
	self.postionStateInfo[mapID][npcID][index] = ePosState.loaded
end

--地图上该点没有NPC,该点原先的loaded状态移除，该点设为idle 状态
function CollectManager:removePosState(mapID, npcID, index)
	if not self.postionStateInfo[mapID] then
		return
	end
	if not self.postionStateInfo[mapID][npcID] then --肯定有
	end
	--该点设为idle 状态
    self.postionStateInfo[mapID][npcID][index] = ePosState.idle
end

--检测位置状态
function CollectManager:checkPosState(mapID, npcID, index)
	if not self.postionStateInfo[mapID] then
		return ePosState.idle
	end
	if not self.postionStateInfo[mapID][npcID] then
		return ePosState.idle
	end
	return self.postionStateInfo[mapID][npcID][index]
end

--设置物件剩余数量
function CollectManager:setReminderAmount(mapID, npcID, amount) 
    local mapTable = {}
    self.totalAmount[mapID] = mapTable
    mapTable[npcID] = amount
end

--获得物件剩余数量 
function CollectManager:getReminderAmount(mapID, npcID)
	local mapNpcAmounts = mapID and self.totalAmount[mapID]
    local amount = mapNpcAmounts and mapNpcAmounts[npcID]
    return amount or 0
end

--减少物件数量
function CollectManager:reduceAmount(mapID, npcID)
	local mapNpcAmounts = mapID and self.totalAmount[mapID]
	if not mapNpcAmounts then
		return
	end
	local amount = mapNpcAmounts[npcID]
	if not amount then
		return
	end
	mapNpcAmounts[npcID] = amount - 1
end

--添加地图上加载了实体的坐标
function CollectManager:addEntityPos(mapID, postion)
    if not  self.loadedPostion[mapID] then
		self.loadedPostion[mapID] = {}
	end
    table.insert(self.loadedPostion[mapID], postion)
end

--移除表中没有加载实体的坐标
function CollectManager:removeEntitypos(mapID, postion)
    if self.loadedPostion[mapID] then
        for k,pos in ipairs (self.loadedPostion[mapID]) do
	        if postion[1] == pos[1] and postion[2] == pos[2] then
				table.remove (self.loadedPostion[mapID],k)
		    end
	    end
    end  
	
end

function CollectManager.getInstence()
    return CollectManager()
end

