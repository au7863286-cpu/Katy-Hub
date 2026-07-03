-- Katy Hub [TSB Edition] - الإصدار الأول
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/uwuware-lib/master/main.lua"))()
local Window = Library:CreateWindow("Katy Hub | TSB")

-- ميزات السكريبت
local TSB = Window:AddFolder("Combat Features")

TSB:AddToggle({text = "Auto Farm", callback = function(value)
    if value then
        print("Auto Farm Activated")
        -- هنا يمكنك وضع كود الـ Auto Farm لاحقاً
    end
end})

TSB:AddToggle({text = "Kill Aura", callback = function(value)
    if value then
        print("Kill Aura Enabled")
    end
end})

TSB:AddButton({text = "Speed Hack", callback = function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    print("Speed Boosted!")
end})

TSB:AddButton({text = "Fly Mode", callback = function()
    -- كود بسيط للطيران
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
end})

-- تفعيل الواجهة
Library:Init()
