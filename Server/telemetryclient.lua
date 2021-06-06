local protocol = "telemetry"
local hostname = "mainsrv"

function split(input, seperator)
    if seperator == nil then
        sep = "/"
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


rednet.open("back")
srvID = rednet.lookup(protocol, hostname)

rednet.send(srvID, "cmd_client_connect", protocol)
sender, response, proto = rednet.receive(protocol, 10)

if response then
    if response == "logged_in" then
        print("Logged in.")
    else
        print("Already logged in?")
    end
else
    print("No response from server.")
end

while true do
    senderId, message, proto = rednet.receive()

    strings = split(message, ' ')
    cmd = strings[1]

    if proto == "telemetry" then
        if cmd == "cmd_message" then
            messageFrom = strings[2]
            msg = table.concat(strings, " ", 3, tableLength(strings))
    
            print(messageFrom .. ': ' .. msg)
        end

        if cmd == "cmd_position" then
            x, y, z = gps.locate()
            if x then
                print(senderId .. " asked for my location.")
                rednet.send(senderId, "cmd_position " .. x .. ":" .. y .. ":" .. z, proto)
            else
                rednet.send(senderId, "nil", proto)
            end
        end
    end
end