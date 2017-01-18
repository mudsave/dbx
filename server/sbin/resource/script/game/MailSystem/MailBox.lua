--[[MailBox.lua
]]
require 'game.MailSystem.Mail'

local MaxMailsPerSend = 10

--[[
	需要考虑一下临时邮件的ID，因为要发送给玩家的
	在客户端，邮件ID也是在使用的
]]
MailBox = class()

function MailBox:__init(dbID)
	self.mails				= {}	--所有的邮件
	self.id_list			= {}	--玩家的邮件ID列表
	self.last_send_index	= 0		--最后一次发送的邮件下标
	self.unremoved_count	= 0
	self.owner = dbID
end

function MailBox:__release()
	self.mails		= nil
	self.id_list	= nil
	self.owner		= nil
end

function MailBox:getOwnerID()
	return self.owner
end

function MailBox:addMailBase(new_mail)
	if type(new_mail)~="table" then
		return false
	end
	local all_mails = self.mails
	local mailID = new_mail.mailID
	local id_list = self.id_list

	if all_mails[mailID] then
		return false
	end

	all_mails[mailID] = new_mail
	id_list[#id_list + 1] = mailID
	self.unremoved_count = self.unremoved_count + 1
	return true
end

--添加邮件，邮件由数据库数据初始化
function MailBox:addSolidMail(new_mail)
	return self:addMailBase(Mail.MailFromSQL(new_mail))
end

--添加邮件，邮件由Table初始化
function MailBox:addFluidMail(new_mail)
	return self:addMailBase(Mail.MailFromTable(new_mail))
end

--删除邮件，仅仅将邮件的属性“已删”设为真
function MailBox:removeMails(ids)
	if type(ids) ~= "table" then
		return
	end
	local all_mails = self.mails
	local unremoved_count = self.unremoved_count

	for _,mailID in ipairs(ids) do
		local mail = all_mails[mailID]
		if mail then
			mail:setProperty(MailFlags_Removed,true)
			unremoved_count = unremoved_count - 1
		end
	end
	self.unremoved_count = unremoved_count
end

function MailBox:getUnremovedMailsCount()
	return self.unremoved_count
end

function MailBox:getMail(mailID)
	return mailID and self.mails[mailID]
end

--获取可以直接发送到客户端的邮件数据
function MailBox:getOutputMails()
	local start		= self.last_send_index

	local all_mails	= self.mails
	local id_array	=self.id_list
	local outputs	={}

	for i = start,#id_array do
		local this_mail = all_mails[id_array[i]]
		if this_mail and not this_mail:isRemoved() then
			outputs[#outputs + 1] = this_mail:trim()
		end
		if #outputs>=MaxMailsPerSend then
			break
		end
		start = i
	end

	if #outputs>0 then self.last_send_index = start + 1 end

	return outputs
end

--更新邮件数据到数据库中
function MailBox:update2DB()
	local all_mails = self.mails
	for _,mailID in ipairs(self.id_list) do
		local mail = all_mails[mailID]
		if mail then
			if mail:isRemoved() then
				if not mail:isNew() then
					LuaDBAccess.MailRemove(mail)
				end
			elseif mail:isNew() then
				LuaDBAccess.MailNew(mail,self.owner)
			end
		end
	end
end

return MailBox
