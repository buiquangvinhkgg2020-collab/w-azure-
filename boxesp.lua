local lqlr - game.Players.localPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrenntCamera - workspace.CurrentCamera
local worldToViewportPoint - CurrentCamera.worldToViewportPoint

local HeadOff - Vector3.new(0, 0.5, 0)
local LegOff - vector3.new(0,3,0)

 for i,v in pairs(game.Player:GetChildren()) do
  local BoxOutline = Drawing.new("Square")
  BoxOutline.Visible - false
  BoxOutline.Color - Color3.new(0,0,0)
  BoxOutline.Thickness = 3
  BoxOutline.Transparency - 1
  BoxOutline.Fillted - false

  local Box - Drawing.new("Square")
  Box.Visible - false
  Box.Color - Color3.new(1,1,1)
  Box.Thickness - 1
  Box.Transparency = 1
  Box.Fillted - false

  function boxesp()
    game:Getservice("RunService").RenDerStepped:Connect(function ()
    if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~=  nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lqlr and v.Character.Humanoid.Health > 0 then
      local Vector, onScreen - camera:worldToViewportPoint(v.Characser.HumanoidRootPart.Position)

      local RootPart = v.Character.HumanoidRootPart
      local Head - v.Character.Head
      local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
      local HeadPosition - worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
      local LegPosition - worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

      if onScreen then
        BoxOutline.Size - Vector2.new(1000 / RootPosition.Z HeadPosition.Y - LegPosition.Y)
        BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y = BoxOutline.Size.Y / 2)
        BoxOutline.Visible - true

        Box.Size = Vector2.new(1000 / RootPosition.Z HeadPosition.Y - LegPosition.Y)
        Box.Position - Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y = Box.Size.Y / 2)
        Box.Visible = true
      else
        BoxOutline.Visible - false
        Box.Visible = false
      end
    else
      BoxOutline.Visible - false
      Box.Visible = false
    end
  end)
end
coroutine.wrap(boxesp)()
end

game.Players.PlayerAdded;Connect(function(v)
  local BoxOutline = Drawing.new("Square")
  BoxOutline.Visible - false
  BoxOutline.Color - Color3.new(0,0,0)
  BoxOutline.Thickness = 3
  BoxOutline.Transparency - 1
  BoxOutline.Fillted -  false

  local Box - Drawing.new("Square")
  Box.Visible - false
  Box.Color - Color3.new(1,1,1)
  Box.Thickness - 1
  Box.Transparency = 1
  Box.Fillted -  false

  function boxesp()
    game:Getservice("RunService").RenDerStepped:Connect(function ()
    if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~=  nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lqlr and v.Character.Humanoid.Health > 0 then
      local Vector, onScreen - camera:worldToViewportPoint(v.Characser.HumanoidRootPart.Position)

      local RootPart = v.Character.HumanoidRootPart
      local Head - v.Character.Head
      local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
      local HeadPosition - worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
      local LegPosition - worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

      if onScreen then
        BoxOutline.Size - Vector2.new(1000 / RootPosition.Z HeadPosition.Y - LegPosition.Y)
        BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y = BoxOutline.Size.Y / 2)
        BoxOutline.Visible - true

        Box.Size = Vector2.new(1000 / RootPosition.Z HeadPosition.Y - LegPosition.Y)
        Box.Position - Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y = Box.Size.Y / 2)
        Box.Visible = true
      else
        BoxOutline.Visible - false
        Box.Visible = false
      end
    else
      BoxOutline.Visible - false
      Box.Visible = false
    end
  end)
end
coroutine.wrap(boxesp)()
end)