fx_version 'adamant'
games { 'rdr3', 'gta5' }
-- shared_script '@es_extended/imports.lua'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'sv.lua'
}

client_scripts {
	'config.lua',
	'cl.lua'
}

dependency 'es_extended'
