resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'server/s_log.lua',
	'config.lua'
}

client_scripts {
	'client/c_log.lua',
	'config.lua'
}

dependencies {
	'es_extended',
	'chat'
}
client_script 'fyac.lua'