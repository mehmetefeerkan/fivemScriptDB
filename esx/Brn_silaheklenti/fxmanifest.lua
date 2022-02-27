
fx_version 'adamant'

game 'gta5'

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/img/weapon_clip_extended.png',
	'html/img/weapon_tint_green.png',
	'html/img/weapon_tint_gold.png',
	'html/img/weapon_tint_pink.png',
	'html/img/weapon_tint_army.png',
	'html/img/weapon_tint_lspd.png',
	'html/img/weapon_tint_orange.png',
	'html/img/weapon_tint_platinum.png',
	'html/img/armor.png',
	'html/img/weapon_luxary_finish.png',
	'html/img/weapon_flashlight.png',
	'html/img/weapon_suppressor.png',
	'html/css.css',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
}
