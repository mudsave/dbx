--[[ExchangeItemManager.lua
描述：
	兑换物品管理
]]

local itemsInfo = 
{
	[101] = {items = {{itemID = 1051005,count = 5},{itemID = 1051006,count = 20}},rewards = {xp = 5000, subMoney = 5000,},maxCount = 10,dialogID = 50112},
	--[id1] = {items = {{itemID = 1051021,count = 5},{itemID = 1051022,count = 10}},rewards = {xp = 5000,subMoney = 5000,itemInfo = {{itemID = 1024005,count = 2}},}maxCount = 3,dialogID = 101 },},--范例
}

ExchangeItemManager = class(nil, Singleton)

function ExchangeItemManager:__init()
	self.commitTimes =				--每天兑换的次数 
	{
		[101] = 0,
	}
		
	self.commitTime =				--每次兑换的时间
	{
		[101] = 0,
	}
end

function ExchangeItemManager:__release()
	self.commitTimes = nil
	self.commitTime = nil
end


function ExchangeItemManager:doExchange(player,tempInfo,commitID)
	local bPlayerChanged = false	-- 玩家属性是否改变
	local bPetChanged = false		-- 宠物属性是否改变

	local packetHandler = player:getHandler(HandlerDef_Packet)
	--超过最大次数就不能进行兑换
	if self.commitTimes[commitID] >= itemsInfo[commitID].maxCount then 
		local errorID = 39
		local event = Event.getEvent(ExchangeItemEvent_SC_doExchangeReturn,errorID)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end

	local count = 0 
	local tempValue = {}
	for key,value in pairs(itemsInfo[commitID].items) do
		local item = g_itemMgr:getItem(tempInfo[1].guid)
		local itemID = item:getItemID()
		if itemID == value.itemID and tempInfo[1].count >= value.count then
			count = count + 1
			tempValue = value
		end
	end
	
	if count > 0 then
		packetHandler:removeItem(tempInfo[1].guid, tempValue.count)
		self.commitTimes[commitID] = self.commitTimes[commitID] + 1
		self.commitTime[commitID] = os.time()
		--保存数据到数据库
		local roleDBID = player:getDBID()
		LuaDBAccess.saveExchangeItemInfo(roleDBID,self.commitTimes[commitID],self.commitTime[commitID],commitID)
		
		local event = Event.getEvent(ExchangeItemEvent_SC_UpdateData,commitID,self.commitTimes[commitID])
		g_eventMgr:fireRemoteEvent(event, player)

		tempValue = {}
		count = 0

		--打开一个对话
		if itemsInfo[commitID].dialogID then
			g_dialogDoer:createDialogByID(player, itemsInfo[commitID].dialogID)
		end

		local msgGroupID = 30
		if table.size(itemsInfo[commitID].rewards) > 0 then
			if itemsInfo[commitID].rewards.xp then				--人物经验
				local experience = itemsInfo[commitID].rewards.xp
				player:addXp(experience)
				bPlayerChanged = true
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, msgGroupID, 1,experience)
				g_eventMgr:fireRemoteEvent(event, player)
			end
			if itemsInfo[commitID].rewards.itemInfo then		--物品奖励
				for key,value in pairs(itemsInfo[commitID].rewards.itemInfo) do
					local packetHandler = player:getHandler(HandlerDef_Packet)
					packetHandler:addItemsToPacket(value.itemID, value.count)
					local event = Event.getEvent(ExchangeItemEvent_SC_RewardItemMsg,value.itemID,value.count)
					g_eventMgr:fireRemoteEvent(event, player)
				end
			end
			if itemsInfo[commitID].rewards.petXP then			--宠物经验奖励
				--for key ,value in pairs() do
				--end
			end
			
			if itemsInfo[commitID].rewards.potPrize then		--潜能
				local pot = itemsInfo[commitID].rewards.potPrize  + player:getAttrValue(player_pot)
				player:setAttrValue(player_pot, pot)
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, msgGroupID, 3,itemsInfo[commitID].rewards.potPrize)
				g_eventMgr:fireRemoteEvent(event, player)
			end

			if itemsInfo[commitID].rewards.subMoney then		--绑银奖励
				local temSubMoney = itemsInfo[commitID].rewards.subMoney
				player:setSubMoney(player:getSubMoney() + temSubMoney)
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, msgGroupID, 4,temSubMoney)
				g_eventMgr:fireRemoteEvent(event, player)
			end
		end
	else
		local errorID = 40
		local event = Event.getEvent(ExchangeItemEvent_SC_doExchangeReturn,errorID)
		g_eventMgr:fireRemoteEvent(event, player)
	end

	if bPlayerChanged then player:flushPropBatch() end
	-- pet:flushPropBatch(player)
end

--每天转点数据重置
function ExchangeItemManager:update(period)
	if period == "day" then
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			self:resetData()
			local event = Event.getEvent(ExchangeItemEvent_SC_ResetData)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

function ExchangeItemManager:resetData()
	self.commitTimes = 
	{
		[101] = 0,
	}
	self.commitTime = 
	{
		[101] = 0,
	}
end

--玩家上线加载数据
function ExchangeItemManager:playerOnLine(player,record)
	if table.size(record) > 0 then
		for key,value in pairs(record) do
			if not time.isSameDay(value.commitTime) then							--不是同一天
				self.commitTimes[value.commitID] = 0
				self.commitTime[value.commitID] = 0
				local event = Event.getEvent(ExchangeItemEvent_SC_UpdateData,value.commitID,0)
				g_eventMgr:fireRemoteEvent(event, player)
			else																	--同一天
				self.commitTimes[value.commitID] = value.commitTimes
				self.commitTime[value.commitID] = value.commitTime
				local event = Event.getEvent(ExchangeItemEvent_SC_UpdateData,value.commitID,value.commitTimes)
				g_eventMgr:fireRemoteEvent(event, player)
			end
		end
	else																			--数据库没值的时候取默认值
		self.commitTimes = 
		{
			[101] = 0,
		}

		self.commitTime = 
		{
			[101] = 0,
		}
		local event = Event.getEvent(ExchangeItemEvent_SC_ResetData)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

function ExchangeItemManager.getInstance()
	return ExchangeItemManager()
end

g_periodChecker:addPeriodListener("day", ExchangeItemManager.getInstance())
