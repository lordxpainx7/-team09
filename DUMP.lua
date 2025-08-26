-- ScriptHUB Universal para Roblox FPS Games (Gun Grounds FFA)
-- Por LORD TEAM
-- Features: ESP, Aimbot, AimSilent, Fly, Speed, Infinite Jump, NoClip, Infinite Ammo, NoRecoil

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = Workspace.CurrentCamera

-- Configurações principais
local MAIN_COLOR = Color3.fromRGB(25, 0, 51)  -- Roxo quase preto
local BORDER_COLOR = Color3.fromRGB(138, 43, 226)  -- Roxo vibrante
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)  -- Branco

-- Criar a interface principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptHUB"
ScreenGui.Parent = player.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Função para criar elementos de UI
local function createElement(className, properties)
	local element = Instance.new(className)
	for property, value in pairs(properties) do
		element[property] = value
	end
	return element
end

-- Botão principal flutuante
local dragToggle = nil
local dragStart = nil
local startPos = nil

local mainButton = createElement("TextButton", {
	Name = "MainButton",
	Parent = ScreenGui,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(0, 120, 0, 40),
	Position = UDim2.new(0.5, -60, 0, 10),
	Text = "LORD TEAM",
	TextColor3 = TEXT_COLOR,
	TextSize = 14,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false,
	Draggable = true
})

local corner = createElement("UICorner", {
	Parent = mainButton,
	CornerRadius = UDim.new(0, 12)
})

local stroke = createElement("UIStroke", {
	Parent = mainButton,
	Color = BORDER_COLOR,
	Thickness = 2
})

-- Função para arrastar o botão
local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	mainButton.Position = position
end

mainButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragToggle = true
		dragStart = input.Position
		startPos = mainButton.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

mainButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)

-- Menu principal
local mainFrame = createElement("Frame", {
	Name = "MainFrame",
	Parent = ScreenGui,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(0, 500, 0, 400),
	Position = UDim2.new(0.5, -250, 0.5, -200),
	Visible = false
})

local mainCorner = createElement("UICorner", {
	Parent = mainFrame,
	CornerRadius = UDim.new(0, 12)
})

local mainStroke = createElement("UIStroke", {
	Parent = mainFrame,
	Color = BORDER_COLOR,
	Thickness = 3
})

-- Barra de título
local titleBar = createElement("Frame", {
	Name = "TitleBar",
	Parent = mainFrame,
	BackgroundColor3 = BORDER_COLOR,
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.new(0, 0, 0, 0)
})

local titleCorner = createElement("UICorner", {
	Parent = titleBar,
	CornerRadius = UDim.new(0, 12)
})

local titleText = createElement("TextLabel", {
	Name = "TitleText",
	Parent = titleBar,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Text = "LORD TEAM - Cheat HUB v2.0",
	TextColor3 = TEXT_COLOR,
	TextSize = 14,
	Font = Enum.Font.GothamBold
})

local closeButton = createElement("TextButton", {
	Name = "CloseButton",
	Parent = titleBar,
	BackgroundTransparency = 1,
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(1, -30, 0, 0),
	Text = "X",
	TextColor3 = TEXT_COLOR,
	TextSize = 16,
	Font = Enum.Font.GothamBold
})

-- Menu lateral
local sideMenu = createElement("Frame", {
	Name = "SideMenu",
	Parent = mainFrame,
	BackgroundColor3 = Color3.fromRGB(15, 0, 30),
	Size = UDim2.new(0, 120, 1, -30),
	Position = UDim2.new(0, 0, 0, 30)
})

local sideCorner = createElement("UICorner", {
	Parent = sideMenu,
	CornerRadius = UDim.new(0, 12)
})

local sideStroke = createElement("UIStroke", {
	Parent = sideMenu,
	Color = BORDER_COLOR,
	Thickness = 2
})

-- Função para criar botões do menu lateral
local function createMenuButton(name, text, position)
	local button = createElement("TextButton", {
		Name = name,
		Parent = sideMenu,
		BackgroundColor3 = MAIN_COLOR,
		Size = UDim2.new(1, -10, 0, 40),
		Position = UDim2.new(0, 5, 0, position),
		Text = text,
		TextColor3 = TEXT_COLOR,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		AutoButtonColor = false
	})
	
	local buttonCorner = createElement("UICorner", {
		Parent = button,
		CornerRadius = UDim.new(0, 8)
	})
	
	local buttonStroke = createElement("UIStroke", {
		Parent = button,
		Color = BORDER_COLOR,
		Thickness = 1
	})
	
	return button
