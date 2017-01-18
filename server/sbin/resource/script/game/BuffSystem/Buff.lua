--[[Buff.lua
描述:
	Buff类
]]

Buff = class()

function Buff:__init(buffID, desEntity)
	-- buff的ID
	self.buffID = buffID
	-- buff的所有者
	self.owner = desEntity
	-- 对配置的读取
	self.db = FightOutBuffDB[buffID]
	-- buff的种类
	self.type = self.db.type
	-- 持续种类
	self.lastType = self.db.last_type
	-- 持续值
	self.lastValue = self.db.last_num
	-- 是否冻结
	self.freeze = false
	-- 增加特殊化处理 因为所有的buff实际上都是加在人物身上 所以实际的作用对象不明确 和
	-- 作用的数量不明
	self:addEffect()
end

-- 得到ID
function Buff:getID()
	return self.buffID
end

-- 得到buff的种类
function Buff:getType()
	return self.type
end

-- 得到buff的持续值
function Buff:getLastValue()
	return self.lastValue
end

function Buff:__release()
	self.buffID = nil
	self.owner = nil
	self.freeze = nil
	self.lastType = nil
	self.lastValue = nil
end

-- 对通知客户端的管理
function Buff:toDoNotifyClient(infoType)
	local isFreeze = self.freeze and true or false
	if not infoType then
		print(" $$ toDoNotifyClient error")
		return
	end
	local event = nil
	-- 设置冻结效果消息
	if infoType == BuffEvents_SC_FreezeBuff then
		event = Event.getEvent(BuffEvents_SC_FreezeBuff, self.owner:getID(),isFreeze)
	-- 添加buff消息
	elseif infoType == BuffEvents_SC_AddBuff then
		 event = Event.getEvent(BuffEvents_SC_AddBuff,	self.owner:getID(), self.buffID, self.lastValue, isFreeze)
	-- 移除buff消息
	elseif	infoType == BuffEvents_SC_RemoveBuff then
		event = Event.getEvent(BuffEvents_SC_RemoveBuff, self.owner:getID(), self.buffID)
	-- 更新持续值消息
	elseif	infoType == BuffEvents_SC_UpdateBuff then
		event = Event.getEvent(BuffEvents_SC_UpdateBuff, self.owner:getID(), self.buffID, self.lastValue, isFreeze)
	end
	-- 发送客户端
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

function Buff:getFreeze()
	return self.freeze
end

--	设置冻结效果 通知客户端
function Buff:setFreeze(isFreeze)
	self.freeze = isFreeze
	self:toDoNotifyClient(BuffEvents_SC_FreezeBuff)
end

-- buff的开始
function Buff:start()
	-- 根据对战斗外buff功能函数的Map对开始buff索引
	funcName = FightOutBuffMap[self.type]
	if self[funcName[1]](self) then
		self:toDoNotifyClient(BuffEvents_SC_AddBuff)
	end
end

-- buff的停止
function Buff:stop()
	-- 把持续值直接设为零值
	self:setLastValue(0)
end

-- 时间持续值的变化
function Buff:calcPeriod()
	if self.freeze == true then
		return true
	end
	-- 时间持续值
	if self.lastType == BUFF_LAST_TYPE.time then
		return self:setLastValue(self.lastValue - 1)
	end
	-- 数值持续值
	if self.lastType == BUFF_LAST_TYPE.num then
		return self:setLastValue(self.lastValue)
	end
	return true
end

--	所有的持续值设置
function Buff:setLastValue(value)
	-- 如果已经是0已经停止
	if self.lastValue == 0 then
		return false
	end
	self.lastValue = value
	funcName = FightOutBuffMap[self.type]
	if self.lastValue <= 0 then
		-- 停止buff并通知客户端
		if self[funcName[3]](self) then
			self:toDoNotifyClient(BuffEvents_SC_RemoveBuff)
			self.lastValue = 0
			return false
		end
	else
		-- 更新服务器
		self[funcName[2]](self)
		-- 更新客户端
		self:toDoNotifyClient(BuffEvents_SC_UpdateBuff)
		return true
	end
end

-- 所有的buff
-- 特殊效果
function Buff:addEffect()
	-- 池灵池对象
	if self.type == FightOutBuffType.hp_pool or self.type == FightOutBuffType.mp_pool then
		self.targetType = self.db.effects[1][1]
	--多倍经验丹倍数
	elseif self.type == FightOutBuffType.xp_boost then
		self.boost = self.db.effects[1][1]
	end
