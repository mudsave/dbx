--[[LoopTaskTargetsDB.lua
	循环任务目标(任务系统)
]]--

--循环任务目标
LoopTaskTargetsDB = 
{
	-- 读取师门任务
	[10001] =                        -------------乾元岛
	{
		[LoopTaskTargetType.script] = 
		{		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4301},},
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4350},},
					
				},
			},

		},
		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4600},},

				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
					{type="openDialog", param={dialogID =4550},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4230},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4751},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4751},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},


		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4773},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},

		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4701},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID = 4450},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4270},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 以下两个任务类型不会被随机到。不用在LooptaskDB配置权重
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
                                        {type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10002] =                           -------------金霞山
	{
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4302},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4358},},
					
				},
			},

		},

		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
                                     {type="openDialog", param={dialogID =4602},},
				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
                                        {type="openDialog", param={dialogID =4552},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
					--{type = "stopAutoMeet", param = {}},---停止自动遇敌
					--{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4235},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4754},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4754},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4774},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4703},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID = 4459},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4273},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 以下两个任务类型不会被随机到。不用在LooptaskDB配置权重
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10003] =                          -------------紫阳门
	{
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4303},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4366},},	
				},
			},

		},

		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4604},},
				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
                                        {type="openDialog", param={dialogID =4554},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
					--{type = "stopAutoMeet", param = {}},---停止自动遇敌
					--{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4240},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4757},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4757},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4775},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4705},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID = 4468},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4276},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 以下两个任务类型不会被随机到。不用在LooptaskDB配置权重
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10004] =                          -------------云霄宫
	{
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4304},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4374},},
				},
			},

		},

		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
                    {type="openDialog", param={dialogID =4606},},
				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
                                        {type="openDialog", param={dialogID =4556},},				
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
					--{type = "stopAutoMeet", param = {}},---停止自动遇敌
					--{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4245},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4760},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4760},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4776},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4707},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID = 4477},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4279},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 以下两个任务类型不会被随机到。不用在LooptaskDB配置权重
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
	                                {type="openDialog", param={dialogID = 4780},},				
				},
			},
		},
	},
	[10005] =                          -------------桃源洞
	{
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4305},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4382},},	
				},
			},

		},

		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4608},},
				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
                                        {type="openDialog", param={dialogID =4558},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
					--{type = "stopAutoMeet", param = {}},---停止自动遇敌
					--{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4250},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4763},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4763},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4777},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4709},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID = 4486},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4282},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 以下两个任务类型不会被随机到。不用在LooptaskDB配置权重
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10006] =                          -------------蓬莱阁
	{
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4306},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4390},},
				},
			},

		},

		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4610},},
				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
                                        {type="openDialog", param={dialogID =4560},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID =4255},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4766},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4766},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4778},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4711},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID =4495},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4285},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 以下两个任务类型不会被随机到。不用在LooptaskDB配置权重
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
     -- 读取试炼任务
	[10007] =
	{
		[LoopTaskTargetType.script] = 
		{
		limitTime = 30*60,
			--悬赏战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 5163},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
		limitTime = 30*60,
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type = "openDialog", param={dialogID = 5164},}, --在任务时打开一个对话
				},
			},
		},
		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			limitTime = 30*60,
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
				    {type = "openDialog", param={dialogID = 5166},}, --在任务时打开一个对话
				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
					{type = "openDialog", param={dialogID = 5232},}, --在任务时打开一个对话
				},
			},
		},
		--上交宠物
		[LoopTaskTargetType.catchPet] = 
		{		
		limitTime = 30*60,
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
				    {type = "openDialog", param={dialogID = 5167},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
				},	
			},
		},
		-- 暗雷战斗, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
		limitTime = 30*60,
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					 {type = "openDialog", param={dialogID = 5161},}, --在任务时打开一个对话
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
		limitTime = 30*60,
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
				    {type = "openDialog", param={dialogID = 5165},}, --在任务时打开一个对话
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
			},
		},
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
		limitTime = 30*60,
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 5162},}, --在任务时打开一个对话
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
	},
	[10008] =
	{
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，mpaID是随机的，x,y 是随机的。
			targets = 
			{	
			},
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4031},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
	},
	[10009] =
	{
		--上交装备
		[LoopTaskTargetType.paidEquip] = 
		{
			triggers = 
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "randomEquip", param = {}},
				},
				[TaskStatus.Done] = 
				{
					--{type = "finishLoopTask", param = {}},
				},
			},
		},
	},

	[10020] =                        -------------乾元岛
	{
		[LoopTaskTargetType.script] = 
		{		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4301},},
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
		-- 和NPC 对话
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4350},},
					
				},
			},

		},
		-- 上交道具,首先要找NPC 买物品，z上缴物品
		[LoopTaskTargetType.buyItem] = 
		{
			-- 在本配置当中来等级区分
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{type = "createBuyItemData", param = {}},
					{type="openDialog", param={dialogID =4600},},

				},
				-- 在上缴物品的时候改变任务状态为Done
				-- 任务完成时候发个指引给客户端
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- 无需配置任务目标
			triggers = 
			{
				-- 这是获取物品的指引发给客户端
				[TaskStatus.Active] = 
				{
					-- 给一个指引给客户端
					{ type = "createCatchPetData", param = {}},
					{type="openDialog", param={dialogID =4550},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---强行停止自动遇敌
					{type = "createPaidPetTrace", param = {}}, -- 发送上缴宠物指引
					{type = "removeMine", param = {}}, -- 移除任务类
				},	
			},
		},
		-- 挑战暗雷, 不需要创建NPC， 到大指定坐标，进入战斗
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4230},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 护送任务
		[LoopTaskTargetType.escort] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 其实对话就是一个改变状态的作用
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4751},}, --在任务时打开一个对话

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- 指引和尾随NPC的添加
					{type = "escortNpcTrace", param = {}},
					{type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- 巡逻对话
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4751},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- 神秘商人
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---接任务状态
				{
					-- 发送一个随机坐标脚本战斗指引，在动态添加任务目标
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4751},},
				},
				[TaskStatus.Done]		=      ---完成目标状态
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- 捐赠
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- 捐赠指引
					{type = "donateTrace", param = {}},
					{type= "openDialog", param={dialogID = 4701},},
				},
				
			},
		},
		--送信
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --任务触发器
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "deliverTrace" , param	= {}},
					{type="openDialog", param={dialogID = 4450},},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
		
			},
		},

		--上交装备
		[LoopTaskTargetType.paidEquip] = 
		{
			triggers = 
			{
				[TaskStatus.Active]		=      ---完成目标状态
				{
					{type = "randomEquip", param = {}},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- 对话直接进入战斗
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- 给一个指引给客户端
					{type = "createPosition", param = {}},
					
				},
			},
		},
	},
-----------压测任务----------------------
	[1] =
	{
		--挑战明雷
		[LoopTaskTargetType.brightMine] = 
		{
			--挑战明雷NPCID是固定随机的		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "brightMine", param = {}},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
	},
	-- 讨逆任务
	[10010] =
	{
		--创建私有NPC，
		[LoopTaskTargetType.script] = 
		{
			-- 明雷战斗NPCID是随机的，坐标是从固定当中随机。
			targets = 
			{	
			},
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- 随机NPC  一种指定NPC，不指定坐标。一种不指定NPC，不指定坐标
					{type = "createRandomNpc", param = {index = 1}},
					--{type="openDialog", param={dialogID = 4031},},
				},
				-- 任务完成时候
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- 这个是完成当前任务目标，接下个任务目标
				},
			},
		},
	},
}