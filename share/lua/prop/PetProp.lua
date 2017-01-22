--[[PetProp.lua
	宠物同步属性定义
]]

-- 格式
-- { propName,dataType,defaultValue,isPublic },
local PetProps = {
	{"PET_LEVEL",					"SHORT",		0,		1},	-- 宠物等级
	{"PET_XP",						"INT",			0,		0},	-- 当前经验
	{"PET_NEXT_XP",					"INT",			0,		0},	-- 升级经验

	{"PET_HP",						"INT",			0,		1},	-- 宠物血量
	{"PET_MP",						"INT",			0,		1},	-- 宠物蓝量
	{"PET_MAX_HP",					"INT",			0,		1},	-- 最大血量
	{"PET_MAX_MP",					"INT",			0,		1},	-- 最大蓝量

	{"PET_STR",						"SHORT",		0,		0},	-- 宠物武力
	{"PET_INT",						"SHORT",		0,		0},	-- 宠物智力
	{"PET_STA",						"SHORT",		0,		0},	-- 宠物根骨
	{"PET_SPI",						"SHORT",		0,		0},	-- 宠物敏锐
	{"PET_DEX",						"SHORT",		0,		0},	-- 宠物身法

	{"PET_STR_POINT",				"SHORT",		0,		0},	-- 武力加点
	{"PET_INT_POINT",				"SHORT",		0,		0},	-- 智力加点
	{"PET_STA_POINT",				"SHORT",		0,		0},	-- 根骨加点
	{"PET_SPI_POINT",				"SHORT",		0,		0},	-- 敏锐加点
	{"PET_DEX_POINT",				"SHORT",		0,		0},	-- 身法加点

	{"PET_ATTR_POINT",				"SHORT",		0,		0},	-- 属性点数
	{"PET_PHASE_POINT",				"SHORT",		0,		0},	-- 相性点数

	{"PET_WIN_AT",					"SHORT",		0,		0},	-- 风攻击
	{"PET_THU_AT",					"SHORT",		0,		0},	-- 雷攻击
	{"PET_ICE_AT",					"SHORT",		0,		0},	-- 冰攻击
	{"PET_SOI_AT",					"SHORT",		0,		0},	-- 土攻击
	{"PET_FIR_AT",					"SHORT",		0,		0},	-- 火攻击
	{"PET_POI_AT",					"SHORT",		0,		0},	-- 毒攻击

	{"PET_WIN_RESIST",				"SHORT",		0,		0},	-- 风抗性
	{"PET_THU_RESIST",				"SHORT",		0,		0},	-- 雷抗性
	{"PET_ICE_RESIST",				"SHORT",		0,		0},	-- 冰抗性
	{"PET_SOI_RESIST",				"SHORT",		0,		0},	-- 土抗性
	{"PET_FIR_RESIST",				"SHORT",		0,		0},	-- 火抗性
	{"PET_POI_RESIST",				"SHORT",		0,		0},	-- 毒抗性

	{"PET_FIR_PHASE_POINT",			"SHORT",		0,		0},	-- 风加点
	{"PET_SOI_PHASE_POINT",			"SHORT",		0,		0},	-- 雷加点
	{"PET_WIN_PHASE_POINT",			"SHORT",		0,		0},	-- 冰加点
	{"PET_POI_PHASE_POINT",			"SHORT",		0,		0},	-- 土加点
	{"PET_ICE_PHASE_POINT",			"SHORT",		0,		0},	-- 火加点
	{"PET_THU_PHASE_POINT",			"SHORT",		0,		0},	-- 毒加点

	{"PET_AT",						"INT",			0,		0},	-- 物理攻击
	{"PET_MT",						"INT",			0,		0},	-- 法术攻击
	{"PET_AF",						"INT",			0,		0},	-- 物理防御
	{"PET_MF",						"INT",			0,		0},	-- 法术防御

	{"PET_HIT",						"SHORT",		0,		0},	-- 命中
	{"PET_DODGE",					"SHORT",		0,		0},	-- 闪避
	{"PET_CRITICAL",				"SHORT",		0,		0},	-- 暴击
	{"PET_TENACITY",				"SHORT",		0,		0},	-- 抗暴
	{"PET_SPEED",					"SHORT",		0,		0},	-- 速度

	{"PET_CAPACITY",				"SHORT",		0,		0},	-- 资质
	{"PET_AT_GROW",					"SHORT",		0,		0},	-- 物攻成长
	{"PET_AF_GROW",					"SHORT",		0,		0},	-- 物防成长
	{"PET_MT_GROW",					"SHORT",		0,		0},	-- 法攻成长
	{"PET_MF_GROW",					"SHORT",		0,		0},	-- 法防成长
	{"PET_HP_GROW",					"SHORT",		0,		0},	-- 血量成长
	{"PET_AT_SPEED_GROW",			"SHORT",		0,		0},	-- 速度成长

	{"PET_CAPACITY_MAX",			"SHORT",		0,		0},	-- 最大资质
	{"PET_AT_GROW_MAX",				"SHORT",		0,		0},	-- 最大物攻成长
	{"PET_AF_GROW_MAX",				"SHORT",		0,		0},	-- 最大物防成长
	{"PET_MT_GROW_MAX",				"SHORT",		0,		0},	-- 最大法攻成长
	{"PET_MF_GROW_MAX",				"SHORT",		0,		0},	-- 最大法防成长
	{"PET_HP_GROW_MAX",				"SHORT",		0,		0},	-- 最大血量成长
	{"PET_AT_SPEED_GROW_MAX",		"SHORT",		0,		0},	-- 最大速度成长
	
	{"PET_LIFE",					"SHORT",		0,		0},	-- 宠物寿命
	{"PET_LIFE_MAX",				"SHORT",		0,		0},	-- 最大寿命

	{"PET_TAO",						"SHORT",		0,		0},	-- 宠物道行
	{"PET_STAND_TAO",				"SHORT",		0,		0},	-- 标准道行

	{"PET_OBSTACLE_HIT",			"SHORT",		0,		0},	-- 障碍命中

	{"PET_TAUNT_RESIST",			"SHORT",		0,		0},	-- 嘲讽抗性
	{"PET_SOPOR_RESIST",			"SHORT",		0,		0},	-- 催眠抗性
	{"PET_CHAOS_RESIST",			"SHORT",		0,		0},	-- 混乱抗性
	{"PET_FREEZE_RESIST",			"SHORT",		0,		0},	-- 冰冻抗性
	{"PET_SILENT_RESIST",			"SHORT",		0,		0},	-- 沉默抗性
	{"PET_TOXICOSIS_RESIST",		"SHORT",		0,		0},	-- 中毒抗性

	{"PET_CHAOS_PHASE_POINT",		"SHORT",		0,		0},	-- 混乱加点
	{"PET_SOPOR_PHASE_POINT",		"SHORT",		0,		0},	-- 催眠加点
	{"PET_TAUNT_PHASE_POINT",		"SHORT",		0,		0},	-- 嘲讽加点
	{"PET_FREEZE_PHASE_POINT",		"SHORT",		0,		0},	-- 冰冻加点
	{"PET_SILENT_PHASE_POINT",		"SHORT",		0,		0},	-- 沉默加点
	{"PET_TOXICOSIS_PHASE_POINT",	"SHORT",		0,		0},	-- 中毒加点

	{"PET_INC_AT",					"SHORT",		0,		0},	-- 物攻加成
	{"PET_INC_AF",					"SHORT",		0,		0},	-- 物防加成
	{"PET_INC_MT",					"SHORT",		0,		0},	-- 魔攻加成
	{"PET_INC_MF",					"SHORT",		0,		0},	-- 魔抗加成
	{"PET_INC_MAX_HP",				"SHORT",		0,		0},	-- 血量加成
	{"PET_INC_MAX_MP",				"SHORT",		0,		0},	-- 蓝量加成
	{"PET_INC_CRITICAL",			"SHORT",		0,		0},	-- 暴击加成
	{"PET_INC_TENACITY",			"SHORT",		0,		0},	-- 抗暴加成
	{"PET_INC_SPEED",				"SHORT",		0,		0},	-- 速度加成
	{"PET_INC_HIT",					"SHORT",		0,		0},	-- 命中加成
	{"PET_INC_DODGE",				"SHORT",		0,		0},	-- 闪避加成

	{"PET_ATTACK_TYPE",				"SHORT",		0,		1},	-- 攻击类型
	{"PET_PHASE_TYPE",				"SHORT",		0,		1},	-- 相性类型
	{"PET_TYPE",					"SHORT",		0,		1}, -- 宠物类型
	{"PET_CONFIGID",				"SHORT",		0,		1},	-- 配置ID
	{"PET_LOYALTY",					"INT",			0,		0},	-- 宠物忠诚
	{"PET_UPLEVEL",					"SHORT",		0,		1},	-- 强化等级
	{"PET_UPCOMP",					"INT",			0,		0}, -- 强化完成度
	{"PET_SKILL_MAX",				"INT",			0,		0},	-- 最大技能
	{"PET_STATUS",					"BYTE",			0,		1},	-- 宠物状态
	{"PET_TAKE_LEVEL",				"BYTE",			0,		0},	-- 出战等级
}

InitPropSet(eClsTypePet,PetProps)
