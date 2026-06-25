local zones = {
    { coords = Config.Routes.Weed.gather, label = 'Wiet plukken', event = 'delfzijl:illegal:weedGather' },
    { coords = Config.Routes.Weed.process, label = 'Wiet verwerken', event = 'delfzijl:illegal:weedProcess' },
    { coords = Config.Routes.Weed.sell, label = 'Wiet verkopen', event = 'delfzijl:illegal:weedSell' },
    { coords = Config.Routes.Coke.gather, label = 'Coca bladeren verzamelen', event = 'delfzijl:illegal:cokeGather' },
    { coords = Config.Routes.Coke.process, label = 'Coke verwerken', event = 'delfzijl:illegal:cokeProcess' },
    { coords = Config.Routes.Coke.sell, label = 'Coke verkopen', event = 'delfzijl:illegal:cokeSell' },
    { coords = Config.Routes.Wash.location, label = 'Geld witwassen', event = 'delfzijl:illegal:wash' }
}

CreateThread(function()
    for _, z in pairs(zones) do
        exports.ox_target:addSphereZone({
            coords = z.coords,
            radius = 1.5,
            options = {{
                label = z.label,
                icon = 'fa-solid fa-mask',
                onSelect = function()
                    TriggerServerEvent(z.event)
                end
            }}
        })
    end
end)
