--[[UnitProp.lua
	实体公用同步属性定义
]]

UNIT_NAME		= UNIT_BASE + 0
UNIT_MODEL		= UNIT_BASE + 1
UNIT_SHOWPARTS	= UNIT_BASE + 2

local Properties = {}

local function DefineProperty(...)
	Properties[#Properties + 1] = arg
end

DefineProperty(UNIT_NAME,		"STRING",	"noname",	1,	1)	--实体名称
DefineProperty(UNIT_MODEL,		"SHORT",	11,			1,	1)	--实体模型
DefineProperty(UNIT_SHOWPARTS,	"STRING",	"{1,1}",	1,	1)	--显示细节

-- 初始化一个属性集合
function InitPropSet(cls,propConfig)
	local unitConfig = CUnitConfig:Instance()
	
	unitConfig:initPropSet(cls)			--添加C++中使用属性

	for _,conf in ipairs(Properties) do	--添加lua中共有属性
		local propId,type,def,pub,sync = unpack(conf)
		local id = unitConfig:addProperty(cls,type,def,pub,sync)
		if propId ~= id then
			print("error:duplicated property initialization!")
			return false
		end
	end

	for _,conf in ipairs(propConfig) do
		local propName,type,def,pub,sync = unpack(conf)
		local propId = unitConfig:addProperty(cls,type,def,pub,sync)
		_G[propName] = propId
	end
end
