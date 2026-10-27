local plrlist = game:GetService('Players')
local Loaded = {}

function PlayerAdded(plr:Player) --verified by checker, sends: State, UserId, PlayerObject
	if _G.Banlist then
		if _G.Banlist[plr.UserId] then
			plr:Kick("Active ban.") return
		end
	end
	if Loaded[plr.UserId] == true then script.ScriptBind:Fire("Already loaded",plr.UserId,plr) return end
	Loaded[plr.UserId] = true
	script.ScriptBind:Fire("Loaded",plr.UserId,plr)
end

function PlayerRemoved(plr:Player)
	if Loaded[plr.UserId] then
		Loaded[plr.UserId] = nil
		script.ScriptBind:Fire("Unloaded",plr.UserId,nil)
	end
end

function checker(plr:Player?) --Checks to see if its a actual player
	if typeof(plr) == "Instance" and plr:IsA("Player") then
		PlayerAdded(plr)
	end
end

--Hault until everything's ready
script.IsReady.OnInvoke = function() return true end
if game:GetService("ServerScriptService"):GetAttribute("ProcessSignals") ~= true then
	game:GetService("ServerScriptService"):GetAttributeChangedSignal("ProcessSignals"):Wait()
end

plrlist.PlayerAdded:Connect(checker)
plrlist.PlayerRemoving:Connect(PlayerRemoved)
for i,v in pairs(plrlist:GetChildren()) do
	checker(v)
end	