end

-- Criar botões do menu
local principalButtonMenu = createMenuButton("PrincipalButtonMenu", "Principal", 10)
local espButtonMenu = createMenuButton("EspButtonMenu", "ESP", 60)
local aimButtonMenu = createMenuButton("AimButtonMenu", "Aimbot", 110)
local movementButtonMenu = createMenuButton("MovementButtonMenu", "Movimentação", 160)
local miscButtonMenu = createMenuButton("MiscButtonMenu", "Misc", 210)

-- Conteúdo das abas
local currentTab = "Principal"

local function showTab(tabName)
	for _, child in ipairs(contentFrame:GetChildren()) do
		child.Visible = false
	end
	
	currentTab = tabName
	
	if tabName == "Principal" then
		contentFrame.PrincipalTab.Visible = true
	elseif tabName == "ESP" then
		contentFrame.EspTab.Visible = true
	elseif tabName == "Aimbot" then
		contentFrame.AimTab.Visible = true
	elseif tabName == "Movimentação" then
		contentFrame.MovementTab.Visible = true
	elseif tabName == "Misc" then
		contentFrame.MiscTab.Visible = true
	end
end

-- Aba Principal
local principalTab = createElement("ScrollingFrame", {
	Name = "PrincipalTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = true,
	ScrollBarThickness = 5
})

