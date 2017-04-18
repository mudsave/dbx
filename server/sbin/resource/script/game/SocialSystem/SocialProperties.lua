-- SocialProperties.lua
-- Properties that needed by social server and provided in world server

local Conf = {
	["Level"]		= "getLevel",
	["ModelID"]		= "getModelID",
	["Vigor"]		= "getVigor",
	["OfflineDate"]	= "getOfflineDate",
	["CurHeadTex"]	= "getCurHeadTex",
	["CurBodyTex"]	= "getCurBodyTex",
	["School"]		= "getSchool",
	["Name"]		= "getName",
	["Sex"]			= "getSex",
}

local rawset = rawset
local rawget = rawget

SocialProperties = class()

function SocialProperties:__init()
	self.changed	= false
end

function SocialProperties:loadEntity(entity)
	for propertyName,funcName in pairs(Conf) do
		-- rawset(self,propertyName,entity[funcName](entity))
		rawget(self,propertyName,false);
	end
	-- self.changed = true
	self.changed = false
end

function SocialProperties:onPropertyUpdated(propertyName,value)
	-- error test
	if not Conf[propertyName] then
		print(propertyName,"是不支持的属性")
	end
	if not value then
		print(propertyName,"值为",value)
	end
	-- test end]]

	rawset(self,propertyName,value)
	self.changed = true
end

function SocialProperties:bcUpdates(entity)
	if not self.changed then return	end
	-- error test
	if not entity then
		print "缺少玩家"
	end
	-- test end]]

	local properties = {}
	for propertyName,_ in pairs(Conf) do
		local value = rawget(self,propertyName)
		if value then
			rawset(self,propertyName,false)
			rawset(properties,propertyName,value)
		end
	end
	g_eventMgr:fireWorldsEvent(
		Event.getEvent(
			SocialEvent_BB_UpdatePlayerAttr,properties,entity:getDBID()
		),SocialWorldID
	)
	self.changed = false
end
