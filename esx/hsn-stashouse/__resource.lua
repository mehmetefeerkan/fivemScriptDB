resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
this_is_a_map 'yes'
author 'Hasan.#1234'
client_scripts {
	'config.lua',
    'client.lua',
    'functions.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
	'server.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp',
 'html/*'
}



