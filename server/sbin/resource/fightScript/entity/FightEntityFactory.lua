--[[FightEntityFactory.lua
描述：
	战斗实体工厂，创建各种类型的战斗实体
--]]

require "base.base"
require "entity.FightPlayer"
require "entity.FightMonster"
require "entity.FightPet"


FightEntityFactory = class(nil, Singleton)
local instance

function FightEntityFactory:__init()
end

function FightEntityFactory:createPlayer(attr)
	local player = FightPlayer()
	player:setLifeState(RoleLifeState.Normal)
	player:createAttributeSet()

	player:loadAttrs(attr)
	player:setGateID(attr.gateID)
	attr.gateID = nil
	player:setClientLink(attr.clientLink)
	attr.clientLink = nil
	player:setDBID(attr.dbID)
	attr.dbID = nil
	player:setName(attr.name)
	attr.name = nil
	player:setModelID(attr.modelID)
	attr.modelID = nil
	player:setSchool(attr.school)
	attr.school = nil
	player:setLevel(attr.level or 1)
	
	attr.level = nil
	player:setSex(attr.sex)
	attr.sex = nil
	player:setShowParts(attr.showParts)
	attr.showParts = nil
	player:setMinds(attr.minds)
	attr.minds = nil
	player:setIsInTeam(attr.isTeam)
	attr.isTeam = nil
	player:setIsTeamHead(attr.isTeamHead)
	if attr.isTeamHead then
		player:setTeamMemberList(attr.playerIDList)
		attr.playerIDList = nil
		attr.isTeamHead = nil
	end
	player:setPkInfo(attr.pkInfo)
	attr.pkInfo = nil
	player:setIsMustCatch(attr.mustCatch)
	attr.mustCatch = nil
	player:setRemouldLevel(attr.remouldLevel)
	attr.remouldLevel = nil
	--加上AI处理
	local AIH = PlayerAIHandler(player)
	player:addHandler(FightEntityHandlerType.AIHandler,AIH)
	--加战斗实体buff
	player:addHandler(FightEntityHandlerType.HandlerDef_FightBuff,FightBuffHandler(player))
	-- 加战斗实体Item
	player:addHandler(FightEntityHandlerType.HandlerDef_FightItem, FightItemHandler(player))
	-- 技能Handler
	
	local skill_handler = SkillHandler(player)
	player:addHandler(FightEntityHandlerType.SkillHandler, skill_handler)
	
	--初始化包裹
	local itemH = player:getHandler(FightEntityHandlerType.HandlerDef_FightItem)
	itemH:setBattlePack(attr.pack)
	attr.pack = nil
	--加入普通攻击技能
	local commonSkill = CommonSkill(player)
	player:setCommonSkill(commonSkill)
	player:setWeaponID(attr.weaponID)
	--将实体加入EntityManager管理
	g_fightEntityMgr:addPlayer(player)
	--player:show_mind()
	--player:show_skill()
	return player
end

