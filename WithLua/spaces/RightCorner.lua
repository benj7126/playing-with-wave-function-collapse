local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile3.png")
tile.name = "RightCorner"
tile.dirs = {
    {"Void", "Bush", "DoubleBushp1"},
    {"Void", "LeftCorner", "LeftSide"},
    {"RightSide"},
    {"CenterTop", "LeftCorner"},
}

return tile