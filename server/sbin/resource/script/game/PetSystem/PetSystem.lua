-- PetSystem.lua
require "game.SystemError"

local function toDo(str,...) end
local function notice(str,...)
	print( ("PetSystem:%s"):format( str and str:format(...) or "" ) )
end

local math_random	= math.random
local math_min		= math.min
local math_ceil		= math.ceil
local math_floor	= math.floor
local CombineArray	= Array.combine
local SubtractArray	= Array.subtract

PetSystem = class(EventSetDoer,Singleton)

function PetSystem:__init()
	self._doer = {
		[PetEvent_CS_SetFightPet]			= PetSystem.onSetFightPet,		-- 设置出战宠物
		[PetEvent_CS_ShowPet]				= PetSystem.onSwitchPetVisible,	-- 切换宠物可视性
		[PetEvent_CS_RequireFullBatch]		= PetSystem.onRequireFullBatch,	-- 客户端请求宠物信息
		[PetEvent_CS_SetStatus]				= PetSystem.onSetPetStatus,		-- 设置宠物状态
		[PetEvent_CS_SetAttrDistribution]	= PetSystem.onSetPetAttrs,		-- 宠物属性点的分配
		[PetEvent_CS_SetName]				= PetSystem.onSetPetName,		-- 设置宠物名称
		[PetEvent_CS_DeletePet]				= PetSystem.onDeletePet,		-- 删除一个宠物
		[PetEvent_CS_RepairPet]				= PetSystem.onConfirmRepair,	-- 宠物修复

		[TeamEvents_SS_MemberJoinTeam]		= PetSystem.onJoinTeam,			-- 加入队伍
		[TeamEvents_SS_QuitTeam]			= PetSystem.onQuitTeam,			-- 退出队伍
		[TeamEvents_SS_ChangeLeader]		= PetSystem.onChangeLeader,		-- 队伍队长改变

		[PetEvent_CS_EnchancePet]			= PetSystem.onEnchancePet,		-- 宠物强化
		[PetEvent_CS_RebirthPet]			= PetSystem.onPetRebirth,		-- 宠物还童
		[PetEvent_CS_SetPhaseDistribution]	= PetSystem.onSetPetPhase,		-- 设置宠物的相性点
		[PetEvent_CS_ExpandPetBar]			= PetSystem.onExpandPetBar,		-- 拓展宠物栏
		[PetEvent_CS_CombinePets]			= PetSystem.onCombinePets,		-- 宠物合成
		[PetEvent_CS_ReadSkillBook]			= PetSystem.onPetLearn,			-- 宠物学习技能
		[PetEvent_CS_LearnExtendSkill]		= PetSystem.onLearnExtendSkill,	-- 宠物学习研发技能
	}
end

local function PetNormalCheck(player,pet)
	if not pet then
		return PetError.NonExistentPet
	end
	if pet:getOwnerID() ~= player:getID() then
		return PetError.OthersPet
	end
	return 0
end

local function SetFightPetCheck(player,pet,fight)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end
	if fight == pet then
		return -1
	end
	local level = player:getLevel()
	if level + FightPetLevelParam < pet:getLevel() then
		return PetError.PlayerLevelLow
	end
	if level < pet:getTakeLevel() then
		return PetError.TakeLevelHigh
	end
	return 0
end

-- 设置出战宠物
function PetSystem:onSetFightPet(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()
	local petID		= params[1]
	local pet		= petID and g_entityMgr:getPet(petID)

	local handler	= player:getHandler(HandlerDef_Pet)
	local fight		= g_entityMgr:getPet(handler:getFightPetID())
	local errCode	= SetFightPetCheck(player,pet,fight)
	if errCode > 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode),player
		)
		return
	end
	if errCode == -1 then
		-- 切换出战宠物的状态为休息
		pet:setPetStatus(PetStatus.Rest)
	else
		-- 撤下之前的出战宠物
		if fight then
			fight:setPetStatus(PetStatus.Rest)
			fight:flushPropBatch(player)			
		end
		-- 宠物出战
		pet:setPetStatus(PetStatus.Fight)
	end

	pet:flushPropBatch(player)
end

