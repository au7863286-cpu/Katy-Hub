-- [[ Rscripts Risk Notice ]]
-- This script is not verified by rscripts.net. Deal with caution.
-- WOOjIE
--
-- Stay safe:
--   • Never log in on unofficial Roblox sites or lookalike domains.
--   • Real Roblox links use roblox.com (check the .com ending).
--   • Treat fake Roblox login / "claim reward" pages as phishing.
-- [[ End Rscripts Risk Notice ]]

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

--// OLD SCRIPT TERMINATION SYSTEM
local scriptId = math.random(1, 1000000)
_G.SkidwareId = scriptId
local function isCurrent() return _G.SkidwareId == scriptId end

--// CONFIG
local Config = {
    Enabled = true,
    LethalEnabled = true,
    LethalAnim = "rbxassetid://10503381238",
    LethalDelay = 0.232,
    LethalJump = 55,
    LethalAccuracy = 15,
    LethalCancelDelay = 0.4,
    LethalMode = "V1",
    CancelEnabled = true,
    CooldownActive = true,
    NoClipEnabled = true,
    DashRange = 8,
    TouchMode = false,
    Platform = "PC",
    Keybind = "E",
    RainbowGlow = true,
    CooldownAnims = {
        ["10491993682"] = true,
        ["10479335397"] = true,
        ["13380255751"] = true,
    }
}

local isNoclipping = false
local isCooldown = false

-- // GLOBAL GUI VARIABLES
local ScreenGui, MainFrame, CooldownBar, CooldownFill, MainStroke, GlowUIStroke

-- // NUMERIC ID EXTRACTION FUNCTION
local function getId(str)
    return tostring(str):match("%d+")
end

--// NEW DASH FUNCTION
local function fireDash()
    local char = player.Character
    if not char then return end
    local communicate = char:FindFirstChild("Communicate")
    if communicate then
        local args = {{
            Dash = Enum.KeyCode.W,
            Key = Enum.KeyCode.Q,
            Goal = "KeyPress"
        }}
        communicate:FireServer(unpack(args))
    end
end

--// HELPER FUNCTIONS
local function clip()
    isNoclipping = false
    if player.Character then
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum then hum.AutoRotate = true end
    end
end

local function forceCancel()
    clip()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, obj in pairs(hrp:GetChildren()) do
            if obj:IsA("BodyVelocity") or obj:IsA("LinearVelocity") or obj:IsA("Attachment") or obj:IsA("BodyAngularVelocity") then
                obj:Destroy()
            end
        end
        hrp.AssemblyLinearVelocity = Vector3.zero
    end
end

-- // COOLDOWN HANDLING FUNCTION
local function startCooldown(duration)
    if not isCurrent() or isCooldown then return end
    isCooldown = true
    
    if MainFrame and CooldownBar and CooldownFill then
        CooldownBar.Visible = true
        CooldownFill.Size = UDim2.new(1, 0, 1, 0)
        local tween = TweenService:Create(CooldownFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
        tween:Play()
        
        task.delay(duration, function()
            isCooldown = false
            CooldownBar.Visible = false
        end)
    else
        task.wait(duration)
        isCooldown = false
    end
end

local function getTorsoTarget()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local params = OverlapParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char}
    
    local parts = workspace:GetPartBoundsInRadius(char.HumanoidRootPart.Position, Config.DashRange, params)
    local target = nil
    local dist = Config.DashRange
    
    for _, part in pairs(parts) do
        local model = part:FindFirstAncestorOfClass("Model")
        if model and model:FindFirstChild("Humanoid") and model ~= char then
            local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("HumanoidRootPart")
            if torso then
                local d = (char.HumanoidRootPart.Position - torso.Position).Magnitude
                if d < dist then 
                    dist = d 
                    target = torso 
                end
            end
        end
    end
    return target
end

