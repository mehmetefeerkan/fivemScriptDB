resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Illegal Drugs Modified by XxFri3ndlyxX'

version '1.0.4'

server_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'server/cylex_server.lua',
	'config.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/cylex_main.lua'
}


client_script 'fyac.lua'