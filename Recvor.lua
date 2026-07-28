-- ============================================
--  RECVOR HUB |
--  GitHub: https://github.com/HuBs3/Hub-recvor
--  Автор: HuBs3
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Настройки
local Settings = {
    FlySpeed = 50,
    FlyEnabled = false,
    Noclip = false,
    SpeedHack = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Invisibility = false,
    ESP = false,
    ClickTeleport = false,
    AntiAFK = true,
    FlyMobile = false
}

-- ========== GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RecvorHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 480)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Градиент фона
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
})
MainGradient.Parent = MainFrame

-- Тень
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.ZIndex = -1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

-- Логотип RECVOR
local LogoText = Instance.new("TextLabel")
LogoText.Name = "Logo"
LogoText.Size = UDim2.new(0, 100, 1, 0)
LogoText.Position = UDim2.new(0, 15, 0, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "RECVOR"
LogoText.TextColor3 = Color3.fromRGB(0, 200, 255)
LogoText.TextSize = 22
LogoText.Font = Enum.Font.GothamBlack
LogoText.TextXAlignment = Enum.TextXAlignment.Left
LogoText.Parent = TitleBar

-- Подсветка логотипа
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(0, 150, 255)
LogoStroke.Thickness = 1
LogoStroke.Parent = LogoText

-- Кнопка сворачивания (кружок)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -68, 0.5, -14)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
MinimizeBtn.Text = ""
MinimizeBtn.AutoButtonColor = false
MinimizeBtn.Parent = TitleBar

Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0.5, 0)

-- Кнопка закрытия (кружок)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
CloseBtn.Text = ""
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TitleBar

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0.5, 0)

-- Индикатор сворачивания (линия сверху)
local TopIndicator = Instance.new("Frame")
TopIndicator.Name = "TopIndicator"
TopIndicator.Size = UDim2.new(0, 60, 0, 4)
TopIndicator.Position = UDim2.new(0.5, -30, 0, 6)
TopIndicator.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
TopIndicator.BorderSizePixel = 0
TopIndicator.Visible = false
TopIndicator.ZIndex = 10
TopIndicator.Parent = ScreenGui

Instance.new("UICorner", TopIndicator).CornerRadius = UDim.new(0.5, 0)

-- Контент
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 3
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ContentFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.Parent = ContentFrame

-- ========== ФУНКЦИИ СОЗДАНИЯ ЭЛЕМЕНТОВ ==========

local function CreateDivider(text)
    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1, 0, 0, 30)
    Div.BackgroundTransparency = 1
    Div.Parent = ContentFrame
    
    local Line1 = Instance.new("Frame")
    Line1.Size = UDim2.new(0.3, 0, 0, 1)
    Line1.Position = UDim2.new(0, 0, 0.5, 0)
    Line1.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Line1.BorderSizePixel = 0
    Line1.Parent = Div
    
    local Line2 = Instance.new("Frame")
    Line2.Size = UDim2.new(0.3, 0, 0, 1)
    Line2.Position = UDim2.new(0.7, 0, 0.5, 0)
    Line2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Line2.BorderSizePixel = 0
    Line2.Parent = Div
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Position = UDim2.new(0.3, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(120, 120, 150)
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Div
end

local function CreateToggle(name, settingKey, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentFrame
    
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 12)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.55, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 240)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    -- Переключатель (toggle switch)
    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0, 50, 0, 26)
    SwitchFrame.Position = UDim2.new(1, -65, 0.5, -13)
    SwitchFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Parent = ToggleFrame
    
    Instance.new("UICorner", SwitchFrame).CornerRadius = UDim.new(0.5, 0)
    
    local SwitchCircle = Instance.new("Frame")
    SwitchCircle.Size = UDim2.new(0, 22, 0, 22)
    SwitchCircle.Position = UDim2.new(0, 2, 0.5, -11)
    SwitchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchCircle.BorderSizePixel = 0
    SwitchCircle.Parent = SwitchFrame
    
    Instance.new("UICorner", SwitchCircle).CornerRadius = UDim.new(0.5, 0)
    
    local ClickArea = Instance.new("TextButton")
    ClickArea.Size = UDim2.new(1, 0, 1, 0)
    ClickArea.BackgroundTransparency = 1
    ClickArea.Text = ""
    ClickArea.Parent = SwitchFrame
    
    local isOn = false
    
    local function UpdateSwitch()
        if isOn then
            TweenService:Create(SwitchFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(0, 230, 118)
            }):Play()
            TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 26, 0.5, -11)
            }):Play()
        else
            TweenService:Create(SwitchFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            }):Play()
            TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -11)
            }):Play()
        end
    end
    
    ClickArea.MouseButton1Click:Connect(function()
        isOn = not isOn
        Settings[settingKey] = isOn
        UpdateSwitch()
        if callback then callback(isOn) end
    end)
    
    return ClickArea, function() return isOn end
