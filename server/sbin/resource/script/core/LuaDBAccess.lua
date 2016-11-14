--[[LuaDBAccess.lua
√Ë ˆ£∫
	lua∑√Œ  ˝æ›ø‚
--]]

LuaDBAccess = {}

local DB_CallbackContext = {}
local params = {{}}
local function clearParams()
	local t = params[1]
	for k,_ in pairs(t) do
		t[k] = nil
	end
end

function LuaDBAccess.loadPlayer(dbId, callbackFunction, callbackArgs)
	clearParams()
	params[1]["spName"] = "sp_LoadAll"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId"
	params[1]["rId"] = dbId

	local operationID = ManagedApp.exeSP(params, false)

	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID] = callback
end

function LuaDBAccess.onExeSP(operationID, recordResult, errorCode)
	local recordList = {}
	if errorCode == 0 then
		for i = 0, 100 do
			local test = CLuaArray:getResultofArray(recordResult, i)
			if test then
				local record = CLuaArray:getResult(test)
				recordList[i + 1] = record
			else
				break
			end
		end
	end
	recordList._result = errorCode
	recordList._operationID = operationID
	local callback = DB_CallbackContext[operationID] 
	if callback then
		callback.func(recordList, callback.args)
		DB_CallbackContext[operationID] = nil
	end
end