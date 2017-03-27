--[[TargetFactory.lua
描述：
	目标工厂(任务系统)
--]]

require "game.TaskSystem.TaskTarget.Tscript"
require "game.TaskSystem.TaskTarget.Tmine"
require "game.TaskSystem.TaskTarget.Tarea"
require "game.TaskSystem.TaskTarget.TlearnSkill"
require "game.TaskSystem.TaskTarget.TautoMeet"
require "game.TaskSystem.TaskTarget.TobtainPet"
require "game.TaskSystem.TaskTarget.TgetItem"
require "game.TaskSystem.TaskTarget.TocatchPet"
require "game.TaskSystem.TaskTarget.TcollectGuard"
require "game.TaskSystem.TaskTarget.TcontactSeal"
require "game.TaskSystem.TaskTarget.TcommitEquip"
require "game.TaskSystem.TaskTarget.TcommitItem"
require "game.TaskSystem.TaskTarget.TattainLevel"
require "game.TaskSystem.TaskTarget.TmysteryBus"
require "game.TaskSystem.TaskTarget.Tescort"
require "game.TaskSystem.TaskTarget.TwearEquip"
require "game.TaskSystem.TaskTarget.TcollectItem"
require "game.TaskSystem.TaskTarget.Tride"
require "game.TaskSystem.TaskTarget.TbabelScript"
require "game.TaskSystem.TaskTarget.TkillMonster"
require "game.TaskSystem.TaskTarget.TguideTask"
require "game.TaskSystem.TaskTarget.TjoinFaction"
require "game.TaskSystem.TaskTarget.TrandomFightScript"
require "game.TaskSystem.TaskTarget.TpaidPet"


local targetList =
{
	
	["Tscript"]				= Tscript,		-- 脚本战斗
	["Tmine"]				= Tmine,		-- 主线明雷
	["Tarea"]				= Tarea,		-- 到达特定区域
	["TlearnSkill"]			= TlearnSkill,	-- 学习技能
	["TautoMeet"]			= TautoMeet,	-- 到指定区域自动遇敌
	["TobtainPet"]			= TobtainPet,	-- 获得宠物任务目标
	["TgetItem"]			= TgetItem,		-- 购买物品
	["TocatchPet"]			= TocatchPet,	-- 循环任务当中捕捉宠物
	["TcollectGuard"]		= TcollectGuard,-- 添加采集护卫
	["TcontactSeal"]		= TcontactSeal,	-- 解除封印
	["TcommitEquip"]		= TcommitEquip,	-- 上交装备
	["TcommitItem"]			= TcommitItem,	-- 上缴物品
	["TattainLevel"]		= TattainLevel,	-- 达到等级
	["TmysteryBus"]			= TmysteryBus,	-- 神秘商人
	["Tescort"]				= Tescort,		-- 护送任务目标
	["TwearEquip"]			= TwearEquip,	-- 上装
	["TcollectItem"]		= TcollectItem,	-- 收集材料
	["Tride"]				= Tride,		-- 上坐骑
	["TbabelScript"]		= TbabelScript,
	["TkillMonster"]		= TkillMonster, -- 击杀怪物
	["TguideTask"]			= TguideTask,	-- 指引任务
	["TjoinFaction"]		= TjoinFaction,	-- 加入帮派
	["TrandomFightScript"]  = TrandomFightScript, --随机脚本战斗
	["TpaidPet"]			= TpaidPet,
}

-- 构造任务目标的函数
function createTarget(player, task, targetType, param, state)
	if targetList[targetType] then
		return targetList[targetType](player, task, param, state)
	end
	
end

-- 动态创建循环任务目标
function createDynamicTarget(player, task, targetType, param, state)
	if targetList[targetType] then
		return targetList[targetType](player, task, param, state)
	end
end
