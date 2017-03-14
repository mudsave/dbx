--[[BuffHandler.lua
描述：
	实体的Buffhandler
--]]

BuffHandler = class(nil, Timer)

function BuffHandler:__init(entity)
	-- buff的所有者
	self.owner = entity
	-- buff的记录
	self.buffList = {}
	--上一次buff记录
	self.oldBuffList = {}
	-- 开启1分钟的定时器
	self.checkBuffTimerID = g_timerMgr:regTimer(self, 1000*60, 1000*60, "计时buff")
	--to-do 定时将用户的buff 存入数据库
end

function BuffHandler:__release()
	self.owner = nil
	self.buffList = nil
	self.oldBuffList = nil
	-- 删除定时器
	g_timerMgr:unRegTimer(self.checkBuffTimerID)
end

-- 定时器
function BuffHandler:update()
	for idx,iter in pairs(self.buffList or {}) do
		if not iter:calcPeriod() then
			self.buffList[idx] = nil
		end
	end
end

-- 增加种对应的增加函数
local buffAddKindMap =
{
	[FightOutBuffType.hp_pool]			= {"addHpPool"},
	[FightOutBuffType.mp_pool]			= {"addMpPool"},
	[FightOutBuffType.exorcism]			= {"addExorcism"},
	[FightOutBuffType.rein_beast]		= {"addReinBeast"},
	[FightOutBuffType.xp_boost]			= {"addXpBoost"},
	[FightOutBuffType.god_bless]		= {"addGodBless"},
	[FightOutBuffType.tarns_card]		= {"addTransCard"},
	[FightOutBuffType.enforced_pk]		= {"addEnforcedPk"},
	[FightOutBuffType.protect_pk]		= {"addProtectPk"},
	[FightOutBuffType.evil]				= {"addEvil"},
	[FightOutBuffType.loyalty_pool]		= {"addLoyaltyPool"},
	[FightOutBuffType.fight_count]		= {"addFightCount"},
	[FightOutBuffType.full_monster]		= {"addFullMonster"},
}

-- 增加一个buff
function BuffHandler:addBuff(buff)
	-- 找到并加入成功
	local addFunName = buffAddKindMap[buff:getType()]
	if self[addFunName[1]](self,buff) then
		return true
	end
	return false
end

-- 增加变身卡
function BuffHandler:addTransCard(buff)
	local pos = FightOutBuffPos.tarns_card
	local transCard = self.buffList[pos]
	if transCard then
		if transCard:getID() == buff:getID() then
			return self:addOrUpdateBuff(buff, pos)
		else
			transCard:stop()
			release(transCard)
			self.buffList[pos] = buff
			buff:start()
		end
	else
		self.buffList[pos] = buff
		buff:start()
	end
end

-- 增加血池
function BuffHandler:addHpPool(buff)
	local pos = FightOutBuffPos.hp_pool
	return self:addOrUpdateBuff(buff, pos)
end

-- 增加蓝池
function BuffHandler:addMpPool(buff)
	local pos = FightOutBuffPos.mp_pool
	return self:addOrUpdateBuff(buff, pos)
end

-- 增加驱魔香
function BuffHandler:addExorcism(buff)
	local pos = FightOutBuffPos.exorcism
	return self:addOrUpdateBuff(buff, pos)
end

-- 增加御兽铃
function BuffHandler:addReinBeast(buff)
	local pos = FightOutBuffPos.rein_beast
	return self:addOrUpdateBuff(buff, pos)
end

-- 增加护心丹
function BuffHandler:addGodBless(buff)
	local pos = FightOutBuffPos.god_bless
	return self:addOrUpdateBuff(buff, pos)
end

-- 增加强制pk
function BuffHandler:addEnforcedPk(buff)
	local pos = FightOutBuffPos.enforced_pk
	return self:addOrReplace(buff, pos)
end

-- 增加保护pk
function BuffHandler:addProtectPk(buff)
	local pos = FightOutBuffPos.protect_pk
	return self:addOrReplace(buff, pos)
end

-- 恶贯满盈
function BuffHandler:addEvil(buff)
	local pos = FightOutBuffPos.evil
	return self:addWithoutUpdate(buff, pos)
end

-- 宠物忠诚池
function BuffHandler:addLoyaltyPool(buff)
	local pos = FightOutBuffPos.loyalty_pool
	return self:addOrUpdateBuff(buff, pos)
end

-- 增加多倍经验丹
function BuffHandler:addXpBoost(buff)
	local pos = FightOutBuffPos.xp_boost
		local xpBoot = self.buffList[pos]
		if xpBoot then
			if xpBoot:getXpBoostValue() < buff:getXpBoostValue() then
				xpBoot:stop()
				release(xpBoot)
				self.buffList[pos] = buff
				buff:start()
				return true
			elseif xpBoot:getXpBoostValue() == buff:getXpBoostValue() then
				return self:addOrUpdateBuff(buff, pos)
			else
				return false
			end
		else
			return self:addOrUpdateBuff(buff, pos)
	end
end

