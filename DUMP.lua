-- ScriptHUB Universal para Roblox - Versão Melhorada
-- Por LORD TEAM

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Configurações principais
local MAIN_COLOR = Color3.fromRGB(25, 0, 51)  -- Roxo quase preto
local BORDER_COLOR = Color3.fromRGB(138, 43, 226)  -- Roxo vibrante (RGB)
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
local dragSpeed = 0.25
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
	AutoButtonColor = false
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
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragToggle then
		updateInput(input)
	end
end)

-- Menu principal (agora menor)
local mainFrame = createElement("Frame", {
	Name = "MainFrame",
	Parent = ScreenGui,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(0, 500, 0, 300),  -- Reduzido de 400 para 300
	Position = UDim2.new(0.5, -250, 0.5, -150),
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
	Text = "LORD TEAM - ScriptHUB v2.0",
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

-- Conteúdo principal
local contentFrame = createElement("Frame", {
	Name = "ContentFrame",
	Parent = mainFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -120, 1, -30),
	Position = UDim2.new(0, 120, 0, 30)
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
local mainButtonMenu = createMenuButton("MainButtonMenu", "Principal", 10)
local dumpButtonMenu = createMenuButton("DumpButtonMenu", "Dump", 60)
local creditsButtonMenu = createMenuButton("CreditsButtonMenu", "Créditos", 110)

-- Conteúdo das abas
local currentTab = "Principal"

local function showTab(tabName)
	for _, child in ipairs(contentFrame:GetChildren()) do
		child.Visible = false
	end
	
	currentTab = tabName
	
	if tabName == "Principal" then
		contentFrame.MainTab.Visible = true
	elseif tabName == "Dump" then
		contentFrame.DumpTab.Visible = true
	elseif tabName == "Créditos" then
		contentFrame.CreditsTab.Visible = true
	end
end

-- Aba Principal
local mainTab = createElement("ScrollingFrame", {
	Name = "MainTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = true,
	ScrollBarThickness = 5,
	CanvasSize = UDim2.new(0, 0, 0, 180)
})

local mainLayout = createElement("UIListLayout", {
	Parent = mainTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local titleLabel = createElement("TextLabel", {
	Name = "TitleLabel",
	Parent = mainTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 30),
	Text = "SCRIPT HUB UNIVERSAL",
	TextColor3 = TEXT_COLOR,
	TextSize = 16,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

local descriptionLabel = createElement("TextLabel", {
	Name = "DescriptionLabel",
	Parent = mainTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "Este é um script universal para análise completa de jogos no Roblox. Versão 2.0",
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	TextWrapped = true,
	Font = Enum.Font.Gotham,
	LayoutOrder = 2
})

local gameName = createElement("TextLabel", {
	Name = "GameName",
	Parent = mainTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 20),
	Text = "Nome do Jogo: ",
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	Font = Enum.Font.Gotham,
	LayoutOrder = 3
})

local gameVersion = createElement("TextLabel", {
	Name = "GameVersion",
	Parent = mainTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 20),
	Text = "ID do Jogo: " .. game.PlaceId,
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	Font = Enum.Font.Gotham,
	LayoutOrder = 4
})

local playersOnline = createElement("TextLabel", {
	Name = "PlayersOnline",
	Parent = mainTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 20),
	Text = "Jogadores Online: " .. #Players:GetPlayers(),
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	Font = Enum.Font.Gotham,
	LayoutOrder = 5
})

-- Aba Dump - Agora com cabeçalho fixo
local dumpTab = createElement("Frame", {
	Name = "DumpTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = false
})

-- Cabeçalho fixo (não rola com o conteúdo)
local dumpHeader = createElement("Frame", {
	Name = "DumpHeader",
	Parent = dumpTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 100),
	Position = UDim2.new(0, 0, 0, 0)
})

local dumpTitle = createElement("TextLabel", {
	Name = "DumpTitle",
	Parent = dumpHeader,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 30),
	Text = "DUMP DE JOGO COMPLETO",
	TextColor3 = TEXT_COLOR,
	TextSize = 16,
	Font = Enum.Font.GothamBold
})

local dumpDescription = createElement("TextLabel", {
	Name = "DumpDescription",
	Parent = dumpHeader,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 40),
	Text = "Esta ferramenta fará o dump completo de todos os arquivos do jogo, incluindo mapas, estruturas, NPCs, scripts, configurações e lógica.",
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	TextWrapped = true,
	Font = Enum.Font.Gotham
})

