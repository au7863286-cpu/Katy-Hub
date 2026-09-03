-- [[ TSB Color Cycling & Smooth Fade Script ]] --

-- قائمة الألوان الإجمالية (20 لوناً: 16 القديمة + 4 جديدة نقيّة)
local colors = {
    -- الألوان الثمانية القديمة:
    Color3.fromRGB(125, 249, 255),  -- 🌊 سماوي جليدي
    Color3.fromRGB(0, 128, 255),    -- ⚡ أزرق كهربائي
    Color3.fromRGB(0, 255, 0),      -- 🟢 أخضر نقي
    Color3.fromRGB(255, 255, 0),    -- 🟡 أصفر نقي
    Color3.fromRGB(255, 95, 31),    -- 🟠 برتقالي ناري
    Color3.fromRGB(255, 0, 0),      -- 🔴 أحمر نقي
    Color3.fromRGB(255, 105, 180),  -- 🌸 زهري فاتح نقي
    Color3.fromRGB(255, 16, 240),   -- 💗 وردي نيون
    
    -- الألوان الثمانية الجديدة النقيّة السابقة:
    Color3.fromRGB(0, 255, 128),    -- 🍃 أخضر نعناعي نقي
    Color3.fromRGB(138, 43, 226),   -- 🔮 بنفسجي ملكي نقي
    Color3.fromRGB(0, 255, 255),    -- 💠 تركوازي ساطع نقي
    Color3.fromRGB(255, 0, 127),    -- 🌺 فوشيا غامق نقي
    Color3.fromRGB(255, 215, 0),    -- 🌟 أصفر ذهبي نقي
    Color3.fromRGB(0, 102, 255),    -- 🌐 أزرق ملكي عميق
    Color3.fromRGB(255, 69, 0),     -- 🔥 أحمر برتقالي (سيركار)
    Color3.fromRGB(199, 21, 133),   -- 💜 بنفسجي محمر نقي

    -- الألوان الأربعة الجديدة المضافة حديثاً:
    Color3.fromRGB(75, 0, 130),     -- 🔮 نيلي داكن نقي
    Color3.fromRGB(0, 250, 154),    -- 🌿 أخضر ربيعي ساطع
    Color3.fromRGB(255, 140, 0),    -- 🧡 برتقالي داكن نقي
    Color3.fromRGB(238, 130, 238)   -- 🦄 بنفسجي فاتح (أوركيد)
}

-- شفافية تتلاشى تدريجياً في النهاية
local fadeTransparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0.0, 0.0),
    NumberSequenceKeypoint.new(0.5, 0.3),
    NumberSequenceKeypoint.new(1.0, 1.0)
})

local function applyEffect(effect)
    if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam") then
        effect.Transparency = fadeTransparency
        effect.LightEmission = 0.85
    elseif effect:IsA("Highlight") then
        effect.FillColor = Color3.fromRGB(255, 255, 255)
        effect.OutlineColor = colors[1]
    end
end

local function monitorInstance(parent)
    local success, err = pcall(function()
        for _, descendant in ipairs(parent:GetDescendants()) do
            applyEffect(descendant)
        end
        
        parent.DescendantAdded:Connect(function(descendant)
            applyEffect(descendant)
        end)
    end)
end

-- تطبيق المراقبة على اللعبة والشخصيات
monitorInstance(workspace)

local Players = game:GetService("Players")
for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        monitorInstance(player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        monitorInstance(char)
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        monitorInstance(char)
    end)
end)

-- نظام تغيير الألوان تدريجياً وواحد تلو الآخر لكل المؤثرات في اللعبة والشخصيات
task.spawn(function()
    local currentIndex = 1
    while true do
        task.wait(0.4) -- سرعة تبديل الألوان (كل 0.4 ثانية يتغير اللون للذي يليه)
        currentIndex = (currentIndex % #colors) + 1
        local nextColor = colors[currentIndex]
        
        -- تحديث اللون لكل المؤثرات الموجودة حالياً
        pcall(function()
            -- تحديث المؤثرات في الويركسبेस
            for _, descendant in ipairs(workspace:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") then
                    descendant.Color = ColorSequence.new(nextColor)
                elseif descendant:IsA("Highlight") then
                    descendant.OutlineColor = nextColor
                end
            end
            
            -- تحديث المؤثرات في شخصيات اللاعبين
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    for _, descendant in ipairs(player.Character:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") then
                            descendant.Color = ColorSequence.new(nextColor)
                        elseif descendant:IsA("Highlight") then
                            descendant.OutlineColor = nextColor
                        end
                    end
                end
            end
        end)
    end
end)

print("✨ تم تفعيل سكريبت 20 لوناً متتالياً بنجاح!")

