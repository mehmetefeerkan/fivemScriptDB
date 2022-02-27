resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'C Y L E X' 
			
server_script {						
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/Server.lua',
	'server/functions.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'Logs/ambulance.log',
	'Logs/vehicleshop.log',
	'Logs/mecano.log',
	'Logs/police.log',
	'Logs/sheriff.log',
	'Logs/taxi.log',
	'server/newlogging.lua'
}

client_script {					
	'config.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'client/Weapons.lua',
	'client/Client.lua'
}

