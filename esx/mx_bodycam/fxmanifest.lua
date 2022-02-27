fx_version "adamant"

game "gta5"

client_script "client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}


files {
    'ui/app.js',
    'ui/index.html',
    'ui/style.css',
	'ui/odznaka.png',
}

ui_page {
    'ui/index.html'
}