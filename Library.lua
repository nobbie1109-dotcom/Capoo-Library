local Capoo = {}

function Capoo.CreateLib(title, theme)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "CapooLibrary"

    -- Khung chính dựa trên image_493357.png
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(35, 45, 55) -- Nền tối chuyên nghiệp
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    -- Viền xanh dương nhạt "Aqua"
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(173, 216, 230)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    -- Tiêu đề Header (Blox Fruits | Cute Blue 💙)
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MainFrame
    TitleLabel.Text = title
    TitleLabel.Position = UDim2.new(0, 25, 0, 15)
    TitleLabel.Size = UDim2.new(0, 400, 0, 30)
    TitleLabel.TextColor3 = Color3.fromRGB(173, 216, 230)
    TitleLabel.Font = Enum.Font.FredokaOne -- Font tròn cute
    TitleLabel.TextSize = 22
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Sidebar (Thanh menu bên trái)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(45, 55, 65)
    Sidebar.BackgroundTransparency = 0.5
    Sidebar.Position = UDim2.new(0, 15, 0, 65)
    Sidebar.Size = UDim2.new(0, 120, 1, -85)
    
    local SideCorner = Instance.new("UICorner")
    SideCorner.CornerRadius = UDim.new(0, 8)
    SideCorner.Parent = Sidebar

    -- Container chia 2 cột như trong ảnh
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.Position = UDim2.new(0, 145, 0, 65)
    Container.Size = UDim2.new(1, -160, 1, -85)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 2
    Container.CanvasSize = UDim2.new(0, 0, 2, 0)

    local UIGrid = Instance.new("UIGridLayout", Container)
    UIGrid.CellSize = UDim2.new(0, 210, 0, 150)
    UIGrid.CellPadding = UDim2.new(0, 12, 0, 12)

    -- Logic trả về các hàm tạo Tab và Chức năng
    local Tabs = {}
    function Tabs:NewTab(tabName)
        -- Tạo nút Tab ở Sidebar (Giống Update, Main, Sub trong ảnh)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.Font = Enum.Font.FredokaOne
        TabBtn.TextSize = 16

        local Elements = {}
        function Elements:NewToggle(toggleName, callback)
            -- Tạo ô chức năng trong Container (Giống Farming method trong ảnh)
            local Box = Instance.new("Frame", Container)
            Box.BackgroundColor3 = Color3.fromRGB(50, 60, 70)
            Box.BorderSizePixel = 0
            
            local BoxLine = Instance.new("Frame", Box)
            BoxLine.Size = UDim2.new(1, 0, 0, 2)
            BoxLine.BackgroundColor3 = Color3.fromRGB(173, 216, 230) -- Line xanh nhạt
            
            local Label = Instance.new("TextLabel", Box)
            Label.Text = toggleName
            Label.Size = UDim2.new(1, 0, 0, 30)
            Label.Position = UDim2.new(0, 0, 0, 10)
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.FredokaOne
            
            -- Logic Toggle ở đây...
        end
        return Elements
    end
    
    return Tabs
end

return Capoo
