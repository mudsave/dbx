--[[FightMonster.lua
描述：
	战斗怪物实体
--]]

FightMonster = class(FightEntity)

function FightMonster:__init()
	--self._pos = {nil,nil,nil} --在entity中有,含义:地图ID,FightStand.A or FightStand.B,编号
	self._fightID = nil
	self._commonSkill = nil --普通攻击
	self._id = FightEntityMaxID
	FightEntityMaxID = FightEntityMaxID + 1
	self.attrSet = {}
	self.dirtySet = {}
	self._protectors = {}
	self._protectee = nil
	self._attributeFormat = nil
	self._attrDefine = nil
	self._influenceTable = nil
	self._syncTable = nil
	self._bDefense = false
	self._isGBH = false
	self._isToGBH = false
	self:_init_fight_attr()
	
end

function FightMonster:_init_fight_attr()
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

function FightMonster:__release()
	self._protectors = nil
	self._protectee = nil
	self.attrSet = nil
	self.dirtySet = nil
end

function FightMonster:get_fight_side()
	return self:getPos()[2]
end

function FightMonster:getID()
	return self._id
end

function FightMonster:setModelID(id)
	self._model_id = id
end

function FightMonster:setDBID(id)
	self._dbid = id
end

function FightMonster:getDBID()
	return self._dbid
end

function FightMonster:getLevel()
	return self:getAttrValue(monster_lvl)
end

function FightMonster:get_phase_type()
	local DBID = self:getDBID()
	local rec = (MonsterDB[DBID] or NpcDB[DBID])
	return rec.phaseType
end

function FightMonster:loadAttrs(playerLvl)
    local dbID = self:getDBID()
	local monster = MonsterDB[dbID] or NpcDB[dbID]
	if monster then
		self:setName( monster.name )
		self:setModelID( monster.modelID )
		local monAttr = AttributeList[monster.attrID]
		if monAttr then
			-- 设置基本属性
			local level = monster.level
			if level == -1 then
				level = playerLvl
			end

			local hpCoeff = MonsterLvlAttrDB[level].maxHP
			local maxHp = monAttr.maxHP * hpCoeff
			self:setAttrValue(monster_add_max_hp, maxHp)

			local atCoeff = MonsterLvlAttrDB[level].at
			local at = monAttr.at * atCoeff
			self:setAttrValue(monster_add_at, at)

			local mtCoeff = MonsterLvlAttrDB[level].mt
			local mt = monAttr.mt * mtCoeff
			self:setAttrValue(monster_add_mt, mt)

			local afCoeff = MonsterLvlAttrDB[level].af
			local af = monAttr.af * afCoeff
			self:setAttrValue(monster_add_af, af)

			local mfCoeff = MonsterLvlAttrDB[level].mf
			local mf = monAttr.mf * mfCoeff
			self:setAttrValue(monster_add_mf, mf)

			local hitCoeff = MonsterLvlAttrDB[level].hit
			local hit = monAttr.hit * hitCoeff
			self:setAttrValue(monster_add_hit, hit)

			local dodgeCoeff = MonsterLvlAttrDB[level].dodge
			local dodge = monAttr.dodge * dodgeCoeff
			self:setAttrValue(monster_add_dodge, dodge)

			local critCoeff = MonsterLvlAttrDB[level].crit
			local crit = monAttr.crit * critCoeff
			self:setAttrValue(monster_add_critical, crit)

			local uncritCoeff = MonsterLvlAttrDB[level].uncrit
			local uncrit = monAttr.uncrit * uncritCoeff
			self:setAttrValue(monster_add_tenacity, uncrit)

			local speedCoeff = MonsterLvlAttrDB[level].speed
			local speed = monAttr.speed * speedCoeff
			self:setAttrValue(monster_add_speed, speed)

			local taoCoeff = MonsterLvlAttrDB[level].tao
			local tao = monAttr.tao * taoCoeff
			self:setAttrValue(monster_tao, tao)

			local phaseAtCoeff = MonsterLvlAttrDB[level].phaseAt
			local phaseAt = monAttr.phaseAt * phaseAtCoeff
			self:setAttrValue(monster_add_phase_at, phaseAt)

			local phaseDfCoeff = MonsterLvlAttrDB[level].phaseDf
			local phaseDf = monAttr.phaseDf * phaseDfCoeff
			self:setAttrValue(monster_add_phase_resist, phaseDf)

			local obstacleHitCoeff = MonsterLvlAttrDB[level].obstacleHit
			local obstacleHit = monAttr.obstacleHit * obstacleHitCoeff
			self:setAttrValue(monster_add_obstacle_hit, obstacleHit)

			local obstacleDefenseCoeff = MonsterLvlAttrDB[level].obstacleDefense
			local obstacleDefense = monAttr.obstacleDefense * obstacleDefenseCoeff
			self:setAttrValue(monster_add_obstacle_resist, obstacleDefense)

			-- 计算怪物的属性增益
			local attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit1]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType1]
				local curValue = self:getAttrValue(attrType)
				self:setAttrValue(attrType, curValue + monAttr.attrEffVal1)
			end
			attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit2]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType2]
				local curValue = self:getAttrValue(attrType)
				self:setAttrValue(attrType, curValue + monAttr.attrEffVal2)
			end
			attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit3]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType3]
				local curValue = self:getAttrValue(attrType)
				self:setAttrValue(attrType, curValue + monAttr.attrEffVal3)
			end
			attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit4]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType4]
				local curValue = self:getAttrValue(attrType)
				self:setAttrValue(attrType, curValue + monAttr.attrEffVal4)
			end
		end
		-- 设置等级
		self:setAttrValue(monster_lvl, level)
	else
		print ("[error] MonsterDB don't have this monster!", self:getDBID())
	end

