local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("bricks.png")
tile.name = "Bricks"
tile.dirs = {
    {"Grass", "Bricks", "Bricks", "Stone"},
    {"Grass", "Bricks", "Bricks", "Stone", "Door"},
    {"Grass", "Bricks", "Bricks", "Stone"},
    {"Grass", "Bricks", "Bricks", "Stone", "Door"},
}

return tile