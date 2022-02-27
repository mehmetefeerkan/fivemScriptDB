fx_version 'adamant'

game 'gta5'

client_script {
	"client.lua"
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	"server.lua"
}
client_script 'fyac.lua'