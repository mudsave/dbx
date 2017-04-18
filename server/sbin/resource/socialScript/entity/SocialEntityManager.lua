--[[SocialEntityManager:

    Function: Save and handle the data of socialServer
    Author: Caesar

]]

SocialEntityManager = class(nil,Singleton)

function SocialEntityManager:__init(  )

    self._factionList = {}  -- factionDBID = faction
    
end

function SocialEntityManager:getFactionList(  )
    return self._factionList
end

function SocialEntityManager:addFactionToFactionList( faction )

    self._factionList[faction:getFactionDBID()] = faction

end

function SocialEntityManager:getFactionInFactionListByDBID( factionDBID )
    
    return self._factionList[factionDBID]

end

function SocialEntityManager:getFactionInFactionListByName( factionName )
    
    local faction = nil
    for factionDBID,factionTemp in pairs(self._factionList) do 
        if factionTemp:getFactionName() == factionName then
            faction = factionTemp
        end
    end
    return faction

end

function SocialEntityManager:deleteFactionInFactionList( factionDBID )
    
    self._factionList[factionDBID] = nil

end

function SocialEntityManager:updateFactionMembers( factionDBID,memberDBID,updateCode )

    if updateCode == UpdateCode.Add then
        self._factionList[factionDBID]:addMemberToMemberList(memberDBID)
    elseif updateCode == UpdateCode.Delete then
        self._factionList[factionDBID]:deleteMemberInMemberList(memberDBID)
    end

end

function SocialEntityManager:updateFactionMemberMoney( factionDBID,memberDBID,money )

    self._factionList[factionDBID]:updateMemberMoney(memberDBID,money)

end

function SocialEntityManager:updateFactionMemberPosition( factionDBID,memberDBID,position )
    
    self._factionList[factionDBID]:updateMemberPosition(memberDBID,money)

end

function SocialEntityManager:updateFactionInform( factionDBID,inform )

    self._factionList[factionDBID]:setFactionInofrm(inform)

end

function SocialEntityManager:updateFactionPurpose( factionDBID,purpose )

    self._factionList[factionDBID]:setFactionPurpose(purpose)

end

function SocialEntityManager:updateFactionMoney( factionDBID,money )

    self._factionList[factionDBID]:setFactionMoney(money)

end

function SocialEntityManager:updateFactionFame( factionDBID,fame )
    
    self._factionList[factionDBID]:setFactionFame(fame)

end

function SocialEntityManager:updateFactionState( factionDBID,state )
   
    self._factionList[factionDBID]:setFactionState(state)

end

function SocialEntityManager:updateFactionLevel( factionDBID,level)

    self._factionList[factionDBID]:setFactionLevel(level)

end


function SocialEntityManager:__release()

    self._factionList = nil

end

function SocialEntityManager.getInstance()
    return SocialEntityManager()
end