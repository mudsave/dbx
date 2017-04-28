--[[OldTowerUtils.lua
	天降宝盒相关设定
--]]

--地图配置
oldTowerMapID = 800

--任务时间
oldTowerTaskTime = 300

oldTowerMaxClear = 20

-- 三种Npc出现的权重
oldTowerNpcClass = {
	{ID = 1, Name = 'NpcA', npcID = 27153, weight = 30},
	{ID = 2, Name = 'NpcB', npcID = 27154, weight = 30},
	{ID = 3, Name = 'NpcC', npcID = 27155, weight = 30},
}

ranksTable = {
	[1] = {1,2,3},
	[2] = {4,5,6},
	[3] = {7,8,9},
	[4] = {1,4,7},
	[5] = {2,5,8},
	[6] = {3,6,9},
}

OldTowerUtils={}

--根据权重随机出Npc类型
local function getRandNpc(config)
	local getLastData = {}
	for k,v in pairs(config) do
		getLastData = v
	end

	local maxWeight = 0
	-- 计算总权重
	for _, datas in pairs(config) do
		maxWeight = maxWeight + datas.weight
	end
	-- 得到随机物
	local rand = math.random(maxWeight)
	local curWeight  = 0
	for _,datas in pairs(config) do
		if rand >= curWeight and rand < curWeight +  datas.weight then
			return datas
		elseif rand == maxWeight then
			return getLastData
		end
		curWeight = curWeight +  datas.weight
	end	
end

--随机跟指定npcID不同的NPC类型
local function getRandDifferenceNpc(aID,bID)
	local newTable = {}
	table.deepCopy(oldTowerNpcClass,newTable)	--配置复制

	local getLen = #newTable
	while getLen >0 do
		if newTable[getLen].npcID == aID or newTable[getLen].npcID == bID then
			table.remove(newTable,getLen)
		end
		getLen = getLen -1
	end

	local npcData = getRandNpc(newTable)
	return npcData
end

function OldTowerUtils.dogetRandNpc()
	return getRandNpc(oldTowerNpcClass)

end

function OldTowerUtils.dogetRandDifferenceNpc(aID,bID)
	return getRandDifferenceNpc(aID,bID)
end