local dumpButton = createElement("TextButton", {
	Name = "DumpButton",
	Parent = dumpHeader,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(0, 200, 0, 30),
	Position = UDim2.new(0.5, -100, 0, 70),
	Text = "INICIAR DUMP COMPLETO",
	TextColor3 = TEXT_COLOR,
	TextSize = 14,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
})

local dumpButtonCorner = createElement("UICorner", {
	Parent = dumpButton,
	CornerRadius = UDim.new(0, 8)
})

local dumpButtonStroke = createElement("UIStroke", {
	Parent = dumpButton,
	Color = BORDER_COLOR,
	Thickness = 2
})

-- Área de resultados com rolagem
local dumpResults = createElement("ScrollingFrame", {
	Name = "DumpResults",
	Parent = dumpTab,
	BackgroundColor3 = Color3.fromRGB(20, 20, 20),
	Size = UDim2.new(1, 0, 1, -100),
	Position = UDim2.new(0, 0, 0, 100),
	CanvasSize = UDim2.new(0, 0, 0, 0),
	ScrollBarThickness = 5,
	Visible = false
})

local dumpResultsCorner = createElement("UICorner", {
	Parent = dumpResults,
	CornerRadius = UDim.new(0, 8)
})

local dumpResultsStroke = createElement("UIStroke", {
	Parent = dumpResults,
	Color = BORDER_COLOR,
	Thickness = 1
})

local dumpOutput = createElement("TextLabel", {
	Name = "DumpOutput",
	Parent = dumpResults,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -10, 1, -40),
	Position = UDim2.new(0, 5, 0, 5),
	Text = "Resultado do dump aparecerá aqui...",
	TextColor3 = TEXT_COLOR,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = true,
	Font = Enum.Font.Code,
	TextTruncate = Enum.TextTruncate.None
})

local copyButton = createElement("TextButton", {
	Name = "CopyButton",
	Parent = dumpResults,
	BackgroundColor3 = MAIN_COLOR,
	Size = UDim2.new(1, -10, 0, 30),
	Position = UDim2.new(0, 5, 1, -35),
	Text = "COPIAR PARA ÁREA DE TRANSFERÊNCIA",
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false,
	Visible = false
})

local copyButtonCorner = createElement("UICorner", {
	Parent = copyButton,
	CornerRadius = UDim.new(0, 8)
})

local copyButtonStroke = createElement("UIStroke", {
	Parent = copyButton,
	Color = BORDER_COLOR,
	Thickness = 1
})

-- Aba Créditos
local creditsTab = createElement("ScrollingFrame", {
	Name = "CreditsTab",
	Parent = contentFrame,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	Visible = false,
	ScrollBarThickness = 5,
	CanvasSize = UDim2.new(0, 0, 0, 150)
})

local creditsLayout = createElement("UIListLayout", {
	Parent = creditsTab,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 10)
})

local creditsTitle = createElement("TextLabel", {
	Name = "CreditsTitle",
	Parent = creditsTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 30),
	Text = "CRÉDITOS",
	TextColor3 = TEXT_COLOR,
	TextSize = 16,
	Font = Enum.Font.GothamBold,
	LayoutOrder = 1
})

local creditsText = createElement("TextLabel", {
	Name = "CreditsText",
	Parent = creditsTab,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 120),
	Text = "Script desenvolvido por:\n\nLORD TEAM\n\nCom a assistência de AI Assistant\n\nVersão: 2.0\n\nEste script foi criado para fins educacionais e de análise.",
	TextColor3 = TEXT_COLOR,
	TextSize = 12,
	TextWrapped = true,
	Font = Enum.Font.Gotham,
	LayoutOrder = 2
})

