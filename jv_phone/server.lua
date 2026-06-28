local function getPlayerNameSafe(source)
    local name = GetPlayerName(source)
    if not name or name == '' then
        return ('Speler %s'):format(source)
    end
    return name
end

local function serviceExists(serviceId)
    for _, service in ipairs(Config.Services) do
        if service.id == serviceId then
            return true
        end
    end
    return false
end

RegisterNetEvent('jv_phone:server:requestService', function(serviceId, message, coords)
    local src = source

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
    TriggerClientEvent('jv_phone:client:notify', src, 'Je melding is verstuurd naar de service.')

    print(('[jv_phone] %s requested %s: %s at %.2f %.2f %.2f'):format(playerName, serviceId, message, coords.x, coords.y, coords.z))
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
