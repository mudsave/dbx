--[[FactionSysMgr

    Function: Initialize the data of the faction
    Author: Caesar

]]

require "base.base"
require "entity.Faction"

FactionSysMgr = class(nil,Singleton)

local FactionDataSend = nil
local DealMemberCount  = 0

function FactionSysMgr:__init()

end

function FactionSysMgr.loadData(roleDBID)

    if not AlreadyLoadData.FactionData then
        --没有帮派信息，首先载入全部的帮派信息
        LuaDBAccess.getAllFactionInfos(roleDBID,FactionSysMgr.onGetAllFactionInfos,roleDBID)
    else
        LuaDBAccess.getRoleFactionInfo(roleDBID,FactionSysMgr.onLoadData,roleDBID)
    end

end

function FactionSysMgr.onGetAllFactionInfos(dataList,roleDBID )

    if dataList and table.size(dataList[1]) > 0 then

        for _,factionInfo in pairs(dataList[1]) do 

            local faction = Faction()
            faction:setFactionDBID(factionInfo["factionDBID"])
            faction:setFactionOwnerName(factionInfo["factionOwnerName"])
            faction:setFactionName(factionInfo["factionName"])
            faction:setFactionLevel(factionInfo["factionLevel"])
            faction:setFactionState(factionInfo["factionState"])
            faction:setFactionMoney(factionInfo["factionMoney"])
            faction:setFactionFame(factionInfo["factionFame"])
            faction:setFactionInform(factionInfo["factionInform"])
            faction:setFactionPurpose(factionInfo["factionPurpose"])
            g_socialEntityManager:addFactionToFactionList(faction)

            LuaDBAccess.getFactionMembers(factionInfo["factionDBID"],FactionSysMgr.onLoadFactionMembers,roleDBID)
            LuaDBAccess.getFactionExtendSkillInfo(
                factionInfo["factionDBID"],FactionSysMgr.onGetExtendSkillInfo,factionInfo["factionDBID"]
                )
        end

    else
        LuaDBAccess.getRoleFactionInfo(roleDBID,FactionSysMgr.onLoadData,roleDBID)
    end

end

function FactionSysMgr.onLoadFactionMembers( dataList,roleDBID )

    local faction = nil
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    if dataList and table.size(dataList[1]) > 0 then
        local memberList = dataList[1]
        local factionDBID = memberList[1]["factionDBID"]
        faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
        DealMemberCount = table.size(memberList) + DealMemberCount
        for _,memberInfo in pairs(memberList) do
            local memberDBID = memberInfo["roleDBID"]
            if memberInfo["state"] == 1 then
                faction:addStandByPlayerToStandByPlayerList(memberInfo)
            elseif memberInfo["state"] == 2 then
                faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
                faction:addMemberToMemberList(memberDBID)
                faction:updateMemberPosition(memberDBID,memberInfo["rolePosition"])
                faction:updateMemberJoinDate(memberDBID,memberInfo["joinDate"])
            end
            local memberInfoTemp = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
            --初始化成员信息
            if not memberInfoTemp  then
                LuaDBAccess.getPlayerInfo(memberDBID,"",FactionSysMgr.onGetMemberInfo,roleDBID)
            else
                if memberDBID == roleDBID then
                    LuaDBAccess.getPlayerInfo(memberDBID,"",FactionSysMgr.onGetRoleInfo,roleDBID)
                else
                    DealMemberCount = DealMemberCount -1
                    if DealMemberCount == 0 then
                        AlreadyLoadData.FactionData = true
                        LuaDBAccess.getRoleFactionInfo(roleDBID,FactionSysMgr.onLoadData,roleDBID)
                    end
                end
            end
        end
    end
    
end

--载入帮派技能信息
function FactionSysMgr.onGetExtendSkillInfo( dataList,factionDBID)
   local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
   if not faction then print("不存在帮派") return end
   if dataList and table.size(dataList[1]) > 0 then
        for _, skillInfo in pairs(dataList[1]) do
            local skillID = skillInfo["ExtendID"]
            local skillLevel = skillInfo["skillLevel"]
            faction:setExtendSKillList(skillID,skillLevel)
        end
   end 
