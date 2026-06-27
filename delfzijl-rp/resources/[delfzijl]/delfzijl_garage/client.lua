local garageZone = vec3(215.8, -810.1, 30.7)
local spawnPoint = vec4(229.7, -800.1, 30.6, 160.0)

local function notify(msg, type)
    lib.notify({ title = 'Delfzijl Garage', description = msg, type = type or 'inform' })
end

local function getVehicleProps(vehicle)
    return lib.getVehicleProperties(vehicle)
end

local function openGarage()
    local vehicles = lib.callback.await('delfzijl_garage:getVehicles', false)
    local options = {}

    if not vehicles or #vehicles == 0 then
        options[#options + 1] = { title = 'Geen voertuigen gevonden', disabled = true }
    else
        for _, v in pairs(vehicles) do
            options[#options + 1] = {
                title = v.plate .. ' - ' .. (v.vehicle_label or 'Voertuig'),
                description = v.stored == 1 and 'Klik om uit garage te halen' or 'Voertuig staat buiten',
                disabled = v.stored ~= 1,
                onSelect = function()
                    TriggerServerEvent('delfzijl_garage:takeOut', v.plate)
                end
            }
        end
    end

    lib.registerContext({ id = 'delfzijl_garage_menu', title = 'Garage Delfzijl', options = options })
    lib.showContext('delfzijl_garage_menu')
end

RegisterNetEvent('delfzijl_garage:spawnVehicle', function(vehicleData, plate)
    local model = vehicleData.model
    lib.requestModel(model)
    local veh = CreateVehicle(model, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.w, true, false)
    lib.setVehicleProperties(veh, vehicleData)
    SetVehicleNumberPlateText(veh, plate)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    notify('Voertuig uit garage gehaald.', 'success')
end)

RegisterCommand('garage', openGarage, false)

RegisterCommand('storecar', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 then return notify('Je zit niet in een voertuig.', 'error') end

    local props = getVehicleProps(vehicle)
    local ok = lib.callback.await('delfzijl_garage:storeVehicle', false, props)
    if ok then
        DeleteVehicle(vehicle)
        notify('Voertuig opgeslagen.', 'success')
    else
        notify('Dit voertuig is niet van jou of bestaat niet in de database.', 'error')
    end
end, false)

CreateThread(function()
    exports.ox_target:addSphereZone({
        coords = garageZone,
        radius = 2.0,
        options = {
            { label = 'Garage openen', icon = 'fa-solid fa-warehouse', onSelect = openGarage },
            { label = 'Voertuig opslaan', icon = 'fa-solid fa-square-parking', onSelect = function() ExecuteCommand('storecar') end }
        }
    })
end)
