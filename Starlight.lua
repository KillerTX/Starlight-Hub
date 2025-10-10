local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
      Name = "Starlight Hub",
      LoadingTitle = "Starlight Hub (alpha)",
                                     LoadingSubtitle = "by Kill",
                                     Theme = "Default",
                                     ToggleUIKeybind = "K",
                                     ConfigurationSaving = {
                                           Enabled = true,
                                           FileName = "StarlightHub"
                                     },
                                     Discord = {
                                           Enabled = true,
                                     Invite = "CKQhaex8NN",
                                     RememberJoins = true
                                     },
})

local MainTab = Window:CreateTab("Main")
local MainSection = MainTab:CreateSection("Home")

Rayfield:Notify({
      Title = "Successfully Executed",
      Content = "Touch grass 🌿",
      Duration = 5,
})

-- Walkspeed input
MainTab:CreateInput({
      Name = "Walkspeed",
      CurrentValue = "16",
      PlaceholderText = "16-300",
      Callback = function(Text)
      local num = tonumber(Text)
      if num then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = num
            end
            end,
})

-- JumpPower input
MainTab:CreateInput({
      Name = "JumpPower",
      CurrentValue = "50",
      PlaceholderText = "50-200",
      Callback = function(Text)
      local num = tonumber(Text)
      if num then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = num
            end
            end,
})

-- Infinite Jump toggle
local infJumpEnabled = false
MainTab:CreateToggle({
      Name = "Infinite Jump",
      CurrentValue = false,
      Callback = function(Value)
      infJumpEnabled = Value
      end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
if infJumpEnabled then
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
            end
            end)

-- Xray toggle
local xrayEnabled = false
MainTab:CreateToggle({
      Name = "Xray",
      CurrentValue = false,
      Callback = function(Value)
      xrayEnabled = Value
      for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                  if Value then
                        part.LocalTransparencyModifier = 0.7
                        else
                              part.LocalTransparencyModifier = 0
                              end
                              end
                              end
                              end,
})



