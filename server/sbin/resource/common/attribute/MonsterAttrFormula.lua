-- MonsterAttrFormula.lua
-- 怪物属性公式


require "misc.constant"

local math_pow		= math.pow
local math_ceil		= math.ceil
local math_floor	= math.floor

MonsterAttrbuteFormula = {}

-----------------------------------------------------------------------
--策划配置
-----------------------------------------------------------------------

--先天武力
function MonsterAttrbuteFormula.monster_in_str(monster)
	return 0
end

--先天智力
function MonsterAttrbuteFormula.monster_in_int(monster)
	return 0
end

--先天根骨
function MonsterAttrbuteFormula.monster_in_sta(monster)
	return 0
end

--先天敏锐
function MonsterAttrbuteFormula.monster_in_spi(monster)
	return 0
end

--先天身法
function MonsterAttrbuteFormula.monster_in_dex(monster)
	return 0
end

--武力加点
function MonsterAttrbuteFormula.monster_str_point(monster)
	return 0
end

--智力加点
function MonsterAttrbuteFormula.monster_int_point(monster)
	return 0
end

--根骨加点
function MonsterAttrbuteFormula.monster_sta_point(monster)
	return 0
end

--敏锐加点
function MonsterAttrbuteFormula.monster_spi_point(monster)
	return 0
end

--身法加点
function MonsterAttrbuteFormula.monster_dex_point(monster)
	return 0
end


--道行：等级^3*道行系数
--修改后：无公式
function MonsterAttrbuteFormula.monster_tao(monster)
	local level = monster:getAttrValue(monster_lvl)
	local monster_tao_coffi = monster:getAttrValue(monster_tao_coffi)
	return 0
end

--武力：先天武力+（怪物等级-1）*武力加点+（怪物等级-1）*5*武力系数
function MonsterAttrbuteFormula.monster_str(monster)
	local level = monster:getAttrValue(monster_lvl)
	local monster_in_str = monster:getAttrValue(monster_in_str)
	local monster_str_point = monster:getAttrValue(monster_str_point)
	local monster_str_coffi = monster:getAttrValue(monster_str_coffi)
	return 0
end

--智力：先天智力+（怪物等级-1）*智力加点+（怪物等级-1）*5*智力系数
function MonsterAttrbuteFormula.monster_int(monster)
	local level = monster:getAttrValue(monster_lvl)
	local monster_in_int = monster:getAttrValue(monster_in_int)
	local monster_int_point = monster:getAttrValue(monster_int_point)
	local monster_int_coffi = monster:getAttrValue(monster_int_coffi)
	return 0
end

--根骨：先天根骨+（怪物等级-1）*根骨加点+（怪物等级-1）*5*根骨系数
function MonsterAttrbuteFormula.monster_sta(monster)
	local level = monster:getAttrValue(monster_lvl)
	local monster_in_sta = monster:getAttrValue(monster_in_sta)
	local monster_sta_point = monster:getAttrValue(monster_sta_point)
	local monster_sta_coffi = monster:getAttrValue(monster_sta_coffi)
	return 0
end

--敏锐：先天敏锐+（怪物等级-1）*敏锐加点+（怪物等级-1）*5*敏锐系数
function MonsterAttrbuteFormula.monster_spi(monster)
	local level = monster:getAttrValue(monster_lvl)
	local monster_in_spi = monster:getAttrValue(monster_in_spi)
	local monster_spi_point = monster:getAttrValue(monster_spi_point)
	local monster_spi_coffi = monster:getAttrValue(monster_spi_coffi)
	return 0
end

--身法：先天身法+（怪物等级-1）*身法加点+（怪物等级-1）*5*身法系数
function MonsterAttrbuteFormula.monster_dex(monster)
	local level = monster:getAttrValue(monster_lvl)
	local monster_in_dex = monster:getAttrValue(monster_in_dex)
	local monster_dex_point = monster:getAttrValue(monster_dex_point)
	local monster_dex_coffi = monster:getAttrValue(monster_dex_coffi)
	return 0
end

--风攻击:风攻击加值+所有相性攻击加值
function MonsterAttrbuteFormula.monster_win_at(monster)
	local monster_add_win_at = monster:getAttrValue(monster_add_win_at)
	local monster_add_phase_at = monster:getAttrValue(monster_add_phase_at)
	return math_floor(monster_add_win_at+monster_add_phase_at)
end

