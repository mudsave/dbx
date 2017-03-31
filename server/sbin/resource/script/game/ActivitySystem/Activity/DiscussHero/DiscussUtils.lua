--[[DiscussUtils.lua
描述:煮酒论英雄的工具类
]]

DiscussUtils = {}

function DiscussUtils.addNpcInRandMap(scene,npc,curMapNpcList)
	print("curMapNpcList",toString(curMapNpcList))
	local reSetTime = 0
	local vect = nil
	local mapID = scene:getMapID()
	npc:setStatus(ePlayerNormal)
	repeat
		local peer = scene:getPeer()
		vect = peer:FindRandomTile(mapID)
		local isReset = true
		reSetTime = reSetTime + 1
		if reSetTime > 50 then
			print("循环50次")
			break
		end
		if curMapNpcList then
			for npcID,npc in pairs(curMapNpcList) do
				-- 其他的坐标
				print("npcID:",npcID)
				local pos = npc:getPos()
				if vect.x == pos[2] and  vect.y == pos[3] then
					isReset = false
				end
			end
		end
	until isReset
	if npc then
		print("vect.x,vect.y",vect.x,vect.y)
		scene:attachEntity(npc,vect.x, vect.y)
		return true
	else
		print("addNpcInRandMap no this npc")
	end
	return false
end

function DiscussUtils.randItem(itemConfig)
	-- 计算最大权重
	local maxWeight = 0
	print(toString(itemConfig))
	for _,item in pairs(itemConfig) do
		maxWeight =	maxWeight + item.weight
	end
	local eventWeight = math.random(maxWeight)
	-- 触发的事件选择  
	local weightCount = 0
	for _,item in pairs(itemConfig) do
		weightCount = weightCount +  item.weight
		if  eventWeight <= weightCount then
			return item.ID
		end
	end
end

function DiscussUtils.getRandMapPos(activityMapID)
	local scene = g_sceneMgr:getDiscussHeroScene(activityMapID)
	if not scene then
		print("这个活动场景")
		return
	end
	local mapID = scene:getMapID()
	local peer = scene:getPeer()
	local vect = peer:FindRandomTile(mapID)
	-- 返回一个x,y`
	if vect.x == 0 and vect.y == 0 then
		print("$$ error getRandomPosition()")
	end
	print("vect.x",vect.x, vect.y)
	return vect.x, vect.y
end