--[[MailSystem.lua
]]
require "event.EventSetDoer"
require "game.MailSystem.Mail"
require "game.MailSystem.MailManager"

MailSystem = class(EventSetDoer,Singleton)

function MailSystem:__init()
	self._doer = {
		[MailEvent_CS_ReadMail]			= MailSystem.onReadMail,	--客户端阅读邮件请求
		[MailEvent_CS_RemoveMails]		= MailSystem.onRemoveMails,	--客户端删除邮件请求
		[MailEvent_CS_PickMailItem]		= MailSystem.onPickMailItem,--客户端领取邮件附件请求
		[MailEvent_SS_NewMail]			= MailSystem.onNewMail,		--新邮件事件
		[MailEvent_CS_RequireMoreMails] = MailSystem.onMoreMailsRequired,--客户端请求更多邮件
	}
end

function MailSystem:onReadMail(event)
	local params 	= event:getParams()
	local playerID	= params[1]
	local mailID	= params[2]
	local player	= g_entityMgr:getPlayerByID(event.playerID)

	local mail = g_mailMgr:isThatYours(mailID,player:getDBID())
	if mail then
		mail:setRead()
	end
end

--删除邮件后，如果不够一页，则客户端发送接收邮件请求
function MailSystem:onRemoveMails(event)
	local params	= event:getParams()
	local playerID	= params[1]
	local id_list	= params[2]

	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local dbID 		= player:getDBID()
	g_mailMgr:removeMails(dbID,id_list)

	local event = Event.getEvent(MailEvent_SC_MailsRemoved,g_mailMgr:getMailsCount(dbID),id_list)
	g_eventMgr:fireRemoteEvent(event,player)

end

--[[
	处理玩家请求领取奖励
	返回协议：
	1，协议号
	2，邮件ID
	3，错误号
		0，无错
		1，邮件已经删除
		2，邮件无奖励
		3，奖励过期
		4，玩家背包满了
]]
function MailSystem:onPickMailItem(event)
	local params	= event:getParams()
	local playerID	= params[1]
	local mailID	= params[2]

	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local box		= g_mailMgr:getMailBox(player:getDBID())
	local mail		= mailID and box:getMail(mailID)

	if not mail then
		return
	end
	local expired,err_code = mail:isExpired()
	if not expired then
		if not self:addPlayerItem(player,mail.extra) then
			err_code = 4
		else
			mail:setTableExtra(nil,0)
			mail:setTaken()
		end
	end

	local event = Event.getEvent(MailEvent_SC_MailItemPicked,mailID,err_code)
	g_eventMgr:fireRemoteEvent(event,player)
end


--[[给玩家发送邮件
	参数1，玩家ID
	参数2，玩家数据库ID；如果玩家不在线，那么参数1无效
	参数3，邮件内容
	--接收到新邮件的时候，发送提示给客户端，客户端邮件不够1页，就发送接收邮件请求
]]
function MailSystem:onNewMail(event)
	local params = event:getParams()
	local playerID,dbID,mdata = unpack(params)
	local player = playerID and g_entityMgr:getPlayerByID(playerID)
	if player then
		g_mailMgr:addFluidMail(player:getDBID(),mdata) --添加浮动邮件，会通过mdata返回动态的邮件ID，新邮件ID是字符串，在服务器中使用
		local event = Event.getEvent(MailEvent_SC_MailsDelieved,g_mailMgr:getMailsCount(player:getDBID()),nil)
		g_eventMgr:fireRemoteEvent(event,player)
	elseif dbID then
		LuaDBAccess.MailNew(Mail.MailFromTable(mdata),dbID)
	else
		print "玩家不在线，没有指定玩家的ID，无法发送邮件"
	end
end

function MailSystem:onMoreMailsRequired(event)
	local params	= event:getParams()
	local playerID	= params[1]
	
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local mails 	= g_mailMgr:retrievePlayerMails(player:getDBID())
	if mails and #mails > 0 then
		local event=Event.getEvent(MailEvent_SC_MailsDelieved,g_mailMgr:getMailsCount(player:getDBID()),mails)
		g_eventMgr:fireRemoteEvent(event,player)
	end
end

function MailSystem:addPlayerItem(player,items)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	
	--判断能否把所有物品放进玩家的包裹中
	for _,item in ipairs(items) do
		if not packetHandler:canAddPacket(item.ID,item.Amount,false) then
			return false
		end
	end

	for _,item in ipairs(items) do
		packetHandler:addItemsToPacket(item.ID, item.Amount)
	end
	return true
end

local instance
function MailSystem.getInstance()
	if not instance then
		instance = MailSystem()
	end
	return instance
end

EventManager.getInstance():addEventListener(MailSystem.getInstance())

return MailSystem
