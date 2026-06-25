local activeJob = nil
local currentSpot = nil

local function msg(text)
    TriggerEvent('chat:addMessage', { args = { 'Jobs', text } })
end

RegisterCommand('jobs', function()
    msg('Beschikbare jobs: /startjob garbage, /startjob taxi, /startjob delivery')
end, false)

RegisterCommand('startjob', function(_, args)
    local name = args[1]
    if not name or not Config.Jobs[name] then
        msg('Gebruik: /startjob garbage | taxi | delivery')
        return
    end

    activeJob = name
    local job = Config.Jobs[name]
    currentSpot = job.spots[math.random(#job.spots)]
    SetNewWaypoint(currentSpot.x, currentSpot.y)
    msg('Je bent gestart als ' .. job.label .. '. Rij naar de waypoint en gebruik /finishjob.')
end, false)

RegisterCommand('finishjob', function()
    if not activeJob or not currentSpot then
        msg('Je hebt geen actieve job.')
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local dist = #(coords - currentSpot)

    if dist > 35.0 then
        msg('Je bent nog niet bij je job locatie.')
        return
    end

    TriggerServerEvent('jv-starterjobs:pay', activeJob)
    activeJob = nil
    currentSpot = nil
end, false)
