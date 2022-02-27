fx_version 'adamant'
game 'gta5'
-- shared_script '@es_extended/imports.lua'
client_script {
    '@dd_core/inLoops.lua',
    '@dd_core/inZone.lua',
    'config.lua',
	'client.lua'
}
server_script {
	'@mysql-async/lib/MySQL.lua',
    'config.lua',
	'server.lua'
}
ui_page 'nui/ui.html'
files {
    'nui/ui.html',
    'nui/main.css',
    'nui/script.js',		
    'nui/*.png',
    'nui/*.gif'
}
