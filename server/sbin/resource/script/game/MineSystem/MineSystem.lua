--[[MineSystem.lua
描述：
	踩雷系统
--]]

require "base.base"
require "misc.MeetMonsterConstant"

MineSystem = class(EventSetDoer, Singleton, Timer)
local fightIDs = {}
local timerContext = {}--[timerID] = context
function MineSystem:__init()
	self._doer = {
		[MoveEvent_SS_OnStartMove]				= MineSystem.onStartMove,
		[MoveEvent_SS_OnStopMove]				= MineSystem.onStopMove,
		[FightEvents_CS_EnterMineFight]			= MineSystem.onEnterMineFight,
		[FightEvents_CS_EnterPatrolFight]		= MineSystem.onEnterPatrolFight,
		[FightEvents_CS_SwitchMineState]		= MineSystem.onSwitchState,
		[FightEvents_SS_FightEnd_afterClient]	= MineSystem.onFightEnd,

	}
end
local function getMineStep()
	local rand = math.random(100)
	local step = 75
	for k,stepInfo in ipairs(MineProbability) do
		if rand <= stepInfo[1] then
			if k == 1 then
				return stepInfo[2]
			else
				local step = math.floor(stepInfo[2]*(rand/stepInfo[1]))
				return step
			end
		end
	end
end

function MineSystem:_checkCommonMine(player,mapID)
			local mapConfig = mapDB[mapID]
			if not mapConfig then
				print("mapConfig",mapID)
			end
			local mapType = mapConfig.mapType
			if mapType == MapType.City or mapType == MapType.Copy or mapType == MapType.Task then

				return false
			end
			local buffHandler = player:getHandler(HandlerDef_Buff)
			if buffHandler:getExorcism() and player:getLevel() > mapConfig.level then
				return false
			end

			local teamHandler = player:getHandler(HandlerDef_Team)
			if teamHandler:isTeam() then
				if not teamHandler:isLeader() and not teamHandler:isStepOutState() then
					return false
				end
			end
			return true
end

function MineSystem:onStartMove(event)
	--print("MineSystem:onStartMove(event)")
	local params = event:getParams()
	local entityID = params[1]
	local entity = g_entityMgr:getPlayerByID(entityID)
	if entity then
		
		local status = entity:getStatus()
		if status ~= ePlayerNormal then
			return
		end

		local handler = entity:getHandler(HandlerDef_Mine)
		if handler:getMine() or (not handler:getIsMine()) then
			return
		end

		local scene = entity:getScene()
		local mapID = scene:getMapID()
		--是否有任务雷
		local taskPreHandler = entity:getHandler(HandlerDef_TaskPrData)
		local mineInfos = taskPreHandler:getTaskMines()
		local mineConfig
		for taskID ,mineInfo in pairs(mineInfos) do
			if taskPreHandler:getStartMineByID(taskID) then
				for _,subMineInfo in pairs (mineInfo) do
					if subMineInfo.mapID == mapID then
						mineConfig = subMineInfo
						break
					end
				end
			end
		end

		--普通暗雷
		if not mineConfig then
			entity:setTaskMineConfig(nil)

			local bPass = self:_checkCommonMine(entity, mapID)
			--print("qqq")
			if bPass then
					entity:setTaskMineConfig(nil)
					handler:setMine(true)
					local mineStep = getMineStep()
					handler:setMineStep(mineStep)
					--print("111111111111111111111111",mineStep)

			end
		--任务雷
		else
			--local bPass = self:_checkCommonMine(entity, mapID)
			--local mineStepOfCommon = bPass and getMineStep() or 0xFFFF
			local mineStepOfTask = math.floor(getMineStep()*(mineConfig.stepFactor or 1))
			print("taskMineStep=",mineStepOfTask)
			if mineStepOfTask == 0 then
				mineStepOfTask = 1
			end
			--local mineStep = math.min(mineStepOfTask,mineStepOfCommon)
			--if mineStep == mineStepOfTask then
				entity:setTaskMineConfig(mineConfig)
			--else
			--	entity:setTaskMineConfig(nil)
			--end
			handler:setMine(true)
			handler:setMineStep(mineStepOfTask)
		end
	end
end

function MineSystem:onStopMove(event)
	
end

function MineSystem:onEnterMineFight(event)
	local params = event:getParams()
	local playerID = params[1]
	local mineNpcID = params[2]
	local player = g_entityMgr:getPlayerByID(playerID)
	local mineNpc = g_entityMgr:getMineNpc(mineNpcID)
	if (not player) or (not mineNpc) then
		return
	end

	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if not teamHandler:isLeader() then
			return
		end
	end

	local config = mineNpc:getConfig()
	mineNpc:getScene():detachEntity(mineNpc)
	local mineHandler = player:getHandler(HandlerDef_Mine)
	local fightID = mineHandler:startObviousFight(config)
	self:addFightID(fightID)
	local period = mineNpc:getUpdatePeriod()
	-- 判断是否有刷新
	if period then
		local context = {config = config,scene = player:getScene(),type = mineNpc:getNpcType()}
		local timerID = g_timerMgr:regTimer(self, period*1000, period*1000, "MineSystem.onMineUpdate")
		context.timerID = timerID
		timerContext[timerID] = context
	end
	g_entityMgr:removeMineNpc(mineNpcID)
end

