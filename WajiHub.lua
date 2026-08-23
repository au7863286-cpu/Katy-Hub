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
noteLabel.Size = UDim2.new(0, 320, 0, 25)
noteLabel.Position = UDim2.new(0.5, -160, 0.35, -135)
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

-- النافذة الرئيسية (عريضة وأفقية)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 440, 0, 260)
mainFrame.Position = UDim2.new(0.5, -220, 0.5, -130)
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

-- شريط الأقسام (Tabs Bar) العلوي داخل النافذة
local tabsBar = Instance.new("Frame", mainFrame)
tabsBar.Size = UDim2.new(1, -20, 0, 30)
tabsBar.Position = UDim2.new(0, 10, 0, 40)
tabsBar.BackgroundTransparency = 1

local tabsLayout = Instance.new("UIListLayout", tabsBar)
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Padding = UDim.new(0, 6)

-- حاوية محتوى الأقسام
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -20, 1, -85)
contentContainer.Position = UDim2.new(0, 10, 0, 75)
contentContainer.BackgroundTransparency = 1

-- إنشاء الأقسام
local function createTabContent()
    local page = Instance.new("ScrollingFrame", contentContainer)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 3
    
    local grid = Instance.new("UIGridLayout", page)
    grid.CellSize = UDim2.new(0, 95, 0, 45)
    grid.CellPadding = UDim2.new(0, 8, 0, 8)
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    return page
end

local tabMain = createTabContent()
local tabVisuals = createTabContent()
local tabCombat = createTabContent()
local tabExtra = createTabContent() -- تم تغيير اسم القسم من Scripts إلى Extra

tabMain.Visible = true -- القسم الافتراضي

local function createTabButton(name, targetPage, order)
    local btn = Instance.new("TextButton", tabsBar)
    btn.Size = UDim2.new(0, 95, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.Activated:Connect(function()
        tabMain.Visible = false
        tabVisuals.Visible = false
        tabCombat.Visible = false
        tabExtra.Visible = false
        
        for _, child in ipairs(tabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        
        targetPage.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 180, 130)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

local btnMainTab = createTabButton("Main", tabMain, 1)
btnMainTab.BackgroundColor3 = Color3.fromRGB(0, 180, 130)
btnMainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
createTabButton("Visuals", tabVisuals, 2)
createTabButton("Combat", tabCombat, 3)
createTabButton("Extra", tabExtra, 4) -- اسم القسم الجديد

local function createSquareButton(parent, text, bgColor, order)
    local btn = Instance.new("TextButton", parent)
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
-- توزيع الأزرار داخل الأقسام
---------------------------------------------------------
local speedBtn       = createSquareButton(tabMain, "Speed:\nON", Color3.fromRGB(0, 180, 130), 1)
local reducingLagBtn = createSquareButton(tabMain, "Reducing\nlag", Color3.fromRGB(45, 45, 45), 2)
local deleteLagBtn   = createSquareButton(tabMain, "Delete\nthe lag", Color3.fromRGB(45, 45, 45), 3)
local killBtn        = createSquareButton(tabMain, "Reset\nHP", Color3.fromRGB(220, 40, 40), 4)

local lightEffBtn    = createSquareButton(tabVisuals, "Light Effect\n[OFF]", Color3.fromRGB(45, 45, 45), 1)
local allColBtn      = createSquareButton(tabVisuals, "All Players\nColors [OFF]", Color3.fromRGB(45, 45, 45), 2)
local shadersBtn     = createSquareButton(tabVisuals, "Best\nShaders", Color3.fromRGB(45, 45, 45), 3)

local aimbot1Btn     = createSquareButton(tabCombat, "Aimbot", Color3.fromRGB(45, 45, 45), 1)
local aimbot2Btn     = createSquareButton(tabCombat, "Best\naimbot", Color3.fromRGB(45, 45, 45), 2)
local loopDashBtn    = createSquareButton(tabCombat, "Loop Dash", Color3.fromRGB(45, 45, 45), 3) -- الزر الجديد في Combat

local sideDashBtn    = createSquareButton(tabExtra, "Side Dash", Color3.fromRGB(45, 45, 45), 1)
local disciplineBtn  = createSquareButton(tabExtra, "Discipline", Color3.fromRGB(45, 45, 45), 2)
local emotesBtn      = createSquareButton(tabExtra, "Emotes", Color3.fromRGB(45, 45, 45), 3) -- زر التعبيرات الجديد
local script2Btn     = createSquareButton(tabExtra, "Feature\nScript", Color3.fromRGB(45, 45, 45), 4)

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

-- 2. زر Light Effect (مع 4 ألوان جديدة مضافة)
local script1Active = false
local lightEffectConnections = {}

lightEffBtn.Activated:Connect(function()
    script1Active = not script1Active
    if script1Active then
        lightEffBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        lightEffBtn.Text = "Light Effect\n[ON]"
        
        -- تدرج لوني مطور يشمل الألوان القديمة + 4 ألوان جديدة (Cyan, Deep Orange, Lime, Hot Magenta)
        local customGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.12, Color3.fromRGB(255, 0, 80)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 243, 255)), -- لون جديد 1
            ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255, 230, 0)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 110, 0)),  -- لون جديد 2
            ColorSequenceKeypoint.new(0.62, Color3.fromRGB(200, 0, 255)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 120)), -- لون جديد 3
            ColorSequenceKeypoint.new(0.88, Color3.fromRGB(0, 255, 60)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 170))  -- لون جديد 4
        })

        local function applyGradient(effect)
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

        local function monitorCharacter(character)
            for _, descendant in ipairs(character:GetDescendants()) do
                applyGradient(descendant)
            end
            local conn = character.DescendantAdded:Connect(function(descendant)
                applyGradient(descendant)
            end)
            table.insert(lightEffectConnections, conn)
        end

        if player.Character then
            monitorCharacter(player.Character)
        end

        local charConn = player.CharacterAdded:Connect(function(character)
            monitorCharacter(character)
        end)
        table.insert(lightEffectConnections, charConn)
        
    else
        lightEffBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        lightEffBtn.Text = "Light Effect\n[OFF]"
        
        for _, conn in ipairs(lightEffectConnections) do
            conn:Disconnect()
        end
        lightEffectConnections = {}
    end
