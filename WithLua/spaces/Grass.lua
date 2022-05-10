local space = require "space"

local tile = space:new()

tile.image = love.graphics.newImage("grass.png")
tile.name = "Grass"
tile.dirs = {
    {"Grass"},
    {"Grass"},
    {"Grass"},
    {"Grass"},
}
tile.possibleDir = {
    {"Bricks", "Stone"},
    {"Bricks", "Stone"},
    {"Bricks", "Stone"},
    {"Bricks", "Stone"},
}

return tile