function FightEntityFactory:createMonster(dbID, monType, playerLvl)
	local attrDefine
	local attributeMonsterFormat
	local attrMonsterInfluenceTable
	local attrMonsterSyncTable
	local config = MonsterDB[dbID] or NpcDB[dbID]
	if not config then
		print("创建怪物时候出错，不存在的怪物信息",dbID)
	end
	local monType = monType or monsterType.commonMonster
	if monType == monsterType.bossMonster then
		attrDefine = MonsterAttrDefine
		attributeMonsterFormat = g_AttributeMonsterFormat
		attrMonsterInfluenceTable = g_AttrMonsterInfluenceTable
		attrMonsterSyncTable = g_AttrMonsterSyncTable
	else
		attrDefine = MonsterAttrDefine
		attributeMonsterFormat = g_AttributeMonsterFormat
		attrMonsterInfluenceTable = g_AttrMonsterInfluenceTable
		attrMonsterSyncTable = g_AttrMonsterSyncTable
	end
	local monster = FightMonster()
	monster:setDBID(dbID)
	monster:setAttrDefine(attrDefine or MonsterAttrDefine)
	monster:setAttributeFormat(attributeMonsterFormat or g_AttributeMonsterFormat)
	monster:setAttrInfluenceTable(attrMonsterInfluenceTable or g_AttrMonsterInfluenceTable)
	monster:setAttrSyncTable(attrMonsterSyncTable or g_AttrMonsterSyncTable)
	monster:createAttributeSet()
	monster:loadAttrs(playerLvl)
	monster:setLifeState(RoleLifeState.Normal)
	-- 设置怪物等级与玩家等级相同
	if monster:getAttrValue(monster_lvl) < 1 and playerLvl then
		print("设置怪物等级与玩家等级相同")
		monster:setAttrValue(monster_lvl, playerLvl)
	elseif monster:getAttrValue(monster_lvl) == 0 or monster:getAttrValue(monster_lvl) ==nil then 
		--怪物配置表的怪物没有等级是暂时设为1级
		print("怪物配置表的怪物没有等级是暂时设为1级")
		monster:setAttrValue(monster_lvl, 1)
	end
	
	--加上AI处理
	local AIH = MonsterAIHandler(monster)
	monster:addHandler(FightEntityHandlerType.AIHandler,AIH)
	if type(config.fightAI) == "table" and #config.fightAI > 0 then
		AIH:setAIIDs(config.fightAI)
	end

	monster:addHandler(FightEntityHandlerType.HandlerDef_FightBuff,FightBuffHandler(monster))
	-- 技能Handler
	
	local skill_handler = MonsterSkillHandler(monster)
	monster:addHandler(FightEntityHandlerType.SkillHandler, skill_handler)
	
	--设置血量
	local maxHp = monster:getAttrValue(monster_max_hp)
	monster:setAttrValue(monster_hp,maxHp)
	--加入普通攻击技能
	local commonSkill = CommonSkill(monster) 
	monster:setCommonSkill(commonSkill)
	--将实体加入EntityManager管理
	g_fightEntityMgr:addMonster(monster)
	return monster
end

function FightEntityFactory:createPet(attr,isFollow)
	local pet = FightPet()
	pet:createAttributeSet()
	pet:loadAttrs(attr)
	pet:setLifeState(RoleLifeState.Normal)
	
	pet:setWorldPetID(attr.worldPetID)
	attr.worldPetID = nil
	pet:setDBID(attr.dbID)
	attr.dbID = nil
	pet:setName(attr.name)
	attr.name = nil
	pet:setModelID(attr.modelID)
	attr.modelID = nil
	pet:setLevel(attr.level or 1)
	attr.level = nil
	pet:setXp(attr.xp or 1)
	attr.xp = nil
	pet:setShowParts(attr.showParts)
	attr.showParts = nil
	pet:setLife(attr.life)
	attr.life = nil
	pet:setLoyalty(attr.loyalty)
	attr.loyalty = nil
	pet:setStatus(attr.status)
	attr.status = nil
	pet:setSkills(attr.skills)
	attr.skills = nil
	local player = g_fightEntityMgr:getPlayerByDBID(attr.ownerID)
	attr.ownerID = nil
	if isFollow then
		player:setPetID(pet:getID())
		--减寿命
		if pet:getLifeState() ~= RoleLifeState.Dead then
			local rand = math.random(EachLifeReduction[1],EachLifeReduction[2])
			local cur = pet:getLife()
			local left = cur - rand
			if left < 0 then
				left = 0
			end
			pet:setLife(left)
		end
		--设参战标记
		pet:setAlready(true)
	end
	player:addPetID(pet:getID())
	pet:setOwnerID(player:getID())
	--[[
	--宠物的先天属性现在放到了属性集合中
	for inBornAttrID,value in pairs(attr.inbornAttrs) do
		pet:setInbornAttr(inBornAttrID,value)
	end
	attr.inbornAttrs = nil
	]]
	--加上AI处理
	local AIH = PlayerAIHandler(pet)
	pet:addHandler(FightEntityHandlerType.AIHandler,AIH)
	--加战斗实体buff
	pet:addHandler(FightEntityHandlerType.HandlerDef_FightBuff,FightBuffHandler(pet))
	-- 加战斗实体Item
	pet:addHandler(FightEntityHandlerType.HandlerDef_FightItem, FightItemHandler(pet))--以后将玩家包裹引用赋给它
	--技能Handler
	local skill_handler = PetSkillHandler(pet)
	pet:addHandler(FightEntityHandlerType.SkillHandler, skill_handler)

	--加入普通攻击技能
	local commonSkill = CommonSkill(pet)
	pet:setCommonSkill(commonSkill)
	--将实体加入EntityManager管理
	g_fightEntityMgr:addPet(pet)
	
	return pet
end

FightEntityFactory.getInstance = function()
	instance = instance or FightEntityFactory()
	return instance
end