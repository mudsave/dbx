-- PetSkillHandler.lua

require "base.RandomTool"
require "base.Array"
require "game.PetSystem.PetSkill"

local function notice(str,...)
	print(("PetSkillHandler:%s"):format(str and (str):format(...) or ""))
end

local table_sort	= table.sort
local table_copy	= table.copy
local math_random	= math.random
local math_pow		= math.pow
local rawget		= rawget
local rawset		= rawset
local Subtract		= Array.subtract

local Basic		= PetSkillCategory.Basic
local Superior	= PetSkillCategory.Superior

PetSkillHandler = class()

function PetSkillHandler:__init(owner)
	self.owner		= owner
	self.skills		= {}
	self.maxSkill	= owner:getAttrValue(pet_skill_max)
	self.categories	= {{},{}}
	self.ordinalMax = 0
end

function PetSkillHandler:getOwner()
	return self.owner
end

function PetSkillHandler:getMaxSkill()
	return self.maxSkill
end

function PetSkillHandler:setMaxSkill(ms)
	ms = tonumber(ms)
	self.maxSkill = ms
	self.owner:setAttrValue(pet_skill_max,ms)
end

function PetSkillHandler:getSkill(skillID)
	return skillID and self.skills[skillID]
end

local function __sd_comparator(x,y)
	return x.ordinal > y.ordinal
end

function PetSkillHandler:loadDB(recordSet)
	if not recordSet then
		return false
	end
	table_sort(recordSet,__sd_comparator)
	for _,data in ipairs(recordSet) do
		self:addSkill(
			PetSkill(data.skillID,data.category)
		)
	end
	return true
end

function PetSkillHandler:canAddSkill(skillID)
	if not skillID or not PetSkillDB[skillID] then
		notice("不存在的技能 %s",skillID or "nil")
		return false,PetError.NoSuchBook
	end
	local prev = self:getSkill(skillID)
	if prev and not prev:isRemoved() then
		return false,PetError.DuplicateSkill
	end
	return true,skillID
end

function PetSkillHandler:isFull()
	return self:getAmount(Superior) >= self:getMaxSkill()
end

function PetSkillHandler:getAmount(ct)
	return #( self.categories[ct] )
end

function PetSkillHandler:getAll(ct)
	return self.categories[ct]
end

function PetSkillHandler:getAllBase()
	return self:getAll(Basic)
end

function PetSkillHandler:getAllSuperior()
	return self:getAll(Superior)
end

