--[[Scene.lua
ÃèÊö£º	³¡¾°µÄ½Å±¾²ã
--]]

Scene = class()
		
function Scene:__init()
	self._mapID	= nil
	self._peer = nil
	self._type = nil
	self.entityList = {}
end

function Scene:__release()
	self._mapID	= nil
	self._peer = nil
	self._type = nil
end

function Scene:setPeer(peer)
	self._peer = peer
end

function Scene:getPeer()
	return self._peer
end

function Scene:setMapID(mapID)
	self._mapID = mapID
end

function Scene:getMapID()
	return self._mapID
end

function Scene:setSceneType(sceneType)
	self._type = sceneType
end

function Scene:getSceneType()
	return self._type
end

function Scene:getEntityList()
	return self.entityList
end

function Scene:attachEntity(entity, posX, PosY)
	local peer = entity:getPeer()
	local curScene = entity:getScene()
	if curScene then
		if (curScene == self) then
			peer:move(0, posX, PosY)
			return
		else
			curScene:detachEntity(entity)
		end
	end
	entity:setScene(self)
	self.entityList[entity:getID()] = entity
	if posX and PosY and peer then 
		return peer:enterScene(self._peer, posX, PosY)
	end
end

function Scene:detachEntity(entity)
	if not entity or entity:getScene() ~= self then
		return false
	end
	local peer = entity:getPeer()
	entity:setScene(nil)
	self.entityList[entity:getID()] = nil
	if peer then 
		peer:quitScene() 
	end
	return true
end

function Scene:initStaticNpc(npcs)
	for _, npcID in pairs(npcs or {}) do
		g_entityFct:createStaticNpc(npcID)
	end
end

function Scene:loadMineInfo(mineInfos)
	for _, mineInfo in pairs(mineInfos or {}) do
		local mineNpc = g_entityFct:createMineNpc(mineInfo.npcID)
		mineNpc:setConfig(mineInfo)
		mineNpc:setScriptID(mineInfo.scriptID)		
		mineNpc:setMovePath(mineInfo.tiles)
		mineNpc:setNpcType(MineNpcType.ConfigPath)
		mineNpc:setUpdatePeriod(mineInfo.updateTime)
		self:attachEntity(mineNpc, mineInfo.tiles[1][1], mineInfo.tiles[1][2])
		--mineNpc:beginMove()
	end
end

function Scene:loadScopeMines(mineInfos)
	for _, mineInfo in pairs(mineInfos or {}) do
		local mineNpc = g_entityFct:createMineNpc(mineInfo.npcID)
		mineNpc:setConfig(mineInfo)
		mineNpc:setScriptID(mineInfo.scriptID)
		mineNpc:setCenterTile(mineInfo.centerTile)
		mineNpc:setRadius(mineInfo.radius)
		mineNpc:setNpcType(MineNpcType.RandPath)
		mineNpc:setUpdatePeriod(mineInfo.updateTime)
		self:attachEntity(mineNpc, mineInfo.centerTile[1], mineInfo.centerTile[2])
		--mineNpc:beginScopeMove()
	end
end