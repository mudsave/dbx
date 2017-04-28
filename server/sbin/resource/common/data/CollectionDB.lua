--[[CollectionDB.lua
描述：采集地图点配置_服务器
	]]
PosEnum = { 
	fixedPos        = 1,    --刷新的位置是固定点
	fixedRandPos    = 2,    --在固定的几个点中刷新
	randPos         = 3,    --刷新的位置是随机的
	uperRandPos     = 4,    --上限刷新
}

CollectionDB ={ 

	[101] = {
		{
		    itemID = 10013,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
	},
	[102] = {
		{
		    itemID = 10013,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
	},
	[104] = {
		{
		    itemID = 10013,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
	},
	[106] = {
		{
		    itemID = 10012,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 1800,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
		{
		    itemID = 10002,
		    posType = 1,
		    posData = {
			{169,191},
		    },
		    repeatable  = true,
		    interval = 10,
		},
	},
	[107] = {
		{
		    itemID = 10012,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 1800,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
	},
	[109] = {
		{
		    itemID = 10012,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 1800,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
	},
	[110] = {
		{
		    itemID = 10003,
		    posType = 1,
		    posData = {
			{51,147},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10006,
		    posType = 1,
		    posData = {
			{136,150},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 1800,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 15,
		},
	},
	[115] = {
		{
		    itemID = 10004,
		    posType = 1,
		    posData = {
			{167,156},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 1800,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 15,
		},
	},
	[116] = {
		{
		    itemID = 10001,
		    posType = 1,
		    posData = {
			{56,230},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10007,
		    posType = 1,
		    posData = {
			{64,263},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10008,
		    posType = 1,
		    posData = {
			{58,190},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10009,
		    posType = 1,
		    posData = {
			{113,128},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10010,
		    posType = 1,
		    posData = {
			{185,71},
		    },
		    repeatable  = true,
		    interval = 10,
		},
		{
		    itemID = 10011,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 3600,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 1800,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 60,
		    number = 3,
		    amount = 10,
		},
	},
	[118] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[119] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[120] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[122] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[124] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[126] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[127] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[128] = {
		{
		    itemID = 10011,
		    posType = 4,
		posData =     {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 3,
		},
		{
		    itemID = 10012,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 2,
		    amount = 5,
		},
		{
		    itemID = 10013,
		    posType = 4,
		    posData = {
			-1
		    },		    repeatable  = true,
		    interval = 10,
		    number = 3,
		    amount = 10,
		},
	},
	[129] = {
		{
		    itemID = 10005,
		    posType = 1,
		    posData = {
			{46,126},
		    },
		    repeatable  = true,
		    interval = 10,
		    number = 1,
		    amount = 1,
		},
	},
}