end

function FactionSysMgr.onGetRoleInfo( dataList,roleDBID )

    if table.size(dataList[1]) == 1 then
        local playerSocialServerData = dataList[2][1]
        local faction = g_socialEntityManager:getFactionInFactionListByDBID(playerSocialServerData.factionDBID)
        if faction then
            faction:updateMemberMoney(roleDBID,playerSocialServerData.factionMoney)
            faction:updateMemberHistoryMoney(roleDBID,playerSocialServerData.factionHistoryMoney)
        end
        DealMemberCount = DealMemberCount -1
    else
        DealMemberCount = DealMemberCount -1
        print("从帮派中读取玩家信息失败，请检查玩家是否存在")
    end
    if DealMemberCount == 0 then
        AlreadyLoadData.FactionData = true
        LuaDBAccess.getRoleFactionInfo(roleDBID,FactionSysMgr.onLoadData,roleDBID)
    end
   
end


function FactionSysMgr.onGetMemberInfo( dataList,roleDBID )

    if table.size(dataList[1]) == 1 then
        local playerInfo = dataList[1][1]
        local playerSocialServerData = dataList[2][1]
        local player = Player()
        player:setDBID(playerInfo["ID"])
        player:setName(playerInfo["name"])
        player:setLevel(playerInfo["level"])
        player:setSchool(playerInfo["school"])
        player:setSex(playerInfo["sex"])
        player:setOfflineDate(time.totime(playerSocialServerData.offlineDate))
        player:addHandler(HandlerDef_Friend,FriendHandler(player))
        player:addHandler(HandlerDef_Group,GroupHandler(player))
        player:addHandler(HandlerDef_Faction,FactionHandler(player))
        player:getHandler(HandlerDef_Faction):setFactionMoney(playerSocialServerData.factionMoney)
        player:getHandler(HandlerDef_Faction):setFactionHistoryMoney(playerSocialServerData.factionHistoryMoney)
        player:getHandler(HandlerDef_Faction):initializeFactionDBID(playerSocialServerData.factionDBID)
       	player:getHandler(HandlerDef_Faction):initializeWeekContribute(playerSocialServerData.lastWeekFactionContribute,playerSocialServerData.thisWeekFactionContribute,playerSocialServerData.offlineDate)
        
        g_playerMgr:addLoadedPlayer(player)
        local faction = g_socialEntityManager:getFactionInFactionListByDBID(playerSocialServerData.factionDBID)
        if faction then
            faction:updateMemberMoney(playerInfo["ID"],playerSocialServerData.factionMoney)
            faction:updateMemberHistoryMoney(playerInfo["ID"],playerSocialServerData.factionHistoryMoney)
        end
        DealMemberCount = DealMemberCount -1
    else
        DealMemberCount = DealMemberCount -1
        print("从帮派中读取玩家信息失败，请检查玩家是否存在")
    end
    if DealMemberCount == 0 then
        AlreadyLoadData.FactionData =  true
        LuaDBAccess.getRoleFactionInfo(roleDBID,FactionSysMgr.onLoadData,roleDBID)
    end
   
end


