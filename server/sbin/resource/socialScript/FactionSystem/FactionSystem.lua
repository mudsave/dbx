--[[FactionSystem:
    
    Function: Receive the event from client or other server 
    Author: Caesar
]]

require "base.base"
require "FactionSystem.FactionSysMgr"
require "entity.Faction"



UpdateFactionInfoInServer = {

    factionOwnerName = function (faction,value) faction:setFactionOwnerName(value) end,
    factionLevel = function (faction,value) faction:setFactionLevel(value) end,
    factionState = function (faction,value) faction:setFactionState(value) end,
    factionMoney = function (faction,value) faction:setFactionMoney(value) end,
    factionFame = function (faction,value) faction:setFactionFame(value) end,
    factionInform = function (faction,value) faction:setFactionInform(value) end,
    factionPurpose = function (faction,value) faction:setFactionPurpose(value) end,
    addFactionFame = function (faction,value) faction:addFactionFame(value) end,
    addFactionMoney = function (faction,value) faction:addFactionMoney(value) end,

}

UpdateFactionMemberInfoInServer = {

    memberPosition = function (faction,memberDBID,value) faction:updateMemberPosition(memberDBID,value) end,
    memberMoney    = function (faction,memberDBID,value) faction:updateMemberMoney(memberDBID,value) end

}


FactionSystem = class(EventSetDoer, Singleton)

function FactionSystem:__init(  )
     
    self._doer = {

        [FactionEvent_CB_CreateFaction]             = FactionSystem.onCreateFaction,
        [FactionEvent_BB_ShowFactionList]           = FactionSystem.onShowFactionList,
        [FactionEvent_CB_LeaderDismissFaction]      = FactionSystem.onLeaderDismissFaction,
        [FactionEvent_CB_InvitePlayerToFaction]     = FactionSystem.onInvitePlayerToFaction,
        [FactionEvent_CB_UpdateFactionMemberList]   = FactionSystem.onUpdateFactionMemberList,
        [FactionEvent_CB_UpdateFactionInfo]         = FactionSystem.onUpdateFactionInfo,
        [FactionEvent_CB_UpdateFactionMemberInfo]   = FactionSystem.onUpdateFactionMemberInfo,
        [FactionEvent_BB_UpdateFactionInfo]         = FactionSystem.onUpdateFactionInfoByGM,
        [FactionEvent_BB_UpdateFactionMemberInfo]   = FactionSystem.onUpdateFactionMemberInfoByGM,
        [FactionEvent_CB_ApplyFaction]              = FactionSystem.onApplyFaction,
        [FactionEvent_BB_ExitFaction]               = FactionSystem.onExitFactionByGM,
        [FactionEvent_CB_AdmitPlayerJoin]           = FactionSystem.onAdmitPlayerJoin,
        [FactionEvent_CB_RefusePlayerJoin]          = FactionSystem.onRefusePlayerJoin,
        [FactionEvent_CB_FireFactionMember]         = FactionSystem.onFireFactionMember,
        [FactionEvent_BB_ContributeFaction]         = FactionSystem.onShowFactionContributeWin,
        [FactionEvent_CB_ContributeFaction]         = FactionSystem.onContributeFaction,
        [FactionEvent_CB_ExtendFactionSkill]        = FactionSystem.onExtendFactionSKill,   

    }

    self._listenState = false

end

function FactionSystem:onLeaderDismissFaction( event )
    
    local params = event:getParams()
    local factionOwnerDBID = params[1]
    local factionDBID = g_encodeSysMgr.decodeDBID(params[2])
    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    local memberList = faction:getMemberList()
    local factionHandler = g_playerMgr:getPlayerByDBID(factionOwnerDBID):getHandler(HandlerDef_Faction)
    for memberDBID,memberInfo in pairs(memberList) do
        local member = g_playerMgr:getPlayerByDBID(memberDBID)
        if member then
            
            local event_DismissFaction  = Event.getEvent(FactionEvent_BC_ExitFaction)
            g_eventMgr:fireRemoteEvent(event_DismissFaction,member)

            local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,memberDBID,UpdateWorldServerDataCode.ExitFaction,factionDBID)
            g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
        end
        LuaDBAccess.updatePlayer(memberDBID,"FactionDBID",0)
    end

    LuaDBAccess.DismissFaction(factionDBID)
    LuaDBAccess.updatePlayer(factionOwnerDBID,"FactionDBID",0)
    
    --解散帮派删除帮派技能数据库
    LuaDBAccess.deleteFactionExtendSkillInfo(factionDBID)

    factionHandler:exitFaction()
    local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,factionOwnerDBID,UpdateWorldServerDataCode.ExitFaction,factionDBID)
    g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
    g_socialEntityManager:deleteFactionInFactionList(factionDBID)


