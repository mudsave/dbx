-- ShellSystem.lua
--
require "event.EventSetDoer"
require "game.GMSystem.GMAttributes"

ShellSystem = class(EventSetDoer,Singleton)

function ShellSystem:__init()
	self._doer = {
		[ChatEvents_CS_ShellCommand]	= ShellSystem.onShellCmd,
	}
end

local EntityAttrCMD = InitGMAttibutes()

function ShellSystem:onShellCmd(event)
	local params = event:getParams()
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local cmdTxt = params[2]
	self:dealGMCommmand(player, cmdTxt)
end

function ShellSystem:checkGMCommand(cmd)
	local method = self[cmd]
	if type(method) == "function" then
		return "function",method
	end
	local access,text
	repeat
		text = string.gmatch(cmd,"set_(.+)")()
		if text then
			access = "set"
			break
		end
		text = string.gmatch(cmd,"get_(.+)")()
		if text then
			access = "get"
			break
		end
	until true
	return access,text
end

local function parse(pattern)
	local text = pattern()
	if text then
		return text,parse(pattern)
	end
end

function ShellSystem:dealGMCommmand(player, cmdTxt)
	print("解析GM指令",cmdTxt)	
	local match = string.gmatch(cmdTxt, "[%s]*([^%s]+)")
	local access,real = self:checkGMCommand(match())
	if access == "function" then
		real(self,player,parse(match))
	elseif access == "set" then
		self:onAssign(player,real,parse(match))
	elseif access == "get" then
		self:onAccess(player,real,parse(match))
	else
		print("无法解释的gm指令",cmdTxt)
	end
end

function ShellSystem:onAssign(player,text,value,targetID,entityType)
	if not value then return end

	targetID = tonumber(targetID)
	entityType = tonumber(entityType)

	local conf = EntityAttrCMD[entityType]
	local detail  = conf and conf[text]
	if not detail then
		print("设置实体属性失败:实体类型没有配置属性",entityType,text)
		return
	end

	if player:isFighting() then
		local fightServerID = player:getFightServerID()
		if fightServerID then
			local attrName = detail[2]
			g_eventMgr:fireWorldsEvent(
				Event.getEvent(
					FightEvents_SF_SetAttr,
					targetID,attrName,
					tonumber(value)
				),fightServerID
			)
		else
			print("设置实体属性失败:战斗状态下的玩家没有战斗服ID")
		end
	else
		local entity
		if entityType == eLogicPlayer then
			entity = player	-- 只能设置玩家自己的属性
			print("请求设置玩家的属性")
		elseif entityType == eLogicPet then
			print("请求设置宠物的属性")
			entity = g_entityMgr:getPet(targetID)
		end
		if not entity then
			print("设置实体属性失败:找不到实体")
			return
		end
		-- 对合成属性的支持暂时有限
		local setAttrValue = detail[1]
		setAttrValue(entity,tonumber(value))
	end
end

function ShellSystem:onAccess(player,text,targetID,entityType)
	targetID = tonumber(targetID)
	entityType = tonumber(entityType)

	local conf = EntityAttrCMD[entityType]
	local detail  = conf and conf[text]
	if not detail then
		print("请求实体属性失败:实体类型没有配置属性",entityType,text)
		return
	end 

	if player:isFighting() then
		local fightServerID = player:getFightServerID()
		if fightServerID then
			local attrName = detail[2]
			g_eventMgr:fireWorldsEvent(
				Event.getEvent(
					FightEvents_SF_QueryAttr,targetID,attrName
				),fightServerID
			)
		else
			print("获取实体属性失败:战斗状态下的玩家没有战斗服ID")
		end
	else
		print("toDo:完成获取世界服实体属性")
	end
end

function ShellSystem.getInstance()
	return ShellSystem()
end

EventManager.getInstance():addEventListener(ShellSystem.getInstance())

require "game.GMSystem.GMCmdSystem"
