local modem = peripheral.find('modem')
local protocol = "telemetry"
local hostname = "mainrv"

if not modem then
    error('Kein Modem an dem Ding')
end

function split(input, seperator)
    if seperator == nil then
        sep = "/"
    end

    local t={}
    for str in string.gmatch(input, "([^"..sep.."]+)") do
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

function start()
    if modem.isOpen(1) then
       error('Modem wird bereits verwendet')
       return
    end

    if rednet.lookup(protocol, hostname) then
        error('Hostname wird bereits verwendet')
        return
    end

    rednet.host(protocol, hostname)

    while true do
        e, sender, message, distance = os.pullEvent("rednet_message")

        strings = split(message, ' ')

        if(strings[0] == 'cmd_broadcast') then
            local msg = string.sub(message, 13, string.len(message))
            rednet.broadcast('cmd_message ' .. sender .. ' ' .. msg, protocol)
            print(sender .. ': ' .. msg)
        end

    end

    modem.close()
end

start()