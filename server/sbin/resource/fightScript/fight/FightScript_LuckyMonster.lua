--[[FightScript_LuckyMonster.lua
描述：
	脚本战斗(瑞兽降福)
--]]

require "base.base"


FightScript_LuckyMonster = class(FightScript)


function FightScript_LuckyMonster:__init(scriptID)
	self._mainMonsterDBID = self._scriptPrototype.majorMonsterInfo[1].ID
	self._playerLevel = nil --玩家代表等级(组队的话是队长等级)
	self._deadInfo = {n={},m={},cur={}}--n={[DBID]=次数},m={[DBID]=次数/2}
end

function FightScript_LuckyMonster:_removeMinorMonsters()
	local monsters = self._members[FightStand.B]
	for _,monster in pairs(monsters) do
		local dbID = monster:getDBID()
		if dbID ~= self._mainMonsterDBID then
			self:removeRole(monster,false)
		end
	end
end

function FightScript_LuckyMonster:updateMonsterDeadInfo(DBID)
	local info = self._deadInfo.cur
	if not info[DBID] then
		info[DBID] = 1
	else
		info[DBID] = info[DBID] + 1
	end
end

function FightScript_LuckyMonster:updateMonsterDeadInfoSum()
	local nInfo = self._deadInfo.n
	local mInfo = self._deadInfo.m
	local info = self._deadInfo.cur
	for DBID, count in pairs(info) do
		if not nInfo[DBID] then
			nInfo[DBID] = count
		else
			nInfo[DBID] = nInfo[DBID] + count
		end

		local mCount =  math.floor(count/2)
		if mCount > 0 then
			if not mInfo[DBID] then
				mInfo[DBID] = mCount
			else
				mInfo[DBID] = mInfo[DBID] + mCount
			end
		end

	end
	table.clear(info)
end

function FightScript_LuckyMonster:getDeadMonsterInfo()
	return self._deadInfo
end

function FightScript_LuckyMonster:_getPlayerLevel()
	local roles = self._members[FightStand.A]
	local level = 1
	for _,role in pairs(roles) do
		if instanceof(role, FightPlayer) then
			level = role:getLevel()
			if role:getIsTeamHead() then
				return level
			end
		end
	end
	return level
end



function FightScript_LuckyMonster:refreshMonsters()
	self:_removeMinorMonsters()
	local minorMonsters = FightUtils.getMinorMonsters(self._scriptPrototype)
	
	local playerLvl = self._playerLevel
	if not playerLvl then
		playerLvl = self:_getPlayerLevel()
	end

	local fightMonsters = {}
	for _, DBID in pairs(minorMonsters) do
		local monster = g_fightEntityFactory:createMonster(DBID, false, playerLvl)
		table.insert(fightMonsters, monster)
	end

	local monsterCount = #fightMonsters 
	for _,monster in ipairs(fightMonsters) do
		local pos = self:getRolePos(StandRoleType.Monster, FightStand.B, monsterCount)
		if pos then
			self:addRole(FightStand.B, pos, monster)
		end
	end

end

function FightScript_LuckyMonster:addMinorMonsters2Results()
	local unchanged={}
	local ResultRefeshMembers = {actionType = FightActionType.System ,type = ScriptFightActionType.RefreshMembers,params = {monsters = {},unchanged=unchanged,}}
	local monsters = self._members[FightStand.B]
	local newMonsters = {}
	for _,monster in pairs(monsters) do
		local dbID = monster:getDBID()
		if dbID ~= self._mainMonsterDBID then
			table.insert(newMonsters, monster)
		else
			table.insert(unchanged,monster:getID())
		end
	end
	local params = ResultRefeshMembers.params
	FightUtils.setMonsterInfo4Client(newMonsters,params.monsters,nil)
	FightUtils.insertFightResult(self,ResultRefeshMembers,false)
end
function FightScript_LuckyMonster:__release()
	
end


