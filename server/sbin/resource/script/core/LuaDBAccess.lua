--[[LuaDBAccess.lua
描述：
	lua访问数据库
--]]

local function toDo(str,...) end

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
			param["type"]	= attrName
			param["value"] = attribute:getValue()
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

-- 加载宠物
function LuaDBAccess.LoadPet(pet,func)
	clearParams()
	local param = params[1]
	param['spName']			= "sp_LoadPet"
	param['dataBase']		= 1
	param['sort']			= "petID"
	param['petID']			= pet:getDBID()

	DB_CallbackContext[
		LuaDBAccess.exeSP(params,false)
	] = {
		func = func,
		args = pet,
	}
end

-- 保存宠物
function LuaDBAccess.SavePet(pet)
	if not pet then
		return false
	end

	clearParams()
	local param = params[1]
	param['dataBase'] = 1

	if pet:onSave(param) then
		DB_CallbackContext[
			LuaDBAccess.exeSP(params,false)
		] = {
			func = LuaDBAccess.OnPetSaved,
			args = pet
		}
	end
end

-- 删除宠物
function LuaDBAccess.DeletePet(pet)
	if not pet then return false end
	clearParams()
	local param = params[1]
	param["dataBase"] 	= 1
	param["spName"]		= "sp_DeletePet"
	param["sort"]		= "DBID"
	param["DBID"]		= pet:getDBID()
	
	LuaDBAccess.exeSP(params,false)		
end

-- 进一步保存宠物数据
function LuaDBAccess.OnPetSaved(recordList,pet)
	print "宠物基础数据保存完毕"
	if LuaDBAccess.SavePetAttrs(pet) then
		print "保存宠物的属性集合"
	end
	if LuaDBAccess.SavePetSkills(pet) then
		print "保存宠物的技能"
	end
	if pet:isRemoved() then
		g_entityMgr:removePet(pet:getID())
	end
end

local function SavePetAttr(param,attrName,attrValue)
	if not attrName then return false end
	param['attrName'] = attrName
	param['attrValue'] = attrValue
	LuaDBAccess.exeSP(params,true)
	return true
end

-- 保存宠物属性集合
function LuaDBAccess.SavePetAttrs(pet)
	clearParams()
	local param = params[1]

	param['dataBase'] = 1
	param['spName'] = 'sp_UpdatePetAttribute'
	param['sort'] = "id,attrName,attrValue"
	param['id'] = pet:getDBID()

	for attrName,attribute in pairs(pet:getAttributeSet()) do
		if attribute:isSaveDB() then
			SavePetAttr(param,attrName,attribute:getValue())
		end
	end

	return true
end

-- 保存宠物技能
function LuaDBAccess.SavePetSkills(pet)
	toDo "添加宠物技能保存"
	clearParams()
	local param = params[1]
	param['dataBase'] = 1

	local function tick()
		LuaDBAccess.exeSP(params,true)
	end

	local handler = pet:getHandler(HandlerDef_PetSkill)
	return handler:onSave(param,tick)
end

-- 保存玩家副本数据
function LuaDBAccess.saveEctypeInfo(playerDBID, ectypeInfo)
	clearParams()
	params[1]["spName"]		 = "sp_SaveEctype"
	params[1]["dataBase"]	 = 1
	params[1]["sort"]		 = "_RoleID,_EctypeInfo"
	params[1]["_RoleID"]	 = playerDBID
	params[1]["_EctypeInfo"] = ectypeInfo
	LuaDBAccess.exeSP(params, true)
end

-- 保存玩家连环副本数据
function LuaDBAccess.saveRingEctypeInfo(playerDBID, ringEctypeInfo)
	clearParams()
	params[1]["spName"]		     = "sp_SaveRingEctype"
	params[1]["dataBase"]	     = 1
	params[1]["sort"]		     = "_RoleID,_RingEctypeInfo"
	params[1]["_RoleID"]	     = playerDBID
	params[1]["_RingEctypeInfo"] = ringEctypeInfo
	LuaDBAccess.exeSP(params, true)
end

function LuaDBAccess.updateNormalTask(playerDBID, task)
	clearParams()
	params[1]["spName"] = "sp_UpdateNormalTask"
	params[1]["dataBase"] = 1
	params[1]["sort"] = '_RoleID,_TaskID,_State,_TargetState,_EndTime'

	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskID"] = task:getID()
	params[1]["_State"] = task:getStatus()
	params[1]["_TargetState"] = toString(task:getTargetState())
	params[1]["_EndTime"] = task:getEndTime() or 0
	LuaDBAccess.exeSP(params, false)
