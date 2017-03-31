


AdminSystem = class(EventSetDoer, Singleton)

function AdminSystem:__init()
	self._doer = {
		[AdminEvents_WA_Test] = AdminSystem.onTest,
	}
end

--[[
request = 
{
	id = 1;
	url= "";
	method= 1;

	arg1 = "";
	arg2 = "";
}
response =
{
	id = 1
	result = 1
	data = {name="zgj", job="IT"}
}
--]]

function printError(msg)
	print ("[ERROR] " .. msg)
	print (debug.traceback())
	return 0;
end

function processRequest(request)
	print(toString(request))
	if request.url then
		local event = Event(AdminEvents_AW_Test, request.id, 100, 'test')
		RPC.send(event)
	end
end

function AdminSystem:onTest(event)
	local params = event:getParams()
	local id = params[1]
	local result = params[2]
	local data = params[3]
	local json_str = JSON.encode(data)
	onResponse(id, result, json_str)
end

function AdminSystem.getInstance()
	return AdminSystem()
end

EventManager.getInstance():addEventListener(AdminSystem.getInstance())