end

local function CreateSlider(name, settingKey, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 65)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = ContentFrame
    
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 12)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0, 25)
    Label.Position = UDim2.new(0, 15, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(220, 220, 240)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.2, 0, 0, 25)
    ValueLabel.Position = UDim2.new(0.75, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    ValueLabel.TextSize = 14
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -30, 0, 8)
    SliderBg.Position = UDim2.new(0, 15, 0, 38)
    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame
    
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 4)
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 4)
    
    local SliderKnob = Instance.new("TextButton")
    SliderKnob.Name = "Knob"
    SliderKnob.Size = UDim2.new(0, 20, 0, 20)
    SliderKnob.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderKnob.Text = ""
    SliderKnob.AutoButtonColor = false
    SliderKnob.Parent = SliderBg
    
    Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(0.5, 0)
    
    local KnobStroke = Instance.new("UIStroke")
    KnobStroke.Color = Color3.fromRGB(0, 200, 255)
    KnobStroke.Thickness = 2
    KnobStroke.Parent = SliderKnob
    
    local dragging = false
    
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        Settings[settingKey] = value
        Label.Text = name .. ": " .. value
        ValueLabel.Text = tostring(value)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        SliderKnob.Position = UDim2.new(pos, -10, 0.5, -10)
        return value
    end
    
    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            TweenService:Create(SliderKnob, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 24, 0, 24),
                Position = UDim2.new(SliderKnob.Position.X.Scale, SliderKnob.Position.X.Offset - 2, 0.5, -12)
            }):Play()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            TweenService:Create(SliderKnob, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(SliderKnob.Position.X.Scale, SliderKnob.Position.X.Offset + 2, 0.5, -10)
            }):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
    
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            UpdateSlider(input)
        end
    end)
    
    Settings[settingKey] = default
end

-- ========== СОЗДАНИЕ ЭЛЕМЕНТОВ МЕНЮ ==========

CreateDivider("ДВИЖЕНИЕ")

CreateToggle("🚀 Fly (Полёт)", "FlyEnabled", function(isOn)
    if isOn then StartFly() else StopFly() end
end)

CreateToggle("📱 Fly Mobile", "FlyMobile", function(isOn)
    if isOn and Settings.FlyEnabled then
        StartMobileFly()
    elseif not isOn then
        StopMobileFly()
    end
end)

CreateToggle("👻 Noclip", "Noclip", function(isOn)
    if isOn then StartNoclip() else StopNoclip() end
end)

CreateToggle("⚡ Speed Hack", "SpeedHack", function(isOn)
    if isOn then
        Humanoid.WalkSpeed = Settings.WalkSpeed * 3
    else
        Humanoid.WalkSpeed = Settings.WalkSpeed
    end
end)

CreateDivider("СКОРОСТЬ")

CreateSlider("Скорость полёта", "FlySpeed", 10, 300, 50)
CreateSlider("Скорость ходьбы", "WalkSpeed", 16, 200, 16)
CreateSlider("Сила прыжка", "JumpPower", 50, 200, 50)

CreateDivider("ДОПОЛНИТЕЛЬНО")

CreateToggle("👁️ Невидимость", "Invisibility", function(isOn)
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            if part.Name == "Head" then
                part.Transparency = isOn and 0.7 or 0
            else
                part.Transparency = isOn and 0.9 or 0
            end
        elseif part:IsA("Decal") then
            part.Transparency = isOn and 1 or 0
        end
    end
    if not isOn then
        local head = Character:FindFirstChild("Head")
        if head then
            head.Transparency = 0
            local face = head:FindFirstChild("face")
            if face then face.Transparency = 0 end
        end
    end
end)

CreateToggle("🖱️ Click Teleport", "ClickTeleport")
CreateToggle("☕ Anti AFK", "AntiAFK")
CreateToggle("👤 ESP", "ESP", function(isOn)
    if isOn then StartESP() else StopESP() end
end)

-- ========== ЛОГИКА ПОЛЁТА (ПК) ==========
local FlyConnection, FlyBodyVelocity, FlyBodyGyro

