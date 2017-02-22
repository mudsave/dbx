--[[LoopTaskTargetAssistDB.lua
	循环任务目标辅助配置(任务系统)
--]]

LoopTaskTargetAssistDB = 
{	
	[10001] =
	{
		-- 1 - 30 级
		[1] =
		{
			-- 1 - 10 环
			[1] =
			{
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
					
				},
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 4121},
						[2] = {petID = 1004, scriptID = 4122},
						[3] = {petID = 1005, scriptID = 4123},
						[4] = {petID = 1006, scriptID = 4124},
						[5] = {petID = 1008, scriptID = 4125},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26001, dialogID = 4231, scriptID = 4101},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
					},
				},
			},
		},
		-- 31 - 40 级
		[2] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26009, scriptID = 4117},
						[2] = {npcID = 26012, scriptID = 4118},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1012, scriptID = 4126},
						[2] = {petID = 1013, scriptID = 4127},
						[3] = {petID = 1014, scriptID = 4128},
						[4] = {petID = 1016, scriptID = 4129},
						[5] = {petID = 1017, scriptID = 4130},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26003, dialogID = 4232, scriptID = 4102},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4752},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{

						[1] = {npcID = 20021,scriptID = 4105,  mapID = 1, x = 32, y = 76},--段岳
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4850, itemID = 1062213, npcID = 26029},
						[2] = {dialogID = 4856, itemID = 1062219, npcID = 26029},
						[3] = {dialogID = 4862, itemID = 1062225, npcID = 26029},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},

				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
			},
		},
		-- 41 - 50 级
		[3] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{

						[1] = {petID = 1019, scriptID = 4131},
						[2] = {petID = 1020, scriptID = 4132},
						[3] = {petID = 1021, scriptID = 4133},
						[4] = {petID = 1027, scriptID = 4134},
						[5] = {petID = 1026, scriptID = 4135},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26005, dialogID = 4233, scriptID = 4103},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4752},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20021,scriptID = 4105,  mapID = 1, x = 32, y = 76},--段岳
						[2] = {npcID = 29066,scriptID = 4111,  mapID = 1, x = 35, y = 99},--乾元岛执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4850, itemID = 1062213, npcID = 26029},
						[2] = {dialogID = 4856, itemID = 1062219, npcID = 26029},
						[3] = {dialogID = 4862, itemID = 1062225, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话指引
					escortTalkTrace =
					{
						-- 对话ID获取的npcID 要和后面的followNpcID 匹配
						[1] = {dialogID = 4811, followNpcID = 26021},
					},
					-- 护送NPc指引
					escortNpcTrace =
					{
						-- followNpcID在之前都已经存起来呢
						[1] = { npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = { npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = { npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = { npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
			},
		},
		-- 51 - 150 级
		[4] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1028, scriptID = 4136},
						[2] = {petID = 1030, scriptID = 4137},
						[3] = {petID = 1031, scriptID = 4138},
						[4] = {petID = 1032, scriptID = 4139},
						[5] = {petID = 1033, scriptID = 4140},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26007, dialogID = 4234, scriptID = 4104},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4752},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 29066,scriptID = 4111,  mapID = 1, x = 35, y = 99},--乾元岛执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4850, itemID = 1062213, npcID = 26029},
						[2] = {dialogID = 4856, itemID = 1062219, npcID = 26029},
						[3] = {dialogID = 4862, itemID = 1062225, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					escortTrace =
					{
						-- dialogID 绑定的npcID和followNpcID要对应
						[1] = {dialogID = 4811, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
			},
		},
	},
	[10002] =
	{
		-- 1 - 30 级
		[1] =
		{
			-- 1 - 10 环
			[1] =
			{
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
					
				},
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 4121},
						[2] = {petID = 1004, scriptID = 4122},
						[3] = {petID = 1005, scriptID = 4123},
						[4] = {petID = 1006, scriptID = 4124},
						[5] = {petID = 1008, scriptID = 4125},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26001, dialogID = 4236, scriptID = 4101},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
					},
				},
			},
		},
		-- 31 - 40 级
		[2] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26009, scriptID = 4117},
						[2] = {npcID = 26012, scriptID = 4118},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1012, scriptID = 4126},
						[2] = {petID = 1013, scriptID = 4127},
						[3] = {petID = 1014, scriptID = 4128},
						[4] = {petID = 1016, scriptID = 4129},
						[5] = {petID = 1017, scriptID = 4130},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26003, dialogID = 4237, scriptID = 4102},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4755},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20023,scriptID = 4107,  mapID = 3, x = 33, y = 111},--李长风
					}
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4851, itemID = 1062214, npcID = 26029},
						[2] = {dialogID = 4857, itemID = 1062220, npcID = 26029},
						[3] = {dialogID = 4863, itemID = 1062226, npcID = 26029},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
			},
		},
		-- 41 - 50 级
		[3] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{

						[1] = {petID = 1019, scriptID = 4131},
						[2] = {petID = 1020, scriptID = 4132},
						[3] = {petID = 1021, scriptID = 4133},
						[4] = {petID = 1027, scriptID = 4134},
						[5] = {petID = 1026, scriptID = 4135},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26005, dialogID = 4238, scriptID = 4103},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4755},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20023,scriptID = 4107,  mapID = 3, x = 33, y = 111},--李长风
						[2] = {npcID = 29068,scriptID = 4113,  mapID = 3, x = 77, y = 44},--金霞山执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4851, itemID = 1062214, npcID = 26029},
						[2] = {dialogID = 4857, itemID = 1062220, npcID = 26029},
						[3] = {dialogID = 4863, itemID = 1062226, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4813, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
			},
		},
		-- 51 - 150 级
		[4] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1028, scriptID = 4136},
						[2] = {petID = 1030, scriptID = 4137},
						[3] = {petID = 1031, scriptID = 4138},
						[4] = {petID = 1032, scriptID = 4139},
						[5] = {petID = 1033, scriptID = 4140},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26007, dialogID = 4239, scriptID = 4104},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4755},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 29068,scriptID = 4113,  mapID = 3, x = 77, y = 44},--金霞山执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4851, itemID = 1062214, npcID = 26029},
						[2] = {dialogID = 4857, itemID = 1062220, npcID = 26029},
						[3] = {dialogID = 4863, itemID = 1062226, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4813, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20006, mapID = 3, x = 26, y = 92},
					},
				},
			},
		},
	},
	[10003] =
	{
		-- 1 - 30 级
		[1] =
		{
			-- 1 - 10 环
			[1] =
			{
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
					
				},
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 4121},
						[2] = {petID = 1004, scriptID = 4122},
						[3] = {petID = 1005, scriptID = 4123},
						[4] = {petID = 1006, scriptID = 4124},
						[5] = {petID = 1008, scriptID = 4125},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26001, dialogID = 4241, scriptID = 4101},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
					},
				},
			},
		},
		-- 31 - 40 级
		[2] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26009, scriptID = 4117},
						[2] = {npcID = 26012, scriptID = 4118},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1012, scriptID = 4126},
						[2] = {petID = 1013, scriptID = 4127},
						[3] = {petID = 1014, scriptID = 4128},
						[4] = {petID = 1016, scriptID = 4129},
						[5] = {petID = 1017, scriptID = 4130},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26003, dialogID = 4242, scriptID = 4102},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4758},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20026,scriptID = 4109,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4852, itemID = 1062215, npcID = 26029},
						[2] = {dialogID = 4858, itemID = 1062221, npcID = 26029},
						[3] = {dialogID = 4864, itemID = 1062227, npcID = 26029},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
			},
		},
		-- 41 - 50 级
		[3] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1019, scriptID = 4131},
						[2] = {petID = 1020, scriptID = 4132},
						[3] = {petID = 1021, scriptID = 4133},
						[4] = {petID = 1027, scriptID = 4134},
						[5] = {petID = 1026, scriptID = 4135},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26005, dialogID = 4243, scriptID = 4103},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4758},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20026,scriptID = 4109,  mapID = 6, x = 43, y = 112},--殿飞白
                                                [2] = {npcID = 29070,scriptID = 4115,  mapID = 6, x = 105, y = 105},--紫阳门执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4852, itemID = 1062215, npcID = 26029},
						[2] = {dialogID = 4858, itemID = 1062221, npcID = 26029},
						[3] = {dialogID = 4864, itemID = 1062227, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4815, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
			},
		},
		-- 51 - 150 级
		[4] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1028, scriptID = 4136},
						[2] = {petID = 1030, scriptID = 4137},
						[3] = {petID = 1031, scriptID = 4138},
						[4] = {petID = 1032, scriptID = 4139},
						[5] = {petID = 1033, scriptID = 4140},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26007, dialogID = 4244, scriptID = 4104},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4758},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
                                                [1] = {npcID = 29070,scriptID = 4115,  mapID = 6, x = 105, y = 105},--紫阳门执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4852, itemID = 1062215, npcID = 26029},
						[2] = {dialogID = 4858, itemID = 1062221, npcID = 26029},
						[3] = {dialogID = 4864, itemID = 1062227, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4815, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20008, mapID = 6, x = 67, y = 135},
					},
				},
			},
		},
	},
	[10004] =
	{
		-- 1 - 30 级
		[1] =
		{
			-- 1 - 10 环
			[1] =
			{
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
					
				},
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 4121},
						[2] = {petID = 1004, scriptID = 4122},
						[3] = {petID = 1005, scriptID = 4123},
						[4] = {petID = 1006, scriptID = 4124},
						[5] = {petID = 1008, scriptID = 4125},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26001, dialogID = 4246, scriptID = 4101},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
					},
				},
			},
		},
		-- 31 - 40 级
		[2] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26009, scriptID = 4117},
						[2] = {npcID = 26012, scriptID = 4118},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1012, scriptID = 4126},
						[2] = {petID = 1013, scriptID = 4127},
						[3] = {petID = 1014, scriptID = 4128},
						[4] = {petID = 1016, scriptID = 4129},
						[5] = {petID = 1017, scriptID = 4130},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26003, dialogID = 4247, scriptID = 4102},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4761},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20024,scriptID = 4110,  mapID = 5, x = 33, y = 77},--玄素
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4853, itemID = 1062216, npcID = 26029},
						[2] = {dialogID = 4859, itemID = 1062222, npcID = 26029},
						[3] = {dialogID = 4865, itemID = 1062228, npcID = 26029},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
			},
		},
		-- 41 - 50 级
		[3] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{

						[1] = {petID = 1019, scriptID = 4131},
						[2] = {petID = 1020, scriptID = 4132},
						[3] = {petID = 1021, scriptID = 4133},
						[4] = {petID = 1027, scriptID = 4134},
						[5] = {petID = 1026, scriptID = 4135},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26005, dialogID = 4248, scriptID = 4103},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4761},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20024,scriptID = 4110,  mapID = 5, x = 33, y = 77},--玄素
						[2] = {npcID = 29071,scriptID = 4116,  mapID = 5, x = 88, y = 27},--云霄宫执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4853, itemID = 1062216, npcID = 26029},
						[2] = {dialogID = 4859, itemID = 1062222, npcID = 26029},
						[3] = {dialogID = 4865, itemID = 1062228, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4817, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
			},
		},
		-- 51 - 150 级
		[4] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1028, scriptID = 4136},
						[2] = {petID = 1030, scriptID = 4137},
						[3] = {petID = 1031, scriptID = 4138},
						[4] = {petID = 1032, scriptID = 4139},
						[5] = {petID = 1033, scriptID = 4140},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26007, dialogID = 4249, scriptID = 4104},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4761},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 29071,scriptID = 4116,  mapID = 5, x = 88, y = 27},--云霄宫执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4853, itemID = 1062216, npcID = 26029},
						[2] = {dialogID = 4859, itemID = 1062222, npcID = 26029},
						[3] = {dialogID = 4865, itemID = 1062228, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4817, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20009, mapID = 5, x = 43, y = 112},
					},
				},
			},
		},
	},
	[10005] =
	{
		-- 1 - 30 级
		[1] =
		{
			-- 1 - 10 环
			[1] =
			{
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
					
				},
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 4121},
						[2] = {petID = 1004, scriptID = 4122},
						[3] = {petID = 1005, scriptID = 4123},
						[4] = {petID = 1006, scriptID = 4124},
						[5] = {petID = 1008, scriptID = 4125},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26001, dialogID = 4251, scriptID = 4101},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
					},
				},
			},
		},
		-- 31 - 40 级
		[2] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26009, scriptID = 4117},
						[2] = {npcID = 26012, scriptID = 4118},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1012, scriptID = 4126},
						[2] = {petID = 1013, scriptID = 4127},
						[3] = {petID = 1014, scriptID = 4128},
						[4] = {petID = 1016, scriptID = 4129},
						[5] = {petID = 1017, scriptID = 4130},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26003, dialogID = 4252, scriptID = 4102},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4764},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20025,scriptID = 4106,  mapID = 4, x = 61, y = 93},--庄梦蝶
					}
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4854, itemID = 1062217, npcID = 26029},
						[2] = {dialogID = 4860, itemID = 1062223, npcID = 26029},
						[3] = {dialogID = 4866, itemID = 1062229, npcID = 26029},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
			},
		},
		-- 41 - 50 级
		[3] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{

						[1] = {petID = 1019, scriptID = 4131},
						[2] = {petID = 1020, scriptID = 4132},
						[3] = {petID = 1021, scriptID = 4133},
						[4] = {petID = 1027, scriptID = 4134},
						[5] = {petID = 1026, scriptID = 4135},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26005, dialogID = 4253, scriptID = 4103},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4764},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20025,scriptID = 4106,  mapID = 4, x = 61, y = 93},--庄梦蝶
                                                [2] = {npcID = 29067,scriptID = 4112,  mapID = 4, x = 82, y = 112},--桃源洞执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4854, itemID = 1062217, npcID = 26029},
						[2] = {dialogID = 4860, itemID = 1062223, npcID = 26029},
						[3] = {dialogID = 4866, itemID = 1062229, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4819, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
			},
		},
		-- 51 - 150 级
		[4] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1028, scriptID = 4136},
						[2] = {petID = 1030, scriptID = 4137},
						[3] = {petID = 1031, scriptID = 4138},
						[4] = {petID = 1032, scriptID = 4139},
						[5] = {petID = 1033, scriptID = 4140},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26007, dialogID = 4254, scriptID = 4104},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4764},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
                                                [1] = {npcID = 29067,scriptID = 4112,  mapID = 4, x = 82, y = 112},--桃源洞执法长老
					},
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4854, itemID = 1062217, npcID = 26029},
						[2] = {dialogID = 4860, itemID = 1062223, npcID = 26029},
						[3] = {dialogID = 4866, itemID = 1062229, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4819, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20005, mapID = 4, x = 59, y = 72},
					},
				},
			},
		},
	},
	[10006] =
	{
		-- 1 - 30 级
		[1] =
		{
			-- 1 - 10 环
			[1] =
			{
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
					
				},
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 4121},
						[2] = {petID = 1004, scriptID = 4122},
						[3] = {petID = 1005, scriptID = 4123},
						[4] = {petID = 1006, scriptID = 4124},
						[5] = {petID = 1008, scriptID = 4125},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26001, dialogID = 4256, scriptID = 4101},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
					},
				},
			},
		},
		-- 31 - 40 级
		[2] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26009, scriptID = 4117},
						[2] = {npcID = 26012, scriptID = 4118},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1012, scriptID = 4126},
						[2] = {petID = 1013, scriptID = 4127},
						[3] = {petID = 1014, scriptID = 4128},
						[4] = {petID = 1016, scriptID = 4129},
						[5] = {petID = 1017, scriptID = 4130},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26003, dialogID = 4257, scriptID = 4102},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4767},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20022,scriptID = 4108,  mapID = 2, x = 61, y = 127},--兮颜
					}
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4855, itemID = 1062218, npcID = 26029},
						[2] = {dialogID = 4861, itemID = 1062224, npcID = 26029},
						[3] = {dialogID = 4867, itemID = 1062230, npcID = 26029},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
			},
		},
		-- 41 - 50 级
		[3] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{

						[1] = {petID = 1019, scriptID = 4131},
						[2] = {petID = 1020, scriptID = 4132},
						[3] = {petID = 1021, scriptID = 4133},
						[4] = {petID = 1027, scriptID = 4134},
						[5] = {petID = 1026, scriptID = 4135},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26005, dialogID = 4258, scriptID = 4103},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4767},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20022,scriptID = 4108,  mapID = 2, x = 61, y = 127},--兮颜
						[2] = {npcID = 29069,scriptID = 4114,  mapID = 2, x = 38, y = 124},--蓬莱阁执法长老
					}
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4855, itemID = 1062218, npcID = 26029},
						[2] = {dialogID = 4861, itemID = 1062224, npcID = 26029},
						[3] = {dialogID = 4867, itemID = 1062230, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4821, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
			},
		},
		-- 51 - 150 级
		[4] =
		{
			-- 1 - 10 环
			[1] =
			{
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 26011, scriptID = 4119},
                                                [2] = {npcID = 26010, scriptID = 4120},
					},
				},
				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 29005, mapID = 10, x = 308, y = 218},
						[2] = {npcID = 29008, mapID = 10, x = 133, y = 104},
						[3] = {npcID = 20027, mapID = 9, x = 72, y = 71},
						[4] = {npcID = 29001, mapID = 10, x = 214, y = 202},
						[5] = {npcID = 20928, mapID = 10, x = 187, y = 215},
						[6] = {npcID = 29012, mapID = 9, x = 77, y = 93},
					}
				},
				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1011001, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},			
						},
						[2] = 
						{
							itemID = 1012003, 
							count = 1,
							buyPosition = {npcID = 20106, mapID = 10, x = 224, y = 166},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1028, scriptID = 4136},
						[2] = {petID = 1030, scriptID = 4137},
						[3] = {petID = 1031, scriptID = 4138},
						[4] = {petID = 1032, scriptID = 4139},
						[5] = {petID = 1033, scriptID = 4140},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
                                          [1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 26007, dialogID = 4259, scriptID = 4104},
                                                [2] = {npcID = 26014, dialogID = 4260, scriptID = 4141},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 4767},
					},
				},
				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041016, npcID = 20049, mapID = 10, x = 46, y = 216} ,
						[2] = {itemID = 1041016, npcID = 27075, mapID = 13, x = 144, y = 116} ,
						[3] = {itemID = 1041016, npcID = 20017, mapID = 10, x = 286, y = 163} ,
						[4] = {itemID = 1041016, npcID = 29079, mapID = 10, x = 184, y = 234} ,
						[5] = {itemID = 1041016, npcID = 29036, mapID = 13, x = 47, y = 106} ,
						[6] = {itemID = 1041016, npcID = 29034, mapID = 13, x = 89, y = 141} ,
						[7] = {itemID = 1041016, npcID = 20059, mapID = 10, x = 45, y = 188} ,
						[8] = {itemID = 1041016, npcID = 20701, mapID = 13, x = 54, y = 145} ,
					},
				},
				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 29069,scriptID = 4114,  mapID = 2, x = 38, y = 124},--蓬莱阁执法长老
					}
				},
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 4855, itemID = 1062218, npcID = 26029},
						[2] = {dialogID = 4861, itemID = 1062224, npcID = 26029},
						[3] = {dialogID = 4867, itemID = 1062230, npcID = 26029},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 4821, followNpcID = 26021},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29010, mapID = 9, x = 45, y = 76},
						[2] = {npcID = 29007, mapID = 10, x = 319, y = 132},
						[3] = {npcID = 29031, mapID = 13, x = 174, y = 74},
						[4] = {npcID = 29023, mapID = 14, x = 63, y = 146},
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26028, scriptID = 4142},
					}
				},
				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20007, mapID = 2, x = 83, y = 125},
					},
				},
			},
		},
	},
	[10007] =
	{
-- 40 - 44 级
		[1] =
		{
			-- 1 - 50 环
			[1] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27078, scriptID = 5089},--黑风小妖
						[2] = {npcID = 27079, scriptID = 5090},--入魔双刀客
						[3] = {npcID = 27080, scriptID = 5091},--魔化女刺客
						[4] = {npcID = 27081, scriptID = 5092},--魔化剑奴
						[5] = {npcID = 27082, scriptID = 5093},--黑衣人
						[6] = {npcID = 27083, scriptID = 5094},--邪恶祭祀
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1009, scriptID = 5161},--河内守卫
						[2] = {petID = 1013, scriptID = 5162},--刀盾手
						[3] = {petID = 1017, scriptID = 5163},--冰妖
						[4] = {petID = 1021, scriptID = 5164},--鲛妖
						[5] = {petID = 1023, scriptID = 5165},--游方妖师
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉]]
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						
						[1] = {npcID = 27001,dialogID = 5001, scriptID = 5001},--董军余党
						[2] = {npcID = 27002,dialogID = 5002, scriptID = 5002},--黄巾余党
						[3] = {npcID = 27003,dialogID = 5003, scriptID = 5003},--悍匪
						[4] = {npcID = 27004,dialogID = 5004, scriptID = 5004},--强盗
						[5] = {npcID = 27005,dialogID = 5005, scriptID = 5005},--流氓
						[6] = {npcID = 27006,dialogID = 5006, scriptID = 5006},--贼寇
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
    -- 51 - 100 环
    [2] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27084, scriptID = 5095},--蛇妖常旭
						[2] = {npcID = 27085, scriptID = 5096},--魔仙黄龙
						[3] = {npcID = 27086, scriptID = 5097},--甲胄翰赤
						[4] = {npcID = 27087, scriptID = 5098},--符咒翰赤
						[5] = {npcID = 27088, scriptID = 5099},--翠岩妖
						[6] = {npcID = 27089, scriptID = 5100},--花魔
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1009, scriptID = 5161},--河内守卫
						[2] = {petID = 1013, scriptID = 5162},--刀盾手
						[3] = {petID = 1017, scriptID = 5163},--冰妖
						[4] = {petID = 1021, scriptID = 5164},--鲛妖
						[5] = {petID = 1023, scriptID = 5165},--游方妖师
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27007, dialogID = 5007, scriptID = 5007},--马匪
						[2] = {npcID = 27008, dialogID = 5008, scriptID = 5008},--玉泉行者
						[3] = {npcID = 27009, dialogID = 5009, scriptID = 5009},--飞贼
						[4] = {npcID = 27010, dialogID = 5010, scriptID = 5010},--董军伍长
						[5] = {npcID = 27011, dialogID = 5011, scriptID = 5011},--黄巾护卫长
						[6] = {npcID = 27012, dialogID = 5012, scriptID = 5012},--荒漠盗匪
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
    -- 101 - 150 环
    [3] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27090, scriptID = 5101},--术妖
						[2] = {npcID = 27091, scriptID = 5102},--鬼姬
						[3] = {npcID = 27092, scriptID = 5103},--虎头怪
						[4] = {npcID = 27093, scriptID = 5104},--巫灵
						[5] = {npcID = 27094, scriptID = 5105},--忧草姬
						[6] = {npcID = 27095, scriptID = 5106},--黑翰赤
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1009, scriptID = 5161},--河内守卫
						[2] = {petID = 1013, scriptID = 5162},--刀盾手
						[3] = {petID = 1017, scriptID = 5163},--冰妖
						[4] = {petID = 1021, scriptID = 5164},--鲛妖
						[5] = {petID = 1023, scriptID = 5165},--游方妖师
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27013, dialogID = 5013, scriptID = 5013},--倭寇
						[2] = {npcID = 27014, dialogID = 5014, scriptID = 5014},--山贼
						[3] = {npcID = 27015, dialogID = 5015, scriptID = 5015},--水贼
						[4] = {npcID = 27016, dialogID = 5016, scriptID = 5016},--董军军阀
						[5] = {npcID = 27017, dialogID = 5017, scriptID = 5017},--黄巾军阀
						[6] = {npcID = 27018, dialogID = 5018, scriptID = 5018},--黑山军
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
		-- 151 - 200 环
    [4] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27096, scriptID = 5107},--白翰赤
						[2] = {npcID = 27097, scriptID = 5108},--幻姬
						[3] = {npcID = 27098, scriptID = 5109},--烽骑
						[4] = {npcID = 27099, scriptID = 5110},--幻妖姬
						[5] = {npcID = 27100, scriptID = 5111},--幻灵姬
						[6] = {npcID = 27101, scriptID = 5112},--无双赤鬼
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1009, scriptID = 5161},--河内守卫
						[2] = {petID = 1013, scriptID = 5162},--刀盾手
						[3] = {petID = 1017, scriptID = 5163},--冰妖
						[4] = {petID = 1021, scriptID = 5164},--鲛妖
						[5] = {petID = 1023, scriptID = 5165},--游方妖师
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27019, dialogID = 5019, scriptID = 5019},--邪教余党
						[2] = {npcID = 27020, dialogID = 5020, scriptID = 5020},--盟军叛党
						[3] = {npcID = 27021, dialogID = 5021, scriptID = 5021},--邪神教徒
						[4] = {npcID = 27022, dialogID = 5022, scriptID = 5022},--邪恶祭祀
						[5] = {npcID = 27023, dialogID = 5023, scriptID = 5023},--逆道天师
						[6] = {npcID = 27024, dialogID = 5024, scriptID = 5024},--截教叛徒
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
		},
