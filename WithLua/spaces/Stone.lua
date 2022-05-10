local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("stone.png")
tile.name = "Stone"
tile.dirs = {
    {"Grass", "Bricks", "Stone", "Stone", "Stone", "Stone", "Stone", "Stone", "Door"},
    {"Grass", "Bricks", "Stone", "Stone", "Stone", "Stone", "Stone", "Stone"},
    {"Grass", "Bricks", "Stone", "Stone", "Stone", "Stone", "Stone", "Stone", "Door"},
    {"Grass", "Bricks", "Stone", "Stone", "Stone", "Stone", "Stone", "Stone"},
}

return tile