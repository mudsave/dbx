--[[DialogAction.lua
描述：
	对话点击行为(对话系统)
--]]

DialogAction = class(Singleton)

function DialogAction:__init()
	
end

--对话功能之切换对话框
function DialogAction:doGoto(player, param, npcID)
	g_dialogDoer:createDialogByID(player, param.dialogID, nil, npcID)			--创建一个对话对象
end

--对话功能之切换对话框
function DialogAction:doGotos(player, param)

	local dialogID = g_dialogCondtion:choseDialogID(player, param.dialogIDs)		--检测条件选出对话id
	if not dialogID then
		print("配置出错，对话ID为空")
		return
	end
	g_dialogDoer:createDialogByID(player, dialogID, true)
	
end

--有返回值的对话之间切换对话框主要是连环副本
function DialogAction:doRingEctype(player, param)
	local ringEctypeID = param.ringEctypeID
	local ringEctypeGroupID = g_ectypeMgr:challengeRingEctype(player, param.ringEctypeID)
	if ringEctypeGroupID <= 0 then
	    return
	end
	local dialogID = tRingEctypeDialog[ringEctypeID][ringEctypeGroupID]
	if not dialogID then
	    print("DialogAction:doRingEctype 逻辑错误", ringEctypeID, ringEctypeGroupID)
	    return
	end
	g_dialogDoer:createDialogByID(player, dialogID)	
end

--对话功能之切换场景
function DialogAction:doSwithScene(player, param)
	SceneManager.getInstance():doSwitchScence(player:getID(), param.tarMapID, param.tarX, param.tarY)
end

--对话功能之切换场景
function DialogAction:doFlyEffect(player, param)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			CactionSystem.getInstance():doFlyEffect(member, param.flyEffectID)	
		end
	else
		CactionSystem.getInstance():doFlyEffect(player, param.flyEffectID)
	end
end

function DialogAction:doEnterFight(player, param)
	local playerList = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		playerList = teamHandler:getTeamPlayerList()
	else
		table.insert(playerList,player)
	end
	print("进入战斗")
	local finalList = {}
	-- 加宠物
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList,pet)
		end
	end
	g_fightMgr:startPveFight(finalList, param.monsters, param.mapID)
end

function DialogAction:doEnterScriptFight(player, param)
	local playerList = {}
	local fightType = param.type
	local scriptID = -1
	local mapID =  -1
	if fightType == "random" then
		print("进入随机脚本战斗>>>>>>>>>>>>")
		--根据权重得到脚本ID
		scriptID = 30
		mapID =  nil
		local taskID = param.taskID
		if taskID then
			local task = player:getHandler(HandlerDef_Task):getTask(taskID)
			local targets = task:getTargets()
			for idx,target in pairs(targets) do
				print("添加scriptID>>>>>>>>>>>>>>>>>>>")
				target:addScriptID(scriptID)
			end
		end
	else
		scriptID = param.scriptID
		mapID =  param.mapID
	end

	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if teamHandler:isLeader() then
			playerList = teamHandler:getTeamPlayerList()
		elseif teamHandler:isStepOutState() then
			table.insert(playerList,player)
		end
	else
		table.insert(playerList,player)
	end
	--加宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList,pet)
		end
	end
	-- print("进入脚本战斗战斗")
	local bPass = g_fightMgr:checkStartScriptFight(finalList, scriptID,mapID)
	if bPass then
		-- 天道任务消耗活力值
		if fightType == "heaven" then
			for _,role in pairs(playerList) do
				local tiredness = role:getTiredness()
				local curValue = tiredness - param.value
				role:setTiredness(curValue)
				role:flushPropBatch()
			end
		end
		g_fightMgr:startScriptFight(finalList,scriptID, mapID)
	end
end

--进入副本NPC接口
function DialogAction:doEnterEctype(player,param)	
	print("进入副本")
	g_ectypeMgr:enterEctype(player, param.ectypeID)
