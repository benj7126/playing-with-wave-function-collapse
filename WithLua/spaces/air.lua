local space = require "space"

local tile = space:new()

tile.color = {1, 1, 1}
tile.name = "air"
tile.dirs = {
    {"air"},
    {"grass", "air"},
    {"grass", "air"},
    {"grass", "air"},
}

return tile