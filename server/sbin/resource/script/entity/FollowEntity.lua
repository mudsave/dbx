--[[FollowEntity.lua
描述：
	跟随实体类
--]]

FollowEntity = class(Entity)

function FollowEntity:__init()
	self._dbID = nil
	self.speed = nil
	self.modelID = nil
	self.name = nil
	self.taskType = nil
	self.visible = true				--是否可见
end

function FollowEntity:__release()
	--todo
	self._dbID = nil
	self.speed = nil
	self.modelID = nil
	self.name = nil
	self.taskType = nil
	for htype,handler in pairs(self._handlers or {}) do
		release(handler)
		self._handlers[htype] = nil
	end
	self._handlers = nil
end

function FollowEntity:setDBID(dbID)
	self._dbID = dbID
end

function FollowEntity:getDBID()
	return self._dbID
end

--获取移动速度
function FollowEntity:setSpeed(speed)
	self.speed = speed
	setPropValue(self._peer, UNIT_MOVE_SPEED, speed)
end

--获取移动速度
function FollowEntity:getSpeed()
	return self.speed
end

function FollowEntity:getName()
	return self.name
end


function FollowEntity:getModelID()
	return self.modelID
end

function FollowEntity:setTaskType(taskType)
	self.taskType = taskType
end

function FollowEntity:getTaskType()
	return self.taskType
end

--	npc可视管理
-- 暂时只对跟随npc处理 别的 暂时没有必要调用这个函数
-- 这里需要传 player 是因为 显示的话 不知道显示到哪里
-- 所以只能根据player的位置做一个操作
-- 不传的话那么就会以自己当前场景的坐标为目标显示
function FollowEntity:setVisible(visible, player)
	visible = not not visible
	if visible ~= self.visible then
		if visible then
			local mapID = nil
			local scene = nil
			local pos = nil
			if player then
				mapID = player:getScene():getMapID()
				scene = player:getScene()
				pos = TileUtils.getVaildTile(player, 1, true)	
			else
				mapID = self:getScene():getMapID()
				scene = self:getScene()
				pos = self:getPos()
			end
			--scene is not exist return
			if not scene then
				print("show follow entity error, because the scene is nil!!!")
				return
			end
			-- pos is not vaild return
			if not pos then
				print("show follow entity error, because the pos is nill!!!!")
				return
			end
			if self:getEntityType() == eLogicFollow then
				if mapDB[mapID].mapType == MapType.Task or mapDB[mapID].mapType == MapType.Wild or member:getTaskType() == TaskType.loop then
					if scene:attachEntity(self, pos.x , pos.y) then
						self.visible = true
					else
						print("show follow entity error, because the scene attachentity error!!!")
					end
				end
			end
		else
			local scene = nil
			if player then
				scene = player:getScene()
			else
				scene = self:getScene()
			end
			if scene then
				scene:detachEntity(self)
				self.visible = false
			end
		end
	end
end

function FollowEntity:isVisible()
	return self.visible
end
