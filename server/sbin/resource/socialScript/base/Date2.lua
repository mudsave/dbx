local os_time=os.time
local os_date=os.date
local strsub=string.sub

Date2=class()

function Date2.Date2String(_time)
	if not _time then _time=os.time() end
	return os_date('%Y-%m-%d %H:%M:%S',_time)
end

function Date2.String2Date(_time)
	if type(_time)~='string' or #_time<10 then return 0 end
	return os_time{
		year=strsub(_time,1,4),
		month=strsub(_time,6,7),
		day=strsub(_time,9,10),
		hour=strsub(_time,12,13),
		min=strsub(_time,15,16),
		sec=strsub(_time,18,19)
	}
end

return Date2