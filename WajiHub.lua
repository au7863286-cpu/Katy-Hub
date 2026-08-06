-- Waji Hub - Ultimate Edition (Integrated with TSB Color & Light Effects)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إزالة أي نسخة قديمة لتجنب التكرار
if playerGui:FindFirstChild("WajiHubGui") then
    playerGui.WajiHubGui:Destroy()
end

-- منع الشخصية من الحركة نهائياً عند التشغيل لأول مرة
local function freezeCharacter(enable)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if enable then
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
                humanoid.AutoRotate = false
            else
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
                humanoid.AutoRotate = true
            end
        end
    end
end
freezeCharacter(true)

-- إنشاء الشاشة الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WajiHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- الملاحظة فوق النافذة باللغة الإنجليزية
local noteLabel = Instance.new("TextLabel")
noteLabel.Name = "NoteLabel"
noteLabel.Parent = screenGui
noteLabel.Size = UDim2.new(0, 260, 0, 25)
noteLabel.Position = UDim2.new(0.5, -130, 0.35, -165)
noteLabel.BackgroundTransparency = 1
noteLabel.Text = "Enable the first button with the second and it will give a cool shape"
noteLabel.TextColor3 = Color3.fromRGB(255, 230, 0)
noteLabel.TextSize = 10
noteLabel.Font = Enum.Font.GothamBold
noteLabel.TextWrapped = true
noteLabel.ZIndex = 5

-- زر فتح الواجهة (Waji) - قابل للتحريك
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Parent = screenGui
openBtn.Size = UDim2.new(0, 60, 0, 32)
openBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
openBtn.Text = "Waji"
openBtn.TextColor3 = Color3.fromRGB(0, 180, 130)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 14
openBtn.Visible = false
openBtn.ZIndex = 10
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)

-- نظام سحب زر Waji
local openDragging, openDragInput, openDragStart, openStartPos
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        openDragging = true
        openDragStart = input.Position
        openStartPos = openBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                openDragging = false
            end
        end)
    end
end)

openBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        openDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == openDragInput and openDragging then
        local delta = input.Position - openDragStart
        openBtn.Position = UDim2.new(openStartPos.X.Scale, openStartPos.X.Offset + delta.X, openStartPos.Y.Scale, openStartPos.Y.Offset + delta.Y)
    end
end)

-- النافذة الرئيسية
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 330) -- زيادة الطول لتستوعب الأزرار الجديدة
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -165)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 1
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- شريط العنوان العلوي
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundTransparency = 1
titleBar.ZIndex = 2

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -45, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Waji Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

-- زر الإغلاق الأحمر (X)
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.ZIndex = 5
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- نظام سحب ناعم للنافذة الرئيسية
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- حاوية الأزرار المربعة
local gridContainer = Instance.new("Frame", mainFrame)
gridContainer.Size = UDim2.new(1, -20, 1, -50)
gridContainer.Position = UDim2.new(0, 10, 0, 42)
gridContainer.BackgroundTransparency = 1

local gridLayout = Instance.new("UIGridLayout", gridContainer)
gridLayout.CellSize = UDim2.new(0, 70, 0, 50)
gridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createSquareButton(text, bgColor, order)
    local btn = Instance.new("TextButton", gridContainer)
    btn.BackgroundColor3 = bgColor or Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.TextWrapped = true
    btn.LayoutOrder = order
    btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

---------------------------------------------------------
-- إنشاء الأزرار (شاملة أزرار الألوان والـ Scripts الجديدة)
---------------------------------------------------------
local speedBtn       = createSquareButton("Speed:\nON", Color3.fromRGB(0, 180, 130), 1)
local lightEffBtn    = createSquareButton("Light Effect\n[OFF]", Color3.fromRGB(45, 45, 45), 2)
local allColBtn      = createSquareButton("All Players\nColors [OFF]", Color3.fromRGB(45, 45, 45), 3)
local aimbot1Btn     = createSquareButton("Aimbot", Color3.fromRGB(45, 45, 45), 4)
local aimbot2Btn     = createSquareButton("Best\naimbot", Color3.fromRGB(45, 45, 45), 5)
local shadersBtn     = createSquareButton("Best\nShaders", Color3.fromRGB(45, 45, 45), 6)
local reducingLagBtn = createSquareButton("Reducing\nlag", Color3.fromRGB(45, 45, 45), 7)
local deleteLagBtn   = createSquareButton("Delete\nthe lag", Color3.fromRGB(45, 45, 45), 8)
local script1Btn     = createSquareButton("Utility\nScript", Color3.fromRGB(45, 45, 45), 9)
local script2Btn     = createSquareButton("Feature\nScript", Color3.fromRGB(45, 45, 45), 10)
local killBtn        = createSquareButton("Reset\nHP", Color3.fromRGB(220, 40, 40), 11)

---------------------------------------------------------
-- برمجة الأزرار
---------------------------------------------------------

-- 1. زر السرعة
local isSpeedActive = true
speedBtn.Activated:Connect(function()
    isSpeedActive = not isSpeedActive
    if isSpeedActive then
        speedBtn.Text = "Speed:\nON"
        speedBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 130)
    else
        speedBtn.Text = "Speed:\nOFF"
        speedBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if isSpeedActive and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 25
    end
end)

