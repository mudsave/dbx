-- GMCmdSystem.lua

require "event.EventSetDoer"
require "game.GMSystem.GMAttributes"

local tonumber,type = tonumber,type

local GMSystem = ShellSystem:getInstance()

function GMSystem:addXP(roleID,xpValue)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		print "玩家设置经验"
		player:addAttrValue(player_xp,tonumber(xpValue))
		player:flushPropBatch()
	end
end

--测试goto传送指令
function GMSystem:goto( roleID, mapID, x, y, targetID, npc)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		if not CoScene:PosValidate(tonumber(mapID),tonumber(x),tonumber(y)) then
			local event = Event.getEvent(ChatEvents_SC_GotoMsgReturn)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
		local mapID,x,y =tonumber(mapID),tonumber(x),tonumber(y)
		g_sceneMgr:doSwitchScence(roleID, mapID ,x ,y)
	end
end

-- 增加道具指令
function GMSystem:additem( roleID, itemID, itemNum)
	local player = g_entityMgr:getPlayerByID(roleID)
	local itemID, itemNum = tonumber(itemID), tonumber(itemNum) or 1
	if player and itemID then
		local packetHandler = player:getHandler(HandlerDef_Packet)
		packetHandler:addItemsToPacket(itemID, itemNum)
	end
end

--设置宠物5个基础属性的值(武力、智力、根骨、敏锐、身法)
function GMSystem:set_pet_all(roleID,value)
    local player = g_entityMgr:getPlayerByID(roleID)
	local petID = player:getFollowPetID()
    local pet = g_entityMgr:getPet(petID)
    if pet then
        pet:setAttrValue(pet_add_str,value)
        pet:setAttrValue(pet_add_int,value)
        pet:setAttrValue(pet_add_sta,value)
        pet:setAttrValue(pet_add_spi,value)
        pet:setAttrValue(pet_add_dex,value)
		pet:flushPropBatch()
    else
        print("没有出战宠物不能进行相关操作")
        return
    end
end

--设置宠物指定属性的值
function GMSystem:set_petattr(roleID,attrType,value)
    local player = g_entityMgr:getPlayerByID(roleID)
	local petID = player:getFollowPetID()
    local pet = g_entityMgr:getPet(petID)
    attrType = tonumber(attrType)
    if pet then
        pet:setAttrValue(attrType,value)
		pet:flushPropBatch()
    else
        print("当前没有出战宠物不能进行相关操作")
        return
    end
end

--为宠物添加技能
function GMSystem:add_pet_skills(roleID,...)
    local player = g_entityMgr:getPlayerByID(roleID)
	local petID = player:getFollowPetID()
    local pet = petID and g_entityMgr:getPet(petID)
	if not pet then
		print("没有出战宠物，无法学习技能")
		return
	end
	local handler = pet:getHandler(HandlerDef_PetSkill)
	if handler:isFull() then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet,PetError.CantLearnMore),player
		)
		return
	end
	print "添加技能中"
	for i = 1,select('#',...) do
		local value = select(i,...)
		local id = tonumber(value)

		local access,errCode = handler:canAddSkill(id)
		if not access then
			print(("不能添加宠物技能:%s"):format(id))
			g_eventMgr:fireRemoteEvent(
				Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet,errCode),player
			)
		else
			handler:addSkill(PetSkill(id,2))
		end
	end
	handler:sendFreshs(player)
	handler:sendPassed(player)
	pet:flushPropBatch(player)
	print "添加宠物技能"
end

