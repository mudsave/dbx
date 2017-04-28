
-- 定义运维工具使用的Event ID
	-- 世界服(AW)
	AdminEvents_AW_Base = 0 
	AdminEvents_AW_Test						= AdminEvents_AW_Base + 1
	AdminEvents_WA_Test						= AdminEvents_AW_Base + 2
	AdminEvents_AW_GetRoleInfo				= AdminEvents_AW_Base + 3
	AdminEvents_WA_GetRoleInfo				= AdminEvents_AW_Base + 4
	AdminEvents_AW_KickPlayer				= AdminEvents_AW_Base + 5
	AdminEvents_WA_KickPlayer				= AdminEvents_AW_Base + 6
	AdminEvents_AW_Base = AdminEvents_AW_Base + 6
	-- 玩家处理
	AdminEvents_AW_GetOnLineInfo			= AdminEvents_AW_Base + 1
	AdminEvents_WA_GetOnLineInfo			= AdminEvents_AW_Base + 2
	AdminEvents_AW_ExitGame					= AdminEvents_AW_Base + 3
	AdminEvents_WA_ExitGame					= AdminEvents_AW_Base + 4
	AdminEvents_AW_Base = AdminEvents_AW_Base + 4
	-- 定义活动处理消息 
	AdminEvents_AW_GetActivityInfo			= AdminEvents_AW_Base + 1
	AdminEvents_WA_GetActivityInfo			= AdminEvents_AW_Base + 2
	AdminEvents_AW_OpenActivity				= AdminEvents_AW_Base + 3
	AdminEvents_AW_CloseActivity			= AdminEvents_AW_Base + 4
	AdminEvents_AW_ChangeActivity			= AdminEvents_AW_Base + 5
	AdminEvents_AW_Base = AdminEvents_AW_Base + 5
	-- 公告处理
	AdminEvents_AW_Broadcast				= AdminEvents_AW_Base + 1
	AdminEvents_WA_Broadcast				= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 查封账号处理
	AdminEvents_AW_CloseAccount				= AdminEvents_AW_Base + 1
	AdminEvents_WA_CloseAccount				= AdminEvents_AW_Base + 2
	AdminEvents_AW_OPenAccount				= AdminEvents_AW_Base + 3
	AdminEvents_WA_OPenAccount				= AdminEvents_AW_Base + 4
	AdminEvents_AW_Base = AdminEvents_AW_Base + 4
	-- 发送邮件
	AdminEvents_AW_SendMail					= AdminEvents_AW_Base + 1
	AdminEvents_WA_SendMail					= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 禁言操作
	AdminEvents_AW_Gag						= AdminEvents_AW_Base + 1
	AdminEvents_WA_Gag						= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 复位角色坐标
	AdminEvents_AW_GetOnlinePlayerByName	= AdminEvents_AW_Base + 1
	AdminEvents_AW_GetOnlinePlayerByDBID	= AdminEvents_AW_Base + 2
	AdminEvents_AW_ResetPos					= AdminEvents_AW_Base + 3				
	AdminEvents_AW_CheckPosOrGoTo			= AdminEvents_AW_Base + 4
	AdminEvents_WA_GetOnlinePlayerInfo		= AdminEvents_AW_Base + 5
	AdminEvents_AW_Base = AdminEvents_AW_Base + 5
	
	-- 战斗服(AF)
	AdminEvents_AF_Base = 1000 
	-- 社会服(AS)
	AdminEvents_AS_Base = 2000 
