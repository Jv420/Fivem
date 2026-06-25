local prices = { id_card = 250, drive = 1500, weapon = 15000 }

RegisterNetEvent('delfzijl:licenses:buy', function(licenseType)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or not prices[licenseType] then return end

    if xPlayer.getMoney() < prices[licenseType] then
        TriggerClientEvent('ox_lib:notify', src, { title='Gemeente', description='Je hebt niet genoeg contant geld.', type='error' })
        return
    end

    xPlayer.removeMoney(prices[licenseType])
    TriggerEvent('esx_license:addLicense', src, licenseType, function()
        TriggerClientEvent('ox_lib:notify', src, { title='Gemeente', description='Licentie succesvol toegevoegd.', type='success' })
    end)
end)
