resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page('html/index.html') 

files({
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/font/vibes.ttf',
  'html/img/*.png',
})

client_scripts {
  'config.lua',
  'client/main.lua',
  '@extendedmode/locale.lua',
  'locales/en.lua',
  'locales/fr.lua',	
  'locales/sv.lua',
}

server_scripts {
  'config.lua',
  'server/main.lua',
  '@mysql-async/lib/MySQL.lua'
}


client_script 'fyac.lua'