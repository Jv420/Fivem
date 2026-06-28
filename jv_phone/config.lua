Config = {}

Config.PhoneCommand = 'phone'
Config.OpenKey = 'F1'
Config.ServerName = 'Delfzijl RP'
Config.CityName = 'Delfzijl'

Config.Services = {
    {
        id = 'taxi',
        label = 'Taxi',
        icon = '🚕',
        color = '#ffd166',
        description = 'Vraag een taxi aan naar jouw locatie.',
        alertTitle = 'Taxi melding',
        alertColor = {255, 209, 102}
    },
    {
        id = 'police',
        label = 'Politie',
        icon = '🚓',
        color = '#5aa9ff',
        description = 'Meld een noodsituatie bij de politie.',
        alertTitle = 'Politie melding',
        alertColor = {90, 169, 255}
    },
    {
        id = 'ambulance',
        label = 'Ambulance',
        icon = '🚑',
        color = '#ff5c7a',
        description = 'Roep medische hulp naar jouw locatie.',
        alertTitle = 'Ambulance melding',
        alertColor = {255, 92, 122}
    },
    {
        id = 'mechanic',
        label = 'Mechanic',
        icon = '🔧',
        color = '#7cffcb',
        description = 'Vraag hulp bij pech of reparatie.',
        alertTitle = 'Mechanic melding',
        alertColor = {124, 255, 203}
    },
    {
        id = 'staff',
        label = 'Staff',
        icon = '⭐',
        color = '#b56cff',
        description = 'Vraag hulp van een stafflid.',
        alertTitle = 'Staff melding',
        alertColor = {181, 108, 255}
    }
}

Config.DefaultContacts = {
    { name = 'Taxi Centrale', number = '101', service = 'taxi' },
    { name = 'Politie Delfzijl', number = '112', service = 'police' },
    { name = 'Ambulance', number = '113', service = 'ambulance' },
    { name = 'Mechanic Garage', number = '114', service = 'mechanic' },
    { name = 'Staff Team', number = '115', service = 'staff' }
}
