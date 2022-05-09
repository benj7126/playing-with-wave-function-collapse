local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile7.png")
tile.name = "Bush"
tile.dirs = {
    {"Void"},
    {"Void", "Bush", "DoubleBushp1"},
    {"CenterTop", "LeftCorner", "RightCorner"},
    {"Void", "Bush", "DoubleBushp1"},
}

return tile