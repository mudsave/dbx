--[[TreasureEffectDB.lua
描述：宝藏效果配置
]]
--[[
-- 配置示例：
[50000] =
{
	-- 宝藏效果类型
	EventEffectType = TreasureEventEffectType.AddMoney,
	-- 不同的效果有不同的效果数值配置
	EventEffectValues = {
		{MinValue = 100, MaxValue = 200},
	},
},
]]
tTreasureEffectDB = {

     [1] = {
	     EventEffectType = TreasureEventEffectType.AddMoney,
	     EventEffectValues = { 
	         {MinValue = 20000, MaxValue = 200000, Weight = 90}, 
	         {MinValue = 500000, MaxValue = 500000, Weight = 10}, 
	     }, 
	 }, 
     [2] = {
	     EventEffectType = TreasureEventEffectType.AddExp,
	     EventEffectValues = { 
	     }, 
	 }, 
     [3] = {
	     EventEffectType = TreasureEventEffectType.AddTao,
	     EventEffectValues = { 
	         {MinValue = 27, MaxValue = 60, Weight = 100}, 
	     }, 
	 }, 
     [4] = {
	     EventEffectType = TreasureEventEffectType.AddPot,
	     EventEffectValues = { 
	         {MinValue = 20000, MaxValue = 100000, Weight = 100}, 
	     }, 
	 }, 
     [5] = {
	     EventEffectType = TreasureEventEffectType.AddItem,
	     EventEffectValues = { 
	         {ItemID = 1021004, Weight = 10}, 
	         {ItemID = 1021005, Weight = 10}, 
	         {ItemID = 1024005, Weight = 10}, 
	         {ItemID = 1024006, Weight = 10}, 
	         {ItemID = 1025003, Weight = 10}, 
	         {ItemID = 1031007, Weight = 50}, 
	     }, 
	 }, 
     [6] = {
	     EventEffectType = TreasureEventEffectType.MonsterFight,
	     EventEffectValues = { 
	         {FightScriptID = 40005, Weight = 35, limitLevel = 1}, 
	         {FightScriptID = 40006, Weight = 30, limitLevel = 1}, 
	         {FightScriptID = 40007, Weight = 30, limitLevel = 1}, 
	     }, 
	 }, 
     [7] = {
	     EventEffectType = TreasureEventEffectType.PlaceMonster,
	     EventEffectValues = { 
	         {NpcID = 50000, Weight = 25, TMapID = 1, TEventID = 15}, 
	         {NpcID = 50008, Weight = 25, TMapID = 1, TEventID = 15}, 
	         {NpcID = 50016, Weight = 25, TMapID = 1, TEventID = 15}, 
	         {NpcID = 50021, Weight = 25, TMapID = 1, TEventID = 15}, 
	     }, 
	 }, 
     [8] = {
	     EventEffectType = TreasureEventEffectType.AddMoney,
	     EventEffectValues = { 
	         {MinValue = 100000, MaxValue = 900000, Weight = 90}, 
	         {MinValue = 5000000, MaxValue = 5000000, Weight = 10}, 
	     }, 
	 }, 
     [9] = {
	     EventEffectType = TreasureEventEffectType.AddExp,
	     EventEffectValues = { 
	         {MinValue = 20000, MaxValue = 200000, Weight = 90}, 
	         {MinValue = 500000, MaxValue = 500000, Weight = 10}, 
	     }, 
	 }, 
     [10] = {
	     EventEffectType = TreasureEventEffectType.AddTao,
	     EventEffectValues = { 
	         {MinValue = 50, MaxValue = 100, Weight = 100}, 
	     }, 
	 }, 
     [11] = {
	     EventEffectType = TreasureEventEffectType.AddPot,
	     EventEffectValues = { 
	         {MinValue = 50000, MaxValue = 200000, Weight = 100}, 
	     }, 
	 }, 
     [12] = {
	     EventEffectType = TreasureEventEffectType.AddItem,
	     EventEffectValues = { 
	         {ItemID = 1021004, Weight = 20}, 
	         {ItemID = 1021005, Weight = 20}, 
	         {ItemID = 1024005, Weight = 20}, 
	         {ItemID = 1024006, Weight = 20}, 
	         {ItemID = 1025003, Weight = 20}, 
	     }, 
	 }, 
     [13] = {
	     EventEffectType = TreasureEventEffectType.MonsterFight,
	     EventEffectValues = { 
	         {FightScriptID = 40005, Weight = 35, limitLevel = 1}, 
	         {FightScriptID = 40006, Weight = 30, limitLevel = 1}, 
	         {FightScriptID = 40007, Weight = 30, limitLevel = 1}, 
	     }, 
	 }, 
     [14] = {
	     EventEffectType = TreasureEventEffectType.PlaceMonster,
	     EventEffectValues = { 
	         {NpcID = 50000, Weight = 25, TMapID = 1, TEventID = 15}, 
	         {NpcID = 50008, Weight = 25, TMapID = 1, TEventID = 15}, 
	         {NpcID = 50016, Weight = 25, TMapID = 1, TEventID = 15}, 
	         {NpcID = 50021, Weight = 25, TMapID = 1, TEventID = 15}, 
	     }, 
	 }, 
     [15] = {
	     EventEffectType = TreasureEventEffectType.AddTao,
	     EventEffectValues = { 
	         {MinValue = 50000, MaxValue = 50, Weight = 1}, 
	         {MinValue = 2, MaxValue = 50001, Weight = 50}, 
	         {MinValue = 1, MaxValue = 2, Weight = 50003}, 
	         {MinValue = 50, MaxValue = 1, Weight = 2}, 
	     }, 
	 }, 
}
