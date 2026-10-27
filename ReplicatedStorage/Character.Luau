local module = {}


module.AwaitCharacterLoad = function(Player:Player):(Model?)
	if not Player.Character then
		local CharacterAdded
		CharacterAdded = Player.CharacterAdded:Once(function() end)
		repeat task.wait()
		until not Player:IsDescendantOf(game.Players) or Player.Character
		if CharacterAdded and CharacterAdded.Connected then CharacterAdded:Disconnect() end
		CharacterAdded = nil
	end
	if not Player:IsDescendantOf(game.Players) then
		return nil
	end
	local IsLoaded = false
	local CharacterAppearance=Player.CharacterAppearanceLoaded:Once(function()IsLoaded=true;end)
	repeat task.wait()
	until not Player:IsDescendantOf(game.Players)or IsLoaded
	if CharacterAppearance and CharacterAppearance.Connected then CharacterAppearance:Disconnect() end
	CharacterAppearance = nil
	task.wait(.5)
	return (Player and Player.Character)
end

return module
