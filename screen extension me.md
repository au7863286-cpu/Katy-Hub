--[[  
FPS Boost+ & WOOjIE Hub
ttk: breaksstore / WOOjIE
]]--

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

print("WOOjIE Hub LocalScript iniciado")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WOOjIEHubPlus"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- زر فتح القائمة (اسم WOOjIE)
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0,75,0,36)
openButton.Position = UDim2.new(0,20,0.5,-18)
openButton.BackgroundColor3 = Color3.fromRGB(0, 180, 160)
openButton.TextColor3 = Color3.fromRGB(255,255,255)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14
openButton.Text = "WOOjIE"
openButton.Parent = screenGui
openButton.Draggable = true

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(0,8)
circleCorner.Parent = openButton

local shadow = Instance.new("UIStroke")
shadow.Color = Color3.fromRGB(255,255,255)
shadow.Thickness = 1
shadow.Transparency = 0.4
shadow.Parent = openButton

-- MAIN FRAME (ناحفة صغيرة وأنيقة)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,240,0,260)
mainFrame.Position = UDim2.new(0.5,-120,0.5,-130)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Visible = false
mainFrame.Parent = screenGui
mainFrame.Draggable = true
mainFrame.Active = true

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,14)
frameCorner.Parent = mainFrame

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(0, 180, 160)
border.Thickness = 1.5
border.Parent = mainFrame

-- ترويسة الواجهة (Extend screen & WOOjIE)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-90,0,35)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Text = "Extend screen & WOOjIE"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- زر الإغلاق (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,24,0,24)
closeBtn.Position = UDim2.new(1,-30,0,8)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)

-- زر علامة الاستفهام (?)
local helpInfoBtn = Instance.new("TextButton")
helpInfoBtn.Size = UDim2.new(0,24,0,24)
helpInfoBtn.Position = UDim2.new(1,-58,0,8)
helpInfoBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
helpInfoBtn.Text = "?"
helpInfoBtn.TextColor3 = Color3.fromRGB(255,255,255)
helpInfoBtn.Font = Enum.Font.GothamBold
helpInfoBtn.TextSize = 12
helpInfoBtn.Parent = mainFrame
Instance.new("UICorner", helpInfoBtn).CornerRadius = UDim.new(0,6)

-- زر الزائد (+)
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0,24,0,24)
plusBtn.Position = UDim2.new(1,-86,0,8)
plusBtn.BackgroundColor3 = Color3.fromRGB(0,140,255)
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.fromRGB(255,255,255)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 14
plusBtn.Parent = mainFrame
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0,6)

-- وظيفة إنشاء الأزرار داخل القائمة الرئيسية
local function createButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85,0,0,34)
    btn.Position = UDim2.new(0.075,0,0,yPos)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = mainFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,8)
    corner.Parent = btn
    return btn
end

-- الأزرار الرئيسية
local boostButton = createButton("Ativar FPS Boost", 45)
local stretchButton = createButton("Esticar Tela", 85)
local glowEffectBtn = createButton("Light Effect (Gradient)", 125)
local saveTpBtn = createButton("Salvar TP", 165)
local goTpBtn = createButton("Ir para TP", 205)

-- نافذة الحسابات المرتبطة بزر الزائد (+)
local accountsFrame = Instance.new("Frame")
accountsFrame.Size = UDim2.new(0,210,0,180)
accountsFrame.Position = UDim2.new(0.5,-105,0.5,-90)
accountsFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
accountsFrame.Visible = false
accountsFrame.Parent = screenGui
Instance.new("UICorner", accountsFrame).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", accountsFrame).Color = Color3.fromRGB(0,140,255)

local accTitle = Instance.new("TextLabel")
accTitle.Size = UDim2.new(1,0,0,30)
accTitle.BackgroundTransparency = 1
accTitle.Text = "WOOjIE Socials"
accTitle.TextColor3 = Color3.fromRGB(255,255,255)
accTitle.Font = Enum.Font.GothamBold
accTitle.TextSize = 14
accTitle.Parent = accountsFrame

