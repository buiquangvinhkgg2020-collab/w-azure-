--=====================================================
-- W-azure | ULTIMATE ALL-IN-ONE
-- Auto Farm 1-2-4 | Boss | Elite | Quest | Fruit | ESP
-- Safe Mode | Teleport | Movable UI
--=====================================================

repeat task.wait() until game:IsLoaded()

-- CLEAR OLD
pcall(function()
    if game.CoreGui:FindFirstChild("W-azure") then
        game.CoreGui["W-azure"]:Destroy()
    end
end)

-- SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

--=====================================================
-- CONFIG
--=====================================================
local C = {
    -- core
    AutoFarm=false, FastAttack=false, AutoBuso=true, SafeMode=true,
    BringMob=true, FlyHeight=15, AttackDelay=0.1,

    -- content
    AutoQuest=false, AutoBoss=false, BossName="", AutoElite=false,

    -- fruit
    AutoFruit=false, StoreFruit=true,

    -- esp
    ESPMob=false, ESPBoss=false, ESPFruit=false,
}

--=====================================================
-- UI
--=====================================================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name="W-azure"; gui.ResetOnSpawn=false

local uiBtn=Instance.new("TextButton",gui)
uiBtn.Size=UDim2.fromOffset(120,40)
uiBtn.Position=UDim2.fromScale(0.02,0.5)
uiBtn.Text="W-azure"
uiBtn.BackgroundColor3=Color3.fromRGB(40,80,150)
uiBtn.TextColor3=Color3.new(1,1,1)
uiBtn.Font=Enum.Font.GothamBold
uiBtn.TextScaled=true
uiBtn.Active=true; uiBtn.Draggable=true
Instance.new("UICorner",uiBtn).CornerRadius=UDim.new(0,10)

local main=Instance.new("Frame",gui)
main.Size=UDim2.fromScale(0.42,0.6)
main.Position=UDim2.fromScale(0.29,0.2)
main.BackgroundColor3=Color3.fromRGB(18,26,44)
main.Active=true; main.Draggable=true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,16)

uiBtn.MouseButton1Click:Connect(function()
    main.Visible=not main.Visible
end)

local title=Instance.new("TextLabel",main)
title.Size=UDim2.new(1,0,0.1,0)
title.BackgroundTransparency=1
title.Text="W-azure | ULTIMATE"
title.TextColor3=Color3.fromRGB(140,200,255)
title.Font=Enum.Font.GothamBold
title.TextScaled=true

-- tabs
local tabBar=Instance.new("Frame",main)
tabBar.Size=UDim2.new(1,0,0.1,0)
tabBar.Position=UDim2.new(0,0,0.1,0)
tabBar.BackgroundTransparency=1

local function TabButton(text,x)
    local b=Instance.new("TextButton",tabBar)
    b.Size=UDim2.new(0.19,0,1,0)
    b.Position=UDim2.new(x,0,0,0)
    b.Text=text
    b.BackgroundColor3=Color3.fromRGB(45,70,120)
    b.TextColor3=Color3.new(1,1,1)
    b.Font=Enum.Font.GothamBold
    b.TextScaled=true
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
    return b
end

local bFarm=TabButton("Farm",0.01)
local bCombat=TabButton("Combat",0.21)
local bFruit=TabButton("Fruit",0.41)
local bTP=TabButton("Teleport",0.61)
local bMisc=TabButton("Misc",0.81)

local function NewTab()
    local f=Instance.new("Frame",main)
    f.Size=UDim2.new(1,0,0.7,0)
    f.Position=UDim2.new(0,0,0.2,0)
    f.BackgroundTransparency=1
    f.Visible=false
    return f
end

local FarmTab,CombatTab,FruitTab,TeleportTab,MiscTab=
    NewTab(),NewTab(),NewTab(),NewTab(),NewTab()
FarmTab.Visible=true

local function Switch(t)
    for _,v in pairs({FarmTab,CombatTab,FruitTab,TeleportTab,MiscTab}) do v.Visible=false end
    t.Visible=true
