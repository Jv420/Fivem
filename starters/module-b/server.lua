RegisterCommand('jvvehhelp', function(source)
    TriggerClientEvent('chat:addMessage', source, {
        args = { 'Vehicle', 'Commands: /jvlock, /jvfuel, /jvplate' }
    })
end, false)
