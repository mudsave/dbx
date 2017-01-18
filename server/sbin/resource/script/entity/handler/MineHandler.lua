--[[MineHandler.lua
描述：
	处理玩家踩雷
--]]

require "base.base"


MineHandler = class()

function MineHandler:__init(entity)
	self._entity = entity
	self._timerID = nil
	self._isMine				= true--是否开启暗雷功能
	self._isMining				= false --是否在遇雷状态
	self._mineStep				= 0--遇雷需要的步数
	self._curStep				= 0--启动雷后已经走的步数

end

function MineHandler:__release()
	self._entity = nil
end

function MineHandler:setMine(ok)
	self._isMining = ok
end

function MineHandler:getMine()
	return self._isMining
end

function MineHandler:setIsMine(ok)
	self._isMine = ok
end

function MineHandler:getIsMine()
	return self._isMine
end

function MineHandler:onMoveStart()
	
end

function MineHandler:onMove()
	if self._isMining then
		self._curStep = self._curStep + 1
		if self._curStep >= self._mineStep then
			self:startFight()
			self._isMining = false
			self._curStep = 0
		end
	end
end

function MineHandler:stop()

end

function MineHandler:setMineStep(step)
	self._mineStep = step
end

function MineHandler:onMoveStop()

	
end


--开始暗雷战斗
function MineHandler:startFight()
		local player = self._entity
		local taskMineConfig = player:getTaskMineConfig()
		local mapID = player:getScene():getMapID()
		local mapInfo = mapDB[mapID]
		local fightMapID
		local fightType 
		--无雷返回
		if (not taskMineConfig) and (not mapInfo.subMineInfo) then
			return
		end

		local scriptID
		if taskMineConfig then
			fightMapID = taskMineConfig.fightMapID
			player:setIsMustCatch(taskMineConfig.mustCatch)
			local count = #(taskMineConfig.scriptID)
			local rand = math.random(count)
			scriptID = taskMineConfig.scriptID[rand]
			fightType = FightBussinessType.Task
		else
			fightMapID = mapInfo.subMineInfo.mapID
			player:setIsMustCatch(false)
			scriptID = mapInfo.subMineInfo.scriptID
			fightType = FightBussinessType.Wild
		end

		local playerList = {}
		local teamHandler = player:getHandler(HandlerDef_Team)
		if teamHandler:isTeam() then
			if teamHandler:isLeader() then
				playerList = teamHandler:getTeamPlayerList()
			elseif teamHandler:isStepOutState() then 
				table.insert(playerList,player)
			end
		else
			table.insert(playerList,player)
		end

		  
		--加宠物
		local finalList = {}
		for k,player in ipairs(playerList) do
			table.insert(finalList,player)
			local petID = player:getFollowPetID()
			if petID then
				local pet = g_entityMgr:getPet(petID)
				table.insert(finalList,pet)
			end
		end

		local fightID = g_fightMgr:startScriptFight(finalList, scriptID, fightMapID ,fightType)
		return fightID

end

--开始明雷战斗
function MineHandler:startObviousFight(mineInfo)
		local player = self._entity
		local playerList = {}
		local teamHandler = player:getHandler(HandlerDef_Team)
		if teamHandler:isTeam() then
			if teamHandler:isLeader() then
				playerList = teamHandler:getTeamPlayerList()
			elseif teamHandler:isStepOutState() then
				table.insert(playerList,player)
			end
		else
			table.insert(playerList,player)
		end

		local scriptID = mineInfo.scriptID
		--加宠物
		local finalList = {}
		for k,player in ipairs(playerList) do
			table.insert(finalList,player)
			local petID = player:getFollowPetID()
			if petID then
				local pet = g_entityMgr:getPet(petID)
				table.insert(finalList,pet)
			end
		end
		local fightID = g_fightMgr:startScriptFight(finalList, scriptID, mineInfo.mapID ,FightBussinessType.Wild)
		return fightID
end
