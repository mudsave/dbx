-- PlayerAttrDefine.lua
-- 玩家属性定义


PlayerAttrDefine = {}

-- defineAttr(属性名, 属性描述, 是否有公式, 能否需持久化)
local function defineAttr(name, desc, bExpr, bSave)
	local base = #PlayerAttrDefine + 1
	PlayerAttrDefine[base] = {
		name	= name,
		db		= bSave,
		expr	= bExpr,
	}
	_G[name] = base
end

--	一级属性：1
--	玩家在生成时就默认带有的属性
--	可以作用和影响其他属性，
--	一级属性条目下包含能变更一级属性本身的属性类型
defineAttr("player_str", "武力", true, false)
defineAttr("player_int", "智力", true, false)
defineAttr("player_sta", "根骨", true, false)
defineAttr("player_spi", "敏锐", true, false)
defineAttr("player_dex", "身法", true, false)

defineAttr("player_in_str", "先天武力", true, false)
defineAttr("player_in_int", "先天智力", true, false)
defineAttr("player_in_sta", "先天根骨", true, false)
defineAttr("player_in_spi", "先天敏锐", true, false)
defineAttr("player_in_dex", "先天身法", true, false)

defineAttr("player_attr_point", "可分配属性点", false, true)
defineAttr("player_str_point", "武力加点", false, true)
defineAttr("player_int_point", "智力加点", false, true)
defineAttr("player_sta_point", "根骨加点", false, true)
defineAttr("player_spi_point", "敏锐加点", false, true)
defineAttr("player_dex_point", "身法加点", false, true)

defineAttr("player_add_str", "武力加值", false, false)
defineAttr("player_add_int", "智力加值", false, false)
defineAttr("player_add_sta", "根骨加值", false, false)
defineAttr("player_add_spi", "敏锐加值", false, false)
defineAttr("player_add_dex", "身法加值", false, false)
defineAttr("player_add_base_attr", "所有属性加值", false, false)

defineAttr("player_win_phase", "风相性", true, false)
defineAttr("player_thu_phase", "雷相性", true, false)
defineAttr("player_ice_phase", "冰相性", true, false)
defineAttr("player_soi_phase", "土相性", true, false)
defineAttr("player_fir_phase", "火相性", true, false)
defineAttr("player_poi_phase", "毒相性", true, false)
defineAttr("player_add_all_phase", "所有相性加值", false, false)

defineAttr("player_win_phase_point", "风相性加点", false, true)
defineAttr("player_thu_phase_point", "雷相性加点", false, true)
defineAttr("player_ice_phase_point", "冰相性加点", false, true)
defineAttr("player_soi_phase_point", "土相性加点", false, true)
defineAttr("player_fir_phase_point", "火相性加点", false, true)
defineAttr("player_poi_phase_point", "毒相性加点", false, true)

defineAttr("player_add_win_phase", "风相性加值", false, false)
defineAttr("player_add_thu_phase", "雷相性加值", false, false)
defineAttr("player_add_ice_phase", "冰相性加值", false, false)
defineAttr("player_add_soi_phase", "土相性加值", false, false)
defineAttr("player_add_fir_phase", "火相性加值", false, false)
defineAttr("player_add_poi_phase", "毒相性加值", false, false)
defineAttr("player_phase_point", "可分配相性点", false, true)

-- 二级属性：
-- 受一级属性影响而产生变动的属性
-- 其本身也会受到来自于装备、buff等地方影响而受到改变
-- 二级属性条目下包含影响二级属性本身的属性类型
-- （命中率、暴击率、闪避率、抗暴率不单独列为三级属性，合并在二级属性条目下）
defineAttr("player_hp", "生命", false, true)
defineAttr("player_mp", "法力", false, true)

defineAttr("player_max_hp", "生命上限", true, false)
defineAttr("player_add_max_hp", "生命上限加值", false, false)
defineAttr("player_inc_max_hp", "生命上限加成", false, false)

