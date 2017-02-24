--[[PlayerBasic.lua
描述：
	玩家基础数据
--]]
require "attribute.Attribute"

local setPropValue		= setPropValue		-- 设置peer中属性值,不会导致发送
local getPropValue		= getPropValue		-- 获得peer中属性值
local flushPropBatch	= flushPropBatch	-- 发送peer中所有最新的属性值

function Player:__init_basic()
	self._sex			= nil
	self._school		= nil
	self.level			= nil
	self.temp_xp		= false --临时经验值
	self.payMode		= false --玩家支付的方式
	self.tiredness		= 0
	self.practise		= 0
	self.practiseCount	= 0
	self.storeXp		= 0 -- 存储经验
	self.attrSet		= {}
	self.actionState	= PlayerStates.Normal
	self.lastActiveTime	= 0
	self._loginPos		= {}--[1]=mapID,[2]=x,[3]=y
	self:createAttributeSet()
end

function Player:__release_basic()
	self._name			= nil
	self._sex			= nil
	self._showParts		= nil
	self._school		= nil
	self.level			= nil
	self.lastActiveTime	= nil
end

-- 性别
function Player:setSex(sex)
	self.sex = sex
end

function Player:getSex()
	return self.sex
end

-- 头部纹理
function Player:setCurHeadTex(texIndex)
	self.curHeadTex = texIndex
end

function Player:getCurHeadTex()
	return self.curHeadTex
end

-- 身体纹理
function Player:setCurBodyTex(texIndex)
	self.curBodyTex = texIndex
end

function Player:getCurBodyTex()
	return self.curBodyTex
end

-- 显示纹理
function Player:initShowParts(showParts)
	if not showParts or showParts == "" then
		return
	end
	if self.showParts == showParts or string.len(showParts) < 5 then
		return
	end
	self.showParts = showParts
	local i = string.find(showParts, ",")
	if not i then
		return
	end
	self.curHeadTex = tonumber(string.sub(showParts, i-1, i-1))
	self.curBodyTex = tonumber(string.sub(showParts, i+1, -2))
end

-- 上一次的心跳时间
function Player:setLastActive(lastActive)
	self.lastActiveTime = lastActive
end

function Player:getLastActive()
	return self.lastActiveTime
end

-- 玩家的登录位置
function Player:getLoginPos()
	return self._loginPos
end

function Player:setLoginPos(pos)
	self._loginPos = pos
end

-- 玩家采集状态
function Player:setCollectState(state)
	self.collectState = state
end

function Player:getCollectState()
	return self.collectState
end

-- 设置绑银
function Player:setSubMoney(money)
	if money > MaxMoneyAndGoldCoin then
		money = MaxMoneyAndGoldCoin
	end
	self.subMoney = money
	setPropValue(self._peer, PLAYER_SUBMONEY, money)
end

-- 获取玩家绑银
function Player:getSubMoney()
	return self.subMoney
end

-- 设置仓库银两
function Player:setDepotMoney(depotMoney)
	self.depotMoney = depotMoney
	setPropValue(self._peer, PLAYER_DEPOTMONEY, depotMoney)
end

-- 获取玩家仓库银两
function Player:getDepotMoney()
	return self.depotMoney
end

-- 设置仓库容量大小
function Player:setDepotCapacity(depotCapacity)
	self.depotCapacity = depotCapacity
end

-- 获取玩家仓库容量大小
function Player:getDepotCapacity()
	return self.depotCapacity
end

-- 设置玩家支付方式,绑银是true
function Player:setPayMode(payMode)
	self.payMode = payMode
end

-- 获取玩家的支付方式
function Player:getPayMode()
	return self.payMode
end

function Player:setMoney(money)
	-- 限制金钱
	if money > MaxMoneyAndGoldCoin then
		money = MaxMoneyAndGoldCoin
	end
	self._money = money
	setPropValue(self._peer, PLAYER_MONEY, money)
end

-- 获取金钱
function Player:getMoney()
	return self._money
end

function Player:setCashMoney(money)
	if money > MaxMoneyAndGoldCoin then
		money = MaxMoneyAndGoldCoin
	end
	self.cashMoney = money
	setPropValue(self._peer, PLAYER_CASHMONEY, money)
