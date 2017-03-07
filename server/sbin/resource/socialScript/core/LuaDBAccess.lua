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

--社会服载入数据--------------------------------------------

--载入玩家，第一个和第三个都为玩家ID，第二个是回调方法
function LuaDBAccess.loadPlayer(dbId, callbackFunction, callbackArgs)
	--清空参数
	clearParams()
	--存进参数
	params[1]["spName"] = "sp_LoadAll"--对应数据库里的函数
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId"
	params[1]["rId"] = dbId
	
	--执行相关函数
	local operationID = LuaDBAccess.exeSP(params, false)

	--处理callback
	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	--将回调方法存进表格，key值为操作ID
	DB_CallbackContext[operationID] = callback
end

-----------------------------------------------------------------------------------------------


--好友系统好友相关数据操作--------------------------------------------------------------------------------------------------


--载入玩家相关好友ID
function LuaDBAccess.loadRoleFriends(dbId,callbackFunction,callbackArgs)

	clearParams()
	
	params[1]["spName"] = "sp_LoadRoleFriends"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId"
	params[1]["rId"] = dbId

	
	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	
	DB_CallbackContext[operationID] = callback

end

--得到玩家信息---------------------------------------------------------------------------------
function LuaDBAccess.getPlayerInfo(playerDBID,playerName,callbackFunction,callbackArgs)

	clearParams()
	
	params[1]["spName"] = "sp_GetPlayerInfo"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "pId,pName"
	params[1]["pId"] = playerDBID
	params[1]["pName"] = playerName
	
	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	
	
	DB_CallbackContext[operationID] = callback
	
end


--增加好友信息------------------------------------------------------------------
function LuaDBAccess.addFriend(roleDBID,friendDBID,state,screenValue)
	clearParams()
	
	params[1]["spName"] = "sp_AddFriend"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId,fId,stateValue,screenValue"
	params[1]["rId"] = roleDBID
	params[1]["fId"] = friendDBID
	params[1]["stateValue"] = state
	params[1]["screenValue"] = screenValue
	
	local operationId =LuaDBAccess.exeSP(params,false)
end

--修改好友信息
function LuaDBAccess.updateFriend(roleDBID,friendDBID,state,screenValue)
	clearParams()
	
	params[1]["spName"] = "sp_UpdateFriend"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rId,fId,stateValue,screenValue"
	params[1]["rId"] = roleDBID
	params[1]["fId"] = friendDBID
	params[1]["stateValue"] = state
	params[1]["screenValue"] = screenValue

	local operationId =LuaDBAccess.exeSP(params,false)
	
end

--删除好友操作-------------------------------------------------------------------------
function LuaDBAccess.deleteFriend(roleDBID,friendDBID)
	clearParams()
	
	params[1]["spName"] = "sp_DeleteFriend"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "roleDBID,friendDBID"
	params[1]["roleDBID"] = roleDBID
	params[1]["friendDBID"] = friendDBID
	
	LuaDBAccess.exeSP(params,false)

end

--增加好友离线聊天记录
function LuaDBAccess.addFriendChatOfflineMsg( roleDBID,friendDBID,friendName,offlineMsgHeader,offlineMsgContent )
	
	clearParams()

	params[1]["spName"] = "sp_AddFriendChatOfflineMsg"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,fID,friendName,offlineMsgHeader,offlineMsgContent"
	params[1]["rID"] = roleDBID
	params[1]["fID"] = friendDBID
	params[1]["friendName"] = friendName
	params[1]["offlineMsgHeader"] = offlineMsgHeader
	params[1]["offlineMsgContent"] = offlineMsgContent

	LuaDBAccess.exeSP(params,false)

end

--得到好友离线聊天记录
function LuaDBAccess.getFriendChatOfflineMsg( roleDBID,callbackFunction,callbackArgs )

	clearParams()

	params[1]["spName"] = "sp_GetFriendChatOfflineMsg"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "roleDBID"
	params[1]["roleDBID"] = roleDBID

	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	
	DB_CallbackContext[operationID] = callback

end

--删除好友离线聊天记录
function LuaDBAccess.deleteFriendChatOfflineMsg( roleDBID,friendDBID )
	clearParams()

	params[1]["spName"] = "sp_DeleteFriendChatOfflineMsg"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "roleDBID,friendDBID"
	params[1]["roleDBID"] = roleDBID
	params[1]["friendDBID"] = friendDBID

	LuaDBAccess.exeSP(params,false)



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