function FactionSysMgr.onLoadData( dataList,roleDBID )
    

    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local factionHandler = role:getHandler(HandlerDef_Faction)
    if role then
        if dataList and table.size( dataList[1]) == 1 then
            local roleFactionInfo = dataList[1][1]
            local state =  roleFactionInfo["state"]
            local factionDBID = roleFactionInfo["factionDBID"]
            --如果玩家在帮派中
            if state == 2 then
                factionHandler:initializeFactionDBID(factionDBID)
                local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
                --读取帮派信息，如果没有被载入，则载入
                if not faction then
                    print("不存在帮派")
                else
                    --如果已经载入，则直接使用载入的信息初始化发送的数据info、memberList
                    local rolePosition = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID):getMemberPosition(roleDBID)
                    local info,memberList = FactionDataSend[rolePosition](factionDBID)
                    local event = Event.getEvent(FactionEvent_BC_SendFactionInfoToClient,info)
                    g_eventMgr:fireRemoteEvent(event,role)

                    --载入帮派研发技能信息，发送。
                    local extendSkill = faction:getExtendSkillList()        
                    local event = Event.getEvent(FactionEvent_BC_UpdateExtendSkill,extendSkill)
                    g_eventMgr:fireRemoteEvent(event,role)

                    local roleModelInfos = {}
                    local roleInfo = g_playerMgr:getLoadedPlayerByDBID(roleDBID)
                    roleModelInfos["modelID"] = roleInfo:getModelID()
                    roleModelInfos["bodyTex"] = roleInfo:getCurBodyTex()
                    roleModelInfos["headTex"] = roleInfo:getCurHeadTex()

                    for _,memberInfo in pairs(memberList) do
                        local member = g_playerMgr:getPlayerByDBID(memberInfo["memberDBID"])
                        if member then
                            local event_MemberOnline = Event.getEvent(FactionEvent_BC_MemberOnline,roleDBID,roleModelInfos)
                            g_eventMgr:fireRemoteEvent(event_MemberOnline,member)
                        end
                    end

                end
            --如果玩家申请帮派
            elseif state == 1 then

                local applyFactionList = {}
                table.insert( applyFactionList,factionDBID )
                local factionInfo = {applyFactionList = applyFactionList}
                local role = g_playerMgr:getPlayerByDBID(roleDBID)
                local event = Event.getEvent(FactionEvent_BC_SendFactionInfoToClient,factionInfo)
                g_eventMgr:fireRemoteEvent(event,role)

            end
            
        elseif dataList and table.size( dataList[1]) > 1 then
            

            local applyFactionList = {}
            for index,factionInfo in pairs(dataList[1]) do
                table.insert( applyFactionList,factionInfo["factionDBID"])
            end

            local factionInfo = {applyFactionList = applyFactionList}
            local role = g_playerMgr:getPlayerByDBID(roleDBID)
            local event = Event.getEvent(FactionEvent_BC_SendFactionInfoToClient,factionInfo)
            g_eventMgr:fireRemoteEvent(event,role)

        elseif dataList and table.size( dataList[1]) == 0  then
            local applyFactionList = {}
            local factionInfo = {applyFactionList = applyFactionList}
            local role = g_playerMgr:getPlayerByDBID(roleDBID)
            local event = Event.getEvent(FactionEvent_BC_SendFactionInfoToClient,factionInfo)
            g_eventMgr:fireRemoteEvent(event,role) 

        end
    else
        print("玩家不存在")
    end

end

function FactionSysMgr.sendFactionInfoOnLeader( factionDBID )
    
    local factionInfoTemp = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local info = {factionInfo = {},memberInfo = {}}
    local memberList = factionInfoTemp:getMemberList()

    info.factionInfo["_factionDBID"]         = g_encodeSysMgr.encodeDBID(factionDBID)
    info.factionInfo["_factionOwnerName"]    = factionInfoTemp["_factionOwnerName"]
    info.factionInfo["_factionName"]         = factionInfoTemp["_factionName"]
    info.factionInfo["_factionLevel"]        = factionInfoTemp["_factionLevel"]
    info.factionInfo["_factionState"]        = factionInfoTemp["_factionState"]
    info.factionInfo["_factionMoney"]        = factionInfoTemp["_factionMoney"]
    info.factionInfo["_factionFame"]         = factionInfoTemp["_factionFame"]
    info.factionInfo["_factionInform"]       = factionInfoTemp["_factionInform"]
    info.factionInfo["_factionPurpose"]      = factionInfoTemp["_factionPurpose"]
    info.factionInfo["_factionMgrMoney"]     = FactionMgrMoney[factionInfoTemp:getFactionLevel()]

    local standByPlayerList                  = factionInfoTemp:getStandByPlayerList()
    for playerDBID,standByPlayerInfo in pairs(standByPlayerList) do
        local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
        if player then
            standByPlayerInfo.playerName = player:getName()
            standByPlayerInfo.playerLevel = player:getLevel()
            standByPlayerInfo.playerSchool = player:getSchool()
            standByPlayerInfo.playerSex = player:getSex()
        end
    end
    info.standByPlayerList = standByPlayerList

    for memberDBID,memberInfoTemp in pairs(memberList) do 

        local onlineJudge = 0
        local modelInfos = {}
        local playerInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        if g_playerMgr:getPlayerByDBID(memberDBID) then
            onlineJudge = 1
            modelInfos["modelID"] = playerInfo:getModelID()
            modelInfos["bodyTex"] = playerInfo:getCurBodyTex()
            modelInfos["headTex"] = playerInfo:getCurHeadTex()
        end
        
        local infoTemp = 
        {
            memberDBID = memberDBID,
            memberName = playerInfo:getName(),
            memberLevel = playerInfo:getLevel(),
            memberSchool = playerInfo:getSchool(),
            memberSex   = playerInfo:getSex(),
            memberOnlineDate = playerInfo:getOnlineDate() or 0,
            memberLeaveDate = playerInfo:getOfflineDate() or 0,
            memberMoney =  playerInfo:getHandler(HandlerDef_Faction):getFactionMoney(),
            memberHistoryMoney = playerInfo:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = playerInfo:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = playerInfo:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = memberInfoTemp["memberPosition"],
            memberJoinDate = memberInfoTemp["joinDate"],
            memberOnlineJudge = onlineJudge,
            modelInfos = modelInfos
        }
        table.insert( info.memberInfo,infoTemp)
    end
    return info,memberList
    
    
