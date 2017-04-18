--[[SkyFallBoxSystem.lua
	天降宝盒系统
--]]

require "game.ActivitySystem.Activity.SkyFallBox.SkyFallBoxUtils"

SkyFallBoxSystem = class(EventSetDoer, Singleton)

function SkyFallBoxSystem:__init()
	self._doer = 
	{
		[FightEvents_SS_FightEnd_afterClient]	= SkyFallBoxSystem.onFightEnd,
	}
end

-- 这里是战斗结束
function SkyFallBoxSystem:onFightEnd(event)
	local params			= event:getParams()
	local fightEndResults	= params[1]	--战斗结果
	local scriptID			= params[2]	--脚本ID
	local monsterDBIDs		= params[3]	--怪物信息
	local fightID			= params[4]	--战斗ID
	local fightInfo			= params[5]	--战斗信息(如瑞兽降幅的怪物死亡统计信息)
	local bWin = false
	local teamPlayerID = nil

	--如果活动结束，不会进行宝盒掉落
	local activityFlag = g_skyFallBoxMgr:getActivityFlag()
	if not activityFlag then
		return
	end

	for playerID,isWin in pairs(fightEndResults) do
		--只有赢了才有机会获得宝盒
		bWin = isWin
		if not bWin then
			return
		end

		player = g_entityMgr:getPlayerByID(playerID)
		if instanceof(player,Player) then
			local handler = player:getHandler(HandlerDef_Activity)
			if not handler then
				print("Error of getHandler in SkyFallBoxSystem.lua")
			end

			--玩家等级低于活动等级限制，则不能掉落宝盒
			if player:getLevel() < roleLevelLimit then
				return
			end

			local point = math.random(100)
			if point <= rewardProbability and handler:getSkyFallBoxNum() < rewardBoxLimit then
				--当身上宝盒未超出上限，且随机结果为可以获得宝盒时

				--给予玩家宝盒
				local packetHandler = player:getHandler(HandlerDef_Packet)
				local itemInfo = {}
				packetHandler:addItemsToPacket(1031021 ,1)
				itemInfo.itemID = 1031021
				itemInfo.itemNum = 1
				local medicamentConfig = tMedicamentDB[itemInfo.itemID]
				local itemName = medicamentConfig.Name

				local BroadCastMsgID = BroadCastMsgGroupID.Group_SkyFallBox
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, BroadCastMsgID.EventID, 3, itemName)
				g_eventMgr:broadcastEvent(event)

				--更新活动期间所获宝盒总数				
				local newBoxNum = handler:getSkyFallBoxNum() + 1
				handler:setSkyFallBoxNum(newBoxNum)

				--通知客户端
				g_skyFallBoxMgr:notifyToClient(player,newBoxNum)

			end
			

		end
	end
end


function SkyFallBoxSystem.getInstance()
	return SkyFallBoxSystem()
end

EventManager.getInstance():addEventListener(SkyFallBoxSystem.getInstance())