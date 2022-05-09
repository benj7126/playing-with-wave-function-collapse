local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile2.png")
tile.name = "CenterTop"
tile.dirs = {
    {"Void", "Bush", "DoubleBushp1", "LeftSide", "RightSide", "LeftCorner", "RightCorner"},
    {"CenterTop", "RightCorner"},
    {"Void"},
    {"CenterTop", "LeftCorner"},
}

return tile