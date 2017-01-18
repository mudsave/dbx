--[[EncodeSysMgr

    Function: Encode the DBID 
    Author: Caesar

]]

EncodeSysMgr = class(nil,Singleton)

function EncodeSysMgr:__init()


end

function EncodeSysMgr.encodeTableInDBID( tableInfo,indexStr)
    
    for key,value in tableInfo do 
        for k,v in value do
            if k == indexStr then
                v = EncodeSysMgr.encodeDBID(v)
            end
        end
    end

end

function EncodeSysMgr.decodeTableInDBID( tableInfo,indexStr )

    for key,value in tableInfo do 
        for k,v in value do
            if k == indexStr then
                v = EncodeSysMgr.decodeDBID(v)
            end
        end
    end

end

function EncodeSysMgr.encodeDBID( DBID )
    
    local new = DBID + 1

    return "social".. new
end

function EncodeSysMgr.decodeDBID ( string )

    local temp = toNumber(string.gsub( string,"social",""))
    local DBID = temp - 1
    return DBID

end 

function EncodeSysMgr.getInstance()
    return EncodeSysMgr()
end