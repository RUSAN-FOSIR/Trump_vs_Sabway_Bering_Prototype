local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local REMOTE = ReplicatedStorage:WaitForChild("TrumpPadEffect")
local player = Players.LocalPlayer

REMOTE.OnClientEvent:Connect(function(who, plr, t, p)
	-- сервер теперь вызывает FireServer, но на всякий случай не делаем тут ничего
	-- клиенты не должны триггерить эффекты Трампа
end)

-- Переопределим логику: клиент шлёт на сервер при касании
workspace.ChildAdded:Connect(function() end)

-- Фактически сервер сам обрабатывает касания через Touched, мы просто добавим проверку на клиенте не нужна
-- Касания обрабатываются на сервере в Pads.server.lua через FireServer
local function setup()
	local pads = {}
	local function addPad(pad)
		if pads[pad] then return end
		pads[pad] = true
		pad.Touched:Connect(function(hit)
			local char = player.Character
			if not char then return end
			if hit.Parent ~= char then return end
			local t = pad:GetAttribute("Type")
			local pwr = pad:GetAttribute("Power") or 0
			if t and pwr ~= 0 then
				REMOTE:FireServer("trump_apply", t, pwr)
			end
		end)
	end
	for _, v in ipairs(workspace:GetChildren()) do
		if v.Name == "BoostPad" or v.Name == "SlowPad" then
			addPad(v)
		end
	end
	workspace.ChildAdded:Connect(function(c)
		if c.Name == "BoostPad" or c.Name == "SlowPad" then
			task.wait()
			addPad(c)
		end
	end)
end

task.wait(1)
setup()