local ytCopyBtn = Instance.new("TextButton")
ytCopyBtn.Size = UDim2.new(0.9,0,0,30)
ytCopyBtn.Position = UDim2.new(0.05,0,0,35)
ytCopyBtn.BackgroundColor3 = Color3.fromRGB(180,30,30)
ytCopyBtn.Text = "Copy YouTube (Copy)"
ytCopyBtn.TextColor3 = Color3.fromRGB(255,255,255)
ytCopyBtn.Font = Enum.Font.GothamBold
ytCopyBtn.TextSize = 12
ytCopyBtn.Parent = accountsFrame
Instance.new("UICorner", ytCopyBtn).CornerRadius = UDim.new(0,6)

local ttCopyBtn = Instance.new("TextButton")
ttCopyBtn.Size = UDim2.new(0.9,0,0,30)
ttCopyBtn.Position = UDim2.new(0.05,0,0,70)
ttCopyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
ttCopyBtn.Text = "Copy TikTok (Copy)"
ttCopyBtn.TextColor3 = Color3.fromRGB(255,255,255)
ttCopyBtn.Font = Enum.Font.GothamBold
ttCopyBtn.TextSize = 12
ttCopyBtn.Parent = accountsFrame
Instance.new("UICorner", ttCopyBtn).CornerRadius = UDim.new(0,6)

-- أزرار تحجيم النافذة (مستطيل ومربع) داخل نافذة الزائد
local rectShapeBtn = Instance.new("TextButton")
rectShapeBtn.Size = UDim2.new(0.42,0,0,30)
rectShapeBtn.Position = UDim2.new(0.05,0,0,105)
rectShapeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
rectShapeBtn.Text = "Small Rect"
rectShapeBtn.TextColor3 = Color3.fromRGB(255,255,255)
rectShapeBtn.Font = Enum.Font.GothamBold
rectShapeBtn.TextSize = 11
rectShapeBtn.Parent = accountsFrame
Instance.new("UICorner", rectShapeBtn).CornerRadius = UDim.new(0,6)

local squareShapeBtn = Instance.new("TextButton")
squareShapeBtn.Size = UDim2.new(0.42,0,0,30)
squareShapeBtn.Position = UDim2.new(0.53,0,0,105)
squareShapeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
squareShapeBtn.Text = "Square"
squareShapeBtn.TextColor3 = Color3.fromRGB(255,255,255)
squareShapeBtn.Font = Enum.Font.GothamBold
squareShapeBtn.TextSize = 11
squareShapeBtn.Parent = accountsFrame
Instance.new("UICorner", squareShapeBtn).CornerRadius = UDim.new(0,6)

-- زر إغلاق نافذة الحسابات
local closeAccBtn = Instance.new("TextButton")
closeAccBtn.Size = UDim2.new(0.9,0,0,24)
closeAccBtn.Position = UDim2.new(0.05,0,0,145)
closeAccBtn.BackgroundColor3 = Color3.fromRGB(100,20,20)
closeAccBtn.Text = "Close"
closeAccBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeAccBtn.Font = Enum.Font.GothamBold
closeAccBtn.TextSize = 11
closeAccBtn.Parent = accountsFrame
Instance.new("UICorner", closeAccBtn).CornerRadius = UDim.new(0,6)

-- نافذة علامة الاستفهام (?)
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0,210,0,120)
infoFrame.Position = UDim2.new(0.5,-105,0.5,-60)
infoFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
infoFrame.Visible = false
infoFrame.Parent = screenGui
Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", infoFrame).Color = Color3.fromRGB(255,255,255)

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(0.9,0,0,50)
infoText.Position = UDim2.new(0.05,0,0,10)
infoText.BackgroundTransparency = 1
infoText.Text = "Made by WOOjIE\nYouTube: @WOOjIE.10-O"
infoText.TextColor3 = Color3.fromRGB(255,255,255)
infoText.Font = Enum.Font.GothamBold
infoText.TextSize = 12
infoText.TextWrapped = true
infoText.Parent = infoFrame

