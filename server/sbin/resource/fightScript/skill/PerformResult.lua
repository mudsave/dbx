--[[PerformResult.lua
	描述：战斗结果协议构造
--]]

--[[
	targetList结构:
	self.targetList = {
		[id] = {
			target = ,
			hp = ,
			mp = ,
			isDodge = 是否闪避,
			isDefense = 是否防御,
			isCritical = 是否暴击,
			isCounter = 是否反震,
			isValid = 是否无效,
			buffID =,
			hitStatus =,
			...
		},
		...
	}
]]

--[[
	protectList结构:
	self.protectList = {
		id = {
			target = ,
		},
		...
	}
]]

PerformResult = class()

--[[
	初始化战斗结果
]]
function PerformResult:__init()
	self.result 	= { actionList = {} }
end

function PerformResult:__release()
	self.result 	= nil
end

--[[
	合成结果集
]]
function PerformResult:compoundResult(skill, targetList, type)
	local setStr, addStr = select(3, unpack(SkillEffect2ActionMap[type]))
	local setResult = self[setStr]
	local addResultAction = self[addStr]
	-- 设置结果集信息
	if setResult then setResult(self, skill) end
	-- 添加结果集动作
	if addResultAction then addResultAction(self, targetList) end
end

--[[
	获取完善且合并后的结果集
]]
function PerformResult:getResult(skill)
	self:optimizeResult(skill)
	self:mergeResult()
	return self.result
end

--[[
	获取结果集中的actionList
]]
function PerformResult:getActionList()
	local result = self.result
	return result and result.actionList
end

--[[
	完善结果集信息(每种协议必需的条目)
]]
function PerformResult:optimizeResult(skill)
	local role = skill:getSkillRole()
	local result = self.result
	result.skillID 	= skill:getSkillID()		-- 技能ID
	result.roleID 	= role:getID()				-- 技能发出者ID
	local consumeType = skill:getConsumeType()
	if consumeType then
		result.consume_type		= consumeType
		result.consume_value	= 0 - skill:getRealConsumeValue()
	end
end

--[[
	设置普通伤害战斗结果
]]
function PerformResult:setNormalResult(skill)
	local result = self.result
	local role = skill:getSkillRole()
	result.actionType 	= FightActionType.UseCommonSkill		-- 战斗动作类型
	result.lifeState 	= role:getLifeState()					-- 技能发出者生命状态

	if instanceof(role, FightPlayer) then
		result.anger = role:get_anger()
	end
end

--[[
	设置普通伤害战斗治疗结果
]]
function PerformResult:setNormalResumeList(roleID, hpHeal)
	local result = self.result
	if not result.resumeList then
		result.resumeList = {}
	end
	result.resumeList[roleID] = {hp_heal = hpHeal or 0}
end

--[[
	添加普通伤害战斗治疗数值
]]
function PerformResult:addNormalResumeValue(roleID, hpHeal, mpHeal)
	local result = self.result
	if not result.resumeList then
		result.resumeList = {}
	end
	local resumeList = result.resumeList
	
	if not resumeList[roleID] then
		resumeList[roleID] = {}
	end
	
	local action = resumeList[roleID]
	if hpHeal then
		action.hp_heal = hpHeal + (action.hp_heal or 0)
	end
	if mpHeal then
		action.mp_heal = mpHeal + (action.mp_heal or 0)
	end
	
	-- print("添加ResumeList:", toString(self.result.resumeList))
	--[[
	if resumeList[roleID] then
		result.resumeList[roleID] = hpHeal + resumeList[roleID]
	else
		result.resumeList[roleID] = hpHeal
	end
	--]]
end

--[[
	添加保护结果集
]]
function PerformResult:addResultProtectors(targetID, protectList)
	if protectList then
		-- 不存在时初始化结果集的保护列表
		if not self.result.protectors then
			self.result.protectors = {}
		end
		local tempList = self.result.protectors
		-- 将保护列表中的角色插入到结果集的保护列表中
		for id, protector in pairs(protectList) do
			-- 获取保护者相关信息
			local protectorSet = {
				ID 				= id,								-- 保护者ID
				lifeState 		= protector.role:getLifeState(),	-- 保护者生命状态
				attrType 		= protector.attrType,				-- 保护者改变的属性类型
				changedValue 	= protector.changedValue,			-- 保护者改变的数值
			}
			if not tempList[targetID] then
				tempList[targetID] = {}
			end
			table.insert(tempList[targetID], protectorSet)
		end
		-- print("添加后的保护列表：", toString(self.result.protectors))
	end
end

