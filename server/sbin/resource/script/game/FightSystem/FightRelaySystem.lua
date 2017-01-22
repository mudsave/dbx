--[[FightRelaySystem.lua
描述：
	战斗服务器消息的接受
--]]

require "base.base"
require "game.FightSystem.FightManager"
require "game.FightSystem.DropManager"

local function notice(format,... )
	print( ("FightRelaySystem:%s"):format((format or ""):format(...)) )
end

FightRelaySystem = class(EventSetDoer, Singleton, Timer)
--local delayedEvent = {}--任务系统会用到，再通知一次结果

function FightRelaySystem:__init()
	self._doer = {
		[FightEvents_FS_StartFight]    = FightRelaySystem.Route,
		[FightEvents_FS_FightEnd]      = FightRelaySystem.FightEnd,
		[FightEvents_FS_QuitFight]     = FightRelaySystem.QuitFight,
		[FightEvents_FS_CreatePet]	   = FightRelaySystem.onCreatePet,
		
	}
end

function FightRelaySystem.onCollectGarbage()
	--notice("onCollectGarbage():%s %s %s",collectgarbage("count"),collectgarbage("collect"),collectgarbage("count"))
end

-- 战斗服通知世界服 战斗开始
function FightRelaySystem:Route( event )
	local params 		= event:getParams()
	local players		= params[2]
	local pets			= params[3]
	local fightServerID = params[4]

	-- 设置每一个战斗的角色的状态为 战斗，并且设定战斗信息(战斗中 和 战斗服ID)
	for _, v in pairs(players) do
		local player = g_entityMgr:getPlayerByDBID(v.playerID)
		if player then
			g_world:send_MsgWS_StartFight(player:getAccountID(), player:getVersion())
			player:setStatus(ePlayerFight)
			player:setFighting(true)
		end
	end

	-- 设置每一个宠物的状态为 战斗
	for _, v in pairs(pets) do
		local petID = v.worldPetID
		local pet 	= g_entityMgr:getPet(petID)
		if pet then
			pet:setStatus(ePlayerFight)
		end
	end
end

-- 结算战斗结果
local function SettleWarResults()
end

local FightEndResults = {}

function FightRelaySystem:FightEnd(event)
	notice("FightEnd(event)")
	table.clear(FightEndResults)
	local newAddedPets= {}--[playerID]={}
	local params			= event:getParams()
	local rolesInfo			= params[1]	--{{dbID=1,isPlayer=1,[102]=2,},{},{}}
	local scriptID			= params[2]	--脚本ID
	local monsterDBIDs		= params[3]	--怪物信息
	local storedPetsInfo	= params[4]	--宠物信息
	local fightID			= params[5]	--战斗ID
	local fightInfo			= params[6]	--战斗信息(如瑞兽降幅的怪物死亡统计信息)

	local resultMap = {} --结果表
	local petlist 	= {} --宠物列表
	local rolelist	= {} --玩家列表

	for _,attrs in ipairs(rolesInfo) do
		local entityType = attrs.isPlayer
		local eid = nil	--实体ID
		if entityType == 1 then	--玩家
			local player = g_entityMgr:getPlayerByDBID(attrs.dbID)
			if player then
				eid = player:getID() --获得实体ID
				rolelist[eid] = player
				local teamHandler = player:getHandler(HandlerDef_Team)
				if teamHandler:isTeam() then
					if teamHandler:isLeader() then
						player:setActionState(PlayerStates.Team)
					else
						player:setActionState(PlayerStates.Follow)
					end
				else
					player:setActionState(player:getOldActionState())
				end
			end
		elseif entityType == 0 then	--宠物
			local pet = g_entityMgr:getPet(attrs.worldPetID)
			if pet then
				eid = pet:getID()
				petlist[eid] = pet
				if attrs.isNew then
					local ownerID = pet:getOwnerID()
					local list = newAddedPets[ownerID]
					local configID = pet:getConfigID()
					if list then
						table.insert(list,configID)
					else
						newAddedPets[ownerID]={configID}
					end
				end
			end
		end
		if eid then
			resultMap[eid] = attrs
			FightEndResults[eid] = not not attrs.isWin
		end
	end

	for _, attrs in ipairs (storedPetsInfo) do
		local eid = nil
		local pet = g_entityMgr:getPet(attrs.worldPetID)
		if pet then
			eid = pet:getID()
			petlist[eid] = pet
			resultMap[eid] = attrs
			FightEndResults[eid] = not not attrs.isWin

			if attrs.isNew then
				local ownerID = pet:getOwnerID()
				local list = newAddedPets[ownerID]
				local configID = pet:getConfigID()
				if list then
					table.insert(list,configID)
				else
					newAddedPets[ownerID]={configID}
				end
			end
		end
	end

	for playerID,player in pairs(rolelist) do
		player:onWarEnded(resultMap[playerID])
		g_world:send_MsgWS_StopFight(player:getAccountID(), player:getVersion())
	end

	for petID,pet in pairs(petlist) do
		pet:onWarEnded(resultMap[petID])
	end
	
	--先通知各系统做各自的善后
	g_eventMgr:fireEvent(
		Event.getEvent(
			FightEvents_SS_FightEnd_beforeClient,FightEndResults,scriptID,monsterDBIDs,fightID,fightInfo
		)
	)

	for playerID,player in pairs(rolelist) do
		--local result = FightEndResults[playerID]
		--delayedEvent[player:getDBID()] = {scriptID,result}
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(FightEvents_FC_QuitFight),player
		)
		--TaskCallBack.script(player, scriptID, result, false)--false表示此时客户端还在战斗中
	end

	--统一奖励和惩罚
	g_dropMgr:dealWithPunish(FightEndResults, scriptID, fightID)
	g_dropMgr:dealWithRewards(FightEndResults, scriptID, monsterDBIDs, fightID)

	for playerID, info in pairs(newAddedPets) do
		TaskCallBack.onObtainPet(playerID,info)
	end
	
	g_eventMgr:fireEvent(
		Event.getEvent(
			FightEvents_SS_FightEnd_afterClient,FightEndResults,scriptID,monsterDBIDs,fightID,fightInfo
		)
	)

	for _,pet in pairs(petlist) do
		pet:flushPropBatch()
	end

	for playerID,player in pairs(rolelist) do
		player:flushPropBatch()
	end
	
	g_eventMgr:fireEvent(
		Event.getEvent(
			FightEvents_SS_FightEnd_ResetState,FightEndResults,scriptID,monsterDBIDs,fightID
		)
	)
	self:_sendAndResetAutoStatus(FightEndResults)
	g_fightMgr:clearFightType(fightID)
	self:_judgeAndDoOffline(FightEndResults)

