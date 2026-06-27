local shops = {
    {
        name = 'supermarkt_delfzijl',
        label = 'Supermarkt Delfzijl',
        coords = vec3(25.7, -1347.3, 29.5)
    },
    {
        name = 'supermarkt_sandy',
        label = 'Supermarkt Sandy Shores',
        coords = vec3(1961.4, 3740.6, 32.3)
    },
    {
        name = 'wapenwinkel_delfzijl',
        label = 'Wapenwinkel',
        coords = vec3(22.0, -1107.2, 29.8),
        license = 'weapon'
    }
}

local function openShop(shop)
    if shop.license then
        local hasLicense = lib.callback.await('delfzijl_shops:hasLicense', false, shop.license)
        if not hasLicense then
            return lib.notify({ title = shop.label, description = 'Je hebt de juiste licentie niet.', type = 'error' })
        end
    end

    exports.ox_inventory:openInventory('shop', { type = shop.name })
end

CreateThread(function()
    for _, shop in pairs(shops) do
        exports.ox_target:addSphereZone({
            coords = shop.coords,
            radius = 1.5,
            options = {
                {
                    label = shop.label .. ' openen',
                    icon = 'fa-solid fa-store',
                    onSelect = function()
                        openShop(shop)
                    end
                }
            }
        })
    end
end)

RegisterCommand('winkel', function()
    lib.notify({ title = 'Delfzijl Shops', description = 'Gebruik het oogje bij een winkel.', type = 'inform' })
end, false)
