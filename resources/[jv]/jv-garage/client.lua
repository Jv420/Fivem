local garages = {
    { name = 'Legion Garage', coords = vector3(215.8, -810.1, 30.7) },
    { name = 'Sandy Garage', coords = vector3(1737.6, 3710.2, 34.1) },
    { name = 'Paleto Garage', coords = vector3(105.3, 6613.6, 32.4) }
}

RegisterCommand('garages', function()
    TriggerEvent('chat:addMessage', { args = { 'Garage', 'Beschikbaar: legion, sandy, paleto. Gebruik /setgarage legion.' } })
end, false)

RegisterCommand('setgarage', function(_, args)
    local key = args[1]
    local selected = nil

    if key == 'legion' then selected = garages[1] end
    if key == 'sandy' then selected = garages[2] end
    if key == 'paleto' then selected = garages[3] end

    if not selected then
        TriggerEvent('chat:addMessage', { args = { 'Garage', 'Gebruik: /setgarage legion | sandy | paleto' } })
        return
    end

    SetNewWaypoint(selected.coords.x, selected.coords.y)
    TriggerEvent('chat:addMessage', { args = { 'Garage', 'Waypoint gezet naar ' .. selected.name } })
end, false)