-- 宠物可视切换检测
local function SwitchPetVisibleCheck(player,pet)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end

	return 0
end

-- 切换可视性
function PetSystem:onSwitchPetVisible(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()

	local petID		= params[1]
	local pet		= petID and g_entityMgr:getPet(petID)

	local handler	= player:getHandler(HandlerDef_Pet)
	local follow	= g_entityMgr:getPet(handler:getFollowPetID())
	local errCode	= SwitchPetVisibleCheck(player,pet)
	if errCode ~=0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode),player
		)
	else
		if follow and follow:isVisible() then
			if follow ~= pet then
				follow:setVisible(false)
				pet:setVisible(true)
			else
				pet:setVisible(false)
			end
		else
			pet:setVisible(true)
		end
	end
end

-- 玩家加入队伍时候,宠物的表现
function PetSystem:onJoinTeam(event)
	local params	= event:getParams()
	local roleID	= params[1]
	local player	= g_entityMgr:getPlayerByID(roleID)
	local follow	= g_entityMgr:getPet(player:getFollowPetID())
	if follow and follow:isVisible() then
		toDo "添加是否是队长判断"
		follow:setVisible(false)
	end
end

function PetSystem:onQuitTeam(event)
	local params	= event:getParams()
	local roleID	= params[1]
	local player	= g_entityMgr:getPlayerByID(roleID)
	local follow	= g_entityMgr:getPet(player:getFollowPetID())
	if follow then
		toDo "添加之前宠物是否是显示的判断"
		follow:setVisible(true)
	end
end

function PetSystem:onChangeLeader(event)
	local params	= event:getParams()
	local roleID	= params[1]
	local player	= g_entityMgr:getPlayerByID(roleID)
	local follow	= g_entityMgr:getPet(player:getFollowPetID())

	toDo "切换队长时候处理"
end

-- 请求宠物数据检测
function RequireFullBatchCheck(player,pet)
	if not pet then
		return PetError.RequireNone
	end
	if pet:getOwnerID() == player:getID() then
		return PetError.RequireMine
	end

	return 0
end

-- 请求宠物数据
function PetSystem:onRequireFullBatch(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()

	local petID		= params[1]
	local pet		= g_entityMgr:getPet(petID)

	local errCode = RequireFullBatchCheck(player,pet)
	if errCode == 0 then
		pet:attachTo(player)
		pet:sendFull(player)

		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_FullBatchPushed,petID),player
		)
	else
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode),player
		)
	end
end

-- 设置宠物状态检测
local function SetPetStatusCheck(player,pet,status)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end

	if pet:getPetStatus() == status then
		return PetError.InSameStatus
	end

	if status == PetStatus.Fight then
		if player:getFightPetID() then
			return PetError.DuplicateFight
		end
	elseif status == PetStatus.Ready then
		if player:getReadyPetID() then
			return PetError.DuplicateReady
		end
	end
	return 0
end

-- 设置宠物状态
function PetSystem:onSetPetStatus(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()

	local petID		= params[1]
	local status	= params[2]

	local pet		= g_entityMgr:getPet(petID)

	local errCode	= SetPetStatusCheck(player,pet,status)
	if errCode == 0 then
		pet:setPetStatus(status)
		pet:flushPropBatch(player)
	else
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet, errCode), player
		)
	end
end

-- 设置属性点检测
local function SetPetAttrsCheck(player,pet,distribution)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end
	if type(distribution) ~= 'table' then
		return PetError.WrongAttrSet
	end

	local need = 0
	for attrName,value in pairs(distribution) do
		if attrName <= pet_dex_point and attrName >= pet_str_point then
			need = need + value
		else
			return PetError.WrongAttrSet
		end
	end
	if pet:getAttrValue(pet_attr_point) < need then
		return PetError.NoEnoughPoint
	end

	return 0	
end

-- 设置属性点
function PetSystem:onSetPetAttrs(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()

	local petID		= params[1]
	local distri	= params[2]
	local pet		= g_entityMgr:getPet(petID)
	local errCode	= SetPetAttrsCheck(player,pet,distri)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet, errCode), player
		)
	else
		local remain = pet:getAttrValue(pet_attr_point)
		for attrName,value in pairs(distri) do
			pet:addAttrValue(attrName,value)
			remain = remain - value
		end
		pet:setAttrValue(pet_attr_point,remain)

		pet:flushPropBatch(player)
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_AttrConfirmed,petID),player
		)
	end
