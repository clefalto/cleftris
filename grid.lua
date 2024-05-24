grid = {}

grid.num_rows = 20
grid.num_columns = 10
grid.cell_size = 5 -- they are squares
grid.mtx = {} -- the actual grid that stores values, indexed using columns and rows
grid.center = {x = 64, y = 64}
grid.rect = {}

function grid:initialize() 
    for j = 1, self.num_rows do
        self.mtx[j] = {}
        for i = 1, self.num_columns do
            self:place_cell(i, j, 0)
        end
    end

    -- just an aabb describing the rectangle formed by the grid
    self.rect = {x = self.center.x - (self.num_columns * self.cell_size)/2, 
                 y = self.center.y - (self.num_rows * self.cell_size)/2,
                 w = self.num_rows * self.cell_size,
                 h = self.num_columns * self.cell_size}
end

-- place piece at cell, this sets the values of the grid cells which that piece occupies
-- use when placing a piece in a FINAL location, not when it's falling
function grid:place_piece(piece) 
    -- pass in a "piece" table created using "create_piece" please
    -- rot: 0 -> default rotation, 1 -> 90 degrees cw, 2 -> 180 degrees cw, 3 -> 270 degrees cw
    -- for i, v in ipairs(piece) do
    --     log(v)
    -- end
    
    local cell_pos = {x = piece.x, y = piece.y}
    local shp = piece.shape

    for i in pairs(shp) do
        for j in pairs(shp[i]) do
            if shp[i][j] != 0 then
                self:place_cell(j - 1 + cell_pos.x, i - 1 + cell_pos.y, piece.type)
            end
        end
    end
end

-- place a cell in the grid to begin drawing it, sets the value in the internal grid array
function grid:place_cell(cx, cy, type)
    -- cx, cy: cell x and y position
    -- type: piece type, should be in range 1-6
    if cx > self.num_columns or cx < 1 then return end
    if cy > self.num_rows or cy < 1 then return end
    type = wrap(type, 0, 8) -- wrap type just in case
    self.mtx[cy][cx] = type
    if type != 0 then -- don't log empty cells being placed
        log("placed cell "..type.." at cell x = "..cx.." and cell y = "..cy)
    end
end

-- poll the grid to test if the given piece collides w/ any grid cells
function grid:test_collisions(piece, dx, dy)
    dx = dx or 0
    dy = dy or 0
    local new_origin_pos = {x = piece.x + dx, y = piece.y + dy}
    for i in pairs(piece.shape) do
        for j in pairs(piece.shape[i]) do
            if piece.shape[i][j] != 0 then
                if self.mtx[new_origin_pos.y + i][new_origin_pos.x + j] != 0 then
                    return true
                end
            end
        end
    end
    return false
end

function grid:draw()
    -- draw the grid at the center of the screen.
    -- each cell should be 5x5 pixels.
    -- each cell (in the 2d array defined by rows & columns) will store a number corresponding to the 
    -- block that was dropped there, so it still renders the right pixel for that block fragment.

    -- original draw position
    local origin = {x = self.rect.x, y = self.rect.y}
    local pos = origin

    for i = 1, self.num_columns do
        for j = 1, self.num_rows do
            local pos = {x = origin.x + (i - 1) * self.cell_size, y = origin.y + (j - 1) * self.cell_size}
            -- block 1 is J piece, 
            -- block 2 is L piece, 
            -- block 3 is T piece, 
            -- block 4 is S piece, 
            -- block 5 is 2 piece, 
            -- block 6 is square piece,
            -- block 7 is tetris
            local val = self.mtx[j][i]
            palt(0, false) -- draw black bg of grid
            palt(1, true)
            spr(val * 2 - 1 + 32, pos.x, pos.y) -- fine
            palt(0, true) -- woah
            palt(1, false)
            if val != 0 then 
                log("drew cell "..val.." at cell position x = "..i.." y = "..j) 
                -- circ(pos.x, pos.y, 0, 11)
            end
        end
    end
end