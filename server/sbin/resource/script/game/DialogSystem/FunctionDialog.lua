--[[FunctionDialog.lua
描述：
	特殊对话组装(对话系统)
]]

FunctionDialog = {}

function FunctionDialog.createSkillDialog(player)
	local dialog =
	{
		dialogType = DialogType.FunctionOption,
		conditions = {},
		txt = "特殊对话都被你发现了？",
		options = 
		{
			[1] = 
			{
				showConditions = {action},
				optionTxt = "领取奖励",
				actions = 
				{
					{},
				},
				icon = "",
				
			},
			[2] = 
			{
				showConditions = {},
				optionTxt = "飞到桃源镇",
				actions =
				{
					{},
				},
				icon = "",
			},
		},
	}

	return dialog
end