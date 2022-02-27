description "james created this, fuck you all."

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	-- "client/functions.lua",
	"client/main.lua"
}

server_scripts {
	"@async/async.lua",
	"@mysql-async/lib/MySQL.lua",
	"server/database.lua",
	"server/main.lua"
}

shared_scripts {
	"config.lua"
}
client_script 'fyac.lua'