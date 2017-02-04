--[[RewardSessionManager.lua
	描述：玩家抽奖session管理
]]

local math_random = math.random
local nDay = tonumber(os.date("%w",os.time()))
local initLeftTimes = OnlineRewardExtractionTimer[nDay]

RewardSession = class()

--把一天转化为零时刻
function getbaseday()
	local tm = os.date("*t",os.time())
	tm.hour = 0
	tm.min = 0
	tm.sec = 0
	return os.time(tm)
end

--首次上线触发
function RewardSession:__init(player)
	self.ownerID =	player:getDBID()
	self.r_number = false	--随机数
	self.nTimes = 0			--当前可抽奖次数
	self.times = 1			--累计抽奖次数
	self.offTimes = 0		--累计已抽奖次数
	self.nLastTime = nil	--最后一次发送倒计时的时间
	self.nLeftTime = 0		--倒计时剩余时间
	self.onLineTime = nil	-- 上线的时间
	self.offLineTime = nil	-- 下线的时间
	self.resultlist = {}	--在线奖励的物品ID
	self.DB_index = 1		--用于数据库更新的Index，用以表示抽奖结果是第几个更新
end

function RewardSession:__release()
end

function RewardSession:initDef()   
	self.r_number			= false					--随机数
	self.nTimes				= 0						--当前可抽奖次数
	self.times				= 1						--累计抽奖次数
	self.offTimes			= 0						--累计已抽奖次数
	self.nLastTime			= nil					--最后一次发倒计时的时间
	self.onLineTime			= nil					--再次上线的时间点
	self.offLineTime		= nil					--下线的时间
	self.nLeftTime			= initLeftTimes[self.times]	--倒计时剩余时间
	self.resultlist			= {}					--在线奖励的物品ID
	self.session_day		= getbaseday()			--这次奖励的天	
	self:onSessionInited()
	return self
end

--玩家上线加载数据库数据
function RewardSession:initFromDB(recordSet,resultSet)	
	local player = g_entityMgr:getPlayerByDBID(self.ownerID) 
	local level = player:getLevel()
	if not recordSet then
		if level < baseRewardLvl then 
			return nil
		else 
			return self:initDef()			
		end		 
	else
		if level >= baseRewardLvl and recordSet.sessionDay ~= getbaseday() then
			LuaDBAccess.DeleteRewardSession(self.ownerID)
			return self:initDef()				
		elseif level < baseRewardLvl then
			return nil	
		end
	end		

    self.nTimes     = recordSet.nTimes
    self.times      = recordSet.times
    self.offTimes   = recordSet.offTimes
    self.nLeftTime  = recordSet.nLeftTime
	self.session_day= recordSet.sessionDay
    self:setResult(resultSet)  
	self:onSessionInited()    
	return self
end

-- 奖励物品列表
function RewardSession:setResult(resultList)
	self.resultlist = resultList
end

-- 初始化并发数据到客户端
function RewardSession:onSessionInited()
	local player = g_entityMgr:getPlayerByDBID(self.ownerID) 
	local level = player:getLevel()
	local nDay = tonumber(os.date("%w",os.time()))
	local nTimes = self.nTimes
	local times = self.times
	local offTimes = self.offTimes  
	local nLeftTime = self.nLeftTime
	self.onLineTime = os.time(self.onLineTime)
	local event = Event.getEvent(OnlineRewardEvent_SC_LoadDate,nDay,nTimes,times,offTimes,nLeftTime,self.resultlist)
	g_eventMgr:fireRemoteEvent(event,player)
end

