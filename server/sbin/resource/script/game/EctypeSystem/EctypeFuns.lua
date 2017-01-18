--[[EctypeFuns.lua
描述:
	副本功能函数
]]

-- 创建热区
function Ectype_CreateHotArea(ectype, params)
	--print("通知客户端创建热区")
	local hotArea = {}
	hotArea.hotAreaID = params.hotAreaID
	hotArea.xPos = params.xPos
	hotArea.yPos = params.yPos
	hotArea.bCreate = true

	-- 通知客户端创建热区
	local event = Event.getEvent(EctypeEvents_SC_EctypeHotArea, hotArea)
	ectype:sendEctypeEvent(event)
end

-- 删除热区
function Ectype_DestroyHotArea(ectype, params)
	local hotArea = {}
	hotArea.hotAreaID = params.hotAreaID
	hotArea.bCreate = false

	ectype:setPreProcedureFlag(false)
	-- 通知客户端删除热区
	local event = Event.getEvent(EctypeEvents_SC_EctypeHotArea, hotArea)
	ectype:sendEctypeEvent(event)
end

-- 创建Npc
function Ectype_CreateNpc(ectype, params)
	ectype:createNpc(params)
end

-- 打开对话框
function Ectype_OpenDialog(ectype, params)
	local optionID = params.dialogID
	if optionID then
		ectype:openDialog(optionID)
	end
end

-- 删除Npc
function Ectype_RemoveNpc(ectype, params)
	local npcID = params.npcID
	if npcID then
		ectype:removeNpc(npcID)
	end
end

-- 加载副本机关
function Ectype_LoadOrganEffect(ectype, params, player)
	if player then
		ectype:loadOrganEffect(player)
	else
		ectype:loadOrganEffect()
	end
end

function Ectype_OpenOrganEffect(ectype, params)
	local npcID = params.npcID
	if npcID then
		ectype:openOrganEffect(npcID)
	end
end

function Ectype_RemoveOrganEffect(ectype, params)
	local npcID = params.npcID
	if npcID then
		ectype:removeOrganEffect(npcID)
	end
end

function Ectype_ResumeOrganEffect(ectype, params)
	local npcID = params.npcID
	if npcID then
		ectype:resumeOrganEffect(npcID)
	end
end

-- 传送到副本第二个场景
function Ectype_TransferToSecondScene(ectype, params)
	local ectypeID = ectype:getEctypeID()
	local ectypeConfig = tEctypeDB[ectypeID]
	if not ectypeConfig then
		return
	end
	ectype:enterEctypeOtherScene(ectypeConfig.EnterInitLocs2.locX, ectypeConfig.EnterInitLocs2.locY)
end

-- 开启场景特效
function Ectype_StartSceneMagic(ectype, params)
	local magicData = {}
	magicData.index = params.index
	magicData.magicID = params.magicID
	magicData.xPos = params.xPos
	magicData.yPos = params.yPos
	magicData.startMagic = true

	-- 通知客户端
	local event = Event.getEvent(EctypeEvents_SC_SceneMagic, magicData)
	ectype:sendEctypeEvent(event)
end

-- 关闭场景特效
function Ectype_StopSceneMagic(ectype, params)
	local magicData = {}
	magicData.index = params.index
	magicData.stopMagic = true

	-- 通知客户端
	local event = Event.getEvent(EctypeEvents_SC_SceneMagic, magicData)
	ectype:sendEctypeEvent(event)
end

-- 传送到指定公共场景
function Ectype_EnterPublicScene(ectype, params)
	ectype:returnPublicSceneEx(params.mapID, params.xPos, params.yPos)
end

-- 添加动态传送门进入指定副本
function Ectype_DynamicTransferDoors(ectype, params)
	ectype:notifyDynamicTransferDoors(params.ectypeID, params.transferDoorLocX, params.transferDoorLocY)
end

-- 创建副本跟随NPC
function Ectype_CreateFollowNPC(ectype, params)
	ectype:createFollowNPC(params.followNpcID)
end

-- 删除副本跟随NPC
function Ectype_DeleteFollowNPC(ectype, params)
	ectype:deleteFollowNPC(params.followNpcID)
end

--创建副本物件
function Ectype_CreateObject(ectype, params)
	ectype:createObject(params)
end

-- 创建副本巡逻怪
function Ectype_CreatePatrolNpc(ectype, params)
	ectype:createPatrolNpc(params)
end