local function buildPart(name, size, cframe, material, color, parent)
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.CFrame = cframe
	p.Material = material or Enum.Material.SmoothPlastic
	p.Color = color or Color3.new(0.4,0.4,0.4)
	p.Anchored = true
	p.Parent = parent or workspace
	return p
end

local function buildBillboard(text, pos)
	local part = buildPart("MagaBillboard", Vector3.new(12,6,1), CFrame.new(pos), Enum.Material.SmoothPlastic, Color3.new(0.8,0.1,0.1))
	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Front
	gui.Parent = part
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundColor3 = Color3.new(1,1,1)
	label.TextScaled = true
	label.Font = Enum.Font.GothamBlack
	label.Text = text
	label.Parent = gui
end

-- Америка
buildPart("USGround", Vector3.new(400, 1, 200), CFrame.new(0, 0, -300), Enum.Material.Grass, Color3.new(0.3,0.6,0.3))
-- Дорога
buildPart("Road", Vector3.new(20, 1, 400), CFrame.new(0, 0.1, -100), Enum.Material.Asphalt, Color3.new(0.2,0.2,0.2))
-- Аляска
buildPart("AlaskaGround", Vector3.new(150, 1, 150), CFrame.new(0, 0, 150), Enum.Material.Snow, Color3.new(0.9,0.95,1))
-- Беринг
buildPart("BeringWater", Vector3.new(80, 1, 80), CFrame.new(0, -0.5, 250), Enum.Material.Water, Color3.new(0.4,0.6,0.9))
local ber = workspace:FindFirstChild("BeringWater")
ber.CanQuery = true
-- Чукотка
buildPart("ChukotkaGround", Vector3.new(150, 1, 150), CFrame.new(0, 0, 350), Enum.Material.Snow, Color3.new(0.85,0.9,1))
-- Финиш
local finish = buildPart("FinishZone", Vector3.new(40, 10, 10), CFrame.new(0, 5, 450), Enum.Material.Neon, Color3.new(0.4,1,0.6))
finish.Material = Enum.Material.Neon
finish.Transparency = 0.3
finish.CanCollide = true

buildBillboard("MAKE AMERICA GREAT AGAIN", Vector3.new(-15, 4, -200))
buildBillboard("MAKE AMERICA GREAT AGAIN", Vector3.new(15, 4, -50))
buildBillboard("TRUMP 2028? PROTOTYPE", Vector3.new(0, 4, 100))

local spawn = Instance.new("SpawnLocation")
spawn.Name = "StartSpawn"
spawn.Size = Vector3.new(12, 1, 12)
spawn.CFrame = CFrame.new(0, 0.5, -350)
spawn.Anchored = true
spawn.Parent = workspace
spawn.Material = Enum.Material.Concrete
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.Enabled = true