end
bFarm.MouseButton1Click:Connect(function() Switch(FarmTab) end)
bCombat.MouseButton1Click:Connect(function() Switch(CombatTab) end)
bFruit.MouseButton1Click:Connect(function() Switch(FruitTab) end)
bTP.MouseButton1Click:Connect(function() Switch(TeleportTab) end)
bMisc.MouseButton1Click:Connect(function() Switch(MiscTab) end)

local function Toggle(parent,text,y,cb)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(0.8,0,0.11,0)
    b.Position=UDim2.new(0.1,0,y,0)
    b.BackgroundColor3=Color3.fromRGB(45,70,120)
    b.Text=text.." : OFF"
    b.TextColor3=Color3.new(1,1,1)
    b.Font=Enum.Font.GothamBold
    b.TextScaled=true
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
    local s=false
    b.MouseButton1Click:Connect(function()
        s=not s; b.Text=text.." : "..(s and "ON" or "OFF"); cb(s)
    end)
end

--=====================================================
-- TABS CONTENT
--=====================================================
Toggle(FarmTab,"Auto Farm",0.05,function(v) C.AutoFarm=v end)
Toggle(FarmTab,"Auto Quest",0.2,function(v) C.AutoQuest=v end)
Toggle(FarmTab,"Fast Attack",0.35,function(v) C.FastAttack=v end)
Toggle(FarmTab,"Safe Mode",0.5,function(v) C.SafeMode=v end)

Toggle(CombatTab,"Auto Boss",0.05,function(v) C.AutoBoss=v end)
Toggle(CombatTab,"Auto Elite",0.2,function(v) C.AutoElite=v end)
local bossBox=Instance.new("TextBox",CombatTab)
bossBox.Size=UDim2.new(0.8,0,0.11,0)
bossBox.Position=UDim2.new(0.1,0,0.35,0)
bossBox.PlaceholderText="Boss Name"
bossBox.Text=""
bossBox.BackgroundColor3=Color3.fromRGB(35,55,90)
bossBox.TextColor3=Color3.new(1,1,1)
bossBox.Font=Enum.Font.Gotham
bossBox.TextScaled=true
Instance.new("UICorner",bossBox).CornerRadius=UDim.new(0,10)
bossBox.FocusLost:Connect(function() C.BossName=bossBox.Text end)

Toggle(FruitTab,"Auto Fruit",0.05,function(v) C.AutoFruit=v end)
Toggle(FruitTab,"Store Fruit",0.2,function(v) C.StoreFruit=v end)
Toggle(FruitTab,"ESP Fruit",0.35,function(v) C.ESPFruit=v end)

Toggle(MiscTab,"ESP Mob",0.05,function(v) C.ESPMob=v end)
Toggle(MiscTab,"ESP Boss",0.2,function(v) C.ESPBoss=v end)
Toggle(MiscTab,"Auto Buso",0.35,function(v) C.AutoBuso=v end)

-- Teleport
local Islands={
    ["Starter"]=CFrame.new(0,50,0),
    ["Jungle"]=CFrame.new(-1300,50,400),
    ["Desert"]=CFrame.new(1100,50,4300),
    ["Sky"]=CFrame.new(-4600,800,-1800),
    ["Colosseum"]=CFrame.new(-1500,50,-300),
    ["Dressrosa"]=CFrame.new(-400,50,500)
}
local y=0.05
for name,cf in pairs(Islands) do
    local b=Instance.new("TextButton",TeleportTab)
    b.Size=UDim2.new(0.8,0,0.11,0)
    b.Position=UDim2.new(0.1,0,y,0)
    b.Text=name
    b.BackgroundColor3=Color3.fromRGB(45,70,120)
    b.TextColor3=Color3.new(1,1,1)
    b.Font=Enum.Font.GothamBold
    b.TextScaled=true
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
    b.MouseButton1Click:Connect(function()
        local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame=cf end
    end)
    y=y+0.13
end

--=====================================================
-- FUNCTIONS
--=====================================================
local function Equip()
    local c=LP.Character or LP.CharacterAdded:Wait()
    if c:FindFirstChildOfClass("Tool") then return end
    for _,v in pairs(LP.Backpack:GetChildren()) do
        if v:IsA("Tool") then c.Humanoid:EquipTool(v); break end
    end
end