end

function Player:getCashMoney()
	return self.cashMoney
end

function Player:setGoldCoin(goldCoin)
	if goldCoin > MaxMoneyAndGoldCoin then
		goldCoin = MaxMoneyAndGoldCoin
	end
	self.goldCoin = goldCoin
	setPropValue(self._peer, PLAYER_GOLDCOIN, goldCoin)
end

function Player:getGoldCoin()
	return self.goldCoin
end

function Player:setTiredness(tiredness)
	self.tiredness = tiredness
	if tiredness < 0 then
		self.tiredness = 0
	end
	setPropValue(self._peer, PLAYER_TIREDNESS, tiredness)
end

function Player:getTiredness()
	return self.tiredness
end

function Player:setPractise(practise)
	self.practise = practise
	if practise < 0 then
		self.practise = 0
	end
	setPropValue(self._peer, PLAYER_PRACTISE, practise)	
end

-- 增加玩家修行请用这个接口 否则不能加入到总值中
function Player:addPractise(v)	
	local priactise = self.practise
	priactise = priactise + v
	self:setPractise(priactise)
	local priactiseCount = self.practiseCount + v
	self:setPractiseCount(priactiseCount)
end
function Player:getPractise()
	return self.practise
end

function Player:setPractiseCount(practiseCount)
	self.practiseCount = practiseCount
	if practiseCount < 0 then
		self.practiseCount = 0
	end
	setPropValue(self._peer, PLAYER_PRACTISECOUNT, practiseCount)
end

function Player:getPractiseCount()
	return self.practiseCount
end

function Player:setStoreXp(storeXp)
	-- 存储经验 不能大于下一级经验
	if storeXp > self:getNextXp() then
		storeXp = self:getNextXp()
	end
	self.storeXp = storeXp
	setPropValue(self._peer, PLAYER_STOREXP, storeXp)
	return storeXp
end

function Player:getStoreXp()
	return self.storeXp
end

-- 设置玩家状态，摆摊，组队等
function Player:setActionState(playerState)
	local teamHandler = self:getHandler(HandlerDef_Team)
	if teamHandler:isLeader() and playerState == PlayerStates.P2PTrade then
		playerState = PlayerStates.P2PTradeAndTeam
	end
	if teamHandler:isLeader() and self.actionState == PlayerStates.P2PTradeAndTeam and playerState == PlayerStates.Normal then
		playerState = PlayerStates.Team
	end
	self.actionState = playerState
	local peer = self:getPeer()
	setPropValue(peer,PLAYER_ACTION_STATE,playerState)
	self:flushPropBatch()
end

-- 获取玩家状态，摆摊，组队等
function Player:getActionState()
	return self.actionState
end

function Player:getOldActionState()
	return self._oldActionState
end

function Player:setOldActionState(s)
	if s == PlayerStates.P2PTrade or s == PlayerStates.P2PTradeAndTeam then 
		self._oldActionState = PlayerStates.Normal
	else 
		self._oldActionState = s
	end 
end

function Player:incHp(value)
	local hp = self:getHP()
	local max_hp = self:getMaxHP()
	local hp_t = hp
	hp = hp + value
	hp = hp > max_hp and max_hp or hp
	hp = hp < 0 and 0 or hp
	if hp_t ~= hp then
		self:setHP(hp)
	end
end

-- 蓝量&血量
function Player:getHP()
	return self:getAttrValue(player_hp)
end

function Player:setHP(value)
	self:setAttrValue(player_hp,math.floor(value))
end

function Player:getMaxHP()
	return self:getAttrValue(player_max_hp)
end

function Player:getMP()
	return self:getAttrValue(player_mp)
end

function Player:setMP(value)
	self:setAttrValue(player_mp,value)
end

function Player:getMaxMP()
	return self:getAttrValue(player_max_mp)
end

-- 体力值
function Player:getVigor()
	return self:getAttrValue(player_vigor)
end

function Player:setVigor(value)
	self:setAttrValue(player_vigor, value)
end

function Player:getMaxVigor()
	return self:getAttrValue(player_max_vigor)
end

-- 最大宠物数量
function Player:getMaxPet()
	return self:getAttrValue(player_max_pet)
end

