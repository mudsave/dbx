--[[EctypeHandler.lua
描述：
	实体的副本handler
--]]

EctypeHandler = class()

function EctypeHandler:__init(entity)
	self._entity = entity
	-- 当前副本地图ID
	self.curEctypeMapID = -1
	-- 记录进入副本前的位置信息
	self.enterPos = {}
	-- 普通副本数据
	self.ectypeInfo = {}
	-- 连环副本数据
	self.ringEctypeInfo = {}
	-- 副本积分
	self.integral = 0
end

function EctypeHandler:__release()
	self._entity = nil
	self.curEctypeMapID = nil
	self.enterPos = nil
	self.ectypeInfo = nil
	self.ringEctypeInfo = nil
	self.integral = nil
end

-- 设置当前所在的副本地图ID
function EctypeHandler:setEctypeMapID(curEctypeMapID)
	self.curEctypeMapID = curEctypeMapID
end

-- 获得当前所在的副本地图ID
function EctypeHandler:getEctypeMapID()
	return self.curEctypeMapID
end

-- 设置进入副本前的位置信息
function EctypeHandler:setEnterPos(mapID, xPos, yPos)
	self.enterPos = {}
	self.enterPos.mapID = mapID
	self.enterPos.xPos = xPos
	self.enterPos.yPos = yPos
end

-- 获得进入副本前的位置信息
function EctypeHandler:getEnterPos()
	return self.enterPos
end

-- 检测指定普通副本数据，不存在的话就默认初始化下
function EctypeHandler:checkEctypeData(ectypeID)
	if not self.ectypeInfo[ectypeID] then
		self.ectypeInfo[ectypeID] = {}
		self.ectypeInfo[ectypeID].finishTimes = 0
		self.ectypeInfo[ectypeID].curProcess = 0
		self.ectypeInfo[ectypeID].leftMin = 0
		self.ectypeInfo[ectypeID].recordTime = os.time()
		self.ectypeInfo[ectypeID].attackTime = 0
		self.ectypeInfo[ectypeID].isSaveDB = false
	end
end

-- 检测指定连环副本数据，不存在的话就默认初始化下
function EctypeHandler:checkRingEctypeData(ringEctypeID)
	if not self.ringEctypeInfo[ringEctypeID] then
		self.ringEctypeInfo[ringEctypeID] = {}
		self.ringEctypeInfo[ringEctypeID].curRing = 0
		self.ringEctypeInfo[ringEctypeID].curGroupID = 0
		self.ringEctypeInfo[ringEctypeID].curChildEctypeID = 0
		self.ringEctypeInfo[ringEctypeID].curProcess = 0
		self.ringEctypeInfo[ringEctypeID].leftMin = 0
		self.ringEctypeInfo[ringEctypeID].childEctypeFlag = {0, 0, 0, 0}
		self.ringEctypeInfo[ringEctypeID].finishFlag = 0
		self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
		self.ringEctypeInfo[ringEctypeID].attackTime = 0
	end
end

-- 设置指定连环副本随机出的群组ID
function EctypeHandler:setRingEctypeGroupID(ringEctypeID, ringEctypeGroupID)
	self:checkRingEctypeData(ringEctypeID)
	self.ringEctypeInfo[ringEctypeID].curGroupID = ringEctypeGroupID
end

-- 获得指定连环副本随机出的群组ID
function EctypeHandler:getRingEctypeGroupID(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].curGroupID
end

