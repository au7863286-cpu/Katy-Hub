local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local selectedNumber = 1
local isSpaceEnabled = false

local toolGroups = {
	{ "Flowing Water", "Lethal Whirlwind Stream", "Hunter's Grasp", "Prey's Peril" },
	{ "Doom Dive", "Crowd Buster", "Hammer Heel", "Binding Cloth" },
	{ "Machine Gun Blows", "Ignition Burst", "Blitz Shot", "Jet Dive" },
	{ "Flash Strike", "Whirlwind Kick", "Scatter", "Explosive Shuriken" },
	{ "Homerun", "Beatdown", "Grand Slam", "Foul Ball" },
	{ "Quick Slice", "Atmos Cleave", "Pinpoint Cut", "Split Second Counter" },
	{ "Crushing Pull", "Windstorm Fury", "Stone Coffin", "Expulsive Push" },
	{ "Bullet Barrage", "Vanishing Kick", "Whirlwind Drop", "Head First" },
	{ "Normal Punch", "Consecutive Punches", "Shove", "Uppercut" }
}

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MacroRemoteGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local function roundify(inst, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = inst
end

local function addStroke(inst, thickness, color)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness or 1.5
	stroke.Color = color or Color3.fromRGB(80, 80, 80)
	stroke.Parent = inst
end

-- ==================== 1. Top Frame (واجهة السكيلز الأساسية في الأعلى) ====================
local topFrame = Instance.new("Frame")
topFrame.Size = UDim2.new(0, 485, 0, 95) -- تم تعديل العرض والارتفاع قليلاً لاستيعاب الزر الجديد بشكل منظم
topFrame.Position = UDim2.new(0.5, -242, 0, 20)
topFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
topFrame.ZIndex = 20
topFrame.Parent = gui
roundify(topFrame, 14)
addStroke(topFrame, 2, Color3.fromRGB(0, 180, 255))

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, -0.4, 0)
title.BackgroundTransparency = 1
title.Text = "✨ Select Skill BackDash ✨"
title.TextColor3 = Color3.fromRGB(0, 210, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Center
title.ZIndex = 21
title.Parent = topFrame

-- Buttons 1-4
for i = 1, 4 do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 48, 0, 35)
	btn.Position = UDim2.new(0, (i - 1) * 58 + 12, 0, 10)
	btn.Text = tostring(i)
	btn.Name = "Select_" .. i
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.ZIndex = 21
	btn.BorderSizePixel = 0
	btn.Parent = topFrame
	roundify(btn, 10)
	addStroke(btn, 1, Color3.fromRGB(60, 60, 70))

	btn.MouseButton1Click:Connect(function()
		selectedNumber = i
		for j = 1, 4 do
			local b = topFrame:FindFirstChild("Select_" .. j)
			if b then
				local color = (j == i) and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(35, 35, 42)
				local textColor = (j == i) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
				TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color, TextColor3 = textColor}):Play()
			end
		end
	end)
end

-- Toggle Space
local spaceToggle = Instance.new("TextButton")
spaceToggle.Size = UDim2.new(0, 85, 0, 35)
spaceToggle.Position = UDim2.new(0, 248, 0, 10)
spaceToggle.Text = "Jump: OFF"
spaceToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
spaceToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
spaceToggle.Font = Enum.Font.GothamMedium
spaceToggle.TextSize = 13
spaceToggle.ZIndex = 21
spaceToggle.BorderSizePixel = 0
spaceToggle.Parent = topFrame
roundify(spaceToggle, 10)
addStroke(spaceToggle, 1, Color3.fromRGB(60, 60, 70))