--雷攻击:雷攻击加值+所有相性攻击加值
function MonsterAttrbuteFormula.monster_thu_at(monster)
	local monster_add_thu_at = monster:getAttrValue(monster_add_thu_at)
	local monster_add_phase_at = monster:getAttrValue(monster_add_phase_at)
	return math_floor(monster_add_thu_at+monster_add_phase_at)
end

--冰攻击:冰攻击加值+所有相性攻击加值
function MonsterAttrbuteFormula.monster_ice_at(monster)
	local monster_add_ice_at = monster:getAttrValue(monster_add_ice_at)
	local monster_add_phase_at = monster:getAttrValue(monster_add_phase_at)
	return math_floor(monster_add_ice_at+monster_add_phase_at)
end

--火攻击:火攻击加值+所有相性攻击加值
function MonsterAttrbuteFormula.monster_fir_at(monster)
	local monster_add_fir_at = monster:getAttrValue(monster_add_fir_at)
	local monster_add_phase_at = monster:getAttrValue(monster_add_phase_at)
	return math_floor(monster_add_fir_at+monster_add_phase_at)
end

--土攻击:土攻击加值+所有相性攻击加值
function MonsterAttrbuteFormula.monster_soi_at(monster)
	local monster_add_soi_at = monster:getAttrValue(monster_add_soi_at)
	local monster_add_phase_at = monster:getAttrValue(monster_add_phase_at)
	return math_floor(monster_add_soi_at+monster_add_phase_at)
end

--毒攻击:毒攻击加值+所有相性攻击加值
function MonsterAttrbuteFormula.monster_poi_at(monster)
	local monster_add_poi_at = monster:getAttrValue(monster_add_poi_at)
	local monster_add_phase_at = monster:getAttrValue(monster_add_phase_at)
	return math_floor(monster_add_poi_at+monster_add_phase_at)
end

--风抗:风抗加值+所有相性抗性加值
function MonsterAttrbuteFormula.monster_win_resist(monster)
	local monster_add_win_resist = monster:getAttrValue(monster_add_win_resist)
	local monster_add_phase_resist = monster:getAttrValue(monster_add_phase_resist)
	return math_floor(monster_add_win_resist+monster_add_phase_resist)
end

--雷抗:雷抗加值+所有相性抗性加值
function MonsterAttrbuteFormula.monster_thu_resist(monster)
	local monster_add_thu_resist = monster:getAttrValue(monster_add_thu_resist)
	local monster_add_phase_resist = monster:getAttrValue(monster_add_phase_resist)
	return math_floor(monster_add_thu_resist+monster_add_phase_resist)
end

--冰抗:冰抗加值+所有相性抗性加值
function MonsterAttrbuteFormula.monster_ice_resist(monster)
	local monster_add_ice_resist = monster:getAttrValue(monster_add_ice_resist)
	local monster_add_phase_resist = monster:getAttrValue(monster_add_phase_resist)
	return math_floor(monster_add_ice_resist+monster_add_phase_resist)
end

--火抗:火抗加值+所有相性抗性加值
function MonsterAttrbuteFormula.monster_fir_resist(monster)
	local monster_add_fir_resist = monster:getAttrValue(monster_add_fir_resist)
	local monster_add_phase_resist = monster:getAttrValue(monster_add_phase_resist)
	return math_floor(monster_add_fir_resist+monster_add_phase_resist)
end

--土抗:土抗加值+所有相性抗性加值
function MonsterAttrbuteFormula.monster_soi_resist(monster)
	local monster_add_soi_resist = monster:getAttrValue(monster_add_soi_resist)
	local monster_add_phase_resist = monster:getAttrValue(monster_add_phase_resist)
	return math_floor(monster_add_soi_resist+monster_add_phase_resist)
end

--毒抗:毒抗加值+所有相性抗性加值
function MonsterAttrbuteFormula.monster_poi_resist(monster)
	local monster_add_poi_resist = monster:getAttrValue(monster_add_poi_resist)
	local monster_add_phase_resist = monster:getAttrValue(monster_add_phase_resist)
	return math_floor(monster_add_poi_resist+monster_add_phase_resist)
end

