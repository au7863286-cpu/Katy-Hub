-- WOOjIE $ kyoto Script (UI Upgraded to Katy/WOOjIE Style ✨)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local AutoKyotoButton = Instance.new("TextButton")
local ToggleInfoButton = Instance.new("TextButton")
local ToggleCreditButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local LockButton = Instance.new("TextButton")

-- Compact Minimized Bar Elements
local MinimizedFrame = Instance.new("Frame")
local MinimizedKyotoBtn = Instance.new("TextButton")
local MinimizedMoveBtn = Instance.new("TextButton")
local MinimizedRestoreBtn = Instance.new("TextButton")

-- Info Panel
local InfoFrame = Instance.new("Frame")
local CloseInfoButton = Instance.new("TextButton")
local StatsLabel = Instance.new("TextLabel")
local TikTokButton = Instance.new("TextButton")
local YouTubeButton = Instance.new("TextButton")

-- Sizers, Colors, and Moving toggle buttons
local SquareSizeButton = Instance.new("TextButton")
local RectSizeButton = Instance.new("TextButton")
local OpenColorsButton = Instance.new("TextButton")
local ToggleMovingButton = Instance.new("TextButton")

-- Colors Panel
local ColorsFrame = Instance.new("Frame")
local CloseColorsButton = Instance.new("TextButton")
local ColorsTitle = Instance.new("TextLabel")
local ColorBtn1 = Instance.new("TextButton")
local ColorBtn2 = Instance.new("TextButton")
local ColorBtn3 = Instance.new("TextButton")
local ColorBtn4 = Instance.new("TextButton")
local ColorBtn5 = Instance.new("TextButton")

-- Credit Panel
local CreditFrame = Instance.new("Frame")
local CreditLabel = Instance.new("TextLabel")
local CloseCreditButton = Instance.new("TextButton")

-- Progress Bar Elements
local ProgressBarBackground = Instance.new("Frame")
local ProgressBarFill = Instance.new("Frame")

local plr = game.Players.LocalPlayer
local UserPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SetClipboard = setclipboard or toclipboard or syn and syn.set_clipboard

-- Define the teleport distance
local teleportDistance = 18.42

local function teleportForward()
    local chr = plr.Character
    if not chr then return end
    local humanoidRootPart = chr:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local forwardDirection = humanoidRootPart.CFrame.LookVector
        local newPosition = humanoidRootPart.Position + forwardDirection * teleportDistance
        humanoidRootPart.CFrame = CFrame.new(newPosition)
    end
end

ScreenGui.Parent = plr:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- --- دالة مساعدة لتطبيق الحواف والحدود الأنيقة ---
local function applyStyle(parent, cornerRadius, strokeColor)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, cornerRadius or 12)
    corner.Parent = parent
    
    if strokeColor then
        local stroke = Instance.new("UIStroke")
        stroke.Color = strokeColor
        stroke.Thickness = 1.2
        stroke.Parent = parent
    end
end

-- MainFrame (شفاف وبشكل عصري)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Size = UDim2.new(0, 220, 0, 115)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -57)
MainFrame.Active = true
MainFrame.Draggable = true
applyStyle(MainFrame, 14, Color3.fromRGB(0, 180, 160))

-- Title Banner
TitleLabel.Parent = MainFrame
TitleLabel.Text = "WOOjIE $ kyoto"
TitleLabel.Size = UDim2.new(1, -100, 0, 28)
TitleLabel.Position = UDim2.new(0, 8, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Lock Button
local isLocked = false
LockButton.Parent = MainFrame
LockButton.Text = "[ ]"
LockButton.Size = UDim2.new(0, 22, 0, 22)
LockButton.Position = UDim2.new(1, -28, 0, 8)
LockButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LockButton.Font = Enum.Font.GothamBold
LockButton.TextSize = 11
applyStyle(LockButton, 6)

LockButton.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    MainFrame.Draggable = not isLocked
    if isLocked then
        LockButton.Text = "[X]"
        LockButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    else
        LockButton.Text = "[ ]"
        LockButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    end
end)

