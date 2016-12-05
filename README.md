# Moonclass
MoonScript class implementation for Lua

### How to use
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

local Bar = class('Bar', Foo)
function Bar:new()
    Foo.new(self)
end
```

### And the other way

Create a class Foo in foo.lua:

```Lua
local class = require 'moonclass'

local Foo = class 'Foo'
function Foo:new()
end

return Foo
```

Import class Foo to bar.moon:

```MoonScript
Foo = require 'foo'

class Bar extends Foo
    new: =>
        super!
```
