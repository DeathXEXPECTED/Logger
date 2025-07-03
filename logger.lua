local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "JoinLeaveLogger"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = screenGui

-- Scrollable container
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -20, 1, -20)
scrollingFrame.Position = UDim2.new(0, 10, 0, 10)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.Parent = frame

local uiList = Instance.new("UIListLayout", scrollingFrame)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 4)

-- Utility: Add log entry as selectable TextBox
local function addLogEntry(text)
    local timestamp = os.date("[%H:%M:%S] ")
    local logBox = Instance.new("TextBox")
    logBox.Size = UDim2.new(1, 0, 0, 24)
    logBox.BackgroundTransparency = 1
    logBox.TextColor3 = Color3.new(1, 1, 1)
    logBox.Font = Enum.Font.SourceSans
    logBox.TextSize = 16
    logBox.TextXAlignment = Enum.TextXAlignment.Left
    logBox.Text = timestamp .. text
    logBox.ClearTextOnFocus = false
    logBox.TextEditable = false  -- Makes it selectable but not editable
    logBox.Parent = scrollingFrame

    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiList.AbsoluteContentSize.Y)
end

-- Player joined
Players.PlayerAdded:Connect(function(player)
    addLogEntry(player.Name .. " has joined the server.")
end)

-- Player left
Players.PlayerRemoving:Connect(function(player)
    addLogEntry(player.Name .. " has left the server.")
end)

-- Toggle GUI with "K"
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.K then
        frame.Visible = not frame.Visible
    end
end)
