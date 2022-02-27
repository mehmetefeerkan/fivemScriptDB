resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script "client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css'
}
client_script 'fyac.lua'