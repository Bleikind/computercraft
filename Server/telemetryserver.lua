local protocol = "telemetry"
local hostname = "mainsrv"
local side = "back"

local clients = {}

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

function containsClient(id)
    for index, value in ipairs(clients) do
        if value == id then
            return index
        end
    end

    return nil
end

function removeClient(id)
    index = containsClient(id)
    if index then
        table.remove(clients, index)
        return true
    end

    return false
end

function addClient(id)

    index = containsClient(id)

    if not index then
        table.insert(clients, id)
        return true
    end

    return false
end

function start()
    if rednet.lookup(protocol, hostname) then
        error('Hostname wird bereits verwendet')
        return
    end

    rednet.open(side)
    rednet.host(protocol, hostname)

    while true do
        senderId, message, proto = rednet.receive(protocol)

        strings = split(message, ' ')


        if(strings[1] == 'cmd_broadcast') then
            local msg = string.sub(message, 13, string.len(message))

            for index, value in ipairs(clients) do
                rednet.send(value, 'cmd_message' .. senderId .. ' ' .. msg, protocol)
            end

            print(senderId .. ': ' .. msg)
        end

        if strings[1] == "cmd_client_connect" then
            print("Client connecting...")

            if addClient(senderId) then
                rednet.send(senderId, "logged_in", protocol)
                print(senderId .. " connected.")
            else
                rednet.send(senderId, "already_logged_in", protocol)
                print(senderId .. "already conntected.")
            end
        end

    end

    rednet.close(side)
end

start()