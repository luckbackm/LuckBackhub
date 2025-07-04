local urlKeys = "https://raw.githubusercontent.com/luckbackm/Keys/main/Key.txt"

local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local titulo = Instance.new("TextLabel", frame)
titulo.Size = UDim2.new(1, 0, 0, 40)
titulo.BackgroundTransparency = 1
titulo.Text = "🔐 Digite sua Key"
titulo.Font = Enum.Font.SourceSansBold
titulo.TextSize = 22
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)

local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Cole aqui: KEY|AAAA-MM-DD"
input.Size = UDim2.new(0.9, 0, 0, 35)
input.Position = UDim2.new(0.05, 0, 0, 55)
input.Font = Enum.Font.SourceSans
input.TextSize = 18
input.Text = ""
input.ClearTextOnFocus = false
input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
input.TextColor3 = Color3.fromRGB(255, 255, 255)

local botao = Instance.new("TextButton", frame)
botao.Text = "Verificar Key"
botao.Size = UDim2.new(0.9, 0, 0, 35)
botao.Position = UDim2.new(0.05, 0, 0, 100)
botao.Font = Enum.Font.SourceSansBold
botao.TextSize = 20
botao.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)

local copiar = Instance.new("TextButton", gui)
copiar.Text = "Get Key"
copiar.Size = UDim2.new(0, 80, 0, 30)
copiar.Position = UDim2.new(0.5, 160, 0.5, -80)
copiar.Font = Enum.Font.SourceSansBold
copiar.TextSize = 16
copiar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
copiar.TextColor3 = Color3.fromRGB(255, 255, 255)

copiar.MouseButton1Click:Connect(function()
    local ok, raw = pcall(function()
        return game:HttpGet(urlKeys)
    end)
    if ok then
        local linhas = {}
        for linha in raw:gmatch("[^\r\n]+") do
            table.insert(linhas, linha)
        end
        if #linhas > 0 then
            local aleatoria = linhas[math.random(1, #linhas)]
            setclipboard(aleatoria)
            copiar.Text = "Copiado!"
            wait(1.5)
            copiar.Text = "Get Key"
        end
    else
        copiar.Text = "Erro!"
        wait(1.5)
        copiar.Text = "Get Key"
    end
end)

local function dataValida(dataExp)
    local y, m, d = dataExp:match("^(%d+)%-(%d+)%-(%d+)$")
    if y and m and d then
        local hoje = os.time()
        local expira = os.time({year=tonumber(y), month=tonumber(m), day=tonumber(d)})
        return hoje <= expira
    end
    return false
end

botao.MouseButton1Click:Connect(function()
    local linha = input.Text
    local key, data = linha:match("^(.-)|(.+)$")
    if key and data and dataValida(data) then
        frame:Destroy()
        copiar:Destroy()
        print("✅ Key válida! Script autorizado.") loadstring(game:HttpGet("https://raw.githubusercontent.com/luckbackm/LuckBackhub/refs/heads/main/LuckBackHub.lua"))()
    else
        input.Text = ""
        titulo.Text = "❌ Key inválida ou expirada!"
        titulo.TextColor3 = Color3.fromRGB(255, 80, 80)
        wait(1.5)
        titulo.Text = "🔐 Digite sua Key"
        titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)