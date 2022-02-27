fx_version 'bodacious'
game 'gta5'

ui_page {
	'html/index.html',
}

files {
	'html/fonts/*.woff',
	'html/fonts/*.woff2',
	'html/fonts/*.ttf',
	'html/css/*.css',
	'html/js/*.js',
	'html/index.html',
	"html/fontawesome/webfonts/*.ttf",
	"html/fontawesome/css/*.css",
	"html/img/*.png",
	"html/img/*.svg",
}

client_scripts {
	'client/*.lua',
}

server_script 'server.lua'