function Player:setMaxPet(pb)
	self:setAttrValue(player_max_pet,pb)
end

function Player:isInView(roleID)
	return self._peer:isInView(roleID)
end

--[[
	处理玩家经验升级
]]
function Player:handleLevelUP()
	local level = self.level
	local currentXp = self:getXp()
	local nextLevelXP = PlayerLevelUpDB[level]

	while level < UserAutoUPMaxLevel and currentXp >= nextLevelXP do
		currentXp = currentXp - nextLevelXP
		level = level + 1
		nextLevelXP = PlayerLevelUpDB[level]
	end

	if self.level ~= level then
		self:onLevelUp(level)
		self:setXp(currentXp)
		return true
	end

	return false
end

-- 玩家升级
function Player:onLevelUp(level)
	local curLevel = self:getLevel()
	level = tonumber(level)
	local addLevel = level - curLevel 
	if addLevel > 0 then
		self:addAttrPoint(5*addLevel)
		if level > 19 then
			self:addPhasePoint(
				2 * (level - math.max(19,curLevel))
			)
		end
	end
	
	self:setLevel(level) 
	self:setHP(self:getMaxHP()) 
	self:setMP(self:getMaxMP())
	self:setVigor(self:getMaxVigor())
	self:flushPropBatch()

	g_eventMgr:fireRemoteEvent(
		Event.getEvent(PlayerSysEvent_SC_RoleUpgrade), self
	)

	if level >= baseRewardLvl then
		local sessionMgr = RewardSessionManager.getInstance()
		if sessionMgr:getSession(self) then
			print("已有抽奖记录了")
		else
			sessionMgr:createSession(self)
		end
	end

	self:flushPropBatch() -- 玩家升级以后同样也发送一次所有属性
	self:getHandler(HandlerDef_Pet):handlePetLevelUP()
end

-- 添加属性点
function Player:addAttrPoint(value)
	self:addAttrValue(player_attr_point,value)
	local handler = self:getHandler(HandlerDef_AutoPoint)
	if handler and handler:isAutoAttr() then
		handler:distibuteAttrPoints()
	end
end

-- 添加相性点
function Player:addPhasePoint(value)
	self:addAttrValue(player_phase_point,value)
	local handler = self:getHandler(HandlerDef_AutoPoint)
	if handler and handler:isAutoPhase() then
		handler:distibutePhasePoints()
	end
end

-- 增加玩家经验值
function Player:addXp(value)
	local temp_xp = self:getXp() + value
	self.temp_xp = temp_xp
	if not self:handleLevelUP() then
		self:setXp(temp_xp)
	end
end

function Player:setXp(value)
	self:setAttrValue(player_xp, value)
	self.temp_xp = false
end

function Player:getXp()
	return self.temp_xp or self:getAttrValue(player_xp)
end

function Player:getNextXp()
	return self:getAttrValue(player_next_xp)
end

-- 这个函数用来同步属性吗? from:2017年1月3日
-- 玩家首次登陆初始化属性
local function initFirstLoginAttr(self)
	if self:getXp() == 0 then
		self:setXp(0)
	end
	if self:getHP() == 0 then
		self:setHP(self:getMaxHP())
	end
	if self:getHP() > self:getMaxHP() then
		self:setHP(self:getMaxHP())
	end
	if self:getMP() == 0 then
		self:setMP(self:getMaxMP())
	end
	if self:getMP() > self:getMaxMP() then
		self:setMP(self:getMaxMP())
	end
	-- 获取最大属性值
	if self:getVigor() == 0 then
		self:setVigor(self:getMaxVigor())
	end
end

function Player:setLevel(level, fromDB)


	self.level = level
	self:setAttrValue(player_lvl,level)
	initFirstLoginAttr(self)
	if level >= PacketLevelPackNeedLevel then
		-- 获取最大属性值
		local packetHandler = self:getHandler(HandlerDef_Packet)
		packetHandler:updateLevelPack()
	end
	-- 等级变化通知任务系统
	g_taskDoer:notifyTaskSystem(self._id, level, fromDB)
end

function Player:getLevel()
	return self.level
end

function Player:setSchool(school)
	self.school = school
	setPropValue(self._peer,PLAYER_SCHOOL,school)
end

function Player:getSchool()
	return self.school
