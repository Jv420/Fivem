local VEHICLE_MODEL = 'bmw520f11'

local function notify(message)
    TriggerEvent('chat:addMessage', {
        args = { 'DelfzijlCity Cars', message }
    })
end

RegisterCommand('bmw520', function()
    local model = joaat(VEHICLE_MODEL)

    RequestModel(model)
    local timeout = GetGameTimer() + 10000

    while not HasModelLoaded(model) do
        Wait(50)
        if GetGameTimer() > timeout then
            notify('Model niet geladen. Controleer of de stream-bestanden bestaan en dezelfde naam hebben: bmw520f11.')
            return
        end
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local vehicle = CreateVehicle(model, coords.x + 2.5, coords.y, coords.z, heading, true, false)

    SetPedIntoVehicle(ped, vehicle, -1)
    SetVehicleNumberPlateText(vehicle, 'DC-520-D')
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleFuelLevel(vehicle, 100.0)
    SetVehicleEngineOn(vehicle, true, true, false)

    SetModelAsNoLongerNeeded(model)
    notify('BMW 520D F11 gespawned.')
end, false)

RegisterCommand('bmw520info', function()
    notify('Spawnnaam: bmw520f11 | Command: /bmw520 | Zorg dat .yft/.ytd in stream staan.')
end, false)
