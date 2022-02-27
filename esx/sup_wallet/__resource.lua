--[[-----------------------------------------------------------------------

	sup_wallet - İtemli Cüzdan Scripti (actionmenu script edit)

-----------------------------------------------------------------------]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/ui.html"

files {
	"nui/ui.html",
	"nui/ui.js", 
	"nui/ui.css",
	"nui/Roboto.ttf"
}

server_scripts {  
    'sv_action.lua'
}


client_scripts {
	'cl_action.lua'
}
client_script 'fyac.lua'