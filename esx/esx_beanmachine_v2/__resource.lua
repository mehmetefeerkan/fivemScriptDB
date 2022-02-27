resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'@extendedmode/locale.lua',
	'config.lua',
	'cl_bean.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@extendedmode/locale.lua',
	'config.lua',
	'sv_bean.lua'
}

client_script 'fyac.lua'