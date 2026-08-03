-- Waji Hub - Fixed Grid & Touch Edition (Updated with Custom Lag Buttons & Movable Open Button)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إزالة أي نسخة قديمة لتجنب التكرار
if playerGui:FindFirstChild("WajiHubGui") then
    playerGui.WajiHubGui:Destroy()
end

-- إنشاء الشاشة الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WajiHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- زر فتح الواجهة (Waji) - أصبح قابلاً للتحريك (سحب وإفلات)
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

-- نظام سحب زر Waji (سحب وإفلات للهواتف والكمبيوتر)
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

-- النافذة الرئيسية (تم زيادة عرضها قليلاً لتستوعب الأزرار الإضافية بشكل مرتب)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 290)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -145)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 1
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- شريط العنوان العلوي (مخصص للسحب فقط دون تعطيل الأزرار)
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

-- نظام سحب ناعم للنافذة الرئيسية يعتمد على شريط العنوان فقط
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

-- حاوية الأزرار المربعة (مقسمة كشبكة مدمجة)
local gridContainer = Instance.new("Frame", mainFrame)
gridContainer.Size = UDim2.new(1, -20, 1, -50)
gridContainer.Position = UDim2.new(0, 10, 0, 42)
gridContainer.BackgroundTransparency = 1

local gridLayout = Instance.new("UIGridLayout", gridContainer)
gridLayout.CellSize = UDim2.new(0, 70, 0, 50) -- أزرار مربعة مدمجة
gridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- دالة إنشاء الأزرار المربعة
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
-- إنشاء الأزرار بترتيب منظم ومربع (شاملة الأزرار الجديدة)
---------------------------------------------------------
local speedBtn       = createSquareButton("Speed:\nON", Color3.fromRGB(0, 180, 130), 1)
local aimbot1Btn     = createSquareButton("Aimbot", Color3.fromRGB(45, 45, 45), 2)
local aimbot2Btn     = createSquareButton("Best\naimbot", Color3.fromRGB(45, 45, 45), 3)
local shadersBtn     = createSquareButton("Best\nShaders", Color3.fromRGB(45, 45, 45), 4)
local reducingLagBtn = createSquareButton("Reducing\nlag", Color3.fromRGB(45, 45, 45), 5)
local deleteLagBtn   = createSquareButton("Delete\nthe lag", Color3.fromRGB(45, 45, 45), 6)
local script1Btn     = createSquareButton("Utility\nScript", Color3.fromRGB(45, 45, 45), 7)
local script2Btn     = createSquareButton("Feature\nScript", Color3.fromRGB(45, 45, 45), 8)
local killBtn        = createSquareButton("Reset\nHP", Color3.fromRGB(220, 40, 40), 9)

---------------------------------------------------------
-- برمجة تشغيل الأزرار عبر حدث Activated (للهواتف والكمبيوتر)
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

-- 2. زر Aimbot
aimbot1Btn.Activated:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/E7HYaqgD", true))()
    end)
end)

-- 3. زر Best aimbot
aimbot2Btn.Activated:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mark22028-2ndAcc/Scripts/refs/heads/main/OPCamlock.lua"))()
    end)
end)

-- 4. زر Best Shaders (الرابط المُحدث والمصحح)
shadersBtn.Activated:Connect(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/RTX%20Gui%20Hub%20Obfuscator'))()
    end)
end)

-- 5. زر Reducing lag (تخفيف الإضاءة والظلال بدون مسح الماپ)
reducingLagBtn.Activated:Connect(function()
    pcall(function()
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.Brightness = 2
        lighting.FogEnd = 999999
    end)
end)

-- 6. زر Delete the lag (سكربت الأداء القوي الجديد)
deleteLagBtn.Activated:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/marianscriptKing/SUPER-MAX.lau/main/SUPER%20MAX%20PERFORMANCE"))()
    end)
end)

-- 7. زر Utility Script
script1Btn.Activated:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/23bcf4264b586dc93b16a9b054eddae259938b7421ac5096353079b2e9d74e24.lua"))()
    end)
end)

-- 8. زر Feature Script
script2Btn.Activated:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/cc456703616921dda82cf9389d4f2782c17785c0ee7da6fa7903d92ae88fb167.lua"))()
    end)
end)

-- 9. زر Reset HP (زر الموت)
killBtn.Activated:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end)

---------------------------------------------------------
-- أزرار الإغلاق والفتح (مع دعم تحريك زر Waji)
---------------------------------------------------------
closeBtn.Activated:Connect(function()
    mainFrame.Visible = false
    openBtn.Visible = true
end)

openBtn.Activated:Connect(function()
    mainFrame.Visible = true
    openBtn.Visible = false
end)

print("Waji Hub Loaded Successfully!")

