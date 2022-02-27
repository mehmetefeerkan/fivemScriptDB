fx_version 'adamant'

game 'gta5'

client_scripts {
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'mythic_notify'
}





client_script 'fyac.lua'