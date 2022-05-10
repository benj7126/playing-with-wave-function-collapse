local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile2.png")
tile.name = "CenterTop"
tile.dirs = {
    {"Void", "Filling", "Bush", "DoubleBushp1", "LeftSide", "RightSide", "LeftCorner", "RightCorner"},
    {"CenterTop", "RightCorner"},
    {"Filling"},
    {"CenterTop", "LeftCorner"},
}

return tile