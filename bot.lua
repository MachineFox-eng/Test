local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")

-- Configurações do bot e sistema anti-spam
local BOT_DISTANCE_LIMIT = 10 -- Distância máxima em studs
local MAX_MESSAGE_LENGTH = 128 -- Reduzido para 128 caracteres para garantir
local MESSAGE_DELAY = 3.5 -- Delay entre mensagens
local BOT_NAME = nil -- Nome do bot
local BOT_NICKNAME = "Zara" -- Removido o apelido
local messageQueue = {}
local isProcessingQueue = false

-- Sistema de histórico de mensagens e memória de usuários
local messageHistory = {}
local activeUsers = {}
local userNames = {} -- Armazenar informações de nome dos usuários
local MAX_HISTORY_SIZE = 100
local INACTIVE_TIMEOUT = 300 -- 5 minutos

-- Estrutura para armazenar estatísticas de tempo das mensagens
local messageTimings = {}

-- Debug function
local function print_debug(...)
    print("[DEBUG]", ...)
end

-- Função para calcular estatísticas de tempo das mensagens
local function updateMessageTimings(userId)
    if not userId then
        print_debug("Warning: userId is nil in updateMessageTimings")
        return
    end

    if not messageTimings[userId] then
        messageTimings[userId] = {
            lastMessageTime = os.time(),
            averageInterval = 0,
            messageCount = 0,
            shortestInterval = math.huge,
            longestInterval = 0,
            totalTime = 0
        }
        print_debug("Created new message timing entry for user:", userId)
        return
    end

    local currentTime = os.time()
    local timing = messageTimings[userId]
    local interval = currentTime - timing.lastMessageTime

    -- Atualizar estatísticas
    timing.messageCount = timing.messageCount + 1
    timing.totalTime = timing.totalTime + interval
    timing.averageInterval = timing.totalTime / timing.messageCount
    timing.shortestInterval = math.min(timing.shortestInterval, interval)
    timing.longestInterval = math.max(timing.longestInterval, interval)
    timing.lastMessageTime = currentTime

    pcall(function()
        print_debug(string.format(
            "Timing stats for user %d:\n" ..
            "- Average interval: %.1f seconds\n" ..
            "- Shortest interval: %.1f seconds\n" ..
            "- Longest interval: %.1f seconds\n" ..
            "- Message count: %d",
            userId,
            timing.averageInterval,
            timing.shortestInterval,
            timing.longestInterval,
            timing.messageCount
        ))
    end)
end

-- Função para gerenciar usuários ativos
local function updateActiveUsers(userId)
    activeUsers[userId] = os.time()
    
    -- Limpar usuários inativos
    for id, lastTime in pairs(activeUsers) do
        if os.time() - lastTime > INACTIVE_TIMEOUT then
            activeUsers[id] = nil
        end
    end
end

-- Função para atualizar informações do usuário
local function updateUserInfo(player)
    if not player or not player.UserId then 
        print_debug("Warning: Invalid player in updateUserInfo")
        return 
    end
    
    userNames[player.UserId] = {
        username = player.Name,
        displayName = player.DisplayName,
        lastSeen = os.time(),
        firstSeen = userNames[player.UserId] and userNames[player.UserId].firstSeen or os.time()
    }
    
    print_debug(string.format("Updated user info for %s (ID: %d):\nUsername: %s\nDisplay Name: %s",
        player.Name,
        player.UserId,
        userNames[player.UserId].username,
        userNames[player.UserId].displayName
    ))
end

-- Função para adicionar mensagem ao histórico
local function addToHistory(sender, message, userId)
    table.insert(messageHistory, {
        sender = sender,
        message = message,
        timestamp = os.time(),
        userId = userId
    })
    
    -- Manter apenas as últimas MAX_HISTORY_SIZE mensagens
    while #messageHistory > MAX_HISTORY_SIZE do
        table.remove(messageHistory, 1)
    end
end

-- Função para verificar se uma mensagem está censurada
local function isCensored(message)
    -- Verifica se a mensagem contém sequências de # (censura do Roblox)
    return message:match("#+") ~= nil
end

