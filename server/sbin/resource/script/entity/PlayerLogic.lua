--[[PlayerLogic.lua
描述：
	玩家业务逻辑部分
--]]

function Player:__init_logic()

	self._ectypeMapID	= false
	self._offlineDate	= 0
	self._pkInfo		= {}		-- pkInfo: hasBuff = true,isAttacker = true,isPK = true
	self._bMustCatch	= false

	self._autoHideChatWin		= 0
	self._factionDBID    		= 0
	self._factionMoney			= 0
	self._factionHistoryMoney	= 0
	self._factionJoinDate 		= 0

	self._thisWeekFactionContribute = 0
	self._lastWeekFactionContribute = 0
	self._intradayFactionContribute = 0
	self._factionConfiguration		= {}

	self._taskMineConfig = nil --任务雷配置
	-- 开启60秒的定时器，体力值和杀气
	self.timerID = g_timerMgr:regTimer(self, 1000 * RegularTime.Second, 1000 * RegularTime.Second, "PlayerLogic:Kill")
	self._fightTimerID = nil
end

function Player:__release_logic()
	-- todo
	self._ectypeMapID = nil
	self._offlineDate = nil
	self._pkInfo	  = nil
	self._bMustCatch  = nil
	
	self._autoHideChatWin		= nil
	self._factionDBID    		= nil
	self._factionMoney			= nil
	self._factionHistoryMoney	= nil
	self._factionJoinDate 		= nil

	self._thisWeekFactionContribute = nil
	self._lastWeekFactionContribute = nil
	self._intradayFactionContribute = nil
	self._factionConfiguration		= nil

	if self.timerID then
		g_timerMgr:unRegTimer(self.timerID)
		self.timerID = nil

	end
end

function Player:getFightTimerID()
	return self._fightTimerID
end

function Player:setFightTimerID(ID)
	self._fightTimerID = ID
end

-- 社会服需要的业务属性
function Player:setOfflineDate(offlineDate)
	self._offlineDate = offlineDate
end

function Player:getOfflineDate()
	return self._offlineDate
end

function Player:setAutoHideChatWin( autoHideChatWin )
	self._autoHideChatWin = autoHideChatWin
end

function Player:getAutoHideChatWin(  )
	return self._autoHideChatWin
end

function Player:setFactionDBID( factionDBID )
	local factionDBID = factionDBID or 0
	self._factionDBID = factionDBID
end

function Player:getFactionDBID(  )
	return self._factionDBID
end

function Player:setFactionMoney( factionMoney )
	local factionMoney = factionMoney or 0
	self._factionMoney = factionMoney
end

function Player:getFactionMoney(  )
	return self._factionMoney
end

function Player:setFactionHistoryMoney( factionHistoryMoney )
	local factionHistoryMoney = factionHistoryMoney or 0
	self._factionHistoryMoney = factionHistoryMoney
end

function Player:getFactionHistoryMoney(  )
	return self._factionHistoryMoney
end

function Player:setFactionJoinDate( factionJoinDate )
	local factionJoinDate = factionJoinDate or 0
	self._factionJoinDate = factionJoinDate
end

function Player:getFactionJoinDate(  )
	return self._factionJoinDate
end

function Player:getThisWeekFactionContribute(  )
	return self._thisWeekFactionContribute
end

function Player:setThisWeekFactionContribute( money )
	self._thisWeekFactionContribute = money
end

function Player:getLastWeekFactionContribute(  )
	return self._lastWeekFactionContribute
end

function Player:setLastWeekFactionContribute( money )
	self._lastWeekFactionContribute = money
end

function Player:getIntradayFactionContribute(  )
	return self._intradayFactionContribute
end

function Player:setIntradayFactionContribute( money )
	self._intradayFactionContribute = money
end

function Player:getFactionConfiguration(  )
	return self._factionConfiguration
end

function Player:setFactionConfiguration( factionConfiguration )
	self._factionConfiguration = factionConfiguration
end

-- 设置玩家副本动态ID
function Player:setEctypeMapID(ectypeMapID)
	self._ectypeMapID = ectypeMapID
end

-- 获取玩家副本动态ID
function Player:getEctypeMapID()
	return self._ectypeMapID
end

-- player is can move
function Player:isCanMove()
	if self:getActionState() == PlayerStates.Follow then
		return false
	--[[elseif self:isFighting() then
		return false]]
	end
	return true
end


-- 宠物相关代码:不要以下范围内插入 --

-- 加载所有宠物
function Player:loadAllPets(recordSet)
	self:getHandler(HandlerDef_Pet):loadDB(recordSet)
