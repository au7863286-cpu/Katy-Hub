local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CamlockEnabled = false
local CamlockToggle = true
local CamlockTarget = nil
local CamlockKey = "c"

getgenv().Key = CamlockKey

local function FindNearestEnemy()
    local closestDistance = math.huge
    local screenCenter = Vector2.new(
        game:GetService("GuiService"):GetScreenResolution().X / 2,
        game:GetService("GuiService"):GetScreenResolution().Y / 2
    )
    local nearestTarget = nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character.Humanoid.Health > 0 then
                local screenPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(character.HumanoidRootPart.Position)
                if onScreen then
                    local distance = (screenCenter - Vector2.new(screenPosition.X, screenPosition.Y)).Magnitude
                    if distance < closestDistance then
                        nearestTarget = character.HumanoidRootPart
                        closestDistance = distance
                    end
                end
            end
        end
    end

    local liveFolder = workspace:FindFirstChild("Live")
    if liveFolder then
        local dummy = liveFolder:FindFirstChild("Weakest Dummy")
        if dummy and dummy:FindFirstChild("HumanoidRootPart") then
            local screenPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(dummy.HumanoidRootPart.Position)
            if onScreen and (screenCenter - Vector2.new(screenPosition.X, screenPosition.Y)).Magnitude < closestDistance then
                nearestTarget = dummy.HumanoidRootPart
            end
        end
    end

    return nearestTarget
end

-- تشغيل الـ Camlock (بدون تنبؤ)
RunService.Heartbeat:Connect(function()
    if CamlockEnabled and CamlockTarget then
        local camera = workspace.CurrentCamera
        camera.CFrame = CFrame.new(camera.CFrame.Position, CamlockTarget.Position)
    end
end)

Mouse.KeyDown:Connect(function(key)
    if key == getgenv().Key then
        CamlockToggle = not CamlockToggle
        if CamlockToggle then
            CamlockTarget = FindNearestEnemy()
            CamlockEnabled = true
        elseif CamlockTarget ~= nil then
            CamlockTarget = nil
            CamlockEnabled = false
        end
    end
end)

local CamlockGui = Instance.new("ScreenGui")
CamlockGui.Name = "RandomParentName"
CamlockGui.Parent = game.CoreGui

local CamlockFrame = Instance.new("Frame")
local CamlockCorner = Instance.new("UICorner")
local CamlockButton = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")

-- تكبير حجم الإطار قليلاً
CamlockFrame.Parent = CamlockGui
CamlockFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 25)
CamlockFrame.BackgroundTransparency = 0.3
CamlockFrame.BorderSizePixel = 0
CamlockFrame.Size = UDim2.new(0, 130, 0, 50)
CamlockFrame.Active = true
CamlockFrame.Draggable = true

local function CenterCamlockFrame()
    CamlockFrame.Position = UDim2.new(0.63, -CamlockFrame.AbsoluteSize.X / 2, 0.2, -CamlockFrame.AbsoluteSize.Y / 2)
end
CenterCamlockFrame()
CamlockFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(CenterCamlockFrame)

CamlockCorner.CornerRadius = UDim.new(0, 8)
CamlockCorner.Parent = CamlockFrame

-- تكبير حجم الزر قليلاً ليناسب الزيادة
CamlockButton.Parent = CamlockFrame
CamlockButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
CamlockButton.BackgroundTransparency = 0.25
CamlockButton.BorderSizePixel = 0
CamlockButton.Position = UDim2.new(0.05, 0, 0.15, 0)
CamlockButton.Size = UDim2.new(0, 117, 0, 35)
CamlockButton.Font = Enum.Font.GothamBold
CamlockButton.Text = "FPS: 0"
CamlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CamlockButton.TextScaled = true
CamlockButton.TextWrapped = true

ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = CamlockButton

-- تحديث الـ FPS باستمرار داخل الزر
local lastTick = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTick = tick()
    if currentTick - lastTick >= 1 then
        local fps = math.floor(frameCount / (currentTick - lastTick) + 0.5)
        CamlockButton.Text = "FPS: " .. tostring(fps)
        frameCount = 0
        lastTick = currentTick
    end
end)

local CamlockState = true
CamlockButton.MouseButton1Click:Connect(function()
    CamlockState = not CamlockState
    if CamlockState then
        CamlockButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        CamlockEnabled = false
        CamlockTarget = nil
    else
        CamlockButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        CamlockEnabled = true
        CamlockTarget = FindNearestEnemy()
    end
end)

StarterGui:SetCore("SendNotification", {
    Title = "Camlock Loaded",
    Text = "FPS counter applied & prediction removed!",
    Duration = 3
})

