local balances = {}
local lastScrap = {}

local function notify(src, message)
    TriggerClientEvent('jv_cardealer:client:notify', src, message)
end

local function ensurePlayer(src)
    if not balances[src] then
        balances[src] = {
            cash = 50000,
            bank = 150000,
            black = 25000
        }
    end
    return balances[src]
end

local function findVehicle(model)
    for _, vehicle in ipairs(Config.Vehicles) do
        if vehicle.model == model then
            return vehicle
        end
    end
    return nil
end

local function removeMoney(src, account, amount)
    local data = ensurePlayer(src)

    if Config.Framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then return false end
        if account == 'cash' then account = 'money' end
        if account == 'black' then account = 'black_money' end
        local current = account == 'money' and xPlayer.getMoney() or xPlayer.getAccount(account).money
        if current < amount then return false end
        if account == 'money' then xPlayer.removeMoney(amount) else xPlayer.removeAccountMoney(account, amount) end
        return true
    end

    if Config.Framework == 'qb' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return false end
        local qbAccount = account == 'cash' and 'cash' or account == 'bank' and 'bank' or 'crypto'
        if Player.Functions.GetMoney(qbAccount) < amount then return false end
        Player.Functions.RemoveMoney(qbAccount, amount, 'jv-cardealer-buy')
        return true
    end

    if not data[account] or data[account] < amount then
        return false
    end
    data[account] = data[account] - amount
    return true
end

local function addMoney(src, account, amount)
    local data = ensurePlayer(src)

    if Config.Framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then return end
        if account == 'cash' then xPlayer.addMoney(amount) return end
        if account == 'black' then xPlayer.addAccountMoney('black_money', amount) return end
        xPlayer.addAccountMoney('bank', amount)
        return
    end

    if Config.Framework == 'qb' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        local qbAccount = account == 'cash' and 'cash' or account == 'bank' and 'bank' or 'crypto'
        Player.Functions.AddMoney(qbAccount, amount, 'jv-cardealer-scrap')
        return
    end

    data[account] = (data[account] or 0) + amount
end

local function makePlate()
    return ('JV%s'):format(math.random(1000, 9999))
end

RegisterNetEvent('jv_cardealer:server:buyVehicle', function(model, payment)
    local src = source
    local vehicle = findVehicle(model)

    if not vehicle then
        notify(src, 'Dit voertuig bestaat niet in de webshop.')
        return
    end

    if payment ~= 'cash' and payment ~= 'bank' and payment ~= 'black' then
        notify(src, 'Ongeldige betaalmethode.')
        return
    end

    if not removeMoney(src, payment, vehicle.price) then
        notify(src, ('Je hebt niet genoeg %s geld.'):format(payment))
        return
    end

    local plate = makePlate()
    TriggerClientEvent('jv_cardealer:client:spawnBoughtVehicle', src, vehicle.model, plate)
    print(('[jv_cardealer] %s bought %s for %s using %s'):format(GetPlayerName(src), vehicle.model, vehicle.price, payment))
end)

RegisterNetEvent('jv_cardealer:server:scrapVehicle', function(class, model, plate, body, engine)
    local src = source
    local now = os.time()

    if lastScrap[src] and now - lastScrap[src] < Config.ChopShop.cooldownSeconds then
        notify(src, 'Wacht even voordat je weer een voertuig inlevert.')
        return
    end

    lastScrap[src] = now

    local className = Config.ClassNames[class] or 'default'
    local range = Config.ChopPrices[className] or Config.ChopPrices.default
    local payout = math.random(range.min, range.max)
    local damageModifier = math.max(0.35, math.min(1.0, ((body or 1000.0) + (engine or 1000.0)) / 2000.0))
    payout = math.floor(payout * damageModifier)

    addMoney(src, Config.ChopShop.payoutAccount, payout)
    notify(src, ('Voertuig ingeleverd. Je kreeg %s%s.'):format(Config.CurrencySymbol, payout))
    print(('[jv_cardealer] %s scrapped vehicle %s plate %s payout %s'):format(GetPlayerName(src), tostring(model), tostring(plate), payout))
end)

RegisterCommand('geld', function(source)
    local data = ensurePlayer(source)
    notify(source, ('Contant: %s%s | Bank: %s%s | Zwart: %s%s'):format(Config.CurrencySymbol, data.cash, Config.CurrencySymbol, data.bank, Config.CurrencySymbol, data.black))
end, false)
