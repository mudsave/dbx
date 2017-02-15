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
	     attrDesc = "高攻物防",
	     strDesc = "弱鸡",
	     maxHP =134.4,
	     at =95.424,
	     mt = 95.424,
	     af = 1.2,
	     mf = 1,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 5.6,
	     tao = 36.645,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [2] = {
	     attrDesc = "速度物防",
	     strDesc = "弱鸡",
	     maxHP =134.4,
	     at =63.616,
	     mt = 63.616,
	     af = 1.2,
	     mf = .8,
	     hit = 10.8,
	     dodge = 40.4210526315789,
	     crit = 1,
	     uncrit = 1,
	     speed = 8.4,
	     tao = 43.974,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [3] = {
	     attrDesc = "高血物防",
	     strDesc = "弱鸡",
	     maxHP =201.6,
	     at =63.616,
	     mt = 63.616,
	     af = 1.2,
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
	     attrDesc = "高攻法防",
	     strDesc = "弱鸡",
	     maxHP =134.4,
	     at =95.424,
	     mt = 95.424,
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
     [5] = {
	     attrDesc = "速度法防",
	     strDesc = "弱鸡",
	     maxHP =134.4,
	     at =63.616,
	     mt = 63.616,
	     af = .8,
	     mf = 1.2,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 8.4,
	     tao = 43.974,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [6] = {
	     attrDesc = "高血法防",
	     strDesc = "弱鸡",
	     maxHP =201.6,
	     at =63.616,
	     mt = 63.616,
	     af = 1,
	     mf = 1.2,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = .8,
	     uncrit = 1.2,
	     speed = 7,
	     tao = 36.645,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [7] = {
	     attrDesc = "高攻高速",
	     strDesc = "弱鸡",
	     maxHP =168,
	     at =95.424,
	     mt = 95.424,
	     af = .8,
	     mf = .8,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 8.4,
	     tao = 36.645,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [8] = {
	     attrDesc = "高攻高血",
	     strDesc = "弱鸡",
	     maxHP =201.6,
	     at =95.424,
	     mt = 95.424,
	     af = 1,
	     mf = 1,
	     hit = 10.8,
	     dodge = 26.9473684210526,
	     crit = 1,
	     uncrit = 1,
	     speed = 5.6,
	     tao = 29.316,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [9] = {
	     attrDesc = "双防",
	     strDesc = "弱鸡",
	     maxHP =168,
	     at =63.616,
	     mt = 63.616,
	     af = 1.2,
	     mf = 1.2,
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
     [10] = {
	     attrDesc = "高血高速",
	     strDesc = "弱鸡",
	     maxHP =201.6,
	     at =79.52,
	     mt = 79.52,
	     af = 1,
	     mf = 1,
	     hit = 8.64,
	     dodge = 26.9473684210526,
	     crit = .8,
	     uncrit = .8,
	     speed = 8.4,
	     tao = 43.974,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [11] = {
	     attrDesc = "攻血速",
	     strDesc = "弱鸡",
	     maxHP =201.6,
	     at =95.424,
	     mt = 95.424,
	     af = .8,
	     mf = .8,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 8.4,
	     tao = 29.316,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
     },
     [12] = {
	     attrDesc = "高血",
	     strDesc = "弱鸡",
	     maxHP =235.2,
	     at =63.616,
	     mt = 63.616,
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
     [13] = {
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
     [14] = {
	     attrDesc = "高攻物防",
	     strDesc = "普通",
	     maxHP =807.2,
	     at =541.44,
	     mt = 541.44,
	     af = 14.7771428571429,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 45.12,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .048,
     },
     [15] = {
	     attrDesc = "速度物防",
	     strDesc = "普通",
	     maxHP =807.2,
	     at =360.96,
	     mt = 360.96,
	     af = 14.7771428571429,
	     mf = 9.8514285714286,
	     hit = 32.4,
	     dodge = 70.7368421052632,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 67.68,
	     tao = 87.948,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .048,
     },
     [16] = {
	     attrDesc = "高血物防",
	     strDesc = "普通",
	     maxHP =1210.8,
	     at =360.96,
	     mt = 360.96,
	     af = 14.7771428571429,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [17] = {
	     attrDesc = "高攻法防",
	     strDesc = "普通",
	     maxHP =807.2,
	     at =541.44,
	     mt = 541.44,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .048,
     },
     [18] = {
	     attrDesc = "速度法防",
	     strDesc = "普通",
	     maxHP =807.2,
	     at =360.96,
	     mt = 360.96,
	     af = 9.8514285714286,
	     mf = 14.7771428571429,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 67.68,
	     tao = 87.948,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .06,
     },
     [19] = {
	     attrDesc = "高血法防",
	     strDesc = "普通",
	     maxHP =1210.8,
	     at =360.96,
	     mt = 360.96,
	     af = 12.3142857142857,
	     mf = 14.7771428571429,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 6.08,
	     uncrit = 17.6842105263158,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [20] = {
	     attrDesc = "高攻高速",
	     strDesc = "普通",
	     maxHP =1009,
	     at =541.44,
	     mt = 541.44,
	     af = 9.8514285714286,
	     mf = 9.8514285714286,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 67.68,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .144,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [21] = {
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
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [22] = {
	     attrDesc = "双防",
	     strDesc = "普通",
	     maxHP =1009,
	     at =360.96,
	     mt = 360.96,
	     af = 14.7771428571429,
	     mf = 14.7771428571429,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = .1864,
	     phaseDf = .216,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [23] = {
	     attrDesc = "高血高速",
	     strDesc = "普通",
	     maxHP =1210.8,
	     at =451.2,
	     mt = 451.2,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 25.92,
	     dodge = 47.1578947368421,
	     crit = 6.08,
	     uncrit = 11.7894736842105,
	     speed = 67.68,
	     tao = 87.948,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .06,
     },
     [24] = {
	     attrDesc = "攻血速",
	     strDesc = "普通",
	     maxHP =1210.8,
	     at =541.44,
	     mt = 541.44,
	     af = 9.8514285714286,
	     mf = 9.8514285714286,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 67.68,
	     tao = 58.632,
	     phaseAt = .233,
	     phaseDf = .144,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [25] = {
	     attrDesc = "高血",
	     strDesc = "普通",
	     maxHP =1412.6,
	     at =360.96,
	     mt = 360.96,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [26] = {
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
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
     },
     [27] = {
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
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .064,
     },
     [28] = {
	     attrDesc = "速度物防",
	     strDesc = "精英",
	     maxHP =832.48,
	     at =384.416,
	     mt = 384.416,
	     af = 56.7428571428572,
	     mf = 37.8285714285715,
	     hit = 32.4,
	     dodge = 70.7368421052632,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 77.28,
	     tao = 131.922,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .064,
     },
     [29] = {
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
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [30] = {
	     attrDesc = "高攻法防",
	     strDesc = "精英",
	     maxHP =832.48,
	     at =576.624,
	     mt = 576.624,
	     af = 47.2857142857143,
	     mf = 47.2857142857143,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 64.4,
	     tao = 109.935,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .064,
     },
     [31] = {
	     attrDesc = "速度法防",
	     strDesc = "精英",
	     maxHP =832.48,
	     at =384.416,
	     mt = 384.416,
	     af = 37.8285714285715,
	     mf = 56.7428571428572,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 77.28,
	     tao = 131.922,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .08,
     },
     [32] = {
	     attrDesc = "高血法防",
	     strDesc = "精英",
	     maxHP =1248.72,
	     at =384.416,
	     mt = 384.416,
	     af = 47.2857142857143,
	     mf = 56.7428571428572,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 6.08,
	     uncrit = 22.7368421052632,
	     speed = 64.4,
	     tao = 109.935,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [33] = {
	     attrDesc = "高攻高速",
	     strDesc = "精英",
	     maxHP =1040.6,
	     at =576.624,
	     mt = 576.624,
	     af = 37.8285714285715,
	     mf = 37.8285714285715,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 77.28,
	     tao = 109.935,
	     phaseAt = .303,
	     phaseDf = .192,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [34] = {
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
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [35] = {
	     attrDesc = "双防",
	     strDesc = "精英",
	     maxHP =1040.6,
	     at =384.416,
	     mt = 384.416,
	     af = 56.7428571428572,
	     mf = 56.7428571428572,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 64.4,
	     tao = 109.935,
	     phaseAt = .2424,
	     phaseDf = .288,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [36] = {
	     attrDesc = "高血高速",
	     strDesc = "精英",
	     maxHP =1248.72,
	     at =480.52,
	     mt = 480.52,
	     af = 47.2857142857143,
	     mf = 47.2857142857143,
	     hit = 25.92,
	     dodge = 47.1578947368421,
	     crit = 6.08,
	     uncrit = 15.1578947368421,
	     speed = 77.28,
	     tao = 131.922,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .08,
     },
     [37] = {
	     attrDesc = "攻血速",
	     strDesc = "精英",
	     maxHP =1248.72,
	     at =576.624,
	     mt = 576.624,
	     af = 37.8285714285715,
	     mf = 37.8285714285715,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 77.28,
	     tao = 87.948,
	     phaseAt = .303,
	     phaseDf = .192,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [38] = {
	     attrDesc = "高血",
	     strDesc = "精英",
	     maxHP =1456.84,
	     at =384.416,
	     mt = 384.416,
	     af = 47.2857142857143,
	     mf = 47.2857142857143,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 64.4,
	     tao = 109.935,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [39] = {
	     attrDesc = "一般",
	     strDesc = "精英",
	     maxHP =1040.6,
	     at =480.52,
	     mt = 480.52,
	     af = 47.2857142857143,
	     mf = 47.2857142857143,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 18.9473684210526,
	     speed = 64.4,
	     tao = 109.935,
	     phaseAt = .303,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [40] = {
	     attrDesc = "高攻物防",
	     strDesc = "boss",
	     maxHP =856.16,
	     at =675.54,
	     mt = 675.54,
	     af = 99.3942857142857,
	     mf = 82.8285714285714,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 57.92,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [41] = {
	     attrDesc = "速度物防",
	     strDesc = "boss",
	     maxHP =856.16,
	     at =450.36,
	     mt = 450.36,
	     af = 99.3942857142857,
	     mf = 66.2628571428571,
	     hit = 32.4,
	     dodge = 70.7368421052632,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 86.88,
	     tao = 175.896,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .08,
     },
     [42] = {
	     attrDesc = "高血物防",
	     strDesc = "boss",
	     maxHP =1284.24,
	     at =450.36,
	     mt = 450.36,
	     af = 99.3942857142857,
	     mf = 82.8285714285714,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 72.4,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [43] = {
	     attrDesc = "高攻法防",
	     strDesc = "boss",
	     maxHP =856.16,
	     at =675.54,
	     mt = 675.54,
	     af = 82.8285714285714,
	     mf = 82.8285714285714,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 72.4,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [44] = {
	     attrDesc = "速度法防",
	     strDesc = "boss",
	     maxHP =856.16,
	     at =450.36,
	     mt = 450.36,
	     af = 66.2628571428571,
	     mf = 99.3942857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 86.88,
	     tao = 175.896,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .1,
     },
     [45] = {
	     attrDesc = "高血法防",
	     strDesc = "boss",
	     maxHP =1284.24,
	     at =450.36,
	     mt = 450.36,
	     af = 82.8285714285714,
	     mf = 99.3942857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 6.08,
	     uncrit = 27.7894736842105,
	     speed = 72.4,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [46] = {
	     attrDesc = "高攻高速",
	     strDesc = "boss",
	     maxHP =1070.2,
	     at =675.54,
	     mt = 675.54,
	     af = 66.2628571428571,
	     mf = 66.2628571428571,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 86.88,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [47] = {
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
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [48] = {
	     attrDesc = "双防",
	     strDesc = "boss",
	     maxHP =1070.2,
	     at =450.36,
	     mt = 450.36,
	     af = 99.3942857142857,
	     mf = 99.3942857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 72.4,
	     tao = 146.58,
	     phaseAt = .2984,
	     phaseDf = .36,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [49] = {
	     attrDesc = "高血高速",
	     strDesc = "boss",
	     maxHP =1284.24,
	     at =562.95,
	     mt = 562.95,
	     af = 82.8285714285714,
	     mf = 82.8285714285714,
	     hit = 25.92,
	     dodge = 47.1578947368421,
	     crit = 6.08,
	     uncrit = 18.5263157894737,
	     speed = 86.88,
	     tao = 175.896,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .1,
     },
     [50] = {
	     attrDesc = "攻血速",
	     strDesc = "boss",
	     maxHP =1284.24,
	     at =675.54,
	     mt = 675.54,
	     af = 66.2628571428571,
	     mf = 66.2628571428571,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 86.88,
	     tao = 117.264,
	     phaseAt = .373,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [51] = {
	     attrDesc = "高血",
	     strDesc = "boss",
	     maxHP =1498.28,
	     at =450.36,
	     mt = 450.36,
	     af = 82.8285714285714,
	     mf = 82.8285714285714,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 72.4,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [52] = {
	     attrDesc = "一般",
	     strDesc = "boss",
	     maxHP =1070.2,
	     at =562.95,
	     mt = 562.95,
	     af = 82.8285714285714,
	     mf = 82.8285714285714,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 72.4,
	     tao = 146.58,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [53] = {
	     attrDesc = "高攻物防",
	     strDesc = "噩梦",
	     maxHP =977.76,
	     at =1113.72,
	     mt = 1113.72,
	     af = 157.68,
	     mf = 131.4,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 59.2,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [54] = {
	     attrDesc = "速度物防",
	     strDesc = "噩梦",
	     maxHP =977.76,
	     at =742.48,
	     mt = 742.48,
	     af = 157.68,
	     mf = 105.12,
	     hit = 32.4,
	     dodge = 70.7368421052632,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 88.8,
	     tao = 263.844,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .08,
     },
     [55] = {
	     attrDesc = "高血物防",
	     strDesc = "噩梦",
	     maxHP =1466.64,
	     at =742.48,
	     mt = 742.48,
	     af = 157.68,
	     mf = 131.4,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 74,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [56] = {
	     attrDesc = "高攻法防",
	     strDesc = "噩梦",
	     maxHP =977.76,
	     at =1113.72,
	     mt = 1113.72,
	     af = 131.4,
	     mf = 131.4,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 74,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .08,
     },
     [57] = {
	     attrDesc = "速度法防",
	     strDesc = "噩梦",
	     maxHP =977.76,
	     at =742.48,
	     mt = 742.48,
	     af = 105.12,
	     mf = 157.68,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 88.8,
	     tao = 263.844,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .1,
     },
     [58] = {
	     attrDesc = "高血法防",
	     strDesc = "噩梦",
	     maxHP =1466.64,
	     at =742.48,
	     mt = 742.48,
	     af = 131.4,
	     mf = 157.68,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 6.08,
	     uncrit = 27.7894736842105,
	     speed = 74,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [59] = {
	     attrDesc = "高攻高速",
	     strDesc = "噩梦",
	     maxHP =1222.2,
	     at =1113.72,
	     mt = 1113.72,
	     af = 105.12,
	     mf = 105.12,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 88.8,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [60] = {
	     attrDesc = "高攻高血",
	     strDesc = "噩梦",
	     maxHP =1466.64,
	     at =1113.72,
	     mt = 1113.72,
	     af = 131.4,
	     mf = 131.4,
	     hit = 32.4,
	     dodge = 47.1578947368421,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 59.2,
	     tao = 175.896,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [61] = {
	     attrDesc = "双防",
	     strDesc = "噩梦",
	     maxHP =1222.2,
	     at =742.48,
	     mt = 742.48,
	     af = 157.68,
	     mf = 157.68,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 74,
	     tao = 219.87,
	     phaseAt = .2984,
	     phaseDf = .36,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [62] = {
	     attrDesc = "高血高速",
	     strDesc = "噩梦",
	     maxHP =1466.64,
	     at =928.1,
	     mt = 928.1,
	     af = 131.4,
	     mf = 131.4,
	     hit = 25.92,
	     dodge = 47.1578947368421,
	     crit = 6.08,
	     uncrit = 18.5263157894737,
	     speed = 88.8,
	     tao = 263.844,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .1,
     },
     [63] = {
	     attrDesc = "攻血速",
	     strDesc = "噩梦",
	     maxHP =1466.64,
	     at =1113.72,
	     mt = 1113.72,
	     af = 105.12,
	     mf = 105.12,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 88.8,
	     tao = 175.896,
	     phaseAt = .373,
	     phaseDf = .24,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [64] = {
	     attrDesc = "高血",
	     strDesc = "噩梦",
	     maxHP =1711.08,
	     at =742.48,
	     mt = 742.48,
	     af = 131.4,
	     mf = 131.4,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 74,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [65] = {
	     attrDesc = "一般",
	     strDesc = "噩梦",
	     maxHP =1222.2,
	     at =928.1,
	     mt = 928.1,
	     af = 131.4,
	     mf = 131.4,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 23.1578947368421,
	     speed = 74,
	     tao = 219.87,
	     phaseAt = .373,
	     phaseDf = .3,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .1,
     },
     [66] = {
	     attrDesc = "高攻物防",
	     strDesc = "世界boss",
	     maxHP =2348,
	     at =2056,
	     mt = 2056,
	     af = 458.836363636364,
	     mf = 382.363636363636,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 132.8,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .64,
     },
     [67] = {
	     attrDesc = "速度物防",
	     strDesc = "世界boss",
	     maxHP =2348,
	     at =1370.66666666667,
	     mt = 1370.66666666667,
	     af = 458.836363636364,
	     mf = 305.890909090909,
	     hit = 51.3,
	     dodge = 104.842105263158,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 199.2,
	     tao = 439.74,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .72,
	     obstacleDefense = .64,
     },
     [68] = {
	     attrDesc = "高血物防",
	     strDesc = "世界boss",
	     maxHP =3522,
	     at =1370.66666666667,
	     mt = 1370.66666666667,
	     af = 458.836363636364,
	     mf = 382.363636363636,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 166,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [69] = {
	     attrDesc = "高攻法防",
	     strDesc = "世界boss",
	     maxHP =2348,
	     at =2056,
	     mt = 2056,
	     af = 382.363636363636,
	     mf = 382.363636363636,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 166,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .64,
     },
     [70] = {
	     attrDesc = "速度法防",
	     strDesc = "世界boss",
	     maxHP =2348,
	     at =1370.66666666667,
	     mt = 1370.66666666667,
	     af = 305.890909090909,
	     mf = 458.836363636364,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 199.2,
	     tao = 439.74,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .72,
	     obstacleDefense = .8,
     },
     [71] = {
	     attrDesc = "高血法防",
	     strDesc = "世界boss",
	     maxHP =3522,
	     at =1370.66666666667,
	     mt = 1370.66666666667,
	     af = 382.363636363636,
	     mf = 458.836363636364,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 51.68,
	     uncrit = 75.7894736842105,
	     speed = 166,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [72] = {
	     attrDesc = "高攻高速",
	     strDesc = "世界boss",
	     maxHP =2935,
	     at =2056,
	     mt = 2056,
	     af = 305.890909090909,
	     mf = 305.890909090909,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 199.2,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .56,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [73] = {
	     attrDesc = "高攻高血",
	     strDesc = "世界boss",
	     maxHP =3522,
	     at =2056,
	     mt = 2056,
	     af = 382.363636363636,
	     mf = 382.363636363636,
	     hit = 51.3,
	     dodge = 69.8947368421053,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 132.8,
	     tao = 293.16,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [74] = {
	     attrDesc = "双防",
	     strDesc = "世界boss",
	     maxHP =2935,
	     at =1370.66666666667,
	     mt = 1370.66666666667,
	     af = 458.836363636364,
	     mf = 458.836363636364,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 166,
	     tao = 366.45,
	     phaseAt = .96,
	     phaseDf = .84,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [75] = {
	     attrDesc = "高血高速",
	     strDesc = "世界boss",
	     maxHP =3522,
	     at =1713.33333333333,
	     mt = 1713.33333333333,
	     af = 382.363636363636,
	     mf = 382.363636363636,
	     hit = 41.04,
	     dodge = 69.8947368421053,
	     crit = 51.68,
	     uncrit = 50.5263157894737,
	     speed = 199.2,
	     tao = 439.74,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .72,
	     obstacleDefense = .8,
     },
     [76] = {
	     attrDesc = "攻血速",
	     strDesc = "世界boss",
	     maxHP =3522,
	     at =2056,
	     mt = 2056,
	     af = 305.890909090909,
	     mf = 305.890909090909,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 199.2,
	     tao = 293.16,
	     phaseAt = 1.2,
	     phaseDf = .56,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [77] = {
	     attrDesc = "高血",
	     strDesc = "世界boss",
	     maxHP =4109,
	     at =1370.66666666667,
	     mt = 1370.66666666667,
	     af = 382.363636363636,
	     mf = 382.363636363636,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 166,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [78] = {
	     attrDesc = "一般",
	     strDesc = "世界boss",
	     maxHP =2935,
	     at =1713.33333333333,
	     mt = 1713.33333333333,
	     af = 382.363636363636,
	     mf = 382.363636363636,
	     hit = 51.3,
	     dodge = 87.3684210526316,
	     crit = 64.6,
	     uncrit = 63.1578947368421,
	     speed = 166,
	     tao = 366.45,
	     phaseAt = 1.2,
	     phaseDf = .7,
	     obstacleHit = .6,
	     obstacleDefense = .8,
     },
     [79] = {
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
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
	     attrBenefit1 = monster_max_hp,
	     attrAddType1 = MonAttrAddType.Value,
	     attrEffVal1 =200000,
     },
     [80] = {
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
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
	     attrBenefit1 = monster_max_hp,
	     attrAddType1 = MonAttrAddType.Value,
	     attrEffVal1 =200000,
	     attrBenefit2 = monster_at,
	     attrAddType2 = MonAttrAddType.Value,
	     attrEffVal2 =10000,
	     attrBenefit3 =monster_mt,
	     attrAddType3 =MonAttrAddType.Value,
	     attrEffVal3 =10000,
     },
     [81] = {
	     attrDesc = "高攻物防",
	     strDesc = "弱鸡",
	     maxHP =134.4,
	     at =95.424,
	     mt = 95.424,
	     af = 1.2,
	     mf = 1,
	     hit = 10.8,
	     dodge = 33.6842105263158,
	     crit = 1,
	     uncrit = 1,
	     speed = 5.6,
	     tao = 36.645,
	     phaseAt = 0,
	     phaseDf = 0,
	     obstacleHit = 0,
	     obstacleDefense = 0,
	     attrBenefit1 = monster_max_hp,
	     attrAddType1 = MonAttrAddType.Value,
	     attrEffVal1 =200000000,
     },
     [503] = {
	     attrDesc = "一般",
	     strDesc = "新手",
	     maxHP =658,
	     at =271.25,
	     mt = 271.25,
	     af = 1,
	     mf = 1,
	     hit = 28.8,
	     dodge = 54.7368421052632,
	     crit = 1.9,
	     uncrit = 2.10526315789474,
	     speed = 33,
	     tao = 73.29,
	     phaseAt = .03,
	     phaseDf = .033,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = 0,
	     attrBenefit1 = monster_at,
	     attrAddType1 = MonAttrAddType.Value,
	     attrEffVal1 =-270,
	     attrBenefit2 = monster_mt,
	     attrAddType2 = MonAttrAddType.Value,
	     attrEffVal2 =-270,
     },
     [504] = {
	     attrDesc = "高血",
	     strDesc = "弱鸡",
	     maxHP =235.2,
	     at =63.616,
	     mt = 63.616,
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
	     attrBenefit1 = monster_at,
	     attrAddType1 = MonAttrAddType.Value,
	     attrEffVal1 =350,
	     attrBenefit2 = monster_mt,
	     attrAddType2 = MonAttrAddType.Value,
	     attrEffVal2 =350,
     },
     [505] = {
	     attrDesc = "高血",
	     strDesc = "普通",
	     maxHP =1412.6,
	     at =200,
	     mt = 200,
	     af = 12.3142857142857,
	     mf = 12.3142857142857,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 56.4,
	     tao = 73.29,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.09999999999999E-02,
	     obstacleDefense = .06,
	     attrBenefit1 = monster_max_hp,
	     attrAddType1 = MonAttrAddType.Value,
	     attrEffVal1 =120000,
     },
     [506] = {
	     attrDesc = "速度法防",
	     strDesc = "普通",
	     maxHP =200,
	     at =200,
	     mt = 200,
	     af = 9.8514285714286,
	     mf = 14.7771428571429,
	     hit = 32.4,
	     dodge = 58.9473684210526,
	     crit = 7.6,
	     uncrit = 14.7368421052632,
	     speed = 67.68,
	     tao = 87.948,
	     phaseAt = .233,
	     phaseDf = .18,
	     obstacleHit = 4.91999999999999E-02,
	     obstacleDefense = .06,
     },
}
