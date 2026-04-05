-- [[ TITAN AI OMNISCIENCE V51 - PUBLIC ]] --
local lp = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local sg = Instance.new("ScreenGui")
sg.Name = "TitanAI"; sg.Parent = (game:GetService("CoreGui") or lp.PlayerGui); sg.IgnoreGuiInset = true

-- [[ CONFIG INTERNE ]] --
local CORRECT_KEY = "Geminigod" -- Change ici pour changer la clé de tout le monde
_G.TitanAuth = false
_G.Config = {
    SilentAim = false, AimFOV = 200, Hitbox = false, HitboxSize = 50,
    Fly = false, FlySpeed = 150, WalkSpeed = 16, JumpPower = 50,
    ESP = false, FullBright = false, RGBEffect = true
}

-- [[ UI PRINCIPALE ]] --
local main = Instance.new("Frame", sg)
main.Size, main.Position = UDim2.new(0, 550, 0, 420), UDim2.new(0.5, -275, 0.5, -210)
main.BackgroundColor3, main.Visible = Color3.fromRGB(10, 10, 15), false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)
local stroke = Instance.new("UIStroke", main); stroke.Thickness = 3

-- EFFET RGB SUR LA BORDURE
RunService.RenderStepped:Connect(function()
    if _G.Config.RGBEffect then stroke.Color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1) end
end)

-- [[ LOGIN SYSTEM ]] --
local login = Instance.new("Frame", sg)
login.Size, login.Position = UDim2.new(0, 350, 0, 250), UDim2.new(0.5, -175, 0.5, -125)
login.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Instance.new("UICorner", login)

local lTitle = Instance.new("TextLabel", login)
lTitle.Size, lTitle.Position = UDim2.new(1, 0, 0, 50), UDim2.new(0,0,0,10)
lTitle.Text = "TITAN AI LOGIN"; lTitle.TextColor3 = Color3.new(1,1,1); lTitle.Font = "GothamBold"; lTitle.TextSize = 20; lTitle.BackgroundTransparency = 1

local lInfo = Instance.new("TextLabel", login)
lInfo.Size, lInfo.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0,0,0,60)
lInfo.Text = "Contact Creator for Key (1€/4 Days)"; lInfo.TextColor3 = Color3.new(0.6,0.6,0.6); lInfo.Font = "Gotham"; lInfo.TextSize = 12; lInfo.BackgroundTransparency = 1

local lBox = Instance.new("TextBox", login)
lBox.Size, lBox.Position = UDim2.new(0.8, 0, 0, 45), UDim2.new(0.1, 0, 0.45, 0)
lBox.PlaceholderText = "Paste Key..."; lBox.Text = ""; lBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30); lBox.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", lBox)

local lBtn = Instance.new("TextButton", login)
lBtn.Size, lBtn.Position = UDim2.new(0.8, 0, 0, 45), UDim2.new(0.1, 0, 0.7, 0)
lBtn.Text = "VERIFY"; lBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 255); lBtn.TextColor3 = Color3.new(1,1,1); lBtn.Font = "GothamBold"; Instance.new("UICorner", lBtn)

-- [[ BOUTON "T" IA ]] --
local bubble = Instance.new("TextButton", sg)
bubble.Size, bubble.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0.02, 0, 0.2, 0)
bubble.BackgroundColor3 = Color3.fromRGB(20, 0, 40); bubble.Text = "T"; bubble.TextColor3 = Color3.new(1,1,1); bubble.Visible = false; bubble.Draggable = true
Instance.new("UICorner", bubble).CornerRadius = UDim.new(1,0); Instance.new("UIStroke", bubble).Color = Color3.new(1,1,1)

-- [[ ACTIONS ]] --
lBtn.MouseButton1Click:Connect(function()
    if lBox.Text == CORRECT_KEY then _G.TitanAuth = true; login:Destroy(); bubble.Visible = true else lBox.Text = ""; lBox.PlaceholderText = "WRONG KEY" end
end)
bubble.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

-- MOTEUR DE TRICHE (SPEED, JUMP, HITBOX, FLY)
RunService.Heartbeat:Connect(function()
    if not _G.TitanAuth then return end
    local c = lp.Character
    if c and c:FindFirstChild("Humanoid") then
        c.Humanoid.WalkSpeed = _G.Config.WalkSpeed
        c.Humanoid.JumpPower = _G.Config.JumpPower
        if _G.Config.Fly then c.HumanoidRootPart.Velocity = Camera.CFrame.LookVector * _G.Config.FlySpeed end
        if _G.Config.Hitbox then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                    p.Character.HumanoidRootPart.Transparency = 0.7; p.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end
end)
