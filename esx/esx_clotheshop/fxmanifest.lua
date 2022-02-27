fx_version 'adamant'

game 'gta5'

description 'ESX Clothes Shop'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@extendedmode/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'extendedmode',
	'esx_skin'
}
client_script 'fyac.lua'