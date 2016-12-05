-- MonsterAttrDefine.lua
-- 怪物属性定义

local __base = 1

MonsterAttrDefine = {}

-- defineAttr(属性值, 属性名, 属性描述, 是否有公式, 能否需持久化)
local function defineAttr(name, desc, bExpr, bSave)
	local base = #MonsterAttrDefine + 1
	MonsterAttrDefine[base] = {
		name	= name,
		expr	= bExpr,
		db		= bSave,
	}
	_G[name] = base
end

-- 一级属性
defineAttr("monster_str", "武力", true, false)
defineAttr("monster_int", "智力", true, false)
defineAttr("monster_sta", "根骨", true, false)
defineAttr("monster_spi", "敏锐", true, false)
defineAttr("monster_dex", "身法", true, false)

defineAttr("monster_in_str", "先天武力", true, false)
defineAttr("monster_in_int", "先天智力", true, false)
defineAttr("monster_in_sta", "先天根骨", true, false)
defineAttr("monster_in_spi", "先天敏锐", true, false)
defineAttr("monster_in_dex", "先天身法", true, false)

defineAttr("monster_str_point", "武力加点", true, false)
defineAttr("monster_int_point", "智力加点", true, false)
defineAttr("monster_sta_point", "根骨加点", true, false)
defineAttr("monster_spi_point", "敏锐加点", true, false)
defineAttr("monster_dex_point", "身法加点", true, false)

defineAttr("monster_add_str", "武力+", false, false)
defineAttr("monster_add_int", "智力+", false, false)
defineAttr("monster_add_sta", "根骨+", false, false)
defineAttr("monster_add_spi", "敏锐+", false, false)
defineAttr("monster_add_dex", "身法+", false, false)
defineAttr("monster_add_base_attr", "所有属性+", false, false)

-- 二级属性
defineAttr("monster_hp", "生命", false, false)
defineAttr("monster_max_hp", "生命上限", true, false)
defineAttr("monster_add_max_hp", "生命上限+", false, false)
defineAttr("monster_inc_max_hp", "生命上限加成", false, false)

defineAttr("monster_at", "物理攻击力", true, false)
defineAttr("monster_add_at", "物理攻击+", false, false)
defineAttr("monster_inc_at", "物理攻击加成", false, false)

defineAttr("monster_mt", "法术攻击力", true, false)
defineAttr("monster_add_mt", "法术攻击+", false, false)
defineAttr("monster_inc_mt", "法术攻击加成", false, false)

defineAttr("monster_add_at_mt", "全部攻击+", false, false)
defineAttr("monster_inc_at_mt", "全部攻击加成", false, false)

defineAttr("monster_af", "物理防御力", true, false)
defineAttr("monster_add_af", "物理防御+", false, false)
defineAttr("monster_inc_af", "物理防御加成", false, false)

defineAttr("monster_mf", "法术防御力", true, false)
defineAttr("monster_add_mf", "法术防御+", false, false)
defineAttr("monster_inc_mf", "法术防御加成", false, false)

defineAttr("monster_add_af_mf", "全部防御+", false, false)
defineAttr("monster_inc_af_mf", "全部防御加成", false, false)

defineAttr("monster_hit", "命中", true, false)
defineAttr("monster_add_hit", "命中+", false, false)
defineAttr("monster_inc_hit", "命中加成", false, false)

defineAttr("monster_dodge", "闪避", true, false)
defineAttr("monster_add_dodge", "闪避+", false, false)
defineAttr("monster_inc_dodge", "闪避加成", false, false)

defineAttr("monster_critical", "暴击", true, false)
defineAttr("monster_add_critical", "暴击+", false, false)
defineAttr("monster_inc_critical", "暴击加成", false, false)

defineAttr("monster_tenacity", "抗暴", true, false)
defineAttr("monster_add_tenacity", "抗暴+", false, false)
defineAttr("monster_inc_tenacity", "抗暴加成", false, false)