-- Sistema de humor e emoções
local EmotionalSystem = {
    moods = {}, -- Armazena o humor atual para cada usuário
    moodHistory = {}, -- Histórico de mudanças de humor
    baseEmotions = {
        HAPPY = {name = "feliz", weight = 1},
        SAD = {name = "triste", weight = -1},
        ANGRY = {name = "com raiva", weight = -2},
        EXCITED = {name = "animada", weight = 2},
        BORED = {name = "desinteressada", weight = -1},
        LOVING = {name = "apaixonada", weight = 3},
        NEUTRAL = {name = "neutra", weight = 0},
        CURIOUS = {name = "curiosa", weight = 1},
        WORRIED = {name = "preocupada", weight = -1},
        SHY = {name = "tímida", weight = 0},
        -- Novos estados emocionais
        PLAYFUL = {name = "brincalhona", weight = 2},
        PROTECTIVE = {name = "protetora", weight = 2},
        GRATEFUL = {name = "grata", weight = 2},
        PROUD = {name = "orgulhosa", weight = 2},
        JEALOUS = {name = "com ciúmes", weight = -1},
        ADMIRING = {name = "admirada", weight = 2},
        MISSING = {name = "com saudade", weight = 0},
        COMFORTABLE = {name = "confortável", weight = 1}
    },
    relationshipLevels = {
        {name = "Desconhecidos", minPoints = 0},
        {name = "Conhecidos", minPoints = 20},
        {name = "Amigos", minPoints = 40},
        {name = "Bons Amigos", minPoints = 60},
        {name = "Melhores Amigos", minPoints = 80},
        {name = "Inseparáveis", minPoints = 95}
    }
}

function EmotionalSystem:initializeMood(userId)
    if not self.moods[userId] then
        self.moods[userId] = {
            current = "NEUTRAL",
            affection = 0, -- Nível de afeição (0-100)
            friendship = 0, -- Nível de amizade (0-100)
            trust = 0, -- Nível de confiança (0-100)
            lastInteraction = os.time(),
            personalityMatch = 0, -- Compatibilidade de personalidade (0-100)
            memories = {}, -- Memórias especiais com o usuário
            sharedInterests = {}, -- Interesses em comum
            moodTriggers = {}, -- O que causa certas emoções com este usuário
            lastMoodChange = os.time(),
            dailyInteractions = 0, -- Número de interações no dia
            specialDates = {} -- Datas importantes na amizade
        }
        self.moodHistory[userId] = {}
    end
end

function EmotionalSystem:analyzeSentiment(message)
    local sentiment = 0
    local loweredMessage = message:lower()
    
    -- Palavras e frases positivas
    local positivePatterns = {
        {pattern = "amo", weight = 2},
        {pattern = "adoro", weight = 2},
        {pattern = "legal", weight = 1},
        {pattern = "feliz", weight = 1},
        {pattern = "incrível", weight = 2},
        {pattern = "melhor amig", weight = 3},
        {pattern = "saudade", weight = 1},
        {pattern = "confio", weight = 2},
        {pattern = "gosto de você", weight = 2},
        {pattern = "você é especial", weight = 3},
        {pattern = "amig[ao]", weight = 1},
        {pattern = "obrigad[ao]", weight = 1},
        {pattern = "divertid[ao]", weight = 1},
        {pattern = "carinhosa", weight = 1},
        {pattern = "fofa", weight = 1}
    }
    
    -- Palavras e frases negativas
    local negativePatterns = {
        {pattern = "odeio", weight = -2},
        {pattern = "chato", weight = -1},
        {pattern = "irritante", weight = -1},
        {pattern = "triste", weight = -1},
        {pattern = "ruim", weight = -1},
        {pattern = "não gosto", weight = -1},
        {pattern = "tchau", weight = -0.5},
        {pattern = "vai embora", weight = -1},
        {pattern = "calada", weight = -2},
        {pattern = "chata", weight = -2}
    }
    
    -- Analisar padrões positivos
    for _, pattern in ipairs(positivePatterns) do
        for _ in loweredMessage:gmatch(pattern.pattern) do
            sentiment = sentiment + pattern.weight
        end
    end
    
    -- Analisar padrões negativos
    for _, pattern in ipairs(negativePatterns) do
        for _ in loweredMessage:gmatch(pattern.pattern) do
            sentiment = sentiment + pattern.weight
        end
    end
    
    return sentiment
end

