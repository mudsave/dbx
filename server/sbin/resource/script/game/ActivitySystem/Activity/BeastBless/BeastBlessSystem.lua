--[[BeastBlessSystem.lua
瑞兽降临系统
]]

require "game.ActivitySystem.Activity.BeastBless.BeastBlessUtils"
require "game.ActivitySystem.Activity.BeastBless.Beast"
require "game.ActivitySystem.Activity.BeastBless.BeastBlessManager"

BeastBlessSystem = class(EventSetDoer, Singleton)

function BeastBlessSystem:__init()
	self._doer = 
	{
		[FightEvents_SS_FightEnd_afterClient]	= BeastBlessSystem.onFightEnd,
	}
end

-- 这里是瑞兽降临战斗结束
function BeastBlessSystem:onFightEnd(event)
	local params			= event:getParams()
	local fightEndResults	= params[1]	--战斗结果
	local scriptID			= params[2]	--脚本ID
	local monsterDBIDs		= params[3]	--怪物信息
	local fightID			= params[4]	--战斗ID
	local fightInfo			= params[5]	--战斗信息(如瑞兽降幅的怪物死亡统计信息)
	local bWin = false
	-- 如果没有这个配置
	if not ScriptFightDB[scriptID] then
		return
	end
	-- 没有瑞兽奖励配置不是这个接口
	if not ScriptFightDB[scriptID].LuckyRewardID then
		return
	end
	for playerID,isWin in pairs(fightEndResults) do
		bWin = isWin
		break
	end
	if bWin then
		-- 奖励计算
		print("fightEndResults2",toString(fightEndResults))
		g_beastBlessMgr:dealWithRewards(fightEndResults, scriptID, monsterDBIDs, fightID, fightInfo)
		-- 移除更新NPC
		local beast = g_beastBlessMgr:getBeastFromFlagList(scriptID)
		if beast then
			g_beastBlessMgr:removeBeastFromList(beast)
		end
	else
		-- 更新NPC标记
		g_beastBlessMgr:removeBeastFightFlagList(scriptID)
	end
end


function BeastBlessSystem.getInstance()
	return BeastBlessSystem()
end

EventManager.getInstance():addEventListener(BeastBlessSystem.getInstance())