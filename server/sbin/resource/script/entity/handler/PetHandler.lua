-- PetHandler.lua
require "base.Array"

local table_sort		= table.sort
local array_subtract	= Array.subtract

local function notice(str,...)
	print( ("PetHandler:%s"):format( str and str:format(...) or "" ) )
end

local function toDo(str,...)
end

PetHandler = class()

function PetHandler:__init(owner)
	self.owner		= owner
	self.pet_map	= {}
	self.id_array	= {}
	self.follow		= false
	self.fight		= false
	self.ready		= false
end

-- 加载宠物记录
function PetHandler:loadDB(recordSet)
	if not recordSet then
		notice( "玩家 %s 没有宠物记录",self.owner:getName() )
		return false
	end

	local owner = self.owner
	local remains = 0
	local function __callback(record,pet)
		self:onPetLoaded(pet,record)

		remains = remains - 1
		if remains < 1 then
			self:onAllLoaded()
		end
	end

	for _,data in pairs(recordSet) do
		local pet = Pet(owner)

		pet:setPeer( CoEntity:Create( eLogicPet,eClsTypePet ) )

		pet:onLoad(data)

		remains = remains + 1

		pet:setEntityType(eLogicPet)
		g_entityMgr:addPet(pet)

		LuaDBAccess.LoadPet(pet,__callback)
	end
end

-- 查询一个宠物
function PetHandler:getPet(petID)
	return petID and self.pet_map[petID]
end

-- 添加一个宠物
function PetHandler:addPet(pet)
	if not pet then
		return false
	end

	local id = pet:getID()
	local map = self.pet_map

	if map[id] then
		return false
	end

	map[id] = pet

	local array = self.id_array
	array[#array + 1] = id

	pet:onAdded(self.owner)

	return true
end

-- 获得所有宠物
function PetHandler:getAll()
	return self.pet_map
end

-- 删除一个宠物

local _tClear = {0}

function PetHandler:removePet(petID)
	local map = self.pet_map
	local pet = petID and map[petID]
	if not pet then
		return false
	end
	
	pet:onRemoved(self.owner)

	map[petID] = nil
	_tClear[1] = petID
	array_subtract(self.id_array,_tClear)
	TaskCallBack.onRemovePet(self.owner:getID(), pet:getConfigID())
	return true
end

-- 获得宠物总数
function PetHandler:getAmount()
	return #(self.id_array)
end

-- 能否添加宠物
function PetHandler:canAddPet()
	return self:getAmount() < self.owner:getMaxPet()
end

-- 宠物所有数据加载完毕
function PetHandler:onPetLoaded(pet,recordList)
	pet:loadAttrs(recordList[1])

	local skillHandler = PetSkillHandler(pet)
	pet:addHandler(HandlerDef_Move,MoveHandler(pet))
	-- pet:addHandler(HandlerDef_Buff,BuffHandler(pet))
	pet:addHandler(HandlerDef_PetSkill,skillHandler)
	skillHandler:loadDB(recordList[2])
	pet:addHandler(HandlerDef_AutoPoint,AutoPointHandler(pet))
	-- 自动加点
	local pointHandler = pet:getHandler(HandlerDef_AutoPoint)
		toDo "添加自动加点"

	pointHandler:loadDB(recordList[3])
	if self:canAddPet() then
		self:addPet(pet)
	else
		notice "宠物数量超过最大数"
	end
end

-- 所有宠物加载完毕
function PetHandler:onAllLoaded()
	self:makeSort()

	local fight = self:getPet(self:getFightPetID())
	if fight then
		fight:setVisible(true)
	end
end

-- 玩家离线时候保存宠物
function PetHandler:onPlayerOffline()
	for id,pet in pairs(self.pet_map) do
		pet.removed = true
		LuaDBAccess.SavePet(pet)
		LuaDBAccess.SavePointSetting(pet)
	end
end

-- 宠物按照创建时间排序
function PetHandler:makeSort()
	local map = self.pet_map
	table_sort(self.id_array,function(a,d)
		return map[a]:getBirth() < map[d]:getBirth()
	end)
end

-- 玩家等级提升对宠物的影响
function PetHandler:onPlayerLevelUP(level)
	for id,pet in pairs(self.pet_map) do
		pet:onPlayerLevelUP(level)
	end
end

-- 获得最后捕捉到的某一个配置ID的宠物
function PetHandler:getLastCaught(configID)
	if not configID then return nil end
	local found
	for id,pet in pairs(self.pet_map) do
		if pet:getConfigID() == configID then
			if not found or pet:getBirth() < found:getBirth() then
				found = pet
			end
		end
	end
	return found
end

-- 跟随宠物,在场景中显示的宠物

function PetHandler:setFollowPetID(id)
	self.follow = id
end

function PetHandler:getFollowPetID()
	return self.follow
end

-- 出战宠物

function PetHandler:setFightPetID(id)
	self.fight = id
end

function PetHandler:getFightPetID()
	return self.fight
end

-- 掠阵宠物

function PetHandler:setReadyPetID(id)
	self.ready = id
end

function PetHandler:getReadyPetID()
	return self.ready
end

function PetHandler:handlePetLevelUP()
	for id,pet in pairs(self.pet_map) do
		pet:handlePetLevelUP()
	end
end
