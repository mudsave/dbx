--[[PlayerBasic.lua
描述�?
	玩家基础数据
--]]
require "entity.attribute.Attribute"
local setPropValue		= setPropValue		-- 设置peer中属性�?,不会导致发�?
local getPropValue		= getPropValue		-- 获得peer中属性�?
local flushPropBatch	= flushPropBatch	-- 发送peer中所有最新的属性�?


function Player:__init_basic()
	self._sex		= nil
	self._school	= nil
	self.level		= nil
	self.attrSet	= {}

	self:createAttributeSet()
end

function Player:__release_basic()
	self._name		= nil
	self._sex		= nil
	self._modelId	= nil
	self._showParts	= nil
	self._school	= nil
	self.level		= nil
end


function Player:setName(name)
	self.name = name
end

function Player:getName()
	return self.name
end

function Player:setModelID(modelID)
	self.modelID = modelID
	setPropValue(self._peer,UNIT_MODEL,modelID)
end

function Player:getModelID()
	return self.modelID
end

function Player:setSex(sex)
	self.sex = sex
end

function Player:getSex()
	return self.sex
end

function Player:setCurHeadTex(texIndex)
	self.curHeadTex = texIndex
end

function Player:getCurHeadTex()
	return self.curHeadTex
end

function Player:setCurBodyTex(texIndex)
	self.curBodyTex = texIndex
end

function Player:getCurBodyTex()
	return self.curBodyTex
end

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

function Player:setShowParts(showParts)
	self.showParts = showParts
	setPropValue(self._peer,UNIT_SHOWPARTS, showParts)
end

function Player:getShowParts()
	return self.showParts
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

--设置玩家状态，摆摊，组队等
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
end

--获取玩家状态，摆摊，组队等
function Player:getActionState()
	return self.actionState
end

function Player:getOldActionState()
	return self._oldActionState
end

function Player:setOldActionState(s)
	self._oldActionState = s
end


function Player:getHp()
	return self:getAttrValue(player_hp)
end

function Player:setHp(value)
	self:setAttrValue(player_hp,math.floor(value))
end

function Player:getMaxHp()
	return self:getAttrValue(player_max_hp)
end

function Player:getMp()
	return self:getAttrValue(player_mp)
end

function Player:setMp(value)
	self:setAttrValue(player_mp,value)
end

function Player:getMaxMp()
	return self:getAttrValue(player_max_mp)
end
function Player:getVigor()
	return self:getAttrValue(player_vigor)
end

function Player:setVigor(value)
	self:setAttrValue(player_vigor, value)
end

function Player:getMaxVigor()
	return self:getAttrValue(player_max_vigor)
end

function Player:isInView(roleID)
	return self._peer:isInView(roleID) 
end

-- 玩家首次登陆初始化属�?
local function initFirstLoginAttr(self)
	if self:getHp() == 0 then
		self:setHp(self:getMaxHp())
	end
	if self:getHp() > self:getMaxHp() then
		self:setHp(self:getMaxHp())
	end
	if self:getMp() == 0 then
		self:setMp(self:getMaxMp())
	end
	if self:getMp() > self:getMaxMp() then
		self:setMp(self:getMaxMp())
	end
	-- 获取最大属性�?
	if self:getVigor() == 0 then
		self:setVigor(self:getMaxVigor())
	end
end

function Player:setLevel(level)
	self.level = level
	self:setAttrValue(player_lvl,level)
	initFirstLoginAttr(self)
	if level >= PacketLevelPackNeedLevel then
		-- 更新背包的等级包�?
		local packetHandler = self:getHandler(HandlerDef_Packet)
		packetHandler:updateLevelPack()
	end
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

	setPropValue(peer, UNIT_NAME,		self:getName())
	setPropValue(peer, UNIT_MODEL,		self:getModelID())
	setPropValue(peer, PLAYER_SEX,		self:getSex())
	setPropValue(peer, PLAYER_LEVEL,	self:getLevel())
	setPropValue(peer, PLAYER_SCHOOL,	self:getSchool())
	setPropValue(peer, PLAYER_MONEY,	self:getMoney())
	setPropValue(peer, PLAYER_SUBMONEY, self:getSubMoney())
	setPropValue(peer, PLAYER_DEPOTMONEY, self:getDepotMoney())
	setPropValue(peer, PLAYER_CASHMONEY, self:getCashMoney())
	setPropValue(peer, PLAYER_GOLDCOIN, self:getGoldCoin())
	self:freshProps()
end

function Player:loadBasicDataFromDB(recordList)
	local rs = recordList[1][1]
	self:initBasicValue(rs)

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

	-- 加载玩家属性集�?
	local attributeRecord = recordList[2]
	self:createAttributeSet()
	self:loadAttrRecord(attributeRecord)

	-- 等级特殊处理
	self:setLevel(rs.level)

	-- 同步属性到peer
	self:updatePropSet()