end

function LuaDBAccess.updateLoopTask(playerDBID, task)
	clearParams()
	params[1]["spName"] = "sp_UpdateLoopTask"
	params[1]["dataBase"] = 1
	params[1]["sort"] = '_RoleID,_TaskID,_State,_TargetState,_TargetType,_GradeIdx,_RingIdx,_Targets,_EndTime,_Triggers,_Level'

	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskID"] = task:getID()
	params[1]["_State"] = task:getStatus()
	params[1]["_TargetState"] = toString(task:getTargetState())
	params[1]["_TargetType"] = task:getTargetType()
	params[1]["_GradeIdx"] = task:getGradeIdx()
	params[1]["_RingIdx"] = task:getRingIdx()
	params[1]["_Targets"] = toString(task:getTargetsConfig())
	params[1]["_EndTime"] = task:getEndTime() or 0
	params[1]["_Triggers"] = toString(task:getTriggers())
	params[1]["_Level"] = task:getReceiveTaskLvl()
	LuaDBAccess.exeSP(params, false)
end

function LuaDBAccess.updateLoopTaskRing(playerDBID, taskID, taskInfo)
	clearParams()
	params[1]["spName"] = "sp_UpdateLoopTaskRing"
	params[1]["dataBase"] = 1
	params[1]["sort"] = '_RoleID,_TaskID,_CountRing,_CurrentRing,_OfflineTime'

	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskID"] = taskID
	params[1]["_CountRing"] = taskInfo.countRing
	params[1]["_CurrentRing"] = taskInfo.currentRing
	params[1]["_OfflineTime"] = os.time()
	LuaDBAccess.exeSP(params, false)

end

function LuaDBAccess.updateTaskTrace(playerDBID, taskTraceList)
	clearParams()
	params[1]["spName"] = "sp_UpdateTaskTrace"
	params[1]["dataBase"] = 1
	params[1]["sort"] = '_RoleID,_TaskTraceList'

	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskTraceList"] = toString(taskTraceList)

	LuaDBAccess.exeSP(params, false)
end

function LuaDBAccess.deleteNormalTask(playerDBID, taskID)
	clearParams()
	params[1]["spName"] = "sp_DeleteNormalTask"
	params[1]["dataBase"] = 1

	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskID"] = taskID

	params[1]["sort"] = '_RoleID,_TaskID'
	LuaDBAccess.exeSP(params, false)
end

function LuaDBAccess.deleteLoopTask(playerDBID, taskID)
	clearParams()
	params[1]["spName"] = "sp_DeleteLoopTask"
	params[1]["dataBase"] = 1

	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskID"] = taskID

	params[1]["sort"] = '_RoleID,_TaskID'
	LuaDBAccess.exeSP(params, false)
end

function LuaDBAccess.updateHisTask(playerDBID, historyList)
	clearParams()
	params[1]["spName"] = "sp_AddHisTask"
	params[1]["dataBase"] = 1

	params[1]["_RoleID"] = playerDBID
	if type(historyList) ~= "table" then
		print("请找贾伦",toString(historyList),debug.traceback())
		assert (type(historyList) == "table")
		return
	end
	params[1]["_HistoryTasks"] = toString(historyList)

	params[1]["sort"] = '_RoleID,_HistoryTasks'
	LuaDBAccess.exeSP(params, false)
end

function LuaDBAccess.updateRoleTaskPrivate(playerDBID, privateTaskData)
	clearParams()
	params[1]["spName"] = "sp_UpdateRoleTaskPrivateData"
	params[1]["dataBase"] = 1
	params[1]["_RoleID"] = playerDBID
	params[1]["_TaskPrivateData"] = toString(privateTaskData)

	params[1]["sort"] = '_RoleID,_TaskPrivateData'
	LuaDBAccess.exeSP(params, false)
end

-- 保存玩家挖宝的数据
function LuaDBAccess.treasureSave(playerDBID,treasuresNum,treasuresBuffer)
	clearParams()

	params[1]["spName"]				= "sp_SaveTreasure"
	params[1]["dataBase"]			= 1
	params[1]["sort"]				= "_RoleID,_TreasuresNum,_TreasuresBuffer"

	params[1]["_RoleID"]			= playerDBID
	params[1]["_TreasuresNum"]		= treasuresNum
	params[1]["_TreasuresBuffer"]	= treasuresBuffer
	-- print("playerDBID,treasuresNum,treasuresBuffer",params[1]["_RoleID"],params[1]["_TreasuresNum"],toString(params[1]["_TreasuresBuffer"]))
	LuaDBAccess.exeSP(params, true)
