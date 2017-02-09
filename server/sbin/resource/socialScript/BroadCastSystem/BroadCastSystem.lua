--[[BroadCastSystem:




]]

BroadCastSystem = class(EventSetDoer, Singleton)

function BroadCastSystem:__init()

	self._doer = {

		[BroadCastSystem_CS_DigTreasure]        = BroadCastSystem.onDigTreasure,
        [BroadCastSystem_CS_RemakeEquip]        = BroadCastSystem.onRemakeEquip,
        [BroadCastSystem_CS_UpgradeMounts]      = BroadCastSystem.onUpgradeMounts,
        [BroadCastSystem_CS_SummonMounts]       = BroadCastSystem.onSummonMounts,

	}

end

function BroadCastSystem:onDigTreasure( event )

    local params = event:getParams()
    local event_DigTreasure = Event.getEvent(ClientEvents_SC_PromptMsg,params[1],params[2],params[3],params[4],params[5])
    RemoteEventProxy.broadcast(event_DigTreasure)

end

function BroadCastSystem:onRemakeEquip( event )

    local params = event:getParams()
    local event_DigTreasure = Event.getEvent(ClientEvents_SC_PromptMsg,params[1],params[2],params[3],params[4])
    RemoteEventProxy.broadcast(event_DigTreasure)

end

function BroadCastSystem:onUpgradeMounts( event )
    local params = event:getParams()
    local event_DigTreasure = Event.getEvent(ClientEvents_SC_PromptMsg,params[1],params[2],params[3],params[4])
    RemoteEventProxy.broadcast(event_DigTreasure)

end

function BroadCastSystem:onSummonMounts( event )

    local params = event:getParams()
    local event_DigTreasure = Event.getEvent(ClientEvents_SC_PromptMsg,params[1],params[2],params[3],params[4])
    RemoteEventProxy.broadcast(event_DigTreasure)

end











function BroadCastSystem.getInstance()
	return BroadCastSystem()
end

g_eventMgr:addEventListener(BroadCastSystem.getInstance())