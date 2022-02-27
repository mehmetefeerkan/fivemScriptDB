resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    'server/server.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua',
    'config.lua'
    
}

dependency{
    'mythic_progbar'
}
client_script 'fyac.lua'