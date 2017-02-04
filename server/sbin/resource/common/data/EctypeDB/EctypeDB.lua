--[[EctypeDB.lua
描述:
	副本配置
	副本ID使用区间规划：

		1-100程序测试用例
		101-999主线用
		1001-1999英雄本
		2001-2999连环副本
		3001-3999普通副本
		4001-4999日常活动副本，帮会副本
		5001-5999通天塔
		6001+策划日常测试用
]]

require "game.EctypeSystem.EctypeFuns"

-- 副本配置表
tEctypeDB =
{
	[1] =
	{
		-- 副本名字
		Name = "副本名字",
		-- 副本ID，策划配置ID
		EctypeID = 1,
		-- 静态地图ID
		StaticMapID = 3,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 1, maxLevel = 100},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 30,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 96, locY = 75},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 57, locY = 77},
			{locX = 63, locY = 78},
			{locX = 66, locY = 79},
			{locX = 69, locY = 90}
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 1, xPos = 45, yPos = 71},
					--{Ectype_CreateHotArea, hotAreaID = 2, xPos = 120, yPos = 80},
					{Ectype_CreateNpc, npcID = 30070, xPos = 45, yPos = 71, dir = 1},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
						-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 1, gotoNext =2},
					},
				},
				-- 步骤结束
				End =
				{

				},
			},
			[2] =
			{
				Start =
				{
					{Ectype_OpenDialog, dialogID = 3013},
				},
				--跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 3},
					},
				},
				-- 步骤结束
				-- 步骤结束
				End =
				{
					{Ectype_RemoveNpc, npcID = 30070},
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
			},
			[3] =
			{
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 41, yPos = 85},
					{Ectype_CreateNpc, npcID = 30070, xPos = 41, yPos = 85, dir = 1},
				},
				--跳转
				Goto =
				{
					-- 进入热区触发
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 2, gotoNext =4},
					},

				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				Start =
				{
					--打开对话
					{Ectype_OpenDialog, dialogID = 3013},
				},

				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 5},
					},

				},
				-- 步骤结束
				End =
				{
					{Ectype_DestroyHotArea, hotAreaID = 2},
					{Ectype_RemoveNpc, npcID = 30070},
				},
			},
			[5] =
			{
				Start =
				{
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
				},
				-- 步骤结束
				End =
				{

				},
			}
		},
	},
	[2] =
	{
		-- 副本名字
		Name = "副本名字",
		-- 副本ID，策划配置ID
		EctypeID = 2,
		-- 静态地图ID
		StaticMapID = 2,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 1, maxLevel = 100},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 30,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 117, locY = 46},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 73, locY = 111},
			{locX = 80, locY = 110},
			{locX = 90, locY = 110},
			{locX = 94, locY = 100}
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 1, xPos = 89, yPos = 69},
					--{Ectype_CreateHotArea, hotAreaID = 2, xPos = 120, yPos = 80},
					{Ectype_CreateNpc, npcID = 30070, xPos = 89, yPos = 69, dir = 1},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 1, gotoNext =2},
					},

				},
				-- 步骤结束
				End =
				{

				},
			},
			[2] =
			{
				Start =
				{
					{Ectype_OpenDialog, dialogID = 3013},
				},
				--跳转
				Goto =
				{
					-- 进入热区触发
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 3}
					},
				},
				-- 步骤结束
				End =
				{
					{Ectype_RemoveNpc, npcID = 30070},
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
			},
			[3] =
			{
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 86, yPos = 91},
					{Ectype_CreateNpc, npcID = 30070, xPos = 86, yPos = 91, dir = 1},
				},
					-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 2, gotoNext =4}
					},

				},
				-- 步骤结束
				End =
				{

				},
			},
			[4] =
			{
				Start =
				{
					--打开对话
					{Ectype_OpenDialog, dialogID = 3013},
				},

				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					{Ectype_DestroyHotArea, hotAreaID = 2},
					{Ectype_RemoveNpc, npcID = 30070},
				},
			},
			[5] =
			{
				Start =
				{

				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
				},
				-- 步骤结束
				End =
				{

				},
			}
		},
	},
	[3] =
	{
		-- 副本名字
		Name = "副本名字",
		-- 副本ID，策划配置ID
		EctypeID = 3,
		-- 静态地图ID
		StaticMapID = 1,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 1, maxLevel = 100},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数
		EctypeCDFinishTimes = 2,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 30,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 119, locY = 48},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 28, locY = 84},
			{locX = 31, locY = 95 },
			{locX = 35, locY = 77},
			{locX = 48, locY = 91}
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 1, xPos = 84, yPos = 64},
					--{Ectype_CreateHotArea, hotAreaID = 2, xPos = 120, yPos = 80},
					{Ectype_CreateNpc, npcID = 30070, xPos = 84, yPos = 64, dir = 1},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 1, gotoNext =2}
					},

				},
				-- 步骤结束
				End =
				{

				},
			},
			[2] =
			{
				Start =
				{
					{Ectype_OpenDialog, dialogID = 3013},
				},
				--跳转
				Goto =
				{
					-- 进入热区触发
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 3}
					},
				},
				-- 步骤结束
				End =
				{
					{Ectype_RemoveNpc, npcID = 30070},
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
			},
			[3] =
			{
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 67, yPos = 94},
					{Ectype_CreateNpc, npcID = 30070, xPos = 67, yPos = 94, dir = 1},
				},
					-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 2, gotoNext =4}
					},

				},
				-- 步骤结束
				End =
				{

				},
			},
			[4] =
			{
				Start =
				{
					--打开对话
					{Ectype_OpenDialog, dialogID = 3013},
				},

				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 5}
					},
				},
				-- 步骤结束
				End =
				{
					{Ectype_DestroyHotArea, hotAreaID = 2},
					{Ectype_RemoveNpc, npcID = 30070},
				},
			},
			[5] =
			{
				Start =
				{

				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
				},
				-- 步骤结束
				End =
				{

				},
			}
		},
	},
	[4] =
	{
		-- 副本名字
		Name = "副本名字",
		-- 副本ID，策划配置ID
		EctypeID = 4,
		-- 静态地图ID
		StaticMapID = 5,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 1, maxLevel = 100},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数
		EctypeCDFinishTimes = 2,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 30,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 87, locY = 58},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 27, locY = 92},
			{locX = 34, locY = 92},
			{locX = 42, locY = 93},
			{locX = 54, locY = 92}
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 1, xPos = 64, yPos = 66},
					--{Ectype_CreateHotArea, hotAreaID = 2, xPos = 120, yPos = 80},
					{Ectype_CreateNpc, npcID = 30070, xPos = 64, yPos = 66, dir = 1},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 1, gotoNext =2}
					},

				},
				-- 步骤结束
				End =
				{

				},
			},
			[2] =
			{
				Start =
				{
					{Ectype_OpenDialog, dialogID = 3013},
				},
				--跳转
				Goto =
				{
					-- 进入热区触发
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 3}
					},
				},
				-- 步骤结束
				End =
				{
					{Ectype_RemoveNpc, npcID = 30070},
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
			},
			[3] =
			{
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 35, yPos = 78},
					{Ectype_CreateNpc, npcID = 30070, xPos = 35, yPos = 78, dir = 1},
				},
					-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						{hotAreaID = 2, gotoNext =4}
					},

				},
				-- 步骤结束
				End =
				{

				},
			},
			[4] =
			{
				Start =
				{
					--打开对话
					{Ectype_OpenDialog, dialogID = 3013},
				},

				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						{fightID = 100, gotoNext = 5}
					},
				},
				-- 步骤结束
				End =
				{
					{Ectype_DestroyHotArea, hotAreaID = 2},
					{Ectype_RemoveNpc, npcID = 30070},
				},
			},
			[5] =
			{
				Start =
				{

				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
				},
				-- 步骤结束
				End =
				{

				},
			}
		},
	},
	[5] =
	{
		-- 副本名字
		Name = "副本名字",
		-- 副本ID，策划配置ID
		EctypeID = 5,
		-- 静态地图ID
		StaticMapID = 3,
		-- 静态地图ID2
		StaticMapID2 = 4,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 1, maxLevel = 100},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Common,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		EctypeEnterType = EctypeEnterType.Single,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 2,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 20,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 53, locY = 77},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		EnterInitLocs2 = {locX = 29, locY = 77},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 32, locY = 99},
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 是否可以使用治疗类道具，默认不用配置此字段，代表可以使用
		CanUseHealItems = false,
		-- 是否可以在副本里进行交易，默认不用配置此字段，代表可以交易
		CanTradeInEctype = false,
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos = 70, yPos = 79},
					-- 开启场景特效
					{Ectype_StartSceneMagic, index = 1, magicID = 1505, xPos = 70, yPos = 79},
					-- 创建副本跟随NPC
					{Ectype_CreateFollowNPC, followNpcID = 20754},
					--启动机关
					{Ectype_LoadOrganEffect},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 20034, xPos = 70, yPos = 79, dir = Direction.South},
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3},
					-- 关闭场景特效
					{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 1, gotoNext = 3},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 20034},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
			},

			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 99, yPos = 76},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 20034, xPos = 99, yPos = 76, dir = Direction.North},
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 1, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{
						{itemID = 10001, itemNum = 1},
					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 20034},
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 102, yPos = 86},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第6步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 传送到第二个场景
					{Ectype_TransferToSecondScene},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入第二个场景触发
					EnterSecondScene =
					{
						-- 跳转到第7步骤
						gotoNext = 7,
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 26, yPos = 85},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 20034, xPos = 26, yPos = 85, dir = Direction.East},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第7步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 20034},
					-- 删除副本跟随NPC
					{Ectype_DeleteFollowNPC, followNpcID = 20754},
				},
				-- 步骤跳转
				Goto =
				{
				},
				-- 步骤结束
				End =
				{
				},
			},
		},
	},