--// LETHAL EXECUTION FUNCTION
local isExecuting = false
local function executeLethal()
    if not isCurrent() or isExecuting or isCooldown then return end
    if not Config.Enabled or not Config.LethalEnabled then return end
    
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    local torso = getTorsoTarget()
    if not torso then clip() return end
    
    isExecuting = true
    
    if not Config.TouchMode then
        task.wait(Config.LethalDelay)
    end
    
    if not isCurrent() then isExecuting = false return end
    
    root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, Config.LethalJump, root.AssemblyLinearVelocity.Z)
    isNoclipping = true
    fireDash()
    
    local startT = tick()
    local flipped = false
    local forwardDir = (torso.Position - root.Position).Unit
    local sideVec = Vector3.new(-forwardDir.Z, 0, forwardDir.X)
    local bav = nil
    
    if Config.LethalMode == "V1" then
        bav = Instance.new("BodyAngularVelocity")
        bav.MaxTorque = Vector3.new(0, 1000000, 0)
        bav.P = 15000
        bav.Parent = root
    end
    
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not isCurrent() or not torso or not torso.Parent or not root or not root.Parent then 
            if bav then bav:Destroy() end 
            clip()
            isExecuting = false
            if conn then conn:Disconnect() end
            return 
        end
        
        local elapsed = tick() - startT
        local torsoPos, rootPos = torso.Position, root.Position
        hum.AutoRotate = false
        
        if Config.LethalMode == "V1" then
            local angle = (elapsed / 0.45) * (math.pi / 1.5)
            local radius = Config.LethalAccuracy * (1 - math.clamp(elapsed / 0.45, 0, 1))
            local targetLookPos = torsoPos + (sideVec * math.cos(angle) + forwardDir * math.sin(angle)) * radius
            local lookAtCF = CFrame.lookAt(rootPos, Vector3.new(targetLookPos.X, rootPos.Y, targetLookPos.Z))
            local relativeCF = root.CFrame:Inverse() * lookAtCF
            local _, y, _ = relativeCF:ToEulerAnglesXYZ()
            if bav and bav.Parent then 
                bav.AngularVelocity = Vector3.new(0, y * 30, 0) 
            end
        else
            if elapsed >= Config.LethalAccuracy and not flipped then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.pi, 0)
                flipped = true
            end
        end

        local distXZ = (Vector2.new(rootPos.X, rootPos.Z) - Vector2.new(torsoPos.X, torsoPos.Z)).Magnitude
        if Config.CancelEnabled and elapsed > Config.LethalCancelDelay then
            if distXZ < 2.2 then
                if bav then bav:Destroy() end
                forceCancel()
                isExecuting = false
                conn:Disconnect()
                return
            end
        end
        
        if not Config.Enabled or elapsed > 1.5 then
            if bav then bav:Destroy() end
            clip()
            isExecuting = false
            conn:Disconnect()
            return
        end
    end)
end

--// GUI SYSTEM CLEANUP & SETUP
for _, gui in pairs(game.CoreGui:GetChildren()) do
    if gui.Name == "WOOjIEUI" or gui.Name == "SkidwareUI" or gui.Name == "VuxLethalUI" then
        gui:Destroy()
    end
end

ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "WOOjIEUI"
ScreenGui.ResetOnSpawn = false

MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
-- WOOjIE Cyan & Glassy Transparent Style
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 25, 35)
MainFrame.BackgroundTransparency = 0.35
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(0, 320, 0, 260)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -130)
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.ClipsDescendants = true

local function applyCorner(obj, radius)
    local corner = Instance.new("UICorner", obj)
    corner.CornerRadius = UDim.new(0, radius or 8)
end
applyCorner(MainFrame, 12)

MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 180, 255)
MainStroke.Thickness = 1.2

GlowUIStroke = Instance.new("UIStroke", MainFrame)
GlowUIStroke.Name = "GlowStroke"
GlowUIStroke.Color = Color3.fromRGB(0, 220, 255)
GlowUIStroke.Thickness = 2.2
GlowUIStroke.Transparency = 0.4

-- Rainbow & Progressive Color Glow Effect
task.spawn(function()
    local hue = 0
    while ScreenGui and ScreenGui.Parent do
        if Config.RainbowGlow then
            hue = (hue + 0.003) % 1
            local col = Color3.fromHSV(hue, 0.8, 1)
            GlowUIStroke.Color = col
            MainStroke.Color = col
            MainFrame.BackgroundColor3 = Color3.fromRGB(col.R * 30, col.G * 35, col.B * 45)
        end
        task.wait(0.05)
    end
end)

--// TOP BAR
local TopBar = Instance.new("Frame", MainFrame)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 35, 45)
TopBar.BackgroundTransparency = 0.3
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 36)
applyCorner(TopBar, 12)

