--[[FactionEctypeDB.lua
	帮会副本配置
--]]
-- 帮会副本配置表
tFactionEctypeDB =
{
	[1] =
	{
		-- 所有子副本, 根据周几选择进那个副本
		tAllEctypes =
		{
			-- 第1个子副本
			[1] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
			-- 第2个子副本
			[2] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
			-- 第3个子副本
			[3] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
			-- 第4个子副本
			[4] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
			[5] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
			[6] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
			[7] =
			{
				-- 对应的副本ID
				EctypeID = 3000,
			},
		},
	},

}

for i = 1, table.getn(tFactionEctypeDB) do
	local factionEctypeGroup = tFactionEctypeDB[i].tAllEctypes
	for index = 1, table.getn(factionEctypeGroup) do
		local ectypeID = factionEctypeGroup[index].EctypeID
		if tEctypeDB[ectypeID] then
			tEctypeDB[ectypeID].factionEctypeID = i
		else
			-- 配置的子副本ID在tEctypeDB里找不到
			local szErrorDes = "连环副本的子副本ID配置错误！连环副本ID = "..i.."，第"..j.."个副本组，第"..index.."个子副本"
			print(szErrorDes)
		end
	end 
end