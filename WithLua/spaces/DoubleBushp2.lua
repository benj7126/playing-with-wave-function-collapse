local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile8.png")
tile.name = "DoubleBushp2"
tile.dirs = {
    {"Void"},
    {"Void"},
    {"DoubleBushp1"},
    {"Void"},
}

return tile