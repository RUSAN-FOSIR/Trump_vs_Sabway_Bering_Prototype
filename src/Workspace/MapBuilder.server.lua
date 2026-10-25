local function buildPart(name, size, cframe, material, color, parent)
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.CFrame = cframe
	p.Material = material or Enum.Material.SmoothPlastic
	p.Color = color or Color3.new(0.4,0.4,0.4)
	p.Anchored = true
	p.Parent = parent or workspace
	p.CastShadow = false
	return p
end

local function buildBillboard(text, pos)
	local part = buildPart("MagaBillboard", Vector3.new(14,7,1), CFrame.new(pos), Enum.Material.SmoothPlastic, Color3.new(0.9,0.1,0.1))
	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Front
	gui.Parent = part
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.GothamBlack
	label.TextScaled = true
	label.Text = text
	label.Parent = gui
end

-- Стартовая зона
buildPart("StartPlatform", Vector3.new(80, 1, 120), CFrame.new(0, 0, -470), Enum.Material.Concrete, Color3.new(0.25,0.25,0.25))
local spawn = Instance.new("SpawnLocation")
spawn.Name = "StartSpawn"
spawn.Size = Vector3.new(40, 1, 40)
spawn.CFrame = CFrame.new(0, 0.6, -480)
spawn.Anchored = true
spawn.Parent = workspace
spawn.Material = Enum.Material.Concrete
spawn.BrickColor = BrickColor.new("Bright blue")
spawn.Enabled = true

-- Переход от спавна до красной линии
for z = -440, -410, 10 do
	buildPart("SpawnBridge_"..z, Vector3.new(80, 1, 10), CFrame.new(0, 0.1, z), Enum.Material.Concrete, Color3.new(0.28,0.28,0.28))
	buildPart("SpawnWallL_"..z, Vector3.new(2, 6, 10), CFrame.new(-40, 3, z), Enum.Material.Concrete, Color3.new(0.3,0.3,0.3))
	buildPart("SpawnWallR_"..z, Vector3.new(2, 6, 10), CFrame.new(40, 3, z), Enum.Material.Concrete, Color3.new(0.3,0.3,0.3))
end

-- Красная линия активации погони
local redLine = buildPart("ChaseTriggerLine", Vector3.new(80, 0.5, 4), CFrame.new(0, 0.3, -400), Enum.Material.Neon, Color3.new(1, 0.1, 0.1))
redLine.Transparency = 0.2

-- Длинный прямой путь в Россию
for z = -380, 800, 40 do
	buildPart("RoadStraight_"..z, Vector3.new(30, 1, 40), CFrame.new(0, 0.1, z), Enum.Material.Asphalt, Color3.new(0.15,0.15,0.15))
	buildPart("WallL_"..z, Vector3.new(2, 7, 40), CFrame.new(-16, 3.5, z), Enum.Material.Concrete, Color3.new(0.3,0.3,0.3))
	buildPart("WallR_"..z, Vector3.new(2, 7, 40), CFrame.new(16, 3.5, z), Enum.Material.Concrete, Color3.new(0.3,0.3,0.3))
end

-- Препятствия
for z = -150, 650, 70 do
	local barrier = buildPart("Barrier_"..z, Vector3.new(22, 4, 2), CFrame.new(math.random(-8,8), 2.5, z), Enum.Material.Metal, Color3.new(0.8,0.2,0.2))
	barrier.Rotation = Vector3.new(0, math.random(-12,12), 0)
end

-- Туннели
for z = 80, 400, 160 do
	buildPart("TunnelTop_"..z, Vector3.new(30, 2, 34), CFrame.new(0, 9, z), Enum.Material.Concrete, Color3.new(0.25,0.25,0.25))
	buildPart("TunnelWallL_"..z, Vector3.new(2, 9, 34), CFrame.new(-14, 4.5, z), Enum.Material.Concrete, Color3.new(0.25,0.25,0.25))
	buildPart("TunnelWallR_"..z, Vector3.new(2, 9, 34), CFrame.new(14, 4.5, z), Enum.Material.Concrete, Color3.new(0.25,0.25,0.25))
	buildPart("TunnelFloor_"..z, Vector3.new(28, 1, 34), CFrame.new(0, 0.05, z), Enum.Material.Concrete, Color3.new(0.22,0.22,0.22))
end

-- Плашки
for z = -60, 720, 55 do
	if math.random(1,2) == 1 then
		local pad = buildPart("SpeedPad_"..z, Vector3.new(12, 0.4, 16), CFrame.new(7, 0.3, z), Enum.Material.Neon, Color3.new(0.2, 0.6, 1))
		pad.Name = "BoostPad"
		pad:SetAttribute("Type", "SpeedUp")
		pad:SetAttribute("Power", 14)
	else
		local pad = buildPart("SlowPad_"..z, Vector3.new(12, 0.4, 16), CFrame.new(-7, 0.3, z), Enum.Material.Neon, Color3.new(1, 0.4, 0.1))
		pad.Name = "SlowPad"
		pad:SetAttribute("Type", "SlowDown")
		pad:SetAttribute("Power", -16)
	end
