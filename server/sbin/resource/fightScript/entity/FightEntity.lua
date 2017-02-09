--[[FightEntity.lua
描述：
	战斗实体类，所有战斗角色的基类
--]]

require "base.base"

FightEntity = class()

function FightEntity:__init()
	self._id = nil					--来自c++层的实体ID
	self._peerHandle = nil			--来自c++层的peerhandle
	self._pos = {nil,nil,nil}		--mapID,x,y
	self._fightID = nil
	self._fightLifeState = nil		--战斗中的生命状态
	self._handlers = {}				--处理各种业务数据的句柄
	self._isGathering = false       --是否再蓄力
	self._isInjured = false
	self._roundCountAfterInjured = 0 --受伤后经过的回合数
	self._enterActionID = nil --实体进入场景的动作ID
	self._enterEffectID = nil --实体进入场景的光效ID
	self._bForceLeave = nil--是否强制离开
	self.posIndex = nil --位置所对应的索引值
end

function FightEntity:__release()
	self._pos = nil
	for _, handler in pairs(self._handlers) do
		handler:release()
	end
	self._handlers = nil
end

function FightEntity:setPeerHandle(peerHandle)
	self._peerHandle = peerHandle
end

--获取c++层的实体ID
function FightEntity:getID()
	return self._id
end

--获取c++层的peerhandle
function FightEntity:getPeerHandle()
	return self._peerHandle
end

function FightEntity:getPos()
	return self._pos
end


function FightEntity:setFightID(fightID)
	self._fightID = fightID
end

function FightEntity:getFightID()
	return self._fightID 
end

function FightEntity:setLifeState(s)
	self._fightLifeState = s
	if s == RoleLifeState.Dead then
		if self._protectee then
			self._protectee:clearProtector(self)
			self._protectee = nil
		end
		if self._isToGBH then
			self:setIsGBH(true)
		end
		--怪物死亡清理buff
		g_fightBuffMgr:onDeadClearBuff(self)
		--通知脚本战斗
		local fight = g_fightMgr:getFight(self._fightID)
		local fightType = fight:getType()
		if fightType == FightType.Script then
			--fight:onRoleDead(self)
		elseif fightType == FightType.PVE then
			fight:removeRole(self,true)
		end
	end
end

function FightEntity:getLifeState()
	return self._fightLifeState 
end

function FightEntity:is_alive()
	if self._fightLifeState and self._fightLifeState == RoleLifeState.Dead then
		return false
	end
	return true
end

function FightEntity:addHandler(hType, handler)
	self._handlers[hType] = handler
end

function FightEntity:removeHandler(hType)
	self._handlers[hType] = nil
end

function FightEntity:getHandler(hType)
	if not self._handlers then
		--print(debug.traceback())
	end
	return self._handlers[hType]
end

function FightEntity:getIsGathering()
		return self._isGathering
end

function FightEntity:setIsGathering(isOk)
		self._isGathering = isOk
end
function FightEntity:getIsInjured()
		return self._isInjured
end

function FightEntity:setIsInjured(isOk)
		self._isInjured = isOk
end


function FightEntity:getRoundCountAfterInjured()
		return self._roundCountAfterInjured
end

function FightEntity:setRoundCountAfterInjured(count)
		self._roundCountAfterInjured = count
end

function FightEntity:setEnterActionID(ID)
	self._enterActionID = ID
end
function FightEntity:getEnterActionID()
	return self._enterActionID
end

function FightEntity:setEnterEffectID(ID)
	self._enterEffectID = ID
end
function FightEntity:getEnterEffectID()
	return self._enterEffectID
end


function FightEntity:getMaxHp()
	print("getMaxHp 没有实现")
	return 0
end

function FightEntity:getMaxMp()
	print("getHp 没有实现")
	return 0
end

function FightEntity:getIsGBH()
	return false
end
--[[
context:{skillID = 10000,target=pos1}}
]]
--蓝，冷却,状态,目标是否合法
function FightEntity:canUseSkill(fight,role, context)
	
	return true
end

function FightEntity:setForceLeave(bOk)
	self._bForceLeave = bOk
