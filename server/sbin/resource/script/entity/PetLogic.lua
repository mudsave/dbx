-- PetLogic.lua

local function notice(str,...) print( ("PetLogic:%s"):format( str and str:format(...) or "" ) ) end
local function toDo(str,...) print( ("toDo:PetLogic:%s"):format( str and str:format(...) or "" ) ) end

local os_time = os.time 
local math_min = math.min
local math_random = math.random

function Pet:__logic_init()
	self._level			= 1
	self._status		= PetStatus.Rest
	self._pkInfo ={}
end

function Pet:__logic_release()
	self._pkInfo = nil
end

-- 由配置ID初始化
function Pet:initByConfig(configID)
	local detail = configID and PetDB[configID]
	if not detail then
		if configID then
			notice("宠物 %s 没有配置信息",configID)
		end
		return false
	end
	
	self:setAttackType(detail.attackType)
	self:setPhaseType(detail.phaseType)
	self:setPetType(detail.petType)
	self:setModelID(detail.modelID)
	self:setName(detail.petName)
	
	local attrSet = self.attrSet
	-- 先天属性
	for attrName,configName in pairs(PetInbornAttrMap) do
		attrSet:setAttrValue(attrName,detail[configName])
	end

	-- 先天加值
	local initAttrs = detail.initAttrs
	if initAttrs then
		for attrName,value in pairs(initAttrs) do
			attrSet:setAttrValue(attrName,value)	
		end
	end

	return true
end

-- 由数据库记录初始化
function Pet:onLoad(attrRecord)
	if not attrRecord then
		notice "没有数据库记录来初始化这个宠物"
		return false
	end
	self.isnew = false

	self:setDBID(attrRecord.petID)
	self:setConfigID(attrRecord.configID)
	self:setName(attrRecord.petName)
	self:setModelID(attrRecord.modelID)
	self:setUpLevel(attrRecord.upLevel)
	self:setPetType(attrRecord.petType)
	self:setLoyalty(attrRecord.loyalty)
	self:setBirth(attrRecord.birthTime)
	self:setMoveSpeed(DefaultSpeed)

	self._level = attrRecord.level
	if attrRecord.status == PetStatus.Sale then
		attrRecord.status = PetStatus.Rest
	end
	self._status = attrRecord.status
	self.attrSet:updateAll( true )
end

-- 被创建
function Pet:onCreate(configID)
	self.isnew = true
	self:setConfigID(configID)
	self:setDBID(createGUID(Pet))
	self:setBirth(os_time())
	self.petStatus = PetStatus.Rest

	self:setLoyalty(MaxPetLoyalty)
	self:setUpLevel(0)
	self:setMoveSpeed(DefaultSpeed)

	self:resetGrowth(PetNormalRandom)

	self:setLevel(1)
	self.attrSet:updateAll( true )
	self:fill()
end

-- 加载属性集合
function Pet:loadAttrs(attrRecord)
	self:setLevel(self._level)
	self.attrSet:loadAttrRecord(attrRecord)
end

-- 等级提升处理
function Pet:onLevelUP(level)
	local curLevel = self:getLevel()
	local addLevel = level - curLevel

	if addLevel > 0 then
		self:addAttrPoint(5 * addLevel)
	end

	if level > 19 then
		self:addPhasePoint( math_min(addLevel,level - 19) )
	end

	self:setLevel(level)

	local handler = self:getHandler(HandlerDef_PetSkill)
	if handler then
		handler:handlePetLevelUP()
	end

	self:fill()	-- 回满血蓝

	self:flushPropBatch() -- 在宠物升级之后发送一次属性
end

-- 被添加后处理
function Pet:onAdded(player)
	if not player then
		player = g_entityMgr:getPlayerByID(self:getOwnerID())
	end
	if not player then
		notice("宠物%s没有绑定所有者",string.gbkToUtf8(self:getName()))
		return
	end
	self:setOwner(player)
	self:setPetStatus(self._status)
	self._status = PetStatus.Rest

	self:attachTo(player)
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(
			PetEvent_SC_PetJoined,self:getID(),self:getBirth()
		),player
	)

	self:getHandler(HandlerDef_PetSkill):sendFull(player)
	self:getHandler(HandlerDef_AutoPoint):sendToClient()
	if self:isNew() then
		LuaDBAccess.SavePet(self)
		LuaDBAccess.SavePet(self)
		TaskCallBack.onCatchPet(player:getID(), self:getConfigID())
	end
end

