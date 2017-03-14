--[[Mind.lua
描述：
	
--]]

Mind = class()

function Mind:__init(handler, role, id, level)
	self.handler	= handler		--和管理器的关系
	self.role		= role			--和所有者的关系
	self.id			= id			--内部数据，技能ID
	self.level		= level			--内部数据，心法等级
	self.db			= MindDB[id]	--缓存数据，心法配置信息
	self.incValue	= 0				--外部数据的内部保留，心法等级加值，用于清除上一次加值的影响

	self:handleLevelInc()
	self:attr_add()
	self:apply_passive_skill()
end

-- 返回技能的等级用来根据技能ID 索引技能等级 而不是心法
function Mind:getSkillLevel(SkillID)
	local db = self.db
	for i = 1,4 do
		local skill_id = db['skill'..i]
		if SkillID == skill_id then
			return self.level
		end
	end
	return nil
end

--心法升级
function Mind:upgrade(level)
	local rt = self:upgrade_verify(level)
	self:attr_add(rt.up_level)
	self:upgrade_passive_skill(rt.up_level)
	self:do_upgrade(rt.up_level)
	return rt
end

--一键升级所能升的最大等级
function Mind:getMaxlevel(addlevel, mindid)
	local mind_level = self.level  
	local all_pot = self.role:getAttrValue(player_pot)  
	local all_Submoney = self.role:getSubMoney() 
	local all_money = self.role:getMoney()
	local cost_money = MindDB[mindid].money_cost_id 
	local cost_pot = MindDB[mindid].pot_cost_id  
	local sum_money  = 0
	local sum_pot = 0
	local max_level = 0
	for i = 1, addlevel do 
		local levelcostmoney = MindDataDB[cost_money][mind_level+i] 
		local levelcostpot = MindDataDB[cost_pot][mind_level + i]  
		sum_money = sum_money + levelcostmoney   
		sum_pot = sum_pot + levelcostpot 
		if (all_Submoney + all_money) >= sum_money and all_pot >= sum_pot  then 
			max_level = i	
		else
			break
		end
	end
	return max_level
end

--升级所花费的潜能金钱
function Mind:costPotMoney(level,mindid)
	local mind_level = self.level
	local all_pot = self.role:getAttrValue(player_pot)
	local all_Submoney = self.role:getSubMoney()
	local all_money = self.role:getMoney()
	local cost_money = MindDB[mindid].money_cost_id 
	local cost_pot = MindDB[mindid].pot_cost_id  
	local sum_money  = 0
	local sum_pot = 0
	for i = 1, level do 
		local levelcostmoney = MindDataDB[cost_money][mind_level+i] 
		local levelcostpot = MindDataDB[cost_pot][mind_level + i]  
		sum_money = sum_money + levelcostmoney
		sum_pot = sum_pot + levelcostpot
		end
	if (all_Submoney + all_money) < sum_money or all_pot < sum_pot  then 
		return  false
	else
		local all_pot = self.role:getAttrValue(player_pot)  
		self.role:setAttrValue(player_pot,all_pot - sum_pot )
		if all_Submoney < sum_money then 
			self.role:setSubMoney(0)
			self.role:setMoney(self.role:getMoney() - (sum_money -all_Submoney))
		else
			self.role:setSubMoney(self.role:getSubMoney() - sum_money)
		end
	end	
	self.role:flushPropBatch()
	return true
end


--心法等级增加
function Mind:do_upgrade(level)
	self:triger_task(level)
	self.level = self.level + level
end

function Mind:triger_task(level)
	local db = self.db
	local skill_id = 0
	local skill_level = 0
	for i = 1,4 do
		if not db['skill'..i..'_level'] then
			break
		end
		skill_id = db['skill'..i]
		if db['skill'..i..'_level'] <= self.level + level then
			skill_level = self.level + level
			if db['skill'..i..'_level'] > self.level then
				TaskCallBack.onLearnSkill(self.role:getID(), skill_id, skill_level)
			else
				TaskCallBack.onLearnSkill(self.role:getID(), skill_id, skill_level)
			end	
		end
	end
