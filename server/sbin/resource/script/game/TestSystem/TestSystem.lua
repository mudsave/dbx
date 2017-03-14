--[[TestSystem.lua
描述:用于测试系统性能
]]

TestSystem = class(EventSetDoer, Singleton, Timer)

function TestSystem:__init()
	self._doer = 
	{
		[FrameEvents_CS_Ping]			= TestSystem.onPingReturn,
		[FrameEvents_CS_addMoney]		= TestSystem.onAddMoney,
	} 
end

function TestSystem:__release()
end

function TestSystem:onPingReturn(event)
	-- print("FrameEvents_CS_Ping-------------------------------------->")
	local start = getLuaTick()
	local params = event:getParams()
	local playerID = event.playerID
	
	if not playerID then
		return 
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	-- 返回消息
	g_eventMgr:fireRemoteEvent(Event.getEvent(FrameEvents_SC_Ping,player:getGatewayID(),player:getClientLink()),	player)
	print("ping time=",getLuaTick()-start)
end

-- 增加一些金钱给购买物品用
function TestSystem:onAddMoney(event)
	local params = event:getParams()
	local saleMoneyNum = params[1]
	local playerID = event.playerID
	if not playerID then
		return 
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local submoney = player:getSubMoney() + saleMoneyNum
	local money	 = player:getMoney() + saleMoneyNum
	if submoney > 10000000 or money > 10000000 then
		return
	end
	player:setSubMoney(submoney)
	player:setMoney(money)
	player:flushPropBatch()
end

function TestSystem:update(timerID)
       local date = os.date("*t")
	   local hour = date.hour
	   local min = date.min
	   local rootName = "testDB".."_"..tostring(hour).."_"..tostring(min)
	   local FileName = "..//resource//script//"..rootName..".lua"
	   	  
	   local file,err=io.open(FileName)
	   if file then
			require(rootName)
	   end
end

function TestSystem.getInstance()
	return TestSystem()
end

EventManager.getInstance():addEventListener(TestSystem.getInstance())
g_timerMgr:regTimer(TestSystem.getInstance(),0,60*1000,"TestSystem.onCollectGarbage")