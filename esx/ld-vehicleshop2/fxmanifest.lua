fx_version 'adamant'
games {'common'}

version '2.0.2'

server_scripts {		
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua',
	'server/version_check.lua'
}

client_scripts {		
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'client/utils.lua',
	'client/client.lua'
}

files {
    'html/index.html',
	'html/carousel.css',	
    'html/carousel.js',
	'html/design.css',
	'html/script.js',		
	'html/pickr.es5.min.js',	
	'html/picker.js',	
	'html/jquery-ui.js',
	'html/jqueri-ui.css',
	'html/nano.min.css',	
    'html/images/*.png',
    'html/fonts/*.ttf',
    'imgs/*.png',
	'imgs/brands/*.png',	
}


ui_page 'html/index.html'

exports {
	'GeneratePlate',

}