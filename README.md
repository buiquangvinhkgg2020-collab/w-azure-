--[[ 
    TBoy Auto Farm Script
    Game: Blox Fruits
    UI: Redz UI V2
    Toggle ON/OFF được thật
]]

-- LOAD UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

local Window = MakeWindow({
    Hub = {
        Title = "TBoy Roblox",
        Animation = "Auto Farm Script"
    },
    Key = {
        KeySystem = false
    }
})

MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=83190276951914",
    Size = {60, 60},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true
})

-- TAB
local FarmTab = MakeTab({Name = "Auto Farm"})

-- SERVICES
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local AutoFarm = false
local WeaponName = "Combat" -- đổi vũ khí tại đây

-- FUNCTIONS
local function EquipWeapon()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Backpack = LocalPlayer.Backpack

    if Character:FindFirstChild(WeaponName) then return end
    if Backpack:FindFirstChild(WeaponName) then
        Character.Humanoid:EquipTool(Backpack[WeaponName])
    end
end

local function GetNearestNPC()
    local Character = LocalPlayer.Character
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end

    local closestMob
    local shortestDistance = math.huge

    if not workspace:FindFirstChild("Enemies") then return nil end

    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid")
        and mob.Humanoid.Health > 0
        and mob:FindFirstChild("HumanoidRootPart") then

            local distance = (mob.HumanoidRootPart.Position - HRP.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestMob = mob
            end
        end
    end

    return closestMob
end

-- TOGGLE AUTO FARM
AddToggle(FarmTab, {
    Name = "Auto Farm (ON / OFF)",
    Default = false,
    Callback = function(Value)
        AutoFarm = Value

        task.spawn(function()
            while AutoFarm do
                pcall(function()
                    EquipWeapon()
                    local mob = GetNearestNPC()
                    if mob then
                        LocalPlayer.Character.HumanoidRootPart.CFrame =
                            mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)

                        VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        task.wait(0.1)
                        VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
})

-- INFO
AddLabel(FarmTab, "TBoy Auto Farm - Custom Script")
AddLabel(FarmTab, "Toggle OFF là dừng thật")
