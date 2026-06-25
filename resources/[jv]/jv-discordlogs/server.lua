local function sendDiscordLog(title, message)
    if not Config.Webhook or Config.Webhook == '' then
        return
    end

    local embed = {
        {
            title = title,
            description = message,
            color = Config.Color,
            footer = {
                text = Config.ServerName
            },
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
        }
    }

    PerformHttpRequest(Config.Webhook, function() end, 'POST', json.encode({
        username = Config.ServerName,
        embeds = embed
    }), {
        ['Content-Type'] = 'application/json'
    })
end

AddEventHandler('playerJoining', function()
    local playerName = GetPlayerName(source) or 'Onbekend'
    sendDiscordLog('Speler verbindt', playerName .. ' is aan het verbinden.')
end)

AddEventHandler('playerDropped', function(reason)
    local playerName = GetPlayerName(source) or 'Onbekend'
    sendDiscordLog('Speler vertrokken', playerName .. ' heeft de server verlaten. Reden: ' .. (reason or 'onbekend'))
end)

RegisterCommand('jvlogtest', function(source)
    if source ~= 0 then
        return
    end
    sendDiscordLog('Test log', 'Discord logging werkt correct.')
    print('[jv-discordlogs] Test log verzonden.')
end, true)