-- Plus Button (+)
ToggleInfoButton.Parent = MainFrame
ToggleInfoButton.Text = "+"
ToggleInfoButton.Size = UDim2.new(0, 22, 0, 22)
ToggleInfoButton.Position = UDim2.new(1, -54, 0, 8)
ToggleInfoButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
ToggleInfoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleInfoButton.Font = Enum.Font.GothamBold
ToggleInfoButton.TextSize = 12
applyStyle(ToggleInfoButton, 6)

-- Question Button (?)
ToggleCreditButton.Parent = MainFrame
ToggleCreditButton.Text = "?"
ToggleCreditButton.Size = UDim2.new(0, 22, 0, 22)
ToggleCreditButton.Position = UDim2.new(1, -80, 0, 8)
ToggleCreditButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
ToggleCreditButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleCreditButton.Font = Enum.Font.GothamBold
ToggleCreditButton.TextSize = 12
applyStyle(ToggleCreditButton, 6)

-- Minimize Button (_)
MinimizeButton.Parent = MainFrame
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 22, 0, 22)
MinimizeButton.Position = UDim2.new(1, -106, 0, 8)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 12
applyStyle(MinimizeButton, 6)

-- Minimized Frame
MinimizedFrame.Parent = ScreenGui
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MinimizedFrame.BackgroundTransparency = 0.15
MinimizedFrame.Size = UDim2.new(0, 185, 0, 38)
MinimizedFrame.Position = MainFrame.Position
MinimizedFrame.Visible = false
MinimizedFrame.Active = true
MinimizedFrame.Draggable = false
applyStyle(MinimizedFrame, 12, Color3.fromRGB(0, 180, 160))

MinimizedKyotoBtn.Parent = MinimizedFrame
MinimizedKyotoBtn.Text = "Kyoto"
MinimizedKyotoBtn.Size = UDim2.new(0.42, 0, 0.75, 0)
MinimizedKyotoBtn.Position = UDim2.new(0, 6, 0.12, 0)
MinimizedKyotoBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
MinimizedKyotoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedKyotoBtn.Font = Enum.Font.GothamBold
MinimizedKyotoBtn.TextSize = 12
applyStyle(MinimizedKyotoBtn, 8)

MinimizedMoveBtn.Parent = MinimizedFrame
MinimizedMoveBtn.Text = "^"
MinimizedMoveBtn.Size = UDim2.new(0.24, 0, 0.75, 0)
MinimizedMoveBtn.Position = UDim2.new(0.45, 0, 0.12, 0)
MinimizedMoveBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
MinimizedMoveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedMoveBtn.Font = Enum.Font.GothamBold
MinimizedMoveBtn.TextSize = 12
applyStyle(MinimizedMoveBtn, 8)

local isMinimizedMoving = false
local dragStartPos, startFramePos

MinimizedMoveBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isMinimizedMoving = true
        dragStartPos = input.Position
        startFramePos = MinimizedFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isMinimizedMoving and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        MinimizedFrame.Position = UDim2.new(
            startFramePos.X.Scale, 
            startFramePos.X.Offset + delta.X, 
            startFramePos.Y.Scale, 
            startFramePos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isMinimizedMoving = false
    end
end)

MinimizedRestoreBtn.Parent = MinimizedFrame
MinimizedRestoreBtn.Text = "[*]"
MinimizedRestoreBtn.Size = UDim2.new(0.25, 0, 0.75, 0)
MinimizedRestoreBtn.Position = UDim2.new(0.72, 0, 0.12, 0)
MinimizedRestoreBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 90)
MinimizedRestoreBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
MinimizedRestoreBtn.Font = Enum.Font.GothamBold
MinimizedRestoreBtn.TextSize = 12
applyStyle(MinimizedRestoreBtn, 8)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    InfoFrame.Visible = false
    CreditFrame.Visible = false
    ColorsFrame.Visible = false
    MinimizedFrame.Position = MainFrame.Position
    MinimizedFrame.Visible = true
end)

MinimizedRestoreBtn.MouseButton1Click:Connect(function()
    MainFrame.Position = MinimizedFrame.Position
    MainFrame.Visible = true
    MinimizedFrame.Visible = false
end)

