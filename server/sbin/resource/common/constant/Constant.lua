-- common.constant.lua

SchoolType = {
	PM      = 0x00,
	QYD     = 0x01,		-- 乾元岛
	JXS     = 0x02,		-- 金霞山
	ZYM     = 0x03,		-- 紫阳门
	YXG     = 0x04,		-- 云霄宫
	TYD     = 0x05,		-- 桃源洞
	PLG     = 0x06,		-- 蓬莱阁
}

--玩家性别的类型
PlayerSexType = {
	Females         = 0x00, --女性
	Males           = 0x01, --男性
}

PhaseType =
{
	Wind    = 1, -- 风
	Thunder = 2, -- 雷
	Ice     = 3, -- 冰
	Fire    = 4, -- 火
	Soil    = 5, -- 土
	Poison  = 6, -- 毒
	None    = 7, -- 无
}

-- 怪物属性加持类型
MonAttrAddType =
{
	Value = 0, -- 加值
	Coffi = 1, -- 加成
}

require "constant.FightConstant"
require "constant.BuffConstant"
require "constant.DialogConstant"
require "constant.EctypeConstant"
require "constant.ItemConstant"
require "constant.PetConstant"
require "constant.SkillConstant"
require "constant.TaskConstant"
require "constant.TreasureConstant"
require "constant.ExpConstant"
require "constant.ItemChangeAttrDef"
