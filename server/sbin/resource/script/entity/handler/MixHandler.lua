--[[MixHandler.lua
描述:玩家混合handler可以随意加东西在这里
]]

MixHandler = class(nil, Timer)


function MixHandler:__init(player)
	self.owner = player
	-- 开启1分钟的定时器
	self.timerID = g_timerMgr:regTimer(self, 1000*60, 1000*60, "MixHandler")
	
end

function MixHandler:__release()
	self.owner = nil
	-- 删除定时器
	g_timerMgr:unRegTimer(self.timerID)
	
	self.timerID = nil
end

function MixHandler:update(timer)
	if timer == self.timerID then
		 self:updatePlayerBanSpeechTime()
	end
end

function MixHandler:updatePlayerBanSpeechTime()
	if self.owner:getBanSpeechTime() > 0 then
		local banSpeech = self.owner:getBanSpeechTime() - 1
		if banSpeech < 1 then
			-- 通知社会服
			local event = Event.getEvent(ChatEvents_SB_BanSpeech, self.owner:getDBID(),0)
			g_eventMgr:fireWorldsEvent(event, SocialWorldID)
		end
		self.owner:setBanSpeechTime(banSpeech)
	end
end

function MixHandler:changeBanSpeechTime(banSpeechTime)
	if banSpeechTime > 0 then
		self.owner:setBanSpeechTime(banSpeechTime)
		-- 通知社会服
		local event = Event.getEvent(ChatEvents_SB_BanSpeech, self.owner:getDBID(),banSpeechTime)
		g_eventMgr:fireWorldsEvent(event, SocialWorldID)
	end
end