end

--进入连环副本接口
function DialogAction:doEnterRingEctype(player,param)
	print("进入连环副本")
	g_ectypeMgr:enterRingEctype(player, param.ringEctypeID)
end


function DialogAction:doEnterPVPFight(player, param)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		
		local playerList1 = {}
		local playerList2 = {}

		local playerList = teamHandler:getTeamPlayerList()
		local i = 1
		for _,player in ipairs(playerList) do
			if (i%2) == 0 then
				table.insert(playerList2,player)
			else
				table.insert(playerList1,player)
			end
			i = i + 1
		end
		print("进入战斗")
		g_fightMgr:startPvpFight(playerList1, playerList2, param.mapID)
	else
		return
	end
end

--冰冻双倍经验丹
function DialogAction:doFreezeBuff(player)
	local buffHandler = player:getHandler(HandlerDef_Buff)
	buffHandler:freezeBuff()
end

--取消冰冻双倍经验丹
function DialogAction:doCancelFrozenBuff(player)
	local buffHandler = player:getHandler(HandlerDef_Buff)
	buffHandler:cancelFreezeBuff()
end

--接受一个任务
function DialogAction:doRecetiveTask(player, param)
	local isTrue,result = g_taskDoer:doRecetiveTask(player, param.taskID)
	--如果接受任务失败，则提示，如果成功，则可以执行扩展的代码
	if result and result > 0 then
		g_dialogFty:createErrorDialogObject(player, result)
		g_dialogDoer:openErrorDialog(player, result)
	else
		if param.matchNPC then
			local roleVerify = RoleVerify.getInstance()
			table.insert( roleVerify._npcTable.pool,roleVerify._npcTable.selectNPCID)
		end 
	end
end

function DialogAction:doRecetiveTasks(player, param)
	local taskIDs = param.taskIDs
	for _,taskID in pairs(taskIDs) do
		g_taskDoer:doRecetiveTask(player,taskID)
	end
end


--接受一个任务
function DialogAction:doRecetiveSpecialTask(player, param)
	local result = g_taskDoer:doReceiveSpecialTask(player, param.taskID)
	if result and result > 0 then
		g_dialogFty:createErrorDialogObject(player, result)
		g_dialogDoer:openErrorDialog(player, result)
	end
end

--Npc货架交易
function DialogAction:doRequestNpcTrade(player, param)
	print("Npc对话进行交易")
	g_tradeMgr:requestNpcTrade(player, param.npcPackID)
end

--完成任务
function DialogAction:doFinishTask(player, param)
	player:getHandler(HandlerDef_Task):finishTaskByID(param.taskID)
end

--完成任务
function DialogAction:doDoneTask(player, param)
	TaskCallBack.script(player,203)
	TaskCallBack.script(player,204)
	TaskCallBack.script(player,205)
end

--Npc对话获取物品
function DialogAction:doGetItem(player, param)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler then
		packetHandler:addItemsToPacket(param.itemID, param.count)
	end
end

--对话自动寻路
function DialogAction:doAutoTrace(player, param)
	CactionSystem.getInstance():doAutoTrace(player, param)
end

--恢复玩家最大血量
function DialogAction:doRecoverMaxHp(player, param)
	local maxHp = player:getMaxHP()
	local curHp = player:getHP()
	if curHp < maxHp then
		player:setHP(maxHp)
	end
end

-- 打开UI指引
function DialogAction:doOpenUITip(player, param)
	CactionSystem.getInstance():doOpenUITip(player,param)
end

-- 关闭对话动作
function DialogAction:doCloseDialog(player, param)
	--自己清除服务器的记录
	g_dialogMgr:removeDialog(player:getID())
	-- 通知客户端关闭
	g_dialogSym:closeDialog(player)
end

-- 打开UI
function DialogAction:doOpenUI(player, param)
	CactionSystem.getInstance():doOpenUI(player, param)
