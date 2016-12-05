--[[ItemConstant.lua
描述：
	物品系统常量定义
]]

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
	-- 忠诚池
	reservePool = 18,
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

-- 武器子类门派
WeaponSubClassSchool = 
{
	[WeaponSubClass.Knife]		= "乾元岛",
	[WeaponSubClass.Spear]		= "金霞山",
	[WeaponSubClass.Crossbow]	= "紫阳门",
	[WeaponSubClass.Sword]		= "云霄宫",
	[WeaponSubClass.Fan]		= "桃源洞",
	[WeaponSubClass.Rod]		= "蓬莱阁",
}

-- 武器子类门派ID
WeaponSubClassSchoolID = 
{
	[WeaponSubClass.Knife]		= SchoolType.QYD,
	[WeaponSubClass.Spear]		= SchoolType.JXS,
	[WeaponSubClass.Crossbow]	= SchoolType.ZYM,
	[WeaponSubClass.Sword]		= SchoolType.YXG,
	[WeaponSubClass.Fan]		= SchoolType.TYD,
	[WeaponSubClass.Rod]		= SchoolType.PLG,
}

-- 防具子类
ArmorSubClass =
{
	-- 头盔
	Helmet   = 7,
	-- 衣甲
	Clothes  = 8,
	-- 鞋子
	Shoes    = 9,
	-- 裤子
	Trousers = 10,
	-- 护肩
	Shoulder = 11,
}

-- 饰品子类
AdornSubClass =
{
	-- 戒指
	Ring     = 12,
	-- 护符
	Amulet   = 13,
	-- 项链
	Necklace = 14,
}

-- 装备类型跟装备栏物品格索引对应表
EquipType_ItemGrid =
{
	[EquipmentClass.Adorn] =
	{
		[AdornSubClass.Necklace] = 1,
		[AdornSubClass.Amulet] = 2,
		[AdornSubClass.Ring] = {9,10},
	},
	[EquipmentClass.Armor] =
	{
		[ArmorSubClass.Shoulder] = 3,
		[ArmorSubClass.Helmet] = 4,
		[ArmorSubClass.Clothes] = 5,
		[ArmorSubClass.Trousers] = 6,
		[ArmorSubClass.Shoes] = 8,
	},
	[EquipmentClass.Weapon] =
	{
		[WeaponSubClass.Rod] = 7,
		[WeaponSubClass.Knife] = 7,
		[WeaponSubClass.Sword] = 7,
		[WeaponSubClass.Fan] = 7,
		[WeaponSubClass.Crossbow] = 7,
		[WeaponSubClass.Spear] = 7,
	},
}

-- 武器对应装备栏的格子索引
WeaponGridIndex = 7

-- 装备蓝色属性最大数目
EquipBlueAttrMaxNum = 3

-- 进行多少场战斗消耗一点耐久
ConsumeDurabilityNeedFightTimes = 50

-- 装备未鉴定的标志
EquipNotIdentityFlag = 10000

-- 仓库存钱的最大值
DepotSaveMoneyMax = 999999999

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

-- 包裹容器ID
PackContainerID =
{
	-- 背包栏
	Packet = 1,
	-- 仓库栏
	Depot  = 2,
	-- 装备栏
	Equip  = 3,
	-- 货架回购栏
	Shelf  = 4,
	--玩家交易
	Trade  = 5
}

-- 添加道具结果
AddItemsResult =
{
	-- 添加道具成功
	Succeed     = 1,
	-- 添加道具成功，但源道具需要销毁，不可用
	SucceedPile = 2,
	-- 道具无效
	SrcInvalid  = 3,
	-- 位置无效
	LocInvalid  = 4,
	-- 包裹已满
	Full        = 5,
	-- 失败
	Failed      = 6
}

-- 移除道具结果
RemoveItemsResult =
{
	-- 移除道具成功
	Succeed      = 1,
	-- 移除道具成功，但源道具需要销毁，不可用
	SucceedClean = 2,
	-- 数量非法
	NumInvalid   = 3,
	-- 物品无效
	SrcInvalid   = 4,
	-- 失败
	Failed       = 5
}

-- 背包的包裹索引
PacketPackIndex =
{
	-- 默认包裹
	Default      = 1,
	-- 等级包裹
	Level        = 2,
	-- VIP包裹，月卡用户专用包裹
	VIP          = 3,
	-- 坐骑包裹
	Horse        = 4,
	-- 任务包裹
	Task         = 5,
	-- 最大计数，方便以后扩展其他包裹
	MaxNum       = 6
}

-- 背包包裹默认容量
PacketPackDefaultCapacity = 24
-- 开启背包等级包裹需要的等级
PacketLevelPackNeedLevel = 40

-- 背包包裹类型，按物品存放类型来区分
PacketPackType =
{
	-- 非任务包裹
	Normal = 1,
	-- 任务包裹
	Task   = 2,
}

-- 仓库的包裹索引
DepotPackIndex =
{
	-- 第一个包裹
	First  = 1,
	-- 第二个包裹
	Second = 2,
	-- 最大计数，方便以后扩展其他包裹
	MaxNum = 3
}

--npc货架
ShelfPackIndex = 
{
	-- 默认包裹
	Default = 1,
}
-- 仓库最大容量
DepotMaxCapacity = 84
-- 仓库默认容量
DepotDefaultCapacity = 24
-- 仓库包裹容量，方便计算仓库扩充
DepotPackCapacity = 42

--货架的最大容量
ShelfMaxCapacity = 12

--p2p交易货架
TradePackIndex = 
{
	--默认包裹
	Default =1,
}
-- p2p交易的默认容量
TradeDefaultCapacity = 12

-- 仓库扩充道具ID
DepotExtendItemID = 1026004

-- 装备栏默认容量
EquipDefaultCapacity = 10

-- 装备栏的包裹索引
EquipPackIndex =
{
	-- 默认包裹
	Default = 1,
}

Bind = 1
UnBind = 0

