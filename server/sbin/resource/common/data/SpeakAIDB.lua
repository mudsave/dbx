--SpeakAIDB.lua
MonsterSpeakAIDB = {}

MonsterSpeakAIDB[1] = {
	name = '例子',
	--type = ConditionType.HPChange,
	doer = {
		defaultWords = "干吗？",
		{
			condition = {["<"] = {"hp",0.8},[">"] = {"hp",0.5},isAnd = true},
			words="疼死我了！",
		},
		{
			condition = {["<="] = {"hp",0.5},isAnd = true},
			words = "你真强！",
		},
		
	},
}

