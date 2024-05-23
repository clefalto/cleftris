ui = {}

function ui:draw()
    local aboveGrid = {x = grid.rect.x, y = grid.rect.y - 6}

    print(frame, aboveGrid.x, aboveGrid.y, 7)
end