--偶遇功能
function LuaDBAccess.runIntoFriends( min,max,roleDBID,callbackFunction,callbackArgs)
	
	clearParams()

	params[1]["spName"] = "sp_RunIntoFriends"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "minLevel,maxLevel,rID"
	params[1]["minLevel"] = min
	params[1]["maxLevel"] = max
	params[1]["rID"] = roleDBID

	local operationID = LuaDBAccess.exeSP(params,false)

	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	
	DB_CallbackContext[operationID] = callback

end



--好友系统群相关数据操作--------------------------------------------------------------------------------------------------

--载入玩家相关群DBID

function LuaDBAccess.loadRoleGroups(roleDBID,callbackFunction,callbackArgs)
	
	clearParams()
	
	params[1]["spName"] = "sp_LoadRoleGroups"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID"
	params[1]["rID"] = roleDBID
	
	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs
	}
	
	DB_CallbackContext[operationID] = callback
	
end

--载入玩家相关群信息
function LuaDBAccess.loadGroupInfo(groupDBID,groupName,callbackFunction,callbackArgs)
	
	clearParams()
	
	params[1]["spName"] = "sp_LoadGroupInfo"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "gID,gName"
	params[1]["gID"] = groupDBID
	params[1]["gName"] = groupName
	
	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs,
	}
	
	DB_CallbackContext[operationID] = callback
	
end

--载入群里的玩家DBID
function LuaDBAccess.loadGroupMembers(groupDBID,callbackFunction,callbackArgs)
	
	clearParams()
	
	params[1]["spName"] = "sp_LoadGroupMembers"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "gID"
	params[1]["gID"] = groupDBID
	
	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs,
	}
	
	DB_CallbackContext[operationID] = callback
	
end

--玩家创建群
function LuaDBAccess.CreateGroup(roleDBID,groupName)

	clearParams()
	
	params[1]["spName"] = "sp_CreateGroup"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,gName"
	params[1]["rID"] = roleDBID
	params[1]["gName"] = groupName
	
	LuaDBAccess.exeSP(params,false)
	
end

--群主删除群
function LuaDBAccess.deleteGroup(groupDBID)

	clearParams()
	
	params[1]["spName"] = "sp_DeleteGroup"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "gID"
	params[1]["gID"] = groupDBID
	
	LuaDBAccess.exeSP(params,false)
	
end

--玩家离群
function LuaDBAccess.exitGroup(roleDBID,groupDBID)
	
	clearParams()
	
	params[1]["spName"] = "sp_ExitGroup"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,gID"
	params[1]["rID"] = roleDBID
	params[1]["gID"] = groupDBID
	
	LuaDBAccess.exeSP(params,false)
	
end

--玩家加群
function LuaDBAccess.addGroupMember(roleDBID,groupDBID,state)
	
	clearParams()
	
	params[1]["spName"] = "sp_AddGroupMember"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,gID,stateValue"
	params[1]["rID"] = roleDBID
	params[1]["gID"] = groupDBID
	params[1]["stateValue"] = state
	
	LuaDBAccess.exeSP(params,false)
	
end

--更新群信息
function LuaDBAccess.updateGroupInfo(groupDBID,inform)

	clearParams()
	
	params[1]["spName"] = "sp_UpdateGroupInfo"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "gID,informValue"
	params[1]["gID"] = groupDBID
	params[1]["informValue"] = inform
	
	LuaDBAccess.exeSP(params,false)
	
end


--更新玩家群设置
function LuaDBAccess.updateGroupSetting(roleDBID,groupDBID,state,notice,receiveOfflineMsgState)

	clearParams()
	
	params[1]["spName"] = "sp_UpdateGroupSetting"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,gID,stateValue,noticeValue,receiveState"
	params[1]["rID"] = roleDBID
	params[1]["gID"] = groupDBID
	params[1]["noticeValue"] = notice
	params[1]["stateValue"] = state
	params[1]["receiveState"] = receiveOfflineMsgState
	
	LuaDBAccess.exeSP(params,false)
	
end