end

-- 设置宠物名称
function PetSystem:onSetPetName(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()
	local petID		= params[1]
	local name		= params[2]
	local pet		= g_entityMgr:getPet(petID)

	local errCode	= PetNormalCheck(player,pet)
	if errCode == 0 then
		pet:setName(name)
		pet:flushPropBatch(player)

		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_NameConfirmed,petID),player
		)
	else
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg, eventGroup_Pet, errCode
			), player
		)
	end
end

-- 删除宠物检测
local function DeletePetCheck(player,pet)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end
	local status = pet:getPetStatus()
	if status == PetStatus.Fight then
		return PetError.FreeFight
	end
	if status == PetStatus.Ready then
		return PetError.FreeReady
	end
	return 0
end

-- 删除宠物
function PetSystem:onDeletePet(event)
	local player	= g_entityMgr:getPlayerByID(event.playerID)
	local params	= event:getParams()
	local petID		= params[1]	
	local pet		= g_entityMgr:getPet(petID)
	local errCode	= DeletePetCheck(player,pet)

	if errCode == 0 then
		LuaDBAccess.DeletePet(pet)
		player:removePet(petID)
		g_entityMgr:removePet(petID)
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_PetLeaved,petID),player
		)
	else
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode),player
		)
	end
end

-- 打开客户端的确定修复界面
local function OpenRepairConfirmUI(player,repairType,costMoney)
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(PetEvent_SC_ConfirmPetRepair,repairType,costMoney),player
	)
end

-- 宠物是不是满状态
local function IsPetFullState(pet)
	return pet:getHP() >= pet:getMaxHP() and
		pet:getMP() >= pet:getMaxMP() and
		pet:getLoyalty() >= MaxPetLoyalty
end

-- 修复出战宠物检测
local function RepairFightPetCheck(player)
	local fight = g_entityMgr:getPet(player:getFightPetID())
	if not fight then
		return PetError.NoFightPet
	end
	if IsPetFullState(fight) then
		return PetError.HealthPet
	end
	if player:getLevel() > 20 then
		local sub = player:getSubMoney()
		local money = player:getMoney()
		if money < PetRepairCostMoney and sub + money < PetRepairCostMoney then
			return PetError.NoEnoughMoney
		end
	end
	return 0,fight
end

-- 修复宠物
local function RepairPet(pet)
	pet:fill()
	pet:setLoyalty(MaxPetLoyalty)

	notice("宠物%s修复完毕",pet:getName())
end

-- 修复所有宠物
local _rList = {}
local function RepairAllPetCheck(player)
	local handler = player:getHandler(HandlerDef_Pet)
	if handler:getAmount() < 1 then
		return PetError.OwnNoPet
	end
	local len = 0
	for _,pet in pairs(handler:getAll()) do
		if not IsPetFullState(pet) then
			len = len + 1
			_rList[len] = pet
		end
	end
	_rList[len + 1] = nil
	if len < 1 then
		return PetError.NoHurtPet
	end
	local cost = 0
	if player:getLevel() > 20 then
		cost = len * PetRepairCostMoney
		local money = player:getMoney()
		local sub = player:getSubMoney()
		if money < cost and money + sub < cost then
			return PetError.NoEnoughMoney
		end
	end
	return 0,_rList,cost
end

-- 修复出战宠物
function PetSystem:onRepairFightPet(player)
	local errCode,fight = RepairFightPetCheck(player)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode
			),player
		)
	else
		if player:getLevel() > 20 then
			OpenRepairConfirmUI(player,ChooseRepair.FightPet,PetRepairCostMoney)
		else
			RepairPet(fight)
			fight:flushPropBatch(player)
			g_eventMgr:fireRemoteEvent(
				Event.getEvent(
					ClientEvents_SC_PromptMsg,eventGroup_Pet,PetError.PetCured
				),player
			)
		end
	end
end