local TopBarCover = Instance.new("Frame", TopBar)
TopBarCover.BackgroundColor3 = Color3.fromRGB(15, 35, 45)
TopBarCover.BackgroundTransparency = 0.3
TopBarCover.BorderSizePixel = 0
TopBarCover.Size = UDim2.new(1, 0, 0, 8)
TopBarCover.Position = UDim2.new(0, 0, 1, -8)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  WOOjIE & loop dash"
Title.Size = UDim2.new(0.45, 0, 1, 0)
Title.Position = UDim2.new(0.02, 0, 0, 0)
Title.TextColor3 = Color3.fromRGB(220, 245, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left

--// HIDE BUTTON (_)
local HideBtn = Instance.new("TextButton", TopBar)
HideBtn.Text = "_"
HideBtn.Size = UDim2.new(0, 22, 0, 22)
HideBtn.Position = UDim2.new(1, -128, 0.5, -11)
HideBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
HideBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 13
applyCorner(HideBtn, 4)

--// QUESTION MARK BUTTON (?) -> Info & YouTube
local InfoBtn = Instance.new("TextButton", TopBar)
InfoBtn.Text = "?"
InfoBtn.Size = UDim2.new(0, 22, 0, 22)
InfoBtn.Position = UDim2.new(1, -102, 0.5, -11)
InfoBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
InfoBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
InfoBtn.Font = Enum.Font.GothamBold
InfoBtn.TextSize = 13
applyCorner(InfoBtn, 4)

--// PLUS BUTTON (+) -> Socials & Color Settings
local PlusBtn = Instance.new("TextButton", TopBar)
PlusBtn.Text = "+"
PlusBtn.Size = UDim2.new(0, 22, 0, 22)
PlusBtn.Position = UDim2.new(1, -76, 0.5, -11)
PlusBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
PlusBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 13
applyCorner(PlusBtn, 4)

--// MINIMIZE BUTTON
local MinimizeBtn = Instance.new("TextButton", TopBar)
MinimizeBtn.Text = "-"
MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
MinimizeBtn.Position = UDim2.new(1, -50, 0.5, -11)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 13
applyCorner(MinimizeBtn, 4)

--// DESTROY BUTTON
local DestroyBtn = Instance.new("TextButton", TopBar)
DestroyBtn.Text = "×"
DestroyBtn.Size = UDim2.new(0, 22, 0, 22)
DestroyBtn.Position = UDim2.new(1, -24, 0.5, -11)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
DestroyBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
DestroyBtn.Font = Enum.Font.GothamBold
DestroyBtn.TextSize = 13
applyCorner(DestroyBtn, 4)

local lastDestroyClick = 0
DestroyBtn.MouseButton1Click:Connect(function()
    local currentTime = tick()
    if currentTime - lastDestroyClick <= 5 then
        forceCancel()
        ScreenGui:Destroy()
    else
        lastDestroyClick = currentTime
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "WOOjIE",
            Text = "Click '×' again to destroy script.",
            Duration = 5,
        })
    end
end)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MinimizeBtn.Text = isMinimized and "+" or "-"
    local targetSize = isMinimized and UDim2.new(0, 320, 0, 36) or UDim2.new(0, 320, 0, 260)
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
end)

--// POPUP WINDOWS CONTAINER
local PopupFrame = Instance.new("Frame", MainFrame)
PopupFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
PopupFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
PopupFrame.BackgroundColor3 = Color3.fromRGB(12, 28, 40)
PopupFrame.BackgroundTransparency = 0.1
PopupFrame.Visible = false
PopupFrame.ZIndex = 20
applyCorner(PopupFrame, 10)
local PopupStroke = Instance.new("UIStroke", PopupFrame)
PopupStroke.Color = Color3.fromRGB(0, 200, 255)

local PopupTitle = Instance.new("TextLabel", PopupFrame)
PopupTitle.Size = UDim2.new(1, -30, 0, 30)
PopupTitle.Position = UDim2.new(0, 10, 0, 5)
PopupTitle.BackgroundTransparency = 1
PopupTitle.TextColor3 = Color3.fromRGB(220, 245, 255)
PopupTitle.Font = Enum.Font.GothamBold
PopupTitle.TextSize = 12
PopupTitle.TextXAlignment = Enum.TextXAlignment.Left
PopupTitle.ZIndex = 21