-- 增加战斗计数buff
function BuffHandler:addFightCount(buff)
	local pos = FightOutBuffPos.fight_count
	return self:addOrUpdateBuff(buff,pos)
end

function BuffHandler:addFullMonster(buff)
	local pos = FightOutBuffPos.full_monster
	return self:addOrUpdateBuff(buff,pos)
end

-- 添加或者更新buff
function BuffHandler:addOrUpdateBuff(buff, pos)
	local existBuff = self.buffList[pos]
	if existBuff then
		local curlastValue = existBuff:getLastValue() + buff:getLastValue()
		existBuff:setLastValue(curlastValue)
	else
		self.buffList[pos] = buff
		buff:start()
	end
	return true
end

-- 添加buff
function BuffHandler:addWithoutUpdate(buff, pos)
	local existBuff = self.buffList[pos]
	if not existBuff then
		self.buffList[pos] = buff
		buff:start()
		return true
	end
	return false
end

-- 更新替代
function BuffHandler:addOrReplace(buff, pos)
	local existBuff = self.buffList[pos]
	if existBuff then
		existBuff:stop()
		self.buffList[pos] = buff
		buff:start()
	else
		self.buffList[pos] = buff
		buff:start()
	end
	return true
end

-- 是否存在血池
function BuffHandler:getHPPool()
	local hpPool = self.buffList[FightOutBuffPos.hp_pool]
	if hpPool then
		return true,hpPool:getLastValue()
	end
	return false
end

-- 是否存在蓝池
function BuffHandler:getMPPool()
	local mpPool = self.buffList[FightOutBuffPos.mp_pool]
	if mpPool then
		return true,mpPool:getLastValue()
	end
	return false
end

-- 驱魔香
function BuffHandler:getExorcism()
	local exorcism = self.buffList[FightOutBuffPos.exorcism]
	if exorcism then
		return true,exorcism:getLastValue()
	end
	return false
end

-- 御兽铃
function BuffHandler:getReinBeast()
	local reinBeast = self.buffList[FightOutBuffPos.rein_beast]
	if reinBeast then
		return true,reinBeast:getLastValue()
	end
	return false
end

-- 多倍经验丹
function BuffHandler:getXpBoost()
	local XpBoot = self.buffList[FightOutBuffPos.xp_boost]
	if XpBoot then
		if XpBoot:getFreeze() then
			return false
		end
		return true,XpBoot:getXpBoostValue()
	end
	return false
end

-- 护心丹
function BuffHandler:getGodBless()
	local godBless = self.buffList[FightOutBuffPos.god_bless]
	if godBless then
		return true,godBless:getLastValue()
	end
	return false
end

-- 使用护心丹
function BuffHandler:useGodBless()
	local godBless = self.buffList[FightOutBuffPos.god_bless]
	if not godBless then
		return false
	end
	local curLastValue = godBless:getLastValue() - 1
	godBless:setLastValue(curLastValue)

	local maxHP = self.owner:getAttrValue(player_max_hp)
	self.owner:setHP(maxHP)
	local maxMP = self.owner:getAttrValue(player_max_mp)
	self.owner:setMP(maxMP)
	return true
end

-- 强制pk
function BuffHandler:getEnforcedPk()
	local enforcedPk =self.buffList[FightOutBuffPos.enforced_pk]
	if enforcedPk then
		return true,enforcedPk:getLastValue()
	end
	return false
end

-- 使用强制pk
function BuffHandler:useEnforcedPk()
	local pos = FightOutBuffPos.god_bless
	if self:getEnforcedPK() then
		self.buffList[pos]:stop()
		self.buffList[pos] = nil
		return true
	end
	return false
end

-- 变身卡
function BuffHandler:getTransCard()
	local transCard = self.buffList[FightOutBuffPos.tarns_card]
	if transCard then
		return true,transCard:getLastValue()
	end
	return false
end

-- 忠诚池
function BuffHandler:getLoyaltyPool()
	local loyaltyPool = self.buffList[FightOutBuffPos.loyalty_pool]
	if loyaltyPool then
		return true,loyaltyPool:getLastValue()
	end
	return false
end

-- 是否存在战斗计数
function BuffHandler:getFightCount()
	local fightCount = self.buffList[FightOutBuffPos.fight_count]
	if fightCount then
		return true,fightCount:getLastValue()
	end
	return false
end

function BuffHandler:getFullMonster()
	local fullMonster = self.buffList[FightOutBuffPos.full_monster]
	if fullMonster then
		return true, fullMonster:getLastValue()
	end
	return false
end

--冰冻双倍经验
function BuffHandler:freezeBuff()
	if self:getXpBoost() then
		return false
	end
	local buff = self.buffList[FightOutBuffPos.xp_boost]
	buff:setFreeze(true)
end

--取消冰冻双倍经验
function BuffHandler:cancelFreezeBuff(player)
	if self:getXpBoost() then
		return false
	end
	local buff = self.buffList[FightOutBuffPos.xp_boost]
	if buff then
		buff:setFreeze(false)
	end
end


