local QBCore = exports['qb-core']:GetCoreObject()

local function notify(src, msg)
    TriggerClientEvent('chat:addMessage', src, { args = { 'WeaponShop', msg } })
end

RegisterCommand('weaponshop', function(source)
    notify(source, 'Items: /buyweapon flashlight | pistolammo. Pistol/taser via staff/licentie later activeren.')
end, false)

RegisterCommand('buyweapon', function(source, args)
    local key = args[1]
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    local selected = nil
    if key == 'flashlight' then selected = Config.Items[1] end
    if key == 'pistolammo' then selected = Config.Items[4] end

    if not selected then
        notify(source, 'Gebruik: /buyweapon flashlight | pistolammo')
        return
    end

    if Player.Functions.RemoveMoney('cash', selected.price, 'weaponshop-buy') then
        Player.Functions.AddItem(selected.item, 1)
        notify(source, 'Gekocht: ' .. selected.label .. ' voor $' .. selected.price)
    else
        notify(source, 'Niet genoeg cash.')
    end
end, false)