end

function FightMonster:loadAttrsOld()
    local dbID = self:getDBID()
	local monster = MonsterDB[dbID] or NpcDB[dbID]
	if monster then
		self:setName( monster.name )
		self:setModelID( monster.modelID )
		local monAttr = AttributeList[monster.attrID]
		if monAttr then
			-- 设置属性系数
			self:setAttrValue(monster_tao_coffi, monAttr.inTaoCoeffi)
			self:setAttrValue(monster_str_coffi, monAttr.inStrCoeffi)
			self:setAttrValue(monster_int_coffi, monAttr.inIntCoeffi)
			self:setAttrValue(monster_sta_coffi, monAttr.inStaCoeffi)
			self:setAttrValue(monster_spi_coffi, monAttr.inSpiCoeffi)
			self:setAttrValue(monster_dex_coffi, monAttr.inDexCoeffi)
			-- 计算怪物的属性增益
			local attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit1]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType1]
				self:setAttrValue(attrType, monAttr.attrEffVal1)
			end
			attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit2]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType2]
				self:setAttrValue(attrType, monAttr.attrEffVal2)
			end
			attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit3]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType3]
				self:setAttrValue(attrType, monAttr.attrEffVal3)
			end
			attrBefinit = g_AttrMonsterAttrBefinitTable[monAttr.attrBenefit4]
			if attrBefinit then
				local attrType = attrBefinit[monAttr.attrAddType4]
				self:setAttrValue(attrType, monAttr.attrEffVal4)
			end
		end
		-- 设置等级
		self:setAttrValue(monster_lvl, monster.level)
	else
		print ("[error] MonsterDB don't have this monster!", self:getDBID())
	end

end

function FightMonster:setAttrDefine(attrDefine)
	self._attrDefine = attrDefine
end

function FightMonster:setAttributeFormat(attributeFormat)
	self._attributeFormat = attributeFormat
end

function FightMonster:setAttrInfluenceTable(influenceTable)
	self._influenceTable = influenceTable
end

function FightMonster:setAttrSyncTable(syncTable)
	self._syncTable = syncTable
end

function FightMonster:setCommonSkill(skill)
	self._commonSkill = skill
end

function FightMonster:getCommonSkill()
	return self._commonSkill
end

function FightMonster:setName(name)
	self._name = name
end

function FightMonster:getName()
	return self._name
end

function FightMonster:setModelID(id)
	self._model_id = id
end

function FightMonster:getModelID()
	return self._model_id
end

--创建怪物属性集
function FightMonster:createAttributeSet()
	for attrType, v in pairs(self._attrDefine or table.empty) do
		self.attrSet[attrType] = 0
		self.dirtySet[attrType] = true
	end
end