-- 修复所有宠物
function PetSystem:onRepairAllPet(player)
	local errCode,list,cost = RepairAllPetCheck(player)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg, eventGroup_Pet, errorCode
			), player
		)
	else
		if player:getLevel() > 20 then
			if cost then
				OpenRepairConfirmUI(player,ChooseRepair.AllPet,cost)
			end
		else
			for _,pet in ipairs(pet_list) do
				RepairPet(pet)
				pet:flushPropBatch(player)
			end
			g_entityMgr:fireRemoteEvent(
				Event.getEvent(
					ClientEvents_SC_PromptMsg,eventGroup_Pet,PetError.PetCured
				),player
			)
		end
	end
end

-- 确定修复宠物
function PetSystem:onConfirmRepair(event)
	local player		= g_entityMgr:getPlayerByID(event.playerID)
	local params		= event:getParams()
	local repair		= params[1]

	local errCode = 0
	local cost
	if repair == ChooseRepair.FightPet then
		local fight
		errCode,fight = RepairFightPetCheck(player)
		if errCode == 0 then
			RepairPet(fight)
			fight:flushPropBatch(player)
			cost = PetRepairCostMoney
		end
	elseif repair == ChooseRepair.AllPet then
		local list
		errCode,list,cost = RepairAllPetCheck(player)
		if errCode == 0 then
			for index,pet in ipairs(list) do
				RepairPet(pet)
				pet:flushPropBatch(player)
			end
		end
	end
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode
			),player
		)
	else
		local money = player:getMoney()
		local sub	= player:getSubMoney()

		if money < cost then
			player:setMoney(0)
			player:setSubMoney(money + sub - cost)
		else
			player:setMoney(money - cost)
		end
		player:flushPropBatch()
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg,eventGroup_Pet,PetError.PetCured
			),player
		)
	end
end

-- 强化宠物检测
local function EnchancePetCheck(player,pet)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~=0 then
		return errCode
	end
	if pet:getUpLevel() >= MaxPetEnchance then
		return PetError.MaxEnchance
	end
	local petType = pet:getPetType()
	if petType == PetType.Spirit or petType == PetType.God then
		return PetError.PetTypeError
	end
	local pill,need = GetEnchanceConsume(pet)
	local packet = player:getHandler(HandlerDef_Packet)
	local own = packet:getNumByItemID(pill)
	if need > own then
		return PetError.NoEnoughEnchance
	end
	return 0,packet,pill,need
end

-- 处理客户端强化宠物请求
function PetSystem:onEnchancePet(event)
	local player		= g_entityMgr:getPlayerByID(event.playerID)
	local params		= event:getParams()

	local petID			= params[1]
	local pet			= g_entityMgr:getPet(petID)

	local errCode,packet,pill,need = EnchancePetCheck(player,pet)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode
			),player
		)
		return
	end
	packet:removeByItemId(pill,need)
	
	local growthAttrName		-- 成长属性名称
	local maxGrowthAtttName		-- 成长上限属性名称
	if pet:getAttackType() == PetAttackType.Physics then
		growthAttrName = pet_at_grow
		maxGrowthAtttName = pet_at_grow_max
	else
		growthAttrName = pet_mt_grow
		maxGrowthAtttName = pet_mt_grow_max
	end

	local upLevel = pet:getUpLevel()
	local rate = PetEnchanceProbability[upLevel]	-- 配置的概率
	local process = pet:getAttrValue(pet_up_comp)	--  rate*math_random(20,50)/100	--完成度增加公式 完成度+成功率*（20%~50%）

	local inc = 1 + 0.08 * upLevel + math_ceil(process / 2000) * 0.01	-- 成长属性的加成
	local basicGrowth = pet:getAttrValue(pet_at_grow)/inc				-- 原先成长属性值
	local basicMaxGrowth = pet:getAttrValue(pet_at_grow_max)/inc		-- 原先最大成长属性值

	local process_plus = math_ceil(math_random(20,50)/100 * rate)
	if math_random(0,10000) < rate or process + process_plus > 10000 then
		upLevel = upLevel + 1
		inc = 1 + 0.08*upLevel
		pet:setUpLevel(upLevel)
		pet:setAttrValue(pet_up_comp,0)
	else
		process = process + 100
		inc = 1 + 0.08*upLevel + math_ceil(process/2000)*0.01
		pet:addAttrValue(pet_up_comp,process_plus)
	end

	pet:setAttrValue(growthAttrName,math_floor(inc * basicGrowth))
	pet:setAttrValue(maxGrowthAtttName,math_floor(inc * basicMaxGrowth))

	pet:flushPropBatch(player)
