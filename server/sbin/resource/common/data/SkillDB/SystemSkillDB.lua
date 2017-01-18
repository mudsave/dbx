--[[SystemSkillDB.lua
描述：
	
--]]

--战斗技能
SystemSkillDB = {
	[1] = {
		name = '模板',
		skill_type = Skill_Type.Normal,
		phase_type = PhaseType.Fire,--相性伤害
		cool_round = 2,--冷却回合
		skill = {
			[1] = {
				type = SkillEff.At, --子技能
				num_id = 3, --技能数值
				target_type = TargetType.enemy, --目标类型
				target_id = 5,--人数数值
			},
		},
	},
	[2] = {
		name = '单体物攻',
		skill_type = Skill_Type.Normal,
		skill = {
			[1] = {
				type = SkillEff.At,
				num_id = 3,
				target_type = TargetType.enemy,
			},
		}
	},
	[3] = {
		name = '群体物攻',
		skill_type = Skill_Type.Normal,
		skill = {
			[1] = {
				type = SkillEff.At,
				num_id = 3,
				target_type = TargetType.enemy_g,
				target_id = 3,
			},
		}
	},
	[4] = {
		name = '群体buff',
		skill_type = Skill_Type.Buff,
		skill = {
			[1] = {
				type = SkillEff.Buff,
				num_id = 7,
				target_type = TargetType.enemy_g,
				target_id = 3,
			},
		},
	},
	[5] = {
		name = '群体恢复hp+mp',
		skill_type = Skill_Type.Heal,
		skill = {
			[1] = {
				type = SkillEff.HpHeal,
				num_id = 8,
				target_type = TargetType.enemy_g,
				target_id = 3,
			},
			[2] = {
				type = SkillEff.MpHeal,
				num_id = 8,
				target_type = TargetType.enemy_g,
				target_id = 3,
			},
		},
	},
	[6] = {
		name = '群体驱散',
		skill_type = Skill_Type.Dispel,
		skill = {
			[1] = {
				type = SkillEff.Dispel,
				num_id = 15,
				target_type = TargetType.enemy_g,
				target_id = 3,
			},
		}
	},
}