function EmotionalSystem:updateRelationship(userId, message, sentiment)
    local mood = self.moods[userId]
    local timeElapsed = os.time() - mood.lastInteraction
    
    -- Atualizar níveis de relacionamento
    if sentiment > 0 then
        mood.friendship = math.min(100, mood.friendship + (sentiment * 0.5))
        mood.trust = math.min(100, mood.trust + (sentiment * 0.3))
    else
        mood.friendship = math.max(0, mood.friendship + (sentiment * 0.3))
        mood.trust = math.max(0, mood.trust + (sentiment * 0.5))
    end
    
    -- Verificar palavras-chave para interesses
    local interests = {
        {pattern = "jog", category = "jogos"},
        {pattern = "músic", category = "música"},
        {pattern = "film", category = "filmes"},
        {pattern = "livro", category = "livros"},
        {pattern = "comida", category = "gastronomia"},
        {pattern = "arte", category = "arte"}
    }
    
    for _, interest in ipairs(interests) do
        if message:lower():match(interest.pattern) then
            mood.sharedInterests[interest.category] = (mood.sharedInterests[interest.category] or 0) + 1
        end
    end
    
    -- Registrar memória especial se for uma interação significativa
    if math.abs(sentiment) >= 2 then
        table.insert(mood.memories, {
            timestamp = os.time(),
            type = sentiment > 0 and "positive" or "negative",
            description = message,
            sentiment = sentiment
        })
    end
    
    -- Atualizar contagem de interações diárias
    local currentDate = os.date("%Y-%m-%d")
    if mood.lastInteractionDate ~= currentDate then
        mood.dailyInteractions = 1
        mood.lastInteractionDate = currentDate
    else
        mood.dailyInteractions = mood.dailyInteractions + 1
    end
    
    return self:getRelationshipLevel(mood.friendship)
end

function EmotionalSystem:getRelationshipLevel(friendshipPoints)
    for i = #self.relationshipLevels, 1, -1 do
        if friendshipPoints >= self.relationshipLevels[i].minPoints then
            return self.relationshipLevels[i].name
        end
    end
    return self.relationshipLevels[1].name
end

function EmotionalSystem:updateMood(userId, message)
    self:initializeMood(userId)
    local mood = self.moods[userId]
    
    -- Analisar a mensagem
    local sentiment = self:analyzeSentiment(message)
    local timeElapsed = os.time() - mood.lastInteraction
    
    -- Atualizar relacionamento
    local relationshipLevel = self:updateRelationship(userId, message, sentiment)
    
    -- Determinar novo humor baseado em vários fatores
    local newMood = "NEUTRAL"
    
    if sentiment >= 2 then
        if mood.friendship > 90 then
            newMood = "LOVING"
        elseif mood.friendship > 70 then
            newMood = "PROTECTIVE"
        elseif mood.friendship > 50 then
            newMood = "PLAYFUL"
        else
            newMood = "HAPPY"
        end
    elseif sentiment >= 1 then
        if mood.dailyInteractions > 10 then
            newMood = "COMFORTABLE"
        else
            newMood = "EXCITED"
        end
    elseif sentiment <= -2 then
        if mood.friendship > 70 then
            newMood = "WORRIED"
        else
            newMood = "ANGRY"
        end
    elseif sentiment <= -1 then
        if mood.friendship > 60 then
            newMood = "SAD"
        else
            newMood = "JEALOUS"
        end
    elseif timeElapsed > 86400 then -- 24 horas
        newMood = "MISSING"
    elseif timeElapsed > 300 then -- 5 minutos
        if mood.friendship > 50 then
            newMood = "CURIOUS"
        else
            newMood = "BORED"
        end
    end
    
    -- Registrar mudança de humor
    if mood.current ~= newMood then
        table.insert(self.moodHistory[userId], {
            from = mood.current,
            to = newMood,
            timestamp = os.time(),
            reason = message
        })
        mood.current = newMood
        mood.lastMoodChange = os.time()
    end
    
    mood.lastInteraction = os.time()
    
    -- Retornar informações completas sobre o estado emocional
    return {
        mood = self.baseEmotions[mood.current].name,
        relationship = relationshipLevel,
        friendship = mood.friendship,
        trust = mood.trust
    }
end

