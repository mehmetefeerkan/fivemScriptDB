fx_version 'adamant'
game 'gta5'
version '1.0'
description 'Custom-made car wash script. Inspired by esx_carwash, with many improvements though.'
author 'Puntherline'

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'server.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',
    'client.lua'
}

dependency 'es_extended'