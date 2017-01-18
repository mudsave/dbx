--[[RevivalEffect.lua
	描述：处理技能效果相关逻辑
]]

RevivalEffect = class(SkillEffect)

--[[
	复活效果
]]
function RevivalEffect:doRevival(target)
	local prob = self.numValue / 10
	-- 测试
	-- prob = 100
	if (math.random(100) <= prob) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		handler:addRevivalTimes(1)
		target:setLifeState(RoleLifeState.Normal)
		return true
	end
	return false
end