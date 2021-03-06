--[[system.lua
描述：
	系统回调入口
--]]

System = {}

function System._LoadWorldServerData(player, worldServerData)
	if not worldServerData then
		return
	end
	local flyFlagPositionList = worldServerData.flyFlagPositionList
	if type(flyFlagPositionList) == "string" then
		if flyFlagPositionList == "" then
			flyFlagPositionList = FlyFlagPositionInitList
		else
			flyFlagPositionList = unserialize(flyFlagPositionList)
		end
		local transportationHandler = player:getHandler(HandlerDef_Transportation)
		transportationHandler:setFlyFlagPositionList(flyFlagPositionList)
		local event_WorldServerData = Event.getEvent(TransportEvent_SC_SendFlyFlagPositionListToClient,flyFlagPositionList)
		g_eventMgr:fireRemoteEvent(event_WorldServerData,player)
	end

end

function System._LoadSocialServerData(player, socialServerData,roleFactionData,factionData)
	if not socialServerData then
		return
	end
	
	local factionDBID = socialServerData.factionDBID
	local factionMoney = socialServerData.factionMoney
	local factionHistoryMoney = socialServerData.factionHistoryMoney
	local autoHideChatWin = socialServerData.autoHideChatWin
	local offlineDate = socialServerData.offlineDate
	local thisWeekFactionContribute = socialServerData.thisWeekFactionContribute
	local lastWeekFactionContribute = socialServerData.lastWeekFactionContribute
	local intradayFactionContribute = socialServerData.intradayFactionContribute
	local factionConfiguration		= unserialize(socialServerData.factionConfiguration)

	player:setOfflineDate(time.totime(offlineDate))
	player:setFactionDBID(factionDBID)
	player:setAutoHideChatWin(autoHideChatWin)
	player:setFactionMoney(factionMoney)
	player:setFactionHistoryMoney(factionHistoryMoney)
	player:setThisWeekFactionContribute(thisWeekFactionContribute)
	player:setLastWeekFactionContribute(lastWeekFactionContribute)
	player:setIntradayFactionContribute(intradayFactionContribute)
	player:setFactionConfiguration(factionConfiguration)

	if factionDBID > 0 then
		SceneManager:getInstance():createFactionScene(factionDBID)
	end
	if roleFactionData then
		player:setFactionJoinDate(time.totime(roleFactionData.joinDate))
	end
	if factionData then
		local factionHandler = player:getHandler(HandlerDef_Faction)
		factionHandler:setFactionLevel(factionData.factionLevel)
	end

	local basicInfo = {
		gateId = player:getGatewayID(),
		clientLink = player:getClientLink(),
		DBID = player:getDBID(),
		name = player:getName(),
		sex = player:getSex(),
		school = player:getSchool(), 
		level = player:getLevel(),
		vigor = player:getVigor(),
		modelID = player:getModelID(),
		curHeadTex = player:getCurHeadTex(),
		curBodyTex=player:getCurBodyTex(),
		factionDBID = player:getFactionDBID(),
		autoHideChatWin = player:getAutoHideChatWin(),
		offlineDate = player:getOfflineDate(),
		factionMoney = player:getFactionMoney(),
		factionHistoryMoney = player:getFactionHistoryMoney(),
		thisWeekFactionContribute = player:getThisWeekFactionContribute(),
		lastWeekFactionContribute = player:getLastWeekFactionContribute(),
		intradayFactionContribute = player:getIntradayFactionContribute(),
		factionConfiguration = player:getFactionConfiguration(),
		roleID = player:getID(),
		banSpeechTime = player:getBanSpeechTime(),
	}
	local event = Event.getEvent(SocialEvent_SB_Enter, basicInfo)
	g_eventMgr:fireWorldsEvent(event, SocialWorldID)

	-- 开启玩家社会服属性监听
	player:createSocialProperties()
end

