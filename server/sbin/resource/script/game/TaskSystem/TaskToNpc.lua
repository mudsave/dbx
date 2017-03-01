--[[TaskProvider.lua
	任务发放者(任务系统)
]]

g_taskProvideNpcs = {}
g_taskRecetiveNpcs = {}

function createTaskProvider()
	for taskID, taskData in pairs(NormalTaskDB) do
		if taskData.startNpcID then
			if	not g_taskProvideNpcs[taskData.startNpcID] then
				g_taskProvideNpcs[taskData.startNpcID] = {}
			end
			table.insert(g_taskProvideNpcs[taskData.startNpcID], taskID)
		end
	end

	for taskID, taskData in pairs(NormalTaskDB) do
		if taskData.endNpcID then
			if not g_taskRecetiveNpcs[taskData.endNpcID] then
				g_taskRecetiveNpcs[taskData.endNpcID] = {}
			end
			table.insert(g_taskRecetiveNpcs[taskData.endNpcID], taskID)
		end
	end

	for taskID,taskData in pairs(DailyTaskDB) do
		if taskData.startNpcID then
			if	not g_taskProvideNpcs[taskData.startNpcID] then
				g_taskProvideNpcs[taskData.startNpcID] = {}
			end
			table.insert(g_taskProvideNpcs[taskData.startNpcID], taskID)
		end
	end

	for taskID,taskData in pairs(DailyTaskDB) do
		if taskData.endNpcID then
			if not g_taskRecetiveNpcs[taskData.endNpcID] then
				g_taskRecetiveNpcs[taskData.endNpcID] = {}
			end
			table.insert(g_taskRecetiveNpcs[taskData.endNpcID], taskID)
		end
	end

	-- 循环任务NPC放在一张表当中
	for taskID, taskData in pairs(LoopTaskDB) do
		if taskData.startNpcID then
			if not g_taskProvideNpcs[taskData.startNpcID] then
				g_taskProvideNpcs[taskData.startNpcID]= {}
			end
			table.insert(g_taskProvideNpcs[taskData.startNpcID], taskID)
		end
	end



end