end

-- 修复当前出战宠物
function DialogAction:doRepairPet(player, param)
	PetSystem.getInstance():onRepairFightPet(player)
end

-- 修复所有宠物
function DialogAction:doRepairAllPet(player, param)
	PetSystem.getInstance():onRepairAllPet(player)
end

-- 循环任务当中上缴宠物
function DialogAction:doPaidPet(player, param)
	--打开一个ui界面
	local event = Event.getEvent(TaskEvent_SC_OpenPaidPetUI, param.taskID)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 循环任务当中有可能完成任务，有可能进入战斗
function DialogAction:doMayTaskFight(player, param)
	local taskID = param.taskID
	local taskHandler = player:getHandler(HandlerDef_Task)
	local value = math.random(1, 2)
	if value == 1 then
		-- 此时还要先调用一下那个消息删除NPC
		-- 处理完成任务
		taskHandler:finishLoopTask(taskID)
	else
		-- 触发下一个任务进度跟新
		g_taskDoer:doDeleteTask(player, taskID)
		-- 再接指定的类型的任务
		local loopTask = g_taskFty:createLoopTask(player, taskID, LoopTaskTargetType.talkScript)
		loopTask:setReceiveTaskLvl(player:getLevel())
		taskHandler:addTask(loopTask)
		taskHandler:updateTaskList(taskID, false)
	end
end

-- 去指定创建的私有NPC那购买物品
function DialogAction:doBuyItem(player, param)
	local itemID = param.itemID
	local itemNum = param.itemNum
	-- 次玩家身上扣除金钱
	local itemConfig = tItemDB[itemID]
	if not itemConfig then
		return
	end
	local saleMoney = itemConfig.SaleMoneyNum
	local buyPrice = P2NTrade_Multiple * saleMoney
	local totalPrice = buyPrice*itemNum
	local playerMoney = player:getMoney()
	local playerSubMoney = player:getSubMoney()
	local costSubMoney =0
	local costMoney = 0
	if playerSubMoney >= totalPrice then
		costSubMoney = totalPrice
	else
		if (playerSubMoney + playerMoney) >= totalPrice then
			costSubMoney = playerSubMoney
			costMoney = totalPrice - costSubMoney
		else
			--玩家金钱不足无法够买
			print("玩家身上携带的金钱不足无法购买此任务道具")
			return
		end
	end
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if not packetHandler:addItemsToPacket(itemID, itemNum) then 
		--物品进入玩家包裹失败
		print("玩家包裹满呢，无法购买")
		return 
	end
	--处理玩家的金钱
	player:setMoney(player:getMoney()-costMoney)
	player:setSubMoney(player:getSubMoney()-costSubMoney)
	-- 通知任务系统，
	TaskCallBack.onAddItem(player:getID(), itemID)
end

--循环任务中对话扣除金钱
function DialogAction:doDeductMoney(player, param)
	local curMoney = player:getMoney()
	if curMoney < param.moneyCount then
		print("玩家金钱不足，不能进行捐赠！")
		return
	else
		player:setMoney(curMoney - param.moneyCount)
		player:getHandler(HandlerDef_Task):finishLoopTask(param.taskID)
	end
end

-- 耗费英两完成任务
function DialogAction:doCostMoney(player, param)
	local costMoney = param.money
	local playerMoney = player:getMoney()
	if playerMoney < costMoney then
		print("对不起，您的英两不足")
		return 
	end
	player:setMoney(playerMoney - costMoney)
	-- 此时还要先调用一下那个消息删除NPC
	TaskCallBack.script(player, param.scriptID, true)
end

function DialogAction:doFight(player, param)
	self:doEnterScriptFight(player, param)
end

