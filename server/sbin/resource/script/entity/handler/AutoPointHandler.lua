-- AutoPointHandler.lua
-- 自动点数分配

--[[
	2017/4/20 改动:
	1,数据库表改动
		表petattrsetting更名为petattrplan
		表roleattrsetting更名为roleattrplan
		函数sp_LoadRoleAttrSetting更名为sp_LoadRoleAttrPlan,同时更新sp_LoadAll
		函数sp_LoadPetAttrSetting更名为sp_LoadPetAttrPlan,同时更新sp_LoadPet
		函数sp_UpdateRoleAttrSetting更名为sp_UpdateRoleAttrPlan
		函数sp_UpdatePetAttrSetting更名为sp_UpdatePetPlan
]]
local math_floor		= math.floor
local math_min			= math.min
local rawget			= rawget
local rawset			= rawset
local MaxPhasePoint		= 35	-- 在一个相性上最多分配的点数

-- 发送加点方案时候的选项
local PlanNone = 1
local PlanAttr = 2
local PlanPhaz = 3
local PlanBoth = 4

-- 玩家属性方案
local PlayerAttrPlan ={
	[SchoolType.QYD] = { 4,0,1,0,0, },
	[SchoolType.JXS] = { 3,0,2,0,0, },
	[SchoolType.ZYM] = { 3,0,0,2,0, },
	[SchoolType.YXG] = { 0,4,0,1,0, },
	[SchoolType.TYD] = { 0,3,1,0,1, },
	[SchoolType.PLG] = { 0,3,1,0,1, },
}

-- 宠物属性分配方案
local PetAttrPlan = {
	[PetAttackType.Physics] = { 4,0,1,0,0, }, 
	[PetAttackType.Magic]	= { 0,4,1,0,0, },
}

-- 返回某一个实体的默认属性点分配方案
local function GetPreDefinePlan( entity )
	local entityType = entity:getEntityType()
	if entityType == eClsTypePlayer then
		return PlayerAttrPlan[ entity:getSchool() ]
	end
	if entityType == eClsTypePet then
		return PetAttrPlan[ entity:getAttackType() ]
	end
	print("不支持的实体类型调用GetPreDefinePlan",tostring(entity))
	return nil
end

-- 数据库存储过程中属性方案的字段名称,不要更改顺序
local DBAttrKey = { "str","int","sta","spi","dex" }
-- 数据库存储过程中相性方案的字段名称,同上
local DBPhazKey = { "one","two","three"}

-- 根据实体类型填充param
local function FillPlanSQLConfig( param,entity )
	local entityType = entity:getEntityType()
	if entityType == eClsTypePlayer then
		param['spName'] = 'sp_UpdateRoleAttrPlan'
		param['sort']	= 'id,autoattr,str,int,sta,spi,dex,autophaz,one,two,three'
		param['id']		= entity:getDBID()
		return DBAttrKey,DBPhazKey
	elseif entityType == eClsTypePet then
		param['spName']	= 'sp_UpdatePetAttrPlan'
		param['sort']	= 'id,autoattr,str,int,sta,spi,dex'
		param['id']		= entity:getDBID()
		return DBAttrKey
	else
		return
	end
end

-- 玩家属性点配置
local PlayerAttrPntConf = { 
	[1] = player_str_point,
	[2] = player_int_point,
	[3] = player_sta_point,
	[4] = player_spi_point,
	[5] = player_dex_point,

	base = player_attr_point,
}
-- 宠物属性点配置
local PetAttrPntConf = {
	[1] = pet_str_point,
	[2] = pet_int_point,
	[3] = pet_sta_point,
	[4] = pet_spi_point,
	[5] = pet_dex_point,

	base = pet_attr_point,
}

-- 获得实体的属性点配置
local function GetAttrPntConf( entity )
	local entityType = entity:getEntityType()
	if entityType == eClsTypePlayer then
		return PlayerAttrPntConf
	elseif entityType == eClsTypePet then
		return PetAttrPntConf
	else
		return nil
	end
end

-- 玩家的相性点配置,这个是一个代理,负责将所有转换成具体的属性名称
local PlayerPhazPntConf = {
	[1] = player_win_phase_point,
	[2] = player_thu_phase_point,
	[3] = player_ice_phase_point,
	[4] = player_soi_phase_point,
	[5] = player_fir_phase_point,
	[6] = player_poi_phase_point,

	base = player_phase_point,
}

