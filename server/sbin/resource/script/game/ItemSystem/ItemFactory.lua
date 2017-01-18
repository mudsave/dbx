--[[ItemFactory.lua
描述:
	道具工厂
]]

ItemFactory = class(nil, Singleton)

function ItemFactory:__init()
end

function ItemFactory:createEquipment(itemId, itemNum)
	if not tEquipmentDB[itemId] then
		-- 找不到装备定义
		return nil
	end

	local equipment = Equipment(itemId, itemNum)
	equipment:setGuid(createGUID(Item))

	return equipment
end

function ItemFactory:createWarrant(itemId, itemNum)
	if not tWarrantDB[itemId] then
		-- 找不到凭证定义
		return nil
	end

	local warrant = Warrant(itemId, itemNum)
	warrant:setGuid(createGUID(Item))

	return warrant
end

function ItemFactory:createMedicament(itemId, itemNum)
	if not tMedicamentDB[itemId] then
		-- 找不到药品定义
		return nil
	end

	local medicament = Medicament(itemId, itemNum)
	medicament:setGuid(createGUID(Item))

	return medicament
end

function ItemFactory.getInstance()
	return ItemFactory()
end
