--// PHANTOM UI CORE (REPO VERSION)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local assets = loadstring(game:HttpGet("https://raw.githubusercontent.com/blackxscripts/phantom/refs/heads/main/assets.lua"))()

local UI = {}
UI.Tabs = {}

-- CREATE WINDOW
function UI:CreateWindow(title)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "PhantomUI"

    -- INTRO LOGO
    local intro = Instance.new("ImageLabel", gui)
    intro.AnchorPoint = Vector2.new(0.5,0.5)
    intro.Position = UDim2.new(0.5,0,0.5,0)
    intro.Size = UDim2.new(0.25,0,0.25,0)
    intro.BackgroundTransparency = 1
    intro.Image = assets.intro

    TweenService:Create(intro, TweenInfo.new(0.6), {
        ImageTransparency = 0,
        Size = UDim2.new(0.3,0,0.3,0)
    }):Play()

    task.wait(2)
    intro:Destroy()

    -- MAIN
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,520,0,300)
    main.Position = UDim2.new(0.5,-260,0.5,-150)
    main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

    -- TOPBAR
    local top = Instance.new("Frame", main)
    top.Size = UDim2.new(1,0,0,32)
    top.BackgroundColor3 = Color3.fromRGB(20,20,20)

    local logo = Instance.new("ImageLabel", top)
    logo.Size = UDim2.new(0,22,0,22)
    logo.Position = UDim2.new(0,8,0.5,-11)
    logo.BackgroundTransparency = 1
    logo.Image = assets.topbar

    local titleLabel = Instance.new("TextLabel", top)
    titleLabel.Size = UDim2.new(1,-60,1,0)
    titleLabel.Position = UDim2.new(0,35,0,0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- CLOSE
    local close = Instance.new("TextButton", top)
    close.Size = UDim2.new(0,32,1,0)
    close.Position = UDim2.new(1,-32,0,0)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(30,30,30)
    close.TextColor3 = Color3.fromRGB(255,255,255)

    Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)

    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    self.Main = main
    self.Content = Instance.new("Frame", main)
    self.Content.Size = UDim2.new(1,-130,1,-42)
    self.Content.Position = UDim2.new(0,125,0,36)
    self.Content.BackgroundTransparency = 1

    self.TabHolder = Instance.new("Frame", main)
    self.TabHolder.Size = UDim2.new(0,120,1,-42)
    self.TabHolder.Position = UDim2.new(0,0,0,36)
    self.TabHolder.BackgroundColor3 = Color3.fromRGB(18,18,18)

    Instance.new("UICorner", self.TabHolder).CornerRadius = UDim.new(0,12)

    return self
end

-- CREATE TAB
function UI:CreateTab(name)
    local frame = Instance.new("Frame", self.Content)
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundTransparency = 1
    frame.Visible = false

    Instance.new("UIListLayout", frame).Padding = UDim.new(0,8)

    local button = Instance.new("TextButton", self.TabHolder)
    button.Size = UDim2.new(1,-10,0,35)
    button.Position = UDim2.new(0,5,0,0)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(25,25,25)
    button.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", button)

    button.MouseButton1Click:Connect(function()
        self:SwitchTab(name)
    end)

    self.Tabs[name] = frame
    return frame
end

-- SWITCH TAB
function UI:SwitchTab(name)
    for n,f in pairs(self.Tabs) do
        f.Visible = (n == name)
    end
end

-- BUTTON
function UI:Button(tab, text, cb)
    local b = Instance.new("TextButton", tab)
    b.Size = UDim2.new(1,0,0,40)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(25,25,25)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", b)

    b.MouseButton1Click:Connect(cb)
end

-- TOGGLE
function UI:Toggle(tab, text, cb)
    local state = false

    local f = Instance.new("Frame", tab)
    f.Size = UDim2.new(1,0,0,40)
    f.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner", f)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.7,0,1,0)
    l.Text = text
    l.TextColor3 = Color3.fromRGB(255,255,255)
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left

    f.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            cb(state)
        end
    end)
end

return UI
