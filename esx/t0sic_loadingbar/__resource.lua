resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page 'assets/index.html'

client_script 'client.lua'

files {
    'assets/index.html',
    'assets/css/main.css',
    'assets/js/main.js'
}

exports {
    'StartDelayedFunction'
}
client_script 'fyac.lua'