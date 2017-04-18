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
	          name = "ÄýÉñÑøÏ¢",
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
	          name = "×ÌÈóÍòÎï",
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
	          name = "ÁÒ·ç»÷",
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
	          name = "Æü·çÕ¶",
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
	          name = "·ç¾í²ÐÔÆ",
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
	          name = "·ç³Ûµç³¸",
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
	          name = "±¼À×Õ¶",
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
	          name = "¼²À×´Ì",
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
	          name = "·üÀ×È¦",
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
	          name = "ÌìÀ×ÆÆ",
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
	          name = "º®±ùÔÉ",
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
	          name = "Ðþ±ù´Ì",
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
	          name = "±ùÓê·ç±©",
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
	          name = "ÒõÈªº®±ù",
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
	          name = "¶ÜÍÁ´Ì",
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
	          name = "ÍÁ±ÀÍß½â",
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
	          name = "ÁùºÏºñÍÁ",
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
	          name = "ÐÈÍÁÓ­Ãæ",
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
	          name = "ÐÇ»ð×¹",
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
	          name = "¸Ö»ð¾÷",
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
	          name = "µÀÉú»ð",
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
	          name = "ÎÞÍýÌì»ð",
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
	          name = "´ã¶¾Ö®ÈÐ",
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
	          name = "¾ç¶¾Ë®¼ý",
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
	          name = "¶¾Ë¿¹íÌÙ",
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
	          name = "Íò¹ÆÆæ¶¾",
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
	          name = "Ç§´¸°ÙÁ¶",
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
	          name = "µÀÐþÃ÷Ãð",
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
	          name = "ÓÎÁú¾ªºè",
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
	          name = "Ç¹¶¯É½ºÓ",
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
	          name = "Å­ÂíÁè¹Ø",
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
	          name = "°Ôµ¶ÎÞ¼«",
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
	          name = "Á÷ÐÇ¶áÔÂ",
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
	          name = "´©ÔÆÂäÈÕ",
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
	          name = "×ÏÆø¶«À´",
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
	          name = "Ê¯ÆÆÌì¾ª",
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
	          name = "ÓÎÁúÏ··ï",
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
	          name = "½ðÉß¿ñÎè",
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
	          name = "À×öªÍò¾û",
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
	          name = "ÎåÀ×ºä¶¥",
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
	          name = "ÆðËÀ»ØÉú",
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
	          name = "ÆÕ¶ÉÖÚÉú",
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
	          name = "¹íº×Ö®¶¾",
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
	          name = "ÎåÎÁ×÷ÂÒ",
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
	          name = "¹Æ»óÈËÐÄ",
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
	          name = "É¥ÐÄ²¡¿ñ",
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
	          name = "ÑªÆø·ÐÌÚ",
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
	          name = "Ä§Ñª³åÂö",
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
	          name = "×Ô±©×ÔÆú",
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
	          name = "µßµ¹Ç¬À¤",
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
	          name = "À×öªÍò¾û",
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
	          name = "ÓÎÁú¾ªºè",
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
	          name = "Ç¹¶¯É½ºÓ",
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
	          name = "½ð¸Õ¸½Ìå",
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
	          name = "°ÔÍõ¾Ù¶¦",
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
	          name = "Ò»·òµ±¹Ø",
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
	          name = "Ò»Æïµ±Ç§",
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
	          name = "°ÙÁ¶³É¸Ö",
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
	          name = "Ô¨Í£ÔÀÖÅ",
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
	          name = "ÎÞÓûÔò¸Õ",
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
	          name = "Æ½É³ÂäÑã",
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
	          name = "Å­ÂíÁè¹Ø",
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
	          name = "°Ôµ¶ÎÞ¼«",
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
	          name = "Ç±Áú³öº£",
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
	          name = "ÏÈ·¢¶áÈË",
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
	          name = "×íÉúÃÎËÀ",
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
	          name = "»ê·ÉÆÇÉ¢",
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
	          name = "ÓÂ²»¿Éµ±",
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
	          name = "ÆøÍÌÉ½ºÓ",
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
	          name = "ÁÒ»ðÁÇÔ­",
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
	          name = "»ð·ïÄù˜„",
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
	          name = "Á÷ÐÇ¶áÔÂ",
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
	          name = "´©ÔÆÂäÈÕ",
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
	          name = "´©ÐÄ¶áÆÇ",
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
	          name = "¼ýÕð¾ÅÖÝ",
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
	          name = "»ê²»ÊØÉá",
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
	          name = "Éñ»êµßµ¹",
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
	          name = "±©·ç¾ÛÓê",
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
	          name = "ÊÆÈô·è»¢",
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
	          name = "·çÁ÷ÔÆÉ¢",
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
	          name = "Çå·ç·÷¸Ú",
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
	          name = "×ÏÆø¶«À´",
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
	          name = "Ê¯ÆÆÌì¾ª",
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
	          name = "ÉñÅ©ÓÓÌå",
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
	          name = "ÆðËÀ»ØÉú",
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
	          name = "±ùÌìÑ©µØ",
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
	          name = "±ù·âÍòÀï",
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
	          name = "½ðÕë¶É½Ù",
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
	          name = "´Èº½ÆÕ¶È",
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
	          name = "±ù¼¡Óñ¹Ç",
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
	          name = "±ù»êËØÆÇ",
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
	          name = "ÓÎÁúÏ··ï",
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
	          name = "½ðÉß¿ñÎè",
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
	          name = "ÎÅ·çÉ¥µ¨",
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
	          name = "¶á»êÉãÆÇ",
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
	          name = "¸½¹ÇÖ®¾Ò",
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
	          name = "Íò¶¾¹¥ÐÄ",
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
	          name = "Ñ¸Ó°¼²ÐÐ",
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
	          name = "ÉñÐÐ°Ù±ä",
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
	          name = "ÒÔ¶¾¹¥¶¾",
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
	          name = "°Ù¶¾²»ÇÖ",
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
	          name = "À×öªÍò¾û",
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
	          name = "ÎåÀ×ºä¶¥",
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
	          name = "É¢Ôª´ÝÃü",
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
	          name = "¸ªµ×³éÐ½",
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
	          name = "÷öÈ»Ïú»ê",
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
	          name = "Ç±ÁúÎðÓÃ",
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
	          name = "·µ±¾¹éÔª",
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
	          name = "¾ÅÔª¹éÒ»",
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
	          name = "î¸À×»¤Ìå",
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
	          name = "À×¶¯¾ÅÌì",
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
	          name = "µØ¶¯É½Ò¡",
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
	          name = "¶¾ÆøÈëÇÖ",
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
	          name = "³àÑæºéÁ÷ ",
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
	          name = "Òõ·çÅ­ºÅ",
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
	          name = "»Ø·ç½£",
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
	          name = "º®±ù´Ì¹Ç",
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
	          name = "Áè·ç´Ì",
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
	          name = "¼á±ÚÇåÒ°",
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
	          name = "»¤ÌåÌìî¸",
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
	          name = "Ìì½µÉñÍþ",
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