end)

-- 3. زر All Players Colors (مع 4 ألوان جديدة مضافة للقائمة)
local script2Active = false
local colorCycleConnections = {}
local activeEffects = {}

allColBtn.Activated:Connect(function()
    script2Active = not script2Active
    if script2Active then
        allColBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        allColBtn.Text = "All Players\nColors [ON]"
        
        -- تم دمج 4 ألوان إضافية جديدة (إجمالي 12 لوناً)
        local colors = {
            Color3.fromRGB(125, 249, 255),
            Color3.fromRGB(0, 128, 255),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 95, 31),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 105, 180),
            Color3.fromRGB(255, 16, 240),
            Color3.fromRGB(0, 255, 255), -- لون جديد 1 (Cyan)
            Color3.fromRGB(255, 140, 0),  -- لون جديد 2 (Dark Orange)
            Color3.fromRGB(127, 255, 0),  -- لون جديد 3 (Chartreuse)
            Color3.fromRGB(255, 20, 147)  -- لون جديد 4 (Deep Pink)
        }

        local fadeTransparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.0, 0.0),
            NumberSequenceKeypoint.new(0.5, 0.3),
            NumberSequenceKeypoint.new(1.0, 1.0)
        })

        local function addEffect(effect)
            if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam") then
                table.insert(activeEffects, effect)
                effect.Transparency = fadeTransparency
                effect.LightEmission = 0.85
                effect.Color = ColorSequence.new(colors[1])
            elseif effect:IsA("Highlight") then
                table.insert(activeEffects, effect)
                effect.FillColor = Color3.fromRGB(255, 255, 255)
                effect.OutlineColor = colors[1]
            end
        end

        local function removeEffect(effect)
            for i, ef in ipairs(activeEffects) do
                if ef == effect then
                    table.remove(activeEffects, i)
                    break
                end
            end
        end

        local function monitorCharacter(character)
            for _, descendant in ipairs(character:GetDescendants()) do
                addEffect(descendant)
            end
            local conn1 = character.DescendantAdded:Connect(function(descendant)
                addEffect(descendant)
            end)
            local conn2 = character.DescendantRemoving:Connect(function(descendant)
                removeEffect(descendant)
            end)
            table.insert(colorCycleConnections, conn1)
            table.insert(colorCycleConnections, conn2)
        end

        if player.Character then
            monitorCharacter(player.Character)
        end

        local charConn = player.CharacterAdded:Connect(function(character)
            activeEffects = {}
            monitorCharacter(character)
        end)
        table.insert(colorCycleConnections, charConn)

        local currentIndex = 1
        local timer = 0
        local switchInterval = 0.4

        local heartbeatConn = RunService.Heartbeat:Connect(function(deltaTime)
            if not script2Active then return end
            timer = timer + deltaTime
            
            if timer >= switchInterval then
                timer = 0
                currentIndex = (currentIndex % #colors) + 1
                local nextColor = colors[currentIndex]
                
                for _, effect in ipairs(activeEffects) do
                    pcall(function()
                        if effect and effect.Parent then
                            if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam") then
                                effect.Color = ColorSequence.new(nextColor)
                            elseif effect:IsA("Highlight") then
                                effect.OutlineColor = nextColor
                            end
                        else
                            removeEffect(effect)
                        end
                    end)
                end
            end
        end)
        table.insert(colorCycleConnections, heartbeatConn)
        
    else
        allColBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        allColBtn.Text = "All Players\nColors [OFF]"
        
        for _, conn in ipairs(colorCycleConnections) do
            conn:Disconnect()
        end
        colorCycleConnections = {}
        activeEffects = {}
    end
end)

-- تشغيل السكريبتات
sideDashBtn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/54d6b993fe3a4c1f5c3e375eba35e5ec.lua"))() end)
end)

disciplineBtn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))("Spider Script") end)
end)

loopDashBtn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longv7217-commits/rayfield/refs/heads/main/Loopdash%20v2"))() end)
end)

emotesBtn.Activated:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/EmoteGui/refs/heads/main/Protected_4900496055951847.lua"))() end)
end)

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
    freezeCharacter(false)
    mainFrame.Visible = false
    noteLabel.Visible = false
    openBtn.Visible = true
end)

openBtn.Activated:Connect(function()
    mainFrame.Visible = true
    noteLabel.Visible = true
    openBtn.Visible = false
end)

print("Waji Hub Fully Loaded Successfully with New Scripts, Custom Emotes, and Extra Colors!")