--打开循环任务捐赠界面
function DialogAction:doOpenLookTaskWin(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskID = param.taskID
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(taskID)
	if task then
		local targetType = task:getTargetType()
		local targetIndex = task:getTargetIdx()
		-- 如果类型是捐赠
		if targetType == LoopTaskTargetType.donate then
			local event = Event.getEvent(TaskEvent_SC_OpenDonateUI, taskID)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

function DialogAction:doEnterTreasureFight(player, param, npcID) 
	local playerList = {}
	print("npcID",npcID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		-- 不是队长不能使用npc
		if not teamHandler:isStepOutState() then
			if teamHandler:isLeader() then
				playerList = teamHandler:getTeamPlayerList()
			else
				print("不是队长不能使用npc")
				return
			end 
		elseif teamHandler:isStepOutState() then 
			if teamHandler:isLeader() then
				playerList = teamHandler:getTeamPlayerList()
			else
				table.insert(playerList,player)
			end
		end
	else
		table.insert(playerList,player)
	end
	--加宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList,pet)
		end
	end
	print("进入脚本战斗战斗")
	local bPass = g_fightMgr:checkStartScriptFight(finalList, param.scriptID,  param.mapID)
	-- 这里判断是不是有人使用过这个npc
	
	local curNpc = g_entityMgr:getNpc(npcID)
	local placeMoster = g_treasureMgr:getPlaceMonster(npcID)
	if not placeMoster then
		print("没有找到npc对应的宝藏")
		return
	end
	if bPass then
		if not curNpc:isFighting() then
			placeMoster:setFightPlayer(player)
			curNpc:setFighting(true)
			g_fightMgr:startScriptFight(finalList, param.scriptID,  param.mapID ,FightBussinessType.Treasure)
		end
	end
end

function DialogAction:doShowFactionList(player, param, npcID)
	
	local playerDBID = player:getDBID()
	local event_ShowFactionList = Event.getEvent(FactionEvent_BB_ShowFactionList,playerDBID)
	g_eventMgr:fireWorldsEvent(event_ShowFactionList,SocialWorldID)

end

function DialogAction:doCreateFaction(player, param, npcID)
	
	if player:getLevel() < 20 then
		local msg = FactionMsgTextKeyTable.LevelIsNotEnough
		local notifyParams = {msg = msg}
		local event_showNotifyInfo = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FactionNotify,notifyParams)
		g_eventMgr:fireRemoteEvent(event_showNotifyInfo,player)
	elseif player:getMoney() < 300000  then
		local msg = FactionMsgTextKeyTable.MoneyIsNotEnough
		local notifyParams = {msg = msg}
		local event_showNotifyInfo = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.FactionNotify,notifyParams)
		g_eventMgr:fireRemoteEvent(event_showNotifyInfo,player)
	else
		local playerDBID = player:getDBID()
		local event_CreateFaction = Event.getEvent(FactionEvent_BC_CreateFaction)
		g_eventMgr:fireRemoteEvent(event_CreateFaction,player)
	end

end

-- 捕宠战斗
--[[
function DialogAction:doEnterCatchPetFight(player, param, npcID)
	local playerList = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if teamHandler:isLeader() then
			playerList = teamHandler:getTeamPlayerList()
		elseif teamHandler:isStepOutState() then
			table.insert(playerList,player)
		end
	else
		table.insert(playerList,player)
	end
	--加宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList,pet)
		end
	end
	local bPass = g_fightMgr:checkStartScriptFight(finalList, param.scriptID,  param.mapID)
	-- 这里判断是不是有人使用过这个npc
	
	local curNpc = g_entityMgr:getNpc(npcID)
	if bPass then
		if curNpc:getStatus() ~= eEntityFighting then
			curNpc:setStatus(eEntityFighting)
			local fightID = g_fightMgr:startScriptFight(finalList, param.scriptID,  param.mapID)
			local catchPet = curNpc:getCatchPet()
			if catchPet then
				catchPet:attachCatchPet(playerID, fightID, npcID)
			end
		end
	end
end
--]]
--进入抓宠地图  (1025001 --消耗品目前都用驱魔香代替)                     
function DialogAction:doEnterCatchPetMap(player, param, npcID)
	g_catchPetMgr:enterCatchPet(player, param)
