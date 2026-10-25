local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local function buildTrump()
	local model = Instance.new("Model")
	model.Name = "DonaldTrumpChaser"
	
	local hrp = Instance.new("Part")
	hrp.Name = "HumanoidRootPart"
	hrp.Size = Vector3.new(2, 3, 1)
	hrp.Transparency = 1
	hrp.Anchored = false
	hrp.CanCollide = true
	hrp.CFrame = CFrame.new(0, 10, -420)
	hrp.Parent = model
	
	local humanoid = Instance.new("Humanoid")
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 50
	humanoid.AutoJumpEnabled = true
	humanoid.HipHeight = 2
	humanoid.Parent = model
	
	local torso = Instance.new("Part")
	torso.Name = "Torso"
	torso.Size = Vector3.new(2, 2, 1)
	torso.Color = Color3.new(0.2, 0.3, 0.8)
	torso.Material = Enum.Material.Fabric
	torso.Parent = model
	
	local head = Instance.new("Part")
	head.Name = "Head"
	head.Size = Vector3.new(1.2, 1.2, 1.2)
	head.Color = Color3.new(0.95, 0.7, 0.5)
	head.Material = Enum.Material.SmoothPlastic
	head.Parent = model
	
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Head
	mesh.Parent = head
	
	local hair = Instance.new("Part")
	hair.Name = "Hair"
	hair.Size = Vector3.new(1.4, 0.4, 1.4)
	hair.Color = Color3.new(1, 0.85, 0)
	hair.Material = Enum.Material.SmoothPlastic
	hair.CanCollide = false
	hair.Parent = model
	
	local leftArm = Instance.new("Part")
	leftArm.Name = "Left Arm"
	leftArm.Size = Vector3.new(1, 2, 1)
	leftArm.Color = Color3.new(0.2, 0.3, 0.8)
	leftArm.Material = Enum.Material.Fabric
	leftArm.CanCollide = false
	leftArm.Parent = model
	
	local rightArm = Instance.new("Part")
	rightArm.Name = "Right Arm"
	rightArm.Size = Vector3.new(1, 2, 1)
	rightArm.Color = Color3.new(0.2, 0.3, 0.8)
	rightArm.Material = Enum.Material.Fabric
	rightArm.CanCollide = false
	rightArm.Parent = model
	
	local leftLeg = Instance.new("Part")
	leftLeg.Name = "Left Leg"
	leftLeg.Size = Vector3.new(1, 2, 1)
	leftLeg.Color = Color3.new(0.1, 0.1, 0.1)
	leftLeg.Material = Enum.Material.Fabric
	leftLeg.CanCollide = false
	leftLeg.Parent = model
	
	local rightLeg = Instance.new("Part")
	rightLeg.Name = "Right Leg"
	rightLeg.Size = Vector3.new(1, 2, 1)
	rightLeg.Color = Color3.new(0.1, 0.1, 0.1)
	rightLeg.Material = Enum.Material.Fabric
	rightLeg.CanCollide = false
	rightLeg.Parent = model
	
	local function weld(p0, p1, c0)
		local w = Instance.new("Weld")
		w.Part0 = p0
		w.Part1 = p1
		w.C0 = c0
		w.Parent = p0
	end
	
	weld(hrp, torso, CFrame.new(0, 0, 0))
	weld(torso, head, CFrame.new(0, 1.6, 0))
	weld(head, hair, CFrame.new(0, 0.8, 0))
	weld(torso, leftArm, CFrame.new(-1.5, 0, 0))
	weld(torso, rightArm, CFrame.new(1.5, 0, 0))
	weld(torso, leftLeg, CFrame.new(-0.5, -2, 0))
	weld(torso, rightLeg, CFrame.new(0.5, -2, 0))
	
	model.PrimaryPart = hrp
	return model
end

local TRUMP_MODEL = buildTrump()
TRUMP_MODEL.Parent = workspace

local humanoid = TRUMP_MODEL:FindFirstChildOfClass("Humanoid")
local hrp = TRUMP_MODEL:FindFirstChild("HumanoidRootPart")

