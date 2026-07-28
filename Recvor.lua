-- ============================================
--  RECVOR HUB v4.0 | One Button Fly + Jerk Animation
--  GitHub: https://github.com/HuBs3/Hub-recvor
--  Author: HuBs3
-- ============================================

settings().Rendering.QualityLevel = 1
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Языки
local Lang = {
    RU = {
        movement = "ДВИЖЕНИЕ",
        fly = "🚀 Fly (Полёт)",
        noclip = "👻 Noclip",
        speed = "⚡ Speed Hack",
        speedSettings = "СКОРОСТЬ",
        flySpeed = "Скорость полёта",
        walkSpeed = "Скорость ходьбы",
        jumpPower = "Сила прыжка",
        extra = "ДОПОЛНИТЕЛЬНО",
        invisible = "👁️ Невидимость",
        clickTP = "🖱️ Click Teleport",
        antiAFK = "☕ Anti AFK",
        esp = "👤 ESP",
        special = "SPECIAL",
        jerkOff = "🗡️ Взять Sword Jerk",
        settings = "НАСТРОЙКИ",
        transparency = "Прозрачность окна",
        language = "Язык",
        restart = "🔄 Перезапустить Hub",
        flyOn = "🚀 Fly включён",
        flyOff = "🚀 Fly выключен",
        welcome = "Добро пожаловать!",
        menuToggle = "RightShift — меню",
        jerkAdded = "Добавлен в инвентарь!"
    },
    EN = {
        movement = "MOVEMENT",
        fly = "🚀 Fly",
        noclip = "👻 Noclip",
        speed = "⚡ Speed Hack",
        speedSettings = "SPEED",
        flySpeed = "Fly Speed",
        walkSpeed = "Walk Speed",
        jumpPower = "Jump Power",
        extra = "EXTRA",
        invisible = "👁️ Invisibility",
        clickTP = "🖱️ Click Teleport",
        antiAFK = "☕ Anti AFK",
        esp = "👤 ESP",
        special = "SPECIAL",
        jerkOff = "🗡️ Get Sword Jerk",
        settings = "SETTINGS",
        transparency = "Window Transparency",
        language = "Language",
        restart = "🔄 Restart Hub",
        flyOn = "🚀 Fly ON",
        flyOff = "🚀 Fly OFF",
        welcome = "Welcome!",
        menuToggle = "RightShift — menu",
        jerkAdded = "Added to inventory!"
    }
}

local CurrentLang = Lang.RU

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
    Transparency = 0,
    CurrentLang = "RU",
    JerkSpeed = 1.0
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
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

local LogoText = Instance.new("TextLabel")
LogoText.Name = "Logo"
LogoText.Size = UDim2.new(0, 100, 1, 0)
LogoText.Position = UDim2.new(0, 16, 0, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "RECVOR"
LogoText.TextColor3 = Color3.fromRGB(0, 200, 255)
LogoText.TextSize = 22
LogoText.Font = Enum.Font.GothamBlack
LogoText.TextXAlignment = Enum.TextXAlignment.Left
LogoText.Parent = TitleBar

-- Кнопка настроек
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Name = "SettingsBtn"
SettingsBtn.Size = UDim2.new(0, 28, 0, 28)
SettingsBtn.Position = UDim2.new(1, -96, 0.5, -14)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
SettingsBtn.Text = "⚙️"
SettingsBtn.TextSize = 16
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Parent = TitleBar

Instance.new("UICorner", SettingsBtn).CornerRadius = UDim.new(0.5, 0)

-- Сворачивание
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -64, 0.5, -14)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0.5, 0)

-- Закрытие
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0.5, 0)

-- Индикатор сверху
local TopIndicator = Instance.new("Frame")
TopIndicator.Name = "TopIndicator"
TopIndicator.Size = UDim2.new(0, 50, 0, 4)
TopIndicator.Position = UDim2.new(0.5, -25, 0, 8)
TopIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
TopIndicator.BorderSizePixel = 0
TopIndicator.Visible = false
TopIndicator.ZIndex = 10
TopIndicator.Parent = ScreenGui

Instance.new("UICorner", TopIndicator).CornerRadius = UDim.new(0.5, 0)

-- Основной контент
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, -16, 1, -54)
ContentFrame.Position = UDim2.new(0, 8, 0, 48)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 3
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.Parent = ContentFrame

local BottomPadding = Instance.new("Frame")
BottomPadding.Size = UDim2.new(1, 0, 0, 12)
BottomPadding.BackgroundTransparency = 1
BottomPadding.Parent = ContentFrame

-- ========== ОКНО НАСТРОЕК ==========
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(1, 0, 1, -44)
SettingsFrame.Position = UDim2.new(1, 0, 0, 44)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.ClipsDescendants = true
SettingsFrame.Parent = MainFrame

Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 16)