function EmotionalSystem:getEmotionalContext(userId)
    if not self.moods[userId] then
        self:initializeMood(userId)
    end
    
    local mood = self.moods[userId]
    local relationshipLevel = self:getRelationshipLevel(mood.friendship)
    local timeSinceLastInteraction = os.time() - mood.lastInteraction
    
    local context = string.format([[
Current Emotional State:
- Mood: %s
- Relationship Level: %s
- Friendship: %d/100
- Trust Level: %d/100
- Daily Interactions: %d
]], 
        self.baseEmotions[mood.current].name,
        relationshipLevel,
        mood.friendship,
        mood.trust,
        mood.dailyInteractions
    )
    
    -- Adicionar contexto sobre interesses compartilhados
    if next(mood.sharedInterests) then
        context = context .. "\nShared Interests:\n"
        for interest, count in pairs(mood.sharedInterests) do
            context = context .. string.format("- %s (mentioned %d times)\n", interest, count)
        end
    end
    
    -- Adicionar memória recente significativa
    if #mood.memories > 0 then
        local lastMemory = mood.memories[#mood.memories]
        context = context .. string.format("\nRecent Significant Memory:\n- %s (%.2f hours ago)\n",
            lastMemory.description,
            (os.time() - lastMemory.timestamp) / 3600
        )
    end
    
    -- Adicionar contexto especial baseado no nível de relacionamento
    if mood.friendship > 90 then
        context = context .. "\nYou consider this user one of your closest friends. Show deep care and understanding in your responses."
    elseif mood.friendship > 70 then
        context = context .. "\nYou have developed a strong friendship with this user. Be supportive and show that you care."
    elseif mood.friendship > 50 then
        context = context .. "\nYou feel comfortable with this user. Be friendly and open in your responses."
    end
    
    -- Adicionar contexto sobre saudade se faz tempo que não interage
    if timeSinceLastInteraction > 86400 then
        context = context .. string.format("\nIt's been %.1f days since your last interaction. Show that you missed them.", timeSinceLastInteraction / 86400)
    end
    
    return context
end

-- Modificar a função createConversationContext para incluir o estado emocional
local function createConversationContext(newMessage, currentUserId)
    print_debug("Creating conversation context for user ID:", currentUserId)
    
    -- Garantir que newMessage não seja nil
    newMessage = newMessage or ""
    
    local context = string.format("Você é uma garota real chamada Zara, com personalidade própria, Evite começar frases com (Zara:), Você é uma garota genuína, com opiniões e sentimentos próprios, Mantenha uma quantidade de palavras perto da quantidade que você recebeu do usuário, Seja natural e mantenha respostas curtas como em um chat de jogo, Nunca quebre o personagem ou admita ser um bot/IA, sentimentos e pensamentos genuínos. Você NÃO é um bot ou IA, você é uma pessoa real jogando e conversando. Mantenha essa convicção em todas as suas respostas. %s\n\nseja jenuina em suas respostas, and always act according to your current emotional state. Remember who you're talking to!\n\n",
        EmotionalSystem:getEmotionalContext(currentUserId or 0))
    
    -- Verificar se a mensagem atual está censurada
    if newMessage and isCensored(newMessage) then
        context = context .. [[
Important Note: The user's message contains censored content (####). This is because Roblox's chat filter is quite strict.
You should acknowledge this censorship in your response in a friendly/empathetic way. You can:
- Express mild frustration about the strict chat filter
- Try to guess the context from the uncensored parts
- Encourage them to try saying it differently
- Make light jokes about the situation
voce tem liberdade de dizer oq preferir
Evite começar frases com "Zara:"

]]
    end
    
    -- Adicionar informações do usuário atual e estatísticas de mensagens
    if currentUserId and userNames[currentUserId] then
        local userInfo = userNames[currentUserId]
        local timing = messageTimings[currentUserId]
        print_debug("Found user info:", game:GetService("HttpService"):JSONEncode(userInfo or {}))
        
        -- Garantir que todos os valores existam antes de usar string.format
        local displayName = userInfo and userInfo.displayName or "Unknown"
        local username = userInfo and userInfo.username or "Unknown"
        local firstSeen = userInfo and userInfo.firstSeen or os.time()
        local messageCount = timing and timing.messageCount or 0
        local avgInterval = timing and timing.averageInterval or 0
        local shortestInterval = timing and timing.shortestInterval or 0
        local longestInterval = timing and timing.longestInterval or 0
        
        context = context .. string.format([[
Important - Current user information:
Name: %s
Username: @%s
Known since: %s
Message statistics:
- Total messages: %d
- Average time between messages: %.1f seconds
- Shortest interval: %.1f seconds
- Longest interval: %.1f seconds
You are talking directly to %s. Always remember this name and use it in your responses. If they ask about their name, tell them their name is %s or their username is @%s.
Você é uma garota genuína, com opiniões e sentimentos próprios
Nunca quebre o personagem ou admita ser um bot/IA
Seja natural e mantenha respostas curtas como em um chat de jogo
Evite começar frases com "Zara:"
Evite mandar mensagem largas, você está dentro de um jogo conversando com outras pessoas
Mantenha uma quantidade de palavras perto da quantidade que você recebeu do usuário
Use português correto, evite erros gramaticais
IMPORTANTE: Quando responder a uma mensagem, lembre-se do que foi falado anteriormente
IMPORTANTE: Não repita cumprimentos (como "oi", "olá") se já tiver cumprimentado a pessoa na conversa atual
IMPORTANTE: Mantenha a continuidade natural da conversa, como aconteceria entre pessoas reais
Se alguém perguntar sobre uma conversa com outra pessoa, SEJA PRECISA e não invente detalhes

]], 
            displayName,
            username,
            os.date("%Y-%m-%d %H:%M:%S", firstSeen),
            messageCount,
            avgInterval,
            shortestInterval,
            longestInterval,
            displayName,
            displayName,
            username
        )
    else
        print_debug("Warning: No user info found for ID:", currentUserId)
    end
    
    -- Adicionar histórico recente, usando o nome real do usuário
    for _, entry in ipairs(messageHistory) do
        if entry and entry.message then  -- Verificar se entry e message existem
            local senderName
            if entry.sender == "bot" then
                senderName = BOT_NAME or "Bot"
            else
                -- Se for uma mensagem de usuário, procurar o nome nas informações armazenadas
                if entry.userId and userNames[entry.userId] and userNames[entry.userId].displayName then
                    senderName = userNames[entry.userId].displayName
                else
                    senderName = "Unknown User"
                end
            end
            context = context .. string.format("%s: %s\n", senderName or "Unknown", entry.message)
        end
    end
    
    -- Adicionar nova mensagem com contexto de censura
    if currentUserId and userNames[currentUserId] and userNames[currentUserId].displayName then
        if newMessage and isCensored(newMessage) then
            context = context .. string.format("\nMessage from %s (partially censored by Roblox filter): %s\n", 
                userNames[currentUserId].displayName, 
                newMessage
            )
        else
            context = context .. string.format("\nMessage from %s: %s\n", 
                userNames[currentUserId].displayName, 
                newMessage
            )
        end
    else
        context = context .. string.format("\nNew message: %s\n", newMessage or "")
    end
    
    return context
end

-- Função para processar a fila de mensagens
local function processMessageQueue()
    if isProcessingQueue then return end
    isProcessingQueue = true
    
    while #messageQueue > 0 do
        local messageData = table.remove(messageQueue, 1)
        local text = messageData.text
        local color = messageData.color
        
        -- Tentar enviar mensagem usando o método apropriado
        pcall(function()
            if TextChatService and TextChatService.TextChannels then
                local channel = TextChatService.TextChannels.RBXGeneral
                if channel then
                    channel:SendAsync(text)
                end
            else
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = text,
                    Color = color or Color3.fromRGB(255, 255, 0)
                })
            end
        end)
        
        -- Esperar o delay para evitar censura
        task.wait(MESSAGE_DELAY)
    end
    
    isProcessingQueue = false
