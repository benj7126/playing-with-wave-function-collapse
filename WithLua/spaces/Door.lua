local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("door.png")
tile.name = "Door"
tile.dirs = {
    {"Stone"},
    {"Bricks"},
    {"Stone"},
    {"Bricks"},
}

return tile