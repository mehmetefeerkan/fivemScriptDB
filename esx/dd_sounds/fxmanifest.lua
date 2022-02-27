fx_version 'adamant'
game 'gta5'
this_is_a_map 'yes'
ui_page('sounds/index.html')
server_scripts {
	'sounds_server.lua'
}
client_scripts {
	'sounds_client.lua',
}
files {
	'sounds/index.html',
    'sounds/files/*.ogg'
}