-- 获得实体的相性点配置
local function GetPhazPntConf( entity )
	local entityType = entity:getEntityType()

	if entityType == eClsTypePlayer then
		return PlayerPhazPntConf
	end
	return nil
end

-- 方案是否是一样的
local function PlanEquals( alpha,delta )
	if not alpha or not delta then
		return false
	end
	for index = 1,5 do
		local a = rawget(alpha,index)
		if not a then return false end
		local b = rawget(delta,index)
		if not b then return false end

		if a ~= b then return false end
	end
	return true
end

-- 是否是一个有效的属性点分配方案
local function ValidAttrPlan( plan )
	if not plan then return false end
	local sum = 0
	for index = 1,5 do
		local value = rawget( plan,index )
		if not value then return false end
		if value < 0 then return false end
		sum = sum + value
	end
	return sum < 6
end

-- 确保是有效的相性索引
local function ValidatePhazIndex( index )
	if index > 0 and index < 7 then
		return index
	end
	return nil
end

-- 是否是一个有效的相性点分配方案
local function ValidPhazPlan( plan )
	if not plan then return false end
	local a = ValidatePhazIndex( rawget( plan,1 ) )
	if not a then return false end
	local b = ValidatePhazIndex( rawget( plan,2 ) )
	if not b then return false end
	local c = ValidatePhazIndex( rawget( plan,3 ) )
	if not c then return false end

	return a ~= b and a ~= c and b ~= c
end

AutoPointHandler = class()

AutoPointHandler.None = PlanNone
AutoPointHandler.Attr = PlanAttr
AutoPointHandler.Phaz = PlanPhaz
AutoPointHandler.Both = PlanBoth

function AutoPointHandler:__init()
	self.attrPlan = { 0,0,0,0,0,auto = false }	-- 属性点分配方案
	self.phazPlan = { 0,0,0,auto = false }	-- 相性点分配方案
	self.needCommit	= false
end

function AutoPointHandler:__release()
end

function AutoPointHandler:markCommit()
	if not self.needCommit then
		self.needCommit = true
	end
end

-- 设置属性点分配方案
function AutoPointHandler:setAttrPlan( param,fromDB )
	if not ValidAttrPlan( param ) then
		print( "不是一个有效的属性点分配方案",toString( param ) )
		return false
	end

	local plan = self.attrPlan
	for index = 1,5 do
		rawset( plan,index,rawget( param,index ) )
	end
	plan.auto = param.auto or false
	if not fromDB then self:markCommit() end
	return true
end

-- 设置相性点分配方案
function AutoPointHandler:setPhazPlan( param,fromDB )
	if not ValidPhazPlan( param ) then
		print("不是一个有效的相性点分配方案",toString( param ))
		return
	end
	local plan = self.phazPlan
	for index = 1,3 do
		rawset( plan,index,rawget( param,index) )
	end
	plan.auto = param.auto or false
	if not fromDB then self:markCommit() end
	return true
end

-- 共用的一个代理数组,免得重复创建
local common = {0,0,0,0,0,auto = false}
-- 加载数据库记录
function AutoPointHandler:init( entity,records )
	local record = records and records[1]
	-- 数据库记录是否有效
	local valid = true
	if record then
		for index,key in ipairs( DBAttrKey ) do
			local value = rawget( record,key )
			if not value then valid = false	break end
			rawset( common,index,value )
		end
	else
		valid = false
	end
	print("加点方案",toString( record ))

	if valid then
		common.auto = rawget( record,'autoAttr' ) == 1
		if not self:setAttrPlan( common,true ) then
			print("加载属性加点方案失败",toString(record),entity:getDBID())
		end
	else
		print "使用默认的属性点分配方案"
		self:setAttrPlan( GetPreDefinePlan( entity),true )
	end

	valid = true
	if record then
		for index,key in ipairs( DBPhazKey ) do
			local value = rawget( record,key )
			if not value then valid = false break end
			rawset( common,index,value )
		end
	else
		valid = false 
	end

	if valid then
		common.auto = rawget( record,'autoPhaz' ) == 1
		if not self:setPhazPlan( common,true ) then
			print("设置相性加点方案失败",toString(record),entity:getDBID())
		end
	end