end

-- 离线所有宠物
function Player:kickAllPets()
	self:getHandler(HandlerDef_Pet):onPlayerOffline()
end

-- not-suggested:获得宠物总数
function Player:getPetAmount()
	return self:getHandler(HandlerDef_Pet):getAmount()
end

-- not-suggested:能否添加宠物
function Player:canAddPet()
	return self:getMaxPet() > self:getPetAmount()
end

-- not-suggested:添加一个宠物
function Player:addPet(pet)
	return self:getHandler(HandlerDef_Pet):addPet(pet)
end

-- not-suggested:获得一个宠物
function Player:getPet(id)
	return self:getHandler(HandlerDef_Pet):getPet(id)
end

-- not-suggested:移除一个宠物
function Player:removePet(id)
	return self:getHandler(HandlerDef_Pet):removePet(id)
end

-- not-suggested:获得最后捕捉的宠物
function Player:getLastCaught(configID)
	return self:getHandler(HandlerDef_Pet):getLastCaught(configID)
end

function Player:getFollowPetID()
	return self:getHandler(HandlerDef_Pet):getFollowPetID()
end

function Player:getFightPetID()
	return self:getHandler(HandlerDef_Pet):getFightPetID()
end

function Player:getReadyPetID()
	return self:getHandler(HandlerDef_Pet):getReadyPetID()
end

-- not-suggested:获得所有宠物
function Player:getPetList()
	return self:getHandler(HandlerDef_Pet):getAll()
end

-- 宠物关联代码:结束 --

-- 加载自动点数分配方案
function Player:loadAutoPoint(attrRecord)
	local handler = self:getHandler(HandlerDef_AutoPoint)
	handler:init(self,attrRecord)
	handler:sendToClient(self,self,AutoPointHandler.Both)
end

-- 保存玩家的自动点数分配策略
function Player:saveAutoPoint()
	LuaDBAccess.SavePointSetting(self)
end

function Player:getPkInfo()
	return self._pkInfo
end

function Player:setIsMustCatch(isOk)
	self._bMustCatch = isOk
end

function Player:getIsMustCatch()
	return self._bMustCatch
end

function Player:inc_allf_add(value)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_add_af_mf) + value
	attrSet:setAttrValue(player_add_af_mf, value)
end

function Player:inc_max_mp_add(value)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_add_max_mp) + value
	attrSet:setAttrValue(player_add_max_mp, value)
end

function Player:inc_disorder_hit_add(value)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_obstacle_hit) + value
	attrSet:setAttrValue(player_inc_obstacle_hit, value)
end

function Player:inc_anger_add_ration(value)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_anger) + value
	attrSet:setAttrValue(player_inc_anger, value)
end

function Player:inc_all_phase_resist_add(value)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_phase_resist) + value
	attrSet:setAttrValue(player_inc_phase_resist, value)
end

function Player:inc_fire_at_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_fir_at) + value
	attrSet:setAttrValue(player_inc_fir_at, value)
end

function Player:inc_wind_at_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_win_at) + value
	attrSet:setAttrValue(player_inc_win_at, value)
end

function Player:inc_thunder_at_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_thu_at) + value
	attrSet:setAttrValue(player_inc_thu_at, value)
end

function Player:inc_soil_at_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_soi_at) + value
	attrSet:setAttrValue(player_inc_soi_at, value)
end

function Player:inc_ice_at_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_ice_at) + value
	attrSet:setAttrValue(player_inc_ice_at, value)
end

function Player:inc_poison_at_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_poi_resist) + value
	attrSet:setAttrValue(player_inc_poi_resist, value)
end

function Player:inc_fire_resist_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_fir_resist) + value
	attrSet:setAttrValue(player_inc_fir_resist, value)
end

function Player:inc_wind_resist_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_win_resist) + value
	attrSet:setAttrValue(player_inc_win_resist, value)
end

function Player:inc_thunder_resist_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_thu_resist) + value
	attrSet:setAttrValue(player_inc_thu_resist, value)
end

function Player:inc_soil_resist_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_soi_resist) + value
	attrSet:setAttrValue(player_inc_soi_resist, value)
end

function Player:inc_ice_resist_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_ice_resist) + value
	attrSet:setAttrValue(player_inc_ice_resist, value)
end

function Player:inc_poison_resist_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_poi_resist) + value
	attrSet:setAttrValue(player_inc_poi_resist, value)
end

