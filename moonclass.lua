local setmetatable = setmetatable
local rawget = rawget
local empty
empty = function() end
local createClass
createClass = function(name, parent)
  local class_t = {
    __name = name,
    __init = empty
  }
  local base_t = {
    __class = class_t
  }
  class_t.__base = base_t
  base_t.__index = base_t
  if parent then
    parent.__base.new = parent.__init
    if parent.__inherited then
      parent:__inherited(class_t)
    end
    class_t.__parent = parent
    setmetatable(base_t, parent.__base)
  end
  return setmetatable(class_t, {
    __index = function(_, key)
      local val = rawget(base_t, key)
      if val == nil and parent then
        return parent[key]
      else
        return val
      end
    end,
    __newindex = function(cls, key, value)
      base_t[key] = value
      if key == 'new' then
        cls.__init = value
      end
    end,
    __call = function(cls, ...)
      local self = setmetatable({ }, base_t)
      cls.__init(self, ...)
      return self
    end
  })
end
return createClass