end

function LuaDBAccess.treasureRemove(playerDBID)
	clearParams()

	params[1]["spName"]				= "sp_DeleteTreasure"
	params[1]["dataBase"]			= 1
	params[1]["sort"]				= "_RoleID"
	params[1]["_RoleID"]			= playerDBID
	LuaDBAccess.exeSP(params, true)
end


function LuaDBAccess.SaveRoleTiredness(roleDBID,tiredness,recordTime)
	clearParams()
	
	params[1]["spName"]			= "sp_UpdateRoleTiredness"
	params[1]["dataBase"]		= 1
	params[1]["sort"]			= "_RoleID,_Tiredness,_RecordTime"

	params[1]["_RoleID"]		= roleDBID
	params[1]["_Tiredness"]		= tiredness
	params[1]["_RecordTime"]	= recordTime
	
	LuaDBAccess.exeSP(params, true)
end


function LuaDBAccess.SavePractise(roleDBID,data)
	clearParams()
	params[1]["spName"]			= "sp_updateRolePractise"
	params[1]["dataBase"]		= 1
	params[1]["sort"]			= "_RoleID,_Practise,_PractiseCount,_BoxAFlage,_BoxBFlage,_BoxCFlage,_BoxDFlage,_BoxEFlage,_RecordTime,_StoreXp"

	params[1]["_RoleID"]		= roleDBID
	params[1]["_Practise"]		= data.practise
	params[1]["_PractiseCount"]	= data.practiseCount
	
	params[1]["_BoxAFlage"]		= data.BoxAFlage
	params[1]["_BoxBFlage"]		= data.BoxBFlage
	params[1]["_BoxCFlage"]		= data.BoxCFlage
	params[1]["_BoxDFlage"]		= data.BoxDFlage
	params[1]["_BoxEFlage"]		= data.BoxEFlage
	params[1]["_RecordTime"]	= data.recordTime
	params[1]["_StoreXp"]		= data.storeXp
	LuaDBAccess.exeSP(params, true)
end


--保存玩家快捷栏数据
function LuaDBAccess.shortCutKeySave(playerDBID,keyData)
	clearParams()
	--这里的组合数据是个32位数，前16位是包裹索引，后16位是格子索引
	local srcSlotType			= keyData.srcSlotType
	local srcSlotIndex			= keyData.srcSlotIndex
	local data1					= bit_lshift(srcSlotType,16)
	local data2					= srcSlotIndex
	local groupData				= bit_or(data1,data2)
	params[1]["spName"]			= "sp_SaveShortCutKey"
	params[1]["dataBase"]		= 1
	params[1]["sort"]			= "roleID,idx,keyType,groupData,skillID"
	params[1]["roleID"]			= playerDBID
	params[1]["idx"]			= keyData.targetSlotIndex							--快捷栏格子索引
	params[1]["keyType"]		= keyData.type										--快捷栏数据的类型
	params[1]["groupData"]		= groupData											--包裹、格子的组合数据
	params[1]["skillID"]		= keyData.skillID
	LuaDBAccess.exeSP(params, true)
end

--删除玩家快捷栏表中所有数据
function LuaDBAccess.shortCutKeyDelete(playerDBID)
	clearParams()
	params[1]["spName"]		= "sp_DeleteShortCutKey"
	params[1]["dataBase"]	= 1
	params[1]["sort"]		= "roleID"
	params[1]["roleID"]		= playerDBID
	LuaDBAccess.exeSP(params, true)
end

-- 保存玩家生活技能等级
function LuaDBAccess.updatePlayerLifeSkill(playerDBID, lifeSkillID, lifeSkillLevel)
	clearParams()
	params[1]["spName"]				 = "sp_UpdatePlayerLifeSkill"
	params[1]["dataBase"]			 = 1
	params[1]["sort"]				 = "_rID,_lifeSkillID,_lifeSkillLevel"
	params[1]["_rID"]				 = playerDBID
	params[1]["_lifeSkillID"]		 = lifeSkillID
	params[1]["_lifeSkillLevel"]     = lifeSkillLevel
	LuaDBAccess.exeSP(params, true)
end

