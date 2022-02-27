
fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/jquery-3.4.1.min.js',
	'html/main.css',
	'html/input.css',
	'html/main.js',
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    'config.lua',
    'server/main.lua',
	'@mysql-async/lib/MySQL.lua',

}