grid = {}

grid.num_rows = 20
grid.num_columns = 10
grid.cell_size = 5 -- they are squares
grid.mtx = {} -- the actual grid that stores values, indexed using columns and rows
grid.center = {x = 64, y = 64}
grid.rect = {}

function grid:reset() 
    for i = 1, self.num_rows do
        self.mtx[i] = {}
        for j = 1, self.num_columns do
            self:place_cell(j, i, 0)
        end
    end

    -- just an aabb describing the rectangle formed by the grid
    -- doing this in this function might waste cpu cycles when the grid is reset in the future but I DONT CARE!
    self.rect = {x = self.center.x - (self.num_columns * self.cell_size)/2, 
                 y = self.center.y - (self.num_rows * self.cell_size)/2,
                 w = self.num_columns * self.cell_size,
                 h = self.num_rows * self.cell_size}
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
    
    -- initial pass, make sure we're not placing inside already existing pieces
    for i in pairs(shp) do
        for j in pairs(shp[i]) do
            if shp[i][j] != 0 then
                self:place_cell(j - 1 + cell_pos.x, i - 1 + cell_pos.y, piece.type)
            end
        end
    end
    for i in pairs(shp) do
        for j in pairs(shp[i]) do
            if shp[i][j] != 0 then
                self:place_cell(j - 1 + cell_pos.x, i - 1 + cell_pos.y, piece.type)
            end
        end
    end

    local piece_bottom_row = cell_pos.y + piece.dim.h - 1
    self:perform_line_clears(piece_bottom_row)
end

-- place a cell in the grid to begin drawing it, sets the value in the internal grid array
function grid:place_cell(cx, cy, type)
    -- cx, cy: cell x and y position
    -- type: piece type, should be in range 1-7
    if cy <= 1 and type != 0 then lose_game() 
        return
    end
    if cx > self.num_columns or cx < 1 then return end
    if cy > self.num_rows then return end
    type = wrap(type, 0, 7) -- wrap type just in case
    self.mtx[cy][cx] = type
    -- if type != 0 then -- don't log empty cells being placed
    --     log("placed cell " .. type .. " at cell x = " .. cx .. " and cell y = " .. cy)
    -- end
end

-- poll the grid to test if the given piece collides w/ any grid cells
function grid:test_collisions(piece, dx, dy)
    dx = dx or 0
    dy = dy or 0
    local new_origin_pos = {x = piece.x + dx, y = piece.y + dy}
    for i in pairs(piece.shape) do
        for j in pairs(piece.shape[i]) do
            if piece.shape[i][j] != 0 then
                local test_pos = {x = new_origin_pos.x + (j - 1), y = new_origin_pos.y + (i - 1)}
                if test_pos.x < 1 or test_pos.x > self.num_columns or 
                   test_pos.y < 1 or test_pos.y > self.num_rows or
                   self.mtx[test_pos.y][test_pos.x] != 0 then
                    log("collision detected at " .. test_pos.x .. " " .. test_pos.y)
                    return {true, {x = test_pos.x, y = test_pos.y}}
                end
            end
        end
    end
    return {false, nil}
end

function grid:get_cell(cx, cy) 
    if cx < 1 or cy < 1 or cx > self.num_rows or cy > self.num_columns then return -1 end
    return self.mtx[cy][cx]
end

function grid:perform_line_clears(start_row)
    -- iterate through grid starting from the bottom, check if the row is completely filled in
    -- if it is, delete all the cells in that row and move everything above it down one
    -- but don't move everything down until you check all the rows
    -- only iterate a max of four times because you can't clear more than 4 lines at once
    -- there's probably a really crazy efficient awesome way of doing this but oh well
    
    -- only called when a piece is placed! mmmm conserve those cpu cycles drooling face emoji
    
    -- find lines
    log("start row: " .. start_row)

    local beebo = false
    local mask = {0, 0, 0, 0} -- dont even worry about this
    local iteration = 1
    for i = start_row, max(start_row - 4, 1), -1 do
        for j = 1, self.num_columns do
            log("am i gooing insane " .. self:get_cell(j, i))
            if self:get_cell(j, i) == 0 then
                log("beebo'd at cx = " .. j .. " and cy = " .. i)
                beebo = true
                break
            end
        end
        if not beebo then 
            mask[iteration] = 1
        end
        iteration += 1
    end

    local GRAJHGRLKAJRH = ""
    for i in pairs(mask) do
        GRAJHGRLKAJRH = GRAJHGRLKAJRH .. mask[i]
    end
    log("uh, " .. GRAJHGRLKAJRH)

    -- move all lines above found lines down by one row
    for i,v in ipairs(mask) do
        if v == 1 then
            -- move all rows above this one down by one row
            local cur_row = start_row - (i-1)
            for j = cur_row, self.num_rows - 1, -1 do -- (except for the top row)
                for k = 1, self.num_columns do
                    self:place_cell(k, j, self:get_cell(k, j - 1)) -- set this cell to the cell directly above it
                end
            end
            -- set the top row to zeroes
            for k = 1, self.num_columns do
                self:place_cell(k, 1, 0)
            end
        end
    end

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
            -- palt(0, false) -- draw black bg of grid
            -- palt(15, true)
            -- spr(val * 2 - 1 + 32, pos.x, pos.y) -- fine
            -- palt(0, true) -- woah
            -- palt(15, false)
            draw_block(val, pos.x, pos.y)
            -- if val != 0 then 
            --     log("drew cell "..val.." at cell position x = "..i.." y = "..j) 
            --     -- circ(pos.x, pos.y, 0, 11)
            -- end
        end
    end
end