end

function FactionSystem:onInvitePlayerToFaction( event )
    local params = event:getParams()
    local playerName = params[1]
    local roleDBID   = params[2]
    local factionDBID = g_encodeSysMgr.decodeDBID(params[3])
    local msg = nil
    local player = g_playerMgr:getPlayerByName(playerName)
    if player then
		local role = g_playerMgr:getPlayerByDBID(roleDBID)
		local systemSetHandler = player:getHandler(HandlerDef_SystemSet) 
		if systemSetHandler:getRefFaction() then
			local eventGroup_SystemSet = 23
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SystemSet, 6)
			g_eventMgr:fireRemoteEvent(event, role)
			return
		else
			local factionHandler = player:getHandler(HandlerDef_Faction)
			local friendHandler = player:getHandler(HandlerDef_Friend)
			local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
			if friendHandler:getScreenInfoInBlackListInfo() or friendHandler:getEnemyInfoInBlackListInfo() then
				msg = FactionMsgTextKeyTable.AlreadyInBlackList
			elseif factionHandler:getFactionDBID() > 0 then
					msg = FactionMsgTextKeyTable.AlreadyHaveFaction
				elseif FactionMaxMemberCount[faction:getFactionLevel()] == table.size(faction:getMemberList()) then
						msg = FactionMsgTextKeyTable.FactionMembersIsEnough
					else    
						msg = FactionMsgTextKeyTable.MsgSendSucceed
						local roleName = role:getName()
						local factionName = faction:getFactionName()
						local event_Inform = Event.getEvent(FriendEvent_BC_ShowInform,MsgboxParams.MsgType.OnlineMsg,MsgboxParams.MsgKind.MsgKind_FactionInvite,roleName,g_encodeSysMgr.encodeDBID(factionDBID),factionName)
						g_eventMgr:fireRemoteEvent(event_Inform,player)
			end
			local notifyParams = {msg = msg}
			local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FactionNotify,notifyParams)
			g_eventMgr:fireRemoteEvent(event_Notify,role)
		end
    end
    
end