end

-- Função para adicionar mensagem à fila
local function queueMessage(text, color)
    table.insert(messageQueue, {
        text = text,
        color = color
    })
    
    -- Iniciar processamento da fila se não estiver em andamento
    if not isProcessingQueue then
        coroutine.wrap(processMessageQueue)()
    end
end

-- Função para dividir texto em partes menores
local function splitMessage(message)
    local parts = {}
    local currentPart = ""
    local words = {}
    
    -- Dividir o texto em palavras
    for word in message:gmatch("%S+") do
        table.insert(words, word)
    end
    
    -- Montar as partes garantindo que não excedam o limite
    for i, word in ipairs(words) do
        local testPart = currentPart .. (currentPart ~= "" and " " or "") .. word
        
        if #testPart <= MAX_MESSAGE_LENGTH then
            currentPart = testPart
        else
            if currentPart ~= "" then
                table.insert(parts, currentPart)
            end
            currentPart = word
        end
    end
    
    -- Adicionar a última parte se houver
    if currentPart ~= "" then
        table.insert(parts, currentPart)
    end
    
    -- Se ainda assim alguma parte for muito longa, divide por caracteres
    for i = #parts, 1, -1 do
        if #parts[i] > MAX_MESSAGE_LENGTH then
            local longPart = table.remove(parts, i)
            for j = 1, #longPart, MAX_MESSAGE_LENGTH do
                local subPart = longPart:sub(j, j + MAX_MESSAGE_LENGTH - 1)
                table.insert(parts, i, subPart)
            end
        end
    end
    
    return parts