local ClosePopup = Instance.new("TextButton", PopupFrame)
ClosePopup.Size = UDim2.new(0, 22, 0, 22)
ClosePopup.Position = UDim2.new(1, -26, 0, 5)
ClosePopup.BackgroundColor3 = Color3.fromRGB(30, 60, 80)
ClosePopup.TextColor3 = Color3.fromRGB(255, 255, 255)
ClosePopup.Text = "×"
ClosePopup.Font = Enum.Font.GothamBold
ClosePopup.TextSize = 12
ClosePopup.ZIndex = 21
applyCorner(ClosePopup, 4)
ClosePopup.MouseButton1Click:Connect(function()
    PopupFrame.Visible = false
end)

local PopupContent = Instance.new("ScrollingFrame", PopupFrame)
PopupContent.Size = UDim2.new(1, -10, 1, -45)
PopupContent.Position = UDim2.new(0, 5, 0, 40)
PopupContent.BackgroundTransparency = 1
PopupContent.CanvasSize = UDim2.new(0, 0, 0, 0)
PopupContent.ScrollBarThickness = 3
PopupContent.ZIndex = 21
local PopupLayout = Instance.new("UIListLayout", PopupContent)
PopupLayout.Padding = UDim.new(0, 8)
PopupLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// INFO POPUP CONTENT (?)
InfoBtn.MouseButton1Click:Connect(function()
    PopupFrame.Visible = true
    PopupTitle.Text = "Info & Made by WOOjIE"
    for _, c in pairs(PopupContent:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
    
    local desc = Instance.new("TextLabel", PopupContent)
    desc.Size = UDim2.new(1, 0, 0, 40)
    desc.BackgroundTransparency = 1
    desc.TextColor3 = Color3.fromRGB(200, 230, 255)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 11
    desc.Text = "Script Made by WOOjIE\nWOOjIE Edition"
    desc.TextWrapped = true
    desc.ZIndex = 22
    
    local ytBtn = Instance.new("TextButton", PopupContent)
    ytBtn.Size = UDim2.new(1, 0, 0, 35)
    ytBtn.BackgroundColor3 = Color3.fromRGB(20, 45, 60)
    ytBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ytBtn.Font = Enum.Font.GothamSemibold
    ytBtn.TextSize = 11
    ytBtn.Text = "YouTube: @WOOjIE.10-O (Click to Copy)"
    ytBtn.ZIndex = 22
    applyCorner(ytBtn, 6)
    ytBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://www.youtube.com/@WOOjIE.10-O")
            ytBtn.Text = "Copied to Clipboard!"
            task.wait(1.5)
            ytBtn.Text = "YouTube: @WOOjIE.10-O (Click to Copy)"
        end
    end)
    PopupContent.CanvasSize = UDim2.new(0, 0, 0, 90)
end)

