-- PetSkill.lua

-- MHSG-6886 需求:高级技能和低级技能同时存在时候,低级技能效果失效,只取高级技能效果

local function notice(str,...)
	print( ("PetSkill:%s"):format( str and str:format(...) or "" ) )
end

-- 属性被动生效
local function MakeAttrEffect(owner,effectType,addType,effectValue)
	local addName,incName = unpack(PetSkillEffect2AttrName[effectType])
	local addValue,incValue

	if addType == AddType.value then
		addValue = effectValue
	elseif addType == AddType.percent then
		incValue = effectValue
	else
		addValue = effectValue[1]
		incValue = effectValue[2]
	end

	if addValue then
		if not addName then
			notice("技能配置错误 %s",effectType)
		end
		owner:addAttrValue(addName,addValue)
	end
	if incValue then
		if not incName then
			notice("技能配置错误 %s",effectType)
		end
		owner:addAttrValue(incName,incValue)
	end
end

PetSkill = class()

function PetSkill:__init(id,category,ordinal)
	self.id				= id				-- 技能ID
	self.category		= category			-- 技能分类
	self.ordinal		= ordinal or false	-- 序列号
	self.removed		= false				-- 技能否被删除
	self.valid			= false				-- 技能是否是有效的
end

function PetSkill:getID()
	return self.id
end

function PetSkill:getCategory()
	return self.category
end

function PetSkill:getOrdinal()
	return self.ordinal
end

function PetSkill:setOrdinal(ordinal)
	self.ordinal = ordinal
end

-- 技能被删除与否

function PetSkill:setRemoved(rm)
	self.removed = not not rm
end

function PetSkill:isRemoved()
	return self.removed
end

-- 技能是否是有效的,主要处理高级和低级技能之前的关系

function PetSkill:isValid()
	return self.valid
end

function PetSkill:setValid(b)
	self.valid = b
end

-- 技能的效果保存

function PetSkill:setLastEffect(key,value)
	rawset(self,1024 + key,value)
end

function PetSkill:getLastEffect(key)
	return rawget(self,1024 + key)
end

function PetSkill:makeEffect(owner)
	if not self:isValid() then return end

	local detail = PetSkillDB[self.id]
	if not detail then
		notice("宠物技能%s没有配置",self.id or "nil")
		return
	end
	-- 只有属性被动技能才能对普通状态下的宠物生效
	if detail.skill_type ~= PetSkillType.AttrPassive then
		return
	end
	-- 技能等级和宠物等级一致
	local lvl = owner:getLevel()
	-- 属性被动技能会有多个效果
	for index,effect in pairs(detail.skill) do
		local formula = PetSkillDataDB[effect.num_id]
		local addType = formula.type

		-- 技能效果的数值
		local value = formula[lvl]
		local prev	= self:getLastEffect(index)

		self:setLastEffect(index,value)

		-- 如果存在之前的技能效果
		if prev then
			if addType == AddType.mix then
				value = {
					value[1] - prev[1],
					value[2] - prev[2],
				}
			else
				value = value - prev
			end
			-- 则需要先移除之前的技能效果
		end

		MakeAttrEffect(owner,effect.type,addType,value)
	end
end

-- 移除技能效果
function PetSkill:removeEffect(owner)
	if not self:isValid() then return end

	local detail = PetSkillDB[self.id]
	if not detail then
		notice("宠物技能%s没有配置",self.id or "nil")
		return
	end
	-- 只有属性被动技能才能对普通状态下的宠物生效
	if detail.skill_type ~= PetSkillType.AttrPassive then
		return
	end
	for index,effect in pairs(detail.skill) do
		local formula = PetSkillDataDB[effect.num_id]
		local addType = formula.type

		local prev = self:getLastEffect(index)
		self:setLastEffect(index,nil)

		if addType == AddType.mix then
			prev[1] = 0 - prev[1]
			prev[2] = 0 - prev[2]
		else
			prev = 0 - prev
		end
		MakeAttrEffect(owner,effect.type,addType,prev)
	end
end

--[[
	好想飞啊,像萤火虫一样,在漆黑的盛夏里闪烁,飘到浩瀚的银河中去
]]