function FactionSystem:onAdmitPlayerJoin( event )

    local params = event:getParams()
    local roleDBID = params[1]
    local factionDBID = g_encodeSysMgr.decodeDBID(params[2])
    local playerDBID = params[3]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    if player then
        local factionHandler = player:getHandler(HandlerDef_Faction)
        if factionHandler:getFactionDBID() > 0 then
            --玩家已经有帮派，返回错误信息，清除申请信息
            local notifyParams = {playerDBID = playerDBID}
            local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.PlayerIsInFaction,notifyParams)
            g_eventMgr:fireRemoteEvent(event_Notify,role)
            LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")

        else
            --判断帮派是否满员
            if faction:isFactionMemberListFull() then
                --帮派已经满员，返回错误信息，保留申请信息
                local msg = FactionMsgTextKeyTable.FactionMembersIsEnough
                local notifyParams = {msg = msg}
                local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FactionNotify,notifyParams)
                g_eventMgr:fireRemoteEvent(event_Notify,role)
                LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")

            else--批准玩家进入

                local memberMoney = factionHandler:getFactionMoney()
                local memberHistoryMoney = factionHandler:getFactionHistoryMoney()
                local factionInfo = FactionSysMgr.sendFactionInfoOnMember(factionDBID)

                faction:deleteStandByPlayerInStandByPlayerList(playerDBID)
                
                factionHandler:initializeFactionDBID(g_encodeSysMgr.decodeDBID(factionInfo.factionInfo["_factionDBID"]))
                g_socialEntityManager:updateFactionMembers(factionDBID,playerDBID,UpdateCode.Add)

                local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.JoinFaction,factionDBID)
                g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
                
                LuaDBAccess.updatePlayer(playerDBID,"FactionDBID",factionDBID)
                LuaDBAccess.DeleteApplyFactions(playerDBID)
                LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Add,2,6,time.tostring(os.time()),"")
                
                local playerOnline = g_playerMgr:getPlayerByDBID(playerDBID)
                local memberOnlineJudge = 0
                if playerOnline then
                    local notifyParams = {msg = "",factionDBID = factionDBID,factionName = faction:getFactionName()}
                    local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.CancelFactionApply,notifyParams)
                    g_eventMgr:fireRemoteEvent(event_Notify,playerOnline)
                    memberOnlineJudge = 1
                end

                local modelInfos = {}
                modelInfos["modelID"] = player:getModelID()
                modelInfos["bodyTex"] = player:getCurBodyTex()
                modelInfos["headTex"] = player:getCurHeadTex()
                local infoTemp = 
                {
                    memberDBID = player:getDBID(),
                    memberName = player:getName(),
                    memberLevel = player:getLevel(),
                    memberSchool = player:getSchool(),
                    memberSex   = player:getSex(),
                    memberOnlineDate = player:getOnlineDate() or "0",
                    memberLeaveDate = player:getOfflineDate() or "0",
                    memberMoney = factionHandler:getFactionMoney(),
                    memberHistoryMoney = factionHandler:getFactionHistoryMoney(),
                    memberLastWeekFactionMoney = factionHandler:getLastWeekContribute(),
                    memberIntradayFactionContribute = factionHandler:getFactionContributeIntraday(),
                    memberPosition = 6,
                    memberJoinDate = time.tostring(os.time()),
                    memberOnlineJudge = memberOnlineJudge,
                    modelInfos = modelInfos
                }
                table.insert( factionInfo.memberInfo,infoTemp)
                local memberList = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID):getMemberList()
                for _,memberInfo in pairs(memberList) do
                    local memberDBID = memberInfo.memberDBID
                    local member = g_playerMgr:getPlayerByDBID(memberDBID)
                    if member then
                        local event_UpdateFactionMemberList = Event.getEvent(FactionEvent_BC_UpdateFactionMemberList,factionInfo)
                        g_eventMgr:fireRemoteEvent(event_UpdateFactionMemberList,member)
                    end
                end

                local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Delete,playerDBID)
                g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,role)

				-- 添加加入帮派成功标记（用于指引加入帮派的行为）
				g_eventMgr:fireWorldsEvent(
					Event.getEvent(
						TaskEvent_BS_GuideJoinFaction,true,playerDBID	-- palyerDBID为申请入帮的玩家
					),CurWorldID
				)
            end
        end
    else
        print("玩家未上过线")
    end

end

function FactionSystem:onRefusePlayerJoin( event )

    local params = event:getParams()
    local roleDBID = params[1]
    local factionDBID =  g_encodeSysMgr.decodeDBID(params[2])
    local playerDBID = params[3]
    local role = g_playerMgr:getPlayerByDBID(roleDBID)
    local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    if player then
        local factionHandler = player:getHandler(HandlerDef_Faction)
        if factionHandler:getFactionDBID() > 0 then

            --玩家已经有帮派，返回错误信息，清除申请信息
            local notifyParams = {playerDBID = playerDBID}
            local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.PlayerIsInFaction,notifyParams)
            g_eventMgr:fireRemoteEvent(event_Notify,role)
            LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")

        else--拒绝玩家，发送消息到客户端，清除申请消息

            LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")
            local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Delete,playerDBID)
            g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,role)
            
            local memberList = faction:getMemberList()
            for memberDBID,memberInfo in pairs(memberList) do 
                if memberInfo.memberPosition ~= FactionPosition.Member then
                    local member = g_playerMgr:getPlayerByDBID(memberDBID)
                    if member then
                        local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Delete,playerDBID)
                        g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,member)
                    end
                end
            end


            faction:deleteStandByPlayerInStandByPlayerList(playerDBID)

            local player = g_playerMgr:getPlayerByDBID(playerDBID)
            if player then
                local notifyParams = {factionDBID = factionDBID,factionName = faction:getFactionName()}
                local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.CancelFactionApply,notifyParams)
                g_eventMgr:fireRemoteEvent(event_Notify,player)
            end

        end
    else
        print("玩家未上过线")
    end

end

