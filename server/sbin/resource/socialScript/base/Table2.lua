--Table2.lua

local StringBuilder=require "base.StringBuilder"

Table2=class()

local builder=StringBuilder()
local tostring=tostring
local gstrsub=string.gsub
local wrapTable=nil

function Table2.String2Table(tbstr)
	if type(tbstr)~="string" then return nil end
	local call=loadstring("return "..tbstr)
	if call then
		local success,ret=pcall(call)
		return (success and ret or nil)
	end
	return nil
end

function Table2.Table2String(tb)
	builder:clear()
	wrapTable(tb)
	return tostring(builder)
end

local function appendValue(value)
	local vtype=type(value)
	if vtype=='number' then builder:append(value)
	elseif vtype=='string' then builder:append('"',gstrsub(value,'"','\\"'),'"')
	elseif vtype=='boolean' then builder:append(value and 'true' or 'false')
	elseif vtype=='table' then wrapTable(value)
	else builder:append('"',tostring(value),'"')
	end
end

wrapTable=function(tb)
	if type(tb)~="table" then
		builder:append(tostring(tb))
		return
	end

	builder:append('{')
	local prev_len=builder:length()
	local t_array_len = #tb
	for _,value in ipairs(tb) do
		appendValue(value)
		builder:append(',')
	end

	for key,value in pairs(tb) do
		local ktype=type(key)

		if ktype == "number" then
			if key > t_array_len then
				builder:append('[',key,']=')
				appendValue(value)
				builder:append(',')
			end
		elseif ktype=="string" then
			builder:append(key,"=")
			appendValue(value)
			builder:append(',')
		else
			builder:append('["',tostring(key),'"]=')
			appendValue(value)
			builder:append(',')
		end

	end
	if builder:length()>prev_len then builder:popend() end
	builder:append('}')
end

return Table2
