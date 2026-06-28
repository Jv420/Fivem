Config = {}

Config.Framework = 'standalone' -- standalone, esx, qb
Config.OpenKey = 38 -- E
Config.CurrencySymbol = '€'

Config.Dealer = {
    label = 'Delfzijl Auto Webshop',
    coords = vector3(-56.42, -1096.88, 26.42),
    marker = true,
    blip = true,
    blipSprite = 326,
    blipColor = 3,
    spawn = vector4(-45.46, -1082.12, 26.70, 69.0)
}

Config.ChopShop = {
    label = 'Chopshop',
    coords = vector3(2340.44, 3052.21, 48.15),
    marker = true,
    blip = true,
    blipSprite = 380,
    blipColor = 1,
    payoutAccount = 'black', -- cash, bank, black
    policeChance = 20,
    cooldownSeconds = 45,
    requireDriver = true
}

Config.PaymentTypes = {
    { id = 'cash', label = 'Contant geld' },
    { id = 'bank', label = 'Bank geld' },
    { id = 'black', label = 'Zwart geld' }
}

Config.Vehicles = {
    { model = 'blista', label = 'Blista', category = 'Starter', price = 8500 },
    { model = 'asea', label = 'Asea', category = 'Starter', price = 9500 },
    { model = 'futo', label = 'Futo', category = 'Sportief', price = 18000 },
    { model = 'sultan', label = 'Sultan', category = 'Sportief', price = 42000 },
    { model = 'buffalo', label = 'Buffalo', category = 'Sportief', price = 55000 },
    { model = 'schafter2', label = 'Schafter', category = 'Luxe', price = 78000 },
    { model = 'baller2', label = 'Baller SUV', category = 'SUV', price = 90000 },
    { model = 'dubsta', label = 'Dubsta', category = 'SUV', price = 115000 },
    { model = 'zentorno', label = 'Zentorno', category = 'Super', price = 650000 }
}

Config.ChopPrices = {
    compact = { min = 1500, max = 3500 },
    sedan = { min = 2500, max = 5500 },
    suv = { min = 4500, max = 8500 },
    coupe = { min = 4000, max = 9000 },
    muscle = { min = 5000, max = 11000 },
    sports = { min = 7500, max = 16000 },
    sportsclassics = { min = 7000, max = 15000 },
    super = { min = 12000, max = 28000 },
    motorcycle = { min = 1800, max = 6000 },
    default = { min = 2000, max = 7000 }
}

Config.ClassNames = {
    [0] = 'compact',
    [1] = 'sedan',
    [2] = 'suv',
    [3] = 'coupe',
    [4] = 'muscle',
    [5] = 'sportsclassics',
    [6] = 'sports',
    [7] = 'super',
    [8] = 'motorcycle'
}
