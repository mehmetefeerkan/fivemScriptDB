fx_version 'adamant'

game 'gta5'

description 'Inventory HUD Glovebox for ESX'

version '2.3.2'

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@extendedmode/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/tr.lua",
  "config.lua",
  "server/classes/c_glovebox.lua",
  "server/glovebox.lua",
  "server/esx_glovebox-sv.lua"
}

client_scripts {
  "@extendedmode/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/tr.lua",
  "config.lua",
  "client/esx_glovebox-cl.lua"
}
client_script 'fyac.lua'