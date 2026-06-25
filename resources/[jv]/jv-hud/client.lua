local showHud = true

RegisterCommand('hud', function()
    showHud = not showHud
    SendNUIMessage({ action = 'toggle', show = showHud })
end, false)

CreateThread(function()
    while true do
        Wait(1000)
        if showHud then
            local ped = PlayerPedId()
            local health = math.max(0, GetEntityHealth(ped) - 100)
            local armor = GetPedArmour(ped)
            local playerId = GetPlayerServerId(PlayerId())
            local streetHash = GetStreetNameAtCoord(table.unpack(GetEntityCoords(ped)))
            local street = GetStreetNameFromHashKey(streetHash)

            SendNUIMessage({
                action = 'update',
                health = health,
                armor = armor,
                id = playerId,
                street = street
            })
        end
    end
end)
