local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile1.png")
tile.name = "LeftCorner"
tile.dirs = {
    {"Void", "Bush", "DoubleBushp1"},
    {"CenterTop", "RightCorner"},
    {"LeftSide"},
    {"Void", "RightCorner", "RightSide"},
}

return tile