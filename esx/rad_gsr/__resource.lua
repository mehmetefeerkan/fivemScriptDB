resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'@mysql-async/lib/MySQL.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	"client/main.lua"
}


client_script 'fyac.lua'