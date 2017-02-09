--[[PlayerAttrFormula.lua
描述：
	玩家属性公式
]]



local math_pow		= math.pow
local math_ceil		= math.ceil
local math_floor	= math.floor

PlayerAttrbuteFormula = {}

-----------------------------------------------------------------------
--策划配置
-----------------------------------------------------------------------
--玩家升级的下一级经验

function PlayerAttrbuteFormula.player_next_xp(player)
	local level = player:getAttrValue(player_lvl)
	return PlayerLevelUpDB[level] or 0
end

--先天武力
function PlayerAttrbuteFormula.player_in_str(player)
	local level = player:getAttrValue(player_lvl)
	return level + 10;
end

--先天智力
function PlayerAttrbuteFormula.player_in_int(player)
	local level = player:getAttrValue(player_lvl)
	return level + 10;
end

--先天根骨
function PlayerAttrbuteFormula.player_in_sta(player)
	local level = player:getAttrValue(player_lvl)
	return level + 10;
end

--先天灵性
function PlayerAttrbuteFormula.player_in_spi(player)
	local level = player:getAttrValue(player_lvl)
	return level + 10;
end

--先天身法
function PlayerAttrbuteFormula.player_in_dex(player)
	local level = player:getAttrValue(player_lvl)
	return level + 10;
end

--武力 = 先天武力 +武力加点 + 武力加值 + 所有属性加值
function PlayerAttrbuteFormula.player_str(player)
	local player_in_str = player:getAttrValue(player_in_str)
	local player_str_point = player:getAttrValue(player_str_point)
	local player_add_str = player:getAttrValue(player_add_str)
	local player_add_base_attr = player:getAttrValue(player_add_base_attr)
	return player_in_str+player_str_point+player_add_str+player_add_base_attr
end

--智力 = 先天智力 +智力加点 + 智力加值 + 所有属性加值
function PlayerAttrbuteFormula.player_int(player)
	local player_in_int = player:getAttrValue(player_in_int)
	local player_int_point = player:getAttrValue(player_int_point)
	local player_add_int = player:getAttrValue(player_add_int)
	local player_add_base_attr = player:getAttrValue(player_add_base_attr)
	return player_in_int+player_int_point+player_add_int+player_add_base_attr
end

--根骨 = 先天根骨 +根骨加点 + 根骨加值 + 所有属性加值
function PlayerAttrbuteFormula.player_sta(player)
	local player_in_sta = player:getAttrValue(player_in_sta)
	local player_sta_point = player:getAttrValue(player_sta_point)
	local player_add_sta = player:getAttrValue(player_add_sta)
	local player_add_base_attr = player:getAttrValue(player_add_base_attr)
	return player_in_sta+player_sta_point+player_add_sta+player_add_base_attr
end

--敏锐 = 先天敏锐 +敏锐加点 + 敏锐加值 + 所有属性加值
function PlayerAttrbuteFormula.player_spi(player)
	local player_in_spi = player:getAttrValue(player_in_spi)
	local player_spi_point = player:getAttrValue(player_spi_point)
	local player_add_spi = player:getAttrValue(player_add_spi)
	local player_add_base_attr = player:getAttrValue(player_add_base_attr)
	return player_in_spi+player_spi_point+player_add_spi+player_add_base_attr
end

--身法 = 先天身法 +身法加点 + 身法加值 + 所有属性加值
function PlayerAttrbuteFormula.player_dex(player)
	local player_in_dex = player:getAttrValue(player_in_dex)
	local player_dex_point = player:getAttrValue(player_dex_point)
	local player_add_dex = player:getAttrValue(player_add_dex)
	local player_add_base_attr = player:getAttrValue(player_add_base_attr)
	return player_in_dex+player_dex_point+player_add_dex+player_add_base_attr
end

--风相性 = 风相性加点 + 风相性加值 + 所有相性加值
function PlayerAttrbuteFormula.player_win_phase(player)
	local player_win_phase_point = player:getAttrValue(player_win_phase_point)
	local player_add_win_phase = player:getAttrValue(player_add_win_phase)
	local player_add_all_phase = player:getAttrValue(player_add_all_phase)
	return player_win_phase_point+player_add_win_phase+player_add_all_phase
end

--雷相性 = 雷相性加点 + 雷相性加值 + 所有相性加值
function PlayerAttrbuteFormula.player_thu_phase(player)
	local player_thu_phase_point = player:getAttrValue(player_thu_phase_point)
	local player_add_thu_phase = player:getAttrValue(player_add_thu_phase)
	local player_add_all_phase = player:getAttrValue(player_add_all_phase)
	return player_thu_phase_point+player_add_thu_phase+player_add_all_phase
end

--冰相性 = 冰相性加点 + 冰相性加值 + 所有相性加值
function PlayerAttrbuteFormula.player_ice_phase(player)
	local player_ice_phase_point = player:getAttrValue(player_ice_phase_point)
	local player_add_ice_phase = player:getAttrValue(player_add_ice_phase)
	local player_add_all_phase = player:getAttrValue(player_add_all_phase)
	return player_ice_phase_point+player_add_ice_phase+player_add_all_phase
