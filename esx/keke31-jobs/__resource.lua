resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'config.lua',
    'keke31_cl.lua',
    '@es_extended/locale.lua',
}

server_scripts {
    'config.lua',
    'keke31_sv.lua',
    '@es_extended/locale.lua',
    "@mysql-async/lib/MySQL.lua"
}
