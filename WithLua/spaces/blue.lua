local space = require "space"

local tile = space:new()

tile.color = {0, 0, 1}
tile.name = "blue"
tile.dirs = {
    {"blue", "sandy"},
    {"blue", "sandy"},
    {"blue", "sandy"},
    {"blue", "sandy"},
}

return tile