-- GMAttributes.lua

require "entity.Attribute"

local PlayerAttributes = {
	[player_xp] = {
		alias				= "xp",
		get_func			= Player.getXp,
		add_func			= Player.addXp,
		comments			= "玩家经验",
	},
	[player_lvl] = {
		alias				= "lvl",
		get_func			= Player.getLevel,
		set_func			= Player.onLevelUp,
		no_less_than_value	= 1,
		no_more_than_value	= 150,
		comments			= "玩家等级",
	},
	[player_tao] = {
		alias				= "tao",
		add_func			= Player.addTao,
		comments			= "玩家道行",
	},
	[player_pot] = {
		alias				= "pot",
		comments			= "玩家潜能",
	},
	[player_expoint] = {
		alias				= "expoint",
		comments			= "玩家历练值",
	},
	[player_hp] = {
		alias				= "hp",
		get_func			= Player.getHP,
		set_func			= Player.setHP,
		no_more_than_attr	= player_max_hp,
		comments			= "玩家血量",
	},
	[player_mp] = {
		alias				= "mp",
		get_func			= Player.getMP,
		set_func			= Player.setMP,
		no_more_than_attr	= player_max_mp,
		comments			= "玩家蓝量",
	},
	[player_max_hp] = {
		alias				= "maxhp",
		get_func			= Player.getMaxHP,
		delta_attr			= player_add_max_hp,
		multi_attr			= player_inc_max_hp,
		comments			= "玩家最大血量",
	},
	[player_max_mp] = {
		alias				= "maxmp",
		get_func			= Player.getMaxMP,
		delta_attr			= player_add_max_mp,
		multi_attr			= player_inc_max_mp,
		comments			= "玩家最大蓝量",
	},
	[player_at] = {
		alias				= "at",
		delta_attr			= player_add_at,
		multi_attr			= player_inc_at,
		comments			= "玩家物理攻击",
	},
	[player_af] = {
		alias				= "af",
		delta_attr			= player_add_af,
		multi_attr			= player_inc_af,
		comments			= "玩家物理防御",
	},
	[player_mt] = {
		alias				= "mt",
		delta_attr			= player_add_mt,
		multi_attr			= player_inc_mt,
		comments			= "玩家魔法攻击",
	},
	[player_mf] = {
		alias				= "mf",
		delta_attr			= player_add_mf,
		multi_attr			= player_inc_mf,
		comments			= "玩家魔法防御",
	},
	[player_speed] = {
		alias				= "sp",
		delta_attr			= player_add_speed,
		multi_attr			= player_inc_speed,
		comments			= "玩家攻击速度",
	},
	[player_str] = {
		alias				= "str",
		delta_attr			= player_add_str,
		comments			= "玩家武力",
	},
	[player_int] = {
		alias				= "int",
		delta_attr			= player_add_str,
		comments			= "玩家智力",
	},
	[player_sta] = {
		alias				= "sta",
		delta_attr			= player_add_sta,
		comments			= "玩家根骨",
	},
	[player_spi] = {
		alias				= "spi",
		delta_attr			= player_add_spi,
		comments			= "玩家敏锐",
	},
	[player_dex] = {
		alias				= "dex",
		delta_attr			= player_add_dex,
		comments			= "玩家身法",
	},
	[player_vigor] = {
		alias				= "vigor",
		get_func			= Player.getVigor,
		set_func			= Player.setVigor,
		no_more_than_attr	= player_max_vigor,
		comments			= "玩家体力",
	},
	[player_critical] = {
		alias				= "crt",
		delta_attr			= player_add_critical,
		multi_attr			= player_inc_critical,
		comments			= "玩家暴击",
	},
	[player_tenacity] = {
		alias				= "ten",
		delta_attr			= player_add_tenacity,
		multi_attr			= player_inc_critical,
		comments			= "玩家抗暴",
	},
	[player_add_max_hm] = {
		alias				= "add_max_hm",
		comments			= "玩家最大红蓝加值",
	},
	[player_inc_max_hm] = {
		alias				= "inc_max_hm",
		comments			= "玩家最大红蓝加成",
	},
	[player_attr_point] = {
		alias				= "attrpnt",
		add_func			= Player.addAttrPoint,
		comments			= "玩家自由属性点",
	},
	[player_phase_point] = {
		alias				= "phasepnt",
		add_func			= Player.addPhasePoint,
		comments			= "玩家自由相性点",
	},
	[player_add_mind_level] = {
		alias				= "mind_lvl_add",
		comments			= "玩家心法等级加值",
	},
	[player_max_pet] = {
		alias				= "petbar",
		comments			= "玩家最大宠物数量",
	},

	[-1024] = {
		alias				= "submoney",
		get_func			= Player.getSubMoney,
		set_func			= Player.setSubMoney,
		comments			= "玩家绑银",
	},
	[-1023] = {
		alias				= "depotmoney",
		get_func			= Player.getDepotMoney,
		set_func			= Player.setDepotMoney,
		comments			= "玩家仓库银两",
	},
	[-1022] = {
		alias				= "depotCapacity",
		get_func			= Player.getDepotCapacity,
		set_func			= Player.setDepotCapacity,
		comments			= "玩家仓库容量",
	},
	[-1021] = {
		alias				= "money",
		get_func			= Player.getMoney,
		set_func			= Player.setMoney,
		comments			= "玩家银两",
	},
	[-1020] = {
		alias				= "cashmoney",
		get_func			= Player.getCashMoney,
		set_func			= Player.setCashMoney,
		comments			= "玩家礼金",
	},
	[-1019] = {
		alias				= "goldcoin",
		get_func			= Player.getGoldCoin,
		set_func			= Player.setGoldCoin,
		comments			= "玩家金元宝",
	},
	[-1018] = {
		alias				= "movespeed",
		get_func			= Player.getMoveSpeed,
		set_func			= Player.setMoveSpeed,
		comments			= "玩家移动速度",
	},
	[-1017] = {
		alias				= "model",
		set_func			= Player.setModelID,
		comments			= "玩家模型(不要随意设置!!!)",
	},
	[-1018] = {
		alias				= "all",
		set_func			= Player.setAll,
		comments			= "同时更改五个基础属性",
	},
}

