--time.lua
--/*-----------------------------------------------------------------
 --* Module:  time.lua
 --* Author:  Huang YingTian
 --* Modified: 2008年5月23日 16:03:57
 --* Purpose: time功能函数集合:目前仅支持format: t="2009-05-15 09:10:44"
 -------------------------------------------------------------------*/

time = {}
function time.year(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>4) then
		return tonumber(string.sub(timeStr,1,4))
	end
end

function time.month(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>7) then
		return tonumber(string.sub(timeStr,6,7))
	end
end

function time.day(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>10) then
		return tonumber(string.sub(timeStr,9,10))
	end
end

function time.hour(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>13) then
		return tonumber(string.sub(timeStr,12,13))
	end
end

function time.min(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>16) then
		return tonumber(string.sub(timeStr,15,16))
	end
end

function time.sec(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>=19) then
		return tonumber(string.sub(timeStr,18,19))
	end
end

function time.weekday(day)
	local daysw = {
		[1] = "星期日",
		[2] = "星期一",
		[3] = "星期二",
		[4] = "星期三",
		[5] = "星期四",
		[6] = "星期五",
		[7] = "星期六",
	}
	return daysw[day]
end

--(format :"2009-05-15 09:10:44")字符串转换为lua time
function time.totime(timeStr)
	local y=time.year(timeStr)
	local m=time.month(timeStr)
	local d=time.day(timeStr)
	local h=time.hour(timeStr)
	local min=time.min(timeStr)
	local sec=time.sec(timeStr)
	if (y and m and d and h and min and sec) then
		local ttime={year=y,month=m,day=d,hour=h,
		min=min,sec=sec}
		return os.time(ttime)
	end
end

--lua time转换为字符串(format :"2009-05-15 09:10:44")
function time.tostring(lua_time)
	local t=os.date("*t",lua_time)
	if (type(t)=="table" and table.size(t)==9) then
		return string.format("%d-%.2d-%.2d %.2d:%.2d:%.2d", t.year, t.month, t.day, t.hour, t.min, t.sec)
	end
end

--lua time转换为字符串(format :"2011年09月16日 13:28:21 星期五")
function time.totext(lua_time)
	local t=os.date("*t",lua_time)
	if (type(t)=="table" and table.size(t)==9) then
		return string.format("%d年%.2d月%.2d日 %.2d:%.2d:%.2d %s", t.year, t.month, t.day, t.hour, t.min, t.sec, time.weekday(t.wday))
	end
	
end

--lua time转换为字符串(format :"2011年09月16日")
function time.toDateText( lua_time )

	local t=os.date("*t",lua_time)
	if (type(t)=="table" and table.size(t)==9) then
		return string.format("%d年%.2d月%.2d日", t.year, t.month, t.day)
	end

end


local __EditionBaseTime=time.totime("2011-07-31 00:00:00")	--周日为每周第一天
local __WeekSeconds=60*60*24*7
local __DaySeconds = 60*60*24
function time.toedition(period,lua_time)
	local edition=0
	lua_time=lua_time or os.time()
	if period=="hour" then					--2011080319(10)
		local t=os.date("*t",lua_time)
		edition= t["year"]*1000000+t["month"]*10000+t["day"]*100+t["hour"]
	elseif period=="mday" then				--20110804(8)
		local t=os.date("*t",lua_time)
		edition= t["year"]*10000+t["month"]*100+t["day"]
	elseif period=="day" then				--20110803(8)
		local t=os.date("*t",lua_time)
		edition= t["year"]*10000+t["month"]*100+t["day"]
	elseif period=="date" then				--20110803(8)
		local t=os.date("*t",lua_time)
		edition= t["year"]*10000+t["month"]*100+t["day"]
	elseif period=="yday" then				--20110803(8)
		local t=os.date("*t",lua_time)
		edition= t["year"]*10000+t["month"]*100+t["day"]
	elseif period=="month" then				--201108(6)
		local t=os.date("*t",lua_time)
		edition= t["year"]*100+t["month"]
	elseif period=="wday" then				--100013(6)
		local t=os.date("*t",lua_time)
		local past=os.difftime(lua_time, __EditionBasetime)
		local week=math.ceil(past/__WeekSeconds)
		edition=week+10000+t["wday"]
	elseif period=="year" then				--2011(4)
		local t=os.date("*t",lua_time)
		edition=t["year"]
	elseif period=="week" then				--10001(5)
		local past=os.difftime(lua_time,__EditionBasetime)--past是输入时间距离当前时间的秒数差
		edition= math.ceil(past/__DaySeconds)
		--print("过去了  "..past.." 秒, 一天有 "..__DaySeconds.."秒,  相差天数"..math.ceil(past/__DaySeconds))
	end
	return edition
