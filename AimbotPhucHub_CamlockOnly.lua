
-- AimbotPhucHub Camlock Only | No ESP | Trigon Compatible

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local CamlockActive = false
local Target = nil

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CamlockGui"
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 200, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -100, 0, 5) -- Đã chỉnh cao lên
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16
ToggleButton.Text = "Camlock: OFF"
ToggleButton.Parent = ScreenGui

local UICorner = Instance.new("UICorner", ToggleButton)
UICorner.CornerRadius = UDim.new(0, 12)

-- Draggable
local dragging = false
local dragInput, dragStart, startPos

ToggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = ToggleButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

ToggleButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Find Closest Player
local function GetClosestPlayer()
	local closest, shortestDist = nil, math.huge
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos, visible = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			local dist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
			if visible and dist < shortestDist then
				shortestDist = dist
				closest = player
			end
		end
	end
	return closest
end

-- Camlock logic
RunService.RenderStepped:Connect(function()
	if CamlockActive and Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
	end
end)

-- Toggle logic
ToggleButton.MouseButton1Click:Connect(function()
	if not CamlockActive then
		Target = GetClosestPlayer()
		if Target then
			CamlockActive = true
			ToggleButton.Text = "Camlock: ON"
		end
	else
		CamlockActive = false
		Target = nil
		ToggleButton.Text = "Camlock: OFF"
	end
end)
