--[[MailManager.lua
]]
require 'game.MailSystem.Mail'
require "game.MailSystem.MailBox"

MailManager = class(Singleton)

function MailManager:__init()
	self.mailBoxs	= {}	--所有玩家的邮箱
end

--添加邮件，邮件来自于SQL
function MailManager:addSolidMail(dbID,mail)
	local _box = dbID and self:getMailBox(dbID)
	if _box then
		return mail and _box:addSolidMail(mail)
	end
	return false
end

--添加新建邮件
function MailManager:addFluidMail(dbID,mail)
	local _box = dbID and self:getMailBox(dbID)
	if _box then
		return mail and _box:addFluidMail(mail)
	end
	return false
end

--删除若干邮件
function MailManager:removeMails(dbID,ids)
	local _box = dbID and self.mailBoxs[dbID]
	if _box and ids then
		return _box:removeMails(ids)
	end
	return false
end

--某封邮件是否属于某一个玩家
function MailManager:isThatYours(mailID,dbID)
	local _box = dbID and self:getMailBox(dbID)
	if _box then
		return mailID and _box:getMail(mailID)
	end
	return nil
end

--获得某一个玩家的邮箱，没有则创建
function MailManager:getMailBox(dbID)
	local player = dbID and g_entityMgr:getPlayerByDBID(dbID)
	if not player then
		return nil
	end

	local mailBoxs = self.mailBoxs
	local _box = mailBoxs[dbID]
	if not _box then
		_box = MailBox(dbID)
		mailBoxs[dbID] = _box
	end

	return _box
end

--和上面的函数对应
function MailManager:removeMailBox(dbID)
	if dbID then
		self.mailBoxs[dbID] = nil
	end
end

--[[
	获取邮箱中未读邮件数量
]]
function MailManager:getMailsCount(dbID)
	local _box = dbID and self.mailBoxs[dbID] 
	if _box then
		return _box:getUnremovedMailsCount()
	end
	return 0
end

function MailManager:getMail(mailID)
	for _,box in pairs(self.mailBoxs) do
		local mail = box:getMail(mailID)
		if mail then
			return mail,box:getOwnerID()
		end
	end
	return nil,nil
end

--获得玩家的若干邮件(截取字段)
function MailManager:retrievePlayerMails(dbID)
	local box = dbID and self.mailBoxs[dbID]
	return box and box:getOutputMails()
end


--初始化加载玩家的所有邮件
function MailManager:loadPlayerMails(player,mails)
-- print("youjian--------------------------------2",toString(mails))
	local _box = self:getMailBox(player:getDBID())
	if not mails then
		return
	end

	for idx,mail in ipairs(mails) do
		_box:addSolidMail(mail,self.owner_pool)
	end

	--函数getOutputMails做了一次邮件发送的数量限制
	--2016年3月30日[修改 发送邮件协议增加邮件总数]
	local event=Event.getEvent(MailEvent_SC_MailsDelieved,g_mailMgr:getMailsCount(player:getDBID()),_box:getOutputMails())
	g_eventMgr:fireRemoteEvent(event,player)
end

function MailManager:update2DB(dbID)
	local _box = dbID and self.mailBoxs[dbID]
	if _box then
		_box:update2DB()
		print(("更新邮件到数据库，玩家ID是%d"):format(dbID))
	end
end

--[[
	给玩家添加物品
]]
function MailManager:addPlayerItems(player,items)
	local packetEvent = Event.getEvent(MailEvent_SS_NewMail,player:getID(),player:getDBID(),
		{
			type = string.utf8ToGbk "系统邮件",
			theme = string.utf8ToGbk "包裹容量不足",
			extra = items,
			expires = 24,
			content = {"html",string.utf8ToGbk "包裹容量不足啊，赶紧买点券补充下吧"}
		}
	)
	g_eventMgr:fireEvent(packetEvent)
end

function MailManager.getInstance()
	return MailManager()
end

return MailManager