[2001] =
	{
		-- 副本名字
		Name = "鬼凤峡",
		-- 副本ID，策划配置ID
		EctypeID = 2001,
		-- 静态地图ID
		StaticMapID = 608,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 35, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		--EctypeEnterType = EctypeEnterType.Team,
		--单人
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 140, locY = 29},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 125, locY = 230},
			{locX = 128, locY = 227},
			{locX = 131, locY = 224},
			{locX = 132, locY = 220},	
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =158, yPos = 105},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30420, xPos = 158, yPos = 105, dir = 6},
					{Ectype_CreateNpc, npcID = 30421, xPos = 155, yPos = 108, dir = 6},
					{Ectype_CreateNpc, npcID = 30422, xPos = 152, yPos = 112, dir = 6},
					{Ectype_CreateNpc, npcID = 30423, xPos = 153, yPos = 115, dir = 6},
					{Ectype_CreateNpc, npcID = 30424, xPos = 157, yPos = 114, dir = 6},
					{Ectype_CreateNpc, npcID = 30425, xPos = 162, yPos = 110, dir = 6},
					{Ectype_CreateNpc, npcID = 30426, xPos = 159, yPos = 109, dir = 6},
					{Ectype_CreateNpc, npcID = 30427, xPos = 156, yPos = 111, dir = 6},
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10001},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3031, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30420},
					{Ectype_RemoveNpc, npcID = 30421},
					{Ectype_RemoveNpc, npcID = 30422},
					{Ectype_RemoveNpc, npcID = 30423},
					{Ectype_RemoveNpc, npcID = 30424},
					{Ectype_RemoveNpc, npcID = 30425},
					{Ectype_RemoveNpc, npcID = 30426},
					{Ectype_RemoveNpc, npcID = 30427},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 219, yPos = 138},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30428, xPos = 219, yPos = 138, dir = 6},
					{Ectype_CreateNpc, npcID = 30429, xPos = 215, yPos = 141, dir = 6},
					{Ectype_CreateNpc, npcID = 30430, xPos = 214, yPos = 143, dir = 6},
					{Ectype_CreateNpc, npcID = 30431, xPos = 216, yPos = 145, dir = 6},
					{Ectype_CreateNpc, npcID = 30432, xPos = 218, yPos = 145, dir = 6},
					{Ectype_CreateNpc, npcID = 30433, xPos = 222, yPos = 141, dir = 6},
					{Ectype_CreateNpc, npcID = 30434, xPos = 221, yPos = 139, dir = 6},
					{Ectype_CreateNpc, npcID = 30435, xPos = 217, yPos = 142, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10003},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3032, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30428},
					{Ectype_RemoveNpc, npcID = 30429},
					{Ectype_RemoveNpc, npcID = 30430},
					{Ectype_RemoveNpc, npcID = 30431},
					{Ectype_RemoveNpc, npcID = 30432},
					{Ectype_RemoveNpc, npcID = 30433},
					{Ectype_RemoveNpc, npcID = 30434},
					{Ectype_RemoveNpc, npcID = 30435},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 175, yPos = 192},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30436, xPos = 175, yPos = 192, dir = 6},
					{Ectype_CreateNpc, npcID = 30437, xPos = 172, yPos = 193, dir = 6},
					{Ectype_CreateNpc, npcID = 30438, xPos = 168, yPos = 196, dir = 6},
					{Ectype_CreateNpc, npcID = 30439, xPos = 169, yPos = 198, dir = 6},
					{Ectype_CreateNpc, npcID = 30440, xPos = 171, yPos = 199, dir = 6},
					{Ectype_CreateNpc, npcID = 30441, xPos = 175, yPos = 197, dir = 6},
					{Ectype_CreateNpc, npcID = 30442, xPos = 176, yPos = 194, dir = 6},
					{Ectype_CreateNpc, npcID = 30443, xPos = 172, yPos = 196, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10005},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3033, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30436},
					{Ectype_RemoveNpc, npcID = 30437},
					{Ectype_RemoveNpc, npcID = 30438},
					{Ectype_RemoveNpc, npcID = 30439},
					{Ectype_RemoveNpc, npcID = 30440},
					{Ectype_RemoveNpc, npcID = 30441},
					{Ectype_RemoveNpc, npcID = 30442},
					{Ectype_RemoveNpc, npcID = 30443},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 102, yPos = 143},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30445, xPos = 102, yPos = 143, dir = 8},
					{Ectype_CreateNpc, npcID = 30446, xPos = 104, yPos = 140, dir = 8},
					{Ectype_CreateNpc, npcID = 30447, xPos = 98, yPos = 143, dir = 8},
					{Ectype_CreateNpc, npcID = 30448, xPos = 95, yPos = 145, dir = 8},
					{Ectype_CreateNpc, npcID = 30449, xPos = 95, yPos = 147, dir = 8},
					{Ectype_CreateNpc, npcID = 30450, xPos = 97, yPos = 148, dir = 8},
					{Ectype_CreateNpc, npcID = 30451, xPos = 97, yPos = 146, dir = 8},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10007},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3034, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30444},
					{Ectype_RemoveNpc, npcID = 30445},
					{Ectype_RemoveNpc, npcID = 30446},
					{Ectype_RemoveNpc, npcID = 30447},
					{Ectype_RemoveNpc, npcID = 30448},
					{Ectype_RemoveNpc, npcID = 30449},
					{Ectype_RemoveNpc, npcID = 30450},
					{Ectype_RemoveNpc, npcID = 30451},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 44, yPos = 129},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30452, xPos = 44, yPos = 129, dir = 6},
					{Ectype_CreateNpc, npcID = 30453, xPos = 41, yPos = 130, dir = 6},
					{Ectype_CreateNpc, npcID = 30454, xPos = 38, yPos = 134, dir = 6},
					{Ectype_CreateNpc, npcID = 30455, xPos = 37, yPos = 136, dir = 6},
					{Ectype_CreateNpc, npcID = 30456, xPos = 40, yPos = 136, dir = 6},
					{Ectype_CreateNpc, npcID = 30457, xPos = 43, yPos = 134, dir = 6},
					{Ectype_CreateNpc, npcID = 30458, xPos = 46, yPos = 130, dir = 6},
					{Ectype_CreateNpc, npcID = 30459, xPos = 41, yPos = 133, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10009},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3035, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30452},
					{Ectype_RemoveNpc, npcID = 30453},
					{Ectype_RemoveNpc, npcID = 30454},
					{Ectype_RemoveNpc, npcID = 30455},
					{Ectype_RemoveNpc, npcID = 30456},
					{Ectype_RemoveNpc, npcID = 30457},
					{Ectype_RemoveNpc, npcID = 30458},
					{Ectype_RemoveNpc, npcID = 30459},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 119, yPos = 215},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30460, xPos = 119, yPos = 215, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10012},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3036, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30460},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},



[2002] =
	{
		-- 副本名字
		Name = "碧波岛",
		-- 副本ID，策划配置ID
		EctypeID = 2002,
		-- 静态地图ID
		StaticMapID = 609,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 35, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		--EctypeEnterType = EctypeEnterType.Team,
		--单人
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 56, locY = 195},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 22, locY = 161},
			{locX = 24, locY = 157},
			{locX = 26, locY = 153},
			{locX = 31, locY = 150},
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =108, yPos = 243},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30510, xPos = 108, yPos = 243, dir = 5},
					{Ectype_CreateNpc, npcID = 30511, xPos = 105, yPos = 243, dir = 5},
					{Ectype_CreateNpc, npcID = 30512, xPos = 108, yPos = 246, dir = 5},
					{Ectype_CreateNpc, npcID = 30513, xPos = 108, yPos = 240, dir = 5},
					{Ectype_CreateNpc, npcID = 30514, xPos = 111, yPos = 243, dir = 5},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10014},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3037, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30510},
					{Ectype_RemoveNpc, npcID = 30511},
					{Ectype_RemoveNpc, npcID = 30512},
					{Ectype_RemoveNpc, npcID = 30513},
					{Ectype_RemoveNpc, npcID = 30514},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 196, yPos = 172},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30518, xPos = 196, yPos = 172, dir = 4},
					{Ectype_CreateNpc, npcID = 30519, xPos = 199, yPos = 172, dir = 4},
					{Ectype_CreateNpc, npcID = 30520, xPos = 199, yPos = 175, dir = 4},
					{Ectype_CreateNpc, npcID = 30521, xPos = 199, yPos = 169, dir = 4},
					{Ectype_CreateNpc, npcID = 30522, xPos = 202, yPos = 172, dir = 4},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10016},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3038, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30518},
					{Ectype_RemoveNpc, npcID = 30519},
					{Ectype_RemoveNpc, npcID = 30520},
					{Ectype_RemoveNpc, npcID = 30521},
					{Ectype_RemoveNpc, npcID = 30522},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 193, yPos = 64},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30526, xPos = 193, yPos = 64, dir = 1},
					{Ectype_CreateNpc, npcID = 30527, xPos = 185, yPos = 64, dir = 1},
					{Ectype_CreateNpc, npcID = 30528, xPos = 189, yPos = 68, dir = 1},
					{Ectype_CreateNpc, npcID = 30529, xPos = 189, yPos = 60, dir = 1},
					{Ectype_CreateNpc, npcID = 30530, xPos = 189, yPos = 64, dir = 1},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10018},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3039, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30526},
					{Ectype_RemoveNpc, npcID = 30527},
					{Ectype_RemoveNpc, npcID = 30528},
					{Ectype_RemoveNpc, npcID = 30529},
					{Ectype_RemoveNpc, npcID = 30530},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 103, yPos = 137},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30534, xPos = 103, yPos = 137, dir = 8},
					{Ectype_CreateNpc, npcID = 30535, xPos = 101, yPos = 139, dir = 8},
					{Ectype_CreateNpc, npcID = 30536, xPos = 105, yPos = 139, dir = 8},
					{Ectype_CreateNpc, npcID = 30537, xPos = 101, yPos = 135, dir = 8},
					{Ectype_CreateNpc, npcID = 30538, xPos = 105, yPos = 135, dir = 8},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10020},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3040, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30534},
					{Ectype_RemoveNpc, npcID = 30535},
					{Ectype_RemoveNpc, npcID = 30536},
					{Ectype_RemoveNpc, npcID = 30537},
					{Ectype_RemoveNpc, npcID = 30538},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 121, yPos = 60},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30542, xPos = 121, yPos = 60, dir = 3},
					{Ectype_CreateNpc, npcID = 30548, xPos = 118, yPos = 60, dir = 3},
					{Ectype_CreateNpc, npcID = 30549, xPos = 121, yPos = 63, dir = 3},
					{Ectype_CreateNpc, npcID = 30545, xPos = 121, yPos = 57, dir = 3},
					{Ectype_CreateNpc, npcID = 30546, xPos = 124, yPos = 60, dir = 3},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10022},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3041, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30542},
					{Ectype_RemoveNpc, npcID = 30548},
					{Ectype_RemoveNpc, npcID = 30549},
					{Ectype_RemoveNpc, npcID = 30545},
					{Ectype_RemoveNpc, npcID = 30546},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 30, yPos = 158},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30550, xPos = 30, yPos = 158, dir = 8},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10024},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3042, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30550},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},
-----冰风原