end

function FightEntity:getForceLeave()
	return self._bForceLeave 
end

function FightEntity:getHp()
	print("getHp 没有实现")
	return 0
end

function FightEntity:setHp(value)
	print("setHp 没有实现")
end

function FightEntity:getMp()
	print("getHp 没有实现")
	return 0
end

function FightEntity:setMp(value)
	print("setHp 没有实现")
end



function FightEntity:getHit()
	print("getHit 没有实现")
	return 0
end

function FightEntity:getDodge()
	print("getDodge 没有实现")
	return 0
end

function FightEntity:getCritical()
	print("getCritical 没有实现")
	return 0
end

function FightEntity:getTenacity()
	print("getTenacity 没有实现")
	return 0
end

function FightEntity:getInc_critical()
	print("getInc_critical 没有实现")
	return 0
end

function FightEntity:getCounter()
	print("getCounter 没有实现")
	return 0
end

function FightEntity:getInc_Counter()
	print("getInc_Counter 没有实现")
	return 0
end

function FightEntity:getAt()
	print("getAt 没有实现")
	return 0
end

function FightEntity:getAf()
	print("getAf 没有实现")
	return 0
end

function FightEntity:get_mt()
	print("get_mt 没有实现")
	return 0
end

function FightEntity:get_mf()
	print("get_mf 没有实现")
	return 0
end

function FightEntity:get_anger()
	print("get_anger 没有实现")
	return 0
end

function FightEntity:set_anger()
	print("set_anger 没有实现")
	return 0
end

function FightEntity:get_max_anger()
	print("get_max_anger 没有实现")
	return 0
end

--[[
	根据消耗类型获取对应角色属性值
]]
function FightEntity:getConsumeAttrValue(type)
	if type then
		if type == ConsumeType.Mp then
			return self:getMp()
		end
		if type == ConsumeType.Hp then
			return self:getHp()
		end
		if type == ConsumeType.Anger then
			return self:get_anger()
		end
		if type == ConsumeType.vit then
			return self:get_vigor()
		end
	end
	return 0
end

--[[
	根据消耗类型获取对应角色属性最大值
]]
function FightEntity:getConsumeAttrMaxValue(type)
	if type then
		if type == ConsumeType.Mp then
			return self:getMaxMpMp()
		end
		if type == ConsumeType.Hp then
			return self:getMaxHpHp()
		end
		if type == ConsumeType.Anger then
			return self:get_max_anger()
		end
		if type == ConsumeType.vit then
			return self:get_max_vigor()
		end
	end
	return 0
end

-- 根据类型获取障碍命中加成
function FightEntity:getObstacleIncHitByType(type)
	return 0
end

-- 攻击破防率
function FightEntity:get_rupture_rate()
	return 0
end

-- 破防效果加成
function FightEntity:get_inc_rupture_effect()
	return 0
end

