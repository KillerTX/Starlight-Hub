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

local MainTab = Window:CreateTab("Visuals", nil)
local MainSection = MainTab:CreateSection("ESP")

local MurdererLabel = Tab:CreateLabel("Murderer is: Unknown")
local SheriffLabel = Tab:CreateLabel("Sheriff is: Unknown")

-- Function to check and update the roles based on tools in players' backpacks
local function updateRolesInfo()
    while true do
        local players = game:GetService("Players"):GetPlayers()
        local murderer, sheriff = "Unknown", "Unknown"

        for _, player in ipairs(players) do
            if player.Character then
                local backpack = player.Backpack
                if backpack then
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            if tool.Name == "Knife" then
                                murderer = player.Name
                            elseif tool.Name == "Gun" then
                                sheriff = player.Name
                            end
                        end
                    end
                end
            end
        end

        MurdererLabel:Set("Murderer is: " .. murderer)
        SheriffLabel:Set("Sheriff is: " .. sheriff)

        wait(1)
    end
end

-- Start updating the Murderer and Sheriff information
coroutine.wrap(updateRolesInfo)()

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP Holder"
ESPFolder.Parent = game.CoreGui

local function AddBillboard(player)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = player.Name .. "Billboard"
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.new(0, 200, 0, 50)
    Billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    Billboard.Enabled = false
    Billboard.Parent = ESPFolder

    local TextLabel = Instance.new("TextLabel")
    TextLabel.TextSize = 20
    TextLabel.Text = player.Name
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    TextLabel.Parent = Billboard

    repeat
        wait()
        pcall(function()
            Billboard.Adornee = player.Character.Head
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                TextLabel.TextColor3 = Color3.new(1, 0, 0)
                if getgenv().MurderEsp then
                    Billboard.Enabled = true
                end
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                TextLabel.TextColor3 = Color3.new(0, 0, 1)
                if getgenv().SheriffEsp then
                    Billboard.Enabled = true
                end
            else
                TextLabel.TextColor3 = Color3.new(0, 1, 0)
                if getgenv().AllEsp then
                    Billboard.Enabled = true
                end
            end
        end)
    until not player.Parent
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local billboard = ESPFolder:FindFirstChild(player.Name .. "Billboard")
    if billboard then
        billboard:Destroy()
    end
end)

local ToggleAllESP = Tab:CreateToggle({
    Name = "Everyone",
    CurrentValue = false,
    Flag = "AllESP",
    Callback = function(state)
        getgenv().AllEsp = state
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and player.Character then
                    local hasKnife = player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
                    local hasGun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
                    if not (hasKnife or hasGun) then
                        billboard.Enabled = state
                    end
                end
            end
        end
    end,
})



local ToggleMurderESP = Tab:CreateToggle({
    Name = "Murderer",
    CurrentValue = false,
    Flag = "MurderESP",
    Callback = function(state)
        getgenv().MurderEsp = state
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and (player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")) then
                    billboard.Enabled = state
                end
            end
        end
    end,
})

local ToggleSheriffESP = Tab:CreateToggle({
    Name = "Sheriff",
    CurrentValue = false,
    Flag = "SheriffESP",
    Callback = function(state)
        getgenv().SheriffEsp = state
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and (player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")) then
                    billboard.Enabled = state
                end
            end
        end
    end,
})
