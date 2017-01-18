--[[用于数组相减的函数
]]
--返回一个匹配函数，用以查询某个元素是否在数组中
local function ContainMatcher(set)
	return function(value)
		for index,v in ipairs(set) do
			if value==v then return true
			end
		end
		return false
	end
end

--返回一个匹配函数，用以查询某个元素是否在数组中，对同一个值的二次查询不会命中
local function OnceContainMatcher(set)
	return function(value)
		local length=#set
		for index,v in ipairs(set) do
			if value==v then
				set[index]=set[length]
				set[length]=nil
				return true
			end
		end
		return false
	end
end

--返回一个匹配函数，用以查询某个元素是否在数组中，
local function SaveContainMatcher(set)
	local copy={}
	for k,v in ipairs(set) do
		copy[k]=v
	end
	return OnceContainMatcher(copy)
end

--返回一个匹配函数，
local function TwiceMatcher()
	local set = {}
	return function(value)
		if set[value] then
			return true
		else
			set[value] = true
			return false
		end
	end
end

--删除数组中的元素
local function Remove(list,can_remove,...)
	if type(can_remove) ~= "function" then
		error(("#2 excepted a function,got %s"):format(type(can_remove)))
	end
	local base=1
	local prev_len=#list
	for i=1,prev_len do
		if not can_remove(list[i],...) then
			if base~= i then
				list[base]=list[i]
				list[i]=nil
			end
			base=base+1
		else
			list[i]=nil
		end
	end
	return list,base-1
end

local function Subtract(list,set,comparator)
	return Remove(list,(comparator or ContainMatcher)(set))
end

local function Trim(list)
	return Remove(list,TwiceMatcher())
end

local temp = {}
local function clear(t)
	for k,_ in pairs(t) do
		t[k] = nil
	end
	return t
end

--合并数组
local function Combine(a,b)
	local temp = clear(temp)
	for _,value in ipairs(a) do
		temp[value] = true
	end
	for _,value in ipairs(b) do
		temp[value] = true
	end
	local ret = {}
	for value,_ in pairs(temp) do
		ret[#ret + 1] = value
	end
	return ret
end

local _Array = {
	remove = Remove,
	subtract = Subtract,
	combine = Combine,
	trim = Trim,
	ContainMatcher = ContainMatcher,
	OnceContainMatcher = OnceContainMatcher,
	SaveContainMatcher = SaveContainMatcher
}

Array = _Array

return _Array