local function getIdentifier(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.identifier or nil
end

lib.callback.register('delfzijl_garage:getVehicles', function(src)
    local identifier = getIdentifier(src)
    if not identifier then return {} end

    return MySQL.query.await('SELECT plate, vehicle, stored FROM owned_vehicles WHERE owner = ?', { identifier }) or {}
end)

lib.callback.register('delfzijl_garage:storeVehicle', function(src, props)
    local identifier = getIdentifier(src)
    if not identifier or not props or not props.plate then return false end

    local vehicle = MySQL.single.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate = ?', { identifier, props.plate })
    if not vehicle then return false end

    MySQL.update.await('UPDATE owned_vehicles SET vehicle = ?, stored = 1 WHERE owner = ? AND plate = ?', {
        json.encode(props), identifier, props.plate
    })

    return true
end)

RegisterNetEvent('delfzijl_garage:takeOut', function(plate)
    local src = source
    local identifier = getIdentifier(src)
    if not identifier or not plate then return end

    local row = MySQL.single.await('SELECT vehicle, stored FROM owned_vehicles WHERE owner = ? AND plate = ?', { identifier, plate })
    if not row or row.stored ~= 1 then return end

    MySQL.update.await('UPDATE owned_vehicles SET stored = 0 WHERE owner = ? AND plate = ?', { identifier, plate })
    TriggerClientEvent('delfzijl_garage:spawnVehicle', src, json.decode(row.vehicle), plate)
end)

print('Delfzijl garage module gestart')
