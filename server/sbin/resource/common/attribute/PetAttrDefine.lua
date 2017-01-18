--　PetAttrDefine.lua
--	宠物属性定义

PetAttrDefine = {}

--　defineAttr(属性名, 属性描述, 是否有公式, 能否需持久化)
local function defineAttr(name,desc, bExpr, bSave)
	local base = #PetAttrDefine + 1
	PetAttrDefine[base] = {
		name = name,
		db = bSave,
		expr = bExpr
	}
	_G[name] = base
end

defineAttr("pet_hp", "生命", false, true)
defineAttr("pet_mp", "法力", false, true)
defineAttr("pet_tao", "道行", false, true)
defineAttr("pet_lvl", "等级", false, true)

defineAttr("pet_str", "武力", true, false)
defineAttr("pet_int", "智力", true, false)
defineAttr("pet_sta", "根骨", true, false)
defineAttr("pet_spi", "敏锐", true, false)
defineAttr("pet_dex", "身法", true, false)

defineAttr("pet_inborn_str", "出生分配武力", false,	true)
defineAttr("pet_inborn_int", "出生分配智力", false,	true)
defineAttr("pet_inborn_sta", "出生分配根骨", false,	true)
defineAttr("pet_inborn_spi", "出生分配敏锐", false,	true)
defineAttr("pet_inborn_dex", "出生分配身法", false,	true)

defineAttr("pet_in_str", "先天武力", true, false)
defineAttr("pet_in_int", "先天智力", true, false)
defineAttr("pet_in_sta", "先天根骨", true, false)
defineAttr("pet_in_spi", "先天敏锐", true, false)
defineAttr("pet_in_dex", "先天身法", true, false)

defineAttr("pet_str_point", "武力加点", false, true)
defineAttr("pet_int_point", "智力加点", false, true)
defineAttr("pet_sta_point", "根骨加点", false, true)
defineAttr("pet_spi_point", "敏锐加点", false, true)
defineAttr("pet_dex_point", "身法加点", false, true)

defineAttr("pet_attr_point", "可分配属性点", false, true)
defineAttr("pet_phase_point", "可分配相性点", false, true)

defineAttr("pet_add_str", "武力+", false, false)
defineAttr("pet_add_int", "智力+", false, false)
defineAttr("pet_add_sta", "根骨+", false, false)
defineAttr("pet_add_spi", "敏锐+", false, false)
defineAttr("pet_add_dex", "身法+", false, false)	 

defineAttr("pet_win_at", "风攻击", true, false)
defineAttr("pet_thu_at", "雷攻击", true, false)
defineAttr("pet_ice_at", "冰攻击", true, false)
defineAttr("pet_soi_at", "土攻击", true, false)
defineAttr("pet_fir_at", "火攻击", true, false)
defineAttr("pet_poi_at", "毒攻击", true, false)	 

defineAttr("pet_inc_win_at", "风攻击加成", false, false)
defineAttr("pet_inc_thu_at", "雷攻击加成", false, false)
defineAttr("pet_inc_ice_at", "冰攻击加成", false, false)
defineAttr("pet_inc_soi_at", "土攻击加成", false, false)
defineAttr("pet_inc_fir_at", "火攻击加成", false, false)
defineAttr("pet_inc_poi_at", "毒攻击加成", false, false)

defineAttr("pet_win_resist", "风抗", true, false)
defineAttr("pet_thu_resist", "雷抗", true, false)
defineAttr("pet_ice_resist", "冰抗", true, false)
defineAttr("pet_soi_resist", "土抗", true, false)
defineAttr("pet_fir_resist", "火抗", true, false)
defineAttr("pet_poi_resist", "毒抗", true, false)		

