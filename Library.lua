local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}

function Library:Tween(object, time, property)
    TweenService:Create(object, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), property):Play()
end

function Library:MakeDraggable(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Library:MakeWindow(config)
    local WindowName = config.Name or "Capoo Library"
    local Info = config.Info or "By Antigravity"
    
    local Capoo = Instance.new("ScreenGui")
    Capoo.Name = "CapooLibrary"
    Capoo.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    Capoo.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Intro Animation Objects
    local IntroFrame = Instance.new("Frame")
    local IntroLogo = Instance.new("TextLabel")
    local IntroGradient = Instance.new("UIGradient")
    local IntroCorner = Instance.new("UICorner")

    IntroFrame.Name = "IntroFrame"
    IntroFrame.Parent = Capoo
    IntroFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 40)
    IntroFrame.Position = UDim2.new(0.5, -100, 0.5, -30)
    IntroFrame.Size = UDim2.new(0, 200, 0, 60)
    IntroFrame.ZIndex = 10
    IntroFrame.ClipsDescendants = true

    IntroCorner.CornerRadius = UDim.new(0, 12)
    IntroCorner.Parent = IntroFrame

    IntroLogo.Parent = IntroFrame
    IntroLogo.Size = UDim2.new(1, 0, 1, 0)
    IntroLogo.Font = Enum.Font.ChangaOne
    IntroLogo.Text = "OKXHUB"
    IntroLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
    IntroLogo.TextSize = 30
    IntroLogo.BackgroundTransparency = 1

    IntroGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(91, 192, 222)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    IntroGradient.Parent = IntroLogo

    spawn(function()
        IntroFrame.Size = UDim2.new(0, 0, 0, 60)
        Library:Tween(IntroFrame, 0.8, {Size = UDim2.new(0, 200, 0, 60)})
        wait(1.5)
        Library:Tween(IntroFrame, 0.8, {BackgroundTransparency = 1})
        Library:Tween(IntroLogo, 0.8, {TextTransparency = 1})
        wait(0.8)
        IntroFrame:Destroy()
    end)

    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local TitleBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Credits = Instance.new("TextLabel")
    local ButtonsFrame = Instance.new("Frame")
    local CloseBtn = Instance.new("ImageButton")
    local MinBtn = Instance.new("ImageButton")
    local Sidebar = Instance.new("Frame")
    local TabList = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local ContentArea = Instance.new("Frame")
    local Separator = Instance.new("Frame")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Capoo
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BackgroundTransparency = 0.15
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false

    local MainGradient = Instance.new("UIGradient")
    MainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 40, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 25, 30))
    })
    MainGradient.Rotation = 45
    MainGradient.Parent = MainFrame

    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    UIStroke.Color = Color3.fromRGB(91, 192, 222)
    UIStroke.Thickness = 1.5
    UIStroke.Transparency = 0.5
    UIStroke.Parent = MainFrame

    spawn(function()
        wait(2.2)
        MainFrame.Visible = true
        Library:Tween(MainFrame, 1, {Size = UDim2.new(0, 600, 0, 400)})
    end)

    Library:MakeDraggable(MainFrame)

    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.BackgroundTransparency = 1.000
    TitleBar.Size = UDim2.new(1, 0, 0, 45)

    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Font = Enum.Font.ChangaOne
    Title.Text = WindowName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Credits.Name = "Credits"
    Credits.Parent = TitleBar
    Credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Credits.BackgroundTransparency = 1.000
    Credits.Position = UDim2.new(1, -250, 0, 0)
    Credits.Size = UDim2.new(0, 180, 1, 0)
    Credits.Font = Enum.Font.Actor
    Credits.Text = Info
    Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
    Credits.TextSize = 14.000
    Credits.TextXAlignment = Enum.TextXAlignment.Right

    ButtonsFrame.Name = "ButtonsFrame"
    ButtonsFrame.Parent = TitleBar
    ButtonsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonsFrame.BackgroundTransparency = 1.000
    ButtonsFrame.Position = UDim2.new(1, -70, 0, 10)
    ButtonsFrame.Size = UDim2.new(0, 60, 0, 25)

    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = ButtonsFrame
    CloseBtn.BackgroundTransparency = 1.000
    CloseBtn.Position = UDim2.new(0.6, 0, 0, 0)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Image = "rbxassetid://6031094678"
    CloseBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)

    MinBtn.Name = "MinBtn"
    MinBtn.Parent = ButtonsFrame
    MinBtn.BackgroundTransparency = 1.000
    MinBtn.Position = UDim2.new(0, 0, 0, 0)
    MinBtn.Size = UDim2.new(0, 25, 0, 25)
    MinBtn.Image = "rbxassetid://6031094667"
    MinBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)

    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Sidebar.BackgroundTransparency = 1.000
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.Size = UDim2.new(0, 140, 1, -45)

    TabList.Name = "TabList"
    TabList.Parent = Sidebar
    TabList.Active = true
    TabList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabList.BackgroundTransparency = 1.000
    TabList.BorderSizePixel = 0
    TabList.Position = UDim2.new(0, 5, 0, 5)
    TabList.Size = UDim2.new(1, -10, 1, -10)
    TabList.ScrollBarThickness = 2

    UIListLayout.Parent = TabList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    Separator.Name = "Separator"
    Separator.Parent = MainFrame
    Separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Separator.BorderSizePixel = 0
    Separator.Position = UDim2.new(0, 140, 0, 55)
    Separator.Size = UDim2.new(0, 2, 1, -65)

    local SepGradient = Instance.new("UIGradient")
    SepGradient.Color = ColorSequence.new(Color3.fromRGB(91, 192, 222))
    SepGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    SepGradient.Rotation = 90
    SepGradient.Parent = Separator

    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainFrame
    ContentArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentArea.BackgroundTransparency = 1.000
    ContentArea.Position = UDim2.new(0, 150, 0, 50)
    ContentArea.Size = UDim2.new(1, -160, 1, -60)

    local Tabs = {}
    local firstTab = true

    function Tabs:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        local TabUICorner = Instance.new("UICorner")
        local TabPage = Instance.new("ScrollingFrame")
        local TabUIList = Instance.new("UIListLayout")

        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabList
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 55, 60)
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.ChangaOne
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 15.000

        TabUICorner.CornerRadius = UDim.new(0, 6)
        TabUICorner.Parent = TabButton

        TabPage.Name = name .. "Page"
        TabPage.Parent = ContentArea
        TabPage.Active = true
        TabPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabPage.BackgroundTransparency = 1.000
        TabPage.BorderSizePixel = 0
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.Visible = false
        TabPage.ScrollBarThickness = 2

        TabUIList.Parent = TabPage
        TabUIList.SortOrder = Enum.SortOrder.LayoutOrder
        TabUIList.Padding = UDim.new(0, 8)

        if firstTab then
            firstTab = false
            TabPage.Visible = true
            TabButton.BackgroundTransparency = 0.5
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentArea:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            for _, v in pairs(TabList:GetChildren()) do
                if v:IsA("TextButton") then
                    Library:Tween(v, 0.3, {BackgroundTransparency = 1})
                    Library:Tween(v, 0.3, {TextColor3 = Color3.fromRGB(180, 180, 180)})
                    if v:FindFirstChild("TabGradient") then
                        v.TabGradient:Destroy()
                    end
                end
            end
            TabPage.Visible = true
            Library:Tween(TabButton, 0.3, {BackgroundTransparency = 0.5})
            Library:Tween(TabButton, 0.3, {TextColor3 = Color3.fromRGB(255, 255, 255)})
            
            local TabGradient = Instance.new("UIGradient")
            TabGradient.Name = "TabGradient"
            TabGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(91, 192, 222)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 35, 40))
            })
            TabGradient.Transparency = NumberSequence.new(0.5)
            TabGradient.Parent = TabButton
        end)

        local Elements = {}

        function Elements:AddSearchBar(placeholder, callback)
            local SearchFrame = Instance.new("Frame")
            local SearchCorner = Instance.new("UICorner")
            local SearchInput = Instance.new("TextBox")
            local SearchIcon = Instance.new("ImageLabel")

            SearchFrame.Name = "SearchBar"
            SearchFrame.Parent = TabPage
            SearchFrame.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
            SearchFrame.Size = UDim2.new(1, 0, 0, 35)

            SearchCorner.CornerRadius = UDim.new(0, 6)
            SearchCorner.Parent = SearchFrame

            SearchIcon.Parent = SearchFrame
            SearchIcon.BackgroundTransparency = 1
            SearchIcon.Position = UDim2.new(0, 10, 0.5, -9)
            SearchIcon.Size = UDim2.new(0, 18, 0, 18)
            SearchIcon.Image = "rbxassetid://6031154871"
            SearchIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)

            SearchInput.Parent = SearchFrame
            SearchInput.BackgroundTransparency = 1
            SearchInput.Position = UDim2.new(0, 35, 0, 0)
            SearchInput.Size = UDim2.new(1, -45, 1, 0)
            SearchInput.Font = Enum.Font.Actor
            SearchInput.PlaceholderText = placeholder or "Search..."
            SearchInput.Text = ""
            SearchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchInput.TextSize = 13
            SearchInput.TextXAlignment = Enum.TextXAlignment.Left

            SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
                callback(SearchInput.Text)
            end)
        end

        function Elements:CreateSection(title)
            local SectionFrame = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionContainer = Instance.new("Frame")
            local SectionList = Instance.new("UIListLayout")
            local SectionLine = Instance.new("Frame")

            SectionFrame.Name = title .. "Section"
            SectionFrame.Parent = TabPage
            SectionFrame.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
            SectionFrame.Size = UDim2.new(1, 0, 0, 30) -- Will auto resize
            SectionFrame.ClipsDescendants = true

            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Parent = SectionFrame

            SectionLine.Parent = SectionFrame
            SectionLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionLine.BorderSizePixel = 0
            SectionLine.Position = UDim2.new(0, 10, 0, 30)
            SectionLine.Size = UDim2.new(1, -20, 0, 2)

            local LineGradient = Instance.new("UIGradient")
            LineGradient.Color = ColorSequence.new(Color3.fromRGB(91, 192, 222))
            LineGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.8, 0),
                NumberSequenceKeypoint.new(1, 1)
            })
            LineGradient.Parent = SectionLine

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 10, 0, 5)
            SectionTitle.Size = UDim2.new(1, -20, 0, 25)
            SectionTitle.Font = Enum.Font.ChangaOne
            SectionTitle.Text = title
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionContainer.Name = "SectionContainer"
            SectionContainer.Parent = SectionFrame
            SectionContainer.BackgroundTransparency = 1
            SectionContainer.Position = UDim2.new(0, 5, 0, 35)
            SectionContainer.Size = UDim2.new(1, -10, 0, 0)

            SectionList.Parent = SectionContainer
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 5)

            SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContainer.Size = UDim2.new(1, -10, 0, SectionList.AbsoluteContentSize.Y)
                SectionFrame.Size = UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 45)
                TabPage.CanvasSize = UDim2.new(0, 0, 0, TabUIList.AbsoluteContentSize.Y)
            end)

            local SectionElements = {}

            function SectionElements:AddButton(text, callback)
                local Button = Instance.new("TextButton")
                local BtnCorner = Instance.new("UICorner")

                Button.Name = text .. "Button"
                Button.Parent = SectionContainer
                Button.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
                Button.Size = UDim2.new(1, 0, 0, 32)
                Button.Font = Enum.Font.Actor
                Button.Text = text
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14

                BtnCorner.CornerRadius = UDim.new(0, 4)
                BtnCorner.Parent = Button

                Button.MouseButton1Click:Connect(function()
                    Library:Tween(Button, 0.1, {BackgroundColor3 = Color3.fromRGB(80, 85, 90)})
                    wait(0.1)
                    Library:Tween(Button, 0.1, {BackgroundColor3 = Color3.fromRGB(55, 60, 65)})
                    callback()
                end)

                Button.MouseEnter:Connect(function()
                    Library:Tween(Button, 0.3, {BackgroundColor3 = Color3.fromRGB(70, 75, 80)})
                    Library:Tween(Button, 0.3, {Size = UDim2.new(1, 5, 0, 32)})
                end)
                Button.MouseLeave:Connect(function()
                    Library:Tween(Button, 0.3, {BackgroundColor3 = Color3.fromRGB(55, 60, 65)})
                    Library:Tween(Button, 0.3, {Size = UDim2.new(1, 0, 0, 32)})
                end)
            end

            function SectionElements:AddToggle(text, default, callback)
                local ToggleFrame = Instance.new("Frame")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleTitle = Instance.new("TextLabel")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnCorner = Instance.new("UICorner")
                local ToggleCircle = Instance.new("Frame")
                local CircleCorner = Instance.new("UICorner")

                local toggled = default or false

                ToggleFrame.Name = text .. "Toggle"
                ToggleFrame.Parent = SectionContainer
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
                ToggleFrame.Size = UDim2.new(1, 0, 0, 35)

                ToggleCorner.CornerRadius = UDim.new(0, 4)
                ToggleCorner.Parent = ToggleFrame

                ToggleTitle.Parent = ToggleFrame
                ToggleTitle.BackgroundTransparency = 1
                ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
                ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
                ToggleTitle.Font = Enum.Font.Actor
                ToggleTitle.Text = text
                ToggleTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                ToggleTitle.TextSize = 14
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleFrame
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
                ToggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
                ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
                ToggleBtn.Text = ""

                ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
                ToggleBtnCorner.Parent = ToggleBtn

                ToggleCircle.Parent = ToggleBtn
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                ToggleCircle.Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)

                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = ToggleCircle

                if toggled then
                    ToggleBtn.BackgroundColor3 = Color3.fromRGB(91, 192, 222)
                    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if toggled then
                        Library:Tween(ToggleBtn, 0.3, {BackgroundColor3 = Color3.fromRGB(91, 192, 222)})
                        Library:Tween(ToggleCircle, 0.3, {Position = UDim2.new(1, -18, 0.5, -8)})
                        Library:Tween(ToggleCircle, 0.3, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    else
                        Library:Tween(ToggleBtn, 0.3, {BackgroundColor3 = Color3.fromRGB(40, 45, 50)})
                        Library:Tween(ToggleCircle, 0.3, {Position = UDim2.new(0, 2, 0.5, -8)})
                        Library:Tween(ToggleCircle, 0.3, {BackgroundColor3 = Color3.fromRGB(150, 150, 150)})
                    end
                    callback(toggled)
                end)

                ToggleFrame.MouseEnter:Connect(function()
                    Library:Tween(ToggleFrame, 0.3, {BackgroundColor3 = Color3.fromRGB(65, 70, 75)})
                    Library:Tween(ToggleTitle, 0.3, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                end)
                ToggleFrame.MouseLeave:Connect(function()
                    Library:Tween(ToggleFrame, 0.3, {BackgroundColor3 = Color3.fromRGB(55, 60, 65)})
                    Library:Tween(ToggleTitle, 0.3, {TextColor3 = Color3.fromRGB(220, 220, 220)})
                end)
            end

            function SectionElements:AddDropdown(text, list, callback)
                local DropdownFrame = Instance.new("Frame")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownTitle = Instance.new("TextLabel")
                local DropdownBtn = Instance.new("TextButton")
                local DropdownIcon = Instance.new("ImageLabel")
                local DropdownList = Instance.new("Frame")
                local ListCorner = Instance.new("UICorner")
                local ListLayout = Instance.new("UIListLayout")
                
                local dropped = false

                DropdownFrame.Name = text .. "Dropdown"
                DropdownFrame.Parent = SectionContainer
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
                DropdownFrame.ClipsDescendants = true

                DropdownCorner.CornerRadius = UDim.new(0, 4)
                DropdownCorner.Parent = DropdownFrame

                DropdownTitle.Parent = DropdownFrame
                DropdownTitle.BackgroundTransparency = 1
                DropdownTitle.Position = UDim2.new(0, 10, 0, 0)
                DropdownTitle.Size = UDim2.new(1, -40, 0, 35)
                DropdownTitle.Font = Enum.Font.Actor
                DropdownTitle.Text = text
                DropdownTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                DropdownTitle.TextSize = 14
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

                DropdownIcon.Parent = DropdownFrame
                DropdownIcon.BackgroundTransparency = 1
                DropdownIcon.Position = UDim2.new(1, -30, 0, 7)
                DropdownIcon.Size = UDim2.new(0, 20, 0, 20)
                DropdownIcon.Image = "rbxassetid://6031094670"
                DropdownIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)

                DropdownBtn.Parent = DropdownFrame
                DropdownBtn.BackgroundTransparency = 1
                DropdownBtn.Size = UDim2.new(1, 0, 0, 35)
                DropdownBtn.Text = ""

                DropdownList.Name = "DropdownList"
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundTransparency = 1
                DropdownList.Position = UDim2.new(0, 5, 0, 35)
                DropdownList.Size = UDim2.new(1, -10, 0, 0)

                ListLayout.Parent = DropdownList
                ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ListLayout.Padding = UDim.new(0, 5)

                for _, v in pairs(list) do
                    local OptionBtn = Instance.new("TextButton")
                    local OptionCorner = Instance.new("UICorner")

                    OptionBtn.Name = v .. "Option"
                    OptionBtn.Parent = DropdownList
                    OptionBtn.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
                    OptionBtn.Size = UDim2.new(1, 0, 0, 25)
                    OptionBtn.Font = Enum.Font.Actor
                    OptionBtn.Text = v
                    OptionBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                    OptionBtn.TextSize = 13

                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionBtn

                    OptionBtn.MouseButton1Click:Connect(function()
                        dropped = false
                        Library:Tween(DropdownFrame, 0.3, {Size = UDim2.new(1, 0, 0, 35)})
                        Library:Tween(DropdownIcon, 0.3, {Rotation = 0})
                        DropdownTitle.Text = text .. " : " .. v
                        callback(v)
                    end)
                end

                DropdownBtn.MouseButton1Click:Connect(function()
                    dropped = not dropped
                    if dropped then
                        Library:Tween(DropdownFrame, 0.3, {Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y + 45)})
                        Library:Tween(DropdownIcon, 0.3, {Rotation = 180})
                    else
                        Library:Tween(DropdownFrame, 0.3, {Size = UDim2.new(1, 0, 0, 35)})
                        Library:Tween(DropdownIcon, 0.3, {Rotation = 0})
                    end
                end)
            end

            function SectionElements:AddSlider(text, min, max, default, callback)
                local SliderFrame = Instance.new("Frame")
                local SliderCorner = Instance.new("UICorner")
                local SliderTitle = Instance.new("TextLabel")
                local SliderBar = Instance.new("Frame")
                local SliderBarCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderVal = Instance.new("TextLabel")
                local SliderBtn = Instance.new("TextButton")

                SliderFrame.Name = text .. "Slider"
                SliderFrame.Parent = SectionContainer
                SliderFrame.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
                SliderFrame.Size = UDim2.new(1, 0, 0, 45)

                SliderCorner.CornerRadius = UDim.new(0, 4)
                SliderCorner.Parent = SliderFrame

                SliderTitle.Parent = SliderFrame
                SliderTitle.BackgroundTransparency = 1
                SliderTitle.Position = UDim2.new(0, 10, 0, 5)
                SliderTitle.Size = UDim2.new(1, -60, 0, 20)
                SliderTitle.Font = Enum.Font.Actor
                SliderTitle.Text = text
                SliderTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                SliderTitle.TextSize = 14
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                SliderVal.Parent = SliderFrame
                SliderVal.BackgroundTransparency = 1
                SliderVal.Position = UDim2.new(1, -50, 0, 5)
                SliderVal.Size = UDim2.new(0, 40, 0, 20)
                SliderVal.Font = Enum.Font.ChangaOne
                SliderVal.Text = tostring(default)
                SliderVal.TextColor3 = Color3.fromRGB(91, 192, 222)
                SliderVal.TextSize = 14
                SliderVal.TextXAlignment = Enum.TextXAlignment.Right

                SliderBar.Parent = SliderFrame
                SliderBar.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
                SliderBar.Position = UDim2.new(0, 10, 0, 30)
                SliderBar.Size = UDim2.new(1, -20, 0, 6)

                SliderBarCorner.CornerRadius = UDim.new(1, 0)
                SliderBarCorner.Parent = SliderBar

                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = Color3.fromRGB(91, 192, 222)
                SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)

                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill

                SliderBtn.Parent = SliderBar
                SliderBtn.BackgroundTransparency = 1
                SliderBtn.Size = UDim2.new(1, 0, 1, 0)
                SliderBtn.Text = ""

                local function move(input)
                    local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local val = math.floor(min + (max - min) * pos)
                    SliderVal.Text = tostring(val)
                    Library:Tween(SliderFill, 0.1, {Size = UDim2.new(pos, 0, 1, 0)})
                    callback(val)
                end

                local dragging = false
                SliderBtn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                SliderBtn.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        move(input)
                    end
                end)
            end

            function SectionElements:AddTextBox(text, placeholder, callback)
                local BoxFrame = Instance.new("Frame")
                local BoxCorner = Instance.new("UICorner")
                local BoxTitle = Instance.new("TextLabel")
                local BoxInput = Instance.new("TextBox")
                local InputCorner = Instance.new("UICorner")

                BoxFrame.Name = text .. "TextBox"
                BoxFrame.Parent = SectionContainer
                BoxFrame.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
                BoxFrame.Size = UDim2.new(1, 0, 0, 35)

                BoxCorner.CornerRadius = UDim.new(0, 4)
                BoxCorner.Parent = BoxFrame

                BoxTitle.Parent = BoxFrame
                BoxTitle.BackgroundTransparency = 1
                BoxTitle.Position = UDim2.new(0, 10, 0, 0)
                BoxTitle.Size = UDim2.new(0, 100, 1, 0)
                BoxTitle.Font = Enum.Font.Actor
                BoxTitle.Text = text
                BoxTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                BoxTitle.TextSize = 14
                BoxTitle.TextXAlignment = Enum.TextXAlignment.Left

                BoxInput.Parent = BoxFrame
                BoxInput.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
                BoxInput.Position = UDim2.new(1, -160, 0.5, -12)
                BoxInput.Size = UDim2.new(0, 150, 0, 24)
                BoxInput.Font = Enum.Font.Actor
                BoxInput.PlaceholderText = placeholder
                BoxInput.Text = ""
                BoxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxInput.TextSize = 13

                InputCorner.CornerRadius = UDim.new(0, 4)
                InputCorner.Parent = BoxInput

                BoxInput.FocusLost:Connect(function(enter)
                    callback(BoxInput.Text)
                end)
            end

            function SectionElements:AddLabel(text)
                local Label = Instance.new("TextLabel")
                Label.Name = text .. "Label"
                Label.Parent = SectionContainer
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(1, 0, 0, 25)
                Label.Font = Enum.Font.Actor
                Label.Text = text
                Label.TextColor3 = Color3.fromRGB(180, 180, 180)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
            end

            return SectionElements
        end

        return Elements
    end

    CloseBtn.MouseButton1Click:Connect(function()
        Capoo:Destroy()
    end)

    return Tabs
end

return Library
