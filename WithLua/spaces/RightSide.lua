local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile5.png")
tile.name = "RightSide"
tile.dirs = {
    {"RightSide", "RightCorner"},
    {"Void"},
    {"RightSide", "CenterTop"},
    {"Void", "LeftSide"},
}

return tile