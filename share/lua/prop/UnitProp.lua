--[[UnitProp.lua
	实体公用同步属性定义
]]

UNIT_NAME		= UNIT_BASE + 0
UNIT_MODEL		= UNIT_BASE + 1
UNIT_SHOWPARTS	= UNIT_BASE + 2

local Properties = {
	{ UNIT_NAME,		"STRING",	"noname",	Public,	Sync,"UNIT_NAME"},		-- 实体名称
	{ UNIT_MODEL,		"SHORT",	11,			Public,	Sync,"UNIT_MODEL"},		-- 实体模型
	{ UNIT_SHOWPARTS,	"STRING",	"{1,1}",	Public,	Sync,"UNIT_SHOWPARTS"},	-- 实体纹理
}

local PropertyError = {
	[-1] = "invalid property set!",
	[-2] = "unrecognized data type!",
}

local function GetID(newID,desireID)
	if newID < 0 then
		error(PropertyError[newID])
	end
	if desireID and newID ~= desireID then
		error("duplicated property initialization!")
	end
	return newID
end

-- 初始化一个属性集合
function InitPropSet(cls,propConfig)
	local unitConfig = CUnitConfig:Instance()
	
	for _,conf in ipairs(Properties) do	--添加lua中共有属性
		local propID,szType,szDefault,bPub,bSync,szName = unpack(conf)
		local id = unitConfig:addProperty(cls,szType,szDefault,bPub,bSync,szName)
		GetID(id,propID)
	end

	if propConfig then
		for _,conf in ipairs(propConfig) do
			local propName,szType,szDefault,bPub,bSync = unpack(conf)
			local id = unitConfig:addProperty(cls,szType,szDefault,bPub,bSync,propName)
			_G[propName] = GetID(id)
		end
	end
end
