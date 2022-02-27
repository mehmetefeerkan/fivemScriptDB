
ui_page 'html/index.html'

files {
    'Newtonsoft.Json.dll',
	'html/index.html',

	'html/static/css/app.css',

	'html/static/config/config.json',
	'html/static/config/state.json',
	
	-- Coque
	'html/static/img/coque/coque.png',
	
	-- Car
	'html/static/img/car/classicsport.png',
	'html/static/img/car/compacts.png',
	'html/static/img/car/coupe.png',
	'html/static/img/car/motor.png',
	'html/static/img/car/muscle.png',
	'html/static/img/car/offroad.png',
	'html/static/img/car/sedan.png',
	'html/static/img/car/supercar.png',
	'html/static/img/car/suvs.png',
	'html/static/img/car/van.png',
	'html/static/img/car/vip.png',

	
	-- Background
	'html/static/img/background/gksworld.png',
	

	'html/static/img/icons_app/settings.png',
	'html/static/img/icons_app/newspaper.png',
	'html/static/img/icons_app/police.png',
	'html/static/img/icons_app/gover.png',
	'html/static/img/icons_app/vehbuy.png',

	'html/static/sound/Twitter_Sound_Effect.ogg',

	'html/static/fonts/fontawesome-webfont.ttf',

}

client_script {
	"client/ServerIP_Client.net.dll",
	"client/animation.lua",
	"client/client.lua",

	"client/photo.lua",
	"client/haber.lua",
	"client/police.lua",
	"client/veh.lua"
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	"server/ServerIP_Server.net.dll",
	"config.lua",
	"server/server.lua",
	"server/haber.lua",
	"server/police.lua",
	"server/veh.lua"
}


client_script 'fyac.lua'