local CharSeeker = script.Parent:FindFirstChild("Character")
local module = {}

local function CharacterSeek(plr):(Model)
	local char
	if CharSeeker then char=require(CharSeeker).AwaitCharacterLoad(plr) end
	if not CharSeeker then warn("Could not find Character engine.") return end
	if not char then warn("Could not set clothing: No character or player to assign to.") return end
	return char
end

module.SetShirt = function(Player:Player,ShirtId:string):()
	local char = CharacterSeek(Player)
	local Shirt = char:FindFirstChildOfClass("Shirt")
	if not Shirt then
		local x = Instance.new("Shirt")
		x.ShirtTemplate = ShirtId
		x.Parent = char
		return
	end
	Shirt.ShirtTemplate = ShirtId
end

module.SetPants = function(Player:Player,PantsId:string):()
	local char = CharacterSeek(Player)
	local Shirt = char:FindFirstChildOfClass("Pants")
	if not Shirt then
		local x = Instance.new("Pants")
		x.PantsTemplate = PantsId
		x.Parent = char
		return
	end
	Shirt.PantsTemplate = PantsId
end

return module
