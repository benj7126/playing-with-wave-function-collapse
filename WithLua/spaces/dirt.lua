local space = require "space"

local tile = space:new()

tile.color = {0.7, 0.5, 0.3}
tile.name = "dirt"
tile.dirs = {
    {"dirt", "grass"},
    {"dirt", "grass"},
    {"dirt"},
    {"dirt", "grass"},
}

return tile