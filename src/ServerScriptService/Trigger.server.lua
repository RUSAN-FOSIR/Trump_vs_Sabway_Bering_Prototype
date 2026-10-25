local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local trigger = workspace:WaitForChild("ChaseTriggerLine")
local activated = false

trigger.Touched:Connect(function(hit)
	if activated then return end
	local char = hit.Parent
	local plr = Players:GetPlayerFromCharacter(char)
	if not plr then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return end
	
	activated = true
	local ev = Instance.new("BindableEvent")
	ev.Name = "ActivateChase"
	ev.Parent = ReplicatedStorage
	ev:Fire()
	ev:Destroy()
end)
