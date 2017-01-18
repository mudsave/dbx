--[[SkillUtils.lua
	描述：
--]]

SkillUtils = {}

--[[
	获得当前回合数
]]
function SkillUtils.getRoundCount(role)
	local fight = g_fightMgr:getFight(role:getFightID())
	return fight:getRoundCount()
end

--[[
	获得角色的类型
]]
function SkillUtils.getRoleType(role)
	if instanceof(role, FightPlayer) then
		return RoleType.Player
	end
	if instanceof(role, FightMonster) then
		return RoleType.Monster
	end
	if instanceof(role, FightPet) then
		return RoleType.Pet
	end
end

--[[
	判断是否为可复活角色类型
]]
function SkillUtils.canRevival(role)
	if instanceof(role, FightPlayer) then
		return true
	end
	if instanceof(role, FightMonster) then
		return true
	end
	if instanceof(role, FightPet) then
		return true
	end
	return false
end

--[[
	技能目标选择判断:选取的目标是否符合技能的目标类型
]]
function SkillUtils.chooseTargetCheck(role, target, targetType)
	-- 复活技能
	-- if target and target:is_alive() then
	if target then
		-- 选择自己
		if targetType == TargetType.self then
			if SkillUtils.isMyself(role, target) then
				return true
			end
		-- 选择友方（包括自己）
		elseif targetType == TargetType.friend or targetType == TargetType.friend_g then
			if SkillUtils.isFriend(role, target) or SkillUtils.isMyself(role, target) then
				return true
			end
		-- 选择敌方
		elseif targetType == TargetType.enemy or targetType == TargetType.enemy_g then
			if SkillUtils.isEnemy(role, target) then
				return true
			end
		end
	end
	return false
end

function SkillUtils.isMyself(role, target)
	return role:getID() == target:getID()
end

function SkillUtils.isFriend(role, target)
	if role:getID() ~= target:getID() and role:get_fight_side() == target:get_fight_side()  then
		return true
	end
end

function SkillUtils.isEnemy(role, target)
	if role:get_fight_side() ~= target:get_fight_side() then
		return true
	end
end

--[[
	获取角色所在阵营所有单位
		num:要获取的单位数量(nil或false获取全部) 
		includeSelf:是否包括自己
		includeDead:是否包括死亡单位
]]
function SkillUtils.getPartners(role, num, includeSelf, includeDead)
	local members = {}
	local fight = g_fightMgr:getFight(role:getFightID())
	local fightMembers = fight:getMembers()
	local side = role:get_fight_side()
	--[[ 包括自己时先将自己加入数组第一位,方便群体技能效果实现 ]]
	if includeSelf then	
		if not includeDead and not role:is_alive() then
			-- 不包括死亡单位且role not alive时排除
		else
			table.insert(members, role)
		end
	end
	for _, tempRole in pairs(fightMembers[side]) do
		if num and #members == tonumber(num) then
			break
		end
		if tempRole:getID() ~= role:getID() then
			-- 包括死亡单位
			if include_dead then
				table.insert(members, tempRole)
			-- 不包括死亡单位
			elseif tempRole:is_alive() then
				table.insert(members, tempRole)
			end
		end	
	end
	return members
end

--[[
	获取角色敌对阵营所有单位
		num:要获取的单位数量(nil或false获取全部) 
		includeDead:是否包括死亡单位
]]
function SkillUtils.getEnemies(role, num, includeDead)
	local members = {}
	local fight = g_fightMgr:getFight(role:getFightID())
	local fightMembers = fight:getMembers()
	local side = role:get_fight_side()
	local opposite = nil
	if side == FightStand.A then
		opposite = FightStand.B
	else
		opposite = FightStand.A
	end
	for _, tempRole in pairs(fightMembers[opposite]) do
		local handler = tempRole:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		local state = handler:getDisorderState()
		-- 判断能否受到攻击
		if state[fromEnemy].can == 1 then
			-- 包括死亡单位
			if include_dead then
				table.insert(members, tempRole)
			-- 不包括死亡单位
			elseif tempRole:is_alive() then
				table.insert(members, tempRole)
			end
			if num and #members == tonumber(num) then
				break
			end
		end
	end
	return members