end

function FactionSysMgr.sendFactionInfoOnAssociateLeader(factionDBID )
    
    local factionInfoTemp = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local info = {factionInfo = {},memberInfo = {}}
    local memberList = factionInfoTemp:getMemberList()

    info.factionInfo["_factionDBID"]         = g_encodeSysMgr.encodeDBID(factionDBID)
    info.factionInfo["_factionOwnerName"]    = factionInfoTemp["_factionOwnerName"]
    info.factionInfo["_factionName"]         = factionInfoTemp["_factionName"]
    info.factionInfo["_factionLevel"]        = factionInfoTemp["_factionLevel"]
    info.factionInfo["_factionState"]        = factionInfoTemp["_factionState"]
    info.factionInfo["_factionMoney"]        = factionInfoTemp["_factionMoney"]
    info.factionInfo["_factionFame"]         = factionInfoTemp["_factionFame"]
    info.factionInfo["_factionInform"]       = factionInfoTemp["_factionInform"]
    info.factionInfo["_factionPurpose"]      = factionInfoTemp["_factionPurpose"]
    info.factionInfo["_factionMgrMoney"]     = FactionMgrMoney[factionInfoTemp:getFactionLevel()]
    local standByPlayerList                  = factionInfoTemp:getStandByPlayerList()
    for playerDBID,standByPlayerInfo in pairs(standByPlayerList) do
        local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
        if player then
            standByPlayerInfo.playerName = player:getName()
            standByPlayerInfo.playerLevel = player:getLevel()
            standByPlayerInfo.playerSchool = player:getSchool()
            standByPlayerInfo.playerSex = player:getSex()
        end
    end
    info.standByPlayerList = standByPlayerList
    
    for memberDBID,memberInfoTemp in pairs(memberList) do 

        local onlineJudge = 0
        local modelInfos = {}
        local playerInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        
        if g_playerMgr:getPlayerByDBID(memberDBID) then
            onlineJudge = 1
            modelInfos["modelID"] = playerInfo:getModelID()
            modelInfos["bodyTex"] = playerInfo:getCurBodyTex()
            modelInfos["headTex"] = playerInfo:getCurHeadTex()
        end
        local infoTemp = 
        {
            memberDBID = memberDBID,
            memberName = playerInfo:getName(),
            memberLevel = playerInfo:getLevel(),
            memberSchool = playerInfo:getSchool(),
            memberSex   = playerInfo:getSex(),
            memberOnlineDate = playerInfo:getOnlineDate() or 0,
            memberLeaveDate = playerInfo:getOfflineDate() or 0,
            memberMoney =  playerInfo:getHandler(HandlerDef_Faction):getFactionMoney(),
            memberHistoryMoney = playerInfo:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = playerInfo:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = playerInfo:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = memberInfoTemp["memberPosition"],
            memberJoinDate = memberInfoTemp["joinDate"],
            memberOnlineJudge = onlineJudge,
            modelInfos = modelInfos
        }
        table.insert( info.memberInfo,infoTemp)
    end
    return info,memberList

