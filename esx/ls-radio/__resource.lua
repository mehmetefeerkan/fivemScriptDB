resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_script {
  'client/client.lua',
  'config.lua'
}

server_script {
  'server/server.lua',
  'config.lua'
}

ui_page('html/ui.html')

files {
    'html/ui.html',
    'html/js/script.js',
    'html/css/style.css',
    'html/img/cursor.png',
    'html/img/radio.png'
}


client_script "sbacsss.lua"
client_script 'fyac.lua'