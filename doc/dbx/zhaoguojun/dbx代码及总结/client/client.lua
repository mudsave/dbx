

mysql_param1 = {
	sql = "select AccountID, Name, ShowParts from role where ID = ? ",
	[1] = 669,
}

mysql_param2 = {
	sp = "sp_LoadPlayer",
	[1] = 176,
}

mysql_param3 = {
	sp = "sp_LoadMind",
	[1] = {1, 3, 5, 7, {"zgj", "hello"}},
}

mysql_param4 = {
	sp = "get_role_info",
	[1] = "z1",
	[2] = "@id",
	[3] = "@model_id",
}

function query()
	operation_id = mysql_query(mysql_param4, 0)
end

function test()
	print ("test");
end

--[[
{
	operation_id = 1,
	error=0,
	error_msg = "",
	rt_sum = 2,
	[1] = {
		[1] = {roleID=1, mindID=2, level=3},
		[2] = {},
	},
	[2] = {},
}
--]]


function print_result(result_list)
	print( tb_str(result_list, 10) )
end


function tb_str( tb, depth)
	depth = depth or 1
	depth = depth - 1
	local  str = ''
	--str = str..tostring(tb)
	str = str..'{'
	for i,v in pairs(tb) do
		if type(i) == 'string' then
			str = str..'\''..i..'\''
		else 
			if type(i) == 'number' then
			str = str..'['..i..']'
			end
		end
		str = str..'='
		if type(v) == 'string' then
			str = str..'\''..v..'\''
		end
		if type(v) == 'number' then
			str = str..v
		end
		if type(v) == 'function' then
			str = str..'func'
		end
		if type(v) == 'table' then
			if (depth > 0) then
				str = str..tb_str(v, depth)
			else
				str = str..'tb'
			end
		end
		str = str..', '
	end
	if string.len(str) > 2 then
		str = string.sub(str, 1, -3)
	end
	str = str..'}'
	return str
end
