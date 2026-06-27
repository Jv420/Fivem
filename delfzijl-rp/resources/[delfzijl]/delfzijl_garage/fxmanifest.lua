fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Delfzijl RP'
description 'Werkende ESX garage voor Delfzijl RP'
version '1.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
