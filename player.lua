function draw_piece(idx, x, y, rot)
    local sprite_index = (idx * 2) - 1
    local w, h
    -- special cases for tetris
    if idx == 7 then w = 3 else w = 2 end
    if idx == 7 then h = 1 else h = 2 end
    rot = rot % 4 -- restrict it to be in 0-3 range
    if rot == 0 then
        spr(sprite_index, x, y, w, h, false, false) -- regular
    elseif rot == 1 then
        rotate(sprite_index, 0, x - 1, y, w, h) -- clockwise 90
    elseif rot == 2 then
        spr(sprite_index, x - 1, y - 1, w, h, true, true) -- clockwise 180
    elseif rot == 3 then
        rotate(sprite_index, 1, x, y - 1, w, h) -- clockwise 270
    end
end

-- draw a piece constrained to the grid, uses the piece's position and rotation internally
-- very similar to the place_piece function of grid
function draw_piece_grid(p)
    local grid_origin = {x = grid.rect.x, y = grid.rect.y}
    local piece_origin_screen = {x = (p.x - 1) * grid.cell_size + grid_origin.x, y = (p.y - 1) * grid.cell_size + grid_origin.y}
    for i in pairs(p.shape) do
        for j in pairs(p.shape[i]) do
            if (p.shape[i][j]) == 1 then
                local pos = {x = piece_origin_screen.x  + (j - 1) * grid.cell_size, y = piece_origin_screen.y + (i - 1) * grid.cell_size}
                spr(p.type * 2 - 1 + 32, pos.x, pos.y)
            end
        end
    end
end

-- player is only controlling one piece at any given time, meaning only one piece is falling at any given time
-- so can do expensive calculations >:)