end

--土相性 = 土相性加点 + 土相性加值 + 所有相性加值
function PlayerAttrbuteFormula.player_soi_phase(player)
	local player_soi_phase_point = player:getAttrValue(player_soi_phase_point)
	local player_add_soi_phase = player:getAttrValue(player_add_soi_phase)
	local player_add_all_phase = player:getAttrValue(player_add_all_phase)
	return player_soi_phase_point+player_add_soi_phase+player_add_all_phase
end

--火相性 = 火相性加点 + 火相性加值 + 所有相性加值
function PlayerAttrbuteFormula.player_fir_phase(player)
	local player_fir_phase_point = player:getAttrValue(player_fir_phase_point)
	local player_add_fir_phase = player:getAttrValue(player_add_fir_phase)
	local player_add_all_phase = player:getAttrValue(player_add_all_phase)
	return player_fir_phase_point+player_add_fir_phase+player_add_all_phase
end

--毒相性 = 毒相性加点 + 毒相性加值 + 所有相性加值
function PlayerAttrbuteFormula.player_poi_phase(player)
	local player_poi_phase_point = player:getAttrValue(player_poi_phase_point)
	local player_add_poi_phase = player:getAttrValue(player_add_poi_phase)
	local player_add_all_phase = player:getAttrValue(player_add_all_phase)
	return player_poi_phase_point+player_add_poi_phase+player_add_all_phase
end

--风攻击 =（风相0.01+风攻击加值+所有相性攻击加值）
function PlayerAttrbuteFormula.player_win_at(player)
	local player_win_phase = player:getAttrValue(player_win_phase)
	local player_inc_win_at = player:getAttrValue(player_inc_win_at)/1000
	local player_inc_phase_at = player:getAttrValue(player_inc_phase_at)/1000
	return player_win_phase*0.01+player_inc_win_at+player_inc_phase_at
end

--雷攻击 = （雷相性*0.01+雷攻击加值+所有相性攻击加值）
function PlayerAttrbuteFormula.player_thu_at(player)
	local player_thu_phase = player:getAttrValue(player_thu_phase)
	local player_inc_thu_at = player:getAttrValue(player_inc_thu_at)/1000
	local player_inc_phase_at = player:getAttrValue(player_inc_phase_at)/1000
	return player_thu_phase*0.01+player_inc_thu_at+player_inc_phase_at
end

--冰攻击 =（冰相性*0.01+冰攻击加值+所有相性攻击加值）
function PlayerAttrbuteFormula.player_ice_at(player)
	local player_ice_phase = player:getAttrValue(player_ice_phase)
	local player_inc_ice_at = player:getAttrValue(player_inc_ice_at)/1000
	local player_inc_phase_at = player:getAttrValue(player_inc_phase_at)/1000
	return player_ice_phase*0.01+player_inc_ice_at+player_inc_phase_at
end

--火攻击 = (火相性*0.01+火攻击加值+所有相性攻击加值)
function PlayerAttrbuteFormula.player_fir_at(player)
	local player_fir_phase = player:getAttrValue(player_fir_phase)
	local player_inc_fir_at = player:getAttrValue(player_inc_fir_at)/1000
	local player_inc_phase_at = player:getAttrValue(player_inc_phase_at)/1000
	return player_fir_phase*0.01+player_inc_fir_at+player_inc_phase_at
end

--土攻击 = (土相性*0.01+土攻击加值+所有相性攻击加值)
function PlayerAttrbuteFormula.player_soi_at(player)
	local player_soi_phase = player:getAttrValue(player_soi_phase)
	local player_inc_soi_at = player:getAttrValue(player_inc_soi_at)/1000
	local player_inc_phase_at = player:getAttrValue(player_inc_phase_at)/1000
	return player_soi_phase*0.01+player_inc_soi_at+player_inc_phase_at
end

--毒攻击 = (毒相性*0.01+毒攻击加值+所有相性攻击加值)
function PlayerAttrbuteFormula.player_poi_at(player)
	local player_poi_phase = player:getAttrValue(player_poi_phase)
	local player_inc_poi_at = player:getAttrValue(player_inc_poi_at)/1000
	local player_inc_phase_at = player:getAttrValue(player_inc_phase_at)/1000
	return player_poi_phase*0.01+player_inc_poi_at+player_inc_phase_at
end

--风抗 = (风相性*0.01+风抗加值+所有相性抗性加值)
function PlayerAttrbuteFormula.player_win_resist(player)
	local player_win_phase = player:getAttrValue(player_win_phase)
	local player_inc_win_resist = player:getAttrValue(player_inc_win_resist)/1000
	local player_inc_phase_resist = player:getAttrValue(player_inc_phase_resist)/1000
	return player_win_phase*0.01+player_inc_win_resist+player_inc_phase_resist
end

