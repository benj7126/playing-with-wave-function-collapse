local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile9.png")
tile.name = "DoubleBushp1"
tile.dirs = {
    {"DoubleBushp2"},
    {"Void", "Bush", "DoubleBushp1"},
    {"CenterTop"},
    {"Void", "Bush", "DoubleBushp1"},
}

return tile