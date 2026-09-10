-- WOOjIE Script Notice
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إزالة أي نسخة قديمة لنفس الرسالة
if playerGui:FindFirstChild("WajiNoticeGui") then
    playerGui.WajiNoticeGui:Destroy()
end

-- إنشاء واجهة الرسالة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WajiNoticeGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 380, 0, 230)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -115)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 180, 130)

-- زر الإغلاق (X)
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.Activated:Connect(function()
    screenGui:Destroy()
end)

-- العنوان
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, -40, 0, 35)
titleLabel.Position = UDim2.new(0, 15, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "WOOjIE Notice"
titleLabel.TextColor3 = Color3.fromRGB(0, 180, 130)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- نص الرسالة والتعليمات بالإنجليزية
local textLabel = Instance.new("TextLabel", mainFrame)
textLabel.Size = UDim2.new(1, -30, 0, 110)
textLabel.Position = UDim2.new(0, 15, 0, 45)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Hi bro, we are sorry to tell you that the script you were using has been deleted. But don't worry, there is good news! To try the new script, dear user, you must follow these instructions, then click on the word 'Here'."
textLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
textLabel.Font = Enum.Font.Gotham
textLabel.TextSize = 12
textLabel.TextWrapped = true
textLabel.TextXAlignment = Enum.TextXAlignment.Left

-- زر "هنا" (Here) لنسخ السكريبت الجديد
local hereBtn = Instance.new("TextButton", mainFrame)
hereBtn.Size = UDim2.new(0, 140, 0, 35)
hereBtn.Position = UDim2.new(0.5, -70, 1, -45)
hereBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 130)
hereBtn.Text = "Here"
hereBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hereBtn.Font = Enum.Font.GothamBold
hereBtn.TextSize = 14
Instance.new("UICorner", hereBtn).CornerRadius = UDim.new(0, 8)

hereBtn.Activated:Connect(function()
    pcall(function()
        setclipboard("loadstring(game:HttpGet('https://raw.githubusercontent.com/au7863286-cpu/Katy-Hub/main/WajiHub.lua'))()")
    end)
    StarterGui:SetCore("SendNotification", {
        Title = "WOOjIE",
        Text = "New script copied to clipboard successfully!",
        Duration = 4
    })
end)

print("WOOjIE Notice Loaded Successfully!")