[2003] =
	{
		-- 副本名字
		Name = "冰风原",
		-- 副本ID，策划配置ID
		EctypeID = 2003,
		-- 静态地图ID
		StaticMapID = 610,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 35, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		--EctypeEnterType = EctypeEnterType.Team,
		--单人
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 46, locY = 132},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 261, locY = 109},
			{locX = 261, locY = 106},
			{locX = 261, locY = 103},
			{locX = 258, locY = 100},
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =107, yPos = 87},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30650, xPos = 107, yPos = 87, dir = 4},
					{Ectype_CreateNpc, npcID = 30651, xPos = 108, yPos = 83, dir = 4},
					{Ectype_CreateNpc, npcID = 30652, xPos = 108, yPos = 91, dir = 4},
					{Ectype_CreateNpc, npcID = 30656, xPos = 111, yPos = 84, dir = 4},
					{Ectype_CreateNpc, npcID = 30657, xPos = 111, yPos = 90, dir = 4},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10030},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3045, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30650},
					{Ectype_RemoveNpc, npcID = 30651},
					{Ectype_RemoveNpc, npcID = 30652},
					{Ectype_RemoveNpc, npcID = 30656},
					{Ectype_RemoveNpc, npcID = 30657},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 145, yPos = 69},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30658, xPos = 145, yPos = 69, dir = 6},
					{Ectype_CreateNpc, npcID = 30659, xPos = 140, yPos = 71, dir = 6},
					{Ectype_CreateNpc, npcID = 30660, xPos = 150, yPos = 71, dir = 6},
					{Ectype_CreateNpc, npcID = 30661, xPos = 145, yPos = 74, dir = 6},
					{Ectype_CreateNpc, npcID = 30663, xPos = 142, yPos = 75, dir = 6},
					{Ectype_CreateNpc, npcID = 30664, xPos = 148, yPos = 75, dir = 6},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10032},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3046, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30658},
					{Ectype_RemoveNpc, npcID = 30659},
					{Ectype_RemoveNpc, npcID = 30660},
					{Ectype_RemoveNpc, npcID = 30661},
					{Ectype_RemoveNpc, npcID = 30663},
					{Ectype_RemoveNpc, npcID = 30664},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 94, yPos = 145},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30666, xPos = 94, yPos = 145, dir = 8},
					{Ectype_CreateNpc, npcID = 30667, xPos = 91, yPos = 142, dir = 8},
					{Ectype_CreateNpc, npcID = 30668, xPos = 91, yPos = 148, dir = 8},
					{Ectype_CreateNpc, npcID = 30670, xPos = 88, yPos = 143, dir = 8},
					{Ectype_CreateNpc, npcID = 30671, xPos = 88, yPos = 147, dir = 8},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10034},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3047, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30666},
					{Ectype_RemoveNpc, npcID = 30667},
					{Ectype_RemoveNpc, npcID = 30668},
					{Ectype_RemoveNpc, npcID = 30670},
					{Ectype_RemoveNpc, npcID = 30671},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 81, yPos = 219},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30674, xPos = 81, yPos = 219, dir = 5},
					{Ectype_CreateNpc, npcID = 30675, xPos = 85, yPos = 219, dir = 5},
					{Ectype_CreateNpc, npcID = 30676, xPos = 81, yPos = 223, dir = 5},
					{Ectype_CreateNpc, npcID = 30680, xPos = 78, yPos = 226, dir = 5},
					{Ectype_CreateNpc, npcID = 30681, xPos = 88, yPos = 216, dir = 5},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10036},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3048, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30674},
					{Ectype_RemoveNpc, npcID = 30675},
					{Ectype_RemoveNpc, npcID = 30676},
					{Ectype_RemoveNpc, npcID = 30680},
					{Ectype_RemoveNpc, npcID = 30681},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 148, yPos = 212},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30682, xPos = 148, yPos = 212, dir = 6},
					{Ectype_CreateNpc, npcID = 30683, xPos = 143, yPos = 213, dir = 6},
					{Ectype_CreateNpc, npcID = 30684, xPos = 153, yPos = 213, dir = 6},
					{Ectype_CreateNpc, npcID = 30685, xPos = 148, yPos = 217, dir = 6},
					{Ectype_CreateNpc, npcID = 30686, xPos = 144, yPos = 217, dir = 6},
					{Ectype_CreateNpc, npcID = 30687, xPos = 152, yPos = 217, dir = 6},
					{Ectype_CreateNpc, npcID = 30688, xPos = 145, yPos = 220, dir = 6},
					{Ectype_CreateNpc, npcID = 30689, xPos = 151, yPos = 220, dir = 6},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10038},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3049, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30682},
					{Ectype_RemoveNpc, npcID = 30683},
					{Ectype_RemoveNpc, npcID = 30684},
					{Ectype_RemoveNpc, npcID = 30685},
					{Ectype_RemoveNpc, npcID = 30686},
					{Ectype_RemoveNpc, npcID = 30687},
					{Ectype_RemoveNpc, npcID = 30688},
					{Ectype_RemoveNpc, npcID = 30689},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 238, yPos = 111},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30690, xPos = 238, yPos = 111, dir = 3},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10040},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3050, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30690},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},
