--MapDB.lua





require "misc.constant"


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
			npcs 		= {20004,20021,29066,29040,50051,29059,29050,29072, },
			safeX 		= 124,
			safeY 		= 48,
		},

	[2] = { 
			map 		= "mp02.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {29069,20022,29075,29053,20007,50056,29062, },
			safeX 		= 85,
			safeY 		= 22,
		},

	[3] = { 
			map 		= "mp03.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {20006,20023,29061,29074,50052,29068,29052, },
			safeX 		= 96,
			safeY 		= 75,
		},

	[4] = { 
			map 		= "mp05.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {29060,20005,20025,50055,29067,29051,29073, },
			safeX 		= 133,
			safeY 		= 62,
		},

	[5] = { 
			map 		= "mp04.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {50054,20024,20009,29055,29077,29071,29064, },
			safeX 		= 119,
			safeY 		= 64,
		},

	[6] = { 
			map 		= "mp06.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {20026,29076,20008,29063,50053,29054,29070, },
			safeX 		= 102,
			safeY 		= 63,
		},

	[7] = { 
			map 		= "bh01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {40034,29080,29084,40033,29078,30817,29049,40032, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[8] = { 
			map 		= "tg_xsc.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20001,20002,20003, },
			safeX 		= 101,
			safeY 		= 142,
		},

	[9] = { 
			map 		= "xsc_new.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {29009,29010,29011,20027,29012,29013,27073,30253,27074,29014,29015, },
			safeX 		= 96,
			safeY 		= 74,
		},

	[10] = { 
			map 		= "ly00.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20059,30320,20049,29081,60500,29008,29048,29006,29083,50050,39050,30252,60000,27150,20011,29079,29046,20928,29065,20012,20013,20014,29082,20015,20016,29001,29002,29003,20106,20107,20108,29004,20017,39000,29056,29005,29007, },
			safeX 		= 189,
			safeY 		= 208,
			compareArea 	= {{x2 = 148, y2 = 171, y1 = 147, x1 = 131}},
		},

	[11] = { 
			map 		= "xsc03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[12] = { 
			map 		= "ceshi.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20638,20639,20635,20640,20637,20605,20724,20615,27078,27084,27079,20929,20901,27085,27080,20933,20911,20904,27086,27081,20940,20914,20905,27087,27082,21000,20917,20908,40002,27088,27083,20944,20944,27089,27095,27110,27094,27111,27126,27093,27112,27127,27117,27092,27113,27128,27104,27091,27114,27129,27105,27090,27115,27130,27106,27096,27116,27131,27107,27097,27132,20029,27108,27098,27118,27140,20030,27099,27119,27139,27137,27136,27135,27134,20031,27100,27120,20038,27101,27102,27121,27141,20044,27103,27122,20045,27109,27123,27133,20046,20047,20048,20051,20053,20055,25006,27124,27142,20056,25018,25011,25005,27125,20067,25025,25017,25010,25004,27138,27143,20070,25031,25031,25024,25023,25016,25009,25003,27149,27144,20071,25030,25022,25015,25014,25008,25002,27148,27147,27146,27145,20076,25029,25021,25013,25007,25001,20077,25028,25020,25019,25012,20079,25027,25027,20084,25026,20089,20095,20098,20101,20109,20010,20026,20028,20032,20037,20071,20032,20074,26009,20083,20076,26011,20086,20804,20809,20813,20813,20820,20823,20801,26010,20091,20901,20905,20908,20313,20911,20914,26012,20917,20904,20944,20933,20929,20940,26028,20309,20601,21000,21032,21002,21009,21033,20702,20625,20606,21034,20703,20707,20607,20608,21013,20752,20731,20626,20610,20764,21035,21015,20730,20714,20640,20615,20733,21035,20712,20619,20624,20734,21038,20719,20735,21037,20326,21039,20302,20327,20313,21032,20318,20322,21001,21033,21002,21015,21036,21010,21037,21013,21038,21016,21039,21017,21035,21018,21019,21034, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[13] = { 
			map 		= "xc_new_00.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {29036,20701,29037,29038,29029,29035,29034,30255,29030,29033,29032,29039,27075,29031, },
			safeX 		= 103,
			safeY 		= 133,
		},

	[14] = { 
			map 		= "xsc00.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {29057,27077,29019,29020,30254,29018,29023,27076,28022,29021,29022,29058, },
			safeX 		= 56,
			safeY 		= 86,
		},

	[15] = { 
			map 		= "yw_yl02.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[98] = { 
			map 		= "ceshi.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20349,21105,28011,28010,21106,28012,28009,21116,28013,28008,28007,21121,28014,28006,21122,28015,28005,21127,28016,28004,21132,28017,28020,28003,28003,21133,28018,28002,21138,28019,28001,21163,21141,21158,21151,21157,21152, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[99] = { 
			map 		= "ceshi.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {40011,40012,30250,40013,40014,30251,40015,40016, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[101] = { 
			map 		= "xc03.mp",
			level 		= 5,
			mapType 	= MapType.Wild,
			npcs 		= {1,2, },
			safeX 		= 106,
			safeY 		= 140,
			subMineInfo 	= {scriptID = 1},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[102] = { 
			map 		= "jy03.mp",
			level 		= 10,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 136,
			safeY 		= 120,
			subMineInfo 	= {scriptID = 11},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[103] = { 
			map 		= "yw_yl01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[104] = { 
			map 		= "jy04.mp",
			level 		= 15,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 110,
			safeY 		= 138,
			subMineInfo 	= {scriptID = 12},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[105] = { 
			map 		= "cd06.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[106] = { 
			map 		= "yw_yl01.mp",
			level 		= 20,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 105,
			safeY 		= 204,
			subMineInfo 	= {scriptID = 13},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[107] = { 
			map 		= "cd_02.mp",
			level 		= 25,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 164,
			safeY 		= 101,
			subMineInfo 	= {scriptID = 14},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[108] = { 
			map 		= "mp03.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[109] = { 
			map 		= "ly14.mp",
			level 		= 28,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 151,
			safeY 		= 124,
			subMineInfo 	= {scriptID = 15},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[110] = { 
			map 		= "ly15.mp",
			level 		= 30,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 199,
			safeY 		= 112,
			subMineInfo 	= {scriptID = 16},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[111] = { 
			map 		= "fb_xs.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[112] = { 
			map 		= "cd02_02.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {20078,20113, },
			safeX 		= 121,
			safeY 		= 34,
		},

	[113] = { 
			map 		= "yw_yl01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 86,
			safeY 		= 151,
		},

	[114] = { 
			map 		= "cd01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {20711,20726, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[115] = { 
			map 		= "xc05.mp",
			level 		= 33,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 150,
			safeY 		= 128,
			subMineInfo 	= {scriptID = 17},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[116] = { 
			map 		= "yw_hd04.mp",
			level 		= 35,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 227,
			safeY 		= 135,
			subMineInfo 	= {scriptID = 18},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[118] = { 
			map 		= "yw_by04.mp",
			level 		= 30,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 176,
			safeY 		= 79,
			subMineInfo 	= {scriptID = 27},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[119] = { 
			map 		= "ly03.mp",
			level 		= 37,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 175,
			safeY 		= 133,
			subMineInfo 	= {scriptID = 19},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[120] = { 
			map 		= "cd03.mp",
			level 		= 40,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 230,
			safeY 		= 104,
			subMineInfo 	= {scriptID = 20},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[122] = { 
			map 		= "cd06.mp",
			level 		= 43,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 80,
			safeY 		= 149,
			subMineInfo 	= {scriptID = 21},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[124] = { 
			map 		= "yw_by03.mp",
			level 		= 46,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 151,
			safeY 		= 123,
			subMineInfo 	= {scriptID = 22},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[126] = { 
			map 		= "yw_ld04.mp",
			level 		= 44,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 146,
			safeY 		= 142,
			subMineInfo 	= {scriptID = 23},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[127] = { 
			map 		= "xc02.mp",
			level 		= 50,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 143,
			safeY 		= 167,
			subMineInfo 	= {scriptID = 24},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[128] = { 
			map 		= "yw_hd03.mp",
			level 		= 48,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 92,
			safeY 		= 206,
			subMineInfo 	= {scriptID = 25},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[129] = { 
			map 		= "cd02_02.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {20829,20834, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[130] = { 
			map 		= "fb_gt01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[131] = { 
			map 		= "ly04.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 34,
			safeY 		= 16,
		},

	[132] = { 
			map 		= "yw_hd02.mp",
			level 		= 0,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 255,
			safeY 		= 116,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[133] = { 
			map 		= "xc04.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[400] = { 
			map 		= "xsc01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[401] = { 
			map 		= "yw_dg01m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[402] = { 
			map 		= "fb_gt01m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[403] = { 
			map 		= "yw_jt08m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[404] = { 
			map 		= "yw_jt07m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[405] = { 
			map 		= "cd01m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[406] = { 
			map 		= "fbx30m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[407] = { 
			map 		= "yw_gt05m.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[408] = { 
			map 		= "ly14.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[409] = { 
			map 		= "yw_df04.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[410] = { 
			map 		= "yw_df03.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[411] = { 
			map 		= "yw_ys01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[412] = { 
			map 		= "yw_jt08.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[413] = { 
			map 		= "yw_df04.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[414] = { 
			map 		= "yw_df03.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[415] = { 
			map 		= "jy05.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[416] = { 
			map 		= "yw_dk01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[417] = { 
			map 		= "yw_ys01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 185,
			safeY 		= 67,
		},

	[418] = { 
			map 		= "fb_zc01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 68,
			safeY 		= 225,
		},

	[500] = { 
			map 		= "yw_jt06.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {31481,31486,31485,31490,31489,31484,31482,31487,31488,31483, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[501] = { 
			map 		= "fb_by01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31508,31512,31515,31519,31504,31509,31506,31510,31505,31502,31507,31513,31516,31517,31518,31501,31511,31520,31514,31503,31500, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[600] = { 
			map 		= "yw_ld03.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30027,30030,30028,30043,30042,30031,30029,30034,30032,30040,30035,30039,30038,30036, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[601] = { 
			map 		= "yw_ld04.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30047,30048,30049,30050, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[602] = { 
			map 		= "yw_hd02.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30147,30125,30104,30140,30141,30106,30142,30139,30137,30145,30136,30146,30133,30135,30097,30119,30098,30134,30123,30129,30114,30115,30096, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[606] = { 
			map 		= "yw_dk01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30218,30219,30188,30189,30215,30200,30234,30190,30216,30187,30217,30211,30230,30203,30237,30202,30198,30243,30207,30228,30224,30238,30205,30208,30242,30210,30209,30241,30240,30212, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[607] = { 
			map 		= "yw_jt08.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30393,30394,30383,30398,30392,30390,30380,30378,30379,30389,30375,30396,30373,30401,30387,30370, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[608] = { 
			map 		= "yw_df04.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30496,30497,30494,30479,30484,30498,30493,30492,30489,30481,30480,30490,30491, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[609] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30564,30578,30565,30579,30599,30580,30594,30562,30581,30561,30582,30560,30597,30591,30598,30593,30592,30586,30568,30556,30590,30555,30567,30585,30587,30589,30588, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[610] = { 
			map 		= "cd08.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30723,30704,30717,30718,30706,30719,30707,30709,30721,30711,30701,30720,30702,30725,30726,30727,30728, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[611] = { 
			map 		= "yw_dk04.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30810,30802,30794,30783,30782,30796,30797,30781,30784,30791,30785,30801,30786,30790,30798,30789,30800,30788,30787,30799, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[612] = { 
			map 		= "xc05.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30880,30879,30884,30887,30866,30881,30867,30885,30888,30882,30871,30868,30878,30877,30869,30883,30889,30875,30876,30874,30886,30870,30872,30873, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[613] = { 
			map 		= "yw_zz01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30957,30948,30946,30964,30945,30955,30953,30956,30960,30959,30934,30943,30949,30958,30961,30942,30933,30963,30941,30950,30932,30939,30952,30931,30936, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[614] = { 
			map 		= "fb_cx01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30982,30981,30979,30978,31000,30984,30999,30992,30991,30976,30987,30974,31001,30989,30998,31006,31004,30973,30996,30972, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[615] = { 
			map 		= "yw_tg04.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31087,31085,31064,31084,31086,31083,31065,31082,31063,31062,31061,31081, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[616] = { 
			map 		= "yw_tg03.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31094,31070,31096,31071,31093,31095,31091,31090,31073,31068,31089,31092,31088, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[617] = { 
			map 		= "yw_jt08.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31170,31168,31163,31165,31167,31169,31162,31164,31166,31161, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[618] = { 
			map 		= "yw_dg01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31151,31156,31155,31154,31157,31152,31153,31159,31158,31160, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[619] = { 
			map 		= "ly14.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31411,31412,31414,31413,31408,31409,31410,31418,31419,31421,31422,31420,31405,31407,31406,31416,31417,31415,31404,31403, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[620] = { 
			map 		= "yw_df03.mp",
			level 		= 35,
			mapType 	= MapType.Copy,
			npcs 		= {31292,31289,31286,31287,31291,31285,31284,31290,31283,31288, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[621] = { 
			map 		= "yw_jt07.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31353,31352,31344,31342,31357,31356,31347,31341,31354,31355,31338,31339,31333,31351,31350,31335, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[622] = { 
			map 		= "yw_jt05.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31231,31232,31247,31246,31245,31228,31237,31240,31230,31239,31229,31238,31234,31233,31235,31236,31227,31226,31225, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[800] = { 
			map 		= "hd_ttt_03.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {},
			safeX 		= 45,
			safeY 		= 33,
		},

	[901] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60001, },
			safeX 		= 75,
			safeY 		= 118,
		},

	[902] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60002, },
			safeX 		= 75,
			safeY 		= 118,
		},

	[903] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60003, },
			safeX 		= 75,
			safeY 		= 118,
		},

	[904] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60004, },
			safeX 		= 75,
			safeY 		= 118,
		},

	[905] = { 
			map 		= "fb_xj01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[906] = { 
			map 		= "fb_xj01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[907] = { 
			map 		= "fb_xj01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[908] = { 
			map 		= "fb_xj01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[909] = { 
			map 		= "pvp_lc.mp",
			level 		= 0,
			mapType 	= nil,
			npcs 		= {39051, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[1001] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60503,60502,60504,60501,60508,60505,60507,60506, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1002] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60511,60510,60512,60509,60516,60513,60515,60514, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1003] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60519,60518,60520,60517,60524,60521,60523,60522, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1004] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60527,60526,60528,60525,60532,60529,60531,60530, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1005] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60535,60534,60536,60533,60540,60537,60539,60538, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1006] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60543,60542,60544,60541,60548,60545,60547,60546, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1007] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60551,60550,60552,60549,60556,60553,60555,60554, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1008] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60559,60558,60560,60557,60564,60561,60563,60562, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1009] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60567,60566,60568,60565,60572,60569,60571,60570, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1010] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60575,60574,60576,60573,60580,60577,60579,60578, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1011] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60583,60582,60584,60581,60588,60585,60587,60586, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1012] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60591,60590,60592,60589,60596,60593,60595,60594, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1013] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60599,60598,60600,60597,60604,60601,60603,60602, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1014] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60607,60606,60608,60605,60612,60609,60611,60610, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1015] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60615,60614,60616,60613,60620,60617,60619,60618, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1016] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60623,60622,60624,60621,60628,60625,60627,60626, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1017] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60631,60630,60632,60629,60636,60633,60635,60634, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1018] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60639,60638,60640,60637,60644,60641,60643,60642, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1019] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60647,60646,60648,60645,60652,60649,60651,60650, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1020] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60655,60654,60656,60653,60660,60657,60659,60658, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1021] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60663,60662,60664,60661,60668,60665,60667,60666, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1022] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60671,60670,60672,60669,60676,60673,60675,60674, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1023] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60679,60678,60680,60677,60684,60681,60683,60682, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1024] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60687,60686,60688,60685,60692,60689,60691,60690, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1025] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60695,60694,60696,60693,60700,60697,60699,60698, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1026] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60703,60702,60704,60701,60708,60705,60707,60706, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1027] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60711,60710,60712,60709,60716,60713,60715,60714, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1028] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60719,60718,60720,60717,60724,60721,60723,60722, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1029] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60727,60726,60728,60725,60732,60729,60731,60730, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1030] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60735,60734,60736,60733,60740,60737,60739,60738, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1031] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60743,60742,60744,60741,60748,60745,60747,60746, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1032] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60751,60750,60752,60749,60756,60753,60755,60754, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1033] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60759,60758,60760,60757,60764,60761,60763,60762, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1034] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60767,60766,60768,60765,60772,60769,60771,60770, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1035] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60775,60774,60776,60773,60780,60777,60779,60778, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1036] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60783,60782,60784,60781,60788,60785,60787,60786, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1037] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60791,60790,60792,60789,60796,60793,60795,60794, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1038] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60799,60798,60800,60797,60804,60801,60803,60802, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1039] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60807,60806,60808,60805,60812,60809,60811,60810, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1040] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60815,60814,60816,60813,60820,60817,60819,60818, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1041] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60823,60822,60824,60821,60828,60825,60827,60826, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1042] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60831,60830,60832,60829,60836,60833,60835,60834, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1043] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60839,60838,60840,60837,60844,60841,60843,60842, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1044] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60847,60846,60848,60845,60852,60849,60851,60850, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1045] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60855,60854,60856,60853,60860,60857,60859,60858, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1046] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60863,60862,60864,60861,60868,60865,60867,60866, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1047] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60871,60870,60872,60869,60876,60873,60875,60874, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1048] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60879,60878,60880,60877,60884,60881,60883,60882, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1049] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60887,60886,60888,60885,60892,60889,60891,60890, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1050] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60895,60894,60896,60893,60900,60897,60899,60898, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1051] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60903,60902,60904,60901,60908,60905,60907,60906, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1052] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60911,60910,60912,60909,60916,60913,60915,60914, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1053] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60919,60918,60920,60917,60924,60921,60923,60922, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1054] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60927,60926,60928,60925,60932,60929,60931,60930, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1055] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60935,60934,60936,60933,60940,60937,60939,60938, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1056] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60943,60942,60944,60941,60948,60945,60947,60946, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1057] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60951,60950,60952,60949,60956,60953,60955,60954, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1058] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60959,60958,60960,60957,60964,60961,60963,60962, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1059] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60967,60966,60968,60965,60972,60969,60971,60970, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1060] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60975,60974,60976,60973,60980,60977,60979,60978, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1061] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60983,60982,60984,60981,60988,60985,60987,60986, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1062] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60991,60990,60992,60989,60996,60993,60995,60994, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1063] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {60999,60998,61000,60997,61004,61001,61003,61002, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1064] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61007,61006,61008,61005,61012,61009,61011,61010, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1065] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61015,61014,61016,61013,61020,61017,61019,61018, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1066] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61023,61022,61024,61021,61028,61025,61027,61026, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1067] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61031,61030,61032,61029,61036,61033,61035,61034, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1068] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61039,61038,61040,61037,61044,61041,61043,61042, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1069] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 41,
			safeY 		= 25,
		},

	[1070] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61055,61054,61056,61053,61060,61057,61059,61058, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1071] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61063,61062,61064,61061,61068,61065,61067,61066, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1072] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61071,61070,61072,61069,61076,61073,61075,61074, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1073] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61079,61078,61080,61077,61084,61081,61083,61082, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1074] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61087,61086,61088,61085,61092,61089,61091,61090, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1075] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61095,61094,61096,61093,61100,61097,61099,61098, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1076] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61103,61102,61104,61101,61108,61105,61107,61106, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1077] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61111,61110,61112,61109,61116,61113,61115,61114, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1078] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61119,61118,61120,61117,61124,61121,61123,61122, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1079] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61127,61126,61128,61125,61132,61129,61131,61130, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1080] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61135,61134,61136,61133,61140,61137,61139,61138, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1081] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61143,61142,61144,61141,61148,61145,61147,61146, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1082] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61151,61150,61152,61149,61156,61153,61155,61154, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1083] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61159,61158,61160,61157,61164,61161,61163,61162, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1084] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61167,61166,61168,61165,61172,61169,61171,61170, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1085] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61175,61174,61176,61173,61180,61177,61179,61178, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1086] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61183,61182,61184,61181,61188,61185,61187,61186, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1087] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61191,61190,61192,61189,61196,61193,61195,61194, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1088] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61199,61198,61200,61197,61204,61201,61203,61202, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1089] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61207,61206,61208,61205,61212,61209,61211,61210, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1090] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61215,61214,61216,61213,61220,61217,61219,61218, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1091] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61223,61222,61224,61221,61228,61225,61227,61226, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1092] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61231,61230,61232,61229,61236,61233,61235,61234, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1093] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61239,61238,61240,61237,61244,61241,61243,61242, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1094] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61247,61246,61248,61245,61252,61249,61251,61250, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1095] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61255,61254,61256,61253,61260,61257,61259,61258, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1096] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61263,61262,61264,61261,61268,61265,61267,61266, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1097] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61271,61270,61272,61269,61276,61273,61275,61274, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1098] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61279,61278,61280,61277,61284,61281,61283,61282, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1099] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61287,61286,61288,61285,61292,61289,61291,61290, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1100] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61295,61294,61296,61293,61300,61297,61299,61298, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1101] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61303,61302,61304,61301,61308,61305,61307,61306, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1102] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61311,61310,61312,61309,61316,61313,61315,61314, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1103] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61319,61318,61320,61317,61324,61321,61323,61322, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1104] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61327,61326,61328,61325,61332,61329,61331,61330, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1105] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61335,61334,61336,61333,61340,61337,61339,61338, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1106] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61343,61342,61344,61341,61348,61345,61347,61346, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1107] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61351,61350,61352,61349,61356,61353,61355,61354, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1108] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61359,61358,61360,61357,61364,61361,61363,61362, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1109] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61367,61366,61368,61365,61372,61369,61371,61370, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1110] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61375,61374,61376,61373,61380,61377,61379,61378, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1111] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61383,61382,61384,61381,61388,61385,61387,61386, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1112] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61391,61390,61392,61389,61396,61393,61395,61394, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1113] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61399,61398,61400,61397,61404,61401,61403,61402, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1114] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61407,61406,61408,61405,61412,61409,61411,61410, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1115] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61415,61414,61416,61413,61420,61417,61419,61418, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1116] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61423,61422,61424,61421,61428,61425,61427,61426, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1117] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61431,61430,61432,61429,61436,61433,61435,61434, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1118] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61439,61438,61440,61437,61444,61441,61443,61442, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1119] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61447,61446,61448,61445,61452,61449,61451,61450, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1120] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61455,61454,61456,61453,61460,61457,61459,61458, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1121] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61463,61462,61464,61461,61468,61465,61467,61466, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1122] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61471,61470,61472,61469,61476,61473,61475,61474, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1123] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61479,61478,61480,61477,61484,61481,61483,61482, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1124] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61487,61486,61488,61485,61492,61489,61491,61490, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1125] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61495,61494,61496,61493,61500,61497,61499,61498, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1126] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61503,61502,61504,61501,61508,61505,61507,61506, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1127] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61511,61510,61512,61509,61516,61513,61515,61514, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1128] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61519,61518,61520,61517,61524,61521,61523,61522, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1129] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61527,61526,61528,61525,61532,61529,61531,61530, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1130] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61535,61534,61536,61533,61540,61537,61539,61538, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1131] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61543,61542,61544,61541,61548,61545,61547,61546, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1132] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61551,61550,61552,61549,61556,61553,61555,61554, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1133] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61559,61558,61560,61557,61564,61561,61563,61562, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1134] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61567,61566,61568,61565,61572,61569,61571,61570, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1135] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61575,61574,61576,61573,61580,61577,61579,61578, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1136] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61583,61582,61584,61581,61588,61585,61587,61586, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1137] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61591,61590,61592,61589,61596,61593,61595,61594, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1138] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61599,61598,61600,61597,61604,61601,61603,61602, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1139] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61607,61606,61608,61605,61612,61609,61611,61610, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1140] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61615,61614,61616,61613,61620,61617,61619,61618, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1141] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61623,61622,61624,61621,61628,61625,61627,61626, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1142] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61631,61630,61632,61629,61636,61633,61635,61634, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1143] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61639,61638,61640,61637,61644,61641,61643,61642, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1144] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61647,61646,61648,61645,61652,61649,61651,61650, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1145] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61655,61654,61656,61653,61660,61657,61659,61658, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1146] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61663,61662,61664,61661,61668,61665,61667,61666, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1147] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61671,61670,61672,61669,61676,61673,61675,61674, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1148] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61679,61678,61680,61677,61684,61681,61683,61682, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1149] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61687,61686,61688,61685,61692,61689,61691,61690, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1150] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61695,61694,61696,61693,61700,61697,61699,61698, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1151] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61703,61702,61704,61701,61708,61705,61707,61706, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1152] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61711,61710,61712,61709,61716,61713,61715,61714, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1153] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61719,61718,61720,61717,61724,61721,61723,61722, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1154] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61727,61726,61728,61725,61732,61729,61731,61730, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1155] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61735,61734,61736,61733,61740,61737,61739,61738, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1156] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61743,61742,61744,61741,61748,61745,61747,61746, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1157] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61751,61750,61752,61749,61756,61753,61755,61754, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1158] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61759,61758,61760,61757,61764,61761,61763,61762, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1159] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61767,61766,61768,61765,61772,61769,61771,61770, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1160] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61775,61774,61776,61773,61780,61777,61779,61778, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1161] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61783,61782,61784,61781,61788,61785,61787,61786, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1162] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61791,61790,61792,61789,61796,61793,61795,61794, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1163] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61799,61798,61800,61797,61804,61801,61803,61802, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1164] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61807,61806,61808,61805,61812,61809,61811,61810, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1165] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61815,61814,61816,61813,61820,61817,61819,61818, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1166] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61823,61822,61824,61821,61828,61825,61827,61826, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1167] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61831,61830,61832,61829,61836,61833,61835,61834, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1168] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61839,61838,61840,61837,61844,61841,61843,61842, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1169] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61847,61846,61848,61845,61852,61849,61851,61850, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1170] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61855,61854,61856,61853,61860,61857,61859,61858, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1171] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61863,61862,61864,61861,61868,61865,61867,61866, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1172] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61871,61870,61872,61869,61876,61873,61875,61874, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1173] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61879,61878,61880,61877,61884,61881,61883,61882, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1174] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61887,61886,61888,61885,61892,61889,61891,61890, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1175] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61895,61894,61896,61883,61900,61897,61899,61898, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1176] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61903,61902,61904,61901,61908,61905,61907,61906, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1177] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61911,61910,61912,61909,61916,61913,61915,61914, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1178] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61919,61918,61920,61917,61924,61921,61923,61922, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1179] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61927,61926,61928,61925,61932,61929,61931,61930, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1180] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61935,61934,61936,61933,61940,61937,61939,61938, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1181] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61943,61942,61944,61941,61948,61945,61947,61946, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1182] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61951,61950,61952,61949,61956,61953,61955,61954, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1183] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61959,61958,61960,61957,61964,61961,61963,61962, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1184] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61967,61966,61968,61965,61972,61969,61971,61970, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1185] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61975,61974,61976,61973,61980,61977,61979,61978, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1186] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61983,61982,61984,61981,61988,61985,61987,61986, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1187] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61991,61990,61992,61989,61996,61993,61995,61994, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1188] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {61999,61998,62000,61997,62004,62001,62003,62002, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1189] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62007,62006,62008,62005,62012,62009,62011,62010, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1190] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62015,62014,62016,62013,62020,62017,62019,62018, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1191] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62023,62022,62024,62021,62028,62025,62027,62026, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1192] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62031,62030,62032,62029,62036,62033,62035,62034, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1193] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62039,62038,62040,62037,62044,62041,62043,62042, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1194] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62047,62046,62048,62045,62052,62049,62051,62050, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1195] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62055,62054,62056,62053,62060,62057,62059,62058, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1196] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62063,62062,62064,62061,62068,62065,62067,62066, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1197] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62071,62070,62072,62069,62076,62073,62075,62074, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1198] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62079,62078,62080,62077,62084,62081,62083,62082, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1199] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62087,62086,62088,62085,62092,62089,62091,62090, },
			safeX 		= 41,
			safeY 		= 25,
		},

	[1200] = { 
			map 		= "hd_ttt_05.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {62095,62094,62096,62093,62100,62097,62099,62098, },
			safeX 		= 41,
			safeY 		= 25,
		},

}
