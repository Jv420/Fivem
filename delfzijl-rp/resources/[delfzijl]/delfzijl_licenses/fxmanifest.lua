fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Delfzijl RP'
description 'delfzijl_licenses - licenties voor Delfzijl RP'
version '1.0.1'

dependencies {
    'ox_lib',
    'oxmysql',
    'ox_target',
    'es_extended',
    'esx_license'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'shared/config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
