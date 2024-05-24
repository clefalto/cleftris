-- returns "piece" table
-- default rotation is 0
function create_piece(t, r)
    local shp = {}
    local d = {}
    if t == 1 then
        shp = {
            {1, 0, 0},
            {1, 1, 1}
        }
        d = {w = 3, h = 2}
    elseif t == 2 then
        shp = {
            {0, 0, 1},
            {1, 1, 1}
        }
        d = {w = 3, h = 2}
    elseif t == 3 then
        shp = {
            {0, 1, 0},
            {1, 1, 1}
        }
        d = {w = 3, h = 2}
    elseif t == 4 then
        shp = {
            {0, 1, 1},
            {1, 1, 0}
        }
        d = {w = 3, h = 2}
    elseif t == 5 then
        shp = {
            {1, 1, 0},
            {0, 1, 1}
        }
        d = {w = 3, h = 2}
    elseif t == 6 then
        shp = {
            {1, 1},
            {1, 1}
        }
        d = {w = 2, h = 2}
    elseif t == 7 then
        shp = {
            {1, 1, 1, 1}
        }
        d = {w = 4, h = 1}
    end

    return {x = 0, y = 0, 
            type = t,
            shape = shp,
            rot = r,
            dim = d}
end

-- given a piece, return its rotated shape matrix for the given rotation
function rotate(piece, rot)
    -- rot = 0: default rotation, return the normal matrix
    -- rot = 1: 90 degrees cw, return the normal matrix rotated 90 degrees
    -- rot = 2: 180 degrees cw, return the normal matrix rotated 180 degrees
    -- rot = 3: 270 degrees cw, return the normal matrix rotated 270 degrees
    local ret = {}
    if rot == 0 then
        return piece.shape
    elseif rot == 1 then
        for i = 1, piece.dim.w do
            ret[i] = {}
            local a = 1
            for j = piece.dim.h, 1, -1 do
                ret[i][a] = piece.shape[j][i]
                a += 1
            end
        end
    elseif rot == 2 then
        local a, b = 1, 1
        for i = piece.dim.h, 1, -1 do
            ret[b] = {}
            a = 1
            for j = piece.dim.w, 1, -1 do
                ret[b][a] = piece.shape[i][j]
                a += 1
            end
            b += 1
        end
    elseif rot == 3 then
        local a = 1
        for i = piece.dim.w, 1, -1 do
            ret[a] = {}
            for j = 1, piece.dim.h do
                ret[a][j] = piece.shape[j][i]
            end
            a += 1
        end
    end
    return ret
end

function step_piece(piece)
    piece.y += 1
end