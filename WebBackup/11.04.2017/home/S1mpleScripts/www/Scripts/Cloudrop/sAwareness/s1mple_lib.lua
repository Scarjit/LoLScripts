function isFile(name)
    if type(name)~="string" then return false end
    if not isDir(name) then
        return os.rename(name,name) and true or false
        -- note that the short evaluation is to
        -- return false instead of a possible nil
    end
    return false
end

function isFileOrDir(name)
    if type(name)~="string" then return false end
    return os.rename(name, name) and true or false
end

function isDir(name)
    if type(name)~="string" then return false end
    local cd = lfs.currentdir()
    local is = lfs.chdir(name) and true or false
    lfs.chdir(cd)
    return is
end

function Download(server, data, port, file_path)
	local port = port or ""
	local data = data or {}
	local file_path = file_path or "out.tmp"
	local requeststring = server
	for i,v in pairs(data)do
		requeststring = requeststring..(first and "?" or "&")..i.."="..v
		first = false
	end
	if port ~= "" then
		requeststring = requeststring..":"..port
	end

	local psscript = "$url = \""..requeststring.."\"\r\n"
	psscript = psscript .. "$output = \"" .. file_path.."\"\r\n"
	psscript = psscript .. [[
	$wc = New-Object System.Net.WebClient
	$wc.DownloadFile($url, $output)
	#OR
	(New-Object System.Net.WebClient).DownloadFile($url, $output)
	

	]]

	local rand = math.random(1,1000)
	local f = io.open(path..rand.."tmp.ps1", "w")
	f:write(psscript)
	f:close()


	os.execute('powershell.exe -ExecutionPolicy Bypass -File \"'..path..rand.."tmp.ps1"..'\"')
	os.execute('del /Q \"'..path..rand..'\"tmp.ps1')
end


function ctype(t)
    local _type = type(t)
    if _type == "userdata" then
        local metatable = getmetatable(t)
        if not metatable or not metatable.__index then
            t, _type = "userdata", "string"
        end
    end
    if _type == "userdata" or _type == "table" then
        local _getType = t.type or t.Type or t.__type
        _type = type(_getType)=="function" and _getType(t) or type(_getType)=="string" and _getType or _type
    end
    return _type
end

function ctostring(t)
    local _type = type(t)
    if _type == "userdata" then
        local metatable = getmetatable(t)
        if not metatable or not metatable.__index then
            t, _type = "userdata", "string"
        end
    end
    if _type == "userdata" or _type == "table" then
        local _tostring = t.tostring or t.toString or t.__tostring
        if type(_tostring)=="function" then
            local tstring = _tostring(t)
            t = _tostring(t)
        else
            local _ctype = ctype(t) or "Unknown"
            if _type == "table" then
                t = tostring(t):gsub(_type,_ctype) or tostring(t)
            else
                t = _ctype
            end
        end
    end
    return tostring(t)
end

local oldprint = print
function print(...)
    local t, len = {}, select("#",...)
    for i=1, len do
        local v = select(i,...)
        local _type = type(v)
        if _type == "string" then t[i] = v
        elseif _type == "number" then t[i] = tostring(v)
        elseif _type == "table" then t[i] = table.serialize(v)
        elseif _type == "boolean" then t[i] = v and "true" or "false"
        elseif _type == "userdata" then t[i] = ctostring(v)
        else t[i] = _type
        end
    end
    if len>0 then oldprint(table.concat(t)) end
end

function prettyprint(arg)
    Game.Chat.Print("<font color=\"#570BB2\"><b>sAwareness:</b></font> " .. arg)
end