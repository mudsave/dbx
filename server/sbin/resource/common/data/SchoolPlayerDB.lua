--[[SchoolPlayerDB 帮派玩家默认数据
	瞎配置的
]]


local function MakePlayer(DefaultMapID,DefaultPosX,DefaultPosY)
	return {
		defaultMapID = DefaultMapID,	--帮派玩家默认的地图ID
		defaultPosX = DefaultPosX,		--默认的位置
		defaultPosY = DefaultPosY		--默认的位置
	}
end

SchoolPlayerDB = {
	[SchoolType.JXS] = MakePlayer(8,95,220),
	[SchoolType.QYD] = MakePlayer(8,95,220),
	[SchoolType.ZYM] = MakePlayer(8,95,220),
	[SchoolType.PLG] = MakePlayer(8,95,220),
	[SchoolType.TYD] = MakePlayer(8,95,220),
	[SchoolType.YXG] = MakePlayer(8,95,220)
}