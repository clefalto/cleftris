PALETTES = {
    -- {navy, violet, dark green, burnt orange, dark gray}
    {5, 13, 1, 5, 0}, -- dark blues
    {14, 15, 8, 14, 2}, -- warm pinks
    {3, 7, 10, 11, 10}, -- bright yellows and greens
    {6, 7, 13, 12, 13}, -- light blues
    {14, 7, 12, 14, 12} -- trans



}

palette = {}
palette.current = PALETTES[1]
palette.level = 1

function palette:draw()
    if frame % 30 == 0 then
        palette.level = wrap(palette.level + 1, 1, #PALETTES)
    end

    palette.current = PALETTES[palette.level]

    -- pallete swapping, only affects the drawing of original colors 1-5
    pal(palette.current)
end 