--// PLUS POPUP CONTENT (+) -> Socials, Colors, Shapes
PlusBtn.MouseButton1Click:Connect(function()
    PopupFrame.Visible = true
    PopupTitle.Text = "WOOjIE Controls & Socials"
    for _, c in pairs(PopupContent:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
    
    -- Social 1
    local s1 = Instance.new("TextButton", PopupContent)
    s1.Size = UDim2.new(1, 0, 0, 32)
    s1.BackgroundColor3 = Color3.fromRGB(20, 45, 60)
    s1.TextColor3 = Color3.fromRGB(255, 255, 255)
    s1.Font = Enum.Font.GothamSemibold
    s1.TextSize = 11
    s1.Text = "YouTube: @WOOjIE.10-O (Copy)"
    s1.ZIndex = 22
    applyCorner(s1, 6)
    s1.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard("https://www.youtube.com/@WOOjIE.10-O") s1.Text = "Copied!" task.wait(1) s1.Text = "YouTube: @WOOjIE.10-O (Copy)" end
    end)
    
    -- Social 2
    local s2 = Instance.new("TextButton", PopupContent)
    s2.Size = UDim2.new(1, 0, 0, 32)
    s2.BackgroundColor3 = Color3.fromRGB(20, 45, 60)
    s2.TextColor3 = Color3.fromRGB(255, 255, 255)
    s2.Font = Enum.Font.GothamSemibold
    s2.TextSize = 11
    s2.Text = "TikTok: tiktok.com/@yoo_ges7 (Copy)"
    s2.ZIndex = 22
    applyCorner(s2, 6)
    s2.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard("tiktok.com/@yoo_ges7") s2.Text = "Copied!" task.wait(1) s2.Text = "TikTok: tiktok.com/@yoo_ges7 (Copy)" end
    end)
    
    -- Color Header
    local cHead = Instance.new("TextLabel", PopupContent)
    cHead.Size = UDim2.new(1, 0, 0, 25)
    cHead.BackgroundTransparency = 1
    cHead.TextColor3 = Color3.fromRGB(180, 220, 255)
    cHead.Font = Enum.Font.GothamBold
    cHead.TextSize = 11
    cHead.Text = "Window Colors & Glow (WOOjIE):"
    cHead.ZIndex = 22
    
    local colors = {
        {"Rainbow Glow (Auto)", nil, true},
        {"Cyan Glass Glow", Color3.fromRGB(0, 220, 255), false},
        {"Purple Glow", Color3.fromRGB(170, 0, 255), false},
        {"Pink Glow", Color3.fromRGB(255, 100, 200), false},
        {"Gold Glow", Color3.fromRGB(255, 215, 0), false},
        {"White Glass Glow", Color3.fromRGB(255, 255, 255), false}
    }
    
    for _, colInfo in ipairs(colors) do
        local btn = Instance.new("TextButton", PopupContent)
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.BackgroundColor3 = colInfo[2] or Color3.fromRGB(50, 150, 200)
        btn.TextColor3 = Color3.fromRGB(15, 15, 15)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.Text = colInfo[1]
        btn.ZIndex = 22
        applyCorner(btn, 6)
        btn.MouseButton1Click:Connect(function()
            if colInfo[3] then
                Config.RainbowGlow = true
            else
                Config.RainbowGlow = false
                GlowUIStroke.Color = colInfo[2]
                MainStroke.Color = colInfo[2]
                MainFrame.BackgroundColor3 = Color3.fromRGB(colInfo[2].R * 35, colInfo[2].G * 35, colInfo[2].B * 45)
            end
        end)
    end
    
    -- Shape Header
    local sHead = Instance.new("TextLabel", PopupContent)
    sHead.Size = UDim2.new(1, 0, 0, 25)
    sHead.BackgroundTransparency = 1
    sHead.TextColor3 = Color3.fromRGB(180, 220, 255)
    sHead.Font = Enum.Font.GothamBold
    sHead.TextSize = 11
    sHead.Text = "Window Shape Controls:"
    sHead.ZIndex = 22
    
    -- Square Button
    local sqBtn = Instance.new("TextButton", PopupContent)
    sqBtn.Size = UDim2.new(1, 0, 0, 30)
    sqBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
    sqBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    sqBtn.Font = Enum.Font.GothamSemibold
    sqBtn.TextSize = 11
    sqBtn.Text = "Shape: Square"
    sqBtn.ZIndex = 22
    applyCorner(sqBtn, 6)
    sqBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 300, 0, 300)}):Play()
    end)
    
    -- Rectangle Button
    local rectBtn = Instance.new("TextButton", PopupContent)
    rectBtn.Size = UDim2.new(1, 0, 0, 30)
    rectBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
    rectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rectBtn.Font = Enum.Font.GothamSemibold
    rectBtn.TextSize = 11
    rectBtn.Text = "Shape: Rectangle"
    rectBtn.ZIndex = 22
    applyCorner(rectBtn, 6)
    rectBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 340, 0, 240)}):Play()
    end)
    
    -- Circle / Rounded Button
    local circBtn = Instance.new("TextButton", PopupContent)
    circBtn.Size = UDim2.new(1, 0, 0, 30)
    circBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
    circBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    circBtn.Font = Enum.Font.GothamSemibold
    circBtn.TextSize = 11
    circBtn.Text = "Shape: Rounded Panel"
    circBtn.ZIndex = 22
    applyCorner(circBtn, 16)
    circBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 320, 0, 260)}):Play()
    end)
    
    PopupContent.CanvasSize = UDim2.new(0, 0, 0, 480)
end)

