local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "MainUI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 70)
frame.Position = UDim2.new(0.5, -160, 0, 10)
frame.BackgroundColor3 = Color3.new(0,0,0)
frame.BackgroundTransparency = 0.4
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,-10,1,-10)
label.Position = UDim2.new(0,5,0,5)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.TextColor3 = Color3.new(1,0.3,0.3)
label.TextStrokeTransparency = 0
label.Text = "УБЕГАЙ ОТ ДОНАЛЬДА ТРАМПА!"
label.Parent = frame
