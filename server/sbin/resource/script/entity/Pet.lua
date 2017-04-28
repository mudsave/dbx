-- Pet.lua

require "entity.Attribute"
require "misc.PetConstant"

local function notice(str,...) print( ("Pet:%s"):format( str and str:format(...) or "" ) ) end
local function toDo(str,...) end

local flushPropBatch = flushPropBatch
local setPropValue	 = setPropValue
local attachEntity	 = attachEntity
local detachEntity	 = detachEntity

Pet = class(Entity)

function Pet:__init(owner)
	self.dbID		= 0						-- 宠物ID

	self.petType	= PetType.Wild			-- 宠物类型
	self.atType		= PetAttackType.Physics	-- 攻击类型
	self.psType		= PhaseType.Wind		-- 相性类型

	self.petStatus	= PetStatus.Rest		-- 宠物状态
	self.loyalty	= MaxPetLoyalty			-- 最大忠诚度
	self.life		= 0						-- 宠物寿命
	self.upLevel	= 0						-- 宠物的强化等级

	self.birthTime	= 0						-- 创建时间
	self.isnew		= true					-- 新建与否
	self.removed	= false					-- 删除与否
	self.visible	= false					-- 宠物可视性
	self.attrSet	= PetAttributeSet(self)	-- 宠物属性集合

	self:setOwner(owner)					-- 所有者ID
	self:__logic_init()
end

function Pet:__release()
	self:__logic_release()
	self:setVisible(false)

	self.attrSet:release()
	self.attrSet = nil
end

-- 所有者相关ID
function Pet:setOwner(owner)
	if owner then
		self.ownerID	= owner:getID()
		self.ownerDBID	= owner:getDBID()
	else
		self.ownerID	= nil
		self.ownerDBID	= nil
	end
end

function Pet:getOwnerID()
	return self.ownerID
end

function Pet:getOwnerDBID()
	return self.ownerDBID
end

-- 唯一标识
function Pet:setDBID(dbid)
	self.dbID = dbid
end

function Pet:getDBID()
	return self.dbID
end

-- 新创建与否
function Pet:isNew()
	return self.isnew
end

-- 是否要移除
function Pet:isRemoved()
	return self.removed
end

-- 属性集合
function Pet:getAttributeSet()
	return self.attrSet
end

function Pet:getAttribute(attrName)
	return rawget(self.attrSet,attrName)
end

function Pet:setAttrValue(attrName,value)
	self.attrSet:setAttrValue(attrName,value)
end

function Pet:addAttrValue(attrName,value)
	self.attrSet:addAttrValue(attrName,value)
end

function Pet:getAttrValue(attrName)
	return self.attrSet:getAttrValue(attrName)
end

-- 创建时间
function Pet:setBirth(uTime)
	self.birthTime = uTime
end

function Pet:getBirth()
	return self.birthTime
end

-- 配置ID
function Pet:setConfigID(configID)
	if self:initByConfig(configID) then
		self.configID = configID
		setPropValue(self._peer,PET_CONFIGID,configID)
		return true
	end
	return false
end

function Pet:getConfigID()
	return self.configID
end

-- 宠物类型
function Pet:setPetType(petType)
	self.petType = petType
	setPropValue(self._peer,PET_TYPE,petType)
end

function Pet:getPetType()
	return self.petType
end

-- 攻击类型
function Pet:setAttackType(atType)
	self.atType = atType
	setPropValue(self._peer,PET_ATTACK_TYPE,atType)
end

function Pet:getAttackType()
	return self.atType
end

-- 相性类型
function Pet:setPhaseType(psType)
	self.psType = psType
	setPropValue(self._peer,PET_PHASE_TYPE,psType)
end

function Pet:getPhaseType()
	return self.psType
end

-- 忠诚度
function Pet:setLoyalty(loyalty)
	self.loyalty = loyalty
	setPropValue(self._peer,PET_LOYALTY,loyalty)
end

function Pet:getLoyalty()
	return self.loyalty
end

-- 等级
function Pet:setLevel(level)
	self:setAttrValue(pet_lvl,level)
end

function Pet:getLevel()
	return self:getAttrValue(pet_lvl)
end

-- 出战等级
function Pet:getTakeLevel()
	return PetDB[self.configID].takeLevel
end

-- 状态
function Pet:setPetStatus(status)
	local prev = self.petStatus
	if prev ~= status then
		self.petStatus = status
		self:onStatusChanged(prev,status)
		setPropValue(self._peer,PET_STATUS,status)
	end
end

function Pet:getPetStatus()
	return self.petStatus
end

-- 宠物寿命
function Pet:setPetLife(life)
	self:setAttrValue(pet_life,life)
end

function Pet:getPetLife()
	return self:getAttrValue(pet_life)
end

-- 强化等级
function Pet:setUpLevel(upLevel)
	self.upLevel = upLevel
	setPropValue(self._peer,PET_UPLEVEL,upLevel)
end

function Pet:getUpLevel()
	return self.upLevel
end

-- 血量&蓝量
function Pet:setHP(hp)
	self:setAttrValue(pet_hp,hp)
end

function Pet:getHP()
	return self:getAttrValue(pet_hp)
end

function Pet:getMaxHP()
	return self:getAttrValue(pet_max_hp)
end

function Pet:setMP(mp)
	self:setAttrValue(pet_mp,mp)
end

function Pet:getMP()
	return self:getAttrValue(pet_mp)
end

function Pet:getMaxMP()
	return self:getAttrValue(pet_max_mp)
end

-- 恢复血量&蓝量
function Pet:fill()
	self:setHP(self:getMaxHP())
	self:setMP(self:getMaxMP())
end

-- 发送所有改动了的属性
function Pet:flushPropBatch(player)
	self.attrSet:updateAll()

	if not player then
		player = g_entityMgr:getPlayerByID(self:getOwnerID())
	end
	if not player then return end

	flushPropBatch(self:getPeer(),player:getID())
end

-- 绑定宠物到某个实体
function Pet:attachTo(player)
	self.attrSet:updateAll( true )
	attachEntity(self:getPeer(),player:getID())
end

-- 将宠物从某个实体上解除绑定
function Pet:detachFrom(player)
	detachEntity(self:getPeer(),player:getID())
end

-- 可视性管理
function Pet:setVisible(visible)
	visible = not not visible
	if visible == self.visible then
		return
	end

	local player = g_entityMgr:getPlayerByID(self:getOwnerID())

	if visible then
		if not player then
			notice("宠物 %s 没有绑定玩家",string.gbkToUtf8(self:getName()))
			return
		end

		local handler = player:getHandler(HandlerDef_Pet)
		-- 撤下之前显示的宠物
		local follow = g_entityMgr:getPet((handler:getFollowPetID()))
		if follow then
			local scene = follow:getScene()
			if scene then
				scene:detachEntity(follow)
			end
			follow.visible = false
		end

		-- 绑定实体到场景中
		local scene = player:getScene()
		local pos = TileUtils.getVaildTile(player,2)
		if scene and scene:attachEntity(self,pos.x,pos.y) then
			self.visible = true
			handler:setFollowPetID(self:getID())
			self:setMoveSpeed(player:getMoveSpeed())
		end
	else
		if player then
			player:getHandler(HandlerDef_Pet):setFollowPetID(false)
		end

		local scene = self:getScene()
		if scene then
			scene:detachEntity(self)
		end
		self.visible = false
	end
end

function Pet:isVisible()
	return self.visible
end

require "entity.PetLogic"

-- 躁动的年代,狂热的年代,迷惘的年代,沸反盈天,不肯止息