local closeInfoBtn = Instance.new("TextButton")
closeInfoBtn.Size = UDim2.new(0.9,0,0,30)
closeInfoBtn.Position = UDim2.new(0.05,0,0,75)
closeInfoBtn.BackgroundColor3 = Color3.fromRGB(0,140,255)
closeInfoBtn.Text = "OK"
closeInfoBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeInfoBtn.Font = Enum.Font.GothamBold
closeInfoBtn.TextSize = 12
closeInfoBtn.Parent = infoFrame
Instance.new("UICorner", closeInfoBtn).CornerRadius = UDim.new(0,6)

-- الأحداث والوظائف (نسخ الروابط)
ytCopyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://www.youtube.com/@WOOjIE.10-O") end)
    StarterGui:SetCore("SendNotification", {Title = "WOOjIE", Text = "YouTube link copied!", Duration = 2})
end)

ttCopyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("tiktok.com/@yoo_ges7") end)
    StarterGui:SetCore("SendNotification", {Title = "WOOjIE", Text = "TikTok link copied!", Duration = 2})
end)

-- تحويل أشكال النافذة
rectShapeBtn.MouseButton1Click:Connect(function()
    mainFrame.Size = UDim2.new(0,240,0,260) -- مستطيل صغير
end)

squareShapeBtn.MouseButton1Click:Connect(function()
    mainFrame.Size = UDim2.new(0,240,0,240) -- مربع تقريباً
end)

-- فتح وإغلاق النوافذ الفرعية
plusBtn.MouseButton1Click:Connect(function()
    accountsFrame.Visible = not accountsFrame.Visible
    infoFrame.Visible = false
end)

closeAccBtn.MouseButton1Click:Connect(function()
    accountsFrame.Visible = false
end)

helpInfoBtn.MouseButton1Click:Connect(function()
    infoFrame.Visible = not infoFrame.Visible
    accountsFrame.Visible = false
end)

closeInfoBtn.MouseButton1Click:Connect(function()
    infoFrame.Visible = false
end)

-- وظيفة FPS Boost
boostButton.MouseButton1Click:Connect(function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(Players) then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") then
            obj.Enabled = false
        end
    end
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 1.5
    StarterGui:SetCore("SendNotification", {Title = "WOOjIE", Text = "FPS Boost Activated!", Duration = 2})
end)

-- وظيفة استطالة الشاشة (Stretch Screen)
local stretched = false
local stretchConnection
stretchButton.MouseButton1Click:Connect(function()
    local Camera = workspace.CurrentCamera
    if not stretched then
        stretchConnection = RunService.RenderStepped:Connect(function()
            Camera.CFrame = Camera.CFrame * CFrame.new(0,0,0, 1,0,0, 0,0.65,0, 0,0,1)
        end)
        stretched = true
        stretchButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    else
        if stretchConnection then stretchConnection:Disconnect() end
        stretched = false
        stretchButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
    end
end)

-- وظيفة اللون الخامس المتوهج والمتدرج تدريجياً (Color Changing Gradient Glow)
local glowActive = false
local colorConn
glowEffectBtn.MouseButton1Click:Connect(function()
    glowActive = not glowActive
    if glowActive then
        glowEffectBtn.BackgroundColor3 = Color3.fromRGB(150,0,255)
        local t = 0
        colorConn = RunService.RenderStepped:Connect(function(dt)
            t = (t + dt * 0.5) % 1
            border.Color = Color3.fromHSV(t, 1, 1)
        end)
    else
        if colorConn then colorConn:Disconnect() end
        glowEffectBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        border.Color = Color3.fromRGB(0, 180, 160)
    end
end)

-- نظام حفظ الانتقال (TP)
local savedCFrame
saveTpBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCFrame = char.HumanoidRootPart.CFrame
        StarterGui:SetCore("SendNotification", {Title = "WOOjIE", Text = "Position Saved!", Duration = 2})
    end
end)

goTpBtn.MouseButton1Click:Connect(function()
    if not savedCFrame then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = savedCFrame
    end
end)

-- فتح وإغلاق القائمة الرئيسية عبر زر WOOjIE
local open = false
openButton.MouseButton1Click:Connect(function()
    open = not open
    mainFrame.Visible = open
end)

closeBtn.MouseButton1Click:Connect(function()
    open = false
    mainFrame.Visible = false
    accountsFrame.Visible = false
    infoFrame.Visible = false
end)

print("WOOjIE Hub successfully initialized!")