local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0, 320, 0, 50)
billboard.StudsOffset = Vector3.new(0, 6, 0)
billboard.AlwaysOnTop = true
billboard.Parent = TRUMP_MODEL:FindFirstChild("Head") or hrp

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBlack
label.TextColor3 = Color3.new(1, 0.1, 0.1)
label.TextStrokeColor3 = Color3.new(0, 0, 0)
label.TextStrokeTransparency = 0
label.Text = "DONALD J. TRUMP | ЖДЁТ ЗА ЛИНИЕЙ"
label.Parent = billboard

local activated = false
local BASE_SPEED = 50
local currentSpeed = BASE_SPEED
local lastTeleport = 0

local function getTarget()
	if not activated then return nil end
	local players = Players:GetPlayers()
	local target = nil
	local dist = math.huge
	if not hrp then return nil end
	for _, plr in ipairs(players) do
		local char = plr.Character
		local chrHrp = char and char:FindFirstChild("HumanoidRootPart")
		local chrHum = char and char:FindFirstChildOfClass("Humanoid")
		if chrHrp and chrHum and chrHum.Health > 0 then
			local d = (chrHrp.Position - hrp.Position).Magnitude
			if d < dist then
				dist = d
				target = chrHrp
			end
		end
	end
	return target
end

ReplicatedStorage.ChildAdded:Connect(function(child)
	if child.Name == "ActivateChase" then
		activated = true
		if hrp then
			hrp.CFrame = CFrame.new(0, 10, -435)
		end
		humanoid.WalkSpeed = BASE_SPEED
		currentSpeed = BASE_SPEED
		label.Text = "DONALD J. TRUMP | MAKE AMERICA GREAT AGAIN"
	end
end)

local padRemote = ReplicatedStorage:WaitForChild("TrumpPadEffect")
padRemote.OnServerEvent:Connect(function(plr, who, t, p)
	if who ~= "trump_apply" then return end
	if not activated then return end
	if t == "SpeedUp" then
		currentSpeed = math.clamp(currentSpeed + p, 28, 58)
		humanoid.WalkSpeed = currentSpeed
		task.wait(2)
		currentSpeed = math.clamp(currentSpeed - p, 28, 58)
		humanoid.WalkSpeed = currentSpeed
	elseif t == "SlowDown" then
		currentSpeed = math.clamp(currentSpeed + p, 20, 58)
		humanoid.WalkSpeed = currentSpeed
		task.wait(2.5)
		currentSpeed = math.clamp(currentSpeed - p, 20, 58)
		humanoid.WalkSpeed = currentSpeed
	end
end)

hrp.Touched:Connect(function(hit)
	if not activated then return end
	local char = hit.Parent
	local plr = Players:GetPlayerFromCharacter(char)
	if not plr then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return end
	if tick() - lastTeleport < 4 then return end
	lastTeleport = tick()
	
	local spawn = workspace:FindFirstChild("StartSpawn")
	if spawn and char:FindFirstChild("HumanoidRootPart") then
		char:FindFirstChild("HumanoidRootPart").CFrame = spawn.CFrame + Vector3.new(math.random(-4,4), 7, math.random(-4,4))
	end
	
	activated = false
	humanoid.WalkSpeed = 0
	label.Text = "DONALD J. TRUMP | ЖДЁТ ЗА ЛИНИЕЙ"
	-- После телепорта ждем новой активации
end)

task.wait(1)
while task.wait(0.12) do
	if not activated or not TRUMP_MODEL.Parent then
		humanoid.WalkSpeed = 0
		continue
	end
	humanoid.WalkSpeed = currentSpeed
	local target = getTarget()
	if target and hrp then
		local path = PathfindingService:CreatePath({
			AgentRadius = 3,
			AgentHeight = 5,
			AgentCanJump = true,
			WaypointSpacing = 2
		})
		local ok = pcall(function()
			path:ComputeAsync(hrp.Position, target.Position)
		end)
		if ok then
			local waypoints = path:GetWaypoints()
			if #waypoints > 0 then
				for _, wp in ipairs(waypoints) do
					if not activated then break end
					if not target.Parent or not TRUMP_MODEL.Parent then break end
					humanoid:MoveTo(wp.Position)
					if wp.Action == Enum.PathWaypointAction.Jump then
						pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
					end
					humanoid.MoveToFinished:Wait()
				end
			else
				humanoid:MoveTo(target.Position)
			end
		else
			humanoid:MoveTo(target.Position)
		end
	end
end
