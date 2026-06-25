CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = vec3(-544.8, -204.5, 38.2),
        size = vec3(2, 2, 2),
        rotation = 30,
        options = {
            { label = 'Gemeente loket openen', icon = 'fa-solid fa-id-card', event = 'delfzijl:licenses:open' }
        }
    })
end)