-- 45 - 49 级
[2] =
{
			-- 1 - 50 环
	    [1] =
	    {
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27102, scriptID = 5113},--魔教大护法
						[2] = {npcID = 27103, scriptID = 5114},--邪恶女妖
						[3] = {npcID = 27104, scriptID = 5115},--魔化妖道
						[4] = {npcID = 27105, scriptID = 5116},--黄巾魔将
						[5] = {npcID = 27106, scriptID = 5117},--冰石傀
						[6] = {npcID = 27107, scriptID = 5118},--飞熊
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1025, scriptID = 5166},--女贼
						[2] = {petID = 1024, scriptID = 5167},--河盗
						[3] = {petID = 1026, scriptID = 5168},--琴魔女
						[4] = {petID = 1027, scriptID = 5169},--妖灵
						[5] = {petID = 1028, scriptID = 5170},--死士
						[6] = {petID = 1029, scriptID = 5171},--蛮族
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27025, dialogID = 5025, scriptID = 5025},--胡力
						[2] = {npcID = 27026, dialogID = 5026, scriptID = 5026},--张龙
						[3] = {npcID = 27027, dialogID = 5027, scriptID = 5027},--九龙
						[4] = {npcID = 27028, dialogID = 5028, scriptID = 5028},--王石
						[5] = {npcID = 27029, dialogID = 5029, scriptID = 5029},--风邪
						[6] = {npcID = 27030, dialogID = 5030, scriptID = 5030},--灵姬
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
    -- 51 - 100 环
    [2] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27108, scriptID = 5119},--血魔君
						[2] = {npcID = 27109, scriptID = 5120},--血狂
						[3] = {npcID = 27110, scriptID = 5121},--莲魂影
						[4] = {npcID = 27111, scriptID = 5122},--花怀风
						[5] = {npcID = 27112, scriptID = 5123},--龙魂
						[6] = {npcID = 27113, scriptID = 5124},--金翅迦楼洛
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1025, scriptID = 5166},--女贼
						[2] = {petID = 1024, scriptID = 5167},--河盗
						[3] = {petID = 1026, scriptID = 5168},--琴魔女
						[4] = {petID = 1027, scriptID = 5169},--妖灵
						[5] = {petID = 1028, scriptID = 5170},--死士
						[6] = {petID = 1029, scriptID = 5171},--蛮族
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27031, dialogID = 5031, scriptID = 5031},--赵融
						[2] = {npcID = 27032, dialogID = 5032, scriptID = 5032},--冯芳
						[3] = {npcID = 27033, dialogID = 5033, scriptID = 5033},--程普
						[4] = {npcID = 27034, dialogID = 5034, scriptID = 5034},--甘宁
						[5] = {npcID = 27035, dialogID = 5035, scriptID = 5035},--袁遗
						[6] = {npcID = 27036, dialogID = 5036, scriptID = 5036},--杨奉
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
    -- 101 - 150 环
    [3] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27114, scriptID = 5125},--雪风
						[2] = {npcID = 27115, scriptID = 5126},--魔道羽灵
						[3] = {npcID = 27116, scriptID = 5127},--鬼道羽灵
						[4] = {npcID = 27117, scriptID = 5128},--古格
						[5] = {npcID = 27118, scriptID = 5129},--夜魔
						[6] = {npcID = 27119, scriptID = 5130},--玄风
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1025, scriptID = 5166},--女贼
						[2] = {petID = 1024, scriptID = 5167},--河盗
						[3] = {petID = 1026, scriptID = 5168},--琴魔女
						[4] = {petID = 1027, scriptID = 5169},--妖灵
						[5] = {petID = 1028, scriptID = 5170},--死士
						[6] = {petID = 1029, scriptID = 5171},--蛮族
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27037, dialogID = 5037, scriptID = 5037},--黄承乙
						[2] = {npcID = 27038, dialogID = 5038, scriptID = 5038},--李奇
						[3] = {npcID = 27039, dialogID = 5039, scriptID = 5039},--晁雷
						[4] = {npcID = 27040, dialogID = 5040, scriptID = 5040},--晁天
						[5] = {npcID = 27041, dialogID = 5041, scriptID = 5041},--李丙
						[6] = {npcID = 27042, dialogID = 5042, scriptID = 5042},--常昊
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
		-- 151 - 200 环
        [4] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27120, scriptID = 5131},--血灵魑魅
						[2] = {npcID = 27121, scriptID = 5132},--地藏妖
						[3] = {npcID = 27122, scriptID = 5133},--雪妖
						[4] = {npcID = 27123, scriptID = 5134},--剑魂
						[5] = {npcID = 27124, scriptID = 5135},--高渊
						[6] = {npcID = 27125, scriptID = 5136},--魅惑妖姬
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1025, scriptID = 5166},--女贼
						[2] = {petID = 1024, scriptID = 5167},--河盗
						[3] = {petID = 1026, scriptID = 5168},--琴魔女
						[4] = {petID = 1027, scriptID = 5169},--妖灵
						[5] = {petID = 1028, scriptID = 5170},--死士
						[6] = {petID = 1029, scriptID = 5171},--蛮族
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27043, dialogID = 5043, scriptID = 5043},--杨显
						[2] = {npcID = 27044, dialogID = 5044, scriptID = 5044},--李兴霸
						[3] = {npcID = 27045, dialogID = 5045, scriptID = 5045},--杨修
						[4] = {npcID = 27046, dialogID = 5046, scriptID = 5046},--马方
						[5] = {npcID = 27047, dialogID = 5047, scriptID = 5047},--吴龙
						[6] = {npcID = 27048, dialogID = 5048, scriptID = 5048},--周信
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
		},
	-- 50 - 54 级