local runComboRef = nil
MinimizedKyotoBtn.MouseButton1Click:Connect(function()
    if runComboRef then runComboRef() end
end)

-- Info Frame
InfoFrame.Parent = ScreenGui
InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
InfoFrame.BackgroundTransparency = 0.15
InfoFrame.Size = UDim2.new(0, 200, 0, 245)
InfoFrame.Position = UDim2.new(0.5, 115, 0.5, -122)
InfoFrame.Visible = false
InfoFrame.Active = true
InfoFrame.Draggable = false
applyStyle(InfoFrame, 12, Color3.fromRGB(0, 140, 255))

CloseInfoButton.Parent = InfoFrame
CloseInfoButton.Text = "X"
CloseInfoButton.Size = UDim2.new(0, 22, 0, 22)
CloseInfoButton.Position = UDim2.new(1, -26, 0, 6)
CloseInfoButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseInfoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseInfoButton.Font = Enum.Font.GothamBold
CloseInfoButton.TextSize = 11
applyStyle(CloseInfoButton, 6)

StatsLabel.Parent = InfoFrame
StatsLabel.Size = UDim2.new(1, -30, 0, 30)
StatsLabel.Position = UDim2.new(0, 10, 0, 6)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatsLabel.Font = Enum.Font.GothamBold
StatsLabel.TextSize = 12
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.Text = "Loading Stats..."

-- TikTok Button
TikTokButton.Parent = InfoFrame
TikTokButton.Text = "TikTok: @yoo_ges7"
TikTokButton.Size = UDim2.new(0.9, 0, 0, 28)
TikTokButton.Position = UDim2.new(0.05, 0, 0, 42)
TikTokButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TikTokButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TikTokButton.Font = Enum.Font.GothamBold
TikTokButton.TextSize = 12
applyStyle(TikTokButton, 8)

TikTokButton.MouseButton1Click:Connect(function()
    if SetClipboard then
        SetClipboard("https://www.tiktok.com/@yoo_ges7")
        TikTokButton.Text = "Copied TikTok!"
        task.wait(1.5)
        TikTokButton.Text = "TikTok: @yoo_ges7"
    end
end)

-- YouTube Button
YouTubeButton.Parent = InfoFrame
YouTubeButton.Text = "YouTube: @WOOjIE.10-O"
YouTubeButton.Size = UDim2.new(0.9, 0, 0, 28)
YouTubeButton.Position = UDim2.new(0.05, 0, 0, 76)
YouTubeButton.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
YouTubeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
YouTubeButton.Font = Enum.Font.GothamBold
YouTubeButton.TextSize = 12
applyStyle(YouTubeButton, 8)

YouTubeButton.MouseButton1Click:Connect(function()
    if SetClipboard then
        SetClipboard("https://www.youtube.com/@WOOjIE.10-O")
        YouTubeButton.Text = "Copied YouTube!"
        task.wait(1.5)
        YouTubeButton.Text = "YouTube: @WOOjIE.10-O"
    end
end)

SquareSizeButton.Parent = InfoFrame
SquareSizeButton.Text = "Square Size"
SquareSizeButton.Size = UDim2.new(0.9, 0, 0, 28)
SquareSizeButton.Position = UDim2.new(0.05, 0, 0, 110)
SquareSizeButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SquareSizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SquareSizeButton.Font = Enum.Font.GothamBold
SquareSizeButton.TextSize = 12
applyStyle(SquareSizeButton, 8)

SquareSizeButton.MouseButton1Click:Connect(function()
    MainFrame.Size = UDim2.new(0, 150, 0, 150)
end)

RectSizeButton.Parent = InfoFrame
RectSizeButton.Text = "Rectangle Size"
RectSizeButton.Size = UDim2.new(0.9, 0, 0, 28)
RectSizeButton.Position = UDim2.new(0.05, 0, 0, 144)
RectSizeButton.BackgroundColor3 = Color3.fromRGB(180, 90, 0)
RectSizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RectSizeButton.Font = Enum.Font.GothamBold
RectSizeButton.TextSize = 12
applyStyle(RectSizeButton, 8)

