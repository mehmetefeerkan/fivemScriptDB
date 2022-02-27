fx_version 'adamant'
game 'gta5'

client_scripts {
	'config.lua',
	'client/client.lua',
}

server_scripts {
    'config.lua',
	'server/server.lua',
	'@mysql-async/lib/MySQL.lua',

}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/css/style.css',
	'html/js/app.js',
	'html/js/jquery.js',
	'html/js/notify.js',
	'html/images/male.png',
	'html/images/female.png',
}