end

function time.todate(dtype, day, quarter)
	quarter = quarter or 0
	local datevalue=0
	local lua_time=os.time()

	if dtype=="mday" then					--20110800(8)
		day = day or 1
		local t=os.date("*t",lua_time)
		datevalue= t["year"]*1000000+t["month"]*10000+day*100+quarter
	elseif dtype=="day" then				--20110803(8)
		local t=os.date("*t",lua_time)
		datevalue= t["year"]*1000000+t["month"]*10000+t["day"]*100+quarter
	elseif dtype=="yday" then				--20110803(8)
		local t=os.date("*t",lua_time)
		day = day or 0101
		datevalue=t["year"]*1000000+day*100+quarter
	elseif dtype=="wday" then				--10100(5)
		day = day or 1
		local t=os.date("*t",lua_time)
		local past=os.difftime(lua_time,__EditionBasetime)
		local week=math.ceil(past/__WeekSeconds)
		datevalue=(week+10000+day)*100+quarter
	elseif dtype=="date" then
		day = day or 20120101
		datevalue=day*100+quarter
	end
	return datevalue
end

function time.towday(dtype, day)
	local t = os.date("*t", os.time())
	if dtype=="mday" then
		local luaTime = time.totime(string.format("%d-%.2d-%.2d 12:00:00", t.year, t.month, day))
		local tm = os.date("*t", luaTime)
		return tm.wday
	elseif dtype=="day" then
		return t.wday
	elseif dtype=="yday" then
		local luaTime = time.totime(string.format("%d-%.2d-%.2d 12:00:00", t.year, (day-day%100)/100, day%100))
		local tm = os.date("*t", luaTime)
		return tm.wday
	elseif dtype=="wday" then
		return day
	elseif dtype=="date" then
		local luaTime = time.totime(string.format("%d-%.2d-%.2d 12:00:00", (day-day%10000)/10000, (day%10000-day%100)/100, day%100))
		local tm = os.date("*t", luaTime)
		return tm.wday
	end
	return 0
end

function time.toquarter()
	local t=os.date("*t",os.time())
	return t["hour"]*4 + math.floor(t["min"]/15)
end

function time.tominute()
	local t=os.date("*t",os.time())
	return t["min"], t["sec"]
end

-- 判断指定秒数跟当前是不是同一天
function time.isSameDay(second)
	local tDate = os.date("*t", second)
	local tCurDate = os.date("*t")
	if tDate.year == tCurDate.year and tDate.yday == tCurDate.yday then
		return true
	end
	return false
end

-- 判断指定秒数跟当前是不是同一周
function time.isSameWeek(second)

	local range = {
		["星期一"] = {0},--周一
		["星期二"] = {1},--周二
		["星期三"] = {2},--周三
		["星期四"] = {3},--周四
		["星期五"] = {4},--周五
		["星期六"] = {5},--周六
		["星期日"] = {6},--周日
	}

	local dateString = time.weekday(os.date("*t",os.time()).wday)
	local dayCount = time.toedition("week") - time.toedition("week", second) 
	local max = range[dateString][1]
	if dayCount <= max then
		return true
	else 
		return false
	end

end

--得到与指定日期相差的天数
function time.getApartTime( second )

	local dayCount = time.toedition("week") - time.toedition("week", second)
	return dayCount

end

function time.isSameMonth(second)
	local tarTime = os.date("*t", second)
	local curTime = os.date("*t")
	if tarTime.year == curTime.year and tarTime.month == curTime.month then
		return true
	end
	return false
end

g_delta = 2
g_checkDayLock = false

function time.isDayEnd()
	local data = os.date("*t", os.time())
	if data.hour == 12 then
		g_checkDayLock = false
	end
	if g_checkDayLock == true then
		return false
	end
	if not g_checkDayLock and data.hour == 0 and data.min - 0 < g_delta then
		g_checkDayLock = true
		return true
	end
	return false
end

function time.isWeekEnd()
	local data = os.date("*t", os.time())
	if data.wday == 2 then
		return true
	end
end

function time.isMonthEnd()
	local data = os.date("*t", os.time())
	if data.day == 1 then
		return true
	end
end