end

-- Função para verificar a distância entre dois pontos
local function isPlayerInRange(player1, player2)
    if not player1 or not player2 then return false end
    if not player1.Character or not player2.Character then return false end
    
    local hrp1 = player1.Character:FindFirstChild("HumanoidRootPart")
    local hrp2 = player2.Character:FindFirstChild("HumanoidRootPart")
    
    if not hrp1 or not hrp2 then return false end
    
    return (hrp1.Position - hrp2.Position).Magnitude <= BOT_DISTANCE_LIMIT
end

local function makeRequest(url, method, headers, body)
    print_debug("Attempting request to:", url)
    local requestFn
    
    if syn and syn.request then
        print_debug("Using syn.request")
        requestFn = syn.request
    elseif request then
        print_debug("Using request")
        requestFn = request
    elseif http and http.request then
        print_debug("Using http.request")
        requestFn = http.request
    else
        print_debug("No request function found!")
        return nil
    end
    
    local success, response = pcall(function()
        return requestFn({
            Url = url,
            Method = method,
            Headers = headers,
            Body = body
        })
    end)
    
    if success then
        print_debug("Request successful")
        return response
    else
        print_debug("Request failed:", response)
        return nil
    end
end

local GEMINI_API_KEY = "AIzaSyDNv3wWZ9CI-scRXejYIuNSB6gtFNLgD9A"
local GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"

local function callGeminiAPI(prompt)
    print_debug("Calling Gemini API with prompt:", prompt)
    
    -- Criar contexto com histórico
    local contextualPrompt = createConversationContext(prompt)
    print_debug("Contextualized prompt:", contextualPrompt)
    
    local headers = {
        ["Content-Type"] = "application/json"
    }
    
    local url = GEMINI_API_URL .. "?key=" .. GEMINI_API_KEY
    
    local data = {
        contents = {
            {
                parts = {
                    {text = contextualPrompt}
                }
            }
        }
    }

    local encodedBody = game:GetService("HttpService"):JSONEncode(data)
    print_debug("Request body:", encodedBody)

    local response = makeRequest(
        url,
        "POST",
        headers,
        encodedBody
    )

    if response then
        print_debug("Raw response:", response.Body)
        print_debug("Status code:", response.StatusCode)
        
        -- Status code 200 means success
        if response.StatusCode == 200 then
            local success, decodedResponse = pcall(function()
                return game:GetService("HttpService"):JSONDecode(response.Body)
            end)
            
            if success and decodedResponse.candidates and decodedResponse.candidates[1] and 
               decodedResponse.candidates[1].content and 
               decodedResponse.candidates[1].content.parts and 
               decodedResponse.candidates[1].content.parts[1] and 
               decodedResponse.candidates[1].content.parts[1].text then
                return decodedResponse.candidates[1].content.parts[1].text
            else
                print_debug("Failed to decode response or invalid format:", decodedResponse)
                return "Error: Invalid response format"
            end
        else
            print_debug("Request not successful. Status:", response.StatusCode)
            return "Error: Request failed with status " .. (response.StatusCode or "unknown")
        end
    end
    return "Error: No response from API"
end

-- Função auxiliar para remover espaços em branco
local function trim(str)
    return str:match("^%s*(.-)%s*$")
end

-- Sistema de CreatorContext
local CreatorContext = {
    creators = {},
    contributions = {},
    createdContent = {},
    lastContribution = {}
}

