--[[PetSkillDB.lua
描述：宠物技能现
	]]

PetSkillDB = {

     [101] = {
	          name = "天生神力",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 11,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [102] = {
	          name = "力破千军",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 12,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [103] = {
	          name = "金声玉振",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 13,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [104] = {
	          name = "天浪贯右",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 14,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [105] = {
	          name = "雷霆万击",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 15,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [106] = {
	          name = "怒荡苍穹",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [107] = {
	          name = "疾风之怒",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 17,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [108] = {
	          name = "风云残卷",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 18,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [109] = {
	          name = "风起云涌",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [110] = {
	          name = "阴风怒号",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 20,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [111] = {
	          name = "焚风阵阵",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 21,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [112] = {
	          name = "风掣惊虹",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 22,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [113] = {
	          name = "风云突变",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.WindAt,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [114] = {
	          name = "御风神罡",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.WindResist,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [115] = {
	          name = "雷霆一击",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 25,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [116] = {
	          name = "雷霆万钧",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 26,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [117] = {
	          name = "奔雷疾电",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 27,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [118] = {
	          name = "九天玄雷",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 28,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [119] = {
	          name = "电闪雷鸣",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 29,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [120] = {
	          name = "鸣雷断空",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 30,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [121] = {
	          name = "雷劲奔袭",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ThunderAt,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [122] = {
	          name = "天罡雷鸣",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ThunderResist,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [123] = {
	          name = "寒冰入骨",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 33,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [124] = {
	          name = "冰雨箭矢",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 34,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [125] = {
	          name = "冰肌玉肤",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 35,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [126] = {
	          name = "六合幺冰",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 36,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [127] = {
	          name = "冰魂雪魄",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 37,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [128] = {
	          name = "冰雨凌天",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 38,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [129] = {
	          name = "冰封千里",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.IceAt,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [130] = {
	          name = "冰霜光环",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.IceResist,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [131] = {
	          name = "土之殇天",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 41,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [132] = {
	          name = "土崩瓦解",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 42,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [133] = {
	          name = "腥土迎面",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 43,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [134] = {
	          name = "簸土扬沙",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 44,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [135] = {
	          name = "践土食毛",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 45,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [136] = {
	          name = "撮土焚香",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 46,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [137] = {
	          name = "土龙刍狗",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.SoilAt,
	                     num_id = 5,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [138] = {
	          name = "土扶成墙",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.SoilResist,
	                     num_id = 5,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [139] = {
	          name = "烈火燎原",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 49,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [140] = {
	          name = "火焚乌巢",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 50,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [141] = {
	          name = "烛龙孽火",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 51,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [142] = {
	          name = "天火陨星",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 52,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [143] = {
	          name = "三味真火",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 53,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [144] = {
	          name = "业火红莲",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 54,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [145] = {
	          name = "煽风点火",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.FireAt,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [146] = {
	          name = "八荒烈火",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.FireResist,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [147] = {
	          name = "淬毒之刃",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 57,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [148] = {
	          name = "毒云弥漫",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 58,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [149] = {
	          name = "毒刃封心",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 59,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [150] = {
	          name = "毒气熏天",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 60,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [151] = {
	          name = "毒血蔓延",
	          consume_type = ConsumeType.Mp,
	          consume_id = 10,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 61,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [152] = {
	          name = "万蛊奇毒",
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill_type = PetSkillType.Normal,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 62,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [153] = {
	          name = "毒化鞭击",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PoisonAt,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [154] = {
	          name = "毒丝鬼藤",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PoisonResist,
	                     num_id = 5,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1001] = {
	          name = "反击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.NormalStrikeBack,
	                     num_id = 65,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.NormalStrikeBackValue,
	                     num_id = 66,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1002] = {
	          name = "高级反击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.NormalStrikeBack,
	                     num_id = 67,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.NormalStrikeBackValue,
	                     num_id = 68,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1003] = {
	          name = "反震",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.CounterFight,
	                     num_id = 69,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.CounterFightValue,
	                     num_id = 70,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1004] = {
	          name = "高级反震",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.CounterFight,
	                     num_id = 71,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.CounterFightValue,
	                     num_id = 72,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1005] = {
	          name = "法术反击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalStrikeBack,
	                     num_id = 73,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.MagicalStrikeBackValue,
	                     num_id = 74,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1006] = {
	          name = "高级法术反击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalStrikeBack,
	                     num_id = 75,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.MagicalStrikeBackValue,
	                     num_id = 76,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1007] = {
	          name = "吸血",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PATWithBloodSucking,
	                     num_id = 77,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1008] = {
	          name = "高级吸血",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PATWithBloodSucking,
	                     num_id = 78,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1009] = {
	          name = "连击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalPursuit,
	                     num_id = 79,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.PhysicalATKChangeValue,
	                     num_id = 80,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1010] = {
	          name = "高级连击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalPursuit,
	                     num_id = 81,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.PhysicalATKChangeValue,
	                     num_id = 82,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1011] = {
	          name = "再生",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.RoundHpHeal,
	                     num_id = 83,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1012] = {
	          name = "高级再生",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.RoundHpHeal,
	                     num_id = 84,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1013] = {
	          name = "冥思",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.RoundMpHeal,
	                     num_id = 85,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1014] = {
	          name = "高级冥思",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.RoundMpHeal,
	                     num_id = 86,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1015] = {
	          name = "慧根",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MpConsumeReduce,
	                     num_id = 87,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1016] = {
	          name = "高级慧根",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MpConsumeReduce,
	                     num_id = 88,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1017] = {
	          name = "必杀",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalATCritAdd,
	                     num_id = 89,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1018] = {
	          name = "高级必杀",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalATCritAdd,
	                     num_id = 90,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1019] = {
	          name = "幸运",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.CritImmune,
	                     num_id = 91,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1020] = {
	          name = "高级幸运",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.CritImmune,
	                     num_id = 92,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.MagicalATDodge,
	                     num_id = 93,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1021] = {
	          name = "神迹",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.RoundDeBuffDispel,
	                     num_id = 94,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1022] = {
	          name = "高级神迹",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.RoundDeBuffDispel,
	                     num_id = 95,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1023] = {
	          name = "招架",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalATDodge,
	                     num_id = 96,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1024] = {
	          name = "高级招架",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalATDodge,
	                     num_id = 97,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1025] = {
	          name = "永恒",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.AcceptAssistRoundAdd,
	                     num_id = 98,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1026] = {
	          name = "高级永恒",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.AcceptAssistRoundAdd,
	                     num_id = 99,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1027] = {
	          name = "敏捷",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Speed,
	                     num_id = 100,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1028] = {
	          name = "高级敏捷",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Speed,
	                     num_id = 101,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1029] = {
	          name = "强力",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.At,
	                     num_id = 102,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.Mt,
	                     num_id = 103,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1030] = {
	          name = "高级强力",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.At,
	                     num_id = 104,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.Mt,
	                     num_id = 105,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1031] = {
	          name = "防御",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Af,
	                     num_id = 106,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.Mf,
	                     num_id = 107,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1032] = {
	          name = "高级防御",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Af,
	                     num_id = 108,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.Mf,
	                     num_id = 109,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1033] = {
	          name = "强壮",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MaxHp,
	                     num_id = 110,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1034] = {
	          name = "高级强壮",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MaxHp,
	                     num_id = 111,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1035] = {
	          name = "刚毅",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MaxMp,
	                     num_id = 112,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1036] = {
	          name = "高级刚毅",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MaxMp,
	                     num_id = 113,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1037] = {
	          name = "偷袭",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.CounterFightImmune,
	                     num_id = 114,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.StrikeBackImmune,
	                     num_id = 115,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.AllATKChangeValue,
	                     num_id = 116,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1038] = {
	          name = "高级偷袭",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.CounterFightImmune,
	                     num_id = 117,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.StrikeBackImmune,
	                     num_id = 118,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.AllATKChangeValue,
	                     num_id = 119,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1039] = {
	          name = "魔之心",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalATKChangeValue,
	                     num_id = 120,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1040] = {
	          name = "高级魔之心",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalATKChangeValue,
	                     num_id = 121,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1041] = {
	          name = "涅槃",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Revival,
	                     num_id = 122,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.HPHealValue,
	                     num_id = 123,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1042] = {
	          name = "高级涅槃",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Revival,
	                     num_id = 124,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.HPHealValue,
	                     num_id = 125,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1043] = {
	          name = "破防",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithBreakDefense,
	                     num_id = 126,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.BreakDefenseBuff,
	                     num_id = 64,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.ATDmgIncValue,
	                     num_id = 127,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1044] = {
	          name = "高级破防",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithBreakDefense,
	                     num_id = 128,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.BreakDefenseBuff,
	                     num_id = 64,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.ATDmgIncValue,
	                     num_id = 129,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1045] = {
	          name = "重伤",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithInjured,
	                     num_id = 130,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.InjuredBuff,
	                     num_id = 65,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.AllATKChangeValue,
	                     num_id = 131,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1046] = {
	          name = "高级重伤",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithInjured,
	                     num_id = 132,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.InjuredBuff,
	                     num_id = 65,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.AllATKChangeValue,
	                     num_id = 133,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1047] = {
	          name = "法术连击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalPursuit,
	                     num_id = 134,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1048] = {
	          name = "高级法术连击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalPursuit,
	                     num_id = 135,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1049] = {
	          name = "法术暴击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalATCrit,
	                     num_id = 136,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.MagicalATDmgChangeValue,
	                     num_id = 137,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1050] = {
	          name = "高级法术暴击",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalATCrit,
	                     num_id = 138,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.MagicalATDmgChangeValue,
	                     num_id = 139,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1051] = {
	          name = "法术波动",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalATDmgFluctuate,
	                     num_id = 140,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1052] = {
	          name = "高级法术波动",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalATDmgFluctuate,
	                     num_id = 141,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1053] = {
	          name = "法术抵抗",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalDEFChangeValue,
	                     num_id = 142,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.PhysicalATKChangeValue,
	                     num_id = 143,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1054] = {
	          name = "高级法术抵抗",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalDEFChangeValue,
	                     num_id = 144,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.PhysicalATKChangeValue,
	                     num_id = 145,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1055] = {
	          name = "迟钝",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Speed,
	                     num_id = 146,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1056] = {
	          name = "高级迟钝",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.Speed,
	                     num_id = 147,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1057] = {
	          name = "风攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.WindAt,
	                     num_id = 148,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1058] = {
	          name = "高级风攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.WindAt,
	                     num_id = 149,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1059] = {
	          name = "雷攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ThunderAt,
	                     num_id = 150,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1060] = {
	          name = "高级雷攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ThunderAt,
	                     num_id = 151,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1061] = {
	          name = "冰攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.IceAt,
	                     num_id = 152,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1062] = {
	          name = "高级冰攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.IceAt,
	                     num_id = 153,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1063] = {
	          name = "土攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.SoilAt,
	                     num_id = 154,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1064] = {
	          name = "高级土攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.SoilAt,
	                     num_id = 155,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1065] = {
	          name = "火攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.FireAt,
	                     num_id = 156,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1066] = {
	          name = "高级火攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.FireAt,
	                     num_id = 157,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1067] = {
	          name = "毒攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PoisonAt,
	                     num_id = 158,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1068] = {
	          name = "高级毒攻",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PoisonAt,
	                     num_id = 159,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1069] = {
	          name = "抗风",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.WindResist,
	                     num_id = 160,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1070] = {
	          name = "高级抗风",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.WindResist,
	                     num_id = 161,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1071] = {
	          name = "抗雷",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ThunderResist,
	                     num_id = 162,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1072] = {
	          name = "高级抗雷",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ThunderResist,
	                     num_id = 163,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1073] = {
	          name = "抗冰",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.IceResist,
	                     num_id = 164,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1074] = {
	          name = "高级抗冰",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.IceResist,
	                     num_id = 165,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1075] = {
	          name = "抗土",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.SoilResist,
	                     num_id = 166,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1076] = {
	          name = "高级抗土",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.SoilResist,
	                     num_id = 167,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1077] = {
	          name = "抗火",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.FireResist,
	                     num_id = 168,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1078] = {
	          name = "高级抗火",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.FireResist,
	                     num_id = 169,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1079] = {
	          name = "抗毒",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PoisonResist,
	                     num_id = 170,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1080] = {
	          name = "高级抗毒",
	          consume_type = nil,
	          skill_type = PetSkillType.AttrPassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PoisonResist,
	                     num_id = 171,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1081] = {
	          name = "法术免疫",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalDmgImmune,
	                     num_id = 172,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1082] = {
	          name = "高级法术免疫",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalDmgImmune,
	                     num_id = 173,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1083] = {
	          name = "汲取物伤",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalDmgReduce,
	                     num_id = 174,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1084] = {
	          name = "高级汲取物伤",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhysicalDmgReduce,
	                     num_id = 175,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1085] = {
	          name = "汲取法伤",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalDmgReduce,
	                     num_id = 176,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1086] = {
	          name = "高级汲取法伤",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.MagicalDmgReduce,
	                     num_id = 177,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1087] = {
	          name = "相性免疫",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhaseDmgImmune,
	                     num_id = 178,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1088] = {
	          name = "高级相性免疫",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhaseDmgImmune,
	                     num_id = 179,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1089] = {
	          name = "汲取相攻",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhaseDmgReduce,
	                     num_id = 180,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1090] = {
	          name = "高级汲取相攻",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.PhaseDmgReduce,
	                     num_id = 181,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1091] = {
	          name = "提神",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.AcceptHealEffectInc,
	                     num_id = 182,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1092] = {
	          name = "高级提神",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.AcceptHealEffectInc,
	                     num_id = 183,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1093] = {
	          name = "气血转化",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.DmgImmuneConvertToHp,
	                     num_id = 184,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.DmgConvertToHpValue,
	                     num_id = 185,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1094] = {
	          name = "高级气血转化",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.DmgImmuneConvertToHp,
	                     num_id = 186,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.DmgConvertToHpValue,
	                     num_id = 187,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1095] = {
	          name = "法术汲取",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithMpSucking,
	                     num_id = 188,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1096] = {
	          name = "高级法术汲取",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithMpSucking,
	                     num_id = 189,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1097] = {
	          name = "法术流失",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithMpOutflow,
	                     num_id = 190,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1098] = {
	          name = "高级法术流失",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ATWithMpOutflow,
	                     num_id = 191,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1099] = {
	          name = "以法续命",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ReplaceHpWithMp,
	                     num_id = 192,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.ReplaceHpWithMpValue,
	                     num_id = 193,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1100] = {
	          name = "高级以法续命",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.ReplaceHpWithMp,
	                     num_id = 194,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.ReplaceHpWithMpValue,
	                     num_id = 195,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1101] = {
	          name = "开天",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.DmgIncORHpHeal,
	                     num_id = 196,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.HPHealProb,
	                     num_id = 197,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.HPHealValue,
	                     num_id = 198,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [4] = { 
	                     type = PetPassiveEffect.ATDmgIncValue,
	                     num_id = 199,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [1102] = {
	          name = "超级开天",
	          consume_type = nil,
	          skill_type = PetSkillType.StatePassive,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = PetPassiveEffect.DmgIncORHpHeal,
	                     num_id = 200,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = PetPassiveEffect.HPHealProb,
	                     num_id = 201,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = PetPassiveEffect.HPHealValue,
	                     num_id = 202,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [4] = { 
	                     type = PetPassiveEffect.ATDmgIncValue,
	                     num_id = 203,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2001] = {
	          name = "噬魂夺魄",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 39,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2002] = {
	          name = "魂飞魄散",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 40,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2003] = {
	          name = "风流云散",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 37,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2004] = {
	          name = "翻云覆雨",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 38,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2005] = {
	          name = "如影随形",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 35,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2006] = {
	          name = "敲骨吸髓",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 36,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2007] = {
	          name = "坚壁清野",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 48,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2008] = {
	          name = "护体天罡",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 49,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2009] = {
	          name = "天降神威",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 41,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2010] = {
	          name = "移花接木",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 50,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2011] = {
	          name = "龙吟虎啸",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 46,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2012] = {
	          name = "太岳镇魂",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 45,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2013] = {
	          name = "佛光闪现",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 47,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2014] = {
	          name = "一夫当关",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 42,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2015] = {
	          name = "士气大振",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 44,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2016] = {
	          name = "魅惑之术",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 43,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2017] = {
	          name = "如沐春风",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 51,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2018] = {
	          name = "鸣雷断空",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 52,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2019] = {
	          name = "冰封万里",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 53,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2020] = {
	          name = "土崩瓦解",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 54,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2021] = {
	          name = "无妄天火",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 55,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2022] = {
	          name = "毒刃封心",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 56,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2023] = {
	          name = "细雨微风",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 57,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2024] = {
	          name = "疾风迅雷",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 58,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2025] = {
	          name = "冰霜封印",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 59,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2026] = {
	          name = "六合厚土",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 60,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2027] = {
	          name = "劫火红莲",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 61,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [2028] = {
	          name = "荼毒生灵",
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill_type = PetSkillType.Buff,
	          phase_type = PhaseType.None,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 62,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
 }
