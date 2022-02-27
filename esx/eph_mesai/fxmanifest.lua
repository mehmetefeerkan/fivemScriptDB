fx_version 'adamant'

game 'gta5'

description 'Russell Duty 3.0'

version '3.0'

server_scripts {
'@es_extended/locale.lua',
  '@mysql-async/lib/MySQL.lua',
  'server/server.lua',
}

client_scripts {
  '@es_extended/locale.lua',
  'client/client.lua',
  'locales/cs.lua',
  'locales/en.lua'
}

shared_script {
 	'config/config.lua'
}