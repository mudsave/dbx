--[[TeamConstant.lua
描述：
	组队系统常量定义
]]


InvalidTeamID = -1 --无效队伍ID
MaxTeamMember = 4 --队伍最多成员数
MaxInvalidCount = 5 --玩家最多收到邀请信息条数

--队伍成员状态
MemberState = 
{
	Leader	= 0x01,--队长
	Follow	= 0x02,--跟随
	StepOut	= 0x04,--暂离
}

--队伍行动目标
TeamActionID =
{
	SMSW = 1,--师门守卫
	HJRQ = 2,--黄巾入侵
	WMCH = 3,--为民除害
	DSX	 = 4,--地煞星
	YWDG = 5,--野外打怪
	JYFB = 6,--经验副本
	QNFB = 7,--潜能副本
	YXT	 = 8,--英雄塔
	DQCJ = 9,--当前场景
}

--仙府争夺战地图
XFZDZMapID = {136,137,138,139,140,141,142,143,151,152,153,154,155,156,157,158}