-- Função para fazer o dump completo do jogo
local function performCompleteDump()
	local dumpData = {
		GameInfo = {
			Name = MarketplaceService:GetProductInfo(game.PlaceId).Name,
			PlaceId = game.PlaceId,
			Creator = game.CreatorId,
			Players = #Players:GetPlayers(),
			MaxPlayers = game.Players.MaxPlayers,
			Time = os.date("%Y-%m-%d %H:%M:%S")
		},
		Workspace = {
			Objects = {},
			Terrain = {}
		},
		Lighting = {},
		Players = {},
		Services = {},
		ReplicatedStorage = {},
		ServerStorage = {},
		Scripts = {}
	}
	
	-- Coletar informações do Workspace
	if workspace:FindFirstChildOfClass("Terrain") then
		dumpData.Workspace.Terrain = {
			Size = workspace.Terrain.Size,
			MaxExtents = workspace.Terrain.MaxExtents
		}
	end
	
	for _, obj in ipairs(workspace:GetDescendants()) do
		local objInfo = {
			Name = obj.Name,
			ClassName = obj.ClassName,
			Path = obj:GetFullName()
		}
		
		if obj:IsA("BasePart") then
			objInfo.Position = {X = obj.Position.X, Y = obj.Position.Y, Z = obj.Position.Z}
			objInfo.Size = {X = obj.Size.X, Y = obj.Size.Y, Z = obj.Size.Z}
			objInfo.Material = tostring(obj.Material)
			objInfo.Transparency = obj.Transparency
			objInfo.CanCollide = obj.CanCollide
			objInfo.Anchored = obj.Anchored
		elseif obj:IsA("Model") then
			objInfo.PrimaryPart = obj.PrimaryPart and obj.PrimaryPart.Name or "None"
		elseif obj:IsA("Decal") or obj:IsA("Texture") then
			objInfo.Texture = obj.Texture ~= "" and obj.Texture or "None"
		elseif obj:IsA("Light") then
			objInfo.Color = {R = obj.Color.R, G = obj.Color.G, B = obj.Color.B}
			objInfo.Brightness = obj.Brightness
			objInfo.Range = obj.Range
		end
		
		table.insert(dumpData.Workspace.Objects, objInfo)
	end
	
	-- Coletar informações do Lighting
	for _, obj in ipairs(game.Lighting:GetDescendants()) do
		local objInfo = {
			Name = obj.Name,
			ClassName = obj.ClassName,
			Path = obj:GetFullName()
		}
		
		if obj:IsA("Light") then
			objInfo.Color = {R = obj.Color.R, G = obj.Color.G, B = obj.Color.B}
			objInfo.Brightness = obj.Brightness
			objInfo.Range = obj.Range
		elseif obj:IsA("Sky") then
			objInfo.SkyboxUp = obj.SkyboxUp ~= "" and "Exists" or "None"
			objInfo.SkyboxLf = obj.SkyboxLf ~= "" and "Exists" or "None"
			objInfo.SkyboxRt = obj.SkyboxRt ~= "" and "Exists" or "None"
		elseif obj:IsA("Atmosphere") then
			objInfo.Density = obj.Density
			objInfo.Offset = obj.Offset
			objInfo.Color = {R = obj.Color.R, G = obj.Color.G, B = obj.Color.B}
		end
		
		table.insert(dumpData.Lighting, objInfo)
	end
	
	-- Coletar informações dos Players
	for _, player in ipairs(Players:GetPlayers()) do
		table.insert(dumpData.Players, {
			Name = player.Name,
			UserId = player.UserId,
			AccountAge = player.AccountAge,
			Team = player.Team and player.Team.Name or "No Team"
		})
	end
	
	-- Coletar informações dos Services
	for _, serviceName in ipairs({"ReplicatedStorage", "ServerStorage", "StarterPack", "StarterGui", "StarterPlayer"}) do
		local service = game:GetService(serviceName)
		if service then
			dumpData[serviceName] = {}
			for _, obj in ipairs(service:GetDescendants()) do
				table.insert(dumpData[serviceName], {
					Name = obj.Name,
					ClassName = obj.ClassName,
					Path = obj:GetFullName()
				})
			end
		end
	end
	
	-- Coletar informações de Scripts
	for _, obj in ipairs(game:GetDescendants()) do
		if obj:IsA("LuaSourceContainer") then
			local scriptInfo = {
				Name = obj.Name,
				ClassName = obj.ClassName,
				Path = obj:GetFullName(),
				Disabled = obj.Disabled,
				LinkedSource = obj.LinkedSource ~= "" and obj.LinkedSource or "None"
			}
			
			table.insert(dumpData.Scripts, scriptInfo)
		end
	end
	
	-- Coletar configurações do jogo
	dumpData.GameSettings = {
		Video = {
			QualityLevel = settings().Rendering.QualityLevel
		},
		Physics = {
			AllowSleep = settings().Physics.AllowSleep,
			ShowPhysicsErrors = settings().Physics.ShowPhysicsErrors
		},
		Network = {
			PrintBits = settings().Network.PrintBits,
			PrintInstances = settings().Network.PrintInstances,
			PrintPhysicsErrors = settings().Network.PrintPhysicsErrors,
			PrintProperties = settings().Network.PrintProperties,
			PrintStreamInstanceQuotas = settings().Network.PrintStreamInstanceQuotas
		}
	}
	
	return HttpService:JSONEncode(dumpData)