--[[
	添加一次普通伤害执行动作
]]
function PerformResult:addNormalResultAction(targetList)
	local actionList = {}
	-- print("添加动作：", toString(targetList))
	-- 遍历技能所有指向的目标
	for id, targetStatus in pairs(targetList) do
		local target = targetStatus.target
		local action = {
			ID 				= id,								-- 受击者ID
			lifeState 		= target:getLifeState(),			-- 受击者生命状态
			status 			= targetStatus.statusType,			-- 受击者受击状态
			counterValue 	= targetStatus.counterValue,		-- 受击者反震量(负数)
			
			buffId			= targetStatus.buffID,
		}
		-- 受攻击者怒气
		if instanceof(target, FightPlayer) then
			action.anger = target:get_anger()
		end
		if targetStatus.hp then
			action.attrType = ResultAttrType.Hp
			action.changedValue = targetStatus.hp
		end
		if targetStatus.mp then
			action.attrType = ResultAttrType.Mp
			action.changedValue = targetStatus.mp
		end
		table.insert(actionList, action)
	end
	local result = self.result
	local list = result.attackActionList
	if not list then
		list = {}
		result.attackActionList = list
	end
	table.insert(list, actionList)
end

--[[
	设置合击结果
]]
function PerformResult:setUnionResult(skill)
	local result = self.result
	local role = skill:getSkillRole()
	result.actionType 	= FightActionType.UseUniteSkill
	-- 使用技能者怒气
	if instanceof(role, FightPlayer) then
		result.anger = role:get_anger()
	end
end

--[[
	添加一次合击执行动作
]]
function PerformResult:addUnionResultAction(targetList)
	-- print("添加合击动作：", toString(targetList))
	-- 遍历技能所有指向的目标
	for id, targetStatus in pairs(targetList) do
		local action = {
			attackerID 		= targetStatus.partnerID,				-- 合作者ID
			targetID 		= id,									-- 攻击目标ID
			lifeState 		= targetStatus.target:getLifeState(),	-- 攻击目标生命状态
			changedValue	= targetStatus.hp,						-- 攻击目标属性改变的数值
			status			= targetStatus.statusType,				-- 攻击目标受击状态
		}
		-- 受攻击者怒气
		if instanceof(target, FightPlayer) then
			action.anger = target:get_anger()
		end
		table.insert(self.result.actionList, action)
	end
end

--[[
	设置恢复结果
]]
function PerformResult:setResumeResult()
	local result = self.result
	if result.actionType and result.actionType == FightActionType.UseCommonSkill then
	else
		result.actionType 	= FightActionType.UseResumeSkill
	end
end

--[[
	添加一次恢复执行动作
]]
function PerformResult:addResumeResultAction(targetList)
	-- print("添加恢复动作：", toString(targetList))
	-- 遍历技能所有指向的目标
	for id, targetStatus in pairs(targetList) do
		if type(targetStatus) == 'table' then
			local action = {
				ID 				= id,
				buffId 			= targetStatus.buffID,
				hp_heal 		= targetStatus.hp,
				mp_heal			= targetStatus.mp,
			}
			table.insert(self.result.actionList, action)
		end
	end
end

--[[
	设置BUFF结果
]]
function PerformResult:setBuffResult(skill)
	local result = self.result
	local role = skill:getSkillRole()
	if result.actionType and result.actionType == FightActionType.UseCommonSkill 
	or result.actionType == FightActionType.UseResumeSkill then
	else
		result.actionType 	= FightActionType.UseBuffSkill
	end
	result.lifeState 	= role:getLifeState()
end

--[[
	添加一次BUFF执行动作
]]
function PerformResult:addBuffResultAction(targetList)
	-- print("添加BUFF动作：", toString(targetList))
	-- 遍历技能所有指向的目标
	for id, targetStatus in pairs(targetList) do
		if type(targetStatus) == 'table' then
			local action = {
				ID 				= id,
				buffId 			= targetStatus.buffID,
				hit_status 		= targetStatus.hitStatus,
			}
			table.insert(self.result.actionList, action)
		end
	end
	self:setBuffEffectInfo()
end

