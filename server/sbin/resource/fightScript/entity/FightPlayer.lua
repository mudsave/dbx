--[[FightPlayer.lua
描述：
	战斗玩家实体
--]]
--require "entity.attribute.PlayerAttrDefine"
--require "entity.attribute.PlayerAttrFormula"

FightPlayer = class(FightEntity)

function FightPlayer:__init()
	--self._pos = {nil,nil,nil} --在entity中有,含义:地图ID,FightStand.A or FightStand.B,编号
	self._gateLink = nil
	self._clientLink = nil
	self._fightID = nil
	self._id = FightEntityMaxID
	FightEntityMaxID = FightEntityMaxID + 1
	self._commonSkill = nil --普通攻击技能
	self._protectors = {}
	self._protectee = nil
	self._peerHandle = nil
	self._dbID = nil
	self._school = nil
	self._name = nil
	self._level = nil
	self._modelID = nil
	self._showParts = nil
	self._sex = nil
	self._attrSet = {}	--所有属性集
	self._dirtyAttrType = {} --需要重新计算的公式属性
	self._changedAttrType = {}--改变的基本属性
	self._petID = nil
	self._bDefense = false
	self._bChoosed = false --是否选过动作
	self._bOffline = false
	self._pack = nil
	self._bInTeam = nil
	self._bTeamHead = nil
	self._petList = {}
	self._pkInfo = nil
	self._bMustCatch = nil --捕获宠物是否一定成功
	self:_init_fight_attr()
	self._weaponID = nil
	self._teamMemberIDList=nil --队伍成员DBID列表(按次序)只有队长有这个数据
	self._remouldLevel = nil --装备改造等级

end

function FightPlayer:_init_fight_attr()
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
	self._add_escape_rate = 0
	self._add_catchpet_rate = 0
	self._reduce_escape_rate = 0
	self._remouldLevel = nil
end

function FightPlayer:getGateID()
	return self._gateLink
end

function FightPlayer:setGateID(id)
	self._gateLink = id
end

function FightPlayer:getClientLink()
	return self._clientLink
end

function FightPlayer:setClientLink(link)
	self._clientLink = link
end

function FightPlayer:get_fight_side()
	return self:getPos()[2]
end

function FightPlayer:setDBID(dbID)
	self._dbID = dbID
end

function FightPlayer:getDBID()
	return self._dbID
end

function FightPlayer:setPeerHandle(h)
	self._peerHandle = h
end

function FightPlayer:getPeerHandle()
	return self._peerHandle
end

function FightPlayer:setName(name)
	self._name = name
end

function FightPlayer:getName()
	return self._name
end

function FightPlayer:setModelID(modelID)
	self._modelID = modelID
end

function FightPlayer:getModelID()
	return self._modelID
end

function FightPlayer:setSex(sex)
	self._sex = sex
end

function FightPlayer:getSex()
	return self._sex
end

function FightPlayer:setLevel(level)
	self._level = level
	self:setAttrValue(player_lvl,level)
end

function FightPlayer:getLevel()
	return self._level or self:getAttrValue(player_lvl)
end

function FightPlayer:setSchool(school)
	self._school = school
end

function FightPlayer:getSchool()
	return self._school
end

function FightPlayer:get_phase_type()
	return SchoolPhase[self._school]
end

function FightPlayer:setShowParts(parts)
	self._showParts = parts
end

function FightPlayer:getShowParts()
	return self._showParts
end

function FightPlayer:setPetID(petID)
	self._petID = petID
end

function FightPlayer:getPetID()
	return self._petID
end


function FightPlayer:setChoosed(bOk)
	self._bChoosed = bOk
end

function FightPlayer:getChoosed()
	return self._bChoosed 
end

function FightPlayer:setOffline(bOk)
	self._bOffline = bOk
end

function FightPlayer:getOffline()
	return self._bOffline 
end

function FightPlayer:getPet()
	
	if self._petID then
		local pet = g_fightEntityMgr:getRole(self._petID)
		return pet
	end
	return nil
end

function FightPlayer:setPack(p)
	self._pack = p
end

function FightPlayer:getPack(p)
	return self._pack
end

function FightPlayer:getIsInTeam()
	return self._bInTeam
end

function FightPlayer:getIsTeamHead()
	return self._bTeamHead
end

function FightPlayer:setIsInTeam(ok)
	self._bInTeam = ok
end

function FightPlayer:setIsTeamHead(ok)
	self._bTeamHead = ok
end

function FightPlayer:addPetID(ID)
	table.insert(self._petList,ID)
end

function FightPlayer:getPetList()
	return self._petList
end

-- 获得宠物数量 -_-
function FightPlayer:getPetAmount()
	local nCount = 0
	for _,_ in pairs(self._petList) do
		nCount = nCount + 1
	end
	return nCount
