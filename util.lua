function clamp(val, min, max)
    local ret = val
    if val < min then ret = min 
    elseif val > max then ret = max end
    return ret
end

function wrap(val, min, max)
    local range = max - min + 1
    return ((val - min) % range) + min
end

-- draw sprite rotated 90, 270 degrees clockwise
function rotate(sprite, mode, dx, dy, w, h)
    -- mode 0: clockwise 90
    -- mode 1: clockwise 270
    -- mode 2: mirror + clockwise 90
    -- mode 3: mirror + clockwise 270
    -- dx,dy: screen position
    -- w,h: sprite width and height (1 if not specified)
    local sx = sprite % 16 * 8
    local sy = flr(sprite / 16) * 8
    w, h = w or 1, h or 1
    w, h = w * 8 - 1, h * 8 - 1
    local ya, yb, xa, xb = 0, 1, 0, 1
    if mode == 0 then
        ya, yb = h, -1
    elseif mode == 1 then
        xa, xb = w, -1
    elseif mode == 2 then
        ya, yb, xa, xb = h, -1, w, -1
    end
    for y = 0, h do
        for x = 0, w do
            -- ignore black pixels, intended for enabling transparency idk how to check what pixels are transparent tho so black it is
            if sget(x + sx, y + sy) != 0 then
                pset((y - ya) * yb + dx, (x - xa) * xb + dy, sget(x + sx, y + sy))
            end
        end
    end
end

-- log something to log.txt file, the file is appended to
function log(string)
    printh(string, "log.txt", false)
end

function format_matrix(mtx)
    local s = ""
    for i in pairs(mtx) do
        for j in pairs(mtx[i]) do
            s = s .. mtx[i][j] .. " "
        end
        s = s.."\n"
    end
    return s
end