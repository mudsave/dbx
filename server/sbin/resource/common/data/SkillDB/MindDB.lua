--[[MindDB.lua
�������ķ��趨
	]]

MindDB = {

     [101] = {
	         name="��ת����",
	         desc="���ɻ����ķ�������ϰ�ñ����ɵ�������ʽ",
	         position = 1,
	         attr_add_type = AttrAddType.At,
	         attr_add_id = 1,
	         money_cost_id = 7,
	         pot_cost_id = 8,
	         icon = "set:SkillIcon1 image:jiuzhuanxuangong",
	         skill1 = 10101,
	         skill1_level = 1,
	         skill2 = 10102,
	         skill2_level = 20,
	         skill3 = 10103,
	         skill3_level = 30,
	         skill4 = 10104,
	         skill4_level = 30,
      },
     [102] = {
	         name="������",
	         desc="�����ϰ��ķ�������ϰ�ñ�����ɫ�ϰ�����",
	         position = 0,
	         attr_add_type = AttrAddType.ObsHit,
	         attr_add_id = 2,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:dingjunshu",
	         skill1 = 10201,
	         skill1_level = 10,
	         skill2 = 10202,
	         skill2_level = 20,
      },
     [103] = {
	         name="�Ԫ��",
	         desc="���ɸ����ķ�������ϰ�ñ�������ɫ��������",
	         position = 0,
	         attr_add_type = AttrAddType.Defense,
	         attr_add_id = 3,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:gangyuanshu",
	         skill1 = 10301,
	         skill1_level = 20,
	         skill2 = 10302,
	         skill2_level = 20,
      },
     [104] = {
	         name="�ݵؽ��",
	         desc="���������ķ�������ϰ�ñ������������ʽ",
	         position = 0,
	         attr_add_type = AttrAddType.PhaseDf,
	         attr_add_id = 4,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:zongdijinguang",
	         skill1 = 10401,
	         skill1_level = 1,
	         skill2 = 10402,
	         skill2_level = 20,
	         skill3 = 10403,
	         skill3_level = 20,
      },
     [105] = {
	         name="ն�ɾ�",
	         desc="�����ش��ķ�������ϰ�úϻ�֮���⻹��ϰ�ñ��ž����������޴�",
	         position = 0,
	         attr_add_type = AttrAddType.AngerAdd,
	         attr_add_id = 5,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:zhanxianjue",
	         skill1 = 10501,
	         skill1_level = 1,
	         skill2 = 10502,
	         skill2_level = 40,
      },
     [106] = {
	         name="��ת����",
	         desc="���������ķ�������ϰ�������Ṧ������֮��",
	         position = 0,
	         attr_add_type = AttrAddType.MaxHp,
	         attr_add_id = 6,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:jiuzhuandanjue",
	         skill1 = 10601,
	         skill1_level = 1,
	         skill2 = 10602,
	         skill2_level = 30,
      },
     [201] = {
	         name="ն������",
	         desc="���ɻ����ķ�������ϰ�ñ����ɵ�������ʽ",
	         position = 1,
	         attr_add_type = AttrAddType.At,
	         attr_add_id = 1,
	         money_cost_id = 7,
	         pot_cost_id = 8,
	         icon = "set:SkillIcon1 image:zhanyaodaofa",
	         skill1 = 20101,
	         skill1_level = 1,
	         skill2 = 20102,
	         skill2_level = 20,
	         skill3 = 20103,
	         skill3_level = 30,
	         skill4 = 20104,
	         skill4_level = 30,
      },
     [202] = {
	         name="������",
	         desc="�����ϰ��ķ�������ϰ�ñ�����ɫ�ϰ�����",
	         position = 0,
	         attr_add_type = AttrAddType.ObsHit,
	         attr_add_id = 2,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:kongmengshu",
	         skill1 = 20201,
	         skill1_level = 10,
	         skill2 = 20202,
	         skill2_level = 20,
      },
     [203] = {
	         name="�����ƾ���",
	         desc="���ɸ����ķ�������ϰ�ñ�������ɫ��������",
	         position = 0,
	         attr_add_type = AttrAddType.Defense,
	         attr_add_id = 3,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:fulongpojunjue",
	         skill1 = 20301,
	         skill1_level = 20,
	         skill2 = 20302,
	         skill2_level = 20,
      },
     [204] = {
	         name="�ػ��",
	         desc="���������ķ�������ϰ�ñ������������ʽ",
	         position = 0,
	         attr_add_type = AttrAddType.PhaseDf,
	         attr_add_id = 4,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:konghuoshu",
	         skill1 = 20401,
	         skill1_level = 1,
	         skill2 = 20402,
	         skill2_level = 20,
	         skill3 = 20403,
	         skill3_level = 20,
      },
     [205] = {
	         name="ŭ��������",
	         desc="�����ش��ķ�������ϰ�úϻ�֮���⻹��ϰ�ñ��ž����������޴�",
	         position = 0,
	         attr_add_type = AttrAddType.AngerAdd,
	         attr_add_id = 5,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:nuyanlongxiangshu",
	         skill1 = 20501,
	         skill1_level = 1,
	         skill2 = 20502,
	         skill2_level = 40,
      },
     [206] = {
	         name="��΢����",
	         desc="���������ķ�������ϰ�������Ṧ������֮��",
	         position = 0,
	         attr_add_type = AttrAddType.MaxHp,
	         attr_add_id = 6,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:qingweifushu",
	         skill1 = 20601,
	         skill1_level = 1,
	         skill2 = 20602,
	         skill2_level = 30,
      },
     [301] = {
	         name="�������",
	         desc="���ɻ����ķ�������ϰ�ñ����ɵ�������ʽ",
	         position = 1,
	         attr_add_type = AttrAddType.At,
	         attr_add_id = 1,
	         money_cost_id = 7,
	         pot_cost_id = 8,
	         icon = "set:SkillIcon1 image:houyijianshu",
	         skill1 = 30101,
	         skill1_level = 1,
	         skill2 = 30102,
	         skill2_level = 20,
	         skill3 = 30103,
	         skill3_level = 30,
	         skill4 = 30104,
	         skill4_level = 30,
      },
     [302] = {
	         name="�����",
	         desc="�����ϰ��ķ�������ϰ�ñ�����ɫ�ϰ�����",
	         position = 0,
	         attr_add_type = AttrAddType.ObsHit,
	         attr_add_id = 2,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:huanfengjue",
	         skill1 = 30201,
	         skill1_level = 10,
	         skill2 = 30202,
	         skill2_level = 20,
      },
     [303] = {
	         name="����ͼ",
	         desc="���ɸ����ķ�������ϰ�ñ�������ɫ��������",
	         position = 0,
	         attr_add_type = AttrAddType.Defense,
	         attr_add_id = 3,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:fengyuntu",
	         skill1 = 30301,
	         skill1_level = 20,
	         skill2 = 30302,
	         skill2_level = 20,
      },
     [304] = {
	         name="�������¼",
	         desc="���������ķ�������ϰ�ñ������������ʽ",
	         position = 0,
	         attr_add_type = AttrAddType.PhaseDf,
	         attr_add_id = 4,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:tianxiangfengshenlu",
	         skill1 = 30401,
	         skill1_level = 1,
	         skill2 = 30402,
	         skill2_level = 20,
	         skill3 = 30403,
	         skill3_level = 20,
      },
     [305] = {
	         name="Īа����",
	         desc="�����ش��ķ�������ϰ�úϻ�֮���⻹��ϰ�ñ��ž����������޴�",
	         position = 0,
	         attr_add_type = AttrAddType.AngerAdd,
	         attr_add_id = 5,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:moxiejianpu",
	         skill1 = 30501,
	         skill1_level = 1,
	         skill2 = 30502,
	         skill2_level = 40,
      },
     [306] = {
	         name="��������",
	         desc="���������ķ�������ϰ�������Ṧ������֮��",
	         position = 0,
	         attr_add_type = AttrAddType.MaxHp,
	         attr_add_id = 6,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:ziyangmishu",
	         skill1 = 30601,
	         skill1_level = 1,
	         skill2 = 30602,
	         skill2_level = 30,
      },
     [401] = {
	         name="�����ľ�",
	         desc="���ɻ����ķ�������ϰ�ñ����ɵ�������ʽ",
	         position = 1,
	         attr_add_type = AttrAddType.Mt,
	         attr_add_id = 1,
	         money_cost_id = 7,
	         pot_cost_id = 8,
	         icon = "set:SkillIcon1 image:daodexinjing",
	         skill1 = 40101,
	         skill1_level = 1,
	         skill2 = 40102,
	         skill2_level = 20,
	         skill3 = 40103,
	         skill3_level = 30,
	         skill4 = 40104,
	         skill4_level = 30,
      },
     [402] = {
	         name="���Ǿ�",
	         desc="�����ϰ��ķ�������ϰ�ñ�����ɫ�ϰ�����",
	         position = 0,
	         attr_add_type = AttrAddType.ObsHit,
	         attr_add_id = 2,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:bingpojue",
	         skill1 = 40201,
	         skill1_level = 10,
	         skill2 = 40202,
	         skill2_level = 20,
      },
     [403] = {
	         name="�ȱ���",
	         desc="���ɸ����ķ�������ϰ�ñ�������ɫ��������",
	         position = 0,
	         attr_add_type = AttrAddType.Defense,
	         attr_add_id = 3,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:cibeizhou",
	         skill1 = 40301,
	         skill1_level = 20,
	         skill2 = 40302,
	         skill2_level = 20,
      },
     [404] = {
	         name="������",
	         desc="���������ķ�������ϰ�ñ������������ʽ",
	         position = 0,
	         attr_add_type = AttrAddType.PhaseDf,
	         attr_add_id = 4,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:xuanbingzhou",
	         skill1 = 40401,
	         skill1_level = 1,
	         skill2 = 40402,
	         skill2_level = 20,
	         skill3 = 40403,
	         skill3_level = 20,
      },
     [405] = {
	         name="��ħ��",
	         desc="�����ش��ķ�������ϰ�úϻ�֮���⻹��ϰ�ñ��ž����������޴�",
	         position = 0,
	         attr_add_type = AttrAddType.AngerAdd,
	         attr_add_id = 5,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:fumozhou",
	         skill1 = 40501,
	         skill1_level = 1,
	         skill2 = 40502,
	         skill2_level = 40,
      },
     [406] = {
	         name="��������",
	         desc="���������ķ�������ϰ�������Ṧ������֮��",
	         position = 0,
	         attr_add_type = AttrAddType.MaxHp,
	         attr_add_id = 6,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:penglaibaojian",
	         skill1 = 40601,
	         skill1_level = 1,
	         skill2 = 40602,
	         skill2_level = 30,
      },
     [501] = {
	         name="���¼",
	         desc="���ɻ����ķ�������ϰ�ñ����ɵ�������ʽ",
	         position = 1,
	         attr_add_type = AttrAddType.Mt,
	         attr_add_id = 1,
	         money_cost_id = 7,
	         pot_cost_id = 8,
	         icon = "set:SkillIcon1 image:piaomiaolu",
	         skill1 = 50101,
	         skill1_level = 1,
	         skill2 = 50102,
	         skill2_level = 20,
	         skill3 = 50103,
	         skill3_level = 30,
	         skill4 = 50104,
	         skill4_level = 30,
      },
     [502] = {
	         name="��Ȼ��",
	         desc="�����ϰ��ķ�������ϰ�ñ�����ɫ�ϰ�����",
	         position = 0,
	         attr_add_type = AttrAddType.ObsHit,
	         attr_add_id = 2,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:ziranjing",
	         skill1 = 50201,
	         skill1_level = 10,
	         skill2 = 50202,
	         skill2_level = 20,
      },
     [503] = {
	         name="���¾�",
	         desc="���ɸ����ķ�������ϰ�ñ�������ɫ��������",
	         position = 0,
	         attr_add_type = AttrAddType.Defense,
	         attr_add_id = 3,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:daodejing",
	         skill1 = 50301,
	         skill1_level = 20,
	         skill2 = 50302,
	         skill2_level = 20,
      },
     [504] = {
	         name="���侭",
	         desc="���������ķ�������ϰ�ñ������������ʽ",
	         position = 0,
	         attr_add_type = AttrAddType.PhaseDf,
	         attr_add_id = 4,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:daojiejing",
	         skill1 = 50401,
	         skill1_level = 1,
	         skill2 = 50402,
	         skill2_level = 20,
	         skill3 = 50403,
	         skill3_level = 20,
      },
     [505] = {
	         name="������",
	         desc="�����ش��ķ�������ϰ�úϻ�֮���⻹��ϰ�ñ��ž����������޴�",
	         position = 0,
	         attr_add_type = AttrAddType.AngerAdd,
	         attr_add_id = 5,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:yinyangjing",
	         skill1 = 50501,
	         skill1_level = 1,
	         skill2 = 50502,
	         skill2_level = 40,
      },
     [506] = {
	         name="�һ�ͼ��",
	         desc="���������ķ�������ϰ�������Ṧ������֮��",
	         position = 0,
	         attr_add_type = AttrAddType.MaxHp,
	         attr_add_id = 6,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:taohuapu",
	         skill1 = 50601,
	         skill1_level = 1,
	         skill2 = 50602,
	         skill2_level = 30,
      },
     [601] = {
	         name="������׾�",
	         desc="���ɻ����ķ�������ϰ�ñ����ɵ�������ʽ",
	         position = 1,
	         attr_add_type = AttrAddType.Mt,
	         attr_add_id = 1,
	         money_cost_id = 7,
	         pot_cost_id = 8,
	         icon = "set:SkillIcon1 image:tiangangwuleijue",
	         skill1 = 60101,
	         skill1_level = 1,
	         skill2 = 60102,
	         skill2_level = 20,
	         skill3 = 60103,
	         skill3_level = 30,
	         skill4 = 60104,
	         skill4_level = 30,
      },
     [602] = {
	         name="��ħ¼",
	         desc="�����ϰ��ķ�������ϰ�ñ�����ɫ�ϰ�����",
	         position = 0,
	         attr_add_type = AttrAddType.ObsHit,
	         attr_add_id = 2,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:fengmolu",
	         skill1 = 60201,
	         skill1_level = 10,
	         skill2 = 60202,
	         skill2_level = 20,
      },
     [603] = {
	         name="���յ½羭",
	         desc="���ɸ����ķ�������ϰ�ñ�������ɫ��������",
	         position = 0,
	         attr_add_type = AttrAddType.Defense,
	         attr_add_id = 3,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:puzhaodejiejing",
	         skill1 = 60301,
	         skill1_level = 20,
	         skill2 = 60302,
	         skill2_level = 20,
      },
     [604] = {
	         name="���������",
	         desc="���������ķ�������ϰ�ñ������������ʽ",
	         position = 0,
	         attr_add_type = AttrAddType.PhaseDf,
	         attr_add_id = 4,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:jiutiankongleishu",
	         skill1 = 60401,
	         skill1_level = 1,
	         skill2 = 60402,
	         skill2_level = 20,
	         skill3 = 60403,
	         skill3_level = 20,
      },
     [605] = {
	         name="�������쾭",
	         desc="�����ش��ķ�������ϰ�úϻ�֮���⻹��ϰ�ñ��ž����������޴�",
	         position = 0,
	         attr_add_type = AttrAddType.AngerAdd,
	         attr_add_id = 5,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:shenleiqingtianjing",
	         skill1 = 60501,
	         skill1_level = 1,
	         skill2 = 60502,
	         skill2_level = 40,
      },
     [606] = {
	         name="��Ϭ��",
	         desc="���������ķ�������ϰ�������Ṧ������֮��",
	         position = 0,
	         attr_add_type = AttrAddType.MaxHp,
	         attr_add_id = 6,
	         money_cost_id = 9,
	         pot_cost_id = 10,
	         icon = "set:SkillIcon1 image:lingxijing",
	         skill1 = 60601,
	         skill1_level = 1,
	         skill2 = 60602,
	         skill2_level = 30,
      },
}