--**[[ 战斗属性获得
function FightEntity:ft_get_at()
	local tmp = self:getAt() + self._at + self._all_at
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_mt()
	local tmp = self:get_mt() + self._mt + self._all_mt
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_af()
	local tmp = self:getAf() + self._af + self._all_af
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_mf()
	local tmp = self:get_mf() + self._mf + self._all_mf
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_hit()
	local tmp = self:getHit() + self._hit
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_dodge()
	local tmp = self:getDodge() + self._dodge
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_critical()
	local tmp = self:getCritical() + self._critical
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_tenacity()
	local tmp = self:getTenacity() + self._tenacity
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_inc_critical_effect()
	local tmp = self:get_inc_critical_effect()
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_speed()
	local tmp = self:get_speed() + self._speed
	return tmp < 0 and 0 or tmp
end
function FightEntity:ft_get_phase_at(type)
	local phase = self:get_phase(type)
	if type == PhaseType.Soil then
		local tmp = phase + self._soil_at
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Ice then
		local tmp = phase + self._ice_at
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Fire then
		local tmp = phase + self._fire_at
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Poison then
		local tmp = phase + self._poison_at
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Thunder then
		local tmp = phase + self._thunder_at
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Wind then
		local tmp = phase + self._wind_at
		return tmp < 0 and 0 or tmp
	end
end
function FightEntity:ft_get_phase_resist(type)
	local phase_resist = self:get_phase_resist(type)
	if type == PhaseType.Soil then
		local tmp = phase_resist + self._soil_resist
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Ice then
		local tmp = phase_resist + self._ice_resist
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Fire then
		local tmp = phase_resist + self._fire_resist
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Poison then
		local tmp = phase_resist + self._poison_resist
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Thunder then
		local tmp = phase_resist + self._thunder_resist
		return tmp < 0 and 0 or tmp
	end
	if type == PhaseType.Wind then
		local tmp = phase_resist + self._wind_resist
		return tmp < 0 and 0 or tmp
	end
end

function FightEntity:ft_get_obstacle_resist(obstacle_type)
	if DisorderResistMapping[obstacle_type] then
		local func = DisorderResistMapping[obstacle_type]
		local tmp = self[func](self)
		return tmp < 0 and 0 or tmp
	end
	return 0
end

function FightEntity:ft_get_add_escape_rate()
	local tmp = self:get_add_escape_rate() + self._add_escape_rate
	return tmp < 0 and 0 or tmp
end

function FightEntity:ft_get_add_catchpet_rate()
	local tmp = self:get_add_catchpet_rate() + self._add_catchpet_rate
	return tmp < 0 and 0 or tmp
end

function FightEntity:ft_get_reduce_escape_rate()
	local tmp = self:get_reduce_escape_rate() + self._reduce_escape_rate
	return tmp < 0 and 0 or tmp
end
--**]]