local SettingsContent = Instance.new("ScrollingFrame")
SettingsContent.Size = UDim2.new(1, -16, 1, -16)
SettingsContent.Position = UDim2.new(0, 8, 0, 8)
SettingsContent.BackgroundTransparency = 1
SettingsContent.ScrollBarThickness = 3
SettingsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsContent.Parent = SettingsFrame

local SettingsList = Instance.new("UIListLayout")
SettingsList.Padding = UDim.new(0, 10)
SettingsList.Parent = SettingsContent

local SettingsPadding = Instance.new("Frame")
SettingsPadding.Size = UDim2.new(1, 0, 0, 10)
SettingsPadding.BackgroundTransparency = 1
SettingsPadding.Parent = SettingsContent

-- Кнопка назад
local BackBtn = Instance.new("TextButton")
BackBtn.Name = "BackBtn"
BackBtn.Size = UDim2.new(0, 36, 0, 36)
BackBtn.Position = UDim2.new(0, 10, 0, 4)
BackBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
BackBtn.Text = "←"
BackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BackBtn.TextSize = 20
BackBtn.Font = Enum.Font.GothamBold
BackBtn.Visible = false
BackBtn.ZIndex = 5
BackBtn.Parent = TitleBar

Instance.new("UICorner", BackBtn).CornerRadius = UDim.new(0.5, 0)

-- ========== ФУНКЦИИ СОЗДАНИЯ ЭЛЕМЕНТОВ ==========

local function CreateDivider(text, parent)
    parent = parent or ContentFrame
    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1, 0, 0, 28)
    Div.BackgroundTransparency = 1
    Div.Parent = parent
    
    local Line1 = Instance.new("Frame")
    Line1.Size = UDim2.new(0.25, 0, 0, 1)
    Line1.Position = UDim2.new(0, 0, 0.5, 0)
    Line1.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Line1.BorderSizePixel = 0
    Line1.Parent = Div
    
    local Line2 = Instance.new("Frame")
    Line2.Size = UDim2.new(0.25, 0, 0, 1)
    Line2.Position = UDim2.new(0.75, 0, 0.5, 0)
    Line2.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Line2.BorderSizePixel = 0
    Line2.Parent = Div
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0.25, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(120, 120, 150)
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Div
    
    return Div
end

local function CreateToggle(name, settingKey, callback, parent)
    parent = parent or ContentFrame
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 48)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 12)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 240)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0, 48, 0, 26)
    SwitchFrame.Position = UDim2.new(1, -62, 0.5, -13)
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
    
    local function UpdateSwitch(animated)
        if animated == nil then animated = true end
        local duration = animated and 0.25 or 0
        
        if isOn then
            TweenService:Create(SwitchFrame, TweenInfo.new(duration, Enum.EasingStyle.Quart), {
                BackgroundColor3 = Color3.fromRGB(0, 230, 118)
            }):Play()
            TweenService:Create(SwitchCircle, TweenInfo.new(duration, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0, 24, 0.5, -11)
            }):Play()
        else
            TweenService:Create(SwitchFrame, TweenInfo.new(duration, Enum.EasingStyle.Quart), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            }):Play()
            TweenService:Create(SwitchCircle, TweenInfo.new(duration, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0, 2, 0.5, -11)
            }):Play()
        end
    end
    
    ClickArea.MouseButton1Click:Connect(function()
        isOn = not isOn
        Settings[settingKey] = isOn
        UpdateSwitch(true)
        if callback then callback(isOn) end
    end)
    
    return ToggleFrame, function() return isOn end, function(state) 
        isOn = state 
        UpdateSwitch(false)
    end
end

local function CreateSlider(name, settingKey, min, max, default, parent)
    parent = parent or ContentFrame
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 12)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 22)
    Label.Position = UDim2.new(0, 14, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(220, 220, 240)
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.2, 0, 0, 22)
    ValueLabel.Position = UDim2.new(0.78, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -28, 0, 6)
    SliderBg.Position = UDim2.new(0, 14, 0, 36)
    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame
    
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 3)
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 3)
    
    local SliderKnob = Instance.new("TextButton")
    SliderKnob.Size = UDim2.new(0, 18, 0, 18)
    SliderKnob.Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9)
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
    
    local function UpdateSlider(input, animated)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        Settings[settingKey] = value
        Label.Text = name .. ": " .. value
        ValueLabel.Text = tostring(value)
        
        local duration = animated and 0.15 or 0
        TweenService:Create(SliderFill, TweenInfo.new(duration), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
        TweenService:Create(SliderKnob, TweenInfo.new(duration), {Position = UDim2.new(pos, -9, 0.5, -9)}):Play()
        
        return value
    end
    
    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            TweenService:Create(SliderKnob, TweenInfo.new(0.15), {Size = UDim2.new(0, 22, 0, 22)}):Play()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            TweenService:Create(SliderKnob, TweenInfo.new(0.15), {Size = UDim2.new(0, 18, 0, 18)}):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input, false)
        end
    end)
    
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            UpdateSlider(input, true)
        end
    end)
    
    Settings[settingKey] = default