end

-- 单个玩家退出战斗
function FightRelaySystem:QuitFight(event)
print("FightRelaySystem:QuitFight")
	table.clear(FightEndResults)
	local newAddedPets = {}--[playerID]={}
	local params			= event:getParams()
	local attrs				= params[1]
	local scriptID			= params[2]
	local storedPetsInfo	= params[3]
	local fightID			= params[4]
	
	local resultMap		= {}
	local petlist		= {}
	local player		= nil
	local entityType	= attrs.isPlayer

	if entityType == 1 then	--玩家
		player = g_entityMgr:getPlayerByDBID(attrs.dbID)
		if player then
			local eid = player:getID()
			resultMap[eid] = attrs
			FightEndResults[eid] = not not attrs.isWin
			
		end
	elseif entityType == 0 then	--宠物
		local pet = g_entityMgr:getPet(attrs.worldPetID)
		if pet then
			local eid = pet:getID()
			petlist[eid] = pet
			resultMap[eid] = attrs
			FightEndResults[eid] = not not attrs.isWin

			if attrs.isNew then
				local ownerID = pet:getOwnerID()
				local list = newAddedPets[ownerID]
				local configID = pet:getConfigID()
				if list then
					table.insert(list,configID)
				else
					newAddedPets[ownerID]={configID}
				end
			end
		end
	end

	--备用的宠物信息
	for _, attrs in ipairs (storedPetsInfo) do
		if attrs.isPlayer == 0 then
			local pet = g_entityMgr:getPet(attrs.worldPetID)
			if pet then
				local eid = pet:getID()
				petlist[eid] = pet
				resultMap[eid] = attrs

				FightEndResults[eid] = not not attrs.isWin

				if attrs.isNew then
					local ownerID = pet:getOwnerID()
					local list = newAddedPets[ownerID]
					local configID = pet:getConfigID()
					if list then
						table.insert(list,configID)
					else
						newAddedPets[ownerID]={configID}
					end
				end
			end
		end
	end

	if player then
		local eid = player:getID()
		local teamHandler = player:getHandler(HandlerDef_Team)
		if teamHandler:isTeam() then
		
			local playerList = teamHandler:getTeamAllPlayerList()
			local memberCount = #playerList
			if memberCount > 1 then

				if teamHandler:isLeader() then
					local validCount = teamHandler:getCurMemberNum()
					if validCount > 1 then
						g_teamMgr:changeLeader(eid)
						g_teamMgr:stepOutTeam(eid)
					else
						player:setActionState(PlayerStates.Team)
					end
				else
					g_teamMgr:stepOutTeam(eid)
					player:setActionState(PlayerStates.Normal)
				end

			else

				player:setActionState(PlayerStates.Team)
			end
		else
			player:setActionState(player:getOldActionState())
		end
		player:onWarEnded(resultMap[eid])
		g_world:send_MsgWS_StopFight(player:getAccountID(), player:getVersion())
		notice("$$$$$ %s",eid)
	end

	for petID,pet in pairs(petlist) do
		pet:onWarEnded(resultMap[petID])
	end
			
	--先通知各系统做各自的善后
	g_eventMgr:fireEvent(
		Event.getEvent(
			FightEvents_SS_FightEnd_beforeClient,FightEndResults,scriptID,nil,fightID
		)
	)
	
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(FightEvents_FC_QuitFight),player
	)
	
	for playerID, info in pairs(newAddedPets) do
		TaskCallBack.onObtainPet(playerID,info)
	end

	g_eventMgr:fireEvent(
		Event.getEvent(
			FightEvents_SS_FightEnd_afterClient,FightEndResults,scriptID,nil,fightID
		)
	)
	--delayedEvent[player:getDBID()] = {scriptID,false}
	--TaskCallBack.script(player, scriptID, false, false)--false表示此时客户端还在战斗中

	--统一奖励和惩罚
	g_dropMgr:dealWithPunish(FightEndResults, scriptID, fightID)

	for _,pet in pairs(petlist) do
		pet:flushPropBatch()
	end

	
	player:flushPropBatch()
	

	g_eventMgr:fireEvent(
		Event.getEvent(
			FightEvents_SS_FightEnd_ResetState,FightEndResults,scriptID,nil,fightID
		)
	)
	self:_sendAndResetAutoStatus(FightEndResults)
	g_fightMgr:clearFightType(fightID)
	self:_judgeAndDoOffline(FightEndResults)
