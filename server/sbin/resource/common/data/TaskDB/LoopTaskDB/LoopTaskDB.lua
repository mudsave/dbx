--[[LoopTaskDB.lua
	循环任务配置(任务系统)
]]

--循环任务
LoopTaskDB = 
{
	-- 师门任务
	[10001] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.QYD,
		startNpcID = 20004,
		loop =10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 30},
			[2] = {31, 40},
			[3] = {41, 50},
			[4] = {51, 150},
		},
		targets = 
		{
			-- 1- 30级
			[1] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 0,
				[LoopTaskTargetType.talk] = 60,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 0,
				[LoopTaskTargetType.mysteryBus] = 0,
				[LoopTaskTargetType.donate] = 50,
			},
			-- 31 - 40 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 30,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--41- 50级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 40,
				[LoopTaskTargetType.mysteryBus] = 40,
				[LoopTaskTargetType.donate] = 40,
			},
			--51- 150级
			[4] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,
				[LoopTaskTargetType.talk] = 30,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 30,
				[LoopTaskTargetType.donate] = 40,
			},
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = MasterRewardFormula.addXp,
			--任务道行
			[TaskRewardList.player_tao] = MasterRewardFormula.addTao,
			--任务潜能
			[TaskRewardList.player_pot] = MasterRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = MasterRewardFormula.addSubMoney,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[2] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[3] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[4] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
		},
	},
	[10002] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.JXS,
		startNpcID = 20006,
		loop = 10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 30},
			[2] = {31, 40},
			[3] = {41, 50},
			[4] = {51, 150},
		},
		targets = 
		{
			-- 1- 30级
			[1] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 0,
				[LoopTaskTargetType.talk] = 60,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 0,
				[LoopTaskTargetType.mysteryBus] = 0,
				[LoopTaskTargetType.donate] = 50,
			},
			-- 31 - 40 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 30,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--41- 50级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 40,
				[LoopTaskTargetType.mysteryBus] = 40,
				[LoopTaskTargetType.donate] = 40,
			},
			--51- 150级
			[4] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,
				[LoopTaskTargetType.talk] = 30,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 30,
				[LoopTaskTargetType.donate] = 40,
			},
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = MasterRewardFormula.addXp,
			--任务道行
			[TaskRewardList.player_tao] = MasterRewardFormula.addTao,
			--任务潜能
			[TaskRewardList.player_pot] = MasterRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = MasterRewardFormula.addSubMoney,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[2] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[3] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[4] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
		},
	},
	[10003] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.ZYM,
		startNpcID = 20008,
		loop = 10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 30},
			[2] = {31, 40},
			[3] = {41, 50},
			[4] = {51, 150},
		},
		targets = 
		{
			-- 1- 30级
			[1] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 0,
				[LoopTaskTargetType.talk] = 60,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 0,
				[LoopTaskTargetType.mysteryBus] = 0,
				[LoopTaskTargetType.donate] = 50,
			},
			-- 31 - 40 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 30,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--41- 50级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 40,
				[LoopTaskTargetType.mysteryBus] = 40,
				[LoopTaskTargetType.donate] = 40,
			},
			--51- 150级
			[4] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,
				[LoopTaskTargetType.talk] = 30,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 30,
				[LoopTaskTargetType.donate] = 40,
			},
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = MasterRewardFormula.addXp,
			--任务道行
			[TaskRewardList.player_tao] = MasterRewardFormula.addTao,
			--任务潜能
			[TaskRewardList.player_pot] = MasterRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = MasterRewardFormula.addSubMoney,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[2] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[3] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[4] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
		},
	},
	[10004] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.YXG,
		startNpcID = 20009,
		loop = 10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 30},
			[2] = {31, 40},
			[3] = {41, 50},
			[4] = {51, 150},
		},
		targets = 
		{
			-- 1- 30级
			[1] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 0,
				[LoopTaskTargetType.talk] = 60,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 0,
				[LoopTaskTargetType.mysteryBus] = 0,
				[LoopTaskTargetType.donate] = 50,
			},
			-- 31 - 40 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 30,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--41- 50级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 40,
				[LoopTaskTargetType.mysteryBus] = 40,
				[LoopTaskTargetType.donate] = 40,
			},
			--51- 150级
			[4] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,
				[LoopTaskTargetType.talk] = 30,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 30,
				[LoopTaskTargetType.donate] = 40,
			},
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = MasterRewardFormula.addXp,
			--任务道行
			[TaskRewardList.player_tao] = MasterRewardFormula.addTao,
			--任务潜能
			[TaskRewardList.player_pot] = MasterRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = MasterRewardFormula.addSubMoney,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[2] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[3] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[4] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
		},
	},
	[10005] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.TYD,
		startNpcID = 20005,
		loop = 10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 30},
			[2] = {31, 40},
			[3] = {41, 50},
			[4] = {51, 150},
		},
		targets = 
		{
			-- 1- 30级
			[1] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 0,
				[LoopTaskTargetType.talk] = 60,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 0,
				[LoopTaskTargetType.mysteryBus] = 0,
				[LoopTaskTargetType.donate] = 50,
			},
			-- 31 - 40 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 30,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--41- 50级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 40,
				[LoopTaskTargetType.mysteryBus] = 40,
				[LoopTaskTargetType.donate] = 40,
			},
			--51- 150级
			[4] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,
				[LoopTaskTargetType.talk] = 30,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 30,
				[LoopTaskTargetType.donate] = 40,
			},
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = MasterRewardFormula.addXp,
			--任务道行
			[TaskRewardList.player_tao] = MasterRewardFormula.addTao,
			--任务潜能
			[TaskRewardList.player_pot] = MasterRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = MasterRewardFormula.addSubMoney,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[2] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[3] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[4] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
		},
	},
	[10006] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.PLG,
		startNpcID = 20007,
		loop = 10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 30},
			[2] = {31, 40},
			[3] = {41, 50},
			[4] = {51, 150},
		},
		targets = 
		{
			-- 1- 30级
			[1] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 0,
				[LoopTaskTargetType.talk] = 60,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 0,
				[LoopTaskTargetType.mysteryBus] = 0,
				[LoopTaskTargetType.donate] = 50,
			},
			-- 31 - 40 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 60,
				[LoopTaskTargetType.partrolScript] = 50,
				[LoopTaskTargetType.escort] = 0,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 30,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--41- 50级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 40,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 40,
				[LoopTaskTargetType.partrolTalk] = 40,
				[LoopTaskTargetType.mysteryBus] = 40,
				[LoopTaskTargetType.donate] = 40,
			},
			--51- 150级
			[4] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,
				[LoopTaskTargetType.talk] = 30,
				[LoopTaskTargetType.buyItem] = 40,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 60,
				[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 30,
				[LoopTaskTargetType.donate] = 40,
			},
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = MasterRewardFormula.addXp,
			--任务道行
			[TaskRewardList.player_tao] = MasterRewardFormula.addTao,
			--任务潜能
			[TaskRewardList.player_pot] = MasterRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = MasterRewardFormula.addSubMoney,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[2] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[3] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
			[4] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1051015, itemNum = 1},
				},
			},
		},
	},
	-- 试炼任务
	[10007] = 
	{
		name = "试炼任务",
		startDialogID = nil,
		taskType2 = TaskType2.Trial,
		level = {40, 150},
		school = nil,
		startNpcID = 27150,
		loop = 200,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.week,
		targets = 
		{
			[1] =
			{
			    -- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 60,		            -- 悬赏战斗
				[LoopTaskTargetType.talk] = 40, 		            -- 和NPC对话
				[LoopTaskTargetType.buyItem] = 50,		            -- 上交物品
				[LoopTaskTargetType.catchPet] = 50,		            -- 捕捉宠物
				[LoopTaskTargetType.partrolScript] = 60,	        -- 暗雷战斗
				[LoopTaskTargetType.deliverLetters] = 40,		    -- 送信
				[LoopTaskTargetType.brightMine] = 60,		        -- 挑战明雷
				--[LoopTaskTargetType.puzzle]		=100,
			}
		},
		-- 公式奖励
		formulaRewards =
		{
                        --角色经验
			[TaskRewardList.player_xp] = TrialRewardFormula.addXp,
			--角色道行
			[TaskRewardList.player_tao] = TrialRewardFormula.addTao,
			--角色潜能
			[TaskRewardList.player_pot] = TrialRewardFormula.addPot,
			--绑银
			[TaskRewardList.subMoney] = TrialRewardFormula.addSubMoney,
			--宠物经验
			[TaskRewardList.pet_xp] = TrialRewardFormula.addPetXp,
			--宠物道行
			[TaskRewardList.pet_tao] = TrialRewardFormula.addPetTao
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[20] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[30] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[40] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[50] = 
				{
					[1] = {itemID = 1031011, itemNum = 1},----银宝箱
				},
				[60] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[70] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[80] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[90] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[100] = 
				{
					[1] = {itemID = 1031011, itemNum = 1},----银宝箱
				},
				[110] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[120] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[130] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[140] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[150] = 
				{
					[1] = {itemID = 1031011, itemNum = 1},----银宝箱
				},
				[160] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[170] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[180] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[190] = 
				{
					[1] = {itemID = 1031010, itemNum = 1},----铜宝箱
				},
				[200] = 
				{
					[1] = {itemID = 1031012, itemNum = 1},----金宝箱
				},
			},
		},
	},
	-- 天道任务
	[10008] = 
	{
		name = "天道任务",
		startDialogID = nil,
		taskType2 = TaskType2.Heaven,
		level = {30, 150},
		teamType = TeamType.team,
		condition = {teamerCount = 2, levelDiff = 10},
		school = nil,
		startNpcID = 29008,		
		loop = 10,
		period = TaskPeriod.day,
		targetLevelSection =
		{
			[1] = {1, 150},
		},
		targets = 
		{
			[1] =
			{
				[LoopTaskTargetType.script] = 50,		            -- 明雷战斗
			},
		},
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1031013, itemNum = 1},
				},
			},
		}
	},
	-- 帮会任务
	[10009] = 
	{
		name = "帮会任务",
		startDialogID = nil,
		taskType2 = TaskType2.Faction,
		level = {20, 60},
		--team = false,
		school = nil,
		startNpcID = 30817,		
		loop = 10,
		period = TaskPeriod.day,
		targetLevelSection =
		{
			[1] = {1, 150},
		},
		targets = 
		{
			[1] =
			{
				[LoopTaskTargetType.paidEquip] = 100,
			},
		},
		normalRewards =
		{
			-- 帮贡奖励
			[TaskRewardList.faction_cont] = 50,
			-- 帮会资金
			[TaskRewardList.faction_money] = 50,
			-- 帮会声望
			[TaskRewardList.faction_Fame] = 50
		},
		formulaRewards =
		{	-- 道行 公式
			[TaskRewardList.player_tao] = FactionRewardFormula.addTao,
			-- 潜能 公式
			[TaskRewardList.player_pot] = FactionRewardFormula.addPot,
			-- 宠物
			[TaskRewardList.pet_tao] = FactionRewardFormula.addTao,
		},
	},

	[10020] = 
	{
		name = "师门任务",
		startDialogID = nil,
		-- 类型是师门任务
		taskType2 = TaskType2.Master,
		level = {20, 150},
		school = SchoolType.QYD,
		startNpcID = 29040,
		loop = 10,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 50},
			[2] = {51, 100},
			[3] = {101, 150},
		},
		targets = 
		{
			-- 1- 50级
			[1] =
			{
				-- 首先来测试等级分段的权重
				--[LoopTaskTargetType.script] = 50,
				--[LoopTaskTargetType.talk] = 50,
				--[LoopTaskTargetType.buyItem] = 50,
				--[LoopTaskTargetType.catchPet] = 50,
				--[LoopTaskTargetType.partrolScript] = 50,
				--[LoopTaskTargetType.escort] = 50,
				--[LoopTaskTargetType.deliverLetters] = 50,
				--[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 50,
				--[LoopTaskTargetType.donate] = 50,

			},
			-- 50 - 100 级
			[2] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 50,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 50,
				--[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			},
			--100- 160级
			[3] =
			{
				-- 首先来测试等级分段的权重
				[LoopTaskTargetType.script] = 50,
				[LoopTaskTargetType.talk] = 50,
				[LoopTaskTargetType.buyItem] = 50,
				[LoopTaskTargetType.catchPet] = 50,
				[LoopTaskTargetType.partrolScript] = 50,
				--[LoopTaskTargetType.escort] = 50,
				[LoopTaskTargetType.deliverLetters] = 50,
				[LoopTaskTargetType.partrolTalk] = 50,
				[LoopTaskTargetType.mysteryBus] = 50,
				[LoopTaskTargetType.donate] = 50,
			}
		},
		-- 公式奖励
		formulaRewards =
		{
			[TaskRewardList.player_xp] = RewardFormula.addXp,
		},
		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1012018, itemNum = 1},
				},
			},
		},
		--固定奖励
		normalRewards =
		{
			[TaskRewardList.player_tao] = 1000,
		},
	},

	-- 压测测试专用
	[1] = 
	{
		name = "压测任务",
		startDialogID = nil,
		taskType2 = TaskType2.Master,
		level = {1, 150},
		school = nil,
		startNpcID = 1,
		loop =1000,
		-- 这个来确定是每日，还是每周的。
		period = TaskPeriod.day,
		-- 这个表示代表
		levelFlag = true,
		targetLevelSection =
		{
			[1] = {1, 150},
		},
		targets = 
		{
			[1] =
			{
				[LoopTaskTargetType.brightMine] = 100,		            -- 明雷战斗
			},
		},
		itemRewards =
		{}
	},

	[10010] =
	{
		name = "讨逆任务",
		taskType2 = TaskType2.Heaven,
		-- 等级限制，
		level = {35, 150},
		-- 可以单人，可以组队
		teamType = TeamType.special,
		-- 组队等级差
		condition = {levelDiff = 10},
		startNpcID = 29008,		
		loop = 10,
		period = TaskPeriod.day,
		targetLevelSection =
		{
			[1] = {1, 150},
		},
		targets = 
		{
			[1] =
			{
				[LoopTaskTargetType.script] = 50,		            -- 明雷战斗
			},
		},

		-- 物品奖励
		itemRewards =
		{
			-- 等级区间
			[1] =
			{	
				-- 环数
				[10] = 
				{
					-- 支持多种物品,和个数
					[1] = {itemID = 1012018, itemNum = 1},
				},
			},
		},
	},
}