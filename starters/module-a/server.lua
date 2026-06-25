local QBCore = exports['qb-core']:GetCoreObject()

local function send(src, title, msg)
    TriggerClientEvent('chat:addMessage', src, { args = { title, msg } })
end

RegisterCommand('jvreport', function(source, args)
    local text = table.concat(args, ' ')
    if text == '' then send(source, 'Report', 'Gebruik: /jvreport tekst') return end
    print('[REPORT] ' .. GetPlayerName(source) .. ': ' .. text)
    send(source, 'Report', 'Je melding is verzonden naar staff.')
end, false)

RegisterCommand('jvplayers', function(source)
    local count = #GetPlayers()
    send(source, 'Server', 'Online spelers: ' .. count)
end, false)

RegisterCommand('jvbill', function(source, args)
    local target = tonumber(args[1])
    local amount = tonumber(args[2])
    if not target or not amount then send(source, 'Billing', 'Gebruik: /jvbill id bedrag') return end
    local Player = QBCore.Functions.GetPlayer(target)
    if not Player then send(source, 'Billing', 'Speler niet gevonden.') return end
    if Player.Functions.RemoveMoney('bank', amount, 'jv-bill') then
        send(source, 'Billing', 'Factuur betaald door speler.')
        send(target, 'Billing', 'Je betaalde een factuur van $' .. amount)
    else
        send(source, 'Billing', 'Speler heeft niet genoeg bankgeld.')
    end
end, false)
