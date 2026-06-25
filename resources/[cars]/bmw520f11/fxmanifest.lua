fx_version 'cerulean'
game 'gta5'

author 'DelfzijlCity / Jv420'
description 'BMW 520D F11 addon vehicle resource scaffold'
version '1.0.0'

files {
    'vehicles.meta',
    'carvariations.meta',
    'handling.meta'
}

data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'HANDLING_FILE' 'handling.meta'

client_script 'client.lua'
