local function registerShop(name, label, inventory, locations)
    exports.ox_inventory:RegisterShop(name, {
        name = label,
        inventory = inventory,
        locations = locations
    })
end

AddEventHandler('onServerResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    registerShop('supermarkt_delfzijl', 'Supermarkt Delfzijl', {
        { name = 'bread', price = 5 },
        { name = 'water', price = 5 },
        { name = 'phone', price = 250 },
        { name = 'radio', price = 150 }
    }, { vec3(25.7, -1347.3, 29.5) })

    registerShop('supermarkt_sandy', 'Supermarkt Sandy Shores', {
        { name = 'bread', price = 5 },
        { name = 'water', price = 5 },
        { name = 'phone', price = 250 },
        { name = 'radio', price = 150 }
    }, { vec3(1961.4, 3740.6, 32.3) })

    registerShop('wapenwinkel_delfzijl', 'Wapenwinkel', {
        { name = 'WEAPON_PISTOL', price = 35000, license = 'weapon' },
        { name = 'ammo-9', price = 75, license = 'weapon' }
    }, { vec3(22.0, -1107.2, 29.8) })

    print('Delfzijl shops geregistreerd')
end)

lib.callback.register('delfzijl_shops:hasLicense', function(src, licenseType)
    local hasLicense = false
    TriggerEvent('esx_license:checkLicense', src, licenseType, function(result)
        hasLicense = result
    end)
    Wait(100)
    return hasLicense
end)