--雷抗 = (雷相性*0.01+雷抗加值+所有相性抗性加值)
function PlayerAttrbuteFormula.player_thu_resist(player)
	local player_thu_phase = player:getAttrValue(player_thu_phase)
	local player_inc_thu_resist = player:getAttrValue(player_inc_thu_resist)/1000
	local player_inc_phase_resist = player:getAttrValue(player_inc_phase_resist)/1000
	return player_thu_phase*0.01+player_inc_thu_resist+player_inc_phase_resist
end

--冰抗 = (冰相性*0.01+冰抗加值+所有相性抗性加值)
function PlayerAttrbuteFormula.player_ice_resist(player)
	local player_ice_phase = player:getAttrValue(player_ice_phase)
	local player_inc_ice_resist = player:getAttrValue(player_inc_ice_resist)/1000
	local player_inc_phase_resist = player:getAttrValue(player_inc_phase_resist)/1000
	return player_ice_phase*0.01+player_inc_ice_resist+player_inc_phase_resist
end

--火抗 = (火相性*0.01+火抗加值+所有相性抗性加值)
function PlayerAttrbuteFormula.player_fir_resist(player)
	local player_fir_phase = player:getAttrValue(player_fir_phase)
	local player_inc_fir_resist = player:getAttrValue(player_inc_fir_resist)/1000
	local player_inc_phase_resist = player:getAttrValue(player_inc_phase_resist)/1000
	return player_fir_phase*0.01+player_inc_fir_resist+player_inc_phase_resist
end

--土抗 = (土相性*0.01+土抗加值+所有相性抗性加值)
function PlayerAttrbuteFormula.player_soi_resist(player)
	local player_soi_phase = player:getAttrValue(player_soi_phase)
	local player_inc_ice_resist = player:getAttrValue(player_inc_ice_resist)/1000
	local player_inc_phase_resist = player:getAttrValue(player_inc_phase_resist)/1000
	return player_soi_phase*0.01+player_inc_ice_resist+player_inc_phase_resist
end

--毒抗 = (毒相性*0.01+毒抗加值+所有相性抗性加值)
function PlayerAttrbuteFormula.player_poi_resist(player)
	local player_poi_phase = player:getAttrValue(player_poi_phase)
	local player_inc_poi_resist = player:getAttrValue(player_inc_poi_resist)/1000
	local player_inc_phase_resist = player:getAttrValue(player_inc_phase_resist)/1000
	return player_poi_phase*0.01+player_inc_poi_resist+player_inc_phase_resist
end

--生命上限=（根骨*7.2+冰相性*6.4+（等级+4）^2/5-等级+196+生命上限加值+红蓝上限加值）*（1+生命值上限加成+红蓝上限加成）
function PlayerAttrbuteFormula.player_max_hp(player)
	local player_sta = player:getAttrValue(player_sta)
	local player_str = player:getAttrValue(player_str)
	local player_ice_phase = player:getAttrValue(player_ice_phase)
	local level = player:getAttrValue(player_lvl)
	local player_add_max_hp = player:getAttrValue(player_add_max_hp)
	local player_inc_max_hp = player:getAttrValue(player_inc_max_hp)/1000
	local player_add_max_hm = player:getAttrValue(player_add_max_hm)
	local player_inc_max_hm = player:getAttrValue(player_inc_max_hm)/1000
	return math_floor((player_sta*7.2+player_str*2.4+player_ice_phase*6.4+math_pow(level+4,2)/5-level+196+player_add_max_hp+player_add_max_hm)*(1+player_inc_max_hp+player_inc_max_hm))
end

--法力上限=（身法*1.2+智力*4.8+冰相性*4+（等级+4）^2/5-等级+146+法力上限加值+红蓝上限加值）*（1+法力值上限加成+红蓝上限加成）
function PlayerAttrbuteFormula.player_max_mp(player)
	local player_dex = player:getAttrValue(player_dex)
	local player_int = player:getAttrValue(player_int)
	local player_ice_phase = player:getAttrValue(player_ice_phase)
	local level = player:getAttrValue(player_lvl)
	local player_add_max_mp = player:getAttrValue(player_add_max_mp)
	local player_inc_max_mp = player:getAttrValue(player_inc_max_mp)/1000
	local player_add_max_hm = player:getAttrValue(player_add_max_hm)
	local player_inc_max_hm = player:getAttrValue(player_inc_max_hm)/1000
	return math_floor((player_dex*1.2+player_int*4.8+player_ice_phase*4+math_pow(level+4,2)/5-level+146+player_add_max_mp+player_add_max_hm)*(1+player_inc_max_mp+player_inc_max_hm))
end

--物理攻击力=（武力*4+火相性*10+（等级+9）^2/10-等级-9+物理攻击力加值+全部攻击力加值）*（1+物理攻击力加成+全部攻击力加成）
function PlayerAttrbuteFormula.player_at(player)
	local player_str = player:getAttrValue(player_str)
	local player_fir_phase = player:getAttrValue(player_fir_phase)
	local level = player:getAttrValue(player_lvl)
	local player_add_at = player:getAttrValue(player_add_at)
	local player_inc_at = player:getAttrValue(player_inc_at)/1000
	local player_add_at_mt = player:getAttrValue(player_add_at_mt)
	local player_inc_at_mt = player:getAttrValue(player_inc_at_mt)/1000
	return math_floor((player_str*4+player_fir_phase*10+math_pow(level+9,2)/10-level-9+player_add_at+player_add_at_mt)*(1+player_inc_at+player_inc_at_mt))
