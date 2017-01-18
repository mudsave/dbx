--[[FightTest.lua
描述：
	临时的东西
--]]

--[[
	输出文件fight_log.txt供测试使用
]]
require "SkillConstant"
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
	--[[
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
	]]
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
	if true then return "" end
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