end

-- ========== СОЗДАНИЕ МЕНЮ ==========

CreateDivider(CurrentLang.movement)
CreateToggle(CurrentLang.fly, "FlyEnabled", function(isOn)
    if isOn then StartFly() else StopFly() end
end)

CreateToggle(CurrentLang.noclip, "Noclip", function(isOn)
    if isOn then StartNoclip() else StopNoclip() end
end)

CreateToggle(CurrentLang.speed, "SpeedHack", function(isOn)
    Humanoid.WalkSpeed = isOn and Settings.WalkSpeed * 3 or Settings.WalkSpeed
end)

CreateDivider(CurrentLang.speedSettings)
CreateSlider(CurrentLang.flySpeed, "FlySpeed", 10, 300, 50)
CreateSlider(CurrentLang.walkSpeed, "WalkSpeed", 16, 200, 16)
CreateSlider(CurrentLang.jumpPower, "JumpPower", 50, 200, 50)

CreateDivider(CurrentLang.extra)
CreateToggle(CurrentLang.invisible, "Invisibility", function(isOn)
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

CreateToggle(CurrentLang.clickTP, "ClickTeleport")
CreateToggle(CurrentLang.antiAFK, "AntiAFK")
CreateToggle(CurrentLang.esp, "ESP", function(isOn)
    if isOn then StartESP() else StopESP() end
end)

CreateDivider(CurrentLang.special)
local JerkBtn = Instance.new("TextButton")
JerkBtn.Size = UDim2.new(1, 0, 0, 48)
JerkBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 150)
JerkBtn.Text = CurrentLang.jerkOff
JerkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JerkBtn.TextSize = 13
JerkBtn.Font = Enum.Font.GothamBold
JerkBtn.Parent = ContentFrame

Instance.new("UICorner", JerkBtn).CornerRadius = UDim.new(0, 12)

JerkBtn.MouseButton1Click:Connect(function()
    GiveSwordJerkTool()
    Notify("🗡️ Sword Jerk", CurrentLang.jerkAdded)
end)

JerkBtn.MouseEnter:Connect(function()
    TweenService:Create(JerkBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 70, 170)}):Play()
end)
JerkBtn.MouseLeave:Connect(function()
    TweenService:Create(JerkBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 50, 150)}):Play()
end)

-- ========== НАСТРОЙКИ ==========

CreateDivider(CurrentLang.settings, SettingsContent)

-- Прозрачность
CreateSlider(CurrentLang.transparency, "Transparency", 0, 100, 0, SettingsContent)

-- Скорость точения
CreateSlider("⚡ Speed Jerk", "JerkSpeed", 1, 10, 5, SettingsContent)

-- Язык
local LangFrame = Instance.new("Frame")
LangFrame.Size = UDim2.new(1, 0, 0, 48)
LangFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
LangFrame.BorderSizePixel = 0
LangFrame.Parent = SettingsContent

Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 12)

local LangLabel = Instance.new("TextLabel")
LangLabel.Size = UDim2.new(0.5, 0, 1, 0)
LangLabel.Position = UDim2.new(0, 14, 0, 0)
LangLabel.BackgroundTransparency = 1
LangLabel.Text = CurrentLang.language
LangLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
LangLabel.TextSize = 13
LangLabel.Font = Enum.Font.Gotham
LangLabel.TextXAlignment = Enum.TextXAlignment.Left
LangLabel.Parent = LangFrame

local LangBtnRU = Instance.new("TextButton")
LangBtnRU.Size = UDim2.new(0, 50, 0, 30)
LangBtnRU.Position = UDim2.new(1, -120, 0.5, -15)
LangBtnRU.BackgroundColor3 = Settings.CurrentLang == "RU" and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(60, 60, 80)
LangBtnRU.Text = "RU"
LangBtnRU.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtnRU.TextSize = 13
LangBtnRU.Font = Enum.Font.GothamBold
LangBtnRU.Parent = LangFrame

Instance.new("UICorner", LangBtnRU).CornerRadius = UDim.new(0, 8)

local LangBtnEN = Instance.new("TextButton")
LangBtnEN.Size = UDim2.new(0, 50, 0, 30)
LangBtnEN.Position = UDim2.new(1, -62, 0.5, -15)
LangBtnEN.BackgroundColor3 = Settings.CurrentLang == "EN" and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(60, 60, 80)
LangBtnEN.Text = "EN"
LangBtnEN.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtnEN.TextSize = 13
LangBtnEN.Font = Enum.Font.GothamBold
LangBtnEN.Parent = LangFrame

