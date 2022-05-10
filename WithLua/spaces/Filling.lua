local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("tile10.png")
tile.name = "Filling"
tile.priority = 0
tile.dirs = {
    {"Filling", "CenterTop"},
    {"Filling", "RightSide"},
    {"Filling", "RightCorner", "LeftCorner", "CenterTop"},
    {"Filling", "LeftSide"},
}

return tile