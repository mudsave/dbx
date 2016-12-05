--[[RideConstant .lua
描述：
	坐骑常量
	--misc.RideConstant 
]]



-- 坐骑栏默认容量
RideDefaultCapacity = 6
RideMaxCapacity = 24

--扩充坐骑栏物品驭兽铃,一次扩充的个数
ExpandRideBarItem = 1027001
ExpandRideBarCount = 2

--坐骑回笼需要的物品兽笼
RideToItem = 1027005

--坐骑进阶需要的物品坐骑进阶丹
RideGrowUpItem = 1027004

--10分钟消耗1点体力值
RidingTimeCostVigor = 10

--坐骑最大阶级
RideMaxLevel = 9

RideMessageID = {
	RideBarDeficiency = 1,
	RideToItemFailure = 2,
	VigorDeficiency = 3,
}

RideState = 
{
	Ride_State_Fly = 1,
	Ride_State_Ride = 2,
	Ride_State_None = 3,
}

--坐骑类型
RideType = 
{
	Apis			= 1,--神牛
	Fox				= 2,--狐狸
	Lion			= 3,--狮子
	Bear			= 4,--熊
	Hippo			= 5,--河马
	Kylin			= 6,--麒麟
	Crane			= 7,--羽鹤
	Leopard			= 8,--豹
	Calabash		= 9,--葫芦
	Scorpion		= 10,--魔蝎
	Spider			= 11--蜘蛛
}

--每阶进阶对应坐骑进阶丹数量为：-
RideGrowToItemCount = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5,
	[6] = 6,
	[7] = 7,
	[8] = 8,
}

--每阶理论最大进阶成功率为
RideGrowToSuccess = {
	[1] = 1,
	[2] = 0.8,
	[3] = 0.65,
	[4] = 0.5,
	[5] = 0.4,
	[6] = 0.3,
	[7] = 0.2,
	[8] = 0.1,
}