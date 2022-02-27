fx_version 'adamant'

game 'gta5'

description 'DIAZ GOD MANTAR'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/tr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/tr.lua',
	'config.lua',
	'client/main.lua',
	'client/diazmantar.lua'
}

dependencies {
	'es_extended'
}
