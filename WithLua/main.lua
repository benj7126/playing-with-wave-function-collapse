local grid = {}
local gW, gH = 80, 60

-- list all tiles
local allTiles = {"blue", "sandy", "green", "forrestGreen"}

-- creat tiles
local tileManager = {}
for i, v in pairs(allTiles) do
    tileManager[v] = require("spaces."..v)
end

local tileSize = 10
local showGrid = true
local autoSpace = false

-- assign tiles
for i, v in pairs(allTiles) do
    local tile = tileManager[v]
    for i2 = 1,4 do
        for i3, tileToAdd in pairs(tile.dirs[i2]) do
            tile.dirs[i2][i3] = tileManager[tileToAdd]
        end
    end
end

local spaces = {
    tileManager.blue,
    tileManager.sandy,
    tileManager.green,
    tileManager.forrestGreen,
}

function love.load()
    for x = 1,gW do
        grid[x] = {}
        for y = 1,gH do
            grid[x][y] = {}
            for i, val in pairs(spaces) do
                grid[x][y][i] = val
            end
        end
    end
end

function love.update()
    if autoSpace then
        activateLowestRandom()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
    for x = 1,gW do
        for y = 1,gH do
            local tilePossiblity = grid[x][y]
            if #tilePossiblity == 1 then
                local tile = findVal(tilePossiblity)
                love.graphics.setColor(tile.color)
                love.graphics.rectangle("fill", (x-1)*tileSize, (y-1)*tileSize, tileSize, tileSize)
            end
            if showGrid then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", (x-1)*tileSize, (y-1)*tileSize, tileSize, tileSize)
            end
        end
    end
end

function love.keypressed(key)
    if key == "space" then
        activateLowestRandom()
    elseif key == "f" then
        for i = 1,gW*gH do
            activateLowestRandom()
        end
    elseif key == "l" then
        autoSpace = not autoSpace
    elseif key == "r" then
        love.load()
    elseif key == "g" then
        showGrid = not showGrid
    end
end

function activateLowestRandom()
    local lowest = 999
    for x = 1,gW do
        for y = 1,gH do
            if #grid[x][y] ~= 1 and #grid[x][y] ~= 0 then
                if #grid[x][y] < lowest then
                    lowest = #grid[x][y]
                end
            end
        end
    end

    local gridToChoseFrom = {}
    for x = 1,gW do
        for y = 1,gH do
            if #grid[x][y] == lowest then
                table.insert(gridToChoseFrom, {x, y})
            end
        end
    end

    if #gridToChoseFrom ~= 0 then
        local pos = gridToChoseFrom[love.math.random(1, #gridToChoseFrom)]
        choseGrid(pos[1], pos[2], love.math.random(1, #grid[pos[1]][pos[2]]))
    end
end

function choseGrid(x, y, nr)
    local valToSave = grid[x][y][nr]
    grid[x][y] = {}
    grid[x][y][1] = valToSave
    if orNil(x+1, y) ~= nil then
        recalcPossibilities(x+1, y)
    end
    if orNil(x, y+1) ~= nil then
        recalcPossibilities(x, y+1)
    end
    if orNil(x-1, y) ~= nil then
        recalcPossibilities(x-1, y)
    end
    if orNil(x, y-1) ~= nil then
        recalcPossibilities(x, y-1)
    end
end

function recalcPossibilities(x, y)
    if #grid[x][y] == 1 then
        return
    end
    grid[x][y] = {}
    local overlaps = {orNil(x+1, y), orNil(x, y+1), orNil(x-1, y), orNil(x, y-1)}
    local overlapDirs = {4, 1, 2, 3}

    for i = 1,4 do
        if overlaps[i] ~= nil then
            local newList = {}
            for _, actualList in pairs(overlaps[i]) do
                for _, v in pairs(actualList.dirs[overlapDirs[i]]) do
                    table.insert(newList, v)
                end
            end
            overlaps[i] = newList
        end
    end

    --checkOverlaps
    for i, v in pairs(spaces) do
        local vals = {false, false, false, false}
        for i2 = 1,4 do
            vals[i2] = nilTrue(overlaps[i2]) -- if a side is nil, then any tile is accepted there

            -- check if it contains tile
            if vals[i2] == false then
                vals[i2] = contains(overlaps[i2], v)
            end
        end

        if (vals[1] == true and vals[2] == true and vals[3] == true and vals[4] == true) then
            table.insert(grid[x][y], spaces[i])
        end
    end
end

function contains(table, val)
    for i, v in pairs(table) do
        if v==val then
            return true
        end
    end
    return false
end

function nilTrue(val)
    if val == nil then
        return true
    end
    return false
end

function orNil(x, y)
    if grid[x] then
        if grid[x][y] then
            return grid[x][y]
        end
    end
    return nil
end

function findVal(toFindIn)
    for i, v in pairs(toFindIn) do
        return v
    end
end