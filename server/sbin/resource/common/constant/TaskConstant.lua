-- common.constant.TaskConstant.lua

TaskRewardList =
{
	player_xp		= 1,	--玩家经验
	pet_xp			= 2,	--宠物经验
	money			= 3,	--银两
	subMoney		= 4,	--绑银
	cashMoney		= 5,
	goldCoin		= 6,
	player_tao		= 7,	--人物道行
	pet_tao			= 8,	--宠物道行
	player_pot		= 9,	--人物潜能

	faction_cont	= 10,	--帮贡
	faction_money	= 11,	--帮会资金
	faction_Fame	= 12,	--帮会声望

}

--任务状态
TaskStatus = {
	Active          = 0x01, --正在进行
	Done            = 0x02, --完成
	Failed          = 0x04, --失败
	Finished        = 0x08, --完成,已交还
	Deleted         = 0x10, --删除的任务
	HalfDone		= 0x20, --野外地图任务雷的特殊状态
	Collection		= 0x40, --特殊状态之采集触发器
}

----类型2
TaskType2 = {
	NewBie			= 0x01,		--指引任务
	Main			= 0x02,		--主线任务
	Faction			= 0x04,		--帮会任务
	Active			= 0x08,		--活动任务
	Daily			= 0x10,		--每日
	Copy			= 0x20,		--副本
	Sub				= 0x40,		--支线
	Random			= 0x80,		--奇遇任务
	SchoolExercise	= 0x100,	--门派历练
	Master			= 0x200,	--师徒任务
	Challenge		= 0x400,	--挑战任务
	Trial			= 0x800,	--试炼任务
	Heaven			= 0x1000,	--天道任务
	Babel			= 0x2000,	--通天塔任务
	Puzzle			= 0x4000,	--拼图任务

}

-- 指引的类型
GuideType = {
	Talk			= 0x01,		--指引任务
	DoTask			= 0x02,		--主线任务
}

--循环任务目标类型
LoopTaskTargetType =
{
	script				= 1,		-- 脚本战斗
	talk				= 2,		-- 和NPC对话
	buyItem				= 3,		-- 买东西
	catchPet			= 4,		-- 捕捉宠物
	partrolScript		= 5,		-- 巡逻战斗
	escort				= 6,		-- 护送
	deliverLetters		= 7,		-- 送信
	recovery			= 8,		-- 动态收集
	partrolTalk			= 9,		-- 巡逻对话
	mysteryBus			= 10,		-- 神秘商人
	donate				= 11,		-- 捐赠
	paidEquip			= 12,		-- 上交装备
	brightMine			= 13,		-- 明雷
	-- 外面不用配置
	talkScript			= 14,		-- 对话战斗
	itemTalk			= 15,		-- 物品战斗

	collectMaterials	= 16,		-- 收集材料
	puzzle				= 17,		-- 拼图玩法
}

CanRecetiveLoopTaskLvl = 
{
	[1] = 20,
	[2] = 30,
	[3] = 40,
}

-- 队伍条件
TeamType =
{
	-- 单人
	single = 1,
	-- 组队
	team = 2,
	-- 单人，组队都可以
	special = 3,
}
