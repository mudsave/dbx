--[[SceneManager.lua
描述：
	场景管理器
--]]

require "base.base"
require "scene.Scene"
require "game.CollectSystem.CollectionRefresher"
SceneManager = class(nil, Singleton)

function SceneManager:__init()
	self.scene = {}
	self.ectypeScene = {}
	self.factionScene = {}
	self._GoldHuntZone = {}
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
		if mapID ~= 7 then
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
end


--通过地图ID获取场景 
function SceneManager:getSceneByID(mapID)
	return self.scene[mapID]
end

function SceneManager:loadSystemByScene()
	-- 检测副本配置
	CheckEctypeConfigValid()
	--刷新对象加载
	local instance = CollectionRefresher.getInstance()
	instance:loadInitCollections()
	instance:start()
end

function SceneManager:enterPublicScene(mapID, role, x, y)
	local scene = self.scene[mapID]
	if scene and role and x and y then
		local prevPos = role:getPrevPos()
		local pos = role:getPos()
		prevPos[1],prevPos[2],prevPos[3] = pos[1],pos[2],pos[3]
		
		if scene:attachEntity(role, x, y) then
			if role:getEntityType() == eClsTypePlayer then
				local petID = role:getFollowPetID()
				local pet = petID and g_entityMgr:getPet(petID)
				if pet and pet:isVisible() then
					pet:setVisible(false)
					pet:setVisible(true)
				end
			end
			return true
		end
	end
end

function SceneManager:reEnterScene(player)
	print("SceneManager:reEnterScene")
	local scene = player:getScene()
	local mapID,x,y = player:getCurPos()
	print(scene,mapID,x,y)
	scene:detachEntity(player)
	local peer = player:getPeer()
	peer:setIsFirstCast(true)
	scene:attachEntity(player, x, y)
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