local principalLayout = createElement("UIListLayout", {
	Parent = principalTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local titleLabel = createElement("TextLabel", {
	Name = "TitleLabel",
	Parent = principalTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "CHEAT HUB PARA GUN GROUNDS FFA",
	TextColor3 = TEXT_COLOR,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

local descriptionLabel = createElement("TextLabel", {
	Name = "DescriptionLabel",
	Parent = principalTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 60),
	Text = "Cheats para [FPS] Gun Grounds FFA. Use com moderação. Versão 2.0",
	TextColor3 = TEXT_COLOR,
	TextSize = 14,
	TextWrapped = true,
	Font = Enum.Font.Gotham,
	LayoutOrder = 2
})

-- Aba ESP
local espTab = createElement("ScrollingFrame", {
	Name = "EspTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = false,
	ScrollBarThickness = 5
})

local espLayout = createElement("UIListLayout", {
	Parent = espTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local espTitle = createElement("TextLabel", {
	Name = "EspTitle",
	Parent = espTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "ESP FEATURES",
	TextColor3 = TEXT_COLOR,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

-- Toggles para ESP
local espLineToggle = false
local espBoxToggle = false
local espNameToggle = false
local espHealthToggle = false

local function createToggle(name, text, position, toggleVar)
	local button = createElement("TextButton", {
		Name = name,
		Parent = espTab,
		BackgroundColor3 = MAIN_COLOR,
		Size = UDim2.new(1, -10, 0, 40),
		Position = UDim2.new(0, 5, 0, position),
		Text = text .. " (OFF)",
		TextColor3 = TEXT_COLOR,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		AutoButtonColor = false,
		LayoutOrder = position / 50 + 1
	})
	
	local buttonCorner = createElement("UICorner", {
		Parent = button,
		CornerRadius = UDim.new(0, 8)
	})
	
	local buttonStroke = createElement("UIStroke", {
		Parent = button,
		Color = BORDER_COLOR,
		Thickness = 1
	})
	
	button.MouseButton1Click:Connect(function()
		toggleVar = not toggleVar
		button.Text = text .. " (" .. (toggleVar and "ON" or "OFF") .. ")"
	end)
	
	return button, toggleVar
end

local lineButton, espLineToggle = createToggle("LineToggle", "ESP Linha", 50, espLineToggle)
local boxButton, espBoxToggle = createToggle("BoxToggle", "ESP Contorno", 100, espBoxToggle)
local nameButton, espNameToggle = createToggle("NameToggle", "ESP Nome", 150, espNameToggle)
local healthButton, espHealthToggle = createToggle("HealthToggle", "ESP Vida", 200, espHealthToggle)

-- Aba Aimbot
local aimTab = createElement("ScrollingFrame", {
	Name = "AimTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = false,
	ScrollBarThickness = 5
})

local aimLayout = createElement("UIListLayout", {
	Parent = aimTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local aimTitle = createElement("TextLabel", {
	Name = "AimTitle",
	Parent = aimTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "AIM FEATURES",
	TextColor3 = TEXT_COLOR,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

local aimbotToggle = false
local aimSilentToggle = false
local fov = 80  -- FOV inicial

local aimbotButton, aimbotToggle = createToggle("AimbotToggle", "Aimbot", 50, aimbotToggle)
local aimSilentButton, aimSilentToggle = createToggle("AimSilentToggle", "Aim Silent", 100, aimSilentToggle)

-- Slider para FOV
local fovSlider = createElement("Frame", {
	Name = "FovSlider",
	Parent = aimTab,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(1, -10, 0, 40),
	LayoutOrder = 3
})

local fovSliderCorner = createElement("UICorner", {
	Parent = fovSlider,
	CornerRadius = UDim.new(0, 8)
})

local fovSliderStroke = createElement("UIStroke", {
	Parent = fovSlider,
	Color = BORDER_COLOR,
	Thickness = 1
})

local fovLabel = createElement("TextLabel", {
	Name = "FovLabel",
	Parent = fovSlider,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Text = "FOV: " .. fov,
	TextColor3 = TEXT_COLOR,
	TextSize = 14,
	Font = Enum.Font.GothamBold
})

fovSlider.MouseButton1Click:Connect(function()
	fov = fov + 10
	if fov > 180 then fov = 35 end
	fovLabel.Text = "FOV: " .. fov
end)

-- Aba Movimentação
local movementTab = createElement("ScrollingFrame", {
	Name = "MovementTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = false,
	ScrollBarThickness = 5
})

local movementLayout = createElement("UIListLayout", {
	Parent = movementTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local movementTitle = createElement("TextLabel", {
	Name = "MovementTitle",
	Parent = movementTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "MOVIMENTAÇÃO FEATURES",
	TextColor3 = TEXT_COLOR,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

local flyToggle = false
local speed = player.Character.Humanoid.WalkSpeed  -- Speed inicial

local flyButton, flyToggle = createToggle("FlyToggle", "Fly", 50, flyToggle)

-- Slider para Speed
local speedSlider = createElement("Frame", {
	Name = "SpeedSlider",
	Parent = movementTab,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(1, -10, 0, 40),
	LayoutOrder = 3
})

local speedSliderCorner = createElement("UICorner", {
	Parent = speedSlider,
	CornerRadius = UDim.new(0, 8)
})

local speedSliderStroke = createElement("UIStroke", {
	Parent = speedSlider,
	Color = BORDER_COLOR,
	Thickness = 1
})

local speedLabel = createElement("TextLabel", {
	Name = "SpeedLabel",
	Parent = speedSlider,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Text = "Speed: " .. speed,
	TextColor3 = TEXT_COLOR,
	TextSize = 14,
	Font = Enum.Font.GothamBold
})

speedSlider.MouseButton1Click:Connect(function()
	speed = speed + 30
	if speed > 4000 then speed = player.Character.Humanoid.WalkSpeed end
	speedLabel.Text = "Speed: " .. speed
	player.Character.Humanoid.WalkSpeed = speed
end)

-- Aba Misc
local miscTab = createElement("ScrollingFrame", {
	Name = "MiscTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = false,
	ScrollBarThickness = 5
})

local miscLayout = createElement("UIListLayout", {
	Parent = miscTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local miscTitle = createElement("TextLabel", {
	Name = "MiscTitle",
	Parent = miscTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "MISC FEATURES",
	TextColor3 = TEXT_COLOR,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

local infiniteJumpToggle = false
local noClipToggle = false
local infiniteAmmoToggle = false
local noRecoilToggle = false

local infiniteJumpButton, infiniteJumpToggle = createToggle("InfiniteJumpToggle", "Infinite Jump", 50, infiniteJumpToggle)
local noClipButton, noClipToggle = createToggle("NoClipToggle", "NoClip", 100, noClipToggle)
local infiniteAmmoButton, infiniteAmmoToggle = createToggle("InfiniteAmmoToggle", "Infinite Ammo", 150, infiniteAmmoToggle)
local noRecoilButton, noRecoilToggle = createToggle("NoRecoilToggle", "No Recoil", 200, noRecoilToggle)

-- Conectando eventos de abas
principalButtonMenu.MouseButton1Click:Connect(function()
	showTab("Principal")
end)

espButtonMenu.MouseButton1Click:Connect(function()
	showTab("ESP")
end)

aimButtonMenu.MouseButton1Click:Connect(function()
	showTab("Aimbot")
end)

movementButtonMenu.MouseButton1Click:Connect(function()
	showTab("Movimentação")
end)

miscButtonMenu.MouseButton1Click:Connect(function()
	showTab("Misc")
end)

-- Abrir/fechar menu
mainButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Efeitos de hover
local function setupButtonHover(button)
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = BORDER_COLOR}):Play()
	end)
	
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = MAIN_COLOR}):Play()
	end)
end

setupButtonHover(mainButton)
setupButtonHover(principalButtonMenu)
setupButtonHover(espButtonMenu)
setupButtonHover(aimButtonMenu)
setupButtonHover(movementButtonMenu)
setupButtonHover(miscButtonMenu)
setupButtonHover(lineButton)
setupButtonHover(boxButton)
setupButtonHover(nameButton)
setupButtonHover(healthButton)
setupButtonHover(aimbotButton)
setupButtonHover(aimSilentButton)
setupButtonHover(flyButton)
setupButtonHover(infiniteJumpButton)
setupButtonHover(noClipButton)
setupButtonHover(infiniteAmmoButton)
setupButtonHover(noRecoilButton)

-- Implementação das features

-- ESP
local espObjects = {}

local function createESP(player)
	if player == game.Players.LocalPlayer or not player.Character then return end
	
	local head = player.Character:FindFirstChild("Head")
	if not head then return end
	
	local line = Drawing.new("Line")
	line.Visible = false
	line.Color = Color3.fromRGB(255, 0, 0)
	line.Thickness = 2
	
	local box = Drawing.new("Square")
	box.Visible = false
	box.Color = Color3.fromRGB(0, 255, 0)
	box.Thickness = 1
	box.Filled = false
	
	local nameText = Drawing.new("Text")
	nameText.Visible = false
	nameText.Color = Color3.fromRGB(255, 255, 255)
	nameText.Size = 16
	nameText.Outline = true
	
	local healthBar = Drawing.new("Quad")
	healthBar.Visible = false
	healthBar.Color = Color3.fromRGB(0, 255, 0)
	healthBar.Thickness = 1
	healthBar.Filled = true
	
	espObjects[player] = {line = line, box = box, name = nameText, health = healthBar}
end

local function updateESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
			if not espObjects[p] then createESP(p) end
			local obj = espObjects[p]
			
			local character = p.Character
			local head = character.Head
			local humanoid = character.Humanoid
			local root = character.HumanoidRootPart
			
			local headPos, onScreen = camera:WorldToViewportPoint(head.Position)
			local rootPos = camera:WorldToViewportPoint(root.Position)
			local legsPos = camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
			
			if onScreen then
				if espLineToggle then
					obj.line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
					obj.line.To = Vector2.new(headPos.X, headPos.Y)
					obj.line.Visible = true
				else
					obj.line.Visible = false
				end
				
				if espBoxToggle then
					local height = (headPos.Y - legsPos.Y) / 2
					local width = height / 2
					obj.box.Size = Vector2.new(width, height)
					obj.box.Position = Vector2.new(rootPos.X - width / 2, rootPos.Y - height / 2)
					obj.box.Color = if camera:WorldToViewportPoint(character.Head.Position).Z > 0 then Color3.fromRGB(0, 255, 0) else Color3.fromRGB(255, 0, 0)
					obj.box.Visible = true
				else
					obj.box.Visible = false
				end
				
				if espNameToggle then
					obj.name.Text = p.Name
					obj.name.Position = Vector2.new(headPos.X, headPos.Y - 20)
					obj.name.Visible = true
				else
					obj.name.Visible = false
				end
				
				if espHealthToggle then
					local healthPct = humanoid.Health / humanoid.MaxHealth
					local healthColor = Color3.fromRGB(255 * (1 - healthPct), 255 * healthPct, 0)
					local healthHeight = height * healthPct
					obj.health.PointA = Vector2.new(rootPos.X - width / 2 - 5, rootPos.Y - height / 2 + height - healthHeight)
					obj.health.PointB = Vector2.new(rootPos.X - width / 2 - 5, rootPos.Y - height / 2 + height)
					obj.health.PointC = Vector2.new(rootPos.X - width / 2 - 2, rootPos.Y - height / 2 + height)
					obj.health.PointD = Vector2.new(rootPos.X - width / 2 - 2, rootPos.Y - height / 2 + height - healthHeight)
					obj.health.Color = healthColor
					obj.health.Visible = true
				else
					obj.health.Visible = false
				end
			else
				obj.line.Visible = false
				obj.box.Visible = false
				obj.name.Visible = false
				obj.health.Visible = false
			end
		elseif espObjects[p] then
			espObjects[p].line:Remove()
			espObjects[p].box:Remove()
			espObjects[p].name:Remove()
			espObjects[p].health:Remove()
			espObjects[p] = nil
		end
	end
end

RunService.RenderStepped:Connect(updateESP)

-- Aimbot
local aimbotCircle = Drawing.new("Circle")
aimbotCircle.Visible = false
aimbotCircle.Color = Color3.fromRGB(138, 43, 226)
aimbotCircle.Thickness = 2
aimbotCircle.NumSides = 100
aimbotCircle.Radius = fov
aimbotCircle.Transparency = 0.5
aimbotCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

local function getClosestPlayer()
	local closest = nil
	local minDist = fov
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
			local headPos = camera:WorldToViewportPoint(p.Character.Head.Position)
			local dist = (Vector2.new(headPos.X, headPos.Y) - aimbotCircle.Position).Magnitude
			if dist < minDist and headPos.Z > 0 then
				minDist = dist
				closest = p
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	aimbotCircle.Radius = fov
	aimbotCircle.Visible = aimbotToggle
	
	if aimbotToggle then
		local target = getClosestPlayer()
		if target then
			camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Character.Head.Position)
		end
	end
end)

-- AimSilent (simplificado, assume raycast em tools)
local oldNamecall
oldNamecall = hookmetatable(game, "__namecall", function(self, ...)
	if aimSilentToggle and getnamecallmethod() == "Raycast" then
		local args = {...}
		local target = getClosestPlayer()
		if target then
			args[2] = (target.Character.Head.Position - args[1]).Unit * (args[3] or 1000)
		end
		return oldNamecall(self, unpack(args))
	end
	return oldNamecall(self, ...)
end)

-- Fly
local flyBodyVelocity = nil
local flySpeed = 50

UserInputService.InputBegan:Connect(function(input)
	if flyToggle and input.KeyCode == Enum.KeyCode.Space then
		if not flyBodyVelocity then
			flyBodyVelocity = Instance.new("BodyVelocity")
			flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
			flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			flyBodyVelocity.Parent = player.Character.HumanoidRootPart
		end
		flyBodyVelocity.Velocity = camera.CFrame.LookVector * flySpeed
	end
end)

RunService.Heartbeat:Connect(function()
	if not flyToggle and flyBodyVelocity then
		flyBodyVelocity:Destroy()
		flyBodyVelocity = nil
	end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
	if infiniteJumpToggle then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- NoClip
RunService.Stepped:Connect(function()
	if noClipToggle then
		for _, part in pairs(player.Character:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Infinite Ammo (assume tools com Ammo)
RunService.Heartbeat:Connect(function()
	if infiniteAmmoToggle and player.Character:FindFirstChildOfClass("Tool") then
		local tool = player.Character:FindFirstChildOfClass("Tool")
		if tool:FindFirstChild("Ammo") then
			tool.Ammo.Value = tool.MaxAmmo.Value
		end
	end
end)

-- NoRecoil (assume localscript no tool)
local oldIndex
oldIndex = hookmetatable(game, "__index", function(self, key)
	if noRecoilToggle and self:IsA("Tool") and key == "Recoil" then
		return 0
	end
	return oldIndex(self, key)
end)

-- Inicialização
showTab("Principal")
print("Cheat HUB carregado com sucesso! Clique no botão 'LORD TEAM' para abrir o menu.")

-- Atualizar jogadores online
RunService.Heartbeat:Connect(function()
	playersOnline.Text = "Jogadores Online: " .. #Players:GetPlayers()
end)
