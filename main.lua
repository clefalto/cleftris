-- TETRIS! PICO-8 VERSION! WOULD YOU CALL THIS A DEMAKE? IDK!



frame = 0
rotate_mode = 0

function _init()
    grid:initialize()
end

function _update()
    frame = frame + 1

    if btnp(🅾️) then
        rotate_mode = wrap(rotate_mode + 1, 0, 3)
    end

    if btnp(❎) then
        local p = create_piece(flr(rnd(7) + 1), 0)
        p.x = 5
        p.y = 5
        
        local t = transform(p, 1)
        for i, v in ipairs(t) do
            log(v)
        end
    end
end

function _draw()
    cls(0)
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
        spr((i * 2 - 1) + 32, (i * 8 - 1) + 24, 110)
    end

    
    -- draw_piece(1, 10, 10, 0)
    -- draw_piece(1, 10, 30, 1)
    -- draw_piece(1, 10, 50, 2)
    -- draw_piece(1, 10, 70, 3)
    -- circ(10, 10, 1, 11)
    -- circ(10, 30, 1, 11)
    -- circ(10, 50, 1, 11)
    -- circ(10, 70, 1, 11)
    -- sprot(10, 30, 3, 2, 0, 0, -1)
end

