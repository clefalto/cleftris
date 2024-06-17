SHAPES = {
    {
        {1, 0, 0},
        {1, 1, 1}
    },
    {
        {0, 0, 1},
        {1, 1, 1}
    },
    {
        {0, 1, 0},
        {1, 1, 1}
    },
    {
        {0, 1, 1},
        {1, 1, 0}
    },
    {
        {1, 1, 0},
        {0, 1, 1}
    },
    {
        {1, 1},
        {1, 1}
    },
    {
        {1, 1, 1, 1}
    }
}

previous_shapes = {} -- array of previous pieces for pity pieces

function gen_next_type()
    local t = flr(rnd(#SHAPES)) + 1
    -- pity piece mechanic, if the player has been getting similar pieces recently gen another one
    local piece_used = true
    while piece_used do
        piece_used = false
        for i,v in ipairs(previous_shapes) do
            if v == t then
                t = flr(rnd(#SHAPES)) + 1
                piece_used = true
            end
        end
    end

    if #previous_shapes == 5 then
        for i,v in ipairs(previous_shapes) do
            if previous_shapes[i+1] then
                previous_shapes[i] = previous_shapes[i+1]
            else 
                previous_shapes[i] = t
            end
        end
    else 
        previous_shapes[#previous_shapes + 1] = t
    end

    return t
end

-- returns "piece" table
-- default rotation is 0
function create_piece(t)
    local shp = SHAPES[t]
    local d = {w = #shp[1], h = #shp}

    return {x = 5, y = 1, 
            type = t,
            shape = shp,
            rot = 0,
            dim = d}
end

-- rotate a piece an amount.
-- doesn't return anything, it just rotate's the pieces shape and assigns it.
-- the piece's position remains the same. this is not intentional as you're currently able to rotate to push the piece inside a wall.
function rotate_piece(piece, rot)
    -- rot = 0: default rotation, return the normal matrix
    -- rot = 1: 90 degrees cw, return the normal matrix rotated 90 degrees
    -- rot = 2: 180 degrees cw, return the normal matrix rotated 180 degrees
    -- rot = 3: 270 degrees cw, return the normal matrix rotated 270 degrees
    local new_shape = {}
    if rot == 0 then
        return
    elseif rot == 1 then
        for i = 1, piece.dim.w do
            new_shape[i] = {}
            local a = 1
            for j = piece.dim.h, 1, -1 do
                new_shape[i][a] = piece.shape[j][i]
                a += 1
            end
        end
        piece.rot = wrap(piece.rot + 1, 0, 3)
        local dimensions = piece.dim
        piece.dim = {w = dimensions.h, h = dimensions.w}
    elseif rot == 2 then
        local a, b = 1, 1
        for i = piece.dim.h, 1, -1 do
            new_shape[b] = {}
            a = 1
            for j = piece.dim.w, 1, -1 do
                new_shape[b][a] = piece.shape[i][j]
                a += 1
            end
            b += 1
        end
        piece.rot = wrap(piece.rot + 2, 0, 3)
    elseif rot == 3 then
        local a = 1
        for i = piece.dim.w, 1, -1 do
            new_shape[a] = {}
            for j = 1, piece.dim.h do
                new_shape[a][j] = piece.shape[j][i]
            end
            a += 1
        end
        piece.rot = wrap(piece.rot + 3, 0, 3)
        local dimensions = piece.dim
        piece.dim = {w = dimensions.h, h = dimensions.w}
    end
    piece.shape = new_shape
end

function step_piece(piece)
    if not grid:test_collisions(piece, 0, 1)[1] then
        piece.y += 1
        return false
    else
        return grid:test_collisions(piece, 0, 1)[2] 
    end
end

function move_piece_x(piece, dir_x) 
    if not grid:test_collisions(piece, dir_x, 0)[1] then
        piece.x += dir_x
    end
end

function xoop_piece(piece)
    while not grid:test_collisions(piece, 0, 1)[1] do
        piece.y += 1
    end
end