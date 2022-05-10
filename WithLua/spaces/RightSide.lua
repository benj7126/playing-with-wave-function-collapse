local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile5.png")
tile.name = "RightSide"
tile.dirs = {
    {"RightSide", "RightCorner"},
    {"Void", "CenterTop"},
    {"RightSide", "CenterTop"},
    {"Filling", "LeftSide"},
}

return tile