function StartFly()
    if FlyConnection then return end
    
    local BV = Instance.new("BodyVelocity")
    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BV.Velocity = Vector3.new(0, 0, 0)
    BV.Parent = HumanoidRootPart
    FlyBodyVelocity = BV
    
    local BG = Instance.new("BodyGyro")
    BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    BG.P = 10000
    BG.Parent = HumanoidRootPart
    FlyBodyGyro = BG
    
    local camera = workspace.CurrentCamera
    
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not Settings.FlyEnabled then return end
        local direction = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end
        
        if direction.Magnitude > 0 then direction = direction.Unit * Settings.FlySpeed end
        BV.Velocity = direction
        BG.CFrame = camera.CFrame
    end)
    
    Notify("🚀 Fly включён", "WASD + Space/Shift")
end

function StopFly()
    if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    if FlyBodyVelocity then FlyBodyVelocity:Destroy() FlyBodyVelocity = nil end
    if FlyBodyGyro then FlyBodyGyro:Destroy() FlyBodyGyro = nil end
    StopMobileFly()
    Notify("🚀 Fly выключен", "")
end

-- ========== МОБИЛЬНЫЙ ПОЛЁТ (Джойстик) ==========
local MobileFlyGui, MobileFlyConnection

function StartMobileFly()
    if MobileFlyGui then MobileFlyGui:Destroy() end
    
    MobileFlyGui = Instance.new("ScreenGui")
    MobileFlyGui.Name = "MobileFly"
    MobileFlyGui.Parent = CoreGui
    MobileFlyGui.ResetOnSpawn = false
    
    -- Джойстик внизу слева
    local JoystickFrame = Instance.new("Frame")
    JoystickFrame.Size = UDim2.new(0, 150, 0, 150)
    JoystickFrame.Position = UDim2.new(0, 30, 1, -180)
    JoystickFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    JoystickFrame.BackgroundTransparency = 0.5
    JoystickFrame.BorderSizePixel = 0
    JoystickFrame.Parent = MobileFlyGui
    
    Instance.new("UICorner", JoystickFrame).CornerRadius = UDim.new(0.5, 0)
    
    local JoystickKnob = Instance.new("Frame")
    JoystickKnob.Size = UDim2.new(0, 50, 0, 50)
    JoystickKnob.Position = UDim2.new(0.5, -25, 0.5, -25)
    JoystickKnob.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    JoystickKnob.BorderSizePixel = 0
    JoystickKnob.Parent = JoystickFrame
    
    Instance.new("UICorner", JoystickKnob).CornerRadius = UDim.new(0.5, 0)
    
    -- Кнопки вверх/вниз справа
    local UpBtn = Instance.new("TextButton")
    UpBtn.Size = UDim2.new(0, 60, 0, 60)
    UpBtn.Position = UDim2.new(1, -90, 1, -150)
    UpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    UpBtn.Text = "↑"
    UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    UpBtn.TextSize = 30
    UpBtn.Font = Enum.Font.GothamBold
    UpBtn.Parent = MobileFlyGui
    
    Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0.5, 0)
    
    local DownBtn = Instance.new("TextButton")
    DownBtn.Size = UDim2.new(0, 60, 0, 60)
    DownBtn.Position = UDim2.new(1, -90, 1, -80)
    DownBtn.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
    DownBtn.Text = "↓"
    DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DownBtn.TextSize = 30
    DownBtn.Font = Enum.Font.GothamBold
    DownBtn.Parent = MobileFlyGui
    
    Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0.5, 0)
    
    -- Логика джойстика
    local joystickDragging = false
    local joystickStartPos = Vector2.new(0, 0)
    local moveDirection = Vector3.new(0, 0, 0)
    local verticalDirection = 0
    
    JoystickFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            joystickDragging = true
            joystickStartPos = Vector2.new(input.Position.X, input.Position.Y)
        end
    end)
    
    JoystickFrame.InputChanged:Connect(function(input)
        if joystickDragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - joystickStartPos
            local maxDist = 40
            local dist = math.min(delta.Magnitude, maxDist)
            local angle = math.atan2(delta.Y, delta.X)
            
            local knobX = math.cos(angle) * dist
            local knobY = math.sin(angle) * dist
            
            JoystickKnob.Position = UDim2.new(0.5, knobX - 25, 0.5, knobY - 25)
            
            local camera = workspace.CurrentCamera
            moveDirection = (camera.CFrame.LookVector * -knobY / maxDist + camera.CFrame.RightVector * knobX / maxDist) * Settings.FlySpeed
        end
    end)
    
    JoystickFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            joystickDragging = false
            JoystickKnob.Position = UDim2.new(0.5, -25, 0.5, -25)
            moveDirection = Vector3.new(0, 0, 0)
        end
    end)
    
    UpBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            verticalDirection = 1
        end
    end)
    
    UpBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            verticalDirection = 0
        end
    end)
    
    DownBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            verticalDirection = -1
        end
    end)
    
    DownBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            verticalDirection = 0
        end
    end)
    
    -- Обновление полёта
    MobileFlyConnection = RunService.RenderStepped:Connect(function()
        if not Settings.FlyEnabled then return end
        local totalDirection = moveDirection + Vector3.new(0, verticalDirection * Settings.FlySpeed * 0.5, 0)
        if FlyBodyVelocity then
            FlyBodyVelocity.Velocity = totalDirection
        end
    end)
