--[[FightSkillDB.lua
描述：角色技能表现
	--战斗技能

	]]

FightSkillDB = {

     [10101] = {
	          -- name = "游龙惊鸿",
	          -- icon = "set:SkillIcon1 image:youlongjinghong",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 14,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10102] = {
	          -- name = "枪动山河",
	          -- icon = "set:SkillIcon1 image:qiangdongshanhe",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 15,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [10103] = {
	          -- name = "金刚附体",
	          -- icon = "set:SkillIcon1 image:jingangfuti",
	          skill_type = Skill_Type.Tranform,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 1,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 17,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10104] = {
	          -- name = "霸王举鼎",
	          -- icon = "set:SkillIcon1 image:bawangjuding",
	          skill_type = Skill_Type.Tranform,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 2,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 17,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10201] = {
	          -- name = "一夫当关",
	          -- icon = "set:SkillIcon1 image:yifudangguan",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 3,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10202] = {
	          -- name = "一骑当千",
	          -- icon = "set:SkillIcon1 image:yijidangqian",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 3,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [10301] = {
	          -- name = "百炼成钢",
	          -- icon = "set:SkillIcon1 image:bailianchenggang",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 4,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10302] = {
	          -- name = "渊停岳峙",
	          -- icon = "set:SkillIcon1 image:yuantingyuezhi",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 5,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [10401] = {
	          -- name = "太岳无形",
	          -- icon = "set:SkillIcon1 image:taiyuewuxing",
	          skill_type = Skill_Type.Passive,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.SoilAt,
	                     num_id = 18,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10402] = {
	          -- name = "无欲则刚",
	          -- icon = "set:SkillIcon1 image:wuyuzegang",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 6,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10403] = {
	          -- name = "平沙落雁",
	          -- icon = "set:SkillIcon1 image:pingshaluoyan",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 7,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [10501] = {
	          -- name = "同仇敌忾",
	          -- icon = "set:SkillIcon1 image:tongchoudikai(jinxiashan)",
	          skill_type = Skill_Type.UnionHit,
	          consume_type = ConsumeType.Anger,
	          consume_id = 10,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.UnionHit,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10502] = {
	          -- name = "怒荡苍穹",
	          -- icon = "set:SkillIcon1 image:nudangcangqiong",
	          skill_type = Skill_Type.Ultimate,
	          consume_type = ConsumeType.Anger,
	          consume_id = 11,
	          phase_type = PhaseType.Soil,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 20,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 21,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10601] = {
	          -- name = "地遁术",
	          -- icon = "set:SkillIcon1 image:didunshu",
	          skill_type = Skill_Type.Transport,
	          consume_type = ConsumeType.Mp,
	          consume_id = 12,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Transport,
	                     num_id = nil,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [10602] = {
	          -- name = "坤元咒",
	          -- icon = "set:SkillIcon1 image:kunyuanzhou",
	          skill_type = Skill_Type.ToolMake,
	          consume_type = ConsumeType.vit,
	          consume_id = 13,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ToolMake,
	                     num_id = 55,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20101] = {
	          -- name = "怒马凌关",
	          -- icon = "set:SkillIcon1 image:numalingguan",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 22,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20102] = {
	          -- name = "霸刀无极",
	          -- icon = "set:SkillIcon1 image:badaowuji",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 23,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [20103] = {
	          -- name = "潜龙出海",
	          -- icon = "set:SkillIcon1 image:qianlongchuhai",
	          skill_type = Skill_Type.Gathering,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          phase_type = PhaseType.Fire,
	          cool_round = 3,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 8,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.At,
	                     num_id = 24,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20104] = {
	          -- name = "先发夺人",
	          -- icon = "set:SkillIcon1 image:xianfaduoren",
	          skill_type = Skill_Type.BuffDmg,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          phase_type = PhaseType.Fire,
	          cool_round = 3,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 25,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Buff,
	                     num_id = 9,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20201] = {
	          -- name = "醉生梦死",
	          -- icon = "set:SkillIcon1 image:zuishengmengsi",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 10,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20202] = {
	          -- name = "魂飞魄散",
	          -- icon = "set:SkillIcon1 image:hunfeiposan",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 10,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [20301] = {
	          -- name = "勇不可当",
	          -- icon = "set:SkillIcon1 image:yongbukedang",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 11,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20302] = {
	          -- name = "气吞山河",
	          -- icon = "set:SkillIcon1 image:qitunshanhe",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 12,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [20401] = {
	          -- name = "怒火中烧",
	          -- icon = "set:SkillIcon1 image:nuhuozhongshao",
	          skill_type = Skill_Type.Passive,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.FireAt,
	                     num_id = 18,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20402] = {
	          -- name = "烈火燎原",
	          -- icon = "set:SkillIcon1 image:liehuoliaoyuan",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 13,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20403] = {
	          -- name = "火凤涅槃",
	          -- icon = "set:SkillIcon1 image:huofengniepan",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 14,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [20501] = {
	          -- name = "同仇敌忾",
	          -- icon = "set:SkillIcon1 image:tongchoudikai(qianyuandao)",
	          skill_type = Skill_Type.UnionHit,
	          consume_type = ConsumeType.Anger,
	          consume_id = 10,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.UnionHit,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20502] = {
	          -- name = "凤舞九天",
	          -- icon = "set:SkillIcon1 image:fengwujiutian",
	          skill_type = Skill_Type.Ultimate,
	          consume_type = ConsumeType.Anger,
	          consume_id = 11,
	          phase_type = PhaseType.Fire,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 26,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20601] = {
	          -- name = "火遁术",
	          -- icon = "set:SkillIcon1 image:huodunshu",
	          skill_type = Skill_Type.Transport,
	          consume_type = ConsumeType.Mp,
	          consume_id = 12,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Transport,
	                     num_id = nil,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [20602] = {
	          -- name = "辟火咒",
	          -- icon = "set:SkillIcon1 image:pihuozhou",
	          skill_type = Skill_Type.ToolMake,
	          consume_type = ConsumeType.vit,
	          consume_id = 13,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ToolMake,
	                     num_id = 55,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30101] = {
	          -- name = "流星夺月",
	          -- icon = "set:SkillIcon1 image:liuxingduoyue",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.At,
	                     num_id = 27,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30102] = {
	          -- name = "穿云落日",
	          -- icon = "set:SkillIcon1 image:chuanyunluori",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
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
	         }, 
     },
     [30103] = {
	          -- name = "穿心夺魄",
	          -- icon = "set:SkillIcon1 image:chuanxinduopo",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          cool_round = 3,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 15,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30104] = {
	          -- name = "箭震九州",
	          -- icon = "set:SkillIcon1 image:jianzhenjiuzhou",
	          skill_type = Skill_Type.Arrows,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          phase_type = PhaseType.Wind,
	          cool_round = 3,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.AddCrit,
	                     num_id = 29,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.At,
	                     num_id = 30,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	              }, 
	         }, 
     },
     [30201] = {
	          -- name = "魂不守舍",
	          -- icon = "set:SkillIcon1 image:hunbushoushe",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30202] = {
	          -- name = "神魂颠倒",
	          -- icon = "set:SkillIcon1 image:shenhundiandao",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [30301] = {
	          -- name = "暴风聚雨",
	          -- icon = "set:SkillIcon1 image:baofengjuyu",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 17,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30302] = {
	          -- name = "势若疯虎",
	          -- icon = "set:SkillIcon1 image:shiruofenghu",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 18,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [30401] = {
	          -- name = "狂风扫林",
	          -- icon = "set:SkillIcon1 image:kuangfengsaolin",
	          skill_type = Skill_Type.Passive,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.WindAt,
	                     num_id = 18,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30402] = {
	          -- name = "风流云散",
	          -- icon = "set:SkillIcon1 image:fengliuyunsan",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 19,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30403] = {
	          -- name = "清风拂岗",
	          -- icon = "set:SkillIcon1 image:qingfengfugang",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 20,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [30501] = {
	          -- name = "同仇敌忾",
	          -- icon = "set:SkillIcon1 image:tongchoudikai(ziyangmen)",
	          skill_type = Skill_Type.UnionHit,
	          consume_type = ConsumeType.Anger,
	          consume_id = 10,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.UnionHit,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30502] = {
	          -- name = "天地同寿",
	          -- icon = "set:SkillIcon1 image:tianditongshou",
	          skill_type = Skill_Type.Ultimate,
	          consume_type = ConsumeType.Anger,
	          consume_id = 11,
	          phase_type = PhaseType.Wind,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.AddCrit,
	                     num_id = 31,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.At,
	                     num_id = 32,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [30601] = {
	          -- name = "风遁术",
	          -- icon = "set:SkillIcon1 image:fengdunshu",
	          skill_type = Skill_Type.Transport,
	          consume_type = ConsumeType.Mp,
	          consume_id = 12,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Transport,
	                     num_id = nil,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [30602] = {
	          -- name = "避风咒",
	          -- icon = "set:SkillIcon1 image:bifengzhou",
	          skill_type = Skill_Type.ToolMake,
	          consume_type = ConsumeType.vit,
	          consume_id = 13,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ToolMake,
	                     num_id = 55,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40101] = {
	          -- name = "紫气东来",
	          -- icon = "set:SkillIcon1 image:ziqidonglai",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 33,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40102] = {
	          -- name = "石破天惊",
	          -- icon = "set:SkillIcon1 image:shipotianjing",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          phase_type = PhaseType.Ice,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 34,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [40103] = {
	          -- name = "神农佑体",
	          -- icon = "set:SkillIcon1 image:shennongyouti",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 21,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40104] = {
	          -- name = "起死回生",
	          -- icon = "set:SkillIcon1 image:qisihuisheng",
	          skill_type = Skill_Type.Revival,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Revival,
	                     num_id = 35,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 53,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	             [3] = { 
	                     type = SkillEff.MpHeal,
	                     num_id = 54,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40201] = {
	          -- name = "冰天雪地",
	          -- icon = "set:SkillIcon1 image:bingtianxuedi",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 22,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40202] = {
	          -- name = "冰封万里",
	          -- icon = "set:SkillIcon1 image:bingfengwanli",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 22,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [40301] = {
	          -- name = "金针渡劫",
	          -- icon = "set:SkillIcon1 image:jinzhendujie",
	          skill_type = Skill_Type.Heal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 36,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40302] = {
	          -- name = "慈航普度",
	          -- icon = "set:SkillIcon1 image:cihangpudu",
	          skill_type = Skill_Type.Heal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 37,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [40401] = {
	          -- name = "冰寒彻骨",
	          -- icon = "set:SkillIcon1 image:binghanchegu",
	          skill_type = Skill_Type.Passive,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.IceAt,
	                     num_id = 18,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40402] = {
	          -- name = "冰肌玉骨",
	          -- icon = "set:SkillIcon1 image:bingjiyugu",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 23,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40403] = {
	          -- name = "冰魂素魄",
	          -- icon = "set:SkillIcon1 image:binghunsupo",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 24,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [40501] = {
	          -- name = "同仇敌忾",
	          -- icon = "set:SkillIcon1 image:tongchoudikai(penglaige)",
	          skill_type = Skill_Type.UnionHit,
	          consume_type = ConsumeType.Anger,
	          consume_id = 10,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.UnionHit,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40502] = {
	          -- name = "沧海桑田",
	          -- icon = "set:SkillIcon1 image:canghaisangtian",
	          skill_type = Skill_Type.Ultimate,
	          consume_type = ConsumeType.Anger,
	          consume_id = 11,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.HpHeal,
	                     num_id = 38,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [40601] = {
	          -- name = "水遁术",
	          -- icon = "set:SkillIcon1 image:shuidunshu",
	          skill_type = Skill_Type.Transport,
	          consume_type = ConsumeType.Mp,
	          consume_id = 12,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Transport,
	                     num_id = nil,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [40602] = {
	          -- name = "冰心咒",
	          -- icon = "set:SkillIcon1 image:bingxinzhou",
	          skill_type = Skill_Type.ToolMake,
	          consume_type = ConsumeType.vit,
	          consume_id = 13,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ToolMake,
	                     num_id = 55,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50101] = {
	          -- name = "游龙戏凤",
	          -- icon = "set:SkillIcon1 image:youlongxifeng",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 41,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50102] = {
	          -- name = "金蛇狂舞",
	          -- icon = "set:SkillIcon1 image:jinshekuangwu",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 42,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [50103] = {
	          -- name = "闻风丧胆",
	          -- icon = "set:SkillIcon1 image:wenfengsangdan",
	          skill_type = Skill_Type.Dispel,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
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
	         }, 
     },
     [50104] = {
	          -- name = "夺魂摄魄",
	          -- icon = "set:SkillIcon1 image:duohunshepo",
	          skill_type = Skill_Type.Dispel,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
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
	         }, 
     },
     [50201] = {
	          -- name = "附骨之疽",
	          -- icon = "set:SkillIcon1 image:fuguzhiju",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 25,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50202] = {
	          -- name = "万毒攻心",
	          -- icon = "set:SkillIcon1 image:wandugongxin",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 25,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [50301] = {
	          -- name = "迅影疾行",
	          -- icon = "set:SkillIcon1 image:xunyingjixing",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 26,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50302] = {
	          -- name = "神行百变",
	          -- icon = "set:SkillIcon1 image:shenxingbaibian",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 27,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [50401] = {
	          -- name = "见血封喉",
	          -- icon = "set:SkillIcon1 image:jianxuefenghou",
	          skill_type = Skill_Type.Passive,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.PoisonAt,
	                     num_id = 18,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50402] = {
	          -- name = "以毒攻毒",
	          -- icon = "set:SkillIcon1 image:yidugongdu",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 28,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50403] = {
	          -- name = "百毒不侵",
	          -- icon = "set:SkillIcon1 image:baidubuqin",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 29,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [50501] = {
	          -- name = "同仇敌忾",
	          -- icon = "set:SkillIcon1 image:tongchoudikai(taoyuandong)",
	          skill_type = Skill_Type.UnionHit,
	          consume_type = ConsumeType.Anger,
	          consume_id = 10,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.UnionHit,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50502] = {
	          -- name = "万物同悲",
	          -- icon = "set:SkillIcon1 image:wanwutongbei",
	          skill_type = Skill_Type.Ultimate,
	          consume_type = ConsumeType.Anger,
	          consume_id = 11,
	          phase_type = PhaseType.Poison,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 45,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	             [2] = { 
	                     type = SkillEff.Buff,
	                     num_id = 30,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [50601] = {
	          -- name = "云遁术",
	          -- icon = "set:SkillIcon1 image:yundunshu",
	          skill_type = Skill_Type.Transport,
	          consume_type = ConsumeType.Mp,
	          consume_id = 12,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Transport,
	                     num_id = nil,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [50602] = {
	          -- name = "驱毒咒",
	          -- icon = "set:SkillIcon1 image:qudushu",
	          skill_type = Skill_Type.ToolMake,
	          consume_type = ConsumeType.vit,
	          consume_id = 13,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ToolMake,
	                     num_id = 55,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60101] = {
	          -- name = "雷霆万钧",
	          -- icon = "set:SkillIcon1 image:leitingwanjun",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 46,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60102] = {
	          -- name = "五雷轰顶",
	          -- icon = "set:SkillIcon1 image:wuleihongding",
	          skill_type = Skill_Type.Normal,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          phase_type = PhaseType.Thunder,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 47,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	             [2] = { 
	                     type = SkillEff.Pursue,
	                     num_id = 16,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [60103] = {
	          -- name = "散元摧命",
	          -- icon = "set:SkillIcon1 image:sanyuancuiming",
	          skill_type = Skill_Type.ReduceMp,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ReduceMp,
	                     num_id = 48,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60104] = {
	          -- name = "釜底抽薪",
	          -- icon = "set:SkillIcon1 image:fudichouxin",
	          skill_type = Skill_Type.ReduceMp,
	          consume_type = ConsumeType.Mp,
	          consume_id = 9,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ReduceMp,
	                     num_id = 49,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 3,
	              }, 
	         }, 
     },
     [60201] = {
	          -- name = "黯然销魂",
	          -- icon = "set:SkillIcon1 image:anranxiaohun",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 31,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60202] = {
	          -- name = "潜龙勿用",
	          -- icon = "set:SkillIcon1 image:qianlongwuyong",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 31,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [60301] = {
	          -- name = "返本归元",
	          -- icon = "set:SkillIcon1 image:fanbenguiyuan",
	          skill_type = Skill_Type.Heal,
	          consume_type = ConsumeType.Hp,
	          consume_id = 7,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.MpHeal,
	                     num_id = 50,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60302] = {
	          -- name = "九元归一",
	          -- icon = "set:SkillIcon1 image:jiuyuanguiyi",
	          skill_type = Skill_Type.Heal,
	          consume_type = ConsumeType.Hp,
	          consume_id = 8,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.MpHeal,
	                     num_id = 51,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [60401] = {
	          -- name = "天雷之怒",
	          -- icon = "set:SkillIcon1 image:tianleizhinu",
	          skill_type = Skill_Type.Passive,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ThunderAt,
	                     num_id = 18,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60402] = {
	          -- name = "罡雷护体",
	          -- icon = "set:SkillIcon1 image:gangleihuti",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 5,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 32,
	                     target_type = TargetType.friend,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60403] = {
	          -- name = "雷动九天",
	          -- icon = "set:SkillIcon1 image:leidongjiutian",
	          skill_type = Skill_Type.Buff,
	          consume_type = ConsumeType.Mp,
	          consume_id = 6,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Buff,
	                     num_id = 33,
	                     target_type = TargetType.friend_g,
	                     target_num_id = 2,
	              }, 
	         }, 
     },
     [60501] = {
	          -- name = "同仇敌忾",
	          -- icon = "set:SkillIcon1 image:tongchoudikai(yunxiaogong)",
	          skill_type = Skill_Type.UnionHit,
	          consume_type = ConsumeType.Anger,
	          consume_id = 10,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.UnionHit,
	                     num_id = 19,
	                     target_type = TargetType.enemy,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60502] = {
	          -- name = "移星换斗",
	          -- icon = "set:SkillIcon1 image:yixinghuandou",
	          skill_type = Skill_Type.Ultimate,
	          consume_type = ConsumeType.Anger,
	          consume_id = 11,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Mt,
	                     num_id = 52,
	                     target_type = TargetType.enemy_g,
	                     target_num_id = 4,
	              }, 
	         }, 
     },
     [60601] = {
	          -- name = "雷遁术",
	          -- icon = "set:SkillIcon1 image:leidunshu",
	          skill_type = Skill_Type.Transport,
	          consume_type = ConsumeType.Mp,
	          consume_id = 12,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.Transport,
	                     num_id = nil,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
     [60602] = {
	          -- name = "喑雷咒",
	          -- icon = "set:SkillIcon1 image:anleizhou",
	          skill_type = Skill_Type.ToolMake,
	          consume_type = ConsumeType.vit,
	          consume_id = 13,
	          skill = { 
	             [1] = { 
	                     type = SkillEff.ToolMake,
	                     num_id = 55,
	                     target_type = TargetType.self,
	                     target_num_id = 1,
	              }, 
	         }, 
     },
 }