end

-- Зигзаг
for i = 1, 10 do
	local z = 450 + i * 45
	buildPart("ZigRoad_"..i, Vector3.new(18, 1, 32), CFrame.new((i % 2 == 0) and -6 or 6, 0.1, z), Enum.Material.Asphalt, Color3.new(0.15,0.15,0.15))
	buildPart("ZigWall_"..i, Vector3.new(2, 7, 32), CFrame.new((i % 2 == 0) and 10 or -10, 3.5, z), Enum.Material.Concrete, Color3.new(0.3,0.3,0.3))
end

-- Переход к Аляске
for z = 820, 880, 20 do
	buildPart("ToAlaska_"..z, Vector3.new(80, 1, 20), CFrame.new(0, 0.1, z), Enum.Material.Snow, Color3.new(0.92,0.95,1))
	buildPart("ToAlaskaWallL_"..z, Vector3.new(2, 7, 20), CFrame.new(-40, 3.5, z), Enum.Material.Concrete, Color3.new(0.35,0.35,0.35))
	buildPart("ToAlaskaWallR_"..z, Vector3.new(2, 7, 20), CFrame.new(40, 3.5, z), Enum.Material.Concrete, Color3.new(0.35,0.35,0.35))
end

-- Аляска
buildPart("AlaskaGround", Vector3.new(200, 1, 160), CFrame.new(0, 0, 920), Enum.Material.Snow, Color3.new(0.9,0.95,1))
for x = -80,80,40 do
	for z = 860,980,40 do
		buildPart("AlaskaTile_"..x.."_"..z, Vector3.new(40, 1, 40), CFrame.new(x, 0.05, z), Enum.Material.Snow, Color3.new(0.88,0.93,1))
	end
end

-- Беринг
buildPart("BeringApproach", Vector3.new(100, 1, 60), CFrame.new(0, 0.1, 1000), Enum.Material.Snow, Color3.new(0.9,0.95,1))
buildPart("BeringWater", Vector3.new(160, 1, 80), CFrame.new(0, -0.5, 1080), Enum.Material.Water, Color3.new(0.4,0.6,0.9))
buildPart("BeringPath", Vector3.new(40, 1, 40), CFrame.new(0, 0.1, 1040), Enum.Material.Snow, Color3.new(0.9,0.95,1))

-- Переход к Чукотке
for z = 1120, 1160, 20 do
	buildPart("ToChukotka_"..z, Vector3.new(80, 1, 20), CFrame.new(0, 0.1, z), Enum.Material.Snow, Color3.new(0.87,0.92,1))
	buildPart("ToChukotkaWallL_"..z, Vector3.new(2, 7, 20), CFrame.new(-40, 3.5, z), Enum.Material.Concrete, Color3.new(0.35,0.35,0.35))
	buildPart("ToChukotkaWallR_"..z, Vector3.new(2, 7, 20), CFrame.new(40, 3.5, z), Enum.Material.Concrete, Color3.new(0.35,0.35,0.35))
end

-- Чукотка
buildPart("ChukotkaGround", Vector3.new(200, 1, 160), CFrame.new(0, 0, 1220), Enum.Material.Snow, Color3.new(0.85,0.9,1))
for x = -80,80,40 do
	for z = 1160,1280,40 do
		buildPart("ChukotkaTile_"..x.."_"..z, Vector3.new(40, 1, 40), CFrame.new(x, 0.05, z), Enum.Material.Snow, Color3.new(0.83,0.88,1))
	end
end

-- Финишная зона (закрытая)
buildPart("FinishPlatform", Vector3.new(80, 1, 80), CFrame.new(0, 0, 1340), Enum.Material.Snow, Color3.new(0.9,1,0.9))
local finish = buildPart("FinishZone", Vector3.new(70, 12, 12), CFrame.new(0, 6, 1380), Enum.Material.Neon, Color3.new(0.4,1,0.6))
finish.Transparency = 0.25
finish.CanCollide = true

buildBillboard("MAKE AMERICA GREAT AGAIN", Vector3.new(-25, 10, -300))
buildBillboard("ПЕРЕСЕКИ КРАСНУЮ ЛИНИЮ - ТРАМП НАЧНЁТ ГНАТЬСЯ", Vector3.new(0, 10, -395))
buildBillboard("УБЕГАЙ ОТ ДОНАЛЬДА ТРАМПА", Vector3.new(0, 10, 50))
buildBillboard("ПЕРЕПЛЫВИ БЕРИНГОВ ПРОЛИВ", Vector3.new(0, 10, 1040))
buildBillboard("ДОБЕРИСЬ ДО ВОСТОЧНОЙ РОССИИ", Vector3.new(0, 10, 1320))
buildBillboard("ФИНИШ", Vector3.new(0, 12, 1375))
