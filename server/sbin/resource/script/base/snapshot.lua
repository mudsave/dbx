if not debug then error("debug not enabled!") end

require "base.StringBuilder"

local setmetatable = setmetatable
local getmetatable = getmetatable
local tostring = tostring
local rawget = rawget
local type = type

local max_level = 4
local max_items = 5
function table_tostring(t,builder,level)
	local count = 0
	builder:append("{ ")
	for key,value in pairs(t) do
		local tk = type(key)
		if tk == "string" then
			builder:append(key)
		elseif tk == "number" then
			builder:append("[",key,"]")
		elseif tk == "boolean" then
			builder:append("[",key and "true" or "false","]")
		elseif tk == "table" then
			if level < max_level then
				builder:append(table_tostring(key,StringBuilder(),level+1))
			else
				builder:append "{...}"
			end
		else
			builder:append(tk)
		end
		builder:append " = "

		local tv = type(value)
		if tv == "table" then
			if level < max_level then
				builder:append(table_tostring(value,StringBuilder(),level+1))
			else
				builder:append "{...}"
			end
		elseif tv == "string" then
			builder:append('"',value,'"')
		elseif tv == "number" then
			builder:append(value)
		elseif tv == "boolean" then
			builder:append(value and "true" or "false")
		else
			builder:append(tv)
		end

		builder:append(",")
		count = count + 1
		if count > max_items then break end
	end
	if count > 0 then
		builder:popend()
	end
	builder:append " }"
	local str = tostring(builder)
	builder:release()
	return str
end

-- clazz.lua
-- 根据某个模式创建一个新表
local weak_mt	= { __mode = "kv" }
local weakk_mt	= { __mode = "k" }
local weakv_mt	= { __mode = "v" }
local function newtable(mode,t)
	if not t then t = {} end
	if type(mode) == "string" then
		local k,v = mode:find("k"),mode:find("v")
		if k and v then
			setmetatable(t,weak_mt)
		elseif k then
			setmetatable(t,weakk_mt)
		elseif v then
			setmetatable(t,weakv_mt)
		end
	end
	return t
end

-- 创建一个新类
local function clazz(t)
	if not t then
		t = { __index = false }
	end
	t.__index = t
	return t
end

-- stack.lua
-- 用于遍历gc对象网的栈
local stack_mt = clazz()

function stack_mt:push(t,what)
	local _hash = self._hash
	if not t or _hash[t] then
		return false
	end
	local index = self._len + 1
	self._array[index] = what
	self._len = index
	_hash[t] = true
	return true
end

function stack_mt:pop(t)
	local _hash = self._hash
	if _hash[t] then
		local index = self._len
		self._array[index] = nil
		self._len = index - 1
		_hash[t] = nil
	end
end

