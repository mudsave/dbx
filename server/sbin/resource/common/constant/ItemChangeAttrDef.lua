--[[
    ItemChangeAttrDef.lua 物品影响属性公式
]]
require "misc.constant"

ItemChangeAttrDef = {}

ItemChangeType  =
{
    Change_BindMoney    = 1,        --改变绑银
    Change_Money        = 2,        --改变银两
    Change_ExpValue     = 3,        --改变经验      
    Change_TaoValue     = 4,        --改变道行 
    Change_Potential    = 5,        --改变潜能
    Change_Expoint      = 6,        --改变历练
}

function ItemChangeAttrDef.Change_BindMoney(entity)
    local level = entity:getLevel()
    return math.floor(level*1 + 10)
end

function ItemChangeAttrDef.Change_Money(entity)
    local level = entity:getLevel()
    return math.floor(level*2 + 15)
end

function ItemChangeAttrDef.Change_ExpValue(entity)
    local level = entity:getLevel()
    return math.floor(level*1 + 12)
end

function ItemChangeAttrDef.Change_TaoValue(entity)
    local level = entity:getLevel()
    return math.floor(level*2 + 123)
end

function ItemChangeAttrDef.Change_Potential(entity)
    local level = entity:getLevel()
    return math.floor(level*2 + 123)
end

function ItemChangeAttrDef.Change_Expoint(entity)
    local level = entity:getLevel()
    return math.floor(level*10 + 123)
end

ItemEffectFuncs =
{
   [ItemChangeType.Change_BindMoney]    = ItemChangeAttrDef.Change_BindMoney,
   [ItemChangeType.Change_Money]        = ItemChangeAttrDef.Change_Money,        
   [ItemChangeType.Change_ExpValue]     = ItemChangeAttrDef.Change_ExpValue,
   [ItemChangeType.Change_TaoValue]     = ItemChangeAttrDef.Change_TaoValue,
   [ItemChangeType.Change_Potential]    = ItemChangeAttrDef.Change_Potential,
   [ItemChangeType.Change_Expoint]      = ItemChangeAttrDef.Change_Expoint,
}

