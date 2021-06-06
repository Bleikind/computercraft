clients = {}

teleporter = {}
teleporter["x"] = 1225
teleporter["y"] = 68
teleporter["z"] = -2725

function split(input, seperator)
    if seperator == nil then
        seperator = "/"
    end

    local t={}
    for str in string.gmatch(input, "([^"..seperator.."]+)") do
        table.insert(t, str)
    end

    return t
end

function tableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end

    return count
end

function check(clientID, initX, initY, initZ, width, height, depth, currX, currY, currZ)

    for x = 1, width, 1 do
        for y = 1, height, 1 do
            for z = 1, depth, 1 do
                local currBlockX = initX + x;
                local currBlockY = initY + y;
                local currBlockZ = initZ + z;

                if currX == currBlockX and currY == currBlockY and currZ == currBlockZ then
                    return true
                end

            end
        end
    end

    return false
end

function getClientPosition(clientID)
    rednet.send(clientID, "cmd_postion", "telemetry")
end


rednet.open("bottom")

while true do
    id, msg, proto = rednet.receive()

    strings = split(msg, ' ')

    cmd = strings[1]

    if proto == "telemetry" then
        if cmd == "cmd_position" then
            clients[id] = strings[2]

            coords = split(strings[2], ":")

            isinrange = check(id, teleporter["x"], teleporter["y"], teleporter["z"], 6, 6, 6, tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
            
            print(strings)
            print(teleporter)
            print(coords)
            print("is in range: " .. isinrange)
        end
    end

end
