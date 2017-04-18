-- snapshot.lua

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

local function checkmetatable(t)
	local mt = getmetatable(t)
	local weakk,weakv = false,false
	if mt then
		local mode = rawget(mt,"__mode")
		if mode then
			if mode:find 'k' then
				weakk = true
			end
			if mode:find 'v' then
				weakv = true
			end
		end
	end
	return mt,weakk,weakv
end

local isgco = {
	['nil'] = false,
	['table'] = true,
	['thread'] = false,
	['number'] = false,
	['string'] = false,
	['function'] = true,
	['userdata'] = true,
}

local function keystring(key)
	local t = type(key)
	if t == 'string' then
		return ('["%s"]'):format(key)
	elseif t == 'number' then
		return ('[%s]'):format(key)
	elseif t == 'boolean' then
		return ('[%s]'):format(key and "true" or "false")
	elseif t == 'userdata' then
		return ('[%s]'):format(tostring(key))
	elseif t == 'table' then
		return table_tostring(key,StringBuilder(),1)
	end
end

snapshot = class()

function snapshot:__init()
	local marked = newtable 'k'
	local connections = newtable 'k'

	local function ismarked( me,other,desc )
		if not marked[me] then
			marked[me] = true
			connections[me] = newtable(
				'k',{ [other] = desc,}
			)
			return false
		end
		if desc then
			connections[me][other] = desc
		end
		return true
	end

	local marktable
	local markuserdata
	local markfunction

	local function markobject( me,other,desc)
		local t = type(me)
		if ismarked( me,other,desc ) then
			return
		end
		if t == 'table' then
			marktable( me,other,desc )
		elseif t == 'function' then
			markfunction( me,other,desc )
		elseif t =='userdata' then
			markuserdata( me,other,desc )
		end
	end

	function marktable( me,other,desc )
		local mt,weakk,weakv = checkmetatable(me)
		if mt then
			markobject( mt,me,'[metatable]' )
		end

		for key,value in pairs(me) do
			if not weakk and isgco[type(key)] then
				markobject( key,me,"[key]" )
			end
			if not weakv and isgco[type(value)] then
				markobject( value,me,keystring(key) )
			end
		end
	end

	function markfunction( me,other,desc )
		local env = getfenv(me)
		if env then
			markobject( env,me,"[environment]" )
		end

		local index = 1
		repeat
			local name,upvalue = debug.getupvalue(me,index)
			if not name then break end
			if isgco[ type(upvalue) ] then
				markobject( upvalue,me,('[upvalue:"%s"]'):format(name) )
			end
			index = index + 1
		until false
	end

	function markuserdata( me,other,desc )
		local mt = getmetatable(me)
		if mt then
			markobject( mt,me,'[metatable]' )
		end
		local env = debug.getfenv(me)
		if env then
			markobject( env,me,'[environment]' )
		end
	end

	markobject( _G,"[_G]",nil )

	self.connections = connections
end

function snapshot:check(leaks,filename)
	local connections = self.connections

	local gl = newtable 'k'
	for key,value in pairs(_G) do
		if isgco[ type(value) ] then
			gl[value] = key
		end
	end
	gl[_G] = "_G"
	gl[debug.getregistry()] = "_R"

	local newt = newtable 'k'
	for value,what in pairs( leaks ) do
		for other,_ in pairs( connections[value] ) do
			if not leaks[other] then
				newt[ value ] = what
				break
			end
		end
	end

	local function search( value,list,hash,results )
		if gl[value] then
			local t = { closure = list.closure,gl[value] }

			local i = #list
			local j = 2
			while i > 0 do
				rawset( t,j,rawget( list,i ) )
				j = j + 1
				i = i - 1
			end
			
			results[ #results + 1 ] = t
		else
			for other,desc in pairs( connections[value] ) do
				if not hash[other] then
					local closure = (type(other) == 'function')

					hash[other] = true
					list[ #list + 1 ] = desc

					if closure then
						list.closure = list.closure + 1
					end
					search( other,list,hash,results )
					if closure then
						list.closure = list.closure - 1
					end

					list[ #list ] = nil
					hash[other] = false
				end
			end
		end
	end

	local results = {}
	local hash = {}

	for value,what in pairs( newt ) do
		local result = {
			routines = 0,
			what = what,
		}
		local list = {
			closure = 0, -- how much routines is based on closure,better no closure,cause one gc-able always shared by much of closures
		}
		hash[ value ] = true
		search( value,list,hash,result )
		hash[ value ] = false
		results[ value ] = result

		table.sort(result,function(a,b)
			return a.closure > b.closure
		end)
	end

	local index = 1
	local f = io.open(filename or "result.txt","w")
	for what,result in pairs(results) do
		local result_str = table.concat(result[1])
		local detail_str = type(what) == 'table' and table_tostring(what,StringBuilder(),1) or tostring(what)
		f:write( index,' : ',detail_str ,'\n' )
		f:write( index,' : ',result_str ,'\n' )
		f:write( index,' : ',result.what,"\n" )
		f:write( '\n' )
		index = index + 1
	end
	f:close()
end
