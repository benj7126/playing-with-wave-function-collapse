local space = require "space"

local tile = space:new()

tile.color = {0.8, 0.5, 0.3}
tile.name = "sandy"
tile.dirs = {
    {"sandy", "blue", "green"},
    {"sandy", "blue", "green"},
    {"sandy", "blue", "green"},
    {"sandy", "blue", "green"},
}

return tile