Instance.new("UICorner", LangBtnEN).CornerRadius = UDim.new(0, 8)

LangBtnRU.MouseButton1Click:Connect(function()
    Settings.CurrentLang = "RU"
    CurrentLang = Lang.RU
    TweenService:Create(LangBtnRU, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
    TweenService:Create(LangBtnEN, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
    Notify("🌐 Language", "Русский выбран! Перезапусти скрипт.")
end)

LangBtnEN.MouseButton1Click:Connect(function()
    Settings.CurrentLang = "EN"
    CurrentLang = Lang.EN
    TweenService:Create(LangBtnEN, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
    TweenService:Create(LangBtnRU, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
    Notify("🌐 Language", "English selected! Restart script.")
end)

-- Кнопка перезапуска
local RestartBtn = Instance.new("TextButton")
RestartBtn.Size = UDim2.new(1, 0, 0, 48)
RestartBtn.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
RestartBtn.Text = CurrentLang.restart
RestartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RestartBtn.TextSize = 13
RestartBtn.Font = Enum.Font.GothamBold
RestartBtn.Parent = SettingsContent

Instance.new("UICorner", RestartBtn).CornerRadius = UDim.new(0, 12)

RestartBtn.MouseButton1Click:Connect(function()
    -- Анимация закрытия
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    task.wait(0.3)
    
    -- Очищаем всё
    ScreenGui:Destroy()
    StopFly()
    StopNoclip()
    StopESP()
    
    -- Перезапуск
    task.wait(0.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HuBs3/Hub-recvor/main/Test_recvor.lua"))()
end)

RestartBtn.MouseEnter:Connect(function()
    TweenService:Create(RestartBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 120)}):Play()
end)
RestartBtn.MouseLeave:Connect(function()
    TweenService:Create(RestartBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 71, 87)}):Play()
end)

-- ========== ПЕРЕКЛЮЧЕНИЕ НАСТРОЕК ==========

local SettingsOpen = false

SettingsBtn.MouseButton1Click:Connect(function()
    SettingsOpen = true
    BackBtn.Visible = true
    SettingsBtn.Visible = false
    
    TweenService:Create(ContentFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
        Position = UDim2.new(-1, 0, 0, 48)
    }):Play()
    
    TweenService:Create(SettingsFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0, 0, 0, 44)
    }):Play()
end)

BackBtn.MouseButton1Click:Connect(function()
    SettingsOpen = false
    BackBtn.Visible = false
    SettingsBtn.Visible = true
    
    TweenService:Create(SettingsFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, 0, 0, 44)
    }):Play()
    
    TweenService:Create(ContentFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0, 8, 0, 48)
    }):Play()
end)

-- ========== ONE BUTTON FLY (PC + MOBILE) ==========
local FlyConnection, FlyBodyVelocity, FlyBodyGyro
local FlyGui, FlyBtn, FlyBtnConnection
local LastFlyUpdate = 0

