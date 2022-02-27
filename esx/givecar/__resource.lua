resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'fivemturk C Y L E X'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@extendedmode/locale.lua',
	'server/main.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'client/main.lua'
}

dependency 'extendedmode'

export 'GeneratePlate'
client_script 'fyac.lua'