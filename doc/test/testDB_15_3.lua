print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
local params = {{}}
local function clearParams()
	local t = params[1]
	for k,_ in pairs(t) do
		t[k] = nil
	end
end
--------------------------------------------------------------------
--[[
	clearParams()
	params[1]["spName"] = "sp_UpdatePlayer"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "name,nvalue,cvalue,fvalue,rId"
	params[1]["rId"] = 1
	params[1]["name"] = "Money"
    params[1]["queueIndex"] = 1 
	local value = 1000000
	if type(value) == "string" then
		params[1]["cvalue"] = value
		params[1]["nvalue"] = 0
		params[1]["fvalue"] = 0
	elseif type(value) == "number" then
		params[1]["cvalue"] = ""
		params[1]["nvalue"] = value
		params[1]["fvalue"] = value
	end
    for i=1,500 do
		LuaDBAccess.exeSP(params, true)
	end
	
    ---------------------------------------------------------
	clearParams()
	params[1]["spName"] = "sp_test0"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID"
	params[1]["rID"] = -1	
	params[1]["queueIndex"] = 2
	LuaDBAccess.exeSP(params, true)	--第二个参数是noCallback的意思，true表示不需要回调
	
]]

clearParams()
params[1]["spName"] = "sp_Login"
params[1]["dataBase"] = 1
params[1]["sort"] = "account,name,dbid"
params[1]["account"] = "zgj"
params[1]["name"] = "1"
params[1]["dbid"] = 1
LuaDBAccess.exeSP(params, false)
