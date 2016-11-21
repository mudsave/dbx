--MapDB.lua

MapType =
{
		Wild = 1,
		City = 2,
		Copy = 3,
		Task = 4,
}

mapDB =
{
	[1] = { 
			map 		= "mp01.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {20004,20021,29066,29040,29059,29050,29072, },
			safeX 		= 124,
			safeY 		= 48,
			obviousMines 	= {{updateTime = 180, scriptID = 100, tiles = {{49, 61}, {59, 53}, {70, 46}, {84, 49}}, npcID = 20021}, {scriptID = 100, tiles = {{20, 30}, {30, 40}, {40, 50}, {50, 60}}, npcID = 20021}},
			scopeMines 	= {{radius = 5, scriptID = 100, updateTime = 180, centerTile = {49, 61}, npcID = 20021}},
		},
}