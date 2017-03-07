-- common.constant.lua

SchoolType = {
	PM      = 0x00,
	QYD     = 0x01,		-- 乾元???
	JXS     = 0x02,		-- 金霞???
	ZYM     = 0x03,		-- 紫阳???
	YXG     = 0x04,		-- 云霄???
	TYD     = 0x05,		-- 桃源???
	PLG     = 0x06,		-- 蓬莱???
}

--玩家性别的类???
PlayerSexType = {
	Females         = 0x00, --女???
	Males           = 0x01, --男???
}

--------------------------------------------------------------------------------
--奖励类型
RewardSelectType = {
	All				=  1, --自动全部选择
	System			=  2, --系统随机等概率选
	Player			=  3, --玩家先选，选择无效则系统帮着选（等概率）
	SysOdds			=  4, --系统随机根据odds为权重来选
	Team			=  5,--队员奖励
}

PhaseType =
{
	Wind    = 1, -- ???
	Thunder = 2, -- ???
	Ice     = 3, -- ???
	Fire    = 4, -- ???
	Soil    = 5, -- ???
	Poison  = 6, -- ???
	None    = 7, -- ???
}

-- 怪物属性加持类???
MonAttrAddType =
{
	Value = 0, -- 加???
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
