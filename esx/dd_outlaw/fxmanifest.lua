fx_version 'adamant'

game 'gta5'

description 'Police Needs'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/*.lua',
	-- 'server/Server.net.dll'
}

client_scripts {
	'@dd_core/inLoops.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/*.lua',
	-- 'client/Client.net.dll',
	-- 'cl_cctv.lua'
}
server_export 'ShowAlert'
export 'ShowAlert'

ui_page {
    'html/alerts.html',
}

files {
	'html/alerts.html',
	'html/main.js', 
	'html/style.css',
}