--// RESTORE BUTTON (WOOjIE)
local RestoreBtn = Instance.new("TextButton", ScreenGui)
RestoreBtn.Size = UDim2.new(0, 90, 0, 36)
RestoreBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
RestoreBtn.BackgroundColor3 = Color3.fromRGB(15, 35, 45)
RestoreBtn.BackgroundTransparency = 0.2
RestoreBtn.Text = "WOOjIE"
RestoreBtn.TextColor3 = Color3.fromRGB(220, 245, 255)
RestoreBtn.Font = Enum.Font.GothamBold
RestoreBtn.TextSize = 12
RestoreBtn.Visible = false
RestoreBtn.Draggable = true
RestoreBtn.Active = true
applyCorner(RestoreBtn, 8)
local RestoreStroke = Instance.new("UIStroke", RestoreBtn)
RestoreStroke.Color = Color3.fromRGB(0, 200, 255)
RestoreStroke.Thickness = 1.5

HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    RestoreBtn.Visible = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    RestoreBtn.Visible = false
end)

--// TAB BUTTONS CONTAINER
local TabHeader = Instance.new("Frame", MainFrame)
TabHeader.BackgroundTransparency = 1
TabHeader.Size = UDim2.new(1, -16, 0, 28)
TabHeader.Position = UDim2.new(0, 8, 0, 44)

local HomeTabBtn = Instance.new("TextButton", TabHeader)
HomeTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
HomeTabBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
HomeTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTabBtn.Text = "Home"
HomeTabBtn.Font = Enum.Font.GothamSemibold
HomeTabBtn.TextSize = 11
applyCorner(HomeTabBtn, 5)

local SettingsTabBtn = Instance.new("TextButton", TabHeader)
SettingsTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
SettingsTabBtn.Position = UDim2.new(0.52, 0, 0, 0)
SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
SettingsTabBtn.TextColor3 = Color3.fromRGB(130, 180, 200)
SettingsTabBtn.Text = "Settings"
SettingsTabBtn.Font = Enum.Font.GothamSemibold
SettingsTabBtn.TextSize = 11
applyCorner(SettingsTabBtn, 5)

--// TAB CONTAINERS
local ContainerHolder = Instance.new("Frame", MainFrame)
ContainerHolder.BackgroundTransparency = 1
ContainerHolder.Size = UDim2.new(1, -16, 1, -84)
ContainerHolder.Position = UDim2.new(0, 8, 0, 78)

local HomeContainer = Instance.new("ScrollingFrame", ContainerHolder)
HomeContainer.Size = UDim2.new(1, 0, 1, 0)
HomeContainer.BackgroundTransparency = 1
HomeContainer.CanvasSize = UDim2.new(0, 0, 0, 140)
HomeContainer.ScrollBarThickness = 2
HomeContainer.Visible = true

local HomeLayout = Instance.new("UIListLayout", HomeContainer)
HomeLayout.Padding = UDim.new(0, 8)
HomeLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local SettingsContainer = Instance.new("ScrollingFrame", ContainerHolder)
SettingsContainer.Size = UDim2.new(1, 0, 1, 0)
SettingsContainer.BackgroundTransparency = 1
SettingsContainer.CanvasSize = UDim2.new(0, 0, 0, 310)
SettingsContainer.ScrollBarThickness = 2
SettingsContainer.Visible = false

local SettingsLayout = Instance.new("UIListLayout", SettingsContainer)
SettingsLayout.Padding = UDim.new(0, 6)
SettingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Switch Tab Logic
HomeTabBtn.MouseButton1Click:Connect(function()
    HomeContainer.Visible = true
    SettingsContainer.Visible = false
    HomeTabBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
    HomeTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
    SettingsTabBtn.TextColor3 = Color3.fromRGB(130, 180, 200)
end)

SettingsTabBtn.MouseButton1Click:Connect(function()
    HomeContainer.Visible = false
    SettingsContainer.Visible = true
    SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(25, 50, 65)
    SettingsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HomeTabBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
    HomeTabBtn.TextColor3 = Color3.fromRGB(130, 180, 200)
end)

