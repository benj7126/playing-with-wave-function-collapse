local grid = {}
local placedGrid = {}
local gW, gH = 80, 60

love.graphics.setDefaultFilter("nearest", "nearest")

-- list all tiles
local allTiles = {"Bush", "CenterTop", "DoubleBushp1", "DoubleBushp2", "LeftCorner", "LeftSide", "RightCorner", "RightSide", "Void", "Filling"}
--local allTiles = {"Grass", "Bricks", "Stone", "Door"}

-- creat tiles
local tileManager = {}
for i, v in pairs(allTiles) do
    tileManager[v] = require("spaces."..v)
end

local tileSize = 10
local showGrid = true
local doDebug = false
local autoSpace = false

-- assign tiles
for i, v in pairs(allTiles) do
    local tile = tileManager[v]
    for i2 = 1,4 do
        for i3, tileToAdd in pairs(tile.dirs[i2]) do
            tile.dirs[i2][i3] = tileManager[tileToAdd]
        end
        for i3, tileToAdd in pairs(tile.possibleDir[i2]) do
            tile.possibleDir[i2][i3] = tileManager[tileToAdd]
        end
    end
end

local spaces = {
    -- tileManager.Grass,
    -- tileManager.Bricks,
    -- tileManager.Stone,
    -- tileManager.Door,
    tileManager.Bush,
    tileManager.CenterTop,
    tileManager.DoubleBushp1,
    tileManager.DoubleBushp2,
    tileManager.LeftCorner,
    tileManager.LeftSide,
    tileManager.RightCorner,
    tileManager.RightSide,
    tileManager.Void,
    tileManager.Filling,
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
    for x = 1,gW do
        placedGrid[x] = {}
        for y = 1,gH do
            placedGrid[x][y] = false
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
            
            if placedGrid[x][y] and #tilePossiblity ~= 0 then
                local tile = findVal(tilePossiblity)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(tile.image, (x-1)*tileSize, (y-1)*tileSize, 0, tileSize/64, tileSize/64)
            end
            if showGrid then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", (x-1)*tileSize, (y-1)*tileSize, tileSize, tileSize)
            end
        end
    end

    local x, y = love.mouse.getPosition()
    x, y = math.floor(x/tileSize)+1, math.floor(y/tileSize)+1

    local val = orNil(x, y)
    if val then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", 0, 0, 100, 40)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(x.." | "..y.." = "..#val, 0, 0)
        if placedGrid[x][y] then
            love.graphics.print("true", 0, 20)
        else
            love.graphics.print("false", 0, 20)
        end
    end

    if doDebug then
        recalcPossibilities(x, y, 2)
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
    elseif key == "d" then
        doDebug = not doDebug
    end
end

function activateLowestRandom()
    local lowest = 999
    for x = 1,gW do
        for y = 1,gH do
            if placedGrid[x][y] == false and #grid[x][y] ~= 0 then
                if #grid[x][y] < lowest then
                    lowest = #grid[x][y]
                end
            end
        end
    end

    local val = 0
    local gridToChoseFrom = {}
    for x = 1,gW do
        for y = 1,gH do
            if #grid[x][y] == lowest and placedGrid[x][y] == false then
                local thisPri = getPriority(grid[x][y])
                table.insert(gridToChoseFrom, {{x, y}, thisPri})
                
                val = math.max(thisPri, val)
            end
        end
    end

    local gridToChoseFrom2 = {}
    for _, obj in pairs(gridToChoseFrom) do
        if obj[2] == val then
            table.insert(gridToChoseFrom2, obj[1])
        end
    end

    if #gridToChoseFrom2 ~= 0 then
        local pos = gridToChoseFrom2[love.math.random(1, #gridToChoseFrom2)]
        local listOfNRs = {}
        local myPriority = 0
        for _, tile in pairs(grid[pos[1]][pos[2]]) do
            if myPriority < tile.priority then
                myPriority = tile.priority
            end
        end
        for i, tile in pairs(grid[pos[1]][pos[2]]) do
            if tile.priority == myPriority then
                table.insert(listOfNRs, i)
            end
        end
        choseGrid(pos[1], pos[2], listOfNRs[love.math.random(1, #listOfNRs)])
    end
end

function getPriority(list)
    local pri = 0
    for _, v in pairs(list) do
        pri = pri + v.priority
    end
    return pri
end

function choseGrid(x, y, nr)
    placedGrid[x][y] = true
    local valToSave = grid[x][y][nr]
    grid[x][y] = {}
    grid[x][y][1] = valToSave
    if orNil(x+1, y) ~= nil then
        recalcPossibilities(x+1, y, 2)
    end
    if orNil(x, y+1) ~= nil then
        recalcPossibilities(x, y+1, 2)
    end
    if orNil(x-1, y) ~= nil then
        recalcPossibilities(x-1, y, 2)
    end
    if orNil(x, y-1) ~= nil then
        recalcPossibilities(x, y-1, 2)
    end
end

function recalcPossibilities(x, y, itterations)
    itterations = itterations - 1
    if itterations == 0 then
        return
    end
    if placedGrid[x][y] then
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
                for _, v in pairs(actualList.possibleDir[overlapDirs[i]]) do
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

        if doDebug then
            print(vals[1], vals[2], vals[3], vals[4], v.name)
        end

        if (vals[1] == true and vals[2] == true and vals[3] == true and vals[4] == true) then
            table.insert(grid[x][y], spaces[i])
        end
    end

    if orNil(x+1, y) ~= nil then
        recalcPossibilities(x+1, y, itterations)
    end
    if orNil(x, y+1) ~= nil then
        recalcPossibilities(x, y+1, itterations)
    end
    if orNil(x-1, y) ~= nil then
        recalcPossibilities(x-1, y, itterations)
    end
    if orNil(x, y-1) ~= nil then
        recalcPossibilities(x, y-1, itterations)
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
            if #grid[x][y] == 0 then
                return nil
            end
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