end

--法术攻击力=（智力*4+雷相性*10+（等级+9）^2/10-等级-9+法术攻击力加值+全部攻击力加值）*（1+法术攻击力加成+全部攻击力加成）
function PlayerAttrbuteFormula.player_mt(player)
	local player_int = player:getAttrValue(player_int)
	local player_thu_phase = player:getAttrValue(player_thu_phase)
	local level = player:getAttrValue(player_lvl)
	local player_add_mt = player:getAttrValue(player_add_mt)
	local player_inc_mt = player:getAttrValue(player_inc_mt)/1000
	local player_add_at_mt = player:getAttrValue(player_add_at_mt)
	local player_inc_at_mt = player:getAttrValue(player_inc_at_mt)/1000
	return math_floor((player_int*4+player_thu_phase*10+math_pow(level+9,2)/10-level-9+player_add_mt+player_add_at_mt)*(1+player_inc_mt+player_inc_at_mt))
end

--物理防御力=（根骨*2.4+武力*0.8+敏锐*0.8+土相性*5+（等级+9）^2/10-等级-9+物理防御力加值+全部防御力加值）*（1+物理防御力加成+全部防御力加成）
function PlayerAttrbuteFormula.player_af(player)
	local player_sta = player:getAttrValue(player_sta)
	local player_str = player:getAttrValue(player_str)	
	local player_spi = player:getAttrValue(player_spi)
	local player_soi_phase = player:getAttrValue(player_soi_phase)
	local level = player:getAttrValue(player_lvl)
	local player_add_af = player:getAttrValue(player_add_af)
	local player_inc_af = player:getAttrValue(player_inc_af)/1000
	local player_add_af_mf = player:getAttrValue(player_add_af_mf)
	local player_inc_af_mf = player:getAttrValue(player_inc_af_mf)/1000
	return math_floor((player_sta*2.4+player_str*0.8+player_spi*0.8+player_soi_phase*5+math_pow(level+9,2)/10-level-9+player_add_af+player_add_af_mf)*(1+player_inc_af+player_inc_af_mf))
end

--法术防御力=（根骨*2.4+智力*0.8+敏锐*0.8+土相性*5+（等级+9）^2/10-等级-9+法术防御力加值+全部防御力加值）*（1+法术防御力加成+全部防御力加成）
function PlayerAttrbuteFormula.player_mf(player)
	local player_sta = player:getAttrValue(player_sta)
	local player_int = player:getAttrValue(player_int)
	local player_spi = player:getAttrValue(player_spi)
	local player_soi_phase = player:getAttrValue(player_soi_phase)
	local level = player:getAttrValue(player_lvl)
	local player_add_mf = player:getAttrValue(player_add_mf)
	local player_inc_mf = player:getAttrValue(player_inc_mf)/1000
	local player_add_af_mf = player:getAttrValue(player_add_af_mf)
	local player_inc_af_mf = player:getAttrValue(player_inc_af_mf)/1000
	return math_floor((player_sta*2.4+player_int*0.8+player_spi*0.8+player_soi_phase*5+math_pow(level+9,2)/10-level-9+player_add_mf+player_add_af_mf)*(1+player_inc_mf+player_inc_af_mf))
end

--命中=（武力*0.2+智力*0.1+敏锐*0.7+（等级-1）*0.5+20+命中加值）*（1+命中加成）
function PlayerAttrbuteFormula.player_hit(player)
	local player_str = player:getAttrValue(player_str)
	local player_int = player:getAttrValue(player_int)
	local player_spi = player:getAttrValue(player_spi)
	local level = player:getAttrValue(player_lvl)
	local player_add_hit = player:getAttrValue(player_add_hit)
	local player_inc_hit = player:getAttrValue(player_inc_hit)/1000
	return math_floor((player_str*0.2+player_int*0.1+player_spi*0.7+(level-1)*0.5+player_add_hit)*(1+player_inc_hit))
end

--闪避=（敏锐*1+（等级-1）*0.5+闪避加值）*（1+闪避加成）
function PlayerAttrbuteFormula.player_dodge(player)
	local player_spi = player:getAttrValue(player_spi)
	local level = player:getAttrValue(player_lvl)
	local player_add_dodge = player:getAttrValue(player_add_dodge)
	local player_inc_dodge = player:getAttrValue(player_inc_dodge)/1000
	return math_floor((player_spi*1+(level-1)*0.5+player_add_dodge)*(1+player_inc_dodge))
end

--暴击=（风相性*2+（等级-1）/2+暴击加值）*（1+暴击加成）+1
function PlayerAttrbuteFormula.player_critical(player)
	local player_win_phase = player:getAttrValue(player_win_phase)
	local level = player:getAttrValue(player_lvl)
	local player_inc_critical = player:getAttrValue(player_inc_critical)/1000
	local player_add_critical = player:getAttrValue(player_add_critical)
	return math_floor((player_win_phase*2+(level-1)/2+player_add_critical)*(1+player_inc_critical)+1)