--生命上限:(根骨*30+等级^2/5)*(1+生命上限加成）+生命上限加值
--修改后：(生命上限加值)*(1+生命上限加成）
function MonsterAttrbuteFormula.monster_max_hp(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_sta = monster:getAttrValue(monster_sta)
	local monster_inc_max_hp = monster:getAttrValue(monster_inc_max_hp) / 1000
	local monster_add_max_hp = monster:getAttrValue(monster_add_max_hp)
	--return math_floor((monster_sta*30+math_pow(level,2)/5)*(1+monster_inc_max_hp)+monster_add_max_hp)
	return math_floor(monster_add_max_hp*(1+monster_inc_max_hp))
end

--物理攻击力:(等级^2/5+武力*12-50)*(1+物理攻击加成）+物理攻击加值
--修改后：物理攻击加值*(1+物理攻击加成）
function MonsterAttrbuteFormula.monster_at(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_str = monster:getAttrValue(monster_str)
	local monster_inc_at = monster:getAttrValue(monster_inc_at) / 1000
	local monster_add_at = monster:getAttrValue(monster_add_at)
	--return math_floor((math_pow(level,2)/5+monster_str*12-50)*(1+monster_inc_at)+monster_add_at)
	return math_floor(monster_add_at*(1+monster_inc_at))
end

--法术攻击力:(等级^2/5+智力*12-50)*(1+法术攻击加成）+法术攻击加值
--修改后：法术攻击加值*(1+法术攻击加成）
function MonsterAttrbuteFormula.monster_mt(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_int = monster:getAttrValue(monster_int)
	local monster_inc_mt = monster:getAttrValue(monster_inc_mt) / 1000
	local monster_add_mt = monster:getAttrValue(monster_add_mt)
	--return math_floor((math_pow(level,2)/5+monster_int*12-50)*(1+monster_inc_mt)+monster_add_mt)
	return math_floor(monster_add_mt*(1+monster_inc_mt))
end

--物理防御力：(等级^2/5+根骨*8-40)*(1+物理防御加成)+物理防御加值
--修改后：物理防御加值*(1+物理防御加成)
function MonsterAttrbuteFormula.monster_af(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_sta = monster:getAttrValue(monster_sta)
	local monster_inc_af = monster:getAttrValue(monster_inc_af) / 1000
	local monster_add_af = monster:getAttrValue(monster_add_af)
	--return math_floor((math_pow(level,2)/5+monster_sta*8-40)*(1+monster_inc_af)+monster_add_af)
	return math_floor(monster_add_af*(1+monster_inc_af))
end

--法术防御力：(等级^2/5+根骨*8-40)*(1+法术防御加成)+法术防御加值
--修改后：法术防御加值*(1+法术防御加成)
function MonsterAttrbuteFormula.monster_mf(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_sta = monster:getAttrValue(monster_sta)
	local monster_inc_mf = monster:getAttrValue(monster_inc_mf) / 1000
	local monster_add_mf = monster:getAttrValue(monster_add_mf)
	--return math_floor((math_pow(level,2)/5+monster_sta*8-40)*(1+monster_inc_mf)+monster_add_mf)
	return math_floor(monster_add_mf*(1+monster_inc_mf))
end

--命中:(武力*0.5+智力*0.5+敏锐*1+等级*0.5)*(1+命中加成)+命中加值
--修改后：命中加值*(1+命中加成)
function MonsterAttrbuteFormula.monster_hit(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_str = monster:getAttrValue(monster_str)
	--local monster_int = monster:getAttrValue(monster_int)
	--local monster_spi = monster:getAttrValue(monster_spi)
	local monster_add_hit = monster:getAttrValue(monster_add_hit)
	local monster_inc_hit = monster:getAttrValue(monster_inc_hit)
	--return math_floor((monster_str*0.5+monster_int*0.5+monster_spi*1+level*0.5)*(1+monster_inc_hit)+monster_add_hit)
	return math_floor(monster_add_hit*(1+monster_inc_hit))
end

--闪避:（身法*1.2+等级*0.5）*（1+闪避加成）+闪避加值
--修改后：闪避加值*（1+闪避加成）
function MonsterAttrbuteFormula.monster_dodge(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_dex = monster:getAttrValue(monster_dex)
	local monster_inc_dodge = monster:getAttrValue(monster_inc_dodge) / 1000
	local monster_add_dodge = monster:getAttrValue(monster_add_dodge)
	--return math_floor((monster_dex*1.2+level*0.5)*(1+monster_inc_dodge)+monster_add_dodge)
	return math_floor(monster_add_dodge*(1+monster_inc_dodge))
end

--暴击:（敏锐*1.5+等级/2）*（1+暴击加成）+暴击加值
--修改后：暴击加值*（1+暴击加成）
function MonsterAttrbuteFormula.monster_critical(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_spi = monster:getAttrValue(monster_spi)
	local monster_inc_critical = monster:getAttrValue(monster_inc_critical) / 1000
	local monster_add_critical = monster:getAttrValue(monster_add_critical)
	--return math_floor((monster_spi*1.5+level/2)*(1+monster_inc_critical)+monster_add_critical)
	return math_floor(monster_add_critical*(1+monster_inc_critical))
end

--抗暴:（敏锐*0.8+等级/2）*（1+抗暴加成）+抗暴加值
--修改后：抗暴加值*（1+抗暴加成）
function MonsterAttrbuteFormula.monster_tenacity(monster)
	--local level = monster:getAttrValue(monster_lvl)
	--local monster_spi = monster:getAttrValue(monster_spi)
	local monster_inc_tenacity = monster:getAttrValue(monster_inc_tenacity) / 1000
	local monster_add_tenacity = monster:getAttrValue(monster_add_tenacity)
	--return math_floor((level/2+monster_spi*0.8)*(1+monster_inc_tenacity)+monster_add_tenacity)
	return math_floor(monster_add_tenacity*(1+monster_inc_tenacity))
end

--速度:（身法*1.2+等级*0.5）*（1+速度加成）+速度加值
--修改后：速度加值*（1+速度加成）
function MonsterAttrbuteFormula.monster_speed(monster)
	--local level = monster:getAttrValue(monster_lvl)
	local monster_inc_speed = monster:getAttrValue(monster_inc_speed) / 1000
	local monster_add_speed = monster:getAttrValue(monster_add_speed)
	--local monster_dex = monster:getAttrValue(monster_dex)
	--return math_floor((monster_dex*1.2+level*0.5)*(1+monster_inc_speed)+monster_add_speed)
	return math_floor(monster_add_speed*(1+monster_inc_speed))
end

--反震
function MonsterAttrbuteFormula.monster_counter(monster)
	return 0
end

--反击
function MonsterAttrbuteFormula.monster_unhit_rate(monster)
	return 0
end

-- 标准道行
function MonsterAttrbuteFormula.monster_stand_tao(monster)
	local level = monster:getAttrValue(monster_lvl)
	return math_floor(math_pow(level,3)*0.29 + 73)
end


--属性影响关系
g_AttrMonsterInfluenceTable =
{
	-- 一级属性
	[monster_str]						= {monster_hit,monster_at},
	[monster_int]						= {monster_hit,monster_mt},
	[monster_sta]						= {monster_tenacity,monster_mf,monster_af,monster_max_hp},
	[monster_spi]						= {monster_critical,monster_hit,monster_af,monster_mf},
	[monster_dex]						= {monster_speed,monster_dodge,monster_af,monster_max_hp},
	[monster_in_str]					= {monster_str},
	[monster_in_int]					= {monster_int},
	[monster_in_sta]					= {monster_sta},
	[monster_in_spi]					= {monster_spi},
	[monster_in_dex]					= {monster_dex},
	[monster_str_point]					= {monster_str},
	[monster_int_point]					= {monster_int},
	[monster_sta_point]					= {monster_sta},
	[monster_spi_point]					= {monster_spi},
	[monster_dex_point]					= {monster_dex},
	[monster_add_str]					= {monster_str},
	[monster_add_int]					= {monster_int},
	[monster_add_sta]					= {monster_sta},
	[monster_add_spi]					= {monster_spi},
	[monster_add_dex]					= {monster_dex},
	[monster_add_base_attr]				= {monster_str,monster_int,monster_sta,monster_spi,monster_dex},

	-- 二级属性
	[monster_add_max_hp]				= {monster_max_hp},
	[monster_inc_max_hp]				= {monster_max_hp},
	[monster_inc_at]					= {monster_at},
	[monster_add_at]					= {monster_at},
	[monster_inc_mt]					= {monster_mt},
	[monster_add_mt]					= {monster_mt},
	[monster_add_at_mt]                 = {monster_at,monster_mt},
	[monster_inc_at_mt]                 = {monster_at,monster_mt},
	[monster_add_af]					= {monster_af},
	[monster_inc_af]                    = {monster_af},
	[monster_add_mf]					= {monster_mf},
	[monster_inc_mf]                    = {monster_mf},
	[monster_add_af_mf]                 = {monster_af,monster_mf},
	[monster_inc_af_mf]                 = {monster_af,monster_mf},
	[monster_add_hit]					= {monster_hit},
	[monster_inc_hit]					= {monster_hit},
	[monster_add_dodge]					= {monster_dodge},
	[monster_inc_dodge]					= {monster_dodge},
	[monster_add_critical]              = {monster_critical},
	[monster_inc_critical]				= {monster_critical},
	[monster_add_tenacity]              = {monster_tenacity},
	[monster_inc_tenacity]				= {monster_tenacity},
	[monster_add_speed]                 = {monster_speed},
	[monster_inc_speed]					= {monster_speed},
	[monster_add_obstacle_resist]		= {monster_add_taunt_resist,monster_add_sopor_resist,monster_add_chaos_resist,monster_add_freeze_resist,monster_add_silent_resist,monster_add_toxicosis_resist},
	[monster_add_win_at]				= {monster_win_at},
	[monster_add_thu_at]				= {monster_thu_at},
	[monster_add_ice_at]				= {monster_ice_at},
	[monster_add_fir_at]				= {monster_fir_at},
	[monster_add_soi_at]				= {monster_soi_at},
	[monster_add_poi_at]				= {monster_poi_at},
	[monster_add_phase_at]				= {monster_win_at,monster_thu_at,monster_ice_at,monster_fir_at,monster_soi_at,monster_poi_at},
	[monster_add_win_resist]			= {monster_win_resist},
	[monster_add_thu_resist]			= {monster_thu_resist},
	[monster_add_ice_resist]			= {monster_ice_resist},
	[monster_add_fir_resist]			= {monster_fir_resist},
	[monster_add_soi_resist]			= {monster_soi_resist},
	[monster_add_poi_resist]			= {monster_poi_resist},
	[monster_add_phase_resist]			= {monster_win_resist,monster_thu_resist,monster_ice_resist,monster_fir_resist,monster_soi_resist,monster_poi_resist},

	-- 三级属性
	[monster_lvl]			            = {monster_tao,monster_str,monster_int,monster_sta,monster_spi,monster_dex,monster_max_hp,monster_at,monster_mt,monster_af,monster_mf,monster_hit,monster_dodge,monster_critical,monster_tenacity,monster_speed, monster_stand_tao},
}

--属性公式对照表
g_AttributeMonsterFormat =
{
	[monster_str]						= MonsterAttrbuteFormula.monster_str,
	[monster_int]						= MonsterAttrbuteFormula.monster_int,
	[monster_sta]						= MonsterAttrbuteFormula.monster_sta,
	[monster_spi]						= MonsterAttrbuteFormula.monster_spi,
	[monster_dex]						= MonsterAttrbuteFormula.monster_dex,
	[monster_in_str]					= MonsterAttrbuteFormula.monster_in_str,
	[monster_in_int]					= MonsterAttrbuteFormula.monster_in_int,
	[monster_in_sta]					= MonsterAttrbuteFormula.monster_in_sta,
	[monster_in_spi]					= MonsterAttrbuteFormula.monster_in_spi,
	[monster_in_dex]					= MonsterAttrbuteFormula.monster_in_dex,
	[monster_str_point]                 = MonsterAttrbuteFormula.monster_str_point,
	[monster_int_point]                 = MonsterAttrbuteFormula.monster_int_point,
	[monster_sta_point]                 = MonsterAttrbuteFormula.monster_sta_point,
	[monster_spi_point]                 = MonsterAttrbuteFormula.monster_spi_point,
	[monster_dex_point]                 = MonsterAttrbuteFormula.monster_dex_point,
	[monster_at]						= MonsterAttrbuteFormula.monster_at,
	[monster_mt]						= MonsterAttrbuteFormula.monster_mt,
	[monster_af]						= MonsterAttrbuteFormula.monster_af,
	[monster_mf]						= MonsterAttrbuteFormula.monster_mf,
	[monster_hit]						= MonsterAttrbuteFormula.monster_hit,
	[monster_dodge]						= MonsterAttrbuteFormula.monster_dodge,
	[monster_critical]					= MonsterAttrbuteFormula.monster_critical,
	[monster_tenacity]					= MonsterAttrbuteFormula.monster_tenacity,
	[monster_speed]						= MonsterAttrbuteFormula.monster_speed,
	[monster_win_at]					= MonsterAttrbuteFormula.monster_win_at,
	[monster_thu_at]					= MonsterAttrbuteFormula.monster_thu_at,
	[monster_ice_at]					= MonsterAttrbuteFormula.monster_ice_at,
	[monster_fir_at]					= MonsterAttrbuteFormula.monster_fir_at,
	[monster_soi_at]					= MonsterAttrbuteFormula.monster_soi_at,
	[monster_poi_at]					= MonsterAttrbuteFormula.monster_poi_at,
	[monster_win_resist]				= MonsterAttrbuteFormula.monster_win_resist,
	[monster_thu_resist]				= MonsterAttrbuteFormula.monster_thu_resist,
	[monster_ice_resist]				= MonsterAttrbuteFormula.monster_ice_resist,
	[monster_fir_resist]				= MonsterAttrbuteFormula.monster_fir_resist,
	[monster_soi_resist]				= MonsterAttrbuteFormula.monster_soi_resist,
	[monster_poi_resist]				= MonsterAttrbuteFormula.monster_poi_resist,
	[monster_max_hp]					= MonsterAttrbuteFormula.monster_max_hp,
	--[monster_tao]						= MonsterAttrbuteFormula.monster_tao,
	[monster_counter]					= MonsterAttrbuteFormula.monster_counter,
	[monster_unhit_rate]				= MonsterAttrbuteFormula.monster_unhit_rate,
	[monster_stand_tao]					= MonsterAttrbuteFormula.monster_stand_tao,
}

-----------------------------------------------------------------------
--程序配置
-----------------------------------------------------------------------
--属性对应的属性同步
g_AttributeMonsterToProp =
{
	
}

--需要立刻更新的属性
g_AttrMonsterSyncTable =
{
	[monster_in_str] = true,
	[monster_in_int] = true,
	[monster_in_sta] = true,
	[monster_in_spi] = true,
	[monster_in_dex] = true,
	--[monster_str] = true,
	[monster_int] = true,
	[monster_sta] = true,
	[monster_spi] = true,
	[monster_dex] = true,
	[monster_win_at] = true,
	[monster_thu_at] = true,
	[monster_ice_at] = true,
	[monster_fir_at] = true,
	[monster_soi_at] = true,
	[monster_poi_at] = true,
	[monster_win_resist] = true,
	[monster_thu_resist] = true,
	[monster_ice_resist] = true,
	[monster_fir_resist] = true,
	[monster_soi_resist] = true,
	[monster_poi_resist] = true,
	[monster_max_hp] = true,
	[monster_at] = true,
	[monster_mt] = true,
	[monster_af] = true,
	[monster_mf] = true,
	[monster_hit] = true,
	[monster_dodge]= true,
	[monster_critical] = true,
	[monster_tenacity] = true,
	[monster_speed] = true,
}

--怪物属性增益对应的加持属性ID
g_AttrMonsterAttrBefinitTable =
{
	[monster_max_hp] =
	{
		[MonAttrAddType.Value] = monster_add_max_hp,
		[MonAttrAddType.Coffi] = monster_inc_max_hp
	},
	[monster_at] =
	{
		[MonAttrAddType.Value] = monster_add_at,
		[MonAttrAddType.Coffi] = monster_inc_at
	},
	[monster_af] =
	{
		[MonAttrAddType.Value] = monster_add_af,
		[MonAttrAddType.Coffi] = monster_inc_af
	},
	[monster_mt] =
	{
		[MonAttrAddType.Value] = monster_add_mt,
		[MonAttrAddType.Coffi] = monster_inc_mt
	},
	[monster_mf] =
	{
		[MonAttrAddType.Value] = monster_add_mf,
		[MonAttrAddType.Coffi] = monster_inc_mf
	},
	[monster_speed] =
	{
		[MonAttrAddType.Value] = monster_add_speed,
		[MonAttrAddType.Coffi] = monster_inc_speed
	},
	[monster_critical] =
	{
		[MonAttrAddType.Value] = monster_add_critical,
		[MonAttrAddType.Coffi] = monster_inc_critical
	},
	[monster_dodge] =
	{
		[MonAttrAddType.Value] = monster_add_dodge,
		[MonAttrAddType.Coffi] = monster_inc_dodge
	},
	[monster_tenacity] =
	{
		[MonAttrAddType.Value] = monster_add_tenacity,
		[MonAttrAddType.Coffi] = monster_inc_tenacity
	},
--	[monster_hit] =
--	{
--		[MonAttrAddType.Value] = monster_add_hit,
--		[MonAttrAddType.Coffi] = monster_inc_hit
--	},
}