end

function FightPlayer:setPkInfo(info)
	self._pkInfo = info
end

function FightPlayer:getPkInfo()
	return self._pkInfo 
end

function FightPlayer:setIsMustCatch(isOk)
	self._bMustCatch = isOk
end

function FightPlayer:getIsMustCatch()
	return self._bMustCatch
end

function FightPlayer:__release()
	self._protectors = nil
	self._protectee = nil
	self._attrSet = nil	
	self._dirtyAttrType = nil 
	self._changedAttrType = nil
	self._pet = nil
	for _ ,petID in pairs(self._petList) do
		g_fightEntityMgr:removeRole(petID)
	end
	self._petList = nil
	self._teamMemberIDList = nil
end

function FightPlayer:getAttributeSet()
	return self._attrSet
end

function FightPlayer:isChanged(attrType)
	return self._changedAttrType[attrType]
end

function FightPlayer:setAttrValue(attrType,value,isLoad)
	if PlayerAttrDefine[attrType].expr == true then
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

function FightPlayer:getAttrValue(attrType)
	if not PlayerAttrDefine[attrType] then
		print("getAttrValue",attrType)
	end
	if not PlayerAttrDefine[attrType].expr  then
		return self._attrSet[attrType]
	else
		if self._dirtyAttrType[attrType] then
			local value = g_AttributePlayerFormat[attrType](self)
			self._attrSet[attrType] = value
			self._dirtyAttrType[attrType] = nil
			return value
		else
			return self._attrSet[attrType]
		end
	end
	
end

--创建玩家属性集
function FightPlayer:createAttributeSet()
	for attrType, v in pairs(PlayerAttrDefine or table.empty) do
		if PlayerAttrDefine[attrType].expr == true then
			self._dirtyAttrType[attrType] = true
		else
			self._attrSet[attrType] = 0
		end
	end
end

--通知属性影响的属性改变并计算
function FightPlayer:notifyInfluenceChanged(attrType,isLoad)
	local attrInfluenceTable = g_AttrPlayerInfluenceTable[attrType]
	if not attrInfluenceTable then
		return 
	end
	for _,exprAttrType in pairs (attrInfluenceTable) do
		if (not isLoad) and PlayerAttrDefine[exprAttrType].expr then
			if not g_AttrPlayerSyncTable[exprAttrType] then
				self._dirtyAttrType[exprAttrType] = true
			else
				local value = g_AttributePlayerFormat[exprAttrType](self)
				self._attrSet[exprAttrType] = value
				self:notifyInfluenceChanged(exprAttrType,isLoad)
			end
		end
	end
end
function FightPlayer:loadAttrs(attrs)
	for attrType, v in pairs(attrs ) do
		if PlayerAttrDefine[attrType] then
			self:setAttrValue(attrType,v,true)
		end
	end
end
function FightPlayer:setCommonSkill(skill)
	self._commonSkill = skill
end
function FightPlayer:getCommonSkill()
	return self._commonSkill
end
function FightPlayer:setLifeState(s)
	self._fightLifeState = s
end
function FightPlayer:setProtectors(p,isClear)
	if isClear then
		table.clear(self._protectors)
	else
		self._protectors[p:getID()] = true
	end
end
function FightPlayer:clearProtector(p)
	self._protectors[p:getID()] = nil
end
function FightPlayer:getProtectors()
	return self._protectors
end
function FightPlayer:setProtectee(p)
	self._protectee = p
end
function FightPlayer:getProtectee()
	return self._protectee
end
function FightPlayer:getIsDefense()
	return self._bDefense
end
function FightPlayer:setIsDefense(bOk)
	self._bDefense = bOk
end

-- 道行衰减等级
function FightPlayer:getTaoDecayLev()
	local decayLev = self:get_tao()/(self:get_standard_tao()*0.2) - 5
	if decayLev >= 1 then
		decayLev = math.floor(decayLev)
	else	
		decayLev = 0
	end
	return decayLev
end

-- 获取障碍命中的影响
function FightPlayer:getBarrierEffect()
	return (self:get_tao()*(self:getTaoDecayLev() + 1) - 
	self:get_standard_tao()*self:getTaoDecayLev())*1
end

