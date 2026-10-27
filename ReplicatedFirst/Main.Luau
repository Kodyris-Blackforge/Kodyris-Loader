local Players = game:GetService("Players")
local SC = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
ReplicatedFirst:RemoveDefaultLoadingScreen()

local LoadUI
if ReplicatedFirst:FindFirstChild("LoadUI") then
	LoadUI = ReplicatedFirst:FindFirstChild("LoadUI"):Clone()
	LoadUI.Parent = SC.PlayerGui
end
if not game:IsLoaded() then game.Loaded:Wait() end
while task.wait(0.1) and game:GetService("ContentProvider").RequestQueueSize>0 do end
if not ReplicatedFirst:FindFirstChild("PendLoad") then
	game:AddTag("Loaded")
else
	ReplicatedFirst:FindFirstChild("PendLoad").OnInvoke=function()return end
end
if LoadUI then
	LoadUI:Destroy()
end