--增加玩家离线群消息
function LuaDBAccess.addGroupChatOfflineMsg(roleDBID,groupDBID,groupName,offlineMsgHeader,offlineMsgContent)

	clearParams()

	params[1]["spName"] = "sp_AddGroupChatOfflineMsg"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,gID,gName,msgHeader,msgContent"
	params[1]["rID"] = roleDBID
	params[1]["gID"] = groupDBID
	params[1]["gName"] = groupName
	params[1]["msgHeader"] = offlineMsgHeader
	params[1]["msgContent"] = offlineMsgContent

	LuaDBAccess.exeSP(params,false)

end

--删除玩家离线群消息
function LuaDBAccess.deleteGroupChatOfflineMsg(roleDBID,groupDBID)

	clearParams()

	params[1]["spName"]  = "sp_DeleteGroupChatOfflineMsg"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rID,gID"
	params[1]["rID"] = roleDBID
	params[1]["gID"] = groupDBID

	LuaDBAccess.exeSP(params,false)

end

--得到玩家离线群消息
function LuaDBAccess.getGroupChatOfflineMsg(groupDBID,roleDBID,callbackFunction,callbackArgs)

	clearParams()
	
	params[1]["spName"] 	= "sp_GetGroupChatOfflineMsg"
	params[1]["dataBase"] 	= 1
	params[1]["sort"] 		= "gID,rID"
	params[1]["gID"] 		= groupDBID
	params[1]["rID"] 		= roleDBID
	
	local operationID = LuaDBAccess.exeSP(params,false)
	
	local callback = {
		func = callbackFunction,
		args = callbackArgs,
	}
	
	DB_CallbackContext[operationID] = callback

end

--玩家帮派系统-------------------------------------------------------------------------------------------

function LuaDBAccess.getAllFactionInfos( playerDBID,callbackFunction,callbackArgs )

	clearParams()

	params[1]["spName"] 	= "sp_LoadAllFactionInfos"
	params[1]["dataBase"] 	= 1 
	params[1]["sort"] = "playerDBID"
	params[1]["playerDBID"] = playerDBID

	local operationID		=	LuaDBAccess.exeSP(params,false)

	local callback 			= {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID]	= callback

end

function LuaDBAccess.getRoleFactionInfo(roleDBID,callbackFunction,callbackArgs)

	clearParams()
	params[1]["spName"] 	= "sp_LoadRoleFactionInfos"
	params[1]["dataBase"] 	= 1 
	params[1]["sort"]		= "rID"
	params[1]["rID"]		= roleDBID

	local operationID		=	LuaDBAccess.exeSP(params,false)
	local callback 			= {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID]	= callback

end

function LuaDBAccess.getFactionInfo( factionDBID,factionName,callbackFunction,callbackArgs )
	
	clearParams()
	params[1]["spName"]		= "sp_LoadFactionInfo"
	params[1]["dataBase"]	= 1
	params[1]["sort"]		= "fID,fName"
	params[1]["fID"]		= factionDBID
	params[1]["fName"]		= factionName

	local operationID		= LuaDBAccess.exeSP(params,false)
	local callback 			= {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID]	= callback

end

function LuaDBAccess.getFactionMembers( factionDBID,callbackFunction,callbackArgs )
	
	clearParams()
	params[1]["spName"]		= "sp_LoadFactionMembers"
	params[1]["dataBase"]	= 1
	params[1]["sort"]		= "fID"
	params[1]["fID"]		= factionDBID

	local operationID 		= LuaDBAccess.exeSP(params,false)
	local callback			= {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID] = callback

end

function LuaDBAccess.ApplyFaction( factionDBID,playerDBID,state,applyMsg,joinDate )

	clearParams()

	params[1]["spName"]		= "sp_ApplyFaction"
	params[1]["dataBase"]	= 1
	params[1]["sort"]		= "fID,mID,state,applyMsg,joinDate"
	params[1]["fID"]		= factionDBID
	params[1]["mID"]		= playerDBID
	params[1]["state"]      = state
	params[1]["applyMsg"]   = applyMsg
	params[1]["joinDate"]   = joinDate


	LuaDBAccess.exeSP(params,false)

end


