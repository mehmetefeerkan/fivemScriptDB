fx_version 'adamant'
game 'gta5'

ui_page('client/html/UI.html')

server_scripts {  
    '@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client/client.lua'
}

files {
    'client/html/UI.html',
    'client/html/style.css',
    'client/html/media/font/Bariol_Regular.otf',
    'client/html/media/font/Vision-Black.otf',
    'client/html/media/font/Vision-Bold.otf',
    'client/html/media/font/Vision-Heavy.otf',
    'client/html/media/img/bg.png',
    'client/html/media/img/circle.png',
    'client/html/media/img/curve.png',
    'client/html/media/img/fingerprint.png',
    'client/html/media/img/fingerprint.jpg',
    'client/html/media/img/graph.png',
    'client/html/media/img/logo-big.png',
    'client/html/media/img/nextRP.png',
    'client/html/media/img/eur.png',
    'client/html/media/img/usd.png'
} 