-- 巡逻NPC战斗当中
function MineSystem:onEnterPatrolFight(event)
	local params = event:getParams()
	local playerID = params[1]
	local patrolNpcID = params[2]
	local player = g_entityMgr:getPlayerByID(playerID)
	local patrolNpc = g_entityMgr:getPatrolNpc(patrolNpcID)
	if (not player) or (not patrolNpc) then
		return
	end

	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if not teamHandler:isLeader() then
			return
		end
	end
	if not patrolNpc:getOwnerID() then
		patrolNpc:setOwnerID(playerID)
		local scriptID = patrolNpc:getScriptID()
		local config = {}
		config.scriptID = scriptID
		local mineHandler = player:getHandler(HandlerDef_Mine)
		local fightID = mineHandler:startObviousFight(config)
		local ectypeHandler = player:getHandler(HandlerDef_Ectype)
		local ectypeMapID = ectypeHandler:getEctypeMapID()
		local ectype = g_ectypeMgr:getEctype(ectypeMapID)
		if ectype then
			-- 在当前副本当中记录战斗ID 和 巡逻NPC运行ID
			ectype:attachPatrolNpc(fightID, patrolNpcID)
		else
			--[[
			local catchPet = patrolNpc:getCatchPet()
			if catchPet then
				catchPet:attachCatchPet(playerID, fightID, patrolNpcID)
			end
			--]]
		end
		local moveHandler = patrolNpc:getHandler(HandlerDef_Move)
		moveHandler:DoStopMove()
		print("进入战斗停止移动》》》》》》》》")
	end
end


function MineSystem:update(timerID)
	g_timerMgr:unRegTimer(timerID)
	local context = timerContext[timerID]
	timerContext[timerID] = nil
	local scene = context.scene
	local npcType = context.type
	local config = context.config
	if npcType == MineNpcType.ConfigPath then
		scene:loadSingleMine(config)
	elseif npcType == MineNpcType.RandPath then
		scene:loadSingleScopeMine(config)
	end
	print("monster revived!")
end

function MineSystem:onSceneChanged(roleID, mapID, x, y)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local mapConfig = mapDB[mapID]
	if not mapConfig then
		return
	end
	local mapType = mapConfig.mapType
	if mapType == MapType.City or mapType == MapType.Copy or mapType == MapType.Task then
		local handler = player:getHandler(HandlerDef_Mine)
		handler:setMine(false)
	else
		--player:setMine(true)
	end
	
end

function MineSystem:onSwitchState(event)
	local params = event:getParams()
	local playerID = params[1]
	local isOk = params[2]

	local player = g_entityMgr:getPlayerByID(playerID)
	if (not player) then
		return
	end

	local handler = player:getHandler(HandlerDef_Mine)
	handler:setIsMine(isOk)
	if handler:getMine() then
		if not isOk then
			handler:setMine(false)
		end
	end
end

function MineSystem:addFightID(fightID)
	if fightID then
		fightIDs[fightID] = true
	end
end

--传送到复活点
function MineSystem:onFightEnd(event)
	local params = event:getParams()
	local results = params[1]
	local fightID = params[4]
	if not fightIDs[fightID] then
		return
	end

	fightIDs[fightID] = nil

	--处理护心丹
	local bUnchanged = false
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player  and (not isWin) then
			local buffHandler = player:getHandler(HandlerDef_Buff)
			if buffHandler:getGodBless() then
				bUnchanged = true
				--g_buffMgr:onFightEndGodBless(player)
			end
		end
	end

	if bUnchanged then
		return
	end

	--处理组队情况
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player and (not isWin) then
			local teamHandler = player:getHandler(HandlerDef_Team)
			local bTeam = teamHandler:isTeam()
			local bHead = teamHandler:isLeader()
			local level = player:getLevel()
			--取决于队长
			if  bTeam and bHead and player:getHP() == 0 and (level > FullMaxHpMpLevel)then
				local scene = player:getScene()
				local mapID = scene:getMapID()
				local mapConfig = mapDB[mapID]
				local mapType = mapConfig.mapType
				if mapType == MapType.Wild then
					local revivePoint = mapConfig.revivePoint
					if  not revivePoint then
						revivePoint = WildRevivePoint
					end
					local x = revivePoint.x
					local y = revivePoint.y
					local toMapID = revivePoint.mapID
					local radius = revivePoint.r or 1
					local peer = scene:getPeer()
					local vect = peer:getRandomPos(x,y,radius,toMapID)
					x = vect.x
					y = vect.y
					local roleID = player:getID()
					local moveHandler = player:getHandler(HandlerDef_Move)
					moveHandler:doStopMove()
					g_sceneMgr:doSwitchScence(roleID, toMapID ,x ,y)
					return
				end
				
			elseif bTeam and bHead and (level <= FullMaxHpMpLevel) then
				return
			end
		end
	end

	--非组队情况
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player and (not isWin) and player:getHP() == 0 and (player:getLevel() > FullMaxHpMpLevel) then
			local scene = player:getScene()
			local mapID = scene:getMapID()
			local mapConfig = mapDB[mapID]
			local mapType = mapConfig.mapType
			if mapType == MapType.Wild then
				local revivePoint = mapConfig.revivePoint
				if  not revivePoint then
					revivePoint = WildRevivePoint
				end
				local x = revivePoint.x
				local y = revivePoint.y
				local toMapID = revivePoint.mapID
				local radius = revivePoint.r or 1

				local peer = scene:getPeer()
				local vect = peer:getRandomPos(x,y,radius,toMapID)
				x = vect.x
				y = vect.y
				g_sceneMgr:doSwitchScence(playerID, toMapID ,x ,y)
			end
		end
	end
	
end

function MineSystem.getInstance()
	return MineSystem()
end

g_eventMgr:addEventListener(MineSystem.getInstance())