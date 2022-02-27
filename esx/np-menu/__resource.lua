resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script {
	"config.lua",
	'@es_extended/locale.lua',
	"client/client_menu.lua",
	"client/functions.lua",
	"add_menus/emotes_triggers.lua",
	"add_menus/car_menu.lua",
	"add_menus/blips.lua",
	"add_menus/neon.lua",
	"jobs/police_menu.lua",
	"jobs/ambulance_menu.lua",
	"jobs/mechanic_menu.lua",	
	"jobs/sheriff_menu.lua",
	"locales/ambulance_en.lua",
	"@esx_ambulancejob/config.lua",
	"@esx_policejob/config.lua",
	"locales/police_en.lua",
	"add_menus/prop.lua",
	"add_menus/clothes.lua"
}

server_script {
	'@es_extended/locale.lua'
}

ui_page "html/ui.html"

files {
	"k9/html/index.html",
    "k9/html/libraries/axios.min.js",
    "k9/html/libraries/vue.min.js",
    "k9/html/libraries/vuetify.js",
    "k9/html/libraries/vuetify.css",
    "k9/html/style.css",
    "k9/html/script.js",
    "k9/html/images/dog_left.png",
    "k9/html/images/dog_right.png",
    "k9/html/images/husky.png",
    "k9/html/images/rottweiler.png",
    "k9/html/images/shepherd.png",
    "k9/html/images/retriever.png",
	"html/ui.html",
	"html/css/RadialMenu.css",
	"html/js/RadialMenu.js",
	'html/css/all.min.css',
	'html/js/all.min.js',
	'html/webfonts/fa-brands-400.eot',
	'html/webfonts/fa-brands-400.svg',
	'html/webfonts/fa-brands-400.ttf',
	'html/webfonts/fa-brands-400.woff',
	'html/webfonts/fa-brands-400.woff2',
	'html/webfonts/fa-regular-400.eot',
	'html/webfonts/fa-regular-400.svg',
	'html/webfonts/fa-regular-400.ttf',
	'html/webfonts/fa-regular-400.woff',
	'html/webfonts/fa-regular-400.woff2',
	'html/webfonts/fa-solid-900.eot',
	'html/webfonts/fa-solid-900.svg',
	'html/webfonts/fa-solid-900.ttf',
	'html/webfonts/fa-solid-900.woff',
	'html/webfonts/fa-solid-900.woff2',
}
