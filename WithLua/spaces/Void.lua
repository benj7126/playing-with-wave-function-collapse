local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile6.png")
tile.name = "Void"
tile.priority = 0
tile.dirs = {
    {"Void", "CenterTop"},
    {"Void", "LeftSide", "LeftCorner", "RightSide"},
    {"Void", "CenterTop"},
    {"Void", "RightSide", "RightCorner", "LeftSide"},
}

return tile