function PetSkillHandler:addSkill(skill)
	if not skill then return false end

	local skills = self.skills
	local id = skill:getID()

	local prev = skills[id]
	if prev and not prev:isRemoved() then
		return false
	end

	local ca = skill:getCategory()
	local id_list = self.categories[ca]
	if not id_list then
		notice("错误的技能%s分类%s",id,ca or "nil")
		return
	end

	skills[id] = skill
	id_list[#id_list + 1] = id

	if ca == Superior then 
		-- 如果这个技能是高级技能,则在这个技能生效之前移除低级技能的效果
		local bIsAdvanced,nBasicID = PS_IsAdvanced(id)
		if bIsAdvanced then
			local tBasicSkill = skills[nBasicID]
			if tBasicSkill and not tBasicSkill:isRemoved() then
				tBasicSkill:removeEffect(self.owner)
				tBasicSkill:setValid(false)
			end
			skill:setValid(true)
			skill:makeEffect(self.owner)
		end
		--- 如果这个技能是低级技能,则只有在无高级技能时候才能生效
		local bIsBasic,nAdvanceID = PS_IsBasic(id)
		if bIsBasic then
			local tAdvanceSkill = skills[nAdvanceID]
			if not tAdvanceSkill or tAdvanceSkill:isRemoved() then
				skill:setValid(true)
				skill:makeEffect(self.owner)
			else
				skill:setValid(false)
			end
		end
	else
		skill:setValid(true)
		skill:makeEffect(self.owner)
	end

	if not skill:getOrdinal() then
		local ordinal = self.ordinalMax + 1
		self.ordinalMax = ordinal
		skill:setOrdinal(ordinal)
	end
	self:pushFresh({
		skillID = id,
		category = ca,
		ordinal = skill:getOrdinal(),
	})
end

local _tClear = {false}
function PetSkillHandler:removeSkill(skillID)
	local skills = self.skills
	local skill = skillID and skills[skillID]
	if not skill or skill:isRemoved() then
		return false
	end
	skill:setRemoved(true)
	
	if skill:getCategory() == Superior then
		-- 如果技能是高级技能,则在移除该技能效果后使低级技能效果生效
		local bIsAdvanced,nBasicID = PS_IsAdvanced(skillID)
		if bIsAdvanced then
			local tBasicSkill = skills[skillID]
			if tBasicSkill and not tBasicSkill:isRemoved() then
				tBasicSkill:setValid(true)
				tBasicSkill:makeEffect(self.owner)
			end
		end
		-- 如果技能是低级技能,则只有在无有效高级技能时候才能移除技能效果
		-- ... 好像不用呢,有设置有效的标记,无效的技能也无法移除技能效果
	end
	skill:removeEffect(self.owner)
	skill:setValid(false)
	
	_tClear[1] = skillID
	Subtract(self.categories[skill:getCategory()],_tClear)
	self:pushPassed(skillID)
end

-- 移除一个ID数组中所有的技能
function PetSkillHandler:removeAll(tID)
	if not tID then return end

	local skills = self.skills
	local owner = self.owner
	local cache = {}

	for _,id in ipairs(tID) do
		local skill = skills[id]
		if skill and not skill:isRemoved()  then
			skill:setRemoved(true)
			if skill:isValid() then
				skill:removeEffect(owner)
				skill:setValid(false)
			end

			self:pushPassed(id)
			cache[#cache + 1] = id
		end
	end

	local lists = self.categories
	Subtract(lists[Superior],cache)
	Subtract(lists[Basic],cache)
end

function PetSkillHandler:removeAllBasic()
	self:removeAll(table_copy(self:getAll(Basic)))
end

function PetSkillHandler:removeAllSuperior()
	local tLearn = PetStudyDB[self.owner:getConfigID()]
	local tGod = tLearn and tLearn.God
	local tRemove = table_copy(self:getAll(Superior))
	if tGod then
		Subtract(tRemove,tGod)
	end
	self:removeAll(tRemove)
end

-- 精简基础技能,在宠物等级下降时候
local _tOverOwn = {}
function PetSkillHandler:retrimBasic()
	local owner = self.owner
	local tLearn = PetStudyDB[owner:getConfigID()]
	local ownerLevel = owner:getLevel()

	local skills = self.skills
	local nCount = 0
	for _,data in ipairs(tLearn.Basic) do
		local id,lvl = unpack(data)
		if skills[id] and ownerLevel < lvl then
			nCount = nCount + 1
			_tOverOwn[nCount] = id
		end
	end
	if nCount > 0 then
		_tOverOwn[nCount + 1] = nil
		self:removeAll(_tOverOwn)
	end
end

-- 宠物创建时候添加天赋技能
function PetSkillHandler:acquireTalent()
	local data = PetStudyDB[self.owner:getConfigID()]
	if not data then
		notice("%s没有配置学习技能",self.owner:getConfigID() or "nil")
		return
	end

	local number = 0
	local rate = math_random(1,100) -- 暂时将获得多个技能的概率定高点
	if rate < 2 then
		number = 4
	elseif rate < 7 then
		number = 3
	elseif rate < 22 then
		number = 2
	elseif rate < 52 then
		number = 1
	end

	local sup = data.Superior
	print("该宠物创建时候,能获得%d个高级技能",nSurAcquired)
	if sup then
		local _next = NonRepeatIndex(#sup)
		while number > 0 do
			local index = _next()
			if index < 1 then break end
			self:addSkill(
				PetSkill(sup[index][1],Superior)
			)
			number = number - 1	
		end
	end

	local god = data.God
	if god then
		for _,id in ipairs(god) do
			self:addSkill(
				PetSkill(id,Superior)
			)
		end
	end
end

-- 宠物上线时候添加基础技能
function PetSkillHandler:acquireBasic()
	local owner = self.owner
	local configID  = owner:getConfigID()
	local tLearn = PetStudyDB[configID]
	if not tLearn then
		notice("宠物%s没有配置技能学习",config)
		return
	end

	local ownerLevel = owner:getLevel()
	local tBasic = tLearn.Basic
	if tBasic then
		for _,config in ipairs(tBasic) do
			local id,lvl = unpack(config)
			if lvl <= ownerLevel and not self:getSkill(id) then
				self:addSkill(
					PetSkill(id,Basic)
				)
			end
		end
	end
end

-- 宠物还童时候获得随机技能
function PetSkillHandler:acquireRandom()
	self:removeAllSuperior()
	local number = 0
	local rate = math_random(1,100) -- 暂时将获得多个技能的概率定高点
	if rate < 2 then
		number = 4
	elseif rate < 7 then
		number = 3
	elseif rate < 22 then
		number = 2
	elseif rate < 52 then
		number = 1
	end

	local tLearn = PetStudyDB[self.owner:getConfigID()]
	if not tLearn then
		notice("宠物还童时候,宠物%s没有配置技能学习表",self.owner:getConfigID() or "没有配置ID")
	end
	local tSuperior = tLearn.Superior
	local _next = NonRepeatIndex(#tSuperior)
	while number > 0 do
		local index = _next()
		if index < 1 then break end

		local id = tSuperior[index]
		local prev = self:getSkill(id)
		if not prev or prev:isRemoved() then
			self:addSkill(
				PetSkill(id,Superior)
			)
			number = number - 1
		end
	end
end

function PetSkillHandler:initDefault()
	local tLearn = PetStudyDB[self.owner:getConfigID()]
	if not tLearn then
		notice("宠物没有配置技能学习",self.owner:getConfigID())
		return
	end

	local tGod = tLearn.God
	if tGod then
		self:setMaxSkill(4 + #tGod)
	else
		self:setMaxSkill(4)
	end
	self:acquireTalent()
	self:acquireBasic()
end

-- 宠物升级时候添加宠物随等级提升而开发开放的基础技能
-- 和在新技能等级下使技能生效
function PetSkillHandler:handlePetLevelUP()
	local owner = self.owner
	local skills = self.skills
	for _,skill in pairs(skills) do
		skill:makeEffect(owner)
	end

	self:acquireBasic()
	self:sendFreshs()
end

-- 保存宠物技能
function PetSkillHandler:onSave(param,tick)
	param['spName']     = "sp_UpdatePetSkill"
	param['sort']       = "pid,sid,cate,ord,rmd"

	param['pid']        = self.owner:getDBID()
	for id,skill in pairs(self.skills) do
		param['sid']    = id
		param['cate']   = skill:getCategory()
		param['ord']    = skill:getOrdinal()
		param['rmd']	= skill:isRemoved()

		tick()
	end

	return true
end

-- 获得发送给客户端的所有技能信息
function PetSkillHandler:getFull()
	local all = {}
	for _,skill in pairs(self.skills) do
		if not skill:isRemoved() then
			rawset(all,#all + 1,{
			  skillID = skill:getID(),
			  category = skill:getCategory(),
			  ordinal = skill:getOrdinal()
		})
		end
	end
	return all
end

-- 添加一个日志
function PetSkillHandler:makeLog(logName)
	local log = rawget(self,logName)
	if not log then
		log = {}
		rawset(self,logName,log)
	end
	return log
end

-- 删除并返回这个日志
function PetSkillHandler:clearLog(logName)
	local log = rawget(self,logName)
	if log then
		rawset(self,logName,nil)
	end
	return log
end

-- 添加新技能日志信息
function PetSkillHandler:pushFresh(ooxx)
	if ooxx then
		local log = self:makeLog("new_skills")
		rawset(log,#log + 1,ooxx)
	end
end

-- 返回新技能日志信息
function PetSkillHandler:popFreshs()
	return self:clearLog("new_skills")
end

-- 添加技能遗忘日志信息
function PetSkillHandler:pushPassed(xxoo)
	if xxoo then
		local log = self:makeLog("passed_skills")
		rawset(log,#log + 1,xxoo)
	end
end

-- 返回技能遗忘信息
function PetSkillHandler:popPassed()
	return self:clearLog("passed_skills")
end

-- 发送所有技能信息到客户端
function PetSkillHandler:sendFull(player)
	self:popFreshs()
	local owner = self.owner
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(PetEvent_SC_SkillsArrived,owner:getID(),self:getFull()),
		player or g_entityMgr:getPlayerByID(owner:getOwnerID())
	)
end

-- 发送所有新技能信息到客户端
function PetSkillHandler:sendFreshs(player)
	local freshs = self:popFreshs()
	if freshs then
		local owner = self.owner
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_SkillsArrived,owner:getID(),freshs),
			player or g_entityMgr:getPlayerByID(owner:getOwnerID())
		)
	end
end

-- 发送所有遗忘技能信息到客户端
function PetSkillHandler:sendPassed(player)
	local passed = self:popPassed()
	if passed then
		local owner = self.owner
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(PetEvent_SC_SkillForgotten,owner:getID(),passed),
			player or g_entityMgr:getPlayerByID(owner:getOwnerID())
		)
	end
end

-- 能否阅读技能书并添加一个技能
function PetSkillHandler:canRead(itemID)
	local detail = itemID and tWarrantDB[itemID]
	if not detail or detail.SubClass ~= ItemSubClass.SkillBook then
		return PetError.NoSuchBook
	end
	local skillID = detail.ReactExtraParam1
	local access,errCode = self:canAddSkill(skillID)
	return access and 0 or errCode
end

-- 阅读技能书
function PetSkillHandler:readBook(itemID)
	local detail = tWarrantDB[itemID]
	local skillID = detail.ReactExtraParam1
	
	local tLearn = PetStudyDB[self.owner:getConfigID()]
	local tGod = tLearn.God

	local all = self:getAll(Superior)

	local rate = 0	-- 失去技能的概率
	if tGod then
		rate = 1 / (math_pow( 2 , #all - #tGod - 1 ))
	else
		rate = 1 / (math_pow(2 , #all - 1))
	end
	if rate > 1 then rate = 1 end

	local replacedID
	-- 将会移除一个已经掌握的技能
	if rate < math_random() or self:isFull() then
		if tGod then
			all = Subtract(table_copy(all),tGod)
		end
		if #all > 0 then
			if #all == 1 then
				replacedID = all[1]
			else
				replacedID = all[math_random(1,#all)]
			end
		end
	end
	if replacedID then
		self:removeSkill(replacedID)
	end
	self:addSkill(PetSkill(skillID,Superior))

	return skillID,replacedID
end

function PetSkillHandler:get_skills()
	local ownerLevel = self.owner:getLevel()
	local ret = {}
	for _,skill in pairs(self.skills) do
		if not skill:isRemoved() and skill:isValid() then
			ret[skill:getID()] = ownerLevel
		end
	end
	return ret
end