-- 被移除后处理
function Pet:onRemoved(player)
	self:setVisible(false)
	self:detachFrom(player)
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(PetEvent_SC_PetLeaved,self:getID()),player
	)
	notice("宠物%s被移除",self:getConfigID())
end

-- 状态改变后处理
function Pet:onStatusChanged(prev,status)	
	local owner = g_entityMgr:getPlayerByID(self.ownerID)
	local handler = owner and owner:getHandler(HandlerDef_Pet)
	if not handler then
		notice("宠物没有绑定玩家")
		return
	end
	if prev == PetStatus.Fight then
		handler:setFightPetID(false)
		self:setVisible(false)
	elseif prev == PetStatus.Ready then
		handler:setReadyPetID(false)
	end

	if status == PetStatus.Fight then
		handler:setFightPetID(self:getID())
		self:setVisible(true)
	elseif status == PetStatus.Ready then
		handler:setReadyPetID(self:getID())
	end
end

-- 保存
function Pet:onSave(param)
	if self:isNew() then
		param["spName"] 	= "sp_SaveNewPet"
		param["sort"] 		= "pid,rid,cid,birth"
		param["pid"] 		= self:getDBID()
		param["rid"] 		= self:getOwnerDBID()
		param["cid"] 		= self:getConfigID()
		param['birth']		= self:getBirth()

		self.isnew			= false
	else
		param['spName'] 	= "sp_UpdatePet"
		param['sort'] 		= "pid,rid,status,name,model,loyalty,level,uLevel,type"
		param['pid'] 		= self:getDBID()
		param['rid']		= self:getOwnerDBID()
		param['status'] 	= self:getPetStatus()
		param['name'] 		= self:getName()
		param['model'] 		= self:getModelID()
		param['loyalty']	= self:getLoyalty()
		param['level']		= self:getLevel()
		param['uLevel']		= self:getUpLevel()
		param['type']		= self:getPetType()
	end
	return true
end

-- 重置生长属性
function Pet:resetGrowth(random)
	local attrSet = self.attrSet
	local detail = PetDB[self:getConfigID()]
	for _,data in ipairs(PetGrowthAttrs) do
		local from,to	= unpack(detail[data[3]])
		local maxValue	= random(from,to)
		local curValue	= random(from,maxValue)

		attrSet:setAttrValue(data[1],curValue)
		attrSet:setAttrValue(data[2],maxValue)
	end

	local maxLife = random(unpack(detail["petLife"]))
	attrSet:setAttrValue(pet_life_max,maxLife)
	attrSet:setAttrValue(pet_life,maxLife)
end

-- 需要置零的宠物属性
local ResetZeroAttrs = {
	pet_str_point,pet_int_point,
	pet_sta_point,pet_spi_point,
	pet_dex_point,

	pet_attr_point,pet_phase_point,pet_xp,

	pet_fir_phase_point,pet_soi_phase_point,
	pet_win_phase_point,pet_poi_phase_point,
	pet_ice_phase_point,pet_thu_phase_point,

	pet_chaos_phase_point,pet_taunt_phase_point,
	pet_sopor_phase_point,pet_silent_phase_point,
	pet_freeze_phase_point,pet_toxicosis_phase_point,
}

-- 重置宠物的属性
function Pet:resetAttrs()
	local attrSet = self.attrSet
	for index,attrName in ipairs(ResetZeroAttrs) do
		attrSet:setAttrValue(attrName,0)
	end
	self:setUpLevel(0)
end

-- 宠物还童
function Pet:onReset()
	local config = PetDB[self:getConfigID()]
	if not config then
		notice("还童错误,没有这个宠物配置 %s",self:getConfigID() or "空配置ID")
		return
	end

	local ePetType = self:getPetType()
	if ePetType == PetType.Wild then
		local rejuvenateID = config.rejuvenateID
		config = PetDB[rejuvenateID]
		if not config then
			notice("还童错误,没有配置野生宠物%s的宝宝ID",self:getConfigID() or "空配置ID")
			return
		end

		self:setConfigID(rejuvenateID)
	elseif ePetType == PetType.Baby then
		if math_random(0,1000) <= PetVarientRate then
			local varientID = config.varientID
			if not varientID then
				notice("还童错误,没有配置宝宝宠物%s的变异ID",self:getConfigID() or "空配置ID")
			else
				self:setConfigID(varientID)
			end
		end
	end

	self:resetAttrs()
	self:setLoyalty(MaxPetLoyalty)
	self:resetGrowth(PetSpecialRandom)
	self:setLevel(1)

	local handler = self:getHandler(HandlerDef_PetSkill)
	handler:retrimBasic()
	handler:acquireRandom()

	self:fill()
