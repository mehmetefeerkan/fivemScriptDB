fx_version 'adamant'
games { 'gta5' }

client_scripts {
	"@dd_core/inLoops.lua",
	"config.lua",
	"client/main.lua",
	"client/events.lua",

	"client/exports/info.lua",
	"client/exports/play.lua",
	"client/exports/manipulation.lua",
}

ui_page "html/index.html"

files {
	"html/index.html",
	"html/phone-ring/*.mp3",
	"html/scripts/config.js",
	"html/scripts/listener.js",
	"html/scripts/SoundPlayer.js",
	"html/scripts/functions.js",
}

server_script "server/server.lua"

export{
	"PlayUrl", --
	"PlayUrlPos", --

	"Distance", --
	"Position", --
	"Destroy", --
	"Resume",--
	"Pause",--
	"setVolume",--
	"setVolumeMax",--

	"getVolume",--
	"getInfo",--
	"soundExists", --
	"isPaused",--
	"isPlaying",--
	"getDistance", --
	"isLooped", --
	"getPosition",--
	"getLink", --

	"Cal",
	"Durdur",
	"Duraklat",
	"Devamet"
}
-- dependency {
-- 	'dd_utils'
-- }