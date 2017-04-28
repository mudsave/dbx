--[[PetAttrFormula.lua
描述：
	宠物物属性公式
]]

PetAttrbuteFormula = {}

-----------------------------------------------------------------------
--策划配置
-----------------------------------------------------------------------
--宠物升级的下一级经验
function PetAttrbuteFormula.pet_next_xp(pet)
	local level = pet:getAttrValue(pet_lvl)
	if level < 20 then
		return math.floor ((math.pow(level,3)*1.5+math.pow(level,2)*12+100)/2.2)
	elseif level < 30 then
		return math.floor ((math.pow(level,3)*2+math.pow(level,2)*2-100)/2.2)
	elseif level < 40 then
		return math.floor ((math.pow(level,3)*2+math.pow(level,2)*4+10)/2.2)
	elseif level < 50 then
		return math.floor ((math.pow(level,3)*2+math.pow(level,2)*6-1000)/2.2)
	elseif level < 60 then
		return math.floor ((math.pow(level,3)*3+math.pow(level,2)*6-110000)/2.2)
	elseif level < 70 then
		return math.floor ((math.pow(level,3)*5+math.pow(level,2)*5-520000)/2.2)
	elseif level < 80 then
		return math.floor ((math.pow(level,3)*6+math.pow(level,2)*4-850000)/2.2)
	elseif level < 100 then
		return math.floor ((math.pow(level,3)*9+math.pow(level,2)*6-2300000)/2.2)
	elseif level < 120 then
		return math.floor ((math.pow(level,4)/6+math.pow(level,2)*2-10000000)/2.2)
	elseif level < 140 then
		return math.floor ((math.pow(level,4)/4+math.pow(level,3)-22000000)/2.2)
	else
		return math.floor ((math.pow(level,5)/70-687000000)/2.2)
	end
end

--先天武力
function PetAttrbuteFormula.pet_in_str(pet)
	local level = pet:getAttrValue(pet_lvl)
	return level-1+pet:getAttrValue(pet_inborn_str)
end

--先天智力
function PetAttrbuteFormula.pet_in_int(pet)
	local level = pet:getAttrValue(pet_lvl)
	return level-1+pet:getAttrValue(pet_inborn_int)
end

--先天根骨
function PetAttrbuteFormula.pet_in_sta(pet)
	local level = pet:getAttrValue(pet_lvl)
	return level-1+pet:getAttrValue(pet_inborn_sta)
end

--先天敏锐
function PetAttrbuteFormula.pet_in_spi(pet)
	local level = pet:getAttrValue(pet_lvl)
	return level-1+pet:getAttrValue(pet_inborn_spi)
end

--先天身法
function PetAttrbuteFormula.pet_in_dex(pet)
	local level = pet:getAttrValue(pet_lvl)
	return level-1+pet:getAttrValue(pet_inborn_dex)
end

--武力:武力加点+先天武力+所有属性加值+武力加值
function PetAttrbuteFormula.pet_str(pet)
	local pet_add_str = pet:getAttrValue(pet_add_str)
	local pet_add_base_attr = pet:getAttrValue(pet_add_base_attr)
	local pet_in_str = pet:getAttrValue(pet_in_str)
	local pet_str_point = pet:getAttrValue(pet_str_point)
	return pet_str_point+pet_in_str+pet_add_base_attr+pet_add_str
end

--智力:智力加点+先天智力+所有属性加值+智力加值
function PetAttrbuteFormula.pet_int(pet)
	local pet_add_int = pet:getAttrValue(pet_add_int)
	local pet_add_base_attr = pet:getAttrValue(pet_add_base_attr)
	local pet_in_int = pet:getAttrValue(pet_in_int)
	local pet_int_point = pet:getAttrValue(pet_int_point)
	return pet_int_point+pet_in_int+pet_add_base_attr+pet_add_int
end

--根骨:根骨加点+先天根骨+所有属性加值+根骨加值
function PetAttrbuteFormula.pet_sta(pet)
	local pet_add_sta = pet:getAttrValue(pet_add_sta)
	local pet_add_base_attr = pet:getAttrValue(pet_add_base_attr)
	local pet_in_sta = pet:getAttrValue(pet_in_sta)
	local pet_sta_point = pet:getAttrValue(pet_sta_point)
	return pet_sta_point+pet_in_sta+pet_add_base_attr+pet_add_sta
end

--敏锐:敏锐加点+先天敏锐+所有属性加值+敏锐加值
function PetAttrbuteFormula.pet_spi(pet)
	local pet_add_spi = pet:getAttrValue(pet_add_spi)
	local pet_add_base_attr = pet:getAttrValue(pet_add_base_attr)
	local pet_in_spi = pet:getAttrValue(pet_in_spi)
	local pet_spi_point = pet:getAttrValue(pet_spi_point)
	return pet_spi_point+pet_in_spi+pet_add_base_attr+pet_add_spi
end