defineAttr("player_max_mp", "法力上限", true, false)
defineAttr("player_add_max_mp", "法力上限加值", false, false)
defineAttr("player_inc_max_mp", "法力上限加成", false, false)

defineAttr("player_at", "物理攻击力", true, false)
defineAttr("player_add_at", "物理攻击加值", false, false)
defineAttr("player_inc_at", "物理攻击加成", false, false)

defineAttr("player_mt", "法术攻击力", true, false)
defineAttr("player_add_mt", "法术攻击加值", false, false)
defineAttr("player_inc_mt", "法术攻击加成", false, false)

defineAttr("player_add_at_mt", "全部攻击加值", false, false)
defineAttr("player_inc_at_mt", "全部攻击加成", false, false)

defineAttr("player_af", "物理防御力", true, false)
defineAttr("player_add_af", "物理防御加值", false, false)
defineAttr("player_inc_af", "物理防御加成", false, false)

defineAttr("player_mf", "法术防御力", true, false)
defineAttr("player_add_mf", "法术防御加值", false, false)
defineAttr("player_inc_mf", "法术防御加成", false, false)

defineAttr("player_add_af_mf", "全部防御加值", false, false)
defineAttr("player_inc_af_mf", "全部防御加成", false, false)

defineAttr("player_hit", "命中", true, false)
defineAttr("player_add_hit", "命中加值", false, false)
defineAttr("player_inc_hit", "命中加成", false, false)

defineAttr("player_dodge", "闪避", true, false)
defineAttr("player_add_dodge", "闪避加值", false, false)
defineAttr("player_inc_dodge", "闪避加成", false, false)

defineAttr("player_critical", "暴击", true, false)
defineAttr("player_add_critical", "暴击加值", false, false)
defineAttr("player_inc_critical", "暴击加成", false, false)

defineAttr("player_tenacity", "抗暴", true, false)
defineAttr("player_add_tenacity", "抗暴加值", false, false)
defineAttr("player_inc_tenacity", "抗暴加成", false, false)

defineAttr("player_speed", "速度", true, false)
defineAttr("player_add_speed", "速度加值", false, false)
defineAttr("player_inc_speed", "速度加成", false, false)

defineAttr("player_inc_obstacle_hit", "障碍命中加成", false, false)
defineAttr("player_inc_taunt_resist", "抗嘲讽加成", false, false)
defineAttr("player_inc_sopor_resist", "抗昏睡加成", false, false)
defineAttr("player_inc_chaos_resist", "抗混乱加成", false, false)
defineAttr("player_inc_freeze_resist", "抗冰冻加成", false, false)
defineAttr("player_inc_silent_resist", "抗沉默加成", false, false)
defineAttr("player_inc_toxicosis_resist", "抗中毒加成", false, false)
defineAttr("player_inc_obstacle_resist", "所有障碍抗性加成", false, false)

defineAttr("player_win_at", "风攻击", true, false)
defineAttr("player_thu_at", "雷攻击", true, false)
defineAttr("player_ice_at", "冰攻击", true, false)
defineAttr("player_soi_at", "土攻击", true, false)
defineAttr("player_fir_at", "火攻击", true, false)
defineAttr("player_poi_at", "毒攻击", true, false)

defineAttr("player_inc_win_at", "风攻击加成", false, false)
defineAttr("player_inc_thu_at", "雷攻击加成", false, false)
defineAttr("player_inc_ice_at", "冰攻击加成", false, false)
defineAttr("player_inc_soi_at", "土攻击加成", false, false)
defineAttr("player_inc_fir_at", "火攻击加成", false, false)
defineAttr("player_inc_poi_at", "毒攻击加成", false, false)

defineAttr("player_inc_phase_at", "所有相性攻击加成", false, false)

defineAttr("player_win_resist", "风抗", true, false)
defineAttr("player_thu_resist", "雷抗", true, false)
defineAttr("player_ice_resist", "冰抗", true, false)
defineAttr("player_soi_resist", "土抗", true, false)
defineAttr("player_fir_resist", "火抗", true, false)
defineAttr("player_poi_resist", "毒抗", true, false)

