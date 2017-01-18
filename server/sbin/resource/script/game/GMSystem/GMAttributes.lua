--[[GMAttributes.lua

Contributor:ChenMiin
]]
require "attribute.PlayerAttrDefine"
require "entity.Player"
require "entity.Pet"

--[[
	-------<< 一个GM属性指令的配置 >>-------
	[player_max_mp] = {					--属性的真正属性名称，可以小于0<即不绑定具体的属性名称>
		alias		= "maxmp",			--属性的附名<用于生成指令名称>
		get_func	= Player.getMaxMP,	--属性的取值函数
		set_func	= false,			--属性的设值函数
		add_func	= false,			--属性的加值函数
		components	= {					--属性的组成
			delta = player_add_max_mp,	--加值
			times = player_inc_max_mp,	--加成
		},
		default		= 0,				--最小值
		limited		= false,			--上限，可以是一个属性名称，也可以是一个用字符串表示的数字
		limits		= player_mp,		--作为谁的上限，并在当前属性改变的时候影响这个属性
	}
]]

PlayerGMAttrs = {
	[player_xp] = {
		alias		= "xp",
		get_func	= Player.getXp,
		set_func	= Player.setXp,
		add_func	= Player.addXp,
		comments	= "玩家经验",
	},
	[player_lvl] = {
		alias		= "lvl",
		get_func	= Player.getLevel,
		set_func	= Player.onLevelUp,
		default		= 1,
		limited		= "200",
		comments	= "玩家等级",
	},
	[player_tao] = {
		alias		= "tao",
		add_func	= Player.addTao,
		comments	= "玩家道行",
	},
	[player_pot] = {
		alias		= "pot",
		comments	= "玩家潜能",
	},
	[player_expoint] = {
		alias		= "expoint",
		comments	= "玩家历练值",
	},
	[player_hp] = {
		alias		= "hp",
		get_func	= Player.getHP,
		set_func	= Player.setHP,
		add_func	= Player.incHp,
		limited		= player_max_hp,
		comments	= "玩家血量",
	},
	[player_mp] = {
		alias		= "mp",
		get_func	= Player.getMP,
		set_func	= Player.setMP,
		limited		= player_max_mp,
		comments	= "玩家蓝量",
	},
	[player_max_hp] = {
		alias		= "maxhp",
		get_func	= Player.getMaxHP,
		components	= {
			delta = player_add_max_hp,
			times = player_inc_max_hp,
		},
		limits		= player_hp,
		comments	= "玩家最大血量",
	},
	[player_max_mp] = {
		alias		= "maxmp",
		get_func	= Player.getMaxMP,
		components	= {
			delta = player_add_max_mp,
			times = player_inc_max_mp,
		},
		limits		= player_mp,
		comments	= "玩家最大蓝量",
	},
	[player_at] = {
		alias		= "at",
		components	= {
			delta = player_add_at,
			times = player_inc_at,
		},
		comments	= "玩家物理攻击",
	},
	[player_af] = {
		alias		= "af",
		components	= {
			delta = player_add_af,
			times = player_inc_af,
		},
		comments	= "玩家物理防御",
	},
	[player_mt] = {
		alias		= "mt",
		components	= {
			delta = player_add_mt,
			times = player_inc_mt,
		},
		comments	= "玩家魔法攻击",
	},
	[player_mf] = {
		alias		= "mf",
		components	= {
			delta = player_add_mf,
			times = player_inc_mf,
		},
		comments	= "玩家魔法防御",
	},
	[player_speed] = {
		alias		= "sp",
		components	= {
			delta = player_add_speed,
			times = player_inc_speed,
		},
		comments	= "玩家攻击速度",
	},
	[player_str] = {
		alias		= "str",
		components	= {
			delta = player_add_str,
		},
		comments	= "玩家武力",
	},
	[player_int] = {
		alias		= "int",
		components	= {
			delta = player_add_str,
		},
		comments	= "玩家智力",
	},
	[player_sta] = {
		alias		= "sta",
		components	= {
			delta = player_add_sta,
		},
		comments	= "玩家根骨",
	},
	[player_spi] = {
		alias		= "spi",
		components	= {
			delta = player_add_spi,
		},
		comments	= "玩家敏锐",
	},
	[player_dex] = {
		alias		= "dex",
		components	= {
			delta = player_add_dex,
		},
		comments	= "玩家身法",
	},
	[player_vigor] = {
		alias		= "vigor",
		get_func	= Player.getVigor,
		set_func	= Player.setVigor,
		limited		= player_max_vigor,
		comments	= "玩家体力",
	},
	[player_critical] = {
		alias		= "crt",
		components	= {
			delta	= player_add_critical,
			times	= player_inc_critical,
		},
		comments	= "玩家暴击",
	},
	[player_tenacity] = {
		alias		= "ten",
		components	= {
			delta	= player_add_tenacity,
			times	= player_inc_critical,
		},
		comments	= "玩家抗暴",
	},
	[player_add_max_hm] = {
		alias		= "add_max_hm",
		comments	= "玩家最大红蓝加值",
	},
	[player_inc_max_hm] = {
		alias		= "inc_max_hm",
		comments	= "玩家最大红蓝加成",
	},
	[player_attr_point] = {
		alias		= "attrpnt",
		add_func	= Player.addAttrPoint,
		comments	= "玩家自由属性点",
	},
	[player_phase_point] = {
		alias		= "phasepnt",
		add_func	= Player.addPhasePoint,
		comments	= "玩家自由相性点",
	},
	[player_add_mind_level] = {
		alias = "mind_lvl_add",
		comments	= "玩家心法等级加值",
	},
	[player_max_pet] = {
		alias		= "petbar",
		comments	= "玩家最大宠物数量",
	},

	[-1024] = {
		alias		= "submoney",
		get_func	= Player.getSubMoney,
		set_func	= Player.setSubMoney,
		comments	= "玩家绑银",
	},
	[-1023] = {
		alias		= "depotmoney",
		get_func	= Player.getDepotMoney,
		set_func	= Player.setDepotMoney,
		comments	= "玩家仓库银两",
	},
	[-1022] = {
		alias		= "depotCapacity",
		get_func	= Player.getDepotCapacity,
		set_func	= Player.setDepotCapacity,
		comments	= "玩家仓库容量",
	},
	[-1021] = {
		alias		= "money",
		get_func	= Player.getMoney,
		set_func	= Player.setMoney,
		comments	= "玩家银两",
	},
	[-1020] = {
		alias		= "cashmoney",
		get_func	= Player.getCashMoney,
		set_func	= Player.setCashMoney,
		comments	= "玩家礼金",
	},
	[-1019] = {
		alias		= "goldcoin",
		get_func	= Player.getGoldCoin,
		set_func	= Player.setGoldCoin,
		comments	= "玩家金元宝",
	},
	[-1018] = {
		alias		= "movespeed",
		get_func	= Player.getMoveSpeed,
		set_func	= Player.setMoveSpeed,
		comments	= "玩家移动速度",
	},
	[-1017] = {
		alias 		= "model",
		set_func	= Player.setModelID,
		comments	= "玩家模型(不要随意设置!!!)",
	}
}