end

function Player:updatePropSet()
	local peer = self:getPeer()
	setPropValue(peer, UNIT_NAME,			self:getName())
	setPropValue(peer, UNIT_MODEL,			self:getModelID())
	setPropValue(peer, PLAYER_SEX,			self:getSex())
	setPropValue(peer, PLAYER_XP,			self:getXp())
	setPropValue(peer, PLAYER_LEVEL,		self:getLevel())
	setPropValue(peer, PLAYER_SCHOOL,		self:getSchool())
	setPropValue(peer, PLAYER_MONEY,		self:getMoney())
	setPropValue(peer, PLAYER_SUBMONEY,		self:getSubMoney())
	setPropValue(peer, PLAYER_DEPOTMONEY,	self:getDepotMoney())
	setPropValue(peer, PLAYER_CASHMONEY,	self:getCashMoney())
	setPropValue(peer, PLAYER_GOLDCOIN,		self:getGoldCoin())
	setPropValue(peer, PLAYER_TIREDNESS,	self:getTiredness())
	setPropValue(peer, PLAYER_PRACTISE,		self:getPractise())
	setPropValue(peer, PLAYER_PRACTISECOUNT,self:getPractiseCount())
	setPropValue(peer, PLAYER_STOREXP,		self:getStoreXp())
	
	self:freshProps()
end

function Player:loadBasicDataFromDB(recordList)
	local rs = recordList[1][1]
	self:initBasicValue(rs)
	self:setAccountID(rs.accountID)
	self:setName(rs.name)
	self:setModelID(rs.modelID)
	self:initShowParts(rs.showParts)
	self:setShowParts(rs.showParts)
	self:setSex(rs.sex and 1 or 0)
	self:setMoney(rs.money)
	self:setSubMoney(rs.subMoney)
	self:setDepotMoney(rs.depotMoney)
	self:setSchool(rs.school)
	self:setDepotCapacity(rs.depotCapacity)
	self:setCashMoney(rs.cashMoney)
	self:setGoldCoin(rs.goldCoin)
	self:setPos({rs.mapID, rs.posX, rs.posY})
	self:setLoginPos({rs.mapID, rs.posX, rs.posY})
	self:getHandler(HandlerDef_Ride):setRideCapacity(rs.rideBar)
	-- 加载玩家属性集合
	local attributeRecord = recordList[2]
	self:createAttributeSet()
	self:loadAttrRecord(attributeRecord)

	-- 等级特殊处理
	self:setLevel(rs.level, true)

	-- 同步属性到peer
	self:updatePropSet()
end

-- 加载玩家属性集合
function Player:loadAttrRecord(attrRecord)
	if not attrRecord then
		print("[Player:loadAttrRecord] 属性集合记录为空")
		return
	end

	local attrSet = self.attrSet
	for index,detail in pairs(attrRecord) do
		local attribute = attrSet[detail.attrType]
		if attribute and not attribute:isExpr() then
			attribute:loadValue(detail.attrValue)
		else
			print(("[Player:loadAttrRecord] 错误的玩家属性定义 %s"):format(attribute and attribute:getName() or "nil"))
		end
	end
	--toDo:add default attribute value handle
end

-- 创建玩家属性集合
function Player:createAttributeSet()
	local attrSet = self.attrSet
	for attrName,detail in pairs(PlayerAttrDefine) do
		if not attrSet[attrName] then
			attrSet[attrName] = PlayerAttribute(self,attrName,detail.expr,0)
		end
	end
end

function Player:getAttributeSet()
	return self.attrSet
end

-- 获取某一项属性
function Player:getAttribute(attrName)
	return attrName and self.attrSet[attrName]
end

-- 获得属性集合
function Player:getAttrSet()
	return self.attrSet
end

-- 设置属性值
function Player:setAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:setAttrValue] 没有属性e %s!"):format(attrName or "nil"))
		return
	end
	if attribute:isExpr() then
		print(("[Player:setAttrValue] 不能设置给公式属性 %s!"):format(attribute:getName()))
		return
	end
	attribute:setValue(value)
end

-- 获得某项属性的值
function Player:getAttrValue(attrName)
	local attribute = attrName and self.attrSet[attrName]
	if attribute then
		return attribute:getValue()
	else
		print(("[Player:getAttrValue()] 没有属性 %s!"):format(attrName or "nil"))
		return nil
	end
