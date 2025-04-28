--// Script Roblox em português - Função de Seguir
local BF_USERNAME = "MachineFox_OFICIAL" -- Nome do usuário para seguir
local TP_DISTANCE = 30 -- Distância para teleporte
local GF_WALKSPEED = 16 -- Velocidade de caminhada
local GF_RIGHT_OFFSET = 3 -- Deslocamento para a direita
local GF_FRONT_OFFSET = 0 -- Deslocamento para frente

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidrootpart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")

-- Atualiza referências quando o personagem é carregado
player.CharacterAdded:Connect(function()
    character = player.Character
    humanoidrootpart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
end)

-- Encontra o jogador alvo
local BF = game:GetService("Players"):WaitForChild(BF_USERNAME, 10)

if not BF then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "NOTIFICAÇÃO",
        Text = "Jogador não encontrado!",
        Duration = 5
    })
    return
end

-- Função para enviar mensagens no chat
local function chat(str)
    if game:GetService('TextChatService').ChatVersion == Enum.ChatVersion.LegacyChatService then
        game:GetService('ReplicatedStorage'):FindFirstChild("SayMessageRequest", true):FireServer(str, "All")
    else
        game:GetService('TextChatService').TextChannels.RBXGeneral:SendAsync(str)
    end
end

-- Estado de seguir
local following = true

-- Detecta comandos no chat
BF.Chatted:Connect(function(msg)
    if msg:lower():find("seguir") then
        following = true
    elseif msg:lower():find("parar") then
        following = false
    end
end)

-- Loop principal de movimento
game:GetService("RunService").RenderStepped:Connect(function()
    if humanoid then
        local bfCharacter = BF.Character
        if bfCharacter and bfCharacter:FindFirstChild("HumanoidRootPart") then
            -- Sincroniza pulos
            if bfCharacter.Humanoid.Jump then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end

            -- Calcula posição
            local bfPosition = bfCharacter.HumanoidRootPart.Position
            local offsetPosition = bfPosition + 
                (bfCharacter.HumanoidRootPart.CFrame.LookVector * GF_FRONT_OFFSET) + 
                (bfCharacter.HumanoidRootPart.CFrame.RightVector * GF_RIGHT_OFFSET)

            -- Move ou teleporta baseado na distância
            local distance = (humanoidrootpart.Position - bfPosition).Magnitude
            if distance > TP_DISTANCE then
                humanoidrootpart.CFrame = CFrame.new(offsetPosition)
            elseif following then
                humanoid:MoveTo(offsetPosition)
                humanoid.WalkSpeed = GF_WALKSPEED
            end
        end
    end
end)
