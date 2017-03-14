-- common.constant.DialogConstant.lua

--对话条件类型
DialogCondition =
{
	Level = 1,				--等级条件
	HasTask = 2,			--任务条件
	School = 3,				--门派条件
	Team = 4,				--组队条件
	Currency = 5,			--货币条件
	Attr	= 6,			--战绩条件
	HasTasks = 7,			--含有多个任务(相互之间是或关系)
	Faction = 8,			--帮派条件
	CheckOwner = 9,			--npc绑定玩家条件
	LoopTaskTalk = 10,
	HasFactionTask = 11,
	NotHasFactionTask = 12,
	CheckTaskTeam = 13,
	CheckLoopTask = 14,
	HasTask_1 = 15,
	CheckLoopTasks = 16,
	CheckBeastBless = 17,
	Time	= 18,
	PlayerCountInGoldHuntMap = 19,
	DekaronSchoolActivity = 20,
	HaveActivityTarget = 21,
	DekaronSchoolActivityTarget = 22,
	TkillMonster = 23,
	DailyTaskTimes = 24,
	MatchTaskNpc = 25,
	NoMatchTaskNpc = 26,
	MatchTaskState = 27,

}

--对话类型
DialogType =
{
	HasOption	= 1,		--有选项对话
	FunctionOption = 2,		--特殊类型对话
	NotOption	= 3,		--无选项对话
	Error	= 4,			--错误对话
}

--对话选项功能
DialogActionType =
{
	SwithScene			= 1,		-- 切换场景
	Goto				= 2,		-- 跳转对话
	EnterFight			= 3,		-- 进入战斗
	EnterScriptFight	= 4,		-- 进入脚本战斗
	EnterEctype			= 5,		-- 进入副本
	RingEctype			= 6,		-- 连环副本1
	EnterRingEctype		= 7,		-- 连环副本2
	EnterPVPFight		= 8,		-- 进入pvp战斗
	FrozenBuff			= 9,		-- 冰冻双倍经验丹
	CancelFrozenBuff	= 10,		-- 取消冰冻双倍经验丹
	RecetiveTask		= 11,		-- 接受一个任务
	RequestNpcTrade		= 12,		-- 请求Npc货架交易
	GetItem				= 13,		-- npc对话获得物品
	FinishTask			= 14,		-- 模拟交任务
	DoneTask			= 15,		-- 模拟完成任务
	AutoTrace			= 16,		-- 自动寻路
	RecoverMaxHp        = 17,       -- 恢复角色最大血量
	FlyEffect			= 18,       -- 飞剑动画
	CloseDialog			= 19,		-- 关闭对话
	UITip				= 20,		-- UI提示
	OpenUI              = 21,       -- 打开UI
	Gotos				= 22,       -- 跳转多对话
	RepairPet			= 23,		-- 修复当前出战宠物
	RepairAllPet		= 24,		-- 修复所有宠物
	PaidItem			= 25,		-- 上缴物品
	PaidPet				= 26,		-- 上缴宠物
	MayTaskFight		= 27,		-- 可能进入战斗，可能完成任务
	BuyItem				= 28,		-- 对话买物品
	CostMoney			= 29,		-- 花费绑银完成任务
	Fight				= 30,		-- 进行战斗来完成任务
	DeductMoney			= 31,		-- 对话扣除玩家金钱
	openLookTaskWin		= 32,		-- 循环任务打开窗口
	EnterTreasureFight	= 33,		-- 进行宝藏类型的脚本战斗
	ShowFactionList		= 34,
	RemoveItem			= 35,		-- 移除物品
	CreateFaction		= 36,
	EnterCatchPetFight	= 37,		-- 捕宠战斗
	EnterCatchPetMap	= 38,		-- 进入抓宠场景
	EnterFactionScene	= 40,		-- 进入帮派场景
	ContributeFaction	= 41,		-- 帮派捐献
	OpenEquipAppraisal	= 42,		-- 装备鉴定
	ExchangeProps		= 43,		-- 兑换道具
	RecetiveSpecialTask = 44,		-- 接受天道任务
	ConsumeRecetiveTask	= 45,		-- 消耗并接受任务 {这里消耗的类型在参数中填 type = "money"--银两,"subMoney--绑银"}
	FinishLoopTask		= 46,		-- 完成循环任务，并且能够自动接任务
	AddFollowNpc		= 47,		-- 改变任务状态
	EnterBeastFight		= 48,		-- 
	EnterGoldHuntZone   = 49,		-- 进入猎金场
	GoldHuntFight		= 50,		-- 猎金场战斗
	GoldHuntCommit		= 51,		-- 猎金场提交分数

	GetTheActivity		= 52,		-- 领取活动
	GiveUpActivity		= 53,		--放弃门派闯关活动
	DekaronSchoolFight	= 54,		-- 挑战活动目标
	RecetiveTasks		= 55,		-- 同时接受多个任务

	ReceiveBabelTask	= 56,		-- 接受天道任务
	EnterBabel			= 57,		-- 进入通天塔
	EnterNextLayer		= 58,		-- 挑战下一层
	FlyUp				= 59,		-- 飞升
	ChangeRewardType	= 60,		-- 跟换奖励类型
	ChangeTarget		= 61,		-- 改变任务目标
	OpenItemRepairWin = 62,			--装备修理
}

--对话框图标类型
DialogIcon = {
	Talk            = 0x00, --气泡(气泡)
	Help            = 0x01, --帮助(灯泡)
	Trade           = 0x02, --交易(钱袋子)
	Box             = 0x03, --仓库(箱子)
	Function        = 0x04, --特殊NPC功能(齿轮)
	Task1           = 0x05, --(不可重复)可接任务(感叹号-绿色)
	Task2           = 0x06, --(可重复)可接任务(感叹号-蓝色)
	Task3           = 0x07, --正在进行(已接)任务(问号-灰色)
	Task4           = 0x08, --(已完成)可交任务(问号-绿色)
}
