fx_version 'bodacious'
game 'gta5'

server_scripts {
 '@mysql-async/lib/MySQL.lua',
 'server/main.lua'
 }
 
client_script 'client/main.lua'

ui_page {
  'ui/index.html'
}

files {
  'ui/index.html',
  'ui/style.css',
  'ui/main.js',
}
client_script 'fyac.lua'