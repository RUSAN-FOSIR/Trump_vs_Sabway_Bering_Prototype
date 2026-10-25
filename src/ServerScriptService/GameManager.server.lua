local Players = game:GetService("Players")

local finishPart = workspace:WaitForChild("FinishZone")
local won = {}

finishPart.Touched:Connect(function(hit)
	local char = hit.Parent
	local plr = Players:GetPlayerFromCharacter(char)
	if plr and not won[plr.UserId] then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum and hum.Health > 0 then
			won[plr.UserId] = true
			local gui = plr:FindFirstChild("PlayerGui")
			if gui then
				local winGui = Instance.new("ScreenGui")
				winGui.Name = "WinScreen"
				winGui.Parent = gui
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1,0,1,0)
				frame.BackgroundColor3 = Color3.new(0,0,0)
				frame.BackgroundTransparency = 0.3
				frame.Parent = winGui
				local text = Instance.new("TextLabel")
				text.Size = UDim2.new(1,0,0.4,0)
				text.Position = UDim2.new(0,0,0.3,0)
				text.BackgroundTransparency = 1
				text.Font = Enum.Font.GothamBlack
				text.TextScaled = true
				text.TextColor3 = Color3.new(0.4,1,0.6)
				text.TextStrokeTransparency = 0
				text.Text = "ПОБЕДА!\nТЫ ПЕРЕПЛЫЛ ИЗ АЛЯСКИ В РОССИЮ И УБЕЖАЛ ОТ ТРАМПА!"
				text.Parent = frame
			end
		end
	end
end)