defineAttr("monster_speed", "速度", true, false)
defineAttr("monster_add_speed", "速度+", false, false)
defineAttr("monster_inc_speed", "速度加成", false, false)

defineAttr("monster_add_obstacle_hit", "障碍命中+", false, false)
defineAttr("monster_add_taunt_resist", "抗嘲讽+", false, false)
defineAttr("monster_add_sopor_resist", "抗昏睡+", false, false)
defineAttr("monster_add_chaos_resist", "抗混乱+", false, false)
defineAttr("monster_add_freeze_resist", "抗冰冻+", false, false)
defineAttr("monster_add_silent_resist", "抗沉默+", false, false)
defineAttr("monster_add_toxicosis_resist", "抗中毒+", false, false)
defineAttr("monster_add_obstacle_resist", "所有障碍抗性加值", false, false)

defineAttr("monster_win_at", "风攻击", true, false)
defineAttr("monster_thu_at", "雷攻击", true, false)
defineAttr("monster_ice_at", "冰攻击", true, false)
defineAttr("monster_soi_at", "土攻击", true, false)
defineAttr("monster_fir_at", "火攻击", true, false)
defineAttr("monster_poi_at", "毒攻击", true, false)

defineAttr("monster_add_win_at", "风攻击+", false, false)
defineAttr("monster_add_thu_at", "雷攻击+", false, false)
defineAttr("monster_add_ice_at", "冰攻击+", false, false)
defineAttr("monster_add_soi_at", "土攻击+", false, false)
defineAttr("monster_add_fir_at", "火攻击+", false, false)
defineAttr("monster_add_poi_at", "毒攻击+", false, false)
defineAttr("monster_add_phase_at", "所有相性攻击+", false, false)

defineAttr("monster_win_resist", "风抗", true, false)
defineAttr("monster_thu_resist", "雷抗", true, false)
defineAttr("monster_ice_resist", "冰抗", true, false)
defineAttr("monster_soi_resist", "土抗", true, false)
defineAttr("monster_fir_resist", "火抗", true, false)
defineAttr("monster_poi_resist", "毒抗", true, false)

defineAttr("monster_add_win_resist", "风抗+", false, false)
defineAttr("monster_add_thu_resist", "雷抗+", false, false)
defineAttr("monster_add_ice_resist", "冰抗+", false, false)
defineAttr("monster_add_soi_resist", "土抗+", false, false)
defineAttr("monster_add_fir_resist", "火抗+", false, false)
defineAttr("monster_add_poi_resist", "毒抗+", false, false)
defineAttr("monster_add_phase_resist", "所有相性抗性+", false, false)
defineAttr("monster_inc_critical_effect", "暴击效果加成", false, false)

-- 三级属性
defineAttr("monster_lvl", "等级", false, false)
defineAttr("monster_tao", "道行", true, false)
defineAttr("monster_inc_skill_trigger", "技能触发几率", false, false)
defineAttr("monster_inc_chase", "追击率", false, false)
defineAttr("monster_inc_health", "治疗效果加成", false, false)
defineAttr("monster_add_health", "治疗效果加值", false, false)
defineAttr("monster_at_da", "吸收物理伤害总量", false, false)
defineAttr("monster_mt_da", "吸收法术伤害总量", false, false)
defineAttr("monster_dmg_da", "吸收全部伤害总量", false, false)
defineAttr("monster_tao_coffi", "道行系数", false, false)
defineAttr("monster_str_coffi", "武力系数", false, false)
defineAttr("monster_int_coffi", "智力系数", false, false)
defineAttr("monster_sta_coffi", "根骨系数", false, false)
defineAttr("monster_spi_coffi", "敏锐系数", false, false)
defineAttr("monster_dex_coffi", "身法系数", false, false)
defineAttr("monster_counter", "反震", true, false)
defineAttr("monster_inc_counter", "反震加成", false, false)
defineAttr("monster_unhit_rate", "反击率", true, false)
defineAttr("monster_add_unhit_rate", "反击率+", false, false)
defineAttr("monster_stand_tao", "标准道行", true, false)