end

function DialogAction:doEnterFactionScene( player,param,npcID )

	SceneManager.getInstance():doEnterFactionScene(player:getID(),param.tarX,param.tarY)

end

function DialogAction:doContributeFaction( player,param,npcID )

	local playerDBID = player:getDBID()
	local event_ContributeFaction = Event.getEvent(FactionEvent_BB_ContributeFaction,playerDBID)
	g_eventMgr:fireWorldsEvent(event_ContributeFaction,SocialWorldID)

end

--装备鉴定
function DialogAction:doOpenEquipAppraisal(player)
	g_itemMgr:openEquipAppraisal(player)
end

--装备修理
function DialogAction:doRepairEquipment(player)
	g_itemMgr:openRepairEquipment(player)
end 

--物品兑换
function DialogAction:doExchangeProps(player)
	print("兑换道具。")
	g_itemMgr:exchangeProps(player)
end

-- 消耗接受任务
function DialogAction:doConsumeRecetiveTask(player, param, npcID)
	local result = 11
	local taskID = param.taskID
	if param.type == "money" then
		local curMoney = player:getMoney()
		local conSumemoney =  param.value
		if player:getMoney() < conSumemoney then
			result = 9
		else
			curMoney = curMoney - conSumemoney
			player:setMoney(curMoney)
			result = 11
		end
	end
	if param.type == "subMoney" then
		local curSubMoney = player:getSubMoney()
		local conSumeSubMoney =  param.value
		if player:getMoney() < conSumeSubMoney then
			result = 10
		else 
			curSubMoney = curSubMoney - conSumeSubMoney
			player:setMoney(curSubMoney)
			result = 11
		end
	end
	if result == 11 then
		print("接受了消耗型任务，任务ID为taskID",taskID)
		g_taskDoer:doRecetiveTask(player, taskID)
	else 
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, result)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

