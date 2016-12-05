--[[LuaDBAccess.lua
描述：
	lua访问数据库
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

function LuaDBAccess.exeSP(params, bNoCallback, level)
	level = level or 20
	local la = CLuaArray:createLuaArray()
	la:setResult(nil, 0, params)
	opId = CDBProxy:callSP(la, bNoCallback, level)
	la:destroyLuaArray()
	return opId
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

function LuaDBAccess.loadPlayer(dbId, callbackFunction, callbackArgs)
	clearParams()
	params[1]["spName"] = "sp_LoadAll"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId"
	params[1]["rId"] = dbId

	local operationID = LuaDBAccess.exeSP(params, false)

	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID] = callback
end

function LuaDBAccess.loadSystem(system, dbId, callbackFunction, callbackArgs)
	clearParams()
	params[1]["spName"] = system
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId"
	params[1]["rId"] = dbId
	
	local operationID = LuaDBAccess.exeSP(params, false)
	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID] = callback	
end

--更新玩家基础值
function LuaDBAccess.updatePlayer(dbId, propName, value)
	clearParams()
	params[1]["spName"] = "sp_UpdatePlayer"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "name,nvalue,cvalue,fvalue,rId"
	params[1]["rId"] = dbId
	params[1]["name"] = propName
	if type(value) == "string" then
		params[1]["cvalue"] = value
		params[1]["nvalue"] = 0
		params[1]["fvalue"] = 0
	elseif type(value) == "number" then
		params[1]["cvalue"] = ""
		params[1]["nvalue"] = value
		params[1]["fvalue"] = value
	end
		
	LuaDBAccess.exeSP(params, true)
	
end

--更新roleAttribute
function LuaDBAccess.onPlayerAttrUpdate(player)
	clearParams()
	local param = params[1]

	param["spName"]		= "sp_UpdatePlayerAttr"
	param["dataBase"]	= 1
	param["sort"]		= "roleId,type,value"
	param["roleId"]		= player:getDBID()

	for attrName,attribute in pairs(player:getAttrSet()) do
		if attribute:isSaveDB() then
			params["type"]	= attrName
			params["value"] = attribute:getValue()
			LuaDBAccess.exeSP(params,true)
		end
	end
end

-- 删除玩家道具
function LuaDBAccess.itemRemove(playerDBID, RemoveFlag)
	clearParams()

	params[1]["spName"]		 = "sp_ItemRemove"
	params[1]["dataBase"]	 = 1
	params[1]["sort"]		 = "_RoleID,_RemoveFlag"

	params[1]["_RoleID"]	 = playerDBID
	params[1]["_RemoveFlag"] = RemoveFlag

	LuaDBAccess.exeSP(params, true)
end

-- 存储玩家道具
function LuaDBAccess.itemSave(playerDBID, itemsNum, itemsBuffer)
	clearParams()

	params[1]["spName"]		  = "sp_ItemSaveEx"
	params[1]["dataBase"]	  = 1
	params[1]["sort"]		  = "_RoleID,_ItemsNum,_ItemsBuffer"

	params[1]["_RoleID"]	  = playerDBID
	params[1]["_ItemsNum"]    = itemsNum
	params[1]["_ItemsBuffer"] = itemsBuffer

	--print("playerDBID, itemsNum, itemsBuffer", playerDBID, itemsNum, itemsBuffer)
	LuaDBAccess.exeSP(params, true)
end

-- 存储玩家装备
function LuaDBAccess.equipSave(playerDBID, equipsNum, equipsBuffer)
	clearParams()

	params[1]["spName"]		  = "sp_EquipSave"
	params[1]["dataBase"]	  = 1
	params[1]["sort"]		  = "_RoleID,_EquipsNum,_EquipsBuffer"

	params[1]["_RoleID"]	  = playerDBID
	params[1]["_EquipsNum"]   = equipsNum
	params[1]["_EquipsBuffer"] = equipsBuffer
	--print("playerDBID, equipsNum, equipsBuffer", playerDBID, equipsNum, equipsBuffer)
	LuaDBAccess.exeSP(params, true)
end

--存储玩家坐骑
function LuaDBAccess.updatePlayerRide(roleID,rideGuid,rideID,vigor,completeness,isFollow,ridingTime)
	if not roleID then
		return
	end
	clearParams()
	local param = params[1]
	param['spName']			= "sp_UpdateRide"
	param["dataBase"]		= 1
	param['sort']			= "rID,guid,ID,vigor,completeness,isFollow,ridingTime"
	param['rID']			= roleID
	param["guid"]			= rideGuid
	param["ID"]				= rideID
	param["vigor"]			= vigor
	param["completeness"]	= completeness
	param["isFollow"]		= isFollow
	param["ridingTime"]		= ridingTime
	LuaDBAccess.exeSP(params,false)
	return true
end

--删除玩家坐骑
function LuaDBAccess.deletePlayerRide(rideGuid)
	clearParams()
	local param = params[1]
	param['spName']			= "sp_DeleteRide"
	param["dataBase"]		= 1
	param['sort']			= "guid"
	param["guid"]			= rideGuid
	LuaDBAccess.exeSP(params,false)
	return true
end
