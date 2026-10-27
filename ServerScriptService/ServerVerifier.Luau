for i,v in pairs(game:GetService("ServerScriptService"):GetDescendants()) do
	if v:IsA("BindableFunction") and v.Name == "IsReady" then
		v:Invoke()
	end
end

game:GetService("ServerScriptService"):SetAttribute("ProcessSignals",true)