------------------------------------魔罗峰，嗨，哥们，加个队------------------
[2004] =
	{
		-- 副本名字
		Name = "魔罗峰",
		-- 副本ID，策划配置ID
		EctypeID = 2004,
		-- 静态地图ID
		StaticMapID = 611,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 35, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--单人副本
		--EctypeEnterType = EctypeEnterType.Single,
		--组队
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 213, locY = 181},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 92, locY = 300},
			{locX = 96, locY = 300},
			{locX = 100, locY = 296},
			{locX = 105, locY = 291},
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =141, yPos = 214},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30740, xPos = 141, yPos = 214, dir = 3},
					{Ectype_CreateNpc, npcID = 30741, xPos = 140, yPos = 212, dir = 3},
					{Ectype_CreateNpc, npcID = 30743, xPos = 143, yPos = 210, dir = 3},
					{Ectype_CreateNpc, npcID = 30745, xPos = 145, yPos = 213, dir = 3},
					{Ectype_CreateNpc, npcID = 30747, xPos = 143, yPos = 216, dir = 3},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10045},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3055, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30740},
					{Ectype_RemoveNpc, npcID = 30741},
					{Ectype_RemoveNpc, npcID = 30743},
					{Ectype_RemoveNpc, npcID = 30745},
					{Ectype_RemoveNpc, npcID = 30747},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 181, yPos = 134},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30748, xPos = 181, yPos = 134, dir = 4},
					{Ectype_CreateNpc, npcID = 30749, xPos = 182, yPos = 130, dir = 4},
					{Ectype_CreateNpc, npcID = 30751, xPos = 185, yPos = 130, dir = 4},
					{Ectype_CreateNpc, npcID = 30753, xPos = 184, yPos = 134, dir = 4},
					{Ectype_CreateNpc, npcID = 30755, xPos = 180, yPos = 138, dir = 4},
			
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10047},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3056, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30748},
					{Ectype_RemoveNpc, npcID = 30749},
					{Ectype_RemoveNpc, npcID = 30751},
					{Ectype_RemoveNpc, npcID = 30753},
					{Ectype_RemoveNpc, npcID = 30755},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 251, yPos = 75},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30756, xPos = 251, yPos = 75, dir = 2},
					{Ectype_CreateNpc, npcID = 30757, xPos = 248, yPos = 75, dir = 2},
					{Ectype_CreateNpc, npcID = 30759, xPos = 251, yPos = 71, dir = 2},
					{Ectype_CreateNpc, npcID = 30761, xPos = 255, yPos = 72, dir = 2},
					{Ectype_CreateNpc, npcID = 30763, xPos = 255, yPos = 76, dir = 2},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10049},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3057, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30756},
					{Ectype_RemoveNpc, npcID = 30757},
					{Ectype_RemoveNpc, npcID = 30759},
					{Ectype_RemoveNpc, npcID = 30761},
					{Ectype_RemoveNpc, npcID = 30763},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 181, yPos = 90},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30764, xPos = 181, yPos = 90, dir = 6},
					{Ectype_CreateNpc, npcID = 30765, xPos = 185, yPos = 89, dir = 6},
					{Ectype_CreateNpc, npcID = 30767, xPos = 181, yPos = 93, dir = 6},
					{Ectype_CreateNpc, npcID = 30769, xPos = 178, yPos = 94, dir = 6},
					{Ectype_CreateNpc, npcID = 30771, xPos = 176, yPos = 92, dir = 6},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10051},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3058, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30764},
					{Ectype_RemoveNpc, npcID = 30765},
					{Ectype_RemoveNpc, npcID = 30767},
					{Ectype_RemoveNpc, npcID = 30769},
					{Ectype_RemoveNpc, npcID = 30771},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 63, yPos = 216},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30772, xPos = 63, yPos = 216, dir = 7},
					{Ectype_CreateNpc, npcID = 30773, xPos = 67, yPos = 212, dir = 7},
					{Ectype_CreateNpc, npcID = 30775, xPos = 66, yPos = 217, dir = 7},
					{Ectype_CreateNpc, npcID = 30777, xPos = 59, yPos = 219, dir = 7},
					{Ectype_CreateNpc, npcID = 30779, xPos = 62, yPos = 214, dir = 7},
					
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10053},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3059, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30772},
					{Ectype_RemoveNpc, npcID = 30773},
					{Ectype_RemoveNpc, npcID = 30775},
					{Ectype_RemoveNpc, npcID = 30777},
					{Ectype_RemoveNpc, npcID = 30779},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 7, xPos = 88, yPos = 284},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30780, xPos = 88, yPos = 284, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 7, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10055},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3060, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30780},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 7},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{	
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},

	------------------------------------董卓之魂副本-------------------------------------------
	[2005] =
	{
		-- 副本名字
		Name = "秋风原",
		-- 副本ID，策划配置ID
		EctypeID = 2005,
		-- 静态地图ID
		StaticMapID = 600,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 35, locY = 190},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 87, locY = 266},
			{locX = 91, locY = 264},
			{locX = 95, locY = 256},
			{locX = 96, locY = 250},
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 开启机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos = 107, yPos = 132},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30001, xPos = 107, yPos = 132, dir = 3},
					{Ectype_CreateNpc, npcID = 30002, xPos = 111, yPos = 128, dir = 3},
					{Ectype_CreateNpc, npcID = 30003, xPos = 106, yPos = 129, dir = 3},
					{Ectype_CreateNpc, npcID = 30004, xPos = 105, yPos = 133, dir = 3},
					{Ectype_CreateNpc, npcID = 30005, xPos = 109, yPos = 134, dir = 3},
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 3000},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{
					--[[EnterSecondScene =
					{
						-- 跳转到第7步骤
						gotoNext = 3,
					},]]

					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3001, gotoNext = 3},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30001},
					{Ectype_RemoveNpc, npcID = 30002},
					{Ectype_RemoveNpc, npcID = 30003},
					{Ectype_RemoveNpc, npcID = 30004},
					{Ectype_RemoveNpc, npcID = 30005},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},

			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 91, yPos = 199},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30006, xPos = 91, yPos = 199, dir = 6},
					{Ectype_CreateNpc, npcID = 30007, xPos = 95, yPos = 195, dir = 6},
					{Ectype_CreateNpc, npcID = 30008, xPos = 90, yPos = 197, dir = 6},
					{Ectype_CreateNpc, npcID = 30009, xPos = 89, yPos = 200, dir = 6},
					{Ectype_CreateNpc, npcID = 30010, xPos = 93, yPos = 200, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3002},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3002, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30006},
					{Ectype_RemoveNpc, npcID = 30007},
					{Ectype_RemoveNpc, npcID = 30008},
					{Ectype_RemoveNpc, npcID = 30009},
					{Ectype_RemoveNpc, npcID = 30010},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 180, yPos = 123},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30011, xPos = 180, yPos = 123, dir = 3},
					{Ectype_CreateNpc, npcID = 30012, xPos = 178, yPos = 121, dir = 3},
					{Ectype_CreateNpc, npcID = 30013, xPos = 182, yPos = 119, dir = 3},
					{Ectype_CreateNpc, npcID = 30014, xPos = 184, yPos = 121, dir = 3},
					{Ectype_CreateNpc, npcID = 30015, xPos = 182, yPos = 125, dir = 3},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第6步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3004},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3003, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30011},
					{Ectype_RemoveNpc, npcID = 30012},
					{Ectype_RemoveNpc, npcID = 30013},
					{Ectype_RemoveNpc, npcID = 30014},
					{Ectype_RemoveNpc, npcID = 30015},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
					-- 传送到第二个场景
					--{Ectype_TransferToSecondScene},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			--[[[7] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 8, xPos = 92, yPos = 266},
					--开启场景光效
					{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 92, yPos = 266},
				},
				-- 步骤跳转
				Goto =
				{
					-- 跳转到第八步
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第8步骤
						{hotAreaID = 8, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
					-- 传送到第二个场景
					--{Ectype_TransferToSecondScene},

				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},]]

			[8] =
			{
				-- 步骤开始
				Start =
				{
					--进入副本第二个场景
					--{Ectype_TransferToSecondScene},

					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 194, yPos = 39},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30016, xPos = 194, yPos = 39, dir = 3},
					{Ectype_CreateNpc, npcID = 30017, xPos = 192, yPos = 36, dir = 3},
					{Ectype_CreateNpc, npcID = 30018, xPos = 197, yPos = 34, dir = 3},
					{Ectype_CreateNpc, npcID = 30019, xPos = 198, yPos = 38, dir = 3},
					{Ectype_CreateNpc, npcID = 30020, xPos = 196, yPos = 42, dir = 3},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第8步骤
					{hotAreaID = 5, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{

				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3006},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第10步骤
						{fightID = 3004, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30016},
					{Ectype_RemoveNpc, npcID = 30017},
					{Ectype_RemoveNpc, npcID = 30018},
					{Ectype_RemoveNpc, npcID = 30019},
					{Ectype_RemoveNpc, npcID = 30020},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 212, yPos = 147},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30021, xPos = 212, yPos = 147, dir = 7},
					{Ectype_CreateNpc, npcID = 30022, xPos = 210, yPos = 146, dir = 7},
					{Ectype_CreateNpc, npcID = 30023, xPos = 205, yPos = 149, dir = 7},
					{Ectype_CreateNpc, npcID = 30024, xPos = 212, yPos = 150, dir = 7},
					{Ectype_CreateNpc, npcID = 30025, xPos = 207, yPos = 153, dir = 7},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第11步骤
						{hotAreaID = 6, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3008},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第12步骤
						{fightID = 3005, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30021},
					{Ectype_RemoveNpc, npcID = 30022},
					{Ectype_RemoveNpc, npcID = 30023},
					{Ectype_RemoveNpc, npcID = 30024},
					{Ectype_RemoveNpc, npcID = 30025},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 7, xPos = 84, yPos = 253},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30026, xPos = 84, yPos = 253, dir = 7},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第11步骤
						{hotAreaID = 7, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[13] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3010},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
							{fightID = 3006, gotoNext = 14},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30026},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 7},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[14]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},

	[2006] =
	{
		-- 副本名字
		Name = "天牢山",
		-- 副本ID，策划配置ID
		EctypeID = 2006,
		-- 静态地图ID
		StaticMapID = 602,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 252, locY = 113},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 114, locY = 252},
			{locX = 117, locY = 255},
			{locX = 124, locY = 255},
			{locX = 128, locY = 252},
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =202, yPos = 67},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30070, xPos = 202, yPos = 67, dir = 1},
					{Ectype_CreateNpc, npcID = 30071, xPos = 202, yPos = 64, dir = 1},
					{Ectype_CreateNpc, npcID = 30072, xPos = 202, yPos = 70, dir = 1},
					{Ectype_CreateNpc, npcID = 30073, xPos = 199, yPos = 67, dir = 1},
					{Ectype_CreateNpc, npcID = 30074, xPos = 205, yPos = 67, dir = 1},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 3013},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3007, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30070},
					{Ectype_RemoveNpc, npcID = 30071},
					{Ectype_RemoveNpc, npcID = 30072},
					{Ectype_RemoveNpc, npcID = 30073},
					{Ectype_RemoveNpc, npcID = 30074},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 163, yPos = 108},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30075, xPos = 163, yPos = 108, dir = 5},
					{Ectype_CreateNpc, npcID = 30076, xPos = 160, yPos = 108, dir = 5},
					{Ectype_CreateNpc, npcID = 30077, xPos = 166, yPos = 108, dir = 5},
					{Ectype_CreateNpc, npcID = 30078, xPos = 163, yPos = 111, dir = 5},
					{Ectype_CreateNpc, npcID = 30079, xPos = 163, yPos = 105, dir = 5},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3015},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3008, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30075},
					{Ectype_RemoveNpc, npcID = 30076},
					{Ectype_RemoveNpc, npcID = 30077},
					{Ectype_RemoveNpc, npcID = 30078},
					{Ectype_RemoveNpc, npcID = 30079},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 192, yPos = 178},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30080, xPos = 192, yPos = 178, dir = 6},
					{Ectype_CreateNpc, npcID = 30081, xPos = 192, yPos = 175, dir = 6},
					{Ectype_CreateNpc, npcID = 30082, xPos = 192, yPos = 181, dir = 6},
					{Ectype_CreateNpc, npcID = 30083, xPos = 189, yPos = 178, dir = 6},
					{Ectype_CreateNpc, npcID = 30084, xPos = 195, yPos = 178, dir = 6},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3017},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3009, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30080},
					{Ectype_RemoveNpc, npcID = 30081},
					{Ectype_RemoveNpc, npcID = 30082},
					{Ectype_RemoveNpc, npcID = 30083},
					{Ectype_RemoveNpc, npcID = 30084},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 126, yPos = 129},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30085, xPos = 126, yPos = 129, dir = 1},
					{Ectype_CreateNpc, npcID = 30086, xPos = 126, yPos = 126, dir = 1},
					{Ectype_CreateNpc, npcID = 30087, xPos = 126, yPos = 132, dir = 1},
					{Ectype_CreateNpc, npcID = 30088, xPos = 123, yPos = 129, dir = 1},
					{Ectype_CreateNpc, npcID = 30089, xPos = 129, yPos = 129, dir = 1},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3019},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3010, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30085},
					{Ectype_RemoveNpc, npcID = 30086},
					{Ectype_RemoveNpc, npcID = 30087},
					{Ectype_RemoveNpc, npcID = 30088},
					{Ectype_RemoveNpc, npcID = 30089},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 70, yPos = 201},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30090, xPos = 70, yPos = 201, dir = 5},
					{Ectype_CreateNpc, npcID = 30091, xPos = 70, yPos = 204, dir = 5},
					{Ectype_CreateNpc, npcID = 30092, xPos = 70, yPos = 198, dir = 5},
					{Ectype_CreateNpc, npcID = 30093, xPos = 73, yPos = 201, dir = 5},
					{Ectype_CreateNpc, npcID = 30094, xPos = 67, yPos = 201, dir = 5},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3021},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3011, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30090},
					{Ectype_RemoveNpc, npcID = 30091},
					{Ectype_RemoveNpc, npcID = 30092},
					{Ectype_RemoveNpc, npcID = 30093},
					{Ectype_RemoveNpc, npcID = 30094},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 122, yPos = 245},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30095, xPos = 122, yPos = 245, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3023},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3012, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30095},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},
	[2007] =
	{
		-- 副本名字
		Name = "魔魂峰",
		-- 副本ID，策划配置ID
		EctypeID = 2007,
		-- 静态地图ID
		StaticMapID = 606,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 156, locY = 39},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 88, locY = 253},
			{locX = 92, locY = 257},
			{locX = 98, locY = 257},
			{locX = 104, locY = 252},
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =122, yPos = 86},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30181, xPos = 122, yPos = 86, dir = 7},
					{Ectype_CreateNpc, npcID = 30182, xPos = 120, yPos = 84, dir = 7},
					{Ectype_CreateNpc, npcID = 30183, xPos = 119, yPos = 89, dir = 7},
					{Ectype_CreateNpc, npcID = 30184, xPos = 117, yPos = 87, dir = 7},
					{Ectype_CreateNpc, npcID = 30185, xPos = 121, yPos = 90, dir = 7},
					{Ectype_CreateNpc, npcID = 30300, xPos = 119, yPos = 92, dir = 7},
					{Ectype_CreateNpc, npcID = 30301, xPos = 116, yPos = 85, dir = 7},
					{Ectype_CreateNpc, npcID = 30302, xPos = 114, yPos = 87, dir = 7},
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 3060},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3017, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30181},
					{Ectype_RemoveNpc, npcID = 30182},
					{Ectype_RemoveNpc, npcID = 30183},
					{Ectype_RemoveNpc, npcID = 30184},
					{Ectype_RemoveNpc, npcID = 30185},
					{Ectype_RemoveNpc, npcID = 30300},
					{Ectype_RemoveNpc, npcID = 30301},
					{Ectype_RemoveNpc, npcID = 30302},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 67, yPos = 169},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30160, xPos = 67, yPos = 169, dir = 6},
					{Ectype_CreateNpc, npcID = 30161, xPos = 63, yPos = 173, dir = 6},
					{Ectype_CreateNpc, npcID = 30162, xPos = 67, yPos = 172, dir = 6},
					{Ectype_CreateNpc, npcID = 30163, xPos = 64, yPos = 175, dir = 6},
					{Ectype_CreateNpc, npcID = 30164, xPos = 70, yPos = 168, dir = 6},
					{Ectype_CreateNpc, npcID = 30303, xPos = 71, yPos = 170, dir = 6},
					{Ectype_CreateNpc, npcID = 30304, xPos = 62, yPos = 176, dir = 6},
					{Ectype_CreateNpc, npcID = 30305, xPos = 63, yPos = 178, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3063},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3018, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30160},
					{Ectype_RemoveNpc, npcID = 30161},
					{Ectype_RemoveNpc, npcID = 30162},
					{Ectype_RemoveNpc, npcID = 30163},
					{Ectype_RemoveNpc, npcID = 30164},
					{Ectype_RemoveNpc, npcID = 30303},
					{Ectype_RemoveNpc, npcID = 30304},
					{Ectype_RemoveNpc, npcID = 30305},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 136, yPos = 162},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30165, xPos = 136, yPos = 162, dir = 2},
					{Ectype_CreateNpc, npcID = 30166, xPos = 133, yPos = 162, dir = 2},
					{Ectype_CreateNpc, npcID = 30167, xPos = 133, yPos = 159, dir = 2},
					{Ectype_CreateNpc, npcID = 30168, xPos = 136, yPos = 159, dir = 2},
					{Ectype_CreateNpc, npcID = 30169, xPos = 138, yPos = 160, dir = 2},
					{Ectype_CreateNpc, npcID = 30306, xPos = 138, yPos = 157, dir = 2},
					{Ectype_CreateNpc, npcID = 30307, xPos = 131, yPos = 160, dir = 2},
					{Ectype_CreateNpc, npcID = 30308, xPos = 131, yPos = 157, dir = 2},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3065},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3019, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30165},
					{Ectype_RemoveNpc, npcID = 30166},
					{Ectype_RemoveNpc, npcID = 30167},
					{Ectype_RemoveNpc, npcID = 30168},
					{Ectype_RemoveNpc, npcID = 30169},
					{Ectype_RemoveNpc, npcID = 30306},
					{Ectype_RemoveNpc, npcID = 30307},
					{Ectype_RemoveNpc, npcID = 30308},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 215, yPos = 91},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30170, xPos = 215, yPos = 91, dir = 4},
					{Ectype_CreateNpc, npcID = 30171, xPos = 215, yPos = 94, dir = 4},
					{Ectype_CreateNpc, npcID = 30172, xPos = 218, yPos = 94, dir = 4},
					{Ectype_CreateNpc, npcID = 30173, xPos = 218, yPos = 91, dir = 4},
					{Ectype_CreateNpc, npcID = 30174, xPos = 217, yPos = 89, dir = 4},
					{Ectype_CreateNpc, npcID = 30309, xPos = 220, yPos = 89, dir = 4},
					{Ectype_CreateNpc, npcID = 30310, xPos = 216, yPos = 96, dir = 4},
					{Ectype_CreateNpc, npcID = 30311, xPos = 219, yPos = 96, dir = 4},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3067},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3020, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30170},
					{Ectype_RemoveNpc, npcID = 30171},
					{Ectype_RemoveNpc, npcID = 30172},
					{Ectype_RemoveNpc, npcID = 30173},
					{Ectype_RemoveNpc, npcID = 30174},
					{Ectype_RemoveNpc, npcID = 30309},
					{Ectype_RemoveNpc, npcID = 30310},
					{Ectype_RemoveNpc, npcID = 30311},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 187, yPos = 192},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30175, xPos = 187, yPos = 192, dir = 7},
					{Ectype_CreateNpc, npcID = 30176, xPos = 185, yPos = 190, dir = 7},
					{Ectype_CreateNpc, npcID = 30177, xPos = 182, yPos = 193, dir = 7},
					{Ectype_CreateNpc, npcID = 30178, xPos = 184, yPos = 195, dir = 7},
					{Ectype_CreateNpc, npcID = 30179, xPos = 187, yPos = 196, dir = 7},
					{Ectype_CreateNpc, npcID = 30312, xPos = 184, yPos = 199, dir = 7},
					{Ectype_CreateNpc, npcID = 30313, xPos = 182, yPos = 190, dir = 7},
					{Ectype_CreateNpc, npcID = 30314, xPos = 179, yPos = 193, dir = 7},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3069},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3021, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30175},
					{Ectype_RemoveNpc, npcID = 30176},
					{Ectype_RemoveNpc, npcID = 30177},
					{Ectype_RemoveNpc, npcID = 30178},
					{Ectype_RemoveNpc, npcID = 30179},
					{Ectype_RemoveNpc, npcID = 30312},
					{Ectype_RemoveNpc, npcID = 30313},
					{Ectype_RemoveNpc, npcID = 30314},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 99, yPos = 251},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30180, xPos = 99, yPos = 251, dir = 1},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3071},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3022, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30180},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},