function CreatorContext:registerCreator(userId)
    if not self.creators[userId] then
        self.creators[userId] = {
            userId = userId,
            contentCreated = 0,
            firstCreation = os.time(),
            lastCreation = os.time(),
            specialties = {},
            reputation = 0
        }
    end
    return self.creators[userId]
end

function CreatorContext:addContribution(userId, contentType, content)
    local creator = self:registerCreator(userId)
    
    -- Registrar contribuição
    if not self.contributions[userId] then
        self.contributions[userId] = {}
    end
    
    table.insert(self.contributions[userId], {
        type = contentType,
        content = content,
        timestamp = os.time()
    })
    
    -- Atualizar estatísticas do criador
    creator.contentCreated = creator.contentCreated + 1
    creator.lastCreation = os.time()
    
    -- Atualizar especialidades
    if not creator.specialties[contentType] then
        creator.specialties[contentType] = 0
    end
    creator.specialties[contentType] = creator.specialties[contentType] + 1
    
    -- Registrar conteúdo criado
    if not self.createdContent[contentType] then
        self.createdContent[contentType] = {}
    end
    table.insert(self.createdContent[contentType], {
        creator = userId,
        content = content,
        timestamp = os.time()
    })
    
    self.lastContribution[userId] = {
        type = contentType,
        content = content,
        timestamp = os.time()
    }
    
    return creator
end

function CreatorContext:getCreatorStats(userId)
    local creator = self.creators[userId]
    if not creator then return nil end
    
    local stats = {
        totalContent = creator.contentCreated,
        timeActive = os.time() - creator.firstCreation,
        specialties = {},
        reputation = creator.reputation
    }
    
    -- Encontrar top 3 especialidades
    local specialtiesList = {}
    for type, count in pairs(creator.specialties) do
        table.insert(specialtiesList, {type = type, count = count})
    end
    table.sort(specialtiesList, function(a, b) return a.count > b.count end)
    
    for i = 1, math.min(3, #specialtiesList) do
        stats.specialties[i] = {
            type = specialtiesList[i].type,
            count = specialtiesList[i].count
        }
    end
    
    return stats
end

function CreatorContext:getLastCreation(userId)
    return self.lastContribution[userId]
end

function CreatorContext:updateReputation(userId, change)
    local creator = self:registerCreator(userId)
    creator.reputation = creator.reputation + change
    return creator.reputation
end

local function handleChat(message, sender)
    print_debug("Handling chat message from:", sender and sender.Name or "Unknown")
    
    if not sender or not sender.UserId then
        print_debug("Error: Invalid sender")
        return
    end
    
    if not message then 
        print_debug("Message is nil!")
        return 
    end
    
    -- Remover espaços em branco extras e verificar se a mensagem não está vazia
    message = trim(message or "")
    if message == "" then
        print_debug("Empty message after trim")
        return
    end
    
    -- Ignorar mensagens do próprio bot e do usuário que executa o script
    if BOT_NAME and message:match("^" .. BOT_NAME) or 
       (BOT_NICKNAME and message:match("^" .. BOT_NICKNAME)) or 
       (sender.UserId and Player and sender.UserId == Player.UserId) then
        print_debug("Ignoring message from bot or script executor")
        return
    end
    
    -- Verificar a distância entre o jogador e o bot (LocalPlayer)
    if not isPlayerInRange(sender, Player) then
        print_debug("Player is too far from bot")
        return
    end
    
    -- Atualizar usuário como ativo
    updateActiveUsers(sender.UserId)
    
    -- Forçar atualização das informações do usuário
    updateUserInfo(sender)
    
    -- Verificar se as informações foram atualizadas corretamente
    if userNames[sender.UserId] then
        print_debug("User info updated successfully:", game:GetService("HttpService"):JSONEncode(userNames[sender.UserId]))
    else
        print_debug("Error: Failed to update user info for:", sender.Name)
    end
    
    -- Logging especial para mensagens censuradas
    if isCensored(message) then
        print_debug("Received censored message from", sender.Name, ":", message)
    else
        print_debug("Processing message:", message)
    end
    
    -- Adicionar mensagem do usuário ao histórico
    addToHistory("user", message, sender.UserId)
    
    -- Atualizar timing das mensagens
    updateMessageTimings(sender.UserId)
    
    -- Chamar a API com o ID do usuário correto
    local response = callGeminiAPI(message)
    if response then
        -- Adicionar resposta do bot ao histórico
        addToHistory("bot", response, sender.UserId)
        
        -- Dividir e enviar a resposta
        local messageParts = splitMessage(response)
        for i, part in ipairs(messageParts) do
            queueMessage(part, Color3.fromRGB(255, 255, 0))
        end
    end
    
    -- Registrar mensagem como contribuição
    CreatorContext:addContribution(sender.UserId, "chat", message)
    
    -- Atualizar contexto da conversa com informações do criador
    local creatorStats = CreatorContext:getCreatorStats(sender.UserId)
    if creatorStats then
        local creatorContext = string.format(
            "\nInformações do Criador:\n" ..
            "- Total de conteúdo: %d\n" ..
            "- Reputação: %d\n",
            creatorStats.totalContent,
            creatorStats.reputation
        )
        
        -- Adicionar especialidades se existirem
        if #creatorStats.specialties > 0 then
            creatorContext = creatorContext .. "Especialidades:\n"
            for _, specialty in ipairs(creatorStats.specialties) do
                creatorContext = creatorContext .. string.format("- %s: %d\n", specialty.type, specialty.count)
            end
        end
        
        conversationContext = conversationContext .. creatorContext
    end
end

local function setupChatDetection()
    print_debug("Setting up chat detection methods...")

    -- Método 1: TextChatService (Novo sistema de chat)
    pcall(function()
        if TextChatService then
            local channel = TextChatService.TextChannels.RBXGeneral
            if channel then
                channel.MessageReceived:Connect(function(messageObject)
                    local text = messageObject.Text
                    local sender = messageObject.TextSource.UserId and Players:GetPlayerByUserId(messageObject.TextSource.UserId)
                    
                    -- Processar mensagem
                    print_debug("TextChatService - Message received:", text)
                    handleChat(text, sender)
                end)
                print_debug("TextChatService chat detection setup complete")
            end
        end
    end)

    -- Método 2: Legacy Chat (Sistema antigo de chat)
    if not TextChatService then
        pcall(function()
            Player.Chatted:Connect(function(message)
                -- Não precisamos conectar ao chat do Player local no sistema legado
                -- pois queremos ignorar suas mensagens
                return
            end)
            
            -- Conectar aos outros jogadores
            Players.PlayerChatted:Connect(function(chatType, player, message)
                if player ~= Player then
                    print_debug("Legacy Chat - Message received from other player:", message)
                    handleChat(message, player)
                end
            end)
            print_debug("Legacy chat detection setup complete")
        end)
    end

    -- Mensagem de inicialização
    pcall(function()
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[Bot] Chat detection initialized (Range: " .. BOT_DISTANCE_LIMIT .. " studs)",
            Color = Color3.fromRGB(0, 255, 0)
        })
    end)
