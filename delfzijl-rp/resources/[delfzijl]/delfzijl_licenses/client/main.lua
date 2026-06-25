RegisterNetEvent('delfzijl:licenses:open', function()
    lib.registerContext({
        id = 'delfzijl_licenses',
        title = 'Gemeente Delfzijl - Licenties',
        options = {
            { title = 'Identiteitskaart aanvragen', event = 'delfzijl:licenses:buy', args = 'id_card' },
            { title = 'Rijbewijs B aanvragen', event = 'delfzijl:licenses:buy', args = 'drive' },
            { title = 'Wapenvergunning aanvragen', event = 'delfzijl:licenses:buy', args = 'weapon' }
        }
    })
    lib.showContext('delfzijl_licenses')
end)

RegisterNetEvent('delfzijl:licenses:buy', function(type)
    TriggerServerEvent('delfzijl:licenses:buy', type)
end)