--更新玩家buff
function LuaDBAccess.updatePlayerBuff(playerDBID, buffID, stayValue, freeze)
	clearParams()
	params[1]["spName"]		= "sp_UpdatePlayerBuff"
	params[1]["dataBase"]	= 1
	params[1]["sort"]		= "rID,buffID,stayValue,lastLogin,freeze"
	params[1]["rID"]		= playerDBID
	params[1]["buffID"]		= buffID
	params[1]["stayValue"]	= stayValue
	params[1]["lastLogin"]	= os.time()
	params[1]["freeze"]		= freeze
	LuaDBAccess.exeSP(params, true)
end

-- 删除玩家buff
function LuaDBAccess.deletePlayerBuff(playerDBID)
	clearParams()
	params[1]["spName"]		= "sp_DeletePlayerBuff"
	params[1]["dataBase"]	= 1
	params[1]["sort"]		= "rID"
	params[1]["rID"]		= playerDBID
	LuaDBAccess.exeSP(params, true)
end

function LuaDBAccess.loadMinds(role_DBID, callback, callback_args)
	clearParams()
	params[1]["spName"] = "sp_LoadMind"
	params[1]["dataBase"] = 1
	params[1]["sort"] = 'role_id'
	params[1]["role_id"] = role_DBID
	local operationID = LuaDBAccess.exeSP(params, false)
	local callback_t = {
		func = callback,
		args = callback_args
	}
	DB_CallbackContext[operationID] = callback_t
end

-- 更新道具使用次数
function LuaDBAccess.updateItemUseTimes(playerDBID, itemID, useTimes, recordTime)
	clearParams()

	params[1]["spName"]		 = "sp_UpdateItemUseTimes"
	params[1]["dataBase"]	 = 1
	params[1]["sort"]		 = "_RoleID,_ItemID,_UseTimes,_RecordTime"

	params[1]["_RoleID"]	 = playerDBID
	params[1]["_ItemID"]     = itemID
	params[1]["_UseTimes"]	 = useTimes
	params[1]["_RecordTime"] = recordTime

	LuaDBAccess.exeSP(params, true)
end

function LuaDBAccess.upgradeMind(role_DBID, mind_id, add_level, callback, callback_args)
	clearParams()
	params[1]["spName"] = "sp_UpdateMind"
	params[1]["dataBase"] = 1
	params[1]["sort"] = 'role_id,mind_id,add_level'
	params[1]["role_id"] = role_DBID
	params[1]["mind_id"] = mind_id
	params[1]["add_level"] = add_level
	local operationID = LuaDBAccess.exeSP(params, false)
	local callback_t = {
		func = callback,
		args = callback_args
	}
	DB_CallbackContext[operationID] = callback_t
end

function LuaDBAccess.addMind(role_DBID, mind_id, mind_level)
	clearParams()
	params[1]["spName"] = "sp_AddMind"
	params[1]["dataBase"] = 1
	params[1]["sort"] = 'role_id,mind_id,mind_level'
	params[1]["role_id"] = role_DBID
	params[1]["mind_id"] = mind_id
	params[1]["mind_level"] = mind_level
	LuaDBAccess.exeSP(params, false)
end

-- 保存在线抽奖数据
function LuaDBAccess.UpdateRewardSession(session)
	if not session then return false end
	clearParams()
	local param = params[1]
	param["dataBase"] = 1
	if session:onUpdateSession2DB(param) then
		LuaDBAccess.exeSP(params, true)
		param["dataBase"] = 1
		LuaDBAccess.exeSP(params, true)
		clearParams()
		param["dataBase"] = 1
		while session:onUpdateResult2DB(param) do
			LuaDBAccess.exeSP(params, true)
		end
	end
end

--删除在线抽奖session记录
function LuaDBAccess.DeleteRewardSession(playerDBID)
    if not playerDBID then return false end
	clearParams()
    local param = params[1]
    param['spName']         = "sp_DeleteRewardSession"
    param["dataBase"]		= 1
    param['sort']           = "rID"
    param['rID']             = playerDBID
    LuaDBAccess.exeSP(params, true)
end
-- 保存在线奖励数据
function LuaDBAccess.SaveNewRewards(roleDBID,times,betweenTime,rewardFlag)
	clearParams()
	params[1]["spName"]			= "sp_SaveNewRewards"
	params[1]["dataBase"]		= 1
	params[1]["sort"]			= "_RoleID,_Times,_BetweenTime"

	params[1]["_RoleID"]		= roleDBID
	params[1]["_Times"]			= times
	params[1]["_BetweenTime"]	= betweenTime
	LuaDBAccess.exeSP(params, true)
end