end

-- 宠物还童检测
local function PetRebirthCheck(player,pet)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end
	local status = pet:getPetStatus()
	if status == PetStatus.Fight or stats == PetStatus.Ready then
		return PetError.RebirthFightOrReady
	end
	local packet = player:getHandler(HandlerDef_Packet)
	local item,need = GetRebirthConsume(pet)
	if packet:getNumByItemID(item) < need then
		return PetError.NoEnoughRebirth
	end
	return 0,packet,item,need
end

-- 宠物还童
function PetSystem:onPetRebirth(event)
	local player		= g_entityMgr:getPlayerByID(event.playerID)
	local params		= event:getParams()
	local petID			= params[1]
	local pet			= g_entityMgr:getPet(petID)

	local errCode,packet,item,need = PetRebirthCheck(player,pet)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode
			),player
		)
	else
		packet:removeByItemId(item,need)
		pet:onReset()
		pet:flushPropBatch(player)
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				PetEvent_SC_PetRebirthed,petID
			),player
		)

		local handler = pet:getHandler(HandlerDef_PetSkill)
		handler:sendPassed(player)
		handler:sendFreshs(player)
	end
end

-- 检查相性点分配
local function SetPetPhaseCheck(player,pet,distribution)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then
		return errCode
	end
	if not distribution then
		return PetError.WrongAttrSet
	end
	local sum = 0
	for attrName,value in pairs(distribution) do
		if value < 0 then
			return PetError.WrongAttrSet
		end
		if attrName <= pet_toxicosis_phase_point and
			attrName >= pet_fir_phase_point then
			if pet:getAttrValue(attrName) + value > 35 then
				return PetError.PhaseOver35
			end
			sum  = sum + value
		else
			return PetError.WrongAttrSet
		end
	end
	if sum > pet:getAttrValue(pet_phase_point) then
		return PetError.NoEnoughPoint
	end
	return 0
end

-- 设置宠物相性
function PetSystem:onSetPetPhase(event)
	local player		= g_entityMgr:getPlayerByID(event.playerID)
	local params		= event:getParams()
	local petID			= params[1]
	local distribution	= params[2]

	local pet			= g_entityMgr:getPet(petID)
	local errCode		= SetPetPhaseCheck(player,pet,distribution)

	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode
			),player
		)
		return
	end

	local free = pet:getAttrValue(pet_phase_point)
	for attrName,value in pairs(distribution) do
		pet:addAttrValue(attrName,value)
		free = free - value
	end
	pet:setAttrValue(pet_phase_point,free)
	pet:flushPropBatch(player)
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(
			PetEvent_SC_PhaseConfirmed,petID
		),player
	)
end

-- 增加最大宠物数量检测
local function ExpandPetBarCheck(player)
	if player:getMaxPet() >= MaxPetNum then
		return PetError.MaxPetBar
	end

	local packet = player:getHandler(HandlerDef_Packet)
	if packet:getNumByItemID(PetTalentBox) < 1 then
		return PetError.NoEnoughExpand
	end
	return 0,packet
end

-- 增加宠物上限
function PetSystem:onExpandPetBar(event)
	local player		= g_entityMgr:getPlayerByID(event.playerID)
	local params		= event:getParams()
	local errCode,packet = ExpandPetBarCheck(player)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode
			),player
		)
	else
		packet:removeByItemId(PetTalentBox,1)
		player:setMaxPet(player:getMaxPet() + 1)
		player:flushPropBatch()
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_PetBarConfirmed),player
		)
	end
end

-- 可以操作的宠物的状态
local function Handleable(pet)
	return pet:getPetStatus() == PetStatus.Rest
end

