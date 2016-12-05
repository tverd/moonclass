# Moonclass
Moon class implementation for Lua

## How to use
Create a class Foo in foo.moon:

```MoonScript
class Foo
    new: =>

Foo
```

Import class Foo to bar.lua:

```Lua
local class = require 'moonclass'
local Foo = require 'foo'

Bar = class('Bar', Foo)
function Bar:new()
    Foo.new(self)
end
```
