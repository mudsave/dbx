--[[Beast.lua 瑞兽降临活动NPC

]]

local updateBeastTime = 20

Beast = class()

function Beast:__init(DBID,mapID)
	self.canUseTime		= 0					-- 更新时间
	self.DBID			= DBID				-- 配置ID
	self.npc			= nil				-- 动态ID
	self.mapID			= mapID
	self.posX			= 0
	self.posY			= 0
	self:initNpc()
end

-- 初始化瑞兽的NPC
function Beast:initNpc()
	self.npc = g_entityFct:createDynamicNpc(self.DBID)
end

function Beast:getPos()
	return self.posX,self.posY
end

-- 把beast随机加入到地图
function Beast:addBeastToMap(curMapBeastList)
	-- 随机地图坐标
	local mapID = self.mapID
	local npc = self.npc
	local curPosX = 0
	local curPosY = 0
	local reSetTime = 0
	-- 重新设置可用时间
	self:reSetCanUseTime()
	repeat
		curPosX,curPosY	= g_sceneMgr:getRandomPosition(mapID)
		local isReset = true
		reSetTime = reSetTime + 1
		if reSetTime > 50 then
			break
		end
		if curMapBeastList then
			for npcID,beast in pairs(curMapBeastList) do
				-- 其他的坐标
				local otherX,otherY = beast:getPos()
				if curPosX == otherX and curPosY == otherY then
					isReset = false
				end
			end
		end
	until isReset
	self.posX = curPosX
	self.posY = curPosY
	local scence = g_sceneMgr:getSceneByID(mapID)
	if npc then
		npcID = npc:getID()
		-- print("________>npc:isFighting()",npc:isFighting())
		-- print("npcID",npcID,self.posX,self.posY)
		scence:attachEntity(npc,self.posX,self.posY)
		-- 加到beastmanager中
		return npcID
	else
		print("error -> addBeastToMap")
	end
end

function Beast:removeFromMap()
	local scence = g_sceneMgr:getSceneByID(self.mapID)
	if scence then
		self.npc:setFighting(false)
		scence:detachEntity(self.npc)
	end
end

function Beast:getMapID()
	return self.mapID
end

function Beast:getNpcID()
	return self.npc:getID()
end

function Beast:getDBID()
	return self.DBID
end

function Beast:updateTime()
	local times = self.canUseTime
	if not self.npc:isFighting() then
		if times < 0 then
			return false
		end
		self.canUseTime = times - 1
	end	
	return true
end

function Beast:setFighting(flag)
	self.npc:setFighting(flag)
end

function Beast:reSetCanUseTime()
	self.npc:setFighting(false)
	self.canUseTime		= updateBeastTime		
end