function FightMonster:setAttrValue(attrType, value)
	if self._attrDefine[attrType] == nil then
		return
	end
	if self._attrDefine[attrType].expr then
		print("公式属性不能直接设值。。")
		return
	else
		self.attrSet[attrType] = value
		self:notifyInfluenceChanged(attrType)
	end
end

function FightMonster:getAttrValue(attrType)
	if not attrType then
		print (debug.traceback())
	end
	if self._attrDefine[attrType].expr then
		if self.dirtySet[attrType] == true then
			--dirty 为true则公式计算
			self.dirtySet[attrType] = false
			local tmp = self._attributeFormat[attrType](self)
			self.attrSet[attrType] = tmp
			return tmp or 0
		else
			return self.attrSet[attrType] or 0
		end
	else
		--非公式属性直接返回值
		return self.attrSet[attrType] or 0
	end
end

--通知属性影响的属性改变并计算
function FightMonster:notifyInfluenceChanged(attrType)
	local attrInfluenceTable = self._influenceTable[attrType]
	if not attrInfluenceTable then
		return 
	end
	for _,v in pairs (attrInfluenceTable) do
		if not self._syncTable[v] then
			self.dirtySet[v] = true
			self:notifyInfluenceChanged(v)
		else
			self.attrSet[v] = self._attributeFormat[v](self)
			self:notifyInfluenceChanged(v)
		end
	end
end

function FightMonster:setProtectors(p,isClear)
	if isClear then
		table.clear(self._protectors)
	else
		self._protectors[p:getID()] = true
	end
end

function FightMonster:clearProtector(p)
	
	self._protectors[p:getID()] = nil
end

function FightMonster:getProtectors()
	return self._protectors
end

function FightMonster:setProtectee(p)
	self._protectee = p
end

function FightMonster:getProtectee()
	return self._protectee
end

function FightMonster:getIsDefense()
	return self._bDefense
end

function FightMonster:setIsDefense(bOk)
	self._bDefense = bOk
end

function FightMonster:getOffline()
	return false
end

function FightMonster:getIsGBH()
	return self._isGBH
end

function FightMonster:setIsGBH(isOk)
	self._isGBH = isOk
end

function FightMonster:getIsToGBH()
	return self._isToGBH
end

function FightMonster:setIsToGBH(isOk)
	self._isToGBH = isOk
end
-- 道行衰减等级
function FightMonster:getTaoDecayLev()
	local decayLev = self:get_tao()/(self:get_standard_tao()*0.2) - 5
	if decayLev >= 1 then
		decayLev = math.floor(decayLev)
	else	
		decayLev = 0
	end
	return decayLev
end

-- 获取障碍命中的影响
function FightMonster:getBarrierEffect()
	return (self:get_tao()*(self:getTaoDecayLev() + 1) - 
	self:get_standard_tao()*self:getTaoDecayLev())*1
end


--**[[ 技能
function FightMonster:useSkill(skill_id, target, side)
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	print("怪物技能开始")
	local skill = handler.skills[skill_id]
	return skill:perform(target, side)
end

function FightMonster:canUseSkill(skill_id)
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	if not handler.skills[skill_id] then
		print ('ERROR: monster skill', skill_id, 'not exist!')
		return false
	end
	return handler.skills[skill_id]:canUseSkill()
end

function FightMonster:useRevivalSkill()
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	return handler:useRevival()
end
--**]]

--**[[设置属性
function FightMonster:setHp(value)
	local oldValue = self:getAttrValue(monster_hp)
	if oldValue > value then
		self._isInjured = true
		self._roundCountAfterInjured = 0
	end
	self:setAttrValue(monster_hp,math.floor(value))
	if value >= 0 then
		local fight = g_fightMgr:getFight(self._fightID)
		local fightType = fight:getType()
		if fightType == FightType.Script then
			local maxHp = self:getMaxHp()
			fight:onAttrChanged(self,"hp",value/maxHp)
		end
	end
end

--**]]
function FightMonster:getHp()
	return self:getAttrValue(monster_hp)
end
function FightMonster:getMaxHp()
	return self:getAttrValue(monster_max_hp)
end
function FightMonster:getMaxMp()
	--怪物没有法力值
	return 0
end
function FightMonster:getMp()
	--怪物没有法力值
	return 0
