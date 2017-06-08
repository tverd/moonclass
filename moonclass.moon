--
--    Copyright (c) 2013-2017 Mikhail Yakushev

--    Permission is hereby granted, free of charge, to any person
--    obtaining a copy of this software and associated documentation
--    files (the "Software"), to deal in the Software without
--    restriction, including without limitation the rights to use,
--    copy, modify, merge, publish, distribute, sublicense, and/or sell
--    copies of the Software, and to permit persons to whom the
--    Software is furnished to do so, subject to the following
--    conditions:

--    The above copyright notice and this permission notice shall be
--    included in all copies or substantial portions of the Software.

--    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
--    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
--    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
--    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
--    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
--    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
--    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
--    OTHER DEALINGS IN THE SOFTWARE.

--------------------------------------------------------------------------------
setmetatable = setmetatable
rawget = rawget
--------------------------------------------------------------------------------
empty = ->

createClass = ( name, parent ) ->
    class_t = { __name: name, __init: empty }
    base_t = { __class: class_t }

    class_t.__base = base_t
    base_t.__index = base_t

    if parent
        class_t.__init = parent.__init
        parent.__base.new = parent.__init

        if parent.__inherited
            parent\__inherited(class_t)

        class_t.__parent = parent
        setmetatable(base_t, parent.__base)

    setmetatable class_t,
        __index: ( _, key ) ->
            val = rawget base_t, key
            if val == nil and parent
                parent[key]
            else
                val

        __newindex: ( cls, key, value ) ->
            base_t[key] = value
            if key == 'new'
                cls.__init = value

        __call: ( cls, ... ) ->
            self = setmetatable {}, base_t
            cls.__init(self, ...)
            self


createClass
