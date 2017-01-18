--[[
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
]]

local __index = getmetatable(_G).__index

function StartGlobalRefCheck()
    getmetatable(_G).__index = function(t,key)
        local value = __index(t,key)
        if value == nil then
            print("全局域中没有",key)
        end
        return value
    end
end

function StopGlobalRefCheck()
    getmetatable(_G).__index = __index
end