function FactionSystem:onFireFactionMember( event )

    local params = event:getParams()
    local factionDBID = g_encodeSysMgr.decodeDBID(params[1])
    local playerDBID = params[2]

    local player = g_playerMgr:getLoadedPlayerByDBID(playerDBID)
    if player then

        local factionHandler = player:getHandler(HandlerDef_Faction)
        factionHandler:exitFaction()

        g_socialEntityManager:updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete)

        local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.ExitFaction)
        g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)

        --更新数据库
        LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")
        LuaDBAccess.updatePlayer(playerDBID,"FactionDBID",0)

        local factionInfo = FactionSysMgr.sendFactionInfoOnMember(factionDBID)
        local memberList = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID):getMemberList()
        for _,memberInfo in pairs(memberList) do
            local memberDBID = memberInfo.memberDBID
            local member = g_playerMgr:getPlayerByDBID(memberDBID)
            if member then
                local event_UpdateFactionMemberList = Event.getEvent(FactionEvent_BC_UpdateFactionMemberList,factionInfo)
                g_eventMgr:fireRemoteEvent(event_UpdateFactionMemberList,member)
            end
        end

        local playerOnline = g_playerMgr:getPlayerByDBID(playerDBID)
        if playerOnline then
            local event_fireFactionMember = Event.getEvent(FactionEvent_BC_ExitFaction)
            g_eventMgr:fireRemoteEvent(event_fireFactionMember,playerOnline)
        end
    end


end

function FactionSystem:onUpdateFactionMemberList( event )
    
    local params = event:getParams()
    local playerDBID = params[1]
    local factionDBID = g_encodeSysMgr.decodeDBID(params[2])
    local updateCode = params[3]
    local memberMoney = params[4]
    local memberHistoryMoney = params[5]
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    local factionHandler = player:getHandler(HandlerDef_Faction)

    if updateCode == UpdateCode.Add then
        
        local factionInfo = FactionSysMgr.sendFactionInfoOnMember(factionDBID)

        factionHandler:initializeFactionDBID(factionInfo["factionDBID"])
        g_socialEntityManager:updateFactionMembers(factionDBID,playerDBID,UpdateCode.Add)
        local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.JoinFaction,factionDBID)
        g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
        
        LuaDBAccess.updatePlayer(playerDBID,"FactionDBID",factionDBID)
        LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Add,2,6,time.tostring(os.time()),"")

        local modelInfos = {}
        modelInfos["modelID"] = player:getModelID()
        modelInfos["bodyTex"] = player:getCurBodyTex()
        modelInfos["headTex"] = player:getCurHeadTex()
        local infoTemp = 
        {
            memberDBID = player:getDBID(),
            memberName = player:getName(),
            memberLevel = player:getLevel(),
            memberSchool = player:getSchool(),
            memberSex   = player:getSex(),
            memberOnlineDate = player:getOnlineDate() or "0",
            memberLeaveDate = player:getOfflineDate() or "0",
            memberMoney = factionHandler:getFactionMoney(),
            memberHistoryMoney = player:getHandler(HandlerDef_Faction):getFactionHistoryMoney(),
            memberLastWeekFactionMoney = player:getHandler(HandlerDef_Faction):getLastWeekContribute(),
            memberIntradayFactionContribute = player:getHandler(HandlerDef_Faction):getFactionContributeIntraday(),
            memberPosition = 6,
            memberJoinDate = time.tostring(os.time()),
            memberOnlineJudge = 1,
            modelInfos = modelInfos
        }
        table.insert( factionInfo.memberInfo,infoTemp)
        local memberList = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID):getMemberList()
        for _,memberInfo in pairs(memberList) do
            local memberDBID = memberInfo.memberDBID
            local member = g_playerMgr:getPlayerByDBID(memberDBID)
            if member then
                local event_UpdateFactionMemberList = Event.getEvent(FactionEvent_BC_UpdateFactionMemberList,factionInfo)
                g_eventMgr:fireRemoteEvent(event_UpdateFactionMemberList,member)
            end
        end

    elseif updateCode == UpdateCode.Delete then

        factionHandler:exitFaction()
        local event_ExitFaction  = Event.getEvent(FactionEvent_BC_ExitFaction)
        g_eventMgr:fireRemoteEvent(event_ExitFaction,player)
        g_socialEntityManager:updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete)
        local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.ExitFaction)
        g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
        --更新数据库
        LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")
        LuaDBAccess.updatePlayer(playerDBID,"FactionDBID",0)

        local factionInfo = FactionSysMgr.sendFactionInfoOnMember(factionDBID)
        local memberList = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID):getMemberList()
        for _,memberInfo in pairs(memberList) do
            local memberDBID = memberInfo.memberDBID
            local member = g_playerMgr:getPlayerByDBID(memberDBID)
            if member then
                local event_UpdateFactionMemberList = Event.getEvent(FactionEvent_BC_UpdateFactionMemberList,factionInfo)
                g_eventMgr:fireRemoteEvent(event_UpdateFactionMemberList,member)
            end
        end

    end


end


