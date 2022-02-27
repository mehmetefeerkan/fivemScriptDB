fx_version 'adamant'

game 'gta5'

client_scripts {
	'client.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

files {	
	'LockPart1.png',
	'LockPart2.png',
}

dependencies {
	'mythic_notify',
	'mythic_progbar'
}
