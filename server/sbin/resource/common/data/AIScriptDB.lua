--[[ AIScriptDB.lua]]

AIScriptDB = {}

AIScriptDB[1] = function(role,targets)

					local finalTargets
					local enemySide = FightUtils.getEnemySide(role)
					finalTargets = targets[enemySide]
					local target = FightUtils.findRandomTarget(finalTargets)
					return FightUIType.CommonAttack,target,CommonSkillID
				end