end

--抗暴=(（等级-1）/2+抗暴加值）*（1+抗暴加成）+1
function PlayerAttrbuteFormula.player_tenacity(player)
	local level = player:getAttrValue(player_lvl)
	local player_inc_tenacity = player:getAttrValue(player_inc_tenacity)/1000
	local player_add_tenacity = player:getAttrValue(player_add_tenacity)
	return math_floor(((level-1)/2+player_add_tenacity)*(1+player_inc_tenacity)+1)
end

--速度=（身法*1+毒相性*2+速度加值）*（1+速度加成）
function PlayerAttrbuteFormula.player_speed(player)
	local player_dex = player:getAttrValue(player_dex)
	local player_poi_phase = player:getAttrValue(player_poi_phase)
	local player_inc_speed = player:getAttrValue(player_inc_speed)/1000
	local player_add_speed = player:getAttrValue(player_add_speed)
	return math_floor((player_dex*1+player_poi_phase*2+player_add_speed)*(1+player_inc_speed))
end

--反震率
function PlayerAttrbuteFormula.player_counter(player)
	return 0
end

--暴击效果加成
--[[function PlayerAttrbuteFormula.player_inc_critical_effect(player)
	local player_inc_critical_effect = player:getAttrValue(player_inc_critical_effect)
	return player_inc_critical_effect
end]]

--移动速度
function PlayerAttrbuteFormula.player_mobile_speed(player)
	return 4
end

--最大怒气
function PlayerAttrbuteFormula.player_max_anger(player)
	return 100
end

--最大体力值
function PlayerAttrbuteFormula.player_max_vigor(player)
	local level = player:getAttrValue(player_lvl)
	if level <= 20 then
		return 50
	else
		return 50 + (level - 20)*5
	end
end

-- 标准道行
function PlayerAttrbuteFormula.player_stand_tao(player)
	local level = player:getAttrValue(player_lvl)
	return math_floor(math_pow(level,3)*0.29 + 73)
end

g_AttrPlayerInfluenceTable =
{
	-- 一级属性
	[player_str]						= {player_at,player_hit,player_max_mp},
	[player_int]						= {player_mt,player_max_mp,player_hit},
	[player_sta]						= {player_max_hp,player_af,player_mf,player_tenacity},
	[player_spi]						= {player_critical,player_hit,player_af,player_mf},
	[player_dex]						= {player_speed,player_dodge},
	[player_in_str]						= {player_str},
	[player_in_int]						= {player_int},
	[player_in_sta]						= {player_sta},
	[player_in_spi]						= {player_spi},
	[player_in_dex]						= {player_dex},
	[player_str_point]					= {player_str},
	[player_int_point]					= {player_int},
	[player_sta_point]					= {player_sta},
	[player_spi_point]					= {player_spi},
	[player_dex_point]					= {player_dex},
	[player_add_str]					= {player_str},
	[player_add_int]					= {player_int},
	[player_add_sta]					= {player_sta},
	[player_add_spi]					= {player_spi},
	[player_add_dex]					= {player_dex},
	[player_add_base_attr]				= {player_str,player_int,player_sta,player_spi,player_dex},
	[player_win_phase]					= {player_win_at,player_win_resist,player_mt},
	[player_thu_phase]					= {player_thu_at,player_thu_resist,player_critical},
	[player_ice_phase]					= {player_ice_at,player_ice_resist,player_max_hp,player_max_mp},
	[player_soi_phase]					= {player_soi_at,player_soi_resist,player_af,player_mf},
	[player_fir_phase]					= {player_fir_at,player_fir_resist,player_at},
	[player_poi_phase]					= {player_poi_at,player_poi_resist},--还会影响dot效果
	[player_add_all_phase]				= {player_win_phase,player_thu_phase,player_ice_phase,player_soi_phase,player_fir_phase,player_poi_phase},
	[player_win_phase_point]			= {player_win_phase},
	[player_thu_phase_point]			= {player_thu_phase},
	[player_ice_phase_point]			= {player_ice_phase},
	[player_soi_phase_point]			= {player_soi_phase},
	[player_fir_phase_point]			= {player_fir_phase},
	[player_poi_phase_point]			= {player_poi_phase},

	-- 二级属性
	[player_add_max_hp]					= {player_max_hp},
	[player_inc_max_hp]					= {player_max_hp},
	[player_add_max_mp]					= {player_max_mp},
	[player_inc_max_mp]					= {player_max_mp},
	[player_add_max_hm]					= {player_max_hp,player_max_mp},
	[player_inc_max_hm]					= {player_max_hp,player_max_mp},
	[player_add_at]						= {player_at},
	[player_inc_at]						= {player_at},
	[player_add_mt]						= {player_mt},
	[player_inc_mt]						= {player_mt},
	[player_add_at_mt]					= {player_at,player_mt},
	[player_inc_at_mt]					= {player_at,player_mt},
	[player_add_af]						= {player_af},
	[player_inc_af]                     = {player_af},
	[player_add_mf]						= {player_mf},
	[player_inc_mf]                     = {player_mf},
	[player_add_af_mf]					= {player_af,player_mf},
	[player_inc_af_mf]					= {player_af,player_mf},
	[player_add_hit]					= {player_hit},
	[player_inc_hit]					= {player_hit},
	[player_add_dodge]					= {player_dodge},
	[player_inc_dodge]					= {player_dodge},
	[player_add_critical]               = {player_critical},
	[player_inc_critical]				= {player_critical},
	[player_add_tenacity]               = {player_tenacity},
	[player_inc_tenacity]				= {player_tenacity},
	[player_add_speed]					= {player_speed},
	[player_inc_speed]					= {player_speed},
	--[player_inc_obstacle_resist]		= {player_inc_taunt_resist,player_inc_sopor_resist,player_inc_chaos_resist,player_inc_freeze_resist,player_inc_silent_resist,player_inc_toxicosis_resist},
	[player_inc_win_at]					= {player_win_at},
	[player_inc_thu_at]					= {player_thu_at},
	[player_inc_ice_at]					= {player_ice_at},
	[player_inc_soi_at]					= {player_soi_at},
	[player_inc_fir_at]					= {player_fir_at},
	[player_inc_poi_at]					= {player_poi_at},
	[player_inc_phase_at]				= {player_win_at,player_thu_at,player_ice_at,player_fir_at,player_soi_at,player_poi_at},
	[player_inc_win_resist]				= {player_win_resist},
	[player_inc_thu_resist]				= {player_thu_resist},
	[player_inc_ice_resist]				= {player_ice_resist},
	[player_inc_fir_resist]				= {player_fir_resist},
	[player_inc_soi_resist]				= {player_soi_resist},
	[player_inc_poi_resist]				= {player_poi_resist},
	[player_inc_phase_resist]			= {player_win_resist,player_thu_resist,player_ice_resist,player_fir_resist,player_soi_resist,player_poi_resist},

	-- 三级属性
	[player_add_mobile_speed]           = {player_mobile_speed},
	[player_lvl]						= {player_next_xp, player_in_str,player_in_int,player_in_sta,player_in_spi,player_in_dex,player_max_vigor,player_stand_tao},
	[player_inc_counter]				= {player_counter},
	[player_inc_escape]					= {player_escape},
}

--属性公式对照表
g_AttributePlayerFormat =
{
	[player_str]						= PlayerAttrbuteFormula.player_str,
	[player_int]						= PlayerAttrbuteFormula.player_int,
	[player_sta]						= PlayerAttrbuteFormula.player_sta,
	[player_spi]						= PlayerAttrbuteFormula.player_spi,
	[player_dex]						= PlayerAttrbuteFormula.player_dex,
	[player_in_str]						= PlayerAttrbuteFormula.player_in_str,
	[player_in_int]						= PlayerAttrbuteFormula.player_in_int,
	[player_in_sta]						= PlayerAttrbuteFormula.player_in_sta,
	[player_in_spi]						= PlayerAttrbuteFormula.player_in_spi,
	[player_in_dex]						= PlayerAttrbuteFormula.player_in_dex,
	[player_win_phase]                  = PlayerAttrbuteFormula.player_win_phase,
	[player_thu_phase]                  = PlayerAttrbuteFormula.player_thu_phase,
	[player_ice_phase]                  = PlayerAttrbuteFormula.player_ice_phase,
	[player_soi_phase]                  = PlayerAttrbuteFormula.player_soi_phase,
	[player_fir_phase]                  = PlayerAttrbuteFormula.player_fir_phase,
	[player_poi_phase]                  = PlayerAttrbuteFormula.player_poi_phase,
	[player_max_hp]						= PlayerAttrbuteFormula.player_max_hp,
	[player_max_mp]						= PlayerAttrbuteFormula.player_max_mp,
	[player_at]							= PlayerAttrbuteFormula.player_at,
	[player_mt]							= PlayerAttrbuteFormula.player_mt,
	[player_af]							= PlayerAttrbuteFormula.player_af,
	[player_mf]							= PlayerAttrbuteFormula.player_mf,
	[player_hit]						= PlayerAttrbuteFormula.player_hit,
	[player_dodge]						= PlayerAttrbuteFormula.player_dodge,
	[player_critical]					= PlayerAttrbuteFormula.player_critical,
	[player_tenacity]					= PlayerAttrbuteFormula.player_tenacity,
	[player_speed]						= PlayerAttrbuteFormula.player_speed,
	[player_win_at]						= PlayerAttrbuteFormula.player_win_at,
	[player_thu_at]						= PlayerAttrbuteFormula.player_thu_at,
	[player_ice_at]						= PlayerAttrbuteFormula.player_ice_at,
	[player_fir_at]						= PlayerAttrbuteFormula.player_fir_at,
	[player_soi_at]						= PlayerAttrbuteFormula.player_soi_at,
	[player_poi_at]						= PlayerAttrbuteFormula.player_poi_at,
	[player_win_resist]					= PlayerAttrbuteFormula.player_win_resist,
	[player_thu_resist]					= PlayerAttrbuteFormula.player_thu_resist,
	[player_ice_resist]					= PlayerAttrbuteFormula.player_ice_resist,
	[player_fir_resist]					= PlayerAttrbuteFormula.player_fir_resist,
	[player_soi_resist]					= PlayerAttrbuteFormula.player_soi_resist,
	[player_poi_resist]					= PlayerAttrbuteFormula.player_poi_resist,
	[player_inc_critical_effect]		= PlayerAttrbuteFormula.player_inc_critical_effect,

	[player_next_xp]					= PlayerAttrbuteFormula.player_next_xp,
	[player_mobile_speed]				= PlayerAttrbuteFormula.player_mobile_speed,
	[player_counter]					= PlayerAttrbuteFormula.player_counter,
	[player_max_anger]					= PlayerAttrbuteFormula.player_max_anger,
	[player_max_vigor]					= PlayerAttrbuteFormula.player_max_vigor,
	[player_stand_tao]					= PlayerAttrbuteFormula.player_stand_tao,
}

-----------------------------------------------------------------------
--程序配置
-----------------------------------------------------------------------
--属性对应的属性同步
g_AttributePlayerToProp =
{
	[player_lvl]						= PLAYER_LEVEL,

	[player_xp]							= PLAYER_XP,
	[player_next_xp]					= PLATER_NEXT_XP,

	[player_hp]							= PLAYER_HP,
	[player_mp]							= PLAYER_MP,
	[player_max_hp]						= PLAYER_MAX_HP,
	[player_max_mp]						= PLAYER_MAX_MP,

	[player_inc_max_hp]					= PLAYER_INC_MAX_HP, -- 生命值上限加成
	[player_inc_max_mp]					= PLAYER_INC_MAX_MP, -- 法力值上限加成
	[player_inc_max_hm]					= PLAYER_INC_MAX_HM, -- 红蓝上限加成
	
	[player_str]						= PLAYER_STR,
	[player_int]						= PLAYER_INT,
	[player_sta]						= PLAYER_STA,
	[player_spi]						= PLAYER_SPI,
	[player_dex]						= PLAYER_DEX,

	[player_attr_point]					= PLAYER_ATTR_POINT,

	[player_str_point]					= PLAYER_STR_POINT,
	[player_int_point]					= PLAYER_INT_POINT,
	[player_sta_point]					= PLAYER_STA_POINT,
	[player_spi_point]					= PLAYER_SPI_POINT,
	[player_dex_point]					= PLAYER_DEX_POINT,

	[player_at]							= PLAYER_AT,
	[player_mt]							= PLAYER_MT,
	[player_af]							= PLAYER_AF,
	[player_mf]							= PLAYER_MF,

	[player_inc_at]						= PLAYER_INC_AT,		-- 物理攻击力加成
	[player_inc_mt]						= PLAYER_INC_MT,		-- 法术攻击力加成
	[player_inc_af]						= PLAYER_INC_AF,		-- 物理防御力加成
	[player_inc_mf]						= PLAYER_INC_MF,		-- 法术防御力加成
	
	[player_inc_at_mt]					= PLAYER_INC_AT_MT,		-- 全部攻击力加成
	[player_inc_af_mf]					= PLAYER_INC_AF_MF,		-- 法术防御力加成
	
	
	[player_speed]						= PLAYER_SPEED,
	[player_hit]						= PLAYER_HIT,
	[player_dodge]						= PLAYER_DODGE,
	[player_critical]					= PLAYER_CRITICAL,
	[player_tenacity]					= PLAYER_TENACITY,

	[player_inc_speed]					= PLAYER_INC_SPEED,		-- 速度加成
	[player_inc_hit]					= PLAYER_INC_HIT,		-- 命中加成
	[player_inc_dodge]					= PLAYER_INC_DODGE,		-- 闪避加成
	[player_inc_critical]				= PLAYER_INC_CRITICAL,	-- 暴击加成
	[player_inc_tenacity]				= PLAYER_INC_TENACITY,	-- 抗暴加成

	
	[player_win_phase]					= PLAYER_WIN_PHASE,
	[player_thu_phase]					= PLAYER_THU_PHASE,
	[player_ice_phase]					= PLAYER_ICE_PHASE,
	[player_soi_phase]					= PLAYER_SOI_PHASE,
	[player_fir_phase]					= PLAYER_FIR_PHASE,
	[player_poi_phase]					= PLAYER_POI_PHASE,

	[player_phase_point]				= PLAYER_PHASE_POINT,
	[player_win_phase_point]			= PLAYER_WIN_PHASE_POINT,
	[player_thu_phase_point]			= PLAYER_THU_PHASE_POINT,
	[player_ice_phase_point]			= PLAYER_ICE_PHASE_POINT,
	[player_soi_phase_point]			= PLAYER_SOI_PHASE_POINT,
	[player_fir_phase_point]			= PLAYER_FIR_PHASE_POINT,
	[player_poi_phase_point]			= PLAYER_POI_PHASE_POINT,

	[player_inc_win_at]					= PLAYER_INC_WIN_AT,
	[player_inc_thu_at]					= PLAYER_INC_THU_AT,
	[player_inc_ice_at]					= PLAYER_INC_ICE_AT,
	[player_inc_fir_at]					= PLAYER_INC_FIR_AT,
	[player_inc_soi_at]					= PLAYER_INC_SOI_AT,
	[player_inc_poi_at]					= PLAYER_INC_POI_AT,

	[player_inc_win_resist]				= PLAYER_INC_WIN_RESIST,
	[player_inc_thu_resist]				= PLAYER_INC_THU_RESIST,
	[player_inc_ice_resist]				= PLAYER_INC_ICE_RESIST,
	[player_inc_fir_resist]				= PLAYER_INC_FIR_RESIST,
	[player_inc_soi_resist]				= PLAYER_INC_SOI_RESIST,
	[player_inc_poi_resist]				= PLAYER_INC_POI_RESIST,

	[player_inc_phase_at]				= PLAYER_INC_PHASE_AT,
	[player_inc_phase_resist]			= PLAYER_INC_PHASE_RESIST,

	[player_inc_taunt_hit]				= PLAYER_INC_TAUNT_HIT,
	[player_inc_soper_hit]				= PLAYER_INC_SOPER_HIT,
	[player_inc_chaos_hit]				= PLAYER_INC_CHAOS_HIT,
	[player_inc_freeze_hit]				= PLAYER_INC_FREEZE_HIT,
	[player_inc_silent_hit]				= PLAYER_INC_SILENT_HIT,
	[player_inc_toxicosis_hit]			= PLAYER_INC_TOXICOSIS_HIT,

	[player_inc_taunt_resist]			= PLAYER_INC_TAUNT_RESIST,
	[player_inc_sopor_resist]			= PLAYER_INC_SOPOR_RESIST,
	[player_inc_chaos_resist]			= PLAYER_INC_CHAOS_RESIST,
	[player_inc_freeze_resist]			= PLAYER_INC_FREEZE_RESIST,
	[player_inc_silent_resist]			= PLAYER_INC_SILENT_RESIST,
	[player_inc_toxicosis_resist]		= PLAYER_INC_TOXICOSIS_RESIST,

	[player_stand_tao]					= PLAYER_STAND_TAO,
	[player_tao]						= PLAYER_TAO,
	[player_pot]						= PLAYER_POT,
	[player_expoint]					= PLAYER_EXPOINT,
	[player_vigor]						= PLAYER_VIGOR,
	[player_anger]						= PLAYER_ANGER,
	[player_combat]						= PLAYER_COMBAT,
	[player_kill]						= PLAYER_KILL,
	[player_max_vigor]					= PLAYER_MAX_VIGOR,
	[player_max_pet]					= PLAYER_MAX_PET,
	
	[player_inc_taunt_hit]				= PLAYER_INC_TAUNT_HIT,
	[player_inc_soper_hit]				= PLAYER_INC_SOPER_HIT,
	[player_inc_chaos_hit]				= PLAYER_INC_CHAOS_HIT,
	[player_inc_freeze_hit]				= PLAYER_INC_FREEZE_HIT,
	[player_inc_silent_hit]				= PLAYER_INC_SILENT_HIT,
	[player_inc_toxicosis_hit]			= PLAYER_INC_TOXICOSIS_HIT,
	[player_inc_taunt_resist]			= PLAYER_INC_TAUNT_RESIST,
	[player_inc_sopor_resist]			= PLAYER_INC_SOPOR_RESIST,
	[player_inc_chaos_resist]			= PLAYER_INC_CHAOS_RESIST,
	[player_inc_freeze_resist]			= PLAYER_INC_FREEZE_RESIST,
	[player_inc_silent_resist]			= PLAYER_INC_SILENT_RESIST,
	[player_inc_toxicosis_resist]		= PLAYER_INC_TOXICOSIS_RESIST,
}

--需要立刻更新的属性
g_AttrPlayerSyncTable =
{
	[player_in_str] = true,
	[player_in_int] = true,
	[player_in_sta] = true,
	[player_in_spi] = true,
	[player_in_dex] = true,
	[player_str] = true,
	[player_int] = true,
	[player_sta] = true,
	[player_spi] = true,
	[player_dex] = true,
	[player_win_at] = true,
	[player_thu_at] = true,
	[player_ice_at] = true,
	[player_fir_at] = true,
	[player_soi_at] = true,
	[player_poi_at] = true,
	[player_win_resist] = true,
	[player_thu_resist] = true,
	[player_ice_resist] = true,
	[player_fir_resist] = true,
	[player_soi_resist] = true,
	[player_poi_resist] = true,
	[player_max_hp] = true,
	[player_max_mp] = true,
	[player_at] = true,
	[player_mt] = true,
	[player_af] = true,
	[player_mf] = true,
	[player_hit] = true,
	[player_dodge]= true,
	[player_critical] = true,
	[player_tenacity] = true,
	[player_speed] = true,
}