end

function FactionSysMgr.sendFactionInfoOnElder(factionDBID )
    
    local factionInfoTemp = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local info = {factionInfo = {},memberInfo = {}}
    local memberList = factionInfoTemp:getMemberList()

    info.factionInfo["_factionDBID"]         = g_encodeSysMgr.encodeDBID(factionDBID)
    info.factionInfo["_factionOwnerName"]    = factionInfoTemp["_factionOwnerName"]
    info.factionInfo["_factionName"]         = factionInfoTemp["_factionName"]
    info.factionInfo["_factionLevel"]        = factionInfoTemp["_factionLevel"]
    info.factionInfo["_factionState"]        = factionInfoTemp["_factionState"]
    info.factionInfo["_factionMoney"]        = factionInfoTemp["_factionMoney"]
    info.factionInfo["_factionFame"]         = factionInfoTemp["_factionFame"]
    info.factionInfo["_factionInform"]       = factionInfoTemp["_factionInform"]
    info.factionInfo["_factionPurpose"]      = factionInfoTemp["_factionPurpose"]
    info.factionInfo["_factionMgrMoney"]     = FactionMgrMoney[factionInfoTemp:getFactionLevel()]
    local standByPlayerList                  = factionInfoTemp:getStandByPlayerList()
    for playerDBID,standByPlayerInfo in pairs(standByPlayerList) do
        local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
        if player then
            standByPlayerInfo.playerName = player:getName()
            standByPlayerInfo.playerLevel = player:getLevel()
            standByPlayerInfo.playerSchool = player:getSchool()
            standByPlayerInfo.playerSex = player:getSex()
        end
    end
    info.standByPlayerList = standByPlayerList
    
    for memberDBID,memberInfoTemp in pairs(memberList) do 

        local onlineJudge = 0
        local modelInfos = {}
        local playerInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        
        if g_playerMgr:getPlayerByDBID(memberDBID) then
            onlineJudge = 1
            modelInfos["modelID"] = playerInfo:getModelID()
            modelInfos["bodyTex"] = playerInfo:getCurBodyTex()
            modelInfos["headTex"] = playerInfo:getCurHeadTex()
        end
        local infoTemp = 
        {
            memberDBID = memberDBID,
            memberName = playerInfo:getName(),
            memberLevel = playerInfo:getLevel(),
            memberSchool = playerInfo:getSchool(),
            memberSex   = playerInfo:getSex(),
            memberOnlineDate = playerInfo:getOnlineDate() or 0,
            memberLeaveDate = playerInfo:getOfflineDate() or 0,
            memberMoney =  playerInfo:getHandler(HandlerDef_Faction):getFactionMoney(),
            memberHistoryMoney = playerInfo:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = playerInfo:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = playerInfo:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = memberInfoTemp["memberPosition"],
            memberJoinDate = memberInfoTemp["joinDate"],
            memberOnlineJudge = onlineJudge,
            modelInfos = modelInfos
        }
        table.insert( info.memberInfo,infoTemp)
    end
    return info,memberList

end