function StartFly()
    if FlyConnection then return end
    
    local BV = Instance.new("BodyVelocity")
    BV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    BV.Velocity = Vector3.new(0, 0, 0)
    BV.Parent = HumanoidRootPart
    FlyBodyVelocity = BV
    
    local BG = Instance.new("BodyGyro")
    BG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    BG.P = 5000
    BG.Parent = HumanoidRootPart
    FlyBodyGyro = BG
    
    local camera = workspace.CurrentCamera
    local keysDown = {}
    local moveDir = Vector3.new(0, 0, 0)
    local verticalDir = 0
    
    -- PC: клавиши
    local keyBeganConn = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.W then keysDown.W = true end
        if input.KeyCode == Enum.KeyCode.S then keysDown.S = true end
        if input.KeyCode == Enum.KeyCode.A then keysDown.A = true end
        if input.KeyCode == Enum.KeyCode.D then keysDown.D = true end
        if input.KeyCode == Enum.KeyCode.Space then keysDown.Space = true end
        if input.KeyCode == Enum.KeyCode.LeftShift then keysDown.Shift = true end
    end)
    
    local keyEndedConn = UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then keysDown.W = false end
        if input.KeyCode == Enum.KeyCode.S then keysDown.S = false end
        if input.KeyCode == Enum.KeyCode.A then keysDown.A = false end
        if input.KeyCode == Enum.KeyCode.D then keysDown.D = false end
        if input.KeyCode == Enum.KeyCode.Space then keysDown.Space = false end
        if input.KeyCode == Enum.KeyCode.LeftShift then keysDown.Shift = false end
    end)
    
    -- Mobile: кнопка полёта
    if UserInputService.TouchEnabled then
        FlyGui = Instance.new("ScreenGui")
        FlyGui.Name = "FlyBtnGui"
        FlyGui.Parent = CoreGui
        FlyGui.ResetOnSpawn = false
        
        FlyBtn = Instance.new("TextButton")
        FlyBtn.Name = "FlyBtn"
        FlyBtn.Size = UDim2.new(0, 70, 0, 70)
        FlyBtn.Position = UDim2.new(1, -90, 1, -160)
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        FlyBtn.Text = "FLY"
        FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        FlyBtn.TextSize = 18
        FlyBtn.Font = Enum.Font.GothamBlack
        FlyBtn.Parent = FlyGui
        
        Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0.5, 0)
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(100, 230, 255)
        btnStroke.Thickness = 3
        btnStroke.Parent = FlyBtn
        
        -- Джойстик для направления
        local JoystickBg = Instance.new("Frame")
        JoystickBg.Name = "Joystick"
        JoystickBg.Size = UDim2.new(0, 120, 0, 120)
        JoystickBg.Position = UDim2.new(0, 20, 1, -160)
        JoystickBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        JoystickBg.BackgroundTransparency = 0.3
        JoystickBg.BorderSizePixel = 0
        JoystickBg.Parent = FlyGui
        
        Instance.new("UICorner", JoystickBg).CornerRadius = UDim.new(0.5, 0)
        
        local JoystickKnob = Instance.new("Frame")
        JoystickKnob.Size = UDim2.new(0, 40, 0, 40)
        JoystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
        JoystickKnob.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        JoystickKnob.BorderSizePixel = 0
        JoystickKnob.Parent = JoystickBg
        
        Instance.new("UICorner", JoystickKnob).CornerRadius = UDim.new(0.5, 0)
        
        local joystickTouchId = nil
        local joystickCenter = Vector2.new(0, 0)
        
        JoystickBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch and not joystickTouchId then
                joystickTouchId = input.UserInputType
                joystickCenter = Vector2.new(JoystickBg.AbsolutePosition.X + 60, JoystickBg.AbsolutePosition.Y + 60)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch and joystickTouchId then
                local pos = Vector2.new(input.Position.X, input.Position.Y)
                local delta = pos - joystickCenter
                local maxDist = 35
                local dist = math.min(delta.Magnitude, maxDist)
                
                if dist > 0 then
                    local angle = math.atan2(delta.Y, delta.X)
                    local nx = math.cos(angle) * dist
                    local ny = math.sin(angle) * dist
                    JoystickKnob.Position = UDim2.new(0.5, nx - 20, 0.5, ny - 20)
                    
                    local cam = workspace.CurrentCamera
                    moveDir = (cam.CFrame.LookVector * (-ny / maxDist) + cam.CFrame.RightVector * (nx / maxDist)) * Settings.FlySpeed
                end
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                joystickTouchId = nil
                JoystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
                moveDir = Vector3.new(0, 0, 0)
            end
        end)
        
        -- Кнопки вверх/вниз
        local UpBtn = Instance.new("TextButton")
        UpBtn.Size = UDim2.new(0, 55, 0, 55)
        UpBtn.Position = UDim2.new(1, -80, 1, -240)
        UpBtn.BackgroundColor3 = Color3.fromRGB(0, 230, 118)
        UpBtn.Text = "▲"
        UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        UpBtn.TextSize = 24
        UpBtn.Font = Enum.Font.GothamBold
        UpBtn.Parent = FlyGui
        
        Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0.5, 0)
        
        local DownBtn = Instance.new("TextButton")
        DownBtn.Size = UDim2.new(0, 55, 0, 55)
        DownBtn.Position = UDim2.new(1, -80, 1, -170)
        DownBtn.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
        DownBtn.Text = "▼"
        DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DownBtn.TextSize = 24
        DownBtn.Font = Enum.Font.GothamBold
        DownBtn.Parent = FlyGui
        
        Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0.5, 0)
        
        local upPressed = false
        local downPressed = false
        
        UpBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then upPressed = true end
        end)
        UpBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then upPressed = false end
        end)
        DownBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then downPressed = true end
        end)
        DownBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then downPressed = false end
        end)
        
        FlyBtnConnection = RunService.Heartbeat:Connect(function()
            if not Settings.FlyEnabled or not FlyBodyVelocity then return end
            
            verticalDir = 0
            if upPressed then verticalDir = 1 end
            if downPressed then verticalDir = -1 end
            
            -- Объединяем PC и Mobile направления
            local pcDir = Vector3.new(0, 0, 0)
            if keysDown.W then pcDir = pcDir + camera.CFrame.LookVector end
            if keysDown.S then pcDir = pcDir - camera.CFrame.LookVector end
            if keysDown.A then pcDir = pcDir - camera.CFrame.RightVector end
            if keysDown.D then pcDir = pcDir + camera.CFrame.RightVector end
            
            local totalDir = moveDir + pcDir
            if totalDir.Magnitude > 0 then totalDir = totalDir.Unit * Settings.FlySpeed end
            
            totalDir = totalDir + Vector3.new(0, verticalDir * Settings.FlySpeed * 0.5, 0)
            if keysDown.Space then totalDir = totalDir + Vector3.new(0, Settings.FlySpeed * 0.5, 0) end
            if keysDown.Shift then totalDir = totalDir - Vector3.new(0, Settings.FlySpeed * 0.5, 0) end
            
            FlyBodyVelocity.Velocity = totalDir
            FlyBodyGyro.CFrame = camera.CFrame
        end)
    else
        -- Только PC
        FlyConnection = RunService.Heartbeat:Connect(function()
            if not Settings.FlyEnabled then return end
            local now = tick()
            if now - LastFlyUpdate < 0.033 then return end
            LastFlyUpdate = now
            
            local direction = Vector3.new(0, 0, 0)
            local cf = camera.CFrame
            
            if keysDown.W then direction = direction + cf.LookVector end
            if keysDown.S then direction = direction - cf.LookVector end
            if keysDown.A then direction = direction - cf.RightVector end
            if keysDown.D then direction = direction + cf.RightVector end
            if keysDown.Space then direction = direction + Vector3.new(0, 1, 0) end
            if keysDown.Shift then direction = direction - Vector3.new(0, 1, 0) end
            
            if direction.Magnitude > 0 then direction = direction.Unit * Settings.FlySpeed end
            
            BV.Velocity = direction
            BG.CFrame = cf
        end)
    end
    
    Notify("🚀 Fly", CurrentLang.flyOn)
