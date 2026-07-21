-- اختبار السرعة المباشر لـ Waji Hub مع زر تحكم متحرك
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- إنشاء واجهة الزر الصغير
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "WajiSpeedGui"
screenGui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 90, 0, 40)
toggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 130) -- أخضر بالبداية (ON)
toggleBtn.Text = "Speed: ON"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Active = true

local corner = Instance.new("UICorner", toggleBtn)
corner.CornerRadius = UDim.new(0, 10)

-- جعل الزر قابلاً للتحريك في الشاشة
local dragging, dragStart, startPos
toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- حالة التشغيل والإيقاف عند النقر على الزر
local isSpeedActive = true
toggleBtn.MouseButton1Click:Connect(function()
    isSpeedActive = not isSpeedActive
    if isSpeedActive then
        toggleBtn.Text = "Speed: ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 130) -- أخضر
    else
        toggleBtn.Text = "Speed: OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40) -- أحمر
    end
end)

-- تطبيق السرعة المباشر
RunService.RenderStepped:Connect(function()
    if isSpeedActive and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 25
    end
end)

