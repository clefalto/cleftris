ui = {}

function ui:draw()
    print(frame, 1, 1, 7)
    
    local above_grid = {x = grid.rect.x, y = grid.rect.y - 6}
    local held_rect = {}
    held_rect.x = above_grid.x + grid.rect.w + 4
    held_rect.y = above_grid.y
    held_rect.w = 30
    held_rect.h = 25
    rectfill(held_rect.x, held_rect.y, held_rect.x + held_rect.w, held_rect.y + held_rect.h, 0)
    print("hELD", held_rect.x + held_rect.w / 2 - 8, held_rect.y + 1, 7)

    if held_piece != 0 then
        draw_piece(held_piece, held_rect.x + held_rect.w / 2 - 8, held_rect.y + held_rect.h / 2 - 2, 0)
    end

    local next_rect = {}
    next_rect.x = held_rect.x
    next_rect.y = above_grid.y + 30
    next_rect.w = 30
    next_rect.h = 25
    rectfill(next_rect.x, next_rect.y, next_rect.x + next_rect.w, next_rect.y + next_rect.h, 0)
    print("nEXT", next_rect.x + next_rect.w / 2 - 8, next_rect.y + 1, 7)
    
    draw_piece(next_piece_type, next_rect.x + next_rect.w / 2 - 8, next_rect.y + next_rect.h / 2 - 2, 0)

    local score_rect = {}
    score_rect.x = held_rect.x
    score_rect.y = above_grid.y + 60
    score_rect.w = 30
    score_rect.h = 52
    rectfill(score_rect.x, score_rect.y, score_rect.x + score_rect.w, score_rect.y + score_rect.h, 0)
    
    print("lEVEL", score_rect.x + score_rect.w / 2 - 9, score_rect.y + 1, 7)
    print(level, score_rect.x + score_rect.w / 2, score_rect.y + score_rect.h / 6 + 1, 7)

    print("cLEARED", score_rect.x + score_rect.w / 2 - 12, score_rect.y + score_rect.h * 1/3, 7)
    print(lines_cleared, score_rect.x + score_rect.w / 2, score_rect.y + score_rect.h * 1/2, 7)

    print("sCORE", score_rect.x + score_rect.w / 2 - 9, score_rect.y + score_rect.h / 2 + 9, 7)
    print(score, score_rect.x + score_rect.w / 2, score_rect.y + score_rect.h * 5/6, 7)
end