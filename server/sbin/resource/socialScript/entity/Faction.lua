--[[Faction:

    Function: Faction entity
    Author: Caesar

]]
require "base.base"

Faction = class()

function Faction:__init()

    self._factionDBID       = 0
    self._factionOwnerName  = "" 
    self._factionName       = ""
    self._factionLevel      = 1
    self._factionState      = 1
    self._factionMoney      = 10000
    self._factionFame       = 0
    self._factionInform     = ""
    self._factionPurpose    = ""
    self._standByPlayerList = {}
    self._memberList        = {}
    self._extendSkillList   = {}

end

function Faction:__release()

    self._factionDBID       = nil
    self._factionOwnerName  = nil
    self._factionName       = nil
    self._factionLevel      = nil
    self._factionState      = nil
    self._factionMoney      = nil
    self._factionFame       = nil
    self._factionInform     = nil
    self._factionPurpose    = nil
    self._memberList        = nil
    self._standByPlayerList = nil
    self._extendSkillList   = nil
end

function Faction:getFactionDBID()

    return self._factionDBID

end

function Faction:setFactionDBID( factionDBID )

    self._factionDBID = factionDBID

end

function Faction:getFactionOwnerName(  )

    return self._factionOwnerName

end

function Faction:setFactionOwnerName( ownerName )
    
    self._factionOwnerName = ownerName

end

function Faction:getFactionAssociateLeaderDBID( )

    for memberDBID,memberInfo in pairs(self._memberList) do 
        if memberInfo.memberPosition == 2 then
            return memberDBID
        end
    end

end


function Faction:getFactionName()

    return self._factionName

end


function Faction:setFactionName( name )

    self._factionName = name 

end

function Faction:getFactionLevel()

    return self._factionLevel

end


function Faction:setFactionLevel( level )

    self._factionLevel = level

end

function Faction:getFactionState()

    return self._factionState

end


function Faction:setFactionState( state )

    self._factionState = state

end

function Faction:getFactionMoney()

    return self._factionMoney
end


function Faction:setFactionMoney( money )

    self._factionMoney = money

end

function Faction:addFactionMoney( money )
    
    self._factionMoney = money + self._factionMoney
    LuaDBAccess.updateFactionInfo(self._factionDBID,"factionMoney","",self._factionMoney)

end

function Faction:getFactionFame()

    return self._factionFame

end


function Faction:setFactionFame( fame )

    self._factionFame = fame

end

function Faction:addFactionFame( fame )

    self._factionFame = fame + self._factionFame
    LuaDBAccess.updateFactionInfo(self._factionDBID,"factionFame","",self._factionFame)

end

function Faction:getFactionInform()

    return self._factionInform

end


function Faction:setFactionInform( inform )

    self._factionInform = inform

end

function Faction:getFactionPurpose()

    return self._factionPurpose

end


function Faction:setFactionPurpose( purpose )

    self._factionPurpose = purpose

end

function Faction:addMemberToMemberList( memberDBID )

    self._memberList[memberDBID] = {memberDBID = memberDBID,memberMoney = 0,memberHistoryMoney = 0, memberPosition = FactionPosition.Member,joinDate = 0}
    
end

function Faction:deleteMemberInMemberList( memberDBID )

    
    self._memberList[memberDBID] = nil


end

function Faction:getMemberInMemberList( memberDBID )
    
    return self._memberList[memberDBID]

end

function Faction:getMemberList(  )
    
    return self._memberList

end

function Faction:getMemberMoney( memberDBID )
    
    return self._memberList[memberDBID]["memberMoney"]

end

function Faction:getMemberHistoryMoney( memberDBID )
    
    return self._memberList[memberDBID]["memberHistoryMoney"]

end

function Faction:getMemberPosition( memberDBID )
    
    return self._memberList[memberDBID]["memberPosition"]

end

function Faction:getMemberJoinDate( memberDBID )

    return self._memberList[memberDBID]["joinDate"]
    
end

function Faction:updateMemberMoney( memberDBID,money )

    g_playerMgr:getLoadedPlayerByDBID(memberDBID):getHandler(HandlerDef_Faction):setFactionMoney(money)
    self._memberList[memberDBID]["memberMoney"] = money
    LuaDBAccess.updateFactionMemberInfo(self._factionDBID,memberDBID,"memberMoney","",self._memberList[memberDBID]["memberMoney"])

end

function Faction:addMemberMoneyInListByDBID( memberDBID,money)

    g_playerMgr:getLoadedPlayerByDBID(memberDBID):getHandler(HandlerDef_Faction):addFactionContribute(money)
    
    self._memberList[memberDBID]["memberMoney"] = money + self._memberList[memberDBID]["memberMoney"]
    self:addMemberHistoryMoneyInListByDBID(memberDBID,money)
    LuaDBAccess.updateFactionMemberInfo(self._factionDBID,memberDBID,"memberMoney","",self._memberList[memberDBID]["memberMoney"])

end

function Faction:updateMemberHistoryMoney( memberDBID,historyMoney )

    self._memberList[memberDBID]["memberHistoryMoney"] = historyMoney
    LuaDBAccess.updateFactionMemberInfo(self._factionDBID,memberDBID,"memberHistoryMoney","",historyMoney)

end

function Faction:addMemberHistoryMoneyInListByDBID( memberDBID,money )

    local historyMoney = self._memberList[memberDBID]["memberHistoryMoney"] + money
    self:updateMemberHistoryMoney(memberDBID,historyMoney)

end

function Faction:updateMemberPosition( memberDBID,position )
    
    if position == 1 then
        local player = g_playerMgr:getLoadedPlayerByDBID(memberDBID)
        if player then
            local name = player:getName()
            self._factionOwnerName = name
            LuaDBAccess.updateFactionInfo(self._factionDBID,"factionOwnerName",self._factionOwnerName,0)
        end
    end

    self._memberList[memberDBID]["memberPosition"] = position

end

function Faction:updateMemberJoinDate( memberDBID,joinDate )
    
    self._memberList[memberDBID]["joinDate"] = joinDate

end 

function Faction:addStandByPlayerToStandByPlayerList( playerInfo )

    local tempPlayerInfo = {
        applyMsg = playerInfo.applyMsg,
        joinDate = playerInfo.joinDate
    }

    self._standByPlayerList[playerInfo.roleDBID] = tempPlayerInfo

end

function Faction:deleteStandByPlayerInStandByPlayerList( playerDBID )
    
    self._standByPlayerList[playerDBID] = nil

end

function Faction:getStandByPlayerInStandByPlayerList( playerDBID )

    return self._standByPlayerList[playerDBID]
    
end

function Faction:getStandByPlayerList(  )
    
    return self._standByPlayerList

end

function Faction:isFactionMemberListFull(  )

    if table.size(self._memberList) < FactionMaxMemberCount[self._factionLevel] then
        return false
    else
        return true
    end

end

--设置研发技能
function Faction:setExtendSkillList(skillID,skillLevel)
    self._extendSkillList[skillID] = skillLevel
end

--获取研发技能表
function Faction:getExtendSkillList()
    return self._extendSkillList
end

--研发技能升级
function Faction:skillLvlUp(skillID,costMoney,playerName)
    if playerName ~= self._factionOwnerName then 
        print("not factionOwner")
        return false
    end
    if self._factionMoney < costMoney then 
        print("factionMoney not enogh")
        return false 
    end
    local curSkillLvl = self._extendSkillList[skillID]
    self._extendSkillList[skillID] = curSkillLvl + 1
    self:addFactionMoney(-costMoney)
    return true
end