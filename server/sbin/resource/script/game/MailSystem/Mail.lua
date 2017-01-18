--Mail.lua
require "base.Date2"
require "base.Table2"

Mail = class()

MailFlags_Removed	= 1	--邮件是否已被删除
MailFlags_Created	= 2	--右键是否是新建的

local String2Date	= Date2.String2Date
local Date2String	= Date2.Date2String
local Table2String	= Table2.Table2String
local String2Table	= Table2.String2Table
local now			= os.time

--[[
	extra = {
		ID = 10023,
		Amount = 3
	}
]]

--[[
	暂时邮件的ID，给客户端用，这个值不会更新到数据库中
]]
local FluidMailIDBase = 1

--[[
	邮件初始化
	邮件类别，邮件主题，邮件正文，附加奖励，奖励过期时间
]]
function Mail:__init(m_type,m_theme,m_content,extra,expires)
	self.type		= m_type or ""
	self.theme		= m_theme or ""
	self.content	= m_content or ""
	self.extra		= extra or nil
	self.expires	= expires --邮件默认保留30天
	self.mailID		= -1

	self.properties = {
		[MailFlags_Removed] = false,
		[MailFlags_Created]  = false
	}

	self.send_time = 0
end

function Mail.MailFromSQL(mdata)
	if not mdata then return nil end

	local mail = Mail(mdata.type,mdata.theme)

	mail:setStringExtra(mdata.extra,mdata.expires)
	mail:setMailID(mdata.mailID)
	mail:setSendDate(mdata.date)
	mail:setContent(mdata.content)

	return mail
end

function Mail.MailFromTable(mdata)
	if not mdata then return nil end

	local mail = Mail(mdata.type,mdata.theme)

	if mdata.extra then
		mail:setTableExtra(mdata.extra,mdata.expires)
	else
		mail.expires = 24 * 30
	end
	mail:setMailID()--如果没有ID，自动生成ID，最好是自动生成的
	mail:setContent(mdata.content)
	mail:setProperty(MailFlags_Created,true)
	mail.send_time = now()

	mdata.mailID = mail.mailID

	return mail
end

function Mail:setRead()
	if self.extra and #self.extra>0 then
		return false
	end
	self:setProperty(MailFlags_Removed,true)
end

function Mail:setTaken()
	self:setProperty(MailFlags_Removed,true)
end

function Mail:setProperty(enum_mail,bvalue)
	if enum_mail then
		self.properties[enum_mail] = bvalue
	end
end

function Mail:getProperty(enum_mail)
	return enum_mail and self.properties[enum_mail]
end

function Mail:isRemoved()
	return self:getProperty(MailFlags_Removed)
end

function Mail:isNew()
	return self:getProperty(MailFlags_Created)
end

function Mail:setContent(scontent)
	self.content = scontent or "<html><center><font color='red'>一封空的邮件</font></center></html>"
end

function Mail:setStringExtra(str_extra,expires)
	self:setTableExtra(String2Table(str_extra),expires)
end

function Mail:setTableExtra(extra,expires)
	if type(extra) == 'table' then
		self.extra = extra
		self.expires = 30*24
	else
		self.extra = nil
		self.expires = 30*24
	end
end

--[[
	获得邮件的附件
	返回字符串，供MySQL使用
]]
function Mail:getExtraString()
	return (self.extra and Table2String(self.extra) or "")
end

--[[
	设置邮件的发送时间，这个时间一般来自于MySQL
]]
function Mail:setSendDate(dtstr)
	self.send_time = String2Date(dtstr)
end

--[[
	获得邮件的发送时间
	返回字符串，供MYSQL使用
]]
function Mail:getSendDate()
	return Date2String(self.send_time) or ""
end

--[[
	设置邮件ID，因为某些邮件暂存在服务器中，没更新到数据库中
]]
function Mail:setMailID(mID)
	if not mID then
		FluidMailIDBase = FluidMailIDBase + 1
		mID = tostring(FluidMailIDBase)	--ID使用字符串
	end
	self.mailID = mID
end

function Mail:getContentString()
	local content = self.content or ""
	if type(content)=="table" then
		return Table2String(content)
	end
	return content
end

--[[
	获得剩余时间，以小时为单位
]]
function Mail:getExpires()
	local pasted = math.floor((os.time()-self.send_time)/3600)
	return (pasted<self.expires and self.expires-pasted or 0)
end

--[[
	奖励是否过期，供领取奖励的时候查询
	1，邮件被删除
	2，没有奖励
	3，过期的奖励
]]
function Mail:isExpired()
	if self:isRemoved() then return true,1 end
	if not self.extra then return true,2 end
	if now()>(self.expires*3600+self.send_time) then return true,3 end
	return false,0
end

--[[
	字段截取，一些字段是不需要给客户端的
]]
function Mail:trim()
	return {
		mailID		= self.mailID,
		date		= self:getSendDate(),
		read_ever	=false,

		type		= self.type,
		theme		= self.theme,
		content		= self.content,

		extra		= self.extra,
		expires		= self:getExpires()
	}
end