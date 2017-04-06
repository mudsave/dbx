--[[Buff.lua
描述:
	Buff类
]]


Buff = class()

function Buff:__init(buffID, desEntity, srcEntity, skillLevel)
	-- id值
	self.buffID = buffID
	-- 数据的配置
	self.db = tFightingBuffDB[buffID]
	-- buff的种类
	self.kind = self.db.kind
	-- 源
	self.srcEntity = srcEntity
	-- buff的持有者
	self.owner = desEntity
	-- buff持有者中的buff链
	self.handler = self.owner:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	-- buff的等级
	self.skillLevel = skillLevel
	-- 持续的类型
	self.stayType = self.db.stayType
	-- 是否可以驱散
	self.isDisperse = self.db.isDisperse
	-- 最大持续值
	self.stayMaxValue = self:getStayPeriod()
	-- 持续值
	self.stayValue = self.stayMaxValue
	-- 是否冻结
	self.freeze = false
	-- buff的效果
	self.effects = {}
	-- 效果的添加
	self:addEffect()
end

function Buff:__release()
	self.owner = nil
	self.buffID = nil
	self.desEntity = nil
	self.srcEntity = nil
	self.stayValue = nil
	self.stayType = nil
	self.effects = nil
	self.freeze = nil
end

function Buff:addStayValue(addValue, percent)
	local value = self.stayValue
	if percent then
		addValue = value * addValue / 100
	end
	self.stayValue = value + addValue
end

-- 得到最大持续值
function Buff:getStayPeriod()
	if self.db.stayType == BuffStayType.Bout then
		return tBuffEffectValueDB[self.db.stayID][self:getLevel()]
	end
	if self.db.stayType == BuffStayType.Tao then
		local affect = SkillUtils.getBarrierEffect(self.srcEntity, self.owner)
		local round = tBuffEffectValueDB[self.db.stayID][self:getLevel()]
		if affect >= 2 then
			round = round + 2
		elseif affect < 2 and affect >= 1 then
			round = round + 1
		elseif affect < 1 and affect >= -1 then
		elseif affect < -1 and affect >= -2 then
			round = round - 1
		else
			round = round - 2
		end
		return round > 0 and round or 1
	end
	return nil
end

function Buff:getLevel()
	if self.db.levelType == BuffJudgeLevel.xpLevel then
		return self.srcEntity:getLevel()
	end
	return self.skillLevel
end
--[[
function Buff:__tostring()
	print ("$$buff$$")
	for idx,iter in pairs(self.effects) do
		print (idx, iter.effectType, iter.effectValue, iter.addType)
	end
	print ("$$buff$$")
end
--]]
--获取buffID
function Buff:getID()
	return self.buffID
end

-- 获取效果
function Buff:getEffects()
	return self.effects
end

-- 获取第一个效果
function Buff:getFirstEffects()
	return self.effects[1]
end

function Buff:getFirstEffectType()
	return self.effects[1].effectType
end

function Buff:getFirstEffectValue()
	return self.effects[1].effectValue
end

function Buff:setFirstEffectValue(value)
	self.effects[1].effectValue = value
end

function Buff:getFirstEffectAddType()
	return self.effects[1].addType
end

-- 获取第二个效果
function Buff:getSecondEffectValue()
	return self.effects[2].effectValue
end

-- 得到持续值
function Buff:getStayValue()
	return self.stayValue
end

-- 得到种类
function Buff:getKind()
	return self.kind
end

-- 得到持续类型
function Buff:getStayType()
	return self.stayType
end

-- 得到死亡清除
function Buff:getDeathCleanup()
	return self.db.deathCleanup
end

-- 得到是否驱散
function Buff:getDisperse()
	return self.isDisperse
end

-- 获得buff技能的持有者
function Buff:getOwner()
	return self.owner
end
-- 获得施技能者
function Buff:getSrcEntity()
	return self.srcEntity
end
-- 添加效果
function Buff:addEffect()
	for _,iter in pairs( self.db.effects or {} ) do
		effect = {
			effectType = iter[1],  --buff的效果类型
			effectValue = math.ceil(tBuffEffectValueDB[iter[2]][self:getLevel()] or 0), --buff的数值
			addType = tBuffEffectValueDB[iter[2]].addType --buff是固定值还是百分比
		}
		table.insert(self.effects, effect)
	end
end

-- 所有buff的持续值下降
function Buff:calc()
	funcName = FightBuffMap[self.kind]
	return self[funcName[2]](self)
end

-- 停止buff 和 停止光效
function Buff:stop()
	funcName = FightBuffMap[self.kind]
	return self[funcName[3]](self)
end

-- 所有buff的持续值下降
function Buff:calcBuffPeriod(stopAction)
	self.stayValue = self.stayValue - 1
	if self.stayValue <= 0 then
		self[stopAction](self)
		return false
	end
	return true
end

-- 改变属性的效果 是加 是减
function Buff:startChangeAttrEffect(isAdd)
	-- 是否属性加减记录
	local doStr = nil
	local func = nil
	for idx,effect in pairs(self.effects) do
		-- 找到作用的方法
		doStr = EffectTypeAction[effect.effectType]
		func = self.owner[doStr]
		-- 是减的效果
		if not isAdd then
			effect.effectValue = 0 - effect.effectValue
		end
		-- 是百分比还是 固定值
		if effect.addType == EffectAddType.FixedValue then
			effect.addValue = func(self.owner, effect.effectValue)
		else
			effect.effectValue = effect.effectValue / 100
			effect.addValue = func(self.owner, effect.effectValue, true)
		end
		-- 特殊的效果
		if doStr == "ft_add_tenacity" and effect.addValue == 0 then
				self.handler:setMustTenacity(true)
		end
		if doStr == "ft_add_speed" and effect.addValue == 0 then
				self.handler:setFastestSpeed(true)
		end
		if doStr == "ft_add_hit" and effect.addValue == 0  then
				self.handler:setMustHit(true)
			end
		Flog:log("属性的改变,种类:"..doStr..effect.effectType.." 值："..effect.addValue.."\n")
	end
end

-- 停止改变属性的效果 是加 是减
function Buff:stopChangeAttrEffect()
	local doStr = nil
	local func = nil
	for idx,effect in pairs(self.effects) do
		doStr = EffectTypeAction[effect.effectType]
		func = self.owner[doStr]
		--变回原来的属性
		func(self.owner, 0-effect.addValue)
		--Flog:log("属性的改变结束,种类:"..doStr..effect.effectType.." 值：-"..effect.addValue.."\n")
	end
end
-- 把相关的文件加载
require "buff.FightBuffAtom"