--身法:身法加点+先天身法+所有属性加值+身法加值
function PetAttrbuteFormula.pet_dex(pet)
	local pet_add_dex = pet:getAttrValue(pet_add_dex)
	local pet_add_base_attr = pet:getAttrValue(pet_add_base_attr)
	local pet_in_dex = pet:getAttrValue(pet_in_dex)
	local pet_dex_point = pet:getAttrValue(pet_dex_point)
	return pet_dex_point+pet_in_dex+pet_add_base_attr+pet_add_dex
end

--风攻击:风攻击加成+所有相性攻击加成
function PetAttrbuteFormula.pet_win_at(pet)
	local pet_inc_phase_at = pet:getAttrValue(pet_inc_phase_at) /1000
	local pet_inc_win_at = pet:getAttrValue(pet_inc_win_at) /1000
	return pet_inc_phase_at+pet_inc_win_at
end

--雷攻击:雷攻击加成+所有相性攻击加成
function PetAttrbuteFormula.pet_thu_at(pet)
	local pet_inc_phase_at = pet:getAttrValue(pet_inc_phase_at) /1000
	local pet_inc_thu_at = pet:getAttrValue(pet_inc_thu_at) /1000
	return pet_inc_phase_at+pet_inc_thu_at
end

--冰攻击:冰攻击加成+所有相性攻击加成
function PetAttrbuteFormula.pet_ice_at(pet)
	local pet_inc_phase_at = pet:getAttrValue(pet_inc_phase_at) /1000
	local pet_inc_ice_at = pet:getAttrValue(pet_inc_ice_at) /1000
	return pet_inc_phase_at+pet_inc_ice_at
end

--火攻击:火攻击加成+所有相性攻击加成
function PetAttrbuteFormula.pet_fir_at(pet)
	local pet_inc_phase_at = pet:getAttrValue(pet_inc_phase_at) /1000
	local pet_inc_fir_at = pet:getAttrValue(pet_inc_fir_at) /1000
	return pet_inc_phase_at+pet_inc_fir_at
end

--土攻击:土攻击加成+所有相性攻击加成
function PetAttrbuteFormula.pet_soi_at(pet)
	local pet_inc_phase_at = pet:getAttrValue(pet_inc_phase_at) /1000
	local pet_inc_soi_at = pet:getAttrValue(pet_inc_soi_at) /1000
	return pet_inc_phase_at+pet_inc_soi_at
end

--毒攻击:毒攻击加成+所有相性攻击加成
function PetAttrbuteFormula.pet_poi_at(pet)
	local pet_inc_phase_at = pet:getAttrValue(pet_inc_phase_at) /1000
	local pet_inc_poi_at = pet:getAttrValue(pet_inc_poi_at) /1000
	return pet_inc_phase_at+pet_inc_poi_at
end

--风抗:风抗加成+所有相性抗性加成+风抗性加点/1000
function PetAttrbuteFormula.pet_win_resist(pet)
	local pet_inc_phase_resist = pet:getAttrValue(pet_inc_phase_resist) /1000
	local pet_inc_win_resist = pet:getAttrValue(pet_inc_win_resist) /1000
	local pet_win_phase_point = pet:getAttrValue(pet_win_phase_point) /1000
	return pet_inc_phase_resist+pet_inc_win_resist + pet_win_phase_point 
end

--雷抗:雷抗加成+所有相性抗性加成+雷抗性加点/1000
function PetAttrbuteFormula.pet_thu_resist(pet)
	local pet_inc_phase_resist = pet:getAttrValue(pet_inc_phase_resist) /1000
	local pet_inc_thu_resist = pet:getAttrValue(pet_inc_thu_resist) /1000
	local pet_thu_phase_point = pet:getAttrValue(pet_thu_phase_point) /1000
	return pet_inc_phase_resist+pet_inc_thu_resist + pet_thu_phase_point
end

--冰抗:冰抗加成+所有相性抗性加成+冰抗性加点/1000
function PetAttrbuteFormula.pet_ice_resist(pet)
	local pet_inc_phase_resist = pet:getAttrValue(pet_inc_phase_resist) /1000
	local pet_inc_ice_resist = pet:getAttrValue(pet_inc_ice_resist) /1000
	local pet_ice_phase_point = pet:getAttrValue(pet_ice_phase_point) /1000
	return pet_inc_phase_resist+pet_inc_ice_resist + pet_ice_phase_point
end

--火抗:火抗加成+所有相性抗性加成+火抗性加点/1000
function PetAttrbuteFormula.pet_fir_resist(pet)
	local pet_inc_phase_resist = pet:getAttrValue(pet_inc_phase_resist) /1000
	local pet_inc_fir_resist = pet:getAttrValue(pet_inc_fir_resist) /1000
	local pet_fir_phase_point = pet:getAttrValue(pet_fir_phase_point) /1000
	return pet_inc_phase_resist+pet_inc_fir_resist + pet_fir_phase_point
end

