local phoneOpen = false
local lastCoords = nil

local function serviceById(id)
    for _, service in ipairs(Config.Services) do
        if service.id == id then
            return service
        end
    end
    return nil
end

local function setPhoneVisible(state)
    phoneOpen = state
    SetNuiFocus(state, state)
    SendNUIMessage({
        action = state and 'open' or 'close',
        serverName = Config.ServerName,
        cityName = Config.CityName,
        services = Config.Services,
        contacts = Config.DefaultContacts
    })
end

RegisterCommand(Config.PhoneCommand, function()
    setPhoneVisible(not phoneOpen)
end, false)

RegisterKeyMapping(Config.PhoneCommand, 'Open telefoon', 'keyboard', Config.OpenKey)

RegisterNUICallback('closePhone', function(_, cb)
    setPhoneVisible(false)
    cb('ok')
end)

RegisterNUICallback('requestService', function(data, cb)
    local service = serviceById(data.service)
    local message = tostring(data.message or '')

    if not service then
        cb({ success = false, error = 'Service bestaat niet.' })
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    lastCoords = coords

    TriggerServerEvent('jv_phone:server:requestService', service.id, message, {
        x = coords.x,
        y = coords.y,
        z = coords.z
    })

    cb({ success = true })
end)

RegisterNetEvent('jv_phone:client:serviceAlert', function(serviceId, playerName, message, coords)
    local service = serviceById(serviceId)
    if not service then return end

    local chatColor = service.alertColor or {255, 255, 255}
    TriggerEvent('chat:addMessage', {
        color = chatColor,
        multiline = true,
        args = {
            service.alertTitle,
            ('Nieuwe melding van %s: %s | Locatie: %.1f, %.1f'):format(playerName, message, coords.x, coords.y)
        }
    })

    PlaySoundFrontend(-1, 'Menu_Accept', 'Phone_SoundSet_Default', true)

    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 280)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(service.alertTitle)
    EndTextCommandSetBlipName(blip)

    CreateThread(function()
        Wait(120000)
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end)

RegisterNetEvent('jv_phone:client:notify', function(message)
    TriggerEvent('chat:addMessage', {
        color = {124, 255, 203},
        args = {'Telefoon', message}
    })
end)

CreateThread(function()
    Wait(1500)
    SendNUIMessage({
        action = 'setup',
        serverName = Config.ServerName,
        cityName = Config.CityName,
        services = Config.Services,
        contacts = Config.DefaultContacts
    })
end)