end

--心法对应的属性价值和加成
function Mind:attr_add(level)
	local value = 0
	if not level then
		value = self.get_value( MindDB[self.id].attr_add_id, self.level) or 0
	else
		value = self.get_value( MindDB[self.id].attr_add_id, self.level+level)
				- self.get_value( MindDB[self.id].attr_add_id, self.level) or 0
	end
	value = math.floor(value)
	local add_type = MindDB[self.id].attr_add_type
	local role = self.role
	local tmp = 0
	if(add_type == AttrAddType.At ) then
		role:inc_at_add(value)
		--print ("$$ 物攻add", value)
		return true
	end
	if(add_type == AttrAddType.Mt ) then
		role:inc_mt_add(value)
		--print ("$$ 法攻add", value)
		return true
	end
	if(add_type == AttrAddType.ObsHit ) then
		role:inc_disorder_hit_add(value)
		--print ("$$ 障碍命中add", value)
		return true
	end
	if(add_type == AttrAddType.Defense ) then
		role:inc_allf_add(value)
		--print ("$$ 全部防御add", value)
		return true
	end
	if(add_type == AttrAddType.PhaseDf ) then
		role:inc_all_phase_resist_add(value)
		--print ("$$ 全部相性防御add", value)
		return true
	end
	if(add_type == AttrAddType.AngerAdd ) then
		role:inc_anger_add_ration(value)
		--print ("$$ 怒气加成add", value)
		return true
	end
	if(add_type == AttrAddType.MaxHp ) then
		role:inc_max_mp_add(value)
		--print ("$$ 最大mp add", value)
		return true
	end
	role:flushPropBatch()
end

--使用被动技能
function Mind:upgrade_passive_skill(level)
	local db = self.db
	local skill_id = 0
	for i = 1,4 do
		if not db['skill'..i..'_level'] then
			break
		end
		skill_id = db['skill'..i]
		if FightSkillDB[skill_id].skill_type == Skill_Type.Passive
			and db['skill'..i..'_level'] <= self.level + level then
			if db['skill'..i..'_level'] > self.level then
				self:use_passive_skill(skill_id, 0, self.level+level)
			else
				self:use_passive_skill(skill_id, self.level, self.level+level)
			end
		end
	end
end

function Mind:apply_passive_skill()
	local skill_id = nil
	for idx = 1,4 do
		if self.db['skill'..idx..'_level']
			and self.db['skill'..idx..'_level'] <= self.level then
			skill_id = self.db['skill'..idx]
			if FightSkillDB[skill_id].skill_type == Skill_Type.Passive then
				self:use_passive_skill(skill_id, 0, self.level)
			end
		end
	end
end


function Mind:use_passive_skill(skill_id, o_level, n_level)
	if n_level == 0 then
		return
	end
	local sv = FightSkillDB[skill_id]
	if not sv then
		return
	end
	local map = SkillTypeEff[sv.skill_type]
	for _,d in pairs(map) do
		for i,dt in pairs(sv.skill) do
			if d == dt.type then
				if dt.type == SkillEff.FireAt then
					self:do_fire_at(dt, o_level, n_level)
				end
				if dt.type == SkillEff.WindAt then
					self:do_wind_at(dt, o_level, n_level)
				end
				if dt.type == SkillEff.ThunderAt then
					self:do_thunder_at(dt, o_level, n_level)
				end
				if dt.type == SkillEff.SoilAt then
					self:do_soil_at(dt, o_level, n_level)
				end
				if dt.type == SkillEff.IceAt then
					self:do_ice_at(dt, o_level, n_level)
				end
				if dt.type == SkillEff.PoisonAt then
					self:do_poison_at(dt, o_level, n_level)
				end
			end
		end
	end
	return true
end