-- 重置副本数据指令
function GMSystem:resetectype( roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local ectypeHandler = player:getHandler(HandlerDef_Ectype)
		ectypeHandler:resetEctypeInfo()
	end
end

-- 进入副本指令
function GMSystem:enterectype( roleID, ectypeID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		ectypeID = tonumber(ectypeID)
		g_ectypeMgr:enterEctype(player, ectypeID)
	end
end

-- 进入帮会不笨指令
function GMSystem:factionectype(roleID, factionEctypeID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		factionEctypeID = tonumber(factionEctypeID)
		g_ectypeMgr:enterFactionEctype(player, factionEctypeID)
	end
end

--设置指定属性的值，战斗内和战斗外都可以用
function GMSystem:set_attr( roleID, attrType, value, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		attrType = tonumber(attrType)
		local fightServerID = player:getFightServerID()
		local bFighting = player:isFighting()
		if bFighting and fightServerID then
			local event = Event.getEvent(FightEvents_SF_SetAttr, player:getDBID(), attrType, value, targetID)
			g_eventMgr:fireWorldsEvent(event, fightServerID)
		else
			player:setAttrValue(attrType, value)
		end
	end
end

-- 设置玩家所有属性 + 战斗外可以，战斗内没处理
function GMSystem:set_all( roleID, value, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local fightServerID = player:getFightServerID()
		local bFighting = player:isFighting()
		if bFighting and fightServerID then
			return
		else
			value = tonumber(value)
			if value < 0 then
				value = 0
			end
			player:setAttrValue(player_add_str, value)
			player:setAttrValue(player_add_int, value)
			player:setAttrValue(player_add_sta, value)
			player:setAttrValue(player_add_spi, value)
			player:setAttrValue(player_add_dex, value)
		end
		local curHp = player:getHP()
		local maxHp = player:getMaxHP()
		if curHp > maxHp then
			player:setHP(maxHp)
		end
		local curMp = player:getMP()
		local maxMp = player:getMaxMP()
		if curMp > maxMp then
			player:setMP(maxMp)
		end
	end
end

function GMSystem:inc_all( roleID, value, targetID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local fightServerID = player:getFightServerID()
		local bFighting = player:isFighting()
		if bFighting and fightServerID then
			return
		else
			value = tonumber(value)
			player:setAttrValue(player_add_str, player:getAttrValue(player_add_str) + value)
			player:setAttrValue(player_add_int, player:getAttrValue(player_add_int) + value)
			player:setAttrValue(player_add_sta, player:getAttrValue(player_add_sta) + value)
			player:setAttrValue(player_add_spi, player:getAttrValue(player_add_spi) + value)
			player:setAttrValue(player_add_dex, player:getAttrValue(player_add_dex) + value)
		end
	end
end

--设置玩家生命法力全满，战斗内和战斗外都可以用
function GMSystem:full( roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local fightServerID = player:getFightServerID()
		local bFighting = player:isFighting()
		if bFighting and fightServerID then
			local event = Event.getEvent(FightEvents_SF_SetAttr, player:getDBID(), player_hp, player:getMaxHP())
			g_eventMgr:fireWorldsEvent(event, fightServerID)
			event = Event.getEvent(FightEvents_SF_SetAttr, player:getDBID(), player_mp, player:getMaxMP())
			g_eventMgr:fireWorldsEvent(event, fightServerID)
		else
			local curHp = player:getHP()
			local maxHp = player:getMaxHP()
			if curHp < maxHp then
				player:setHP(maxHp)
			end
			local curMp = player:getMP()
			local maxMp = player:getMaxMP()
			if curMp < maxMp then
				player:setMP(maxMp)
			end
			player:flushPropBatch()
		end
	end
end

GMSystem.fill = GMSystem.full

--设置 人物心法等级([set_skill 101, 30] 101->心法id，30->等级)
function GMSystem:set_skill( roleID, id, level)
	local player = g_entityMgr:getPlayerByID(roleID)
	local handler = player:getHandler(HandlerDef_Mind)
	local add_level = tonumber(level)
	local mind_id = tonumber(id)

	local result
	local add_max_level = 0
	local max_level = player:getLevel() + 10
	local minds = {}
	if mind_id == 1 then
		minds = SchoolMind[player:getSchool()]
	else
		local mind = handler:get_mind(mind_id)
		if not mind then
			print ('ERROR: not exist mind', mind_id)
			return
		end
		if mind.level >= MAX_MIND_LEVEL then
			print ('ERROR: mind arrived max level')
			return
		end

		if mind.db.position == 0 then
			max_level = handler:get_main_mind_level()
		end
		table.insert(minds, mind_id)
	end
	local context = {}
	for _, id in ipairs(minds) do
		local add_value = add_level
		local mind = handler:get_mind(id)
		add_max_level = max_level - mind.level
		if add_max_level <= 0 then
			add_value = 0
			print ('ERROR: mind arrived max avalibe level')
		elseif add_value > add_max_level then
			add_value = add_max_level
		end
		result = mind:upgrade(add_value)
		result.mindID = id
		MindSystem.getInstance().answerUpgrade(player, result)

		if result.up_level ~= 0 then
			context.mind_id = id
			context.add_level = result.up_level
			LuaDBAccess.upgradeMind(player:getDBID(), id, result.up_level, MindSystem.getInstance().onUpgradeMind, context)
		end
	end
end

--设置 人物心法等级([set_mind 101, 30] 101->心法id，30->等级)
function GMSystem:set_mind( roleID, mind_id, level)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		mind_id = tonumber(mind_id)
		level = tonumber(level)
		local handler = player:getHandler(HandlerDef_Mind)
		handler:gm_set_mind_level(mind_id, level)
	end
end

--进入脚本战斗(格式：s_fight 12 12是脚本战斗ID)
function GMSystem:s_fight(roleID,scriptID ,mapID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local script_ID = tonumber(scriptID)
	local map_id = tonumber(mapID)
	if player and script_ID then
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
		local finalList = {}
		--加宠物
		for k,player in ipairs(playerList) do
			table.insert(finalList,player)
			local petID = player:getFollowPetID()
			if petID then
				local pet = g_entityMgr:getPet(petID)
				table.insert(finalList,pet)
			end
		end
		g_fightMgr:startScriptFight(finalList, script_ID,  map_id ,FightBussinessType.Test)
	end
end

--进入脚本战斗(格式：s_fightType 12 12是脚本战斗ID,战斗的类型)
--FightBussinessType = {--1,--野外2,--切磋3,--PK4,--任务5,--测试6,--采集7,--藏宝图}
function GMSystem:s_fightType(roleID,scriptID,fightType,mapID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local script_ID = tonumber(scriptID)
	local map_id = tonumber(mapID)
	if player and script_ID then
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
		local finalList = {}
		--加宠物
		for k,player in ipairs(playerList) do
			table.insert(finalList,player)
			local petID = player:getFollowPetID()
			if petID then
				local pet = g_entityMgr:getPet(petID)
				table.insert(finalList,pet)
			end
		end
		if not fightType then
			fightType = FightBussinessType.Test
		else
			fightType = toNumber(fightType)
		end
		g_fightMgr:startScriptFight(finalList, script_ID,  map_id ,fightType)
	end
end

--和怪物战斗(格式：m_fight 12 13 14 (12,13,14是怪物ID) )
function GMSystem:m_fight(roleID,...)
	local player = g_entityMgr:getPlayerByID(roleID)
	--怪物列表
	local m_IDs = {}
	for idx = 1,select('#',...) do
		local id = select(idx,...)
		table.insert(m_IDs,tonumber(id))
	end

	local mapID
	--玩家列表
	if player and #m_IDs > 0 then
		local playerList = {}
		local teamHandler = player:getHandler(HandlerDef_Team)
		if teamHandler:isTeam() then
			playerList = teamHandler:getTeamPlayerList()
		else
			table.insert(playerList,player)
		end
		print("进入战斗")
		local finalList = {}
		--加宠物
		for k,player in ipairs(playerList) do
			table.insert(finalList,player)
			local petID = player:getFollowPetID()
			if petID then
				local pet = g_entityMgr:getPet(petID)
				table.insert(finalList,pet)
			end
		end
		g_fightMgr:startPveFight(finalList, m_IDs,  mapID ,FightBussinessType.Test)
	end
end

-- 接受任务(格式：add_task 2002 (2002是任务ID) )
function GMSystem:add_task( roleID, taskID, state)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player and taskID then
		g_taskDoer:doRecetiveTask(player, tonumber(taskID), state)
	end
end

-- 结束任务(格式：finish_task 2002 (2002是任务ID) )
function GMSystem:finish_task( roleID, taskID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player and taskID then
		player:getHandler(HandlerDef_Task):finishTaskByID(tonumber(taskID))
	end
end

-- 结束任务(格式：finish_task 2002 (2002是任务ID) )
function GMSystem:done_scriptTask( roleID, scriptID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		TaskCallBack.script(player, scriptID, true)
	end
end

--世界广播(格式: horn ok (ok是内容))
function GMSystem:horn( roleID, msg)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		g_chatMgr:sendMessage(player, ChatChannelType.World, msg, {}, true)
	end
end

--退出战斗(格式: e_fight )
function GMSystem:e_fight( roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local fightServerID = player:getFightServerID()
		local bFighting = player:isFighting()
		if bFighting and fightServerID then
			local event = Event.getEvent(FightEvents_SF_ExitFight, player:getDBID())
			g_eventMgr:fireWorldsEvent(event, fightServerID)
		end
	end
end

-- 设置银两
function GMSystem:set_money( roleID, value)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		value = tonumber(value)
		player:setMoney(value)
	end
end

-- 设置绑银
function GMSystem:set_submoney( roleID, value)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		value = tonumber(value)
		player:setSubMoney(value)
	end
end

-- 设置礼金
function GMSystem:set_cashmoney( roleID, value)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		value = tonumber(value)
		player:setCashMoney(value)
	end
end

function GMSystem:send_mail(roleID,...)
end

function GMSystem:addGoldCoin( roleID, value)
	local player = g_entityMgr:getPlayerByID(roleID)
	local roleDBID = player:getDBID()
	if player then
		value = tonumber(value)
		LuaDBAccess.AddGoldCoin(roleDBID, value, GMSystem_addGoldCoin, roleDBID)
	end
end

function GMSystem:deductGoldCoin( roleID, value)
	local player = g_entityMgr:getPlayerByID(roleID)
	local roleDBID = player:getDBID()
	if player then
		value = tonumber(value)
		LuaDBAccess.DeductGoldCoin(roleDBID ,value, GMSystem_deductGoldCoin, roleDBID)
	end
end

-- 元宝增加的回调函数
function GMSystem:addGoldCoin(recordList, dbId)
	local params = recordList[1]
	local player = g_playerMgr:findPlayerByDBID(dbId)
	player:setGoldCoin(params[1].goldCoin)
end

-- 扣除元宝的回调函数
function GMSystem:deductGoldCoin(recordList, dbId)
	local params = recordList[1]
	if 0 == params[1].result then
		-- 失败...
	else
		-- 成功
		local player = g_playerMgr:findPlayerByDBID(dbId)
		player:setGoldCoin(params[1].goldCoin)
	end
end

function GMSystem:test_pet(roleID, configID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local roleDBID = player:getDBID()
	if player then
		if player:canAddPet() then
			local pet = g_entityFct:createPet(tonumber(configID))
			if not pet then
				print(("宠物%s是没有配置的"):format(configID))
				return
			end
			pet:setOwner(player)
			player:addPet(pet)
		else
			g_eventMgr:fireRemoteEvent(
				Event.getEvent(
					ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.MaxPetNumber
				),player
			)
		end
	end
end

function GMSystem:rename_pet(roleID,name)
	local player = g_entityMgr:getPlayerByID(roleID)
	local roleDBID = player:getDBID()
	if not player then return false end
	for _,pet in pairs(player:getPetList()) do
		if pet:getPetStatus() == PetStatus.Fight then
			pet:setName(name)
			return true
		end
	end
	return false
end

function GMSystem:test_pvp(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
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
		g_fightMgr:startPvpFight(playerList1, playerList2, 2)
	else
		return
	end
end

-- 增加装备指令
function GMSystem:add_equipment( roleID, itemId, itemNum, bindFlag, blueAttrNum, remouldLevel)
	itemId = tonumber(itemId)
	itemNum = tonumber(itemNum)
	local itemConfig = tItemDB[itemId]
	if not itemConfig or itemConfig.Class ~= ItemClass.Equipment then
		-- 找不到道具配置
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		-- 生成道具属性现场
		local propertyContext = {}
		propertyContext.itemID = itemId
		propertyContext.effect = 0
		propertyContext.identityFlag = true

		propertyContext.expireTime = itemConfig.MaxDurability*ConsumeDurabilityNeedFightTimes
		-- 基础属性
		g_itemMgr:generateEquipBaseAttr(propertyContext, itemConfig)

		if itemConfig.Quality == ItemQuality.NoIdentify then
			-- 设置未鉴定标志
			propertyContext.identityFlag = false
		else
			-- 附加属性
			if blueAttrNum then
				blueAttrNum = tonumber(blueAttrNum)
				if blueAttrNum > EquipBlueAttrMaxNum then
					blueAttrNum = EquipBlueAttrMaxNum
				elseif blueAttrNum <= 1 then
					blueAttrNum = 1
				end
			end
			g_itemMgr:generateEquipAddAttr(propertyContext, itemConfig, blueAttrNum)
		end
		-- 绑定属性
		g_itemMgr:generateEquipBindAttr(propertyContext, itemConfig)
		for i = 1,itemNum do
			local equip = g_itemMgr:createItemFromContext(propertyContext, 1)
			if equip then
				if bindFlag ~= nil then
					equip:setBindFlag(Bind)
				else
					equip:setBindFlag(UnBind)
				end
				local packetHandler = player:getHandler(HandlerDef_Packet)
				packetHandler:addItems(equip:getGuid())
			end
		end
	end
end

-- 设置所有装备的耐久度
function GMSystem:set_durable( roleID, durable)
	durable = tonumber(durable)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local equipHandler = player:getHandler(HandlerDef_Equip)
		local equip = equipHandler:getEquip()
		local equipPack = equip:getPack()
		for gridIndex = 1, equipPack:getCapability() do
			local equip = equipPack:getGridItem(gridIndex)
			if equip then
				local maxDurability = equip:getMaxDurability()
				if durable > maxDurability then
					durable = maxDurability
				elseif durable < 0 then
					durable = 0
				end
				equip:setCurDurability(durable * ConsumeDurabilityNeedFightTimes)
			end
		end
		equipPack:updateClient()
	end
end

-- 清空背包
function GMSystem:empty_packet( roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local packetHandler = player:getHandler(HandlerDef_Packet)
		local packet = packetHandler:getPacket()
		for packindex = PacketPackIndex.Default, PacketPackIndex.MaxNum-1 do
			local pack = packet:getPack(packindex)
			if pack then
				for gridIndex = 1, pack:getCapability() do
					pack:destroyItem(gridIndex, false)
				end
			end
		end
		packet:updateItemToClient()
	end
end

--添加坐骑
function GMSystem:add_ride(roleID,rideID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		g_rideMgr:addRide(player,tonumber(rideID))
	end
end

-- 取消所有的buff
function GMSystem:empty_buff(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if player then
		local buffHandler = player:getHandler(HandlerDef_Buff)
		buffHandler:calcelAllBuff()
	end
end

-- 修改帮贡
function GMSystem:set_factionMemberMoney( roleID,money)

	local player = g_entityMgr:getPlayerByID(roleID)
	local playerDBID = player:getDBID()
	local event = Event.getEvent(FactionEvent_BB_UpdateFactionMemberInfo,"memberMoney",playerDBID,toNumber(money))
	g_eventMgr:fireWorldsEvent(event,SocialWorldID)

end

-- 帮会资金
function GMSystem:set_factionMoney( roleID,money)

	local player = g_entityMgr:getPlayerByID(roleID)
	local playerDBID = player:getDBID()
	local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo,"factionMoney",playerDBID,toNumber(money))
	g_eventMgr:fireWorldsEvent(event,SocialWorldID)

end

-- 帮会声望
function GMSystem:set_factionFame( roleID,fame)

	local player = g_entityMgr:getPlayerByID(roleID)
	local playerDBID = player:getDBID()
	local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo,"factionFame",playerDBID,toNumber(fame))
	g_eventMgr:fireWorldsEvent(event,SocialWorldID)

end

-- 帮会等级
function GMSystem:set_factionLevel( roleID,level)

	local player = g_entityMgr:getPlayerByID(roleID)
	local playerDBID = player:getDBID()
	local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo,"factionLevel",playerDBID,toNumber(level))
	g_eventMgr:fireWorldsEvent(event,SocialWorldID)

end
-- 退出帮会
function GMSystem:set_exitFaction( roleID)

	local player = g_entityMgr:getPlayerByID(roleID)
	local playerDBID = player:getDBID()
	local event = Event.getEvent(FactionEvent_BB_ExitFaction,playerDBID)
	g_eventMgr:fireWorldsEvent(event,SocialWorldID)

end

-- 活力值

function GMSystem:set_tiredness( roleID,inputValue)
	local value = tonumber(inputValue)
	if value >= 0 and value <= MaxPlayerTiredness then
		local player = g_entityMgr:getPlayerByID(roleID)
		player:setTiredness(value)
		player:flushPropBatch()
	end
end

-- 设置修行值
function GMSystem:set_practise( roleID,inputValue)
	local value = tonumber(inputValue)
	if value >= 0 then
		local player = g_entityMgr:getPlayerByID(roleID)
		player:setPractise(value)
		player:flushPropBatch()
	end
end

-- 添加修行值
function GMSystem:add_practise( roleID,inputValue)
	local value = tonumber(inputValue)
	if value >= 0 then
		local player = g_entityMgr:getPlayerByID(roleID)
		player:addPractise(value)
		player:flushPropBatch()
	end
end

function GMSystem:set_storeXp(roleID,inputValue)
	local value = tonumber(inputValue)
	if value >= 0 then
		local player = g_entityMgr:getPlayerByID(roleID)
		player:setStoreXp(value)
		player:flushPropBatch()
	end
end

function GMSystem:show_fight(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then return end
	local pet = g_entityMgr:getPet(player:getFollowPetID())
	if pet then
		pet:setVisible(true)
	else
		notice("玩家没有出战宠物")
	end
end

function GMSystem:show_ready(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then return end
	local pet = g_entityMgr:getPet(player:getReadyPetID())
	if pet then
		pet:setVisible(true)
	else
		notice("玩家没有掠阵宠物")
	end
end

function GMSystem:hideOrShow(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then return end

	local pet = g_entityMgr:getPet(player:getFollowPetID())
	if pet and pet:isVisible() then
		pet:setVisible(false)
	else
		for _,pet in pairs(player:getPetList()) do
			pet:setVisible(true)
			break
		end
	end
end

function GMSystem:openBeastBless(roleID)
	local activityList =  g_activityMgr:getActivityList()
	local id = g_beastBless:getID()
	activityList[id] = g_beastBless
	print("openBeastBless $$$$$$ ")
	g_beastBless:open()
end

function GMSystem:closeBeastBless(roleID)
	print("closeBeastBless $$$$$$")
	g_beastBless:close()
end


--[[
	同步玩家属性到战斗服
	只能同步在属性集合中的属性
]]
local function onPlayerAttrToWar(player,attrNavalue)
	local fightServerID = player:getFightServerID()
	if player:isFighting() and fightServerID then
		local event = Event.getEvent(FightEvents_SF_SetAttr, player:getDBID(), attrName, value, targetID)
		g_eventMgr:fireWorldsEvent(event, fightServerID)
	end
end

--[[
	同步宠物属性到战斗服
	当前战斗服不支持
	local function onPetAttrToWar(pet,attrNavalue)
	end
]]

--[[
	获取玩家战斗服属性
]]
local function onPlayerWarAttr(player,attrName)
	local fightServerID = player:getFightServerID()
	local bFighting = player:isFighting()
	if bFighting and fightServerID then
		local event = Event.getEvent(FightEvents_SF_QueryAttr, player:getDBID(), attrName,targetID)
		g_eventMgr:fireWorldsEvent(event, fightServerID)
	end
end

local function onGetPlayerByID(id)
	return g_entityMgr:getPlayerByID(id)
end

local function onGetPet(id)
	local player = onGetPlayerByID(id)
	if player then
		local petID = player:getFollowPetID()
		return petID and g_entityMgr:getPet(petID)
	end
	return nil
end

local function onPetAttrSet(entity)
	print "宠物属性设置完毕"
	entity:flushPropBatch()
end

-- 属性设置之后同步到客户端
local function onPlayerAttrSet(entity)
	entity:flushPropBatch()
end

-- 通过属性配置生成对应的实体属性操作指令
-- 接受参数
-- onGetEntity	通过ID获取实体
-- onAttrToWar	同时实体属性到战斗服
-- onWarAttr	获得战斗服中的实体属性
-- onAttrToWar	属性设置完毕后调用的函数
local function MakeEntityGM(Attrs,onGetEntity,onAttrToWar,onWarAttr,onAttrSet)
	for attrName,detail in pairs(Attrs) do
		-- 初始化某条属性的取值函数
		-- 如果在配置中有指定对应的函数,则使用该函数
		-- 否则并且这条属性的有配置属性ID,则使用默认的属性集合获取函数
		-- 如果最终没有取值函数,则加值指令不能使用
		local get_func = detail.get_func
		if not get_func and attrName > 0 then
			get_func = function(entity)
				return entity:getAttrValue(attrName)
			end
		end

		-- 初始化设值函数
		-- 使用配置中的设值函数或者根据属性配置根据属性ID生成
		-- 如果设值函数是生成的,则会尝试同步属性到战斗服
		-- 如果没有设值函数,则不会生成用来确保值在值域之间的函数
		local set_func = detail.set_func
		if not set_func and attrName > 0 and not detail.components then
			set_func = function(entity,value)
				entity:setAttrValue(attrName,value)

				-- 普通属性同步到战斗服
				if onAttrToWar then
					onAttrToWar(entity,attrName,value)
				end
			end	
		end

		-- 确保值在范围内
		local ensure_func = nil
		local limited = detail.limited
		local default = detail.default or 0
		local maxValue_func = nil

		if limited then
			if type(limited) == "string" then
				local maxValue_Number = tonumber(limited)
				maxValue_func = function(entity)
					return maxValue_Number
				end
			else
				maxValue_func = function(entity)
					return entity:getAttrValue(limited)
				end
			end
		end

		-- 函数作用:确保值在合理的范围内
		ensure_func = function(entity,value)
			if value < default then
				return default
			end
			if maxValue_func then
				local maxValue = maxValue_func(entity)
				if value > maxValue then
					value = maxValue_
				end
			end
			return value
		end

		-- 加值函数
		local add_func = detail.add_func
		if not add_func then
			local components = detail.components
			if components then
				local delta = components.delta
				add_func = function(entity,value)
					if value + entity:getAttrValue(delta) < 1 then
						entity:setAttrValue(delta,0)
					else
						entity:addAttrValue(delta, value)
					end
					if onAttrToWar then
						onAttrToWar(entity,delta,entity:getAttrValue(delta))
					end
				end
			elseif attrName > 0 then
				add_func = function(entity,value)
					local newValue = ensure_func(entity,entity:getAttrValue(attrName) + value)
					set_func(entity,newValue)
					if onAttrToWar then
						onAttrToWar(entity,attrName,newValue)
					end
				end
			elseif set_func and get_func then
				add_func = function(entity,value)
					set_func(entity,ensure_func(entity,get_func(entity) + value))
				end
			end
		end

		if not set_func and ( get_func and add_func ) then
			set_func = function(entity,value)
				value = ensure_func(entity,value)
				local current = get_func(entity)
				add_func( entity,value - current )
			end
		end

		if set_func then
			GMSystem[ ("set_%s"):format(detail.alias) ] = function(self,id,value)
				local entity = onGetEntity(id)
				if not entity then
					print( ("set_%s:no such entity!"):format(detail.alias) )
					return
				end
				set_func(entity,tonumber(value))
				if onAttrSet then onAttrSet(entity) end
			end
		end

		if add_func then
			GMSystem[ ("add_%s"):format(detail.alias) ] = function(self,id,value)
				local entity = onGetEntity(id)
				if not entity then
					print( ("set_%s:no such entity!"):format(detail.alias) )
					return
				end
				add_func(entity,tonumber(value))
				if onAttrSet then onAttrSet(entity) end
			end
		end

		if onWarAttr and attrName > 0 then
			GMSystem[ ("get_%s"):format(detail.alias) ] = function(self,id)
				local entity = onGetEntity(id)
				if not entity then
					print( ("set_%s:no such entity!"):format(detail.alias) )
					return
				end
				onWarAttr(entity,attrName)
			end
		end
	end
end

-- 开启活动
function GMSystem:openactivity(player, activityID)
	local value = tonumber(activityID)
	if value >= 0 then
		local activity = g_activityMgr:getActivity(value)
		if not activity then
			g_activityMgr:openActivity(value, ActivityDB[value].name)
		end
	end
end

-- 关闭活动
function GMSystem:closeactivity(player, activityID)
	local value = tonumber(activityID)
	if value >= 0 then
		local activity = g_activityMgr:getActivity(value)
		if activity then
			g_activityMgr:closeActivity(value)
		end
	end
end

MakeEntityGM( PlayerGMAttrs,onGetPlayerByID,onPlayerAttrToWar,onPlayerWarAttr,onPlayerAttrSet)
MakeEntityGM( PetGMAttrs,onGetPet,nil,nil,onPetAttrSet)
