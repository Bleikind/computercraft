function checkFuel() 
    for i = 1, 16 do
        selected_slot = turtle.select(i)
        if selected_slot then
            local data = turtle.getItemDetail();

            if data == not nil and data.name == "minecraft:coal" then
                turtle.refuel(turtle.getItemCount())
                print('Fuel state: ' .. turtle.getFuelLevel() .. " / " .. turtle.getFuelLimit())
            end
        else

        end
    end
end

checkFuel()