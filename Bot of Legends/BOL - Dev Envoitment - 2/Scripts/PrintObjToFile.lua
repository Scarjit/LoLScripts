
function OnCreateObj(obj)
	if obj and obj.name then
		local str = "Time: "..os.clock().." || Name: "..obj.name.." || X: "..obj.x.." || Y: "..obj.y.." || Z: "..obj.z.." || Team: "..obj.team.."\n"
		file:write(str)
		file:flush()
	end
end

function OnLoad()
	file = io.open(SCRIPT_PATH.."test.txt", "a")
end