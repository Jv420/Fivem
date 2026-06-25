RegisterCommand('jvhelp', function(source)
    local lines = {
        'Jv420 helper commands:',
        '/jvhelp - toon deze hulp',
        '/jvplayers - toon aantal spelers',
        '/jvannounce <tekst> - server aankondiging'
    }

    if source == 0 then
        for _, line in ipairs(lines) do print(line) end
    else
        for _, line in ipairs(lines) do
            TriggerClientEvent('chat:addMessage', source, { args = { 'Jv420', line } })
        end
    end
end, true)

RegisterCommand('jvplayers', function(source)
    local count = #GetPlayers()
    local msg = 'Online spelers: ' .. count
    if source == 0 then
        print(msg)
    else
        TriggerClientEvent('chat:addMessage', source, { args = { 'Server', msg } })
    end
end, true)

RegisterCommand('jvannounce', function(source, args)
    local msg = table.concat(args, ' ')
    if msg == '' then return end

    TriggerClientEvent('chat:addMessage', -1, {
        color = { 100, 210, 255 },
        multiline = true,
        args = { 'Aankondiging', msg }
    })
end, true)