spaceToggle.MouseButton1Click:Connect(function()
	isSpaceEnabled = not isSpaceEnabled
	spaceToggle.Text = isSpaceEnabled and "Jump: ON" or "Jump: OFF"
	local targetBg = isSpaceEnabled and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(35, 35, 42)
	TweenService:Create(spaceToggle, TweenInfo.new(0.2), {BackgroundColor3 = targetBg, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

-- Nút X (إغلاق)
local xButton = Instance.new("TextButton")
xButton.Size = UDim2.new(0, 35, 0, 35)
xButton.Position = UDim2.new(0, 438, 0, 10)
xButton.Text = "✕"
xButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
xButton.TextColor3 = Color3.fromRGB(255, 255, 255)
xButton.Font = Enum.Font.GothamBold
xButton.TextSize = 15
xButton.ZIndex = 21
xButton.Parent = topFrame
roundify(xButton, 10)

-- ==================== زر Dash, no final الجديد ====================
local dashNoFinalBtn = Instance.new("TextButton")
dashNoFinalBtn.Size = UDim2.new(0, 461, 0, 32)
dashNoFinalBtn.Position = UDim2.new(0, 12, 0, 53)
dashNoFinalBtn.Text = "⚡ Dash, no final"
dashNoFinalBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
dashNoFinalBtn.TextColor3 = Color3.fromRGB(220, 180, 255)
dashNoFinalBtn.Font = Enum.Font.GothamBold
dashNoFinalBtn.TextSize = 13
dashNoFinalBtn.ZIndex = 21
dashNoFinalBtn.BorderSizePixel = 0
dashNoFinalBtn.Parent = topFrame
roundify(dashNoFinalBtn, 10)
addStroke(dashNoFinalBtn, 1, Color3.fromRGB(150, 50, 255))

dashNoFinalBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/truly1ndonly/made-this-script-enjoy-teehee/refs/heads/main/TSB%20Infinite%20Dash"))()
	end)
	dashNoFinalBtn.Text = " ✓ Executed Dash, no final!"
	task.wait(1)
	dashNoFinalBtn.Text = "⚡ Dash, no final"
end)


-- ==================== 2. Social Media Bar (في الأسفل تحت واجهة السكيلز) ====================
local socialFrame = Instance.new("Frame")
socialFrame.Size = UDim2.new(0, 485, 0, 45)
socialFrame.Position = UDim2.new(0.5, -242, 0, 125)
socialFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
socialFrame.ZIndex = 20
socialFrame.Parent = gui
roundify(socialFrame, 12)
addStroke(socialFrame, 2, Color3.fromRGB(255, 0, 128))

-- زر تيك توك
local tiktokBtn = Instance.new("TextButton")
tiktokBtn.Size = UDim2.new(0, 230, 0, 31)
tiktokBtn.Position = UDim2.new(0, 7, 0, 7)
tiktokBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
tiktokBtn.Text = " 🎵 TikTok: @yoo_ges7"
tiktokBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tiktokBtn.Font = Enum.Font.GothamBold
tiktokBtn.TextSize = 12
tiktokBtn.ZIndex = 21
tiktokBtn.Parent = socialFrame
roundify(tiktokBtn, 8)
addStroke(tiktokBtn, 1, Color3.fromRGB(0, 242, 234))

tiktokBtn.MouseButton1Click:Connect(function()
	pcall(function()
		setclipboard("https://tiktok.com/@yoo_ges7")
	end)
	tiktokBtn.Text = " ✓ Copied TikTok Link!"
	task.wait(1)
	tiktokBtn.Text = " 🎵 TikTok: @yoo_ges7"
end)

-- زر يوتيوب
local youtubeBtn = Instance.new("TextButton")
youtubeBtn.Size = UDim2.new(0, 230, 0, 31)
youtubeBtn.Position = UDim2.new(0, 248, 0, 7)
youtubeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
youtubeBtn.Text = " 📺 YouTube: WOOjIE"
youtubeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
youtubeBtn.Font = Enum.Font.GothamBold
youtubeBtn.TextSize = 12
youtubeBtn.ZIndex = 21
youtubeBtn.Parent = socialFrame
roundify(youtubeBtn, 8)
addStroke(youtubeBtn, 1, Color3.fromRGB(255, 0, 0))

youtubeBtn.MouseButton1Click:Connect(function()
	pcall(function()
		setclipboard("https://www.youtube.com/@WOOjIE.10-O")
	end)
	youtubeBtn.Text = " ✓ Copied YouTube Link!"
	task.wait(1)
	youtubeBtn.Text = " 📺 YouTube: WOOjIE"
end)


-- Confirm remove (نافذة التأكيد)
local confirmFrame = Instance.new("Frame")
confirmFrame.Size = UDim2.new(0, 220, 0, 110)
confirmFrame.Position = UDim2.new(0.5, -110, 0.4, 0)
confirmFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
confirmFrame.Visible = false
confirmFrame.ZIndex = 50
confirmFrame.Parent = gui
roundify(confirmFrame, 14)
addStroke(confirmFrame, 2, Color3.fromRGB(200, 50, 50))

local confirmLabel = Instance.new("TextLabel")
confirmLabel.Size = UDim2.new(1, 0, 0, 40)
confirmLabel.Position = UDim2.new(0, 0, 0, 10)
confirmLabel.BackgroundTransparency = 1
confirmLabel.Text = "Do you want remove?"
confirmLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
confirmLabel.Font = Enum.Font.GothamMedium
confirmLabel.TextSize = 15
confirmLabel.ZIndex = 51
confirmLabel.Parent = confirmFrame

local yesButton = Instance.new("TextButton")
yesButton.Size = UDim2.new(0, 90, 0, 35)
yesButton.Position = UDim2.new(0, 15, 0, 60)
yesButton.Text = "Yes"
yesButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
yesButton.Font = Enum.Font.GothamBold
yesButton.TextSize = 14
yesButton.ZIndex = 51
yesButton.Parent = confirmFrame
roundify(yesButton, 10)

local noButton = Instance.new("TextButton")
noButton.Size = UDim2.new(0, 90, 0, 35)
noButton.Position = UDim2.new(0, 115, 0, 60)
noButton.Text = "No"
noButton.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noButton.Font = Enum.Font.GothamBold
noButton.TextSize = 14
noButton.ZIndex = 51
noButton.Parent = confirmFrame
roundify(noButton, 10)

xButton.MouseButton1Click:Connect(function()
	confirmFrame.Visible = true
end)

yesButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

noButton.MouseButton1Click:Connect(function()
	confirmFrame.Visible = false
end)


-- ==================== 3. Back Dash Button & Action Frame ====================
local actionFrame = Instance.new("Frame")
actionFrame.Size = UDim2.new(0, 65, 0, 65)
actionFrame.Position = UDim2.new(0.5, -32, 0.7, 0)
actionFrame.AnchorPoint = Vector2.new(0.5, 0.5)
actionFrame.BackgroundTransparency = 1
actionFrame.Parent = gui
actionFrame.ZIndex = 5

-- السحب السلس للداش
local dragging, dragInput, dragStart, startPos
actionFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = actionFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

actionFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		actionFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- ICON MENU: ⚙️ (ترس ثلاثي الأبعاد وواقعي)
local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0, 20, 0, 200)
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
icon.Text = "⚙️"
icon.TextSize = 26
icon.Font = Enum.Font.GothamBold
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.ZIndex = 99
icon.Parent = gui
roundify(icon, 25)
addStroke(icon, 2, Color3.fromRGB(0, 180, 255))

