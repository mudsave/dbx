--[[OpenTreasureChestDB.lua
描述：宝箱物品配置
	]]
--宝箱物品种类数目固定或区间取值
TreasureType = 
{
	Fixed = 1, --数目固定
	Interval = 2, --数目取区间值
}
--宝箱物品种类数目固定或区间取值
NumType = 
{
	Fixed = 1, --数目固定
	Interval = 2, --数目取区间值
}



tTreasureChestItems = {

	[1031001] = {
		typeNum = 2,
		treasure = {
			[1] = {itemID = 1110099, number = {1,2}, weight = 20,},
			[2] = {itemID = 1110100, number = {1,2}, weight = 20,},
			[3] = {itemID = 1110101, number = {1,2}, weight = 20,},
			[4] = {itemID = 1110102, number = {1,2}, weight = 20,},
			[5] = {itemID = 1110103, number = {1,2}, weight = 20,},
		},
	},
	[1031009] = {
		typeNum = 2,
		treasure = {
			[1] = {itemID = 1110031, number = 1, weight = 20,},
			[2] = {itemID = 1110100, number = 5, weight = 20,},
			[3] = {itemID = 1110031, number = 1, weight = 20,},
			[4] = {itemID = 1110031, number = 1, weight = 20,},
			[5] = {itemID = 1110031, number = 1, weight = 20,},
		},
	},
	[1031010] = {
		typeNum = 1,
		treasure = {
			[1] = {itemID = 1021001, number = 1, weight = 20,},
			[2] = {itemID = 1021002, number = 1, weight = 20,},
			[3] = {itemID = 1021003, number = 1, weight = 20,},
			[4] = {itemID = 1021004, number = 1, weight = 20,},
			[5] = {itemID = 1022001, number = 1, weight = 10,},
			[6] = {itemID = 1311082, number = 2, weight = 20,},
			[7] = {itemID = 1311083, number = 2, weight = 20,},
		},
	},
	[1031011] = {
		typeNum = 1,
		treasure = {
			[1] = {itemID = 1021001, number = 2, weight = 20,},
			[2] = {itemID = 1021002, number = 2, weight = 20,},
			[3] = {itemID = 1021003, number = 2, weight = 20,},
			[4] = {itemID = 1021004, number = 2, weight = 20,},
			[5] = {itemID = 1022001, number = 2, weight = 10,},
			[6] = {itemID = 1013003, number = 1, weight = 10,},
			[7] = {itemID = 1013004, number = 1, weight = 10,},
		},
	},
	[1031012] = {
		typeNum = 1,
		treasure = {
			[1] = {itemID = 1021001, number = 3, weight = 20,},
			[2] = {itemID = 1021002, number = 3, weight = 20,},
			[3] = {itemID = 1021003, number = 3, weight = 20,},
			[4] = {itemID = 1021004, number = 3, weight = 20,},
			[5] = {itemID = 1022001, number = 3, weight = 10,},
			[6] = {itemID = 1022001, number = 3, weight = 10,},
			[7] = {itemID = 1031002, number = 2, weight = 10,},
		},
	},
	[1031013] = {
		typeNum = 1,
		treasure = {
			[1] = {itemID = 1021001, number = {1,2}, weight = 20,},
			[2] = {itemID = 1021002, number = {1,2}, weight = 20,},
			[3] = {itemID = 1021003, number = {1,2}, weight = 20,},
			[4] = {itemID = 1021004, number = {1,2}, weight = 20,},
			[5] = {itemID = 1022001, number = 1, weight = 10,},
			[6] = {itemID = 1024001, number = 1, weight = 20,},
			[7] = {itemID = 1024024, number = 1, weight = 20,},
		},
	},

}