local function GetEnemy()
    if not workspace:FindFirstChild("Enemies") then return end
    for _,m in pairs(workspace.Enemies:GetChildren()) do
        if m:FindFirstChild("Humanoid") and m.Humanoid.Health>0 and m:FindFirstChild("HumanoidRootPart") then
            return m
        end
    end
end

local EliteNames={"Elite","Deandre","Urban","Diablo"}
local function GetElite()
    if not workspace:FindFirstChild("Enemies") then return end
    for _,m in pairs(workspace.Enemies:GetChildren()) do
        for _,n in pairs(EliteNames) do
            if m.Name:find(n) and m:FindFirstChild("Humanoid") and m.Humanoid.Health>0 then return m end
        end
    end
end

local function GetBossByName(name)
    if name=="" or not workspace:FindFirstChild("Enemies") then return end
    for _,m in pairs(workspace.Enemies:GetChildren()) do
        if m.Name:lower():find(name:lower()) and m:FindFirstChild("Humanoid") and m.Humanoid.Health>0 then
            return m
        end
    end
end

-- Fly lock
local function EnableFly()
    local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not hrp:FindFirstChild("WazureBV") then
        local bv=Instance.new("BodyVelocity",hrp)
        bv.Name="WazureBV"; bv.MaxForce=Vector3.new(1e9,1e9,1e9)
        local bg=Instance.new("BodyGyro",hrp)
        bg.Name="WazureBG"; bg.MaxTorque=Vector3.new(1e9,1e9,1e9); bg.P=9e4
    end
end

-- Bring mob
local function BringMob(m)
    if not m or not m:FindFirstChild("HumanoidRootPart") then return end
    pcall(function()
        m.HumanoidRootPart.CanCollide=false
        m.HumanoidRootPart.AssemblyLinearVelocity=Vector3.zero
        m.HumanoidRootPart.CFrame=
            LP.Character.HumanoidRootPart.CFrame*CFrame.new(0,-8,0)
    end)
end

-- Farm position (1-2-4)
local function FarmPosition(m)
    local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not m or not m:FindFirstChild("HumanoidRootPart") then return end
    EnableFly()
    local cf=m.HumanoidRootPart.CFrame*CFrame.new(0,C.FlyHeight,0)*CFrame.Angles(math.rad(-90),0,0)
    hrp.CFrame=cf; hrp.WazureBG.CFrame=cf
    if C.BringMob then BringMob(m) end
end

local function Attack()
    local tool=LP.Character and LP.Character:FindFirstChildOfClass("Tool")
    if tool then tool:Activate() end
end

--=====================================================
-- ESP
--=====================================================
local function ESP(hrp,color)
    if hrp:FindFirstChild("WazureESP") then return end
    local b=Instance.new("BoxHandleAdornment",hrp)
    b.Name="WazureESP"; b.Size=hrp.Size; b.Adornee=hrp
    b.AlwaysOnTop=true; b.ZIndex=5; b.Transparency=0.5; b.Color3=color
end

RunService.RenderStepped:Connect(function()
    if workspace:FindFirstChild("Enemies") then
        for _,m in pairs(workspace.Enemies:GetChildren()) do
            if m:FindFirstChild("HumanoidRootPart") then
                if C.ESPMob then ESP(m.HumanoidRootPart,Color3.fromRGB(255,0,0)) end
                if C.ESPBoss and m.Name:lower():find("boss") then ESP(m.HumanoidRootPart,Color3.fromRGB(255,170,0)) end
            end
        end
    end
end)

--=====================================================
-- LOOPS
--=====================================================
task.spawn(function()
    while task.wait(0.1) do
        if C.AutoFarm then
            Equip()
            local m
            if C.AutoBoss then m=GetBossByName(C.BossName)
            elseif C.AutoElite then m=GetElite()
            else m=GetEnemy() end
            if m then FarmPosition(m) end
        end
    end
end)

task.spawn(function()
    while task.wait(C.AttackDelay) do
        if C.FastAttack and C.AutoFarm then Attack() end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if C.AutoBuso then
            pcall(function() RS.Remotes.CommF_:InvokeServer("Buso") end)
        end
    end
end)
