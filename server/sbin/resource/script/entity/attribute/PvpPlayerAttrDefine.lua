-- PvpPlayerAttrDefine.lua
-- Boss属性定义

PvpPlayerAttrDefine = {}

-- defineAttr(属性值, 属性名, 属性描述, 是否有公式, 能否需持久化)
local function defineAttr(name, desc, bExpr, bSave)
	local base = #PvpPlayerAttrDefine + 1
	PvpPlayerAttrDefine[base] = {
		name	= name,
		expr	= bExpr,
		db		= bSave,
	}
	_G[name] = base
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------
defineAttr("pvp_in_str", "先天武力", true)
defineAttr("pvp_in_int", "先天智力", true)
defineAttr("pvp_in_sta", "先天根骨", true)
defineAttr("pvp_in_spi", "先天灵性", true)
defineAttr("pvp_in_dex", "先天身法", true)
defineAttr("pvp_hp", "生命", true)
defineAttr("pvp_max_hp", "生命上限", true)