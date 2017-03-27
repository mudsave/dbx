-- StringBuilder.lua

local type			= type
local select		= select
local concat		= table.concat
local getmetatable	= getmetatable
local setmetatable	= setmetatable

local sb_mt = {
	__index = false,
	__tostring = false,
	__concat = false,
	nodes = false,
}
sb_mt.__index = sb_mt

function sb_mt:append(...)
	local args_len = select('#',...)
	if self.outcome and args_len>0 then 
		self.outcome = false
	end
	for i=1,args_len do 
		local arg = select(i,...)
		self:push(arg) 
	end
	return self
end

function sb_mt:popend()
	local list = self.list
	list[#list] = nil
end

function sb_mt:length()
	return #(self.list)
end

function sb_mt:clear()
	local list = self.list
	for key,_ in pairs(list) do
		list[key] = nil
	end
	self.outcome = false
end

function sb_mt:setJoiner(joiner)
	if self.joiner ~= joiner then
		self.joiner = joiner
		self.outcome = false
	end
end

function sb_mt:pushTable(tb)
	if not tb then return end
	local list = self.list
	if getmetatable(tb) == sb_mt then
		local his_list = tb.list
		local his_len = #his_list
		if tb.joiner ~= self.joiner then
			list[#list + 1] = tostring(tb)
		else			
			for i = 1,his_len do
				list[#list + 1] = his_list[i]
			end
		end
	else
		local tb_len = #tb
		if tb_len > 0 then
			for i=1,tb_len do self:push(tb[i]) end
		else
			list[#list + 1] = tb
		end
	end
end

function sb_mt:push(value)
	if not value then return end
	local list = self.list
	local vtype = type(value)
	if vtype == 'string' or vtype == 'number' then
		list[#list+1] = value
	elseif vtype == 'table' then
		self:pushTable(value)
	else
		list[#list+1] = value
	end
end

function sb_mt:release()
	if not self.free then
		self.next = sb_mt.nodes
		sb_mt.nodes = self
		self.free = true
	end
end

function sb_mt:__concat(str)
	return self:append(str)
end

function sb_mt:__tostring()
	local outcome = self.outcome
	if not outcome then
		outcome = concat(self.list,self.joiner)
		self.outcome = outcome
	end
	return outcome
end

function StringBuilder(joiner)
	if type(joiner) ~= "string" then
		joiner = ""
	end
	local builder = sb_mt.nodes
	if builder then
		sb_mt.nodes = builder.next
		builder.next = false
		builder.free = false
		builder:clear()
		builder:setJoiner(joiner)
	else
		builder = setmetatable( {
			list = {},
			outcome = false,
			joiner = joiner,
			free = builder,
			next = false,
		},sb_mt)
	end
	return builder
end

return StringBuilder