end

--[[
	获得role己方中随机的一个单位
]]
function SkillUtils.getPartner(role)
	local members = SkillUtils.getPartners(role)
	local rand = 1
	if #members > 1 then
		rand = math.random(#members)
	elseif #members == 0 then
		return nil
	end
	return members[rand]
end

--[[
	获得role敌方中随机的一个单位
]]
function SkillUtils.getEnemy(role)
	local members = SkillUtils.getEnemies(role)
	local rand = 1
	if #members > 1 then
		rand = math.random(#members)
	elseif #members == 0 then
		return nil
	end
	return members[rand]
end

--[[
	获取友方所有能被敌方技能指向的角色
]]
function SkillUtils.getCanBeAttackedPartners(role, num, includeSelf)
	local members = SkillUtils.getPartners(role, false, includeSelf)
	local ret = {}
	for _, tmpRole in ipairs(members) do
		if num and #ret == tonumber(num) then
			break
		end
		local handler = tmpRole:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		local state = handler:getDisorderState()
		if state[fromEnemy].can == 1 then
			table.insert(ret, tmpRole)
		end	
	end
	return ret
end

--[[
	获取友方所有能被友方技能指向的角色
]]
function SkillUtils.getAcceptableHelpPartners(role, num, includeSelf)
	local members = SkillUtils.getPartners(role, false, includeSelf)
	local ret = {}
	for _, tmpRole in ipairs(members) do
		if num and #ret == tonumber(num) then
			break
		end
		local handler = tmpRole:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		local state = handler:getDisorderState()
		if state[fromFriend].can == 1 then
			table.insert(ret, tmpRole)
		end	
	end
	return ret
end

--[[
	获取role敌方所有能被role技能指向的角色
]]
function SkillUtils.getCanBeAttackedEnemies(role, num)
	local members = SkillUtils.getEnemies(role)
	local ret = {}
	for _, tmpRole in ipairs(members) do
		if num and #ret == tonumber(num) then
			break
		end
		local handler = tmpRole:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		local state = handler:getDisorderState()
		if state[fromEnemy].can == 1 then
			table.insert(ret, tmpRole)
		end	
	end
	return ret
end

--[[
	获得友方所有能被敌方技能指向的角色中任意一个
]]
function SkillUtils.getCanBeAttackedPartner(role, includeSelf)
	local members = SkillUtils.getCanBeAttackedPartners(role, false, includeSelf)
	local rand = 1
	if #members > 1 then
		rand = math.random(#members)
	elseif #members == 0 then
		return nil
	end
	return members[rand]
end

--[[
	获取友方所有能被友方技能指向的角色中任意一个
]]
function SkillUtils.getAcceptableHelpPartner(role, includeSelf)
	local members = SkillUtils.getAcceptableHelpPartners(role, false, includeSelf)
	local rand = 1
	if #members > 1 then
		rand = math.random(#members)
	elseif #members == 0 then
		return nil
	end
	return members[rand]
end

--[[
	获取role敌方所有能被role技能指向的角色中任意一个
]]
function SkillUtils.getCanBeAttackedEnemy(role)
	local members = SkillUtils.getCanBeAttackedEnemies(role)
	local rand = 1
	if #members > 1 then
		rand = math.random(#members)
	elseif #members == 0 then
		return nil
	end
	return members[rand]
end

-- 找到目标组中是否有两边的
function SkillUtils.getGroupEnemy(targetGroup)
	local firstTarget = targetGroup[1]
	for _,target in pairs(targetGroup) do
		if SkillUtils.isEnemy(firstTarget,target) then
			return firstTarget,target
		end
	end
	return firstTarget,nil
end

--[[
	检测该技能效果的buff是否等于buffKind
]]
function SkillUtils.EffectBuffKindCheck(effects, buffKind)
	for _, effect in pairs(effects) do
		if effect.type and  effect.type == SkillEff.Buff then
			if tFightingBuffDB[effect.numID].kind == buffKind then
				return true
			end
		end
	end
	return false
end

--[[
	检测该技能消耗类型是否等于type
]]
function SkillUtils.ConsumeTypeCheck(role, id, type)
	if SkillUtils.getRoleType(role) == RoleType.Player then
		local temp = FightSkillDB[id]
		if temp and temp.consume_type == type then
			return true
		end
	elseif SkillUtils.getRoleType(role) == RoleType.Pet then
		local temp = PetSkillDB[id]
		if temp and temp.consume_type == type then
			return true
		end
	end
	return false
end

--[[
	判断是否是单体效果,否则是群体效果
]]
function SkillUtils.isSingleEffect(targetType)
	local temp = TargetType
	if targetType == temp.friend_g or targetType == temp.enemy_g then
		return false
	end
	return true
end

--[[
	返回值 1克制 2不克制 3被克制
]]
function SkillUtils.getRestraintType(type_1, type_2)
	if RestraintMapping[type_1] and RestraintMapping[type_1][type_2] then
		return RestraintMapping[type_1][type_2]
	end
	-- 默认返回不克制
	return RestraintType.NoneRrestrain
end

--[[
	数值加成计算(原始数值,增加数值,加成类型)
]]
function SkillUtils.calcNumAdd(data, value, addType)
	-- print("数值计算：", data, value, addType)
	if data and value and addType then
		if addType == AddType.value then
			return math.floor(data + value)
		end
		if addType == AddType.percent then
			return math.floor(data * (100 + value) / 100)
		end
		if addType == AddType.mix then
			local value_1, value_2 = unpack(value)
			return math.floor(data * (value_1 / 100) + value_2)
		end
	end
	return data
end

--[[
	1.返回不大于原始数据的value值
	2.返回原始数据一定比例的数值
]]
function SkillUtils.getProperValue(data, value, addType)
	if addType == AddType.value then
		return data > value and value or data
	end
	if addType == AddType.percent then
		return math.floor(data * value / 100)
	end
end

--[[
	更新目标属性,并获取改变量
]]
function SkillUtils.getHpChange(target, change)
	-- print(debug.traceback())
	local change = math.floor(change)
	local hp = target:getHp()
	local maxHp = target:getMaxHp()
	local ret = change
	local temp = hp + change
	if temp < 0 then
		ret = 0 - hp
		temp = 0
	elseif temp > maxHp then
		ret = maxHp - hp
		temp = maxHp
	end
	-- print("血量改变(hp, maxHp, ret, temp)：", hp, maxHp, ret, temp)
	target:setHp(temp)
	return change
end

--[[
	更新目标属性,并获取改变量
]]
function SkillUtils.getMpChange(target, change)
	if instanceof(target, FightMonster) then
		return change
	end
	local change = math.floor(change)
	local mp = target:getMp()
	local maxMp = target:getMaxMp()
	local ret = change
	local temp = mp + change
	if temp < 0 then
		ret = 0 - mp
		temp = 0
	elseif temp > maxMp then
		ret = maxMp - mp
		temp = maxMp
	end
	-- print("蓝量改变：", mp, maxMp, ret, temp)
	target:setMp(temp)
	return change
end

--[[
	判断能否对自己使用技能
]]
function SkillUtils.canHelpMyself(skill)
	local status = skill:getDisorderState(skill.role)
	if status[toMyself].can == 1 then
		-- 沉默无法使用耗蓝技能
		if skill:isConsumeMp() and status[toMyself].mpHelpfulSkill == 0 then
			return false
		end
		return true
	end
	return false
end

--[[
	判断能否对友方使用技能使用技能,且目标可以接受友方技能效果
]]
function SkillUtils.canHelpFriend(skill, target)
	-- 技能使用者的障碍buff状态
	local status = skill:getDisorderState(skill.role)
	if status[toFriend].can == 1 then
		-- 沉默无法使用耗蓝技能
		if skill:isConsumeMp() and status[toFriend].mpHelpfulSkill == 0 then
			return false
		end
		-- 目标的障碍buff状态
		status = skill:getDisorderState(target)
		if status[fromFriend].can == 1 then
			return true
		end
	end
	return false
end

--[[
	判断能否对敌方使用技能使用技能,且目标可以接受敌方技能效果
]]
function SkillUtils.canAttackEnemy(skill, target)
	-- 技能使用者的障碍buff状态
	local status = skill:getDisorderState(skill.role)
	if status[toEnemy].can == 1 then
		if status[toEnemy].mpSkill == 0 then
			if skill:isConsumeMp() or status[toEnemy].nonmpSkill == 0 then
				return false
			end
		end
		-- 目标的障碍buff状态
		status = skill:getDisorderState(target)
		if status[fromEnemy].can == 1 then
			return true
		end
	end
	return false
end

--[[
	输出文件fight_log.txt供测试使用
]]
Flog = {}
Flog.file = nil

function Flog:open()
	self.file = io.open("fight_log.txt", "w")
end

function Flog:log(str)
	self.file:write(str)
	self.file:flush()
end

function Flog:close()
	self.file:close()
end

function Flog:role_info(role)
	local str = ""
	if SkillUtils.getRoleType(role) == RoleType.Player then
		str = str .. "\n[Player]: "..role:getID().." "
		str = str .. " HP:" .. role:getHp() .. " MP:" .. role:getMp()
		str = str .. " 怒气:" .. role:get_anger()
	end
	if SkillUtils.getRoleType(role) == RoleType.Monster then
		str = str .. "\n[Monster]: "..role:getID().." "
		str = str .. " HP:" .. role:getHp()
	end
	if SkillUtils.getRoleType(role) == RoleType.Pet then
		str = str .. "\n[Pet]: "..role:getID().." "
		str = str .. " HP:" .. role:getHp().. " MP:" .. role:getMp()
	end
	str = str .. " 物攻:" .. role:ft_get_at()
	str = str .. " 法攻:" .. role:ft_get_mt()
	str = str .. " 物防:" .. role:ft_get_af()
	str = str .. " 法防:" .. role:ft_get_mf()
	str = str .. " 暴击:" .. role:ft_get_critical()
	str = str .. " 暴击效果加成:" .. role:ft_get_inc_critical_effect() 
	str = str .. " 抗暴:" .. role:ft_get_tenacity()
	str = str .. " 闪避:" .. role:ft_get_dodge()
	str = str .. " 命中:" .. role:ft_get_hit()
	str = str .. " 速度:" .. role:ft_get_speed()
	str = str .. " 相性:" .. PhaseName[role:get_phase_type() or PhaseType.None]
	str = str .. " 风攻击:" .. role:ft_get_phase_at(PhaseType.Wind)
	str = str .. " 雷攻击:" .. role:ft_get_phase_at(PhaseType.Thunder)
	str = str .. " 冰攻击:" .. role:ft_get_phase_at(PhaseType.Ice)
	str = str .. " 土攻击:" .. role:ft_get_phase_at(PhaseType.Soil)
	str = str .. " 火攻击:" .. role:ft_get_phase_at(PhaseType.Fire)
	str = str .. " 毒攻击:" .. role:ft_get_phase_at(PhaseType.Poison)
	str = str .. " 风抗:" .. role:ft_get_phase_resist(PhaseType.Wind)
	str = str .. " 雷抗:" .. role:ft_get_phase_resist(PhaseType.Thunder)
	str = str .. " 冰抗:" .. role:ft_get_phase_resist(PhaseType.Ice)
	str = str .. " 土抗:" .. role:ft_get_phase_resist(PhaseType.Soil)
	str = str .. " 火抗:" .. role:ft_get_phase_resist(PhaseType.Fire)
	str = str .. " 毒抗:" .. role:ft_get_phase_resist(PhaseType.Poison)
	str = str .. "\n"
	return str
end

function Flog:buff_info(role)
	local str = " buff : {"
	local handler = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local buff_list = handler:getBuffList()
	for _,iter in pairs(buff_list) do
		str = str .. 
			" buff id:" .. (iter:getID() or "") ..
			" buff类型:" .. (PrintTypeInfo[iter:getKind()] or "") ..
			" 持续类型:" .. (iter:getStayType() or "")..
			" 持续时间:" .. (iter:getStayValue() or "")
		str = str .. " 效果:"
		for _,item in pairs(iter:getEffects() or {} ) do
			str = str .. "类型："..(item.effectType or "") .." 值："..(item.effectValue or "")..","
		end
		str = str .. "    "
	end
	str = str .. " }"
	return str
end

Flog:open()



function SkillUtils.calcShield(role, damage, dmg_type)
	local can_shield = false
	local isMpShield = false
	local handler = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	if not handler then
		return damage
	end
	local _, shield_type, shield_value = handler:getShieldEffect()
	if (not shield_value) or shield_value == 0 then
		return damage
	end
	Flog:log("------------护盾----------".."\n")
	Flog:log("将要造成的伤害种类"..dmg_type.."伤害"..damage.."\n")
	-- print("将要造成的伤害种类"..dmg_type.."伤害"..damage.."\n")
	if shield_type == EffectType.AbsorbAllDmgDa then
		Flog:log("全能盾")
		can_shield = true
	end
	if shield_type == EffectType.MtShield then
		Flog:log("以法替伤盾")
		can_shield = true
		isMpShield = true
	end
	if dmg_type == AtType.At and shield_type == EffectType.AbsorbAtDmgDa then
		Flog:log("有物盾")	
		can_shield = true
	elseif dmg_type == AtType.Mt and shield_type == EffectType.AbsorbMtDmgDa then
		Flog:log("有法盾")	
		can_shield = true
	end
	if can_shield == false then
		return damage
	end
	Flog:log("盾的值是:",shield_value)	
	if (-damage) > shield_value then
		damage = damage + shield_value
		handler:setShieldEffect(0)
		Flog:log("减盾值后的伤害是：:",damage)	
		-- 第二个值是这次护盾是否是以代盾
		return damage,isMpShield,shield_value
	else
		Flog:log("伤害不足完全被吸收 剩余:",shield_value+damage)	
		handler:setShieldEffect(shield_value+damage)
		return 0,isMpShield,damage
	end
end

-- 障碍命中道行影响值
function SkillUtils.getBarrierEffect(player1, player2)
	local effect1 = player1:getBarrierEffect()
	local effect2 = player2:getBarrierEffect()
	local effect = (effect1/player2:get_standard_tao()
			- effect2/player1:get_standard_tao())*0.01
	return effect
end

--[[
	判断障碍命中
]]
function SkillUtils.isBarrierHit(role, target, type)
	local funcName = DisorderResistMapping[type]
	local effect = SkillUtils.getBarrierEffect(role, target)
	local targetAllResist = target:get_add_obstacle_resist()
	local targetResist = target[funcName](target)
	local hitRate = (0.5 + effect) * (role:get_obstacle_hit() - targetAllResist - targetResist)
	if math.random <= math.floor(hitRate) then
		return true
	end
end

--[[
	设置随机种子
]]
function SkillUtils.setSeed()
	local tiemStr = tostring(os.time()):reverse()
	local num_1 = tiemStr:sub(1, 1) + 1
	local num_2 = tiemStr:sub(1, 2)
	local seed = num_1 * num_1 * num_2 * num_2
	math.randomseed(seed)
end

--[[
	随机获取范围值中的值
]]
function SkillUtils.getRangeValue(minValue, maxValue)
	if minValue == maxValue then
		return minValue
	end
	local tiemStr = tostring(os.time()):reverse()
	local num_1 = tiemStr:sub(1, 1) + 1
	local num_2 = tiemStr:sub(1, 2)
	local seed = num_1 * num_1 * num_2 * num_2
	--math.randomseed(seed)--频繁设置会造成每次开始取值都一样
	
	if maxValue < minValue then
		local tmp = minValue
		minValue = maxValue
		maxValue = tmp
	end
	-- math.rand 数据过大会造成溢出
	-- local value = math.floor(math.rand(minValue, maxValue))
	local value = math.floor(math.random(minValue, maxValue))
	-- print("范围随机值:", minValue, maxValue, value)
	return value
end

--[[
	获取给定值在波动因子计算出的范围内的随机值
]]
function SkillUtils.getFluctuateValue(value, factor)
	local factor = factor or 0
	local max = value * (100 + factor) / 100
	local min = value * (100 - factor) /100
	return SkillUtils.getRangeValue(min, max)
end