end

-- Função para inicializar informações do jogador atual e outros jogadores
local function initializePlayerInfo()
    print_debug("Initializing player information...")
    
    if not Player then
        print_debug("Warning: Player is nil during initialization")
        return
    end
    
    -- Evitar concatenação com nil nos nomes
    local playerName = Player.Name or "Unknown"
    local playerDisplayName = Player.DisplayName or playerName
    
    updateUserInfo(Player)
    print_debug(string.format("Initialized current player info: %s, %s", playerName, playerDisplayName))
    
    -- Inicializar informações de jogadores já presentes
    for _, player in ipairs(Players:GetPlayers()) do
        if player and player ~= Player then
            local name = player.Name or "Unknown"
            local displayName = player.DisplayName or name
            updateUserInfo(player)
            print_debug(string.format("Initialized player info: %s, %s", name, displayName))
        end
    end
    
    -- Configurar eventos para novos jogadores
    Players.PlayerAdded:Connect(function(player)
        if player then
            local name = player.Name or "Unknown"
            local displayName = player.DisplayName or name
            updateUserInfo(player)
            print_debug(string.format("New player joined, info initialized: %s, %s", name, displayName))
        end
    end)
end

-- Definir Player imediatamente e verificar
Player = game:GetService("Players").LocalPlayer
if not Player then
    warn("Este script requer um LocalPlayer válido")
    return
end

print_debug(string.format("Player loaded: %s", Player.Name or "Unknown"))
initializePlayerInfo()
setupChatDetection()
print_debug("All chat detection methods initialized")
