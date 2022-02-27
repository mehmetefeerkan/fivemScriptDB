resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Lockpick'
version '2.0.3'

client_scripts {
	'@extendedmode/locale.lua',
	'client/main.lua',
	'locales/en.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@extendedmode/locale.lua',
	'server/main.lua',
	'locales/en.lua',
	'config.lua'
}

dependency {
	'extendedmode',
	'pNotify',
	'mythic_progressbar'
}
client_script 'fyac.lua'