end

-- 给某项属性加值
function Player:addAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:addAttrValue] 没有%s这项属性!"):format(attrName or "nil"))
	end
	attribute:addValue(value)
end

--属性减值
function Player:subAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:subAttrValue] 没有%s这项属性!"):format(attrName or "nil"))
	end
	attribute:addValue(0 - value)
end

-- 确保所有需要同步的属性都是最新的
function Player:freshProps()
	local attrSet = self.attrSet
	for attrName,_ in pairs(g_AttributePlayerToProp) do
		attrSet[attrName]:getValue()
	end
end

-- 发送所有的属性变化
function Player:flushPropBatch()
	self:freshProps()
	flushPropBatch(self:getPeer())
end

function Player:onPlayerLogout(reason)
	--store the status and position
	self:updatePlayerAttr()
	local mapID, xPos, yPos = self:getCurPos()
	if mapID >= EctypeMap_StartID then
		-- 在副本中下线，找到进入点坐标
		local ectypeHandler = self:getHandler(HandlerDef_Ectype)
		local enterPos = ectypeHandler:getEnterPos()
		mapID = enterPos.mapID
		xPos = enterPos.xPos
		yPos = enterPos.yPos
	end
	
	-- 如果在捕宠活动场景当中
	if g_catchPetMgr:isInActivityScene(self) then
		local activityHandler = self:getHandler(HandlerDef_Activity)
		local enterPos = activityHandler:getEnterPos()
		mapID = enterPos.mapID
		xPos = enterPos.xPos
		yPos = enterPos.yPos
	end
	self:updateProperty("MapID",mapID)
	self:updateProperty("PosX",xPos)
	self:updateProperty("PosY",yPos)
	self:updateProperty("Level",self:getLevel())
	self:updateProperty("ModelID",self:getModelID())
	self:updateProperty("Money",self:getMoney())
	self:updateProperty("SubMoney",self:getSubMoney())
	self:updateProperty("DepotMoney",self:getDepotMoney())
	self:updateProperty("DepotCapacity",self:getDepotCapacity())
	self:updateProperty("CashMoney",self:getCashMoney())
	self:updateProperty("ShowParts",self:getShowParts())
	self:updateProperty("PetDepotCapacity",self:getHandler(HandlerDef_PetDepot):getCapacity())
	self:updateProperty("Tiredness",self:getTiredness())
	self:updateProperty("Practise",self:getPractise())
	self:updateProperty("PractiseCount",self:getPractiseCount())
	self:updateProperty("StoreXp",self:getStoreXp())
	self:updateProperty("RideBar",self:getHandler(HandlerDef_Ride):getRideCapacity())
end

-- 提交玩家属性集合
function Player:updatePlayerAttr()
	LuaDBAccess.onPlayerAttrUpdate(self)
end

-- 提交玩家基础值
function Player:updateProperty(name,value)
	local dbID = self._dbId
	LuaDBAccess.updatePlayer(dbID, name, value)
end

-- 获得玩家当前位置信息
function Player:getCurPos()
	local peer = self:getPeer()
	local scene = self:getScene()
	local mapID = self:getEctypeMapID() or scene:getMapID()
	local pos = peer:getPosition()
	return mapID, pos.x, pos.y
end

-- 属性改变事件通知
function Player:onAttrChanged(attrName,prev,value)
	if attrName == player_max_hp then
		local hp = self:getHP() + value - prev
		if hp > value then hp = value
		elseif hp < 0 then hp = 0
		end
		self:setHP(hp)
		return
	end
	if attrName == player_max_mp then
		local mp = self:getMP() + value - prev
		if mp > value then mp = value
		elseif mp < 0 then mp = 0
		end
		self:setMP(mp)
		return
	end
end

function Player:initBasicValue(rs)
	if rs.mapID < 1 then
		local defPlrInfo = SchoolPlayerDB[rs.school]
		if defPlrInfo then
			rs.mapID = defPlrInfo.defaultMapID
			rs.posX = defPlrInfo.defaultPosX
			rs.posY = defPlrInfo.defaultPosY
		end
	end
end