-- 宠物合成检测
local function CombinePetCheck(player,first,second)
	local one = g_entityMgr:getPet(first)
	local two = g_entityMgr:getPet(second)

	local errCode = PetNormalCheck(player,one)
	if errCode == 0 then
		errCode = PetNormalCheck(player,two)
	end
	if errCode ~= 0 then
		return errCode
	end

	if first == second then
		return PetError.CombineSame
	end

	if not Handleable(one) or not Handleable(two) then
		return PetError.CombineUnhandle
	end

	if one:getLevel() < PetMinCombineLvl or two:getLevel() < PetMinCombineLvl then
		return PetError.CombineLevelLow
	end

	local survivor,victim
	if math_random(1,100) <= 50 then
		survivor,victim = one,two
	else
		survivor,victim = two,one
	end
	local failure = (math_random(1,100) < PetCombineFailRate)

	-- 返回值:错误ID,幸存者,罹难者,合成是否失败
	return 0,survivor,victim,failure
end

-- 取得区间,最小值的0.9到最大值的1.1
local function Order(a,b)
	if a < b then
		return a * 0.9 , b * 1.1
	else
		return b * 0.9 , a * 1.1
	end
end

-- 合并宠物的属性
local function MergeAttrs(survivor,victim)
	local random = PetCompoundRandom
	local petType = survivor:getPetType()
	if petType ~= PetType.Spirit and petType ~= PetType.God then
		for index,data in ipairs(PetGrowthAttrs) do
			local growth,growthMax = data[1],data[2]
			local maxValue = random(Order(survivor:getAttrValue(growthMax),victim:getAttrValue(growthMax)))
			local from,to = Order(survivor:getAttrValue(growth),victim:getAttrValue(growth))
			local growthValue = random(from,math_min(to,maxValue))
			survivor:setAttrValue(growthMax,maxValue)
			survivor:setAttrValue(growth,growthValue)
		end
	end
end

-- 合并宠物的技能
local function CombineSkills(survivor,victim,level)
	local alpha = survivor:getHandler(HandlerDef_PetSkill)
	local belta = victim:getHandler(HandlerDef_PetSkill)

	alpha:retrimBasic()
	local maxSkill = math_ceil(
		( alpha:getMaxSkill() + belta:getMaxSkill() ) * math_random(60,65) / 100
	)
	if maxSkill > 10 then maxSkill = 10 end
	alpha:setMaxSkill(maxSkill)

	notice(("宠物合成后最大技能数量%d"):format(maxSkill))

	local all  = CombineArray(alpha:getAllSuperior(),belta:getAllSuperior())
	notice(("可以学习的技能:%s"):format(toString(all)))

	local tGod = PetStudyDB[survivor:getConfigID()].God
	if tGod then
		SubtractArray(all,tGod)
		notice(("幸存者的神将技能:%s"):format(toString(tGod)))
		notice(("去除幸存者的神将技能后,剩余可用技能:%s"):format(toString(all)))
	end
	tGod = PetStudyDB[victim:getConfigID()].God
	if tGod then
		SubtractArray(all,tGod)
		notice(("罹难者的神将技能:%s"):format(toString(tGod)))
		notice(("去除罹难者的神将技能后,剩余可用技能:%s"):format(toString(all)))
	end
	alpha:removeAllSuperior()

	local next = NonRepeatIndex(#all)
	local skillCount = math_min( math_ceil(#all * math_random(30,60) / 100 ),maxSkill )
	for i = 1,skillCount do
		local skillID = all[next()]
		notice(("获得技能:%s"):format(skillID))
		alpha:addSkill(PetSkill(skillID,2,level))
	end
end

-- 合成宠物
function PetSystem:onCombinePets(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()

	local first = params[1]
	local second = params[2]
	
	local errCode,survivor,victim,failure = CombinePetCheck(player,first,second)
	
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode),player
		)
		return
	end
	
	toDo "添加宠物合成失败处理:替换成另外一个低出战等级宠物"

	local level = failure and 1 or math_ceil( ( victim:getLevel() + survivor:getLevel() ) * 40 / 100 )
	survivor:resetAttrs()
	survivor:setLevel(1)

	MergeAttrs(survivor,victim)
	CombineSkills(survivor,victim,level)

	local config = PetDB[survivor:getConfigID()]
	survivor:setPetLife(PetCompoundRandom(config.petLife[1],survivor:getAttrValue(pet_life_max)))
	survivor:setLoyalty(MaxPetLoyalty)
	survivor:onLevelUP(level)
	survivor:flushPropBatch(player)
	toDo "没有发送宠物的技能信息??"

	if failure then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,PetError.CombineFailed),player
		)
	end

	LuaDBAccess.DeletePet(victim)
	player:removePet(victim:getID())
	g_entityMgr:removePet(victim:getID())

	g_eventMgr:fireRemoteEvent(
		Event.getEvent(PetEvent_CS_PetsCombined,first,second),player
	)
