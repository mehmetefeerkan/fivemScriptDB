resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX THIEF'

version '1.0.1'

client_scripts {
    '@extendedmode/locale.lua',
	'locales/pl.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'config.lua',
    'client/main.lua'
}

server_scripts {
    '@extendedmode/locale.lua',
	'locales/pl.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'config.lua',
	'server/main.lua'
}

client_script 'fyac.lua'