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
			npcs 		= {20004,20021,29066,29040,29059,29050,29072, },
			safeX 		= 124,
			safeY 		= 48,
		},

	[2] = { 
			map 		= "mp02.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {29069,20022,29075,29053,20007,29062, },
			safeX 		= 87,
			safeY 		= 13,
		},

	[3] = { 
			map 		= "mp03.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {20006,20023,29061,29074,29068,29052, },
			safeX 		= 96,
			safeY 		= 75,
		},

	[4] = { 
			map 		= "mp05.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {29060,20005,20025,29067,29051,29073, },
			safeX 		= 133,
			safeY 		= 62,
		},

	[5] = { 
			map 		= "mp04.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {20024,20009,29055,29077,29071,29064, },
			safeX 		= 119,
			safeY 		= 64,
		},

	[6] = { 
			map 		= "mp06.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {20026,29076,20008,29063,29054,29070, },
			safeX 		= 102,
			safeY 		= 63,
		},

	[7] = { 
			map 		= "bh01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {29080,29078,30817,29049, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[8] = { 
			map 		= "tg_xsc.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20001,20002,20003, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[9] = { 
			map 		= "xsc_new.mp",
			level 		= nil,
			mapType 	= MapType.City,
			npcs 		= {29009,29010,29011,20027,29012,29013,30251,20019,27073,27074,29014,29015, },
			safeX 		= 96,
			safeY 		= 74,
		},

	[10] = { 
			map 		= "ly00.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20059,30320,20049,29008,29048,29006,30250,20909,20018,20913,60000,27150,20011,29081,29079,29046,20928,29065,20012,20013,20014,20015,20016,29001,29002,29003,20106,20107,20108,29004,20017,39000,29056,29005,29007,20060, },
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
			npcs 		= {20638,20639,20635,20640,20637,20605,20724,20615,27078,27084,27079,20929,20901,27085,27080,20933,20911,20904,27086,27081,20940,20914,20905,27087,27082,21000,20917,20908,40002,27088,27083,20944,20944,27089,27095,27110,27094,27111,27126,27093,27112,27127,27117,27092,27113,27128,27104,27091,27114,27129,27105,27090,27115,27130,27106,27096,27116,27131,27107,27097,27132,27108,27098,27118,27140,27099,27119,27139,27137,27136,27135,27134,27100,27120,27102,27101,27121,27141,27103,27122,27109,27123,27133,25006,27124,27142,25018,25011,25005,27125,25025,25017,25010,25004,27138,27143,25031,25031,25024,25023,25016,25009,25003,27149,27144,25030,25022,25015,25014,25008,25002,27148,27147,27146,27145,25029,25021,25013,25007,25001,25028,25020,25019,25012,25027,25027,25026,20010,20026,20028,20032,20037,20071,20032,20103,20074,26009,20083,20076,26011,20086,20804,20809,20813,20813,20820,20823,20801,26010,20091,20901,20905,20908,20313,20911,20914,26012,20917,20904,20944,20933,20929,20940,26028,20309,20601,21000,21032,21002,21009,21033,20702,20625,20606,21034,20703,20707,20607,20608,21013,20752,20731,20626,20610,20764,21035,21015,20730,20714,20640,20615,20733,21035,20712,20619,20624,20734,21038,20719,20735,21037,20326,21039,20302,20327,20313,21032,20318,20322,21001,21033,21002,21015,21036,21010,21037,21013,21038,21016,21039,21017,21035,21018,21019,21034, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[13] = { 
			map 		= "xc_new_00.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {29036,20701,29037,29038,29029,29035,29034,29030,30257,30256,29033,29032,29039,27075,29031, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[14] = { 
			map 		= "xsc00.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {29057,27077,29019,30253,29020,30252,29018,29023,27076,29021,29022,29058, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[15] = { 
			map 		= "yw_yl02.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[16] = { 
			map 		= "cs_hg.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[99] = { 
			map 		= "ceshi.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[101] = { 
			map 		= "xc03.mp",
			level 		= 5,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[102] = { 
			map 		= "jy03.mp",
			level 		= 10,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[103] = { 
			map 		= "yw_yl01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[104] = { 
			map 		= "jy04.mp",
			level 		= 15,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
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
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[107] = { 
			map 		= "cd_02.mp",
			level 		= 25,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
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
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[110] = { 
			map 		= "ly15.mp",
			level 		= 30,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
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
			map 		= "tg_xsc.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {20070, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[113] = { 
			map 		= "yw_yl01.mp",
			level 		= 0,
			mapType 	= MapType.Task,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
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
			safeX 		= 0,
			safeY 		= 0,
			subMineInfo 	= {scriptID = 17},
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[116] = { 
			map 		= "yw_hd04.mp",
			level 		= 35,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[118] = { 
			map 		= "yw_by04.mp",
			level 		= 30,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[119] = { 
			map 		= "ly03.mp",
			level 		= 37,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[120] = { 
			map 		= "cd03.mp",
			level 		= 40,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[122] = { 
			map 		= "cd06.mp",
			level 		= 43,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[124] = { 
			map 		= "yw_by03.mp",
			level 		= 46,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[126] = { 
			map 		= "yw_ld04.mp",
			level 		= 44,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[127] = { 
			map 		= "xc02.mp",
			level 		= 50,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
			revivePoint 	= {y = 32, mapID = 9, x = 93, r = 5},
		},

	[128] = { 
			map 		= "yw_hd03.mp",
			level 		= 48,
			mapType 	= MapType.Wild,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
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
			safeX 		= 0,
			safeY 		= 0,
		},

	[400] = { 
			map 		= "xsc01.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[401] = { 
			map 		= "yw_dg01m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[402] = { 
			map 		= "fb_gt01m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[403] = { 
			map 		= "yw_jt08m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[404] = { 
			map 		= "yw_jt07m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[405] = { 
			map 		= "cd01m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[406] = { 
			map 		= "fbx30m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[407] = { 
			map 		= "yw_gt05m.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[408] = { 
			map 		= "ly14.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[600] = { 
			map 		= "yw_ld03.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30027,30030,30028,30043,30042,30031,30041,30029,30034,30032,30033,30040,30035,30039,30038,30037,30036, },
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
			npcs 		= {30147,30124,30125,30104,30105,30100,30138,30140,30141,30106,30142,30118,30139,30117,30137,30136,30133,30135,30122,30123,30132,30099,30121,30116,30145,30120,30146,30130,30131,30097,30119,30098,30134,30144,30143,30129,30114,30115,30096, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[606] = { 
			map 		= "yw_dk01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30218,30235,30219,30188,30201,30236,30189,30215,30200,30234,30190,30199,30216,30233,30187,30217,30211,30229,30230,30196,30220,30203,30214,30237,30204,30221,30191,30202,30213,30198,30186,30243,30207,30227,30197,30195,30228,30192,30222,30194,30225,30193,30223,30224,30226,30238,30205,30208,30206,30239,30242,30210,30209,30241,30240,30231,30212, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[607] = { 
			map 		= "yw_jt08.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30393,30394,30395,30376,30383,30382,30377,30398,30392,30384,30385,30381,30390,30380,30378,30379,30389,30375,30396,30374,30372,30373,30401,30387,30370, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[608] = { 
			map 		= "yw_df04.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30483,30482,30495,30496,30497,30494,30479,30484,30498,30488,30493,30492,30489,30481,30480,30490,30499,30491, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[609] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30564,30578,30565,30569,30579,30570,30599,30563,30580,30594,30551,30595,30552,30596,30562,30581,30561,30583,30582,30560,30553,30597,30566,30591,30554,30559,30598,30593,30592,30584,30558,30557,30586,30568,30556,30590,30555,30567,30585,30587,30589,30588, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[610] = { 
			map 		= "cd08.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30723,30704,30717,30722,30700,30718,30724,30706,30719,30707,30703,30712,30709,30721,30711,30701,30720,30702,30725,30726,30713,30716,30727,30715,30728, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[611] = { 
			map 		= "yw_dk04.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30806,30805,30810,30804,30803,30802,30794,30783,30782,30796,30797,30781,30784,30791,30785,30793,30795,30801,30792,30786,30790,30798,30789,30800,30788,30787,30799, },
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
			npcs 		= {30957,30948,30947,30946,30964,30944,30945,30970,30954,30969,30955,30953,30956,30960,30935,30959,30934,30943,30949,30958,30961,30962,30942,30933,30963,30941,30950,30932,30940,30939,30966,30967,30938,30965,30952,30937,30931,30936, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[614] = { 
			map 		= "fb_cx01.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {30982,30983,30980,30981,30979,30978,30977,31000,30984,30985,30994,30999,30986,30992,30991,30990,30976,30987,30993,31002,30974,30988,31001,30975,30989,30998,31003,31005,31006,31004,30997,30995,30973,30996,30972,30971, },
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
			npcs 		= {},
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
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[622] = { 
			map 		= "yw_jt05.mp",
			level 		= 0,
			mapType 	= MapType.Copy,
			npcs 		= {31231,31232,31243,31247,31244,31239,31240,31246,31245,31242,31228,31237,31241,31230,31229,31238,31234,31233,31235,31236,31227,31226,31225, },
			safeX 		= 0,
			safeY 		= 0,
		},

	[901] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[902] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[903] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

	[904] = { 
			map 		= "ly03.mp",
			level 		= 0,
			mapType 	= MapType.City,
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
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
			npcs 		= {},
			safeX 		= 0,
			safeY 		= 0,
		},

}
