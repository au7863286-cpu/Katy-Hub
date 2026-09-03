local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local AutoBlockEnabled = true
local CloseRangeDistance = 14
local LongRangeDistance = 35
local IsBlockingActive = false

local CloseRangeAnimations = {
    "rbxassetid://16552234590", "rbxassetid://17889290569", "rbxassetid://17889461810",
    "rbxassetid://17889458563", "rbxassetid://17889471098", "rbxassetid://16515448089",
    "rbxassetid://16515520431", "rbxassetid://16515503507", "rbxassetid://15162694192",
    "rbxassetid://15240176873", "rbxassetid://15240216931", "rbxassetid://15259161390",
    "rbxassetid://14136436157", "rbxassetid://14001963401", "rbxassetid://13997092940",
    "rbxassetid://14004222985", "rbxassetid://13378708199", "rbxassetid://13378751717",
    "rbxassetid://13390230973", "rbxassetid://13295936866", "rbxassetid://13295919399",
    "rbxassetid://13296577783", "rbxassetid://13491635433", "rbxassetid://13294471966",
    "rbxassetid://13532604085", "rbxassetid://13532600125", "rbxassetid://13532562418",
    "rbxassetid://10469643643", "rbxassetid://10469630950", "rbxassetid://10469639222",
    "rbxassetid://10469493270", "rbxassetid://10479335397", "rbxassetid://17325537719",
    "rbxassetid://17325522388", "rbxassetid://17325510002", "rbxassetid://17325513870",
    "rbxassetid://13380255751", "rbxassetid://17857788598", "rbxassetid://17799224866",
    "rbxassetid://10470104242", "rbxassetid://10503381238", "rbxassetid://18464351556",
    "rbxassetid://10466974800", "rbxassetid://10468665991", "rbxassetid://12509505723",
    "rbxassetid://18179181663", "rbxassetid://17857880283", "rbxassetid://12534735382",
    "rbxassetid://12296882427", "rbxassetid://12272894215", "rbxassetid://15290930205",
    "rbxassetid://16431491215", "rbxassetid://16515850153", "rbxassetid://16139402582",
    "rbxassetid://13362587853", "rbxassetid://16139108718", "rbxassetid://14046756619",
    "rbxassetid://134775406437626", "rbxassetid://104895379416342", "rbxassetid://100059874351664",
    "rbxassetid://123005629431309", "rbxassetid://98542310119798", "rbxassetid://77509627104305",
    "rbxassetid://113166426814229", "rbxassetid://13376869471", "rbxassetid://15295895753",
    "rbxassetid://13370310513", "rbxassetid://125955606488863"
}

local LongRangeAnimations = {
    "rbxassetid://10479335397", "rbxassetid://10468665991", "rbxassetid://12684185971",
    "rbxassetid://12509505723", "rbxassetid://12684390285", "rbxassetid://17275150809",
    "rbxassetid://131820095363270", "rbxassetid://13362587853", "rbxassetid://14046756619",
    "rbxassetid://15295895753", "rbxassetid://15290930205", "rbxassetid://13380255751"
}

local function IsPlayingAnimation(humanoid, animationList)
    if not humanoid then return false end
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if table.find(animationList, track.Animation.AnimationId) then
            return true
        end
    end
    return false
end

local function StartBlock()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Communicate") then
        char.Communicate:FireServer({ Goal = "KeyPress", Key = Enum.KeyCode.F })
    end
end

local function StopBlock()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Communicate") then
        char.Communicate:FireServer({ Goal = "KeyRelease", Key = Enum.KeyCode.F })
    end
end

RunService.Heartbeat:Connect(function()
    if not AutoBlockEnabled then return end

    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local myPosition = character.HumanoidRootPart.Position

    local shouldBlock = false

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local targetChar = player.Character
            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChildOfClass("Humanoid") then
                local distance = (myPosition - targetChar.HumanoidRootPart.Position).Magnitude
                local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")

                if (distance <= CloseRangeDistance and IsPlayingAnimation(targetHumanoid, CloseRangeAnimations)) or
                   (distance <= LongRangeDistance and IsPlayingAnimation(targetHumanoid, LongRangeAnimations)) then
                    shouldBlock = true
                    break
                end
            end
        end
    end

    if shouldBlock then
        if not IsBlockingActive then
            StartBlock()
            IsBlockingActive = true
        end
    else
        if IsBlockingActive then
            StopBlock()
            IsBlockingActive = false
        end
    end
end)

StarterGui:SetCore("SendNotification", {
    Title = "Auto Block",
    Text = "Running silently in background!",
    Duration = 3
})

