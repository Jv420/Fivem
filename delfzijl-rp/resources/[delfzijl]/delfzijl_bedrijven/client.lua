local bossLocations = {
    cardealer = { label = 'Autodealer Baasmenu', coords = vec3(-31.2, -1114.4, 26.4) },
    mechanic = { label = 'ANWB Baasmenu', coords = vec3(-347.3, -133.4, 39.0) },
    taxi = { label = 'Taxi Baasmenu', coords = vec3(907.1, -151.7, 74.2) }
}

local function openBossMenu(jobName)
    local isBoss = lib.callback.await('delfzijl_bedrijven:isBoss', false, jobName)
    if not isBoss then
        return lib.notify({ title = 'Bedrijven', description = 'Je bent geen baas van dit bedrijf.', type = 'error' })
    end

    TriggerEvent('esx_society:openBossMenu', jobName, function() end, { wash = false })
end

CreateThread(function()
    for jobName, data in pairs(bossLocations) do
        exports.ox_target:addSphereZone({
            coords = data.coords,
            radius = 1.5,
            options = {
                {
                    label = data.label,
                    icon = 'fa-solid fa-building',
                    onSelect = function()
                        openBossMenu(jobName)
                    end
                }
            }
        })
    end
end)

RegisterCommand('bedrijf', function()
    lib.notify({ title = 'Delfzijl Bedrijven', description = 'Gebruik het oogje bij je bedrijfslocatie.', type = 'inform' })
end, false)
