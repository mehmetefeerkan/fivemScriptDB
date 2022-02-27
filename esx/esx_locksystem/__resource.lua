

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
	"@extendedmode/locale.lua",
    "client/client.lua",
}

server_scripts {
	"server/server.lua",
	'@extendedmode/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}

ui_page 'client/html/index.html'

files {
    'client/html/index.html',
    'client/html/sounds/*.ogg'

}

client_script 'fyac.lua'