[2008] =
	{
		-- 副本名字
		Name = "潜龙岭",
		-- 副本ID，策划配置ID
		EctypeID = 2008,
		-- 静态地图ID
		StaticMapID = 607,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Ring,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--组队副本
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 230, locY = 127},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 130, locY = 234},
			{locX = 130, locY = 238},
			{locX = 130, locY = 242},
			{locX = 130, locY = 246},
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =188, yPos = 87},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30321, xPos = 188, yPos = 87, dir = 8},
					{Ectype_CreateNpc, npcID = 30322, xPos = 183, yPos = 85, dir = 8},
					{Ectype_CreateNpc, npcID = 30323, xPos = 183, yPos = 89, dir = 8},
					{Ectype_CreateNpc, npcID = 30324, xPos = 181, yPos = 84, dir = 8},
					{Ectype_CreateNpc, npcID = 30325, xPos = 181, yPos = 90, dir = 8},
					{Ectype_CreateNpc, npcID = 30326, xPos = 186, yPos = 83, dir = 8},
					{Ectype_CreateNpc, npcID = 30327, xPos = 185, yPos = 87, dir = 8},
					{Ectype_CreateNpc, npcID = 30328, xPos = 186, yPos = 91, dir = 8},
					-- 开启场景特效
					{Ectype_StartSceneMagic, index = 8, magicID = 5068, xPos = 208, yPos = 116},

					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 3075},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3025, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30321},
					{Ectype_RemoveNpc, npcID = 30322},
					{Ectype_RemoveNpc, npcID = 30323},
					{Ectype_RemoveNpc, npcID = 30324},
					{Ectype_RemoveNpc, npcID = 30325},
					{Ectype_RemoveNpc, npcID = 30326},
					{Ectype_RemoveNpc, npcID = 30327},
					{Ectype_RemoveNpc, npcID = 30328},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 74, yPos = 109},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30329, xPos = 74, yPos = 109, dir = 8},
					{Ectype_CreateNpc, npcID = 30330, xPos = 72, yPos = 106, dir = 8},
					{Ectype_CreateNpc, npcID = 30331, xPos = 72, yPos = 112, dir = 8},
					{Ectype_CreateNpc, npcID = 30332, xPos = 70, yPos = 108, dir = 8},
					{Ectype_CreateNpc, npcID = 30333, xPos = 70, yPos = 110, dir = 8},
					{Ectype_CreateNpc, npcID = 30334, xPos = 68, yPos = 107, dir = 8},
					{Ectype_CreateNpc, npcID = 30335, xPos = 66, yPos = 109, dir = 8},
					{Ectype_CreateNpc, npcID = 30336, xPos = 68, yPos = 111, dir = 8},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3077},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3026, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30329},
					{Ectype_RemoveNpc, npcID = 30330},
					{Ectype_RemoveNpc, npcID = 30331},
					{Ectype_RemoveNpc, npcID = 30332},
					{Ectype_RemoveNpc, npcID = 30333},
					{Ectype_RemoveNpc, npcID = 30334},
					{Ectype_RemoveNpc, npcID = 30335},
					{Ectype_RemoveNpc, npcID = 30336},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 105, yPos = 137},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30337, xPos = 105, yPos = 137, dir = 4},
					{Ectype_CreateNpc, npcID = 30338, xPos = 106, yPos = 134, dir = 4},
					{Ectype_CreateNpc, npcID = 30339, xPos = 106, yPos = 140, dir = 4},
					{Ectype_CreateNpc, npcID = 30340, xPos = 110, yPos = 132, dir = 4},
					{Ectype_CreateNpc, npcID = 30341, xPos = 110, yPos = 142, dir = 4},
					{Ectype_CreateNpc, npcID = 30342, xPos = 112, yPos = 135, dir = 4},
					{Ectype_CreateNpc, npcID = 30343, xPos = 109, yPos = 137, dir = 4},
					{Ectype_CreateNpc, npcID = 30344, xPos = 112, yPos = 139, dir = 4},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3079},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3027, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30337},
					{Ectype_RemoveNpc, npcID = 30338},
					{Ectype_RemoveNpc, npcID = 30339},
					{Ectype_RemoveNpc, npcID = 30340},
					{Ectype_RemoveNpc, npcID = 30341},
					{Ectype_RemoveNpc, npcID = 30342},
					{Ectype_RemoveNpc, npcID = 30343},
					{Ectype_RemoveNpc, npcID = 30344},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 176, yPos = 177},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30345, xPos = 176, yPos = 177, dir = 6},
					{Ectype_CreateNpc, npcID = 30346, xPos = 173, yPos = 180, dir = 6},
					{Ectype_CreateNpc, npcID = 30347, xPos = 179, yPos = 180, dir = 6},
					{Ectype_CreateNpc, npcID = 30348, xPos = 172, yPos = 183, dir = 6},
					{Ectype_CreateNpc, npcID = 30349, xPos = 180, yPos = 183, dir = 6},
					{Ectype_CreateNpc, npcID = 30350, xPos = 172, yPos = 176, dir = 6},
					{Ectype_CreateNpc, npcID = 30351, xPos = 176, yPos = 181, dir = 6},
					{Ectype_CreateNpc, npcID = 30352, xPos = 180, yPos = 176, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3081},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3028, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30345},
					{Ectype_RemoveNpc, npcID = 30346},
					{Ectype_RemoveNpc, npcID = 30347},
					{Ectype_RemoveNpc, npcID = 30348},
					{Ectype_RemoveNpc, npcID = 30349},
					{Ectype_RemoveNpc, npcID = 30350},
					{Ectype_RemoveNpc, npcID = 30351},
					{Ectype_RemoveNpc, npcID = 30352},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 117, yPos = 168},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30353, xPos = 117, yPos = 168, dir = 8},
					{Ectype_CreateNpc, npcID = 30354, xPos = 114, yPos = 164, dir = 8},
					{Ectype_CreateNpc, npcID = 30355, xPos = 114, yPos = 171, dir = 8},
					{Ectype_CreateNpc, npcID = 30356, xPos = 116, yPos = 165, dir = 8},
					{Ectype_CreateNpc, npcID = 30357, xPos = 116, yPos = 170, dir = 8},
					{Ectype_CreateNpc, npcID = 30358, xPos = 111, yPos = 164, dir = 8},
					{Ectype_CreateNpc, npcID = 30359, xPos = 113, yPos = 168, dir = 8},
					{Ectype_CreateNpc, npcID = 30360, xPos = 111, yPos = 171, dir = 8},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3083},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3029, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30353},
					{Ectype_RemoveNpc, npcID = 30354},
					{Ectype_RemoveNpc, npcID = 30355},
					{Ectype_RemoveNpc, npcID = 30356},
					{Ectype_RemoveNpc, npcID = 30357},
					{Ectype_RemoveNpc, npcID = 30358},
					{Ectype_RemoveNpc, npcID = 30359},
					{Ectype_RemoveNpc, npcID = 30360},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 114, yPos = 240},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30361, xPos = 114, yPos = 240, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 3085},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3030, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30361},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},

