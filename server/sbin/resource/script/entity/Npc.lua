--[[Npc.lua
描述：
	NPC类
--]]

require "base.base"
require "entity.Entity"

Npc = class(Entity)

function Npc:__init()
	self._dbID = nil
	self.showParts = "{1,1}"
	self.visible = true
	self.detachTime = nil
end

function Npc:__release()
	self._dbID = nil
	self.showParts = nil
	self.detachTime = nil
	for htype,handler in pairs(self._handlers or {}) do
		release(handler)
		self._handlers[htype] = nil
	end
	self._handlers = nil
end

function Npc:setDBID(dbID)
	self._dbID = dbID
end

function Npc:getDBID()
	return self._dbID
end

function Npc:getID()
	return  self._id or self._dbID
end

function Npc:setShowParts(parts)
	self.showParts = parts
	setPropValue(self._peer,UNIT_SHOWPARTS, showParts)
end

function Npc:getShowParts()
	return self.showParts
end

--	npc可视管理
--  暂时只对跟随npc处理 别的 暂时没有必要调用这个函数
--  这里需要传 player 是因为 显示的话 不知道显示到哪里
--  所以只能根据player的位置做一个操作
--  不传的话那么就会以自己当前场景的坐标为目标显示

function Npc:setVisible(visible, player)
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
			-- 场景不存在 所以直接退出
			if not scene then
				print("show npc error, because the scene is nil!!!")
				return
			end
			
			-- 位置没有找到 那么退出不显示
			if not pos then
				print("show npc error, because the pos is nill!!!!")
				return
			end
			
			if self:getEntityType() == eLogicEctypeNpc then
				if member:getTaskType() == TaskType2.Copy then
					if scene:attachEntity(self, pos.x , pos.y) then
						self.visible = true
					else
						print("show npc error, because the scene attachentity error!!!")
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

function Npc:isVisible()
	return self.visible
end

function Npc:setDetachTime(detachTime)
	self.detachTime = detachTime
end

function Npc:getDetachTime()
	return self.detachTime
end
