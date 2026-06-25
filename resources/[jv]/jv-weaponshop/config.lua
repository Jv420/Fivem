Config = {}

-- Starter legal weapon shop. Houd wapens beperkt voor economy/RP balans.
Config.Items = {
    { item = 'weapon_flashlight', label = 'Zaklamp', price = 250 },
    { item = 'weapon_stungun', label = 'Taser', price = 2500, policeOnly = true },
    { item = 'weapon_pistol', label = 'Pistol', price = 12000, licenseRequired = true },
    { item = 'pistol_ammo', label = 'Pistol Ammo', price = 250, licenseRequired = true }
}
