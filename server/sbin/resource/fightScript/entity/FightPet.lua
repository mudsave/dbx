--[[FightPet.lua
描述：
	战斗宠物实体
--]]
--require "entity.attribute.PetAttrDefine"
--require "entity.attribute.PetAttrFormula"
FightPet  = class(FightEntity)

function FightPet:__init()
	--self._pos = {nil,nil,nil} --在entity中有,含义:地图ID,FightStand.A or FightStand.B,编号
	self._fightID = nil
	self._id = FightEntityMaxID
	FightEntityMaxID = FightEntityMaxID + 1
	self._commonSkill = nil --普通攻击技能
	self._protectors = {}
	self._protectee = nil
	self._ownerID = nil
	self._bDefense = false
	self._bChoosed = false --是否选过动作
	self._bOffline = false

	self._dbID = nil
	self._name = nil
	self._level = nil
	self._modelID = nil
	self._showParts = nil
	self._attrSet = {}	--所有属性集
	self._dirtyAttrType = {} --需要重新计算的公式属性
	self._changedAttrType = {}--改变的基本属性

	self._worldPetID = nil --宠物在世界服的运行时ID
	self._life = nil --寿命
	self._loyalty = nil --忠诚度
	self._status = nil
	self._isEscaped = nil
	self._counterFightRatio = nil
	self._xp = nil
	self:_init_fight_attr()
	self._bAlready = nil --是否上过场
	self._bNewAdded = false--战斗中新加的
end

function FightPet:__release()
	self._protectors = nil
	self._protectee = nil
	self._owner = nil
	self._attrSet = nil
	self._dirtyAttrType = nil
	self._changedAttrType = nil
	self._attrSet = nil
	self._dirtyAttrType = nil
	self._changedAttrType = nil
	self._counterFightRatio = nil
	self._xp = nil
	self._bAlready = nil
end

function FightPet:getAttributeSet()
	return self._attrSet
end

function FightPet:isChanged(attrType)
	return self._changedAttrType[attrType]
end

function FightPet:get_fight_side()
	return self:getPos()[2]
end

function FightPet:setDBID(dbID)
	self._dbID = dbID
end

function FightPet:getDBID()
	return self._dbID
end

function FightPet:setName(name)
	self._name = name
end

function FightPet:getName()
	return self._name
end

function FightPet:setShowParts(value)
	self._showParts = value
end

function FightPet:getShowParts()
	return self._showParts
end

function FightPet:setModelID(modelID)
	self._modelID = modelID
end

function FightPet:getModelID()
	return self._modelID
end

function FightPet:getOwnerID()
	return self._ownerID
end

function FightPet:setOwnerID( ownerID)
	self._ownerID = ownerID
end

function FightPet:setChoosed(bOk)
	self._bChoosed = bOk
end

function FightPet:getChoosed()
	return self._bChoosed 
end

function FightPet:setOffline(bOk)
	--玩家离线清理宠物buff
	--g_fightBuffMgr:onFightEnd(self)
	self._bOffline = bOk
end

function FightPet:getOffline()
	return self._bOffline 
end

function FightPet:setLevel(level)
	self._level = level
	self:setAttrValue(pet_lvl,level)
end

function FightPet:getLevel()
	return self._level
end

function FightPet:getTao()
	return self:getAttrValue(pet_tao)
end

function FightPet:getUnhit()
	return self:getAttrValue(pet_unhit_rate)
end

function FightPet:setWorldPetID(ID)
	self._worldPetID = ID
end

function FightPet:getWorldPetID()
	return self._worldPetID
end

function FightPet:getLife()
	return self._life
end

function FightPet:setLife(value)
	self._life = value
end

function FightPet:getLoyalty()
	return self._loyalty
end

function FightPet:setLoyalty(value)
	self._loyalty = value
end

function FightPet:getStatus()
	return self._status
end

function FightPet:setStatus(s)
	self._status = s
end

function FightPet:getIsEscaped()
	return self._isEscaped
end

function FightPet:setIsEscaped(bValue)
	self._isEscaped = bValue
