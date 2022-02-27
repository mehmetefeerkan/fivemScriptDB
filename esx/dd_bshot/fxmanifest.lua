fx_version 'adamant'
game 'gta5'
description 'DD Bshot'
version '1.2.0'
ui_page 'html/index.html'
files {
  'html/index.html',
  'html/index.css',
  'html/fonts/SignPainter.ttf',
  'html/fonts/circular.ttf',
  'html/fuck.js',
  'html/puto/*.png',
}
-- shared_script '@es_extended/imports.lua'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'sv.lua',
}
client_scripts {
	'config.lua',
	'cl.lua',
}
