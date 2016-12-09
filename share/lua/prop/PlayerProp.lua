--[[PlayerProp.lua
	玩家同步属性定义
]]

-- 格式
-- { propName,dataType,defaultValue,isPublic },
local PlayerProps = {
	{"PLAYER_SEX",					"BYTE",		0,		1},	-- 玩家性别
	{"PLAYER_SCHOOL",				"BYTE",		0,		1},	-- 玩家门派
	{"PLAYER_ACTION_STATE",			"SHORT",	0,		1},	-- 图标
	{"PLAYER_EQUIP_WEAPON",			"STRING",	"",		1},	-- 武器
	{"PLAYER_SEX",					"SHORT",	0,		1},	-- 性别
	{"PLAYER_RIDE_INFO",			"STRING",	"",		1},	-- 坐骑信息
	{"PLAYER_LEVEL",				"INT",		0,		1},	-- 玩家等级
	{"PLAYER_XP",					"INT",		0,		0},	-- 经验
	{"PLATER_NEXT_XP",				"INT",		0,		0},	-- 升级经验

	{"PLAYER_HP",					"INT",		0,		1},	-- 生命
	{"PLAYER_MP",					"INT",		0,		1},	-- 法力
	{"PLAYER_MAX_HP",				"INT",		0,		1},	-- 最大生命
	{"PLAYER_MAX_MP",				"INT",		0,		1},	-- 最大法力

	{"PLAYER_STR",					"INT",		0,		0},	-- 武力
	{"PLAYER_INT",					"INT",		0,		0},	-- 智力
	{"PLAYER_STA",					"INT",		0,		0},	-- 根骨
	{"PLAYER_SPI",					"INT",		0,		0},	-- 敏锐
	{"PLAYER_DEX",					"INT",		0,		0},	-- 身法

	{"PLAYER_ATTR_POINT",			"INT",		0,		0},	-- 玩家属性点

	{"PLAYER_STR_POINT",			"INT",		0,		0},	-- 武力加点
	{"PLAYER_INT_POINT",			"INT",		0,		0},	-- 智力加点
	{"PLAYER_STA_POINT",			"INT",		0,		0},	-- 根骨加点
	{"PLAYER_SPI_POINT",			"INT",		0,		0},	-- 敏锐加点
	{"PLAYER_DEX_POINT",			"INT",		0,		0},	-- 身法加点

	{"PLAYER_AT",					"INT",		0,		1},	-- 物理攻击
	{"PLAYER_MT",					"INT",		0,		0},	-- 法术攻击
	{"PLAYER_AF",					"INT",		0,		0},	-- 物理防御
	{"PLAYER_MF",					"INT",		0,		0},	-- 法术防御

	{"PLAYER_SPEED",				"INT",		0,		0},	-- 攻击速度
	{"PLAYER_HIT",					"INT",		0,		0},	-- 命中
	{"PLAYER_DODGE",				"INT",		0,		0},	-- 闪避
	{"PLAYER_CRITICAL",				"INT",		0,		0},	-- 暴击
	{"PLAYER_TENACITY",				"INT",		0,		0},	-- 抗暴

	{"PLAYER_WIN_PHASE",			"INT",		0,		0},	-- 风
	{"PLAYER_THU_PHASE",			"INT",		0,		0},	-- 雷
	{"PLAYER_ICE_PHASE",			"INT",		0,		0},	-- 冰
	{"PLAYER_SOI_PHASE",			"INT",		0,		0},	-- 土
	{"PLAYER_FIR_PHASE",			"INT",		0,		0},	-- 火
	{"PLAYER_POI_PHASE",			"INT",		0,		0},	-- 毒

	{"PLAYER_PHASE_POINT",			"INT",		0,		0},	-- 相性点

	{"PLAYER_WIN_PHASE_POINT",		"INT",		0,		0},	-- 风加点
	{"PLAYER_THU_PHASE_POINT",		"INT",		0,		0},	-- 雷加点
	{"PLAYER_ICE_PHASE_POINT",		"INT",		0,		0},	-- 冰加点
	{"PLAYER_SOI_PHASE_POINT",		"INT",		0,		0},	-- 土加点
	{"PLAYER_FIR_PHASE_POINT",		"INT",		0,		0},	-- 火加点
	{"PLAYER_POI_PHASE_POINT",		"INT",		0,		0},	-- 毒加点

	{"PLAYER_WIN_AT",				"INT",		0,		0},	-- 风攻
	{"PLAYER_THU_AT",				"INT",		0,		0},	-- 雷攻
	{"PLAYER_ICE_AT",				"INT",		0,		0},	-- 冰攻
	{"PLAYER_SOI_AT",				"INT",		0,		0},	-- 土攻
	{"PLAYER_FIR_AT",				"INT",		0,		0},	-- 火攻
	{"PLAYER_POI_AT",				"INT",		0,		0},	-- 毒攻

	{"PLAYER_WIN_RESIST",			"INT",		0,		0},	-- 风抗
	{"PLAYER_THU_RESIST",			"INT",		0,		0},	-- 雷抗
	{"PLAYER_ICE_RESIST",			"INT",		0,		0},	-- 冰抗
	{"PLAYER_SOI_RESIST",			"INT",		0,		0},	-- 土抗
	{"PLAYER_FIR_RESIST",			"INT",		0,		0},	-- 火抗
	{"PLAYER_POI_RESIST",			"INT",		0,		0},	-- 毒抗

	{"PLAYER_MONEY",				"INT",		0,		0},	-- 银两
	{"PLAYER_SUBMONEY",				"INT",		0,		0},	-- 绑银
	{"PLAYER_DEPOTMONEY",			"INT",		0,		0},	-- 仓库银两
	{"PLAYER_CASHMONEY",			"INT",		0,		0},	-- 礼金
	{"PLAYER_GOLDCOIN",				"INT",		0,		0},	-- 金元宝

	{"PLAYER_STAND_TAO",			"INT",		0,		0},	-- 标准道行
	{"PLAYER_TAO",					"INT",		0,		0},	-- 道行
	{"PLAYER_POT",					"INT",		0,		0},	-- 潜能
	{"PLAYER_EXPOINT",				"INT",		0,		0},	-- 历练值
	{"PLAYER_VIGOR",				"INT",		0,		0},	-- 体力值
	{"PLAYER_ANGER",				"INT",		0,		0},	-- 怒气值
	{"PLAYER_COMBAT",				"INT",		0,		0},	-- 战绩
	{"PLAYER_KILL",					"INT",		0,		0},	-- 杀气
	{"PLAYER_MAX_PET",				"INT",		3,		0},	-- 最大宠物数

	{"PLAYER_INC_TAUNT_HIT",		"INT",		0,		0},	-- 嘲讽命中加成
	{"PLAYER_INC_SOPER_HIT",		"INT",		0,		0},	-- 催眠命中加成
	{"PLAYER_INC_CHAOS_HIT",		"INT",		0,		0},	-- 混乱命中加成
	{"PLAYER_INC_FREEZE_HIT",		"INT",		0,		0},	-- 冻结命中加成
	{"PLAYER_INC_SILENT_HIT",		"INT",		0,		0},	-- 沉默命中加成
	{"PLAYER_INC_TOXICOSIS_HIT",	"INT",		0,		0},	-- 下毒命中加成

	{"PLAYER_INC_TAUNT_RESIST",		"INT",		0,		0},	-- 嘲讽抵抗加成
	{"PLAYER_INC_SOPER_RESIST",		"INT",		0,		0},	-- 催眠抵抗加成
	{"PLAYER_INC_CHAOS_RESIST",		"INT",		0,		0},	-- 嘲讽抵抗加成
	{"PLAYER_INC_FREEZE_RESIST",	"INT",		0,		0},	-- 冰冻抵抗加成
	{"PLAYER_INC_SILENT_RESIST",	"INT",		0,		0},	-- 沉默抵抗加成
	{"PLAYER_INC_TOXICOSIS_RESIST",	"INT",		0,		0},	-- 中毒抵抗加成
}

InitPropSet(eClsTypePlayer,PlayerProps)
