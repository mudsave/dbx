--[[GlobalRefCheck.lua
	全局变量引用检查
	引用一个为nil的全局量时,会给出警告

	demo:

	StartGlobalRefCheck()
	local t = {
		eLogicPet,eLogicGod,
	}
	StopGlobalRefCheck()

	其中eLogicGod没有定义,则在引用这个量时,会给出提示

	对于作为状态用的全局量,为空则强烈建议使用false代替nil,原因有:
	1,false 和 nil 作逻辑判断上是等价的,if false 和 if nil 或者 not false 和 not nil 是一样的
	2,nil会导致键值对的删除,造成再哈希,false则不会

	现在提供了一个查询函数用以获取对全局变量失败的引用
	PrintLostRef:
		不带参数时候,返回所有的失败引用名称
		带一个字符串参数时候,打印这个引用名称失败时候所处的运行环境
]]

local gmt = getmetatable(_G)

local LostGlobalRefH = {}
local LostGloablRefA = {}
local function Warnning(key)
	if not LostGlobalRefH[key] then
		LostGloablRefA[#LostGloablRefA + 1] = key
		local info = debug.getinfo(3)
		LostGlobalRefH[key] = ("引用了一个不存在的全局变量 %s: %s line %d"):format(tostring(key),info.short_src,info.currentline)
		return true
	end
	return false
end

function PrintLostRef(refName)
	if not refName then
		print(("[\"%s\"]"):format(table.concat(LostGloablRefA,"\",\"")))
		return LostGlobalRefH
	else
		print(LostGlobalRefH[refName])
	end
end

if not gmt then
	gmt = {
		__index = function(self,key)
			Warnning(key)
		end,
		__newindex = function(self,key,value)
			Wanning(key)
			rawset(self,key,value)
		end
	}
	function StartGlobalRefCheck()
		setmetatable(_G,gmt)
	end

	function StopGlobalRefCheck()
		setmetatable(_G,nil)
	end
else
	local index = gmt.__index
	local function __index(self,key)
		local value = index(self,key)
		if nil == value then
			Warnning(key)
		end
		return value
	end

	function StartGlobalRefCheck()
		gmt.__index = __index
	end

	function StopGlobalRefCheck()
		gmt.__index = index
	end
end
