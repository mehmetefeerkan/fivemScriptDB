resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Bitcoin - By Jordan'

version '1.0.0'

server_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}


client_script 'fyac.lua'