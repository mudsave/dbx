--[[EquipItemConsumeDB.lua
描述：装备玩法物品消耗配置
	]]

EquipItemConsumeDB = 
{

	[EquipPlaying.AttrReset] =
	{
		[EquipAttrColor.Blue] =
		{
			{BitemID = 1110005,itemID = 1110073,itemNum = 1},
			{BitemID = 1110006,itemID = 1110074,itemNum = 1},
		},
		[EquipAttrColor.Pink] =
		{
			{BitemID = 1110005,itemID = 1110073,itemNum = 1},
			{BitemID = 1110007,itemID = 1110075,itemNum = 1},
		},
		[EquipAttrColor.Gold] =
		{
			{BitemID = 1110005,itemID = 1110073,itemNum = 1},
			{BitemID = 1110008,itemID = 1110076,itemNum = 1},
		},
		[EquipAttrColor.Green] =
		{
			{BitemID = 1110005,itemID = 1110073,itemNum = 1},
			{BitemID = 1110009,itemID = 1110077,itemNum = 1},
		},
	},
	[EquipPlaying.AttrImprove] =
	{
		[20] = {BitemID = 1110021,itemID = 1110089,itemNum = 1},
		[30] = {BitemID = 1110022,itemID = 1110090,itemNum = 1},
		[40] = {BitemID = 1110023,itemID = 1110091,itemNum = 1},
		[50] = {BitemID = 1110024,itemID = 1110092,itemNum = 1},
		[60] = {BitemID = 1110025,itemID = 1110093,itemNum = 1},
	},
	[EquipPlaying.EquipRemould] =
	{
		[EquipRemouldType.remould] = {BitemID = 1110010,itemID = 1110078,itemNum = 1},
		[EquipRemouldType.rollBack] =
		{
			[5] = {BitemID = 1110070,itemID = 1110138,itemNum = 2},
			[6] = {BitemID = 1110070,itemID = 1110138,itemNum = 3},
			[7] = {BitemID = 1110070,itemID = 1110138,itemNum = 4},
			[8] = {BitemID = 1110070,itemID = 1110138,itemNum = 5},
			[9] = {BitemID = 1110070,itemID = 1110138,itemNum = 6},
		},
	},
	[EquipPlaying.AdornMake] =
	{
		[AdornSubClass.Ring] =
		{
			{BitemID = 1110017,itemID = 1110085,itemNum = 1},
			{BitemID = 1110018,itemID = 1110086,itemNum = 1},
		},
		[AdornSubClass.Amulet] =
		{
			{BitemID = 1110020,itemID = 1110088,itemNum = 1},
			{BitemID = 1110018,itemID = 1110086,itemNum = 1},
		},
		[AdornSubClass.Necklace] =
		{
			{BitemID = 1110019,itemID = 1110087,itemNum = 1},
			{BitemID = 1110018,itemID = 1110086,itemNum = 1},
		},
	},
}
