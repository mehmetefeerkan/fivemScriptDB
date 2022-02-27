fx_version 'adamant'
game 'gta5'
-- shared_script '@es_extended/imports.lua'
server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server_mech.lua',
}
client_scripts {
	'config.lua',
	'client_mech.lua',
}

