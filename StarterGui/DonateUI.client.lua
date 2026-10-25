local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DonateUI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 320)
frame.Position = UDim2.new(1, -270, 0.5, -160)
frame.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
frame.BackgroundTransparency = 0.2
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.new(1,0.2,0.2)
title.Text = "MAGA ДОНАТ"
title.Parent = frame

local function addBtn(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,-20,0,40)
	btn.Position = UDim2.new(0,10,0,y)
	btn.BackgroundColor3 = Color3.new(0.8,0.15,0.15)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = text
	btn.Parent = frame
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = btn
	btn.AutoButtonColor = true
	btn.MouseButton1Click:Connect(function()
		btn.Text = "СКОРО..."
		task.wait(1)
		btn.Text = text
	end)
end

addBtn("X2 СПРИНТ - 49 Р", 50)
addBtn("НЕУЯЗВИМОСТЬ ОТ ТРАМПА - 99 Р", 100)
addBtn("БОЖЕСТВЕННЫЙ ТУРБО - 149 Р", 150)
addBtn("ТЕЛЕПОРТ К ФИНИШУ - 299 Р", 200)
addBtn("СНЯТЬ ТРАМПА - 999 Р", 250)
addBtn("СДЕЛАТЬ ТРАМПА ДРУГОМ - 4999 Р", 300)