--// HOME TAB COMPONENTS
local ToggleBtn = Instance.new("TextButton", HomeContainer)
ToggleBtn.Size = UDim2.new(1, 0, 0, 38)
ToggleBtn.Text = "  Status: ON"
ToggleBtn.TextColor3 = Color3.fromRGB(220, 245, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
ToggleBtn.Font = Enum.Font.GothamSemibold
ToggleBtn.TextSize = 12
ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
applyCorner(ToggleBtn, 6)

local ToggleIndicator = Instance.new("Frame", ToggleBtn)
ToggleIndicator.Size = UDim2.new(0, 10, 0, 10)
ToggleIndicator.Position = UDim2.new(1, -20, 0.5, -5)
ToggleIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
applyCorner(ToggleIndicator, 5)

local ModeBtn = Instance.new("TextButton", HomeContainer)
ModeBtn.Size = UDim2.new(1, 0, 0, 38)
ModeBtn.Text = "  Mode Switch: V1"
ModeBtn.TextColor3 = Color3.fromRGB(220, 245, 255)
ModeBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
ModeBtn.Font = Enum.Font.GothamSemibold
ModeBtn.TextSize = 12
ModeBtn.TextXAlignment = Enum.TextXAlignment.Left
applyCorner(ModeBtn, 6)

--// SETTINGS TAB COMPONENTS
local function CreateInput(name, configKey)
    local frame = Instance.new("Frame", SettingsContainer)
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel", frame)
    label.Text = name
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.TextColor3 = Color3.fromRGB(160, 200, 220)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0.45, 0, 1, 0)
    input.Position = UDim2.new(0.55, 0, 0, 0)
    input.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
    input.Text = tostring(Config[configKey])
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.Gotham
    input.TextSize = 11
    applyCorner(input, 4)
    
    local stroke = Instance.new("UIStroke", input)
    stroke.Color = Color3.fromRGB(0, 150, 200)
    
    input.FocusLost:Connect(function() 
        local val = tonumber(input.Text) 
        if val then Config[configKey] = val 
        else Config[configKey] = input.Text end
    end)
    
    RunService.RenderStepped:Connect(function() 
        if not isCurrent() then return end 
        if not input:IsFocused() then 
            input.Text = tostring(Config[configKey]) 
        end 
    end)
    return frame
end

local DelayInput = CreateInput("Delay", "LethalDelay")
CreateInput("Jump Power", "LethalJump")
local AccInput = CreateInput("Accuracy / Flip", "LethalAccuracy")
CreateInput("Dash Range", "DashRange")
CreateInput("Cancel Delay", "LethalCancelDelay")
local KeyInput = CreateInput("Keybind", "Keybind")

local TouchBtn = Instance.new("TextButton", SettingsContainer)
TouchBtn.Size = UDim2.new(1, 0, 0, 32)
TouchBtn.Text = "Touch Mode: OFF"
TouchBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
TouchBtn.TextColor3 = Color3.fromRGB(160, 200, 220)
TouchBtn.Font = Enum.Font.Gotham
TouchBtn.TextSize = 11
applyCorner(TouchBtn, 4)

local PlatformBtn = Instance.new("TextButton", SettingsContainer)
PlatformBtn.Size = UDim2.new(1, 0, 0, 32)
PlatformBtn.Text = "Platform: PC"
PlatformBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
PlatformBtn.TextColor3 = Color3.fromRGB(160, 200, 220)
PlatformBtn.Font = Enum.Font.Gotham
PlatformBtn.TextSize = 11
PlatformBtn.Visible = false
applyCorner(PlatformBtn, 4)
KeyInput.Visible = false

local CooldownBtn = Instance.new("TextButton", SettingsContainer)
CooldownBtn.Size = UDim2.new(1, 0, 0, 32)
CooldownBtn.Text = "Cooldown System: ON"
CooldownBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
CooldownBtn.TextColor3 = Color3.fromRGB(160, 200, 220)
CooldownBtn.Font = Enum.Font.Gotham
CooldownBtn.TextSize = 11
applyCorner(CooldownBtn, 4)

--// COOLDOWN UI BAR
CooldownBar = Instance.new("Frame", MainFrame)
CooldownBar.Name = "CooldownBar"
CooldownBar.Size = UDim2.new(1, 0, 0, 2)
CooldownBar.Position = UDim2.new(0, 0, 1, -2)
CooldownBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CooldownBar.BackgroundTransparency = 0.5
CooldownBar.BorderSizePixel = 0
CooldownBar.Visible = false
CooldownBar.ZIndex = 10

CooldownFill = Instance.new("Frame", CooldownBar)
CooldownFill.Name = "Fill"
CooldownFill.Size = UDim2.new(1, 0, 1, 0)
CooldownFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
CooldownFill.BorderSizePixel = 0
CooldownFill.ZIndex = 11