defineAttr("pet_inc_win_resist", "风抗加成", false, false)
defineAttr("pet_inc_thu_resist", "雷抗加成", false, false)
defineAttr("pet_inc_ice_resist", "冰抗加成", false, false)
defineAttr("pet_inc_soi_resist", "土抗加成", false, false)
defineAttr("pet_inc_fir_resist", "火抗加成", false, false)
defineAttr("pet_inc_poi_resist", "毒抗加成", false, false)

defineAttr("pet_fir_phase_point", "火相性加点", false, true)
defineAttr("pet_soi_phase_point", "土相性加点", false, true)
defineAttr("pet_win_phase_point", "风相性加点", false, true)
defineAttr("pet_poi_phase_point", "毒相性加点", false, true)
defineAttr("pet_ice_phase_point", "冰相性加点", false, true)
defineAttr("pet_thu_phase_point", "雷相性加点", false, true)  

defineAttr("pet_max_hp", "生命上限", true, false)
defineAttr("pet_add_max_hp", "生命上限+", false, false)
defineAttr("pet_inc_max_hp", "生命上限加成", false, false)	   

defineAttr("pet_max_mp", "法力上限", true, false)
defineAttr("pet_add_max_mp", "法力上限+", false, false)
defineAttr("pet_inc_max_mp", "法力上限加成", false, false)

defineAttr("pet_at", "物理攻击力", true, false)
defineAttr("pet_add_at", "物理攻击+", false, false)
defineAttr("pet_inc_at", "物理攻击加成", false, false)

defineAttr("pet_mt", "法术攻击力", true, false)
defineAttr("pet_add_mt", "法术攻击+", false, false)
defineAttr("pet_inc_mt", "法术攻击加成", false, false)

defineAttr("pet_af", "物理防御力", true, false)
defineAttr("pet_add_af", "物理防御+", false, false)
defineAttr("pet_inc_af", "物理防御加成", false, false)

defineAttr("pet_mf", "法术防御力", true, false)
defineAttr("pet_add_mf", "法术防御+", false, false)
defineAttr("pet_inc_mf", "法术防御加成", false, false)

defineAttr("pet_hit", "命中", true, false)
defineAttr("pet_add_hit", "命中+", false, false)
defineAttr("pet_inc_hit", "命中加成", false, false)

defineAttr("pet_dodge", "闪避", true, false)
defineAttr("pet_add_dodge", "闪避+", false, false)
defineAttr("pet_inc_dodge", "闪避加成", false, false)

defineAttr("pet_critical", "暴击", true, false)
defineAttr("pet_add_critical", "暴击+", false, false)
defineAttr("pet_inc_critical", "暴击加成", false, false)

defineAttr("pet_tenacity", "抗暴", true, false)
defineAttr("pet_add_tenacity", "抗暴+", false, false)
defineAttr("pet_inc_tenacity", "抗暴加成", false, false)

defineAttr("pet_speed", "速度", true, false)
defineAttr("pet_add_speed", "速度+", false, false)
defineAttr("pet_inc_speed", "速度加成", false, false)

defineAttr("pet_add_base_attr", "所有属性+", false, false)
defineAttr("pet_add_phase_at", "所有相性攻击+", false, false)
defineAttr("pet_inc_phase_at", "所有相性攻击加成+", false, false)
defineAttr("pet_add_phase_resist", "所有相性抗性+", false, false)
defineAttr("pet_inc_phase_resist", "所有相性抗性加成+", false, false)
defineAttr("pet_add_obstacle_resist", "所有障碍抗性+", false, false)
defineAttr("pet_inc_obstacle_resist", "所有障碍抗性加成+", false, false)

defineAttr("pet_capacity", "天资成长", false, true)
defineAttr("pet_at_grow", "物攻成长", false, true)
defineAttr("pet_af_grow", "物防成长", false, true)
defineAttr("pet_mt_grow", "法攻成长", false, true)
defineAttr("pet_mf_grow", "法防成长", false, true)
defineAttr("pet_hp_grow", "生命成长", false, true)
defineAttr("pet_at_speed_grow", "速度成长", false, true)

