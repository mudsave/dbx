--[[WorldDropsDB.lua
描述：
	怪物的世界掉落
--]]
WorldDropConfig = {
					{ID = 1051011,count = 1 ,weight = 200},
					{ID = 1051012,count = 1 ,weight = 50},
				  }

LevelDropsConfig ={ --等级掉落
					{minLevel = 1, maxLevel = 9, items = {{ID = 1051013,count = 1, weight = 50},{ID = 1051013,count = 1, weight = 50},}, },
					{minLevel = 10, maxLevel = 19,items = {{ID = 1051013,count = 1, weight = 100},}, },
					{minLevel = 20, maxLevel = 29,items = {{ID = 1051013,count = 1, weight = 100},} ,},
					{minLevel = 30, maxLevel = 39, items = {{ID = 1051013,count = 1, weight = 100},} ,},
					{minLevel = 40, maxLevel = 150, items ={{ID = 1051013,count = 1, weight = 100},}, },
				}
