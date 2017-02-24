--[[GoodsNpc.lua
描述：
    场景物件类
--]]

require "base.base"
require "entity.Entity"

GoodsNpc = class(Entity)

function GoodsNpc:__init()
  self._dbID = nil
  self._period = nil
  self._goodsType = nil
  self._postion = nil
  self._index = nil
  self._mapID = nil
  self._refreshTime = nil
  self._collectionInfo = nil
  self._collectedCount = 0
end

function GoodsNpc:__release()
	for htype,handler in pairs(self._handlers or {}) do
		release(handler)
		self._handlers[htype] = nil
	end
	self._handlers = nil
end

function GoodsNpc:setDBID(dbID)
	self._dbID = dbID
end

function GoodsNpc:getDBID()
	return self._dbID
end

function GoodsNpc:setGoodsType(goodsType)
	self._goodsType = goodsType
end

function GoodsNpc:getGoodsType()
	return self._goodsType 
end

function GoodsNpc:setPostion(postion)
	self._postion= postion
end

function GoodsNpc:getPostion(postion)
	return self._postion
end

function GoodsNpc:setUpdatePeriod(period)
	self._period = period
end

function GoodsNpc:getUpdatePeriod()
	return self._period
end

function GoodsNpc:setRefreshData(collection) 
    self._collection = collection
end

function GoodsNpc:getRefreshData()
	return self._collection
end

function GoodsNpc:setTotlecollectionData(collectionInfo) 
    self._collectionInfo = collectionInfo
end

function GoodsNpc:getTotlecollectionData()
	return self._collectionInfo
end

function GoodsNpc:setLastCollect(refreshTime) 
    self._refreshTime = refreshTime
end

function GoodsNpc:getLastCollect()
	return self._refreshTime
end

function GoodsNpc:attachScene(scene,tile)
	scene:attachEntity(self,unpack(tile))
	self._tile = tile
end

function GoodsNpc:setMapID(mapID)
	self._mapID = mapID
end
 
function GoodsNpc:getMapID()
    
	return self._mapID
end

function GoodsNpc:setMapTileindex(index)
	self._index = index
end
 
function GoodsNpc:getMapTileindex()
	return self._index
end

function GoodsNpc:setPosIndex(index)
	self.index = index
end
 
function GoodsNpc:getPosIndex()
	return self.index
end

function GoodsNpc:setCollectedCount(count)
	 self._collectedCount = count
end

function GoodsNpc:getCollectedCount()
	 return self._collectedCount 
end