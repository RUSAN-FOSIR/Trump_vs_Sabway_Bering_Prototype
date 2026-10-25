local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	humanoid.WalkSpeed = 16
end)

local SPRINT_SPEED = 28
local NORMAL_SPEED = 16
local sprinting = false

local function updateSprint()
	if sprinting and humanoid then
		humanoid.WalkSpeed = SPRINT_SPEED
	else
		humanoid.WalkSpeed = NORMAL_SPEED
	end
end

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		sprinting = true
		updateSprint()
	end
end)

UserInputService.InputEnded:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		sprinting = false
		updateSprint()
	end
end)

humanoid.WalkSpeed = NORMAL_SPEED
