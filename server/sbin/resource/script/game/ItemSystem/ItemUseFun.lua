--[[ItemUseFun.lua
描述：
	物品使用调用的Lua函数定义
]]

require "data.OpenTreasureChestDB"

local function SendMessage(player, groupID, msgID, params, params1)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, groupID, msgID ,params, params1)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 打开新手礼包
function NewPlayerLoginGift(player, item)
	local itemID = item:getItemID()
	local tGiftItems = tLoginGiftItems[itemID]
	if not tGiftItems then
		return
	end
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local emptyGrids = packetHandler:getPacketEmptyGridsNum(PacketPackType.Normal)
	local itemCount = 0
	for _, itemInfo in pairs(tGiftItems) do
		local itemID = itemInfo.itemID
		local itemNum = itemInfo.itemNum
		local itemConfig = tItemDB[itemID]
		local needCreateNum = 1
		if itemNum > itemConfig.MaxPileNum then
			needCreateNum = itemNum / itemConfig.MaxPileNum
			if itemNum % itemConfig.MaxPileNum > 0 then
				needCreateNum = needCreateNum + 1
			end
		end
		itemCount = itemCount + needCreateNum
	end
	if emptyGrids < itemCount then
		SendMessage(player, eventGroup_Item, 8)
	else
		if packetHandler:removeByItemId(itemID, 1) == 1 then
			for i = 1, table.getn(tGiftItems) do
				local itemID = tGiftItems[i].itemID
				local itemNum = tGiftItems[i].itemNum
				print("--------itemID---itemID-----itemID---------",itemID)
				packetHandler:addItemsToPacket(itemID, itemNum)
			end
		end
	end
end

--打开宝箱

--宝箱物品权重处理
local function GetGainInfo(config)
	local totalWeight = 0
	for _,info in ipairs(config) do
		totalWeight = totalWeight + (info.weight or 0)
	end
	local rand = math.random(totalWeight)
	rand = rand/totalWeight
	local probList = {}
	for index = 1, #config, 1 do
		probList[index] = 1/#config * index
	end
	for idx, prob in pairs(probList) do
		if rand < prob then
			return idx 
		end
	end
end

function PlayerOpenTreasureChest(player, item)
	local itemID = item:getItemID()
	local treasureDB = tTreasureChestItems[itemID]
	if not treasureDB then print("读取配置出错") return end
	local typeNum = 0
	if "number" == type(treasureDB.typeNum) then
		typeNum = treasureDB.typeNum
	elseif "table" == type(treasureDB.typeNum) then
		typeNum = math.random(treasureDB.typeNum[1],treasureDB.typeNum[2])
	end
	--创建获得的物品列表
	local treasureList = treasureDB.treasure
	local itemList = {}
	local indexList = {}
	for index = 1, typeNum , 1 do
		local idx = GetGainInfo(treasureList)
		if idx then
			if itemList[1] then
				for _,item in pairs(itemList) do
					if item.itemID == treasureList[idx].itemID then
						index = index - 1
					else
						table.insert(itemList,treasureList[idx])
					end
				end
			else
				table.insert(itemList,treasureList[idx])
			end
		end
	end

	--背包中创建物品
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local emptyGrids = packetHandler:getPacketEmptyGridsNum(PacketPackType.Normal)
	local itemCount = 0
	local itemNum = 0
	for _, itemInfo in pairs(itemList) do
		local itemID = itemInfo.itemID

		local numType = type(itemInfo.number)
		if numType == "number" then
		 	itemNum = itemInfo.number
		elseif numType == "table" then
			itemNum = math.random(itemInfo.number[1],itemInfo.number[2])
		end
		local itemConfig = tItemDB[itemID]
		local needCreateNum = 1
		if itemNum > itemConfig.MaxPileNum then
			needCreateNum = itemNum / itemConfig.MaxPileNum
			if itemNum % itemConfig.MaxPileNum > 0 then
				needCreateNum = needCreateNum + 1
			end
		end
		itemCount = itemCount + needCreateNum
	end
	if emptyGrids < itemCount then
		SendMessage(player, eventGroup_Item, 8)
	else
		if packetHandler:removeByItemId(itemID, 1) == 1 then
			for i = 1, table.getn(itemList) do
				local itemID = itemList[i].itemID
				packetHandler:addItemsToPacket(itemID, itemNum)
				params = string.format("%s", itemNum)
				params1 = string.format("%s", tItemDB[itemID].Name)
				SendMessage(player,eventGroup_Goods, 1, params, params1) 
			end
		end
	end
end