function FactionSystem:onUpdateFactionInfo( event )

    local params = event:getParams()
    local factionDBID = g_encodeSysMgr.decodeDBID(params[1])
    local infoCount = params[2]
    local factionInfoList = {}
    for index = 1,infoCount do
        table.insert( factionInfoList,params[2 + index] )
    end

    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    for key,info in pairs(factionInfoList) do
        UpdateFactionInfoInServer[info.name](faction,info.value)
    end

    for key,table in pairs(factionInfoList) do
        if type(table.value) == "number" then
            LuaDBAccess.updateFactionInfo(factionDBID,table.name,"",table.value)
        else
            LuaDBAccess.updateFactionInfo(factionDBID,table.name,table.value,0)
        end
    end

    local memberList = faction:getMemberList()
    for _,memberInfo in pairs(memberList) do
        local member = g_playerMgr:getPlayerByDBID(memberInfo.memberDBID)
        if member then
            local event_UpdateFactionInfo = Event.getEvent(FactionEvent_BC_UpdateFactionInfo,factionInfoList)
            g_eventMgr:fireRemoteEvent(event_UpdateFactionInfo,member)
        end
    end

end

function FactionSystem:onUpdateFactionMemberInfo( event )
    
    local params = event:getParams()
    local factionDBID = g_encodeSysMgr.decodeDBID(params[1])
    local memberDBID = params[2]
    local infoCount = params[3]

    local memberInfoList = {}
    for var = 1,infoCount do 
        table.insert( memberInfoList,params[var + 3] )
    end

    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    for _,table in pairs(memberInfoList) do
        UpdateFactionMemberInfoInServer[table.name](faction,memberDBID,table.value)
    end
    
    for _,table in pairs(memberInfoList) do
        if type(table.value) == "number" then
            LuaDBAccess.updateFactionMemberInfo(factionDBID,memberDBID,table.name,"",table.value)
        else
            LuaDBAccess.updateFactionMemberInfo(factionDBID,memberDBID,table.name,table.value,0)
        end
    end

    local memberList = faction:getMemberList()
    for _,memberInfo in pairs(memberList) do
        local member = g_playerMgr:getPlayerByDBID(memberInfo.memberDBID)
        if member then
            local event_UpdateFactionInfo = Event.getEvent(FactionEvent_BC_UpdateFactionMemberInfo,memberDBID,memberInfoList)
            g_eventMgr:fireRemoteEvent(event_UpdateFactionInfo,member)
        end
    end

end

function FactionSystem:onShowFactionList( event )
    
    local params = event:getParams()
    local playerDBID = params[1]

    local allFactionList = g_socialEntityManager:getFactionList()
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    local factionHandler = player:getHandler(HandlerDef_Faction)
    local factionListShowInfos = {}
    for _,faction in pairs(allFactionList) do

        local factionDBID = faction:getFactionDBID() 
        local factionName = faction:getFactionName()
        local factionOwnerName = faction:getFactionOwnerName()
        local factionInform = faction:getFactionInform()
        local factionMemberCount = table.size(faction:getMemberList())
        local factionMemberMaxCount = FactionMaxMemberCount[faction:getFactionLevel()]

        local tempFactionListShowInfos = 
        {
            factionDBID = factionDBID,
            factionName = factionName,
            factionOwnerName = factionOwnerName,
            factionState = "",
            factionInform = factionInform,
            factionMemberCount = factionMemberCount,
            factionMemberMaxCount = factionMemberMaxCount,
        }
        table.insert( factionListShowInfos,tempFactionListShowInfos )

    end

    local event_ShowFactionList = Event.getEvent(FactionEvent_BC_ShowFactionList,factionListShowInfos)
    g_eventMgr:fireRemoteEvent(event_ShowFactionList,player)

end

function FactionSystem:onCreateFaction( event )
    
    local params = event:getParams()
    local factionOwnerDBID = params[1]
    local factionName = params[2]
    local player = g_playerMgr:getPlayerByDBID(factionOwnerDBID)
    local factionOwnerName = player:getName()
    if g_socialEntityManager:getFactionInFactionListByName(factionName) then
        local msg = FactionMsgTextKeyTable.FactionNameExist
        local notifyParams = {msg = msg}
        local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FactionNotify,notifyParams)
        g_eventMgr:fireRemoteEvent(event_Notify,player)
    else
		-- 创建帮派成功（用于指引加入帮派的行为）
		g_eventMgr:fireWorldsEvent(
			Event.getEvent(
				TaskEvent_BS_GuideJoinFaction,true,factionOwnerDBID	
			),CurWorldID
		)
        LuaDBAccess.CreateFaction(factionName,factionOwnerName)
        LuaDBAccess.getFactionInfo(0,factionName,FactionSystem.onLoadFactionInfo,factionOwnerDBID)
    end