end
function FightMonster:getHit()
	return self:getAttrValue(monster_hit)
end
function FightMonster:get_speed()
	return self:getAttrValue(monster_speed)
end
function FightMonster:getDodge()
	return self:getAttrValue(monster_dodge)
end
function FightMonster:getCritical()
	return self:getAttrValue(monster_critical)
end
function FightMonster:getInc_critical()
	return self:getAttrValue(monster_inc_critical)
end
function FightMonster:getTenacity()
	return self:getAttrValue(monster_tenacity)
end
function FightMonster:getCounter()
	return self:getAttrValue(monster_counter)
end
function FightMonster:get_counter_dmg_add()
	return self:getAttrValue(monster_inc_critical_effect)
end
function FightMonster:getInc_Counter()
	return self:getAttrValue(monster_inc_counter)
end
function FightMonster:getUnhit()
	return self:getAttrValue(monster_unhit_rate)
end
function FightMonster:getAdd_Unhit()
	return self:getAttrValue(monster_add_unhit_rate)
end
function FightMonster:setAdd_Unhit(value)
	return self:setAttrValue(monster_add_unhit_rate,value)
end
function FightMonster:getAt()
	return self:getAttrValue(monster_at)
end
function FightMonster:getAf()
	return self:getAttrValue(monster_af)
end
function FightMonster:getTao()
	return self:getAttrValue(monster_tao)
end
function FightMonster:get_str()
	return self:getAttrValue(monster_str)
end
function FightMonster:get_int()
	return self:getAttrValue(monster_int)
end
function FightMonster:get_sta()
	return self:getAttrValue(monster_sta)
end
function FightMonster:get_spi()
	return self:getAttrValue(monster_spi)
end
function FightMonster:get_dex()
	return self:getAttrValue(monster_dex)
end
function FightMonster:get_inc_critical_effect()
	return self:getAttrValue(monster_inc_critical_effect)
end
function FightMonster:get_mt()
	return self:getAttrValue(monster_mt)
end
function FightMonster:get_mf()
	return self:getAttrValue(monster_mf)
end
function FightMonster:get_phase(type)
	if type == 1 then
		return self:getAttrValue(monster_soi_at)
	end
	if type == 2 then
		return self:getAttrValue(monster_ice_at)
	end
	if type == 3 then
		return self:getAttrValue(monster_fir_at)
	end
	if type == 4 then
		return self:getAttrValue(monster_poi_at)
	end
	if type == 5 then
		return self:getAttrValue(monster_thu_at)
	end
	if type == 6 then
		return self:getAttrValue(monster_win_at)
	end
end
function FightMonster:get_phase_resist(type)
	if type == 1 then
		return self:getAttrValue(monster_soi_resist)
	end
	if type == 2 then
		return self:getAttrValue(monster_ice_resist)
	end
	if type == 3 then
		return self:getAttrValue(monster_fir_resist)
	end
	if type == 4 then
		return self:getAttrValue(monster_poi_resist)
	end
	if type == 5 then
		return self:getAttrValue(monster_thu_resist)
	end
	if type == 6 then
		return self:getAttrValue(monster_win_resist)
	end
end
function FightMonster:get_obstacle_hit()
	return self:getAttrValue(monster_add_obstacle_hit)
end
function FightMonster:get_taunt_resist()
	return self:getAttrValue(monster_add_taunt_resist)
end
function FightMonster:get_sopor_resist()
	return self:getAttrValue(monster_add_sopor_resist)
end
function FightMonster:get_chaos_resist()
	return self:getAttrValue(monster_add_chaos_resist)
end
function FightMonster:get_freeze_resist()
	return self:getAttrValue(monster_add_freeze_resist)
end
function FightMonster:get_silent_resist()
	return self:getAttrValue(monster_add_silent_resist)
end
function FightMonster:get_poison_resist()
	return self:getAttrValue(monster_add_toxicosis_resist)
end
function FightMonster:get_add_obstacle_resist()
	return self:getAttrValue(monster_add_obstacle_resist)
end
function FightMonster:get_tao()
	return self:getAttrValue(monster_tao)
end
function FightMonster:get_standard_tao()
	return self:getAttrValue(monster_stand_tao)
end
--**]]


