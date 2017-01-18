--[[AutoPointHandler.lua
	自动点数分配
]]

local math_floor		= math.floor
local math_min			= math.min
local table_concat		= table.concat
local MaxPhasePoint		= 35	--在一个相性上最多分配的点数
local defaultPoint		= 0		-- 添加一个默认的自动加点的id

-- 标记存数据库的数据
local flag = {
	[eClsTypePlayer] = true,
	[eClsTypePet]	 = true,
}
-- 系统分配方案
local PreDefineDistributions = {
	[eClsTypePlayer] ={
		[SchoolType.QYD] = {
			4,0,1,0,0,
		},
		[SchoolType.JXS] = {
			3,0,2,0,0,
		},
		[SchoolType.ZYM] = {
			3,0,0,2,0,
		},
		[SchoolType.YXG] = {
			0,4,0,1,0,
		},
		[SchoolType.TYD] = {
			0,3,1,0,1,
		},
		[SchoolType.PLG] = {
			0,3,1,0,1,
		},
	},
	[eClsTypePet] = {
		[PetAttackType.Physics] = {
			4,0,1,0,0,
		}, 
		[PetAttackType.Magic]	= {
			0,4,1,0,0,
		},
	},
	[defaultPoint] = {
		0,0,0,0,0,
	},
}

AutoPointHandler = class()

local EntityConfig = {
	[eClsTypePlayer] = {
		basePointAttr	= player_str_point,			--第一个属性加点属性名称
		freeAttrPoint	= player_attr_point,		--可分配属性点属性名称
		freePhasePoint	= player_phase_point,		--可分配相性点属性名称
		phaseAttrStart	= player_win_phase_point,	--加值相性属性范围开始
		phaseAttrEnd	= player_poi_phase_point,	--加值相性属性范围结尾
	},
	[eClsTypePet] = {
		basePointAttr	= pet_str_point,
		freeAttrPoint	= pet_attr_point,
	}
}

-- 数据库记录的武力、智力、根骨等属性的名称
local DBAttrNames = {
	"str","int","sta","spi","dex"
}

-- 数据库记录中的三个相性的字段
local DBPhaseNames = {
	"phaseOne","phaseTwo","phaseThree"
}

-- 默认相性点分配顺序
local DefOrder = {0,0,0}

function AutoPointHandler:__init(entity)
	self.entity			= entity								-- 实体
	self.auto_attr		= false									-- 是否自动分配属性
	self.auto_phase		= false									-- 是否自动分配相性
	self.order			= DefOrder								-- 相性属性分配顺序
	self.planID			= self.entity:getEntityType()			-- 属性点分配方案
	print("--ININT----self.planID",self.planID)
	self.distribution	= nil									-- 每个属性的分配比例，总值不能超过五
end

-- 从数据库中加载
function AutoPointHandler:loadDB(attrRecord)

	local setting = attrRecord and attrRecord[1]
	if not setting then
		return false	--没有属性自动分配记录
	end

	local planID = setting.planID	-- 记录为玩家还是宠物或者是自定义
	local distribution
	if flag[planID] then
		self.planID = planID
	else
		distribution = {0,0,0,0,0}
		for index,dbAttrName in ipairs(DBAttrNames) do
			distribution[index] = setting[dbAttrName] or 0
		end
		planID = defaultPoint
	end

	if distribution then
		self.distribution = distribution
		self.planID = planID
	end

	local order = {0,0,0}
	for index,name in ipairs(DBPhaseNames) do
		order[index] = setting[name] or 0
	end
	self.order = order

	self.auto_attr	= (setting["autoAttr"] == 1)
	self.auto_phase	= (setting["autoPhase"] == 1)
end

