local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local ESPEnabled = true -- ESP activé par défaut

-- Fonction pour activer/désactiver l'ESP
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
        ESPEnabled = not ESPEnabled
        print("ESP activé :", ESPEnabled)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = player.Character:FindFirstChild("Highlight")
                if highlight then
                    highlight.Enabled = ESPEnabled
                end
            end
        end
    end
end)

-- Fonction pour créer un ESP autour d'un joueur
local function createESP(target)
    if target and target.Character and not target.Character:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Parent = target.Character
        highlight.Adornee = target.Character
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Rouge
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Blanc
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Enabled = ESPEnabled
    end
end

-- Appliquer l'ESP aux joueurs existants
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
    end
end

-- Ajouter un ESP aux nouveaux joueurs
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)
