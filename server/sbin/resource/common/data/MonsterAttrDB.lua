--[[MonsterAttrDB.lua
描述：怪物公有属性值
	]]

--[[

	[1] =
	{
	       -- 能力描述
	       attrDesc = 高血物防,
	       -- 强度描述
	       strDesc = 弱鸡,
	       -- 生命
	       maxHP = 1000,
	       -- 物攻
	       at = 50,
	       -- 法攻
	       mt = 50,
	       -- 物防
	       af = 50,
	       -- 法防
	       mf = 50,
	       -- 命中
	       hit = 50,
	       -- 闪避
	       dodge = 50,
	       -- 暴击
	       crit = 50,
	       -- 抗暴
	       uncrit = 50,
	       -- 速度
	       speed = 50,
	       -- 道行
	       tao = 50,
	       -- 相攻击
	       phaseAt = 50,
	       -- 相防御
	       phaseDf = 50,
	       -- 障碍命中
	       obstacleHit = 50,
	       -- 障碍抗性
	       obstacleDefense = 50,
	       -- 属性增益1
	       attrBenefit1 = player_max_hp,
	       -- 加持类型1
	       attrAddType1 = AttrAddType.Value,
	       -- 效果数值1
	       attrEffVal1 = 100,
	       -- 属性增益2
	       attrBenefit2 = player_max_hp,
	       -- 加持类型2
	       attrAddType2 = AttrAddType.Value,
	       -- 效果数值2
	       attrEffVal2 = 100,
	       -- 属性增益3
	       attrBenefit3 = player_max_hp,
	       -- 加持类型3
	       attrAddType3 = AttrAddType.Value,
	       -- 效果数值3
	       attrEffVal3 = 100,
	       -- 属性增益4
	       attrBenefit4 = player_max_hp,
	       -- 加持类型4
	       attrAddType4 = AttrAddType.Value,
	       -- 效果数值4
	       attrEffVal4 = 100,
	},
--]]



AttributeList = {


     [1] = {
	     attrDesc = "一般",
	     strDesc = "弱鸡",
	     maxHP =168,
	     at =79.52,
	     mt = 79.52,
	     af = 1,
	     mf = 1,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 7,
	     tao = 36.645,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [2] = {
	     attrDesc = "一般",
	     strDesc = "普通",
	     maxHP =1009,
	     at =451.2,
	     mt = 451.2,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = 0.233,
	     phaseDf = 0.18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.06,
     },
     [3] = {
	     attrDesc = "一般",
	     strDesc = "弱鸡",
	     maxHP =168,
	     at =79.52,
	     mt = 79.52,
	     af = 1,
	     mf = 1,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 7,
	     tao = 36.645,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [4] = {
	     attrDesc = "一般",
	     strDesc = "普通",
	     maxHP =1009,
	     at =451.2,
	     mt = 451.2,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = 0.233,
	     phaseDf = 0.18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.06,
     },
     [5] = {
	     attrDesc = "",
	     maxHP =999999999,
	     at =1,
	     mt = 1,
	     af = 99999999,
	     mf = 99999999,
	     hit = 1,
	     dodge = 1,
	     crit = 1,
	     uncrit = 1,
	     speed = 1,
	     tao = 1,
	     phaseAt = 1,
	     phaseDf = 1,
	     obstacleHit = 1,
	     obstacleDefense = 999999999,
     },
     [6] = {
	     attrDesc = "",
	     maxHP =1,
	     at =1,
	     mt = 1,
	     af = 1,
	     mf = 1,
	     hit = 1,
	     dodge = 0,
	     crit = 1,
	     uncrit = 1,
	     speed = 1,
	     tao = 1,
	     phaseAt = 1,
	     phaseDf = 1,
	     obstacleHit = 1,
	     obstacleDefense = 99999999,
     },
     [501] = {
	     attrDesc = "高攻高血",
	     strDesc = "boss",
	     maxHP =1284.24,
	     at =675.54,
	     mt = 675.54,
	     af = 82.8285714285714,
	     mf = 82.8285714285714,
	     hit = 32.4,
	     dodge = 47.1578947368421,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 57.92,
	     tao = 117.264,
	     phaseAt = 0.373,
	     phaseDf = 0.3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.1,
     },
     [502] = {
	     attrDesc = "高攻物防",
	     strDesc = "精英",
	     maxHP =832.48,
	     at =576.624,
	     mt = 576.624,
	     af = 56.7428571428572,
	     mf = 47.2857142857143,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 51.52,
	     tao = 109.935,
	     phaseAt = 0.303,
	     phaseDf = 0.24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.064,
     },
     [503] = {
	     attrDesc = "高血物防",
	     strDesc = "精英",
	     maxHP =1248.72,
	     at =384.416,
	     mt = 384.416,
	     af = 56.7428571428572,
	     mf = 47.2857142857143,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 64.4,
	     tao = 109.935,
	     phaseAt = 0.303,
	     phaseDf = 0.24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.08,
     },
     [504] = {
	     attrDesc = "高攻高血",
	     strDesc = "精英",
	     maxHP =1248.72,
	     at =576.624,
	     mt = 576.624,
	     af = 47.2857142857143,
	     mf = 47.2857142857143,
	     hit = 32.4,
	     dodge = 47.1578947368421,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 51.52,
	     tao = 87.948,
	     phaseAt = 0.303,
	     phaseDf = 0.24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.08,
     },
     [505] = {
	     attrDesc = "高攻高血",
	     strDesc = "普通",
	     maxHP =1210.8,
	     at =541.44,
	     mt = 541.44,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 47.1578947368421,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 45.12,
	     tao = 58.632,
	     phaseAt = 0.233,
	     phaseDf = 0.18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0.06,
     },
}
