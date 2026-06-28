fx_version 'cerulean'
game 'gta5'

name 'jv_phone'
author 'Jv420 / ChatGPT'
description 'Standalone telefoon systeem met services voor Delfzijl RP'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