end

function FightPet:get_phase_type()
	return PetDB[self._dbID].phaseType
end

function FightPet:setCommonSkill(skill)
	self._commonSkill = skill
end

function FightPet:getCommonSkill()
	return self._commonSkill
end 

function FightPet:setLifeState(s)
	self._fightLifeState = s
end
function FightPet:setCounterHitRatio(v)
	self._counterFightRatio  = v
end

function FightPet:getCounterHitRatio()
	return self._counterFightRatio  
end

function FightPet:setXp(value)
	self._xp = value
end

function FightPet:getXp()
	return self._xp
end

function FightPet:setAlready(isOk)
	self._bAlready = isOk
end

function FightPet:getAlready()
	return self._bAlready
end

function FightPet:getIsNew()
	return self._bNewAdded
end

function FightPet:setIsNew(value)
	self._bNewAdded = value
end

--属性同步:什么都不做
function FightPet:onAttributeToProp(attrType,newValue)
	
end

function FightPet:setAttrValue(attrType,value,isLoad)
	if PetAttrDefine[attrType].expr == true then
		print("公式属性不能直接设值。。。",attrType,value)
		return
	end
	if self._attrSet[attrType] ~= value then
		self._attrSet[attrType] = value
		if (not isLoad) and (not self._changedAttrType[attrType]) then
			self._changedAttrType[attrType] = true
		end
		
		self:notifyInfluenceChanged(attrType,isLoad)
	end
	
end

function FightPet:getAttrValue(attrType)
	if not PetAttrDefine[attrType] then
		print("getAttrValue error!",attrType)
		--print(debug.traceback())
	end
	if not PetAttrDefine[attrType].expr  then
		return self._attrSet[attrType]
	else
		if self._dirtyAttrType[attrType] then
			local value = g_AttributePetFormat[attrType](self)
			self._attrSet[attrType] = value
			self._dirtyAttrType[attrType] = nil
			return value
		else
			return self._attrSet[attrType]
		end
	end
	
end

--创建玩家属性集
function FightPet:createAttributeSet()
	for attrType, v in pairs(PetAttrDefine or table.empty) do
		if PetAttrDefine[attrType].expr == true then
			self._dirtyAttrType[attrType] = true
		else
			self._attrSet[attrType] = 0
		end
	end
end

--通知属性影响的属性改变并计算
function FightPet:notifyInfluenceChanged(attrType,isLoad)
	local attrInfluenceTable = g_AttrPetInfluenceTable[attrType]
	if not attrInfluenceTable then
		return 
	end
	for _,exprAttrType in pairs (attrInfluenceTable) do
		if (not isLoad) and PetAttrDefine[exprAttrType].expr then
			if not g_AttrPetSyncTable[exprAttrType] then
				self._dirtyAttrType[exprAttrType] = true
			else
				local value = g_AttributePetFormat[exprAttrType](self)
				self._attrSet[exprAttrType] = value
				self:notifyInfluenceChanged(exprAttrType,isLoad)
			end
		end
	end
end

function FightPet:loadAttrs(attrs)
	for attrType, v in pairs(attrs ) do
		if PetAttrDefine[attrType] then
			self:setAttrValue(attrType,v,true)
		end
	end
end

function FightPet:setProtectors(p,isClear)
	if isClear then
		table.clear(self._protectors)
	else
		self._protectors[p:getID()] = true
	end
end

function FightPet:clearProtector(p)
	
	self._protectors[p:getID()] = nil
end

function FightPet:getProtectors()
	return self._protectors
end

function FightPet:setProtectee(p)
	self._protectee = p
end

function FightPet:getProtectee()
	return self._protectee
end

function FightPet:getIsDefense()
	return self._bDefense
end

function FightPet:setIsDefense(bOk)
	self._bDefense = bOk
end

