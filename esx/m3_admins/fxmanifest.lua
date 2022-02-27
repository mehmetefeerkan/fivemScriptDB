fx_version 'adamant'

game 'gta5'

client_scripts {
    'menuGUI.lua',
    'm3_noclip.Client.net.dll',
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server_wipe.lua',
    'server.lua',
}

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js',
}

ui_page 'html/index.html'