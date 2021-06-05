function checkFuel() 
    for i = 1, 16 do
        selected_slot = turtle.select(i)
        if selected_slot then
            print(selected_slot .. ' ' .. i)
        else

        end
    end
end

checkFuel()