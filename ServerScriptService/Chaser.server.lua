local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ASSETS = ReplicatedStorage:WaitForChild("Assets")
local TRUMP_MODEL = ASSETS:WaitForChild("DonaldTrump"):Clone()

TRUMP_MODEL.Name = "DonaldTrumpChaser"
TRUMP_MODEL.Parent = workspace

if not TRUMP_MODEL:FindFirstChild("HumanoidRootPart") then
	warn("Trump model needs HumanoidRootPart")
	return
end

local humanoid = TRUMP_MODEL:FindFirstChildOfClass("Humanoid")
if not humanoid then
	humanoid = Instance.new("Humanoid")
	humanoid.Parent = TRUMP_MODEL
end

humanoid.WalkSpeed = 32

local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0, 280, 0, 40)
billboard.StudsOffset = Vector3.new(0, 5, 0)
billboard.AlwaysOnTop = true
billboard.Parent = TRUMP_MODEL:FindFirstChild("Head") or TRUMP_MODEL:FindFirstChild("HumanoidRootPart")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBlack
label.TextColor3 = Color3.new(1, 0.2, 0.2)
label.TextStrokeColor3 = Color3.new(0, 0, 0)
label.TextStrokeTransparency = 0
label.Text = "DONALD J. TRUMP | MAKE AMERICA GREAT AGAIN"
label.Parent = billboard

local function getTarget()
	local players = Players:GetPlayers()
	local target = nil
	local dist = math.huge
	local hrp = TRUMP_MODEL:FindFirstChild("HumanoidRootPart")
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

task.wait(1)
while task.wait(0.2) do
	local target = getTarget()
	if target and TRUMP_MODEL.Parent then
		local hrp = TRUMP_MODEL:FindFirstChild("HumanoidRootPart")
		if hrp then
			local path = PathfindingService:CreatePath({
				AgentRadius = 3,
				AgentHeight = 5,
				AgentCanJump = true
			})
			path:ComputeAsync(hrp.Position, target.Position)
			local waypoints = path:GetWaypoints()
			if #waypoints > 0 then
				for _, wp in ipairs(waypoints) do
					if not target.Parent or not TRUMP_MODEL.Parent then break end
					humanoid:MoveTo(wp.Position)
					if wp.Action == Enum.PathWaypointAction.Jump then
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end
					humanoid.MoveToFinished:Wait()
				end
			else
				humanoid:MoveTo(target.Position)
			end
		end
	end
end
