--[[TreasureDB.lua
描述：藏宝图配置
]]
--[[
-- 配置示例：
[50000] =
{
	-- 藏宝图ID，每种类都有各自的ID段，由策划分配
	ID = 1,
	-- 藏宝图的类别
	Type = 1
	-- 藏宝图对应的地图场景对应表的ID
	TMapID = 1
	-- 藏宝图的触发事件约定好第一个值是eventID,第二个值是weight
	TriggerEvents = { 
		{TEventID = 1,Weight = 100},
	},
},
]]
tTreasureDB = {

     [1] = {
	     ID = 1,
	     Type = TreasureType.Common,
	     TMapID = 1,
	     TriggerEvents = { 
	         {TEventID = 1, Weight = 15}, 
	         {TEventID = 2, Weight = 15}, 
	         {TEventID = 3, Weight = 15}, 
	         {TEventID = 4, Weight = 10}, 
	         {TEventID = 5, Weight = 15}, 
	         {TEventID = 6, Weight = 15}, 
	         {TEventID = 7, Weight = 15}, 
	     }, 
	 }, 
     [2] = {
	     ID = 2,
	     Type = TreasureType.HighGrade,
	     TMapID = 2,
	     TriggerEvents = { 
	         {TEventID = 8, Weight = 10}, 
	         {TEventID = 9, Weight = 10}, 
	         {TEventID = 10, Weight = 10}, 
	         {TEventID = 11, Weight = 20}, 
	         {TEventID = 12, Weight = 15}, 
	         {TEventID = 13, Weight = 20}, 
	         {TEventID = 14, Weight = 15}, 
	     }, 
	 }, 
}
