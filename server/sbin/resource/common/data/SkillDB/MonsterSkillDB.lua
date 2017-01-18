--[[MonsterSkillDB.lua
ÃèÊö£º¹ÖÎï¼¼ÄÜ
	]]

MonsterSkillDB = {

     [1001] = {
	          name = "´óµØ»Ø´º",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
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
     [1002] = {
	          name = "ÄýÉñÑøÏ¢",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 13,
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
	          name = "×ÌÈóÍòÎï",
	          skill_type = Skill_Type.Heal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 14,
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
	          name = "ÁÒ·ç»÷",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "Æü·çÕ¶",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "·ç¾í²ÐÔÆ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "·ç³Ûµç³¸",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "±¼À×Õ¶",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "¼²À×´Ì",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "·üÀ×È¦",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "ÌìÀ×ÆÆ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "º®±ùÔÉ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "Ðþ±ù´Ì",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "±ùÓê·ç±©",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "ÒõÈªº®±ù",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "¶ÜÍÁ´Ì",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "ÍÁ±ÀÍß½â",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "ÁùºÏºñÍÁ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "ÐÈÍÁÓ­Ãæ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "ÐÇ»ð×¹",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "¸Ö»ð¾÷",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "µÀÉú»ð",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "ÎÞÍýÌì»ð",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "´ã¶¾Ö®ÈÐ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "¾ç¶¾Ë®¼ý",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "¶¾Ë¿¹íÌÙ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "Íò¹ÆÆæ¶¾",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "Ç§´¸°ÙÁ¶",
	          skill_type = Skill_Type.Normal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "µÀÐþÃ÷Ãð",
	          skill_type = Skill_Type.Normal,
	          phase_type = nil,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "ÓÎÁú¾ªºè",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "Ç¹¶¯É½ºÓ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.UnionHit,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "Å­ÂíÁè¹Ø",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "°Ôµ¶ÎÞ¼«",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "Á÷ÐÇ¶áÔÂ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
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
	          name = "´©ÔÆÂäÈÕ",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
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
	          name = "×ÏÆø¶«À´",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "Ê¯ÆÆÌì¾ª",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "ÓÎÁúÏ··ï",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "½ðÉß¿ñÎè",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
	          name = "À×öªÍò¾û",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 11,
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
	          name = "ÎåÀ×ºä¶¥",
	          skill_type = Skill_Type.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	                 [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 12,
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
 }