-- 保存到数据库
function AutoPointHandler:onSave(param)
	local entity	= self.entity
	local eType		= entity:getEntityType()
	if eClsTypePlayer == eType then
		param["spName"]		= "sp_UpdateRoleAttrSetting"
		param["sort"]		= ("rid,autoattr,%s,plan,autophase,%s"):format(table_concat(DBAttrNames,","),table_concat(DBPhaseNames,","))
		param["rid"]		= entity:getDBID()
		param["autoattr"]	= self:isAutoAttr() and 1 or 0
		param["autophase"]	= self:isAutoPhase() and 1 or 0
		param["plan"]		= self:getPlanID()

		local distribution = self.distribution
		if not distribution then return end
		for index,name in ipairs(DBAttrNames) do
			param[name] = distribution[index]
		end

		local order = self.order
		for index,name in ipairs(DBPhaseNames) do
			param[name] = order[index]
		end
		return true
	elseif eClsTypePet == eType then
		param["spName"]		= "sp_UpdatePetAttrSetting"
		param["sort"]		= ("pid,autoattr,%s,plan"):format(table_concat(DBAttrNames,","))
		param["pid"]		= entity:getDBID()
		param["autoattr"]	= self:isAutoAttr() and 1 or 0
		param["plan"]		= self:getPlanID()

		local distribution = self.distribution
		if not distribution then return end
		for index,name in ipairs(DBAttrNames) do
			param[name] = distribution[index]
		end
		return true
	end
	return false
end

-- 是否自动分配属性
function AutoPointHandler:isAutoAttr()
	return self.auto_attr
end

function AutoPointHandler:setAutoAttr(b)
	self.auto_attr = not not b
end

-- 是否自动分配相性
function AutoPointHandler:isAutoPhase()
	return self.auto_phase
end

function AutoPointHandler:setAutoPhase(b)
	self.auto_phase = not not b
end

function AutoPointHandler:getPlanID()
	return self.planID
end

-- 分配属性
function AutoPointHandler:distibuteAttrPoints()
	local entity = self.entity
	local config = EntityConfig[entity:getEntityType()]
	if not config then return end

	local basePointAttr = config.basePointAttr	--第一个加点属性的属性名称<<属性名称是数字
	local freePointAttr = config.freeAttrPoint	--自由属性点的属性名称

	local totalPoint = entity:getAttrValue(freePointAttr)
	local freePoint = totalPoint	--剩余属性点
	local _index,_value = 1,0		--最大值的索引和最大值
	local allocted = false			--属性点是否已经分配
	local distribution = self.distribution
	for index = 1,5 do
		local value = distribution[index]

		if _value < value then
			_index,_value = index,value
		end

		local point = math_floor(totalPoint * value / 5)
		if point > 0 then
			entity:addAttrValue(basePointAttr + index - 1,point)
			freePoint = freePoint - point
			allocted = true
		end
	end
	if freePoint > 0 then	--将剩余的点数加到最多的属性上
		entity:addAttrValue(basePointAttr + _index - 1,freePoint)
		allocted = true
	end

	if allocted then		-- 没有剩余属性点了
		entity:setAttrValue(freePointAttr,0)
		self:onAttrAllocated()
	end

	return allocted
end

-- 分配相性
function AutoPointHandler:distibutePhasePoints()

	local entity = self.entity
	local config = EntityConfig[entity:getEntityType()]
	local pntAttr = config and config.freePhasePoint
	if not pntAttr then return end

	local freePoint = entity:getAttrValue(pntAttr)
	if freePoint < 1 then
		print "没有点数"
		return
	end
	local half_all = entity:getLevel() - 19		--一半的所有点数，在一个属性上不能分配超过一半所有相性点
	local allocted = false
	local order = self.order
	for index = 1,3 do
		local attrName = order[index]
		if attrName and attrName > 0 then
			local points = entity:getAttrValue(attrName)
			local point2add = math_min(
				freePoint,MaxPhasePoint - points,half_all - points
			)
			if point2add > 0 then
				entity:addAttrValue(attrName,point2add)
				freePoint = freePoint - point2add
				allocted = true
			end
			if freePoint < 1 then
				break
			end
		end
	end
	if allocted then
		entity:setAttrValue(pntAttr,freePoint)
		self:onPhaseAllocated()
	end
	return allocted
