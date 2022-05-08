local space = {}

function space:new()
    local o = {}
    o.dirs = {
        {}, -- up
        {}, -- right
        {}, -- down
        {}, -- left
    }
    o.name = "nil"
    o.color = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function space:setDirs()
    
end

return space