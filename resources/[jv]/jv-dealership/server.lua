local QBCore = exports['qb-core']:GetCoreObject()

local function msg(src, text)
    TriggerClientEvent('chat:addMessage', src, { args = { Config.ShopName, text } })
end

RegisterCommand('dealer', function(source)
    msg(source, 'Gebruik /dealerlist om voertuigen te bekijken en /buycar model om te kopen.')
end, false)

RegisterCommand('dealerlist', function(source)
    for _, v in ipairs(Config.Vehicles) do
        msg(source, v.model .. ' - ' .. v.label .. ' - $' .. v.price .. ' [' .. v.category .. ']')
    end
end, false)

RegisterCommand('buycar', function(source, args)
    local model = args[1]
    if not model then
        msg(source, 'Gebruik: /buycar model')
        return
    end

    local selected = nil
    for _, v in ipairs(Config.Vehicles) do
        if v.model == model then selected = v break end
    end

    if not selected then
        msg(source, 'Dit voertuig staat niet in de catalogus.')
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    if Player.Functions.RemoveMoney('bank', selected.price, 'dealer-buy') then
        msg(source, 'Je hebt ' .. selected.label .. ' gekocht voor $' .. selected.price .. '. Voeg later opslag toe via qb-vehicleshop/player_vehicles.')
    else
        msg(source, 'Niet genoeg geld op je bank.')
    end
end, false)
