-- TETRIS! PICO-8 VERSION! WOULD YOU CALL THIS A DEMAKE? IDK!

frame = 0
rotate_mode = 0
ctrl_piece = create_piece(1) -- global variable for the currently controlled piece by the player
held_piece = 0
ctrl_piece.x = 5
ctrl_piece.y = 1
next_piece_type = gen_next_type()

time_left_held = 0
time_right_held = 0

gamestate = 1

piece_step_length = 10 -- every this many frames the current piece falls one cell
fast_drop_step_length = 2

function _init()
    grid:reset()
end

function _update()
    frame = frame + 1

    if gamestate == 1 then
        check_input()

        if frame % piece_step_length == 0 then
            if step_piece(ctrl_piece) then
                place_cur_piece_and_get_next()
            end
        end
    elseif gamestate == 2 then
        -- transition to lose screen or something
    end
end

function _draw()
    cls(1)
    -- bg:draw()
    grid:draw()
    palette:draw()
    ui:draw()

    if gamestate == 2 then
        print("you lose thumbs down emoji", 16, 64, 7)
    end
    
    draw_piece_grid(ctrl_piece)
end

function check_input()
    -- counter clockwise rotation
    if btnp(❎) then
        rotate_mode = wrap(rotate_mode - 1, 0, 3)
        if ctrl_piece then
            log(format_matrix(ctrl_piece.shape))

            rotate_piece(ctrl_piece, 3)
            local rot_coll_test = grid:test_collisions(ctrl_piece, 0, 0)
            if rot_coll_test[1] then
                local dir = {x = rot_coll_test[2].x - ctrl_piece.x, y = rot_coll_test[2].y - ctrl_piece.y}
                if dir.x > 0 then ctrl_piece.x -= 1
                elseif dir.x < 0 then ctrl_piece.x += 1
                elseif dir.y > 0 then ctrl_piece.y -= 1
                elseif dir.y < 0 then ctrl_piece.y += 1
                end
            end
        end
    end

    -- no xooping
    -- clockwise rotation
    if btnp(🅾️) then
        rotate_mode = wrap(rotate_mode + 1, 0, 3)
        if ctrl_piece then
            log(format_matrix(ctrl_piece.shape))

            rotate_piece(ctrl_piece, 1)
            local rot_coll_test = grid:test_collisions(ctrl_piece, 0, 0)
            if rot_coll_test[1] then
                local dir = {x = rot_coll_test[2].x - ctrl_piece.x, y = rot_coll_test[2].y - ctrl_piece.y}
                if dir.x > 0 then ctrl_piece.x -= 1
                elseif dir.x < 0 then ctrl_piece.x += 1
                elseif dir.y > 0 then ctrl_piece.y -= 1
                elseif dir.y < 0 then ctrl_piece.y += 1
                end
            end
        end
    end

    if btn(⬅️) then
        if btnp(⬅️) then
            move_piece_x(ctrl_piece, -1)
            time_left_held = 0
        elseif time_left_held % 3 == 0 then
            move_piece_x(ctrl_piece, -1)
        end
        time_left_held += 1
    end
            
    if btn(➡️) then
        if btnp(➡️) then
            move_piece_x(ctrl_piece, 1)
            time_right_held = 0
        elseif time_right_held % 3 == 0 then
            move_piece_x(ctrl_piece, 1)
        end
        time_right_held += 1
    end

    if btn(⬇️) then
        piece_step_length = fast_drop_step_length -- change
    else piece_step_length = 10 -- change    
    end

    if btn(⬆️) then

    end
end

-- what do you think this does
function place_cur_piece_and_get_next()
    grid:place_piece(ctrl_piece)
    ctrl_piece = create_piece(next_piece_type)
    next_piece_type = gen_next_type()
end