end

--设置属性分配
--分配的属性是一个数组{0,0,0,0,0} = {武力,智力,...}
function AutoPointHandler:setDistribution(planID,data)
	local distribution
	if planID and planID ~= 0 then
		if planID == eClsTypePlayer then
			distribution = PreDefineDistributions[planID][self.entity:getSchool()]
		elseif planID == eClsTypePet then
			local attackType = self.entity:getAttackType()
			distribution = PreDefineDistributions[planID][attackType]
		end
	elseif type(data) == 'table' then
		local total = 0
		distribution = {0,0,0,0,0}
		for index = 1,5 do
			local value = data[index]
			total = total + value
			distribution[index] = value
		end
		if total ~= 5 then
			distribution = nil
		end
	end
	if not distribution then
		return false
	end
	self.planID = planID
	self.distribution = distribution
	return true
end

--设置相性分配
function AutoPointHandler:setOrder(order)
	local etype = self.entity:getEntityType()
	if etype ~= eLogicPlayer or type(order) ~= "table" then
		return false
	end
	local config	= EntityConfig[etype]
	local from		= config.phaseAttrStart
	local to		= config.phaseAttrEnd
	local t = {0,0,0}
	local len = 1
	for index = 1,3 do
		local attrName = order[index]
		if attrName > 0 then
			if attrName < from or attrName > to then
				return false
			end
			t[len] = attrName
			len = len + 1
		end
	end
	self.order = t
	return true
end

--发送属性点分配方案
function AutoPointHandler:sendDistribution(player)
	local entity = self.entity   
	local eType = entity:getEntityType()
	local planID = self.planID or eType
	local event

	if flag[planID] then
		event = Event.getEvent(AutoPointEvent_SC_DistributionComfirmed,entity:getID(),planID,self:isAutoAttr())
	else
		event = Event.getEvent(AutoPointEvent_SC_DistributionComfirmed,entity:getID(),self.distribution,self:isAutoAttr())
	end
	g_eventMgr:fireRemoteEvent(event, player)

	if not self.distribution then
		if eType == eClsTypePlayer then
			self.distribution = PreDefineDistributions[eClsTypePlayer][entity:getSchool()]
		elseif eType == eClsTypePet then
			self.distribution = PreDefineDistributions[eClsTypePet][entity:getAttackType()]
		end
	end
end

--发送相性点分配顺序
function AutoPointHandler:sendOrder(player)
	local entity = self.entity
	if eClsTypePlayer == entity:getEntityType() then
		local event_order = Event.getEvent(AutoPointEvent_SC_OrderComfirmed,entity:getID(),self.order,self:isAutoPhase())
		g_eventMgr:fireRemoteEvent(event_order, player)
	end
end

--发送到客户端
function AutoPointHandler:sendToClient(player)
	if not player then
		local entity = self.entity
		local eType = entity:getEntityType()
		if eType == eClsTypePlayer then
			player = entity
		elseif eType == eClsTypePet then
			player = g_entityMgr:getPlayerByID(entity:getOwnerID())
		else
			--对其他的可以配置自动分配方案的实体的支持
		end
	end
	if not player then return false end
	self:sendDistribution(player)
	self:sendOrder(player)
end

--属性分配完毕后的操作
function AutoPointHandler:onAttrAllocated()
	local entity = self.entity
	local eType = entity:getEntityType()
	if eType == eClsTypePet then
		entity:flushPropBatch(g_entityMgr:getPlayerByID(entity:getOwnerID()))
	elseif eType == eClsTypePlayer then
		entity:flushPropBatch()
	end
end

--相性点分配完毕后的操作
function AutoPointHandler:onPhaseAllocated()
	local entity = self.entity
	if entity:getEntityType() == eClsTypePlayer then
		entity:flushPropBatch()
	end
end