end

-- 属性改变
function Pet:onAttrChanged(attrName,prev,value)
	if attrName == pet_max_hp then
		local hp = self:getHP() + value - prev
		if hp > value then hp = value
		elseif hp < 0 then hp = 0
		end
		self:setHP(hp)
		return
	end
	if attrName == pet_max_mp then
		local mp = self:getMP() + value - prev
		if mp > value then mp = value
		elseif mp < 0 then mp = 0
		end
		self:setMP(mp)
		return
	end
end

-- 战斗结束
function Pet:onWarEnded(attrs,notSyn)
	local attrSet = self.attrSet
	for attrType, attrValue in pairs(attrs) do
		if type(attrType) == "number" then
			attrSet:setAttrValue(attrType,attrValue)
		end
	end
	self:setPetLife(attrs.life)
	self:setLoyalty(attrs.loyalty)
	if not notSyn then
		self:flushPropBatch()
	end
end

-- 添加属性点
function Pet:addAttrPoint(value)
	self:addAttrValue(pet_attr_point,value)
	local handler = self:getHandler(HandlerDef_AutoPoint)
	if handler and handler:isAutoAttr() then
		handler:distibuteAttrPoints()
	end

	if not handler then
		print "没有自动加点管理"
	elseif not handler:isAutoAttr() then
		print "没有设定自动加点"
	end
end

-- 添加相性点
function Pet:addPhasePoint(value)
	self:addAttrValue(pet_phase_point,value)
	local handler = self:getHandler(HandlerDef_AutoPoint)
	if handler and handler:isAutoPhase() then
		-- 宠物似乎不能自动分配属性点
		handler:distibutePhasePoints()
	end
end

-- 设置宠物经验,同时处理宠物升级
function Pet:setXp(xp)
	self.tempAllXP = xp
	if self:canLevelUP() then
		self:handlePetLevelUP()
	else
		self:setAttrValue(pet_xp,xp)
	end
end

-- 获得宠物经验
function Pet:getXp()
	return self.tempAllXP or self:getAttrValue(pet_xp)
end

-- 宠物增加经验
function Pet:addXp(xp)
	self:setXp(xp + self:getXp())
end

-- 宠物能否升级
function Pet:canLevelUP()
	if self:getXp() >= self:getAttrValue(pet_next_xp) then
		local owner = g_entityMgr:getPlayerByID(self:getOwnerID())
		if owner then
			return self:getLevel() < owner:getLevel() + FightPetLevelParam,owner
		end
	end
	return false
end

-- 用于处理宠物升级的虚拟宠物
local FakePet = {}
local _level = 1

function FakePet:getAttrValue(attrName)
	if attrName == pet_lvl then
		return _level
	else
		notice "不可获取虚拟宠物的其他其他属性"
		return nil
	end
end

function FakePet:getLevel()
	return _level
end

function FakePet:setLevel(level)
	_level = level
end

function FakePet:addLevel(l)
	_level = _level + l
end

-- 处理宠物升级
function Pet:handlePetLevelUP()
	local can,owner = self:canLevelUP()
	if not can then return end

	local maxLevel = owner:getLevel() + FightPetLevelParam
	local allXP = self:getXp()
	FakePet:setLevel(self:getLevel())

	local next_xp = PetAttrbuteFormula.pet_next_xp(FakePet)
	while (allXP >= next_xp and FakePet:getLevel() < maxLevel) do
		allXP = allXP - next_xp
		FakePet:addLevel(1)
		next_xp = PetAttrbuteFormula.pet_next_xp(FakePet)
	end
	self:onLevelUP(FakePet:getLevel())
	self:setAttrValue(pet_xp,allXP)
	if self.tempAllXP then
		self.tempAllXP = false
	end
end

function Pet:getPkInfo()
	return self._pkInfo
end

-- 同时设定宠物的5项基础属性,供GM系统使用,暂时没有提供战斗服支持
function Pet:setAll(value)
	local attrSet = self.attrSet
	attrSet:setAttrValue(pet_add_str, value)
	attrSet:setAttrValue(pet_add_int, value)
	attrSet:setAttrValue(pet_add_sta, value)
	attrSet:setAttrValue(pet_add_spi, value)
	attrSet:setAttrValue(pet_add_dex, value)
end 

-- 固执的人总是很孤单