RectSizeButton.MouseButton1Click:Connect(function()
    MainFrame.Size = UDim2.new(0, 220, 0, 115)
end)

OpenColorsButton.Parent = InfoFrame
OpenColorsButton.Text = "Colors Panel"
OpenColorsButton.Size = UDim2.new(0.9, 0, 0, 28)
OpenColorsButton.Position = UDim2.new(0.05, 0, 0, 178)
OpenColorsButton.BackgroundColor3 = Color3.fromRGB(120, 30, 180)
OpenColorsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenColorsButton.Font = Enum.Font.GothamBold
OpenColorsButton.TextSize = 12
applyStyle(OpenColorsButton, 8)

OpenColorsButton.MouseButton1Click:Connect(function()
    ColorsFrame.Visible = not ColorsFrame.Visible
end)

ToggleMovingButton.Parent = InfoFrame
ToggleMovingButton.Text = "Moving windows: OFF"
ToggleMovingButton.Size = UDim2.new(0.9, 0, 0, 28)
ToggleMovingButton.Position = UDim2.new(0.05, 0, 0, 212)
ToggleMovingButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
ToggleMovingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMovingButton.Font = Enum.Font.GothamBold
ToggleMovingButton.TextSize = 11
applyStyle(ToggleMovingButton, 8)

local isMovingEnabled = false
ToggleMovingButton.MouseButton1Click:Connect(function()
    isMovingEnabled = not isMovingEnabled
    InfoFrame.Draggable = isMovingEnabled
    CreditFrame.Draggable = isMovingEnabled
    ColorsFrame.Draggable = isMovingEnabled
    
    if isMovingEnabled then
        ToggleMovingButton.Text = "Moving windows: ON"
        ToggleMovingButton.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
    else
        ToggleMovingButton.Text = "Moving windows: OFF"
        ToggleMovingButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    end
end)

-- Colors Frame
ColorsFrame.Parent = ScreenGui
ColorsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ColorsFrame.BackgroundTransparency = 0.15
ColorsFrame.Size = UDim2.new(0, 180, 0, 190)
ColorsFrame.Position = UDim2.new(0.5, -90, 0.5, -95)
ColorsFrame.Visible = false
ColorsFrame.Active = true
ColorsFrame.Draggable = false
applyStyle(ColorsFrame, 12, Color3.fromRGB(120, 30, 180))

CloseColorsButton.Parent = ColorsFrame
CloseColorsButton.Text = "X"
CloseColorsButton.Size = UDim2.new(0, 22, 0, 22)
CloseColorsButton.Position = UDim2.new(1, -26, 0, 6)
CloseColorsButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseColorsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseColorsButton.Font = Enum.Font.GothamBold
CloseColorsButton.TextSize = 11
applyStyle(CloseColorsButton, 6)

CloseColorsButton.MouseButton1Click:Connect(function()
    ColorsFrame.Visible = false
end)

ColorsTitle.Parent = ColorsFrame
ColorsTitle.Size = UDim2.new(1, -30, 0, 25)
ColorsTitle.Position = UDim2.new(0, 10, 0, 6)
ColorsTitle.BackgroundTransparency = 1
ColorsTitle.Text = "Animated Themes"
ColorsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorsTitle.Font = Enum.Font.GothamBold
ColorsTitle.TextSize = 12
ColorsTitle.TextXAlignment = Enum.TextXAlignment.Left

local currentTheme = nil

ColorBtn1.Parent = ColorsFrame
ColorBtn1.Text = "Neon Purple"
ColorBtn1.Size = UDim2.new(0.85, 0, 0, 24)
ColorBtn1.Position = UDim2.new(0.075, 0, 0, 36)
ColorBtn1.BackgroundColor3 = Color3.fromRGB(100, 0, 220)
ColorBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorBtn1.Font = Enum.Font.GothamBold
ColorBtn1.TextSize = 12
applyStyle(ColorBtn1, 6)
ColorBtn1.MouseButton1Click:Connect(function() currentTheme = "Purple" end)