--**[[ 属性获得
function FightPlayer:get_vigor()
	return self:getAttrValue(player_vigor)
end
function FightPlayer:get_max_vigor()
	return self:getAttrValue(player_max_vigor)
end
function FightPlayer:get_anger()
	return self:getAttrValue(player_anger)
end
function FightPlayer:get_max_anger()
	--return self:getAttrValue(player_max_anger)
	return 100
end
function FightPlayer:getMaxHp()
	return self:getAttrValue(player_max_hp)
end
function FightPlayer:getHp()
	return self:getAttrValue(player_hp)
end
function FightPlayer:getMp()
	return self:getAttrValue(player_mp)
end
function FightPlayer:getMaxMp()
	return self:getAttrValue(player_max_mp)
end
function FightPlayer:get_mt()
	return self:getAttrValue(player_mt)
end
function FightPlayer:get_mf()
	return self:getAttrValue(player_mf)
end
function FightPlayer:get_speed()
	return self:getAttrValue(player_speed)
end
function FightPlayer:getTao()
	return self:getAttrValue(player_tao)
end
function FightPlayer:get_str()
	return self:getAttrValue(player_str)
end
function FightPlayer:get_int()
	return self:getAttrValue(player_int)
end
function FightPlayer:get_sta()
	return self:getAttrValue(player_sta)
end
function FightPlayer:get_spi()
	return self:getAttrValue(player_spi)
end
function FightPlayer:get_dex()
	return self:getAttrValue(player_dex)
end
function FightPlayer:getHit()
	--modified by cm:from 取"玩家命中率" to 取"玩家命中值"
	return self:getAttrValue(player_hit)
end
function FightPlayer:getDodge()
	--modfied by cm:from "玩家闪避率" to "玩家闪避值"
	return self:getAttrValue(player_dodge)
end
function FightPlayer:getCritical()
	--modified by cm:as above
	return self:getAttrValue(player_critical)
end
function FightPlayer:getTenacity()
	--modified by cm:as above
	return self:getAttrValue(player_tenacity)
end
function FightPlayer:getInc_critical()
	return self:getAttrValue(player_inc_critical)
end
function FightPlayer:get_counter_dmg_add()
	return self:getAttrValue(player_inc_critical_effect)
end
function FightPlayer:getCounter()
	return self:getAttrValue(player_counter)
end
function FightPlayer:getInc_Counter()
	return self:getAttrValue(player_inc_counter)
end
function FightPlayer:getAt()
	return self:getAttrValue(player_at)
end
function FightPlayer:getAf()
	return self:getAttrValue(player_af)
end
function FightPlayer:get_inc_critical_effect()
	return self:getAttrValue(player_inc_critical_effect)
end

function FightPlayer:get_phase(type)
	if type == PhaseType.Soil then
		return self:getAttrValue(player_soi_at)
	end
	if type == PhaseType.Ice then
		return self:getAttrValue(player_ice_at)
	end
	if type == PhaseType.Fire then
		return self:getAttrValue(player_fir_at)
	end
	if type == PhaseType.Poison then
		return self:getAttrValue(player_poi_at)
	end
	if type == PhaseType.Thunder then
		return self:getAttrValue(player_thu_at)
	end
	if type == PhaseType.Wind then
		return self:getAttrValue(player_win_at)
	end
end

function FightPlayer:get_phase_resist(type)
	if type == PhaseType.Soil then
		return self:getAttrValue(player_soi_resist)
	end
	if type == PhaseType.Ice then
		return self:getAttrValue(player_ice_resist)
	end
	if type == PhaseType.Fire then
		return self:getAttrValue(player_fir_resist)
	end
	if type == PhaseType.Poison then
		return self:getAttrValue(player_poi_resist)
	end
	if type == PhaseType.Thunder then
		return self:getAttrValue(player_thu_resist)
	end
	if type == PhaseType.Wind then
		return self:getAttrValue(player_win_resist)
	end
end
function FightPlayer:get_obstacle_hit()
	return self:getAttrValue(player_inc_obstacle_hit)
end
function FightPlayer:get_taunt_resist()
	return self:getAttrValue(player_inc_taunt_resist)
end
function FightPlayer:get_sopor_resist()
	return self:getAttrValue(player_inc_sopor_resist)
end
function FightPlayer:get_chaos_resist()
	return self:getAttrValue(player_inc_chaos_resist)
end
function FightPlayer:get_freeze_resist()
	return self:getAttrValue(player_inc_freeze_resist)
end
function FightPlayer:get_silent_resist()
	return self:getAttrValue(player_inc_silent_resist)
end
function FightPlayer:get_poison_resist()
	return self:getAttrValue(player_inc_toxicosis_resist)
end
function FightPlayer:get_add_obstacle_resist()
	return self:getAttrValue(player_inc_obstacle_resist)
end
function FightPlayer:get_tao()
	return self:getAttrValue(player_tao)
end
function FightPlayer:get_standard_tao()
	return self:getAttrValue(player_stand_tao)
end

function FightPlayer:getObstacleIncHitByType(type)
	if type == BuffKind.TauntObstacle then
		return self:getAttrValue(player_inc_taunt_hit)
	end
	if type == BuffKind.SoporObstacle then
		return self:getAttrValue(player_inc_soper_hit)
	end
	if type == BuffKind.ChaosObstacle then
		return self:getAttrValue(player_inc_chaos_hit)
	end
	if type == BuffKind.FreezeObstacle then
		return self:getAttrValue(player_inc_freeze_hit)
	end
	if type == BuffKind.SilenceObstacle then
		return self:getAttrValue(player_inc_silent_hit)
	end
	if type == BuffKind.PoisonObstacle then
		return self:getAttrValue(player_inc_toxicosis_hit)
	end
end

function FightPlayer:get_dec_spell_cost()
	return self:getAttrValue(player_dec_spell_cost)
end

-- 攻击破防率
function FightPlayer:get_rupture_rate()
	return self:getAttrValue(player_rupture_rate)
end

-- 破防效果加成
function FightPlayer:get_inc_rupture_effect()
	return self:getAttrValue(player_inc_rupture_effect)
end

function FightPlayer:get_add_escape_rate()
	return self:getAttrValue(player_add_escape_rate) or 0
end

function FightPlayer:get_add_catchpet_rate()
	return self:getAttrValue(player_add_catchpet_rate) or 0
end

function FightPlayer:get_reduce_escape_rate()
	return self:getAttrValue(player_reduce_escape_rate) or 0
end
--**]]