-- 2. زر Light Effect (الزر الأول المدمج بنظام التشغيل والإيقاف)
local script1Active = false
lightEffBtn.Activated:Connect(function()
    script1Active = not script1Active
    if script1Active then
        lightEffBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        lightEffBtn.Text = "Light Effect\n[ON]"
        
        local customGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 0, 80)),
            ColorSequenceKeypoint.new(0.40, Color3.fromRGB(255, 230, 0)),
            ColorSequenceKeypoint.new(0.65, Color3.fromRGB(200, 0, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 60))
        })

        local function applyGradient(effect)
            if script1Active then
                if effect:IsA("ParticleEmitter") then
                    effect.Color = customGradient
                    effect.LightEmission = 1.0
                elseif effect:IsA("Trail") then
                    effect.Color = customGradient
                elseif effect:IsA("Beam") then
                    effect.Color = customGradient
                elseif effect:IsA("Highlight") then
                    effect.FillColor = Color3.fromRGB(255, 255, 255)
                    effect.OutlineColor = Color3.fromRGB(200, 0, 255)
                end
            end
        end

        local function monitorInstance(parent)
            for _, descendant in ipairs(parent:GetDescendants()) do
                applyGradient(descendant)
            end
            parent.DescendantAdded:Connect(function(descendant)
                applyGradient(descendant)
            end)
        end

        monitorInstance(workspace)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                monitorInstance(p.Character)
            end
            p.CharacterAdded:Connect(function(char)
                monitorInstance(char)
            end)
        end
    else
        lightEffBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        lightEffBtn.Text = "Light Effect\n[OFF]"
    end
end)

-- 3. زر All Players Colors (الزر الثاني المدمج بنظام التشغيل والإيقاف)
local script2Active = false
allColBtn.Activated:Connect(function()
    script2Active = not script2Active
    if script2Active then
        allColBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        allColBtn.Text = "All Players\nColors [ON]"
        
        local colors = {
            Color3.fromRGB(125, 249, 255),
            Color3.fromRGB(0, 128, 255),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 95, 31),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 105, 180),
            Color3.fromRGB(255, 16, 240)
        }

        local fadeTransparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.0, 0.0),
            NumberSequenceKeypoint.new(0.5, 0.3),
            NumberSequenceKeypoint.new(1.0, 1.0)
        })

        local function applyEffect(effect)
            if script2Active then
                if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam") then
                    effect.Transparency = fadeTransparency
                    effect.LightEmission = 0.85
                elseif effect:IsA("Highlight") then
                    effect.FillColor = Color3.fromRGB(255, 255, 255)
                    effect.OutlineColor = colors[1]
                end
            end
        end

        local function monitorInstance2(parent)
            pcall(function()
                for _, descendant in ipairs(parent:GetDescendants()) do
                    applyEffect(descendant)
                end
                parent.DescendantAdded:Connect(function(descendant)
                    applyEffect(descendant)
                end)
            end)
        end

        monitorInstance2(workspace)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                monitorInstance2(p.Character)
            end
            p.CharacterAdded:Connect(function(char)
                monitorInstance2(char)
            end)
        end

        task.spawn(function()
            local currentIndex = 1
            while script2Active do
                task.wait(0.4)
                currentIndex = (currentIndex % #colors) + 1
                local nextColor = colors[currentIndex]
                
                pcall(function()
                    if not script2Active then return end
                    for _, descendant in ipairs(workspace:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") then
                            descendant.Color = ColorSequence.new(nextColor)
                        elseif descendant:IsA("Highlight") then
                            descendant.OutlineColor = nextColor
                        end
                    end
                    
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p.Character then
                            for _, descendant in ipairs(p.Character:GetDescendants()) do
                                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") then
                                    descendant.Color = ColorSequence.new(nextColor)
                                elseif descendant:IsA("Highlight") then
                                    descendant.OutlineColor = nextColor
                                end
                            end
                        end
                    end
                end)
            end
        end)
    else
        allColBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        allColBtn.Text = "All Players\nColors [OFF]"
    end
end)

-- أزرار الهكر المتبقية
aimbot1Btn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/E7HYaqgD", true))() end)
end)

aimbot2Btn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Mark22028-2ndAcc/Scripts/refs/heads/main/OPCamlock.lua"))() end)
end)

shadersBtn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/RTX%20Gui%20Hub%20Obfuscator'))() end)
end)

reducingLagBtn.Activated:Connect(function()
    pcall(function()
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.Brightness = 2
        lighting.FogEnd = 999999
    end)
end)

deleteLagBtn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/marianscriptKing/SUPER-MAX.lau/main/SUPER%20MAX%20PERFORMANCE"))() end)
end)

script1Btn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/23bcf4264b586dc93b16a9b054eddae259938b7421ac5096353079b2e9d74e24.lua"))() end)
end)

script2Btn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/cc456703616921dda82cf9389d4f2782c17785c0ee7da6fa7903d92ae88fb167.lua"))() end)
end)

killBtn.Activated:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end)

-- أزرار الإغلاق والفتح وإلغاء التجميد
closeBtn.Activated:Connect(function()
    freezeCharacter(false) -- فك تجميد الحركة عند الإغلاق
    mainFrame.Visible = false
    noteLabel.Visible = false
    openBtn.Visible = true
end)

openBtn.Activated:Connect(function()
    mainFrame.Visible = true
    noteLabel.Visible = true
    openBtn.Visible = false
end)

print("Waji Hub Fully Loaded Successfully with TSB Color Effects!")

