-- [[ TSB Ultra Bright & Vivid Multi-Color Script ]] --

local customGradient = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),  -- ⚪ أبيض ساطع ناصع تماماً (قوي جداً)
    ColorSequenceKeypoint.new(0.06, Color3.fromRGB(255, 0, 80)),      -- 🔴 أحمر فاقع وقوي
    ColorSequenceKeypoint.new(0.13, Color3.fromRGB(255, 230, 0)),    -- 🟡 أصفر فاقع وساطع
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(200, 0, 255)),    -- 🟣 بنفسجي نيون قوي
    ColorSequenceKeypoint.new(0.27, Color3.fromRGB(0, 255, 60)),      -- 🟢 أخضر فاقع وصريح
    
    -- الألوان العشرة الجديدة المضافة:
    ColorSequenceKeypoint.new(0.34, Color3.fromRGB(0, 100, 0)),      -- 🌲 أخضر غامق (الذي تحبينه)
    ColorSequenceKeypoint.new(0.41, Color3.fromRGB(0, 255, 255)),    -- 💠 تركوازي ساطع
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 128, 0)),    -- 🟠 برتقالي ناري
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(138, 43, 226)),   -- 🔮 بنفسجي ملكي
    ColorSequenceKeypoint.new(0.62, Color3.fromRGB(255, 20, 147)),   -- 🌸 وردي عميق
    ColorSequenceKeypoint.new(0.69, Color3.fromRGB(0, 0, 255)),      -- 🔵 أزرق نقي
    ColorSequenceKeypoint.new(0.76, Color3.fromRGB(50, 205, 50)),    -- 🍃 أخضر ليموني
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 105, 180)),  -- 💗 زهري فاتح
    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(75, 0, 130)),     -- 🌙 نيلي داكن
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 215, 0))     -- 🌟 أصفر ذهبي
})

local function applyGradient(effect)
    if effect:IsA("ParticleEmitter") then
        effect.Color = customGradient
        -- رفع معدل اليعان لأقصى حد لتكون الألوان مضيئة وبارزة تماماً وليست باهتة
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

local function monitorInstance(parent)
    for _, descendant in ipairs(parent:GetDescendants()) do
        applyGradient(descendant)
    end
    
    parent.DescendantAdded:Connect(function(descendant)
        applyGradient(descendant)
    end)
end

-- تطبيق المراقبة على اللعبة والشخصيات
monitorInstance(workspace)
for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player.Character then
        monitorInstance(player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        monitorInstance(char)
    end)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        monitorInstance(char)
    end)
end)

print("✨ تم تفعيل الألوان الفاقعة والساطعة بقوة بنجاح!")

