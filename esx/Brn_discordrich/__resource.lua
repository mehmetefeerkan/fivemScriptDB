-- BrnOrkun#3131

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client.lua'
}