local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile4.png")
tile.name = "LeftSide"
tile.dirs = {
    {"LeftSide", "LeftCorner"},
    {"Filling", "RightSide"},
    {"LeftSide", "CenterTop"},
    {"Void", "CenterTop"},
}

return tile