ColorBtn2.Parent = ColorsFrame
ColorBtn2.Text = "Cyber Cyan"
ColorBtn2.Size = UDim2.new(0.85, 0, 0, 24)
ColorBtn2.Position = UDim2.new(0.075, 0, 0, 64)
ColorBtn2.BackgroundColor3 = Color3.fromRGB(0, 180, 220)
ColorBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorBtn2.Font = Enum.Font.GothamBold
ColorBtn2.TextSize = 12
applyStyle(ColorBtn2, 6)
ColorBtn2.MouseButton1Click:Connect(function() currentTheme = "Cyan" end)

ColorBtn3.Parent = ColorsFrame
ColorBtn3.Text = "Sunset Flame"
ColorBtn3.Size = UDim2.new(0.85, 0, 0, 24)
ColorBtn3.Position = UDim2.new(0.075, 0, 0, 92)
ColorBtn3.BackgroundColor3 = Color3.fromRGB(220, 120, 0)
ColorBtn3.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorBtn3.Font = Enum.Font.GothamBold
ColorBtn3.TextSize = 12
applyStyle(ColorBtn3, 6)
ColorBtn3.MouseButton1Click:Connect(function() currentTheme = "Flame" end)

ColorBtn4.Parent = ColorsFrame
ColorBtn4.Text = "Matrix Emerald"
ColorBtn4.Size = UDim2.new(0.85, 0, 0, 24)
ColorBtn4.Position = UDim2.new(0.075, 0, 0, 120)
ColorBtn4.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
ColorBtn4.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorBtn4.Font = Enum.Font.GothamBold
ColorBtn4.TextSize = 12
applyStyle(ColorBtn4, 6)
ColorBtn4.MouseButton1Click:Connect(function() currentTheme = "Emerald" end)

ColorBtn5.Parent = ColorsFrame
ColorBtn5.Text = "Gradual Rainbow"
ColorBtn5.Size = UDim2.new(0.85, 0, 0, 28)
ColorBtn5.Position = UDim2.new(0.075, 0, 0, 148)
ColorBtn5.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
ColorBtn5.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorBtn5.Font = Enum.Font.GothamBold
ColorBtn5.TextSize = 12
applyStyle(ColorBtn5, 6)
ColorBtn5.MouseButton1Click:Connect(function() currentTheme = "Rainbow" end)

-- Animated Color Loop Engine
RunService.RenderStepped:Connect(function()
    if currentTheme then
        local col = Color3.fromRGB(20, 20, 25)
        local timeVal = tick()
        if currentTheme == "Purple" then
            col = Color3.fromRGB(math.sin(timeVal*2)*50 + 100, 0, math.cos(timeVal*2)*50 + 200)
        elseif currentTheme == "Cyan" then
            col = Color3.fromRGB(0, math.sin(timeVal*2)*50 + 150, 220)
        elseif currentTheme == "Flame" then
            col = Color3.fromRGB(240, math.sin(timeVal*2)*40 + 100, 0)
        elseif currentTheme == "Emerald" then
            col = Color3.fromRGB(0, math.sin(timeVal*2)*50 + 180, 80)
        elseif currentTheme == "Rainbow" then
            col = Color3.fromHSV((timeVal % 6) / 6, 0.9, 1)
        end
        MainFrame.BackgroundColor3 = col:Lerp(Color3.fromRGB(20, 20, 25), 0.5)
        MinimizedFrame.BackgroundColor3 = MainFrame.BackgroundColor3
    end
end)

-- Credit Frame
CreditFrame.Parent = ScreenGui
CreditFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
CreditFrame.BackgroundTransparency = 0.15
CreditFrame.Size = UDim2.new(0, 160, 0, 75)
CreditFrame.Position = UDim2.new(0.5, -80, 0.5, -125)
CreditFrame.Visible = false
CreditFrame.Active = true
CreditFrame.Draggable = false
applyStyle(CreditFrame, 12, Color3.fromRGB(255, 255, 255))

