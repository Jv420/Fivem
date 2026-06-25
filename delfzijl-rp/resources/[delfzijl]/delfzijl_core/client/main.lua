CreateThread(function()
    Wait(1500)
    print('[Delfzijl RP] Core client geladen')
end)

RegisterCommand('delfzijl', function()
    lib.notify({ title = 'Delfzijl RP', description = 'Welkom op Delfzijl RP!', type = 'success' })
end)
