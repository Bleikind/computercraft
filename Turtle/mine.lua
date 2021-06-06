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

turnDirection = 1
count = 0
full = false

function go()
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
            turnDirection = 2
        else
            turnDirection = 1
        end
    end

    if turnDirection == 1 then
        turnDirection = 2
    else
        turnDirection = 1
    end

    turtle.down()
    count = count + 1

    if count == 2 then
        block, data = turtle.inspectUp()

        while not block do
            if data.name == "minecraft:chest" then
                for i = 1, 16, 1 do
                    if not turtle.dropUp() then
                        full = true
                    end
                end
            else
                if not block then
                    turtle.up()
                end
            end
        end


        blockDown, dataDown = turtle.inspectDown()

        while not block do
            turtle.down()
        end

        count = 0
    end
end

while true do

    if full == true then
        return
    end

    refuel()
    go()
end

