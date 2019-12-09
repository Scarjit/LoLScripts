if _G.AutobuyerIB then
	print("Other autobuyer loaded")
	return
end
_G.AutobuyerIB = true

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local error_switch = false
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

local req_downloaded = false
local item_tbl = {}
local function DownloadRequirements()
	local current_game_version = GetGameVersion():sub(0,6)
	local item_table_f = io.open(LIB_PATH.."item_table.lua")
	if not item_table_f then
		print("Item table missing, downloading")
		local r, s, t = TCPGetRequest("s1mplescripts.de","/S1mple/Scripts/DDragonParser/getItems.php")
		local file_writer = io.open(LIB_PATH.."item_table.lua", "wb")
		file_writer:write(r)
		file_writer:close()
		item_table_f = io.open(LIB_PATH.."item_table.lua")
	end
	local item_table = load(item_table_f:read('*all'))()
	if item_table.Version ~= current_game_version then
		print("Outdated Item Table, updating")
		local r, s, t = TCPGetRequest("s1mplescripts.de","/S1mple/Scripts/DDragonParser/getItems.php")
		local file_writer = io.open(LIB_PATH.."item_table.lua", "wb")
		file_writer:write(r)
		file_writer:close()
		item_table_f = io.open(LIB_PATH.."item_table.lua")
		item_table = load(item_table_f:read('*all'))()
	end
	item_tbl = item_table
	req_downloaded = true
end

local fake_replace_table = {
	[3029] = 3027, --Rod of ages
	[3007] = 3003, --Archangle's Staff
	[3004] = 3008, --Manamune
	[3073] = 3070, --Tear of the Goddess
}

