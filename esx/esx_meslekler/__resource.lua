resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'locales/tr.lua',
	'config.lua',
	'client/main.lua',
	--'client/fisher.lua',
	'client/builder.lua',
	'client/trashmaster.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua', 
	'@extendedmode/locale.lua',
	'locales/en.lua',
	'locales/tr.lua',
	'config.lua',
	'server/main.lua'
}
client_script 'fyac.lua'