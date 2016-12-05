--[[SceneManager.lua
描述：
	场景管理器
--]]

require "base.base"
require "scene.Scene"

SceneManager = class(nil, Singleton)

function SceneManager:__init()
	self.scene = {}
	self.ectypeScene = {}
	self.factionScene = {}
end

function SceneManager:__release()
	for idx,iter in pairs(self.scene) do
		release(iter)
		self.scene[idx] = nil
	end
	self.scene = nil
end

function SceneManager:getSceneByID(mapID)
	return self.scene[mapID]
end

function SceneManager:loadPublicScenes()
	for mapID, mapConfig in pairs(mapDB) do
		local scene = Scene()
		local peer = CoScene:Create(mapConfig.mapType, mapID, mapConfig.map)
		scene:setPeer(peer)
		scene:setMapID(mapID)
		scene:setSceneType(mapConfig.mapType)
		scene:initStaticNpc(mapConfig.npcs)
		scene:loadMineInfo(mapConfig.obviousMines or {})
		scene:loadScopeMines(mapConfig.scopeMines or {})
		self.scene[mapID] = scene
	end
end

function SceneManager:enterPublicScene(mapID, role, x, y)
	local scene = self.scene[mapID]
	if scene and role and x and y then
		local success = scene:attachEntity(role, x, y)
		return success
	end
end

--判断这个场景地图的点是否可以用
function SceneManager:isPosValidate(mapID, x, y)
	local scene = self.scene[mapID]
	if not scene then
		return nil
	end
	local peer = scene:getPeer()
	return peer:PosValidate(mapID, x, y)
end

function SceneManager.getInstance()
	return SceneManager()
end