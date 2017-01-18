--[[Dialog.lua
描述：
	对话对象(对话系统)
--]]

Dialog = class()

function Dialog:__init()
	self._options = {}			--对话选项
	self._dialogType = 0		--对话类型
	self._txt = nil				--对话文字
	self._id = 0				--对话id
	self._beginTime = 0			--对话开始时间
end

function Dialog:setID(id)
	self._id = id
end

function Dialog:getID()
	return self._id
end

function Dialog:setTxt(txt)
	self._txt = txt
end

function Dialog:getTxt()
	return self._txt
end

function Dialog:setOptions(options)
	self._options = options
end

function Dialog:getOptions()
	return self._options
end

function Dialog:getOptionByID(optionID)
	return self._options[optionID]
end

function Dialog:setDialogType(dialogType)
	self._dialogType = dialogType
end

function Dialog:getDialogType()
	return self._dialogType
end

function Dialog:setBeginTime(beginTime)
	self._beginTime = beginTime
end

function Dialog:getBeginTime()
	return self._beginTime
end