--**[[ 属性获得

function FightPet:get_in_str()
	return self._in_str or 1
end
function FightPet:get_in_sta()
	return self._in_sta or 1
end
function FightPet:get_in_spi()
	return self._in_spi or 1
end
function FightPet:get_in_dex()
	return self._in_dex or 1 
end
function FightPet:get_in_int()
	return self._in_int or 1
end

function FightPet:set_in_str(value)
	self._in_str = value
end
function FightPet:set_in_sta(value)
	self._in_sta = value
end
function FightPet:set_in_spi(value)
	self._in_spi = value
end
function FightPet:set_in_dex(value)
	self._in_dex = value 
end
function FightPet:set_in_int(value)
	self._in_int = value
end

function FightPet:get_mt()
	return self:getAttrValue(pet_mt)
end
function FightPet:get_mf()
	return self:getAttrValue(pet_mf)
end
function FightPet:get_max_anger()
	return MaxAngerValue 
end
function FightPet:get_speed()
	return self:getAttrValue(pet_speed)
end

function FightPet:get_str()
	return self:getAttrValue(pet_str)
end
function FightPet:get_int()
	return self:getAttrValue(pet_int)
end
function FightPet:get_sta()
	return self:getAttrValue(pet_sta)
end
function FightPet:get_spi()
	return self:getAttrValue(pet_spi)
end
function FightPet:get_dex()
	return self:getAttrValue(pet_dex)
end
function FightPet:get_vigor()
	return self:getAttrValue(pet_vigor)
end
function FightPet:get_anger()
	return self:getAttrValue(pet_anger)
end
function FightPet:getMaxHp()
	return self:getAttrValue(pet_max_hp)
end
function FightPet:getHp()
	return self:getAttrValue(pet_hp)
end
function FightPet:getHit()
	return self:getAttrValue(pet_hit)
end
function FightPet:getDodge()
	--Mofidied by cm:remove rate attr,changed to integer value
	return self:getAttrValue(pet_dodge)
end
function FightPet:getCritical()
	return self:getAttrValue(pet_critical)
end
function FightPet:getTenacity()
	return self:getAttrValue(pet_tenacity)
end
function FightPet:getInc_critical()
	return self:getAttrValue(pet_inc_critical)
end
function FightPet:get_counter_dmg_add()
	return self:getAttrValue(pet_inc_critical_effect)
end
function FightPet:getCounter()
	return self:getAttrValue(pet_counter)
end
function FightPet:getInc_Counter()
	return self:getAttrValue(pet_inc_counter)
end
function FightPet:getAt()
	return self:getAttrValue(pet_at)
end
function FightPet:getAf()
	return self:getAttrValue(pet_af)
end
function FightPet:getMaxMp()
	return self:getAttrValue(pet_max_mp)
end
function FightPet:getMp()
	return self:getAttrValue(pet_mp)
end
function FightPet:get_inc_critical_effect()
	return self:getAttrValue(pet_critical_effect)
end

function FightPet:get_phase(type)
	if type == PhaseType.Soil then
		return self:getAttrValue(pet_soi_at)
	end
	if type == PhaseType.Ice then
		return self:getAttrValue(pet_ice_at)
	end
	if type == PhaseType.Fire then
		return self:getAttrValue(pet_fir_at)
	end
	if type == PhaseType.Poison then
		return self:getAttrValue(pet_poi_at)
	end
	if type == PhaseType.Thunder then
		return self:getAttrValue(pet_thu_at)
	end
	if type == PhaseType.Wind then
		return self:getAttrValue(pet_win_at)
	end
end

function FightPet:get_phase_resist(type)
	if type == PhaseType.Soil then
		return self:getAttrValue(pet_soi_resist)
	end
	if type == PhaseType.Ice then
		return self:getAttrValue(pet_ice_resist)
	end
	if type == PhaseType.Fire then
		return self:getAttrValue(pet_fir_resist)
	end
	if type == PhaseType.Poison then
		return self:getAttrValue(pet_poi_resist)
	end
	if type == PhaseType.Thunder then
		return self:getAttrValue(pet_thu_resist)
	end
	if type == PhaseType.Wind then
		return self:getAttrValue(pet_win_resist)
	end
end

function FightPet:get_obstacle_hit()
	return self:getAttrValue(pet_obstacle_hit)
end
function FightPet:get_taunt_resist()
	return self:getAttrValue(pet_taunt_resist)
end
function FightPet:get_sopor_resist()
	return self:getAttrValue(pet_sopor_resist)
end
function FightPet:get_chaos_resist()
	return self:getAttrValue(pet_chaos_resist)
end
function FightPet:get_freeze_resist()
	return self:getAttrValue(pet_freeze_resist)
end
function FightPet:get_silent_resist()
	return self:getAttrValue(pet_silent_resist)
end
function FightPet:get_poison_resist()
	return self:getAttrValue(pet_toxicosis_resist)
end
function FightPet:get_add_obstacle_resist()
	return self:getAttrValue(pet_add_obstacle_resist)
end

function FightPet:get_tao()
	return self:getAttrValue(pet_tao)
end
function FightPet:get_standard_tao()
	return self:getAttrValue(pet_stand_tao)
end

function FightPet:setHp(value)
	self:setAttrValue(pet_hp,math.floor(value))
end
function FightPet:setMp(value)
	self:setAttrValue(pet_mp, value)
end
function FightPet:inc_mp(value)
	local mp = self:getMp()
	local max_mp = self:getMaxMp()
	local mp_t = mp
	mp = mp + value
	mp = mp > max_mp and max_mp or mp
	mp = mp < 0 and 0 or mp
	if mp_t ~= mp then
		self:setMp(mp)
	end
end
function FightPet:inc_hp(value)
	local hp = self:getHp()
	local max_hp = self:getMaxHp()
	local hp_t = hp
	hp = hp + value
	hp = hp > max_hp and max_hp or hp
	hp = hp < 0 and 0 or hp
	if hp_t ~= hp then
		self:setHp(hp)
	end
end

-- 道行衰减等级
function FightPet:getTaoDecayLev()
	local decayLev = self:get_tao()/(self:get_standard_tao()*0.2) - 5
	if decayLev >= 1 then
		decayLev = math.floor(decayLev)
	else	
		decayLev = 0
	end
	return decayLev
end

-- 获取障碍命中的影响
function FightPet:getBarrierEffect()
	return (self:get_tao()*(self:getTaoDecayLev() + 1) - 
	self:get_standard_tao()*self:getTaoDecayLev())*1
end

--**]]


