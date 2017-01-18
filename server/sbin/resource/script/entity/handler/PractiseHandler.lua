--[[PractiseHandler.lua
描述:修行
]]

PractiseHandler = class()

function PractiseHandler:__init(owner)
	-- 持有者
	self.owner = owner
	-- 活动宝箱
	self.tabBox = {}
	-- 初始化宝箱状态
	self:initBoxData()
end

function PractiseHandler:__release()

end

function PractiseHandler:initBoxData()
	local tabBox = self.tabBox
	for i = 1,PractiseMaxBoxNum do
		tabBox[i] = PractiseBoxState.Close
	end
end

function PractiseHandler:savePracitseData()
	local tabBox = self.tabBox
	if  tabBox then
		local player = self.owner
		local roleDBID = player:getDBID()
		local data = {}
		data.practise = player:getPractise()
		data.storeXp = player:getStoreXp()
		data.practiseCount = player:getPractiseCount()
		data.BoxAFlage = tabBox[1]
		data.BoxBFlage = tabBox[2]
		data.BoxCFlage = tabBox[3]
		data.BoxDFlage = tabBox[4]
		data.BoxEFlage = tabBox[5]
		data.recordTime = os.time()
		LuaDBAccess.SavePractise(roleDBID,data)
	end
end

-- 更新单个宝箱
function PractiseHandler:setBoxState(index,boxState)
	local tabBox = self.tabBox
	if tabBox[index] then
		tabBox[index] = boxState
	else 
		print("Error! PractiseHandler: this box is not there")
	end
end

-- 更新所有的宝箱状态
function PractiseHandler:setTabBoxState(box)
	local tabBox = self.tabBox
	if box then
		tabBox[1] = box.boxAFlage
		tabBox[2] = box.boxBFlage
		tabBox[3] = box.boxCFlage
		tabBox[4] = box.boxDFlage
		tabBox[5] = box.boxEFlage
		-- 更新到客户端
		self:updateToClient()
	end
end

-- 宝箱更新到客户端
function PractiseHandler:updateToClient()
	local tabBox = self.tabBox
	if tabBox then
		local event = Event.getEvent(PractiseEvent_SC_updateBox,tabBox)
		g_eventMgr:fireRemoteEvent(event, self.owner)
	end
end