--心法升级校验
--[[
up_level 可以升的等级
ec 0正常 1钱不够 2潜能不够
--]]
function Mind:upgrade_verify(level)
	local result = {}
	local cl = self.level
	local all_submoney = self.role:getSubMoney()
	local all_slvmoney  = self.role:getMoney()
	local all_money = all_submoney + all_slvmoney 
	local all_pot = self.role:getAttrValue(player_pot)
	local money = 0
	local pot = 0
	for i = 1,level do
		money = money + self.get_value(self.db.money_cost_id, cl+i)
		pot = pot + self.get_value(self.db.pot_cost_id, cl+i)
	end 
	if all_money < money then
		result.ec = 1	
	elseif all_pot < pot then 
		result.ec = 2
	else 
		result.ec = 0	
	end
	result.up_level = level 
	result.money = money
	result.pot = pot
	return result
end

function Mind.get_value(id, level)
	return MindDataDB[id][level] or 0
end

--处理心法等级加值
function Mind:handleLevelInc(incValue)
	if not incValue then
		incValue = self.role:getAttrValue(player_add_mind_level)
	end

	local delta = incValue - self.incValue	--等级加值的差值
	if delta == 0 then return end

	local level = self.level + delta
	if level > MAX_MIND_LEVEL then
		level = MAX_MIND_LEVEL
	elseif level < 0 then
		level = 0
	end
	self.incValue = incValue
	self.level = level
	return level
end

--火攻击
function Mind:do_fire_at(data, old_level, new_level)
	local value = 0
	if old_level == 0 then
		value = FightSkillDataDB[data.num_id][new_level] or 0
	else
		value = FightSkillDataDB[data.num_id][new_level] - FightSkillDataDB[data.num_id][old_level]
	end
	value = math.floor(value)
	self.role:inc_fire_at_add(value)
	print ("火攻击增加", value)
end
--风攻击
function Mind:do_wind_at(data, old_level, new_level)
	local value = 0
	if old_level == 0 then
		value = FightSkillDataDB[data.num_id][new_level] or 0
	else
		value = FightSkillDataDB[data.num_id][new_level] - FightSkillDataDB[data.num_id][old_level]
	end
	value = math.floor(value)
	self.role:inc_wind_at_add(value)
	print ("风攻击增加", value)
end
--雷攻击
function Mind:do_thunder_at(data, old_level, new_level)
	local value = 0
	if old_level == 0 then
		value = FightSkillDataDB[data.num_id][new_level] or 0
	else
		value = FightSkillDataDB[data.num_id][new_level] - FightSkillDataDB[data.num_id][old_level]
	end
	value = math.floor(value)
	self.role:inc_thunder_at_add(value)
	print ("雷攻击增加", value)
end
--土攻击
function Mind:do_soil_at(data, old_level, new_level)
	local value = 0
	if old_level == 0 then
		value = FightSkillDataDB[data.num_id][new_level] or 0
	else
		value = FightSkillDataDB[data.num_id][new_level] - FightSkillDataDB[data.num_id][old_level]
	end
	value = math.floor(value)
	self.role:inc_soil_at_add(value)
	print ("土攻击增加", value)
end
--冰攻击
function Mind:do_ice_at(data, old_level, new_level)
	local value = 0
	if old_level == 0 then
		value = FightSkillDataDB[data.num_id][new_level] or 0
	else
		value = FightSkillDataDB[data.num_id][new_level] - FightSkillDataDB[data.num_id][old_level]
	end
	value = math.floor(value)
	self.role:inc_ice_at_add(value)
	print ("冰攻击增加", value)
end
--毒攻击
function Mind:do_poison_at(data, old_level, new_level)
	local value = 0
	if old_level == 0 then
		value = FightSkillDataDB[data.num_id][new_level] or 0
	else
		value = FightSkillDataDB[data.num_id][new_level] - FightSkillDataDB[data.num_id][old_level]
	end
	value = math.floor(value)
	self.role:inc_poison_at_add(value)
	print ("毒攻击增加", value)
end
