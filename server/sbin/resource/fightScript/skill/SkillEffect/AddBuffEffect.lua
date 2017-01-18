--[[AddBuffEffect.lua
	描述：处理技能效果相关逻辑
]]

AddBuffEffect = class(SkillEffect)

--[[
	添加BUFF效果
]]
function AddBuffEffect:doAddBuff(target)
	if instanceof(self.role, FightPet) then
		self:doAddSpecialBuff(target)
	else
		-- 判断是否是单体效果
		if SkillUtils.isSingleEffect(self.targetType) then
			self:onSingleBuff(target, self.numID)
		else
			local targets = SkillUtils.getPartners(target, self.targetNum, true)
			for _, target in pairs(targets) do
				self:onSingleBuff(target, self.numID)
			end
		end
	end
	return true
end

--[[
	执行单体BUFF
]]
function AddBuffEffect:onSingleBuff(target, buffID)
	if not target:is_alive() then
		target = SkillUtils.getPartner(target)
	end
	if target then
		-- 添加目标到技能目标列表
		self:addTarget(target)	
		-- 设置目标BUFFID
		self:setTargetBuffID(target, buffID)
		local hitStatus = 0
		local level = self.skill:getSkillLevel()
		local role = self.role
		-- 添加BUFF
		if not g_fightBuffMgr:addBuff(role, target, buffID, level) then
			local buffHandler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
			hitStatus = buffHandler:getHitStatus()
		end
		self:petAcceptAssistRoundAdd(target, buffID)
		-- 设置BUFF命中状态
		self:setBuffHitStatus(target, hitStatus)

		Flog:log("ID:"..self.role:getID().." 添加BUFF".." ID:"..target:getID())
	end
end

--[[
	永恒-宠物被动：受到的辅助类法术效果持续回合增加
]]
function AddBuffEffect:petAcceptAssistRoundAdd(target, buffID)
	if instanceof(target, FightPet) then
		local skillHanlder = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue, value, addType = skillHanlder:getAcceptAssistRoundAdd()
		if isTrue then
			local buffHandler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
			local buff = buffHandler:getBuffByID(buffID)
			if buff and buffHandler:isAssistBuff(buff) then			
				print("BUFF原始持续回合数：", buff:getStayValue())
				buffHandler:addBuffStayValue(buff, value, addType == AddType.percent)
				print("BUFF现在持续回合数：", buff:getStayValue())
			end
		end
	end
end

--[[
	添加特殊BUFF效果
]]
function AddBuffEffect:doAddSpecialBuff(target)
	local skillID = self.skill:getSkillID()
	local addNum = 0
	-- 能否使用特殊buff&特殊buff增加目标数量
	if PetSpecialBuffConf[skillID] then
		if not self:canUseSpecialBuff(target, skillID) then
			return true
		end
		addNum = self:addSpecialBuffTarget(skillID)
	end
	local buffID = self.numID
	if addNum == 0 and SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleBuff(target, buffID)
	else
		local targetNum = self.targetNum + addNum
		local targets = SkillUtils.getPartners(target, targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleBuff(target, buffID)
		end
	end
	return true
end

--[[
	使用特殊BUFF(计算成功率和失败率)
]]
function AddBuffEffect:canUseSpecialBuff(target, skillID)
	local getFuncSet = PetSpecialBuffConf[skillID]
	if getFuncSet then
		local handler = self.role:getHandler(FightEntityHandlerType.SkillHandler)
		-- 自身被动成功率加成
		local _, successRate = handler[getFuncSet[1]](handler)
		local ratio = successRate or 0
		
		local skillName = PetSkillDB[skillID].name or str
		Flog:log(skillName.." 成功率增加:"..ratio.." ")
		
		-- 目标是宠物时,判断目标是否有成功率减益的被动
		if instanceof(target, FightPet) then
			local t_handler = target:getHandler(FightEntityHandlerType.SkillHandler)
			local _, failureRate = t_handler[getFuncSet[2]](t_handler)
			failureRate = failureRate or 0
			ratio = ratio - failureRate
			Flog:log(" 成功率减少:"..failureRate.."\n")
		end
		if math.random(100) < 100 + ratio then
			return true
		end
	end
	return false
end

--[[
	增加特殊BUFF目标
]]
function AddBuffEffect:addSpecialBuffTarget(skillID)
	local _,_, getAddTargetNum = unpack(PetSpecialBuffConf[skillID])
	local handler = self.role:getHandler(FightEntityHandlerType.SkillHandler)
	local isTrue, num = handler[getAddTargetNum](handler)
	if isTrue then
		Flog:log(" 特殊buff增加目标:"..num.."\n")
		return num
	end
	return 0
end
