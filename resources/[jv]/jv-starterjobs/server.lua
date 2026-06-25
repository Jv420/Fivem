local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('jv-starterjobs:pay', function(jobName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local job = Config.Jobs[jobName]
    if not job then return end

    local amount = math.random(job.reward.min, job.reward.max)
    Player.Functions.AddMoney('cash', amount, 'jv-starter-job')
    TriggerClientEvent('chat:addMessage', src, {
        args = { 'Jobs', 'Werk voltooid! Je kreeg $' .. amount .. ' cash.' }
    })
end)
