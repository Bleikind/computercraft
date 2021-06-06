startPosition = vector.new()
width = 8


function refuel()
    for i = 1, 16 do
        selected_slot = turtle.select(i)
        if selected_slot then
            local data = turtle.getItemDetail();

            if data then
                if turtle.refuel() then
                    print('Fuel state: ' .. turtle.getFuelLevel() .. " / " .. turtle.getFuelLimit())
                end
            end
        end
    end
end

function setStartPosition()
end

function go()
    turnDirection = 1

    for i = 1, width, 1 do

        for x = 1, width, 1 do
            turtle.digDown()
            turtle.forward()
        end

        if turnDirection % 2 == 1 then
            turtle.turnRight()
            turtle.forward()
            turtle.turnRight()
        else
            turtle.turnLeft()
            turtle.forward()
            turtle.turnLeft()
        end

        if turnDirection == 1 then
            turnDirection = 1
        else
            turnDirection = 2
        end
    end

    turtle.down()
    turtle.turnRight()
    turtle.turnRight()

    if(turnDirection == 1) == 1 then
        turnDirection = 1
    else
        turnDirection = 2
    end
end

while true do
    refuel()
    go()
end