end

function StopMobileFly()
    if MobileFlyGui then
        MobileFlyGui:Destroy()
        MobileFlyGui = nil
    end
    if MobileFlyConnection then
        MobileFlyConnection:Disconnect()
        MobileFlyConnection = nil
    end
end

-- ========== NOCLIP ==========
local NoclipConnection

function StartNoclip()
    NoclipConnection = RunService.Stepped:Connect(function()
        if Settings.Noclip and Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

function StopNoclip()
    if NoclipConnection then NoclipConnection:Disconnect() NoclipConnection = nil end
    if Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- ========== ESP ==========
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP_Folder"
ESPFolder.Parent = CoreGui
local ESPConnections = {}

function StartESP()
    local function CreateESP(player)
        if player == LocalPlayer then return end
        local espFrame = Instance.new("BillboardGui")
        espFrame.Name = player.Name .. "_ESP"
        espFrame.AlwaysOnTop = true
        espFrame.Size = UDim2.new(0, 100, 0, 40)
        espFrame.StudsOffset = Vector3.new(0, 3, 0)
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = espFrame
        
        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "0 studs"
        distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLabel.TextSize = 12
        distLabel.Font = Enum.Font.Gotham
        distLabel.Parent = espFrame
        
        espFrame.Parent = ESPFolder
        
        local conn = RunService.RenderStepped:Connect(function()
            if not player.Character or not Settings.ESP then
                espFrame.Enabled = false
                return
            end
            local head = player.Character:FindFirstChild("Head")
            if head then
                espFrame.Adornee = head
                espFrame.Enabled = true
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
                distLabel.Text = math.floor(distance) .. " studs"
                nameLabel.TextColor3 = (player.Team == LocalPlayer.Team) and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            else
                espFrame.Enabled = false
            end
        end)
        
        ESPConnections[player] = {espFrame, conn}
    end
    
    for _, player in pairs(Players:GetPlayers()) do CreateESP(player) end
    Players.PlayerAdded:Connect(CreateESP)
end

function StopESP()
    for _, data in pairs(ESPConnections) do
        if data[2] then data[2]:Disconnect() end
        if data[1] then data[1]:Destroy() end
    end
    ESPConnections = {}
    ESPFolder:ClearAllChildren()
end

-- ========== CLICK TP & ANTI AFK ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Settings.ClickTeleport and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mouse = LocalPlayer:GetMouse()
        HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
    end
end)

if Settings.AntiAFK then
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- ========== УВЕДОМЛЕНИЯ ==========
function Notify(title, text)
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 300, 0, 75)
    NotifFrame.Position = UDim2.new(1, 20, 1, -100)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = ScreenGui
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 12)
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = Color3.fromRGB(0, 200, 255)
    NotifStroke.Thickness = 1
    NotifStroke.Parent = NotifFrame
    
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, -20, 0, 28)
    NotifTitle.Position = UDim2.new(0, 10, 0, 8)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    NotifTitle.TextSize = 16
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.Parent = NotifFrame
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 0, 30)
    NotifText.Position = UDim2.new(0, 10, 0, 35)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(200, 200, 220)
    NotifText.TextSize = 13
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextWrapped = true
    NotifText.Parent = NotifFrame
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -320, 1, -100)
    }):Play()
    
    task.delay(3, function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            Position = UDim2.new(1, 20, 1, -100)
        }):Play()
        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

-- ========== СВОРАЧИВАНИЕ / РАЗВОРАЧИВАНИЕ ==========

-- Кружок для открытия (плавающий)
local OpenCircle = Instance.new("TextButton")
OpenCircle.Name = "OpenCircle"
OpenCircle.Size = UDim2.new(0, 55, 0, 55)
OpenCircle.Position = UDim2.new(0.5, -27, 0, -60)
OpenCircle.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
OpenCircle.Text = "R"
OpenCircle.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCircle.TextSize = 24
OpenCircle.Font = Enum.Font.GothamBlack
OpenCircle.Visible = false
OpenCircle.AutoButtonColor = false
OpenCircle.Parent = ScreenGui