end

-- 离线数据库记录
function AutoPointHandler:onSave( param,entity )
	if not self.needCommit then
		-- print( ("%s不需要提交加点方案"):format( string.gbkToUtf8(entity:getName()) ) )
		return false
	end

	local attrKey,phazKey= FillPlanSQLConfig( param,entity )
	if not attrKey and not phazKey then
		-- print( ("%s没有加点方案配置"):format( string.gbkToUtf8(entity:getName()) ) )
		return false
	end

	if attrKey then
		local plan = self.attrPlan
		for index,key in ipairs( attrKey ) do
			param[key] = rawget( plan,index )
		end
		param[ 'autoattr' ] = plan.auto and 1 or 0
	end

	if phazKey then
		local plan = self.phazPlan
		for index,key in ipairs( phazKey ) do
			param[key] = rawget( plan,index )
		end
		param[ 'autophaz' ] = plan.auto and 1 or 0
	end

	self.needCommit = false
	return true	-- 目前不提交
end

-- 自动加点方案生效
function AutoPointHandler:effect( entity,choose )
	local effective = false	-- 属性加点方案是否生效
	local attrSet = entity:getAttributeSet()	-- 属性集合

	-- 分配属性点
	local plan,conf = self.attrPlan,GetAttrPntConf( entity )
	while (choose == PlanAttr or choose == PlanBoth) and conf and plan.auto do
		local free = attrSet:getAttrValue( conf.base )	-- 自由属性点
		if free < 1 then print "实体没有多余的自由属性点" break end

		local used = 0
		local mindex = 1
		local mvalue = rawget( plan,1 )

		for index = 1,5 do
			-- 没有剩余属性点
			if used >= free then break end
			-- 在某一项上需要增加的属性点数量
			local value = math_floor( free * rawget( plan,index ) / 5)
			-- 属性点属性加值
			if value > 0 then
				used = used + value
				attrSet:addAttrValue( conf[index], value )
			end
			-- 找出最大的属性项
			if mvalue < value then
				mvalue = value
				mindex = index
			end
		end

		-- 还有剩余的属性点
		if free - used > 0 then
			-- 把剩余点数加到权最大的属性上
			attrSet:addAttrValue( conf[index],free - used )
		end
		-- 分配完就没有自由属性点了 
		attrSet:setAttrValue( conf.base,0 )
		effective = true
		break
	end

	-- 分配相性点
	plan,conf = self.phazPlan,GetPhazPntConf( entity )
	while ( choose == PlanPhaz or choose == PlanBoth ) and conf and plan.auto do
		local free = attrSet:getAttrValue( conf.base )
		if free < 1 then break end
		local used = 0

		for index = 1,3 do
			if used >= free then break end

			local attrName = rawget( conf,rawget( plan,index ) )
			if attrName then
				-- 在一个相性点上的加值不能超过 1,自由相性点数,2,最大相性点数
				local addValue = math_min( free - used,MaxPhasePoint - attrSet:getAttrValue( attrName ) )
				if addValue > 0 then
					used = used + addValue
					attrSet:addAttrValue( attrName,addValue )
				end
			end
		end
		if used > 0 then
			attrSet:setAttrValue( conf.base,free - used)
			effective = true
		end
		break
	end

	return effective
end

-- 发送给客户端
function AutoPointHandler:sendToClient( entity,player,plan )
	if not player then
		print "自动加点方案发送,没有指定发送给谁"
		return
	end
	if not plan then plan = PlanAttr end
	local event
	if plan == PlanBoth then
		event = Event.getEvent( AutoPointEvent_SC_PlanConfirmed,entity:getID(),self.attrPlan,self.phazPlan )
	elseif plan == PlanAttr then
		event = Event.getEvent( AutoPointEvent_SC_PlanConfirmed,entity:getID(),self.attrPlan)
	elseif plan == PlanPhaz then
		event = Event.getEvent( AutoPointEvent_SC_PlanConfirmed,entity:getID(),nil,self.phazPlan )
	end
	if event then
		g_eventMgr:fireRemoteEvent( event,player )
	end
end