defineAttr("player_inc_win_resist", "风抗加成", false, false)
defineAttr("player_inc_thu_resist", "雷抗加成", false, false)
defineAttr("player_inc_ice_resist", "冰抗加成", false, false)
defineAttr("player_inc_soi_resist", "土抗加成", false, false)
defineAttr("player_inc_fir_resist", "火抗加成", false, false)
defineAttr("player_inc_poi_resist", "毒抗加成", false, false)

defineAttr("player_inc_phase_resist", "所有相性抗性加成", false, false)
defineAttr("player_inc_critical_effect", "暴击效果加成", false, false)

-- 三级属性：
-- 独立作用和影响玩家的属性值，不影响其他属性
-- 三级属性条目下包含影响三级属性自身的属性类型
defineAttr("player_stand_tao", "标准道行", true, false)
defineAttr("player_xp", "经验", false, true)
defineAttr("player_pot", "潜能", false, true)
defineAttr("player_expoint", "历练", false, true)
defineAttr("player_vigor", "体力", false, true)

defineAttr("player_mobile_speed", "移动速度", true, false)
defineAttr("player_add_mobile_speed", "移动速度加成", false, false)

defineAttr("player_tao", "道行", false, true)
defineAttr("player_anger", "怒气值", false, false)
defineAttr("player_combat", "战绩", false, true)
defineAttr("player_lvl", "等级", false, false)
defineAttr("player_next_xp", "升级经验", true, false)

defineAttr("player_counter", "反震率", true, false)
defineAttr("player_inc_counter", "反震率加成", false, false)
defineAttr("player_escape", "逃跑成功率", false, false)
defineAttr("player_inc_anger", "怒气获得加成", false, false)
defineAttr("player_inc_escape", "逃跑成功率加成", false, false)
defineAttr("player_inc_skill_trigger", "技能触发几率", false, false)
defineAttr("player_inc_chase", "追击率", false, false)
defineAttr("player_max_anger", "最大怒气", true, false)
defineAttr("player_inc_health", "治疗效果加成", false, false)
defineAttr("player_add_health", "治疗效果加值", false, false)
defineAttr("player_at_da", "吸收物理伤害总量", false, false)
defineAttr("player_mt_da", "吸收法术伤害总量", false, false)
defineAttr("player_dmg_da", "吸收全部伤害总量", false, false)
defineAttr("player_counter_dmg_add", "反震伤害加成", false, false)
defineAttr("player_kill", "杀气值", false, true)
defineAttr("player_unhit_rate", "反击率", false, false)
defineAttr("player_add_unhit_rate", "反击率加值", false, false)
defineAttr("player_max_vigor", "最大体力", true, false)
defineAttr("player_max_pet", "最大宠物数", false, true)
defineAttr("player_add_max_hm","生命、法力上限加值",false,false)
defineAttr("player_inc_max_hm","生命、法力上限加成",false,false)
defineAttr("player_inc_taunt_hit","嘲讽命中加成",false,false)
defineAttr("player_inc_soper_hit","催眠命中加成",false,false)
defineAttr("player_inc_chaos_hit","混乱命中加成",false,false)
defineAttr("player_inc_freeze_hit","冻结命中加成",false,false)
defineAttr("player_inc_silent_hit","沉默命中加成",false,false)
defineAttr("player_inc_toxicosis_hit","下毒命中加成",false,false)
defineAttr("player_dec_spell_cost","技能消耗降低",false,false)
defineAttr("player_rupture_rate","物理攻击破防率",false,false)
defineAttr("player_inc_rupture_effect","破防效果加成",false,false)
defineAttr("player_add_mind_level","玩家心法等级加值",false,false)
defineAttr("player_add_escape_rate","玩家逃跑率加值",false,true)
defineAttr("player_add_catchpet_rate","玩家抓宠率加值",false,true)
defineAttr("player_reduce_escape_rate","玩家对敌逃跑率减值",false,true)