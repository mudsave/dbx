--[[EctypeManager.lua
描述:
	副本管理类
]]

EctypeManager = class(nil, Singleton)

function EctypeManager:__init()
	-- 副本ID
	self.curEctypeMapID = EctypeMap_StartID
	-- 所有副本
	self.allEctypes = {}
	-- 玩家ID-副本ID
	--[[
	self.actorEctypeMapID = {}
	-- 副本ID-玩家ID
	self.ectypeMapIDActor = {}
	-- 队伍ID-副本ID，这里会记录进入的队员玩家ID，以便再次进入判断
	self.teamEctypeMapID = {}
	-- 副本ID-队伍ID
	self.ectypeMapIDTeam = {}
	--]]
end

function EctypeManager:__release()
end

-- 设置玩家副本数据
function EctypeManager:setEctypeData(player, ectypeRecord, ringEctypeRecord)
	--print("ectypeRecord", toString(ectypeRecord))
	--print("ringEctypeRecord", toString(ringEctypeRecord))
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	-- 读取普通副本数据
	ectypeHandler:setEctypeInfo(ectypeRecord)
	-- 读取连环副本数据
	ectypeHandler:setRingEctypeInfo(ringEctypeRecord)
end

-- 玩家下线保存副本数据
function EctypeManager:saveEctypeData(player)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	if ectypeMapID >= EctypeMap_StartID then
		-- 处理副本中下线
		local ectype = self:getEctype(ectypeMapID)
		if ectype then
			ectype:onPlayerCheckOut(player)
		end
	end
	-- 保存普通副本数据
	ectypeHandler:saveEctypeData()
	-- 保存连环副本数据
	ectypeHandler:saveRingEctypeData()
end

-- 生成新的副本ID
function EctypeManager:generateEctypeMapID()
	self.curEctypeMapID = self.curEctypeMapID + 1
	return self.curEctypeMapID
end

-- 获得指定副本
function EctypeManager:getEctype(ectypeMapID)
	return self.allEctypes[ectypeMapID]
end

