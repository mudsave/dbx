
DramaSystem = class(EventSetDoer, Singleton)

function DramaSystem:__init()
	self._doer = 
	{
		[Drama_CS_Start]			= DramaSystem.OnStartDrama,
		[Drama_CS_Stop]				= DramaSystem.OnStopDrama,
	}
end

function DramaSystem:OnStartDrama(event)
	local params = event:getParams()
	local playerID = params[1]
	local playID = params[2]
	local sceneID = params[3]
	local player = g_entityMgr:getPlayerByID(playerID)
	if player then
		local handler = player:getHandler(HandlerDef_Team)
		if handler and handler:isLeader() then
			local memberList = handler:getTeamPlayerList()
			for _, entity in pairs(memberList) do
				if id ~= entity:getID() then
					local event = Event.getEvent(Drama_SC_Start, playID, sceneID)
					g_eventMgr:fireRemoteEvent(event, entity)
				end
			end
		end
	end
end

function DramaSystem:OnStopDrama(event)
	local params = event:getParams()
	local player = g_entityMgr:getPlayerByID(playerID)
	if player then
		local handler = player:getHandler(HandlerDef_Team)
		if handler and handler:isLeader() then
			local memberList = handler:getTeamPlayerList()
			for _, member in pairs(memberList) do
				if id ~= entity:getID() then
					local event = Event.getEvent(Drama_SC_Stop)
					g_eventMgr:fireRemoteEvent(event, entity)
				end
			end
		end
	end
end
	
function DramaSystem.getInstance()
		return DramaSystem()
end

EventManager.getInstance():addEventListener(DramaSystem.getInstance())
