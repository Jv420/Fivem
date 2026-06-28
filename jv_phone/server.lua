local phoneData = {}
local numberToIdentifier = {}
local DATA_FILE = 'phone_data.json'

local function loadData()
    local raw = LoadResourceFile(GetCurrentResourceName(), DATA_FILE)
    if raw and raw ~= '' then
        phoneData = json.decode(raw) or {}
    else
        phoneData = {}
    end

    numberToIdentifier = {}
    for identifier, data in pairs(phoneData) do
        if data.number then
            numberToIdentifier[data.number] = identifier
        end
    end
end

local function saveData()
    SaveResourceFile(GetCurrentResourceName(), DATA_FILE, json.encode(phoneData, { indent = true }), -1)
end

local function getIdentifier(src)
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if id:find('license:') then
            return id
        end
    end
    return ('source:%s'):format(src)
end

local function getPlayerNameSafe(src)
    local name = GetPlayerName(src)
    if not name or name == '' then
        return ('Speler %s'):format(src)
    end
    return name
end

local function generateNumber()
    local tries = 0
    while tries < 1000 do
        tries = tries + 1
        local number = Config.NumberPrefix
        for _ = 1, Config.NumberLength do
            number = number .. tostring(math.random(0, 9))
        end
        if not numberToIdentifier[number] then
            return number
        end
    end
    return Config.NumberPrefix .. tostring(os.time())
end

local function getOrCreatePlayerData(src)
    local identifier = getIdentifier(src)
    if not phoneData[identifier] then
        local number = generateNumber()
        phoneData[identifier] = {
            number = number,
            name = getPlayerNameSafe(src),
            messages = {}
        }
        numberToIdentifier[number] = identifier
        saveData()
    else
        phoneData[identifier].name = getPlayerNameSafe(src)
        phoneData[identifier].messages = phoneData[identifier].messages or {}
    end
    return phoneData[identifier], identifier
end

local function findOnlinePlayerByIdentifier(identifier)
    for _, playerId in ipairs(GetPlayers()) do
        if getIdentifier(tonumber(playerId)) == identifier then
            return tonumber(playerId)
        end
    end
    return nil
end

local function serviceExists(serviceId)
    for _, service in ipairs(Config.Services) do
        if service.id == serviceId then
            return true
        end
    end
    return false
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    math.randomseed(os.time())
    loadData()
end)

AddEventHandler('playerJoining', function()
    local src = source
    SetTimeout(3000, function()
        getOrCreatePlayerData(src)
    end)
end)

RegisterNetEvent('jv_phone:server:getPhoneData', function()
    local src = source
    local data = getOrCreatePlayerData(src)
    TriggerClientEvent('jv_phone:client:setPhoneData', src, {
        number = data.number,
        messages = data.messages or {}
    })
end)

RegisterNetEvent('jv_phone:server:sendSms', function(targetNumber, text)
    local src = source
    local senderData = getOrCreatePlayerData(src)

    targetNumber = tostring(targetNumber or ''):gsub('%s+', '')
    text = tostring(text or ''):sub(1, Config.MaxSmsLength or 220)

    if targetNumber == '' or text:gsub('%s+', '') == '' then
        TriggerClientEvent('jv_phone:client:notify', src, 'Vul een nummer en bericht in.')
        return
    end

    local targetIdentifier = numberToIdentifier[targetNumber]
    if not targetIdentifier or not phoneData[targetIdentifier] then
        TriggerClientEvent('jv_phone:client:notify', src, 'Dit telefoonnummer bestaat niet.')
        return
    end

    local sms = {
        from = senderData.number,
        fromName = getPlayerNameSafe(src),
        to = targetNumber,
        text = text,
        time = os.date('%d-%m %H:%M')
    }

    phoneData[targetIdentifier].messages = phoneData[targetIdentifier].messages or {}
    table.insert(phoneData[targetIdentifier].messages, 1, sms)

    while #phoneData[targetIdentifier].messages > 50 do
        table.remove(phoneData[targetIdentifier].messages)
    end

    saveData()

    local onlineTarget = findOnlinePlayerByIdentifier(targetIdentifier)
    if onlineTarget then
        TriggerClientEvent('jv_phone:client:newSms', onlineTarget, sms)
        TriggerClientEvent('jv_phone:client:notify', onlineTarget, ('Nieuwe SMS van %s'):format(senderData.number))
    end

    TriggerClientEvent('jv_phone:client:notify', src, 'SMS verstuurd.')
end)

RegisterNetEvent('jv_phone:server:requestService', function(serviceId, message, coords)
    local src = source
    local senderData = getOrCreatePlayerData(src)

    if not serviceExists(serviceId) then
        TriggerClientEvent('jv_phone:client:notify', src, 'Deze service bestaat niet.')
        return
    end

    message = tostring(message or '')
    if message:gsub('%s+', '') == '' then
        message = 'Geen extra bericht ingevuld.'
    end

    coords = coords or { x = 0.0, y = 0.0, z = 0.0 }
    local playerName = getPlayerNameSafe(src)

    TriggerClientEvent('jv_phone:client:serviceAlert', -1, serviceId, playerName, message, coords)
    TriggerClientEvent('jv_phone:client:notify', src, ('Je melding is verstuurd. Jouw nummer: %s'):format(senderData.number))

    print(('[jv_phone] %s (%s) requested %s: %s at %.2f %.2f %.2f'):format(playerName, senderData.number, serviceId, message, coords.x, coords.y, coords.z))
end)

RegisterCommand('taxi', function(source, args)
    local message = table.concat(args, ' ')
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)

    TriggerEvent('jv_phone:server:requestService', 'taxi', message, {
        x = coords.x,
        y = coords.y,
        z = coords.z
    })
end, false)

RegisterCommand('mijnnummer', function(source)
    local data = getOrCreatePlayerData(source)
    TriggerClientEvent('jv_phone:client:notify', source, ('Jouw telefoonnummer is: %s'):format(data.number))
end, false)

RegisterCommand('sms', function(source, args)
    local target = args[1]
    table.remove(args, 1)
    local text = table.concat(args, ' ')
    TriggerEvent('jv_phone:server:sendSms', target, text)
end, false)