CloseCreditButton.Parent = CreditFrame
CloseCreditButton.Text = "X"
CloseCreditButton.Size = UDim2.new(0, 22, 0, 22)
CloseCreditButton.Position = UDim2.new(1, -26, 0, 6)
CloseCreditButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseCreditButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCreditButton.Font = Enum.Font.GothamBold
CloseCreditButton.TextSize = 11
applyStyle(CloseCreditButton, 6)

CloseCreditButton.MouseButton1Click:Connect(function()
    CreditFrame.Visible = false
end)

CreditLabel.Parent = CreditFrame
CreditLabel.Size = UDim2.new(1, 0, 1, -20)
CreditLabel.Position = UDim2.new(0, 0, 0, 22)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Made by WOOjIE"
CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.TextSize = 13

ToggleInfoButton.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
    CreditFrame.Visible = false
end)

CloseInfoButton.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
end)

ToggleCreditButton.MouseButton1Click:Connect(function()
    CreditFrame.Visible = not CreditFrame.Visible
    InfoFrame.Visible = false
end)

RunService.RenderStepped:Connect(function()
    if InfoFrame.Visible then
        local success, fps = pcall(function()
            return math.floor(1 / RunService.RenderStepped:Wait())
        end)
        local pingVal = math.floor(UserPing:GetValue())
        if success then
            StatsLabel.Text = "FPS: " .. fps .. " | Ping: " .. pingVal .. " ms"
        else
            StatsLabel.Text = "Ping: " .. pingVal .. " ms"
        end
    end
end)

-- Auto Kyoto button
AutoKyotoButton.Parent = MainFrame
AutoKyotoButton.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
AutoKyotoButton.Size = UDim2.new(0.9, 0, 0, 36)
AutoKyotoButton.Position = UDim2.new(0.05, 0, 0, 36)
AutoKyotoButton.Text = "Auto Kyoto [Q]"
AutoKyotoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoKyotoButton.Font = Enum.Font.GothamBold
AutoKyotoButton.TextSize = 13
applyStyle(AutoKyotoButton, 8)

-- Progress Bar Background
ProgressBarBackground.Parent = MainFrame
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ProgressBarBackground.Size = UDim2.new(0.9, 0, 0, 10)
ProgressBarBackground.Position = UDim2.new(0.05, 0, 0, 80)
applyStyle(ProgressBarBackground, 5)

-- Progress Bar Fill
ProgressBarFill.Parent = ProgressBarBackground
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
applyStyle(ProgressBarFill, 5)

local function calculateWaitTime(ping)
    local baseWaitTime = 1.45
    if ping <= 50 then
        return baseWaitTime * 0.65
    elseif ping <= 100 then
        return baseWaitTime * 0.75
    elseif ping <= 150 then
        return baseWaitTime * 0.85
    elseif ping <= 200 then
        return baseWaitTime * 0.95
    elseif ping <= 250 then
        return baseWaitTime * 1.05
    else
        return baseWaitTime * 1.15
    end
end

local function useTool(toolName)
    local chr = plr.Character
    if not chr then return end
    
    local tool = plr.Backpack:FindFirstChild(toolName) or chr:FindFirstChild(toolName)
    if tool then
        tool.Parent = chr
        task.wait(0.1)
        if tool:IsA("Tool") then
            tool:Activate()
        end
        task.wait(0.8)
        tool.Parent = plr.Backpack
    end
end

local isExecuting = false
local function runCombo()
    if isExecuting then return end
    isExecuting = true
    local chr = plr.Character
    if not chr then 
        isExecuting = false
        return 
    end

    local ping = UserPing:GetValue()
    local waitTime = calculateWaitTime(ping)
    
    useTool("Flowing Water")

    local startTime = tick()
    local duration = waitTime
    
    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        ProgressBarFill.Size = UDim2.new(alpha, 0, 1, 0)
        task.wait()
    end
    ProgressBarFill.Size = UDim2.new(1, 0, 1, 0)

    teleportForward()
    useTool("Lethal Whirlwind Stream")

    task.wait(0.2)
    ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)

    isExecuting = false
end

runComboRef = runCombo

AutoKyotoButton.MouseButton1Click:Connect(runCombo)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        runCombo()
    end
end)

print("WOOjIE $ kyoto (Upgraded UI) Loaded successfully!")