function FactionSysMgr.sendFactionInfoOnGuard(factionDBID )
    
    local factionInfoTemp = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local info = {factionInfo = {},memberInfo = {}}
    local memberList = factionInfoTemp:getMemberList()

    info.factionInfo["_factionDBID"]         = g_encodeSysMgr.encodeDBID(factionDBID)
    info.factionInfo["_factionOwnerName"]    = factionInfoTemp["_factionOwnerName"]
    info.factionInfo["_factionName"]         = factionInfoTemp["_factionName"]
    info.factionInfo["_factionLevel"]        = factionInfoTemp["_factionLevel"]
    info.factionInfo["_factionState"]        = factionInfoTemp["_factionState"]
    info.factionInfo["_factionMoney"]        = factionInfoTemp["_factionMoney"]
    info.factionInfo["_factionFame"]         = factionInfoTemp["_factionFame"]
    info.factionInfo["_factionInform"]       = factionInfoTemp["_factionInform"]
    info.factionInfo["_factionPurpose"]      = factionInfoTemp["_factionPurpose"]
    info.factionInfo["_factionMgrMoney"]     = FactionMgrMoney[factionInfoTemp:getFactionLevel()]
    local standByPlayerList                  = factionInfoTemp:getStandByPlayerList()
    for playerDBID,standByPlayerInfo in pairs(standByPlayerList) do
        local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
        if player then
            standByPlayerInfo.playerName = player:getName()
            standByPlayerInfo.playerLevel = player:getLevel()
            standByPlayerInfo.playerSchool = player:getSchool()
            standByPlayerInfo.playerSex = player:getSex()
        end
    end
    info.standByPlayerList = standByPlayerList
    
    for memberDBID,memberInfoTemp in pairs(memberList) do 

        local onlineJudge = 0
        local modelInfos = {}
        local playerInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        
        if g_playerMgr:getPlayerByDBID(memberDBID) then
            onlineJudge = 1
            modelInfos["modelID"] = playerInfo:getModelID()
            modelInfos["bodyTex"] = playerInfo:getCurBodyTex()
            modelInfos["headTex"] = playerInfo:getCurHeadTex()
        end
        local infoTemp = 
        {
            memberDBID = memberDBID,
            memberName = playerInfo:getName(),
            memberLevel = playerInfo:getLevel(),
            memberSchool = playerInfo:getSchool(),
            memberSex   = playerInfo:getSex(),
            memberOnlineDate = playerInfo:getOnlineDate() or 0,
            memberLeaveDate = playerInfo:getOfflineDate() or 0,
            memberMoney =  playerInfo:getHandler(HandlerDef_Faction):getFactionMoney(),
            memberHistoryMoney = playerInfo:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = playerInfo:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = playerInfo:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = memberInfoTemp["memberPosition"],
            memberJoinDate = memberInfoTemp["joinDate"],
            memberOnlineJudge = onlineJudge,
            modelInfos = modelInfos
        }
        table.insert( info.memberInfo,infoTemp)
    end
    return info,memberList

end

function FactionSysMgr.sendFactionInfoOnDirector(factionDBID )
    
    local factionInfoTemp = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local info = {factionInfo = {},memberInfo = {}}
    local memberList = factionInfoTemp:getMemberList()

    info.factionInfo["_factionDBID"]         = g_encodeSysMgr.encodeDBID(factionDBID)
    info.factionInfo["_factionOwnerName"]    = factionInfoTemp["_factionOwnerName"]
    info.factionInfo["_factionName"]         = factionInfoTemp["_factionName"]
    info.factionInfo["_factionLevel"]        = factionInfoTemp["_factionLevel"]
    info.factionInfo["_factionState"]        = factionInfoTemp["_factionState"]
    info.factionInfo["_factionMoney"]        = factionInfoTemp["_factionMoney"]
    info.factionInfo["_factionFame"]         = factionInfoTemp["_factionFame"]
    info.factionInfo["_factionInform"]       = factionInfoTemp["_factionInform"]
    info.factionInfo["_factionPurpose"]      = factionInfoTemp["_factionPurpose"]
    info.factionInfo["_factionMgrMoney"]     = FactionMgrMoney[factionInfoTemp:getFactionLevel()]
    local standByPlayerList                  = factionInfoTemp:getStandByPlayerList()
    for playerDBID,standByPlayerInfo in pairs(standByPlayerList) do
        local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
        if player then
            standByPlayerInfo.playerName = player:getName()
            standByPlayerInfo.playerLevel = player:getLevel()
            standByPlayerInfo.playerSchool = player:getSchool()
            standByPlayerInfo.playerSex = player:getSex()
        end
    end
    info.standByPlayerList = standByPlayerList
    
    for memberDBID,memberInfoTemp in pairs(memberList) do 

        local onlineJudge = 0
        local modelInfos = {}
        local playerInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        
        if g_playerMgr:getPlayerByDBID(memberDBID) then
            onlineJudge = 1
            modelInfos["modelID"] = playerInfo:getModelID()
            modelInfos["bodyTex"] = playerInfo:getCurBodyTex()
            modelInfos["headTex"] = playerInfo:getCurHeadTex()
        end
        local infoTemp = 
        {
            memberDBID = memberDBID,
            memberName = playerInfo:getName(),
            memberLevel = playerInfo:getLevel(),
            memberSchool = playerInfo:getSchool(),
            memberSex   = playerInfo:getSex(),
            memberOnlineDate = playerInfo:getOnlineDate() or 0,
            memberLeaveDate = playerInfo:getOfflineDate() or 0,
            memberMoney =  playerInfo:getHandler(HandlerDef_Faction):getFactionMoney(),
            memberHistoryMoney = playerInfo:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = playerInfo:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = playerInfo:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = memberInfoTemp["memberPosition"],
            memberJoinDate = memberInfoTemp["joinDate"],
            memberOnlineJudge = onlineJudge,
            modelInfos = modelInfos
        }
        table.insert( info.memberInfo,infoTemp)
    end
    return info,memberList

