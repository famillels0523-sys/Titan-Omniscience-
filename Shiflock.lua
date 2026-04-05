-- [[ SHIFT LOCK UNIVERSEL (PC & MOBILE) ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- 1. CRÉATION DU BOUTON (GUI)
local slGui = Instance.new("ScreenGui")
slGui.Name = "ShiftLockGui"; slGui.Parent = (game:GetService("CoreGui") or lp.PlayerGui)
slGui.IgnoreGuiInset = true

local slButton = Instance.new("ImageButton", slGui)
slButton.Size = UDim2.new(0, 50, 0, 50)
slButton.Position = UDim2.new(0.85, 0, 0.7, 0) -- Position en bas à droite
slButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
slButton.BackgroundTransparency = 0.5
slButton.Image = "rbxassetid://13054178550" -- Icône de cadenas
Instance.new("UICorner", slButton).CornerRadius = UDim.new(1, 0)

-- 2. LOGIQUE DE VERROUILLAGE
local isShiftLock = false

local function toggleShiftLock()
    isShiftLock = not isShiftLock
    if isShiftLock then
        slButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- Devient bleu quand actif
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    else
        slButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end

-- Activer via le bouton (Mobile)
slButton.MouseButton1Click:Connect(toggleShiftLock)

-- Activer via la touche Shift (PC)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftShift then
        toggleShiftLock()
    end
end)

-- 3. MOTEUR DE LA CAMÉRA (IMPORTANT)
RunService.RenderStepped:Connect(function()
    if isShiftLock and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local root = lp.Character.HumanoidRootPart
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        
        -- Force le personnage à regarder devant la caméra
        local look = camera.CFrame.LookVector
        root.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(look.X, 0, look.Z))
        
        -- Décale un peu la caméra sur le côté (effet épaule)
        hum.CameraOffset = Vector3.new(1.7, 0.5, 0) 
        
        -- Verrouille la souris
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    else
        if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
            lp.Character:FindFirstChildOfClass("Humanoid").CameraOffset = Vector3.new(0,0,0)
        end
    end
end)
