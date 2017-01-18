--[[ExperienceDB.lua
描述：历练系统配置
	]]
ExperienceDB = {
	[1] = {
		--名字
		name = "攻击",
		--tip显示描述
		desc = "提升后可直接提高角色的物理和法术攻击",
		effectsDesc = "提升角色物理和法术攻击",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_016",
		-- 属性类型
		attrType = player_add_at_mt,
		--效果
		effect = ExperienceEffectDB[1],
		-- 历练消耗
		expCost = ExperienceExpCostDB[1],
		},
	[2] = {
		--名字
		name = "防御",
		--tip显示描述
		desc = "提升后可直接提高角色的物理和法术方防御",
		effectsDesc = "提升角色物理和法术防御",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_017",
		-- 属性类型
		attrType = player_add_af_mf,
		--效果
		effect = ExperienceEffectDB[2],
		-- 历练消耗
		expCost = ExperienceExpCostDB[2],
		},
	[3] = {
		--名字
		name = "暴击",
		--tip显示描述
		desc = "提升后可直接提高角色的暴击",
		effectsDesc = "提升角色暴击",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_018",
		-- 属性类型
		attrType = player_add_critical,
		--效果
		effect = ExperienceEffectDB[3],
		-- 历练消耗
		expCost = ExperienceExpCostDB[3],
		},

	[4] = {
		--名字
		name = "抗暴",
		--tip显示描述
		desc = "提升后可直接提高角色的抗暴",
		effectsDesc = "提升角色抗暴",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_019",
		-- 属性类型
		attrType = player_add_tenacity,
		--效果
		effect = ExperienceEffectDB[4],
		-- 历练消耗
		expCost = ExperienceExpCostDB[4],
		},

	[5] = {
		--名字
		name = "速度",
		--tip显示描述
		desc = "提升后可直接提高角色的速度",
		effectsDesc = "提升角色速度",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_020",
		-- 属性类型
		attrType = player_add_speed,
		--效果
		effect = ExperienceEffectDB[5],
		-- 历练消耗
		expCost = ExperienceExpCostDB[5],
		},
	[6] = {
		--名字
		name = "命中",
		--tip显示描述
		desc = "提升后可直接提高角色的命中",
		effectsDesc = "提升角色命中",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_021",
		-- 属性类型
		attrType = player_add_hit,
		--效果
		effect = ExperienceEffectDB[6],
		-- 历练消耗
		expCost = ExperienceExpCostDB[6],
		},
	[7] = {
		--名字
		name = "闪避",
		--tip显示描述
		desc = "提升后可直接提高角色的闪避",
		effectsDesc = "提升角色闪避",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_022",
		-- 属性类型
		attrType = player_add_dodge,
		--效果
		effect = ExperienceEffectDB[7],
		-- 历练消耗
		expCost = ExperienceExpCostDB[7],
		},
	[8] = {
		--名字
		name = "生存",
		--tip显示描述
		desc = "提升后可直接提高角色的生命和法力值",
		effectsDesc = "提升角色生命和法力值",
		-- 图标
		icon = "set:SkillIcon image:tb_jn_w1_023",
		-- 属性类型
		attrType = player_add_max_hm,
		--效果
		effect = ExperienceEffectDB[8],
		-- 历练消耗
		expCost = ExperienceExpCostDB[8],
		},
}