-- 完成循环任务自动接循环任务
function DialogAction:doFinishLoopTask(player, param, npcID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:finishLoopTask(param.taskID)
end

-- 改变任务状态
function DialogAction:doAddFollowNpc(player, param, npcID)
	local taskID = param.taskID
	local followNpcID = param.followNpcID
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(taskID)
	if task then
		-- 通知任务系统监听
		local npcsData = {}
		local scene = player:getScene()
		local sceneType = scene:getSceneType()
		local pos = player:getPos()	
		local followEntityList = {}
		local followEntity = g_entityFct:createFollowEntity(followNpcID)
		if followEntity then
			followEntity:setSpeed(player:getMoveSpeed())
			followEntity:setTaskType(task:getType())			
			player:getHandler(HandlerDef_Follow):addMember(followEntity)
			table.insert(npcsData, {followEntity:getID(), followNpcID})
			table.insert(followEntityList, followEntity)
		end	
		
		g_taskSystem:addFollowEntity(player, npcsData)
		for _, followEntity in pairs(followEntityList) do	
			if sceneType == MapType.Task or sceneType == MapType.Wild or task:getType() == TaskType.loop then
				scene:attachEntity(followEntity, pos[2] - 1 , pos[3] - 1)
			end
		end
		TaskCallBack.onAddFollowNpc(player:getID(), followNpcID)
	end
end
--进入猎金场
function DialogAction:doEnterGoldHuntZone(player, param)
	g_goldHuntMgr:enterHuntZone(player,param)
end

--猎金场战斗
function DialogAction:doGoldHuntFight(player, param, npcID)
	local playerList = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		return
	
	end

	local curNpc = g_entityMgr:getNpc(npcID)
	if not curNpc then
		return
	end

	g_goldHuntMgr:doGoldHuntPVEFight(player, param, npcID)
	
end

--领取活动
function DialogAction:doGetTheActivity(player)
	g_dekaronSchoolMgr:joinActivity(player)
end

--放弃门派闯关活动
function DialogAction:doGiveUpActivity(player)
	g_dekaronSchoolMgr:giveUpActivity(player)
end

function DialogAction:doDekaronSchoolFight(player,param)
	local targetID = param.activityTargetID
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler and teamHandler:isLeader() then
		local teamID = teamHandler:getTeamID()
		local team = g_teamMgr:getTeam(teamID)
		local activityTarget = team:getDekaronActivityTarget()
		if activityTarget and activityTarget:getActivityTargetId() == targetID then
			local playerList = {}
			playerList = teamHandler:getTeamPlayerList()
			--加宠物
			local finalList = {}
			for k,player in ipairs(playerList) do
				table.insert(finalList,player)
				local petID = player:getFollowPetID()
				if petID then
					local pet = g_entityMgr:getPet(petID)
					table.insert(finalList,pet)
				end
			end	

			local scriptID = activityTarget:getScriptID() 
			local bPass = g_fightMgr:checkStartScriptFight(finalList, scriptID)
			print("进入脚本战斗战斗，scriptID，bPass",scriptID,bPass)
			if bPass then
				g_dekaronSchoolMgr:addFightFlagList(teamID,scriptID)
				g_fightMgr:startScriptFight(finalList, scriptID,  nil ,FightBussinessType.Wild)
			end
		end
	end
end


--猎金场玩家提交积分
function DialogAction:doGoldHuntCommit(player, param)
	g_goldHuntMgr:commitScore(player)
end

function DialogAction:doEnterBeastFight(player, param, npcID)
	local scriptID = param.scriptID
	local beast = g_beastBlessMgr:findBeastFromList(npcID)
		print("doEnterBeastFight1")
		if beast then
			print("doEnterBeastFight2")
			local playerList = {}
			local teamHandler = player:getHandler(HandlerDef_Team)
			if teamHandler:isTeam() then
				-- 不是队长不能使用npc
				if not teamHandler:isStepOutState() then
					if teamHandler:isLeader() then
						playerList = teamHandler:getTeamPlayerList()
					else
						print("不是队长不能使用npc")
						return
					end 
				elseif teamHandler:isStepOutState() then 
					if teamHandler:isLeader() then
						playerList = teamHandler:getTeamPlayerList()
					else
						table.insert(playerList,player)
					end
				end
			else
				table.insert(playerList,player)
			end
			--加宠物
			local finalList = {}
			for k,player in ipairs(playerList) do
				table.insert(finalList,player)
				local petID = player:getFightPetID()
				if petID then
					local pet = g_entityMgr:getPet(petID)
					table.insert(finalList,pet)
				end
			end	
			local bPass = g_fightMgr:checkStartScriptFight(finalList, scriptID,  param.mapID)
			-- 这里判断是不是有人使用过这个npc
			print("进入脚本战斗战斗，npcID scriptID，bPass",npcID,scriptID,bPass)
			local curNpc = g_entityMgr:getNpc(npcID)
			if bPass then
				print("curNpc:isFighting()----------->",curNpc:isFighting())
				if not curNpc:isFighting() then
					g_beastBlessMgr:addBeastFightFlagList(player:getID(),curNpc)
					g_fightMgr:startScriptFight(finalList, scriptID,  param.mapID ,FightBussinessType.Task)
				end
			end
		end
	print("DialogAction:doEnterBeastFight")
end	

-- 接受通天塔任务，没有任务 设置任务奖励类型，切换场景
function DialogAction:doReceiveBabelTask(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(param.taskID)
	-- 如果没有任务，接受一个任务
	if not task then
		-- 之后还要改，根据玩家等级来确定层数
		local finishFlag = taskHandler:getBabelFinishFlag(param.taskID)
		-- 今日也完成
		if finishFlag == 1 then
			local msg = 23
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, result)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
		local layer = 1
		local flyLayer = 1
		local result = g_taskDoer:doReceiveBabelTask(player, param.taskID, param.rewardType, layer, flyLayer)
		if result > 0 then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, result)
			g_eventMgr:fireRemoteEvent(event, player)
			return 
		end
		local mapID = BabelEachLayerDB[param.taskID][layer].mapID
		print("mapID任务数据",mapID, param.taskID, layer)
		if mapID then
			-- 切换玩家到场景
			g_sceneMgr:doSwitchScence(player:getID(), mapID, 34, 25)
			taskHandler:setReceiveBabelTaskTime(param.taskID)
		end
	end
