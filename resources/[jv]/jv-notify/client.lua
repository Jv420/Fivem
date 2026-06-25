RegisterCommand('welkom', function()
    TriggerEvent('chat:addMessage', {
        color = { 100, 210, 255 },
        multiline = true,
        args = { 'Jv420 RP', 'Welkom op de server! Gebruik Discord voor regels, support en updates.' }
    })
end, false)

RegisterCommand('regels', function()
    TriggerEvent('chat:addMessage', {
        color = { 255, 220, 100 },
        multiline = true,
        args = { 'Regels', 'Geen RDM/VDM, geen cheats, geen combat logging en respecteer roleplay.' }
    })
end, false)
