--[[RingEctypeDB.lua
描述:
	连环副本配置
]]

-- 连环副本配置表
tRingEctypeDB =
{
------------------------------------------------- 35级连环经验副本-----------------------------------------------------------
	[1] =
	{
		EnterNeedLevel = {minLevel = 35, maxLevel = 44},
		-- 所有子副本
		tAllEctypes =
		{
			-- 第1个子副本
			[1] =
			{
				-- 对应的副本ID
				EctypeID = 2013,
			},
			-- 第2个子副本
			[2] =
			{
				-- 对应的副本ID
				EctypeID = 2014,
			},
			-- 第3个子副本
			[3] =
			{
				-- 对应的副本ID
				EctypeID = 2015,
			},
			-- 第4个子副本
			[4] =
			{
				-- 对应的副本ID
				EctypeID = 2016,
			},
		},

		-- 连环副本奖励，这个奖励跟环数和进度挂钩，跟具体的副本没关系
		tPrizes =
		{
			-- 第1环
			[1] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第2环
			[2] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 1500,--经验
					MoneyPrize = 1500,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第3环
			[3] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 2000,--经验
					MoneyPrize = 2000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第4环
			[4] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 2500,--经验
					MoneyPrize = 2500,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
	            	},
         	},
           },
--------------------------------------------------------- 35级连环潜能副本 -----------------------------------------------
	[2] =
	{
		EnterNeedLevel = {minLevel = 35, maxLevel = 44},
		-- 所有子副本
		tAllEctypes =
		{
			-- 第1个子副本
			[1] =
			{
				-- 对应的副本ID
				EctypeID = 2001,
			},
			-- 第2个子副本
			[2] =
			{
				-- 对应的副本ID
				EctypeID = 2002,
			},
			-- 第3个子副本
			[3] =
			{
				-- 对应的副本ID
				EctypeID = 2003,
			},
			-- 第4个子副本
			[4] =
			{
				-- 对应的副本ID
				EctypeID = 2004,
			},
		},

		-- 连环副本奖励，这个奖励跟环数和进度挂钩，跟具体的副本没关系
		tPrizes =
		{
			-- 第1环
			[1] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第2环
			[2] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第3环
			[3] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第4环
			[4] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 25,
					MoneyPrize = 25,
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
	            	},
         	},
           },
------------------------------------------------- 45级连环经验副本-----------------------------------------------------------
	[3] =
	{
		EnterNeedLevel = {minLevel = 45, maxLevel = 60},
		-- 所有子副本
		tAllEctypes =
		{
			-- 第1个子副本
			[1] =
			{
				-- 对应的副本ID
				EctypeID = 2005,
			},
			-- 第2个子副本
			[2] =
			{
				-- 对应的副本ID
				EctypeID = 2006,
			},
			-- 第3个子副本
			[3] =
			{
				-- 对应的副本ID
				EctypeID = 2007,
			},
			-- 第4个子副本
			[4] =
			{
				-- 对应的副本ID
				EctypeID = 2008,
			},
		},

		-- 连环副本奖励，这个奖励跟环数和进度挂钩，跟具体的副本没关系
		tPrizes =
		{
			-- 第1环
			[1] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 1000,--经验
					MoneyPrize = 1000,--金钱
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第2环
			[2] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 1500,
					MoneyPrize = 1500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第3环
			[3] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 2000,
					MoneyPrize = 2000,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第4环
			[4] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[8] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[10] =
				{
					ExpPrize = 2500,
					MoneyPrize = 2500,
					TaoPrize = 10,--道行
					PotPrize = 10,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
	            	},
         	},
           },
------------------------------------------------ 45级连环潜能副本【这里的副本由于是两张图，进度和其他的不一样】 ---------------------------------
	[4] =
	{
		EnterNeedLevel = {minLevel = 45, maxLevel = 60},
		-- 所有子副本
		tAllEctypes =
		{
			-- 第1个子副本
			[1] =
			{
				-- 对应的副本ID
				EctypeID = 2009,
			},
			-- 第2个子副本
			[2] =
			{
				-- 对应的副本ID
				EctypeID = 2010,
			},
			-- 第3个子副本
			[3] =
			{
				-- 对应的副本ID
				EctypeID = 2011,
			},
			-- 第4个子副本
			[4] =
			{
				-- 对应的副本ID
				EctypeID = 2012,
			},
		},

		-- 连环副本奖励，这个奖励跟环数和进度挂钩，跟具体的副本没关系
		tPrizes =
		{
			-- 第1环
			[1] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[9] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[11] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度6
				[13] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1000,--道行
					PotPrize = 1000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第2环
			[2] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[9] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[11] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度6
				[13] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 1500,--道行
					PotPrize = 1500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第3环
			[3] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[9] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[11] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度6
				[13] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2000,--道行
					PotPrize = 2000,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
			},
			-- 第4环
			[4] =
			{
				-- 进度1
				[2] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度2
				[4] =
				{
					ExpPrize = 25,
					MoneyPrize = 25,
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度3
				[6] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度4
				[9] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
				-- 进度5
				[11] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10000, itemNum = 1},
					},
				},
				-- 进度6
				[13] =
				{
					ExpPrize = 50,--经验
					MoneyPrize = 50,--金钱
					TaoPrize = 2500,--道行
					PotPrize = 2500,--潜能
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
					ExtraPrizes =
					{
						-- 经验奖励
						ExpPrize = 100,
						-- 金钱奖励
						MoneyPrize = 100,
					},
				},
	            	},
         	},
           },





}

-- 插入副本对应的连环副本ID
--[[
for i = 1, table.getn(tRingEctypeDB) do
	for j = 1, table.getn(tRingEctypeDB[i]) do
		local ringEctypeGroup = tRingEctypeDB[i][j].tAllEctypes
		for index = 1, table.getn(ringEctypeGroup) do
			local ectypeID = ringEctypeGroup[index].EctypeID
			if tEctypeDB[ectypeID] then
				tEctypeDB[ectypeID].ringEctypeID = i
			else
				-- 配置的子副本ID在tEctypeDB里找不到
				local szErrorDes = "连环副本的子副本ID配置错误！连环副本ID = "..i.."，第"..j.."个副本组，第"..index.."个子副本"
				print(szErrorDes)
			end
		end
	end
end
--]]

for i = 1, table.getn(tRingEctypeDB) do
	local ringEctypeGroup = tRingEctypeDB[i].tAllEctypes
	for index = 1, table.getn(ringEctypeGroup) do
		local ectypeID = ringEctypeGroup[index].EctypeID
		if tEctypeDB[ectypeID] then
			tEctypeDB[ectypeID].ringEctypeID = i
		else
			-- 配置的子副本ID在tEctypeDB里找不到
			local szErrorDes = "连环副本的子副本ID配置错误！连环副本ID = "..i.."，第"..j.."个副本组，第"..index.."个子副本"
			print(szErrorDes)
		end
	end 
end