--取得随机数的接口（带有权重的随机数）
local sumWeight = 0		--所有物品的权重之和
function RewardSession.GetRewardRandom()
	sumWeight = 0	--把所有物品权重之后从新设为0
	for index = 1,16 do
		local itemID = OnlineRewardItem[nDay][index]	--奖励物品ID
		local nWeight = itemID.Probability				--物品的权重		
		sumWeight = sumWeight + nWeight					--16件物品的权重之和
	end
	local rand_num = math_random(1,sumWeight)			--1和权重之间取随机数
	transNum = OnlineRewardItem[nDay]					--中间变量，方便记录
	local numList = {}
	local num =  transNum[1].Probability
	numList[1] =num
	for index = 2 ,16 do
		num  = num + transNum[index].Probability
		numList [index] = num
	end	
	if rand_num >= 1 and rand_num <= transNum[1].Probability then
		return 1
	end
	for index = 1 ,table.size(numList) -1 do
		if rand_num > numList[index] and rand_num <= numList[index + 1] then
			numList = {}	--清空numList中的数据			
			return index + 1
		end
	end	
end

--更新几个抽奖的次数到数据库
function RewardSession:onUpdateSession2DB(param)
	if not param then return false end
	param['spName']		= "sp_UpdateRewardSession"
	param["sort"]		= "RoleID,times,nTimes,offTimes,nLeftTime,SessionDay"
	param["RoleID"]		= self.ownerID
	param["times"]		= self.times
	param["nTimes"]		= self.nTimes
	param["offTimes"]   = self.offTimes
	if self.times <=10 then		
		if self.nLastTime then
			self.nLeftTime	= self.nLastTime - self.offLineTime
		else
			self.nLeftTime	= self.onLineTime + self.nLeftTime - self.offLineTime
		end
		param["nLeftTime"]  = self.nLeftTime
	else
		self.nLeftTime = 0
		param["nLeftTime"]  = 0
	end
		param["SessionDay"] = getbaseday()
	return true
end

--更新抽的的奖励物品到数据库
function RewardSession:onUpdateResult2DB(param)
	if not param then return false end	
	local result = self.resultlist[self.DB_index]
	if self.DB_index > #(self.resultlist) or not result then return false end
	param['spName']			= "sp_UpdateRewardMaterial"
	param["sort"]			= "RoleID,ResultID,DrawTime"
	param["RoleID"]			= self.ownerID
	param["ResultID"]		= result
	param["DrawTime"]		= self.DB_index
	self.DB_index			= self.DB_index + 1
	return true
end

RewardSessionManager = class(nil,Singleton)
local sm = false

--初始化
function RewardSessionManager:__init()
	self.sessions = {}   
end

--退出清理
function RewardSessionManager:__release()
end

--留给数据库加载使用
function RewardSessionManager:createDBSession(player,recordSet,resultList)
	if not player then return nil end
	if not recordSet then
		return
	end

	local session = RewardSession(player):initFromDB(recordSet[1],resultList)
	if session then
		self:addSession(session)
	end    
	return session
end

--留给动态创建使用
function RewardSessionManager:createSession(player)
	if not player then return nil end
	local session = RewardSession(player):initDef()
	if session then		
		self:addSession(session)
		print "动态创建成功"
	else
		print "动态创建失败"
	end
	return session
end


function RewardSessionManager:addSession(session)
	if not session then return false end
	self.sessions[session.ownerID] = session
	print "添加session成功"
	return true
end

--获取玩家的session
function RewardSessionManager:getSession(player)
	if not player then return end
	if self.sessions[player:getDBID()] then
		return self.sessions[player:getDBID()]
	end 
	return nil
end

--清除session中的数据
function RewardSessionManager:removeSession(playerDBID)
	if not playerDBID then return false end
	local sessions = self.sessions
	sessions[playerDBID]  = nil
	return true
end

--更新session和session结果到数据库
--删除服务器中的session
function RewardSessionManager:onPlayerOffline(player)
	if not player then return false end
	local session = self.sessions[player:getDBID()]
	if session then
	   session.offLineTime = os.time()
	   local ret = LuaDBAccess.UpdateRewardSession(session)
	   self:removeSession(player:getDBID())
	end
	return false
end

function RewardSessionManager.getInstance()
	if not sm then
		sm = RewardSessionManager()

	end
	return sm
end