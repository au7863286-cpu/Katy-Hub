-- WAJI HUB v3.4 [STABLE - 25 SPEED - ALL SCRIPTS INTEGRATED]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WajiHub_v3") then CoreGui.WajiHub_v3:Destroy() end

local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "WajiHub_v3"; screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 280, 0, 390); mainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20); mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(0, 212, 255); mainFrame.UIStroke.Thickness = 2

local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 26, 0, 26); closeBtn.Position = UDim2.new(0.86, 0, 0.04, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75); closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local buttonContainer = Instance.new("Frame", mainFrame)
buttonContainer.Size = UDim2.new(0, 244, 0, 300); buttonContainer.Position = UDim2.new(0, 18, 0, 60)
buttonContainer.BackgroundTransparency = 1
local listLayout = Instance.new("UIListLayout", buttonContainer); listLayout.Padding = UDim.new(0, 8)

local function makeBtn(text, color)
    local b = Instance.new("TextButton", buttonContainer)
    b.Size = UDim2.new(1, 0, 0, 35); b.BackgroundColor3 = color; b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255); b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    return b
end

local resetBtn = makeBtn("Transfer to Hungary", Color3.fromRGB(220, 40, 40))
local noSlowedBtn = makeBtn("No Slowed: ON", Color3.fromRGB(0, 180, 130))
local noStunBtn = makeBtn("No Stun: ON", Color3.fromRGB(0, 180, 130))
local script1Btn = makeBtn("Implementing the Golden Hand technique", Color3.fromRGB(80, 80, 80))
local script2Btn = makeBtn("Golden side rush", Color3.fromRGB(80, 80, 80))
local rtxBtn = makeBtn("RTX Graphics", Color3.fromRGB(80, 80, 80))

-- الوظائف
resetBtn.MouseButton1Click:Connect(function() if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.Health = 0 end end)
script1Btn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/cc456703616921dda82cf9389d4f2782c17785c0ee7da6fa7903d92ae88fb167.lua"))() end)
script2Btn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/23bcf4264b586dc93b16a9b054eddae259938b7421ac5096353079b2e9d74e24.lua"))() end)
rtxBtn.MouseButton1Click:Connect(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/RTX%20Gui%20Hub%20Obfuscator'))() end)

-- نظام تحريك الواجهة
local function makeDraggable(obj)
    local dragging, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end
makeDraggable(mainFrame)

local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 70, 0, 35); openBtn.Position = UDim2.new(0, 15, 0, 15)
openBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20); openBtn.Text = "WAJI"; openBtn.Visible = false
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255); openBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(0, 212, 255)
makeDraggable(openBtn)

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; openBtn.Visible = false end)

-- الميزات
local NoSlowedActive, NoStunActive = true, true
noSlowedBtn.MouseButton1Click:Connect(function() NoSlowedActive = not NoSlowedActive; noSlowedBtn.Text = NoSlowedActive and "No Slowed: ON" or "No Slowed: OFF"; noSlowedBtn.BackgroundColor3 = NoSlowedActive and Color3.fromRGB(0, 180, 130) or Color3.fromRGB(80, 80, 80) end)
noStunBtn.MouseButton1Click:Connect(function() NoStunActive = not NoStunActive; noStunBtn.Text = NoStunActive and "No Stun: ON" or "No Stun: OFF"; noStunBtn.BackgroundColor3 = NoStunActive and Color3.fromRGB(0, 180, 130) or Color3.fromRGB(80, 80, 80) end)

RunService.RenderStepped:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        -- السرعة الجديدة 25
        if NoSlowedActive and hum.WalkSpeed < 25 then hum.WalkSpeed = 25 end
        if NoStunActive then
            hum.PlatformStand = false
            for _, attr in {"Stunned", "Slowed", "CantMove", "AttackSlow", "Stun"} do if char:GetAttribute(attr) then char:SetAttribute(attr, false) end end
        end
    end
end)