end

function FactionSystem.onLoadFactionInfo( recordList,factionOwnerDBID )

    local factionInfo = recordList[1][1]
    if factionInfo then
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

        local player = g_playerMgr:getPlayerByDBID(factionOwnerDBID)
        local factionHandler = player:getHandler(HandlerDef_Faction)
        factionHandler:initializeFactionDBID(factionInfo["factionDBID"])
        local memberMoney = factionHandler:getFactionMoney()
        local memberHistoryMoney = factionHandler:getFactionHistoryMoney()
        faction:addMemberToMemberList(factionOwnerDBID)
        faction:updateMemberMoney(factionOwnerDBID,memberMoney)
        faction:updateMemberHistoryMoney(factionOwnerDBID,memberHistoryMoney)
        faction:updateMemberPosition(factionOwnerDBID,FactionPosition.Leader)
        faction:updateMemberJoinDate(factionOwnerDBID,time.tostring(os.time()))

        LuaDBAccess.updateFactionMembers(factionInfo["factionDBID"],factionOwnerDBID,UpdateCode.Create,2,1,time.tostring(os.time()),"")
        LuaDBAccess.updatePlayer(factionOwnerDBID,"FactionDBID",factionInfo["factionDBID"])

        local info,memberList = FactionSysMgr.sendFactionInfoOnLeader(factionInfo["factionDBID"])
        local event = Event.getEvent(FactionEvent_BC_SendFactionInfoToClient,info)
        g_eventMgr:fireRemoteEvent(event,player)
        
        local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,factionOwnerDBID,UpdateWorldServerDataCode.CreateFaction,factionInfo["factionDBID"])
        g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)

    else    
        print("没得到数据")
    end

end

function FactionSystem:onApplyFaction( event )

    local params = event:getParams()
    local playerDBID = params[1]
    local factionDBID = params[2]
    local msg = params[3]
    local state = params[4]

    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
    if state == FactionApplyState.Apply then
        if faction then
            local applyMsg = msg 
            local joinDate = time.tostring(os.time())
            local playerInfo = {
                roleDBID = playerDBID,
                applyMsg = applyMsg,
                joinDate = joinDate
            }
            faction:addStandByPlayerToStandByPlayerList(playerInfo)
            local factionOwnerName = faction:getFactionOwnerName()
            local factionOwner = g_playerMgr:getPlayerByName(factionOwnerName)
            --群主在线，更新群主的申请面板
            if factionOwner then
                local player = g_playerMgr:getPlayerByDBID(playerDBID)
                local info = {}
                local standByPlayerInfo = faction:getStandByPlayerInStandByPlayerList(playerDBID)
                standByPlayerInfo.playerName = player:getName()
                standByPlayerInfo.playerLevel = player:getLevel()
                standByPlayerInfo.playerSchool = player:getSchool()
                standByPlayerInfo.playerSex = player:getSex()
                print("standByPlayerInfo.playerSex>>>",player:getSex())
                info = {playerDBID = playerDBID,standByPlayerInfo = standByPlayerInfo }
                local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Add,info)
                g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,factionOwner)
            end

            local associateLeaderDBID = faction:getFactionAssociateLeaderDBID()
            local associateLeader = g_playerMgr:getPlayerByDBID(associateLeaderDBID)
            if associateLeader then
                local player = g_playerMgr:getPlayerByDBID(playerDBID)
                local info = {}
                local standByPlayerInfo = faction:getStandByPlayerInStandByPlayerList(playerDBID)
                standByPlayerInfo.playerName = player:getName()
                standByPlayerInfo.playerLevel = player:getLevel()
                standByPlayerInfo.playerSchool = player:getSchool()
                standByPlayerInfo.playerSex = player:getSex()
                info = {playerDBID = playerDBID,standByPlayerInfo = standByPlayerInfo }
                local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Add,info)
                g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,associateLeader)
            end
            LuaDBAccess.ApplyFaction(factionDBID,playerDBID,state,applyMsg,joinDate)

        end
    elseif state == FactionApplyState.Cancel then
    
        local factionOwnerName = faction:getFactionOwnerName()
        local factionOwner = g_playerMgr:getPlayerByName(factionOwnerName)
        local associateLeaderDBID = faction:getFactionAssociateLeaderDBID()
        local associateLeader = g_playerMgr:getPlayerByDBID(associateLeaderDBID)
        --群主在线，更新群主的申请面板
        if factionOwner then
            local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Delete,playerDBID)
            g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,factionOwner)
        end
        if associateLeader then
            local event_UpdateStandByPlayerList = Event.getEvent(FactionEvent_BC_UpdateStandByPlayerList,UpdateCode.Delete,playerDBID)
            g_eventMgr:fireRemoteEvent(event_UpdateStandByPlayerList,associateLeader)
        end
        faction:deleteStandByPlayerInStandByPlayerList(playerDBID)
        LuaDBAccess.ApplyFaction(factionDBID,playerDBID,state,"","")

    end

