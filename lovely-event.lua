local LovelyEvent = {
  events = {}, -- list of all events
  eventQueue = {},
  waitTimer = 0,
  -- -- --
  loopedEvent = false, -- if event is looped
}
-- -- --
function LovelyEvent.new()
  local e = setmetatable( LovelyEvent, { __index = LovelyEvent } )
  e:loadDefaultEvents()
  return e
end
-- -- --
function LovelyEvent:isRunning() return #self.eventQueue > 0 or self.waitTimer > 0 end
-- -- --


-- -- --
function LovelyEvent:update( dt )
  if self.waitTimer > 0 then
    self.waitTimer = self.waitTimer - dt
  else
    if #self.eventQueue ~= 0 then
      -- throws error if event doesn't exist
      if not self.events[self.eventQueue[1].name] then error( "EventSystem Event \""..self.eventQueue[1].name.."\" doesn't exist!" ) end
      -- otherwise, runs as usual
      local finishedEvent = self.events[self.eventQueue[1].name]( self.eventQueue[1].vars, self.loopedEvent )
      if finishedEvent then table.remove( self.eventQueue, 1 ) self.loopedEvent = false else self.loopedEvent = true end
    end
  end
end
-- -- --


-- -- --
function LovelyEvent:loadDefaultEvents()
  self:newEvent( "wait", function( vars, looped ) self.waitTimer = vars return true end )
  self:newEvent( "print", function( vars, looped ) print( vars ) return true end )
end
-- -- --
function LovelyEvent:queueEvent( name, ... )
  local vars = {...} if #vars == 1 then vars = vars[1] end
  table.insert( self.eventQueue, {name=name,vars=vars} )
end
-- -- --
function LovelyEvent:newEvent( name, func )
  self.events[name] = func
end
-- -- --


-- -- --
return LovelyEvent.new()
