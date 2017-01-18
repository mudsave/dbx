--[[FightItemHandler.lua
描述：
	实体的FightItemHandler
--]]

FightItemHandler = class()

function FightItemHandler:__init(entity)
	self._entity = entity
	-- 战斗包裹
	self.battlePack = {}
end

function FightItemHandler:__release()
	self._entity = nil
	self.battlePack = nil
end

-- 设置战斗包裹
function FightItemHandler:setBattlePack(battlePack)
	self.battlePack = battlePack
end

-- 获得战斗包裹
function FightItemHandler:getBattlePack()
	return self.battlePack
end

-- 增加奖励道具
function FightItemHandler:addItemToBattlePack(itemID, itemNum)
	local tItemPrize = {}
	tItemPrize.itemID = itemID
	tItemPrize.itemNum = itemNum
	table.insert(self.battlePack, tItemPrize)
end

-- 消耗战斗道具
function FightItemHandler:removeBattleItem(itemGuid, itemNum)
	local itemInfo = self.battlePack[itemGuid]
	if not itemInfo then
		return
	end
	local medicamentConfig = tMedicamentDB[itemInfo.itemID]
	if medicamentConfig.ReactType == MedicamentReactType.UseHpPool or medicamentConfig.ReactType == MedicamentReactType.UseMpPool then
		itemInfo.effect = itemInfo.effect - itemNum
		if itemInfo.effect == 0 then
			itemInfo.itemNum = itemInfo.itemNum - 1
		end
	else
		if itemInfo.itemNum < itemNum then
			return 
		end
		itemInfo.itemNum = itemInfo.itemNum - itemNum
	end

	-- 通知客户端背包物品变化
	local changeInfo = {}
	changeInfo[itemInfo.gridIndex] = {}
	changeInfo[itemInfo.gridIndex].gridIndex = itemInfo.gridIndex
	if itemInfo.itemNum > 0 then
		changeInfo[itemInfo.gridIndex].guid = itemGuid
		-- 这里要把数目发下去，world服处理不一样，那里在发送之前直接通知客户端重新创建了
		changeInfo[itemInfo.gridIndex].num = itemInfo.itemNum
		changeInfo[itemInfo.gridIndex].effect = itemInfo.effect
	end
	local event = Event.getEvent(ItemEvents_SC_UpdateInfo, 1, itemInfo.packIndex, changeInfo)
	g_eventMgr:fireRemoteEvent(event, self._entity)
	return itemNum
end