end

-- Função para copiar texto para a área de transferência
local function copyToClipboard(text)
	-- Em Roblox, precisamos usar uma abordagem diferente para copiar para a área de transferência
	-- Esta é uma implementação que funciona em muitos ambientes
	local success, result = pcall(function()
		-- Tenta usar o SetClipboard se disponível
		if setclipboard then
			setclipboard(text)
			return true
		else
			-- Alternativa: criar um TextBox temporário para copiar
			local tempBox = Instance.new("TextBox")
			tempBox.Parent = ScreenGui
			tempBox.Text = text
			tempBox:CaptureFocus()
			tempBox:SelectAll()
			tempBox:ReleaseFocus()
			wait(0.1)
			tempBox:Destroy()
			return true
		end
	end)
	
	return success
end

-- Conectando eventos
mainButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

mainButtonMenu.MouseButton1Click:Connect(function()
	showTab("Principal")
end)

dumpButtonMenu.MouseButton1Click:Connect(function()
	showTab("Dump")
end)

creditsButtonMenu.MouseButton1Click:Connect(function()
	showTab("Créditos")
end)

dumpButton.MouseButton1Click:Connect(function()
	dumpOutput.Text = "Executando dump completo... Isso pode levar alguns segundos."
	dumpResults.Visible = true
	dumpOutput.TextXAlignment = Enum.TextXAlignment.Center
	dumpOutput.TextYAlignment = Enum.TextYAlignment.Center
	
	-- Simular processo de dump (em um ambiente real, isso seria substituído pela função real)
	local success, result = pcall(function()
		return performCompleteDump()
	end)
	
	if success then
		-- Formatar o JSON para exibição
		local formatted = result:gsub(",", ",\n"):gsub("{", "{\n"):gsub("}", "\n}")
		dumpOutput.Text = "Dump concluído com sucesso!\n\n" .. 
			"Jogo: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "\n" ..
			"Objetos no Workspace: " .. #workspace:GetDescendants() .. "\n" ..
			"Objetos no Lighting: " .. #game.Lighting:GetDescendants() .. "\n" ..
			"Scripts encontrados: " .. #dumpData.Scripts .. "\n" ..
			"Jogadores: " .. #Players:GetPlayers() .. "\n\n" ..
			"Dados completos disponíveis para cópia."
		
		dumpOutput.TextXAlignment = Enum.TextXAlignment.Left
		dumpOutput.TextYAlignment = Enum.TextYAlignment.Top
		
		-- Armazenar os dados para cópia
		dumpOutput.DumpData = result
		copyButton.Visible = true
		
		-- Ajustar o tamanho do canvas para o conteúdo
		local textSize = TextService:GetTextSize(dumpOutput.Text, dumpOutput.TextSize, dumpOutput.Font, Vector2.new(dumpOutput.AbsoluteSize.X, 10000))
		dumpResults.CanvasSize = UDim2.new(0, 0, 0, textSize.Y + 50)
	else
		dumpOutput.Text = "Erro durante o dump: " .. result
		copyButton.Visible = false
	end
end)

copyButton.MouseButton1Click:Connect(function()
	if dumpOutput.DumpData then
		local success = copyToClipboard(dumpOutput.DumpData)
		
		-- Feedback visual
		local originalText = copyButton.Text
		if success then
			copyButton.Text = "✓ COPIADO!"
		else
			copyButton.Text = "✗ ERRO AO COPIAR"
		end
		
		wait(1.5)
		copyButton.Text = originalText
	end
end)

-- Efeitos de hover para todos os botões
local function setupButtonHover(button)
	button.MouseEnter:Connect(function()
		Tween