end

-- 血池灵池对象
function Buff:getPoolTarget()
	return self.targetType
end

-- 多倍经验丹倍数
function Buff:getXpBoostValue()
	return self.boost
end

-- 血池buff
function Buff:startHpPool()
	return true
end

function Buff:calcHpPool()
	return true
end

function Buff:stopHpPool()
	return true
end

-- 蓝池buff
function Buff:startMpPool()
	return true
end

function Buff:calcMpPool()
	return true
end

function Buff:stopMpPool()
	return true
end

-- 驱魔香buff
function Buff:startExorcism()
	return true
end

function Buff:calcExorcism()
	return true
end

function Buff:stopExorcism()
	return true
end

-- 御兽铃buff
function Buff:startReinBeast()
	return true
end

function Buff:calcReinBeast()
	return true
end

function Buff:stopReinBeast()
	return true
end

-- 多倍经验丹buff
function Buff:startXpBoost()

	return true
end

function Buff:calcXpBoost()
	return true
end

function Buff:stopXpBoost()
	return true
end

-- 护心丹buff
function Buff:startGodBless()
	return true
end

function Buff:calcGodBless()
	return true
end

function Buff:stopGodBless()
	return true
end

-- 变身buff
function Buff:startTarnsCard()
	--对记录影响效果
	self.effects = {}
	for _,iter in pairs(self.db.effects) do
		if iter[1] and iter[2] then
			table.insert( self.effects, { iter[1], math.floor(iter[2]) } )
		end
	end
	-- 对效果的使用
	local do_str = 0
	for _,iter in pairs(self.effects) do
		do_str = Trans_effect_method[iter[1]]
		self.owner[do_str](self.owner, iter[2])
	end
	self.owner:setModelID(self.db.model)
	return true
end

function Buff:calcTarnsCard()
	return true
end

function Buff:stopTarnsCard()
	local do_str = 0
	for _,iter in pairs(self.effects) do
		do_str = Trans_effect_method[iter[1]]
		self.owner[do_str](self.owner, 0-iter[2])
	end

	local equipHandler = self.owner:getHandler(HandlerDef_Equip)
	local equip = equipHandler:getEquip()
	local result, item = equip:getItems(1,EquipType_ItemGrid[EquipmentClass.Armor][ArmorSubClass.Clothes])
	if item then
		-- 上装
		local equipConfig = tEquipmentDB[item:getItemID()]
		local str = ModelIDByClothDB[self.owner:getSchool()][self.owner:getSex()][equipConfig.UseNeedLvl]
		if str then
			local i,j = string.find(str,"%d+")
			local modelID = toNumber(string.sub(str,i,j))

			local subStr = string.sub(str,j+2,string.len(str))
			i,j = string.find(subStr,"%d+")
			bodyTex = toNumber(string.sub(subStr,i,j))

			if modelID and bodyTex then
				self.owner:setModelID(modelID)
				self.owner:setCurBodyTex(bodyTex)
			end
		end
	else
		local modelID = SchoolModelSwitch[self.owner:getSex()][self.owner:getSchool()]
		self.owner:setModelID(modelID)
	end
	return true
end

-- 强制pk
function Buff:startEnforcedPk()
	return true
end

function Buff:calcEnforcedPk()
	return true
end

function Buff:stopEnforcedPk()
	return true
end

-- pk保护
function Buff:startProtectPk()
	return true
end

function Buff:calcProtectPk()
	return true
end

function Buff:stopProtectPk()
	return true
end

-- 恶贯满盈
function Buff:startEvil()
	return true
end

function Buff:calcEvil()
	return true
end

function Buff:stopEvil()
	return true
end

--	宠物忠诚池
function Buff:startLoyaltyPool()
	return true
end
function Buff:calcLoyaltyPool()
	return true
end
function Buff:stopLoyaltyPool()
	return true
end

-- 战斗计数buff
function Buff:startFightCount()
	return true
end
function Buff:calcFightCount()
	return true
end
function Buff:stopFightCount()
	return true
end

-- 满怪buff
function Buff:startFullMoster()
	return true
end
function Buff:calcFullMoster()
	return true
end
function Buff:stopFullMoster()
	return true
end
