--[[TransportationHandler.lua



]]


TransportationHandler = class()

function TransportationHandler:__init(entity)
	self._entity = entity
    self._flyFlagPositionList = {}
end

function TransportationHandler:setFlyFlagPositionList( flyFlagPositionList )

    self._flyFlagPositionList = flyFlagPositionList

end

function TransportationHandler:getFlyFlagPositionList(  )

    return self._flyFlagPositionList

end

function TransportationHandler:__release()
	self._entity = nil
    self._flyFlagPositionList = nil
end