local space = {}

function space:new()
    local o = {}
    o.dirs = {
        {}, -- up
        {}, -- right
        {}, -- down
        {}, -- left
    }
    o.possibleDir = { -- things that can be placed, but i cant
        {}, -- up
        {}, -- right
        {}, -- down
        {}, -- left
    }
    o.priority = 1
    o.name = "nil"
    o.image = nil
    setmetatable(o, self)
    self.__index = self
    return o
end

function space:setDirs()
    
end

return space