end

function FactionSystem:onUpdateFactionMemberInfoByGM( event )

    local params = event:getParams()
    local updateInfo = params[1]
    local playerDBID = params[2]
    local updateValue = params[3]
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    if player then
        local factionHandler = player:getHandler(HandlerDef_Faction)
        local factionDBID = factionHandler:getFactionDBID()
        if factionDBID then
            local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
            UpdateFactionMemberInfoInServer[updateInfo](faction,playerDBID,updateValue)
            if type(updateValue) == "number" then
                LuaDBAccess.updateFactionMemberInfo(factionDBID,playerDBID,updateInfo,"",updateValue)
            else
                LuaDBAccess.updateFactionMemberInfo(factionDBID,playerDBID,updateInfo,updateValue,0)
            end
            local memberList = faction:getMemberList()
            for _,memberInfo in pairs(memberList) do
                local member = g_playerMgr:getPlayerByDBID(memberInfo.memberDBID)
                if member then
                    local memberInfoList = {{name = updateInfo,value = updateValue}}
                    local event_UpdateFactionInfo = Event.getEvent(FactionEvent_BC_UpdateFactionMemberInfo,playerDBID,memberInfoList)
                    g_eventMgr:fireRemoteEvent(event_UpdateFactionInfo,member)
                end
            end
        end
    end
    
end

function FactionSystem:onUpdateFactionInfoByGM( event )

    local params = event:getParams()
    local updateInfo = params[1]
    local playerDBID = params[2]
    local updateValue = params[3]
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    if player then
        local factionHandler = player:getHandler(HandlerDef_Faction)
        local factionDBID = factionHandler:getFactionDBID()
        if factionDBID then
            local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
            UpdateFactionInfoInServer[updateInfo](faction,updateValue)
             if type(updateValue) == "number" then
                LuaDBAccess.updateFactionInfo(factionDBID,updateInfo,"",updateValue)
            else
                LuaDBAccess.updateFactionInfo(factionDBID,updateInfo,updateValue,0)
            end
            local memberList = faction:getMemberList()
            for _,memberInfo in pairs(memberList) do
                local member = g_playerMgr:getPlayerByDBID(memberInfo.memberDBID)
                if member then
                    local factionInfoList = {{name = updateInfo,value = updateValue}}
                    local event_UpdateFactionInfo = Event.getEvent(FactionEvent_BC_UpdateFactionInfo,factionInfoList)
                    g_eventMgr:fireRemoteEvent(event_UpdateFactionInfo,member)
                end
            end
        end
    end
    
end

function FactionSystem:onExitFactionByGM( event )
    
    local params =event:getParams()
    local playerDBID = params[1]
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    if player then
        local factionHandler = player:getHandler(HandlerDef_Faction)
        local factionDBID = factionHandler:getFactionDBID()
        local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)
        if faction then
            local factionOwnerName = faction:getFactionOwnerName()
            if player:getName() == factionOwnerName then
                local memberList = faction:getMemberList()
                for memberDBID,memberInfo in pairs(memberList) do
                    local member = g_playerMgr:getPlayerByDBID(memberDBID)
                    if member then
                        local event_DismissFaction  = Event.getEvent(FactionEvent_BC_ExitFaction)
                        g_eventMgr:fireRemoteEvent(event_DismissFaction,member)
                        local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,memberDBID,UpdateWorldServerDataCode.ExitFaction,factionDBID)
                        g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
                    end
                    
                    LuaDBAccess.updatePlayer(memberDBID,"FactionDBID",0)
                end

                LuaDBAccess.DismissFaction(factionDBID)
                LuaDBAccess.updatePlayer(playerDBID,"FactionDBID",0)

                factionHandler:exitFaction()
                local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.ExitFaction,factionDBID)
                g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
                g_socialEntityManager:deleteFactionInFactionList(factionDBID)

            else
                factionHandler:exitFaction()
                g_socialEntityManager:updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete)
                local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.ExitFaction)
                g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)
                --更新数据库
                LuaDBAccess.updateFactionMembers(factionDBID,playerDBID,UpdateCode.Delete,0,0,"","")
                LuaDBAccess.updatePlayer(playerDBID,"FactionDBID",0)

                local factionInfo = FactionSysMgr.sendFactionInfoOnMember(factionDBID)
                local memberList = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID):getMemberList()
                for _,memberInfo in pairs(memberList) do
                    local memberDBID = memberInfo.memberDBID
                    local member = g_playerMgr:getPlayerByDBID(memberDBID)
                    if member then
                        local event_UpdateFactionMemberList = Event.getEvent(FactionEvent_BC_UpdateFactionMemberList,factionInfo)
                        g_eventMgr:fireRemoteEvent(event_UpdateFactionMemberList,member)
                    end
                end
            end
        end

    end

