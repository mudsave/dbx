--[[MonsterSkillDB.lua
描述：怪物技能
	]]

MonsterSkillDB = {

     [1001] = {
	          name = "大地回春",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 62,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1002] = {
	          name = "凝神养息",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 62,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1003] = {
	          name = "滋润万物",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 63,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1004] = {
	          name = "烈风击",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1005] = {
	          name = "泣风斩",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1006] = {
	          name = "风卷残云",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1007] = {
	          name = "风驰电掣",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1008] = {
	          name = "奔雷斩",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1009] = {
	          name = "疾雷刺",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1010] = {
	          name = "伏雷圈",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1011] = {
	          name = "天雷破",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1012] = {
	          name = "寒冰陨",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1013] = {
	          name = "玄冰刺",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1014] = {
	          name = "冰雨风暴",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1015] = {
	          name = "阴泉寒冰",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1016] = {
	          name = "盾土刺",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1017] = {
	          name = "土崩瓦解",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1018] = {
	          name = "六合厚土",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1019] = {
	          name = "腥土迎面",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1020] = {
	          name = "星火坠",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1021] = {
	          name = "钢火诀",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1022] = {
	          name = "道生火",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1023] = {
	          name = "无妄天火",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1024] = {
	          name = "淬毒之刃",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1025] = {
	          name = "剧毒水箭",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1026] = {
	          name = "毒丝鬼藤",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1027] = {
	          name = "万蛊奇毒",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1028] = {
	          name = "千锤百炼",
	          skill_type = Skill_Type.Normal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1029] = {
	          name = "道玄明灭",
	          skill_type = Skill_Type.Normal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1030] = {
	          name = "游龙惊鸿",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1031] = {
	          name = "枪动山河",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1032] = {
	          name = "怒马凌关",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1033] = {
	          name = "霸刀无极",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1034] = {
	          name = "流星夺月",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1035] = {
	          name = "穿云落日",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1036] = {
	          name = "紫气东来",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1037] = {
	          name = "石破天惊",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1038] = {
	          name = "游龙戏凤",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1039] = {
	          name = "金蛇狂舞",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1040] = {
	          name = "雷霆万钧",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1041] = {
	          name = "五雷轰顶",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1042] = {
	          name = "起死回生",
	          skill_type = Skill_Type.Revival,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 62,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1043] = {
	          name = "普渡众生",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 67,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1044] = {
	          name = "鬼鹤之毒",
	          skill_type = Skill_Type.BuffDmg,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 63,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1045] = {
	          name = "五瘟作乱",
	          skill_type = Skill_Type.BuffDmg,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 63,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1046] = {
	          name = "蛊惑人心",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 67,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1047] = {
	          name = "丧心病狂",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 67,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1048] = {
	          name = "血气沸腾",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 66,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1049] = {
	          name = "魔血冲脉",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 46,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1050] = {
	          name = "自暴自弃",
	          skill_type = Skill_Type.Buff,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 29,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1051] = {
	          name = "颠倒乾坤",
	          skill_type = Skill_Type.Buff,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1052] = {
	          name = "雷霆万钧",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1053] = {
	          name = "游龙惊鸿",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 14,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1054] = {
	          name = "枪动山河",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 15,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1055] = {
	          name = "金刚附体",
	          skill_type = Skill_Type.Tranform,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 1,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 17,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1056] = {
	          name = "霸王举鼎",
	          skill_type = Skill_Type.Tranform,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 2,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 17,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1057] = {
	          name = "一夫当关",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 3,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1058] = {
	          name = "一骑当千",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 3,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1059] = {
	          name = "百炼成钢",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 4,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1060] = {
	          name = "渊停岳峙",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 5,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1061] = {
	          name = "无欲则刚",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 6,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1062] = {
	          name = "平沙落雁",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 7,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1063] = {
	          name = "怒马凌关",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 22,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1064] = {
	          name = "霸刀无极",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 23,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1065] = {
	          name = "潜龙出海",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = nil,
	                     num_id = 8,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     num_id = 24,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1066] = {
	          name = "先发夺人",
	          skill_type = Skill_Type.BuffDmg,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 25,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = SkillEff.Buff,
	                     num_id = 9,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1067] = {
	          name = "醉生梦死",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 10,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1068] = {
	          name = "魂飞魄散",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 10,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1069] = {
	          name = "勇不可当",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 11,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1070] = {
	          name = "气吞山河",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 12,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1071] = {
	          name = "烈火燎原",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 13,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1072] = {
	          name = "火凤涅槃",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 14,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1073] = {
	          name = "流星夺月",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 27,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1074] = {
	          name = "穿云落日",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 28,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1075] = {
	          name = "穿心夺魄",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 15,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1076] = {
	          name = "箭震九州",
	          skill_type = Skill_Type.Arrows,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 30,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = SkillEff.AddCrit,
	                     num_id = 29,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1077] = {
	          name = "魂不守舍",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1078] = {
	          name = "神魂颠倒",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1079] = {
	          name = "暴风聚雨",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 17,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1080] = {
	          name = "势若疯虎",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 18,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1081] = {
	          name = "风流云散",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 19,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1082] = {
	          name = "清风拂岗",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 20,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1083] = {
	          name = "紫气东来",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 33,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1084] = {
	          name = "石破天惊",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 34,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1085] = {
	          name = "神农佑体",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 21,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1086] = {
	          name = "起死回生",
	          skill_type = Skill_Type.Revival,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 35,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 53,
	                     target_type = nil,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1087] = {
	          name = "冰天雪地",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 22,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1088] = {
	          name = "冰封万里",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 22,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1089] = {
	          name = "金针渡劫",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 36,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1090] = {
	          name = "慈航普度",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 37,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1091] = {
	          name = "冰肌玉骨",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 23,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1092] = {
	          name = "冰魂素魄",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 24,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1093] = {
	          name = "游龙戏凤",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 41,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1094] = {
	          name = "金蛇狂舞",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 42,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1095] = {
	          name = "闻风丧胆",
	          skill_type = Skill_Type.Dispel,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 43,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = SkillEff.Dispel,
	                     num_id = 39,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1096] = {
	          name = "夺魂摄魄",
	          skill_type = Skill_Type.Dispel,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 44,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = SkillEff.Dispel,
	                     num_id = 40,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1097] = {
	          name = "附骨之疽",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 25,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1098] = {
	          name = "万毒攻心",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 25,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1099] = {
	          name = "迅影疾行",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 26,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1100] = {
	          name = "神行百变",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 27,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1101] = {
	          name = "以毒攻毒",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 28,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1102] = {
	          name = "百毒不侵",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 29,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1103] = {
	          name = "雷霆万钧",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 46,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1104] = {
	          name = "五雷轰顶",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 47,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1105] = {
	          name = "散元摧命",
	          skill_type = Skill_Type.ReduceMp,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.ReduceMp,
	                     num_id = 48,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1106] = {
	          name = "釜底抽薪",
	          skill_type = Skill_Type.ReduceMp,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.ReduceMp,
	                     num_id = 49,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1107] = {
	          name = "黯然销魂",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 31,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1108] = {
	          name = "潜龙勿用",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 31,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1109] = {
	          name = "返本归元",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.MpHeal,
	                     num_id = 50,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1110] = {
	          name = "九元归一",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.MpHeal,
	                     num_id = 51,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1111] = {
	          name = "罡雷护体",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 32,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1112] = {
	          name = "雷动九天",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 33,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1113] = {
	          name = "地动山摇",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1114] = {
	          name = "毒气入侵",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 41,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1115] = {
	          name = "赤焰洪流 ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 22,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1116] = {
	          name = "阴风怒号",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 28,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1117] = {
	          name = "回风剑",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1118] = {
	          name = "寒冰刺骨",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1119] = {
	          name = "凌风刺",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1201] = {
	          name = "坚壁清野",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 48,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1202] = {
	          name = "护体天罡",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 49,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
     [1203] = {
	          name = "天降神威",
	          skill_type = Skill_Type.Buff,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 41,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	                 },
	                 [2] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [3] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	                 [4] = { 
	                     type = nil,
	                     target_type = nil,
	                 },
	             },
	         },
 }
