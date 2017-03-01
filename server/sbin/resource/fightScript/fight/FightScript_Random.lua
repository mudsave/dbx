--[[FightScript_Random.lua
描述：
	脚本战斗
--]]

require "base.base"


FightScript_Random = class(FightScript)


function FightScript_Random:__init(scriptID)
	self._unpassedPhase ={}--[ID]=true
	self._passedCount = 0
	for ID,_ in pairs(self._scriptPrototype.phases ) do
		self._unpassedPhase[ID] = true
	end
	
end

function FightScript_Random:setPhaseID(phaseID)
	self._curPhase = phaseID
end

function FightScript_Random:getSystemActions()
			
	return self._scriptPrototype.phases[self._curPhase].systemActions
end

function FightScript_Random:_getRandomPhase()
	local phaseInfo = self._scriptPrototype.phases
	local count = table.size(self._unpassedPhase)
	if count > 0 then
		local rand = math.random(count)
		local i = 1
		for ID,_ in pairs(self._unpassedPhase) do
			if i == rand then
				return ID
			end
			i = i + 1
		end
	else
		return 0
	end
end
--[[
处理客户端播放动作完毕的事件
]]
function FightScript_Random:onPlayOver(params)
	--校验有效性
	--print("Fight:onPlayOver(params)",self._curWaitClientNum)
	self._curWaitClientNum = self._curWaitClientNum - 1
	if self._curWaitClientNum <= 0 then
		self:_informEscape()
		local bOver = self:_canFightEnd()
		--此阶段结束
		if bOver then
			local phaseInfo = self._scriptPrototype.phases
			if not self._scriptPrototype.isRepeat then
				self._unpassedPhase[self._curPhase] = nil
			end
			self._passedCount = self._passedCount + 1
			local nextPhase = self:_getRandomPhase()
			if self._passedCount >= self._scriptPrototype.count or nextPhase == 0 then
				self:gotoState(FightState.FightEnd)
				return
			end
			
			--有下一阶段(玩家赢)
			if self._winSide == FightStand.A and phaseInfo and phaseInfo[nextPhase] and #(phaseInfo[nextPhase].monsters)>0 then
				self:_clearMonsters()
				local fightMonsters = {}
				local monsterDBIDs = phaseInfo[nextPhase].monsters
				for _, DBID in pairs(monsterDBIDs) do
					local monster = g_fightEntityFactory:createMonster(DBID)
					table.insert(fightMonsters, monster)
				end
				g_fightFactory:initFightByMonsters(self,fightMonsters)
				self._curPhase = nextPhase
				self._roundCount = 0--回合清0
				self:gotoState(FightState.PhaseStart)
			--战斗结束
			else
				self:gotoState(FightState.FightEnd)
			end
			
			print("*************FightState.FightPhaseEnd",self._curPhase)
		else
			self:gotoState(FightState.RoundStart)
		end
	else
		local DBID = params[1]
		self:_informEscape(DBID)
	end
end



function FightScript_Random:__release()
	self._unpassedPhase = nil
end


