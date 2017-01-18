--[[FactionHandler:

    Function: Save the data or function for Faction
    Author: Caesar

]]

FactionHandler = class()

function FactionHandler:__init(entity)

    self._entity                    = entity
    self._factionDBID               = 0
    self._factionMoney              = 0
    self._factionHistoryMoney       = 0
    self._lastWeekContribute        = 0
    self._thisWeekContribute        = 0
    self._intradayFactionContribute = 0

end

function FactionHandler:__realease()

    self._entity                = nil
    self._factionList           = nil
    self._factionMoney          = nil
    self._factionHistoryMoney   = nil
    self._lastWeekContribute    = nil
    self._thisWeekContribute    = nil

end

function FactionHandler:initializeFactionDBID( factionDBID )

    self._factionDBID = factionDBID

end


function FactionHandler:getFactionDBID()

    return self._factionDBID

end


function FactionHandler:setFactionMoney( money )
    
    self._factionMoney = money

end

function FactionHandler:getFactionMoney(  )
    
    return self._factionMoney

end

function FactionHandler:addFactionContribute( money )

    self._factionMoney = money + self._factionMoney
    self:addFactionHistoryContribute(money)
    self:addThisWeekContribute(money)
    
end


function FactionHandler:setFactionHistoryMoney( money) 
    
    self._factionHistoryMoney = money

end

function FactionHandler:getFactionHistoryMoney(  )
    
    return self._factionHistoryMoney
    
end

function FactionHandler:addFactionHistoryContribute( money )

    self._factionHistoryMoney = money + self._factionHistoryMoney

end





function FactionHandler:initializeWeekContribute( lastWeekContribute,thisWeekContribute,offlineDate )

	local range = {
		["星期一"] = {0},--周一
		["星期二"] = {1},--周二
		["星期三"] = {2},--周三
		["星期四"] = {3},--周四
		["星期五"] = {4},--周五
		["星期六"] = {5},--周六
		["星期日"] = {6},--周日
    }

    local dateString = time.weekday(os.date("*t",os.time()).wday)

    if time.isSameWeek(time.totime(offlineDate)) then--如果在同一周
        self._thisWeekContribute = thisWeekContribute
        self._lastWeekContribute = lastWeekContribute
    else--如果不在同一周，判断是否在上周
        if time.getApartTime(time.totime(offlineDate)) < (7 + range[dateString][1]) then 
            self._lastWeekContribute = thisWeekContribute
            self._thisWeekContribute = 0
        else--如果不在上周，则全部清0
            self._lastWeekContribute = 0
            self._thisWeekContribute = 0
        end
    end

end


function FactionHandler:setThisWeekContribute( money )
    self._thisWeekContribute = money
end

function FactionHandler:getThisWeekContribute(  )
    return self._thisWeekContribute
end

function FactionHandler:addThisWeekContribute( money )
    self._thisWeekContribute = money + self._thisWeekContribute
    LuaDBAccess.updatePlayer(self._entity:getDBID(),"ThisWeekFactionContribute",self._thisWeekContribute)
end

function FactionHandler:setLastWeekContribute( money )
    self._lastWeekContribute = money
end

function FactionHandler:getLastWeekContribute(  )
    return self._lastWeekContribute
end

function FactionHandler:addLastWeekContribute( money )
    self._lastWeekContribute = money + self._lastWeekContribute
end

function FactionHandler:exitFaction( )
    
    self._factionDBID =  0

end

function FactionHandler:getFactionContributeIntraday(  )
    
    return self._intradayFactionContribute

end

function FactionHandler:addFactionContributeIntraday( money )

    self._intradayFactionContribute = money + self._intradayFactionContribute
    LuaDBAccess.updatePlayer(self._entity:getDBID(),"IntradayFactionContribute",self._intradayFactionContribute)

end

function FactionHandler:setFactionContributeIntraday( money )

    self._intradayFactionContribute = money
    LuaDBAccess.updatePlayer(self._entity:getDBID(),"IntradayFactionContribute",self._intradayFactionContribute)

end



