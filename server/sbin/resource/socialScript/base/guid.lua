--[[Guid.lua
描述：
	生成物品等实体的全局唯一标识
--]]

local last_guids = {}

function createGUID(clz)
	if clz == nil then
		return 0
	end

	local guid = 0
	if clz == Player then
		guid = NEW_GUID_LUA(1, 1)
	elseif clz == Pet then
		guid = NEW_GUID_LUA(1, 2)
	elseif clz == Item then
		guid = NEW_GUID_LUA(1, 3)
	elseif clz == Ride then
		guid = NEW_GUID_LUA(1, 4)
	elseif clz == Email then
		guid = NEW_GUID_LUA(1, 5)
	else
		return 0
	end
	if guid == last_guids[clz] then
		--不应该会重复？
		guid = createGUID(clz)
	end
	last_guids[clz] = guid

	return guid
end