----------------------------------董贼再现群副本·邪盘山-----------------------------------------------

[2009] =
	{
		-- 副本名字
		Name = "邪盘山",
		-- 副本ID，策划配置ID
		EctypeID = 2009,
		-- 静态地图ID
		StaticMapID = 612,
		-- 静态地图ID2
		--StaticMapID2 = 601,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.team,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--单人副本
		--EctypeEnterType = EctypeEnterType.Single,
		--组队
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 68, locY = 188},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 35, locY = 190},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 51, locY = 152},
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =130, yPos = 178},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30825, xPos = 130, yPos = 178, dir = 3},
					{Ectype_CreateNpc, npcID = 30826, xPos = 130, yPos = 175, dir = 3},
					{Ectype_CreateNpc, npcID = 30827, xPos = 133, yPos = 179, dir = 3},
					{Ectype_CreateNpc, npcID = 30828, xPos = 133, yPos = 172, dir = 3},
					{Ectype_CreateNpc, npcID = 30829, xPos = 136, yPos = 176, dir = 3},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10057},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3061, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30825},
					{Ectype_RemoveNpc, npcID = 30826},
					{Ectype_RemoveNpc, npcID = 30827},
					{Ectype_RemoveNpc, npcID = 30828},
					{Ectype_RemoveNpc, npcID = 30829},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 172, yPos = 115},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30833, xPos = 172, yPos = 115, dir = 4},
					{Ectype_CreateNpc, npcID = 30834, xPos = 174, yPos = 112, dir = 4},
					{Ectype_CreateNpc, npcID = 30835, xPos = 174, yPos = 117, dir = 4},
					{Ectype_CreateNpc, npcID = 30836, xPos = 177, yPos = 112, dir = 4},
					{Ectype_CreateNpc, npcID = 30837, xPos = 177, yPos = 117, dir = 4},
			
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10059},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3062, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30833},
					{Ectype_RemoveNpc, npcID = 30834},
					{Ectype_RemoveNpc, npcID = 30835},
					{Ectype_RemoveNpc, npcID = 30836},
					{Ectype_RemoveNpc, npcID = 30837},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 203, yPos = 69},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30841, xPos = 203, yPos = 69, dir = 1},
					{Ectype_CreateNpc, npcID = 30842, xPos = 201, yPos = 66, dir = 1},
					{Ectype_CreateNpc, npcID = 30843, xPos = 205, yPos = 66, dir = 1},
					{Ectype_CreateNpc, npcID = 30844, xPos = 201, yPos = 62, dir = 1},
					{Ectype_CreateNpc, npcID = 30845, xPos = 205, yPos = 62, dir = 1},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10061},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3063, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30841},
					{Ectype_RemoveNpc, npcID = 30842},
					{Ectype_RemoveNpc, npcID = 30843},
					{Ectype_RemoveNpc, npcID = 30844},
					{Ectype_RemoveNpc, npcID = 30845},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 173, yPos = 17},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30849, xPos = 173, yPos = 17, dir = 1},
					{Ectype_CreateNpc, npcID = 30850, xPos = 169, yPos = 18, dir = 1},
					{Ectype_CreateNpc, npcID = 30851, xPos = 173, yPos = 14, dir = 1},
					{Ectype_CreateNpc, npcID = 30852, xPos = 167, yPos = 16, dir = 1},
					{Ectype_CreateNpc, npcID = 30853, xPos = 171, yPos = 12, dir = 1},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10063},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3064, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30849},
					{Ectype_RemoveNpc, npcID = 30850},
					{Ectype_RemoveNpc, npcID = 30851},
					{Ectype_RemoveNpc, npcID = 30852},
					{Ectype_RemoveNpc, npcID = 30853},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 120, yPos = 88},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30857, xPos = 120, yPos = 88, dir = 5},
					{Ectype_CreateNpc, npcID = 30858, xPos = 119, yPos = 91, dir = 5},
					{Ectype_CreateNpc, npcID = 30859, xPos = 124, yPos = 87, dir = 5},
					{Ectype_CreateNpc, npcID = 30860, xPos = 120, yPos = 93, dir = 5},
					{Ectype_CreateNpc, npcID = 30861, xPos = 125, yPos = 89, dir = 5},
					
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10065},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3065, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30857},
					{Ectype_RemoveNpc, npcID = 30858},
					{Ectype_RemoveNpc, npcID = 30859},
					{Ectype_RemoveNpc, npcID = 30860},
					{Ectype_RemoveNpc, npcID = 30861},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 6, xPos = 48, yPos = 137},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30865, xPos = 48, yPos = 137, dir = 7},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 6, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10067},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3066, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30865},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 6},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[13]=
			{
			-- 步骤开始
				Start =
				{
					{Ectype_StartSceneMagic, index = 2, magicID = 1109, xPos =47 , yPos = 151},
					{Ectype_StartSceneMagic, index = 2, magicID = 1109, xPos =56 , yPos = 152},
					{Ectype_StartSceneMagic, index = 2, magicID = 1109, xPos =58 , yPos = 147},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},

-----------------------------------------------董卓再现·毒龙峰----------------------------------
[2010] =
	{
		-- 副本名字
		Name = "毒龙峰",
		-- 副本ID，策划配置ID
		EctypeID = 2010,
		-- 静态地图ID
		StaticMapID = 613,
		-- 静态地图ID2
		StaticMapID2 = 614,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Common,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--单人副本
		--EctypeEnterType = EctypeEnterType.Single,
		--组队
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 267, locY = 145},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		EnterInitLocs2 = {locX = 284, locY = 87},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 226, locY = 69},
			{locX = 223, locY = 63},
			{locX = 222, locY = 76},
			{locX = 219, locY = 59},
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =179, yPos = 166},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30890, xPos = 179, yPos = 166, dir = 2},
					{Ectype_CreateNpc, npcID = 30891, xPos = 175, yPos = 164, dir = 2},
					{Ectype_CreateNpc, npcID = 30892, xPos = 184, yPos = 166, dir = 2},
					{Ectype_CreateNpc, npcID = 30893, xPos = 183, yPos = 163, dir = 2},
					{Ectype_CreateNpc, npcID = 30894, xPos = 179, yPos = 162, dir = 2},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10069},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3070, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30890},
					{Ectype_RemoveNpc, npcID = 30891},
					{Ectype_RemoveNpc, npcID = 30892},
					{Ectype_RemoveNpc, npcID = 30893},
					{Ectype_RemoveNpc, npcID = 30894},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 148, yPos = 40},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30898, xPos = 148, yPos = 40, dir = 7},
					{Ectype_CreateNpc, npcID = 30899, xPos = 147, yPos = 37, dir = 7},
					{Ectype_CreateNpc, npcID = 30900, xPos = 146, yPos = 44, dir = 7},
					{Ectype_CreateNpc, npcID = 30902, xPos = 144, yPos = 40, dir = 7},
					{Ectype_CreateNpc, npcID = 30903, xPos = 144, yPos = 43, dir = 7},
			
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10071},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3071, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30898},
					{Ectype_RemoveNpc, npcID = 30899},
					{Ectype_RemoveNpc, npcID = 30900},
					{Ectype_RemoveNpc, npcID = 30901},
					{Ectype_RemoveNpc, npcID = 30902},
					{Ectype_RemoveNpc, npcID = 30903},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 53, yPos = 160},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30906, xPos = 53, yPos = 160, dir = 8},
					{Ectype_CreateNpc, npcID = 30910, xPos = 50, yPos = 159, dir = 8},
					{Ectype_CreateNpc, npcID = 30908, xPos = 49, yPos = 165, dir = 8},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10073},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3072, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30906},
					{Ectype_RemoveNpc, npcID = 30908},
					{Ectype_RemoveNpc, npcID = 30910},

					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 8, xPos = 43, yPos = 146},
					--开启场景光效
					{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 43, yPos = 146},
				},
				-- 步骤跳转
				Goto =
				{
					-- 跳转到第八步
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第8步骤
						{hotAreaID = 8, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
					-- 传送到第二个场景
					{Ectype_TransferToSecondScene},

				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 传送到第二个场景
					--{Ectype_TransferToSecondScene},
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 194, yPos = 176},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30914, xPos = 194, yPos = 176, dir = 6},
					{Ectype_CreateNpc, npcID = 30915, xPos = 190, yPos = 178, dir = 6},
					{Ectype_CreateNpc, npcID = 30916, xPos = 192, yPos = 179, dir = 6},
					{Ectype_CreateNpc, npcID = 30917, xPos = 195, yPos = 179, dir = 6},
					{Ectype_CreateNpc, npcID = 30918, xPos = 195, yPos = 182, dir = 6},
					{Ectype_CreateNpc, npcID = 30919, xPos = 192, yPos = 183, dir = 6},
					{Ectype_CreateNpc, npcID = 30920, xPos = 189, yPos = 183, dir = 6},
					{Ectype_CreateNpc, npcID = 30921, xPos = 187, yPos = 181, dir = 6},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10075},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3073, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30914},
					{Ectype_RemoveNpc, npcID = 30915},
					{Ectype_RemoveNpc, npcID = 30916},
					{Ectype_RemoveNpc, npcID = 30917},
					{Ectype_RemoveNpc, npcID = 30918},
					{Ectype_RemoveNpc, npcID = 30919},
					{Ectype_RemoveNpc, npcID = 30920},
					{Ectype_RemoveNpc, npcID = 30921},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 77, yPos = 196},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30922, xPos = 77, yPos = 196, dir = 4},
					{Ectype_CreateNpc, npcID = 30923, xPos = 80, yPos = 195, dir = 4},
					{Ectype_CreateNpc, npcID = 30924, xPos = 76, yPos = 193, dir = 4},
					{Ectype_CreateNpc, npcID = 30925, xPos = 79, yPos = 192, dir = 4},
					{Ectype_CreateNpc, npcID = 30926, xPos = 81, yPos = 192, dir = 4},
					{Ectype_CreateNpc, npcID = 30927, xPos = 76, yPos = 198, dir = 4},
					{Ectype_CreateNpc, npcID = 30928, xPos = 78, yPos = 198, dir = 4},
					{Ectype_CreateNpc, npcID = 30929, xPos = 80, yPos = 198, dir = 4},
					
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10077},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3074, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30922},
					{Ectype_RemoveNpc, npcID = 30923},
					{Ectype_RemoveNpc, npcID = 30924},
					{Ectype_RemoveNpc, npcID = 30925},
					{Ectype_RemoveNpc, npcID = 30926},
					{Ectype_RemoveNpc, npcID = 30927},
					{Ectype_RemoveNpc, npcID = 30928},
					{Ectype_RemoveNpc, npcID = 30929},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 7, xPos = 213, yPos = 69},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 30930, xPos = 213, yPos = 69, dir = 4},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 7, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[13] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10079},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3075, gotoNext = 14},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 30930},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 7},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[14]=
			{
			-- 步骤开始
				Start =
				{	
				{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 223, yPos = 63},
				{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 222, yPos = 76},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},

--------------------------------幻天宫嗷嗷啊---------------------------------------------------------------------------------------------
[2011] =
	{
		-- 副本名字
		Name = "幻天宫",
		-- 副本ID，策划配置ID
		EctypeID = 2011,
		-- 静态地图ID
		StaticMapID = 615,
		-- 静态地图ID2
		StaticMapID2 = 616,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 45, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Common,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--单人副本
		--EctypeEnterType = EctypeEnterType.Single,
		--组队
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 240, locY = 100},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		EnterInitLocs2 = {locX = 233, locY = 175},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 36, locY = 163},
			
			
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =191, yPos = 156},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31020, xPos = 191, yPos = 156, dir = 6},
					{Ectype_CreateNpc, npcID = 31021, xPos = 188, yPos = 159, dir = 6},
					{Ectype_CreateNpc, npcID = 31022, xPos = 193, yPos = 159, dir = 6},
					{Ectype_CreateNpc, npcID = 31023, xPos = 188, yPos = 162, dir = 6},
					{Ectype_CreateNpc, npcID = 31024, xPos = 193, yPos = 162, dir = 6},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10081},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3076, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31020},
					{Ectype_RemoveNpc, npcID = 31021},
					{Ectype_RemoveNpc, npcID = 31022},
					{Ectype_RemoveNpc, npcID = 31023},
					{Ectype_RemoveNpc, npcID = 31024},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 79, yPos = 209},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31028, xPos = 79, yPos = 209, dir = 2},
					{Ectype_CreateNpc, npcID = 31029, xPos = 76, yPos = 211, dir = 2},
					{Ectype_CreateNpc, npcID = 31030, xPos = 82, yPos = 210, dir = 2},
					{Ectype_CreateNpc, npcID = 31031, xPos = 76, yPos = 208, dir = 2},
					{Ectype_CreateNpc, npcID = 31032, xPos = 82, yPos = 206, dir = 2},
			
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10083},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3077, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31028},
					{Ectype_RemoveNpc, npcID = 31029},
					{Ectype_RemoveNpc, npcID = 31030},
					{Ectype_RemoveNpc, npcID = 31031},
					{Ectype_RemoveNpc, npcID = 31032},
					
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 49, yPos = 143},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31036, xPos = 49, yPos = 143, dir = 7},
					{Ectype_CreateNpc, npcID = 31037, xPos = 45, yPos = 144, dir = 7},
					{Ectype_CreateNpc, npcID = 31038, xPos = 48, yPos = 147, dir = 7},
					{Ectype_CreateNpc, npcID = 31039, xPos = 42, yPos = 147, dir = 7},
					{Ectype_CreateNpc, npcID = 31040, xPos = 45, yPos = 150, dir = 7}
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10085},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3078, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31036},
					{Ectype_RemoveNpc, npcID = 31037},
					{Ectype_RemoveNpc, npcID = 31038},
					{Ectype_RemoveNpc, npcID = 31039},
					{Ectype_RemoveNpc, npcID = 31040},

					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 8, xPos = 23, yPos = 193},
					--开启场景光效
					{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 23, yPos = 193},
				},
				-- 步骤跳转
				Goto =
				{
					-- 跳转到第八步
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第8步骤
						{hotAreaID = 8, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
					-- 传送到第二个场景
					{Ectype_TransferToSecondScene},

				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 传送到第二个场景
					--{Ectype_TransferToSecondScene},
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 173, yPos = 193},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31044, xPos = 173, yPos = 193, dir = 6},
					{Ectype_CreateNpc, npcID = 31045, xPos = 170, yPos = 196, dir = 6},
					{Ectype_CreateNpc, npcID = 31046, xPos = 175, yPos = 196, dir = 6},
					{Ectype_CreateNpc, npcID = 31047, xPos = 170, yPos = 199, dir = 6},
					{Ectype_CreateNpc, npcID = 31048, xPos = 175, yPos = 199, dir = 6},
					
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10087},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3079, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31044},
					{Ectype_RemoveNpc, npcID = 31045},
					{Ectype_RemoveNpc, npcID = 31046},
					{Ectype_RemoveNpc, npcID = 31047},
					{Ectype_RemoveNpc, npcID = 31048},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 139, yPos = 142},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31052, xPos = 139, yPos = 142, dir = 7},
					{Ectype_CreateNpc, npcID = 31053, xPos = 136, yPos = 140, dir = 7},
					{Ectype_CreateNpc, npcID = 31054, xPos = 133, yPos = 140, dir = 7},
					{Ectype_CreateNpc, npcID = 31055, xPos = 133, yPos = 145, dir = 7},
					{Ectype_CreateNpc, npcID = 31056, xPos = 136, yPos = 145, dir = 7},
					
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10089},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3080, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31052},
					{Ectype_RemoveNpc, npcID = 31053},
					{Ectype_RemoveNpc, npcID = 31054},
					{Ectype_RemoveNpc, npcID = 31055},
					{Ectype_RemoveNpc, npcID = 31056},
					
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 7, xPos = 42, yPos = 156},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31060, xPos = 42, yPos = 156, dir = 7},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 7, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[13] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10091},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3081, gotoNext = 14},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31060},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 7},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[14]=
			{
			-- 步骤开始
				Start =
				{	
				{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 33, yPos = 156},
				{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 36, yPos = 163},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},
--------------------------------------天公山-----------------------
[2016] =
	{
		-- 副本名字
		Name = "天公山",
		-- 副本ID，策划配置ID
		EctypeID = 2016,
		-- 静态地图ID
		StaticMapID = 622,
		-- 静态地图ID2
		--StaticMapID2 = 622,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 35, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Common,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 235, locY = 28},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		--EnterInitLocs2 = {locX = 233, locY = 175},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 33, locY = 228},
			
			
			
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =100, yPos = 100},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 1000, xPos = 100, yPos = 100, dir = 6},
					{Ectype_CreateNpc, npcID = 1000, xPos = 100, yPos = 100, dir = 6},
					{Ectype_CreateNpc, npcID = 1000, xPos = 100, yPos = 100, dir = 6},
					{Ectype_CreateNpc, npcID = 1000, xPos = 100, yPos = 100, dir = 6},
					{Ectype_CreateNpc, npcID = 1000, xPos = 100, yPos = 100, dir = 6},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 100},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3076, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 100},
					{Ectype_RemoveNpc, npcID = 100},
					{Ectype_RemoveNpc, npcID = 100},
					{Ectype_RemoveNpc, npcID = 100},
					{Ectype_RemoveNpc, npcID = 100},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			
	},
},
-----------------------------------------------董卓再现·赤魂岭----------------------------------
[2012]=
	{
		-- 副本名字
		Name = "赤魂岭",
		-- 副本ID，策划配置ID
		EctypeID = 2012,
		-- 静态地图ID
		StaticMapID = 618,
		-- 静态地图ID2
		StaticMapID2 = 617,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 42, maxLevel = 100},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Team,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--单人副本
		--EctypeEnterType = EctypeEnterType.Single,
		--组队
		EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 100,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 0,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 74, locY = 88},
		--EnterInitLocs = {locX = 40, locY = 192},
		-- 进入副本第二个场景的初始坐标，分别为X坐标和Y坐标
		EnterInitLocs2 = {locX = 230, locY = 126},
		-- 副本结束后出现传送门的坐标
		TransferDoorLocs =
		{
			{locX = 114, locY = 250},
			--{locX = 223, locY = 63},
			--{locX = 222, locY = 76},
			--{locX = 219, locY = 59},
		},
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {itemID = 10000, itemNum = 1},
		-- 是否可以使用治疗类道具，默认不用配置此字段，代表可以使用
		CanUseHealItems = true,
		-- 是否可以在副本里进行交易，默认不用配置此字段，代表可以交易
		CanTradeInEctype = false,
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 1, xPos =161, yPos = 68},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31110, xPos = 161, yPos = 68, dir = 4},
					{Ectype_CreateNpc, npcID = 31111, xPos = 164, yPos = 71, dir = 4},
					{Ectype_CreateNpc, npcID = 31113, xPos = 164, yPos = 66, dir = 4},
					{Ectype_CreateNpc, npcID = 31115, xPos = 169, yPos = 72, dir = 4},
					{Ectype_CreateNpc, npcID = 31116, xPos = 169, yPos = 63, dir = 4},
					
					-- 开启场景特效
					--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 70, yPos = 79},
					--启动机关
					--{Ectype_LoadOrganEffect},
					-- 添加动态传送门进入指定副本
					--{Ectype_DynamicTransferDoors, ectypeID = 4, transferDoorLocX = 60, transferDoorLocY = 74},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第2步骤
						{hotAreaID = 1, gotoNext = 2},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[2] =
			{
				-- 步骤开始
				Start =
				{	
					--打开飞剑
					--{Ectype_ResumeOrganEffect, npcID = 30046},
					 --打开指定对话
					{Ectype_OpenDialog, dialogID = 10093},
					-- 关闭场景特效
					--{Ectype_StopSceneMagic, index = 1},
				},
				-- 步骤跳转
				Goto =
				{

					-- 战斗结束触发
					
					FightWin =
					{
						-- 跳转到第3步骤
						{fightID = 3082, gotoNext = 3},
					},
					
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31110},
					{Ectype_RemoveNpc, npcID = 31111},
					{Ectype_RemoveNpc, npcID = 31113},
					{Ectype_RemoveNpc, npcID = 31115},
					{Ectype_RemoveNpc, npcID = 31116},
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 1},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[3] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 2, xPos = 151, yPos =137},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31118, xPos = 151, yPos = 137, dir = 6},
					{Ectype_CreateNpc, npcID = 31119, xPos = 145, yPos = 141, dir = 6},
					{Ectype_CreateNpc, npcID = 31121, xPos = 156, yPos = 141, dir = 6},
					{Ectype_CreateNpc, npcID = 31123, xPos = 147, yPos = 145, dir = 6},
					{Ectype_CreateNpc, npcID = 31124, xPos = 152, yPos = 146, dir = 6},
			
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 2, gotoNext = 4},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[4] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10095},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3083, gotoNext = 5},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31118},
					{Ectype_RemoveNpc, npcID = 31119},
					{Ectype_RemoveNpc, npcID = 31121},
					{Ectype_RemoveNpc, npcID = 31123},
					{Ectype_RemoveNpc, npcID = 31124},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 2},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[5] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 3, xPos = 187, yPos = 216},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31126, xPos = 187, yPos = 216, dir = 4},
					{Ectype_CreateNpc, npcID = 31127, xPos = 184, yPos = 220, dir = 4},
					{Ectype_CreateNpc, npcID = 31129, xPos = 188, yPos = 220, dir = 4},
					{Ectype_CreateNpc, npcID = 31131, xPos = 181, yPos = 225, dir = 4},
                                        {Ectype_CreateNpc, npcID = 31132, xPos = 185, yPos = 224, dir = 4},
                                        {Ectype_CreateNpc, npcID = 31133, xPos = 189, yPos = 224, dir = 4},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 3, gotoNext = 6},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[6] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10097},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3084, gotoNext = 7},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31126},
					{Ectype_RemoveNpc, npcID = 31127},
					{Ectype_RemoveNpc, npcID = 31129},
                                        {Ectype_RemoveNpc, npcID = 31131},
                                        {Ectype_RemoveNpc, npcID = 31132},
                                        {Ectype_RemoveNpc, npcID = 31133},

					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 3},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[7] =
			{
				-- 步骤开始
				Start =
				{
					{Ectype_CreateHotArea, hotAreaID = 8, xPos = 186, yPos = 231},
					--开启场景光效
					{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 186, yPos = 231},
				},
				-- 步骤跳转
				Goto =
				{
					-- 跳转到第八步
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第8步骤
						{hotAreaID = 8, gotoNext = 8},
					},
				},
				-- 步骤结束
				End =
				{
					-- 传送到第二个场景
					{Ectype_TransferToSecondScene},

				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[8] =
			{
				-- 步骤开始
				Start =
				{
					-- 传送到第二个场景
					--{Ectype_TransferToSecondScene},
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 4, xPos = 40, yPos = 156},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31134, xPos = 40, yPos = 156, dir = 7},
					{Ectype_CreateNpc, npcID = 31135, xPos = 37, yPos = 155, dir = 7},
					{Ectype_CreateNpc, npcID = 31137, xPos = 41, yPos = 159, dir = 7},
					{Ectype_CreateNpc, npcID = 31139, xPos = 34, yPos = 154, dir = 7},
					{Ectype_CreateNpc, npcID = 31140, xPos = 42, yPos = 162, dir = 7},
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 4, gotoNext = 9},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[9] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10099},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3085, gotoNext = 10},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31134},
					{Ectype_RemoveNpc, npcID = 31135},
					{Ectype_RemoveNpc, npcID = 31137},
					{Ectype_RemoveNpc, npcID = 31139},
					{Ectype_RemoveNpc, npcID = 31140},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 4},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[10] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 5, xPos = 177, yPos = 180},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31142, xPos = 177, yPos = 180, dir = 6},
					{Ectype_CreateNpc, npcID = 31143, xPos = 174, yPos = 184, dir = 6},
					{Ectype_CreateNpc, npcID = 31145, xPos = 178, yPos = 184, dir = 6},
					{Ectype_CreateNpc, npcID = 31147, xPos = 171, yPos = 188, dir = 6},
					{Ectype_CreateNpc, npcID = 31148, xPos = 175, yPos = 188, dir = 6},
					{Ectype_CreateNpc, npcID = 31149, xPos = 179, yPos = 188, dir = 6},
					
					
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 5, gotoNext = 11},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[11] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10101},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3086, gotoNext = 12},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31142},
					{Ectype_RemoveNpc, npcID = 31143},
					{Ectype_RemoveNpc, npcID = 31145},
					{Ectype_RemoveNpc, npcID = 31147},
					{Ectype_RemoveNpc, npcID = 31148},
					{Ectype_RemoveNpc, npcID = 31149},
					
					
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 5},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[12] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateHotArea, hotAreaID = 7, xPos = 114, yPos = 240},
					-- 创建动态NPC
					{Ectype_CreateNpc, npcID = 31150, xPos = 114, yPos = 240, dir = 6},
				},
				-- 步骤跳转
				Goto =
				{
					-- 进入热区触发
					EnterArea =
					{
						-- 跳转到第4步骤
						{hotAreaID = 7, gotoNext = 13},
					},
				},
				-- 步骤结束
				End =
				{
				},
			},
			[13] =
			{
				-- 步骤开始
				Start =
				{
					-- 打开指定对话
					{Ectype_OpenDialog, dialogID = 10103},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{
						-- 跳转到第5步骤
						{fightID = 3087, gotoNext = 14},
					},
				},
				-- 步骤结束
				End =
				{
					-- 删除动态NPC
					{Ectype_RemoveNpc, npcID = 31150},
					-- 删除热区
					{Ectype_DestroyHotArea, hotAreaID = 7},
				},
				-- 进度奖励
				Prizes =
				{
					-- 经验奖励
					ExpPrize = 20,
					-- 金钱奖励
					MoneyPrize = 20,
					-- 道具奖励
					ItemPrize =
					{

					},
				},
			},
			[14]=
			{
			-- 步骤开始
				Start =
				{	
				{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 114, yPos = 250},
				--{Ectype_StartSceneMagic, index = 1, magicID = 1109, xPos = 222, yPos = 76},
				},
				-- 步骤跳转
				Goto =
				{
					-- 战斗结束触发
					FightWin =
					{

					},
				},
				-- 步骤结束
				End =
				{

				},
			},
		},
	},
