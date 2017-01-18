-- common.constant.ItemConstant.lua

EquipRefiningphase =
{
	win_phase = 1,
	thu_phase = 2,
	ice_phase = 3,
	soi_phase = 4,
	fir_phase = 5,
	poi_phase = 6,
}

--套装件数
Suit = {
	twoPieceSuit	= 2,
	fourPieceSuit	= 4,
	sixPieceSuit	= 6,
}

--装备属性颜色
EquipAttrColor = {
	-- 蓝
	Blue   = 1,
	-- 粉
	Pink = 2,
	-- 金
	Gold   = 3,
	-- 绿
	Green  = 4,
}

--装备改造与回退
EquipRemouldType =
{
	remould = 1,
	rollBack = 2,
}

-- 道具分类
ItemClass =
{
	-- 装备
	Equipment  = 1,
	-- 药品，除了装备，游戏里所有能右键使用的道具都属于药品
	Medicament = 2,
	-- 凭证，除了装备，游戏里所有不能右键使用的道具都属于凭证
	Warrant    = 3,
}

-- 装备分类
EquipmentClass =
{
	-- 武器
	Weapon   = 1,
	-- 防具
	Armor    = 2,
	-- 饰品
	Adorn    = 3,
	-- 法宝
	Talisman = 4,
}

-- 武器子类
WeaponSubClass =
{
	-- 杖
	Rod      = 1,
	-- 刀
	Knife    = 2,
	-- 剑
	Sword    = 3,
	-- 扇
	Fan      = 4,
	-- 弩
	Crossbow = 5,
	-- 枪
	Spear    = 6,
}

-- 道具品质
ItemQuality =
{
	-- 未鉴定
	NoIdentify = 0,
	-- 白
	White  = 1,
	-- 蓝
	Blue   = 2,
	-- 粉
	Pink = 3,
	-- 金
	Gold   = 4,
	-- 绿
	Green  = 5,
}

-- 道具价格类型
ItemPriceType =
{
	-- 银两
	Money		= 1,
	-- 绑银
	BindMoney	= 2,
	--帮贡
	FacContrib	= 3,
}

--装备改造属性颜色
EquipRemouldColour =
{
	null = 0,
	White = 1,
	Blue = 2,
	Pink = 3,
	Gold = 4,
	Green = 5,
}

-- 装备玩法类型
EquipPlaying =
{
	-- 装备制作
	EquipMake      = 1,
	-- 装备拆解
	EquipAnalyse   = 2,
	-- 装备改造
	EquipRemould   = 3,
	-- 装备属性重置
	AttrReset      = 4,
	-- 装备属性强化
	AttrImprove    = 5,
	-- 装备炼化
	EquipRefining  = 6,
	-- 饰品制作
	AdornMake      = 7,
	-- 饰品合成
	AdornSynthetic = 8,
}

-- 道具子类，服务器用来区分是否是任务道具，以便放入任务背包，客户端用来在Tips上显示标志用
ItemSubClass =
{
	-- 材料
	Material   = 1,
	-- 药品
	Medicament = 2,
	-- 功能道具
	Function   = 3,
	-- 任务道具
	Task       = 4,
	-- 战利品
	Trophy     = 5,
	-- 变身卡
	ChangeCard = 6,
	-- 技能书
	SkillBook  = 7,
	-- 包裹
	Pack       = 8,
	-- 兑换品
	Exchange   = 9,
	-- 食品
	Food       = 10,
	-- 珍稀品
	Treasure   = 11,
	--图纸
	Drawing    = 12,
	--符石
	Runes	   = 13,
	--灵石
	LingShi	   = 14,
	--飞行旗
	FlyingFlag = 15,
	--兽文
	Beast      = 16,
	-- 玲珑丹
	LinglongPill= 17,
	-- 储备池
	reservePool = 18,
	-- 装备制作的材料
	manufacMat = 19,
}


-- 药品使用状态
MedicamentUseState =
{
	-- 不可用
	NonUse  = 1,
	-- 普通状态用
	General = 2,
	-- 战斗中用
	Fight   = 3,
	-- 都可用
	All     = 4,
}

-- 药品作用类型
MedicamentReactType =
{
	-- 增加Buff
	AddBuff            = 1,
	-- 执行Lua函数
	ExeLuaFun          = 2,
	-- 改变生命
	ChangeHp           = 3,
	-- 改变法力
	ChangeMp           = 4,
	-- 改变生命和法力
	ChangeHpMp         = 5,
	-- 改变怒气
	ChangeAnger        = 6,
	-- 改变PK值
	ChangePk           = 7,
	-- 改变绑银
	ChangeBindMoney    = 8,
	-- 改变银两
	ChangeMoney        = 9,
	-- 改变经验
	ChangeExp          = 10,
	-- 改变礼金
	ChangeCashMoney    = 11,
	-- 改变元宝
	ChangeGoldCoin     = 12,
	-- 改变道行
	ChangeTao          = 13,
	-- 改变潜能
	ChangePotential    = 14,
	-- 改变历练
	ChangeExpoint      = 15,
	-- 改变战绩
	ChangeCombatNum    = 16,
	-- 改变帮贡
	ChangeContribution = 17,
	-- 改变体力
	ChangeVigor        = 18,
	-- 改变宠物忠诚
	ChangePetLoyalty   = 19,
	-- 改变宠物寿命
	ChangePetLife      = 20,
	-- 使用生命池
	UseHpPool          = 21,
	-- 使用法力池
	UseMpPool          = 22,
	-- 打开客户端UI
	OpenClientUI       = 23,
	-- 取消buff
	CancelBuff         = 24,
	-- 添加宠物
	AddPet             = 25,
	-- 添加坐骑
	AddRide            = 26,
	-- 所有属性点
	ChangeAllAttr      = 27,
	-- 所有相性洗点
	ChangeAllPhase     = 28,
	-- 改变坐骑体力值
	ChangeRideVigor    = 29,
	-- 完成任务,再接一种指定类型任务
	FinishTask         = 30,
	-- 打开藏宝图
	OpenTreasure	   = 31,
	-- 添加宠物技能
	AddPetSkill		   = 32,
	-- 添加一个任务
	AddTask			   = 33,
	-- 完成一个任务
	CompleteTask	   = 34,
	--改变宠物忠诚度并添加buff
	ChangeLoyaltyAndAddBuff   = 35,
	--改变生命并添加buff
	ChangeHpAndAddBuff   = 36,
	--改变法力并添加buff
	ChangeMpAndAddBuff   = 37,
}

-- 药品作用对象类型
MedicamentReactTarget =
{
	-- 自己
	Self   = 1,
	-- 宠物
	Pet    = 2,
	-- 友方单位
	Friend = 3,
	-- 敌方单位
	Enemy  = 4,
	--坐骑
	Ride   = 5,
	--宠物和玩家
	SelfAndPet = 6,
}
