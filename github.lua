url = arg[0]

--if false, possible private
--TODO login
function checkUrl()
    return http.checkURL(url);
end

function download()
    splitter = split(url, '/')
    name = splitter[tableLength(splitter)]
    
    local content = http.get(url).readAll()
    if not content then
        error("Could not download website.")
    end

    f = fs.open(name, "w")
    f.write(content)
    f.close()
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