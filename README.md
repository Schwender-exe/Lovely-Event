# Lovely-Event
A small Love2D event queue library



## Description
Obviously this isn't a large library, but its flexability is what really shines.
'Lovely-Event' is a simple but flexible library which is built to help you with anything your heart desires when it comes to queable 'events' in a linear fashion.


## Setting it up in your project!
Setting Lovely-Event is as simple as it gets.

First, require the library.
```Lua
LovelyEvent = require 'lovely-event'
```

Make sure it's updated:
```Lua
function love.update( dt )
  LovelyEvent:update(dt)
end
```

Next up, you'll probably want to initialize new events:
```Lua
LovelyEvent:newEvent( "ExampleEventName", function( vars, looped )
  -- code here
  return true
end )
```
Notice the `return true` there? that's extremely important as Lovely-Event won't continue past that event until it returns true. Also notice, `vars` and `looped` variables within the function? those are also a requirement as any variables inputted when queuing the event is funnelled into there while `looped` is a bool which indicates whether the called function is being looped (doesn't return true on first call).

Once all that's done with, next comes queuing the event itself!
```Lua
LovelyEvent:queueEvent( "ExampleEventName", 1, var2, "3" )
```

Wanted to check if the event system is currently running? Easy!
```Lua
LovelyEvent:isRunning()
```

## Functions
When it comes to functions, well it's pretty bare-bones, the bulk of it comes from what you add on to it, but here's a list of what's included:

### Update
call within love.update(dt), use to update Lovely-Event
```Lua
LovelyEvent:update( number:dt )
```

### isRunning
returns whether there are queued events or not
```Lua
(bool) = LovelyEvent:isRunning()
```

### newEvent
initializes a new event by the given Name, can be called later with the same given name.
```Lua
LovelyEvent:newEvent( string:Name, function:Func( vars, looped ) )
```
`vars`: given variables when queued, note that if only one variable is expected, use 'vars'. If multiple then use vars\[index]. Named variables can be achieved by having one variable which would be a table eg.
`{example=1,name="example!"}` which would be called as: `vars.example` and `vars.name`

`looped`: boolean which is true if function is 'looping' aka hasn't returned true yet. Always end your function with 'return true', otherwise will infinitely loop the event.

### queueEvent
queues event of given name, if it exists / has been initialized.
```Lua
LovelyEvent:queueEvent( string:Name, ... )
```

## Example Events!

### call X times
loops the event X times (X = being the given variable)
```lua
LovelyEvent:newEvent( "callXTimes", function( vars, looped )
  return vars < 1
  vars = vars - 1
end )
```
example queuing:
```Lua
LovelyEvent:queueEvent( "callXTimes", 4 )
-- will loop event 4 times before continuing
```

### set direction
example of a set event for setting the direction of a character:
```Lua
LovelyEvent:newEvent( "setDirection", function( vars, looped )
  vars[1].direction = vars[2]
  return true
end)
```
example queueing:
```Lua
LovelyEvent:queueEvent( "setDirection", Player, "left" )
```