-- 根据配置ID 获取场景地图
function SceneManager:getRandomPosition(mapID)
	local scene = self.scene[mapID]
	if not scene then
		print("随机地图没有配置")
	end
	local peer = scene:getPeer()
	local vect = peer:FindRandomTile(mapID)
	-- 返回一个x,y`
	if vect.x == 0 and vect.y == 0 then
		print("$$ error getRandomPosition()")
	end
	return vect.x, vect.y
end

-- 切换场景
function SceneManager:doSwitchScence(roleID,tarMapID,x,y)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local handler	= player:getHandler(HandlerDef_Team)
	local team		= g_teamMgr:getTeam(handler:getTeamID())
	if team then
		if not handler:isStepOutState() then
			for _,member in pairs(handler:getTeamPlayerList()) do
				if member ~= player then
					self:enterPublicScene(tarMapID,member,x,y)
				end
			end
		end
	end
	if self:enterPublicScene(tarMapID,player,x,y) then
		player:getHandler(HandlerDef_Follow):loadFollowEntity(tarMapID,x,y)

		self:notifySystem(roleID,tarMapID,x,y)
	end
end

function SceneManager:notifySystem(roleID,mapID,x,y)
	--[[
		TaskCallBack.onEntityPosChanged(roleID,mapID,x,y)
		MineSystem.getInstacne():onSceneChanged(roleID,mapID,x,y)
	--]]
end

function SceneManager.getInstance()
	return SceneManager()
end

-- 创建副本场景
function SceneManager:createEctypeScene(mapID)
	local mapConfig = mapDB[mapID]
	if not mapConfig then
		return -1
	end
	local scene = Scene()
	local peer = CoScene:Create(mapConfig.sceneType, mapID, mapConfig.map)
	scene:setPeer(peer)
	scene:setMapID(mapID)
	local ectypeMapID = g_ectypeMgr:generateEctypeMapID()
	self.ectypeScene[ectypeMapID] = scene
	return ectypeMapID
end

-- 进入副本场景 roles:{{role,x,y}}
function SceneManager:enterEctypeScene(ectypeMapID, roleInfo)
	local toScene = self.ectypeScene[ectypeMapID]
	if not toScene then
		return
	end
	local role,x, y = unpack(roleInfo)
	if role and x and y then
		toScene:attachEntity(role, x, y)
		if role:getEntityType() == eClsTypePlayer then
			role:setEctypeMapID(ectypeMapID)
			local petID = role:getFollowPetID()
			local pet = petID and g_entityMgr:getPet(petID)
			if pet and pet:isVisible() then
				pet:setVisible(false)
				pet:setVisible(true)                  
			end
			-- 拉玩家的跟随NPC进入副本
			role:getHandler(HandlerDef_Follow):loadFollowEntityEx(ectypeMapID, x-1, y-1)
		end
	end
end

-- 销毁副本场景
function SceneManager:releaseEctypeScene(ectypeMapID)
	local scene = self.ectypeScene[ectypeMapID]
	if not scene then
		return
	end
	-- 释放场景
	local peer = scene:getPeer()
	if peer then
		--peer:close()
	end
	release(scene)
	self.ectypeScene[ectypeMapID] = nil
end

-- 创建猎金场场景
function SceneManager:createGoldHuntScene(mapID,activityID)
	local mapConfig = mapDB[mapID]
	if not mapConfig then
		return -1
	end
	local scene = Scene()
	local peer = CoScene:Create(mapConfig.sceneType, mapID, mapConfig.map)
	scene:setPeer(peer)
	scene:setMapID(mapID)
	self._GoldHuntZone[activityID] = scene
	return scene
end

-- 进入猎金场场景 
function SceneManager:enterGoldHuntScene(activityID, role,x ,y)
	local toScene = self._GoldHuntZone[activityID]
	if not toScene then
		return false
	end
	if role and x and y then
		local prevPos = role:getPrevPos()
		local pos = role:getPos()
		prevPos[1],prevPos[2],prevPos[3] = pos[1],pos[2],pos[3]

		toScene:attachEntity(role, x, y)
		if role:getEntityType() == eClsTypePlayer then
			
			local petID = role:getFollowPetID()
			local pet = petID and g_entityMgr:getPet(petID)
			if pet and pet:isVisible() then
				pet:setVisible(false)
				pet:setVisible(true) 
				toScene:attachEntity(pet, x -1 , y - 1 )
			end
			return true
		end
	end
	return false
end

function SceneManager:isInGoldHuntScene(player)
	local curScene = player:getScene()
	for _ ,scene in pairs(self._GoldHuntZone) do
		if curScene == scene then
			return true
		end
	end
	return false
end

function SceneManager:isGoldHuntScene(curScene)
	
	for _ ,scene in pairs(self._GoldHuntZone) do
		if curScene == scene then
			return true
		end
	end
	return false
end

-- 销毁猎金场场景
function SceneManager:releaseGoldHuntScene(activityID)
	local scene = self._GoldHuntZone[activityID]
	if not scene then
		return
	end
	--遣返还在的玩家
	local entityList = scene:getEntityList()
	for ID, role in pairs(entityList) do
		if instanceof(role, Player) and role:getStatus() ~= ePlayerFight then
			local prevPos = role:getPrevPos()
			self:doSwitchScence(role:getID(),prevPos[1],prevPos[2],prevPos[3])
		end
	end
	-- 释放场景
	local peer = scene:getPeer()
	if peer then
		--peer:close()
	end
	release(scene)
	self._GoldHuntZone[activityID] = nil
end

--检验玩家要进入的猎金场当前玩家数
function SceneManager:checkPlayerCountInGoldHuntMap(player)
	local	activityID = g_goldHuntMgr:getPlayerActivityID(player)
	if activityID then
		local scene = self._GoldHuntZone[activityID]
		if  scene then
			local playerCount = scene:getPlayerCount()
			if playerCount < GoldHuntZone_MapPlayerLimit then
				return true
			end
		end
	end
	return false
end

function SceneManager:enterFactionSceneAtBegin(factionDBID,roleInfo)

	local toScene = self.factionScene[factionDBID]
	if not toScene then return end
	local role,x,y = unpack(roleInfo)
	if role and x and y then
		local success = toScene:attachEntity(role,x,y)
		if success and role:getEntityType() == eClsTypePlayer then
			local petID = role:getFollowPetID()		
			local pet = petID and g_entityMgr:getPet(petID)
			if pet and pet:isVisible() then
				pet:setVisible(false)
				pet:setVisible(true)
			end
		end
		return success
	end
end

--创建帮派场景
function SceneManager:createFactionScene(factionDBID )

	if self.factionScene[factionDBID] then
		return -1
	else
		local mapConfig = mapDB[7]
		if not mapConfig then
			return -1 
		end
		local scene = Scene()
		local peer = CoScene:Create(mapConfig.sceneType, 7, mapConfig.map)
		scene:setPeer(peer)
		scene:setMapID(7)
		--scene:setPkConfig(mapConfig.pkConfig)
		--scene:setRandomScriptFights(mapConfig.rodScriptFights)
		scene:setSceneType(mapConfig.mapType)
		scene:initStaticNpc(mapConfig.npcs)
		scene:loadMineInfo(mapConfig.obviousMines or {})
		scene:loadScopeMines(mapConfig.scopeMines or {})
		
		self.factionScene[factionDBID] = scene
	end

end

--准备进入帮派场景
function SceneManager:doEnterFactionScene(roleID,x, y)

	local player = g_entityMgr:getPlayerByID(roleID)
	local factionDBID = player:getFactionDBID()

	if not player then
		return
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:getTeamID() ~= -1 then
		local msg = FactionMsgTextKeyTable.CantEnterFactionScene
        local notifyParams = {msg = msg}
        local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FactionNotify,notifyParams)
        g_eventMgr:fireRemoteEvent(event_Notify,player)
	else
		if self:enterFactionScene(factionDBID, {player, x ,y}) then
			player:getHandler(HandlerDef_Follow):loadFollowEntity(7, x ,y)
		end
	end
end

--进入帮派场景
function SceneManager:enterFactionScene(factionDBID,roleInfo)

	local toScene = self.factionScene[factionDBID]
	if not toScene then return end
	local role,x,y = unpack(roleInfo)

	if role and x and y then
		local success = toScene:attachEntity(role,x,y)
		if success and role:getEntityType() == eClsTypePlayer then
			local petID = role:getFollowPetID()		
			local pet = petID and g_entityMgr:getPet(petID)
			if pet and pet:isVisible() then
				pet:setVisible(false)
				pet:setVisible(true)
			end
		end
		return success
	end

end


function SceneManager:getValidEmptyPos(conditions)
	local mapList = {}
	getMapIDByCondition(mapList, conditions or {{}})
	--检测出符合条件的所有地图并随机出一个地图
	local mapId = mapList[math.random(1,#mapList)]	
	local scene = self.scene[mapId]
	if not scene then
		print("找不到这个场景,mapID = ",mapID)
	end
	
	--开始随机坐标
	local x,y
	local checkTime = 0
	local checkSuccess
	while (1) do
		if checkTime > 50 then
			print("检测50次依然没有发现可用坐标")
			break
		end
		checkTime = checkTime + 1
		checkSuccess = true 

		x,y = self:getRandomPosition(mapId)
		for entityId, entity in pairs(scene:getEntityList()) do
			if entity:getEntityType() == eLogicNpc or entity:getEntityType() == eLogicGoodsNpc then
				if entity:getPos()[2] == x and entity:getPos()[3] == y then
					checkSuccess = false
					break
				end
			end
		end
		if checkSuccess then
			break
		end
	end

	--随机失败,直接放到安全坐标
	if checkSuccess == false then
		return mapId, mapDB[mapId].safeX, mapDB[mapId].safeY
	end
	--print("随机坐标成功mapID, x, y", mapId, vect.x, vect.y)
	return mapId, x, y
end

function getMapIDByCondition(mapList, conditions)
	for mapID, mapConfig in pairs(mapDB) do
		local irtMap = true
		for _, condition in pairs(conditions) do	
			if condition.type == "level" then
				if condition.param.state then
					if mapConfig.level then
						if mapConfig.level < condition.param.level then
							irtMap = false
							break
						end
					end
				else
					if mapConfig.level then
						if mapConfig.level > condition.param.level then
							irtMap = false
							break
						end
					end
				end
			end
			if condition.type == "type" then
				if condition.param.type ~= mapConfig.mapType then
					irtMap = false
					break
				end
			end
			--其他条件
			
		end
		if irtMap then
			table.insert(mapList, mapID)
		end
	end
end

-- 副本场景随机坐标
function SceneManager:getEctypeRandomPosition(ectypeMapID, mapID)
	local scene = self.ectypeScene[ectypeMapID]
	if not scene then
		print("没有副本场景")
		return
	end
	local peer = scene:getPeer()
	local vect = peer:FindRandomTile(mapID)
	-- 返回一个x,y`
	if vect.x == 0 and vect.y == 0 then
		print("$$ error getRandomPosition()")
	end
	return vect.x, vect.y
end

function SceneManager:getEctypeScene(ectypeMapID)
	return self.ectypeScene[ectypeMapID]
end