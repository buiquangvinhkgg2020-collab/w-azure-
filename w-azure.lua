--=====================================================
-- W-azure | FINAL RELEASE
-- Blox Fruits | Seliware PC
--=====================================================

repeat task.wait() until game:IsLoaded()

----------------------------
-- CLEAR OLD UI
----------------------------
if game.CoreGui:FindFirstChild("W-azure") then
    game.CoreGui["W-azure"]:Destroy()
end

----------------------------
-- SERVICES
----------------------------
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

----------------------------
-- CONFIG
----------------------------
local C = {
    AutoFarm = false,
    AutoQuest = false,
    AutoBuso = true,
    FastAttack = false,
    FlyHeight = 15,
    AttackDelay = 0.12,
    Weapon = "Combat"
}

----------------------------
-- UI ROOT
----------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "W-azure"
gui.ResetOnSpawn = false

----------------------------
-- UI TOGGLE BUTTON (MOVABLE)
----------------------------
local toggleUI = Instance.new("TextButton", gui)
toggleUI.Size = UDim2.fromOffset(120,40)
toggleUI.Position = UDim2.fromScale(0.02,0.5)
toggleUI.Text = "W-azure"
toggleUI.BackgroundColor3 = Color3.fromRGB(40,80,140)
toggleUI.TextColor3 = Color3.new(1,1,1)
toggleUI.Font = Enum.Font.GothamBold
toggleUI.TextScaled = true
toggleUI.Active = true
toggleUI.Draggable = true
Instance.new("UICorner", toggleUI).CornerRadius = UDim.new(0,10)

----------------------------
-- MAIN UI
----------------------------
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.36,0.5)
main.Position = UDim2.fromScale(0.32,0.25)
main.BackgroundColor3 = Color3.fromRGB(18,25,40)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

toggleUI.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

----------------------------
-- TITLE
----------------------------
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0.1,0)
title.Text = "W-azure"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(120,180,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

----------------------------
-- TAB BAR
----------------------------
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(1,0,0.1,0)
tabBar.Position = UDim2.new(0,0,0.1,0)
tabBar.BackgroundTransparency = 1

local function TabButton(text, x)
    local b = Instance.new("TextButton", tabBar)
    b.Size = UDim2.new(0.3,0,1,0)
    b.Position = UDim2.new(x,0,0,0)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(45,65,110)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local farmBtn = TabButton("Farm",0.02)
local combatBtn = TabButton("Combat",0.35)
local miscBtn = TabButton("Misc",0.68)

----------------------------
-- TAB CONTENT
----------------------------
local function Tab()
    local f = Instance.new("Frame", main)
    f.Size = UDim2.new(1,0,0.7,0)
    f.Position = UDim2.new(0,0,0.2,0)
    f.BackgroundTransparency = 1
    f.Visible = false
    return f
end

local FarmTab = Tab()
local CombatTab = Tab()
local MiscTab = Tab()
FarmTab.Visible = true

local function Switch(tab)
    FarmTab.Visible = false
    CombatTab.Visible = false
    MiscTab.Visible = false
    tab.Visible = true
end

farmBtn.MouseButton1Click:Connect(function() Switch(FarmTab) end)
combatBtn.MouseButton1Click:Connect(function() Switch(CombatTab) end)
miscBtn.MouseButton1Click:Connect(function() Switch(MiscTab) end)

----------------------------
-- UI TOGGLE HELPER
----------------------------
local function Toggle(parent,text,y,callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.8,0,0.12,0)
    btn.Position = UDim2.new(0.1,0,y,0)
    btn.BackgroundColor3 = Color3.fromRGB(45,65,110)
    btn.Text = text.." : OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text.." : "..(state and "ON" or "OFF")
        callback(state)
    end)
end

----------------------------
-- UI CONTENT
----------------------------
Toggle(FarmTab,"Auto Farm",0.05,function(v) C.AutoFarm=v end)
Toggle(FarmTab,"Auto Quest",0.22,function(v) C.AutoQuest=v end)

Toggle(CombatTab,"Fast Attack",0.05,function(v) C.FastAttack=v end)
Toggle(MiscTab,"Auto Buso",0.05,function(v) C.AutoBuso=v end)

----------------------------
-- FUNCTIONS
----------------------------
local function Equip()
    local c = LP.Character or LP.CharacterAdded:Wait()
    if c:FindFirstChild(C.Weapon) then return end
    if LP.Backpack:FindFirstChild(C.Weapon) then
        c.Humanoid:EquipTool(LP.Backpack[C.Weapon])
    end
end

local function GetEnemy()
    if not workspace:FindFirstChild("Enemies") then return end
    for _,m in pairs(workspace.Enemies:GetChildren()) do
        if m:FindFirstChild("Humanoid")
        and m.Humanoid.Health > 0
        and m:FindFirstChild("HumanoidRootPart") then
            return m
        end
    end
end

----------------------------
-- FLY SYSTEM (NO FALL)
----------------------------
local function EnableFly()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not hrp:FindFirstChild("WazureBV") then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "WazureBV"
        bv.MaxForce = Vector3.new(1e9,1e9,1e9)
        bv.Velocity = Vector3.zero
    end

    if not hrp:FindFirstChild("WazureBG") then
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "WazureBG"
        bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
        bg.P = 9e4
    end
end

local function DisableFly()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        if hrp:FindFirstChild("WazureBV") then hrp.WazureBV:Destroy() end
        if hrp:FindFirstChild("WazureBG") then hrp.WazureBG:Destroy() end
    end
end

local function FarmPosition(mob)
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not mob then return end

    EnableFly()

    local cf =
        mob.HumanoidRootPart.CFrame
        * CFrame.new(0,C.FlyHeight,0)
        * CFrame.Angles(math.rad(-90),0,0)

    hrp.CFrame = cf
    if hrp:FindFirstChild("WazureBG") then
        hrp.WazureBG.CFrame = cf
    end
end

----------------------------
-- ATTACK
----------------------------
local function Attack()
    local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

----------------------------
-- LOOPS
----------------------------
task.spawn(function()
    while task.wait(0.1) do
        if C.AutoFarm then
            pcall(function()
                Equip()
                local mob = GetEnemy()
                if mob then
                    FarmPosition(mob)
                end
            end)
        else
            DisableFly()
        end
    end
end)

task.spawn(function()
    while task.wait(C.AttackDelay) do
        if C.FastAttack and C.AutoFarm then
            Attack()
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if C.AutoFarm and C.AutoQuest then
            pcall(function()
                if not LP.PlayerGui.Main.Quest.Visible then
                    RS.Remotes.CommF_:InvokeServer("StartQuest")
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if C.AutoBuso then
            pcall(function()
                if LP.Character and not LP.Character:FindFirstChild("HasBuso") then
                    RS.Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)
