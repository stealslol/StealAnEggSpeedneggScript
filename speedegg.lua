local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "StealsLolGUI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 250)
frame.Position = UDim2.new(0.5, -100, 0.5, -125)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "MADE BY STEALS LOL"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.Parent = frame

local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Скорость:"
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0, 35)
speedLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextScaled = true
speedLabel.Parent = frame

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.8, 0, 0, 25)
speedBox.Position = UDim2.new(0.1, 0, 0, 60)
speedBox.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextScaled = true
speedBox.Parent = frame

local eggListLabel = Instance.new("TextLabel")
eggListLabel.Text = "Выберите яйца:"
eggListLabel.Size = UDim2.new(1, 0, 0, 20)
eggListLabel.Position = UDim2.new(0, 0, 0, 100)
eggListLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
eggListLabel.TextColor3 = Color3.new(1, 1, 1)
eggListLabel.Font = Enum.Font.SourceSans
eggListLabel.TextScaled = true
eggListLabel.Parent = frame

local eggScrollingFrame = Instance.new("ScrollingFrame")
eggScrollingFrame.Size = UDim2.new(0.8, 0, 0, 80)
eggScrollingFrame.Position = UDim2.new(0.1, 0, 0, 125)
eggScrollingFrame.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
eggScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
eggScrollingFrame.Parent = frame

local spawnButton = Instance.new("TextButton")
spawnButton.Text = "Спавнить выбранные яйца"
spawnButton.Size = UDim2.new(0.8, 0, 0, 30)
spawnButton.Position = UDim2.new(0.1, 0, 0, 220)
spawnButton.BackgroundColor3 = Color3.new(0.1, 0.5, 0.1)
spawnButton.TextColor3 = Color3.new(1, 1, 1)
spawnButton.Font = Enum.Font.SourceSansBold
spawnButton.TextScaled = true
spawnButton.Parent = frame

local petEggsFolder = game:GetService("Workspace"):FindFirstChild("PetEggs")
local eggTypes = {}
if petEggsFolder then
    for _, egg in pairs(petEggsFolder:GetChildren()) do
        table.insert(eggTypes, egg.Name)
    end
end

local checkboxInstances = {}
local yOffset = 0
for _, eggName in pairs(eggTypes) do
    local checkbox = Instance.new("TextButton")
    checkbox.Text = eggName
    checkbox.Size = UDim2.new(1, 0, 0, 20)
    checkbox.Position = UDim2.new(0, 0, 0, yOffset)
    checkbox.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    checkbox.TextColor3 = Color3.new(1, 1, 1)
    checkbox.Font = Enum.Font.SourceSans
    checkbox.TextScaled = true
    checkbox.Parent = eggScrollingFrame
    checkbox.MouseButton1Click:Connect(function()
        checkbox.BackgroundColor3 = checkbox.BackgroundColor3 == Color3.new(0.5, 0.5, 0.5) and Color3.new(0.1, 0.7, 0.1) or Color3.new(0.5, 0.5, 0.5)
    end)
    checkboxInstances[eggName] = checkbox
    yOffset = yOffset + 25
end
eggScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)

local function setSpeed()
    local speed = tonumber(speedBox.Text)
    if speed then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

local function spawnSelectedEggs()
    for eggName, checkbox in pairs(checkboxInstances) do
        if checkbox.BackgroundColor3 == Color3.new(0.1, 0.7, 0.1) then
            local egg = petEggsFolder:FindFirstChild(eggName)
            if egg then
                egg:Clone().Parent = petEggsFolder
            end
        end
    end
end

speedBox.FocusLost:Connect(setSpeed)
spawnButton.MouseButton1Click:Connect(spawnSelectedEggs)

gui.ResetOnSpawn = false
