--[[NewReWardsManager.lua
描述：
	新手在线奖励功能的实现
]]
NewReWardsManager = class(nil, Singleton)

function NewReWardsManager:__init()
	self.times			= 0						--当前第几次领奖
	self.endTimes		= 0						--记录当前次数领奖定时器结束的时间
	self.doRewardsFlag	= false					--标记玩家最后一次的奖励是否领取
	self.lastRoleDBID	= nil
end

--更新客户端显示时间
function NewReWardsManager:updateClientHour()

end

--玩家领取在线奖励
function NewReWardsManager:doRewards(roleID,times)
	if times == NOVICEREWARD_MAXTIMES then
		self.doRewardsFlag = true
	end
	local itemData = NewRewardsDB[times]
	local player = g_entityMgr:getPlayerByID(roleID)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local mailData = {}
	for _,value in pairs(itemData) do
		local flag = packetHandler:addItemsToPacket(value.materialID,value.number)
		if flag == false then
			table.insert(mailData,value)
		end
	end
	
	if table.size(mailData) > 0 then
		local sendMailData = {
				reward_name = "新手在线奖励",
				type = "新手在线奖励",
				theme = "新手在线奖励",
				content  = "<body><center>恭喜你获得了新手在线奖励</body></body>",
			}
		if table.size(mailData) == 1 then
			sendMailData.extra = { {ID = mailData[1].materialID,Amount = mailData[1].number}}
		elseif table.size(mailData) == 2 then
			sendMailData.extra = { {ID = mailData[1].materialID,Amount = mailData[1].number},{ID = mailData[2].materialID,Amount = mailData[2].number}}
		elseif table.size(mailData) == 3 then
			sendMailData.extra = { {ID = mailData[1].materialID,Amount = mailData[1].number},{ID = mailData[2].materialID,Amount = mailData[2].number},{ID = mailData[3].materialID,Amount = mailData[3].number}}
		end
		local event=Event.getEvent(MailEvent_SS_NewMail,player:getID(),player:getDBID(),sendMailData)
		g_eventMgr:fireEvent(event)
	end

	local event = Event.getEvent(NewRewardsEvent_SC_DoRewardsReturn,times)
	g_eventMgr:fireRemoteEvent(event,player)
end

--记录定时器开启启动结束的时间
function NewReWardsManager:startTimer(roleID,times,betweenTime)
	local player = g_entityMgr:getPlayerByID(roleID)
	self.endTimes = os.time() + betweenTime
	self.times = times
end

--玩家上线加载数据库数据
function NewReWardsManager:loadDataFromDB(player,value)
	--更新数据到客户端
	local event 
	if table.size(value) > 0 then
		event = Event.getEvent(NewRewardsEvent_SC_LoadData,value[1].betweenTime ,value[1].times)
		self.times = value[1].times
	else																					--玩家还没开启新手奖励
		event = Event.getEvent(NewRewardsEvent_SC_LoadData,0,0)
		self.times = 0
		self.endTimes = 0
	end
	g_eventMgr:fireRemoteEvent(event,player)
end

--检查玩家是否下线
function NewReWardsManager:onPlayerCheckOut(player)
	local roleDBID = player:getDBID()
	local roleLevel = player:getLevel()
	local offLineTime = os.time()
	local betweenTime 
	if offLineTime - self.endTimes >= 0 then
		if self.doRewardsFlag and self.times ==  NOVICEREWARD_MAXTIMES then					--玩家已经领取了最后一次新手奖励
			betweenTime = -1
		else																				--到了能领取而没有领取奖励
			betweenTime = 0
		end
	else
		betweenTime = self.endTimes - offLineTime
	end
	if roleLevel < 10 then
		LuaDBAccess.SaveNewRewards(roleDBID,0,0)
	else
		LuaDBAccess.SaveNewRewards(roleDBID,self.times,betweenTime)
	end
	self.lastRoleDBID = roleDBID
end

function NewReWardsManager.getInstance()
	return NewReWardsManager()
end