local function ProtectedCall(name,func)
	-- 你可以把下面的false设置为true
	if false then
		return func()
	end

	local b,errMsg = pcall(func)
	if not b then
		local builder = StringBuilder()
		builder:append( name,"出错:" )
		builder:append( '\n\t',errMsg )
		for i = 3,3 do -- 打印堆栈信息
			local info = debug.getinfo(2,"nSl")
			builder:append( '\n\t',info.short_src,":",info.currentline,' function:',info.name )
		end
		print(tostring(builder))
	end
end

function System.OnPlayerLoaded(player, recordList)	
	-- 看到这里了吗?
	-- 为了避免在测试过程中一个系统的出错影响另外一个系统的加载
	-- 我用了pcall函数屏蔽了函数执行过程中的可能出错
	-- 这样后续的函数执行能持续执行下去

	ProtectedCall("加载坐骑",function()
		-- 玩家上线加载坐骑数据
		g_rideMgr:loadRides(player,recordList[20])
	end)

	ProtectedCall("加载物品",function()
		-- 加载所有道具，因为有坐骑坐骑包裹才会开启，没有坐骑，坐骑包裹时关闭的，所以得在加载坐骑后面
		local itemsRecord = recordList[3]
		g_itemMgr:createItemFromDB(player, itemsRecord)
	end)

	ProtectedCall("加载Buff",function()
		-- 加载战斗外buff
		g_buffMgr:loadPlayerBuffFromDB(player, recordList[5])
		player:getHandler(HandlerDef_Mind):loadMinds()
	end)

	ProtectedCall("加载副本",function()
		-- 加载副本系统
		local ectypeRecord = recordList[6]
		local ringEctypeRecord = recordList[7]
		g_ectypeMgr:setEctypeData(player, ectypeRecord, ringEctypeRecord)
	end)

	ProtectedCall("加载道具使用",function()
		-- 加载道具使用次数
		g_itemMgr:loadItemUseTimes(player, recordList[8])
	end)

	ProtectedCall("加载任务",function()
		-- 加载任务系统
		g_taskDoer:loadDailyTaskConfiguration(player,recordList[35])
		g_taskDoer:loadHistoryTask(player, recordList[9])
		g_taskDoer:loadGuideHisTask(player, recordList[42])
		g_taskDoer:loadNormalTask(player, recordList[10])
		g_taskDoer:loadLoopTaskRing(player, recordList[22])
		g_taskDoer:loadDailyTask(player,recordList[34])
		g_taskDoer:loadLoopTask(player, recordList[11])
		g_taskDoer:loadTaskTrace(player, recordList[12])
		g_taskDoer:loadTaskPrivateData(player, recordList[13])
	end)

	ProtectedCall("加载新手奖励",function()
		-- 新手奖励系统
		g_newRewardsMgr:loadDataFromDB(player,recordList[15])	-- 加载玩家宠物
	end)

	ProtectedCall("加载宠物",function()
		player:loadAllPets(recordList[16])
	end)

	ProtectedCall("加载历练",function()
		-- 加载玩家历练数据
		g_experienceMgr:loadExperience(player, recordList[17])
	end)

	ProtectedCall("加载在线奖励",function()
		-- 玩家上线加载在线奖励数据
		g_onlineRewardSessMgr:createDBSession(player,recordList[18],recordList[19])	

	end)
	
	ProtectedCall("加载自动加点",function()
		-- 加载自动加点数据
		player:loadAutoPoint(recordList[21])
	end)

	ProtectedCall("加载宝藏",function()
		-- 加载宝藏的数据
		g_treasureMgr:createTreasureFromDB(player,recordList[23])
	end)
	
	ProtectedCall("加载系统功能设置",function()
		-- 加载系统功能设置
		g_RoleConfigMgr:loadDataFromDB(player,recordList[25])
	end)

	ProtectedCall("加载生活技能",function()
		--加载生活技能数据
		g_LifeSkillMgr:loadLifeSkill(player, recordList[27])
	end)

	ProtectedCall("加载疲劳",function()
		g_tirednessdMgr:loadTirednessFromDB(player,recordList[28])
	end)

	ProtectedCall("加载快捷键",function()
		--加载快捷键数据
		local keyRecord = recordList[4]
		g_ShortCutKeyMgr:updateDataToClient(player,keyRecord)
	end)

	ProtectedCall("加载历练",function()
		-- 修改
		g_practiseMgr:loadPractiseFromDB(player,recordList[29])
	end)

	ProtectedCall("加载宠物仓库",function()
		--加载玩家宠物仓库数据
		g_PetDepotMgr:playerCheckIn(player,recordList[1][1])
	end)

	ProtectedCall("加载邮件",function()
		--加载邮箱系统
		g_mailMgr:loadPlayerMails(player,recordList[14])
	end)

	ProtectedCall("加载猎金场",function()
		--加载猎金场活动
		g_goldHuntMgr:loadGoldHunt(player,recordList[30])
	end)
	
	ProtectedCall("加载瑞兽降临",function()
		g_beastBlessMgr:onPlayerOnline(player,recordList[31])
	end)

	ProtectedCall("加载门派闯关活动",function()
		-- 活动上线
		g_dekaronSchoolMgr:onPlayerOnline(player,recordList[32])
	end)

	ProtectedCall("加载物品兑换",function()
		--加载兑换物品数据
		g_exchangeItemMgr:playerOnLine(player,recordList[33])
	end)

	ProtectedCall("加载通天塔任务",function()
		g_taskDoer:loadBabelTask(player, recordList[36])
	end)

	ProtectedCall("加载天降宝盒",function()
		--加载天降宝盒活动
		g_skyFallBoxMgr:loadSkyFallBoxDB(player,recordList[37])
	end)
	
	ProtectedCall("加载煮酒论英雄",function()
		g_discussHeroMgr:onPlayerOnline(player,recordList[38])
	end)
	
	-- 通知玩家上线
	g_activityMgr:onPlayerOnline(player)
