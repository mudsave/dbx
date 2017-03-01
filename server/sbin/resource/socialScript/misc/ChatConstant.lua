--[[ChatConstant .lua
描述：
	聊天常量
	
]]

--聊天频道类型
ChatChannelType = 
{
	Current = 1,--当前频道
	Team	= 2,--队伍频道
	System	= 3,--系统频道
	World	= 4,--世界频道
	Faction = 5,--帮会频道
	School	= 6,--门派频道
	Private	= 7,--私人频道
	Horn	= 8,--小喇叭
}

WorldChannelMinLevel = 20
WorldChannelCoolTime = 30 --s
ChatCoolTime = 2 --s
ChatMessageMaxLen = 254 * 2
ChatHornTextMaxLen = 25*2
ChatHornItemID = 1023001
WorldChannelVigorCost = 1