local function GetItemsInInventory()
	local ret = {}
	local ItemSlot = { ITEM_1, ITEM_2, ITEM_3, ITEM_4, ITEM_5, ITEM_6, ITEM_7 }
	for i = 1, 7, 1 do
		local item = (object or player):getItem(ItemSlot[i])
		if item then
			if fake_replace_table[item.id] then
				ret[#ret+1] = fake_replace_table[item.id]
			else
				ret[#ret+1] = item.id
			end
		end
	end
	return ret
end

local function ReplaceMapBasedItems(tbl)
	if GetGame().map.index == 1 or GetGame().map.index == 15 then return tbl end
	local replacements = {
		[404] = 1337,
	}
	for k,v in pairs(tbl) do
		if replacements[v] then
			tbl[k] = replacements[v]
		end
	end
	return tbl
end

local req_cache = {}
local function GetRecommendedItems()
	if #req_cache > 0 then return req_cache end
	local r, s, t = TCPGetRequest("s1mplescripts.de", "/S1mple/Scripts/DDragonParser/championgg.php", {champion = myHero.charName})
	local rec_items = load(r)()
	if not rec_items then
		print("Error retriving Recommended Items")
		error_switch = true
	else
		rec_items = ReplaceMapBasedItems(rec_items)
		req_cache = rec_items
		return rec_items
	end
end

local function SubStractTable(tbl1, tbl2)
	local m = deepcopy(tbl1)
	local n = deepcopy(tbl2)
	local ret = {}
	for k,v in pairs(m) do
		for k2,v2 in pairs(n) do
			if v == v2 then
				m[k] = nil
				n[k2] = nil
			end
		end
	end
	for k,v in pairs(m) do
		ret[#ret+1] = v
	end
	return ret
end

local function GetRequirementforItemID(id)
	return item_tbl[id]
end

local locked = 0
local oldbuy = BuyItem
local function BuyItem(itemID)
	if not (InShop() or myHero.dead) then return end
	if os.clock() < locked then return end
	locked = os.clock() + 1
	oldbuy(itemID)
end

local start_items_tbl = {}
local sold_start_items = false
local start_items = false
local function BuyStartItems()
	local r, s, t = TCPGetRequest("s1mplescripts.de", "/S1mple/Scripts/DDragonParser/championggstart.php", {champion = myHero.charName})
	local start_i = load(r)()
	if not start_i then
		print("Error retriving Start Items")
	else
		start_items_tbl = start_t
		for i=1,#start_i do
			local i = start_i[i]
			oldbuy(i)
		end
	end
	start_items = true
end

AddLoadCallback(function ()
	print("Loaded")
	DownloadRequirements()
	if GetGameTimer() < 250 then
		DelayAction(function ()
			BuyStartItems()			
		end,5)
	else
		start_items = true
	end
end)

AddDrawCallback(function ()
	if start_items == false then
		DrawTextA("Getting Start Items", 12, 20 ,20, ARGB(255,255,0,255))
		return
	end
	DrawTextA("Recommended Items", 12,20,20)
	for k,v in pairs(GetRecommendedItems()) do
		DrawTextA(k.." : "..v,12,20,k*20+20)
	end

	DrawTextA("Items In Inventory:",12,180,20)
	for k,v in pairs(GetItemsInInventory()) do
		DrawTextA(k.." : "..v,12,180,k*20+20)
	end

	local substr_tbl = SubStractTable(GetRecommendedItems(),GetItemsInInventory())
	DrawTextA("SubStractTable: ",12,340,20)
	for k,v in pairs(substr_tbl) do
		DrawTextA(k.." : "..v,12,340,k*20+20)
	end

	if #substr_tbl < 4 and not sold_start_items then
		sold_start_items = true
		for k,v in pairs(start_items_tbl) do
			local ItemSlot = { ITEM_1, ITEM_2, ITEM_3, ITEM_4, ITEM_5, ITEM_6, ITEM_7 }
            for i = 1, 7, 1 do
                local item = player:getItem(ItemSlot[i])
                if item and item.id == v then
                	SellItem(v)
                end
            end
		end
	end

	local nxt = substr_tbl[1]
	local req = GetRequirementforItemID(nxt)
	if not nxt or not req or not item_tbl[nxt] or not item_tbl[nxt].item_name then return end
	DrawTextA("Next Item to Buy:",12,520,20)
	DrawTextA(nxt.." : ",12,520,40)
	DrawTextA(item_tbl[nxt].item_name,12,560,40)

	local required_gold = item_tbl[nxt].cost_total
	if(required_gold < myHero.gold)then
		BuyItem(nxt)
		return
	end

	local from = req.from
	local shift = 0
	local used = {}
	local missing = {}
	DrawTextA("Child Items",12,680,20)
	for k,v in pairs(from) do
		DrawTextA("["..k.."] "..v,12,680,20+k*20)
		local i_data = GetRequirementforItemID(v)
		local in_inv = false
		for x,v2 in pairs(GetItemsInInventory()) do
			if v2 == v and not used[x] then
				DrawTextA(" << In Inventory",12,760,20+k*20)
				used[x] = true
				in_inv = true
				required_gold = required_gold - i_data.cost_total
			end
		end
		DrawTextA(" > "..i_data.cost_total,12,720,20+k*20)
		if not in_inv then
			missing[#missing+1] = v
		end
	end


	DrawTextA(math.round(myHero.gold) .. " / " ..required_gold,12,520,60)
	if(required_gold < myHero.gold)then
		BuyItem(nxt)
		return
	end


	DrawTextA("Missing Items",12,900,20)
	for k,v in pairs(missing) do
		local i_data = GetRequirementforItemID(v)
		DrawTextA("["..k.."] "..v.." > "..i_data.cost_total,12,900,20+k*20)
		if i_data.cost_total < myHero.gold then
			BuyItem(v)
			return
		end

		if #i_data.from > 0 then
			for k,v in pairs(i_data.from) do
				DrawTextA(v, 12,1000,20*k)
				local x_data = GetRequirementforItemID(v)
				DrawTextA(" > "..x_data.cost_total, 12,1030,20*k)

				local in_inv = false
				for x2,v2 in pairs(GetItemsInInventory()) do
					if v2 == v then
						in_inv = true
					end
				end

				if(in_inv == false and x_data.cost_total < myHero.gold)then
					BuyItem(v)
					return
					DrawTextA(" >> Can Buy",12,1070,20*k,ARGB(255,0,255,0))
				end
			end
		end
	end
end)
