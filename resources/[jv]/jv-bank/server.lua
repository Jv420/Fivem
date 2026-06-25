local QBCore = exports['qb-core']:GetCoreObject()

local function notify(src, msg)
    TriggerClientEvent('chat:addMessage', src, { args = { 'Bank', msg } })
end

RegisterCommand('bank', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    local cash = Player.PlayerData.money.cash or 0
    local bank = Player.PlayerData.money.bank or 0
    notify(source, ('Cash: $%s | Bank: $%s'):format(cash, bank))
end, false)

RegisterCommand('deposit', function(source, args)
    local amount = tonumber(args[1])
    if not amount or amount <= 0 then
        notify(source, 'Gebruik: /deposit bedrag')
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    if Player.Functions.RemoveMoney('cash', amount, 'bank-deposit') then
        Player.Functions.AddMoney('bank', amount, 'bank-deposit')
        notify(source, 'Je hebt $' .. amount .. ' gestort.')
    else
        notify(source, 'Je hebt niet genoeg cash.')
    end
end, false)

RegisterCommand('withdraw', function(source, args)
    local amount = tonumber(args[1])
    if not amount or amount <= 0 then
        notify(source, 'Gebruik: /withdraw bedrag')
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    if Player.Functions.RemoveMoney('bank', amount, 'bank-withdraw') then
        Player.Functions.AddMoney('cash', amount, 'bank-withdraw')
        notify(source, 'Je hebt $' .. amount .. ' opgenomen.')
    else
        notify(source, 'Je hebt niet genoeg geld op de bank.')
    end
end, false)