end

function FightRelaySystem:onCreatePet(event)
	local params = event:getParams()
	local sourceServerID = params[1]
	local playerDBID = params[2]
	local petConfigID = params[3]

	local player = g_entityMgr:getPlayerByDBID(playerDBID)
	if player then
		local pet = g_entityFct:createPet(petConfigID)
		pet:setOwner(player)
		
		player:addPet(pet)
		local info = {}
		g_fightMgr.setPetAttrInfo(pet,info)
		
		g_eventMgr:fireWorldsEvent(
			Event(
				FightEvents_SF_CreatePet, playerDBID, info, g_serverId
			),sourceServerID
		)
		
	end
end



function FightRelaySystem:_sendAndResetAutoStatus(results)
	
	for playerID, result in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player  then
			--local autoStatus = player:getAutoMeetOrWay()
			--if autoStatus then
				local event = Event.getEvent(FightEvents_SC_StartAutoMeet,result)
				g_eventMgr:fireRemoteEvent(event,player)
				--player:setAutoMeetOrWay(nil)
			--end

		end
	end
end

function FightRelaySystem:_judgeAndDoOffline(results)
	for roleID, result in pairs(results) do
		local player = g_entityMgr:getPlayerByID(roleID)
		if player  then
			local status = player:getStatus()
			if status == ePlayerInactiveFight then
				local accountID = player:getAccountID()
				g_world:send_MsgWS_ClearOffFightInfo(accountID, player:getVersion())

			end
			if (status == ePlayerInactiveFight) and player:getIsFightClose() then
				g_playerMgr:doPlayerLogout(player:getDBID(),LOGOUT_REASON_WORLD_KICK,nil)
				return
			
			end
			if status == ePlayerInactiveFight then
				player:setStatus(ePlayerInactive)
			else
				player:setStatus(ePlayerNormal)
			end
			
		else
			local pet = g_entityMgr:getPet(roleID)
			if pet  then
				pet:setStatus(ePlayerNormal)
			end
		end
	end
end

function FightRelaySystem:update(timerID)
		FightRelaySystem.onCollectGarbage()
end

function FightRelaySystem.getInstance()
	return FightRelaySystem()
end

g_eventMgr:addEventListener(FightRelaySystem.getInstance())
g_timerMgr:regTimer(FightRelaySystem.getInstance(),0,MemCollectPeriod*1000,"FightRelaySystem.onCollectGarbage")
