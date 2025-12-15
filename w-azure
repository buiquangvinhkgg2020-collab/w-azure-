--=====================================================
-- TBoy Auto Farm | Seliware Edition
-- Game: Blox Fruits
-- UI: Redz UI V2
-- Status: Stable - Clean - Optimized
--=====================================================

----------------------------
-- LOAD UI
----------------------------
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"
))()

local Window = MakeWindow({
    Hub = {
        Title = "TBoy Roblox",
        Animation = "Seliware Edition"
    },
    Key = { KeySystem = false }
})

MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=83190276951914",
    Size = {60,60},
    Color = Color3.fromRGB(20,20,20),
    Corner = true
})

----------------------------
-- TABS
----------------------------
local FarmTab  = MakeTab({Name = "Farm"})
local BossTab  = MakeTab({Name = "Boss"})
local MiscTab  = MakeTab({Name = "Misc"})

----------------------------
-- SERVICES
----------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

----------------------------
-- SETTINGS (CORE)
----------------------------
local Config = {
    AutoFarm   = false,
    AutoQuest  = false,
    AutoBoss   = false,
    AutoBuso   = true,
    Weapon     = "Combat",
    BossName   = "",
    Delay      = 0.35 -- tối ưu cho Seliware
}

----------------------------
-- UTIL FUNCTIONS
----------------------------
local function GetChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function EquipWeapon()
    local Char = GetChar()
    if Char:FindFirstChild(Config.Weapon) then return end
    local Tool = LocalPlayer.Backpack:FindFirstChild(Config.Weapon)
    if Tool then
        Char.Humanoid:EquipTool(Tool)
    end
end

local function GetNearestEnemy()
    local Char = GetChar()
    local HRP = Char:FindFirstChild("HumanoidRootPart")
    if not HRP or not workspace:FindFirstChild("Enemies") then return nil end

    local Target, MinDist = nil, math.huge
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid")
        and mob.Humanoid.Health > 0
        and mob:FindFirstChild("HumanoidRootPart") then

            local dist = (mob.HumanoidRootPart.Position - HRP.Position).Magnitude
            if dist < MinDist then
                MinDist = dist
                Target = mob
            end
        end
    end
    return Target
end

local function Attack()
    pcall(function()
        VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.05)
        VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

----------------------------
-- AUTO QUEST (SAFE)
----------------------------
local function StartQuest()
    if not Config.AutoQuest then return end
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest")
    end)
end

----------------------------
-- AUTO BUSO (SAFE)
----------------------------
task.spawn(function()
    while task.wait(5) do
        if Config.AutoBuso then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end)
        end
    end
end)

----------------------------
-- AUTO FARM LOOP
----------------------------
task.spawn(function()
    while task.wait(Config.Delay) do
        if Config.AutoFarm then
            pcall(function()
                EquipWeapon()
                StartQuest()

                local Enemy = GetNearestEnemy()
                if Enemy then
                    local HRP = GetChar():FindFirstChild("HumanoidRootPart")
                    HRP.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                    Attack()
                end
            end)
        end
    end
end)

----------------------------
-- AUTO BOSS LOOP
----------------------------
task.spawn(function()
    while task.wait(Config.Delay + 0.15) do
        if Config.AutoBoss and Config.BossName ~= "" then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name:lower():find(Config.BossName:lower())
                and mob:FindFirstChild("Humanoid")
                and mob.Humanoid.Health > 0 then

                    EquipWeapon()
                    GetChar().HumanoidRootPart.CFrame =
                        mob.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                    Attack()
                end
            end
        end
    end
end)

----------------------------
-- UI CONTROLS
----------------------------
AddToggle(FarmTab,{
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(v) Config.AutoFarm = v end
})

AddToggle(FarmTab,{
    Name = "Auto Quest",
    Default = false,
    Callback = function(v) Config.AutoQuest = v end
})

AddToggle(BossTab,{
    Name = "Auto Farm Boss",
    Default = false,
    Callback = function(v) Config.AutoBoss = v end
})

AddTextbox(BossTab,{
    Name = "Boss Name",
    Default = "",
    Callback = function(t) Config.BossName = t end
})

AddToggle(MiscTab,{
    Name = "Auto Buso Haki",
    Default = true,
    Callback = function(v) Config.AutoBuso = v end
})

----------------------------
-- ANTI AFK (SELIWARE SAFE)
----------------------------
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

AddLabel(MiscTab, "TBoy Auto Farm - Seliware Edition")
AddLabel(MiscTab, "Toggle OFF = DỪNG THẬT")