end

-- 使用技能书
function PetLearnCheck(player,pet,bookID)
	local errCode = PetNormalCheck(player,pet)
	if errCode ~= 0 then return errCode end
	if pet:getPetType() == PetType.Wild then
		return PetError.WildCantLearn
	end
	if pet:getPetStatus() == PetStatus.Fight then
		return PetError.FightPetLearn
	end
	local packet = player:getHandler(HandlerDef_Packet)
	local number = packet:getNumByItemID(bookID)
	if not number or number < 1 then
		return PetError.NoSuchBook
	end
	local handler = pet:getHandler(HandlerDef_PetSkill)
	errCode = handler:canRead(bookID)
	return errCode,packet,handler
end

-- 宠物学习技能
function PetSystem:onPetLearn(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()

	local petID = params[1]
	local bookID = params[2]

	local pet = g_entityMgr:getPet(petID)
	local errCode,packet,handler = PetLearnCheck(player,pet,bookID)
	if errCode ~= 0 then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Pet,errCode),player
		)
		return
	end
	packet:removeByItemId(bookID,1)
	local skillID,replaceID = handler:readBook(bookID)
	handler:sendPassed(player)
	handler:sendFreshs(player)
	pet:flushPropBatch(player)
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(PetEvent_CS_SkillBookRead,petID,skillID,replacedID),player
	)
end


------------------------------宠物学习研发技能
local CostType = {
	[PetSkillCostType.potential] 	= function(player) return player:getAttrValue(player_pot) end,
	[PetSkillCostType.money] 		= function(player) return player:getMoney() end,
	[PetSkillCostType.contrib]		= function(player) return player:getFactionMoney() end,
	[PetSkillCostType.exp] 			= function(player) return player:getAttrValue(player_xp) end,
}

local CostValue = {
	[PetSkillCostType.potential] 	= function(player,value) player:setAttrValue(player_pot,value) end,
	[PetSkillCostType.money] 		= function(player,value) player:setMoney(value) end,
	[PetSkillCostType.contrib]		= function(player,value) player:setFactionMoney(value) end,
	[PetSkillCostType.exp] 			= function(player,value) player:setAttrValue(player_xp,value) end,
}

--消耗
local function PetExtendConsume(player,skillID,skillLevel)
	local skillData = PetSkillLevelUpDB[skillID]
	local cost = skillData.cost
	for index,value in pairs(cost) do
		local needCost = PetSkillDataDB[value][skillLevel]
		local curCost = CostType[index](player)
		if curCost < needCost then
			print("cost not enough")
			return false 
		else
			CostValue[index](player,curCost - need)
			player:flushPropBatch()
			return true
		end
	end
end

--研发技能
function PetSystem.onLearnExtendSkill(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()

	local petID = params[1]
	local skillID = params[2]
	local skillLevel = params[3]

	local pet = player:getHandler(HandlerDef_Pet):getPet(petID)
	if not pet then print("the pet is empty") return end
	local skillhandler = pet:getHandler(HandlerDef_PetSkill)
	
	--是否能操作判定
	if skillhandler:canLearnExtend(skillID,skillLevel) then return end
	--消耗
	if not PetExtendConsume(player,skillID,skillLevel) then return end
	--研发技能
	skillhandler:learnExtendSkill(skillID,skillLevel)
	
	handler:sendFreshs(player)
	handler:sendChanges(player)
	pet:flushPropBatch(player)
end



function PetSystem.getInstance()
	return PetSystem()
end

g_eventMgr:addEventListener(PetSystem.getInstance())

_G["DeletePetCheck"] = DeletePetCheck
