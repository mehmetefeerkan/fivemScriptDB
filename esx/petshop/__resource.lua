resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@extendedmode/locale.lua',
	'locales/tr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/tr.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
client_script 'fyac.lua'