PetGMAttrs = {
	[pet_lvl] = {
		alias		= "pet_lvl",
		set_func	= Pet.onLevelUP,
		default		= 1,
		limited		= "200",
		comments	= "宠物等级",
	},
	[pet_xp] = {
		alias		= "pet_xp",
		set_func	= Pet.setXp,
		add_func	= Pet.addXp,
		comments	= "宠物经验",
	},
	[pet_tao] = {
		alias		= "pet_tao",
		limited		= "10000",
		comments	= "宠物道行",
	},
	[pet_hp] = {
		alias		= "pet_hp",
		limited		= pet_max_hp,
		comments	= "宠物血量",
	},
	[pet_mp] = {
		alias		= "pet_mp",
		limited		= pet_max_mp,
		comments	= "宠物蓝量",
	},
	[pet_max_hp] = {
		alias		= "pet_maxhp",
		components	= {
			delta = pet_add_max_hp,
			times = pet_inc_max_hp,
		},
		limits		= pet_hp,
		comments	= "宠物最大血量",
	},
	[pet_max_mp] = {
		alias		= "pet_maxmp",
		components	= {
			delta = pet_add_max_mp,
			times = pet_inc_max_mp,
		},
		limits		= pet_mp,
		comments	= "宠物最大蓝量",
	},
	[pet_life] = {
		alias		= "pet_life",
		limited		= pet_life_max,
		get_func	= Pet.getPetLife,
		set_func	= Pet.setPetLife,
		comments	= "宠物寿命",
	},
	[pet_life_max] = {
		alias		= "pet_maxlife",
		limits		= pet_life,
		comments	= "宠物最大寿命",
	},
	[pet_attr_point] = {
		alias		= "pet_attrpnt",
		add_func	= Pet.addAttrPoint,
		comments	= "宠物属性点",
	},
	[pet_phase_point] = {
		alias		= "pet_phasepnt",
		comments	= "宠物相性点",
	},
	[pet_skill_max] = {
		alias		= "pet_maxskill",
		comments	= "宠物最大技能数量",
	},
	[-1023] = {
		alias		= "pet_model",
		set_func	= Pet.setModelID,
		default		= 13,
		comments	= "宠物模型(不要随意设置!!!)",
	},
	[-1022] = {
		alias		= "pet_type",
		set_func	= Pet.setPetType,
		comments	= "宠物类型",
	},
	[-1021] = {
		alias		= "pet_attacktype",
		set_func	= Pet.setPhaseType,
		comments	= "宠物攻击类型",
	},
	[-1020] = {
		alias		= "pet_phasetype",
		set_func	= Pet.setPhaseType,
		comments	= "宠物相性类型",
	},
	[-1019] = {
		alias		= "pet_loyalty",
		get_func	= Pet.getLoyalty,
		set_func	= Pet.setLoyalty,
		comments	= "宠物忠诚度",
	},
	[-1018] = {
		alias		= "pet_uplevel",
		get_func	= Pet.getUpLevel,
		set_func	= Pet.setUpLevel,
		comments	= "宠物强化等级",
	},
}
