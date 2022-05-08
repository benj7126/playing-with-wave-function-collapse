local space = require "space"

local tile = space:new()

tile.color = {0, 1, 0}
tile.name = "forrestGreen"
tile.dirs = {
    {"forrestGreen", "green"},
    {"forrestGreen", "green"},
    {"forrestGreen", "green"},
    {"forrestGreen", "green"},
}

return tile