defineAttr("pet_capacity_max", "天资成长最大值", false, true)
defineAttr("pet_at_grow_max", "物攻成长最大值", false, true)
defineAttr("pet_af_grow_max", "物防成长最大值", false, true)
defineAttr("pet_mt_grow_max", "法攻成长最大值", false, true)
defineAttr("pet_mf_grow_max", "法防成长最大值", false, true)
defineAttr("pet_hp_grow_max", "生命成长最大值", false, true)
defineAttr("pet_at_speed_grow_max", "速度成长最大值", false, true)

defineAttr("pet_obstacle_hit", "障碍命中", false, false)

defineAttr("pet_taunt_resist", "抗嘲讽", true, false)
defineAttr("pet_inc_taunt_resist", "抗嘲讽加成", false, false)

defineAttr("pet_sopor_resist", "抗昏睡", true, false)
defineAttr("pet_inc_sopor_resist", "抗昏睡加成", false, false)

defineAttr("pet_chaos_resist", "抗混乱", true, false)
defineAttr("pet_inc_chaos_resist", "抗混乱加成", false, false)

defineAttr("pet_freeze_resist", "抗冰冻", true, false)
defineAttr("pet_inc_freeze_resist", "抗冰冻加成", false, false)

defineAttr("pet_silent_resist", "抗沉默", true, false)
defineAttr("pet_inc_silent_resist", "抗沉默加成", false, false)

defineAttr("pet_toxicosis_resist", "抗中毒", true, false)
defineAttr("pet_inc_toxicosis_resist", "抗中毒加成", false, false)

defineAttr("pet_chaos_phase_point", "混乱相性加点", false, true)
defineAttr("pet_taunt_phase_point", "嘲讽相性加点", false, true)
defineAttr("pet_sopor_phase_point", "昏睡相性加点", false, true)
defineAttr("pet_silent_phase_point", "沉默相性加点", false, true)
defineAttr("pet_freeze_phase_point", "冰冻相性加点", false, true)
defineAttr("pet_toxicosis_phase_point", "中毒相性加点", false, true)

defineAttr("pet_xp", "经验", false, true)
defineAttr("pet_next_xp", "升级经验", true, false)

defineAttr("pet_life", "当前寿命", false, true)
defineAttr("pet_life_max", "最大寿命", false, true)

defineAttr("pet_mobile_speed", "移动速度", false, false)
defineAttr("pet_add_mobile_speed", "移动速度加成", false, false)

defineAttr("pet_counter", "反震率", true, false)
defineAttr("pet_inc_counter", "反震率加成", false, false)

defineAttr("pet_escape", "逃跑成功率", false, false)
defineAttr("pet_inc_escape", "逃跑成功率加成", false, false)

defineAttr("pet_critical_effect", "暴击伤害", true, false)
defineAttr("pet_inc_critical_effect", "暴击伤害加成", false, false)

defineAttr("pet_inc_skill_trigger", "技能触发几率", false, false)
defineAttr("pet_inc_chase", "追击率", false, false)

defineAttr("pet_inc_health", "治疗效果加成", false, false)
defineAttr("pet_add_health", "治疗效果加值", false, false)

defineAttr("pet_allt", "全部攻击力", false, false)
defineAttr("pet_allf", "全部防御力", false, false)

defineAttr("pet_at_da", "吸收物理伤害总量", false, false)
defineAttr("pet_mt_da", "吸收法术伤害总量", false, false)
defineAttr("pet_dmg_da", "吸收全部伤害总量", false, false)

defineAttr("pet_stand_tao", "标准道行", true, false)

defineAttr("pet_unhit_rate", "反击率", true, false)
defineAttr("pet_add_unhit_rate", "反击率+", false, false)

defineAttr("pet_skill_max","宠物最大技能数量",false,true)
defineAttr("pet_up_comp","宠物强化完成度",false,true)