--土抗:土抗加成+所有相性抗性加成+土抗性加点/1000
function PetAttrbuteFormula.pet_soi_resist(pet)
	local pet_inc_phase_resist = pet:getAttrValue(pet_inc_phase_resist) /1000
	local pet_inc_soi_resist = pet:getAttrValue(pet_inc_soi_resist) /1000
	local pet_soi_phase_point = pet:getAttrValue(pet_soi_phase_point) /1000
	return pet_inc_phase_resist+pet_inc_soi_resist + pet_soi_phase_point
end

--毒抗:毒抗加成+所有相性抗性加成+毒抗性加点/1000
function PetAttrbuteFormula.pet_poi_resist(pet)
	local pet_inc_phase_resist = pet:getAttrValue(pet_inc_phase_resist) /1000
	local pet_inc_poi_resist = pet:getAttrValue(pet_inc_poi_resist) /1000
	local pet_poi_phase_point = pet:getAttrValue(pet_poi_phase_point) /1000
	return pet_inc_phase_resist+pet_inc_poi_resist + pet_poi_phase_point
end

--抗嘲讽:抗嘲讽加成+所有障碍抗性加成+嘲讽相性加点/1000
function PetAttrbuteFormula.pet_taunt_resist(pet)
	local pet_inc_taunt_resist = pet:getAttrValue(pet_inc_taunt_resist) /1000
	local pet_inc_obstacle_resist = pet:getAttrValue(pet_inc_obstacle_resist) /1000
	local pet_taunt_phase_point = pet:getAttrValue(pet_taunt_phase_point) /1000
	return pet_inc_taunt_resist+pet_inc_obstacle_resist + pet_taunt_phase_point
end

--抗昏睡:抗昏睡加成+所有障碍抗性加成+昏睡相性加点/1000
function PetAttrbuteFormula.pet_sopor_resist(pet)
	local pet_inc_sopor_resist = pet:getAttrValue(pet_inc_sopor_resist) /1000
	local pet_inc_obstacle_resist = pet:getAttrValue(pet_inc_obstacle_resist) /1000
	local pet_sopor_phase_point = pet:getAttrValue(pet_sopor_phase_point) /1000
	return pet_inc_sopor_resist+pet_inc_obstacle_resist + pet_sopor_phase_point
end

--抗混乱:抗混乱加成+所有障碍抗性加成+混乱相性加点/1000
function PetAttrbuteFormula.pet_chaos_resist(pet)
	local pet_inc_chaos_resist = pet:getAttrValue(pet_inc_chaos_resist) /1000
	local pet_inc_obstacle_resist = pet:getAttrValue(pet_inc_obstacle_resist) /1000
	local pet_chaos_phase_point = pet:getAttrValue(pet_chaos_phase_point) /1000
	return pet_inc_chaos_resist+pet_inc_obstacle_resist + pet_chaos_phase_point
end

--抗冰冻:抗冰冻加成+所有障碍抗性加成+冰冻相性加点/1000
function PetAttrbuteFormula.pet_freeze_resist(pet)
	local pet_inc_freeze_resist = pet:getAttrValue(pet_inc_freeze_resist) /1000
	local pet_inc_obstacle_resist = pet:getAttrValue(pet_inc_obstacle_resist) /1000
	local pet_freeze_phase_point = pet:getAttrValue(pet_freeze_phase_point) /1000
	return pet_inc_freeze_resist+pet_inc_obstacle_resist + pet_freeze_phase_point
end

--抗沉默:抗沉默加成+所有障碍抗性加成+沉默相性加点/1000
function PetAttrbuteFormula.pet_silent_resist(pet)
	local pet_inc_silent_resist = pet:getAttrValue(pet_inc_silent_resist) /1000
	local pet_inc_obstacle_resist = pet:getAttrValue(pet_inc_obstacle_resist) /1000
	local pet_silent_phase_point = pet:getAttrValue(pet_silent_phase_point) /1000
	return pet_inc_silent_resist+pet_inc_obstacle_resist + pet_silent_phase_point
end

--抗中毒:抗中毒加成+所有障碍抗性加成+中毒相性加点/1000
function PetAttrbuteFormula.pet_toxicosis_resist(pet)
	local pet_inc_toxicosis_resist = pet:getAttrValue(pet_inc_toxicosis_resist) /1000
	local pet_inc_obstacle_resist = pet:getAttrValue(pet_inc_obstacle_resist) /1000
	local pet_toxicosis_phase_point = pet:getAttrValue(pet_toxicosis_phase_point) /1000
	return pet_inc_toxicosis_resist+pet_inc_obstacle_resist + pet_toxicosis_phase_point
end

