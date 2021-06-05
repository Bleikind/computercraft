function checkFuel() 
    for i = 1, 16 do
        selected = turtle.select(i)
        if selected then
            print(selected .. ' ' .. i)
        else

        end
    end
end

checkFuel()