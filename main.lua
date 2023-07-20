function love.load()
    love.mouse.setVisible(false)

    time_unit = 0

    direction = {'up'}

    game_over = false

    score = 0

    total_height = love.graphics.getHeight()

    half_height = total_height / 2

    block = total_height / 20

    square = block - (block/10)

    snake_parts = {
        {x = half_height, y = half_height},
        {x = half_height, y = (half_height) + block},
        {x = half_height, y = (half_height) + (block * 2)},
    }

    function drawPellet()
        pellet = {
            x = (love.math.random(1, 20) - 1) * block,
            y = (love.math.random(1, 20) - 1) * block
        }
    end

    drawPellet()

    function checkPellet()
        pellet_is_well_positioned = true

        for part_index, part in ipairs(snake_parts) do
            if part.x == pellet.x and part.y == pellet.y then
                pellet_is_well_positioned = false
            end
        end

        if pellet_is_well_positioned == false then
            drawPellet()
            checkPellet()
        end
    end

    checkPellet()
end

function love.update(dt)
    time_unit = time_unit + dt
    if game_over == false then
        if time_unit >= 0.2 then
            time_unit = 0

            if #direction > 1 then
                table.remove(direction, 1)
            end

            local movement_x = snake_parts[1].x
            local movement_y = snake_parts[1].y

            if direction[1] == 'up' then
                movement_y = movement_y - block
            elseif direction[1] == 'right' then
                movement_x = movement_x + block
            elseif direction[1] == 'down' then
                movement_y = movement_y + block
            elseif direction[1] == 'left' then
                movement_x = movement_x - block
            end

            for part_index, part in ipairs(snake_parts) do
                if part_index ~= #snake_parts and movement_x == part.x and movement_y == part.y then
                    game_over = true
                end
            end

            if (movement_x == pellet.x) and (movement_y == pellet.y) then
                table.insert(snake_parts, 1, {x = movement_x, y = movement_y})
                score = score + 1
                drawPellet()
                checkPellet()
            else
                table.insert(snake_parts, 1, {x = movement_x, y = movement_y})
                table.remove(snake_parts)
            end
    
            if movement_x > (total_height - block) or movement_x < 0 or movement_y > (total_height - block) or movement_y < 0 then
                game_over = true
            end
        end
    elseif game_over == true then
        if time_unit >= 3 then
            love.load()
        end
    end
end

function love.draw()
    love.graphics.setColor(.200, .200, .200)
    love.graphics.rectangle('fill', 0, 0, total_height, total_height)

    for part_index, part in ipairs(snake_parts) do
        love.graphics.setColor(0, 130, 0)
        love.graphics.rectangle('fill', part.x, part.y, square, square)
    end
    
    love.graphics.setColor(190, 100, 0)
    love.graphics.rectangle('fill', pellet.x, pellet.y, square, square)

    if game_over == true then
        love.graphics.setColor(50, 0, 0)
        love.graphics.print("GAME OVER", half_height - (half_height/2), half_height - (half_height/2), 0, 4, 4)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Score: " .. score, half_height - (half_height/3), half_height - (half_height/5), 0, 4, 4)

    end
end

function love.keypressed(key)
    if (direction[#direction] ~= 'down') and (key == 'up' or key == 'w') then
        table.insert(direction, 'up')
    end
    if (direction[#direction] ~= 'left') and (key == 'right' or key == 'd') then
        table.insert(direction, 'right')
    end
    if (direction[#direction] ~= 'up') and (key == 'down' or key == 's') then
        table.insert(direction, 'down')
    end
    if (direction[#direction] ~= 'right') and (key == 'left' or key == 'a') then
        table.insert(direction, 'left')
    end
end