end

function StopFly()
    if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    if FlyBtnConnection then FlyBtnConnection:Disconnect() FlyBtnConnection = nil end
    if FlyBodyVelocity then FlyBodyVelocity:Destroy() FlyBodyVelocity = nil end
    if FlyBodyGyro then FlyBodyGyro:Destroy() FlyBodyGyro = nil end
    if FlyGui then FlyGui:Destroy() FlyGui = nil end
    
    Notify("🚀 Fly", CurrentLang.flyOff)
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
local ESPUpdateInterval = 0.1

function StartESP()
    local lastESPUpdate = 0
    
    local function CreateESP(player)
        if player == LocalPlayer then return end
        
        local espFrame = Instance.new("BillboardGui")
        espFrame.Name = player.Name .. "_ESP"
        espFrame.AlwaysOnTop = true
        espFrame.Size = UDim2.new(0, 80, 0, 30)
        espFrame.StudsOffset = Vector3.new(0, 2.5, 0)
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        nameLabel.TextSize = 12
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = espFrame
        
        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0.4, 0)
        distLabel.Position = UDim2.new(0, 0, 0.6, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "0m"
        distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLabel.TextSize = 10
        distLabel.Font = Enum.Font.Gotham
        distLabel.Parent = espFrame
        
        espFrame.Parent = ESPFolder
        
        local conn = RunService.Heartbeat:Connect(function()
            if not Settings.ESP then
                espFrame.Enabled = false
                return
            end
            
            local now = tick()
            if now - lastESPUpdate < ESPUpdateInterval then return end
            lastESPUpdate = now
            
            if not player.Character then
                espFrame.Enabled = false
                return
            end
            
            local head = player.Character:FindFirstChild("Head")
            if head then
                espFrame.Adornee = head
                espFrame.Enabled = true
                
                local myHRP = Character:FindFirstChild("HumanoidRootPart")
                if myHRP then
                    local distance = (myHRP.Position - head.Position).Magnitude
                    distLabel.Text = math.floor(distance) .. "m"
                end
                
                nameLabel.TextColor3 = (player.Team == LocalPlayer.Team) 
                    and Color3.fromRGB(50, 255, 50) 
                    or Color3.fromRGB(255, 50, 50)
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

-- ========== CLICK TP ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Settings.ClickTeleport and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mouse = LocalPlayer:GetMouse()
        if mouse.Hit then
            HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
        end
    end
end)

-- ========== ANTI AFK ==========
if Settings.AntiAFK then
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- ========== SWORD JERK TOOL (ТОЛЬКО ДЛЯ ТЕБЯ) ==========
function GiveSwordJerkTool()
    local tool = Instance.new("Tool")
    tool.Name = "SwordJerk"
    tool.RequiresHandle = true
    tool.CanBeDropped = false
    
    -- Меч (виден только тебе)
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.3, 3, 0.3)
    handle.BrickColor = BrickColor.new("Silver")
    handle.Material = Enum.Material.Metal
    handle.CanCollide = false
    handle.Parent = tool
    
    -- Лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.1, 2.5, 0.6)
    blade.BrickColor = BrickColor.new("Institutional White")
    blade.Material = Enum.Material.Neon
    blade.CanCollide = false
    blade.Parent = tool
    
    local bladeWeld = Instance.new("Weld")
    bladeWeld.Part0 = handle
    bladeWeld.Part1 = blade
    bladeWeld.C0 = CFrame.new(0, 1.5, 0)
    bladeWeld.Parent = blade
    
    -- Рукоять
    local grip = Instance.new("Part")
    grip.Name = "Grip"
    grip.Size = Vector3.new(0.5, 0.8, 0.5)
    grip.BrickColor = BrickColor.new("Brown")
    grip.Material = Enum.Material.Wood
    grip.CanCollide = false
    grip.Parent = tool
    
    local gripWeld = Instance.new("Weld")
    gripWeld.Part0 = handle
    gripWeld.Part1 = grip
    gripWeld.C0 = CFrame.new(0, -1.2, 0)
    gripWeld.Parent = grip
    
    -- Экипировка — анимация "точу шпагу"
    tool.Equipped:Connect(function()
        -- Создаём кастомную анимацию через Motor6D
        local rightArm = Character:FindFirstChild("RightUpperArm") or Character:FindFirstChild("Right Arm")
        if not rightArm then return end
        
        local anim = Instance.new("Animation")
        -- Анимация idle с рукой на поясе
        anim.AnimationId = "rbxassetid://507768375" -- Idle with tool
        local track = Humanoid:LoadAnimation(anim)
        track:Play()
        
        -- Кастомная поза: рука на поясе, меч внизу
        local pose = Instance.new("BodyGyro")
        pose.MaxTorque = Vector3.new(0, 0, 0)
        pose.Parent = HumanoidRootPart
        
        -- Создаём партиклы "искры" при точении
        local attachment = Instance.new("Attachment")
        attachment.Position = Vector3.new(0, 1.5, 0.3)
        attachment.Parent = handle
        
        local sparks = Instance.new("ParticleEmitter")
        sparks.Name = "Sparks"
        sparks.Texture = "rbxassetid://258128463"
        sparks.Size = NumberSequence.new(0.2, 0)
        sparks.Lifetime = NumberRange.new(0.3, 0.6)
        sparks.Rate = 0 -- Выкл по умолчанию
        sparks.Speed = NumberRange.new(1, 3)
        sparks.SpreadAngle = Vector2.new(45, 45)
        sparks.Color = ColorSequence.new(Color3.fromRGB(255, 200, 100))
        sparks.Parent = attachment
        
        tool:SetAttribute("AnimTrack", track)
        tool:SetAttribute("Sparks", sparks)
        tool:SetAttribute("Pose", pose)
    end)
    
    tool.Unequipped:Connect(function()
        local track = tool:GetAttribute("AnimTrack")
        if track then track:Stop() end
        
        local pose = tool:GetAttribute("Pose")
        if pose then pose:Destroy() end
    end)
    
    -- Активация — анимация "точу шпагу"
    tool.Activated:Connect(function()
        local track = tool:GetAttribute("AnimTrack")
        local sparks = tool:GetAttribute("Sparks")
        
        if track then
            track:AdjustSpeed(Settings.JerkSpeed / 5) -- Настраиваемая скорость
        end
        
        -- Анимация движения рукой (как точишь шпагу)
        local jerkAnim = Instance.new("Animation")
        jerkAnim.AnimationId = "rbxassetid://507765644" -- Tool swing
        local jerkTrack = Humanoid:LoadAnimation(jerkAnim)
        jerkTrack:Play()
        jerkTrack:AdjustSpeed(Settings.JerkSpeed / 5)
        
        -- Искры при "точении"
        if sparks then
            sparks.Rate = 50 * Settings.JerkSpeed
            task.wait(0.5 / Settings.JerkSpeed)
            sparks.Rate = 0
        end
        
        -- Вибрация меча
        local vibration = Instance.new("BodyPosition")
        vibration.MaxForce = Vector3.new(1000, 1000, 1000)
        vibration.Position = handle.Position
        vibration.Parent = handle
        
        task.spawn(function()
            for i = 1, 10 * Settings.JerkSpeed do
                if not vibration.Parent then break end
                vibration.Position = handle.Position + Vector3.new(
                    math.random(-5, 5) / 100,
                    math.random(-5, 5) / 100,
                    math.random(-5, 5) / 100
                )
                task.wait(0.05 / Settings.JerkSpeed)
            end
            vibration:Destroy()
        end)
        
        task.delay(0.8 / Settings.JerkSpeed, function()
            jerkTrack:Stop()
        end)
    end)
    
    -- Делаем невидимым для других (только локально)
    tool.AncestryChanged:Connect(function()
        if tool.Parent == LocalPlayer.Character then
            for _, part in pairs(tool:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0 -- Видно тебе
                end
            end
        end
    end)
    
    tool.Parent = LocalPlayer.Backpack
end

-- ========== УВЕДОМЛЕНИЯ ==========
function Notify(title, text)
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 260, 0, 60)
    NotifFrame.Position = UDim2.new(1, 20, 1, -80)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.BackgroundTransparency = 1
    NotifFrame.Parent = ScreenGui
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 10)
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = Color3.fromRGB(0, 200, 255)
    NotifStroke.Thickness = 1
    NotifStroke.Parent = NotifFrame
    
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, -16, 0, 24)
    NotifTitle.Position = UDim2.new(0, 8, 0, 6)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    NotifTitle.TextSize = 14
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.Parent = NotifFrame
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -16, 0, 24)
    NotifText.Position = UDim2.new(0, 8, 0, 28)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(200, 200, 220)
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.Parent = NotifFrame
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -280, 1, -80),
        BackgroundTransparency = 0
    }):Play()
    
    task.delay(2.5, function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
            Position = UDim2.new(1, 20, 1, -80),
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.4)
        NotifFrame:Destroy()
    end)
