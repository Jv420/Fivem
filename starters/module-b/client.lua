local locked = false

local function chat(title, msg)
    TriggerEvent('chat:addMessage', { args = { title, msg } })
end

RegisterCommand('jvlock', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then
        veh = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 71)
    end
    if veh == 0 then chat('Vehicle', 'Geen voertuig dichtbij.') return end

    locked = not locked
    SetVehicleDoorsLocked(veh, locked and 2 or 1)
    chat('Vehicle', locked and 'Voertuig gesloten.' or 'Voertuig geopend.')
end, false)

RegisterCommand('jvfuel', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then chat('Fuel', 'Je zit niet in een voertuig.') return end
    SetVehicleFuelLevel(veh, 100.0)
    chat('Fuel', 'Tank gevuld voor testdoeleinden.')
end, false)

RegisterCommand('jvplate', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then chat('Plate', 'Je zit niet in een voertuig.') return end
    local plate = GetVehicleNumberPlateText(veh)
    chat('Plate', 'Kenteken: ' .. plate)
end, false)
