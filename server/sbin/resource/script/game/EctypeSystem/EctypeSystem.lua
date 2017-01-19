--[[EctypeSystem.lua
描述:
	副本系统，处理客户端副本相关的消息
]]

require "game.EctypeSystem.Ectype"
require "game.EctypeSystem.FactionEctype"
require "game.EctypeSystem.EctypeManager"

EctypeSystem = class(EventSetDoer, Singleton)

function EctypeSystem:__init()
	self._doer =
	{
		-- 进入副本
		[EctypeEvents_CS_EnterEctype]                    = EctypeSystem.onEnterEctype,
		-- 退出副本
		[EctypeEvents_CS_ExitEctype]                     = EctypeSystem.onExitEctype,
		-- 热区回调
		[EctypeEvents_CS_HotAreaCallback]                = EctypeSystem.onHotAreaCB,
		-- 战斗结束后
		[FightEvents_SS_FightEnd_afterClient]            = EctypeSystem.onFightEndAfter,
		-- 连环副本传送门
		[EctypeEvents_CS_TransferDoor]                   = EctypeSystem.onTransferDoor,
		-- 解散队伍和退出队伍
		[TeamEvents_SS_DissolveEctypeTeam]               = EctypeSystem.onDissolveEctypeTeam,
		-- 暂离队伍
		[TeamEvents_SS_StepOutTeam]                      = EctypeSystem.onTeamMemberStepOut,
		-- 移除队员
		[TeamEvents_SS_MoveOutMember]                    = EctypeSystem.onMoveOutMember,
		-- 战斗结束前
		[FightEvents_SS_FightEnd_beforeClient]           = EctypeSystem.onFightEndBefor,
		-- 采集物件
		[EctypeEvents_CS_RemoveObject]                   = EctypeSystem.onRemoveObject,
		-- 受到机关撞击效果
		[SceneEvent_SS_AttackEffect]                     = EctypeSystem.onAttackEffect,
	}
end

-- 进入副本
function EctypeSystem:onEnterEctype(event)
	local params = event:getParams()
	local roleID = event.playerID
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local ectypeID = params[1]
	g_ectypeMgr:enterEctype(player, ectypeID)
end

-- 退出副本
function EctypeSystem:onExitEctype(event)
	local params = event:getParams()
	local roleID = event.playerID
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end
	g_ectypeMgr:exitEctype(player)
end

-- 热区回调
function EctypeSystem:onHotAreaCB(event)
	local params = event:getParams()
	local roleID = event.playerID
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local ectypeID = params[1]
	local hotAreaID = params[2]
	-- 找到玩家所在副本
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	if ectype:getEctypeID() ~= ectypeID then
		return
	end
	-- 热区触发，驱动副本进度
	ectype:hotAreaCB(player, hotAreaID)
end

-- 对话结束
function EctypeSystem:onDialogueEnd(event)
	local params = event:getParams()
	local dialogueID = params[1]

	-- 找到玩家所在副本
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end

	-- 对话结束，驱动副本进度
	ectype:onDialogueEnd(player, dialogueID)
end


-- 战斗结束后
function EctypeSystem:onFightEndBefor(event)
	local params = event:getParams()
	local fightEndResults = params[1]
	local scriptID = params[2]
	local fightID = params[4]
	local result = false
	local ectype = nil
	for playerID, fightResult in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			if not ectype then
				-- 找到玩家所在副本
				local ectypeHandler = player:getHandler(HandlerDef_Ectype)
				local ectypeMapID = ectypeHandler:getEctypeMapID()
				ectype = g_ectypeMgr:getEctype(ectypeMapID)
				if not ectype then
					return
				end
			end
			-- 战斗结束，驱动副本进度
			if fightResult then 
				result = true
				break
			end
		end
	end
	if not ectype then
		return
	end
	-- 根据
	local ectypeID = ectype:getEctypeID()
	local ectypeType = tEctypeDB[ectypeID].EctypeType
	if ectypeType == EctypeType.Faction then
		-- 帮会副本的一些处理
		ectype:onFightEndBefor(fightID, result)
	else
		-- 战斗结束，驱动副本进度
		ectype:onFightEndBefor(nil, scriptID, result)
	end
end

-- 战斗结束后
function EctypeSystem:onFightEndAfter(event)
	local params = event:getParams()
	local fightEndResults = params[1]
	local scriptID = params[2]

	local result = false
	local ectype = nil
	for playerID, fightResult in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			if not ectype then
				-- 找到玩家所在副本
				local ectypeHandler = player:getHandler(HandlerDef_Ectype)
				local ectypeMapID = ectypeHandler:getEctypeMapID()
				ectype = g_ectypeMgr:getEctype(ectypeMapID)
				if not ectype then
					return
				end
			end
			-- 战斗结束，驱动副本进度
			if fightResult then 
				result = true
				break
			end
		end
	end
	if not ectype then
		return
	end
	-- 根据
	local ectypeID = ectype:getEctypeID()
	local ectypeType = tEctypeDB[ectypeID].EctypeType
	if ectypeType == EctypeType.Faction then
		-- 帮会副本的一些处理
		ectype:onFightEnd(fightID, result)
	else
		-- 战斗结束，驱动副本进度
		ectype:onFightEnd(nil, scriptID, result)
	end
end

-- 连环副本传送门
function EctypeSystem:onTransferDoor(event)
	local params = event:getParams()
	local roleID = event.playerID
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end
	-- 找到玩家所在副本
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	-- 点击传送门
	ectype:onTransferDoor(player)
end

-- 解散副本队伍和退出队伍
function EctypeSystem:onDissolveEctypeTeam(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	if player then
		g_ectypeMgr:exitEctype(player)
	end
end

-- 副本中队员暂离
function EctypeSystem:onTeamMemberStepOut(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	ectype:returnPublicScene(player)
end

-- 副本中移除队员
function EctypeSystem:onMoveOutMember(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	ectype:returnPublicScene(player)
end

-- 采集副本物件
function EctypeSystem:onRemoveObject(event)
	local params = event:getParams()
	local roleID = event.playerID
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end
	-- 找到玩家所在副本
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	local objectID = params[1]
	local object = g_entityMgr:getGoodsNpc(objectID)
	if not object then
		return
	end
	-- 移除物品
	ectype:removeObject(objectID)
	-- 增加积分分离开来
	ectype:incIntegral()
	--  物品采集个数到达，完成副本，获取奖励
	ectype:dealObjectNum()
end

-- 机关撞击效果
function EctypeSystem:onAttackEffect(event)
	local params = event:getParams()
	local roleID = params[1]
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end
	-- 找到玩家所在副本
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	local msgID = 17
	-- 记录撞击次数
	ectype:onAttackEffect()
	--ectype:redIntegral(msgID, EctypeIntegral.Effect)
end

function EctypeSystem.getInstance()
	return EctypeSystem()
end

EventManager.getInstance():addEventListener(EctypeSystem.getInstance())