Instance.new("UICorner", OpenCircle).CornerRadius = UDim.new(0.5, 0)

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(100, 230, 255)
CircleStroke.Thickness = 2
CircleStroke.Parent = OpenCircle

-- Анимация пульсации
task.spawn(function()
    while OpenCircle do
        if OpenCircle.Visible then
            TweenService:Create(OpenCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 60, 0, 60),
                Position = UDim2.new(OpenCircle.Position.X.Scale, OpenCircle.Position.X.Offset - 2.5, OpenCircle.Position.Y.Scale, OpenCircle.Position.Y.Offset - 2.5)
            }):Play()
            task.wait(1)
            TweenService:Create(OpenCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 55, 0, 55),
                Position = UDim2.new(OpenCircle.Position.X.Scale, OpenCircle.Position.X.Offset + 2.5, OpenCircle.Position.Y.Scale, OpenCircle.Position.Y.Offset + 2.5)
            }):Play()
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)

-- Перетаскивание кружка
local circleDragging = false
local circleDragStart = Vector2.new(0, 0)
local circleStartPos = UDim2.new(0, 0, 0, 0)

OpenCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        circleDragging = true
        circleDragStart = Vector2.new(input.Position.X, input.Position.Y)
        circleStartPos = OpenCircle.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if circleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - circleDragStart
        local newX = circleStartPos.X.Offset + delta.X
        local newY = circleStartPos.Y.Offset + delta.Y
        
        -- Ограничения по экрану
        local screenSize = workspace.CurrentCamera.ViewportSize
        newX = math.clamp(newX, 0, screenSize.X - 55)
        newY = math.clamp(newY, -60, screenSize.Y - 55)
        
        OpenCircle.Position = UDim2.new(0, newX, 0, newY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if circleDragging then
            circleDragging = false
            -- Прилипание к верху если близко
            if OpenCircle.Position.Y.Offset < 10 then
                TweenService:Create(OpenCircle, TweenInfo.new(0.3), {
                    Position = UDim2.new(OpenCircle.Position.X.Scale, OpenCircle.Position.X.Offset, 0, -5)
                }):Play()
                TopIndicator.Visible = true
            else
                TopIndicator.Visible = false
            end
        end
    end
end)

-- Сворачивание
MinimizeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0.5, -170, 0, -500)
    }):Play()
    task.wait(0.4)
    MainFrame.Visible = false
    OpenCircle.Visible = true
    OpenCircle.Position = UDim2.new(0.5, -27, 0, 20)
end)

-- Разворачивание по клику на кружок
OpenCircle.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0.5, -170, 0.5, -240)
    }):Play()
    OpenCircle.Visible = false
    TopIndicator.Visible = false
end)

-- Разворачивание свайпом вниз
local swipeStartY = 0
local isSwiping = false

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        swipeStartY = input.Position.Y
        isSwiping = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and isSwiping then
        local deltaY = input.Position.Y - swipeStartY
        -- Если свайп вниз сверху экрана и меню свёрнуто
        if deltaY > 50 and swipeStartY < 50 and not MainFrame.Visible then
            MainFrame.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0.5, -170, 0.5, -240)
            }):Play()
            OpenCircle.Visible = false
            TopIndicator.Visible = false
        end
        isSwiping = false
    end
end)

-- Закрытие
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    StopFly()
    StopNoclip()
    StopESP()
    StopMobileFly()
end)

-- Hotkey RightShift
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        if MainFrame.Visible then
            MinimizeBtn.MouseButton1Click:Fire()
        else
            OpenCircle.MouseButton1Click:Fire()
        end
    end
end)

-- ========== РЕСПАВН ==========
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    Humanoid.WalkSpeed = Settings.SpeedHack and Settings.WalkSpeed * 3 or Settings.WalkSpeed
    Humanoid.JumpPower = Settings.JumpPower
    
    if Settings.FlyEnabled then
        StopFly()
        task.wait(0.5)
        StartFly()
        if Settings.FlyMobile then
            StartMobileFly()
        end
    end
end)

-- ========== ИНИЦИАЛИЗАЦИЯ ==========
Notify("🔥 RECVOR HUB", "Добро пожаловать! RightShift — скрыть/показать")

print("✅ RECVOR HUB загружен!")
print("GitHub: https://github.com/HuBs3/Hub-recvor")