-------------------------------------------------------------帮会副本配置--------------------------------------------------------------
	[3000] =
	{
		-- 副本名字
		Name = "帮会副本1",
		-- 副本ID，策划配置ID
		EctypeID = 3000,
		-- 静态地图ID
		StaticMapID = 608,
		-- 进入副本所需等级，分别为最小等级和最大等级，配置成0代表不限制玩家等级
		EnterNeedLevel = {minLevel = 1, maxLevel = 150},
		-- 进入副本最少人数，组队时有效
		EnterNeedPlayerNum = 1,
		-- 副本类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeType
		EctypeType = EctypeType.Faction,
		-- 副本进入类型，见server\sbin\resource\script\misc\EctypeConstant.lua中的EctypeEnterType
		--单人副本
		--EctypeEnterType = EctypeEnterType.Single,
		--组队
		--EctypeEnterType = EctypeEnterType.Team,
		-- 副本CD内可完成次数，除了周常副本，其他类型副本的CD类型都是天
		EctypeCDFinishTimes = 1,
		-- 副本存在时间，超过这个时间，副本就会销毁，以分钟为单位，如果配置成0则代表不限制时间
		EctypeExistTime = 2,
		-- 副本弥留时间，当副本里不存在玩家时开始计时，超过这个时间，副本就会销毁，配置成0的话，当玩家掉线离开副本就立即销毁，以分钟为单位
		EctypeDyingTime = 0,
		-- 副本定时监测时间
		EctypeCheckTime = 1,
		-- 进入副本初始坐标，分别为X坐标和Y坐标
		EnterInitLocs = {locX = 140, locY = 29},
		-- 副本完成条件, 采集物件的个数 
		CollectObjectNum = 2,
		-- 副本结束后出现传送门的坐标
		--[[
		TransferDoorLocs =
		{
			{locX = 36, locY = 163},
		},
		-]]
		-- 消耗道具可以额外次数进入，分别为道具ID和道具数目
		EnterNeedItems = {},
		-- 是否可以使用治疗类道具，默认不用配置此字段，代表可以使用
		CanUseHealItems = true,
		-- 是否可以在副本里进行交易，默认不用配置此字段，代表可以交易
		CanTradeInEctype = false,
		-- 副本机关
		EctypeEffect = {Ectype_LoadOrganEffect},
		-- 副本逻辑流程
		LogicProcedure =
		{
			-- 步骤一
			[1] =
			{
				-- 步骤开始
				Start =
				{
					-- 创建热区
					{Ectype_CreateObject, objectID = 1000, objectNum = 8},
					-- 创建动态NPC
					{Ectype_CreatePatrolNpc, npcID = 60201, npcNum = 8, scriptID = 35401, radius = 5},
				},
				Goto =
				{
					-- 这两个什么都不需要配置
				},
				-- 步骤结束
				End =
				{
					-- 这两个什么都不需要配置
				},
				-- 进度奖励
				Prizes =
				{
					--个人经验，帮贡奖励，帮会资金，帮会声望奖励。
					[1] =
					{	-- 经验奖励
						ExpPrize = 20,
						-- 帮贡
						FactionCont = 20,
						--资金
						FactionMoney = 20,
						-- 声望
						FactionFame = 20,
					},
					[2] = 
					{
						-- 经验奖励
						ExpPrize = 20,
						-- 帮贡
						FactionCont = 20,
						--资金
						FactionMoney = 20,
						-- 声望
						FactionFame = 20,
					},
					[3] = 
					{
						-- 经验奖励
						ExpPrize = 20,
						-- 帮贡
						FactionCont = 20,
						--资金
						FactionMoney = 20,
						-- 声望
						FactionFame = 20,
					},
					[4] = 
					{
						-- 经验奖励
						ExpPrize = 20,
						-- 帮贡
						FactionCont = 20,
						--资金
						FactionMoney = 20,
						-- 声望
						FactionFame = 20,
					},
					
				},
			},
		},
	},
}