-- 设置指定连环副本当前子副本ID
function EctypeHandler:setCurChildEctypeID(ringEctypeID, curChildEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	self.ringEctypeInfo[ringEctypeID].curChildEctypeID = curChildEctypeID
	self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
	self.ringEctypeInfo[ringEctypeID].isSaveDB = true
end

-- 获得指定连环副本当前子副本ID
function EctypeHandler:getCurChildEctypeID(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].curChildEctypeID
end

-- 完成指定连环副本的子副本
function EctypeHandler:setRingEctypeChildEctypeFinish(ringEctypeID, childEctypeID)
	self:checkRingEctypeData(ringEctypeID)	
	local ringEctypeInfo = tRingEctypeDB[ringEctypeID]
	if ringEctypeInfo then
		for i = 1, table.getn(ringEctypeInfo.tAllEctypes) do
			if ringEctypeInfo.tAllEctypes[i].EctypeID == childEctypeID then
				self.ringEctypeInfo[ringEctypeID].childEctypeFlag[i] = 1
				self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
				self.ringEctypeInfo[ringEctypeID].isSaveDB = true 
				break
			end
		end
	end
end

-- 获得指定连环副本子副本信息
function EctypeHandler:getRingEctypeChildEctypeInfo(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].childEctypeFlag
end

-- 增加指定连环副本当前环数
function EctypeHandler:addRingEctypeCurRing(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)	
	self.ringEctypeInfo[ringEctypeID].curRing = self.ringEctypeInfo[ringEctypeID].curRing + 1
	self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
end

-- 设置指定连环副本当前环数，这个在队员副本信息同步的时候用
function EctypeHandler:setRingEctypeCurRing(ringEctypeID, curRing)
	self:checkRingEctypeData(ringEctypeID)	
	self.ringEctypeInfo[ringEctypeID].curRing = curRing
	self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
	-- 通知客户端，注意客户端的环数显示从1开始
	local event = Event.getEvent(EctypeEvents_SC_CurRing, curRing+1)
	g_eventMgr:fireRemoteEvent(event, self._entity)
end

-- 获得指定连环副本当前环数
function EctypeHandler:getRingEctypeCurRing(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].curRing
end

-- 设置连环副本进度
function EctypeHandler:setRingEctypeProcess(ringEctypeID, curProcess)
	self:checkRingEctypeData(ringEctypeID)
	if self.ringEctypeInfo[ringEctypeID].finishFlag == 0 then
		if curProcess > self.ringEctypeInfo[ringEctypeID].curProcess then
			local curRing = self.ringEctypeInfo[ringEctypeID].curRing
			local ringEctypeConfig = tRingEctypeDB[ringEctypeID]
			if ringEctypeConfig and ringEctypeConfig.tPrizes then
				local ectypePrizes = ringEctypeConfig.tPrizes[curRing+1][curProcess]
				if ectypePrizes then
					-- 经验奖励
					if ectypePrizes.ExpPrize then
						local msgID = 11
						local tem_xp_ratio = self._entity:getAttrValue(player_xp_ratio)
						local addXp = math.floor(ectypePrizes.ExpPrize * tem_xp_ratio / 100)
						self._entity:addXp(player_xp, addXp)
						self:sendEctypePrize(msgID, addXp)
					end
					-- 金钱奖励
					if ectypePrizes.MoneyPrize then
						local msgID = 12
						local money = ectypePrizes.MoneyPrize + self._entity:getMoney()
						self._entity:setMoney(money)
						self:sendEctypePrize(msgID, ectypePrizes.MoneyPrize)
					end
					-- 道行
					if ectypePrizes.TaoPrize then
						local msgID = 13
						-- 衰减等级
						--local decayLev = self._entity:getTaoDecayLev()
						-- 衰减强度
						--decayPower = math.pow(1/1.1, decayLev)
						--local curTaoPrize = math.floor(ectypePrizes.TaoPrize * decayPower)
						local tao = ectypePrizes.TaoPrize + self._entity:getAttrValue(player_tao)
						self._entity:setAttrValue(player_tao, tao)
						self:sendEctypePrize(msgID, ectypePrizes.TaoPrize)
					end
					-- 潜能
					if ectypePrizes.PotPrize then
						local msgID = 14
						local pot = ectypePrizes.PotPrize + self._entity:getAttrValue(player_pot)
						self._entity:setAttrValue(player_pot, pot)
						self:sendEctypePrize(msgID, ectypePrizes.PotPrize)
					end

					-- 道具奖励
					if ectypePrizes.ItemPrize then
						local msgID = 15
						local packetHandler = self._entity:getHandler(HandlerDef_Packet)
						local itemInfo = {}
						for i = 1, table.getn(ectypePrizes.ItemPrize) do
							local itemID = ectypePrizes.ItemPrize[i].itemID
							local itemNum = ectypePrizes.ItemPrize[i].itemNum
							if packetHandler:addItemsToPacket(itemID, itemNum) then
								if not itemInfo[i] then
									itemInfo[i] = {}
									itemInfo[i].itemID = itemID
									itemInfo[i].itemNum = itemNum
								end
							end
						end

						if table.size(itemInfo) > 0 then
							self:sendEctypePrize(msgID, itemInfo)
						end
						-- 机关撞击额外奖励
						local attackTime = self.ringEctypeInfo[ringEctypeID].attackTime
						local ringEctypeExtraPrizes = ringEctypeConfig.tPrizes[curRing+1][curProcess].ExtraPrizes
						local percent = 100 - (attackTime * 5)					
						if percent > 0 and ringEctypeExtraPrizes then
							-- 经验奖励
							self:sendEctypePrize(25, attackTime)
							if ringEctypeExtraPrizes.ExpPrize then
								local msgID = 26
								local expPrize = math.floor(ringEctypeExtraPrizes.ExpPrize * percent / 100)
								local tem_xp_ratio = self._entity:getAttrValue(player_xp_ratio)
								local addXp = math.floor(expPrize * tem_xp_ratio / 100)
								self._entity:addXp(player_xp, addXp)
								self:sendEctypePrize(msgID, addXp)
							end
							-- 金钱奖励
							if ringEctypeExtraPrizes.MoneyPrize then
								local msgID = 27
								local moneyPrize = math.floor(ringEctypeExtraPrizes.ExpPrize * percent / 100)
								local money = moneyPrize + self._entity:getMoney()
								self._entity:setMoney(money)
								self:sendEctypePrize(msgID, moneyPrize)
							end
							-- 道行
							if ringEctypeExtraPrizes.TaoPrize then
								local msgID = 28
								-- 衰减等级
								--local decayLev = self._entity:getTaoDecayLev()
								-- 衰减强度
								--decayPower = math.pow(1/1.1, decayLev)
								local taoPrize = math.floor(ringEctypeExtraPrizes.ExpPrize * percent / 100)
								local tao = taoPrize + self._entity:getAttrValue(player_tao)
								self._entity:setAttrValue(player_tao, tao)
								self:sendEctypePrize(msgID, taoPrize)
							end
							-- 潜能
							if ringEctypeExtraPrizes.PotPrize then
								local msgID = 29
								local potPrize = math.floor(ringEctypeExtraPrizes.ExpPrize * percent / 100)
								local pot = potPrize + self._entity:getAttrValue(player_pot)
								self._entity:setAttrValue(player_pot, pot)
								self:sendEctypePrize(msgID, potPrize)
							end
						end
					end
					print("获得连环副本进度奖励")
				end
			end
		end
	end
	self.ringEctypeInfo[ringEctypeID].curProcess = curProcess
	self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
	self.ringEctypeInfo[ringEctypeID].isSaveDB = true
end

-- 获得连环副本进度
function EctypeHandler:getRingEctypeProcess(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].curProcess
end

-- 设置连环副本剩余分钟数
function EctypeHandler:setRingEctypeLeftMin(ringEctypeID, leftMin)
	self:checkRingEctypeData(ringEctypeID)
	self.ringEctypeInfo[ringEctypeID].leftMin = leftMin
	if leftMin > 0 then
		self.ringEctypeInfo[ringEctypeID].isSaveDB = true
	end
end

-- 获得连环副本剩余分钟数
function EctypeHandler:getRingEctypeLeftMin(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].leftMin
end

-- 设置连环副本完成标志
function EctypeHandler:setRingEctypeFinishFlag(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	self.ringEctypeInfo[ringEctypeID].finishFlag = 1
	self.ringEctypeInfo[ringEctypeID].recordTime = os.time()
	self.ringEctypeInfo[ringEctypeID].attackTime = 0
	self.ringEctypeInfo[ringEctypeID].isSaveDB = true
end

-- 获得连环副本完成标志
function EctypeHandler:getRingEctypeFinishFlag(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	return self.ringEctypeInfo[ringEctypeID].finishFlag
end

-- 增加普通副本完成次数
function EctypeHandler:addEctypeFinishTimes(ectypeID)
	self:checkEctypeData(ectypeID)
	self.ectypeInfo[ectypeID].finishTimes = self.ectypeInfo[ectypeID].finishTimes + 1
	self.ectypeInfo[ectypeID].curProcess = 0
	self.ectypeInfo[ectypeID].recordTime = os.time()
	self.ectypeInfo[ectypeID].attackTime = 0
	-- 完成当前副本记录需要存数据库
	self.ectypeInfo[ectypeID].isSaveDB = true
end

-- 设置普通副本完成次数
function EctypeHandler:setEctypeFinishTimes(ectypeID, finishTimes)
	self:checkEctypeData(ectypeID)
	self.ectypeInfo[ectypeID].finishTimes = finishTimes
	self.ectypeInfo[ectypeID].recordTime = os.time()
end

-- 获得普通副本完成次数
function EctypeHandler:getEctypeFinishTimes(ectypeID)
	self:checkEctypeData(ectypeID)
	return self.ectypeInfo[ectypeID].finishTimes
end

-- 设置普通副本进度, 还有帮会副本奖励
function EctypeHandler:setEctypeProcess(ectypeID, curProcess)
	self:checkEctypeData(ectypeID)
	-- 普通副本发放奖励的条件是完成的进度比记录的进度大，如果玩家今天已经全部完成了，就没有奖励
	if curProcess > self.ectypeInfo[ectypeID].curProcess then
		local ectypeConfig = tEctypeDB[ectypeID]
		if ectypeConfig then
			if self.ectypeInfo[ectypeID].finishTimes < ectypeConfig.EctypeCDFinishTimes then
				local ectypePrizes = ectypeConfig.LogicProcedure[curProcess].Prizes
				if ectypePrizes then
					-- 经验奖励
					if ectypePrizes.ExpPrize then
						local msgID = 11
						local tem_xp_ratio = self._entity:getAttrValue(player_xp_ratio)
						local addXp = math.floor(ectypePrizes.ExpPrize * tem_xp_ratio / 100)
						self._entity:addXp(player_xp, addXp)
						self:sendEctypePrize(msgID, addXp)
						
					end
					-- 金钱奖励
					if ectypePrizes.MoneyPrize then
						local msgID = 12
						local money = ectypePrizes.MoneyPrize + self._entity:getMoney()
						self._entity:setMoney(money)
						self:sendEctypePrize(msgID, ectypePrizes.MoneyPrize)
					end
					-- 道行
					if ectypePrizes.TaoPrize then
						local msgID = 13
						-- 衰减等级
						--local decayLev = self._entity:getTaoDecayLev()
						-- 衰减强度
						--decayPower = math.pow(1/1.1, decayLev)
						--local curTaoPrize = math.floor(ectypePrizes.TaoPrize * decayPower)
						local tao = ectypePrizes.TaoPrize + self._entity:getAttrValue(player_tao)
						self._entity:setAttrValue(player_tao, tao)
						self:sendEctypePrize(msgID, ectypePrizes.TaoPrize)
					end
					-- 潜能
					if ectypePrizes.PotPrize then
						local msgID = 14
						local pot = ectypePrizes.PotPrize + self._entity:getAttrValue(player_pot)
						self._entity:setAttrValue(player_pot, pot)
						self:sendEctypePrize(msgID, ectypePrizes.PotPrize)
					end
					if ectypePrizes.ItemPrize then
						local msgID = 15
						local packetHandler = self._entity:getHandler(HandlerDef_Packet)
						local itemInfo = {}
						for i = 1, table.getn(ectypePrizes.ItemPrize) do
							local itemID = ectypePrizes.ItemPrize[i].itemID
							local itemNum = ectypePrizes.ItemPrize[i].itemNum
							if packetHandler:addItemsToPacket(itemID, itemNum) then
								if not itemInfo[i] then
									itemInfo[i] = {}
									itemInfo[i].itemID = itemID
									itemInfo[i].itemNum = itemNum
								end
							end
						end

						if table.size(itemInfo) > 0 then
							self:sendEctypePrize(msgID, itemInfo)
						end
					end
					print("获得普通副本进度奖励")
				end
				-- 副本额外进度奖励
				local attackTime = self.ectypeInfo[ectypeID].attackTime
				local percent = 100 - (attackTime * 5)
				local ectypeExtraPrizes = ectypeConfig.LogicProcedure[curProcess].ExtraPrizes
				if percent > 0 and ectypeExtraPrizes then
					-- 经验奖励
					self:sendEctypePrize(25, attackTime)
					if ectypeExtraPrizes.ExpPrize then
						local msgID = 26
						local expPrize = math.floor(ectypeExtraPrizes.ExpPrize * percent / 100)
						local tem_xp_ratio = self._entity:getAttrValue(player_xp_ratio)
						local addXp = math.floor(expPrize * tem_xp_ratio / 100)
						self._entity:addXp(player_xp, addXp)
						self:sendEctypePrize(msgID, addXp)
					end
					-- 金钱奖励
					if ectypeExtraPrizes.MoneyPrize then
						local msgID = 27
						local moneyPrize = math.floor(ectypeExtraPrizes.MoneyPrize * percent / 100)
						local money = moneyPrize + self._entity:getMoney()
						self._entity:setMoney(money)
						self:sendEctypePrize(msgID, moneyPrize)
					end
					-- 道行
					if ectypeExtraPrizes.TaoPrize then
						local msgID = 28
						-- 衰减等级
						--local decayLev = self._entity:getTaoDecayLev()
						-- 衰减强度
						--decayPower = math.pow(1/1.1, decayLev)
						local taoPrize = math.floor(ectypeExtraPrizes.TaoPrize * percent / 100)
						local tao = taoPrize + self._entity:getAttrValue(player_tao)
						self._entity:setAttrValue(player_tao, tao)
						self:sendEctypePrize(msgID, taoPrize)
					end
					-- 潜能
					if ectypeExtraPrizes.PotPrize then
						local msgID = 29
						local potPrize = math.floor(ectypeExtraPrizes.PotPrize * percent / 100)
						local pot = potPrize + self._entity:getAttrValue(player_pot)
						self._entity:setAttrValue(player_pot, pot)
						self:sendEctypePrize(msgID, potPrize)
					end
				end
			end
			self.ectypeInfo[ectypeID].curProcess = curProcess
			self.ectypeInfo[ectypeID].recordTime = os.time()
			if ectypeConfig.EctypeType ~= EctypeType.Common then
				self.ectypeInfo[ectypeID].isSaveDB = true
			end
		end
	end
end

-- 设置帮会副本奖励
function EctypeHandler:setFactionEctypeProcess(ectypeID, curProcess)
	self:checkEctypeData(ectypeID)
	-- 普通副本发放奖励的条件是完成的进度比记录的进度大，如果玩家今天已经全部完成了，就没有奖励
	if curProcess > self.ectypeInfo[ectypeID].curProcess then
		local ectypeConfig = tEctypeDB[ectypeID]
		if ectypeConfig then
			if self.ectypeInfo[ectypeID].finishTimes < ectypeConfig.EctypeCDFinishTimes then
				local stage = self:getFactionEctypeStage()
				local ectypePrizes = ectypeConfig.LogicProcedure[curProcess].Prizes[stage]
				local playerDBID = self._entity:getDBID()
				if ectypePrizes then
					-- 经验奖励
					if ectypePrizes.ExpPrize then
						local msgID = 11
						local tem_xp_ratio = self._entity:getAttrValue(player_xp_ratio)
						local addXp = math.floor(ectypePrizes.ExpPrize * tem_xp_ratio / 100)
						self._entity:addXp(player_xp, addXp)
						self:sendEctypePrize(msgID, addXp)
					end
					-- 帮贡
					if ectypePrizes.FactionCont then
						local msgID = 22
						local event = Event.getEvent(FactionEvent_BB_UpdateFactionMemberInfo,"memberMoney",playerDBID, ectypePrizes.FactionCont)
						g_eventMgr:fireWorldsEvent(event,SocialWorldID)
						self:sendEctypePrize(msgID, ectypePrizes.FactionCont)
					end
					-- 帮会资金
					if ectypePrizes.FactionMoney then
						local msgID = 23
						local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo, "addFactionMoney", playerDBID, ectypePrizes.FactionMoney)
						g_eventMgr:fireWorldsEvent(event, SocialWorldID)
						self:sendEctypePrize(msgID, ectypePrizes.FactionMoney)
					end
					-- 帮会声望
					if ectypePrizes.FactionFame then
						local msgID = 24
						local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo, "addFactionFame", playerDBID, ectypePrizes.FactionFame)
						g_eventMgr:fireWorldsEvent(event, SocialWorldID)
						self:sendEctypePrize(msgID, ectypePrizes.FactionFame)
					end
				end
			end
		end
	end
	self.ectypeInfo[ectypeID].curProcess = curProcess
	self.ectypeInfo[ectypeID].recordTime = os.time()
end

-- 获得普通副本进度
function EctypeHandler:getEctypeProcess(ectypeID)
	self:checkEctypeData(ectypeID)
	return self.ectypeInfo[ectypeID].curProcess
end

-- 设置普通副本剩余分钟数
function EctypeHandler:setEctypeLeftMin(ectypeID, leftMin)
	self:checkEctypeData(ectypeID)
	self.ectypeInfo[ectypeID].leftMin = leftMin
	self.ectypeInfo[ectypeID].recordTime = os.time()
	if leftMin > 0 then
		self.ectypeInfo[ectypeID].isSaveDB = true
	end
end

-- 获得普通副本剩余分钟数
function EctypeHandler:getEctypeLeftMin(ectypeID)
	self:checkEctypeData(ectypeID)
	return self.ectypeInfo[ectypeID].leftMin
end

-- 设置普通副本数据
function EctypeHandler:setEctypeInfo(ectypeRecord)
	for _, ectype in pairs(ectypeRecord or {}) do
		-- 如果副本数据是上一个CD周期的，则要重置完成次数
		local ectypeConfig = tEctypeDB[ectype.ectypeID]
		if ectypeConfig then
		    -- 除了周常副本，其他类型副本的CD类型都是天
			if ectypeConfig.EctypeType ~= EctypeType.Weekly then
				-- 判断记录日期跟现在是不是同一天
				if not time.isSameDay(ectype.recordTime) then
					-- 不是同一天，算是新CD了，重置完成次数和副本进度
					ectype.finishTimes = 0
					ectype.curProcess = 0
					ectype.leftMin = 0
					ectype.attackTime = 0
				end
			else
				-- 判断记录日期跟现在是不是同一周
				if not time.isSameWeek(ectype.recordTime) then
					-- 不是同一周，算是新CD了，重置完成次数和副本进度
					ectype.finishTimes = 0
					ectype.curProcess = 0
					ectype.leftMin = 0
					ectype.attackTime = 0
				end
			end
			-- 玩家首次上次，设置其保存数据库的字段为false
			if not self.ectypeInfo[ectype.ectypeID] then
				self.ectypeInfo[ectype.ectypeID] = {}
				self.ectypeInfo[ectype.ectypeID].finishTimes = ectype.finishTimes
				self.ectypeInfo[ectype.ectypeID].curProcess = ectype.curProcess
				self.ectypeInfo[ectype.ectypeID].leftMin = ectype.leftMin
				self.ectypeInfo[ectype.ectypeID].recordTime = ectype.recordTime
				self.ectypeInfo[ectype.ectypeID].attackTime = ectype.attackTime or 0
				self.ectypeInfo[ectype.ectypeID].isSaveDB = false
			else
				-- 逻辑错误
			end
		else
			-- 找不到副本配置
		end
	end
end

-- 设置连环副本数据
function EctypeHandler:setRingEctypeInfo(ringEctypeRecord)
	for _, ringEctype in pairs(ringEctypeRecord or {}) do
		local ringEctypeConfig = tRingEctypeDB[ringEctype.ringEctypeID]
		if ringEctypeConfig then
			-- 判断记录日期跟现在是不是同一天
			if time.isSameDay(ringEctype.recordTime) then
				if not self.ringEctypeInfo[ringEctype.ringEctypeID] then
					self.ringEctypeInfo[ringEctype.ringEctypeID] = {}
					self.ringEctypeInfo[ringEctype.ringEctypeID].curRing = ringEctype.curRing
					self.ringEctypeInfo[ringEctype.ringEctypeID].curGroupID = ringEctype.curGroupID
					self.ringEctypeInfo[ringEctype.ringEctypeID].curChildEctypeID = ringEctype.curChildEctypeID
					self.ringEctypeInfo[ringEctype.ringEctypeID].curProcess = ringEctype.curProcess
					self.ringEctypeInfo[ringEctype.ringEctypeID].leftMin = ringEctype.leftMin
					self.ringEctypeInfo[ringEctype.ringEctypeID].childEctypeFlag = {}
					self.ringEctypeInfo[ringEctype.ringEctypeID].childEctypeFlag[1] = ringEctype.firstChildEctypeFlag
					self.ringEctypeInfo[ringEctype.ringEctypeID].childEctypeFlag[2] = ringEctype.secondChildEctypeFlag
					self.ringEctypeInfo[ringEctype.ringEctypeID].childEctypeFlag[3] = ringEctype.thirdChildEctypeFlag
					self.ringEctypeInfo[ringEctype.ringEctypeID].childEctypeFlag[4] = ringEctype.fourthChildEctypeFlag
					self.ringEctypeInfo[ringEctype.ringEctypeID].finishFlag = ringEctype.finishFlag
					self.ringEctypeInfo[ringEctype.ringEctypeID].recordTime = ringEctype.recordTime
					self.ringEctypeInfo[ringEctype.ringEctypeID].attackTime = ringEctype.attackTime or 0
					self.ringEctypeInfo[ringEctype.ringEctypeID].isSaveDB = false
				else
					-- 逻辑错误
				end
			else
				-- 不是同一天，算是新CD了
			end
		else
			-- 找不到连环副本配置
		end
	end
end

-- 保存普通副本数据
function EctypeHandler:saveEctypeData()
	local playerDBID = self._entity:getDBID()
	for ectypeID, ectype in pairs(self.ectypeInfo) do
		local ectypeConfig = tEctypeDB[ectypeID]
		-- 除普通副本之外，只保存有进入次数的副本, 而且配置次数> 0 才需要保存数据库
		if ectypeConfig then
			if (ectypeConfig.EctypeType ~= EctypeType.Common and ectypeConfig.EctypeCDFinishTimes > 0 and ectype.isSaveDB) then		
				local ectypeInfo = ""
				ectypeInfo = ectypeInfo..ectypeID.."-"
				ectypeInfo = ectypeInfo..ectype.finishTimes.."-"
				ectypeInfo = ectypeInfo..ectype.curProcess.."-"
				ectypeInfo = ectypeInfo..ectype.leftMin.."-"
				ectypeInfo = ectypeInfo..ectype.recordTime.."-"
				ectypeInfo = ectypeInfo..ectype.attackTime.."-"
				LuaDBAccess.saveEctypeInfo(playerDBID, ectypeInfo)
			end
		end
	end
end

-- 保存连环副本数据
function EctypeHandler:saveRingEctypeData()
	local playerDBID = self._entity:getDBID()
	for ringEctypeID, ringEctype in pairs(self.ringEctypeInfo) do
		if ringEctype.isSaveDB then
			local ringEctypeInfo = ""
			ringEctypeInfo = ringEctypeInfo..ringEctypeID.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.curRing.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.curGroupID.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.curChildEctypeID.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.curProcess.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.leftMin.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.childEctypeFlag[1].."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.childEctypeFlag[2].."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.childEctypeFlag[3].."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.childEctypeFlag[4].."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.finishFlag.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.recordTime.."-"
			ringEctypeInfo = ringEctypeInfo..ringEctype.attackTime.."-"
			LuaDBAccess.saveRingEctypeInfo(playerDBID, ringEctypeInfo)
		end
	end
end

-- 这个地方发的最后一个参数组装成一个字符串
function EctypeHandler:sendEctypePrize(msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Ectype, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, self._entity)
end

-- 重设副本数据，供GM指令使用
function EctypeHandler:resetEctypeInfo()
	-- 普通副本数据
	self.ectypeInfo = {}
	-- 连环副本数据
	self.ringEctypeInfo = {}
end

-- 获取玩家副本积分
function EctypeHandler:getEctypeIntegral()
	return self.integral
end

-- 增加积分
function EctypeHandler:incIntegral(integral)
	self.integral = self.integral + integral
end

-- 减少积分
function EctypeHandler:redIntegral(integral)
	if self.integral > 0 then
		if self.integral >= integral then
			self.integral = self.integral - integral
			return integral
		else
			local curIntegral = self.integral
			self.integral = 0 
			return curIntegral
		end
	end
end

function EctypeHandler:setIntegral(integral)
	self.integral = integral
end

-- 获取玩家帮会副本奖励阶段分数区间
function EctypeHandler:getFactionEctypeStage()
	for index, integralSection in pairs(FactionEctypeReward) do
		if self.integral >= integralSection[1] and self.integral <= integralSection[2] then
			return index
		end
	end
end

-- 连环副本撞击次数
function EctypeHandler:addRingEctypeAttackTime(ringEctypeID)
	self:checkRingEctypeData(ringEctypeID)
	self.ringEctypeInfo[ringEctypeID].attackTime = self.ringEctypeInfo[ringEctypeID].attackTime + 1
	self.ringEctypeInfo[ringEctypeID].isSaveDB = true
end

-- 普通副本撞击次数
function EctypeHandler:addEctypeAttackTime(ectypeID)
	self:checkEctypeData(ectypeID)
	self.ectypeInfo[ectypeID].attackTime = self.ectypeInfo[ectypeID].attackTime + 1
	local ectypeEnterType = tEctypeDB[ectypeID].EctypeType
	if ectypeEnterType ~= EctypeType.Common and ectypeEnterType ~= EctypeType.Faction and ectypeEnterType ~= EctypeType.HulaoPass then
		self.ectypeInfo[ectypeID].isSaveDB = true
	end
end

-- 设置common副本的撞击次数
function EctypeHandler:setEctypeAttackTime(ectypeID, attackTime)
	self:checkEctypeData(ectypeID)
	self.ectypeInfo[ectypeID].attackTime = attackTime
end

-- 连环副本传送门撞击次数
function EctypeHandler:setRingEctypeAttackTime(ringEctypeID, attackTime)
	self:checkRingEctypeData(ringEctypeID)
	self.ringEctypeInfo[ringEctypeID].attackTime = attackTime
end