function LuaDBAccess.updateFactionMembers( factionDBID,playerDBID,updateCode,state,position,joinDate,applyMsg )
	
	clearParams()

	params[1]["spName"] 				= "sp_UpdateFactionMembers"
	params[1]["dataBase"] 				= 1
	params[1]["sort"] 					= "fID,pID,updateCode,state,position,jDate,applyMsg"
	params[1]["fID"]					= factionDBID
	params[1]["pID"] 					= playerDBID
	params[1]["updateCode"] 			= updateCode
	params[1]["state"]					= state
	params[1]["position"]				= position
	params[1]["jDate"] 					= joinDate
	params[1]["applyMsg"]				= applyMsg

	LuaDBAccess.exeSP(params,false)

end


function LuaDBAccess.updateFactionInfo( factionDBID,info,cvalue,ivalue )

	clearParams()
	
	params[1]["spName"] = "sp_UpdateFactionInfo"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "fID,info,cvalue,ivalue"
	params[1]["fID"] = factionDBID
	params[1]["info"] = info
	params[1]["cvalue"] = cvalue
	params[1]["ivalue"] = ivalue

	LuaDBAccess.exeSP(params,false)
	
end

function LuaDBAccess.updateFactionMemberInfo( factionDBID,memberDBID,info,cvalue,ivalue )
	
	clearParams()

	params[1]["spName"] = "sp_UpdateFactionMemberInfo"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "fID,mID,info,cvalue,ivalue"
	params[1]["fID"] = factionDBID
	params[1]["mID"] = memberDBID
	params[1]["info"] = info
	params[1]["cvalue"] = cvalue
	params[1]["ivalue"] = ivalue

	LuaDBAccess.exeSP(params,false)

end

function LuaDBAccess.CreateFaction( factionName,factionOwnerName)

	clearParams()

	params[1]["spName"] = "sp_CreateFaction"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "fName,rName"
	params[1]["fName"] = factionName
	params[1]["rName"] = factionOwnerName

	LuaDBAccess.exeSP(params,false)

end

function LuaDBAccess.DismissFaction( factionDBID )

	clearParams()

	params[1]["spName"] = "sp_DismissFaction"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "fID"
	params[1]["fID"] = factionDBID

	LuaDBAccess.exeSP(params,false)

end

function LuaDBAccess.DeleteApplyFactions( playerDBID )

	clearParams()

	params[1]["spName"] = "sp_DeleteApplyFactions"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "rDBID"
	params[1]["rDBID"] = playerDBID

	LuaDBAccess.exeSP(params,false)

end
--对全服的玩家的猎金场总积分进行排序,并筛选出前n名的玩家
function LuaDBAccess.orderGoldHuntActivity(orderCount, callbackFunction, callbackArgs)
	
		clearParams()
		params[1]["spName"]			= "sp_GoldHuntRank"
		params[1]["dataBase"]		= 1
		params[1]["orderCount"]		= orderCount
		params[1]["sort"]			= "orderCount"
		
		
		local operationID = LuaDBAccess.exeSP(params, false)
		local callback = {
							func = callbackFunction,
							args = callbackArgs
		}
		DB_CallbackContext[operationID] = callback
	
end

--帮派研发技能数据存储
function LuaDBAccess.updateFactionExtendSkillInfo(factionDBID,skillID,skillLevel)
	if factionDBID then
		return
	end
	clearParams()
	params[1]["spName"] = "sp_UPdateFactionExtendSkill"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "fID,sID,skillLevel,"
	params[1]["fID"] = factionDBID
	params[1]["sID"] = skillID
	params[1]["skillLevel"] = skillLevel

	LuaDBAccess.exeSP(params,false) 
end

--帮派研发技能加载
function LuaDBAccess.getFactionExtendSkillInfo(factionDBID,callbackFunction,callbackArgs)
	if not factionDBID then return end
	clearParams()
	params[1]["spName"] = "sp_LoadFactionExtendSkill"
	params[1]["dataBase"] = 1
	params[1]["sort"] = "fID"
	params[1]["fID"] = factionDBID

	local operationID 		= LuaDBAccess.exeSP(params,false)
	local callback			= {
		func = callbackFunction,
		args = callbackArgs
	}
	DB_CallbackContext[operationID] = callback
end

--帮派研发技能删除
function LuaDBAccess.deleteFactionExtendSkillInfo(factionDBID)
	clearParams()
	local param = params[1]
	param['spName']			= "sp_FactionExtendSkill"
	param["dataBase"]		= 1
	param['sort']			= "fID"
	param["fID"]			= factionDBID
	LuaDBAccess.exeSP(params,false)
end