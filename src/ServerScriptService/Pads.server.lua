local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REMOTE = Instance.new("RemoteEvent")
REMOTE.Name = "TrumpPadEffect"
REMOTE.Parent = ReplicatedStorage

local active = {}

local function hookup(pad)
	if pad:GetAttribute("Hooked") then return end
	pad:SetAttribute("Hooked", true)
	pad.Touched:Connect(function(hit)
		local char = hit.Parent
		local plr = Players:GetPlayerFromCharacter(char)
		if not plr then return end
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then return end
		local key = plr.UserId .. "_" .. pad:GetDebugId()
		if active[key] then return end
		active[key] = true
		task.delay(2.5, function() active[key] = nil end)
		local t = pad:GetAttribute("Type")
		local p = pad:GetAttribute("Power") or 0
		REMOTE:FireServer("trump_apply", t, p)
	end)
end

workspace.ChildAdded:Connect(function(child)
	if child.Name == "BoostPad" or child.Name == "SlowPad" then
		hookup(child)
	end
end)

for _, child in ipairs(workspace:GetChildren()) do
	if child.Name == "BoostPad" or child.Name == "SlowPad" then
		hookup(child)
	end
end

