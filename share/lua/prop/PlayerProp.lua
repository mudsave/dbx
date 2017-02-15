--[[PlayerProp.lua
	玩家同步属性定义
]]

-- 格式
-- { propName,dataType,defaultValue,isPublic,isSync },
local PlayerProps = {
	{"PLAYER_SEX",					"BYTE",		0,		Public,		Postpone},	-- 玩家性别
	{"PLAYER_SCHOOL",				"BYTE",		0,		Public,		Postpone},	-- 玩家门派
	{"PLAYER_ACTION_STATE",			"SHORT",	0,		Public,		Sync},		-- 图标
	{"PLAYER_EQUIP_WEAPON",			"STRING",	"",		Public,		Sync},		-- 武器
	{"PLAYER_RIDE_INFO",			"STRING",	"",		Public,		Sync},		-- 坐骑信息

	{"PLAYER_LEVEL",				"INT",		0,		Public,		Postpone},	-- 玩家等级
	{"PLAYER_XP",					"INT",		0,		Private,	Postpone},	-- 经验
	{"PLAYER_NEXT_XP",				"INT",		0,		Private,	Postpone},	-- 升级经验

	{"PLAYER_HP",					"INT",		0,		Public,		Postpone},	-- 生命
	{"PLAYER_MP",					"INT",		0,		Public,		Postpone},	-- 法力
	{"PLAYER_MAX_HP",				"INT",		0,		Public,		Postpone},	-- 最大生命
	{"PLAYER_MAX_MP",				"INT",		0,		Public,		Postpone},	-- 最大法力

	{"PLAYER_INC_MAX_HP",			"INT",		0,		Public,		Postpone},	-- 生命值上限加成
	{"PLAYER_INC_MAX_MP",			"INT",		0,		Public,		Postpone},	-- 法力值上限加成
	{"PLAYER_INC_MAX_HM",			"INT",		0,		Public,		Postpone},	-- 红蓝上限加成
	
	{"PLAYER_STR",					"INT",		0,		Private,	Postpone},	-- 武力
	{"PLAYER_INT",					"INT",		0,		Private,	Postpone},	-- 智力
	{"PLAYER_STA",					"INT",		0,		Private,	Postpone},	-- 根骨
	{"PLAYER_SPI",					"INT",		0,		Private,	Postpone},	-- 敏锐
	{"PLAYER_DEX",					"INT",		0,		Private,	Postpone},	-- 身法

	{"PLAYER_ATTR_POINT",			"INT",		0,		Private,	Postpone},	-- 玩家属性点
	{"PLAYER_PHASE_POINT",			"INT",		0,		Private,	Postpone},	-- 玩家相性点

	{"PLAYER_STR_POINT",			"INT",		0,		Private,	Postpone},	-- 武力加点
	{"PLAYER_INT_POINT",			"INT",		0,		Private,	Postpone},	-- 智力加点
	{"PLAYER_STA_POINT",			"INT",		0,		Private,	Postpone},	-- 根骨加点
	{"PLAYER_SPI_POINT",			"INT",		0,		Private,	Postpone},	-- 敏锐加点
	{"PLAYER_DEX_POINT",			"INT",		0,		Private,	Postpone},	-- 身法加点

	{"PLAYER_AT",					"INT",		0,		Public,		Postpone},	-- 物理攻击
	{"PLAYER_MT",					"INT",		0,		Private,	Postpone},	-- 法术攻击
	{"PLAYER_AF",					"INT",		0,		Private,	Postpone},	-- 物理防御
	{"PLAYER_MF",					"INT",		0,		Private,	Postpone},	-- 法术防御

	{"PLAYER_INC_AT",				"INT",		0,		Public,		Postpone},	-- 物理攻击力加成
	{"PLAYER_INC_MT",				"INT",		0,		Private,	Postpone},	-- 法术攻击力加成
	{"PLAYER_INC_AF",				"INT",		0,		Private,	Postpone},	-- 物理防御力加成
	{"PLAYER_INC_MF",				"INT",		0,		Private,	Postpone},	-- 法术防御力加成
	
	{"PLAYER_INC_AT_MT",			"INT",		0,		Private,	Postpone},	-- 全部攻击力加成
	{"PLAYER_INC_AF_MF",			"INT",		0,		Private,	Postpone},	-- 法术防御力加成
	
	{"PLAYER_SPEED",				"INT",		0,		Private,	Postpone},	-- 攻击速度
	{"PLAYER_HIT",					"INT",		0,		Private,	Postpone},	-- 命中
	{"PLAYER_DODGE",				"INT",		0,		Private,	Postpone},	-- 闪避
	{"PLAYER_CRITICAL",				"INT",		0,		Private,	Postpone},	-- 暴击
	{"PLAYER_TENACITY",				"INT",		0,		Private,	Postpone},	-- 抗暴

	{"PLAYER_INC_SPEED",			"INT",		0,		Private,	Postpone},	-- 速度加成
	{"PLAYER_INC_HIT",				"INT",		0,		Private,	Postpone},	-- 命中加成
	{"PLAYER_INC_DODGE",			"INT",		0,		Private,	Postpone},	-- 闪避加成
	{"PLAYER_INC_CRITICAL",			"INT",		0,		Private,	Postpone},	-- 暴击加成
	{"PLAYER_INC_TENACITY",			"INT",		0,		Private,	Postpone},	-- 抗暴加成
	
	{"PLAYER_WIN_PHASE",			"INT",		0,		Private,	Postpone},	-- 风
	{"PLAYER_THU_PHASE",			"INT",		0,		Private,	Postpone},	-- 雷
	{"PLAYER_ICE_PHASE",			"INT",		0,		Private,	Postpone},	-- 冰
	{"PLAYER_SOI_PHASE",			"INT",		0,		Private,	Postpone},	-- 土
	{"PLAYER_FIR_PHASE",			"INT",		0,		Private,	Postpone},	-- 火
	{"PLAYER_POI_PHASE",			"INT",		0,		Private,	Postpone},	-- 毒

	{"PLAYER_PHASE_POINT",			"INT",		0,		Private,	Postpone},	-- 相性点

	{"PLAYER_WIN_PHASE_POINT",		"INT",		0,		Private,	Postpone},	-- 风加点
	{"PLAYER_THU_PHASE_POINT",		"INT",		0,		Private,	Postpone},	-- 雷加点
	{"PLAYER_ICE_PHASE_POINT",		"INT",		0,		Private,	Postpone},	-- 冰加点
	{"PLAYER_SOI_PHASE_POINT",		"INT",		0,		Private,	Postpone},	-- 土加点
	{"PLAYER_FIR_PHASE_POINT",		"INT",		0,		Private,	Postpone},	-- 火加点
	{"PLAYER_POI_PHASE_POINT",		"INT",		0,		Private,	Postpone},	-- 毒加点

	{"PLAYER_INC_PHASE_AT",			"INT",		0,		Private,	Postpone},	-- 相性攻击加成
	{"PLAYER_INC_PHASE_RESIST",		"INT",		0,		Private,	Postpone},	-- 相性防御加成

	{"PLAYER_INC_WIN_AT",			"INT",		0,		Private,	Postpone},	-- 风攻击加成
	{"PLAYER_INC_THU_AT",			"INT",		0,		Private,	Postpone},	-- 雷攻击加成
	{"PLAYER_INC_ICE_AT",			"INT",		0,		Private,	Postpone},	-- 冰攻击加成
	{"PLAYER_INC_FIR_AT",			"INT",		0,		Private,	Postpone},	-- 火攻击加成
	{"PLAYER_INC_SOI_AT",			"INT",		0,		Private,	Postpone},	-- 土攻击加成
	{"PLAYER_INC_POI_AT",			"INT",		0,		Private,	Postpone},	-- 毒攻击加成

	{"PLAYER_INC_WIN_RESIST",		"INT",		0,		Private,	Postpone},	-- 风抗性加成
	{"PLAYER_INC_THU_RESIST",		"INT",		0,		Private,	Postpone},	-- 雷抗性加成
	{"PLAYER_INC_ICE_RESIST",		"INT",		0,		Private,	Postpone},	-- 冰抗性加成
	{"PLAYER_INC_FIR_RESIST",		"INT",		0,		Private,	Postpone},	-- 火抗性加成
	{"PLAYER_INC_SOI_RESIST",		"INT",		0,		Private,	Postpone},	-- 土抗性加成
	{"PLAYER_INC_POI_RESIST",		"INT",		0,		Private,	Postpone},	-- 毒抗性加成

	{"PLAYER_INC_TAUNT_HIT",		"INT",		0,		Private,	Postpone},	-- 嘲讽命中
	{"PLAYER_INC_SOPER_HIT",		"INT",		0,		Private,	Postpone},	-- 催眠命中
	{"PLAYER_INC_CHAOS_HIT",		"INT",		0,		Private,	Postpone},	-- 混乱命中
	{"PLAYER_INC_FREEZE_HIT",		"INT",		0,		Private,	Postpone},	-- 冻结命中
	{"PLAYER_INC_SILENT_HIT",		"INT",		0,		Private,	Postpone},	-- 沉默命中
	{"PLAYER_INC_TOXICOSIS_HIT",	"INT",		0,		Private,	Postpone},	-- 致毒命中

	{"PLAYER_INC_TAUNT_RESIST",		"INT",		0,		Private,	Postpone},	-- 嘲讽抵抗
	{"PLAYER_INC_SOPOR_RESIST",		"INT",		0,		Private,	Postpone},	-- 昏迷抵抗
	{"PLAYER_INC_CHAOS_RESIST",		"INT",		0,		Private,	Postpone},	-- 混乱抵抗
	{"PLAYER_INC_FREEZE_RESIST",	"INT",		0,		Private,	Postpone},	-- 冰冻抵抗
	{"PLAYER_INC_SILENT_RESIST",	"INT",		0,		Private,	Postpone},	-- 沉默抵抗
	{"PLAYER_INC_TOXICOSIS_RESIST",	"INT",		0,		Private,	Postpone},	-- 中毒抵抗

	{"PLAYER_MONEY",				"INT",		0,		Private,	Sync},		-- 银两
	{"PLAYER_SUBMONEY",				"INT",		0,		Private,	Sync},		-- 绑银
	{"PLAYER_DEPOTMONEY",			"INT",		0,		Private,	Sync},		-- 仓库银两
	{"PLAYER_CASHMONEY",			"INT",		0,		Private,	Sync},		-- 礼金
	{"PLAYER_GOLDCOIN",				"INT",		0,		Private,	Sync},		-- 金元宝

	{"PLAYER_STAND_TAO",			"INT",		0,		Private,	Postpone},	-- 标准道行
	{"PLAYER_TAO",					"INT",		0,		Private,	Postpone},	-- 道行
	{"PLAYER_POT",					"INT",		0,		Private,	Postpone},	-- 潜能
	{"PLAYER_EXPOINT",				"INT",		0,		Private,	Postpone},	-- 历练值
	{"PLAYER_VIGOR",				"INT",		0,		Private,	Postpone},	-- 体力值
	{"PLAYER_ANGER",				"INT",		0,		Private,	Postpone},	-- 怒气值
	{"PLAYER_COMBAT",				"INT",		0,		Private,	Postpone},	-- 战绩
	{"PLAYER_KILL",					"INT",		0,		Private,	Postpone},	-- 杀气
	{"PLAYER_MAX_PET",				"INT",		3,		Private,	Postpone},	-- 最大宠物数

	{"PLAYER_MAX_VIGOR",			"INT",		0,		Private,	Postpone},	-- 最大怒气值
	
	{"PLAYER_INC_TAUNT_HIT",		"INT",		0,		Private,	Postpone},	-- 嘲讽命中加成
	{"PLAYER_INC_SOPER_HIT",		"INT",		0,		Private,	Postpone},	-- 催眠命中加成
	{"PLAYER_INC_CHAOS_HIT",		"INT",		0,		Private,	Postpone},	-- 混乱命中加成
	{"PLAYER_INC_FREEZE_HIT",		"INT",		0,		Private,	Postpone},	-- 冻结命中加成
	{"PLAYER_INC_SILENT_HIT",		"INT",		0,		Private,	Postpone},	-- 沉默命中加成
	{"PLAYER_INC_TOXICOSIS_HIT",	"INT",		0,		Private,	Postpone},	-- 下毒命中加成

	{"PLAYER_INC_TAUNT_RESIST",		"INT",		0,		Private,	Postpone},	-- 嘲讽抵抗加成
	{"PLAYER_INC_SOPOR_RESIST",		"INT",		0,		Private,	Postpone},	-- 催眠抵抗加成
	{"PLAYER_INC_CHAOS_RESIST",		"INT",		0,		Private,	Postpone},	-- 嘲讽抵抗加成
	{"PLAYER_INC_FREEZE_RESIST",	"INT",		0,		Private,	Postpone},	-- 冰冻抵抗加成
	{"PLAYER_INC_SILENT_RESIST",	"INT",		0,		Private,	Postpone},	-- 沉默抵抗加成
	{"PLAYER_INC_TOXICOSIS_RESIST",	"INT",		0,		Private,	Postpone},	-- 中毒抵抗加成
	
	{"PLAYER_TIREDNESS",			"INT",		0,		Private,	Postpone},	-- 活力值
	{"PLAYER_PRACTISE",				"INT",		0,		Private,	Postpone},	-- 修行值
	{"PLAYER_PRACTISECOUNT",		"INT",		0,		Private,	Postpone},	-- 修行总值
	{"PLAYER_STOREXP",				"INT",		0,		Private,	Postpone},	-- 存储经验
	{"PLAYER_GOLD_HUNT_MINE",		"SHORT",	1,		Public,		Sync},		-- 在猎金场所得矿量
}

InitPropSet(eClsTypePlayer,PlayerProps)