end

-- ========== СВОРАЧИВАНИЕ / РАЗВОРАЧИВАНИЕ ==========

local OpenCircle = Instance.new("TextButton")
OpenCircle.Name = "OpenCircle"
OpenCircle.Size = UDim2.new(0, 50, 0, 50)
OpenCircle.Position = UDim2.new(0.5, -25, 0, 20)
OpenCircle.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
OpenCircle.Text = "R"
OpenCircle.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCircle.TextSize = 20
OpenCircle.Font = Enum.Font.GothamBlack
OpenCircle.Visible = false
OpenCircle.AutoButtonColor = false
OpenCircle.Parent = ScreenGui

Instance.new("UICorner", OpenCircle).CornerRadius = UDim.new(0.5, 0)

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(100, 230, 255)
CircleStroke.Thickness = 2
CircleStroke.Parent = OpenCircle

-- Пульсация
task.spawn(function()
    while OpenCircle and OpenCircle.Parent do
        if OpenCircle.Visible then
            TweenService:Create(OpenCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 55, 0, 55)
            }):Play()
            task.wait(1)
            TweenService:Create(OpenCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 50, 0, 50)
            }):Play()
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)

-- Перетаскивание
local circleDragging = false
local circleDragStart = Vector2.new(0, 0)
local circleStartPos = UDim2.new(0, 0, 0, 0)

OpenCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        circleDragging = true
        circleDragStart = Vector2.new(input.Position.X, input.Position.Y)
        circleStartPos = OpenCircle.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if circleDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - circleDragStart
        local newX = circleStartPos.X.Offset + delta.X
        local newY = circleStartPos.Y.Offset + delta.Y
        
        local screenSize = workspace.CurrentCamera.ViewportSize
        newX = math.clamp(newX, 0, screenSize.X - 50)
        newY = math.clamp(newY, 0, screenSize.Y - 50)
        
        OpenCircle.Position = UDim2.new(0, newX, 0, newY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if circleDragging then
            circleDragging = false
            if OpenCircle.Position.Y.Offset < 30 then
                TweenService:Create(OpenCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    Position = UDim2.new(OpenCircle.Position.X.Scale, OpenCircle.Position.X.Offset, 0, 5)
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
        Position = UDim2.new(0.5, -160, 0, -450)
    }):Play()
    task.wait(0.4)
    MainFrame.Visible = false
    OpenCircle.Visible = true
    OpenCircle.Position = UDim2.new(0.5, -25, 0, 20)
end)

-- Разворачивание
OpenCircle.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
        Position = UDim2.new(0.5, -160, 0.5, -210)
    }):Play()
    OpenCircle.Visible = false
    TopIndicator.Visible = false
end)

-- Свайп вниз
local swipeStart = nil
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        swipeStart = Vector2.new(input.Position.X, input.Position.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and swipeStart then
        local endPos = Vector2.new(input.Position.X, input.Position.Y)
        local delta = endPos - swipeStart
        
        if delta.Y > 60 and swipeStart.Y < 50 and not MainFrame.Visible then
            MainFrame.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0.5, -160, 0.5, -210)
            }):Play()
            OpenCircle.Visible = false
            TopIndicator.Visible = false
        end
        swipeStart = nil
    end
end)

-- Закрытие
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.wait(0.3)
    ScreenGui:Destroy()
    StopFly()
    StopNoclip()
    StopESP()
end)

-- Hotkey
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
    end
end)

-- ========== ИНИЦИАЛИЗАЦИЯ ==========
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 320, 0, 420),
    Position = UDim2.new(0.5, -160, 0.5, -210)
}):Play()

task.delay(0.6, function()
    Notify("🔥 RECVOR HUB v4.0", CurrentLang.welcome .. " " .. CurrentLang.menuToggle)
end)

print("✅ RECVOR HUB v4.0 loaded!")