function stack_mt:reverse()
	local _array = self._array
	local t = newtable()
	for index = self._len,1,-1 do
		t[#t + 1] = _array[index]
	end
	return t
end

function stack_mt:__tostring()
	return ("[%s] len=%d"):format(table.concat(self._array,","),self._len)
end

local function stack()
	return setmetatable({
		_len = 0,
		_hash = newtable("v"),
		_array = newtable(),
	},stack_mt)
end

local result_mt = clazz()

function result_mt:__tostring()
	return table.concat(self)
end

local function result(r)
	return setmetatable(r or {},result_mt)
end

-- search.lua
local search_mt = clazz()

function search_mt:results()
	self:traverse(stack(),self._start)
	table.sort(self._flows,function(a,b) return #a > #b end)
	return self._flows
end

function search_mt:result()
	self:traverse(stack(),self._start)
	return self._flows[1]
end

function search_mt:traverse(stk,nd,what)
	if not self._done and stk:push(nd,what) then
		repeat
			if self._meet(nd) then
				self:add_flow(stk:reverse())
				self._done = true
				break
			end
			local relation = self._connections[nd]
			if not relation then	
				break
			end
			for nnd,what in pairs(relation) do
				self:traverse(stk,nnd,what)
			end
		until true
		stk:pop(nd)
	end
end

function search_mt:add_flow(flow)
	local _flows = self._flows
	_flows[#_flows + 1] = result(flow)
end

local function search(connections,meet,start)
	if type(meet) ~= "function" then
		error("search #2 exception a function!")
	end
	return setmetatable({
		_connections = connections,
		_meet = meet,
		_start = start,
		_flows = {},
		_done = false,
	},search_mt)
end

-- report.lua
local report_mt = clazz()

function report_mt:add_record(gco)
	local index = self._count + 1
	self._array[index] = gco
	self._count = index
end

function report_mt:get_count()
	return self._count
end

function report_mt:get_detail(index)
	local gco = self._array[index]
	local t = type(gco)
	if t == "function" then
		return "function:"..self.sources[gco]
	elseif type(gco) == "table" then
		return table_tostring(gco,StringBuilder(),1) 
	else
		return tostring(gco)
	end
end

local _G = _G
local _R = debug.getregistry()
local function meet( o )
	return o == _G or o == _R
end

function report_mt:get_trace(index)
	local gco = self._array[index]
	if gco then
		return search(
			self.connections,meet,gco
		):result()
	end
end

function report_mt:get_traces(index)
	local gco = self._array[index]
	if gco then
		return search(
			self.connections,meet,gco
		):results()
	end
end

function report_mt:set_compare(elder,newer)
	self._elder = elder
	self._newer = newer
end

function report_mt:__tostring()
	return ("%s->%s:%d"):format(self._elder,self._newer,self._count)
end

local function report(connections,sources)
	return setmetatable({
		connections = connections,
		sources = sources,
		_elder = false,
		_newer = false,
		_array = newtable("v"),
		_count = 0,
	},report_mt)
end

-- snapshpt.lua
-- convert time slot to custom format
local function time2string(slot)
	local t = os.date("*t",slot)
	return ("%d:%d:%d"):format(
		t.hour,t.min,t.sec
	)
end

local snapshot_mt = clazz()

function snapshot_mt:diff(ss)
	if getmetatable(ss) ~= snapshot_mt or ss == self then
		print("snapshot:diff(ss) except another snapshot!")
		return false
	end

	local newer,elder
	if ss._slot < self._slot then
		newer,elder = self,ss
	else
		newer,elder = ss,self
	end

	local rp = report(newer.connections,newer.sources)

	local new = newtable("k")
	local marked = elder.marked
	for gco,_ in pairs(newer.marked) do
		if marked[gco] == nil then
			new[gco] = true
		end
	end
	
	local connections = newer.connections
	for gco,_ in pairs(new) do
		for key,what in pairs(connections[gco]) do
			if not new[key] then
				rp:add_record(gco)
				break
			end
		end
	end
	return rp
end

function snapshot_mt:__tostring()
	return ("[%s %s]"):format(
		time2string(self._when),self._detail
	)
end

local function checkmetatable(t)
	local t_mt = getmetatable(t)
	if t_mt then
		local weakk,weakv = false,false
		local mode = rawget(t_mt,"__mode")
		if mode then
			if mode:find("k") then
				weakk = true
			end
			if mode:find("v") then
				weakv = true
			end
		end
		return t_mt,weakk,weakv
	end
	return nil,false,false
end

local function isgco(o)
	local t = type(o)
	if t == "function" then
		return true
	end
	if t == "table" then
		return true
	end
	if t == "userdata" then
		return true
	end
	if t == "thread" then
		-- current not support thread
		return false
	end
	return false
end

local function keystring(key)
	local t = type(key)
	if t == "string" then
		return ("[\"%s\"]"):format(key)
	end
	if t == "number" then
		return ("[%s]"):format(tostring(key))
	end
	return ("[%s]"):format(tostring(key) or "")
end

function snapshot()
	local marked = newtable("k")
	local connections = newtable("k")
	local sources = newtable("k")

	-- make a mark
	local function ismarked(me,parent,desc)
		if not marked[me] then
			marked[me] = true
			connections[me] = newtable( "k",{ [parent] = desc } )
			return false
		end
		connections[me][parent] = desc
		return true
	end
	
	-- mark an object
	local markobject
	
	-- mark a table
	local function marktable(me,parent,desc)
		-- print("lets mark a table named",desc)
		if ismarked(me,parent,desc) then
			-- print("marked...")
			return
		end
	
		local mt,weakk,weakv = checkmetatable(me)
		if mt then
			-- print("got metatable")
			if mt == snapshot_mt then
				return
			end
			marktable(mt,me,"[metatable]")
		end

		if mt == snapshot_mt then
			return
		end
	
		for key,value in pairs(me) do
			if not weakk and isgco(key) then
				-- print("key",key)
				markobject(key,me,"[key]")
			end
			if not weakv and isgco(value) then
				-- print("value",key)
				markobject(value,me,keystring(key))
			end
		end
	end
	
	-- mark a function
	local function markfunction(me,parent,desc)
		if ismarked(me,parent,desc) then
			return
		end

		local env = getfenv(me)
		if env then
			marktable(env,me,"[environment]")
		end
		local uname,uvalue = debug.getupvalue(me,1)
		local index = 2
		while uname do
			if isgco(uvalue) then
				markobject(uvalue,me,("[upvalue:\"%s\"]"):format(uname))
			end
			uname,uvalue = debug.getupvalue(me,index)
			index = index + 1
		end
	
		local info = debug.getinfo(me)
		sources[me] = ("%s:%d"):format(info.short_src,info.linedefined)
	end
	
	-- mark a userdata
	local function markuserdata(me,parent,desc)
		if ismarked(me,parent,desc) then
			return
		end
	
		local mt = getmetatable(me)
		if mt then
			marktable(mt,me,"[metatable]")
		end
		local env = debug.getfenv(me)
		if env then
			marktable(env,me,"[environment]")
		end
	end

	-- mark an object
	function markobject(me,parent,desc)
		local t = type(me)
		if t == "table" then
			marktable(me,parent,desc)
		elseif t == "function" then
			markfunction(me,parent,desc)
		elseif t == "userdata" then
			markuserdata(me,parent,desc)
		elseif t == "thread" then
			-- thread not supported
		else
		end
	end

	marktable(debug.getregistry(),"root","registry")

	local callinfo = debug.getinfo(2)

	return setmetatable({
			marked		= marked,
			connections	= connections,
			sources		= sources,
			_slot		= os.clock(),
			_when		= os.time(),
			_detail		= ("%s:%d"):format(callinfo.short_src,callinfo.currentline)
		},snapshot_mt
	)
end

return snapshot
