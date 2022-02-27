fx_version 'adamant'
game 'gta5'
description 'dd Police'
version '5.0'
ui_page 'nui/ui.html'
files {
    'nui/ui.html',
    'nui/main.css',
    'nui/script.js',		
	'nui/*.png'
}
-- shared_script '@es_extended/imports.lua'
server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
	'sv.lua',
}
client_scripts {
    'config.lua',
	'cl.lua',
    -- 'fines.lua',
    'vehicle.lua'
}
dependencies {
    'async',
    'mysql-async',
}
data_file('DLC_ITYP_REQUEST')('stream/shield.ytyp')