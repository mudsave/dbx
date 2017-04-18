package.cpath = "temp/?.so;"..package.cpath
require "tool"
function main()
	local color = Color(256,255,255)
	local size = Size(1024,768)

	local t = { {} ,{}, {}, {} }
	-- try `collectgarbage "collect"` to see difference
end

luacollect.start()
main()
luacollect.pause()
local src = luacollect.getresult()
for gco,what in pairs(src) do
	print(type(gco),what)
end
luacollect.stop()