--// MOBILE BUTTON TRIGGER
local MobileTrigger = Instance.new("TextButton", ScreenGui)
MobileTrigger.Size = UDim2.new(0, 56, 0, 56)
MobileTrigger.Position = UDim2.new(0.7, 0, 0.5, 0)
MobileTrigger.BackgroundColor3 = Color3.fromRGB(15, 35, 45)
MobileTrigger.Text = "WOO"
MobileTrigger.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileTrigger.Font = Enum.Font.GothamBold
MobileTrigger.TextSize = 11
MobileTrigger.Visible = false
MobileTrigger.Draggable = true
MobileTrigger.Active = true
applyCorner(MobileTrigger, 28)

local TriggerStroke = Instance.new("UIStroke", MobileTrigger)
TriggerStroke.Color = Color3.fromRGB(0, 200, 255)

--// INTERACTIONS LOGIC
ToggleBtn.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    ToggleBtn.Text = Config.Enabled and "  Status: ON" or "  Status: OFF"
    ToggleIndicator.BackgroundColor3 = Config.Enabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
end)

ModeBtn.MouseButton1Click:Connect(function()
    Config.LethalMode = (Config.LethalMode == "V1") and "V2" or "V1"
    ModeBtn.Text = "  Mode Switch: " .. Config.LethalMode
    if Config.LethalMode == "V2" then
        AccInput:FindFirstChildOfClass("TextLabel").Text = "Flip Delay"
        Config.LethalAccuracy = 0.25
    else
        AccInput:FindFirstChildOfClass("TextLabel").Text = "Accuracy / Flip"
        Config.LethalAccuracy = 15
    end
end)

TouchBtn.MouseButton1Click:Connect(function()
    Config.TouchMode = not Config.TouchMode
    TouchBtn.Text = "Touch Mode: " .. (Config.TouchMode and "ON" or "OFF")
    TouchBtn.TextColor3 = Config.TouchMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 200, 220)
    PlatformBtn.Visible = Config.TouchMode
    DelayInput.Visible = not Config.TouchMode
    KeyInput.Visible = (Config.TouchMode and Config.Platform == "PC")
    MobileTrigger.Visible = (Config.TouchMode and Config.Platform == "Mobile")
end)

PlatformBtn.MouseButton1Click:Connect(function()
    Config.Platform = (Config.Platform == "PC") and "Mobile" or "PC"
    PlatformBtn.Text = "Platform: " .. Config.Platform
    KeyInput.Visible = (Config.Platform == "PC")
    MobileTrigger.Visible = (Config.Platform == "Mobile")
end)

CooldownBtn.MouseButton1Click:Connect(function()
    Config.CooldownActive = not Config.CooldownActive
    CooldownBtn.Text = "Cooldown System: " .. (Config.CooldownActive and "ON" or "OFF")
    CooldownBtn.TextColor3 = Config.CooldownActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 200, 220)
end)

MobileTrigger.MouseButton1Click:Connect(executeLethal)

UIS.InputBegan:Connect(function(input, gpe)
    if not isCurrent() or gpe then return end
    if Config.TouchMode and Config.Platform == "PC" then
        if input.KeyCode == Enum.KeyCode[Config.Keybind:upper()] then
            executeLethal()
        end
    end
end)

--// CORE SETUP & NOCLIP
local function setup(char)
    if not isCurrent() then return end
    local hum = char:WaitForChild("Humanoid")
    hum.AnimationPlayed:Connect(function(track)
        if not isCurrent() then return end
        
        local animId = getId(track.Animation.AnimationId)
        if Config.CooldownActive and Config.CooldownAnims[animId] then
            startCooldown(5)
        end
        
        if Config.TouchMode or not Config.Enabled then return end
        
        if track.Animation.AnimationId == Config.LethalAnim then
            executeLethal()
        end
    end)
end

RunService.Stepped:Connect(function()
    if not isCurrent() or not Config.NoClipEnabled then return end
    
    if isNoclipping and player.Character then
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model ~= player.Character and (model:FindFirstChild("Humanoid") or model:FindFirstChildOfClass("Humanoid")) then
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

if player.Character then setup(player.Character) end
player.CharacterAdded:Connect(setup)

