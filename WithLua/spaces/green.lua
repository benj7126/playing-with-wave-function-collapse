local space = require "space"

local tile = space:new()

tile.color = {0.5, 1, 0.5}
tile.name = "green"
tile.dirs = {
    {"forrestGreen", "green", "sandy"},
    {"forrestGreen", "green", "sandy"},
    {"forrestGreen", "green", "sandy"},
    {"forrestGreen", "green", "sandy"},
}

return tile