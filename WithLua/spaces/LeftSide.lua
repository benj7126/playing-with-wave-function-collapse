local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile4.png")
tile.name = "LeftSide"
tile.dirs = {
    {"LeftSide", "LeftCorner"},
    {"Void", "RightSide"},
    {"LeftSide", "CenterTop"},
    {"Void"},
}

return tile