local PetAttributes = {
	[pet_lvl] = {
		alias				= "lvl",
		set_func			= Pet.onLevelUP,
		no_less_than_value	= 1,
		no_more_than_value	= 150,
		comments			= "宠物等级",
	},
	[pet_xp] = {		
		alias				= "xp",
		set_func			= Pet.setXp,
		add_func			= Pet.addXp,
		comments			= "宠物经验",
	},
	[pet_tao] = {
		alias				= "tao",
		no_more_than_value	= 10000,
		comments			= "宠物道行",
	},
	[pet_hp] = {		
		alias				= "hp",
		no_more_than_attr	= pet_max_hp,
		comments			= "宠物血量",
	},
	[pet_mp] = {		
		alias				= "mp",
		no_more_than_attr	= pet_max_mp,
		comments			= "宠物蓝量",
	},
	[pet_max_hp]  = {
		alias				= "maxhp",
		delta_attr			= pet_add_max_hp,
		multi_attr			= pet_inc_max_hp,
		comments			= "宠物最大血量",
	},
	[pet_max_mp]	= {
		alias				= "maxmp",
		delta_attr			= pet_add_max_mp,
		multi_attr			= pet_inc_max_mp,
		comments			= "宠物最大蓝量",
	},
	[pet_life] =		 {
		alias				= "life",
		no_more_than_attr	= pet_life_max,
		get_func			= Pet.getPetLife,
		set_func			= Pet.setPetLife,
		comments			= "宠物寿命",
	},
	[pet_life_max] = {
		alias				= "maxlife",
		comments			= "宠物最大寿命",
	},
	[pet_attr_point] = {
		alias				= "attrpnt",
		add_func			= Pet.addAttrPoint,
		comments			= "宠物属性点",
	},
	[pet_phase_point] = {
		alias				= "phasepnt",
		comments			= "宠物相性点",
	},
	[pet_skill_max] = {
		alias				= "maxskill",
		comments			= "宠物最大技能数量",
	},
	[pet_at] = {
		alias				= "at",
		delta_attr			= pet_add_at,
		multi_attr			= pet_inc_at,
		comments			= "宠物物理攻击",
	},
	[pet_af] = {
		alias				= "af",
		delta_attr			= pet_add_af,
		multi_attr			= pet_inc_af,
		comments			= "宠物物理防御",
	},
	[pet_mt] = {
		alias				= "mt",
		delta_attr			= pet_add_mt,
		multi_attr			= pet_inc_mt,
		comments			= "宠物魔法攻击",
	},
	[pet_mf] = {
		alias				= "mf",
		delta_attr			= pet_add_mf,
		multi_attr			= pet_inc_mf,
		comments			= "宠物魔法防御",
	},
	[pet_speed] = {
		alias				= "sp",
		delta_attr			= pet_add_speed,
		multi_attr			= pet_inc_speed,
		comments			= "宠物攻击速度",
	},
	[pet_str] = {
		alias				= "str",
		delta_attr			= pet_add_str,
		comments			= "宠物武力",
	},
	[pet_int] = {
		alias				= "int",
		delta_attr			= pet_add_str,
		comments			= "宠物智力",
	},
	[pet_sta] = {
		alias				= "sta",
		delta_attr			= pet_add_sta,
		comments			= "宠物根骨",
	},
	[pet_spi] = {
		alias				= "spi",
		delta_attr			= pet_add_spi,
		comments			= "宠物敏锐",
	},
	[pet_dex] = {
		alias				= "dex",
		delta_attr			= pet_add_dex,
		comments			= "宠物身法",
	},
	[pet_critical] = {
		alias				= "crt",
		delta_attr			= pet_add_critical,
		multi_attr			= pet_inc_critical,
		comments			= "宠物暴击",
	},
	[pet_tenacity] = {
		alias				= "ten",
		delta_attr			= pet_add_tenacity,
		multi_attr			= pet_inc_critical,
		comments			= "宠物抗暴",
	},
	[-1023] = {
		alias				= "model",
		set_func			= Pet.setModelID,
		no_less_than_value	= 13,
		comments			= "宠物模型(不要随意设置!!!)",
	},
	[-1022] = {
		alias				= "type",
		set_func			= Pet.setPetType,
		comments			= "宠物类型",
	},
	[-1021] = {
		alias				= "attacktype",
		set_func			= Pet.setPhaseType,
		comments			= "宠物攻击类型",
	},
	[-1020] = {
		alias				= "phasetype",
		set_func			= Pet.setPhaseType,
		comments			= "宠物相性类型",
	},
	[-1019] = {
		alias				= "loyalty",
		get_func			= Pet.getLoyalty,
		set_func			= Pet.setLoyalty,
		comments			= "宠物忠诚度",
	},
	[-1018] = {
		alias				= "uplevel",
		get_func			= Pet.getUpLevel,
		set_func			= Pet.setUpLevel,
		comments			= "宠物强化等级",
	},
	[-1017] = {
		alias				= "all",
		set_func			= Pet.setAll,
		comments			= "同时改变5个基础属性",
	},
}