function Player:inc_at_add(value, percent)
	local attrSet = self.attrSet
	if percent then
		value = attrSet:getAttrValue(player_inc_at) + value
		attrSet:setAttrValue(player_inc_at, value)
	else
		value = attrSet:getAttrValue(player_add_at) + value
		attrSet:setAttrValue(player_add_at, value)
	end
end

function Player:inc_mt_add(value, percent)
	local attrSet = self.attrSet
	if percent then
		value = attrSet:getAttrValue(player_inc_mt) + value
		attrSet:setAttrValue(player_inc_mt, value)
	else
		value = attrSet:getAttrValue(player_add_mt) + value
		attrSet:setAttrValue(player_add_mt, value)
	end
end

function Player:inc_af_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_add_af) + value
	attrSet:setAttrValue(player_add_af, value)
end

function Player:inc_mf_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_add_mf) + value
	attrSet:setAttrValue(player_add_mf, value)
end

function Player:inc_hit_add(value, percent)
	local attrSet = self.attrSet
	if percent then
		value = attrSet:getAttrValue(player_inc_hit) + value
		attrSet:setAttrValue(player_inc_hit, value)
	else
		value = attrSet:getAttrValue(player_add_hit) + value
		attrSet:setAttrValue(player_add_hit, value)
	end
end

function Player:inc_dodge_add(value, percent)
	local attrSet = self.attrSet
	if percent then
		value = attrSet:getAttrValue(player_inc_dodge) + value
		attrSet:setAttrValue(player_inc_dodge, value)
	else
		value = attrSet:getAttrValue(player_add_dodge) + value
		attrSet:setAttrValue(player_add_dodge, value)
	end
end

function Player:inc_critical_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_critical) + value
	attrSet:setAttrValue(player_inc_critical, value)
end

function Player:inc_tenacity_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_tenacity) + value
	attrSet:setAttrValue(player_inc_tenacity, value)
end

function Player:inc_speed_add(value, percent)
	local attrSet = self.attrSet
	value = attrSet:getAttrValue(player_inc_speed) + value
	attrSet:setAttrValue(player_inc_speed, value)
end

function Player:inc_all_at_mt(value, percent)
	local attrSet = self.attrSet
	if percent then
		value = value + attrSet:getAttrValue(player_inc_at_mt)
		attrSet:setAttrValue(player_inc_at_mt, value)
	else
		value = value + attrSet:getAttrValue(player_add_at_mt)
		attrSet:setAttrValue(player_add_at_mt, value)
	end
end

function Player:inc_all_af_mf(value, percent)
	local attrSet = self.attrSet
	if percent then
		value = value + attrSet:getAttrValue(player_inc_af_mf)
		attrSet:setAttrValue(player_inc_af_mf, value)
	else
		value = value + attrSet:getAttrValue(player_add_af_mf)
		attrSet:setAttrValue(player_add_af_mf, value)
	end
end

function Player:setTaskMineConfig(config)
	self._taskMineConfig = config
end

function Player:getTaskMineConfig()
	return self._taskMineConfig
end

function Player:onWarEnded(attrs, notSyn)
	local attrSet = self.attrSet
	for attrType, attrValue in pairs(attrs) do
		if type(attrType) == "number" then
			attrSet:setAttrValue(attrType,attrValue)
		end
	end
	
	self:setFighting(false)
	self:setIsMustCatch(false)
	local newBattlePack = attrs.pack
	local packetHandler = self:getHandler(HandlerDef_Packet)
	local packet = packetHandler:getPacket()
	packet:setBattlePack(newBattlePack)
	if not notSyn then
		self:flushPropBatch()
	end
end

-- 定时器回调
function Player:update(timerID)
	if timerID == self.timerID then
		-- 增加玩家的体力值
		local vigor = self:getVigor()
		local maxVigor = self:getMaxVigor()
		if vigor < maxVigor then
			vigor = vigor + 1
			self:setVigor(vigor)
		end
		-- 减玩家杀气
		local attrSet = self.attrSet
		local killAir = attrSet:getAttrValue(player_kill)
		if killAir > 0 then
			killAir = killAir - 1
			attrSet:setAttrValue(player_kill, killAir)
		end
	end
end

-- 同时设定玩家的5项基础属性,供GM系统使用,暂时没有提供战斗服支持
function Player:setAll(value)
	local attrSet = self.attrSet
	attrSet:setAttrValue(player_add_str, value)
	attrSet:setAttrValue(player_add_int, value)
	attrSet:setAttrValue(player_add_sta, value)
	attrSet:setAttrValue(player_add_spi, value)
	attrSet:setAttrValue(player_add_dex, value)
end