--**[[ 属性设置

function FightPlayer:setMp(value)
	self:setAttrValue(player_mp, value)
end
function FightPlayer:inc_mp(value)
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
function FightPlayer:setHp(value)
	self:setAttrValue(player_hp,math.floor(value))
end
function FightPlayer:inc_hp(value)
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
function FightPlayer:set_anger(value)
	return self:setAttrValue(player_anger, value)
end
function FightPlayer:inc_anger(value)
	local anger = self:get_anger()
	local MaxAngerValue = self:get_max_anger()
	local anger_t = anger
	anger = anger + value
	anger = anger > MaxAngerValue and MaxAngerValue or anger
	anger = anger < 0 and 0 or anger
	if anger_t ~= anger then
		self:set_anger(anger)
	end
end
function FightPlayer:set_vigor(value)
	return self:setAttrValue(player_vigor, value)
end
function FightPlayer:inc_vigor(value)
	local vigor = self:get_vigor()
	local max_vigor = self:get_max_vigor()
	local vigor_t = vigor
	vigor = vigor + value
	vigor = vigor > max_vigor and max_vigor or vigor
	vigor = vigor < 0 and 0 or vigor
	if vigor_t ~= vigor then
		self:set_vigor(vigor)
	end
end
--**]]





--**[[ 技能相关
function FightPlayer:useSkill(skill_id, position)
	local fightID = self:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local target = fight:getRole(position)
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	print("人物技能开始".." role:"..self:getID().." skill:"..skill_id.."\n")
	Flog:log("人物技能开始".." role:"..self:getID().." skill:"..skill_id.."\n")
	-- local rt1, rt2 = handler.skills[skill_id]:perform( target )
	-- Flog:log("技能结束\n")
	return handler.skills[skill_id]:perform( target )
end

function FightPlayer:canUseSkill(skill_id)
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	if not handler.skills[skill_id] then
		print ('ERROR: player skill', skill_id, 'not exist!')
		return false
	end
	local state = handler.skills[skill_id]:canUseSkill()
	if state then
		Flog:log("该技能能使用\n")
	else
		Flog:log("该技能不能使用\n")
	end
	return state
end

function FightPlayer:useRevivalSkill()
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	return handler:useRevival()
	--return nil
end
--**]]




--**[[ 心法相关
function FightPlayer:show()
	self:show_mind()
	self:show_skill()
end
function FightPlayer:show_mind()
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	local minds = handler.minds
	for _,item in pairs(minds) do
		print ("minds: ", item.id, item.db.name)
	end
end
function FightPlayer:show_skill()
	local handler = self:getHandler(FightEntityHandlerType.SkillHandler)
	for _,item in pairs(handler.skills) do
		--print ("skills: ", item.id, item.db.name)
		print ("skills: ", item.id)
	end
end
function FightPlayer:setMinds(minds)
	self._minds = minds
end
function FightPlayer:getMinds()
	return self._minds
end

function FightPlayer:setWeaponID(weaponID)
	self._weaponID = weaponID
end

function FightPlayer:getWeaponID()
	return self._weaponID
end

function FightPlayer:setTeamMemberList(l)
	self._teamMemberIDList = l
end

function FightPlayer:getTeamMemberList()
	return self._teamMemberIDList 
end

function FightPlayer:setRemouldLevel(level)
	self._remouldLevel = level
end

function FightPlayer:getRemouldLevel()
	return self._remouldLevel
end
--**]]