end

function System.OnPlayerLogout(player, reason)
	ProtectedCall("玩家下线保存坐骑数据",function()
		-- 玩家下线保存坐骑数据
		g_rideMgr:onPlayerCheckOut(player)
	end)

	ProtectedCall("这个必须在物品保存之前",function()
		-- 这个必须在物品保存之前
		g_treasureMgr:saveTreasureDate(player)
	end)

	ProtectedCall("下线保存道具数据",function()
		-- 下线保存道具数据
		g_itemMgr:saveItemsData(player)
	end)

	ProtectedCall("下线保存道具的使用次数",function()
		-- 下线保存道具的使用次数
		g_itemMgr:updateItemUseTimes(player)
	end)

	ProtectedCall("玩家下线保存所有的宠物",function()
		-- 玩家下线保存所有的宠物
		player:kickAllPets()
	end)

	ProtectedCall("玩家下线保存副本数据",function()
		-- 玩家下线保存副本数据
		g_ectypeMgr:saveEctypeData(player)
	end)

	ProtectedCall("保存玩家快捷键信息",function()
		g_ShortCutKeyMgr:onPlayerCheckOut(player)
	end)

	ProtectedCall("玩家下线保存在线奖励信息",function()
		-- 玩家下线保存在线奖励信息
		g_onlineRewardSessMgr:onPlayerOffline(player)
	end)

	ProtectedCall("玩家下线保存在线奖励记录",function()
		--玩家下线保存在线奖励记录
		g_newRewardsMgr:onPlayerCheckOut(player)
	end)

	ProtectedCall("玩家下线时保存生活技能数据",function()
		--玩家下线时保存生活技能数据
		g_LifeSkillMgr:saveLifeSkillData(player)
	end)

	ProtectedCall("玩家下线离线修行数值",function()
		g_experienceMgr:saveExperienceData(player)
	end)

	ProtectedCall("保存玩家的自动点数分配策略",function()
		--保存玩家的自动点数分配策略
		player:saveAutoPoint()
	end)

	ProtectedCall("玩家下线保存活力值",function()
		-- 玩家下线保存活力值
		g_tirednessdMgr:saveTiredness(player)
	end)

	ProtectedCall("玩家下线保存修行值",function()
		-- 玩家下线保存修行值
		g_practiseMgr:savePractiseData(player)
	end)

	
	ProtectedCall("玩家下线时更新",function()
		--玩家下线时更新buff
		g_buffMgr:updateRoleBuff(player)
	end)

	ProtectedCall("玩家下线时更新任务",function()
		--玩家下线时更新任务
		g_taskDoer:updateRoleTask(player)
	end)

	ProtectedCall("玩家下线增加未读邮件",function()
		--玩家下线增加未读邮件
		g_mailMgr:update2DB(player:getDBID())
		g_mailMgr:removeMailBox(player:getDBID())
	end)

	ProtectedCall("玩家下线关闭交易",function()
		--玩家下线关闭交易
		g_tradeMgr:releaseTrade(player:getID())
	end)
	
	ProtectedCall("玩家下线退出队伍",function()
		--玩家下线退出队伍
		g_teamMgr:onPlayerCheckOut(player)
	end)

	ProtectedCall("玩家下线保存活动值",function()
		-- 玩家下线保存活动值
		g_activityMgr:onPlayerOffline(player)
	end)

	ProtectedCall("玩家下线保存兑换物品信息",function()
		--玩家下线保存兑换物品信息
		--g_exchangeItemMgr:palyerOffLine(player)
	end)

	ProtectedCall("下线保存已完成指引任务",function()
		player:getHandler(HandlerDef_Task):checkHisGuideTask2DB()		
	end)
	
	ProtectedCall("释放对话",function()
		-- 释放对话
		g_dialogMgr:onPlayerOffline(player)
	end)

	g_eventMgr:fireWorldsEvent(
		Event.getEvent(
			SocialEvent_BB_ExitWorld,player:getDBID()
		), SocialWorldID
	)