function FightPet:_init_fight_attr()
	self._at = 0
	self._mt = 0
	self._af = 0
	self._mf = 0
	self._hit = 0
	self._dodge = 0
	self._critical = 0
	self._tenacity = 0
	self._speed = 0
	self._wind_at = 0
	self._thunder_at = 0
	self._ice_at = 0
	self._fire_at = 0
	self._soil_at = 0
	self._poison_at = 0
	self._wind_resist = 0
	self._thunder_resist = 0
	self._ice_resist = 0
	self._fire_resist = 0
	self._soil_resist = 0
	self._poison_resist = 0
	self._all_at = 0
	self._all_mt = 0
	self._all_af = 0
	self._all_mf = 0
end

--**[[ 技能相关

function FightPet:useSkill(skill_id, position)
	local fightID = self:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local target = fight:getRole(position)
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	Flog:log("宠物技能开始".." role:"..self:getID().." skill:"..skill_id.."\n")
	print("宠物技能开始")
	if not handler.skills[skill_id] then
		print("没有这个技能 技能ID:", skill_id)
	end
	-- local rt1, rt2 , targets = handler.skills[skill_id]:perform( target )
	-- Flog:log("宠物技能结束\n")
	return handler.skills[skill_id]:perform( target )
end

function FightPet:canUseSkill(skill_id)
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	if not handler.skills[skill_id] then
		print ('ERROR: pet skill', skill_id, 'not exist!')
		return false
	end
	local state = handler.skills[skill_id]:canUseSkill()
	return state
end

function FightPet:useRevivalSkill()
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	return handler:useRevival()
end
--**]]


function FightPet:setSkills(skills)
	self._skills = skills
end
function FightPet:getSkills()
	return self._skills
end