local MonsterAttributes = {
	[monster_hp] = {
		alias				= "hp",
	},
	[monster_at] = {
		alias				= "at",
	}
}

local function MakeGM(AttrDefine,AttrConfig,CMDPools,entityType)
	local cmds = CMDPools[entityType]
	if not cmds then
		cmds = {}
		CMDPools[entityType] = cmds
	end
	for attrName,config in pairs(AttrConfig) do
		local getFunc			= config.get_func
		local addFunc			= config.add_func
		local setFunc			= config.set_func

		local alias				= config.alias
		local isExpr			= attrName > 0 and AttrDefine[attrName].expr
		local deltaAttr			= config.delta_attr
		local minValue			= config.no_less_than_value or 0
		local maxValue			= config.no_more_than_value
		local maxAttr			= config.no_more_than_attr

		-- 取值函数,指定取值函数>取属性集合属性
		if not getFunc and attrName > 0 then
			function getFunc(entity)
				return entity:getAttrValue(attrName)
			end
		end

		-- 该条属性的上限值取值函数
		local function max_value(entity)
			if maxValue then
				return maxValue
			elseif maxAttr then
				return entity:getAttrValue(maxAttr)
			end
			return nil
		end

		-- 限定对属性的设值在指定范围内
		local function ensure_value(entity,value)
			if value < minValue then
				return minValue
			end
			local maxValue = max_value(entity)
			if maxValue and value > maxValue then
				return maxValue
			end
			return value
		end

		-- 设值函数
		local function setValue(entity,value)
			local done = true
			value = ensure_value(entity,value) -- 确保值的范围
			repeat
				if setFunc then
					setFunc(
						entity,value
					)
					break	-- 如果有设值函数,直接调用
				end
				if attrName > 0 and not isExpr then -- 如果是属性名有效,并且是直接属性,设值
					entity:setAttrValue(
						attrName,value
					)
					break
				end
				if getFunc then -- 无法通过直接设置的方式设值
					if deltaAttr then	-- 通过属性分量加值
						entity:addAttrValue(deltaAttr,
						  value - getFunc(entity)
						)
						break
					end
					if addFunc then
						addFunc( -- 通过加值函数设置
							entity,value - getFunc(entity)
						)
						break
					end
				end
				done = false
			until true
			if done then
				entity:flushPropBatch()
			else
				print(("Entity %s set attribute %s failed!"):format(string.gbk2Utf8(entity:getName()),config.alias))
			end
		end

		cmds[alias] = { setValue,attrName }
	end
end

function InitGMAttibutes()
	local pool = {}

	MakeGM(PlayerAttrDefine,PlayerAttributes,pool,eLogicPlayer)
	MakeGM(PetAttrDefine,PetAttributes,pool,eLogicPet)
	MakeGM(MonsterAttrDefine,MonsterAttributes,pool,eLogicMonster)

	return pool
end

-- Know Thyself
