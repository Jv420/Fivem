local function addItem(src, item, count)
    exports.ox_inventory:AddItem(src, item, count)
end

local function removeItem(src, item, count)
    return exports.ox_inventory:RemoveItem(src, item, count)
end

RegisterNetEvent('delfzijl:illegal:weedGather', function()
    addItem(source, 'weed_leaf', math.random(1, 3))
end)

RegisterNetEvent('delfzijl:illegal:weedProcess', function()
    local src = source
    if removeItem(src, 'weed_leaf', 3) then
        addItem(src, 'weed_bag', 1)
    end
end)

RegisterNetEvent('delfzijl:illegal:weedSell', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if removeItem(src, 'weed_bag', 1) then
        xPlayer.addAccountMoney('black_money', math.random(250, 450))
    end
end)

RegisterNetEvent('delfzijl:illegal:cokeGather', function()
    addItem(source, 'coca_leaf', math.random(1, 2))
end)

RegisterNetEvent('delfzijl:illegal:cokeProcess', function()
    local src = source
    if removeItem(src, 'coca_leaf', 3) then
        addItem(src, 'coke_bag', 1)
    end
end)

RegisterNetEvent('delfzijl:illegal:cokeSell', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if removeItem(src, 'coke_bag', 1) then
        xPlayer.addAccountMoney('black_money', math.random(700, 1100))
    end
end)

RegisterNetEvent('delfzijl:illegal:wash', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local dirty = xPlayer.getAccount('black_money').money
    if dirty < 1000 then
        return TriggerClientEvent('ox_lib:notify', src, {title='Witwassen', description='Minimaal €1000 zwart geld nodig.', type='error'})
    end

    local clean = math.floor(dirty * 0.75)
    xPlayer.removeAccountMoney('black_money', dirty)
    xPlayer.addMoney(clean)
    TriggerClientEvent('ox_lib:notify', src, {title='Witwassen', description='Je hebt €' .. clean .. ' ontvangen.', type='success'})
end)
