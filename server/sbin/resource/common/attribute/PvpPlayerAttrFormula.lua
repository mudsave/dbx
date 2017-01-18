--[[PvpPlayerAttrFormula.lua
描述：
	伪pvp属性公式
]]

require "misc.constant"

PvpPlayerAttrFormula = {}

-----------------------------------------------------------------------
--策划配置
-----------------------------------------------------------------------
--生命上限
function PvpPlayerAttrFormula.pvp_player_max_hp(monster)
	return 1000
end

--怪物公式对照表
g_AttributePvpPlayerFormat =
{
	[pvp_max_hp]						= PvpPlayerAttrFormula.pvp_player_max_hp,
}

--属性影响关系
g_AttrPvpPlayerInfluenceTable =
{
	[pvp_hp]							= {pvp_max_hp},
}

-----------------------------------------------------------------------
--程序配置
-----------------------------------------------------------------------
--属性对应的属性同步
g_AttrPvpPlayerToProp =
{
}

--需要立即更新的属性
g_AttrPvpPlayerSyncTable =
{
}