--**[[ 战斗属性设置
function FightEntity:ft_add_at(value, percent)
	if percent then
		value = self:getAt() * value
	end
	self._at = self._at + value
	return value
end
function FightEntity:ft_add_mt(value, percent)
	if percent then
		value = self:get_mt() * value
	end
	self._mt = self._mt + value
	return value
end
function FightEntity:ft_add_af(value, percent)
	if percent then
		value = self:getAf() * value
	end
	self._af = self._af + value
	return value
end
function FightEntity:ft_add_mf(value, percent)
	if percent then
		value = self:get_mf() * value
	end
	self._mf = self._mf + value
	return value
end
function FightEntity:ft_add_hit(value, percent)
	if percent then
		value = self:getHit() * value
	end
	self._hit = self._hit + value
	return value
end
function FightEntity:ft_add_dodge(value, percent)
	if percent then
		value = self:getDodge() * value
	end
	self._dodge = self._dodge + value
	return value
end
function FightEntity:ft_add_critical(value, percent)
	if percent then
		value = self:getCritical() * value
	end
	self._critical = self._critical + value
	return value
end
function FightEntity:ft_add_tenacity(value, percent)
	if percent then
		value = self:getTenacity() * value
	end
	self._tenacity = self._tenacity + value
	return value
end
function FightEntity:ft_add_speed(value, percent)
	if percent then
		value = self:get_speed() * value
	end
	self._speed = self._speed + value
	return value
end
function FightEntity:ft_add_phase_at(type, value, percent)
	local phase = self:get_phase(type)
	local add_value = 0
	if percent then
		add_value = phase * value
	else
		add_value = value
	end
	if type == PhaseType.Soil then
		self._soil_at = self._soil_at + add_value
	end
	if type == PhaseType.Ice then
		self._ice_at = self._ice_at + add_value
	end
	if type == PhaseType.Fire then
		self._fire_at = self._fire_at + add_value
	end
	if type == PhaseType.Poison then
		self._poison_at = self._poison_at + add_value
	end
	if type == PhaseType.Thunder then
		self._thunder_at = self._thunder_at + add_value
	end
	if type == PhaseType.Wind then
		self._wind_at = self._wind_at + add_value
	end
	return add_value
end
function FightEntity:ft_add_phase_resist(type, value, percent)
	local phase = self:get_phase_resist(type)
	local add_value = 0
	if percent then
		add_value = phase * value
	else
		add_value = value
	end
	if type == PhaseType.Soil then
		self._soil_resist = self._soil_resist + add_value
	end
	if type == PhaseType.Ice then
		self._ice_resist = self._ice_resist + add_value
	end
	if type == PhaseType.Fire then
		self._fire_resist = self._fire_resist + add_value
	end
	if type == PhaseType.Poison then
		self._poison_resist = self._poison_resist + add_value
	end
	if type == PhaseType.Thunder then
		self._thunder_resist = self._thunder_resist + add_value
	end
	if type == PhaseType.Wind then
		self._wind_resist = self._wind_resist + add_value
	end
	return add_value
end

function FightEntity:ft_add_all_attack(value1, percent, value2)
	if value1 and value2 then
		self._all_at = self._all_at + value1
		self._all_mt = self._all_mt + value2
	else
		if not value1 then
			return 0, 0
		end
		if percent then
			value2 = self:get_mt() * value1
			value1 = self:getAt() * value1
		else
			value2 = value1
		end
		self._all_at = self._all_at + value1
		self._all_mt = self._all_mt + value2
		return value1, value2		
	end
end


function FightEntity:ft_add_all_defense(value1, percent ,value2)
	if value1 and value2 then
		self._all_af = self._all_af + value1
		self._all_mf = self._all_mf + value2
	else
		if not value1 then
			return 0, 0
		end
		if percent then
			value2 = self:get_mf() * value1
			value1 = self:getAf() * value1
		else
			value2 = value1
		end
		self._all_af = self._all_af + value1
		self._all_mf = self._all_mf + value2
		return value1, value2
	end
end

function FightEntity:ft_add_soil_at(value, percent)
	if percent then
		value = self:ft_get_phase_at(PhaseType.Soil) * value
	end
	self._soil_at = self._soil_at + value
	return value
end
function FightEntity:ft_add_ice_at(value, percent)
	if percent then
		value = self:ft_get_phase_at(PhaseType.Ice) * value
	end
	self._ice_at = self._ice_at + value
	return value
end
function FightEntity:ft_add_fire_at(value, percent)
	if percent then
		value = self:ft_get_phase_at(PhaseType.Fire) * value
	end
	self._fire_at = self._fire_at + value
	return value
end
function FightEntity:ft_add_poison_at(value, percent)
	if percent then
		value = self:ft_get_phase_at(PhaseType.Poison) * value
	end
	self._poison_at = self._poison_at + value
	return value
end
function FightEntity:ft_add_thunder_at(value, percent)
	if percent then
		value = self:ft_get_phase_at(PhaseType.Thunder) * value
	end
	self._thunder_at = self._thunder_at + value
	return value
end
function FightEntity:ft_add_wind_at(value, percent)
	if percent then
		value = self:ft_get_phase_at(PhaseType.Wind) * value
	end
	self._wind_at = self._wind_at + value
	return value
end

function FightEntity:ft_add_soil_resist(value, percent)
	if percent then
		value = self:ft_get_phase_resist(PhaseType.Soil) * value
	end
	self._soil_resist = self._soil_resist + value
	return value
end
function FightEntity:ft_add_ice_resist(value, percent)
	if percent then
		value = self:ft_get_phase_resist(PhaseType.Ice) * value
	end
	self._ice_resist = self._ice_resist + value
	return value
end
function FightEntity:ft_add_fire_resist(value, percent)
	if percent then
		value = self:ft_get_phase_resist(PhaseType.Fire) * value
	end
	self._fire_resist = self._fire_resist + value
	return value
end
function FightEntity:ft_add_poison_resist(value, percent)
	if percent then
		value = self:ft_get_phase_resist(PhaseType.Poison) * value
	end
	self._poison_resist = self._poison_resist + value
	return value
end
function FightEntity:ft_add_thunder_resist(value, percent)
	if percent then
		value = self:ft_get_phase_resist(PhaseType.Thunder) * value
	end
	self._thunder_resist = self._thunder_resist + value
	return value
end
function FightEntity:ft_add_wind_resist(value, percent)
	if percent then
		value = self:ft_get_phase_resist(PhaseType.Wind) * value
	end
	self._wind_resist = self._wind_at + value
	return value
end
--**]]