end

function FactionSystem:onShowFactionContributeWin( event )

    local params = event:getParams()
    local playerDBID = params[1]
    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    local event_ContributeFaction = Event.getEvent(FactionEvent_BC_ContributeFaction)
    g_eventMgr:fireRemoteEvent(event_ContributeFaction,player)

end

function FactionSystem:onContributeFaction( event )

    local params = event:getParams()
    local playerDBID = params[1]
    local factionDBID = g_encodeSysMgr.decodeDBID(params[2])
    local moneyCount = params[3]
    local factionContribute = (moneyCount/10000)*10

    local event_UpdateWorldServerData = Event.getEvent(FactionEvent_BB_UpdateWorldServerData,playerDBID,UpdateWorldServerDataCode.ContributeFaction,moneyCount)
    g_eventMgr:fireWorldsEvent(event_UpdateWorldServerData,CurWorldID)

    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    local factionHandler = player:getHandler(HandlerDef_Faction)
    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)

    if factionHandler then
        factionHandler:addFactionContributeIntraday(factionContribute)
    end

    faction:addMemberMoneyInListByDBID(playerDBID,factionContribute)
    faction:addFactionMoney(moneyCount)

    local memberList = faction:getMemberList()
    for memberDBID,memberInfo in pairs(memberList) do
        local member = g_playerMgr:getPlayerByDBID(memberDBID)
        if member then
            local notifyParams = {factionMoney = factionContribute,memberDBID = playerDBID,playerName = player:getName(),moneyCount = moneyCount}
            local event_Notify = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.ContributeFaction,notifyParams)
            g_eventMgr:fireRemoteEvent(event_Notify,member)
        end
    end

end

--帮主研发技能
function FactionSystem.onExtendFactionSKill(event)
    local params = event:getParams()
    local playerDBID = params[1]
    local skillID = params[2]
    local costMoney = params[3]

    local player = g_playerMgr:getPlayerByDBID(playerDBID)
    local playerName = player:getName()

    local factionHandler = player:getHandler(HandlerDef_Faction)
    local factionDBID = factionHandler:getFactionDBID()
    local faction = g_socialEntityManager:getFactionInFactionListByDBID(factionDBID)

    --技能等级提升
    local isUpdate = faction:skillLvlUp(skillID,costMoney,playerName)    
    if not isUpdate then return end
    --技能信息更新，执行操作
    --更新数据库
    local extendSkill = faction:getExtendSkillList()
    local level = extendSkill[skillID]
    LuaDBAccess.updateFactionExtendSkillInfo(factionDBID,skillID,level)
    
    --向在线帮众发送技能数据,以及帮派资金更改
    local memberList = factionHandler:getMemberList()
    for memberDBID,memberInfo in pairs(memberList) do
        local member = g_playerMgr:getPlayerByDBID(memberDBID)
        if  member then
            local event = Event.getEvent(FactionEvent_BC_UpdateExtendSkill,extendSkill)
            g_eventMgr:fireRemoteEvent(event,member)
            
            --通知客户端帮派资金更改
            factionInfo = {{name = factionMoney,value = faction:getFactionMoney()}}
            event = Event.getEvent(FactionEvent_BC_UpdateFactionInfo,factionInfo)
            g_eventMgr:fireRemoteEvent(event_UpdateFactionInfo,member)

        end
    end
end


function FactionSystem.getInstance()
    return FactionSystem()
end

g_eventMgr:addEventListener(FactionSystem.getInstance())