--[[
	添加BUFF光效信息
]]
function PerformResult:setBuffEffectInfo()
	local actionList = self:getActionList()
	if actionList then
		local buffID = actionList[1].buffId
		if buffID then
			local buffConfig = tFightingBuffDB[buffID]
			local kind = buffConfig.kind
			
			if LightingEffectType2[kind] then
				self.result.phaseType = LightingEffectType2[kind]
				self.result.skillAttrType = SkillAttrType.reducePhase
				return true
			end
			if LightingEffectType3[kind] then
				self.result.skillAttrType = SkillAttrType.addAndReduceAttr
				return true
			end
			
			local effects = buffConfig.effects
			local effect = effects[1]
			local attr_value = tBuffEffectValueDB[effect[2]][1]
			local add_or_reduce = attr_value>0 and 1 or -1
			if table.size(effects) > 1 then
				self.result.skillAttrType = SkillAttrType.addAndReduceAttr
				return true
			end
			local effectType = LightingEffectType[effect[1]]
			if effectType == 1 then
				if add_or_reduce == 1 then
					self.result.skillAttrType = SkillAttrType.addAttr
				else
					self.result.skillAttrType = SkillAttrType.reduceAttr
				end
				return true
			end
			if effectType == 2 then
				self.result.skillAttrType = SkillAttrType.absorbHurt
				return true
			end
			if effectType then
				self.result.phaseType = effectType
				if add_or_reduce == 1 then
					self.result.skillAttrType = SkillAttrType.addPhase
				else
					self.result.skillAttrType = SkillAttrType.reducePhase
				end
				return true
			end
		end
	end
end

--[[
	设置复活结果
]]
function PerformResult:setRevivalResult()
	local result = self.result
	result.actionType 	= FightActionType.Relive	-- 战斗动作类型
end

--[[
	添加一次复活执行动作
]]
function PerformResult:addRevivalResultAction(targetList)
	-- print("添加复活动作：", toString(targetList))
	-- 遍历技能所有指向的目标
	for id, targetStatus in pairs(targetList) do
		local action = {
			ID 				= id,
			hp_heal 		= targetStatus.hp,
			mp_heal 		= targetStatus.mp,
		}
		table.insert(self.result.actionList, action)
	end
end

--[[
	设置驱散结果
]]
function PerformResult:setDispelResult()
	local result = self.result
	if result.actionType and result.actionType == FightActionType.UseCommonSkill then
	else
		result.actionType 	= FightActionType.DispelSkill
	end
end

--[[
	添加一次驱散执行动作
]]
function PerformResult:addDispelResultAction(targetList)
	for id, targetStatus in pairs(targetList) do
		if targetStatus.dispel then
			local action = {
				ID 				= id,
				dispel			= true,
			}
			table.insert(self.result.actionList, action)
		end
	end
end

--[[
	合并结果集
]]
function PerformResult:mergeResult()
	local result = self.result
	if result.actionType ~= FightActionType.UseCommonSkill then
		result.actionList = self:mergeResulActionByID()
	else
		local attackActionList = result and result.attackActionList
		local actionList = result.actionList
		local ret = {}
		for i = 1, #actionList do
			local action = select(i, unpack(actionList))
			-- 如果有治疗效果
			if action.hp_heal then
				self:setNormalResumeList(action.ID, action.hp_heal)
			else
				for j = 1, #attackActionList do
					local tempActionList = select(j, unpack(attackActionList))
					-- 遍历攻击系技能attackActionList
					for _, pursueAction in ipairs(tempActionList) do
						-- 给技能释放者自身上BUFF
						if action.ID and result.roleID == action.ID then
							result.buffId = action.buffId
							result.dispel = action.dispel
						-- 给攻击目标上BUFF
						elseif pursueAction.ID and action.ID and pursueAction.ID == action.ID then
							for key, value in pairs(action) do
								pursueAction[key] = value
							end
						end
					end
				end
			end
			-- 处理过的表置为空表
			actionList[i] = {}
		end
		result.actionList = attackActionList
		result.attackActionList = nil
	end
end

--[[
	将传入的多个action中相同ID的action表合并(暂未使用)
]]
function PerformResult:mergeActionByID(...)
	local mytable = {...}
	local ret = {}
	for i = 1, #mytable do
		local tempAction = select(i, unpack(mytable))
		if tempAction then
			for j = 2, #mytable do
				local action = select(j, unpack(mytable))
				if tempAction.ID and action.ID and tempAction.ID == action.ID then
					for key, value in pairs(action) do
						tempAction[key] = value
					end
					-- 合并过的表置为空表
					mytable[j] = {}
				end
			end
			-- 排除空表
			if table.size(tempAction) ~= 0 then
				table.insert(ret, tempAction)
			end
		end
	end
	return ret
end

--[[
	将actionList中相同ID的action表合并(NormalResultAction不适用)
]]
function PerformResult:mergeResulActionByID()
	local mytable = self.result and self.result.actionList
	local ret = {}
	for i = 1, #mytable do
		local tempAction = select(i, unpack(mytable))
		if tempAction then
			for j = 2, #mytable do
				local action = select(j, unpack(mytable))
				if tempAction.ID and action.ID and tempAction.ID == action.ID then
					for key, value in pairs(action) do
						tempAction[key] = value
					end
					-- 合并过的表置为空表
					mytable[j] = {}
				end
			end
			-- 排除空表
			if table.size(tempAction) ~= 0 then
				table.insert(ret, tempAction)
			end
		end
	end
	return ret
end