end

-- 如果有通天塔任务，点击对话直接进入
function DialogAction:doEnterBabel(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(param.taskID)
	if task then
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		local team = g_teamMgr:getTeam(teamID)
		if team then
			print("组队玩家不能进入通天塔地图场景")
			return
		end
		local layer = task:getLayer()
		local mapID = BabelEachLayerDB[param.taskID][layer].mapID
		if mapID then
			-- 切换玩家到场景
			g_sceneMgr:doSwitchScence(player:getID(), mapID, 34, 25)
		end
	end
end

-- 点击对话功能，进入下一层
function DialogAction:doEnterNextLayer(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(param.taskID)
	if not task then
		print("通天塔任务删除，导致出错")
		return
	end
	-- 完成任务
	-- 先获取任务当前层数，
	local layer = task:getLayer() + 1
	local reWardType = task:getRewardType()
	taskHandler:finishBabelTask(param.taskID)
	-- 在这可能还要判断一下层数， 之后再添加
	local flyLayer = 1
	g_taskDoer:doReceiveBabelTask(player, param.taskID, reWardType, layer, flyLayer)
	local curTask = taskHandler:getTask(param.taskID)
	if curTask then
		local layer = curTask:getLayer()
		local mapID = BabelEachLayerDB[param.taskID][layer].mapID
		if mapID then
			-- 切换玩家到场景
			g_sceneMgr:doSwitchScence(player:getID(), mapID, 34, 25)
		end
	end
end

-- 飞升功能
function DialogAction:doFlyUp(player, param)
	g_taskDoer:doFlyUp(player, param)
end

--  跟换奖励类型
function DialogAction:doChangeRewardType(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(param.taskID)
	if task then
		local rewardType = task:getRewardType()
		if rewardType == RewardType.expe then
			rewardType = RewardType.tao
		else
			rewardType = RewardType.expe
		end
		task:setRewardType(rewardType)
	end
end

-- 跟换任务目标
function DialogAction:doChangeTarget(player, param)
	local itemID = param.itemID
	local itemNum = param.itemNum
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local itemCount = packetHandler:getNumByItemID(itemID)
	if itemCount < itemNum then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, 22)
		g_eventMgr:fireRemoteEvent(event, player)
	else
		-- 删除任务，
		local taskHandler = player:getHandler(HandlerDef_Task)
		local task = taskHandler:getTask(param.taskID)
		if task then
			-- 移除物品
			packetHandler:removeByItemId(itemID, itemNum)
			local layer = task:getLayer()
			local reWardType = task:getRewardType()
			local flyLayer = task:getFlyLayer()
			taskHandler:finishBabelTask(param.taskID)
			-- 在这可能还要判断一下层数， 之后再添加
			g_taskDoer:doReceiveBabelTask(player, param.taskID, reWardType, layer, flyLayer)
		end
	end
end

function DialogAction:doEnterDiscussHero(player, param)
	g_discussHeroMgr:enterDiscussHero(player, param)
end

function DialogAction:doDiscussHeroFight(player, param, npcID)
	g_discussHeroMgr:doDiscussHeroPVEFight(player, param, npcID)
end


function DialogAction.getInstance()
	return DialogAction()
end

g_dialogAction = DialogAction.getInstance()
