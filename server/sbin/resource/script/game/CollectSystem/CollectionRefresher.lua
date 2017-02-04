--[[CollectionRefresher.lua
	描述：
		采集的刷新工具
--]]
require "base.RandomTool"
CollectionRefresher = class(nil,Timer,Singleton)

function CollectionRefresher:__init()
	self.showingNpcs = {}
	self.hiddenNpcs = {}
	self.timerID = -1
end

--[[
	 获得采集物的位置
--]]

local function GetCollectPosition(posType, posData,mapID, npcID,collectionInfo)
	if posType == PosEnum.fixedPos then
		return posData
	end
	
	if posType == PosEnum.fixedRandPos then
	    local fixedRandPosTable = CollectionRefresher:getFixRandPos(posData, mapID, npcID,collectionInfo)
	    return fixedRandPosTable
	end
	
	if posType == PosEnum.randPos then
		local randPosTable = CollectionRefresher:getPnts(mapID,collectionInfo)	
		return randPosTable
	end
	
	if posType == PosEnum.uperRandPos then
		local uperRandPosTable = CollectionRefresher:getPnts(mapID,collectionInfo)	
		return uperRandPosTable
	end
	
	return nil
end

--通过随机个数获取固定坐标池中坐标个数
function CollectionRefresher:getFixRandPos(posData, mapID, npcID,collectionInfo)
    local pTable ={}
	local num  = collectionInfo.number
	local getIndex,reset = NonRepeatIndex (#posData)
    for i = 1, num do
		local index =getIndex()
		local n = 1
		while(g_CollectMgr:checkPosState(mapID, npcID, index) == ePosState.loaded) do
			index = getIndex()
			n = n+1	
			--随机10次找不到就结束随机
			if n >=10 then 
				break
			end
		end
		table.insert(pTable,{posData[index],index} )
	end
    return pTable
end

--通过随机个数全地图随机坐标个数
function CollectionRefresher:getPnts(mapID,collectionInfo)
	local scene = g_sceneMgr:getSceneByID(mapID) 
	if not scene then 
	    return 
	end
	local pTable = {}
	local peer = scene:getPeer()
	local num  = collectionInfo.number
    for i = 1, num do
		local point = peer:FindRandomTile(mapID)
		local postion = {point.x,point.y}
		table.insert(pTable, postion)
	end
	return pTable
end

--获取单个随机坐标
function CollectionRefresher:getSingleRandPos(mapID,collection)
	local scene = g_sceneMgr:getSceneByID(mapID) 
	if not scene then 
	    return 
	end
	local peer = scene:getPeer()
	--C++层随机一个坐标
    local point = peer:getRandomPosition()
	for _, collectInfo in ipairs(collection) do
	    local Type = collectInfo.posType 
		--判断该坐标是否在固定刷新类型和固定池随机刷新类型内
		if Type == PosEnum.fixedPos or Type == PosEnum.fixedRandPos then
		    for _,pos in ipairs(collectInfo.posData) do
		        --比较随机点是否和两种类型中的坐标相等
			    if point.x == pos[1] and point.y == pos[2]then
				    return self:getSingleRandPos(mapID,collection)
		        else
                    local entityPosTable = g_CollectMgr.loadedPostion[mapID]
				    for _, pos in ipairs(entityPosTable) do
						if point.x == pos[1] and point.y == pos[2] then
							return self:getSingleRandPos(mapID,collection)
						else
							local postion = {point.x,point.y}
							return postion	
						end
		            end
				end	
			end
		end
	end
	
end

--初始加载采集物件
function CollectionRefresher:loadInitCollections()
	for mapID,mapCollections in pairs(CollectionDB) do 
		local scene = g_sceneMgr:getSceneByID(mapID)
		if mapCollections then
			for _,collection in ipairs(mapCollections) do 
		        local npcID = collection.itemID
		        local Type = collection.posType
				
				--固定点刷新类型的初始加载到场景
				if Type == PosEnum.fixedPos then
					local posInfo = GetCollectPosition(collection.posType,collection.posData,mapID ,npcID,nil)
					for index ,tile in ipairs(posInfo) do
						local npc = g_entityFct:createGoodsNpc(collection,npcID,index)
						npc:setMapID(mapID)					
						npc:setRefreshData(collection)
						scene:attachEntity(npc,unpack(tile))
					end
				end
				
				--固定坐标池随机点刷新类型的初始加载到场景
				if Type == PosEnum.fixedRandPos then
					local posIndexInfo = GetCollectPosition(collection.posType,collection.posData,mapID,npcID,collection)
					for _ , posIndesin in ipairs(posIndexInfo) do
						local npc = g_entityFct:createGoodsNpc(collection,npcID,nil)
						npc:setMapID(mapID)					
						npc:setRefreshData(collection)
						npc:setPosIndex(posIndesin[2])
						scene:attachEntity(npc,unpack(posIndesin[1]))
						g_CollectMgr:addPosState(mapID, npcID, posIndesin[2])
					end
				end
				
				--全地图随机刷新类型的初始加载到场景
				if Type == PosEnum.randPos then
				    local pos = GetCollectPosition(collection.posType,nil,mapID,nil,collection )
					for _, postion in ipairs(pos) do
						local npc = g_entityFct:createGoodsNpc(collection,npcID,nil)
						npc:setMapID(mapID)		
						npc:setRefreshData(collection)
						npc:setPostion(postion)
						npc:setTotlecollectionData(mapCollections)
						scene:attachEntity(npc,unpack(postion))
						g_CollectMgr:addEntityPos(mapID, postion)
					end
				end
				
				--全地图随机刷新的上限类型的初始加载到场景
				if Type == PosEnum.uperRandPos then
				    local pos = GetCollectPosition(collection.posType,nil,mapID,nil,collection )
					local amount = collection.amount --物件配置总数
					--存储该物件的的总数
                    g_CollectMgr:setReminderAmount(mapID, npcID, amount)					
					for k, postion in ipairs(pos) do
					    --检测该中类型的上限值
						if g_CollectMgr:getReminderAmount(mapID, npcID)>0 then
							local npc = g_entityFct:createGoodsNpc(collection,npcID,nil)
							npc:setRefreshData(collection)
							npc:setTotlecollectionData(mapCollections)
							npc:setMapID(mapID)
							npc:setPostion(postion)
							scene:attachEntity(npc,unpack(postion))
							g_CollectMgr:addEntityPos(mapID, postion)
							--每加载一个，上限就减少一个
							g_CollectMgr:reduceAmount(mapID, npcID)
						else
							return
						end
					end
				end
			end
		end
	end     
end

--[[
	删除一个采集物
]]
function CollectionRefresher:collect(npcID)
	local npc = npcID and g_entityMgr:getGoodsNpc(npcID)
	if not npc then
		return 
	end
	
	local mapID = npc:getMapID()
	local scene = npc:getScene()
	if scene then

		if g_sceneMgr:isInGoldHuntScene(npc) then
			local count = npc:getCollectedCount()+1
			npc:setCollectedCount(count)
			local rand = math.random(GoldHuntZone_MineCollectLimit[1],GoldHuntZone_MineCollectLimit[2])
			if count >= rand then
				scene:detachEntity(npc)
				return true
			else
				return false
			end
		end

		local Type = data.posType
	
		if Type ==PosEnum.fixedPos then
			scene:detachEntity(npc)
		end
		
		if Type ==PosEnum.fixedRandPos then
		    local id = npc:getDBID()
		    local index = npc:getPosIndex()
		    scene:detachEntity(npc)
		    g_CollectMgr:removePosState(mapID, id, index)
	    end
		
		if Type == PosEnum.randPos then
			local postion = npc:getPostion() 
		    scene:detachEntity(npc)
			g_CollectMgr:removeEntitypos(mapID, postion)
	    end
		if Type ==PosEnum.uperRandPos then
			local id = npc:getDBID()
			local postion = npc:getPostion()  
		    scene:detachEntity(npc)
			g_CollectMgr:removeEntitypos(mapID, postion)
			
		end
		
	    if not data.repeatable then
			--删除这个实体
			print(("实体%d配置为不重复刷新，将被删除"):format(id))
	    else
			self.hiddenNpcs[npcID] = npc
			npc:setLastCollect(os.time())
	    end
	    self.showingNpcs[npcID] = nil
	end
end

--[[
    刷新物件包
]]
function CollectionRefresher:refresh(npc)
	local data = npc:getRefreshData()
	local collectionData = npc:getTotlecollectionData()	
	local npcTileIndex = npc:getMapTileindex()
	local mapID = npc:getMapID()
	local scene = g_sceneMgr:getSceneByID(mapID)
	local Type =data.posType 
    
    --固定点重刷
	if Type ==PosEnum.fixedPos then
		local id = npc:getDBID()
		local pos = GetCollectPosition(data.posType,data.posData,mapID,id,nil)
		scene:attachEntity(npc,pos[npcTileIndex][1],pos[npcTileIndex][2])
	end
	
	--固定坐标集随机点重刷
	if Type ==PosEnum.fixedRandPos then
		local id = npc:getDBID()
	    local posIndexInfo = GetCollectPosition(data.posType,data.posData,mapID ,id,data)
		for _ , posIndesin in ipairs(posIndexInfo) do
			npc:setMapID(mapID)					
			npc:setPosIndex(posIndesin[2])
			scene:attachEntity(npc,unpack(posIndesin[1]))
		end
    end
	
	--全地图随机刷新
	if Type ==PosEnum.randPos then
		local posInfo = self:getSingleRandPos(mapID,collectionData)
		scene:attachEntity(npc,unpack(posInfo))
	end
	
	--全地图随机上限刷新
	if Type ==PosEnum.uperRandPos then
		local id = npc:getDBID()
		local posInfo = self:getSingleRandPos(mapID,collectionData)
		if not posInfo then
			print("CollectionRefresher:getSingleRandPos error!!!")
			return false
		end
		local amount = g_CollectMgr:getReminderAmount(mapID,id)
		if amount > 0 then
			scene:attachEntity(npc,unpack(posInfo))
			g_CollectMgr:reduceAmount(mapID, id)
	    end
	end
	npc:setLastCollect(os.time())
end

--[[ 
     刷新时刻处理
]]
function CollectionRefresher:handleHidden()
	local now = os.time()
	if table.size(self.hiddenNpcs) > 0 then
		for _,npc in pairs(self.hiddenNpcs) do
			if now - npc:getLastCollect() >= npc:getRefreshData().interval then
				self:refresh(npc)
				self.hiddenNpcs[npc:getID()] = nil
				self.showingNpcs[npc:getID()] = npc
			end
		end
	end
end

--[[
	启动刷新定时器
]]
function CollectionRefresher:start()
	if self.timerID < 0 then
		self.timerID = g_timerMgr:regTimer(
			self,2000,2000,"CollectionRefresher.update"
		)
	end
end

--[[
	停止刷新
]]
function CollectionRefresher:stop()
	if self.timerID > 0 then
		g_timerMgr:unRegTimer(self.timerID)
		self.timerID = -1
	end
end

--[[
	刷新的过程
]]
function CollectionRefresher:update(timerID) 
	self:handleHidden()
end

local instance = nil
function CollectionRefresher.getInstance()
	if not instance then
		instance = CollectionRefresher()
	end
	return instance
end