end

-- 加载玩家属性集�?
function Player:loadAttrRecord(attrRecord)
	if not attrRecord then
		print("[Player:loadAttrRecord] 属性集合记录为�?")
		return
	end

	local attrSet = self.attrSet
	for index,detail in pairs(attrRecord) do
		local attribute = attrSet[detail.attrType]
		if attribute and not attribute:isExpr() then
			attribute:loadValue(detail.attrValue)
		else
			print(("[Player:loadAttrRecord] 错误的玩家属性定�? %s"):format(attribute and attribute:getName() or "nil"))
		end
	end
	--toDo:add default attribute value handle
end

-- 创建玩家属性集�?
function Player:createAttributeSet()
	local attrSet = self.attrSet
	for attrName,detail in pairs(PlayerAttrDefine) do
		if not attrSet[attrName] then
			attrSet[attrName] = PlayerAttribute(self,attrName,detail.expr,0)
		end
	end
end

-- 获取某一项属�?
function Player:getAttribute(attrName)
	return attrName and self.attrSet[attrName]
end

-- 获得属性集�?
function Player:getAttrSet()
	return self.attrSet
end

-- 设置属性�?
function Player:setAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:setAttrValue] 没有属性e %s!"):format(attrName or "nil"))
		return
	end
	if attribute:isExpr() then
		print(("[Player:setAttrValue] 不能设置给公式属�? %s!"):format(attribute:getName()))
		return
	end
	attribute:setValue(value)
end

-- 获得某项属性的�?
function Player:getAttrValue(attrName)
	local attribute = attrName and self.attrSet[attrName]
	if attribute then
		return attribute:getValue()
	else
		print(("[Player:getAttrValue()] 没有属�? %s!"):format(attrName or "nil"))
		return nil
	end
end

-- 给某项属性加�?
function Player:addAttrValue(attrName,value)
	local attribute = attrName and self.attrSet[attrName]
	if not attribute then
		print(("[Player:addAttrValue] 没有%s这项属�?!"):format(attrName or "nil"))
	end
	if attribute:isExpr() then
		print(("[Player:addAttrValue] 不能给公式属�?%s设�?"):format(attribute:getName()))
	end
	attribute:setValue(attribute:getValue() + value)
end

-- 确保所有需要同步的属性都是最新的
function Player:freshProps()
	local attrSet = self.attrSet
	for attrName,_ in pairs(g_AttributePlayerToProp) do
		attrSet[attrName]:getValue()
	end
end

-- 发送所有的属性变�?
function Player:flushPropBatch()
	self:freshProps()
	flushPropBatch(self:getPeer())
end

function Player:onPlayerLogout(reason)
	--store the status and position
	local tick
	tick = getLuaTick()
	self:updatePlayerAttr()
	print(1,getLuaTick()-tick)
	local mapID, xPos, yPos = self:getCurPos()
	if mapID >= EctypeMap_StartID then
		-- 在副本中下线，找到进入点坐标
		local ectypeHandler = self:getHandler(HandlerDef_Ectype)
		local enterPos = ectypeHandler:getEnterPos()
		mapID = enterPos.mapID
		xPos = enterPos.xPos
		yPos = enterPos.yPos
	end
	tick = getLuaTick()
	self:updateProperty("MapID",mapID)
	print(2,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("PosX",xPos)
	print(3,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("PosY",yPos)
	print(4,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("Level",self:getLevel())
	print(5,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("ModelID",self:getModelID())
	print(6,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("Money",self:getMoney())
	print(7,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("SubMoney",self:getSubMoney())
	print(8,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("DepotMoney",self:getDepotMoney())
	print(9,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("DepotCapacity",self:getDepotCapacity())
	print(10,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("CashMoney",self:getCashMoney())
	print(11,getLuaTick()-tick)

	tick = getLuaTick()
	self:updateProperty("ShowParts",self:getShowParts())
	print(12,getLuaTick()-tick)
	--self:updateProperty("RideBar",self:getHandler(HandlerDef_Ride):getRideCapacity())
end

-- 提交玩家属性集�?
function Player:updatePlayerAttr()
	LuaDBAccess.onPlayerAttrUpdate(self)
end

-- 提交玩家基础�?
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
		return
	end
	if attrName == player_max_mp then
		return
	end
end

function Player:initBasicValue(rs)
	if rs.mapID<1 then
		local defPlrInfo = SchoolPlayerDB[rs.school]
		if defPlrInfo then
			rs.mapID = defPlrInfo.defaultMapID
			rs.posX = defPlrInfo.defaultPosX
			rs.posY = defPlrInfo.defaultPosY
		end
	end
end
