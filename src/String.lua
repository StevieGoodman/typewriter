local TableUtil = require(script.Parent.Parent.TableUtil)

local submodule = {}

local metatable = {}

metatable.__index = submodule

function metatable.__newindex()
    error("Attempt to modify a read-only table")
end

function metatable:__tostring()
    return self.content
end

function metatable:__add(other)
    return self.content .. other
end

function metatable:__concat(other)
    return self.content .. other
end

function metatable:__eq(other)
    return self.content == other.content
end

function metatable:__lt(other)
    return self.content < other.content
end

function metatable:__le(other)
    return self.content <= other.content
end

function metatable:__len()
    return #self.content
end

function submodule.new(content)
    local self = { content = content }
    setmetatable(self, metatable)
    return self
end

function submodule.rep(...)
    return submodule(string.rep(...))
end

function submodule:byte(...)
    return string.byte(self.content, ...)
end

function submodule:char(...)
    return submodule(string.char(self.content, ...))
end

function submodule:find(...)
    return string.find(self.content, ...)
end

function submodule:format(...)
    return submodule(string.format(self.content, ...))
end

function submodule:upper()
    return submodule(string.upper(self.content))
end

function submodule:lower()
    return submodule(string.lower(self.content))
end

function submodule:reverse()
    return submodule(string.reverse(self.content))
end

function submodule:split(...)
    local table = string.split(self.content, ...)
    return TableUtil.Map(table, submodule.new)
end

function submodule:sub(...)
    return submodule(string.sub(self.content, ...))
end

function submodule:gsub(...)
    return submodule(string.gsub(self.content, ...))
end

function submodule:match(...)
    return submodule(string.match(self.content, ...))
end

function submodule:gmatch(...)
    return string.gmatch(self.content, ...)
end

function submodule:pack(...)
    return submodule(string.pack(self.content, ...))
end

function submodule:unpack(...)
    return string.unpack(self.content, ...)
end

setmetatable(submodule, {
    __call = function(self, content)
        return self.new(content)
    end
})

return submodule