-- 恢复血
function BuffHandler:useHpPool(role)
	local buff = nil
	if instanceof(role,Player) or instanceof(role,Pet) then
		buff = self.buffList[FightOutBuffPos.hp_pool]
	else
		return false
	end
	local gap = role:getMaxHP() - role:getHP()
	if buff and gap > 0 then
		local lastValue = buff:getLastValue()
		if lastValue > gap then
			role:setHP(role:getMaxHP())
			buff:setLastValue(lastValue - gap)
		else
			role:setHP(role:getHP() + lastValue)
			buff:setLastValue(0)
		end
		buff:calcPeriod()
		return true
	end
	return false
end

-- 恢复蓝
function BuffHandler:useMpPool(role)
	local buff = nil
	if instanceof(role, Player) or instanceof(role,Pet) then
		buff = self.buffList[FightOutBuffPos.mp_pool]
	else
		return false
	end
	local gap = role:getMaxMP() - role:getMP()
	if buff and gap > 0 then
		local lastValue = buff:getLastValue()
		if lastValue > gap then
			role:setMP(role:getMaxMP())
			buff:setLastValue(lastValue - gap)
		else
			role:setMP(role:getMP() + lastValue)
			buff:setLastValue(0)
		end
		buff:calcPeriod()
		return true
	end
	return false
end

-- 宠物忠诚池
function BuffHandler:useLoyaltyPool(role)
	local buff = nil
	if instanceof(role, Pet) then
		buff = self.buffList[FightOutBuffPos.loyalty_pool]
	else
		return false
	end
	local gap = MaxPetLoyalty - role:getLoyalty()
	if buff and gap > 0 then
		local lastValue = buff:getLastValue()
		if lastValue > gap then
			role:setLoyalty(MaxPetLoyalty)
			buff:setLastValue(lastValue - gap)
		else
			role:setLoyalty(role:getLoyalty() + lastValue)
			buff:setLastValue(0)
		end
		buff:calcPeriod()
	end
	return true
end


-- 从数据库中加载
function BuffHandler:loadBuff(recordList)
	self.oldBuffList = recordList
	local event = Event.getEvent(BuffEvents_SC_LoadBuff, self.owner:getID(), {})
	g_eventMgr:fireRemoteEvent(event, self.owner)
	for _,iter in pairs(recordList) do
		--print ("  $$  loadBuff", toString(iter))
		if iter.freeze == 1 then
			local buff = Buff(iter.buffID, self.owner)
			buff.freeze = true
			buff.lastValue = iter.buffStayValue
			self:addBuff(buff)
		else
			if FightOutBuffDB[iter.buffID].last_type == BUFF_LAST_TYPE.time then
				local diffTime = math.floor( os.difftime(os.time(), iter.lastLogin) / 60 )
				if diffTime < iter.buffStayValue then
					local buff = Buff(iter.buffID, self.owner)
					buff.lastValue = iter.buffStayValue - diffTime
					self:addBuff(buff)
				end
			end
			if FightOutBuffDB[iter.buffID].last_type == BUFF_LAST_TYPE.num then
				local buff = Buff(iter.buffID, self.owner)
				buff.lastValue = iter.buffStayValue
				self:addBuff(buff)
			end
		end
	end
end
	
-- 存储到数据库
function BuffHandler:saveBuff()
	local dbid = self.owner:getDBID()
	--判断原buff是否存在
	if next(self.oldBuffList) ~= nil then 
		LuaDBAccess.deletePlayerBuff(dbid)
	end 	
	for idx,iter in pairs(self.buffList) do
		local isFreeze = iter.freeze and 1 or 0
		LuaDBAccess.updatePlayerBuff(dbid, iter.buffID, iter.lastValue, isFreeze)
	end
end

--没找到返回nil,找到返回id
function BuffHandler:findBuffByID(buffID)
	for idx,iter in pairs(self.buffList) do
		if iter.buffID == buffID then
			return buffID
		end
	end
	return nil
end

-- 通过种类查找
function BuffHandler:findBuffByType(type)
	for idx,iter in pairs(self.buffList) do
		if iter.type == type then
			return iter.buff_id
		end
	end
	return nil
end

--要根据物品标记消除buff
function BuffHandler:cancelBuffByFlag(buffID)
	for idx,iter in pairs(self.buffList or {}) do
		if buffID == iter.buffID then
			if iter.db.can_cancel == true then
				iter:stop()
				self.buffList[idx] = nil
				return true
			end
		end
	end
	return false
end

--忽略物品标记可以消除buff
function BuffHandler:cancelBuff(buffID)
	for idx,iter in pairs(self.buffList or {}) do
		if(buffID == iter.buffID) then
			iter:stop()
			self.buffList[idx] = nil
			return true
		end
	end
	return false
end

-- 清除所有的buff
function BuffHandler:calcelAllBuff()
	for idx,iter in pairs(self.buffList or {}) do
		iter:stop()
		self.buffList[idx] = nil
	end
end

function BuffHandler:addBuffByID(buffID, desEntity)
	if FightOutBuffDB[buffID] then
		return false
	end
	buff = Buff(buffID,desEntity)
	self:addBuff(buff)
	return true
end