-- سحب أيقونة الترس
local draggingIcon, dragInputIcon, dragStartIcon, startPosIcon

icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingIcon = true
		dragStartIcon = input.Position
		startPosIcon = icon.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingIcon = false
			end
		end)
	end
end)

icon.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInputIcon = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInputIcon and draggingIcon then
		local delta = input.Position - dragStartIcon
		icon.Position = UDim2.new(startPosIcon.X.Scale, startPosIcon.X.Offset + delta.X, startPosIcon.Y.Scale, startPosIcon.Y.Offset + delta.Y)
	end
end)

-- Toggle GUI عند الضغط على الترس (يخفي السكيلز والسوشيال فقط ويبقى زر الداش ظاهراً دائماً)
local guiVisible = true

icon.MouseButton1Click:Connect(function()
	guiVisible = not guiVisible
	local targetColor = guiVisible and Color3.fromRGB(30, 30, 36) or Color3.fromRGB(0, 120, 200)
	TweenService:Create(icon, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()

	topFrame.Visible = guiVisible
	socialFrame.Visible = guiVisible
end)

-- Back Dash Image Button
local mainButton = Instance.new("ImageButton")
mainButton.Size = UDim2.new(1, 0, 1, 0)
mainButton.Position = UDim2.new(0, 0, 0, 0)
mainButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainButton.Image = "rbxassetid://139705395031155"
mainButton.ZIndex = 6
mainButton.Parent = actionFrame
roundify(mainButton, 32)
addStroke(mainButton, 2, Color3.fromRGB(255, 0, 150))

-- Remote Fire
local function triggerRemote(tool)
	local args = {
		[1] = {
			["Tool"] = tool,
			["Goal"] = "Console Move"
		}
	}
	local remote = player.Character and player.Character:FindFirstChild("Communicate")
	if remote then
		remote:FireServer(unpack(args))
	end
end

mainButton.MouseButton1Click:Connect(function()
	if isSpaceEnabled then
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		task.wait(0.05)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
	end

	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)

	task.spawn(function()
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
		task.wait(0.05)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
	end)

	task.spawn(function()
		local backpack = player:FindFirstChild("Backpack")
		if not backpack then return end

		for _, group in ipairs(toolGroups) do
			local toolName = group[selectedNumber]
			local tool = backpack:FindFirstChild(toolName)
			if tool then
				triggerRemote(tool)
				break
			end
		end
	end)

	task.delay(0.1, function()
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
	end)
end)

