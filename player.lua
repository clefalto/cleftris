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

-- player is only controlling one piece at any given time, meaning only one piece is falling at any given time
-- so can do expensive calculations >:)
