fx_version 'cerulean'
games      { 'gta5' }
-- shared_script '@es_extended/imports.lua'
ui_page 'html/index.html'
files {
    'html/js/jquery.js',
    'html/fonts/quicksand.ttf',
    'html/img/*.png',
    'html/index.html',
}
server_scripts {
    'shared/config.lua',
    'server/server.lua',
}
client_scripts {
    'shared/config.lua',
    'client/client.lua',
}