-- 保存玩家功能设置
function LuaDBAccess.SaveRoleConfig(roleDBID,data)
	clearParams()
	params[1]["spName"]			= "sp_UpdateRoleConfig"
	params[1]["dataBase"]		= 1
	params[1]["sort"]			= "_rID,_rFriend,_rMess,_rInfo,_rTeam,_rTrade,_rFaction"
	params[1]["_rID"]			= roleDBID
	params[1]["_rFriend"]		= data.rFriend
	params[1]["_rMess"]			= data.rMess
	params[1]["_rInfo"]			= data.rInfo
	params[1]["_rTeam"]			= data.rTeam
	params[1]["_rTrade"]		= data.rTrade
	params[1]["_rFaction"]		= data.rFaction
	LuaDBAccess.exeSP(params, true)
end

--邮件相关
function LuaDBAccess.MailRemove(mail)
	if not mail then return end
	clearParams()
	local param = params[1]
	param["spName"] = "sp_MailRemove"
	param["dataBase"] = 1
	param["sort"] = "mailID"
	param["mailID"]=mail.mailID
	
	LuaDBAccess.exeSP(params,false)
end

function LuaDBAccess.MailNew(mail,dbID)
	if not mail or not dbID then return end
	clearParams()
	local param = params[1]
	param["spName"] = "sp_MailNew"
	param["dataBase"] = 1
	param["sort"] = "rID,date,type,theme,content,extra,expires,read"
	param["rID"] = dbID
	param["date"] = mail:getSendDate()
	param["type"] = mail.type
	param["theme"] = mail.theme
	param["content"] = mail:getContentString()
	param["extra"] = mail:getExtraString()
	param["expires"] = mail.expires
	param["read"] = false
	
	LuaDBAccess.exeSP(params,false)
end

-- 保存玩家历练等级
function LuaDBAccess.updatePlayerExperience(playerDBID, expSkillID, expLevel)
	clearParams()
	params[1]["spName"]			= "sp_UpdatePlayerExperience"
	params[1]["dataBase"]		= 1
	params[1]["sort"]			= "_rID,_expSkillID,_expLevel"
	params[1]["_rID"]			= playerDBID
	params[1]["_expSkillID"]	= expSkillID
	params[1]["_expLevel"]		= expLevel
	LuaDBAccess.exeSP(params, false)
end

--保存实体的自动点数分配策略
function LuaDBAccess.SavePointSetting(entity)
	local handler = entity:getHandler(HandlerDef_AutoPoint)
	if handler then
		clearParams()
		local param = params[1]
		if handler:onSave(param) then
			param["dataBase"] = 1
			LuaDBAccess.exeSP(params, false)
		end
	end
end
--保存玩家的猎金场总积分
function LuaDBAccess.updateGoldHuntActivity(player)
	local handler = player:getHandler(HandlerDef_Activity)
	if handler then
		clearParams()
		local curTotal = handler:getGoldHuntData().totalScore
		local isPrized = handler:getGoldHuntData().isPrized
		params[1]["spName"]			= "sp_UpdateGoldHunt"
		params[1]["dataBase"]		= 1
		params[1]["sort"]			= "ID,totalScore,isPrized"
		params[1]["ID"]			= player:getDBID()
		params[1]["totalScore"]	= curTotal
		params[1]["isPrized"]	= isPrized
		
		LuaDBAccess.exeSP(params, false)
	end
end

function LuaDBAccess.updateBeastBless(player,activityId)
	local handler = player:getHandler(HandlerDef_Activity)
	if handler then
		clearParams()
		local fightCount = handler:getPriData(activityId)
		params[1]["spName"]			= "sp_UpdatePlayerBeastBless"
		params[1]["dataBase"]		= 1
		params[1]["sort"]			= "_roleID,_fightCount,_recordTime"
		params[1]["_roleID"]		= player:getDBID()
		params[1]["_fightCount"]	= fightCount
		params[1]["_recordTime"]	= os.time()
		LuaDBAccess.exeSP(params, false)
	end
end

---------------------------------------------------------------------------------------------------
--更新世界服数据
function LuaDBAccess.UpdateWorldServerData( playerDBID,valueName,cvalue,ivalue )

	clearParams()
	params[1]["spName"] = "sp_UpdateWorldServerData"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "pID,valueName,cvalue,ivalue"
	params[1]["pID"] = playerDBID
	params[1]["valueName"] = valueName
	params[1]["cvalue"] = cvalue
	params[1]["ivalue"] = ivalue
	LuaDBAccess.exeSP(params,false)

end