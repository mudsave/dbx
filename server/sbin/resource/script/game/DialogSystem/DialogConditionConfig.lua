--[[DialogConditionConfig.lua
	对话条件配置(对话系统)
]]

--对话条件
DialogConditionDoer = 
{
	[DialogCondition.Level] = RoleVerify.checkLevel,
	[DialogCondition.HasTask] = RoleVerify.hasTask,
	[DialogCondition.HasTasks] = RoleVerify.hasTasks,
	[DialogCondition.School] = RoleVerify.checkSchool,
	[DialogCondition.Team] = RoleVerify.hasTeam,
	[DialogCondition.Currency] = RoleVerify.hasCurrency,
	[DialogCondition.Attr] = RoleVerify.hasAttr,
	[DialogCondition.Faction] = RoleVerify.checkFaction,
	[DialogCondition.CheckOwner] = NpcVerify.CheckOwner,
	-- 对话交谈NPC所需要的条件
	[DialogCondition.LoopTaskTalk] = RoleVerify.loopTaskTalk,
	[DialogCondition.HasFactionTask] = RoleVerify.hasFactionTask,
	[DialogCondition.NotHasFactionTask] = RoleVerify.notHasFactionTask,
	[DialogCondition.CheckTaskTeam] = RoleVerify.checkTaskTeam,
	[DialogCondition.CheckLoopTask] = RoleVerify.checkLoopTask,
	[DialogCondition.HasTask_1] = RoleVerify.hasTask_1,
	[DialogCondition.CheckLoopTasks] = RoleVerify.checkLoopTasks,
	[DialogCondition.CheckBeastBless] = RoleVerify.checkBeastBless,
	[DialogCondition.Time] = RoleVerify.checkTime,
	[DialogCondition.PlayerCountInGoldHuntMap] = SceneManager.checkPlayerCountInGoldHuntMap,
}

--对话条件对应的实例
DialogConditionInstance = 
{
	[DialogCondition.Level] = RoleVerify.getInstance(),
	[DialogCondition.HasTask] = RoleVerify.getInstance(),
	[DialogCondition.HasTasks] = RoleVerify.getInstance(),
	[DialogCondition.School] = RoleVerify.getInstance(),
	[DialogCondition.Team] = RoleVerify.getInstance(),
	[DialogCondition.Currency] = RoleVerify.getInstance(),
	[DialogCondition.Attr] = RoleVerify.getInstance(),
	[DialogCondition.Faction] = RoleVerify.getInstance(),
	[DialogCondition.CheckOwner] = NpcVerify.getInstance(),
	[DialogCondition.LoopTaskTalk] = RoleVerify.getInstance(),
	[DialogCondition.HasFactionTask] = RoleVerify.getInstance(),
	[DialogCondition.NotHasFactionTask] = RoleVerify.getInstance(),
	[DialogCondition.CheckTaskTeam] = RoleVerify.getInstance(),
	[DialogCondition.CheckBeastBless] = RoleVerify.getInstance(),
	[DialogCondition.CheckLoopTask] = RoleVerify.getInstance(),
	[DialogCondition.HasTask_1] = RoleVerify.getInstance(),
	[DialogCondition.CheckLoopTasks] = RoleVerify.getInstance(),
	[DialogCondition.Time] = RoleVerify.getInstance(),
	[DialogCondition.PlayerCountInGoldHuntMap] = SceneManager.getInstance(),
}