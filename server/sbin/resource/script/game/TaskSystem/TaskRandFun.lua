--[[TaskRandFun.lua
描述：
	任务系统随机数据获取(任务系统)
--]]

--获取随机数据
function GetRandData(task, type)
	local taskID = task:getID()
	local gradeIdx = task:getGradeIdx()
	-- 根据等级段来返回index
	local ringIdx = task:getRingIdx()
	-- 获取当前等级NPC配置

	local curGradeNpcConfig = LoopTaskTargetAssistDB[taskID][gradeIdx][ringIdx]
	local taskNpcConfig = curGradeNpcConfig[task:getTargetType()][type]
	local index = math.random(1, #taskNpcConfig)
	return taskNpcConfig[index]
end

-- 随机坐标获取函数
function GetRandTitle(task)
	local taskMapConfig = RandTargetMapDB[task:getID()][task:getTargetType()]
	local index = math.random(1, #taskMapConfig)
	local mapID = taskMapConfig[index]
	local x,y = g_sceneMgr:getRandomPosition(mapID)
	return mapID, x, y
end

function GetRandEquipData(task, type)
	local taskID = task:getID()
	local gradeIdx = task:getGradeIdx()
	-- 根据等级段来返回index
	local ringIdx = task:getRingIdx()
	-- 获取当前等级NPC配置
	local curGradeNpcConfig = LoopTaskTargetAssistDB[taskID][gradeIdx][ringIdx]
	local taskNpcConfig = curGradeNpcConfig[task:getTargetType()][type]
	local index = math.random(1, #(taskNpcConfig.equipInfo))
	local equipIndex = math.random(1,#(taskNpcConfig.equipInfo[index]))
	local equipType = taskNpcConfig.equipInfo[index][equipIndex]
	local equipData = {}
	equipData.npcID = taskNpcConfig.npcInfo.npcID
	equipData.mapID = taskNpcConfig.npcInfo.mapID
	equipData.x = taskNpcConfig.npcInfo.x
	equipData.y = taskNpcConfig.npcInfo.y
	equipData.type = index							--区分是武器还是、防具
	equipData.index = equipType						--具体的装备类型
	return equipData
end