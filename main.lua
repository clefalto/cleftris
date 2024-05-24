-- TETRIS! PICO-8 VERSION! WOULD YOU CALL THIS A DEMAKE? IDK!



frame = 0
rotate_mode = 0
pWHAT = create_piece(1, 0)
pWHAT.x = 5
pWHAT.y = 1

function _init()
    grid:initialize()
end

function _update()
    frame = frame + 1

    if btnp(🅾️) then
        rotate_mode = wrap(rotate_mode + 1, 0, 3)
    end

    if btnp(❎) then
        local p1 = create_piece(1, 0)
        p1.x = 4
        p1.y = 1
        grid:place_piece(p1)
    end

    if frame % 10 == 0 then
        if not grid:test_collisions(pWHAT, 0, 1) then
            pWHAT.y += 1
        end
    end

    -- step_piece
end

function _draw()
    cls(1)
    -- bg:draw()
    grid:draw()
    palette:draw()
    ui.draw()

    draw_piece(1, 10, 10, rotate_mode)
    draw_piece(2, 10, 30, rotate_mode)
    draw_piece(3, 10, 50, rotate_mode)
    draw_piece(4, 10, 70, rotate_mode)
    draw_piece(5, 10, 90, rotate_mode)
    draw_piece(6, 100, 10, rotate_mode)
    draw_piece(7, 100, 30, rotate_mode)

    for i = 1, 7 do
        spr((i * 2 - 1) + 32, (i * 9 - 1) + 27, 120)
    end

    
    draw_piece_grid(pWHAT)
end

