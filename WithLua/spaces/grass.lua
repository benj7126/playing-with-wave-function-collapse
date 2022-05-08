local space = require "space"

local tile = space:new()

tile.color = {0, 1, 0}
tile.name = "grass"
tile.dirs = {
    {"air"},
    {"grass", "dirt", "air"},
    {"dirt"},
    {"grass", "dirt", "air"},
}

return tile