[3] =
{
			-- 1 - 50 环
	    [1] =
	    {
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27126, scriptID = 5137},--魔化器灵
						[2] = {npcID = 27127, scriptID = 5138},--牛魔
						[3] = {npcID = 27128, scriptID = 5139},--金翅大鹏王
						[4] = {npcID = 27129, scriptID = 5140},--邪灵分身
						[5] = {npcID = 27130, scriptID = 5141},--血法祭祀
						[6] = {npcID = 27131, scriptID = 5142},--魔灵傀儡
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1030, scriptID = 5172},--虎将
						[2] = {petID = 1031, scriptID = 5173},--谋士
						[3] = {petID = 1032, scriptID = 5174},--牛头
						[4] = {petID = 1033, scriptID = 5175},--马面
						[5] = {petID = 1034, scriptID = 5176},--骷髅将
						[6] = {petID = 1035, scriptID = 5177},--魔兵
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27049, dialogID = 5049, scriptID = 5049},--诡异术士符血
						[2] = {npcID = 27050, dialogID = 5050, scriptID = 5050},--邪教魔化护法
						[3] = {npcID = 27051, dialogID = 5051, scriptID = 5051},--魔君白久
						[4] = {npcID = 27052, dialogID = 5052, scriptID = 5052},--魔将陈千军
						[5] = {npcID = 27053, dialogID = 5053, scriptID = 5053},--妖将火獐
						[6] = {npcID = 27054, dialogID = 5054, scriptID = 5054},--镇狱明王
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
    -- 51 - 100 环
    [2] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27132, scriptID = 5143},--冰魔
						[2] = {npcID = 27133, scriptID = 5144},--罗刹恶鬼
						[3] = {npcID = 27134, scriptID = 5145},--蛟魔
						[4] = {npcID = 27135, scriptID = 5146},--双头魔狼
						[5] = {npcID = 27136, scriptID = 5147},--嗜血魔将
						[6] = {npcID = 27137, scriptID = 5148},--嗜血蛮将
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1030, scriptID = 5172},--虎将
						[2] = {petID = 1031, scriptID = 5173},--谋士
						[3] = {petID = 1032, scriptID = 5174},--牛头
						[4] = {petID = 1033, scriptID = 5175},--马面
						[5] = {petID = 1034, scriptID = 5176},--骷髅将
						[6] = {petID = 1035, scriptID = 5177},--魔兵
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27055, dialogID = 5055, scriptID = 5055},--魔君玄霓
						[2] = {npcID = 27056, dialogID = 5056, scriptID = 5056},--魔将萧怀青
						[3] = {npcID = 27057, dialogID = 5057, scriptID = 5057},--千年藤妖
						[4] = {npcID = 27058, dialogID = 5058, scriptID = 5058},--妖将陆魁
						[5] = {npcID = 27059, dialogID = 5059, scriptID = 5059},--邪道刘邑
						[6] = {npcID = 27060, dialogID = 5060, scriptID = 5060},--术士方相
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
    -- 101 - 150 环
    [3] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27138, scriptID = 5149},--罗刹女妖
						[2] = {npcID = 27139, scriptID = 5150},--幽灵鬼师
						[3] = {npcID = 27140, scriptID = 5151},--血炼猪魔
						[4] = {npcID = 27141, scriptID = 5152},--魔灵犬
						[5] = {npcID = 27142, scriptID = 5153},--魔奴
						[6] = {npcID = 27143, scriptID = 5154},--魔将端无
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1030, scriptID = 5172},--虎将
						[2] = {petID = 1031, scriptID = 5173},--谋士
						[3] = {petID = 1032, scriptID = 5174},--牛头
						[4] = {petID = 1033, scriptID = 5175},--马面
						[5] = {petID = 1034, scriptID = 5176},--骷髅将
						[6] = {petID = 1035, scriptID = 5177},--魔兵
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27061, dialogID = 5061, scriptID = 5061},--魔君姬发
						[2] = {npcID = 27062, dialogID = 5062, scriptID = 5062},--魔将乔坤
						[3] = {npcID = 27063, dialogID = 5063, scriptID = 5063},--妖将曹宝
						[4] = {npcID = 27064, dialogID = 5064, scriptID = 5064},--邪道萧臻
						[5] = {npcID = 27065, dialogID = 5065, scriptID = 5065},--术士方弼
						[6] = {npcID = 27066, dialogID = 5066, scriptID = 5066},--薛恶虎
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
		-- 151 - 200 环
        [4] =
			{
				-- 在根据环数来分配不同的怪物 
				--暗雷战斗
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 27144, scriptID = 5155},--恶灵童子
						[2] = {npcID = 27145, scriptID = 5156},--枪魔
						[3] = {npcID = 27146, scriptID = 5157},--赤魂王
						[4] = {npcID = 27147, scriptID = 5158},--金蟾鬼母
						[5] = {npcID = 27148, scriptID = 5159},--毒娘子
						[6] = {npcID = 27149, scriptID = 5160},--妖鬼皇
					},
				},

				-- 对话
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 挑战明雷
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 20049,scriptID = 5073, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320,scriptID = 5074,  mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059,scriptID = 5075,  mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008,scriptID = 5076,  mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073,scriptID = 5077,  mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074,scriptID = 5078,  mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701,scriptID = 5079,  mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075,scriptID = 5080,  mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076,scriptID = 5081,  mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077,scriptID = 5082,  mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021,scriptID = 5083,  mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022,scriptID = 5084,  mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023,scriptID = 5085,  mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025,scriptID = 5086,  mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024,scriptID = 5087,  mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026,scriptID = 5088,  mapID = 6, x = 43, y = 112},--殿飞白
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = --------------西凉军服
						{
							itemID = 1051001, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = --------------蒙面布巾
						{
							itemID = 1051002, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[3] = --------------破碎铠甲
						{
							itemID = 1051006, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[4] = --------------西凉军鞋
						{
							itemID = 1051007, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[5] = --------------强盗徽章
						{
							itemID = 1051008, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[6] = --------------夜行衣
						{
							itemID = 1051009, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[7] = --------------家书
						{
							itemID = 1051010, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[8] = --------------花瓣
						{
							itemID = 1051011, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
					
				},
				-- 上交宠物
				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1030, scriptID = 5172},--虎将
						[2] = {petID = 1031, scriptID = 5173},--谋士
						[3] = {petID = 1032, scriptID = 5174},--牛头
						[4] = {petID = 1033, scriptID = 5175},--马面
						[5] = {petID = 1034, scriptID = 5176},--骷髅将
						[6] = {petID = 1035, scriptID = 5177},--魔兵
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 20049, mapID = 10, x = 46, y = 216},--卢植
						[2] = {npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},

				-- 暗雷战斗
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {npcID = 27067, dialogID = 5067, scriptID = 5067},--韩毒龙
						[2] = {npcID = 27068, dialogID = 5068, scriptID = 5068},--赤精子
						[3] = {npcID = 27069, dialogID = 5069, scriptID = 5069},--雪峰老妖
						[4] = {npcID = 27070, dialogID = 5070, scriptID = 5070},--水火童子
						[5] = {npcID = 27071, dialogID = 5071, scriptID = 5071},--魔将马善
						[6] = {npcID = 27072, dialogID = 5072, scriptID = 5072},--妖将王虎
					},
				},

				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1041017, npcID = 20049, mapID = 10, x = 46, y = 216} ,--卢植
						[2] = {itemID = 1041017, npcID = 30320, mapID = 10, x = 45, y = 209},--王子师
						[3] = {itemID = 1041017, npcID = 20059, mapID = 10, x = 45, y = 188},--皇甫嵩
						[4] = {itemID = 1041017, npcID = 29008, mapID = 10, x = 133, y = 104},--张维义
						[5] = {itemID = 1041017, npcID = 27073, mapID = 9, x = 97, y = 137},--杨森
						[6] = {itemID = 1041017, npcID = 27074, mapID = 9, x = 125, y = 87},--高友乾
						[7] = {itemID = 1041017, npcID = 20701, mapID = 13, x = 54, y = 145},--王允
						[8] = {itemID = 1041017, npcID = 27075, mapID = 13, x = 144, y = 116},--杨文辉
						[9] = {itemID = 1041017, npcID = 27076, mapID = 14, x = 73, y = 58},--郑伦
						[10] = {itemID = 1041017, npcID = 27077, mapID = 14, x = 36, y = 65},--陈奇
						[11] = {itemID = 1041017, npcID = 20021, mapID = 1, x = 32, y = 76},--段岳
						[12] = {itemID = 1041017, npcID = 20022, mapID = 2, x = 61, y = 127},--兮颜
						[13] = {itemID = 1041017, npcID = 20023, mapID = 3, x = 33, y = 111},--李长风
						[14] = {itemID = 1041017, npcID = 20025, mapID = 4, x = 61, y = 93},--庄梦蝶
						[15] = {itemID = 1041017, npcID = 20024, mapID = 5, x = 33, y = 77},--玄素
						[16] = {itemID = 1041017, npcID = 20026, mapID = 6, x = 43, y = 112},--殿飞白
					},
				},
			},
		},
	},
	[10008] =
	{
		-- 1 - 151 级
		[1] =
		{
			-- 1 - 40 环
			[1] =
			{
				-- 在根据环数来分配不同的怪物 
				[LoopTaskTargetType.script] =
				{	
					-- 这个对话ID和脚本战斗ID要根据什么什么配置
					createRandomNpc =
					{
						[1] = {npcID = 25001, scriptID = 4001},
						[2] = {npcID = 25002, scriptID = 4002},
						[3] = {npcID = 25003, scriptID = 4003},
						[4] = {npcID = 25004, scriptID = 4004},
						[5] = {npcID = 25005, scriptID = 4005},
						[6] = {npcID = 25006, scriptID = 4006},
						[7] = {npcID = 25007, scriptID = 4007},
						[8] = {npcID = 25008, scriptID = 4008},
						[9] = {npcID = 25009, scriptID = 4009},
						[10] = {npcID = 25010, scriptID = 4010},
						[11] = {npcID = 25011, scriptID = 4011},
						[12] = {npcID = 25012, scriptID = 4012},
						[13] = {npcID = 25013, scriptID = 4013},
						[14] = {npcID = 25014, scriptID = 4014},
						[15] = {npcID = 25015, scriptID = 4015},
						[16] = {npcID = 25016, scriptID = 4016},
						[17] = {npcID = 25017, scriptID = 4017},
						[18] = {npcID = 25018, scriptID = 4018},
						[19] = {npcID = 25019, scriptID = 4019},
						[20] = {npcID = 25020, scriptID = 4020},
						[21] = {npcID = 25021, scriptID = 4021},
						[22] = {npcID = 25022, scriptID = 4022},
						[23] = {npcID = 25023, scriptID = 4023},
						[24] = {npcID = 25024, scriptID = 4024},
						[25] = {npcID = 25025, scriptID = 4025},
						[26] = {npcID = 25026, scriptID = 4026},
						[27] = {npcID = 25027, scriptID = 4027},
						[28] = {npcID = 25028, scriptID = 4028},
						[29] = {npcID = 25029, scriptID = 4029},
						[30] = {npcID = 25030, scriptID = 4030},
					},
				},
			},
		},
	},
	[10009] = 
	{
		[1] =
		{
			[1] =
			{
				-- 上交装备
				[LoopTaskTargetType.paidEquip] = 
				{
					randomEquip = 
					{
						npcInfo = {npcID = 30817, mapID = 7, x = 74, y = 63},
						equipInfo = 
						{
							[1] = {1, 2, 3, 4, 5, 6},
							[2] = {7, 8, 9, 10, 11},
						}
					},
				},
			}
		}
	},

	[10020] =
	{
		-- 1 - 150 级
		[1] =
		{
			-- 1 - 200 环
			[1] =
			{
				-- 在根据环数来分配不同的怪物 
				[LoopTaskTargetType.script] =
				{	
					--创建npc在此随机
					createRandomNpc =
					{
						[1] = {npcID = 40002, scriptID = 100},
					},
				},

				-- 交谈只有对话ID无战斗
				[LoopTaskTargetType.talk] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					createPosition =
					{
						[1] = {npcID = 40004, mapID = 10, x = 187, y = 240},
					}
				},

				-- 上缴物品
				[LoopTaskTargetType.buyItem] =
				{
					-- 买物品指引
					createBuyItemData = 
					{
						[1] = 
						{
							itemID = 1051013, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},			
						},
						[2] = 
						{
							itemID = 1051013, 
							count = 1,
							buyPosition = {npcID = 20012, mapID = 10, x = 190, y = 190},
						},
					},
					-- 交物品指引
					createPaidItemTrace = 
					{
						[1] ={npcID = 40003, mapID = 10, x = 178, y = 243},
					},
					
				},

				[LoopTaskTargetType.catchPet] =
				{
					-- 捕捉宠物指引
					createCatchPetData =
					{
						[1] = {petID = 1001, scriptID = 101},
						[2] = {petID = 1001, scriptID = 101},
					},
					-- 上缴宠物指引
					createPaidPetTrace = 
					{
						[1] = {npcID = 40005, mapID = 10, x = 185, y = 174},
					},
				},

				-- 挑战暗雷
				[LoopTaskTargetType.partrolScript] =
				{
					addSpecialArea =
					{
						[1] = {dialogID = 30009, scriptID = 100},
						[2] = {dialogID = 30009, scriptID = 100},
					},
				},
				-- 护送NPC,
				[LoopTaskTargetType.escort] =
				{
					-- 巡逻出对话
					partrolTalkTrace =
					{
						[1] = {dialogID = 30016, followNpcID = 20702},
					},
					-- 添加尾随Npc
					escortNpcTrace =
					{
						[1] = {npcID = 29040, mapID = 1, x = 58, y = 124},
					},
				},
				[LoopTaskTargetType.partrolTalk] =
				{
					partrolTalkTrace =
					{
						[1] = {dialogID = 30007},
						[2] = {dialogID = 30007},
					},
				},
				
				-- 神秘商人
				[LoopTaskTargetType.mysteryBus] =
				{
					mysteryTrace =
					{
						[1] = {dialogID = 30008, itemID = 1062212},
						[2] = {dialogID = 30008, itemID = 1062212},
					},
				},

				[LoopTaskTargetType.donate] =
				{
					donateTrace = 
					{
						[1] = {npcID = 29079, mapID = 10, x = 184, y = 234},
					},
				},
				--送信
				[LoopTaskTargetType.deliverLetters] = 
				{
					deliverTrace =
					{
						[1] = {itemID = 1051013, npcID = 40009, mapID = 10, x = 184, y = 240} ,
					},
				},

				-- 上交装备
				[LoopTaskTargetType.paidEquip] = 
				{
					randomEquip = 
					{
						npcInfo = {npcID = 30817, mapID = 10, x = 133, y = 186},
						equipInfo = 
						{
							[1] = {1, 2, 3, 4, 5, 6},
							[2] = {7, 8, 9, 10, 11},
						}
					},
				},
				-- 点击对话触发的触发下一个脚本战斗任务
				[LoopTaskTargetType.talkScript] =
				{
					createRandomNpc = 
					{
						[1] = {npcID = 26009, scriptID = 4117},
					}
				},

				[LoopTaskTargetType.itemTalk] =
				{
					createPosition = 
					{
						[1] ={npcID = 20004, mapID = 1, x = 26, y = 84},
					},
				},
			},
		},
	},

	[10030] =
	{
		[1] =
		{
			[1] = 
			{
				[LoopTaskTargetType.collectMaterials] = 
				{
					collectTrace = 
					{
						[1] = {itemsInfo = {{itemID = 1051005, itemNum = 10},{itemID = 1051006,itemNum = 20}},npcID = 29081, mapID = 10, x = 49, y = 229},
					},
				},
			},
		},
		
	},
	[1] =
	{
		-- 1 - 151 级
		[1] =
		{
			-- 1 - 1000 环
			[1] =
			{
				-- 在根据环数来分配不同的怪物 
				[LoopTaskTargetType.brightMine] =
				{	
					-- 指定NPC，固定坐标 ,无需创建，但是这个坐标要发给客户端
					brightMine =
					{
						[1] = {npcID = 2,scriptID = 100, mapID = 101, x = 100, y = 200},
					}
				},
			},
		},
	},
}