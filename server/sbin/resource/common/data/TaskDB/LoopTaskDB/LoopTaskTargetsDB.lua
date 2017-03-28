--[[LoopTaskTargetsDB.lua
	Ñ­»·ÈÎÎñÄ¿±ê(ÈÎÎñÏµÍ³)
]]--

--Ñ­»·ÈÎÎñÄ¿±ê
LoopTaskTargetsDB = 
{
	-- ¶ÁÈ¡Ê¦ÃÅÈÎÎñ
	[10001] =                        -------------Ç¬Ôªµº
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
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4350},},
					
				},
			},

		},
		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4600},},

				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4230},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4751},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4751},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},


		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4773},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},

		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4701},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4270},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ÒÔÏÂÁ½¸öÈÎÎñÀàĞÍ²»»á±»Ëæ»úµ½¡£²»ÓÃÔÚLooptaskDBÅäÖÃÈ¨ÖØ
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
                                        {type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10002] =                           -------------½ğÏ¼É½
	{
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4302},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4358},},
					
				},
			},

		},

		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
                                     {type="openDialog", param={dialogID =4602},},
				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4235},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4754},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4754},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4774},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4703},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4273},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ÒÔÏÂÁ½¸öÈÎÎñÀàĞÍ²»»á±»Ëæ»úµ½¡£²»ÓÃÔÚLooptaskDBÅäÖÃÈ¨ÖØ
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10003] =                          -------------×ÏÑôÃÅ
	{
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4303},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4366},},	
				},
			},

		},

		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4604},},
				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4240},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4757},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4757},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4775},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4705},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4276},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ÒÔÏÂÁ½¸öÈÎÎñÀàĞÍ²»»á±»Ëæ»úµ½¡£²»ÓÃÔÚLooptaskDBÅäÖÃÈ¨ÖØ
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10004] =                          -------------ÔÆÏö¹¬
	{
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4304},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4374},},
				},
			},

		},

		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
                    {type="openDialog", param={dialogID =4606},},
				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4245},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4760},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4760},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4776},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4707},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4279},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ÒÔÏÂÁ½¸öÈÎÎñÀàĞÍ²»»á±»Ëæ»úµ½¡£²»ÓÃÔÚLooptaskDBÅäÖÃÈ¨ÖØ
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
	                                {type="openDialog", param={dialogID = 4780},},				
				},
			},
		},
	},
	[10005] =                          -------------ÌÒÔ´¶´
	{
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4305},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4382},},	
				},
			},

		},

		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4608},},
				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4250},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4763},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4763},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4777},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4709},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4282},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ÒÔÏÂÁ½¸öÈÎÎñÀàĞÍ²»»á±»Ëæ»úµ½¡£²»ÓÃÔÚLooptaskDBÅäÖÃÈ¨ÖØ
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
	[10006] =                          -------------ÅîÀ³¸ó
	{
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4306},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4390},},
				},
			},

		},

		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
                                        {type="openDialog", param={dialogID =4610},},
				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID =4255},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4766},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
                    {type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4766},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4778},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type="openDialog", param={dialogID = 4711},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 4285},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ÒÔÏÂÁ½¸öÈÎÎñÀàĞÍ²»»á±»Ëæ»úµ½¡£²»ÓÃÔÚLooptaskDBÅäÖÃÈ¨ÖØ
		[LoopTaskTargetType.talkScript] =
		{
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 4769},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4780},},
				},
			},
		},
	},
     -- ¶ÁÈ¡ÊÔÁ¶ÈÎÎñ
	[10007] =
	{
		[LoopTaskTargetType.script] = 
		{
			--ĞüÉÍÕ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type = "openDialog", param={dialogID = 5163},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
		limitTime = 30*60,
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type = "openDialog", param={dialogID = 5164},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
			},
		},
		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			limitTime = 30*60,
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
				    {type = "openDialog", param={dialogID = 5166},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
					{type = "openDialog", param={dialogID = 5232},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
			},
		},
		--ÉÏ½»³èÎï
              [LoopTaskTargetType.catchPet] = 
              {		
	       -- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
	                triggers = 
	                {
		             -- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
		                 [TaskStatus.Active] = 
		                 {
			                    -- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë, Âò³èÎïÖ¸Òı
			                    {type = "createBuyPetTrace", param = {}},
		                 },
		                 [TaskStatus.Done] =
		                 {
			     -- ÉÏ½É³èÎïÖ¸Òı
			                    {type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
		                 },	
	                },
              },

		-- °µÀ×Õ½¶·, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					 {type = "openDialog", param={dialogID = 5161},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
		limitTime = 30*60,
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "deliverTrace" , param	= {}},
				    {type = "openDialog", param={dialogID = 5165},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
			},
		},
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
					 {type = "openDialog", param={dialogID = 5162},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		--Æ´Í¼ÈÎÎñ
		--[[[LoopTaskTargetType.puzzle] = 
		{
		limitTime = 5*60,
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},]]
	},
	[10008] =
	{
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬mpaIDÊÇËæ»úµÄ£¬x,y ÊÇËæ»úµÄ¡£
			targets = 
			{	
			},
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					{type="openDialog", param={dialogID = 4031},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
	},
	[10009] =
	{
		--ÉÏ½»×°±¸
		[LoopTaskTargetType.paidEquip] = 
		{
			triggers = 
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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

	[10020] =                        -------------Ç¬Ôªµº
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
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
		-- ºÍNPC ¶Ô»°
		[LoopTaskTargetType.talk] = 
		{		
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					{type="openDialog", param={dialogID = 4350},},
					
				},
			},

		},
		-- ÉÏ½»µÀ¾ß,Ê×ÏÈÒªÕÒNPC ÂòÎïÆ·£¬zÉÏ½ÉÎïÆ·
		[LoopTaskTargetType.buyItem] = 
		{
			-- ÔÚ±¾ÅäÖÃµ±ÖĞÀ´µÈ¼¶Çø·Ö
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createBuyItemData", param = {}},
					{type="openDialog", param={dialogID =4600},},

				},
				-- ÔÚÉÏ½ÉÎïÆ·µÄÊ±ºò¸Ä±äÈÎÎñ×´Ì¬ÎªDone
				-- ÈÎÎñÍê³ÉÊ±ºò·¢¸öÖ¸Òı¸ø¿Í»§¶Ë
				[TaskStatus.Done] =
				{
					{type = "createPaidItemTrace", param = {}},
				},
			},
		},

		[LoopTaskTargetType.catchPet] = 
		{		
			-- ÎŞĞèÅäÖÃÈÎÎñÄ¿±ê
			triggers = 
			{
				-- ÕâÊÇ»ñÈ¡ÎïÆ·µÄÖ¸Òı·¢¸ø¿Í»§¶Ë
				[TaskStatus.Active] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{ type = "createCatchPetData", param = {}},
					{type="openDialog", param={dialogID =4550},},
				},
				[TaskStatus.Done] =
				{
					{type = "forceStopAutoMeet", param = {}},---Ç¿ĞĞÍ£Ö¹×Ô¶¯ÓöµĞ
					{type = "createPaidPetTrace", param = {}}, -- ·¢ËÍÉÏ½É³èÎïÖ¸Òı
					{type = "removeMine", param = {}}, -- ÒÆ³ıÈÎÎñÀà
				},	
			},
		},
		-- ÌôÕ½°µÀ×, ²»ĞèÒª´´½¨NPC£¬ µ½´óÖ¸¶¨×ø±ê£¬½øÈëÕ½¶·
		[LoopTaskTargetType.partrolScript] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "addSpecialArea", param = {}},
					{type="openDialog", param={dialogID = 4230},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeSpecialArea", param = {}},
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- »¤ËÍÈÎÎñ
		[LoopTaskTargetType.escort] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ÆäÊµ¶Ô»°¾ÍÊÇÒ»¸ö¸Ä±ä×´Ì¬µÄ×÷ÓÃ
					{type = "escortTalkTrace", param = {}},
					{type = "openDialog", param={dialogID = 4751},}, --ÔÚÈÎÎñÊ±´ò¿ªÒ»¸ö¶Ô»°

				},
				[TaskStatus.Done] =
				{
					{type = "removePartrolTalkTace", param = {}},
					-- Ö¸ÒıºÍÎ²ËæNPCµÄÌí¼Ó
					{type = "escortNpcTrace", param = {}},
					{type="openDialog", param={dialogID = 4823},},
				},
				[TaskStatus.Finished] = 
				{
					{type = "removeFollowNpc", param = {}},
				},
			},
		},
		
		-- Ñ²Âß¶Ô»°
		[LoopTaskTargetType.partrolTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "partrolTalkTrace", param = {}},
					{type="openDialog", param={dialogID = 4751},},
				},
				[TaskStatus.Finished] =
				{
					{type = "removePartrolTalkTace", param = {}},
				}
			},
		},

		-- ÉñÃØÉÌÈË
		[LoopTaskTargetType.mysteryBus] = 
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---½ÓÈÎÎñ×´Ì¬
				{
					-- ·¢ËÍÒ»¸öËæ»ú×ø±ê½Å±¾Õ½¶·Ö¸Òı£¬ÔÚ¶¯Ì¬Ìí¼ÓÈÎÎñÄ¿±ê
					{type = "mysteryTrace", param = {}},
					{type="openDialog", param={dialogID = 4751},},
				},
				[TaskStatus.Done]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "removeMysteryTrace", param = {}},
				},
			},
		},
		-- ¾èÔù
		[LoopTaskTargetType.donate] = 
		{
			triggers = 
			{
				[TaskStatus.Done] =
				{
					-- ¾èÔùÖ¸Òı
					{type = "donateTrace", param = {}},
					{type= "openDialog", param={dialogID = 4701},},
				},
				
			},
		},
		--ËÍĞÅ
		[LoopTaskTargetType.deliverLetters] =
		{
			triggers = --ÈÎÎñ´¥·¢Æ÷
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
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

		--ÉÏ½»×°±¸
		[LoopTaskTargetType.paidEquip] = 
		{
			triggers = 
			{
				[TaskStatus.Active]		=      ---Íê³ÉÄ¿±ê×´Ì¬
				{
					{type = "randomEquip", param = {}},
				},
				[TaskStatus.Done] = 
				{
					{type = "finishLoopTask", param = {}},
				},
			},
		},

		-- ¶Ô»°Ö±½Ó½øÈëÕ½¶·
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
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},

		[LoopTaskTargetType.itemTalk] =
		{
			triggers = 
			{
				[TaskStatus.Done] = 
				{
					-- ¸øÒ»¸öÖ¸Òı¸ø¿Í»§¶Ë
					{type = "createPosition", param = {}},
					
				},
			},
		},
	},
