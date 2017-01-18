--[[SystemSkillResult.lua
描述：技能结果集
]]
--[[
{	
	actionType = 技能类型，
	magicID = 技能id,
	actionList = 
	{
		{--受击者1
			ID = 受击者ID,
			lifeState = 生命状态,
			status = 受击状态(防御),
			attrType = 改变的属性类型,
			changedValue = 改变的值,
			buffId = buff,
			hp_heal = hp恢复,
			mp_heal = mp恢复,
		},
		{--受击者2
		}						
	},
}
--]]

-- 设置系统技能结果集
function SystemSkill:setSystemResult()
	self.result.actionType = FightActionType.SystemSkill
	self.result.magicID = self.id
	self.result.actionList = {}
	for id,targetStatus in pairs(self.targetsList) do
		if type(targetStatus) == 'table' then
			local action = {
				ID = id,
				lifeState = targetStatus.target:getLifeState(),
				status = self:getResultStatusType(id),
				attrType = targetStatus.attrType,
				changedValue = targetStatus.changedValue,
				buffId = targetStatus.buffId,
				hp_heal = targetStatus.hp,
				mp_heal = targetStatus.hp,
			}
			table.insert(self.result.actionList,action)
		end
	end
end