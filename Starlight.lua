local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Starlight Hub",
   Icon = 0,
   LoadingTitle = "Starlight Hub (alpha)",
   LoadingSubtitle = "by Kill",
   ShowText = "SH",
   Theme = "Default",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Stardih Hub"
   },

   Discord = {
      Enabled = true,
      Invite = "CKQhaex8NN",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local MainTab = Window:CreateTab("Main", nil)
local MainSection = MainTab:CreateSection("Home")

Rayfield:Notify({
   Title = "Sucessfully Executed",
   Content = "Touch grass",
   Duration = 5,
   Image = nil,
})

local Input = MainTab:CreateInput({
   Name = "Walkspeed",
   CurrentValue = "16",
   PlaceholderText = "16-300",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
      local num = tonumber(Text)
      if num then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = num
      end
   end,
})

local Input = MainTab:CreateInput({
   Name = "JumpPower",
   CurrentValue = "50",
   PlaceholderText = "50-200",
   RemoveTextAfterFocusLost = false,
   Flag = "Input2",
   Callback = function(Text)
      local num = tonumber(Text)
      if num then
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = num
      end
   end,
})

-- Infinite Jump
local infJump = false
local Toggle = MainTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      infJump = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if infJump then
      game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- Xray (ignores players, tools, and accessories)
local Toggle = MainTab:CreateToggle({
   Name = "Xray",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
      for _, part in ipairs(workspace:GetDescendants()) do
         if part:IsA("BasePart") then
            local inPlayer = false

            for _, player in pairs(game.Players:GetPlayers()) do
               if player.Character and part:IsDescendantOf(player.Character) then
                  inPlayer = true
                  break
               end
               if player.Backpack and part:IsDescendantOf(player.Backpack) then
                  inPlayer = true
                  break
               end
            end

            -- skip accessories, tools, or handle parts
            if part:IsDescendantOf(game.Players) or part.Parent:IsA("Accessory") or part.Parent:IsA("Tool") then
               inPlayer = true
            end

            if not inPlayer then
               if Value then
                  part.LocalTransparencyModifier = 0.7
               else
                  part.LocalTransparencyModifier = 0
               end
            end
         end
      end
   end,
})