--生命上限=(（根骨*6+武力*2）*天资/500+(等级+1）^2*生命成长/3000+496)*(1+生命上限加成）+生命上限加值
function PetAttrbuteFormula.pet_max_hp(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_str = pet:getAttrValue(pet_str)
	local pet_sta = pet:getAttrValue(pet_sta)
	local pet_hp_grow = pet:getAttrValue(pet_hp_grow)
	local pet_capacity = pet:getAttrValue(pet_capacity)
	local pet_inc_max_hp = pet:getAttrValue(pet_inc_max_hp) / 1000
	local pet_add_max_hp = pet:getAttrValue(pet_add_max_hp)
	--return math.floor((pet_sta*pet_capacity*15/400+math.pow(level-2,2)*pet_hp_grow/600)*(1+pet_inc_max_hp)+pet_add_max_hp)
	return math.floor(((pet_sta*6+pet_str*2)*pet_capacity/500+math.pow(level+1,2)*pet_hp_grow/3000+496)*(1+pet_inc_max_hp)+pet_add_max_hp)
end

--法力上限=（(等级+8)^2/3+智力*6+身法*1.5+150）*（1+法力值上限加成）+法力上限加值
function PetAttrbuteFormula.pet_max_mp(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_int = pet:getAttrValue(pet_int)
	local pet_dex = pet:getAttrValue(pet_dex)
	local pet_inc_max_mp = pet:getAttrValue(pet_inc_max_mp) / 1000
	local pet_add_max_mp = pet:getAttrValue(pet_add_max_mp)
	--return math.floor((math.pow(level,2)/5+pet_int*10+pet_str*10)*(1+pet_inc_max_mp)+pet_add_max_mp)
	return math.floor((math.pow(level+8,2)/3+pet_int*6+pet_dex*1.5+150)*(1+pet_inc_max_mp)+pet_add_max_mp)
end

--物理攻击=（武力*天资成长*2.5/800+(等级+1)^2*物攻成长/3000+250-等级）*（1+物理攻击力加成）+物理攻击力加值
function PetAttrbuteFormula.pet_at(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_str = pet:getAttrValue(pet_str)
	local pet_at_grow = pet:getAttrValue(pet_at_grow)
	local pet_capacity = pet:getAttrValue(pet_capacity)
	local pet_inc_at = pet:getAttrValue(pet_inc_at) / 1000
	local pet_add_at = pet:getAttrValue(pet_add_at)
	--return math.floor((pet_str*pet_capacity*4/500+math.pow(level-1,2)*pet_at_grow/1500)*(1+pet_inc_at)+pet_add_at)
	return math.floor((pet_str*pet_capacity*2.5/800+math.pow(level+1,2)*pet_at_grow/3000+250-level)*(1+pet_inc_at)+pet_add_at)
end

--法术攻击=（智力*天资成长*2.5/800+(等级+1)^2*法攻成长/3000+250-等级）*（1+法术攻击力加成）+法术攻击力加值
function PetAttrbuteFormula.pet_mt(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_int = pet:getAttrValue(pet_int)
	local pet_mt_grow = pet:getAttrValue(pet_mt_grow)
	local pet_capacity = pet:getAttrValue(pet_capacity)
	local pet_inc_mt = pet:getAttrValue(pet_inc_mt) / 1000
	local pet_add_mt = pet:getAttrValue(pet_add_mt)
	--return math.floor((pet_int*pet_capacity*4/500+math.pow(level-1,2)*pet_mt_grow/1500)*(1+pet_inc_mt)+pet_add_mt)
	return math.floor((pet_int*pet_capacity*2.5/800+math.pow(level+1,2)*pet_mt_grow/3000+250-level)*(1+pet_inc_mt)+pet_add_mt)
end

--物理防御=（（根骨*1.5+武力*0.5+敏锐*0.5）*天资成长/800+(等级+1)^2*物防成长/3000+250-等级）*（1+物理防御力加成）+物理防御力加值
function PetAttrbuteFormula.pet_af(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_sta = pet:getAttrValue(pet_sta)
	local pet_str = pet:getAttrValue(pet_str)
	local pet_spi = pet:getAttrValue(pet_spi)
	local pet_af_grow = pet:getAttrValue(pet_af_grow)
	local pet_capacity = pet:getAttrValue(pet_capacity)
	local pet_inc_af = pet:getAttrValue(pet_inc_af) / 1000
	local pet_add_af = pet:getAttrValue(pet_add_af)
	--return math.floor((pet_sta*pet_capacity*2.5/500+math.pow(level-1,2)*pet_af_grow/1600+40)*(1+pet_inc_af)+pet_add_af)
	return math.floor(((pet_sta*1.5+pet_str*0.5+pet_spi*0.5)*pet_capacity/800+math.pow(level+1,2)*pet_af_grow/3000+250-level)*(1+pet_inc_af)+pet_add_af)
end

--法术防御=（（根骨*1.5+智力*0.5+敏锐*0.5）*天资成长/800+(等级+1)^2*法防成长/3000+250-等级）*（1+法术防御力加成）+法术防御力加值
function PetAttrbuteFormula.pet_mf(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_sta = pet:getAttrValue(pet_sta)
	local pet_int = pet:getAttrValue(pet_int)
	local pet_spi = pet:getAttrValue(pet_spi)
	local pet_mf_grow = pet:getAttrValue(pet_mf_grow)
	local pet_capacity = pet:getAttrValue(pet_capacity)
	local pet_inc_mf = pet:getAttrValue(pet_inc_mf) / 1000
	local pet_add_mf = pet:getAttrValue(pet_add_mf)
	--return math.floor((pet_sta*pet_capacity*2.5/500+math.pow(level-1,2)*pet_mf_grow/1600+40)*(1+pet_inc_mf)+pet_add_mf)
	return math.floor(((pet_sta*1.5+pet_int*0.5+pet_spi*0.5)*pet_capacity/800+math.pow(level+1,2)*pet_mf_grow/3000+250-level)*(1+pet_inc_mf)+pet_add_mf)
end

--命中=（武力*0.2+智力*0.1+敏锐*0.7+(等级-1)*0.5+20）*（1+命中加成）+命中加值
function PetAttrbuteFormula.pet_hit(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_str = pet:getAttrValue(pet_str)
	local pet_int = pet:getAttrValue(pet_int)
	local pet_spi = pet:getAttrValue(pet_spi)
	local pet_inc_hit = pet:getAttrValue(pet_inc_hit) / 1000
	local pet_add_hit = pet:getAttrValue(pet_add_hit)
	return math.floor((pet_str*0.2+pet_int*0.1+pet_spi*0.7+(level-1)*0.5+20)*(1+pet_inc_hit)+pet_add_hit)
end

--闪避=（敏锐*1+(等级-1)*0.5）*（1+闪避加成）+闪避加值
function PetAttrbuteFormula.pet_dodge(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_spi = pet:getAttrValue(pet_spi)
	local pet_inc_dodge = pet:getAttrValue(pet_inc_dodge) / 1000
	local pet_add_dodge = pet:getAttrValue(pet_add_dodge)
	return math.floor((pet_spi*1+(level-1)*0.5)*(1+pet_inc_dodge)+pet_add_dodge)
end

--暴击=（(等级-1)/2*1.2）*（1+暴击加成）+暴击加值
function PetAttrbuteFormula.pet_critical(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_inc_critical = pet:getAttrValue(pet_inc_critical) / 1000
	local pet_add_critical = pet:getAttrValue(pet_add_critical)
	--return math.floor((pet_spi*1.2+math.pow(level-1,2)/50)*(1+pet_inc_critical)+pet_add_critical)
	return math.floor((level-1)/2*1.2*(1+pet_inc_critical)+pet_add_critical)
end

--抗暴=（(等级-1)/2）*（1+抗暴加成）+抗暴加值
function PetAttrbuteFormula.pet_tenacity(pet)
	local level = pet:getAttrValue(pet_lvl)
	local pet_add_tenacity = pet:getAttrValue(pet_add_tenacity)
	local pet_inc_tenacity = pet:getAttrValue(pet_inc_tenacity) / 1000
	--return math.floor((pet_spi*1.5+math.pow(level-1,2)/100)*(1+pet_inc_tenacity)+pet_add_tenacity)
	return math.floor((level-1)/2*(1+pet_inc_tenacity)+pet_add_tenacity)
end

--速度=（身法*天资成长*1.5/800+速度成长*4/800）*（1+速度加成）+速度加值
function PetAttrbuteFormula.pet_speed(pet)
	local pet_dex = pet:getAttrValue(pet_dex)
	local pet_at_speed_grow = pet:getAttrValue(pet_at_speed_grow)
	local pet_capacity = pet:getAttrValue(pet_capacity)
	local pet_inc_speed = pet:getAttrValue(pet_inc_speed) / 1000
	local pet_add_speed = pet:getAttrValue(pet_add_speed)
	return math.floor((pet_dex*pet_capacity*1.5/800+pet_at_speed_grow*4/800)*(1+pet_inc_speed)+pet_add_speed)
end

--反震
function PetAttrbuteFormula.pet_counter(pet)
	return 0
end

--暴击效果加成=1.5
function PetAttrbuteFormula.pet_critical_effect(pet)
	return pet:getAttrValue(pet_inc_critical_effect) / 1000
end

--反击率=0.01+反击率加值
function PetAttrbuteFormula.pet_unhit_rate(pet)
	local add_rate = pet:getAttrValue(pet_add_unhit_rate) / 1000
	return 0.01 + add_rate
end

-- 标准道行
function PetAttrbuteFormula.pet_stand_tao(pet)
	local level = pet:getAttrValue(pet_lvl)
	return math.floor(math.pow(level,3)*0.29 + 73)
end

--属性影响关系
g_AttrPetInfluenceTable =
{
	-- 一级属性
	[pet_str]						= {pet_at,pet_hit,pet_max_mp},
	[pet_int]						= {pet_mt,pet_max_mp,pet_hit},
	[pet_sta]						= {pet_max_hp,pet_af,pet_mf,pet_tenacity},
	[pet_spi]						= {pet_critical,pet_hit,pet_af,pet_mf},
	[pet_dex]						= {pet_speed,pet_dodge},
	[pet_inborn_str]				= {pet_in_str},
	[pet_inborn_int]				= {pet_in_int},
	[pet_inborn_sta]				= {pet_in_sta},
	[pet_inborn_spi]				= {pet_in_spi},
	[pet_inborn_dex]				= {pet_in_dex},
	[pet_in_str]					= {pet_str},
	[pet_in_int]					= {pet_int},
	[pet_in_sta]					= {pet_sta},
	[pet_in_spi]					= {pet_spi},
	[pet_in_dex]					= {pet_dex},
	[pet_str_point]					= {pet_str},
	[pet_int_point]					= {pet_int},
	[pet_sta_point]					= {pet_sta},
	[pet_spi_point]					= {pet_spi},
	[pet_dex_point]					= {pet_dex},
	[pet_add_str]					= {pet_str},
	[pet_add_int]					= {pet_int},
	[pet_add_sta]					= {pet_sta},
	[pet_add_spi]					= {pet_spi},
	[pet_add_dex]					= {pet_dex},
	[pet_add_base_attr]				= {pet_str,pet_int,pet_sta,pet_spi,pet_dex},
	[pet_at_grow]					= {pet_at},
	[pet_af_grow]					= {pet_af},
	[pet_mt_grow]					= {pet_mt},
	[pet_mf_grow]					= {pet_mf},
	[pet_hp_grow]					= {pet_max_hp},
	[pet_at_speed_grow]				= {pet_speed},
	[pet_capacity]					= {pet_str,pet_int,pet_sta,pet_spi,pet_dex},

	[pet_fir_phase_point]			= {pet_fir_resist},
	[pet_soi_phase_point]			= {pet_soi_resist},
	[pet_win_phase_point]			= {pet_win_resist},
	[pet_poi_phase_point]			= {pet_poi_resist},
	[pet_ice_phase_point]			= {pet_ice_resist},
	[pet_thu_phase_point]			= {pet_thu_resist},
	[pet_chaos_phase_point]			= {pet_chaos_resist},
	[pet_taunt_phase_point]			= {pet_taunt_resist},
	[pet_sopor_phase_point]			= {pet_sopor_resist},
	[pet_silent_phase_point]		= {pet_silent_resist},
	[pet_freeze_phase_point]		= {pet_freeze_resist},
	[pet_toxicosis_phase_point]		= {pet_toxicosis_resist},
	
	-- 二级属性
	[pet_add_max_hp]					= {pet_max_hp},
	[pet_inc_max_hp]					= {pet_max_hp},
	[pet_add_max_mp]					= {pet_max_mp},
	[pet_inc_max_mp]					= {pet_max_mp},
	[pet_add_at]						= {pet_at},
	[pet_inc_at]						= {pet_at},
	[pet_add_mt]						= {pet_mt},
	[pet_inc_mt]						= {pet_mt},
	[pet_add_af]						= {pet_af},
	[pet_inc_af]						= {pet_af},
	[pet_add_mf]						= {pet_mf},
	[pet_inc_mf]						= {pet_mf},
	[pet_add_hit]						= {pet_hit},
	[pet_inc_hit]						= {pet_hit},
	[pet_add_dodge]						= {pet_dodge},
	[pet_inc_dodge]						= {pet_dodge},

	[pet_add_critical]					= {pet_critical},
	[pet_inc_critical]					= {pet_critical},
	[pet_inc_critical_effect]			= {pet_critical_effect},
	[pet_add_tenacity]					= {pet_tenacity},
	[pet_inc_tenacity]					= {pet_tenacity},
	[pet_add_speed]						= {pet_speed},
	[pet_inc_speed]						= {pet_speed},

	[pet_inc_taunt_resist] 				= {pet_taunt_resist},
	[pet_inc_sopor_resist] 				= {pet_sopor_resist},
	[pet_inc_chaos_resist] 				= {pet_chaos_resist},
	[pet_inc_freeze_resist] 			= {pet_freeze_resist},
	[pet_inc_silent_resist] 			= {pet_silent_resist},
	[pet_inc_toxicosis_resist] 			= {pet_toxicosis_resist},

	[pet_add_unhit_rate]				= {pet_unhit_rate},
	
	-- 三级属性
	[pet_add_mobile_speed]				= {pet_mobile_speed},
	[pet_lvl]							= {pet_next_xp,pet_in_str,pet_in_int,pet_in_sta,pet_in_spi,pet_in_dex,pet_at,pet_af,pet_mt,pet_mf,pet_max_hp,pet_speed,pet_hit,pet_dodge,pet_critical,pet_tenacity,pet_stand_tao},
	[pet_inc_counter]					= {pet_counter},
	[pet_inc_escape]					= {pet_escape},
}

--属性公式对着表
g_AttributePetFormat =
{
	[pet_str]						= PetAttrbuteFormula.pet_str,
	[pet_int]						= PetAttrbuteFormula.pet_int,
	[pet_sta]						= PetAttrbuteFormula.pet_sta,
	[pet_spi]						= PetAttrbuteFormula.pet_spi,
	[pet_dex]						= PetAttrbuteFormula.pet_dex,
	[pet_in_str]					= PetAttrbuteFormula.pet_in_str,
	[pet_in_int]					= PetAttrbuteFormula.pet_in_int,
	[pet_in_sta]					= PetAttrbuteFormula.pet_in_sta,
	[pet_in_spi]					= PetAttrbuteFormula.pet_in_spi,
	[pet_in_dex]					= PetAttrbuteFormula.pet_in_dex,
	[pet_max_hp]					= PetAttrbuteFormula.pet_max_hp,
	[pet_max_mp]					= PetAttrbuteFormula.pet_max_mp,
	[pet_at]						= PetAttrbuteFormula.pet_at,
	[pet_mt]						= PetAttrbuteFormula.pet_mt,
	[pet_af]						= PetAttrbuteFormula.pet_af,
	[pet_mf]						= PetAttrbuteFormula.pet_mf,
	[pet_hit]						= PetAttrbuteFormula.pet_hit,
	[pet_dodge]						= PetAttrbuteFormula.pet_dodge,
	[pet_critical]					= PetAttrbuteFormula.pet_critical,
	[pet_tenacity]					= PetAttrbuteFormula.pet_tenacity,
	[pet_speed]						= PetAttrbuteFormula.pet_speed,
	[pet_win_at]					= PetAttrbuteFormula.pet_win_at,
	[pet_thu_at]					= PetAttrbuteFormula.pet_thu_at,
	[pet_ice_at]					= PetAttrbuteFormula.pet_ice_at,
	[pet_fir_at]					= PetAttrbuteFormula.pet_fir_at,
	[pet_soi_at]					= PetAttrbuteFormula.pet_soi_at,
	[pet_poi_at]					= PetAttrbuteFormula.pet_poi_at,
	[pet_win_resist]				= PetAttrbuteFormula.pet_win_resist,
	[pet_thu_resist]				= PetAttrbuteFormula.pet_thu_resist,
	[pet_ice_resist]				= PetAttrbuteFormula.pet_ice_resist,
	[pet_fir_resist]				= PetAttrbuteFormula.pet_fir_resist,
	[pet_soi_resist]				= PetAttrbuteFormula.pet_soi_resist,
	[pet_poi_resist]				= PetAttrbuteFormula.pet_poi_resist,
	[pet_critical_effect]			= PetAttrbuteFormula.pet_critical_effect,
	[pet_next_xp]					= PetAttrbuteFormula.pet_next_xp,

	[pet_taunt_resist]				= PetAttrbuteFormula.pet_taunt_resist,
	[pet_sopor_resist]				= PetAttrbuteFormula.pet_sopor_resist,
	[pet_chaos_resist]				= PetAttrbuteFormula.pet_chaos_resist,
	[pet_freeze_resist]				= PetAttrbuteFormula.pet_freeze_resist,
	[pet_silent_resist]				= PetAttrbuteFormula.pet_silent_resist,
	[pet_toxicosis_resist]			= PetAttrbuteFormula.pet_toxicosis_resist,

	[pet_counter]					= PetAttrbuteFormula.pet_counter,
	[pet_stand_tao]					= PetAttrbuteFormula.pet_stand_tao,
	[pet_unhit_rate]				= PetAttrbuteFormula.pet_unhit_rate,
}
-- ---------------------------------------------------------------------
-- 程序配置
-- ---------------------------------------------------------------------
-- 属性对应的属性同步
g_AttributePetToProp =
{
	[pet_lvl]						= PET_LEVEL,
	[pet_xp]						= PET_XP,
	[pet_next_xp]					= PET_NEXT_XP,

	[pet_hp]						= PET_HP,
	[pet_mp]						= PET_MP,
	[pet_max_hp]					= PET_MAX_HP,
	[pet_max_mp]					= PET_MAX_MP,

	[pet_str]						= PET_STR,
	[pet_int]						= PET_INT,
	[pet_sta]						= PET_STA,
	[pet_spi]						= PET_SPI,
	[pet_dex]						= PET_DEX,

	[pet_str_point]					= PET_STR_POINT,
	[pet_int_point]					= PET_INT_POINT,
	[pet_sta_point]					= PET_STA_POINT,
	[pet_spi_point]					= PET_SPI_POINT,
	[pet_dex_point]					= PET_DEX_POINT,

	[pet_attr_point]				= PET_ATTR_POINT,
	[pet_phase_point]				= PET_PHASE_POINT,

	[pet_win_at]					= PET_WIN_AT,
	[pet_thu_at]					= PET_THU_AT,
	[pet_ice_at]					= PET_ICE_AT,
	[pet_soi_at]					= PET_SOI_AT,
	[pet_fir_at]					= PET_FIR_AT,
	[pet_poi_at]					= PET_POI_AT,

	[pet_win_resist]				= PET_WIN_RESIST,
	[pet_thu_resist]				= PET_THU_RESIST,
	[pet_ice_resist]				= PET_ICE_RESIST,
	[pet_soi_resist]				= PET_SOI_RESIST,
	[pet_fir_resist]				= PET_FIR_RESIST,
	[pet_poi_resist]				= PET_POI_RESIST,

	[pet_fir_phase_point]			= PET_FIR_PHASE_POINT,
	[pet_soi_phase_point]			= PET_SOI_PHASE_POINT,
	[pet_win_phase_point]			= PET_WIN_PHASE_POINT,
	[pet_poi_phase_point]			= PET_POI_PHASE_POINT,
	[pet_ice_phase_point]			= PET_ICE_PHASE_POINT,
	[pet_thu_phase_point]			= PET_THU_PHASE_POINT,

	[pet_at]						= PET_AT,
	[pet_mt]						= PET_MT,
	[pet_af]						= PET_AF,
	[pet_mf]						= PET_MF,

	[pet_hit]						= PET_HIT,
	[pet_dodge]						= PET_DODGE,
	[pet_critical]					= PET_CRITICAL,
	[pet_tenacity]					= PET_TENACITY,
	[pet_speed]						= PET_SPEED,
	[pet_capacity]					= PET_CAPACITY,

	[pet_at_grow]					= PET_AT_GROW,
	[pet_af_grow]					= PET_AF_GROW,
	[pet_mt_grow]					= PET_MT_GROW,
	[pet_mf_grow]					= PET_MF_GROW,
	[pet_hp_grow]					= PET_HP_GROW,
	[pet_at_speed_grow]				= PET_AT_SPEED_GROW,

	[pet_capacity_max]				= PET_CAPACITY_MAX,
	[pet_at_grow_max]				= PET_AT_GROW_MAX,
	[pet_af_grow_max]				= PET_AF_GROW_MAX,
	[pet_mt_grow_max]				= PET_MT_GROW_MAX,
	[pet_mf_grow_max]				= PET_MF_GROW_MAX,
	[pet_hp_grow_max]				= PET_HP_GROW_MAX,
	[pet_at_speed_grow_max]			= PET_AT_SPEED_GROW_MAX,

	[pet_life]						= PET_LIFE,
	[pet_life_max]					= PET_LIFE_MAX,

	[pet_tao]						= PET_TAO,
	[pet_stand_tao]					= PET_STAND_TAO,

	[pet_obstacle_hit]				= PET_OBSTACLE_HIT,

	[pet_taunt_resist]				= PET_TAUNT_RESIST,
	[pet_sopor_resist]				= PET_SOPOR_RESIST,
	[pet_chaos_resist]				= PET_CHAOS_RESIST,
	[pet_freeze_resist]				= PET_FREEZE_RESIST,
	[pet_silent_resist]				= PET_SILENT_RESIST,
	[pet_toxicosis_resist]			= PET_TOXICOSIS_RESIST,

	[pet_chaos_phase_point]			= PET_CHAOS_PHASE_POINT,
	[pet_sopor_phase_point]			= PET_SOPOR_PHASE_POINT,
	[pet_taunt_phase_point]			= PET_TAUNT_PHASE_POINT,
	[pet_freeze_phase_point]		= PET_FREEZE_PHASE_POINT,
	[pet_silent_phase_point]		= PET_SILENT_PHASE_POINT,
	[pet_toxicosis_phase_point]		= PET_TOXICOSIS_PHASE_POINT,

	[pet_inc_at]					= PET_INC_AT,
	[pet_inc_af]					= PET_INC_AF,
	[pet_inc_mt]					= PET_INC_MT,
	[pet_inc_mf]					= PET_INC_MF,
	[pet_inc_max_hp]				= PET_INC_MAX_HP,
	[pet_inc_max_mp]				= PET_INC_MAX_MP,
	[pet_inc_critical]				= PET_INC_CRITICAL,
	[pet_inc_tenacity]				= PET_INC_TENACITY,
	[pet_inc_speed]					= PET_INC_SPEED,
	[pet_inc_hit]					= PET_INC_HIT,
	[pet_inc_dodge]					= PET_INC_DODGE,

	[pet_skill_max]					= PET_SKILL_MAX,
	[pet_up_comp]					= PET_UPCOMP,

}

-- 需要立刻更新的属性
g_AttrPetSyncTable =
{
	[pet_in_str] = true,
	[pet_in_int] = true,
	[pet_in_sta] = true,
	[pet_in_spi] = true,
	[pet_in_dex] = true,
	[pet_str] = true,
	[pet_int] = true,
	[pet_sta] = true,
	[pet_spi] = true,
	[pet_dex] = true,
	[pet_win_at] = true,
	[pet_thu_at] = true,
	[pet_ice_at] = true,
	[pet_fir_at] = true,
	[pet_soi_at] = true,
	[pet_poi_at] = true,
	[pet_win_resist] = true,
	[pet_thu_resist] = true,
	[pet_ice_resist] = true,
	[pet_fir_resist] = true,
	[pet_soi_resist] = true,
	[pet_poi_resist] = true,
	[pet_max_hp] = true,
	[pet_max_mp] = true,
	[pet_at] = true,
	[pet_mt] = true,
	[pet_af] = true,
	[pet_mf] = true,
	[pet_hit] = true,
	[pet_dodge]= true,
	[pet_critical] = true,
	[pet_tenacity] = true,
	[pet_speed] = true,
	[pet_mobile_speed] = true,

}