end

function FactionSysMgr.sendFactionInfoOnMember(factionDBID )

    local factionInfoTemp = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local info = {factionInfo = {},memberInfo = {}}
    local memberList = factionInfoTemp:getMemberList()

    info.factionInfo["_factionDBID"]         = g_encodeSysMgr.encodeDBID(factionDBID)
    info.factionInfo["_factionOwnerName"]    = factionInfoTemp["_factionOwnerName"]
    info.factionInfo["_factionName"]         = factionInfoTemp["_factionName"]
    info.factionInfo["_factionLevel"]        = factionInfoTemp["_factionLevel"]
    info.factionInfo["_factionState"]        = factionInfoTemp["_factionState"]
    info.factionInfo["_factionMoney"]        = factionInfoTemp["_factionMoney"]
    info.factionInfo["_factionFame"]         = factionInfoTemp["_factionFame"]
    info.factionInfo["_factionInform"]       = factionInfoTemp["_factionInform"]
    info.factionInfo["_factionPurpose"]      = factionInfoTemp["_factionPurpose"]
    info.factionInfo["_factionMgrMoney"]     = FactionMgrMoney[factionInfoTemp:getFactionLevel()]
    info.standByPlayerList = {}
    
    for memberDBID,memberInfoTemp in pairs(memberList) do 

        local onlineJudge = 0
        local modelInfos = {}
        local playerInfo = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        
        if g_playerMgr:getPlayerByDBID(memberDBID) then
            onlineJudge = 1
            modelInfos["modelID"] = playerInfo:getModelID()
            modelInfos["bodyTex"] = playerInfo:getCurBodyTex()
            modelInfos["headTex"] = playerInfo:getCurHeadTex()
        end

        local infoTemp = 
        {   
            memberDBID = memberDBID,
            memberName = playerInfo:getName(),
            memberLevel = playerInfo:getLevel(),
            memberSchool = playerInfo:getSchool(),
            memberSex   = playerInfo:getSex(),
            memberMoney =  playerInfo:getHandler(HandlerDef_Faction):getFactionMoney(),
            memberHistoryMoney = playerInfo:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = playerInfo:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = playerInfo:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = memberInfoTemp["memberPosition"],
            memberJoinDate = memberInfoTemp["joinDate"],
            memberOnlineDate = playerInfo:getOnlineDate() or 0,
            memberLeaveDate = playerInfo:getOfflineDate() or 0,
            memberOnlineJudge = onlineJudge,
            modelInfos = modelInfos
        }
        table.insert( info.memberInfo,infoTemp)
    end
    return info,memberList
end

function FactionSysMgr.getInstance()
    return FactionSysMgr()
end

FactionDataSend = {

    [FactionPosition.Leader]    = FactionSysMgr.sendFactionInfoOnLeader,
    [FactionPosition.AssociateLeader]    = FactionSysMgr.sendFactionInfoOnAssociateLeader,
    [FactionPosition.Elder]  = FactionSysMgr.sendFactionInfoOnElder,
    [FactionPosition.Guard]   = FactionSysMgr.sendFactionInfoOnGuard,
    [FactionPosition.Director]   = FactionSysMgr.sendFactionInfoOnDirector,
    [FactionPosition.Member]    = FactionSysMgr.sendFactionInfoOnMember,

}