-- 判断进入副本条件是否满足
function EctypeManager:canEnterEctype(player, ectypeConfig)
	if ectypeConfig.EctypeType == EctypeType.Ring then
		-- 这里不用考虑连环子副本
		return true
	end
	-- 判断进入等级
	local enterNeedLevel = ectypeConfig.EnterNeedLevel
	if enterNeedLevel then
		local level = player:getLevel()
		if level < enterNeedLevel.minLevel or level > enterNeedLevel.maxLevel then
			-- 等级不满足要求
			self:sendEctypeMessageTip(player, 7)
			return false
		end
	end

	-- 判断可完成次数
	if ectypeConfig.EctypeCDFinishTimes > 0 then
		local ectypeHandler = player:getHandler(HandlerDef_Ectype)
		local finishTimes = ectypeHandler:getEctypeFinishTimes(ectypeConfig.EctypeID)
		if finishTimes >= ectypeConfig.EctypeCDFinishTimes then
			-- 次数已用完
			local itemID = ectypeConfig.EnterNeedItems.itemID
			if itemID and itemID > 0 then
				local itemNum = ectypeConfig.EnterNeedItems.itemNum
				local packetHandler = player:getHandler(HandlerDef_Packet)
				-- 判断是否有额外进入的道具
				if packetHandler:getNumByItemID(itemID) < itemNum then
					print("完成次数已经用完，有玩家没有道具不能进入")
					self:sendEctypeMessageTip(player, 8)
					return false
				end
			else
				-- 不能再进入了
				local teamHandler = player:getHandler(HandlerDef_Team)
				-- 如果是队伍副本，队长次数用完就无法进入，队员可以继续作为打手进入
				local teamID = teamHandler:getTeamID()
				if teamID > 0 then
					local team = g_teamMgr:getTeam(teamID)
					if team:getLeaderID() == player:getID() then
						print("队长的次数已经用完")
						self:sendEctypeMessageTip(player, 8)
						return false
					end
				else
					print("完成次数已经用完>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
					self:sendEctypeMessageTip(player, 8)
					return false
				end
			end
		end
	else
		-- 可以无限次的进入
	end
	return true
end

-- 执行进入副本需要的扣除条件，目前只有道具
function EctypeManager:exeEnterEctypeDeductCondition(player, ectypeConfig)
	if ectypeConfig.EctypeType == EctypeType.Ring then
		-- 这里不用考虑连环子副本
		return
	end
	-- 扣除进入副本需要的额外道具
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local finishTimes = ectypeHandler:getEctypeFinishTimes(ectypeConfig.EctypeID)
	if finishTimes >= ectypeConfig.EctypeCDFinishTimes then
		-- 完成次数已用完，需要额外道具
		local itemID = ectypeConfig.EnterNeedItems.itemID
		if itemID and itemID > 0 then
			local itemNum = ectypeConfig.EnterNeedItems.itemNum
			local packetHandler = player:getHandler(HandlerDef_Packet)
			packetHandler:removeByItemId(itemID, itemNum)
			-- 扣除道具之后，把副本完成次数减1，要不领不到奖励。。
			ectypeHandler:setEctypeFinishTimes(ectypeConfig.EctypeID, finishTimes-1)
		end
	end
end

-- 进入副本
function EctypeManager:enterEctype(player, ectypeID)
	-- 找到副本配置
	local ectypeConfig = tEctypeDB[ectypeID]
	if not ectypeConfig then
		print("不存在副本配置，ectypeID = ", ectypeID)
		return
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local playerDBID = player:getDBID()
	-- 如果是暂离的队员提示不能进入副本
	if teamID > 0  then
		if teamHandler:isStepOutState() then
			self:sendEctypeMessageTip(player, 12)
			return
		end
	end

	if ectypeConfig.EctypeEnterType == EctypeEnterType.Single then
		if teamID > 0 then
			-- 组队状态不能进单人副本
			self:sendEctypeMessageTip(player, 6)
			return
		end
		-- 判断进入条件
		if not self:canEnterEctype(player, ectypeConfig) then
			return
		end
		-- 执行进入副本需要的扣除条件
		self:exeEnterEctypeDeductCondition(player, ectypeConfig)
		-- 创建副本
		local ectype = Ectype()
		if ectype:create(ectypeID) then
			local ectypeMapID = ectype:getEctypeMapID()
			-- 记录新副本
			self.allEctypes[ectypeMapID] = ectype
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			-- 设置副本进度
			if ectypeConfig.EctypeType == EctypeType.Common then
				-- 普通副本每次进入都是从头开始
				ectype:setEctypeProcess(1)
				ectype:setEctypeAttackTime(0)
			else
				local ectypeProcess = ectypeHandler:getEctypeProcess(ectypeID)
				ectypeProcess = ectypeProcess + 1
				ectype:setEctypeProcess(ectypeProcess)
			end
			-- 设置副本时间
			local leftMin = ectypeHandler:getEctypeLeftMin(ectypeID)
			ectype:setEctypeLeftMin(leftMin)
			-- 如果有两张地图
			ectype:createEctypeOhterScene()
			-- 进入新副本
			ectype:enterEctypeScene(player)
			-- 驱动副本进度
			ectype:driveEctypeProcess()
		else
			-- 创建副本失败
			print("EctypeManager:enterEctype 创建失败 1，ectypeID = ", ectypeID)
			release(ectype)
		end
	elseif ectypeConfig.EctypeEnterType == EctypeEnterType.Team then
		-- 组队副本
		if teamID <= 0 then
			-- 没有组队，无法进入
			self:sendEctypeMessageTip(player, 1)
			return
		end
		local team = g_teamMgr:getTeam(teamID)
		if not team then
			-- 找不到队伍
			self:sendEctypeMessageTip(player, 1)
			return
		end
		if team:getLeaderID() ~= player:getID() then
			-- 不是队长
			return
		end
		-- 判断进入副本最少人数
		if team:getMemberCount() < ectypeConfig.EnterNeedPlayerNum then
			self:sendEctypeMessageTip(player, 5)
			return
		end
		-- 获得队员玩家列表
		local teamMemberList = team:getMemberList()
		local teamMemberPlayer = {}
		for i = 1, table.getn(teamMemberList) do
			-- 暂离的队员排除掉
			if teamMemberList[i].memberState ~= MemberState.StepOut then
				local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
				if teamMember then
					table.insert(teamMemberPlayer, teamMember)
				end
			end
		end
		-- 判断进入条件
		for i = 1, table.getn(teamMemberPlayer) do
			if not self:canEnterEctype(teamMemberPlayer[i], ectypeConfig) then
				-- 提示不能进入的原因
				return
			end
		end
		-- 执行进入副本需要的扣除条件
		for i = 1, table.getn(teamMemberPlayer) do
			self:exeEnterEctypeDeductCondition(teamMemberPlayer[i], ectypeConfig)
		end
		-- 创建副本
		local ectype = Ectype()
		if ectype:create(ectypeID) then
			local ectypeMapID = ectype:getEctypeMapID()
			-- 记录新副本
			self.allEctypes[ectypeMapID] = ectype
			-- 设置副本进度
			local ectypeProcess = 0
			local ectypeLeftMin = 0
			if ectypeConfig.EctypeType ~= EctypeType.Ring then
				if ectypeConfig.EctypeType == EctypeType.Common then
					-- 普通副本每次进入都是从头开始
					ectypeProcess = 0
					ectypeLeftMin = 0
					ectype:setEctypeAttackTime(0)
				else
					-- 日常、周常等类型的组队副本
					for i = 1, table.getn(teamMemberPlayer) do
						local ectypeHandler = teamMemberPlayer[i]:getHandler(HandlerDef_Ectype)
						local curEctypeProcess = ectypeHandler:getEctypeProcess(ectypeID)
						-- 取队伍成员最高进度
						if curEctypeProcess > ectypeProcess then
							ectypeProcess = curEctypeProcess
							ectypeLeftMin = ectypeHandler:getEctypeLeftMin(ectypeID)
						end
					end
				end
			else
				-- 连环副本
				local teamMember = g_entityMgr:getPlayerByID(team[ectypeConfig.ringEctypeID])
				local ectypeHandler = teamMember:getHandler(HandlerDef_Ectype)
				ectypeProcess = ectypeHandler:getRingEctypeProcess(ectypeConfig.ringEctypeID)
				ectypeLeftMin = ectypeHandler:getRingEctypeLeftMin(ectypeConfig.ringEctypeID)
			end
			ectypeProcess = ectypeProcess + 1
			ectype:setEctypeProcess(ectypeProcess)
			-- 设置副本时间
			ectype:setEctypeLeftMin(ectypeLeftMin)
			-- 是否创建第二张地图
			ectype:createEctypeOhterScene()
			for i = 1, table.getn(teamMemberPlayer) do
				-- 进入新副本
				ectype:enterEctypeScene(teamMemberPlayer[i])
			end
			-- 驱动副本进度
			ectype:driveEctypeProcess()
		else
			-- 创建副本失败
			print("EctypeManager:enterEctype 创建失败 2，ectypeID = ", ectypeID)
			release(ectype)
		end
	end
end

-- 退出副本
function EctypeManager:exitEctype(player)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = self.allEctypes[ectypeMapID]
	if not ectype then
		return
	end
	local ectypePlayers = ectype:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do 
		local curPlayer = g_entityMgr:getPlayerByID(playerID) 
		if curPlayer then
			ectype:returnPublicScene(player)
		end
	end
end

-- 计算队伍指定连环副本的进入信息
function EctypeManager:calcTeamRingEctypeEnterInfo(team, ringEctypeID)
	-- 队伍当前最大环数
	local teamCurMaxRing = 0
	-- 队伍当前最大进度
	local teamCurMaxProcess = 0
	-- 队伍当前使用的副本进入信息的玩家ID，默认用队长的
	local teamEnterInfoPlayerID = team:getLeaderID()

	local teamMemberList = team:getMemberList()
	for i = 1, table.getn(teamMemberList) do
		local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
		if teamMember then
			local ectypeHandler = teamMember:getHandler(HandlerDef_Ectype)
			local finishFlag = ectypeHandler:getRingEctypeFinishFlag(ringEctypeID)
			-- 未完成今日连环副本的才参与
			if finishFlag == 0 then
				local curRing = ectypeHandler:getRingEctypeCurRing(ringEctypeID)
				local curProcess = ectypeHandler:getRingEctypeProcess(ringEctypeID)
				if curRing > teamCurMaxRing then
					-- 环数最大的话，就按照当前玩家的环数和进度来进入副本
					teamEnterInfoPlayerID = teamMember:getID()
					teamCurMaxRing = curRing
					teamCurMaxProcess = curProcess
				elseif curRing == teamCurMaxRing then
					-- 环数一致的话，就再比较进度
					if curProcess > teamCurMaxProcess then
						teamEnterInfoPlayerID = teamMember:getID()
						teamCurMaxRing = curRing
						teamCurMaxProcess = curProcess
					end
				end
			end
		end
	end

	-- 暂时记录到队伍数据里，随着队伍销毁而销毁
	team[ringEctypeID] = teamEnterInfoPlayerID
end

-- 根据等级获得所在连环副本的等级区间
function EctypeManager:getRingEctypeLevelSection(level, ringEctypeID)
	local lvlSection = 0
	for i = 1, table.getn(tRingEctypeDB[ringEctypeID]) do
		if level >= tRingEctypeDB[ringEctypeID][i].OpenLevel then
			lvlSection = i
		end
	end
	return lvlSection
end

-- 随机出当前连环副本下一子副本ID
function EctypeManager:randomRingEctypeChildEctypeID(ectypeHandler, ringEctypeID)
	local tAllEctypes = tRingEctypeDB[ringEctypeID].tAllEctypes
	if not tAllEctypes then
		return
	end
	-- 随机出子副本
	local childEctypeIndexs = {}
	local childEctypeInfo = ectypeHandler:getRingEctypeChildEctypeInfo(ringEctypeID)
	for i = 1, table.getn(childEctypeInfo) do
		if childEctypeInfo[i] == 0 then
			table.insert(childEctypeIndexs, i)
		end
	end
	local childEctypeIndexNum = table.getn(childEctypeIndexs)
	if childEctypeIndexNum <= 0 then
		return
	end
	local childEctypeIndex = childEctypeIndexs[math.random(1, childEctypeIndexNum)]
	return tAllEctypes[childEctypeIndex].EctypeID
end

-- 进入连环副本ringEctypeID 指的是那个副本群,对话进入连环副本的接口
function EctypeManager:enterRingEctype(player, ringEctypeID)
	if not tRingEctypeDB[ringEctypeID] then
		return
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if not team then
		self:sendEctypeMessageTip(player, 1)
		return -1
	end
	if team:getLeaderID() ~= player:getID() then
		-- 不是队长
		return -1
	end
	-- 等级区间判断
	local enterNeedLevel = tRingEctypeDB[ringEctypeID].EnterNeedLevel
	local teamMemberList = team:getMemberList()
	for i = 1, table.getn(teamMemberList) do
		local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
		if teamMember then
			local teamMemberLvl = teamMember:getLevel()
			if teamMemberLvl < enterNeedLevel.minLevel or teamMemberLvl > enterNeedLevel.maxLevel then
				-- 提示队伍成员不符合进入副本等级区间
				self:sendEctypeMessageTip(player, 2)
				return -1
			end
		end
	end
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local finishFlag = ectypeHandler:getRingEctypeFinishFlag(ringEctypeID)
	if finishFlag == 1 then
		-- 队长已经完成的话，就不让进了
		self:sendEctypeMessageTip(player, 4)
		return -1
	end

	-- 计算当前队伍连环副本的进入信息
	self:calcTeamRingEctypeEnterInfo(team, ringEctypeID)
	local teamMember = g_entityMgr:getPlayerByID(team[ringEctypeID])
	if teamMember then
		local ectypeHandler = teamMember:getHandler(HandlerDef_Ectype)
		local childEctypeID = ectypeHandler:getCurChildEctypeID(ringEctypeID)
		if childEctypeID <= 0 then
			childEctypeID = self:randomRingEctypeChildEctypeID(ectypeHandler, ringEctypeID)
			-- 随机出子副本后，就同步队员的当前子副本
			local teamMemberList = team:getMemberList()
			for i = 1, table.getn(teamMemberList) do
				local teamMember = g_entityMgr:getPlayerByID(teamMemberList[i].memberID)
				if teamMember then
					local memberEctypeHandler = teamMember:getHandler(HandlerDef_Ectype)
					memberEctypeHandler:setCurChildEctypeID(ringEctypeID, childEctypeID)
				end
			end
			print("1 随机出子副本ID = ", childEctypeID)
		end
		-- 进入子副本
		self:enterEctype(player, childEctypeID)
	end
end

-- 暂离玩家归队进入副本场景
function EctypeManager:enterEctypeScene(ectypeMapID, roleInfo)
	local ectype = self:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	local role = roleInfo[1]
	local x, y = roleInfo[2], roleInfo[3]

	if role and x and y then
		ectype:enterEctypeSceneEx(role, x, y)
	end
end

-- 销毁副本回调
function EctypeManager:onReleaseEctype(ectypeID, ectypeMapID)
	-- 删除副本记录
	local ectype = self.allEctypes[ectypeMapID]
	release(ectype)
	self.allEctypes[ectypeMapID] = nil
	-- 删除副本场景
	g_sceneMgr:releaseEctypeScene(ectypeMapID)
	print("副本场景销毁掉呢》》》》》》》》》》》》》》》》》》》》。")
end

-- 
function EctypeManager:onPlayerPreRelogin(player, status)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if not ectype then
		return
	end
	-- 副本存在
	local ectypeID = ectype:getEctypeID()
	if status == ePlayerFight then
		-- 不需要再次进入，只需要通知当前离线玩家，有机关开启机关。冲洗发消息个当前离线玩家，创建Npc，热区等等
		-- 当前进度要向前-1 重新出执行
		ectype:onPlayerPreRelogin(player)
	else
		-- 发送当前玩家到公共场景，不在战斗当中
		ectype:returnPublicScene(player)
	end
end

-- 发送副本消息提示
function EctypeManager:sendEctypeMessageTip(player, msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, 2, msgID)
	g_eventMgr:fireRemoteEvent(event, player)
end


------------------------------------------------------------------------帮会副本入口-------------------------------------------------------------------------------
function EctypeManager:enterFactionEctype(player, factionEctypeID)
	if not tFactionEctypeDB[factionEctypeID] then
		return
	end
	local wDay =  tonumber(os.date("%w",os.time()))
	if wDay == 0 then
		wDay = 7
	end
	local allEctypes = tFactionEctypeDB[factionEctypeID].tAllEctypes
	local ectypeID = allEctypes[wDay].EctypeID
	if not ectypeID then
		print("没有配置次次副本ID")
	end
	local ectypeConfig = tEctypeDB[ectypeID]
	if not ectypeConfig then
		print("不存在副本配置，ectypeID = ", ectypeID)
		return
	end
	local players = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	local playerDBID = player:getDBID()
	if not team then
		table.insert(players, player:getID())
	else
		if team:getLeaderID() ~= player:getID() then
			-- 不是队长
			return -1
		end
		local teamMemberList = team:getMemberList()
		for i = 1, table.getn(teamMemberList) do
			local memberID = teamMemberList[i].memberID
			if memberID then
				table.insert(players, memberID)
			end
		end
	end
	-- 判断帮会条件
	local factionID = 0
	for _, roleID in pairs(players) do
		local curRole = g_entityMgr:getPlayerByID(roleID)	
		local errorCode, roleFactionID =  self:checkFactionCondition(curRole, ectypeConfig) 
		-- 证明判断有玩家不在帮会当中
		if errorCode > 0 then
			self:sendEctypeMessageTip(player, errorCode)
			return 
		else
			if factionID > 0 then
				if factionID ~= roleFactionID then
					self:sendEctypeMessageTip(player, 21)
					return 
				end
			end
			factionID = roleFactionID
		end
		
	end
	-- 判断进入条件
	for _, roleID in pairs(players) do
		local player = g_entityMgr:getPlayerByID(roleID)
		if not self:canEnterEctype(player, ectypeConfig) then
			-- 提示不能进入的原因
			return
		end
	end
	-- 执行进入副本需要的扣除条件
	for _, roleID in pairs(players) do
		local player = g_entityMgr:getPlayerByID(roleID)
		self:exeEnterEctypeDeductCondition(player, ectypeConfig)
	end
	
	-- 创建副本
	local ectype = FactionEctype()
	if ectype:create(ectypeID) then
		local ectypeMapID = ectype:getEctypeMapID()
		-- 记录新副本
		self.allEctypes[ectypeMapID] = ectype
		local ectypeHandler = player:getHandler(HandlerDef_Ectype)
		-- 设置副本进度
		ectype:setEctypeProcess(1)
		-- 设置副本时间
		local leftMin = ectypeConfig.EctypeExistTime
		ectype:setEctypeLeftMin(leftMin)
		ectype:setEctypeAttackTime(0)
		-- 如果有两张地图
		ectype:createEctypeOhterScene()
		-- 进入新副本
		for _, roleID in pairs(players) do
			local player = g_entityMgr:getPlayerByID(roleID)
			ectype:enterEctypeScene(player)
		end
		-- 驱动副本进度
		ectype:driveEctypeProcess()
	else
		-- 创建副本失败
		print("EctypeManager:enterEctype 创建失败 1，ectypeID = ", ectypeID)
		release(ectype)
	end

end

-- 这个条件补上呢
function EctypeManager:checkFactionCondition(player, ectypeConfig)
	local factionID = player:getFactionDBID()
	if factionID <= 0 then
		return 20, factionID
	end
	return 0, factionID
end

function EctypeManager.getInstance()
	return EctypeManager()
end
