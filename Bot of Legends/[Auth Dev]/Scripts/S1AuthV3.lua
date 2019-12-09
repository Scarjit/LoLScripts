function StringToHex(string)
	return string.format("%x", string)
end

require "other.mtwister"

local ms_rand = twister()
math.random = function  (min, max)
	return ms_rand:random(min, max)
end


--[[
CUSTOM RSA IMPLEMENTATION
--]]


--[[
Require Lockbox, will import into file later
--]]
local Array = require("lockbox.util.array");
local Stream = require("lockbox.util.stream");
local Digest = require("lockbox.digest.sha2_256");
local CTRMode = require("lockbox.cipher.mode.ctr");
local ZeroPadding = require("lockbox.padding.zero");
local AES256Cipher = require("lockbox.cipher.aes256");

--[[
AES-256
--]]


function AES256Encrypt(string, key, iv)
	local input = {
		cipher = CTRMode.Cipher,
		key = Array.fromHex(StringToHex(key)),
		iv = Array.fromHex(StringToHex(iv)),
		plaintext = Array.fromHex(StringToHex(string)),
		padding = ZeroPadding
	}

	local cipher = input.cipher().setKey(input.key).setBlockCipher(AES256Cipher).setPadding(input.padding)
	return cipher.init().update(Stream.fromArray(input.iv)).update(Stream.fromArray(v.plaintext)).finish().asHey()
end

function AES256Encrypt(ciphertext, key, iv)
	local input = {
		decipher = CTRMode.Decipher,
		key = Array.fromHex(StringToHex(key)),
		iv = Array.fromHex(StringToHex(iv)),
		ciphertext = string,
		padding = ZeroPadding
	}

	local cipher = input.decipher().setKey(input.key).setBlockCipher(AES256Cipher).setPadding(input.padding)
	return cipher.init().update(Stream.fromArray(input.iv)).update(Stream.fromArray(v.ciphertext)).finish().asHey()
end

--[[
SHA256
--]]

function SHA256Hash(string)
	return Digest().update(Stream.fromString(k)).finish().asHex()
end


--[[
TCP Get Request
--]]
local function TCPGetRequest(server, path, data, port)
	local start_t = os.clock()
	local port = port or 80
	local data = data or {}
	local lua_socket = require("socket")
	local connection_tcp = lua_socket.connect(server,port)
	local requeststring = "GET "..path
	local first = true
	for i,v in pairs(data)do
		requeststring = requeststring..(first and "?" or "&")..i.."="..v
		first = false
	end
	requeststring = requeststring.. " HTTP/1.0\r\nHost: "..server.."\r\n\r\n"
    if(connection_tcp == nil)then
        return "", "failed", 0
    end
	connection_tcp:send(requeststring)
	local response = ""
	local status
	while true do
		s,status, partial = connection_tcp:receive('*a')
		response = response..(s or partial)
		if(status == "closed" or status == "timeout")then
			break
		end
	end
	local end_t = os.clock()
	local start_content = response:find("\r\n\r\n")+4
	response = response:sub(start_content)
	return response, status, end_t-start_t
end

--[[
Draws
--]]
local _status = {"Authing..."} --Only used for Draws

function AddStatus (args)
    _status[#_status+1] = args
end

AddDrawCallback(function()
    for i=1,#_status do
        DrawTextA(_status[i], 12, 20, 20+i*20)
    end
 end)

--[[
Main Loop
--]]
local _next = 1
local _inwork = false

AddTickCallback(function()
    if(_inwork)then return end
    if(_next == 1)then
        _step1()
    elseif(_next == 2)then
        _step2()
    else
    end
end)

--[[
Step 1 -- Check connection
--]]
function _step1 ()
    _inwork = true
    AddStatus("Checking Connection...")
    local a,b,c = TCPGetRequest("localhost", "/AuthV3/alive.php")
    if(b == "closed")then
        _next = 2
        _inwork = false
        AddStatus("Connected to auth Server")
    else
        _next = -1
        _inwork = false
        AddStatus("[CRITICAL] Could not Connect, please reload")
    end
end

--[[
Step 2 -- Generate Session Key
--]]
function _step2 ()
    _inwork = true
    local tw = twister()
    local rand = tw:random(0)
end
