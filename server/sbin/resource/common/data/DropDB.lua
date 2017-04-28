--[[DropDB.lua
ÃèÊö£º
	µôÂäÅäÖÃ
--]]

DropDB = {
	[1] = { 
		dropNumData = {1,2,3,4} ,
		dropType =	{
				{weight = 20,xp = 300},
				{weight = 25,pot = 200},
				{weight = 30,money = 700},
				{weight = 35,subMoney = 700},
				{weight = 40,expoint = 100},
				{weight = 25,item ={id = 2030048, number = {1,2,3},},},		
			},
	}, 
	
	[2] = { 
		dropNumData = {1,2,3} ,
		dropType =	{
				{weight = 20,xp = 300},
				{weight = 25,pot = 200},
				{weight = 30,money = 700},
				{weight = 35,subMoney = 700},
				{weight = 40,expoint = 100},
				{weight = 45,item ={id = 1041006, number = {1,2,3},},},		
			},
	}, 
	[3] = { 
		dropNumData = {1,2,3} ,
		dropType =	{
				{weight = 20,xp = 400},
				{weight = 25,pot = 400},
				{weight = 30,money = 700},
				{weight = 35,subMoney = 700},
				{weight = 40,expoint = 100},
			},
	}, 
	[4] = { 
		dropNumData = {1,2,3} ,
		dropType =	{
				{weight = 20,xp = 300},
				{weight = 25,pot = 300},
				{weight = 35,subMoney = 700},
			},
	}, 	
	[5] = { 
		dropNumData = {1,2,3} ,
		dropType =	{
				{weight = 20,xp = 200},
				{weight = 25,pot = 200},
			},
	}, 	
	[18] = { --ÁÔ½ð³¡¿óÊ¯Ëæ»úµôÂä
		dropNumData = {1,2} ,
		dropType =	{
				{weight = 80,xp = 500},
				{weight = 20,money = 100},
				{weight = 80,subMoney = 1000},
				{weight = 20,expoint = 50},
				{weight = 80,item ={id = 1051005, number = {1},},},
				{weight = 80,item ={id = 1051006, number = {1},},},
			},
	},
	[19] = { --ÐþÌú¾§Ê¯µôÂä
		dropNumData = {1} ,
		dropType =	{
				{weight = 100,item ={id = 1041005, number = {1},},},
			},
	},
	[20] = { --Í¨Áé¾§Ê¯µôÂä
		dropNumData = {1} ,
		dropType =	{
				{weight = 100,item ={id = 1041006, number = {1},},},
			},
	},
	[21] = { --»Ø»ê²Ý
		dropNumData = {1} ,
		dropType =	{
				{weight = 100,item ={id = 1041007, number = {1},},},
			},
	},
	[22] = { --ÁúÑª²Ý
		dropNumData = {1} ,
		dropType =	{
				{weight = 100,item ={id = 1041001, number = {1},},},
			},
	},
}