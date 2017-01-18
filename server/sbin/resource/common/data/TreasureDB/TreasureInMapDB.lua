--[[TreasureInMapDB.lua
描述：随机场景配置
]]
--[[
	-- 第一个值场景ID,第二个值是权重
	MapValues = {{MapID = 10,Weight = 100},}
]]
tTreasureInMapDB = {

     [1] = {
	     MapValues = { 
	         {MapID = 101, Weight = 50, limitLevel = 10}, 
	         {MapID = 102, Weight = 30, limitLevel = 20}, 
	         {MapID = 104, Weight = 100, limitLevel = 30}, 
	     }, 
	 }, 
     [2] = {
	     MapValues = { 
	         {MapID = 104, Weight = 50, limitLevel = 10}, 
	         {MapID = 106, Weight = 30, limitLevel = 20}, 
	         {MapID = 107, Weight = 100, limitLevel = 40}, 
	     }, 
	 }, 
}