-----------Ñ¹²âÈÎÎñ----------------------
	[1] =
	{
		--ÌôÕ½Ã÷À×
		[LoopTaskTargetType.brightMine] = 
		{
			--ÌôÕ½Ã÷À×NPCIDÊÇ¹Ì¶¨Ëæ»úµÄ		
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "brightMine", param = {}},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
	},
	-- ÌÖÄæÈÎÎñ
	[10010] =
	{
		--´´½¨Ë½ÓĞNPC£¬
		[LoopTaskTargetType.script] = 
		{
			-- Ã÷À×Õ½¶·NPCIDÊÇËæ»úµÄ£¬×ø±êÊÇ´Ó¹Ì¶¨µ±ÖĞËæ»ú¡£
			targets = 
			{	
			},
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					-- Ëæ»úNPC  Ò»ÖÖÖ¸¶¨NPC£¬²»Ö¸¶¨×ø±ê¡£Ò»ÖÖ²»Ö¸¶¨NPC£¬²»Ö¸¶¨×ø±ê
					{type = "createRandomNpc", param = {index = 1}},
					--{type="openDialog", param={dialogID = 4031},},
				},
				-- ÈÎÎñÍê³ÉÊ±ºò
				[TaskStatus.Done] =
				{
					{type = "removeRandomNpc", param = {index = 1}},
					{type = "finishLoopTask", param = {}},-- Õâ¸öÊÇÍê³Éµ±Ç°ÈÎÎñÄ¿±ê£¬½ÓÏÂ¸öÈÎÎñÄ¿±ê
				},
			},
		},
	},
	-- æ‹¼å›¾ä»»åŠ¡
	[50000] =
	{
		--æ‹¼å›¾ï¼Œ
		[LoopTaskTargetType.puzzle] = 
		{
			limitTime = 5*60,
			targets = 
			{	
			},
			triggers = 
			{
				[TaskStatus.Active] = 
				{
					--éšæœºæ‹¼å›¾
					{type = "createRandomPuzzle", param = {}},
					
				},
				-- ä»»åŠ¡å®Œæˆæ—¶å€™
				[TaskStatus.Done] =
				{

				},
			},
		},
	},
}