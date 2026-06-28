local uiOpen = false

local function notify(message)
    TriggerEvent('chat:addMessage', {
        color = {92, 225, 255},
        args = {'Auto Systeem', message}
    })
end

local function drawText3D(coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    if not onScreen then return end
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(x, y)
end

local function openDealer()
    uiOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        dealer = Config.Dealer,
        vehicles = Config.Vehicles,
        payments = Config.PaymentTypes,
        currency = Config.CurrencySymbol
    })
end

local function closeDealer()
    uiOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end

local function createBlips()
    if Config.Dealer.blip then
        local blip = AddBlipForCoord(Config.Dealer.coords.x, Config.Dealer.coords.y, Config.Dealer.coords.z)
        SetBlipSprite(blip, Config.Dealer.blipSprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, Config.Dealer.blipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Dealer.label)
        EndTextCommandSetBlipName(blip)
    end

    if Config.ChopShop.blip then
        local blip = AddBlipForCoord(Config.ChopShop.coords.x, Config.ChopShop.coords.y, Config.ChopShop.coords.z)
        SetBlipSprite(blip, Config.ChopShop.blipSprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, Config.ChopShop.blipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.ChopShop.label)
        EndTextCommandSetBlipName(blip)
    end
end

RegisterNUICallback('close', function(_, cb)
    closeDealer()
    cb('ok')
end)

RegisterNUICallback('buyVehicle', function(data, cb)
    TriggerServerEvent('jv_cardealer:server:buyVehicle', data.model, data.payment)
    cb('ok')
end)

RegisterNetEvent('jv_cardealer:client:spawnBoughtVehicle', function(model, plate)
    local hash = joaat(model)
    RequestModel(hash)

    local timeout = GetGameTimer() + 8000
    while not HasModelLoaded(hash) and GetGameTimer() < timeout do
        Wait(0)
    end

    if not HasModelLoaded(hash) then
        notify('Voertuig model kon niet geladen worden.')
        return
    end

    local spawn = Config.Dealer.spawn
    local vehicle = CreateVehicle(hash, spawn.x, spawn.y, spawn.z, spawn.w, true, false)
    SetVehicleNumberPlateText(vehicle, plate)
    SetVehicleOnGroundProperly(vehicle)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetModelAsNoLongerNeeded(hash)

    notify(('Je voertuig is geleverd met kenteken %s.'):format(plate))
    closeDealer()
end)

RegisterNetEvent('jv_cardealer:client:notify', notify)

RegisterCommand('cardealer', function()
    openDealer()
end, false)

RegisterCommand('scrapcar', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        notify('Je zit niet in een voertuig.')
        return
    end

    if Config.ChopShop.requireDriver and GetPedInVehicleSeat(vehicle, -1) ~= ped then
        notify('Je moet de bestuurder zijn.')
        return
    end

    local coords = GetEntityCoords(ped)
    local dist = #(coords - Config.ChopShop.coords)
    if dist > 10.0 then
        notify('Je bent niet bij de sloopwerf.')
        return
    end

    local class = GetVehicleClass(vehicle)
    local model = GetEntityModel(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local body = GetVehicleBodyHealth(vehicle)
    local engine = GetVehicleEngineHealth(vehicle)

    TaskLeaveVehicle(ped, vehicle, 0)
    Wait(1500)
    TriggerServerEvent('jv_cardealer:server:scrapVehicle', class, model, plate, body, engine)
    DeleteEntity(vehicle)
end, false)

CreateThread(function()
    createBlips()

    while true do
        local sleep = 800
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dealerDist = #(coords - Config.Dealer.coords)
        local scrapDist = #(coords - Config.ChopShop.coords)

        if dealerDist < 25.0 and Config.Dealer.marker then
            sleep = 0
            DrawMarker(36, Config.Dealer.coords.x, Config.Dealer.coords.y, Config.Dealer.coords.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 92, 225, 255, 160, false, true, 2, false, nil, nil, false)
        end

        if scrapDist < 25.0 and Config.ChopShop.marker then
            sleep = 0
            DrawMarker(1, Config.ChopShop.coords.x, Config.ChopShop.coords.y, Config.ChopShop.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.2, 4.2, 0.6, 255, 70, 90, 150, false, true, 2, false, nil, nil, false)
        end

        if dealerDist < 2.5 then
            sleep = 0
            drawText3D(Config.Dealer.coords + vector3(0.0, 0.0, 1.0), '[E] Auto webshop openen')
            if IsControlJustReleased(0, Config.OpenKey) then
                openDealer()
            end
        end

        if scrapDist < 4.0 then
            sleep = 0
            drawText3D(Config.ChopShop.coords + vector3(0.0, 0.0, 1.0), '[E] Voertuig inleveren bij sloopwerf')
            if IsControlJustReleased(0, Config.OpenKey) then
                ExecuteCommand('scrapcar')
            end
        end

        Wait(sleep)
    end
end)