end

--玩家掉线后再登陆上线的统一入口，由个业务系统实现初始化(在进战斗前)
function System.onPlayerReloginBeforeFight(player)
	local status = player:getStatus()
	g_ectypeMgr:onPlayerPreRelogin(player, status)
end

--玩家掉线后再登陆上线的统一入口，由个业务系统实现初始化(在进战斗后)
function System.onPlayerReloginAfterFight(player)
end

--在战斗中玩家强叉客户端，各业务系统的处理(此时玩家保留，不保存数据库)
function System.onPlayerLogOutByForce(player)
end

--掉线后重新恢复了心跳,由个业务系统根据需要实现
function System.onPlayerReAttached(player)
	local status = player:getStatus()
	player:setLastActive(os.time())
	if status == ePlayerInactiveFight then
		player:setStatus(ePlayerFight)
		local accountID = player:getAccountID()
		g_world:send_MsgWS_ClearOffFightInfo(accountID, player:getVersion())
		local fightServerID = player:getFightServerID()
		local event = Event.getEvent(FrameEvents_SS_playerOnLine, player:getDBID(),OnlineReason.Reattach)
		g_eventMgr:fireWorldsEvent(event,fightServerID)
	else
		player:setStatus(ePlayerNormal)
	end
end

--当玩家心跳没有触发的掉线,由个业务系统根据需要实现
function System.onPlayerDettached(player)
	print(player:getDBID(),"begin  offline")
	
	local state = player:getStatus()
	if state == ePlayerFight then
		player:setStatus(ePlayerInactiveFight)
		local gateLink = player:getGateLink()
		local DBID =  player:getDBID()
		g_world:send_MsgWG_OfflineInFight(gateLink, DBID, player:getVersion())
		player:setStatus(ePlayerInactiveFight)
		player:setIsFightClose(false)
		local fightServerID = player:getFightServerID()
		local event = Event.getEvent(FrameEvents_SS_playerDropLine, DBID, ePlayerInactiveFight)
		g_eventMgr:fireWorldsEvent(event,fightServerID)
	else
		player:setStatus(ePlayerInactive)
	end
end