-- 静态地图跟副本的对应表
tStaticMapID_EctypeID = {}

-- 检测副本配置是否合法
function CheckEctypeConfigValid()
	for ectypeID, _ in pairs(tEctypeDB) do
		if tEctypeDB[ectypeID].EctypeID ~= ectypeID then
			print("副本ID配置错误，EctypeID = ", ectypeID)
		end
		-- 插入到静态地图跟副本的对应表里
		local staticMapID = tEctypeDB[ectypeID].StaticMapID
		if not tStaticMapID_EctypeID[staticMapID] then
			tStaticMapID_EctypeID[staticMapID] = ectypeID
		else
			-- 重复。。
		end
		for index, _ in pairs(tEctypeDB[ectypeID].LogicProcedure) do
			-- 插入热区触发对应的索引
			local gotoActions = tEctypeDB[ectypeID].LogicProcedure[index].Goto
			if gotoActions and gotoActions.EnterArea then
				local startActions = tEctypeDB[ectypeID].LogicProcedure[index].Start
				for index = 1, table.getn(gotoActions.EnterArea) do
					local hotAreaID = gotoActions.EnterArea[index].hotAreaID
					for actionIndex = 1, table.getn(startActions) do
						if startActions[actionIndex].hotAreaID then
							if startActions[actionIndex].hotAreaID == hotAreaID then
								gotoActions.EnterArea[index].index = actionIndex
							end
						end
					end
					-- 判断下索引是否插入成功
					if not gotoActions.EnterArea[index].index then
						local szErrorDes = "副本热区触发配置错误！副本ID = "..ectypeID.."，热区ID = "..hotAreaID
						print(szErrorDes)
					end
				end
			end
		end
		-- 检测进入副本的初始坐标是否是障碍
		local posValid = CoScene:PosValidate(tEctypeDB[ectypeID].StaticMapID or 0 , tEctypeDB[ectypeID].EnterInitLocs.locX or 0, tEctypeDB[ectypeID].EnterInitLocs.locY or 0, 0)
		if not posValid then
			print("副本地图初始坐标不合法，EctypeID = ", ectypeID)
		end
	end
end
